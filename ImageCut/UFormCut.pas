unit UFormCut;

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
  FMX.Objects,
  UFormImageCut;

type
  TFormCut = class(TForm)
    ImageCut: TImage;
    ImageTemp: TImage;
    RectangleAreaSelected: TRectangle;
    procedure ImageCutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ImageCutMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ImageCutMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    isMouseDown: boolean;

    X0, Y0, Y1, X1: Double;

    procedure DrawResource();
    procedure CutResource();
  public
    { Public declarations }
  end;

var
  FormCut: TFormCut;

implementation

{$R *.fmx}

procedure TFormCut.CutResource;
var
  Bmp: TBitmap;
  xScale, yScale: extended;
  iRect: TRect;
begin
  Bmp := TBitmap.Create;
  xScale := ImageCut.Bitmap.Width / ImageCut.Width;
  yScale := ImageCut.Bitmap.Height / ImageCut.Height;
  try
    Bmp.Width := round(RectangleAreaSelected.Width * xScale);
    Bmp.Height := round(RectangleAreaSelected.Height * yScale);
    iRect.Left := round(RectangleAreaSelected.Position.X * xScale);
    iRect.Top := round(RectangleAreaSelected.Position.Y * yScale);
    iRect.Width := round(RectangleAreaSelected.Width * xScale);
    iRect.Height := round(RectangleAreaSelected.Height * yScale);
    Bmp.CopyFromBitmap(ImageCut.Bitmap, iRect, 0, 0);
    ImageTemp.Bitmap := Bmp
  finally
    Bmp.Free;
  end;
end;

procedure TFormCut.DrawResource;
begin
  RectangleAreaSelected.Width := X1 - X0;
  RectangleAreaSelected.Height := Y1 - Y0;
end;

procedure TFormCut.FormShow(Sender: TObject);
begin
  Self.Height := ImageCut.Bitmap.Height;
  Self.Width := ImageCut.Bitmap.Width;
end;

procedure TFormCut.ImageCutMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  RectangleAreaSelected.Width := 0;
  RectangleAreaSelected.Height := 0;

  isMouseDown := true;
  X0 := X;
  Y0 := Y;

  RectangleAreaSelected.Position.X := X0;
  RectangleAreaSelected.Position.Y := Y0;
  RectangleAreaSelected.Visible := true;
end;

procedure TFormCut.ImageCutMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  if isMouseDown then
  begin
    X1 := X;
    Y1 := Y;
    DrawResource();
  end;
end;

procedure TFormCut.ImageCutMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  isMouseDown := false;
  CutResource();
  FormImageCut.ImageAreaSelected.Bitmap.Assign(ImageTemp.Bitmap);
end;

end.
