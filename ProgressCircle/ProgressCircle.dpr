program ProgressCircle;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Platform,
  FMX.Consts,
  UFormProgressiveCircle
    in 'UFormProgressiveCircle.pas' {FormPregressiveCircle};

{$R *.res}

begin
  // TPlatformServices.Current.GlobalFlags.Add(GlobalDisableiOSGPUCanvas, True);

  Application.Initialize;
  Application.CreateForm(TFormPregressiveCircle, FormPregressiveCircle);
  Application.Run;

end.
