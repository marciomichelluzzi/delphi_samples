program ActionSheet;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormActionSheet in 'UFormActionSheet.pas' {FormActionSheet};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormActionSheet, FormActionSheet);
  Application.Run;
end.
