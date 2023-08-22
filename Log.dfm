object fmLog: TfmLog
  Left = 398
  Top = 286
  Width = 590
  Height = 412
  Caption = #1046#1091#1088#1085#1072#1083' '#1086#1087#1077#1088#1072#1094#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object panLog: TPanel
    Left = 0
    Top = 0
    Width = 582
    Height = 380
    Align = alClient
    Caption = 'panLog'
    TabOrder = 0
    DesignSize = (
      582
      380)
    object lstboxLog: TTextListBox
      Left = 8
      Top = 8
      Width = 565
      Height = 335
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 16
      TabOrder = 0
    end
    object btnClear: TButton
      Left = 477
      Top = 349
      Width = 94
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 1
      OnClick = btnClearClick
    end
  end
  object fsLog: TFormStorage
    StoredValues = <>
    Left = 48
    Top = 32
  end
end
