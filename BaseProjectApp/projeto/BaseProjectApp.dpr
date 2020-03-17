program BaseProjectApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormMain in '..\codigo\telas\UFormMain.pas' {FormMain},
  UFormSplash in '..\codigo\telas\UFormSplash.pas' {FormSplash},
  UThreadSincronizacao in '..\codigo\sincronizacao\UThreadSincronizacao.pas',
  UFrameWait in '..\codigo\wait\UFrameWait.pas' {FrameWait: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormSplash, FormSplash);
  Application.Run;
end.
