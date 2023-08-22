object fmOrders: TfmOrders
  Left = 393
  Top = 318
  Width = 530
  Height = 252
  Caption = #1041#1044'1: '#1047#1072#1082#1072#1079#1099
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
  PixelsPerInch = 120
  TextHeight = 16
  object panOrders: TPanel
    Left = 0
    Top = 0
    Width = 522
    Height = 220
    Align = alClient
    Caption = 'panOrders'
    TabOrder = 0
    DesignSize = (
      522
      220)
    object grdOrders: TIB_CursorGrid
      Left = 8
      Top = 8
      Width = 505
      Height = 204
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 1
      DefaultRowHeight = 17
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentFont = False
      TabOrder = 0
      DataSource = datsrcOrders
      NullText = '-'
    end
  end
  object fsOrders: TFormStorage
    StoredValues = <>
    Left = 176
    Top = 48
  end
  object cursOrders: TIB_Cursor
    FieldsDisplayLabel.Strings = (
      'ID=Id'
      'REF_ID='#1057#1089#1099#1083#1082#1072
      'Name='#1053#1072#1079#1074#1072#1085#1080#1077
      'PLANNED_DT='#1047#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1086
      'ACTUAL_DT='#1042#1099#1087#1086#1083#1085#1077#1085#1086
      'STATUS='#1057#1090#1072#1090#1091#1089)
    IB_Connection = DatMod.connDb1
    SQL.Strings = (
      'select Id,Ref_Id,Name,Planned_DT,Actual_DT,Status'
      'from Orders'
      'order by Id')
    AutoFetchAll = True
    AfterOpen = cursOrdersAfterOpen
    BeforeClose = cursOrdersBeforeClose
    Left = 56
    Top = 56
  end
  object datsrcOrders: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = cursOrders
    Left = 56
    Top = 104
  end
end
