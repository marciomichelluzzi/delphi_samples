program DynamicListGrid;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormDynamicListGrid in 'UFormDynamicListGrid.pas' {FormDynamicListGrid};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormDynamicListGrid, FormDynamicListGrid);
  Application.Run;
end.
