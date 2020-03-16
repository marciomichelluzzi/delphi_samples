unit UnitXmlUtils;

interface

uses System.Generics.Collections, System.classes, XML.XmlDoc,
  XML.XmlIntf, SysUtils,
{$IFDEF MSWINDOWS}
  XML.Win.msxmldom, ActiveX, FMX.Forms,
{$ELSE}
  XML.omnixmldom,
{$ENDIF}
  XML.xmldom;

type
  TXmlUtils = class(TObject)
    function AbrirXML(PPathString: String): IXMLDocument;
  end;

var
  XMLUtils: TXmlUtils;

implementation

{ TXmlUtils }

function TXmlUtils.AbrirXML(PPathString: String): IXMLDocument;

var
  xmlDocumento: TXmlDocument;
begin
  try
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
    DefaultDOMVendor := sOmniXmlVendor;
{$ELSE}
    CoInitialize(nil);
    DefaultDOMVendor := SMSXML;
{$ENDIF}
    xmlDocumento := TXmlDocument.Create(nil);
    xmlDocumento.Active := true;
    xmlDocumento.Encoding := 'UTF-8';
    xmlDocumento.LoadFromFile(PPathString);
    Result := xmlDocumento;
{$IF DEFINED(MSWINDOWS)}
    CoUninitialize;
{$ENDIF}
  except
    on E: Exception do
      // ModuloDeDados.inserirLogg('error', E.Message, Now());
  end;

  Result := xmlDocumento;
end;

end.
