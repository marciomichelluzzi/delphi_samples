unit CalendarEventsManager;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  Androidapi.JNI.GraphicsContentViewText,Androidapi.JNI.provider, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net, Androidapi.Jni.App, Androidapi.JNIBridge, FMX.Helpers.Android, dateutils,
  FMX.Dialogs, Androidapi.Helpers;

const
  _App_Calendar_Name : string = 'FireMonkeyDemo';
Type
  TCalendarEventsManager = Class
    private
      fContentResolver : JContentResolver;
      fCalendarID : integer;
      function CreateNewCalendar : integer;
      function IsAppCalendarExist : integer; //return -1 if calendar not found
    public
      constructor Create;
      Destructor Destroy;override;
      function AddNewReminder(ADate : TDate; ATitle : string) : integer;
      function UpdateReminder(AReminderID : Integer; AUpdatedDate : TDate; AUpdateTitle : String) : Boolean;
      function DeleteReminder(AReminderID : Integer) : Boolean;
      function SetCompletedState(AComplteted : Boolean) : Boolean;
      function GetAvailableCalendars : TStringList;
  End;

implementation

{ TCalendarEventsManager }


{===============================================================================
  Procedure: TCalendarEventsManager.IfAppCalendarExist
  Author   : kelhedadi
  DateTime : 13/05/2014
  Arguments: None
  Result   : Boolean
===============================================================================}
function TCalendarEventsManager.IsAppCalendarExist: integer;
var
  wValues :  TJavaObjectArray<JString>;
  wArgs : TJavaObjectArray<JString>;
  wCursor : JCursor;
  wFilter : JString;
begin
  Result := -1;
  try
    wValues := TJavaObjectArray<JString>.Create(2);  //Extracting only calendar name
    wValues[0] := StringToJString('_id');
    wValues[1] := StringToJString('account_name');
    wFilter := StringToJString('account_type = ? AND account_name = ?'); //filter
    wArgs := TJavaObjectArray<JString>.Create(2);  // Arguments to filter calendars list
    wArgs[0] := StringToJString('LOCAL');
    wArgs[1] := StringToJString(_App_Calendar_Name);
    wCursor := fContentResolver.query(StrToJURI('content://com.android.calendar/calendars'),wValues,wfilter,wArgs,nil);
    if wCursor.moveToFirst then
      Result := wCursor.getLong(0);
  except
    On E:Exception do
      Raise Exception.create('[TCalendarEventsManager.IfAppCalendarExist] : '+E.message);
  end;
end;


{===============================================================================
  Procedure: TCalendarEventsManager.Create
  Author   : kelhedadi
  DateTime : 13/05/2014
  Arguments: None
  Result   : None
===============================================================================}
constructor TCalendarEventsManager.Create;
var wCalendarID : integer;
    wCalendarsList : TStringList;
begin
  try
    fContentResolver := SharedActivity.getContentResolver;
    wCalendarsList := GetAvailableCalendars;
    try
      if wCalendarsList.Count = 0 then
        raise Exception.Create('No calendar found on the device');

      fCalendarID := StrToInt(wCalendarsList.Names[0]);
    finally
      wCalendarsList.Free;
    end;

    (*  the code show how to create a new calendar if needed
    fCalendarID := IsAppCalendarExist;
    if fCalendarID = -1 then              // if app calendar doesn't exist
      fCalendarID := CreateNewCalendar;   // Create it
    if fCalendarID = -1 then
      raise Exception.Create('Error creating calendar'); *)
  except
    On E:Exception do
      Raise Exception.create('[TCalendarEventsManager.Create] : '+E.message);
  end;
end;


{===============================================================================
  Procedure: TCalendarEventsManager.Destroy
  Author   : kelhedadi
  DateTime : 13/05/2014
  Arguments: None
  Result   : None
===============================================================================}
destructor TCalendarEventsManager.Destroy;
begin
  fContentResolver := nil;
  inherited;
end;




