unit UFormProgressiveCircle;

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
  FMX.Dialogs,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.Controls.Presentation;

type
  TFormPregressiveCircle = class(TForm)
    ArcProgressive: TArc;
    TrackBar1: TTrackBar;
    CircleProgressiveCircle: TCircle;
    CircleInternal: TCircle;
    TextValue: TText;
    ButtonStart: TButton;
    FloatAnimation1: TFloatAnimation;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPregressiveCircle: TFormPregressiveCircle;

implementation

{$R *.fmx}

procedure TFormPregressiveCircle.ButtonStartClick(Sender: TObject);
begin
  if FloatAnimation1.Enabled then
    ButtonStart.Text := 'Start'
  else
    ButtonStart.Text := 'Stop';
  FloatAnimation1.Enabled := not FloatAnimation1.Enabled;
end;

procedure TFormPregressiveCircle.FormCreate(Sender: TObject);
begin
  TrackBar1Change(Sender);
end;

procedure TFormPregressiveCircle.TrackBar1Change(Sender: TObject);
begin
  if TrackBar1.Value <> 0 then
    ArcProgressive.EndAngle := 360 / (100 / TrackBar1.Value)
  else
    ArcProgressive.EndAngle := 0;
  TextValue.Text := Trunc(TrackBar1.Value).ToString + '%';
end;

end.
