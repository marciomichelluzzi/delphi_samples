unit UFormColorMoveAnimation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects;

type
  TFormColorMoveAnimation = class(TForm)
    RectangleBackground: TRectangle;
    CircleMoved: TCircle;
    ShadowEffect: TShadowEffect;
    procedure CircleMovedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormColorMoveAnimation: TFormColorMoveAnimation;

implementation

{$R *.fmx}

procedure TFormColorMoveAnimation.CircleMovedClick(Sender: TObject);
begin
  if (CircleMoved.Fill.Color = TAlphaColorRec.Blue) then
  begin
    CircleMoved.AnimateFloat('Margins.Top', 180, 0.5, TAnimationType.InOut,
      TInterpolationType.Cubic);
    CircleMoved.AnimateColor('Fill.Color', TAlphaColorRec.Red, 0.5);
  end
  else
  begin
    CircleMoved.AnimateFloat('Margins.Top', 0, 0.5, TAnimationType.InOut,
      TInterpolationType.Cubic);
    CircleMoved.AnimateColor('Fill.Color', TAlphaColorRec.Blue, 0.5);
  end;
end;

end.
