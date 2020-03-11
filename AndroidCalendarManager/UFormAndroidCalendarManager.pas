unit UFormAndroidCalendarManager;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Edit,
  FMX.DateTimeCtrls,
  FMX.StdCtrls,
  FMX.Helpers.Android,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Controls.Presentation,
  FMX.ComboEdit,
  FMX.CalendarEdit,

  Androidapi.JNI.provider,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNI.App,
  Androidapi.JNIBridge,
{$IFDEF ANDROID}
  Androidapi.JNI.Os,
  Androidapi.Helpers,
{$ENDIF}
  DateUtils,
  CalendarEventsManager;

type
  TFormAndroidCalendarManager = class(TForm)
    CalendarEditDate: TCalendarEdit;
    ButtonDelete: TButton;
    EditTitle: TEdit;
    ButtonAdd: TButton;
    ListBoxRemindersIds: TListBox;
    ButtonUpdate: TButton;
    ButtonShowCalendars: TButton;
    LabelDate: TLabel;
    LabelTitle: TLabel;
    ToolBarAndroidCalendarManager: TToolBar;
    LabelToolBarTitle: TLabel;
    VertScrollBoxAndroidCalendarManager: TVertScrollBox;
    LabelReminders: TLabel;
    procedure ButtonDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonUpdateClick(Sender: TObject);
    procedure ButtonShowCalendarsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    CalendarManager: TCalendarEventsManager;
    HasPermission: Boolean;
    procedure getPermissions();
  public
    { Déclarations publiques }
  end;

var
  FormAndroidCalendarManager: TFormAndroidCalendarManager;

implementation

uses
  FMX.DialogService,
  System.Permissions;

{$R *.fmx}

procedure TFormAndroidCalendarManager.ButtonShowCalendarsClick(Sender: TObject);
var
  LStringList: TStringList;
begin
  if HasPermission then
  begin
    LStringList := CalendarManager.GetAvailableCalendars;
    try
      ShowMessage(LStringList.Text);
    finally
      LStringList.Free;
    end;
  end
  else
  begin
    getPermissions();
  end;
end;

procedure TFormAndroidCalendarManager.ButtonDeleteClick(Sender: TObject);
begin
  if HasPermission then
  begin
    if ListBoxRemindersIds.Selected <> nil then
    begin
      if CalendarManager.DeleteReminder
        (StrToInt(ListBoxRemindersIds.Selected.Text)) then
        ShowMessage('Deleted')
      else
        ShowMessage('Failed');
    end
    else
    begin
      TDialogService.ShowMessage('Choose a Reminder id do you know delete');
    end;
  end
  else
  begin
    getPermissions();
  end;
end;

procedure TFormAndroidCalendarManager.ButtonAddClick(Sender: TObject);
var
  LId: integer;
begin
  if HasPermission then
  begin
    LId := CalendarManager.AddNewReminder(CalendarEditDate.Date,
      EditTitle.Text);
    ListBoxRemindersIds.Items.Add(IntToStr(LId));
  end
  else
  begin
    getPermissions();
  end;
end;

procedure TFormAndroidCalendarManager.ButtonUpdateClick(Sender: TObject);
begin
  if HasPermission then
  begin
    if ListBoxRemindersIds.Selected <> nil then
    begin
      CalendarManager.UpdateReminder
        (StrToInt(ListBoxRemindersIds.Items[ListBoxRemindersIds.ItemIndex]),
        CalendarEditDate.Date, EditTitle.Text);
    end
    else
    begin
      TDialogService.ShowMessage('Choose a Reminder id do you know update');
    end;
  end
  else
  begin
    getPermissions();
  end;
end;

procedure TFormAndroidCalendarManager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CalendarManager.Free;
end;

procedure TFormAndroidCalendarManager.FormCreate(Sender: TObject);
begin
  getPermissions();
end;

procedure TFormAndroidCalendarManager.getPermissions;
begin
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions
    ([JStringToString(TJManifest_permission.JavaClass.READ_CALENDAR),
    JStringToString(TJManifest_permission.JavaClass.WRITE_CALENDAR)],
    procedure(const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (Length(AGrantResults) = 2) and
        (AGrantResults[0] = TPermissionStatus.Granted) and
        (AGrantResults[1] = TPermissionStatus.Granted) then
      begin
        { activate or deactivate the location sensor }
        HasPermission := true;
        CalendarManager := TCalendarEventsManager.Create
      end
      else
      begin
        HasPermission := false;
        TDialogService.ShowMessage('You denied permissions');
      end;
    end)
{$ENDIF}
end;

end.
