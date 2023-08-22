unit DataModule;

interface

uses
  SysUtils, Classes, Forms, IniFiles, IB_Components, Placemnt, Log,
  Orders, TimerLst;

const
  PID = 'реплиГатор';

type
  TDatMod = class(TDataModule)
    connDb1: TIB_Connection;
    connDb2: TIB_Connection;
    fsConf: TFormStorage;
    cursGetNewOrders: TIB_Cursor;
    tmrlstGeneral: TRxTimerList;
    tmrevtRefreshOrdersGrid: TRxTimerEvent;
    tmrevtCheckNewOrders: TRxTimerEvent;
    dsqlOrderAccepted: TIB_DSQL;
    dsqlSaveNewOrder: TIB_DSQL;
    tmrevtCheckProcessedOrders: TRxTimerEvent;
    cursGetProcessedOrders: TIB_Cursor;
    dsqlUpdateOrderDTs: TIB_DSQL;
    trsSaveNewOrder: TIB_Transaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure connDb1AfterConnect(Sender: TIB_Connection);
    procedure tmrevtRefreshOrdersGridTimer(Sender: TObject);
    procedure tmrevtCheckNewOrdersTimer(Sender: TObject);
    procedure connDb2AfterConnect(Sender: TIB_Connection);
    procedure connDb2BeforeDisconnect(Sender: TIB_Connection);
    procedure tmrevtCheckProcessedOrdersTimer(Sender: TObject);
  private
    { Private declarations }
  public
    fmLog: TfmLog;
    fmOrders: TfmOrders;
    // --
    procedure WLog(const s: string);
    procedure ConnectDbs;
    procedure DisconnectDbs;
    procedure ShowOrders;
    procedure ShowLog;
    procedure CheckNewOrders;
    function SaveNewOrder(ARefId: integer; var ORefId: integer;
               AName: string): boolean;
    procedure OrderAccepted(AId, ARefId: integer; AStatus: integer);
    procedure CheckProcessedOrders;
    procedure UpdateOrderDTs(AId: integer; PlannedDT, ActualDT: TDateTime);
    procedure ToggleRefreshOrdersGridTimer(AEnabled: boolean);
    procedure ToggleCheckNewOrdersTimer(AEnabled: boolean);
    procedure ToggleCheckProcessedOrdersTimer(AEnabled: boolean);
  end;

var
  DM: TDatMod;

implementation

uses
  Dialogs,
  Main;

{$R *.dfm}

procedure TDatMod.DataModuleCreate(Sender: TObject);
begin
  fsConf.IniFileName := ChangeFileExt(Application.ExeName, '.conf');
  fsConf.RestoreFormPlacement;

  if connDb1.Path = '' then
    connDb1.Path := ExtractFilePath(Application.ExeName) + 'db\Gator1.fdb';
  if connDb2.Path = '' then
    connDb2.Path := ExtractFilePath(Application.ExeName) + 'db\Gator2.fdb';
end;

procedure TDatMod.DataModuleDestroy(Sender: TObject);
begin
  fsConf.SaveFormPlacement;
end;

procedure TDatMod.ConnectDbs;
begin
  try
    try
      connDb1.Connected := true;
      connDb2.Connected := true;
      // соединение прошло успешно
      fmMain.miConnectDbs.Action := fmMain.actDisconnectDbs;
      WLog('Подключились к БД');
    except
      on E: Exception do begin
        connDb1.Connected := false;
        connDb2.Connected := false;
        WLog(E.Message);
        MessageDlg(E.Message,mtError,[mbOk],0);
      end;
    end; {TRY EXCEPT}
  finally
    fmMain.statbarMain.Invalidate;
  end; {TRY FINALLY}
end;

procedure TDatMod.DisconnectDbs;
begin
  connDb1.Connected := false;
  connDb2.Connected := false;

  WLog('Отключились от БД');

  fmMain.miConnectDbs.Action := fmMain.actConnectDbs;
  fmMain.statbarMain.Invalidate;
end;

procedure TDatMod.CheckNewOrders;
{ Ищем новые заказы в БД1 и заносим их в БД2 }
var
  Id,              // Id в БД1
  RefId: integer;  // Id нового заказа в БД2, которое будет вписанов в Ref_Id БД1
  AName: string;

