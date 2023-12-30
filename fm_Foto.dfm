object fmFoto: TfmFoto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1077#1073' '#1082#1072#1084#1077#1088#1072
  ClientHeight = 395
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = CloseVideoClick
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 178
    Height = 370
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 3
      Top = 217
      Width = 71
      Height = 13
      Caption = #1056#1072#1079#1084#1077#1088' '#1092#1086#1090#1086': '
      Transparent = True
      Visible = False
    end
    object Label2: TLabel
      Left = 3
      Top = 240
      Width = 41
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072':'
      Visible = False
    end
    object Label3: TLabel
      Left = 3
      Top = 267
      Width = 44
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072':'
      Visible = False
    end
    object Label4: TLabel
      Left = 3
      Top = 294
      Width = 63
      Height = 13
      Caption = #1050#1086#1084#1087#1088#1077#1089#1089#1080#1103':'
      Transparent = True
      Visible = False
    end
    object Label5: TLabel
      Left = 3
      Top = 317
      Width = 52
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
      Visible = False
    end
    object Label6: TLabel
      Left = 3
      Top = 336
      Width = 143
      Height = 26
      Caption = #1086#1090' 0 '#1076#1086' 100, '#1075#1076#1077' 100 -'#1089#1072#1084#1086#1077' '#1083#1091#1095#1096#1077#1077' '#1082#1072#1095#1077#1089#1090#1074#1086
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object OpenVideo: TButton
      Left = 3
      Top = 4
      Width = 169
      Height = 34
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074#1080#1076#1077#1086' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
      TabOrder = 0
      OnClick = OpenVideoClick
    end
    object CloseVideo: TButton
      Left = 3
      Top = 118
      Width = 169
      Height = 34
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1080#1076#1077#1086' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
      Enabled = False
      TabOrder = 1
      OnClick = CloseVideoClick
    end
    object GrabFrame: TButton
      Left = 3
      Top = 41
      Width = 169
      Height = 34
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1083#1077#1076#1091#1102#1097#1080#1081' '#1089#1085#1080#1084#1086#1082
      Enabled = False
      TabOrder = 2
      OnClick = GrabFrameClick
    end
    object SaveBMP: TButton
      Left = 3
      Top = 79
      Width = 169
      Height = 34
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1089#1085#1080#1084#1086#1082
      Enabled = False
      TabOrder = 3
      OnClick = SaveBMPClick
    end
    object CheckBox1: TCheckBox
      Left = 3
      Top = 163
      Width = 134
      Height = 17
      Caption = #1042' '#1088#1077#1078#1080#1084#1077' '#1090#1088#1072#1085#1089#1083#1103#1094#1080#1080' '
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 3
      Top = 184
      Width = 169
      Height = 26
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1083#1103' '#1087#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1087#1077#1088#1077#1076' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077#1084' '
      TabOrder = 5
      Visible = False
      WordWrap = True
    end
    object edHeight: TSpinEdit
      Left = 55
      Top = 237
      Width = 58
      Height = 22
      MaxValue = 400
      MinValue = 50
      TabOrder = 6
      Value = 250
      Visible = False
      OnChange = edHeightChange
    end
    object edWidth: TSpinEdit
      Left = 55
      Top = 264
      Width = 58
      Height = 22
      MaxValue = 400
      MinValue = 50
      TabOrder = 7
      Value = 200
      Visible = False
      OnChange = edHeightChange
    end
    object edCompression: TSpinEdit
      Left = 55
      Top = 314
      Width = 58
      Height = 22
      MaxValue = 100
      MinValue = 0
      TabOrder = 8
      Value = 100
      Visible = False
      OnChange = edHeightChange
    end
  end
  object Panel1: TPanel
    Left = 178
    Top = 0
    Width = 200
    Height = 250
    ParentColor = True
    TabOrder = 1
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 198
      Height = 248
      Align = alClient
      Proportional = True
      Stretch = True
      Transparent = True
      ExplicitLeft = 0
      ExplicitTop = 65
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 370
    Width = 642
    Height = 25
    Align = alBottom
    TabOrder = 2
    object Label7: TLabel
      Left = 572
      Top = 6
      Width = 33
      Height = 13
      Caption = '0 '#1073#1072#1081#1090
      Transparent = True
    end
    object ProgressBar: TProgressBar
      Left = 0
      Top = 4
      Width = 566
      Height = 17
      TabOrder = 0
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 192
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 350
    OnTimer = Timer1Timer
    Left = 224
  end
end
