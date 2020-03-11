program WifiStatusBar;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormWiFiStatusBar in 'UFormWiFiStatusBar.pas' {FormWiFiStatusBar},
  UFrameWifiStatusBar in 'UFrameWifiStatusBar.pas' {FrameWifiStatus: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormWiFiStatusBar, FormWiFiStatusBar);
  Application.Run;
end.
