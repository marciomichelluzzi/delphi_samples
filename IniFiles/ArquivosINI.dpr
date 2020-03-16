program ArquivosINI;

uses
  Vcl.Forms,
  UFormMain in 'UFormMain.pas' {FormArquivosINI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormArquivosINI, FormArquivosINI);
  Application.Run;
end.
