object fmTestForm: TfmTestForm
  Left = 0
  Top = 0
  Caption = #1058#1077#1089#1090#1086#1074#1072#1103' '#1092#1086#1088#1084#1072
  ClientHeight = 719
  ClientWidth = 1240
  Color = 13948116
  Constraints.MinHeight = 700
  Constraints.MinWidth = 1000
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object RzToolbar: TRzToolbar
    Left = 0
    Top = 0
    Width = 1240
    Height = 40
    AutoStyle = False
    Images = dmData.im16
    RowHeight = 40
    ButtonLayout = blGlyphTop
    ButtonWidth = 60
    ButtonHeight = 40
    ShowButtonCaptions = True
    TextOptions = ttoShowTextLabels
    AutoSize = True
    BorderInner = fsNone
    BorderOuter = fsGroove
    BorderSides = [sdTop]
    BorderWidth = 0
    Caption = #1069#1082#1089#1087#1086#1088#1090
    Ctl3D = True
    FlatColor = 10930928
    ParentColor = True
    ParentCtl3D = False
    TabOrder = 0
    VisualStyle = vsGradient
    ToolbarControls = (
      BtnExecute
      btExcel)
    object BtnExecute: TRzToolButton
      Left = 4
      Top = 0
      Width = 64
      Height = 40
      Hint = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093
      DisabledIndex = 16
      ImageIndex = 15
      Layout = blGlyphTop
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      OnClick = BtnExecuteClick
    end
    object btExcel: TRzToolButton
      Left = 68
      Top = 0
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1076#1077#1088#1077#1074#1072' '#1074' Excel'
      DisabledIndex = 12
      ImageIndex = 14
      Layout = blGlyphTop
      Caption = #1069#1082#1089#1087#1086#1088#1090
      OnClick = btExcelClick
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 40
    Width = 1240
    Height = 41
    Align = alTop
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdRight]
    FlatColor = clBtnFace
    GradientColorStyle = gcsCustom
    ParentColor = True
    TabOrder = 1
    VisualStyle = vsClassic
    object Label1: TLabel
      Left = 4
      Top = 14
      Width = 83
      Height = 13
      Caption = #1050#1091#1088#1089#1099' '#1074#1072#1083#1102#1090' '#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 365
      Top = 14
      Width = 65
      Height = 13
      Caption = #1044#1086#1083#1083#1072#1088' '#1057#1064#1040
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 542
      Top = 14
      Width = 26
      Height = 13
      Caption = #1045#1042#1056#1054
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object btRecalc: TcxButton
      Left = 183
      Top = 9
      Width = 175
      Height = 25
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1087#1086' '#1082#1091#1088#1089#1091' '#1062#1041' '#1056#1060
      TabOrder = 0
      OnClick = btRecalcClick
      LookAndFeel.SkinName = 'Black'
    end
    object edDate: TcxDateEdit
      Left = 93
      Top = 12
      Properties.DateButtons = [btnToday]
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Style.Color = clWhite
      Style.LookAndFeel.SkinName = 'Black'
      StyleDisabled.LookAndFeel.SkinName = 'Black'
      StyleFocused.LookAndFeel.SkinName = 'Black'
      StyleHot.LookAndFeel.SkinName = 'Black'
      TabOrder = 1
      Width = 84
    end
    object edUSA: TcxCurrencyEdit
      Left = 434
      Top = 12
      EditValue = 0c
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.0000;-,0.0000'
      Properties.ReadOnly = True
      Style.LookAndFeel.SkinName = 'Black'
      Style.Shadow = False
      StyleDisabled.Color = clBtnFace
      StyleDisabled.LookAndFeel.SkinName = 'Black'
      StyleDisabled.TextColor = clBlack
      StyleFocused.LookAndFeel.SkinName = 'Black'
      StyleHot.LookAndFeel.SkinName = 'Black'
      TabOrder = 2
      Width = 97
    end
    object edEURO: TcxCurrencyEdit
      Left = 572
      Top = 12
      EditValue = 0c
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.0000;-,0.0000'
      Properties.ReadOnly = True
      Style.LookAndFeel.SkinName = 'Black'
      StyleDisabled.Color = clBtnFace
      StyleDisabled.LookAndFeel.SkinName = 'Black'
      StyleDisabled.TextColor = clBlack
      StyleFocused.LookAndFeel.SkinName = 'Black'
      StyleHot.LookAndFeel.SkinName = 'Black'
      TabOrder = 3
      Width = 97
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 81
    Width = 601
    Height = 638
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ParentColor = True
    TabOrder = 2
    object cxTreeList: TcxTreeList
      Left = 0
      Top = 0
      Width = 593
      Height = 638
      Align = alClient
      Bands = <
        item
          Caption.AlignHorz = taCenter
          Caption.Text = '('#1055#1077#1088#1077#1090#1072#1097#1080#1090#1077' '#1084#1099#1096#1082#1086#1081' '#1090#1086#1074#1072#1088' '#1074' '#1085#1091#1078#1085#1091#1102' '#1075#1088#1091#1087#1087#1091')'
          Options.Moving = False
          Width = 387
        end
        item
          Caption.AlignHorz = taCenter
          Caption.Text = #1062#1077#1085#1099
          Width = 337
        end>
      BufferedPaint = True
      DragMode = dmAutomatic
      Images = dmData.im16
      LookAndFeel.SkinName = 'Black'
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.AutoDragCopy = True
      OptionsBehavior.Sorting = False
      OptionsBehavior.MultiSort = False
      OptionsData.Editing = False
      OptionsData.Deleting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideFocusRect = False
      OptionsView.CellAutoHeight = True
      OptionsView.ShowEditButtons = ecsbAlways
      OptionsView.Bands = True
      OptionsView.CategorizedColumn = cxTreeListcxTreeListName
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLines = tlglBoth
      OptionsView.Indicator = True
      StateImages = dmData.im16
      Styles.Selection = dmData.stGroupRow
      TabOrder = 0
      OnCollapsed = cxTreeListCollapsed
      OnCustomDrawCell = cxTreeListCustomDrawCell
      OnDragDrop = cxTreeListDragDrop
      OnDragOver = cxTreeListDragOver
      OnEndDrag = cxTreeListEndDrag
      OnExpanded = cxTreeListExpanded
      OnExpanding = cxTreeListExpanding
      object cxTreeListcxTreeListName: TcxTreeListColumn
        Caption.AlignHorz = taCenter
        Caption.Text = #1058#1086#1074#1072#1088#1099
        DataBinding.ValueType = 'String'
        Options.Footer = True
        Options.Editing = False
        Options.Focusing = False
        Width = 208
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        SummaryFooter.Format = #1050#1086#1083'-'#1074#1086': 0'
        SummaryFooter.Kind = skCount
      end
      object cxTreeListcxTreeListRub: TcxTreeListColumn
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        Caption.AlignHorz = taCenter
        Caption.Text = #1056#1091#1073#1083#1080
        DataBinding.ValueType = 'Currency'
        Options.Footer = True
        Options.Editing = False
        Options.Moving = False
        Options.ShowEditButtons = eisbAlways
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 1
        SummaryFooter.Format = ',0.0000;-,0.0000'
        SummaryFooter.Kind = skSum
      end
      object cxTreeListcxTreeListDolars: TcxTreeListColumn
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        Caption.AlignHorz = taCenter
        Caption.Text = #1044#1086#1083#1083#1072#1088#1099
        DataBinding.ValueType = 'Currency'
        Options.Footer = True
        Options.Editing = False
        Options.Moving = False
        Position.ColIndex = 2
        Position.RowIndex = 0
        Position.BandIndex = 1
        SummaryFooter.Format = ',0.0000;-,0.0000'
        SummaryFooter.Kind = skSum
      end
      object cxTreeListcxTreeListEuro: TcxTreeListColumn
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        Caption.AlignHorz = taCenter
        Caption.Text = #1045#1074#1088#1086
        DataBinding.ValueType = 'Currency'
        Options.Footer = True
        Options.Editing = False
        Options.Moving = False
        Position.ColIndex = 1
        Position.RowIndex = 0
        Position.BandIndex = 1
        SummaryFooter.Format = ',0.0000;-,0.0000'
        SummaryFooter.Kind = skSum
      end
    end
    object cxSplitter: TcxSplitter
      Left = 593
      Top = 0
      Width = 8
      Height = 638
      HotZoneClassName = 'TcxXPTaskBarStyle'
      HotZone.SizePercent = 70
      AlignSplitter = salRight
      Control = Panel2
    end
  end
  object Panel2: TPanel
    Left = 601
    Top = 81
    Width = 639
    Height = 638
    Align = alRight
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object grResult: TcxGrid
      Left = 0
      Top = 0
      Width = 639
      Height = 248
      Align = alClient
      TabOrder = 0
      LookAndFeel.SkinName = 'Black'
      object grResultDBTV: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        NavigatorButtons.Append.Visible = False
        NavigatorButtons.Edit.Visible = False
        NavigatorButtons.Cancel.Visible = False
        NavigatorButtons.Refresh.Visible = False
        NavigatorButtons.SaveBookmark.Visible = False
        NavigatorButtons.GotoBookmark.Visible = False
        NavigatorButtons.Filter.Visible = False
        DataController.DataSource = DSResult
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsView.Navigator = True
        OptionsView.Indicator = True
        Styles.Selection = dmData.stGroupRow
        Styles.Indicator = dmData.stFillTabel
      end
      object grResultLVL: TcxGridLevel
        GridView = grResultDBTV
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 256
      Width = 639
      Height = 382
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 639
        Height = 15
        Align = alTop
        Caption = #1055#1077#1088#1077#1090#1072#1097#1080#1090#1077' '#1085#1072' '#1092#1086#1088#1084#1091' '#1092#1072#1081#1083' '#1080#1079' '#1087#1088#1086#1074#1086#1076#1085#1080#1082#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 218
      end
      object OleContainer: TOleContainer
        Left = 0
        Top = 15
        Width = 639
        Height = 367
        AutoActivate = aaManual
        Align = alClient
        Caption = 'OleContainer'
        ParentColor = True
        TabOrder = 0
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 248
      Width = 639
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      HotZone.SizePercent = 70
      AlignSplitter = salBottom
      Control = Panel3
    end
  end
  object tResult: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = tResultAfterScroll
    Left = 88
    Top = 128
  end
  object DSResult: TDataSource
    DataSet = tResult
    Left = 120
    Top = 128
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
    end
  end
end
