object TextSearchDialog: TTextSearchDialog
  Left = 132
  Top = 168
  BorderStyle = bsDialog
  Caption = 'Search Text'
  ClientHeight = 171
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object PanOptions: TPanel
    Left = 0
    Top = 62
    Width = 332
    Height = 138
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 60
    object gbSearchOptions: TGroupBox
      Left = 8
      Top = -2
      Width = 154
      Height = 105
      Caption = 'Options'
      TabOrder = 0
      object cbSearchCaseSensitive: TCheckBox
        Left = 8
        Top = 17
        Width = 140
        Height = 17
        Caption = 'C&ase sensitivity'
        TabOrder = 0
      end
      object cbSearchWholeWords: TCheckBox
        Left = 8
        Top = 39
        Width = 140
        Height = 17
        Caption = '&Whole words only'
        TabOrder = 1
      end
      object cbSearchFromCursor: TCheckBox
        Left = 8
        Top = 61
        Width = 140
        Height = 17
        Caption = 'Search from &caret'
        TabOrder = 2
      end
      object cbSearchSelectedOnly: TCheckBox
        Left = 8
        Top = 83
        Width = 140
        Height = 17
        Caption = '&Selected text only'
        TabOrder = 3
      end
      object cbRegularExpression: TCheckBox
        Left = 8
        Top = 104
        Width = 140
        Height = 17
        Caption = '&Regular expression'
        TabOrder = 4
        Visible = False
      end
    end
    object rgSearchDirection: TRadioGroup
      Left = 170
      Top = -2
      Width = 154
      Height = 65
      Caption = 'Direction'
      ItemIndex = 0
      Items.Strings = (
        '&Forward'
        '&Backward')
      TabOrder = 1
    end
    object btnOK: TButton
      Left = 170
      Top = 80
      Width = 75
      Height = 23
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
    object btnCancel: TButton
      Left = 249
      Top = 80
      Width = 75
      Height = 23
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 3
    end
  end
  object PanReplace: TPanel
    Left = 0
    Top = 33
    Width = 332
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    ExplicitLeft = -8
    ExplicitTop = 42
    object Label2: TLabel
      Left = 8
      Top = 9
      Width = 65
      Height = 13
      Caption = '&Replace with:'
    end
    object cbReplaceText: TComboBox
      Left = 96
      Top = 5
      Width = 228
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object PanSearch: TPanel
    Left = 0
    Top = 0
    Width = 332
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 29
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 52
      Height = 13
      Caption = '&Search for:'
    end
    object cbSearchText: TComboBox
      Left = 96
      Top = 8
      Width = 228
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
end
