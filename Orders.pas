unit Orders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Placemnt, IB_Components, Grids, IB_CursorGrid, ExtCtrls;

type
  TfmOrders = class(TForm)
    fsOrders: TFormStorage;
    cursOrders: TIB_Cursor;
    datsrcOrders: TIB_DataSource;
    panOrders: TPanel;
    grdOrders: TIB_CursorGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cursOrdersAfterOpen(IB_Dataset: TIB_Dataset);
    procedure tmrCheckOrdersTimer(Sender: TObject);
    procedure cursOrdersBeforeClose(IB_Dataset: TIB_Dataset);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  DataModule;

{$R *.dfm}

procedure TfmOrders.FormCreate(Sender: TObject);
begin
  fsOrders.IniFileName := DM.fsConf.IniFileName;
  //ScaleBy(120,96);
  if DM.connDb1.Connected then
    cursOrders.Active := true;
end;

procedure TfmOrders.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.fmOrders := nil;
  cursOrders.Active := false;
  Action := caFree;
end;

procedure TfmOrders.cursOrdersAfterOpen(IB_Dataset: TIB_Dataset);
begin
  DM.ToggleRefreshOrdersGridTimer(true);
end;

procedure TfmOrders.cursOrdersBeforeClose(IB_Dataset: TIB_Dataset);
begin
  DM.ToggleRefreshOrdersGridTimer(false);
end;

procedure TfmOrders.tmrCheckOrdersTimer(Sender: TObject);
begin
  cursOrders.Refresh;
  showmessage(IntToStr(cursOrders.RowsAffected));
end;

end.
