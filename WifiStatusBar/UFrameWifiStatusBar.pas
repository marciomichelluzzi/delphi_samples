unit UFrameWifiStatusBar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani;

type
  TFrameWifiStatus = class(TFrame)
    RectangleFundo: TRectangle;
    FloatAnimationFundo: TFloatAnimation;
    TextMensagem: TText;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowStatusBar(PMostrar: Boolean);
    procedure SetStatusWifi(PConectado: Boolean);
  end;

implementation

{$R *.fmx}
{ TFrameWifiStatus }

procedure TFrameWifiStatus.SetStatusWifi(PConectado: Boolean);
begin
  if PConectado then
  begin
    RectangleFundo.Fill.Color := TAlphaColors.Green;
    RectangleFundo.Stroke.Color := TAlphaColors.Green;
    TextMensagem.Text := 'Conexão reestabelecida';
    FloatAnimationFundo.Duration := 0.7;
  end
  else
  begin
    RectangleFundo.Fill.Color := TAlphaColors.Tomato;
    RectangleFundo.Stroke.Color := TAlphaColors.Tomato;
    TextMensagem.Text := 'Sem conexão com a internet';
    FloatAnimationFundo.Duration := 0.2;
  end;
  ShowStatusBar(not PConectado);
end;

procedure TFrameWifiStatus.ShowStatusBar(PMostrar: Boolean);
begin
  if PMostrar then
  begin
    FloatAnimationFundo.StartValue := 0;
    FloatAnimationFundo.StopValue := 50;
  end
  else
  begin
    FloatAnimationFundo.StartValue := 50;
    FloatAnimationFundo.StopValue := 0;
  end;
  FloatAnimationFundo.Start();
end;

end.