{===============================================================================
  Procedure: TCalendarEventsManager.GetAvailableCalendars
  Author   : kelhedadi
  DateTime : 19/05/2014
  Arguments: None
  Result   : TStringList
===============================================================================}
function TCalendarEventsManager.GetAvailableCalendars: TStringList;
var
  wValues :  TJavaObjectArray<JString>;
  wArgs : TJavaObjectArray<JString>;
  wCursor : JCursor;
  wFilter : JString;
begin
  Result := TStringList.Create;
  try
    wValues := TJavaObjectArray<JString>.Create(2);  //Extracting only calendar name
    wValues[0] := StringToJString('_id');
    wValues[1] := StringToJString('account_name');
  //  wFilter := StringToJString('account_type = ?'); //filter
   // wArgs := TJavaObjectArray<JString>.Create(1);  // Arguments to filter calendars list
   // wArgs[0] := StringToJString('LOCAL');
    wCursor := fContentResolver.query(StrToJURI('content://com.android.calendar/calendars'),wValues,nil,nil,nil);
    if wCursor.moveToFirst then
    begin
      Result.Add(Format('%d=%s',[wCursor.getLong(0), JstringtoString(wCursor.getString(1))]));
      while (wCursor.moveToNext) do
        Result.Add(Format('%d=%s',[wCursor.getLong(0), JstringtoString(wCursor.getString(1))]));
    end;
  except
    On E:Exception do
      Raise Exception.create('[TCalendarEventsManager.IfAppCalendarExist] : '+E.message);
  end;
end;

{===============================================================================
  Procedure: TCalendarEventsManager.CreateNewCalendar
  Author   : kelhedadi
  DateTime : 13/05/2014
  Arguments: None
  Result   : None
===============================================================================}
function TCalendarEventsManager.CreateNewCalendar : integer;
var
  Values : JContentValues;
  wBuilder : JUri_Builder;
begin
  try
    Values := TJContentValues.JavaClass.init;
    Values.put(StringToJString('account_name'), StringToJString(_App_Calendar_Name));   // Calendar name
    Values.put(StringToJString('account_type'), StringToJString('LOCAL'));    // calendar type
    Values.put(StringToJString('calendar_displayName'), StringToJString(_App_Calendar_Name+' Calendar')); //Display name
    wBuilder := TJCalendarContract_Calendars.JavaClass.CONTENT_URI.buildUpon;
    wBuilder.appendQueryParameter(StringToJString('account_name'),StringToJString(_App_Calendar_Name));
    wBuilder.appendQueryParameter(StringToJString('account_type'),StringToJString('LOCAL'));
    wBuilder.appendQueryParameter(StringToJString('caller_is_syncadapter'),StringToJString('true'));
    result :=  StrtointDef(JstringtoString(SharedActivity.getContentResolver.insert(wBuilder.build,values).getLastPathSegment),-1);
  except
    On E:Exception do
      Raise Exception.create('[TCalendarEventsManager.CreateNewCalendar] : '+E.message);
  end;
end;


{===============================================================================
  Procedure: TCalendarEventsManager.AddNewReminder
  Author   : kelhedadi
  DateTime : 13/05/2014
  Arguments: ADate: TDate; ATitle: string
  Result   : integer
===============================================================================}
function TCalendarEventsManager.AddNewReminder(ADate: TDate;  ATitle: string): integer;
var
  wEvent : JContentValues;
  wUri : Jnet_Uri;
begin
  try
    wEvent := TJContentValues.JavaClass.init;
    wEvent.put(StringToJString('calendar_id'), TJInteger.JavaClass.init(fCalendarID));
    wEvent.put(StringToJString('title'), StringToJString(ATitle));
