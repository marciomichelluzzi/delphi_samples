program ColorMoveAnimation;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormColorMoveAnimation in 'UFormColorMoveAnimation.pas' {FormColorMoveAnimation};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormColorMoveAnimation, FormColorMoveAnimation);
  Application.Run;
end.
