object fmMainTest: TfmMainTest
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = #1058#1077#1089#1090
  ClientHeight = 552
  ClientWidth = 917
  Color = 13948116
  TransparentColorValue = clMaroon
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon: TdxRibbon
    Left = 0
    Top = 0
    Width = 917
    Height = 126
    BarManager = dxBarManager
    ColorSchemeName = 'Black'
    TabOrder = 0
    TabStop = False
    object dxNew: TdxRibbonTab
      Active = True
      Caption = #1053#1086#1074#1072#1103' '#1092#1086#1088#1084#1072
      Groups = <
        item
        end
        item
          ToolbarName = 'dxBarNew'
        end
        item
          ToolbarName = 'dxBarWin'
        end
        item
        end
        item
          ToolbarName = 'dxBarManagerBar1'
        end>
    end
    object dxDictionary: TdxRibbonTab
      Caption = #1050#1072#1084#1077#1088#1072
      Groups = <
        item
        end
        item
          ToolbarName = 'dxBarWebCam'
        end
        item
          ToolbarName = 'dxBarWin'
        end
        item
          ToolbarName = 'dxBarManagerBar1'
        end>
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 532
    Width = 917
    Height = 20
    Images = dmData.im16
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarKeyboardStatePanelStyle'
        PanelStyle.CapsLockKeyAppearance.ActiveCaption = 'CAPS'
        PanelStyle.CapsLockKeyAppearance.InactiveCaption = 'CAPS'
        PanelStyle.NumLockKeyAppearance.ActiveCaption = 'NUM'
        PanelStyle.NumLockKeyAppearance.InactiveCaption = 'NUM'
        PanelStyle.ScrollLockKeyAppearance.ActiveCaption = 'SCRL'
        PanelStyle.ScrollLockKeyAppearance.InactiveCaption = 'SCRL'
        PanelStyle.InsertKeyAppearance.ActiveCaption = 'OVR'
        PanelStyle.InsertKeyAppearance.InactiveCaption = 'INS'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        Width = 150
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        Width = 20
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 20
      end>
    LookAndFeel.SkinName = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.DisabledLargeImages = dmData.imMenu24Disabled
    ImageOptions.LargeImages = dmData.imMenu24
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Black'
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 32
    Top = 200
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarNew: TdxBar
      Caption = #1060#1086#1088#1084#1072
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 951
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'blbTestForm'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarWin: TdxBar
      Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1086#1082#1085#1072#1084#1080
      CaptionButtons = <>
      DockedLeft = 65
      DockedTop = 0
      FloatLeft = 951
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'blbWinClose'
        end
        item
          Visible = True
          ItemName = 'blbWinMax'
        end
        item
          Visible = True
          ItemName = 'siWinList'
        end
        item
          Visible = True
          ItemName = 'siWindows'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar1: TdxBar
      Caption = #1055#1088#1080#1083#1086#1078'.'
      CaptionButtons = <>
      DockedLeft = 357
      DockedTop = 0
      FloatLeft = 951
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'blbExit'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarWebCam: TdxBar
      Caption = #1057#1098#1105#1084#1082#1072
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 951
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'blbWebCam'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object blbTestForm: TdxBarLargeButton
      Caption = #1053#1086#1074#1072#1103' '#1092#1086#1088#1084#1072
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1092#1086#1088#1084#1072
      Visible = ivAlways
      LargeImageIndex = 16
      OnClick = blbTestFormClick
    end
    object blbWinClose: TdxBarLargeButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1090#1077#1082#1091#1097#1077#1077
      Category = 0
      Enabled = False
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1090#1077#1082#1091#1097#1077#1077
      Visible = ivAlways
      LargeImageIndex = 21
      OnClick = blbWinCloseClick
    end
    object blbWinMax: TdxBarLargeButton
      Caption = #1052#1072#1082#1089#1080#1084#1080#1079#1080#1088'. '#1090#1077#1082#1091#1097#1077#1077
      Category = 0
      Enabled = False
      Hint = #1052#1072#1082#1089#1080#1084#1080#1079#1080#1088'. '#1090#1077#1082#1091#1097#1077#1077
      Visible = ivAlways
      LargeImageIndex = 22
      OnClick = blbWinMaxClick
    end
    object siWinList: TdxBarSubItem
      Caption = #1057#1087#1080#1089#1086#1082
      Category = 0
      Enabled = False
      Visible = ivAlways
      LargeImageIndex = 7
      ItemLinks = <
        item
          Visible = True
          ItemName = 'liWinList'
        end>
    end
    object siWindows: TdxBarSubItem
      Caption = #1054#1087#1077#1088#1072#1094#1080#1080
      Category = 0
      Enabled = False
      Hint = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1086#1082#1085#1072#1084#1080
      Visible = ivAlways
      ImageIndex = 15
      LargeImageIndex = 8
      ItemLinks = <
        item
          Visible = True
          ItemName = 'DxBbWinCascade'
        end
        item
          Visible = True
          ItemName = 'DxBbWinTileVertical'
        end
        item
          Visible = True
          ItemName = 'DxBbWinTileHorizontal'
        end
        item
          Visible = True
          ItemName = 'DxBbWinArrange'
        end
        item
          Visible = True
          ItemName = 'DxBbWinMinimizeAll'
        end>
      ItemOptions.Size = misLarge
    end
    object liWinList: TdxBarListItem
      Caption = #1057#1087#1080#1089#1086#1082' '#1086#1082#1086#1085
      Category = 0
      Visible = ivAlways
      OnClick = liWinListClick
      OnGetData = liWinListGetData
      ShowCheck = True
    end
    object DxBbWinCascade: TdxBarButton
      Action = WindowCascade
      Caption = #1050#1072#1089#1082#1072#1076#1086#1084
      Category = 0
      LargeImageIndex = 7
    end
    object DxBbWinTileVertical: TdxBarButton
      Action = WindowTileVertical
      Caption = #1063#1077#1088#1077#1087#1080#1094#1077#1081' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
      Category = 0
      LargeImageIndex = 11
    end
    object DxBbWinTileHorizontal: TdxBarButton
      Action = WindowTileHorizontal
      Category = 0
      LargeImageIndex = 10
    end
    object DxBbWinArrange: TdxBarButton
      Action = WindowArrange
      Caption = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100
      Category = 0
      LargeImageIndex = 12
    end
    object DxBbWinMinimizeAll: TdxBarButton
      Action = WindowMinimizeAll
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      Category = 0
      LargeImageIndex = 9
    end
    object blbExit: TdxBarLargeButton
      Caption = #1042#1099#1093#1086#1076
      Category = 0
      Hint = #1042#1099#1093#1086#1076' '#1079#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Visible = ivAlways
      LargeImageIndex = 51
      OnClick = blbExitClick
      HotImageIndex = 53
    end
    object blbWebCam: TdxBarLargeButton
      Caption = #1050#1072#1084#1077#1088#1072
      Category = 0
      Hint = #1050#1072#1084#1077#1088#1072
      Visible = ivAlways
      LargeImageIndex = 54
      OnClick = blbWebCamClick
      SyncImageIndex = False
      ImageIndex = 54
    end
  end
  object ActionList: TActionList
    Left = 64
    Top = 200
    object WindowCascade: TWindowCascade
      Category = 'Window'
      Caption = '&Cascade'
      Enabled = False
      Hint = 'Cascade'
      ImageIndex = 17
    end
    object WindowTileHorizontal: TWindowTileHorizontal
      Category = 'Window'
      Caption = 'Tile &Horizontally'
      Enabled = False
      Hint = 'Tile Horizontal'
      ImageIndex = 15
    end
    object WindowTileVertical: TWindowTileVertical
      Category = 'Window'
      Caption = '&Tile Vertically'
      Enabled = False
      Hint = 'Tile Vertical'
      ImageIndex = 16
    end
    object WindowMinimizeAll: TWindowMinimizeAll
      Category = 'Window'
      Caption = '&Minimize All'
      Enabled = False
      Hint = 'Minimize All'
    end
    object WindowArrange: TWindowArrange
      Category = 'Window'
      Caption = '&Arrange'
      Enabled = False
    end
    object aListVisit: TAction
      Caption = 'aListVisit'
    end
    object aPrintLabel: TAction
      Caption = 'aPrintLabel'
      ShortCut = 24699
    end
  end
end
