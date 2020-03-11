program BitmapFromURL;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  UFormBitmapFromURL in 'UFormBitmapFromURL.pas' {FormBitmapFromURL},
  FMX.Devgear.Extentions in 'FMX.Devgear.Extentions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormBitmapFromURL, FormBitmapFromURL);
  Application.Run;
end.
