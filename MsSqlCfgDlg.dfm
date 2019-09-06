object FrmMsSqlCfg: TFrmMsSqlCfg
  Left = 372
  Top = 188
  BorderStyle = bsDialog
  Caption = 'MsSQL DataBinding Wizard'
  ClientHeight = 299
  ClientWidth = 326
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object panMain: TPanel
    Left = 0
    Top = 0
    Width = 326
    Height = 256
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object pcMain: TPageControl
      Left = 5
      Top = 5
      Width = 316
      Height = 246
      ActivePage = tsConnection
      Align = alClient
      TabOrder = 0
      OnChange = pcMainChange
      object tsConnection: TTabSheet
        Caption = 'Connection'
        object TestConButton: TBitBtn
          Left = 174
          Top = 213
          Width = 123
          Height = 25
          Caption = 'Test connection'
          TabOrder = 0
          Visible = False
          OnClick = TestConButtonClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
            33333333333F8888883F33330000324334222222443333388F3833333388F333
            000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
            F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
            223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
            3338888300003AAAAAAA33333333333888888833333333330000333333333333
            333333333333333333FFFFFF000033333333333344444433FFFF333333888888
            00003A444333333A22222438888F333338F3333800003A2243333333A2222438
            F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
            22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
            33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
            3333333333338888883333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
        object PanSqlSettings: TPanel
          Left = 0
          Top = 0
          Width = 308
          Height = 218
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label1: TLabel
            Left = 10
            Top = 5
            Width = 237
            Height = 13
            Caption = 'Server name (pick from the list or enter manually)'
          end
          object Label2: TLabel
            Left = 10
            Top = 173
            Width = 75
            Height = 13
            Caption = 'Database name'
          end
          object cboServers: TComboBox
            Left = 10
            Top = 21
            Width = 289
            Height = 21
            ItemHeight = 13
            TabOrder = 0
            Text = 'SrvProg\Tourmed'
            OnDropDown = cboServersDropDown
          end
          object cboDatabases: TComboBox
            Left = 10
            Top = 189
            Width = 289
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 1
            OnDropDown = cboDatabasesDropDown
          end
          object gbLoginInfo: TGroupBox
            Left = 10
            Top = 49
            Width = 289
            Height = 117
            Caption = 'Login info'
            TabOrder = 2
            object rbIntegratedSecurity: TRadioButton
              Left = 8
              Top = 20
              Width = 181
              Height = 17
              Caption = 'Use Windows integrated security'
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = rbIntegratedSecurityClick
            end
            object rbLoginInfo: TRadioButton
              Left = 8
              Top = 44
              Width = 237
              Height = 17
              Caption = 'Use a specific user name and password'
              TabOrder = 1
              OnClick = rbLoginInfoClick
            end
            object ledUserName: TLabeledEdit
              Left = 24
              Top = 84
              Width = 121
              Height = 21
              EditLabel.Width = 51
              EditLabel.Height = 13
              EditLabel.Caption = 'User name'
              Enabled = False
              TabOrder = 2
              Text = 'Tourmed'
            end
            object ledPassword: TLabeledEdit
              Left = 156
              Top = 84
              Width = 121
              Height = 21
              EditLabel.Width = 46
              EditLabel.Height = 13
              EditLabel.Caption = 'Password'
              Enabled = False
              PasswordChar = '*'
              TabOrder = 3
              Text = 'Cim$$S9u'
            end
          end
        end
      end
      object tsTables: TTabSheet
        Caption = 'Tables'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object vstTable: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 308
          Height = 218
          Version = '6.2.5.918'
          Align = alClient
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
          TabOrder = 0
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
          OnGetText = vstTableGetText
          OnInitNode = vstTableInitNode
          Columns = <
            item
              Position = 0
              Width = 308
              WideText = 'Tables'
            end>
        end
      end
    end
  end
  object panButtons: TPanel
    Left = 0
    Top = 256
    Width = 326
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      326
      43)
    object btnOk: TBitBtn
      Left = 20
      Top = 8
      Width = 101
      Height = 25
      TabOrder = 0
      OnClick = btnOKClick
      Kind = bkOK
    end
    object btnCancel: TBitBtn
      Left = 213
      Top = 8
      Width = 93
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
