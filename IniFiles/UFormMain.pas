unit UFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IniFiles, Vcl.Grids;

type
  TFormArquivosINI = class(TForm)
    ButtonGravar: TButton;
    EditSecao: TEdit;
    EditPropriedade: TEdit;
    EditValor: TEdit;
    ButtonCarregar: TButton;
    StringGridINI: TStringGrid;
    procedure ButtonGravarClick(Sender: TObject);
    procedure ButtonCarregarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    ArquivoINI: TIniFile;
    procedure CarregarGridINI(const aGrid: TStringGrid);
  public
  { Public declarations }

    CONST
    INI_PATH: String = 'C:\Configuracao.ini';
  end;

var
  FormArquivosINI: TFormArquivosINI;

implementation

{$R *.dfm}

procedure TFormArquivosINI.ButtonCarregarClick(Sender: TObject);
begin
  CarregarGridINI(StringGridINI);
end;

procedure TFormArquivosINI.ButtonGravarClick(Sender: TObject);
begin
  if not Assigned(ArquivoINI) then
  begin
    ArquivoINI := TIniFile.Create(INI_PATH);
  end;
  ArquivoINI.WriteString(EditSecao.Text, EditPropriedade.Text, EditValor.Text);
end;

procedure TFormArquivosINI.CarregarGridINI(const aGrid: TStringGrid);
var
  Ini: TIniFile;
  I, J: Integer;
  LSecoes: TStringList;
  LValores: TStringList;
  LLinha: Integer;
begin
  LSecoes := TStringList.Create();
  try
    Ini := TIniFile.Create(INI_PATH);
    try
      aGrid.ColCount := 3;
      Ini.ReadSections(LSecoes);
      LLinha := 0;

      for I := 0 to LSecoes.Count - 1 do
      begin
        LValores := TStringList.Create();
        Ini.ReadSectionValues(LSecoes[I], LValores);
        for J := 0 to LValores.Count - 1 do
        begin
          aGrid.Cells[0, LLinha] := LSecoes[I];
          aGrid.Cells[1, LLinha] := LValores.Names[J];
          aGrid.Cells[2, LLinha] := LValores.ValueFromIndex[J];
          Inc(LLinha);
          aGrid.RowCount := LLinha;
        end;
        LValores.DisposeOf();
      end;
    finally
      Ini.Free;
    end;
  finally
  end;
end;

procedure TFormArquivosINI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ArquivoINI.DisposeOf();
end;

end.
