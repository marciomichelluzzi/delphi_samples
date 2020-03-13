unit UFormImageCut;

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
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts;

type
  TFormImageCut = class(TForm)
    OpenDialog: TOpenDialog;
    ToolBarImageCut: TToolBar;
    SpeedButtonOpen: TSpeedButton;
    ImageAreaSelected: TImage;
    SpeedButtonSave: TSpeedButton;
    SaveDialog: TSaveDialog;
    procedure SpeedButtonOpenClick(Sender: TObject);
    procedure SpeedButtonSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormImageCut: TFormImageCut;

implementation

{$R *.fmx}

uses UFormCut;

procedure TFormImageCut.SpeedButtonOpenClick(Sender: TObject);
begin
  OpenDialog.Filter := '*.jpeg; *.jpg';

  if OpenDialog.Execute then
  begin
    if not Assigned(FormCut) then
      Application.CreateForm(TFormCut, FormCut);

    FormCut.ImageCut.Bitmap.LoadFromFile(OpenDialog.FileName);
    FormCut.ShowModal();
  end;
end;

procedure TFormImageCut.SpeedButtonSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute Then
  Begin
    ImageAreaSelected.Bitmap.SaveToFile(SaveDialog.Name);
  End;
end;

end.
