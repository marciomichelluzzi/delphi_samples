program ShellExecute;

uses
  Vcl.Forms,
  UFormMain in 'UFormMain.pas' {FormShellExecute};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormShellExecute, FormShellExecute);
  Application.Run;
end.