//    wEvent.put(StringToJString('description'), StringToJString('Description here if needed'));
    wEvent.put(StringToJString('dtstart'), TJLong.JavaClass.init(MilliSecondsBetween(ADate , EncodeDate(1970,1,1))));
    wEvent.put(StringToJString('dtend'), TJLong.JavaClass.init(MilliSecondsBetween(ADate , EncodeDate(1970,1,1))));
    wEvent.put(StringToJString('eventTimezone'), StringToJString('Europe/London'));
    wEvent.put(StringToJString('allDay'), TJBoolean.JavaClass.init(StringToJString('true')));
    wEvent.put(StringToJString('hasAlarm'), TJBoolean.JavaClass.init(StringToJString('true')));
    wEvent.put(StringToJString('accessLevel'), TJInteger.JavaClass.init(3));
//    wEvent.put(StringToJString('guestsCanModify'), TJBoolean.JavaClass.init(StringToJString('true')));

    wUri := fContentResolver.insert(StrToJURI('content://com.android.calendar/events'),wEvent);
    Result := StrToInt(JStringToString(wUri.getLastPathSegment()));

    wEvent.clear;
    wEvent.put(StringToJString('event_id'),TJInteger.JavaClass.init(Result));
    wEvent.put(StringToJString('method'),TJInteger.JavaClass.init(1));
    wEvent.put(StringToJString('minutes'),TJInteger.JavaClass.init(30));
    wEvent.put(StringToJString('event_id'),TJInteger.JavaClass.init(Result));

    fContentResolver.insert(TJCalendarContract_Reminders.JavaClass.CONTENT_URI, wEvent);

  except
    On E:Exception do
      Raise Exception.create('[TCalendarEventsManager.AddNewReminder] : '+E.message);
  end;
end;


{===============================================================================
  Procedure: TCalendarEventsManager.DeleteReminder
  Author   : kelhedadi
  DateTime : 13/05/2014
  Arguments: AReminderID: Integer
  Result   : Boolean = True if
===============================================================================}
function TCalendarEventsManager.DeleteReminder(AReminderID: Integer): Boolean;
var
  wArgs :  TJavaObjectArray<JString>;
begin
  try
    wArgs := TJavaObjectArray<JString>.Create(1);  //Extracting only calendar name
    wArgs[0] := StringToJString(inttostr(AReminderID));                                //
    Result := fContentResolver.delete(TJCalendarContract_Events.JavaClass.CONTENT_URI,StringToJString('_id =?'),wArgs) > 0;
    //Result = true if row number returned by delete is > 0
  except
    On E:Exception do
      Raise Exception.create('[TCalendarEventsManager.DeleteReminder] : '+E.message);
  end;
end;


{===============================================================================
  Procedure: TCalendarEventsManager.UpdateReminder
  Author   : kelhedadi
  DateTime : 13/05/2014
  Arguments: AReminderID: Integer; AUpdatedDate: TDate; AUpdateTitle: String
  Result   : Boolean
===============================================================================}
function TCalendarEventsManager.UpdateReminder(AReminderID: Integer; AUpdatedDate: TDate; AUpdateTitle: String): Boolean;
var
  wValues : JContentValues;
  wUri : Jnet_Uri;
  wArgs :  TJavaObjectArray<JString>;
begin
  try
    wValues := TJContentValues.JavaClass.init;
    wValues.put(StringToJString('title'), StringToJString(AUpdateTitle));
    wValues.put(StringToJString('dtstart'), TJLong.JavaClass.init(MilliSecondsBetween(AUpdatedDate , EncodeDate(1970,1,1))));
    wValues.put(StringToJString('dtend'), TJLong.JavaClass.init(MilliSecondsBetween(AUpdatedDate , EncodeDate(1970,1,1))));

    wArgs := TJavaObjectArray<JString>.Create(1);  //Extracting only calendar name
    wArgs[0] := StringToJString(inttostr(AReminderID));                                //
    Result := fContentResolver.update(TJCalendarContract_Events.JavaClass.CONTENT_URI, wValues, StringToJString('_id =?'),wArgs) > 0;
  except
    On E:Exception do
      Raise Exception.create('[TCalendarEventsManager.UpdateReminder] : '+E.message);
  end;
end;



function TCalendarEventsManager.SetCompletedState(
  AComplteted: Boolean): Boolean;
begin

end;



end.
