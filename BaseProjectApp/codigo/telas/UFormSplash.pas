unit UFormSplash;

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
  FMX.Dialogs, FMX.Objects, UThreadSincronizacao, UFrameWait;

type
  TFormSplash = class(TForm)
    RectangleSplash: TRectangle;
    TimerSplash: TTimer;
    ImageSplashLogo: TImage;
    TextSplashSlogan: TText;
    FrameWait: TFrameWait;
    procedure FormCreate(Sender: TObject);
    procedure ImageSplashLogoPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure TimerSplashTimer(Sender: TObject);
  private
    { Private declarations }
    Inicializado: Boolean;
    ThreadSincronizacao: TThreadSincronizacao;
    procedure InicializarApp();
    procedure ThreadSincronizarOnTerminate(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FormSplash: TFormSplash;

implementation

{$R *.fmx}
{ TFormSplash }

uses
  IdSSLOpenSSLHeaders,

  System.IOUtils, UFormMain;

procedure TFormSplash.FormCreate(Sender: TObject);
begin
  Inicializado := false;
  TimerSplash.Enabled := false;
  TimerSplash.Interval := 2000;
end;

procedure TFormSplash.ImageSplashLogoPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  TimerSplash.Enabled := not Inicializado;
end;

procedure TFormSplash.InicializarApp;
var
  ListaLinks: TList<String>;
begin
{$IF DEFINED(ANDROID)}
  IdOpenSSLSetLibPath(TPath.GetDocumentsPath);
{$ENDIF}
  Application.FormFactor.Orientations := [TFormOrientation.Portrait,
    TFormOrientation.InvertedPortrait];

  ReportMemoryLeaksOnShutdown := true;

  // Inicializar o modulo de dados;
  // Pegar a lista de Downloads
  // Baixar as imagens necessárias
  // Quando acabar carregar a aplicação
  ListaLinks := nil;
  FrameWait.MostrarMensagem('Aguarde', 'Sincronizando informações');
  ThreadSincronizacao := TThreadSincronizacao.Create('LinkServidor', 'Usuario',
    'Senha', ListaLinks);
  ThreadSincronizacao.OnTerminate := ThreadSincronizarOnTerminate;
  ThreadSincronizacao.FreeOnTerminate := true;
  ThreadSincronizacao.Start();
end;

procedure TFormSplash.ThreadSincronizarOnTerminate(Sender: TObject);
begin
  FrameWait.OcultarMensagem();
  if not Assigned(FormMain) then
    Application.CreateForm(TFormMain, FormMain);

{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  FormMain.Show();
{$ELSE}
  FormMain.Show();
{$ENDIF}
  Application.MainForm := FormMain;
  Self.Close;
end;

procedure TFormSplash.TimerSplashTimer(Sender: TObject);
begin
  TimerSplash.Enabled := false;
  if not Inicializado then
  begin
    Inicializado := true;
    InicializarApp();
  end;
end;

end.
