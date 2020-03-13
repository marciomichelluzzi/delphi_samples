program ImageCut;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormMain in 'UFormMain.pas' {FormMain},
  UFormCut in 'UFormCut.pas' {FormCut};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormCut, FormCut);
  Application.Run;
end.
