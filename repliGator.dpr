program repliGator;

uses
  Forms,
  Main in 'Main.pas' {fmMain},
  DataModule in 'DataModule.pas' {DatMod: TDataModule},
  Log in 'Log.pas' {fmLog},
  Orders in 'Orders.pas' {fmOrders},
  Options in 'Options.pas' {fmOptions};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDatMod, DM);
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
