unit UFormMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormMain = class(TForm)
    ButtonMaterialDesign: TButton;
    ButtonColorAnimation: TButton;
    ButtonMenu: TButton;
    ButtonTransparentEdit: TButton;
    ButtonDynamicListView: TButton;
    procedure ButtonMaterialDesignClick(Sender: TObject);
    procedure ButtonColorAnimationClick(Sender: TObject);
    procedure ButtonMenuClick(Sender: TObject);
    procedure ButtonTransparentEditClick(Sender: TObject);
    procedure ButtonDynamicListViewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses
  UFormDynamicListView,
  UFormMaterialDesignLayout,
  UFormTransparentEdit,
  UFormColorAnimation,
  UFormMenu;

procedure TFormMain.ButtonMaterialDesignClick(Sender: TObject);
begin
  FormMaterialDesignLayout.Show;
end;

procedure TFormMain.ButtonColorAnimationClick(Sender: TObject);
begin
  FormColorAnimation.Show;
end;

procedure TFormMain.ButtonMenuClick(Sender: TObject);
begin
  FormMenu.Show;
end;

procedure TFormMain.ButtonTransparentEditClick(Sender: TObject);
begin
  FormTransparentEdit.Show;
end;

procedure TFormMain.ButtonDynamicListViewClick(Sender: TObject);
begin
  FormDynamicListView.Show;
end;

end.
