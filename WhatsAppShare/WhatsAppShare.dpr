program WhatsAppShare;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFormWhatsAppShare in 'UFormWhatsAppShare.pas' {FormWhatsAppShare};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormWhatsAppShare, FormWhatsAppShare);
  Application.Run;
end.
