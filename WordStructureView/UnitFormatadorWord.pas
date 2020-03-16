unit UnitFormatadorWord;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.MultiView,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Edit,
  FMX.ScrollBox, FMX.Memo, FMX.TreeView,

  System.Generics.Collections, XML.XmlDoc,
  XML.XmlIntf,
{$IFDEF MSWINDOWS}
  XML.Win.msxmldom, ActiveX,
{$ELSE}
  XML.omnixmldom,
{$ENDIF}
  XML.xmldom;

type
  TFormWordStructureView = class(TForm)
    LayoutWordStructureView: TLayout;
    ToolBarWordStructureView: TToolBar;
    MultiViewWordStructureView: TMultiView;
    SpeedButtonFormatadorWordMenu: TSpeedButton;
    ToolBarWordStructureViewMenu: TToolBar;
    ListBoxWordStructureViewMenuOpcoes: TListBox;
    ListBoxItemWordStructureViewAbrirDocumento: TListBoxItem;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    EditCaminhoDocumento: TEdit;
    Label2: TLabel;
    TreeView1: TTreeView;
    Memo1: TMemo;
    procedure ListBoxItemWordStructureViewAbrirDocumentoClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirDocumentoWord();
    procedure MontarArvoreDeArquivos(PCaminho: String);

    procedure BuscaSubDiretorios(strNomeDir: String; Pai: TFMXObject);
    function GetNodePath(ANode: TTreeViewItem;
      ADelimiter: String = '\'): String;
  public
    { Public declarations }
  end;

var
  FormWordStructureView: TFormWordStructureView;

implementation

{$R *.fmx}

uses UnitZipUtils, UnitXmlUtils;

procedure TFormWordStructureView.AbrirDocumentoWord();
begin
  OpenDialog1.Title := 'Documento do word';
  OpenDialog1.InitialDir := 'C:\\Users';
  if OpenDialog1.Execute then
  Begin
    EditCaminhoDocumento.Text := OpenDialog1.FileName;
  end;
  MultiViewWordStructureView.HideMaster;
end;

procedure TFormWordStructureView.BuscaSubDiretorios(strNomeDir: String;
  Pai: TFMXObject);
var
  sr: TSearchRec;
  FileAttrs: Integer;
  strNome: String;
  Item: TTreeViewItem;
begin
  try
    FileAttrs := faDirectory;
    strNome := strNomeDir;

    while strNome[Length(strNome)] = '\' do
      strNome := copy(strNome, 1, Length(strNome) - 1);

    if strNome[Length(strNome)] <> ':' then
    begin
      strNome := ExtractFileName(strNome);

    end
    else
    begin
      strNome := copy(strNome, 1, Length(strNome) - 1);
    end;

    Item := TTreeViewItem.Create(Pai);
    Item.Text := strNome;
    Item.Parent := Pai;

    Pai := Item;

    if FindFirst(strNomeDir + '*.*', FileAttrs, sr) = 0 then
    begin
      repeat
        if (sr.Name <> '.') and (sr.Name <> '..') and
          ((sr.Attr > 15) and (sr.Attr < 32)) then
        // verifica se o arquivo encontrado é uma pasta
        begin
          BuscaSubDiretorios(strNomeDir + sr.Name + '\', Pai);
        end
        else
        begin
          Item := TTreeViewItem.Create(Pai);
          Item.Text := sr.Name;
          Item.Parent := Pai;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  except

  end;
end;

function TFormWordStructureView.GetNodePath(ANode: TTreeViewItem;
  ADelimiter: String): String;
var
  NodeTreeViewItem: TTreeViewItem;
  Path: String;
begin
  Result := '';

  while Assigned(ANode) do
  begin
    Path := (ANode as TTreeViewItem).Text;
    Result := ADelimiter + Path + Result;
    ANode := ANode.ParentItem;
  end;
end;

procedure TFormWordStructureView.ListBoxItemWordStructureViewAbrirDocumentoClick
  (Sender: TObject);
var
  CaminhoExtracao: String;
begin
  CaminhoExtracao := 'C:\temp\';

  AbrirDocumentoWord;
  ZipUtils.ExtrairConteudoDoDucumento(EditCaminhoDocumento.Text,
    CaminhoExtracao);
  MontarArvoreDeArquivos(CaminhoExtracao);
end;

procedure TFormWordStructureView.MontarArvoreDeArquivos(PCaminho: String);
begin
  BuscaSubDiretorios(PCaminho, TreeView1);
end;

procedure TFormWordStructureView.TreeView1Change(Sender: TObject);
var
  XmlPath: String;
  XmlDocumento: IXMLDocument;
begin
  XmlPath := 'C:' + GetNodePath(TreeView1.Selected);

  XMLUtils := TXmlUtils.Create;

  XmlDocumento := XMLUtils.AbrirXML(XmlPath);
  Memo1.Text := XmlDocumento.XML.Text;
end;

end.
