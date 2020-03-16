unit UnitZipUtils;

interface

type
  TZipUtils = class(TObject)

    procedure ExtrairConteudoDoDucumento(PCaminhoArquivo: String;
      PCaminhoDestino: String);

  end;

var
  ZipUtils: TZipUtils;

implementation

{ TZipUtils }

uses System.Zip;

procedure TZipUtils.ExtrairConteudoDoDucumento(PCaminhoArquivo: String;
  PCaminhoDestino: String);
var
  MeuArquivoZip: TZipFile;
begin
  MeuArquivoZip := TZipFile.Create;
  MeuArquivoZip.Open(PCaminhoArquivo, TZipMode.zmReadWrite);
  MeuArquivoZip.ExtractAll(PCaminhoDestino);
end;

end.
