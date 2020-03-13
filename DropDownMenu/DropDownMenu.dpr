program DropDownMenu;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormDropDownMenu in 'UFormDropDownMenu.pas' {FormDropDownMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormDropDownMenu, FormDropDownMenu);
  Application.Run;
end.
