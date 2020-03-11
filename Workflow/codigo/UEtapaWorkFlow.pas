unit UEtapaWorkFlow;

interface

uses
  FMX.Objects;

type
  TStatusEtapa = (NAO_INICIADA, EM_ANDAMENTO, CONCLUIDA);

type
  TEtapaWorkFlow = class(Tobject)
  private

  protected

  public

    FNome: String;
    FImagem: TImage;
    FStatus: TStatusEtapa;

    property Nome: String read FNome write FNome;
    property Imagem: TImage read FImagem write FImagem;
    property Status: TStatusEtapa read FStatus write FStatus;

  end;

implementation

end.
