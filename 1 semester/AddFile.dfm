object Form6: TForm6
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form6'
  ClientHeight = 297
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object InstrumentsPanel: TPanel
    Left = 484
    Top = 0
    Width = 149
    Height = 297
    Align = alRight
    TabOrder = 0
    object AssignDefoltButton: TButton
      Left = 14
      Top = 16
      Width = 129
      Height = 41
      Caption = 'Assign Default File'
      TabOrder = 0
      OnClick = AssignDefoltButtonClick
    end
    object FillFileButton: TButton
      Left = 14
      Top = 77
      Width = 129
      Height = 46
      Caption = 'Create New File'
      TabOrder = 1
      OnClick = FillFileButtonClick
    end
    object OpenButton: TButton
      Left = 14
      Top = 143
      Width = 129
      Height = 42
      Caption = 'Open File'
      TabOrder = 2
      OnClick = OpenButtonClick
    end
  end
  object SettingsPanel: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 297
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object NewNameLabel: TLabel
      Left = 163
      Top = 120
      Width = 100
      Height = 17
      Caption = 'Enter new name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object ResultPanel: TPanel
      Left = 72
      Top = 216
      Width = 353
      Height = 57
      BevelInner = bvSpace
      BevelKind = bkTile
      BevelOuter = bvSpace
      Caption = 'File not loaded'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object NewNameEdit: TEdit
      Left = 140
      Top = 143
      Width = 150
      Height = 21
      TabOrder = 1
      Visible = False
    end
    object AssignNameButton: TButton
      Left = 296
      Top = 133
      Width = 97
      Height = 34
      Caption = 'Assign'
      TabOrder = 2
      Visible = False
      OnClick = AssignNameButtonClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 480
    Top = 248
  end
end
