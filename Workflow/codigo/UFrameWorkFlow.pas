unit UFrameWorkFlow;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,

  UFrameEtapaWorkFlow,

  FMX.Objects,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  UEtapaWorkFlow, FMX.Layouts;

type
  TStatusEtapa = (NAO_INICIADA, EM_ANDAMENTO, CONCLUIDA, CANCELADA);

type
  TFrameWorkFlow = class(TFrame)
    VertScrollBoxWorkFlow: TVertScrollBox;
  private
    FNomeWorkFlow: String;
    FListaFramesEtapaWorkFlow: TList<TFrameEtapaWorkFlow>;
    { Private declarations }

    property NomeWorkFlow: String read FNomeWorkFlow write FNomeWorkFlow;
    property ListaFramesEtapaWorkFlow: TList<TFrameEtapaWorkFlow>
      read FListaFramesEtapaWorkFlow write FListaFramesEtapaWorkFlow;
  public
    { Public declarations }

    procedure MontarWorkFlow(PListaEtapasWorkFlow: TList<TEtapaWorkFlow>);
  end;

implementation

{$R *.fmx}
{ TFrame1 }

procedure TFrameWorkFlow.MontarWorkFlow(PListaEtapasWorkFlow
  : TList<TEtapaWorkFlow>);
var
  I: Integer;
  LNumeroEtapas: Integer;
  LFrameEtapaWorkflow: TFrameEtapaWorkFlow;
begin
  ListaFramesEtapaWorkFlow := TList<TFrameEtapaWorkFlow>.Create();
  LNumeroEtapas := PListaEtapasWorkFlow.Count - 1;

  for I := 0 to LNumeroEtapas - 1 do
  begin
    LFrameEtapaWorkflow := TFrameEtapaWorkFlow.Create(Self);
    LFrameEtapaWorkflow.Name := 'FrameEtapaWorkFlow' + IntToStr(I);

    if (I <> 0) and (I < LNumeroEtapas - 1) then
    begin
      LFrameEtapaWorkflow.MontarFrameEtapaWorkflow
        (PListaEtapasWorkFlow.Items[I], false, false);
    end
    else
    begin
      if I = 0 then
        LFrameEtapaWorkflow.MontarFrameEtapaWorkflow
          (PListaEtapasWorkFlow.Items[I], true, false);
      if I = LNumeroEtapas - 1 then
        LFrameEtapaWorkflow.MontarFrameEtapaWorkflow
          (PListaEtapasWorkFlow.Items[I], false, true);
    end;

    ListaFramesEtapaWorkFlow.Add(LFrameEtapaWorkflow);
  end;

  for I := 0 to ListaFramesEtapaWorkFlow.Count - 1 do
  begin
    LFrameEtapaWorkflow := ListaFramesEtapaWorkFlow.Items[I];
    VertScrollBoxWorkFlow.AddObject(LFrameEtapaWorkflow);
    LFrameEtapaWorkflow.Align := TAlignLayout.MostTop;
  end;

end;

end.
