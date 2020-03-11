program AndroidCalendarManager;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormAndroidCalendarManager in 'UFormAndroidCalendarManager.pas' {FormAndroidCalendarManager};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormAndroidCalendarManager, FormAndroidCalendarManager);
  Application.Run;
end.
