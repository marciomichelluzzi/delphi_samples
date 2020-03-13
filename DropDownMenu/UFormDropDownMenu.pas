unit UFormDropDownMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListBox, FMX.Layouts, FMX.Effects, FMX.Objects;

type
  TFormDropDownMenu = class(TForm)
    rctMenu: TRectangle;
    ShadowEffect1: TShadowEffect;
    lst1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem3: TListBoxItem;
    rctToolbar: TRectangle;
    btnMenu: TButton;
    lblTitulo: TLabel;
    btnMenu1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lst1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure btnMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Menu;
  end;

var
  FormDropDownMenu: TFormDropDownMenu;

implementation

{$R *.fmx}

procedure TFormDropDownMenu.btnMenuClick(Sender: TObject);
begin
  Menu;
end;

procedure TFormDropDownMenu.FormCreate(Sender: TObject);
begin
  rctMenu.Position.Y := 0 - rctMenu.Height;
end;

procedure TFormDropDownMenu.lst1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Menu;
end;

procedure TFormDropDownMenu.Menu;
begin
  if (rctMenu.Position.Y = 0 - rctMenu.Height) then
  begin
    btnMenu.AnimateFloat('RotationAngle', 90, 0.3);
    rctMenu.AnimateFloat('Position.Y', 55, 0.3, TAnimationType.InOut,
      TInterpolationType.Cubic);
  end
  else
  begin
    btnMenu.AnimateFloat('RotationAngle', 0, 0.3);
    rctMenu.AnimateFloat('Position.Y', 0 - rctMenu.Height, 0.3,
      TAnimationType.InOut, TInterpolationType.Cubic);
  end;
end;

end.
