program ComboAutoComplete;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Edit.Suggest2 in '..\code\FMX.Edit.Suggest2.pas',
  UFormTesteComboAutoComplete
    in '..\code\UFormTesteComboAutoComplete.pas' {FormAutoComplete};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormAutoComplete, FormAutoComplete);
  Application.Run;

end.