begin
  with cursGetNewOrders do begin
    if not Prepared then
      Prepare;

    First;
    while not Eof do begin
      // О! Новый заказ!
      Id := FieldByName('Id').AsInteger;
      AName := FieldByName('Name').AsString;

      WLog('Принят новый заказ '+IntToStr(Id)+' "'+AName+'"');

      if not SaveNewOrder(Id,RefId,AName) then begin
        { если SaveNewOrder() вернул False, значит такой заказ уже есть в БД2
          (или произошёл икзепшн);
          нужно проверить RefId;
          возможно, в этом случае следует предпринять какие-то особые действия,
          но пока мы прсото будем выставлять этому заказу
          в БД1 Status=3 - проблемный заказ }

        // если в SaveNewOrdr() произошёл экзепшн и он вернул RefId=-1971,
        // ничего ваще не делаем
        if RefId <> -1971 then begin
          // просто проблемный заказ, меняем его Status на 3,
          // дабы он в след раз не попался
          OrderAccepted(Id,RefId,3);
        end;
      end
      else begin
        // внесение заказа в БД2 произошло успешно
        OrderAccepted(Id,RefId,2);
      end;

      Next;
    end;

    Close;
  end;
end;

procedure TDatMod.ShowLog;
begin
  if fmLog <> nil then
    if fmLog.WindowState = wsMinimized then
      fmLog.WindowState := wsNormal
    else
      fmLog.Show
  else begin
    fmLog := TfmLog.Create(fmMain);
    fmLog.Show;
  end;
end;

procedure TDatMod.ShowOrders;
begin
  if fmOrders <> nil then
    if fmOrders.WindowState = wsMinimized then
      fmOrders.WindowState := wsNormal
    else
      fmOrders.Show
  else begin
    fmOrders := TfmOrders.Create(fmMain);
    fmOrders.Show;
  end;
end;

procedure TDatMod.WLog(const s: string);
begin
  if fmLog <> nil then
    fmLog.WLog(s);
end;

procedure TDatMod.connDb1AfterConnect(Sender: TIB_Connection);
begin
  if fmOrders <> nil then
    fmOrders.cursOrders.Active := true;
end;

procedure TDatMod.tmrevtRefreshOrdersGridTimer(Sender: TObject);
begin
  if fmOrders <> nil then
    fmOrders.cursOrders.Refresh;
end;

procedure TDatMod.ToggleRefreshOrdersGridTimer(AEnabled: boolean);
begin
  tmrevtRefreshOrdersGrid.Enabled := true;
  tmrlstGeneral.Active := true;
end;

procedure TDatMod.tmrevtCheckNewOrdersTimer(Sender: TObject);
begin
  CheckNewOrders;
end;

function TDatMod.SaveNewOrder(ARefId: integer; var ORefId: integer;
   AName: string): boolean;
{ Вносит новый заказ в БД2, если там такого ещё нет.

  Проверка на существование такого заказа в БД2 происходит
  в хранимой процедуре saveNewOrder() по полю Ref_Id.

  Возвращает: True и Id новой (или Id уже имеющеся) записи в БД2 в ORefId,
  если всё прошло хорошо, False и в случае ошибки.
}
begin
  DM.tmrlstGeneral.Active := false;

  try
    with dsqlSaveNewOrder do begin
      try
        if not Prepared then
          Prepare;

        ParamByName('aRef_Id').AsInteger :=ARefId;
        ParamByName('aName').AsString := AName;

        ExecSQL;

        ORefId := FieldByName('oId').AsInteger;  // Id новой записи, или уже
                                                 // имеющейся с таким Ref_Id

        if FieldByName('err').AsInteger <> 0 then begin
          // такой заказ уже есть в БД2 -
          // - это проблемный заказ, его нужно пометить Status=3;
          // в ORefId Id записи в БД2
          IB_Transaction.Rollback;

          Result := false;
          WLog('ОШИБКА ('+FieldByName('err').AsString+'): '+FieldByName('msg').AsString);
        end
        else begin
          // заказ внесён в БД2, в ORefId вернётся Id новой записи в БД2, всё Ok
          Result := true;
          WLog('Заказ '+IntToStr(ARefId)+' "'+AName+'" зафиксирован в БД2');
        end;

        IB_Transaction.Commit;
      except
        on E: Exception do begin
          IB_Transaction.Rollback;

          Result := false;
          ORefId := -1971;
          WLog('SHIT HAPPENED: '+E.Message);
        end;
      end; {TRY EXCEPT}
    end;
  finally
    DM.tmrlstGeneral.Active := true;
  end; {TRY FINALLY}
