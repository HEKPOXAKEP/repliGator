object fmOptions: TfmOptions
  Left = 392
  Top = 339
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
  ClientHeight = 417
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    526
    417)
  PixelsPerInch = 120
  TextHeight = 16
  object grpDatabases: TGroupBox
    Left = 16
    Top = 8
    Width = 495
    Height = 193
    Anchors = [akLeft, akTop, akRight]
    Caption = ' '#1041#1072#1079#1099' '#1076#1072#1085#1085#1099#1093' '
    TabOrder = 0
    DesignSize = (
      495
      193)
    object lblDb1: TLabel
      Left = 16
      Top = 32
      Width = 49
      Height = 16
      AutoSize = False
      Caption = #1041#1044'1'
    end
    object lblDb2: TLabel
      Left = 16
      Top = 64
      Width = 49
      Height = 16
      AutoSize = False
      Caption = #1041#1044'2'
    end
    object Bevel1: TBevel
      Left = 8
      Top = 104
      Width = 473
      Height = 2
    end
    object lblDbsRemark: TLabel
      Left = 24
      Top = 112
      Width = 441
      Height = 65
      AutoSize = False
      Caption = 
        '* '#1053#1077' '#1085#1072#1079#1085#1072#1095#1072#1081#1090#1077' '#1073#1072#1079#1072#1084' '#1076#1072#1085#1085#1099#1093' '#1086#1076#1080#1085#1072#1082#1086#1074#1099#1077' '#1080#1084#1077#1085#1072'.'#13#10'   '#1055#1086#1089#1083#1077#1076#1089#1090#1074#1080#1103' '#1084 +
        #1086#1075#1091#1090' '#1073#1099#1090#1100' '#1085#1077#1087#1088#1077#1076#1089#1082#1072#1079#1091#1077#1084#1099#1084#1080','#13#10'   '#1074#1087#1083#1086#1090#1100' '#1076#1086' '#1089#1093#1086#1076#1072' '#1047#1077#1084#1083#1080' '#1089' '#1086#1088#1073#1080#1090#1099' '#1080 +
        #1083#1080' '#1074#1086#1079#1085#1080#1082#1085#1086#1074#1077#1085#1080#1103#13#10'   '#1089#1074#1077#1088#1093#1084#1072#1089#1089#1080#1074#1085#1086#1081' '#1095#1105#1088#1085#1086#1081' '#1076#1099#1088#1099'.'
    end
    object edtDb1: TFilenameEdit
      Left = 64
      Top = 32
      Width = 415
      Height = 21
      Filter = #1041#1072#1079#1099' '#1076#1072#1085#1085#1099#1093' Firebird (*.fdb)|*.fdb|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
      FilterIndex = 0
      Anchors = [akLeft, akTop, akRight]
      NumGlyphs = 1
      TabOrder = 0
    end
    object edtDb2: TFilenameEdit
      Left = 64
      Top = 64
      Width = 415
      Height = 21
      Filter = #1041#1072#1079#1099' '#1076#1072#1085#1085#1099#1093' Firebird (*.fdb)|*.fdb|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
      FilterIndex = 0
      Anchors = [akLeft, akTop, akRight]
      NumGlyphs = 1
      TabOrder = 1
    end
  end
  object btnOk: TButton
    Left = 335
    Top = 385
    Width = 83
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 423
    Top = 385
    Width = 83
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object grpTimers: TGroupBox
    Left = 16
    Top = 208
    Width = 495
    Height = 169
    Anchors = [akLeft, akTop, akRight]
    Caption = ' '#1048#1085#1090#1077#1088#1074#1072#1083#1099' '
    TabOrder = 3
    object lblCheckNewOrders: TLabel
      Left = 16
      Top = 32
      Width = 273
      Height = 16
      AutoSize = False
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1085#1086#1074#1099#1093' '#1079#1072#1082#1072#1079#1086#1074
    end
    object lblCheckProcessedOrders: TLabel
      Left = 16
      Top = 64
      Width = 273
      Height = 16
      AutoSize = False
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' '#1079#1072#1082#1072#1079#1086#1074
    end
    object lblRefreshGrid: TLabel
      Left = 16
      Top = 96
      Width = 273
      Height = 16
      AutoSize = False
      Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099' '#1079#1072#1082#1072#1079#1086#1074
    end
    object lblTimersRemark: TLabel
      Left = 24
      Top = 136
      Width = 457
      Height = 17
      AutoSize = False
      Caption = '* '#1048#1085#1090#1077#1088#1074#1072#1083#1099' '#1079#1072#1076#1072#1102#1090#1089#1103' '#1074' '#1089#1077#1082#1091#1085#1076#1072#1093'; '#1084#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' - 5 '#1089#1077#1082#1091#1085#1076'.'
    end
    object bvlTimers: TBevel
      Left = 8
      Top = 128
      Width = 473
      Height = 2
    end
    object sedtCheckNewOrders: TRxSpinEdit
      Left = 304
      Top = 24
      Width = 65
      Height = 24
      MaxValue = 600.000000000000000000
      MinValue = 5.000000000000000000
      Value = 10.000000000000000000
      TabOrder = 0
    end
    object sedtCheckProcessedOrders: TRxSpinEdit
      Left = 304
      Top = 56
      Width = 65
      Height = 24
      MaxValue = 600.000000000000000000
      MinValue = 5.000000000000000000
      Value = 10.000000000000000000
      TabOrder = 1
    end
    object sedtRefreshGrid: TRxSpinEdit
      Left = 304
      Top = 88
      Width = 65
      Height = 24
      MaxValue = 600.000000000000000000
      MinValue = 5.000000000000000000
      Value = 10.000000000000000000
      TabOrder = 2
    end
  end
  object fsOptions: TFormStorage
    StoredProps.Strings = (
      'edtDb1.InitialDir'
      'edtDb2.InitialDir')
    StoredValues = <>
    Left = 256
    Top = 8
  end
end
