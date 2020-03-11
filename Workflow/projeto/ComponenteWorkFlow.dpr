program ComponenteWorkFlow;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormWorkFlow in '..\codigo\UFormWorkFlow.pas' {FormWorkFlow},
  UFrameEtapaWorkFlow in '..\codigo\UFrameEtapaWorkFlow.pas' {FrameEtapaWorkFlow: TFrame},
  UFrameWorkFlow in '..\codigo\UFrameWorkFlow.pas' {FrameWorkFlow: TFrame},
  UEtapaWorkFlow in '..\codigo\UEtapaWorkFlow.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormWorkFlow, FormWorkFlow);
  Application.Run;
end.
