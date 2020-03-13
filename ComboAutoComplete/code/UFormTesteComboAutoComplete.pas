unit UFormTesteComboAutoComplete;

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
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.Edit.Suggest2,
  FMX.Layouts,
  FMX.ListBox,
  FMX.StdCtrls;

type
  TFormAutoComplete = class(TForm)
    ButtonSelectItem: TButton;
    EditComboValues: TEdit;
    ButtonComboBox: TButton;
    LabelTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonSelectItemClick(Sender: TObject);
    procedure OnItemChange(Sender: TObject);
    procedure EditComboValuesPresentationNameChoosing(Sender: TObject;
      var PresenterName: string);
    procedure ButtonComboBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAutoComplete: TFormAutoComplete;
  sl: TStrings;

implementation

{$R *.fmx}

type
  TIntObj = class(TObject)
  private
    FId: integer;
  public
    constructor Create(Id: integer); overload;
    function Value: integer;
  end;

procedure TFormAutoComplete.ButtonSelectItemClick(Sender: TObject);
begin
  EditComboValues.ItemIndex := 3;
  // force choice as if it was combobox behaviour
end;

procedure TFormAutoComplete.ButtonComboBoxClick(Sender: TObject);
begin
  EditComboValues.ForceDropDown;
  // add a button inside TEdit and use it as dropdown
end;

procedure TFormAutoComplete.EditComboValuesPresentationNameChoosing
  (Sender: TObject; var PresenterName: string);
begin
  inherited;
  PresenterName := 'SuggestEditStyle';
end;

procedure TFormAutoComplete.OnItemChange(Sender: TObject);
begin
  // occurs when ItemIndex is changed
  LabelTitle.Text := TEdit(Sender).SelectedItem.Text + LineFeed + 'idx=' +
    TEdit(Sender).ItemIndex.ToString + LineFeed + 'data=';
  if TEdit(Sender).SelectedItem.Data <> nil then
    LabelTitle.Text := LabelTitle.Text +
      TIntObj(TEdit(Sender).SelectedItem.Data).Value.ToString
  else
    LabelTitle.Text := LabelTitle.Text + 'nil';
end;

procedure TFormAutoComplete.FormCreate(Sender: TObject);
begin
  sl := TStringList.Create;
  // sl.AddObject('aaa',10); // Segmentation fault 11 under Android
  sl.AddObject('aaa', TIntObj.Create(10));
  sl.AddObject('aaabb', TIntObj.Create(20));
  sl.AddObject('aaabbbcc', TIntObj.Create(30));
  sl.AddObject('aaacc', TIntObj.Create(40));
  sl.AddObject('aaafff', TIntObj.Create(50));
  sl.AddObject('aaaggg', TIntObj.Create(60));
  EditComboValues.AssignItems(sl);
  EditComboValues.OnItemChange := OnItemChange;
end;

{ TIntObject }

constructor TIntObj.Create(Id: integer);
begin
  inherited Create;
  FId := Id;
end;

function TIntObj.Value: integer;
begin
  Result := FId;
end;

end.
