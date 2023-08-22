unit Log;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RXCtrls, Placemnt, ExtCtrls;

type
  TfmLog = class(TForm)
    fsLog: TFormStorage;
    panLog: TPanel;
    lstboxLog: TTextListBox;
    btnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure WLog(const s: string); 
  end;

implementation

uses
  DataModule;

{$R *.dfm}

procedure TfmLog.FormCreate(Sender: TObject);
begin
  fsLog.IniFileName := DM.fsConf.IniFileName;
end;

procedure TfmLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmLog.FormDestroy(Sender: TObject);
begin
  DM.fmLog := nil;
end;

procedure TfmLog.btnClearClick(Sender: TObject);
begin
  lstboxLog.Clear;
end;

procedure TfmLog.WLog(const s: string);
begin
  lstboxLog.AddItem(s,nil);
end;

end.
