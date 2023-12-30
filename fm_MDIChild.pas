unit fm_MDIChild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxTl, RzBHints, dxPSCore;

type
  TfmMDIChild = class(TForm)
    rzHint: TRzBalloonHints;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  protected
    FMuteClose: Boolean;
    FStoreSize: Boolean;
  public
    FFormCaption: string;
    function IsEditMode: Boolean; virtual;
  end;


implementation

uses fm_maintest, StrUtils;

{$R *.dfm}

procedure TfmMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FormStyle = fsMdiChild then Action:=caFree
end;

procedure TfmMDIChild.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=FMuteClose or not IsEditMode or
     (MessageBox(0, PAnsiChar('Уверены что хотите закрыть окно и отменить изменение данных?'),
       PAnsiChar('Внимание'), MB_YESNO+MB_ICONQUESTION) = IDYES)
end;

procedure TfmMDIChild.FormCreate(Sender: TObject);
begin
  FStoreSize:=True;
  FMuteClose:=False;
  FFormCaption:=Caption;

  if FormStyle = fsMdiChild then
    with fmMainTest do
    begin
      liWinList.Items.AddObject(Self.Caption, Self);
      siWindows.Enabled:=True;
      siWinList.Enabled:=True;
      blbWinClose.Enabled:=True;
      blbWinMax.Enabled:=True;
    end;
    WindowState:=wsMaximized
end;

procedure TfmMDIChild.FormDestroy(Sender: TObject);
begin
 if FormStyle = fsMdiChild then
   with fmMainTest do
   begin
     with liWinList.Items do Delete(IndexOfObject(Self));
     siWindows.Enabled:=liWinList.Items.Count > 0;
     siWinList.Enabled:=liWinList.Items.Count > 0;
     blbWinClose.Enabled:=liWinList.Items.Count > 0;
     blbWinMax.Enabled:=liWinList.Items.Count > 0;
   end;
end;

procedure TfmMDIChild.FormResize(Sender: TObject);
begin
  if FormStyle = fsMDIChild
    then fmMainTest.blbWinMax.Caption:=IfThen(WindowState = wsNormal,
           'Максимизировать', 'Восстановить') + ' текущее';
end;

function TfmMDIChild.IsEditMode: Boolean;
begin
  Result:=False
end;


end.
