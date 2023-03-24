object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 481
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbV: TLabel
    Left = 128
    Top = 0
    Width = 353
    Height = 462
    Align = alRight
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    ExplicitHeight = 369
  end
  object bVer: TBitBtn
    Left = 20
    Top = 30
    Width = 89
    Height = 75
    Caption = 'Vers'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = bVerClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 462
    Width = 481
    Height = 19
    Panels = <
      item
        Width = 500
      end>
  end
end
