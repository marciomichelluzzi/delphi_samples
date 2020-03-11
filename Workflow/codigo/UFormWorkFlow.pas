unit UFormWorkFlow;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  UFrameWorkFlow,
  FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TFormWorkFlow = class(TForm)
    FrameWorkFlow: TFrameWorkFlow;
    ButtonGerarWorkFlow: TButton;
    procedure ButtonGerarWorkFlowClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWorkFlow: TFormWorkFlow;

implementation

{$R *.fmx}

uses UEtapaWorkFlow;

procedure TFormWorkFlow.ButtonGerarWorkFlowClick(Sender: TObject);
var
  I: Integer;
  LListaEtapas: TList<TEtapaWorkFlow>;
  LEtapaWorkFlow: TEtapaWorkFlow;
begin
  LListaEtapas := TList<TEtapaWorkFlow>.Create();
  for I := 0 to 5 do
  begin
    LEtapaWorkFlow := TEtapaWorkFlow.Create();
    LEtapaWorkFlow.Nome := 'Etapa - ' + IntToStr(I);
    LEtapaWorkFlow.Status := TStatusEtapa(Random(3));

    LListaEtapas.Add(LEtapaWorkFlow);
  end;

  FrameWorkFlow.MontarWorkFlow(LListaEtapas);
end;

end.
