unit UFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellApi;

type
  TFormShellExecute = class(TForm)
    ButtonExplorer: TButton;
    ButtonSite: TButton;
    ButtonImprimir: TButton;
    ButtonAbrir: TButton;
    procedure ButtonAbrirClick(Sender: TObject);
    procedure ButtonImprimirClick(Sender: TObject);
    procedure ButtonExplorerClick(Sender: TObject);
    procedure ButtonSiteClick(Sender: TObject);
  private
    { Private declarations }
  public
  { Public declarations }

    const
    FILE_PATH: String = 'C:\teste.txt';
    FOLDER_PATH: String = 'C:\';
    DOC_PATH: String = 'C:\teste.doc';
    SITE_PATH: String = 'http://www.google.com';
  end;

var
  FormShellExecute: TFormShellExecute;

implementation

{$R *.dfm}
{
  FORMATO:

  function ShellExecute(hWnd: HWND; Operation,
  FileName, Parameters, Directory: PChar; ShowCmd: Integer): HINST;


  hWnd:
  --- Handle da Janela que está executando o Comando.
  Operation:
  ---- Tipo de operação que se quer executar. Pode ser 'open', 'print' ou 'explorer'.
  FileName:
  --- O arquivo que se quer abrir.
  Parameters:
  --- Parâmetros a serem passados para o FileName que vai ser aberto.
  Este parâmetro é útil no caso de se passar no FileName o caminho de um executável.
  Directory:
  --- O diretório onde a aplicação deve executar.
  ShowCmd:
  --- indica o tipo de janela que deve ser aberta. Podemos utilizar por
  exemplo SW_HIDE (deixa a janela invisível), SW_MAXIMIZE (janela maximizada),
  SW_MINIMIZE (janela minimizada), SW_SHOWNORMAL (abre a janela restaurada e ativa).
  Retorno:
  --- A função possui erro quando o retorno é menor ou igual a 32.
  Exemplos de erros que podem ser testados são
  ERROR_FILE_NOT_FOUND (arquivo não encontrado),
  ERROR_PATH_NOT_FOUND (caminho não encontrado),
  SE_ERR_ACCESSDENIED (o programa não tem direito para acessar o arquivo/programa requisitado),
  SE_ERR_ASSOCINCOMPLETE (arquivo requisitado não possui associação definida),
  SE_ERR_SHARE (Violação de Compartilhamento), entre outros erros que podem ser mapeados.
}

procedure TFormShellExecute.ButtonImprimirClick(Sender: TObject);
begin
  ShellExecute(handle, 'print', PChar(DOC_PATH), '', '', SW_SHOWNORMAL);
end;

procedure TFormShellExecute.ButtonAbrirClick(Sender: TObject);
begin
  ShellExecute(handle, 'open', PChar(FILE_PATH), '', '', SW_SHOWNORMAL);
end;

procedure TFormShellExecute.ButtonExplorerClick(Sender: TObject);
begin
  ShellExecute(handle, 'explore', PChar(FOLDER_PATH), '', '', SW_SHOWMAXIMIZED);
end;

procedure TFormShellExecute.ButtonSiteClick(Sender: TObject);
begin
  ShellExecute(handle, 'open', PChar(SITE_PATH), '', '', SW_SHOWNORMAL)
end;

end.
