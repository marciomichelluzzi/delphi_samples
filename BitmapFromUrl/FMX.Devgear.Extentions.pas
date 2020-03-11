unit FMX.Devgear.Extentions;

interface

uses
  System.Classes, System.Types, FMX.Graphics;

type
  TBitmapHelper = class helper for TBitmap
  private
    function LoadStreamFromURL(AURL: string): TMemoryStream;
  public
    procedure LoadFromURL(AURL: string; var outSize: Int64); overload;
    procedure LoadFromURL(AURL: string); overload;

    procedure LoadThumbnailFromURL(AURL: string; const AFitWidth, AFitHeight: Integer);
  end;

implementation

uses
  IdHttp, IdTCPClient;

function TBitmapHelper.LoadStreamFromURL(AURL: string): TMemoryStream;
var
  Http: TIdHttp;
begin
  Result := TMemoryStream.Create;
  Http := TIdHttp.Create(nil);
  try
    try
      Http.Get(AURL, Result);
    except
    end;
  finally
    Http.Free;
  end;
end;

procedure TBitmapHelper.LoadFromURL(AURL: string; var outSize: Int64);
var
  Stream: TMemoryStream;
begin
  Stream := LoadStreamFromURL(AURL);
  outSize := Stream.Size;
  try
    if Stream.Size > 0 then
    begin
      LoadFromStream(Stream);
    end
  finally
    Stream.Free;
  end;
end;

procedure TBitmapHelper.LoadFromURL(AURL: string);
var
  tmp: Int64;
begin
  LoadFromURL(AUrl, tmp);
end;

procedure TBitmapHelper.LoadThumbnailFromURL(AURL: string; const AFitWidth,
  AFitHeight: Integer);
var
  Bitmap: TBitmap;
  scale: Single;
begin
  LoadFromURL(AUrl);
  scale := RectF(0, 0, Width, Height).Fit(RectF(0, 0, AFitWidth, AFitHeight));
  Bitmap := CreateThumbnail(Round(Width / scale), Round(Height / scale));
  try
    Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;
end.
