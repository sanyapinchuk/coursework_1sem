object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Find structs'
  ClientHeight = 311
  ClientWidth = 654
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 670
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = ChangeLocationPanel
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 432
    Top = 0
    Width = 222
    Height = 311
    Align = alRight
    TabOrder = 0
    object Box_div: TCheckBox
      Left = 61
      Top = 161
      Width = 97
      Height = 17
      Caption = 'Hesh divide'
      TabOrder = 2
      OnClick = Box_divClick
      OnKeyPress = EnterPressed
    end
    object Box_shift: TCheckBox
      Left = 61
      Top = 138
      Width = 97
      Height = 17
      Caption = 'Hesh shift'
      TabOrder = 1
      OnClick = Box_shiftClick
      OnKeyPress = EnterPressed
    end
    object Button1: TButton
      Left = 69
      Top = 91
      Width = 89
      Height = 41
      Caption = 'FIND'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 37
      Top = 64
      Width = 145
      Height = 21
      Hint = 'should be  (a..d)+(a..z)+(0000..9999)'
      Ctl3D = True
      DoubleBuffered = False
      MaxLength = 6
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = 'Enter your unique key'
    end
    object Panel3: TPanel
      Left = 1
      Top = 251
      Width = 220
      Height = 59
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 4
      object End_find: TButton
        Left = 37
        Top = 2
        Width = 156
        Height = 49
        Caption = 'End Finding '
        TabOrder = 0
        TabStop = False
        OnClick = End_findClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 432
    Height = 311
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel4: TPanel
      Left = 57
      Top = 15
      Width = 360
      Height = 289
      BevelOuter = bvNone
      TabOrder = 0
      object CountTimeFindLabel: TLabel
        Left = 128
        Top = 200
        Width = 3
        Height = 13
        Visible = False
      end
      object Not_found_lab: TLabel
        Left = 99
        Top = 51
        Width = 123
        Height = 20
        Align = alCustom
        Caption = 'Record not found'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object SG: TStringGrid
        Left = 14
        Top = 123
        Width = 306
        Height = 65
        TabStop = False
        Align = alCustom
        Color = clBtnFace
        ColCount = 3
        DefaultColWidth = 100
        DefaultRowHeight = 30
        DragCursor = crIBeam
        FixedColor = clWhite
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        TabOrder = 0
        Visible = False
      end
    end
  end
end
