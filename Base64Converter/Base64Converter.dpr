program Base64Converter;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormBase64Converter in 'source\UFormBase64Converter.pas' {FormBase64Converter},
  UnitBase64 in 'source\UnitBase64.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormBase64Converter, FormBase64Converter);
  Application.Run;
end.
