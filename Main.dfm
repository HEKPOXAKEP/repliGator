object fmMain: TfmMain
  Left = 410
  Top = 223
  Width = 783
  Height = 523
  Caption = 'fmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mnuMain
  OldCreateOrder = False
  Scaled = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object spdbarMain: TSpeedBar
    Left = 0
    Top = 0
    Width = 775
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    BtnOffsetHorz = 3
    BtnOffsetVert = 3
    BtnWidth = 24
    BtnHeight = 23
    Images = imglstActions
    TabOrder = 0
    InternalVer = 1
    object SpeedbarSection1: TSpeedbarSection
      Caption = 'Untitled (0)'
    end
    object spdbtnOrders: TSpeedItem
      Caption = #1047#1072#1082#1072#1079#1099
      Hint = #1047#1072#1082#1072#1079#1099' '#1074' '#1041#1044'1'
      Spacing = 1
      Top = 3
      SectionName = 'Untitled (0)'
    end
    object spdbtnLog: TSpeedItem
      Caption = #1046#1091#1088#1085#1072#1083
      Hint = #1046#1091#1088#1085#1072#1083' '#1086#1087#1077#1088#1072#1094#1080#1081
      Spacing = 1
      Top = 3
      SectionName = 'Untitled (0)'
    end
  end
  object statbarMain: TStatusBar
    Left = 0
    Top = 446
    Width = 775
    Height = 21
    Panels = <
      item
        Style = psOwnerDraw
        Text = #1041#1044'1'
        Width = 32
      end
      item
        Style = psOwnerDraw
        Text = #1041#1044'2'
        Width = 32
      end
      item
        Style = psOwnerDraw
        Width = 50
      end>
    OnMouseDown = statbarMainMouseDown
    OnDrawPanel = statbarMainDrawPanel
  end
  object fsMain: TFormStorage
    StoredValues = <>
    Left = 576
    Top = 56
  end
  object mnuMain: TRxMainMenu
    Images = imglstActions
    Left = 40
    Top = 48
    object mmiFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object miConnectDbs: TMenuItem
        Action = actConnectDbs
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Action = actExit
      end
    end
    object mmiWindows: TMenuItem
      Caption = #1054#1082#1085#1072
      object miLog: TMenuItem
        Action = actLog
      end
      object miOrders: TMenuItem
        Action = actOrders
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miTileVert: TMenuItem
        Action = actTileVert
      end
    end
    object mmiTools: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      object miOptions: TMenuItem
        Action = actOptions
      end
    end
  end
  object imglstActions: TImageList
    Left = 128
    Top = 48
  end
  object actsMain: TActionList
    Images = imglstActions
    Left = 40
    Top = 96
    object actExit: TAction
      Caption = #1042#1099#1093#1086#1076
      Hint = #1042#1099#1093#1086#1076' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ShortCut = 16472
      OnExecute = actExitExecute
    end
    object actOrders: TAction
      Caption = #1047#1072#1082#1072#1079#1099
      Hint = #1047#1072#1082#1072#1079#1099' '#1074' '#1041#1044'1'
      OnExecute = actOrdersExecute
    end
    object actLog: TAction
      Caption = #1046#1091#1088#1085#1072#1083
      Hint = #1046#1091#1088#1085#1072#1083' '#1086#1087#1077#1088#1072#1094#1080#1081
      OnExecute = actLogExecute
    end
    object actConnectDbs: TAction
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1082' '#1041#1044
      Hint = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1082' '#1073#1072#1079#1072#1084' '#1076#1072#1085#1085#1099#1093
      OnExecute = actConnectDbsExecute
    end
    object actTileVert: TAction
      Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1080#1090#1100' '#1087#1083#1080#1090#1082#1086#1081
      Hint = #1056#1072#1089#1087#1083#1086#1078#1080#1090#1100' '#1086#1082#1085#1072' '#1087#1083#1080#1090#1082#1086#1081' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
      OnExecute = actTileVertExecute
    end
    object actDisconnectDbs: TAction
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1086#1090' '#1041#1044
      Hint = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1086#1090' '#1073#1072#1079' '#1076#1072#1085#1085#1099#1093
      OnExecute = actDisconnectDbsExecute
    end
    object actOptions: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      OnExecute = actOptionsExecute
    end
  end
end
