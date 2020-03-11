unit UFormActionSheet;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Ani;

type
  TFormActionSheet = class(TForm)
    ToolBar: TToolBar;
    SpeedButtonMenu: TSpeedButton;
    LabelTituloToolBar: TLabel;
    LayoutMenu: TLayout;
    RectangleFundo: TRectangle;
    rect_selecao: TRoundRect;
    RectangleBase: TRectangle;
    LabelTitulo: TLabel;
    HorzScrollBoxAnos: THorzScrollBox;
    LabelSubTitulo: TLabel;
    Layout1: TLayout;
    Label4: TLabel;
    Layout2: TLayout;
    Label5: TLabel;
    Layout3: TLayout;
    Label6: TLabel;
    Layout4: TLayout;
    Label7: TLabel;
    Layout5: TLayout;
    Label8: TLabel;
    Layout6: TLayout;
    Label9: TLabel;
    Layout7: TLayout;
    Label10: TLabel;
    LabelCancelar: TLabel;
    Line1: TLine;
    LayoutValores: TLayout;
    Line2: TLine;
    LabelVendasValor: TLabel;
    LabelVendasTitulo: TLabel;
    RectangleVendas: TRectangle;
    LayoutVendas: TLayout;
    LayoutPedidos: TLayout;
    RectanglePedidos: TRectangle;
    LabelPedidosTitulo: TLabel;
    LabelPedidosValor: TLabel;
    LayoutChamados: TLayout;
    RectangleChamados: TRectangle;
    LabelChamadosTitulo: TLabel;
    LabelChamadosValor: TLabel;
    procedure SpeedButtonMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabelCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormActionSheet: TFormActionSheet;

implementation

{$R *.fmx}

procedure ExibirMenu();
begin
  with FormActionSheet do
  begin
    RectangleBase.Width := LayoutMenu.Width - 16;
    RectangleBase.Position.X := 8;
    RectangleBase.Position.Y := LayoutMenu.Height + 20;

    LayoutMenu.Visible := true;
    RectangleFundo.Opacity := 0;
    RectangleFundo.AnimateFloat('Opacity', 0.4, 0.2);

    RectangleBase.AnimateFloat('Position.Y', LayoutMenu.Height - 270 - 8, 0.5,
      TAnimationType.InOut, TInterpolationType.Circular);

  end;
end;

procedure EsconderMenu();
begin
  with FormActionSheet do
  begin
    RectangleBase.AnimateFloat('Position.Y', LayoutMenu.Height + 20, 0.3,
      TAnimationType.InOut, TInterpolationType.Circular);

    RectangleFundo.AnimateFloat('Opacity', 0, 0.6);

    TThread.CreateAnonymousThread(
      procedure
      begin
        sleep(800);
        LayoutMenu.Visible := false;
      end).Start;

  end;
end;

procedure TFormActionSheet.SpeedButtonMenuClick(Sender: TObject);
begin
  ExibirMenu;
end;

procedure TFormActionSheet.FormCreate(Sender: TObject);
begin
  LayoutMenu.Visible := false;
end;

procedure TFormActionSheet.LabelCancelarClick(Sender: TObject);
begin
  EsconderMenu;
end;

end.
