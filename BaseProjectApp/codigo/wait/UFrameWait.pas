unit UFrameWait;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts;

type
  TFrameWait = class(TFrame)
    RectangleFundo: TRectangle;
    RectangleFrente: TRectangle;
    AniIndicatorStatus: TAniIndicator;
    TextMensagem: TText;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MostrarMensagem(PTitulo, PMensagem: String);
    procedure OcultarMensagem();
  end;

implementation

{$R *.fmx}
{ TFrameWait }

procedure TFrameWait.MostrarMensagem(PTitulo, PMensagem: String);
begin
  // TextTitulo.Text := PTitulo;
  TextMensagem.Text := PMensagem;
  AniIndicatorStatus.Enabled := true;
  Self.Visible := true;
end;

procedure TFrameWait.OcultarMensagem;
begin
  AniIndicatorStatus.Enabled := false;
  Self.Visible := false
end;

end.
