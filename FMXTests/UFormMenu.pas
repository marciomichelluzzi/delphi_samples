unit UFormMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Effects, FMX.ListBox,
  FMX.Layouts;

type
  TFormMenu = class(TForm)
    RectangleToolBar: TRectangle;
    ButtonMenu: TButton;
    LabelTitle: TLabel;
    RectangleMenu: TRectangle;
    ShadowEffect: TShadowEffect;
    ListBoxMenuOptions: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem3: TListBoxItem;
    procedure FormCreate(Sender: TObject);
    procedure ButtonMenuClick(Sender: TObject);
    procedure ListBoxMenuOptionsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    { Private declarations }
  public
    procedure Menu;
  end;

var
  FormMenu: TFormMenu;

implementation

{$R *.fmx}

procedure TFormMenu.ButtonMenuClick(Sender: TObject);
begin
  Menu;
end;

procedure TFormMenu.FormCreate(Sender: TObject);
begin
  RectangleMenu.Position.Y := 0 - RectangleMenu.Height;
end;

procedure TFormMenu.ListBoxMenuOptionsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Menu;
end;

procedure TFormMenu.Menu;
begin
  if (RectangleMenu.Position.Y = 0 - RectangleMenu.Height) then
  begin
    ButtonMenu.AnimateFloat('RotationAngle', 90, 0.3);
    RectangleMenu.AnimateFloat('Position.Y', 55, 0.3, TAnimationType.InOut,
      TInterpolationType.Cubic);
  end
  else
  begin
    ButtonMenu.AnimateFloat('RotationAngle', 0, 0.3);
    RectangleMenu.AnimateFloat('Position.Y', 0 - RectangleMenu.Height, 0.3,
      TAnimationType.InOut, TInterpolationType.Cubic);
  end;
end;

end.
