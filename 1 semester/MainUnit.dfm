object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Hesh Functions'
  ClientHeight = 408
  ClientWidth = 780
  Color = clInactiveCaption
  Constraints.MinHeight = 438
  Constraints.MinWidth = 796
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = ChangePanelLocation
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 556
    Top = 0
    Width = 224
    Height = 408
    Align = alRight
    BevelOuter = bvSpace
    TabOrder = 0
    object PauseButton: TButton
      Left = 24
      Top = 163
      Width = 185
      Height = 49
      Caption = 'Stop'
      TabOrder = 2
      Visible = False
      OnClick = PauseButtonClick
    end
    object ButtonThread: TButton
      Left = 24
      Top = 8
      Width = 185
      Height = 49
      Caption = 'Start Thread'
      TabOrder = 0
      Visible = False
      OnClick = ButtonThreadClick
    end
    object TestFindBox: TCheckBox
      Left = 32
      Top = 63
      Width = 105
      Height = 17
      Caption = 'Use Total Find'
      TabOrder = 1
      Visible = False
      OnKeyPress = EnterPressed
    end
    object FillFileButton: TButton
      Left = 24
      Top = 108
      Width = 185
      Height = 49
      Caption = 'Fill file'
      TabOrder = 3
      OnClick = FillFileButtonClick
    end
    object Panel4: TPanel
      Left = 1
      Top = 227
      Width = 222
      Height = 180
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 4
      object CloseButton: TButton
        Left = 24
        Top = 98
        Width = 185
        Height = 70
        Caption = 'End application '
        TabOrder = 0
        Visible = False
        OnClick = CloseButtonClick
      end
      object Button3: TButton
        Left = 24
        Top = 22
        Width = 185
        Height = 70
        Caption = 'Go Find Records'
        TabOrder = 1
        Visible = False
        OnClick = Button3Click
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 556
    Height = 408
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 51
      Top = 7
      Width = 478
      Height = 386
      BevelOuter = bvNone
      TabOrder = 0
      object CountPacketsLabel: TLabel
        Left = 67
        Top = 8
        Width = 3
        Height = 13
        Enabled = False
      end
      object div_time: TLabel
        Left = 352
        Top = 272
        Width = 3
        Height = 13
        Visible = False
      end
      object DivOverLabel: TLabel
        Left = 47
        Top = 44
        Width = 3
        Height = 13
        Enabled = False
      end
      object shift_time: TLabel
        Left = 352
        Top = 312
        Width = 3
        Height = 13
        Visible = False
      end
      object ShiftOverLabel: TLabel
        Left = 48
        Top = 96
        Width = 3
        Height = 13
      end
      object WaitResultLabel: TLabel
        Left = 128
        Top = 149
        Width = 125
        Height = 21
        Caption = 'Wait the result...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object ProgressBar1: TProgressBar
        Left = 35
        Top = 215
        Width = 353
        Height = 25
        HelpType = htKeyword
        ParentCustomHint = False
        ParentShowHint = False
        Step = 1
        ShowHint = False
        TabOrder = 0
        Visible = False
      end
    end
  end
end
