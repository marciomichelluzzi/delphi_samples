unit UnitBase64;

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
    function encodeToString(Pstring: String): String; overload;
    function decodeToString(Pstring: String): String; overload;

    constructor Create();
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
end;

function TBase64.decodeToString(Pmemorystream: TMemoryStream): String;
begin

end;

function TBase64.decodeToString(Pstring: String): String;
begin
  Result := idDecoderMIME.DecodeString(Pstring, IndyTextEncoding_UTF8);
end;

function TBase64.encodeToStream(Pstring: String): TMemoryStream;
begin

end;

function TBase64.encodeToString(Pmemorystream: TMemoryStream): String;
begin
  Pmemorystream.Position := 0;
  Result := idEncoderMIME.EncodeStream(Pmemorystream, Pmemorystream.Size);
end;

function TBase64.encodeToString(Pstring: String): String;
begin

end;

end.
