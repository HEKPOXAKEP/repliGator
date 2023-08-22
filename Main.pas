unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Placemnt, ActnList, ImgList, Menus, RxMenus, SpeedBar, ExtCtrls,
  ComCtrls;

type
  TfmMain = class(TForm)
    fsMain: TFormStorage;
    spdbarMain: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    mnuMain: TRxMainMenu;
    imglstActions: TImageList;
    actsMain: TActionList;
    actExit: TAction;
    mmiFile: TMenuItem;
    miExit: TMenuItem;
    statbarMain: TStatusBar;
    spdbtnOrders: TSpeedItem;
    spdbtnLog: TSpeedItem;
    actOrders: TAction;
    actLog: TAction;
    mmiWindows: TMenuItem;
    miLog: TMenuItem;
    miOrders: TMenuItem;
    actConnectDbs: TAction;
    N1: TMenuItem;
    miConnectDbs: TMenuItem;
    N2: TMenuItem;
    actTileVert: TAction;
    miTileVert: TMenuItem;
    actDisconnectDbs: TAction;
    actOptions: TAction;
    mmiTools: TMenuItem;
    miOptions: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure statbarMainDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormShow(Sender: TObject);
    procedure statbarMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actOrdersExecute(Sender: TObject);
    procedure actConnectDbsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actLogExecute(Sender: TObject);
    procedure actTileVertExecute(Sender: TObject);
    procedure actDisconnectDbsExecute(Sender: TObject);
    procedure actOptionsExecute(Sender: TObject);
  private
    procedure DisplayHint(Sender: TObject);
    function StatusPanelAt(X,Y: integer): integer;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
  CommCtrl,
  DataModule,
  Log,
  Orders,
  Options;

{$R *.dfm}

const
  connClrs: array [boolean] of TColor =(
    clRed,clGreen
  );

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Caption := PID;
  fsMain.IniFileName := DM.fsConf.IniFileName;
  Application.OnHint := DisplayHint;
end;

procedure TfmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.statbarMainDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  with StatusBar.Canvas do begin
    case Panel.Index of
      0: begin
        Font.Color := clWhite;
        Brush.Color := connClrs[DM.connDb1.Connected];
      end;
      1: begin
        Font.Color := clWhite;
        Brush.Color := connClrs[DM.connDb2.Connected];
      end;
    else
      Font.Style := [];
    end;
    FillRect(Rect);
    TextOut(Rect.Left+2,Rect.Top,Panel.Text);
  end;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  statbarMain.Invalidate;
end;

procedure TfmMain.DisplayHint(Sender: TObject);
begin
  statbarMain.Panels[2].Text := GetLongHint(Application.Hint);
end;

procedure TfmMain.statbarMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{ Возможно, эта фича не так уж безопасна для данного приложения,
  поэтому я её отключил :-) }
begin
  exit;  // do nothing

  if (Button = mbLeft) and (ssDouble in Shift) then begin
    case StatusPanelAt(X,Y) of
      0: begin
        DM.connDb1.Connected := not DM.connDb1.Connected;
        statbarMain.Invalidate;
      end;
      1: begin
        DM.connDb2.Connected := not DM.connDb2.Connected;
        statbarMain.Invalidate;
      end;
    end; {CASE}
  end;
end;

function TfmMain.StatusPanelAt(X, Y: integer): integer;
var
  p: TPoint;
  arr: array of integer;
  idx: integer;

begin
  Result := -1;
  p := Point(X,Y);

  if not PtInRect(statbarMain.ClientRect, p) then
    exit;

  SetLength(arr, SendMessage(statbarMain.Handle, SB_GETPARTS, 0, 0));
  SendMessage(statbarMain.Handle, SB_GETPARTS, Length(arr), LPARAM(PInteger(arr)));

  idx := 0;
  while idx < Length(arr) do begin
    if (p.X <= arr[idx]) or (arr[idx] = -1) then begin
      Result := idx;
      exit;
    end;
    Inc(idx);
  end;
end;

procedure TfmMain.actConnectDbsExecute(Sender: TObject);
begin
  DM.ConnectDbs;
end;

procedure TfmMain.actDisconnectDbsExecute(Sender: TObject);
begin
  DM.DisconnectDbs;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.DisconnectDbs;
end;

procedure TfmMain.actLogExecute(Sender: TObject);
begin
  DM.ShowLog;
end;

procedure TfmMain.actOrdersExecute(Sender: TObject);
begin
  DM.ShowOrders;
end;

procedure TfmMain.actTileVertExecute(Sender: TObject);
begin
  Tile;
end;

procedure TfmMain.actOptionsExecute(Sender: TObject);
var
  f: TfmOptions;

begin
  f := TfmOptions.Create(Self);
  try
    f.ShowModal;
  finally
    f.Free;
  end;
end;

end.

