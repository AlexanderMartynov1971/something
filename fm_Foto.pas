unit fm_Foto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, ShellAPI, Mask, Spin, ComCtrls;

type
  TfmFoto = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    OpenVideo: TButton;
    CloseVideo: TButton;
    GrabFrame: TButton;
    SaveBMP: TButton;
    SaveDialog1: TSaveDialog;
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    Image1: TImage;
    CheckBox2: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edHeight: TSpinEdit;
    edWidth: TSpinEdit;
    Label4: TLabel;
    edCompression: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    Label7: TLabel;
    ProgressBar: TProgressBar;
    procedure edHeightChange(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SaveBMPClick(Sender: TObject);
    procedure GrabFrameClick(Sender: TObject);
    procedure CloseVideoClick(Sender: TObject);
    procedure OpenVideoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    hWndC: THandle;
    CapturingAVI: Boolean;
    procedure PanelToJpg;
    procedure RGBToGray;
    procedure RGBToGrayNew;
    function RGBToGrayF(RGBColor : TColor): TColor;
    procedure SetImsgeSize(AH, AW: integer);
  public
    ImgFileName: string;
  end;

  type TFriendPanel = class(TPanel);

var
  fmFoto: TfmFoto;
  bmp,bmp2: TBitmap;
  jpg: TJpegImage;


implementation

{$R *.dfm}

const
  WM_CAP_START = WM_USER;
const
  WM_CAP_STOP = WM_CAP_START + 68;
const
  WM_CAP_DRIVER_CONNECT = WM_CAP_START + 10;
const
  WM_CAP_DRIVER_DISCONNECT = WM_CAP_START + 11;
const
  WM_CAP_SAVEDIB = WM_CAP_START + 25;
const
  WM_CAP_GRAB_FRAME = WM_CAP_START + 60;
const
  WM_CAP_SEQUENCE = WM_CAP_START + 62;
const
  WM_CAP_FILE_SET_CAPTURE_FILEA = WM_CAP_START + 20;

function capCreateCaptureWindowA(lpszWindowName: PCHAR;
  dwStyle: longint;
  x: integer;
  y: integer;
  nWidth: integer;
  nHeight: integer;
  ParentWin: HWND;
  nId: integer): HWND; stdcall; external 'AVICAP32.DLL';


procedure TfmFoto.SetImsgeSize(AH, AW: integer);
begin
  if (AW >=0) and (AH >=0) then
  begin
   try
    Panel1.Width := AW;
    Panel1.Height:= AH;
   except
   end;
  end;
end;

procedure TfmFoto.CheckBox1Click(Sender: TObject);
begin
  Timer1.Enabled:= CheckBox1.Checked;
end;

procedure TfmFoto.CloseVideoClick(Sender: TObject);
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    hWndC := 0;
    OpenVideo.Enabled:= True;
    SaveBMP.Enabled:= False;
    CloseVideo.Enabled:= False;
    GrabFrame.Enabled:= False;

    edHeight.Enabled:= True;
    Label2.Enabled:= True;
    edWidth.Enabled:= True;
    Label3.Enabled:= True;
    edCompression.Enabled:= True;
    Label5.Enabled:= True;

  end;
end;

procedure TfmFoto.edHeightChange(Sender: TObject);
begin
  SetImsgeSize(edHeight.Value, edWidth.Value);
end;

procedure TfmFoto.FormCreate(Sender: TObject);
begin
  hWndC:= 0;
  ImgFileName:= '';
  SetImsgeSize(edHeight.Value, edWidth.Value);
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+'ClientImg') then
   CreateDir(ExtractFilePath(Application.ExeName)+'ClientImg');
  ImgFileName:= ExtractFilePath(Application.ExeName)+'ClientImg\NewImg.jpg';
  SaveDialog1.Options :=
    [ofHideReadOnly, ofNoChangeDir, ofPathMustExist]
//  CapturingAVI:= false;
end;

function GetFileSize(FileName: String): Integer;
var
  FS: TFileStream;
begin
  try
    FS := TFileStream.Create(Filename, fmOpenRead);
  except
    Result := -1;
  end;
  if Result <> -1 then Result := FS.Size;
  FS.Free;
end;

procedure TfmFoto.PanelToJpg;  //сохраняем изображение с Panel в переменную, затем сжимаем и переводим в jpg
label m1;
var
  Res, FileSize: Integer;
  flgOk: Boolean;
begin
  Screen.Cursor:= crHourGlass;
  flgOk:= False;
  FileSize:= 0;
  try
    bmp:= TBitmap.Create;
    bmp.Width := Panel1.Width;
    bmp.Height:= Panel1.Height;
    bmp.Canvas.CopyRect(Rect(0,0,Panel1.Width, Panel1.Height), TFriendPanel(Panel1).Canvas, Rect(0,0,Panel1.Width, Panel1.Height));

    bmp2:= TBitmap.Create;
    bmp2.Width := edWidth.Value;
    bmp2.Height:= edHeight.Value;
    bmp2.Canvas.StretchDraw(Rect(0, 0, edWidth.Value, edHeight.Value), bmp);
    Image1.Picture.Bitmap:=bmp2;

    //RGBToGrayNew;
    RGBToGray;   //<---

    jpg:=TJpegImage.Create;
    jpg.Assign(Image1.Picture.Bitmap);
    jpg.CompressionQuality:= edCompression.Value; // от 0 до 100, где 100 -самое лучшее качество
    //jpg.Grayscale:= True;
    jpg.Compress;

    if CheckBox2.Checked then
     begin
      Res := MessageBox(
       Self.Handle
        , PChar('Просмотр фотографии.')
        , PChar('Фото')
        , MB_YESNO + MB_ICONQUESTION + MB_APPLMODAL
        );
      case Res of
        IDYES : begin
          ShellExecute (Self.Handle, nil, PChar(ImgFileName), nil, nil, SW_NORMAL);
          if MessageDlg('Создать этот файл?',mtConfirmation, mbYesNo, 0) = mrYes then
           GoTo m1;
        end;
        IDNO : begin
          Exit;
        end;
      end;
     end else Goto m1;
