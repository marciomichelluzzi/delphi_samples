unit UFormDynamicListView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TTipoLayout = (tlPortait, tlLandScape);

  TFormDynamicListView = class(TForm)
    RectangleToolBar: TRectangle;
    ShadowEffectToolBar: TShadowEffect;
    ButtonMenu: TButton;
    VertScrollBoxDynamicListView: TVertScrollBox;
    GridLayoutDynamicListView: TGridLayout;
    Rectangle2: TRectangle;
    ShadowEffect2: TShadowEffect;
    Rectangle3: TRectangle;
    ShadowEffect3: TShadowEffect;
    Rectangle4: TRectangle;
    ShadowEffect4: TShadowEffect;
    Rectangle5: TRectangle;
    ShadowEffect5: TShadowEffect;
    Rectangle6: TRectangle;
    ShadowEffect6: TShadowEffect;
    Rectangle7: TRectangle;
    ShadowEffect7: TShadowEffect;
    Rectangle8: TRectangle;
    ShadowEffect8: TShadowEffect;
    Rectangle9: TRectangle;
    ShadowEffect9: TShadowEffect;
    Rectangle10: TRectangle;
    ShadowEffect10: TShadowEffect;
    Rectangle11: TRectangle;
    ShadowEffect11: TShadowEffect;
    ButtonBack: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonMenuClick(Sender: TObject);
    procedure ButtonBackClick(Sender: TObject);
  private
    poTela: TTipoLayout;
    procedure TamanhoItens;
    procedure LayoutPortait(oGridLayout: TGridLayout);
    procedure LayoutLandScape(oGridLayout: TGridLayout);
    procedure MudaLayout;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDynamicListView: TFormDynamicListView;

implementation

{$R *.fmx}

procedure TFormDynamicListView.ButtonBackClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TFormDynamicListView.ButtonMenuClick(Sender: TObject);
begin
  MudaLayout;
end;

procedure TFormDynamicListView.FormCreate(Sender: TObject);
begin
  TamanhoItens;
end;

procedure TFormDynamicListView.TamanhoItens;
var
  iMargin, iItemHeight: Single;
  iControlsCount: Integer;
begin
  iControlsCount := GridLayoutDynamicListView.ControlsCount;
  if (Odd(iControlsCount)) then
    iControlsCount := iControlsCount + 1;
  iMargin := 10 * iControlsCount;
  iItemHeight := GridLayoutDynamicListView.ItemHeight - 10;
  GridLayoutDynamicListView.Height :=
    (iItemHeight * (iControlsCount / 2) - iMargin);
  GridLayoutDynamicListView.ItemWidth := ClientWidth / 2;
  GridLayoutDynamicListView.ItemHeight := ClientHeight / 2 - 62;
end;

procedure TFormDynamicListView.LayoutPortait(oGridLayout: TGridLayout);
var
  iMargin, iControlsCount: Integer;
begin
  iControlsCount := oGridLayout.ControlsCount;
  if (oGridLayout <> NIL) then
  begin
    if (Odd(iControlsCount)) then
      iControlsCount := iControlsCount + 1;
    iMargin := 10 * iControlsCount;
    oGridLayout.AnimateFloat('ItemWidth', ClientWidth / 2, 0.4,
      TAnimationType.InOut, TInterpolationType.Cubic);
    oGridLayout.AnimateFloat('ItemHeight', ClientHeight / 2 - 62, 0.4,
      TAnimationType.InOut, TInterpolationType.Cubic);
    oGridLayout.Width := ClientWidth;
    poTela := tlPortait;
    oGridLayout.Height := ((oGridLayout.ItemHeight * iControlsCount) / 2);
  end;
end;

procedure TFormDynamicListView.LayoutLandScape(oGridLayout: TGridLayout);
begin
  if (oGridLayout <> NIL) then
  begin
    oGridLayout.AnimateFloat('ItemWidth', ClientWidth, 0.1,
      TAnimationType.InOut, TInterpolationType.Cubic);
    oGridLayout.AnimateFloat('ItemHeight', ClientHeight / 2 - 62, 0.1,
      TAnimationType.InOut, TInterpolationType.Cubic);
    oGridLayout.Height := (oGridLayout.ItemHeight * oGridLayout.ControlsCount);
    poTela := tlLandScape;
  end;
end;

procedure TFormDynamicListView.MudaLayout;
begin
  if (not(poTela = tlPortait)) then
  begin
    LayoutPortait(GridLayoutDynamicListView);
  end
  else
  begin
    LayoutLandScape(GridLayoutDynamicListView);
  end;
end;

end.
