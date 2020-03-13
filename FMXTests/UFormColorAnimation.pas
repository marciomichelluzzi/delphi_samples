unit UFormColorAnimation;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Effects,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TFormColorAnimation = class(TForm)
    RectangleBackground: TRectangle;
    CircleShape: TCircle;
    ShadowEffect1: TShadowEffect;
    ToolBarColorAnimation: TToolBar;
    ButtonBack: TButton;
    procedure CircleShapeClick(Sender: TObject);
    procedure ButtonBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormColorAnimation: TFormColorAnimation;

implementation

{$R *.fmx}

procedure TFormColorAnimation.ButtonBackClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TFormColorAnimation.CircleShapeClick(Sender: TObject);
begin
  if (CircleShape.Fill.Color = TAlphaColorRec.Blue) then
  begin
    CircleShape.AnimateFloat('Margins.Top', 180, 0.5, TAnimationType.InOut,
      TInterpolationType.Cubic);
    CircleShape.AnimateColor('Fill.Color', TAlphaColorRec.Red, 0.5);
  end
  else
  begin
    CircleShape.AnimateFloat('Margins.Top', 0, 0.5, TAnimationType.InOut,
      TInterpolationType.Cubic);
    CircleShape.AnimateColor('Fill.Color', TAlphaColorRec.Blue, 0.5);
  end;
end;

end.