m1:   try
       Image1.Hint:= '';
       jpg.SaveToFile(ImgFileName);
       if FileExists(ImgFileName) then
       begin
        FileSize:= GetFileSize(ImgFileName);
        if (FileSize <= 5000) then
        begin
         Image1.Hint:= ImgFileName;
         ShowMessage('Размер полученного конечного файла: '+IntToStr(FileSize)+' байт');
         flgOk:= True;
        end else
        begin
         if edCompression.Value = 0 then
         begin
          ShowMessage('Сжать файл до требуемого размера не удалось.'+#13#10+
              'Попробуйте создать другой кадр.');
          Exit;
         end;
        end;
       end;
      except
       ShowMessage('Файл не создан');
      end;
  finally
   if Assigned(bmp) then bmp.Free;
   if Assigned(bmp2) then bmp2.Free;
   if Assigned(jpg) then jpg.Free;
   Screen.Cursor:= crDefault;
   if flgOk then
    Self.ModalResult:= mrOk
   else
   begin
    if edCompression.Value > 0 then
    begin
     Label7.Caption:= IntToStr(FileSize) + ' байт';
     edCompression.Value:= edCompression.Value - 5;
     ProgressBar.Position:= edCompression.Value;
     Application.ProcessMessages;
     PanelToJpg;
    end;
   end;
  end;
end;

procedure TfmFoto.RGBToGrayNew;
var
 x, y : integer;
 r, g, b : byte;
 c : dword;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      c := Image1.Canvas.Pixels[x,y];
      r := GetRValue(c);
      g := GetGValue(c);
      b := GetBValue(c);
      if (r + g + b) div 3 > 80 then
      begin
        Image1.Canvas.Pixels[x,y] := clWhite;
      end
      else
      begin
        Image1.Canvas.Pixels[x,y] := clBlack;
      end;
    end;
  end;
end;

function TfmFoto.RGBToGrayF(RGBColor : TColor): TColor;
var
  Gray : byte;
begin
  Gray :=Round((0.30*GetRValue(RGBColor))+
  (0.59*GetGValue(RGBColor))+(0.11*GetBValue(RGBColor)));
  Result :=RGB(Gray, Gray, Gray);
end;

procedure TfmFoto.RGBToGray;
var
  i,j: integer;
  c,d: TColor;
begin
  for i :=Image1.Left to Image1.Left+Image1.Width do
    for j :=Image1.Top to Image1.Top+Image1.Height do
    begin
      c := Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top];
      d := RGBToGrayf(c);
      Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top] :=d;
    end;
end;

procedure TfmFoto.GrabFrameClick(Sender: TObject);
begin
  if hWndC <> 0 then
   SendMessage(hWndC, WM_CAP_GRAB_FRAME, 0, 0);
end;

procedure TfmFoto.OpenVideoClick(Sender: TObject);
begin
  hWndC:= capCreateCaptureWindowA('My Own Capture Window',
  WS_CHILD or WS_VISIBLE ,
  0,
  0,
  Panel1.Width,
  Panel1.Height,
  Panel1.Handle,
  0);
  if hWndC <> 0 then
  begin
   CheckBox1.OnClick(Sender);
   OpenVideo.Enabled:= False;
   GrabFrame.Enabled:= True;
   SaveBMP.Enabled:= True;
   CloseVideo.Enabled:= True;

   edHeight.Enabled:= False;
   Label2.Enabled:= False;
   edWidth.Enabled:= False;
   Label3.Enabled:= False;
   edCompression.Enabled:= False;
   Label5.Enabled:= False;

   SendMessage(hWndC, WM_CAP_DRIVER_CONNECT, 0, 0);
  end;
end;

procedure TfmFoto.SaveBMPClick(Sender: TObject);
begin
  if hWndC <> 0 then
  begin
    //RGBToGrayNew;
    ProgressBar.Position:= 100;
    edCompression.Value:= 100;
    PanelToJpg;
    {
    SaveDialog1.DefaultExt := 'bmp';
    SaveDialog1.Filter := 'Bitmap files (*.bmp)|*.bmp';
    if SaveDialog1.Execute then
      SendMessage(hWndC,
        WM_CAP_SAVEDIB,
        0,
        longint(pchar(SaveDialog1.FileName)));
    }
  end;
end;

procedure TfmFoto.Timer1Timer(Sender: TObject);
begin
  if hWndC <> 0 then SendMessage(hWndC, WM_CAP_GRAB_FRAME, 0, 0);
end;


end.

