unit fm_Camera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_MDIChild, ExtCtrls, StdCtrls, Menus, cxLookAndFeelPainters,
  cxButtons, RzPanel, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxControls,
  cxContainer, cxEdit, cxCheckBox, uThread,
  frxClass, frxExportPDF, frxDesgn, frxExportImage, cxGroupBox, cxRadioGroup;

type
  TfmCamera = class(TfmMDIChild)
    paCam: TPanel;
    RzPanel1: TRzPanel;
    btOpenVideo: TcxButton;
    btGrabFrame: TcxButton;
    btSaveBMP: TcxButton;
    btCloseVideo: TcxButton;
    edExpotTo: TcxRadioGroup;
    procedure btSaveBMPClick(Sender: TObject);
    procedure btGrabFrameClick(Sender: TObject);
    procedure btCloseVideoClick(Sender: TObject);
    procedure btOpenVideoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    hWndC: THandle;

    frxReport: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    procedure frxCheckPDF;
    procedure LoadReport;
    procedure CT;
  public
    procedure GrabFrame;
  end;

const
  WM_CAP_START = WM_USER;
  WM_CAP_STOP = WM_CAP_START + 68;
  WM_CAP_DRIVER_CONNECT = WM_CAP_START + 10;
  WM_CAP_DRIVER_DISCONNECT = WM_CAP_START + 11;
  WM_CAP_GRAB_FRAME = WM_CAP_START + 60;

function capCreateCaptureWindowA(lpszWindowName: PCHAR;
  dwStyle: longint;
  x: integer;
  y: integer;
  nWidth: integer;
  nHeight: integer;
  ParentWin: HWND;
  nId: integer): HWND; stdcall; external 'AVICAP32.DLL';

  type TFriendPanel = class(TPanel);

var
  fmCamera: TfmCamera;
  CamThread: TCamThread;

implementation

{$R *.dfm}

procedure TfmCamera.btCloseVideoClick(Sender: TObject);
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    hWndC := 0;
    btOpenVideo.Enabled:= True;
    btSaveBMP.Enabled:= False;
    btCloseVideo.Enabled:= False;
    btGrabFrame.Enabled:= False;
    btGrabFrame.Caption:= 'Стоп-кадр';
  end;
  if Assigned(CamThread) then
   CamThread.Terminate;
end;

procedure TfmCamera.GrabFrame;
begin
  if hWndC <> 0 then
   SendMessage(hWndC, WM_CAP_GRAB_FRAME, 0, 0);
end;

procedure TfmCamera.btGrabFrameClick(Sender: TObject);
begin
  if Assigned(CamThread) then
   if not CamThread.Suspended then
   begin
    CamThread.Suspend;
    GrabFrame;
    btGrabFrame.Caption:= 'Продолжить';
    edExpotTo.Enabled:= True;
    btSaveBMP.Enabled:= True;
   end else
   begin
    CamThread.Resume;
    btGrabFrame.Caption:= 'Стоп-кадр';
    btSaveBMP.Enabled:= False;
    edExpotTo.Enabled:= False;
   end;
end;

procedure TfmCamera.CT;
begin
  if not Assigned(CamThread) then begin
   CamThread:= TCamThread.Create(True);
   CamThread.Priority:= tpIdle;   // tpLowest
   CamThread.FreeOnTerminate:= True;
  end;
  CamThread.Resume;
end;

procedure TfmCamera.btOpenVideoClick(Sender: TObject);
begin
  if (hWndC = 0) then
   hWndC:= capCreateCaptureWindowA('Capture', WS_CHILD or WS_VISIBLE ,
   0, 0, paCam.Width, paCam.Height, paCam.Handle, 0);
  if hWndC <> 0 then
  begin
   btOpenVideo.Enabled:= False;
   btGrabFrame.Enabled:= True;
   btGrabFrame.Caption:= 'Стоп-кадр';
   edExpotTo.Enabled:= False;
   btSaveBMP.Enabled:= False;
   btCloseVideo.Enabled:= True;
   SendMessage(hWndC, WM_CAP_DRIVER_CONNECT, 0, 0);
   CT;
  end;
end;

procedure TfmCamera.btSaveBMPClick(Sender: TObject);
begin
  LoadReport;
end;

procedure TfmCamera.FormCreate(Sender: TObject);
begin
  inherited;
  paCam.DoubleBuffered:= True;
end;

procedure TfmCamera.FormDestroy(Sender: TObject);
begin
  if Assigned(CamThread) then
   CamThread.Terminate;
  inherited;
  fmCamera:=nil;
end;

procedure TfmCamera.FormShow(Sender: TObject);
begin
  inherited;
  {..}
end;

procedure TfmCamera.frxCheckPDF;
var
  PDFFileName: string;
begin
  PDFFileName:= ExtractFilePath(ParamStr(0))+'test.pdf';
  if frxPDFExport = nil then
  begin
    frxPDFExport:= TfrxPDFExport.Create(Self);
    frxPDFExport.ShowDialog:= False;
    frxPDFExport.Compressed:= True;
    frxPDFExport.OpenAfterExport:= True;
    frxPDFExport.FileName:= PDFFileName;
  end;

  if frxReport = nil then
  begin
    frxReport:= TfrxReport.Create(Self);
    with frxReport do
    begin
      PreviewOptions.AllowEdit:= False;
      PreviewOptions.Buttons:= PreviewOptions.Buttons -
        [pbTools, pbEdit, pbOutline, pbLoad, pbSave]
    end;
  end;
end;

procedure TfmCamera.LoadReport;
var
  Page: TfrxReportPage;
  Band: TfrxBand;
//  DataBand: TfrxMasterData;
  Memo: TfrxMemoView;
  Picture: TfrxPictureView;
  bmp: TBitmap;
begin
  frxCheckPDF;
  try
   frxReport.Clear;
   Page:=TfrxReportPage.Create(frxreport);
   Page.CreateUniqueName;

   Band:= TfrxReportTitle.Create(Page);
   Band.CreateUniqueName;
   Band.Top:= 0;
   Band.Height:= 30;

   Memo:= TfrxMemoView.Create(Band);
   Memo.CreateUniqueName;
   Memo.Text:= 'ТЕСТОВЫЙ ПРИМЕР';
   Memo.SetBounds(0, 0, 500, 30);
   Memo.HAlign:= haCenter;
   Memo.Align:= baCenter;
   Memo.Font.Style:= [fsBold];
   Memo.Font.Size:= 20;

   bmp:= TBitmap.Create;
   bmp.Width := paCam.Width;
   bmp.Height:= paCam.Height;
   bmp.Canvas.CopyRect(Rect(0,0,paCam.Width, paCam.Height), TFriendPanel(paCam).Canvas, Rect(0,0,paCam.Width, paCam.Height));

   Picture:= TfrxPictureView.Create(Page);
   Picture.CreateUniqueName;
   Picture.SetBounds(0, 60, 1000, 800);
   Picture.Align:= baCenter;
   Picture.Picture.Bitmap:= bmp;

   if frxReport.PrepareReport() then
   case edExpotTo.ItemIndex of
   0: frxReport.ShowReport;
   1: frxReport.Export(frxPDFExport);
   end;
   //frxReport.DesignReport;
  finally
   bmp.Free;
   FreeAndNil(frxReport);
   FreeAndNil(frxPDFExport);
  end;
  
end;


end.
