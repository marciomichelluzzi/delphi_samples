unit UFormWiFiStatusBar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls,
  UFrameWifiStatusBar, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.ObjectScope, Fmx.Bind.GenData,
  Data.Bind.GenData, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors;

type
  TFormWiFiStatusBar = class(TForm)
    ListViewContatos: TListView;
    FrameWifiStatus: TFrameWifiStatus;
    CheckBoxConectado: TCheckBox;
    PrototypeBindSource: TPrototypeBindSource;
    BindingsList: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ToolBarContatos: TToolBar;
    procedure CheckBoxConectadoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWiFiStatusBar: TFormWiFiStatusBar;

implementation

{$R *.fmx}

procedure TFormWiFiStatusBar.CheckBoxConectadoChange(Sender: TObject);
begin
  FrameWifiStatus.SetStatusWifi(CheckBoxConectado.isChecked);
end;

end.
