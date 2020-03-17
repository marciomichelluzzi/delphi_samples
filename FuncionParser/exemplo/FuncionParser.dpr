program FuncionParser;

uses
  Forms,
  UFormFuncionParser in 'UFormFuncionParser.pas' {FormFuncionParser},
  UFuncionParser in '..\UFuncionParser.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormFuncionParser, FormFuncionParser);
  Application.Run;
end.



