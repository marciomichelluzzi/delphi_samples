program ArquivosINI;

uses
  Vcl.Forms,
  UFormMain in 'UFormMain.pas' {Form53};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm53, Form53);
  Application.Run;
end.
