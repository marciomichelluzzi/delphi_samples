unit UFormDynamicListGrid;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.Objects;

type
  TTipoLayout = (tlPortait, tlLandScape);

  TFormDynamicListGrid = class(TForm)
    RectangleToolBar: TRectangle;
    ShadowEffect1: TShadowEffect;
    btnVisualizacao: TButton;
    VertScrollBoxDynamic: TVertScrollBox;
    GridLayoutDynamic: TGridLayout;
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
    procedure btnVisualizacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    poTela: TTipoLayout;
    procedure TamanhoItens;
    procedure LayoutPortait(oGridLayout: TGridLayout);
    procedure LayoutLandScape(oGridLayout: TGridLayout);
    procedure MudaLayout;
  public
    { Public declarations }
  end;

var
  FormDynamicListGrid: TFormDynamicListGrid;

implementation

{$R *.fmx}

procedure TFormDynamicListGrid.FormCreate(Sender: TObject);
begin
  TamanhoItens;
  MudaLayout;
end;

procedure TFormDynamicListGrid.TamanhoItens;
var
  iMargin, iItemHeight: Single;
  iControlsCount: Integer;
begin
  iControlsCount := GridLayoutDynamic.ControlsCount;
  if (Odd(iControlsCount)) then
    iControlsCount := iControlsCount + 1;
  iMargin := 10 * iControlsCount;
  iItemHeight := GridLayoutDynamic.ItemHeight - 10;
  GridLayoutDynamic.Height := (iItemHeight * (iControlsCount / 2) - iMargin);
  GridLayoutDynamic.ItemWidth := ClientWidth / 2;
  GridLayoutDynamic.ItemHeight := ClientHeight / 2 - 62;
end;

procedure TFormDynamicListGrid.LayoutPortait(oGridLayout: TGridLayout);
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

procedure TFormDynamicListGrid.btnVisualizacaoClick(Sender: TObject);
begin
  MudaLayout;
end;

procedure TFormDynamicListGrid.LayoutLandScape(oGridLayout: TGridLayout);
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

procedure TFormDynamicListGrid.MudaLayout;
begin
  if (not(poTela = tlPortait)) then
  begin
    LayoutPortait(GridLayoutDynamic);
  end
  else
  begin
    LayoutLandScape(GridLayoutDynamic);
  end;
end;

end.
