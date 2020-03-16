program WordStructureView;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitFormatadorWord in '..\UnitFormatadorWord.pas' {FormWordStructureView},
  UnitZipUtils in '..\codigo\zip\UnitZipUtils.pas',
  UnitXmlUtils in '..\codigo\xml\UnitXmlUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormWordStructureView, FormWordStructureView);
  ZipUtils := TZipUtils.Create();

  Application.Run;

end.
