unit fm_maintest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSilver,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxRibbonPainter, cxClasses, dxRibbon, cxControls,
  dxSkinsdxBarPainter, dxBar, XPStyleActnCtrls, ActnList, ActnMan,
  cxGraphics, dxSkinsdxStatusBarPainter, dxStatusBar, dxBarExtItems, ImgList,
  StdActns, dxRibbonForm;

type
  TfmMainTest = class(TdxRibbonForm)
    dxNew: TdxRibbonTab;
    dxRibbon: TdxRibbon;
    dxBarManager: TdxBarManager;
    dxStatusBar: TdxStatusBar;
    blbTestForm: TdxBarLargeButton;
    dxBarNew: TdxBar;
    dxDictionary: TdxRibbonTab;
    dxBarWin: TdxBar;
    blbWinClose: TdxBarLargeButton;
    blbWinMax: TdxBarLargeButton;
    siWinList: TdxBarSubItem;
    siWindows: TdxBarSubItem;
    liWinList: TdxBarListItem;
    ActionList: TActionList;
    WindowCascade: TWindowCascade;
    WindowTileHorizontal: TWindowTileHorizontal;
    WindowTileVertical: TWindowTileVertical;
    WindowMinimizeAll: TWindowMinimizeAll;
    WindowArrange: TWindowArrange;
    aListVisit: TAction;
    aPrintLabel: TAction;
    DxBbWinCascade: TdxBarButton;
    DxBbWinTileVertical: TdxBarButton;
    DxBbWinTileHorizontal: TdxBarButton;
    DxBbWinArrange: TdxBarButton;
    DxBbWinMinimizeAll: TdxBarButton;
    dxBarManagerBar1: TdxBar;
    blbExit: TdxBarLargeButton;
    dxBarWebCam: TdxBar;
    blbWebCam: TdxBarLargeButton;
    procedure blbWebCamClick(Sender: TObject);
    procedure liWinListGetData(Sender: TObject);
    procedure liWinListClick(Sender: TObject);
    procedure blbWinCloseClick(Sender: TObject);
    procedure blbWinMaxClick(Sender: TObject);
    procedure blbExitClick(Sender: TObject);
    procedure blbTestFormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMainTest: TfmMainTest;

implementation

uses dm_Data, fm_TestForm, fm_Camera;

{$R *.dfm}

procedure TfmMainTest.blbTestFormClick(Sender: TObject);
begin
  OpenTestForm(NULL);
end;

procedure TfmMainTest.blbWebCamClick(Sender: TObject);
begin
  ShowForm(TfmCamera, fmCamera)
end;

procedure TfmMainTest.blbWinCloseClick(Sender: TObject);
begin
  with Screen do
    if Assigned(ActiveForm) and (ActiveForm.FormStyle = fsMDIChild)
      then ActiveForm.Close
end;

procedure TfmMainTest.blbWinMaxClick(Sender: TObject);
begin
  with Screen do
    if Assigned(ActiveForm) and
      (ActiveForm.FormStyle = fsMDIChild) then
    begin
      if ActiveForm.WindowState = wsNormal
        then ActiveForm.WindowState:=wsMaximized
        else ActiveForm.WindowState:=wsNormal;
      ActiveForm.BringToFront
    end;
end;

procedure TfmMainTest.blbExitClick(Sender: TObject);
begin
  Close
end;

procedure TfmMainTest.FormCreate(Sender: TObject);
begin
  Application.Title:= 'ÈÑ «Òåñò»';
end;


procedure TfmMainTest.liWinListClick(Sender: TObject);
var
  MDIForm: TForm;
begin
  with Sender as TdxBarListItem do
   MDIForm:=TForm(Items.Objects[ItemIndex]);
  MDIForm.WindowState:=wsNormal;
  MDIForm.BringToFront
end;

procedure TfmMainTest.liWinListGetData(Sender: TObject);
var
  i: Integer;
begin
  with Sender as TdxBarListItem do
  begin
    ItemIndex:=Items.IndexOfObject(ActiveMDIChild);
    for i:=0 to Pred(Items.Count) do
     Items[i]:=TForm(Items.Objects[i]).Caption;
  end;
end;

end.
