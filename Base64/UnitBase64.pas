unit UnitBase64;

{$IFDEF DEBUG}
// se for necessário depurar esta UNIT, ligue este define,
// caso contrário, mantenha-o em comentário
// {$DEFINE FORMFEED_DBG}
{$ENDIF}

interface

uses System.SysUtils, Classes, IdCoderMIME, IdGlobal;

type
  TBase64 = class(TObject)

  private

    FidEncoderMIME: TIdEncoderMIME;
    FidDecoderMIME: TIdDecoderMIME;

  public

    property idEncoderMIME: TIdEncoderMIME read FidEncoderMIME
      write FidEncoderMIME;
    property idDecoderMIME: TIdDecoderMIME read FidDecoderMIME
      write FidDecoderMIME;

    function encodeToString(Pmemorystream: TMemoryStream): String; overload;
    function decodeToString(Pmemorystream: TMemoryStream): String; overload;
    function encodeToStream(Pstring: String): TMemoryStream;
    function decodeToStream(Pstring: String): TMemoryStream;
    function decodeToString(Pstring: String): String; overload;

    constructor Create();
    destructor Destroy(); override;
  end;

var
  Base64: TBase64;

implementation

{ TBase64 }

uses
  EncdDecd, FMX.Dialogs, FMX.Graphics, IOUtils, System.NetEncoding;

constructor TBase64.Create;
begin
  idEncoderMIME := TIdEncoderMIME.Create(nil);
  idDecoderMIME := TIdDecoderMIME.Create(nil);
end;

function TBase64.decodeToStream(Pstring: String): TMemoryStream;
var
  memoryStream: TMemoryStream;
begin
  memoryStream := TMemoryStream.Create;
  memoryStream.Position := 0;
  idDecoderMIME.DecodeStream(Pstring, memoryStream);
  Result := memoryStream;
  // memoryStream.DisposeOf();
end;

function TBase64.decodeToString(Pmemorystream: TMemoryStream): String;
begin

end;

function TBase64.decodeToString(Pstring: String): String;
begin
  Result := idDecoderMIME.DecodeString(Pstring, IndyTextEncoding_UTF8);
end;

destructor TBase64.Destroy;
begin
  idEncoderMIME.DisposeOf();
  idEncoderMIME := nil;
  idDecoderMIME.DisposeOf();
  idDecoderMIME := nil;
  inherited;
end;

function TBase64.encodeToStream(Pstring: String): TMemoryStream;
begin
  Result := nil;
end;

function TBase64.encodeToString(Pmemorystream: TMemoryStream): String;
begin
  Pmemorystream.Position := 0;
  Result := idEncoderMIME.EncodeStream(Pmemorystream, Pmemorystream.Size);
end;

end.

// http://stackoverflow.com/questions/22026825/base64-encode-and-decode-is-not-working
// http://stackoverflow.com/questions/28669994/base64-decode-a-string-using-netencoding-in-delphi-xe7
// http://docwiki.embarcadero.com/RADStudio/XE7/en/What%27s_New_in_Delphi_and_C%2B%2BBuilder_XE7
// http://stackoverflow.com/questions/17109223/delphi-xe2-encode-decode-base-64
