unit UFormMaterialDesignLayout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Effects,
  FMX.TabControl, System.Actions, FMX.ActnList;

type
  TFormMaterialDesignLayout = class(TForm)
    RectangleToolBar: TRectangle;
    ButtonBack: TButton;
    LabelTitle: TLabel;
    ButtonMenu: TButton;
    RectanglePageController: TRectangle;
    GridPanelLayout: TGridPanelLayout;
    rctLista: TRectangle;
    rctNovo: TRectangle;
    btnLista: TButton;
    btnAdd: TButton;
    RectangleActiveTab: TRectangle;
    LayoutToolBar: TLayout;
    ShadowEffect: TShadowEffect;
    RectangleBody: TRectangle;
    TabControlTabs: TTabControl;
    TabLista: TTabItem;
    TabItemAdd: TTabItem;
    actlst1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    Rectangle: TRectangle;
    Circle: TCircle;
    procedure FormCreate(Sender: TObject);
    procedure rctListaClick(Sender: TObject);
    procedure rctNovoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure MouseLeave(Sender: TObject);
    procedure ButtonBackClick(Sender: TObject);
  private
    oPageAtivo: TRectangle;
  public
    procedure Transicao(oRectangle: TRectangle);
  end;

var
  FormMaterialDesignLayout: TFormMaterialDesignLayout;

implementation

{$R *.fmx}

procedure TFormMaterialDesignLayout.ButtonBackClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TFormMaterialDesignLayout.FormCreate(Sender: TObject);
begin
  oPageAtivo := rctLista;
  RectangleActiveTab.Width := rctLista.Width;
  TabControlTabs.TabPosition := TTabPosition.None;
  TabControlTabs.TabIndex := 0;
end;

procedure TFormMaterialDesignLayout.FormResize(Sender: TObject);
begin
  Transicao(oPageAtivo);
end;

procedure TFormMaterialDesignLayout.rctListaClick(Sender: TObject);
begin
  Transicao(rctLista);
  oPageAtivo := rctLista;
  ChangeTabAction1.ExecuteTarget(TabControlTabs);
end;

procedure TFormMaterialDesignLayout.MouseLeave(Sender: TObject);
begin
  TRectangle(Sender).Fill.Color := TAlphaColor($FF2C2C2C);
end;

procedure TFormMaterialDesignLayout.MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TRectangle(Sender).Fill.Color := TAlphaColor($FF4B4B4B);
end;

procedure TFormMaterialDesignLayout.rctNovoClick(Sender: TObject);
begin
  Transicao(rctNovo);
  oPageAtivo := rctNovo;
  ChangeTabAction2.ExecuteTarget(TabControlTabs);
end;

procedure TFormMaterialDesignLayout.Transicao(oRectangle: TRectangle);
begin
  RectangleActiveTab.AnimateFloat('Position.X', oRectangle.Position.X, 0.2,
    TAnimationType.InOut, TInterpolationType.Cubic);
  RectangleActiveTab.AnimateFloat('Width', oRectangle.Width, 0.2,
    TAnimationType.InOut, TInterpolationType.Cubic);
end;

end.
