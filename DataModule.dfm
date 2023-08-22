object DatMod: TDatMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 447
  Top = 395
  Height = 376
  Width = 659
  object connDb1: TIB_Connection
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'PAGE SIZE=8192'
      'USER NAME=SYSDBA'
      'CHARACTER SET=WIN1251'
      'SQL DIALECT=3')
    AfterConnect = connDb1AfterConnect
    Left = 56
    Top = 32
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object connDb2: TIB_Connection
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PAGE SIZE=8192'
      'CHARACTER SET=WIN1251'
      'SQL DIALECT=3')
    AfterConnect = connDb2AfterConnect
    BeforeDisconnect = connDb2BeforeDisconnect
    Left = 200
    Top = 32
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object fsConf: TFormStorage
    IniSection = 'DataModule'
    Options = []
    StoredProps.Strings = (
      'connDb1.Path'
      'connDb2.Path'
      'tmrevtCheckNewOrders.Interval'
      'tmrevtCheckProcessedOrders.Interval'
      'tmrevtRefreshOrdersGrid.Interval')
    StoredValues = <>
    Left = 568
    Top = 32
  end
  object cursGetNewOrders: TIB_Cursor
    IB_Connection = connDb1
    SQL.Strings = (
      'select Id,Name'
      'from Orders'
      'where Status=1;')
    Left = 56
    Top = 80
  end
  object tmrlstGeneral: TRxTimerList
    Active = True
    Left = 488
    Top = 32
    object tmrevtRefreshOrdersGrid: TRxTimerEvent
      Enabled = False
      Interval = 20000
      OnTimer = tmrevtRefreshOrdersGridTimer
    end
    object tmrevtCheckNewOrders: TRxTimerEvent
      Enabled = False
      Interval = 20000
      OnTimer = tmrevtCheckNewOrdersTimer
    end
    object tmrevtCheckProcessedOrders: TRxTimerEvent
      Enabled = False
      Interval = 20000
      OnTimer = tmrevtCheckProcessedOrdersTimer
    end
  end
  object dsqlOrderAccepted: TIB_DSQL
    IB_Connection = connDb1
    SQL.Strings = (
      'update Orders'
      'set Ref_Id=:aRef_Id,Status=:aStatus'
      'where Id=:aId')
    Left = 56
    Top = 128
  end
  object dsqlSaveNewOrder: TIB_DSQL
    IB_Connection = connDb2
    IB_Transaction = trsSaveNewOrder
    SQL.Strings = (
      'select oId,err,msg'
      'from saveNewOrder(:aRef_Id,:aName)'
      '-- execute procedure saveNewOrder(:aRef_Id,:aName)')
    Left = 200
    Top = 80
  end
  object cursGetProcessedOrders: TIB_Cursor
    IB_Connection = connDb2
    SQL.Strings = (
      'select oId,oRef_Id,oPlanned_DT,oActual_DT'
      'from getProcessedOrders')
    Left = 200
    Top = 128
  end
  object dsqlUpdateOrderDTs: TIB_DSQL
    IB_Connection = connDb1
    SQL.Strings = (
      'update Orders'
      'set Planned_DT=:aPlanned_DT,Actual_DT=:aActual_DT'
      'where Id=:aId')
    Left = 56
    Top = 176
  end
  object trsSaveNewOrder: TIB_Transaction
    IB_Connection = connDb2
    Isolation = tiCommitted
    Left = 320
    Top = 80
  end
end
