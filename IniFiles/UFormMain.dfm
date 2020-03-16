object FormArquivosINI: TFormArquivosINI
  Left = 0
  Top = 0
  Caption = 'FormArquivosINI'
  ClientHeight = 484
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonGravar: TButton
    Left = 24
    Top = 187
    Width = 425
    Height = 25
    Caption = 'Gravar'
    TabOrder = 0
    OnClick = ButtonGravarClick
  end
  object EditSecao: TEdit
    Left = 24
    Top = 72
    Width = 425
    Height = 21
    TabOrder = 1
    TextHint = 'Se'#231#227'o'
  end
  object EditPropriedade: TEdit
    Left = 24
    Top = 112
    Width = 425
    Height = 21
    TabOrder = 2
    TextHint = 'Propriedade'
  end
  object EditValor: TEdit
    Left = 24
    Top = 152
    Width = 425
    Height = 21
    TabOrder = 3
    TextHint = 'Valor'
  end
  object ButtonCarregar: TButton
    Left = 24
    Top = 24
    Width = 425
    Height = 25
    Caption = 'Carregar'
    TabOrder = 4
    OnClick = ButtonCarregarClick
  end
  object StringGridINI: TStringGrid
    Left = 24
    Top = 232
    Width = 425
    Height = 225
    TabOrder = 5
    ColWidths = (
      64
      64
      64
      64
      64)
  end
end
