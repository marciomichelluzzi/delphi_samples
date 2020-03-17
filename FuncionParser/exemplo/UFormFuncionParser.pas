unit UFormFuncionParser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, UFuncionParser;

type
  TFormFuncionParser = class(TForm)
    ButtonGenerateGraph: TButton;
    PaintBox3D: TPaintBox;
    LabelError: TLabel;
    ComboBoxEquations: TComboBox;
    PanelToolbar: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonGenerateGraphClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FuncionParser1ParserError(Sender: TObject; ParseError: Integer);
    procedure FuncionParser1PideVariable(Sender: TObject; Variable: String;
      var Valor: Extended; var Found: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    XCen, YCen: Integer;
    FuncionParser: TFuncionParser;
    function Get2DPoint(X, Y, Z: Extended): TPoint;
    procedure Do3DGraph;
  public
    { Public declarations }
  end;

const
  Ratio = 35;
  Sections = 90;
  Bounds = 2;

var
  FormFuncionParser: TFormFuncionParser;
  X2, Y2: Extended;

implementation

{$R *.DFM}

{ determina el Punto Tridimensional en el canvas bidimensional... }
function TFormFuncionParser.Get2DPoint(X, Y, Z: Extended): TPoint;
begin
  Result := Point(Round(XCen + Ratio * (X - Y * 1 / sqrt(2))),
    Round(YCen + Ratio * (-Z + Y * 1 / sqrt(2))));
end;

function f(X1, Y1: real): real;
begin
  X2 := X1;
  Y2 := Y1;
  FormFuncionParser.FuncionParser.Parse;
  if not FormFuncionParser.FuncionParser.ParseError then
    f := FormFuncionParser.FuncionParser.ParseValor
  else
    f := 0;
end;

{ Este es un muy simple aunque no muy rápido algoritmo de }
{ dibujado tridimensional ... }
procedure TFormFuncionParser.Do3DGraph;
var
  I: Integer;
  P: TPoint;
  X, Y, H: Extended;
  Max, Min: Array [0 .. 1024] of Integer;
begin
  FuncionParser.funcion := ComboBoxEquations.text;
  LabelError.Caption := 'No hay Problema';
  with PaintBox3D.Canvas do
  begin
    Brush.Color := clBlack;
    FillRect(Rect(0, 0, Width, Height));

    for I := 0 to 1024 do
    begin
      Max[I] := 0;
      Min[I] := Height;
    end;

    X := Bounds;
    H := 2 * Bounds / Sections;
    while X >= -Bounds do
    begin
      Y := -Bounds;
      while Y <= Bounds do
      begin
        P := Get2DPoint(X, Y, f(X, Y));
        if P.Y > Max[P.X] then
        begin
          Pixels[P.X, P.Y] := clRed;
          Max[P.X] := P.Y;
        end;
        if P.Y < Min[P.X] then
        begin
          Pixels[P.X, P.Y] := clYellow;
          Min[P.X] := P.Y;
        end;

        Y := Y + H;
      end;
      X := X - H;
    end;
  end;
end;

procedure TFormFuncionParser.FormCreate(Sender: TObject);
begin
  XCen := PaintBox3D.Width div 2;
  YCen := PaintBox3D.Height div 2;

  FuncionParser := TFuncionParser.Create(Self);
  FuncionParser.OnPideVariable := FuncionParser1PideVariable;
  FuncionParser.OnParserError := FuncionParser1ParserError;
end;

procedure TFormFuncionParser.ButtonGenerateGraphClick(Sender: TObject);
begin
  LabelError.Caption := '';
  LabelError.Font.Color := TColor(clYellow);
  FuncionParser.funcion := ComboBoxEquations.text;
  f(0, 0);
  if not FuncionParser.ParseError then
    Do3DGraph;
end;

procedure TFormFuncionParser.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormFuncionParser.FuncionParser1ParserError(Sender: TObject;
  ParseError: Integer);
var
  Msg: string;
begin
  case ParseError of
    1:
      Msg := 'Desbordamiento de Pila.';
    2:
      Msg := 'Valor Fuera de Rango.';
    3:
      Msg := 'Esperaba una Expresión.';
    4:
      Msg := 'Esperaba un Operador.';
    5:
      Msg := 'Esperaba Parentesis que Abre "(".';
    6:
      Msg := 'Esperaba Parentesis que Cierra ")".';
  end; { case }
  LabelError.Caption := 'Error! ' + Msg;
  LabelError.Font.Color := TColor(clRed);
end;

procedure TFormFuncionParser.FuncionParser1PideVariable(Sender: TObject;
  Variable: String; var Valor: Extended; var Found: Boolean);
begin
  Found := true;
  If uppercase(Variable) = 'X' then
    Valor := X2
  else If uppercase(Variable) = 'Y' then
    Valor := Y2
  else
    Found := false;
end;

procedure TFormFuncionParser.FormShow(Sender: TObject);
begin
  ComboBoxEquations.ItemIndex := 0;
end;

end.
