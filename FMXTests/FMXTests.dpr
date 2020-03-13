program FMXTests;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormMaterialDesignLayout in 'UFormMaterialDesignLayout.pas' {FormMaterialDesignLayout},
  UFormMain in 'UFormMain.pas' {FormMain},
  UFormColorAnimation in 'UFormColorAnimation.pas' {FormColorAnimation},
  UFormMenu in 'UFormMenu.pas' {FormMenu},
  UFormTransparentEdit in 'UFormTransparentEdit.pas' {FormTransparentEdit},
  UFormDynamicListView in 'UFormDynamicListView.pas' {FormDynamicListView};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormMaterialDesignLayout, FormMaterialDesignLayout);
  Application.CreateForm(TFormColorAnimation, FormColorAnimation);
  Application.CreateForm(TFormMenu, FormMenu);
  Application.CreateForm(TFormTransparentEdit, FormTransparentEdit);
  Application.CreateForm(TFormDynamicListView, FormDynamicListView);
  Application.Run;
end.
