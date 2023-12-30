object fmCamera: TfmCamera
  Left = 0
  Top = 0
  Caption = #1050#1072#1084#1077#1088#1072
  ClientHeight = 515
  ClientWidth = 874
  Color = 13948116
  Constraints.MinHeight = 554
  Constraints.MinWidth = 890
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object paCam: TPanel
    Left = 225
    Top = 0
    Width = 648
    Height = 513
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 515
    Align = alLeft
    BorderInner = fsGroove
    BorderOuter = fsNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      225
      515)
    object btOpenVideo: TcxButton
      Left = 8
      Top = 8
      Width = 209
      Height = 29
      Anchors = [akLeft, akTop, akRight]
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074#1080#1076#1077#1086' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
      TabOrder = 0
      OnClick = btOpenVideoClick
      LookAndFeel.SkinName = 'Black'
    end
    object btGrabFrame: TcxButton
      Left = 8
      Top = 43
      Width = 209
      Height = 29
      Anchors = [akLeft, akTop, akRight]
      Caption = #1057#1090#1086#1087'-'#1082#1072#1076#1088
      Enabled = False
      TabOrder = 1
      OnClick = btGrabFrameClick
      LookAndFeel.SkinName = 'Black'
    end
    object btSaveBMP: TcxButton
      Left = 8
      Top = 152
      Width = 209
      Height = 29
      Anchors = [akLeft, akTop, akRight]
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1085#1080#1084#1082#1072
      Enabled = False
      TabOrder = 2
      OnClick = btSaveBMPClick
      LookAndFeel.SkinName = 'Black'
    end
    object btCloseVideo: TcxButton
      Left = 8
      Top = 187
      Width = 209
      Height = 29
      Anchors = [akLeft, akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1080#1076#1077#1086' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
      Enabled = False
      TabOrder = 3
      OnClick = btCloseVideoClick
      LookAndFeel.SkinName = 'Black'
    end
    object edExpotTo: TcxRadioGroup
      Left = 8
      Top = 80
      Anchors = [akLeft, akTop, akRight]
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074':'
      Enabled = False
      Properties.DefaultValue = False
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = #1060#1086#1088#1084#1072#1090' FastReport'
          Value = False
        end
        item
          Caption = #1060#1086#1088#1084#1072#1090' PDF'
          Value = True
        end>
      Style.LookAndFeel.SkinName = 'Black'
      StyleDisabled.LookAndFeel.SkinName = 'Black'
      StyleFocused.LookAndFeel.SkinName = 'Black'
      StyleHot.LookAndFeel.SkinName = 'Black'
      TabOrder = 4
      Transparent = True
      Height = 65
      Width = 209
    end
  end
end
