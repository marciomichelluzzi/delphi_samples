unit UFormTransparentEdit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TFormTransparentEdit = class(TForm)
    EditTransparent: TEdit;
    RectangleBackground: TRectangle;
    StyleBook: TStyleBook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTransparentEdit: TFormTransparentEdit;

implementation

{$R *.fmx}

end.
