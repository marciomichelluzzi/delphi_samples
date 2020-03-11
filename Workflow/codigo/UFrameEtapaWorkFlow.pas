unit UFrameEtapaWorkFlow;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Objects,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls, FMX.Layouts,

  UEtapaWorkFlow;

type
  TFrameEtapaWorkFlow = class(TFrame)
    GridPanelLayoutEtapaWorkFlow: TGridPanelLayout;
    CircleStatusEtapaWorkFlow: TCircle;
    RectangleAnterior: TRectangle;
    RectangleProximo: TRectangle;
    TextNomeEtapaWorkFlow: TText;
  private
    FEtapaWorkFlow: TEtapaWorkFlow;
    { Private declarations }
  public
    { Public declarations }
    property EtapaWorkFlow: TEtapaWorkFlow read FEtapaWorkFlow
      write FEtapaWorkFlow;

    procedure MontarFrameEtapaWorkflow(PEtapaWorkFlow: TEtapaWorkFlow;
      HePrimeira, HeUltima: Boolean);
  end;

implementation

{$R *.fmx}
{ TFrameEtapaWorkFlow }

procedure TFrameEtapaWorkFlow.MontarFrameEtapaWorkflow(PEtapaWorkFlow
  : TEtapaWorkFlow; HePrimeira, HeUltima: Boolean);
begin
  EtapaWorkFlow := PEtapaWorkFlow;

  TextNomeEtapaWorkFlow.Text := EtapaWorkFlow.Nome;

  if EtapaWorkFlow.Imagem <> nil then
  begin
    CircleStatusEtapaWorkFlow.Fill.Kind := TBrushKind.Bitmap;
    CircleStatusEtapaWorkFlow.Fill.Bitmap.Assign(EtapaWorkFlow.Imagem.Bitmap);
  end;

  case EtapaWorkFlow.Status of
    NAO_INICIADA:
      begin
        CircleStatusEtapaWorkFlow.Fill.Color := TAlphaColorRec.Red;
        RectangleAnterior.Fill.Color := TAlphaColorRec.Red;
        RectangleProximo.Fill.Color := TAlphaColorRec.Red;
        TextNomeEtapaWorkFlow.TextSettings.FontColor := TAlphaColorRec.Red;
      end;

    EM_ANDAMENTO:
      begin
        CircleStatusEtapaWorkFlow.Fill.Color := TAlphaColorRec.Yellow;
        RectangleAnterior.Fill.Color := TAlphaColorRec.Yellow;
        RectangleProximo.Fill.Color := TAlphaColorRec.Yellow;
        TextNomeEtapaWorkFlow.TextSettings.FontColor := TAlphaColorRec.Yellow;
      end;
    CONCLUIDA:
      begin
        CircleStatusEtapaWorkFlow.Fill.Color := TAlphaColorRec.Green;
        RectangleAnterior.Fill.Color := TAlphaColorRec.Green;
        RectangleProximo.Fill.Color := TAlphaColorRec.Green;
        TextNomeEtapaWorkFlow.TextSettings.FontColor := TAlphaColorRec.Green;
      end;
  end;

  if HePrimeira then
    RectangleAnterior.Fill.Color := TAlphaColorRec.Null;

  if HeUltima then
    RectangleProximo.Fill.Color := TAlphaColorRec.Null;
end;

end.
