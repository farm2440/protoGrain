object Form1: TForm1
  Left = 192
  Top = 114
  Width = 428
  Height = 498
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 22
    Height = 13
    Caption = 'TAG'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 28
    Height = 13
    Caption = 'BASE'
  end
  object Edit_tag: TEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit_base: TEdit
    Left = 8
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1000'
  end
  object Memo1: TMemo
    Left = 152
    Top = 8
    Width = 257
    Height = 441
    TabOrder = 2
  end
  object Button_run: TButton
    Left = 40
    Top = 232
    Width = 75
    Height = 25
    Caption = 'RUN'
    TabOrder = 3
    OnClick = Button_runClick
  end
  object Button_stop: TButton
    Left = 40
    Top = 296
    Width = 75
    Height = 25
    Caption = 'STOP'
    TabOrder = 4
    OnClick = Button_stopClick
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Host = 'localhost'
    Port = 9000
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    Left = 8
    Top = 424
  end
end
