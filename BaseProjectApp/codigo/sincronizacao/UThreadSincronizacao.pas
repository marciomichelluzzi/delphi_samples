unit UThreadSincronizacao;

interface

uses
  System.Generics.Collections,
  System.Classes;

type
  TThreadSincronizacao = class(TThread)
  private

    FLinkServidor: String;
    FUsuario: String;
    FSenha: String;
    FHasError: Boolean;
    FMensagemErro: String;
    FListaLinks: TList<String>;

    property LinkServidor: String read FLinkServidor write FLinkServidor;
    property Usuario: String read FUsuario write FUsuario;
    property Senha: String read FSenha write FSenha;

  protected
    procedure Execute(); override;

  public

    property PossuiErro: Boolean read FHasError write FHasError;
    property MensagemErro: String read FMensagemErro write FMensagemErro;
    property ListaLinks: TList<String> read FListaLinks write FListaLinks;

    constructor Create(PLinkServidor: String; PUsuario: String; PSenha: String;
      PListaLinks: TList<String>);
  end;

implementation

{ TThreadSincronizacao }

uses
  System.SysUtils;

constructor TThreadSincronizacao.Create(PLinkServidor, PUsuario, PSenha: String;
  PListaLinks: TList<String>);
begin
  inherited Create(true);
end;

procedure TThreadSincronizacao.Execute;
var
  LNomeArquivo: String;
  LCaminhoCompleto: String;
begin
  inherited;

  // Pegar nome do arquivo

  // Gerar o caminho Completo

  Sleep(4000);

  // Baixa os arquivos do link
  if not FileExists(LCaminhoCompleto) then
  begin

  end;
end;

end.
