object FormShellExecute: TFormShellExecute
  Left = 0
  Top = 0
  Caption = 'FormShellExecute'
  ClientHeight = 186
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonExplorer: TButton
    AlignWithMargins = True
    Left = 10
    Top = 100
    Width = 452
    Height = 25
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Caption = 'Explorer'
    TabOrder = 0
    OnClick = ButtonExplorerClick
  end
  object ButtonSite: TButton
    AlignWithMargins = True
    Left = 10
    Top = 145
    Width = 452
    Height = 25
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Caption = 'Site'
    TabOrder = 1
    OnClick = ButtonSiteClick
  end
  object ButtonImprimir: TButton
    AlignWithMargins = True
    Left = 10
    Top = 55
    Width = 452
    Height = 25
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Caption = 'Imprimir'
    TabOrder = 2
    OnClick = ButtonImprimirClick
  end
  object ButtonAbrir: TButton
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 452
    Height = 25
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Caption = 'Abrir'
    TabOrder = 3
    OnClick = ButtonAbrirClick
  end
end