end;

procedure TDatMod.OrderAccepted(AId, ARefId, AStatus: integer);
{ Вносим в БД1 ссылку Ref_Id на Id в БД2 и меняем статус
  на AStatus (обычно 2) - заказ отправлен в БД2 или уже там был,
  но его статус почему-то изменился на 1 }
var
  s: string;

begin
  with dsqlOrderAccepted do begin
    if not Prepared then
      Prepare;

    ParamByName('aId').AsInteger := AId;
    ParamByName('aRef_Id').AsInteger := ARefId;
    ParamByName('aStatus').AsInteger := AStatus;

    ExecSQL;

    case AStatus of
      2: // новый заказ принят
        s := 'Заказ '+IntToStr(AId)+' помечен, как принятый в БД1';
      3: // такой заказ уже был, просто поменяли его Status на 3 - проблемный
        s := 'Заказ '+IntToStr(AId)+' помечен, как проблемный';
    else
      s := 'Произошло что-то непонятное, AStatus='+IntToStr(AStatus);
    end;
    WLog(s);
  end;
end;

procedure TDatMod.ToggleCheckNewOrdersTimer(AEnabled: boolean);
begin
  tmrevtCheckNewOrders.Enabled := AEnabled;
  tmrlstGeneral.Active := true;
end;

procedure TDatMod.connDb2AfterConnect(Sender: TIB_Connection);
begin
  ToggleCheckNewOrdersTimer(true);
  ToggleCheckProcessedOrdersTimer(true);
end;

procedure TDatMod.connDb2BeforeDisconnect(Sender: TIB_Connection);
begin
  ToggleCheckNewOrdersTimer(false);
  ToggleCheckProcessedOrdersTimer(false);
end;

procedure TDatMod.ToggleCheckProcessedOrdersTimer(AEnabled: boolean);
begin
  tmrevtCheckProcessedOrders.Enabled := AEnabled;
  tmrlstGeneral.Active := true;
end;

procedure TDatMod.tmrevtCheckProcessedOrdersTimer(Sender: TObject);
begin
  CheckProcessedOrders;
end;

procedure TDatMod.CheckProcessedOrders;
{ Ищем в БД2 заказы с несовпадающими датами }
var
  AId: integer;
  ARefId: integer;
  PlannedDT, ActualDT: TDateTime;

begin
  with cursGetProcessedOrders do begin
    if not Prepared then
      Prepare;

    First;
    while not Eof do begin
      // oId,oRef_Id,oPlanned_DT,oActual_DT
      AId := FieldByName('oId').AsInteger;
      ARefId := FieldByName('oRef_Id').AsInteger;
      PlannedDT := FieldByName('oPlanned_DT').AsDateTime;
      ActualDT := FieldByName('oActual_DT').AsDateTime;

      //wlog(FormatDateTime('c',PlannedDT)+' - '+FormatDateTime('c',ActualDT));

      WLog('У заказа '+IntToStr(AId)+' поменялись даты');

      // обновляем даты в БД1
      UpdateOrderDTs(ARefId,PlannedDT,ActualDT);

      Next;
    end;

    Close;
  end;
end;

procedure TDatMod.UpdateOrderDTs(AId: integer; PlannedDT,
  ActualDT: TDateTime);
{ Обновляем даты в БД1 из БД2 }
begin
  with dsqlUpdateOrderDTs do begin
    if not Prepared then
      Prepare;

    ParamByName('aId').AsInteger := AId;
    ParamByName('aPlanned_DT').AsDateTime := PlannedDT;
    ParamByName('aActual_DT').AsDateTime := ActualDT;

    ExecSQL;

    WLog('Обновлены даты у заказа '+IntToStr(AId));
  end;
end;

end.


