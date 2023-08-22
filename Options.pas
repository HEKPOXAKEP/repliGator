unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Placemnt, Mask, ToolEdit, ExtCtrls, RXSpin;

type
  TfmOptions = class(TForm)
    grpDatabases: TGroupBox;
    fsOptions: TFormStorage;
    edtDb1: TFilenameEdit;
    edtDb2: TFilenameEdit;
    lblDb1: TLabel;
    lblDb2: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    grpTimers: TGroupBox;
    lblCheckNewOrders: TLabel;
    lblCheckProcessedOrders: TLabel;
    lblRefreshGrid: TLabel;
    sedtCheckNewOrders: TRxSpinEdit;
    sedtCheckProcessedOrders: TRxSpinEdit;
    sedtRefreshGrid: TRxSpinEdit;
    lblTimersRemark: TLabel;
    bvlTimers: TBevel;
    Bevel1: TBevel;
    lblDbsRemark: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    procedure FillFormData;
  public
    procedure SaveFormData;
  end;

var
  fmOptions: TfmOptions;

implementation

uses
  DataModule;

{$R *.dfm}

procedure TfmOptions.FormCreate(Sender: TObject);
begin
  fsOptions.IniFileName := DM.fsConf.IniFileName;
  FillFormData;
end;

procedure TfmOptions.FillFormData;
begin
  if edtDb1.InitialDir = '' then
    edtDb1.InitialDir := ExtractFilePath(Application.ExeName)+'db\';
  if edtDb2.InitialDir = '' then
    edtDb2.InitialDir := ExtractFilePath(Application.ExeName)+'db\';

  edtDb1.Text := DM.connDb1.Path;
  edtDb2.Text := DM.connDb2.Path;

  sedtCheckNewOrders.Value :=
    DM.tmrevtCheckNewOrders.Interval /1000;
  sedtCheckProcessedOrders.Value :=
    DM.tmrevtCheckProcessedOrders.Interval /1000;
  sedtRefreshGrid.Value :=
    DM.tmrevtRefreshOrdersGrid.Interval /1000;
end;

procedure TfmOptions.SaveFormData;
begin
  if edtDb1.Text <> DM.connDb1.Path then
    DM.connDb1.Path := edtDb1.Text;
  if edtDb2.Text <> DM.connDb2.Path then
    DM.connDb2.Path := edtDb2.Text;

  DM.tmrevtCheckNewOrders.Interval :=
    Trunc(sedtCheckNewOrders.Value) *1000;
  DM.tmrevtCheckProcessedOrders.Interval :=
    Trunc(sedtCheckProcessedOrders.Value) *1000;
  DM.tmrevtRefreshOrdersGrid.Interval :=
    Trunc(sedtRefreshGrid.Value) *1000;

  ModalResult := mrOk;  
end;

procedure TfmOptions.btnOkClick(Sender: TObject);
begin
  SaveFormData;
end;

procedure TfmOptions.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
