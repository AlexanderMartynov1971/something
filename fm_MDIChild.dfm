object fmMDIChild: TfmMDIChild
  Left = 359
  Top = 272
  Caption = 'MDIChild'
  ClientHeight = 113
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  PrintScale = poNone
  Scaled = False
  Visible = True
  OnActivate = FormResize
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object rzHint: TRzBalloonHints
    Bitmaps.TransparentColor = clOlive
    CaptionWidth = 300
    CenterThreshold = 0
    FrameColor = cl3DDkShadow
    Corner = hcNone
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    Left = 4
    Top = 8
  end
end