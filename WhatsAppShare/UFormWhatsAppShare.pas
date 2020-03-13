unit UFormWhatsAppShare;

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
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.TabControl,
  FMX.ListBox,
  FMX.Layouts,
  FMX.VirtualKeyboard,

{$IFDEF ANDROID}
  Androidapi.Jni.Net,
  Androidapi.Jni.JavaTypes,
  Androidapi.Jni,
  Androidapi.JNIBridge,
  Androidapi.Helpers,
  FMX.Helpers.Android,
  Androidapi.Jni.GraphicsContentViewText,
{$ENDIF ANDROID}
{$IFDEF IOS}
  Macapi.Helpers,
  iOSapi.Foundation,
  FMX.Helpers.iOS,
{$ENDIF IOS}
  FMX.Platform;

type
  TFormWhatsAppShare = class(TForm)
    ToolBarWhatsAppShare: TToolBar;
    LabelTitle: TLabel;
    ButtonShare: TSpeedButton;
    procedure ButtonShareClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWhatsAppShare: TFormWhatsAppShare;

implementation

{$R *.fmx}

procedure TFormWhatsAppShare.ButtonShareClick(Sender: TObject);
var
  LMessage: string;
  LRet: boolean;

{$IFDEF ANDROID}
  IntentWhats: JIntent;
{$ENDIF ANDROID}
{$IFDEF IOS}
  NSU: NSUrl;
{$ENDIF IOS}
begin
  LMessage := 'Share this message in WhatsApp';
  LMessage := 'whatsapp://send?text=' + LMessage;

{$IFDEF ANDROID}
  IntentWhats := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
  IntentWhats.setType(StringToJString('text/plain'));
  IntentWhats.putExtra(TJIntent.JavaClass.EXTRA_TEXT,
    StringToJString(LMessage));
  IntentWhats.setPackage(StringToJString('com.whatsapp'));
  SharedActivity.startActivity(IntentWhats);
{$ENDIF ANDROID}
{$IFDEF IOS}
  NSU := StrToNSUrl(mensagem);
  ret := SharedApplication.openUrl(NSU);
{$ENDIF IOS}
end;

end.
