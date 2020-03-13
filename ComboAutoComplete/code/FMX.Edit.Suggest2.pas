unit FMX.Edit.Suggest2;

interface

uses
  FMX.Edit.Style, FMX.Controls.Presentation, FMX.Controls.Model, FMX.Presentation.Messages, FMX.Edit,
  FMX.Controls, FMX.ListBox, System.Classes, System.Types;

const
  PM_DROP_DOWN = PM_EDIT_USER + 10;
  PM_PRESSENTER = PM_EDIT_USER + 11;
  PM_SET_ITEMINDEX = PM_EDIT_USER + 12;
  PM_GET_ITEMINDEX = PM_EDIT_USER + 13;
  PM_GET_SELECTEDITEM = PM_EDIT_USER + 14;
  PM_SET_ITEMCHANGE_EVENT = PM_EDIT_USER + 15;
  PM_GET_ITEMS = PM_EDIT_USER + 16;

type
  TSelectedItem = record
    Text: String;
    Data: TObject;
  end;

  TStyledSuggestEdit = class(TStyledEdit)
  private
    FItems: TStrings;
    FPopup: TPopup;
    FListBox: TListBox;
    FDropDownCount: Integer;
    FOnItemChange: TNotifyEvent;
    FItemIndex: integer;
    FDontTrack: Boolean;
    FLastClickedIndex: Integer;
    function _GetIndex: Integer;
    procedure _SetIndex(const Value: Integer);
    procedure _SetItems(const Value: TStrings);
  protected
    procedure CheckIfTextMatchesSuggestions; // used to find out if a typed text matches any of suggestions and then do select
    function GetListBoxIndexByText(const AText: string): Integer;
    procedure OnItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure PMDropDown(var AMessage: TDispatchMessage); message PM_DROP_DOWN;
    procedure MMDataChanged(var AMessage: TDispatchMessageWithValue<TDataRecord>); message MM_DATA_CHANGED;
    procedure PMSetSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_SET_SIZE;
    procedure PMGetItemIndex(var AMessage: TDispatchMessageWithValue<Integer>); message PM_GET_ITEMINDEX;
    procedure PMSetItemIndex(var AMessage: TDispatchMessageWithValue<Integer>); message PM_SET_ITEMINDEX;
    procedure PMGetItems(var AMessage: TDispatchMessageWithValue<TStrings>); message PM_GET_ITEMS;
    procedure PMGetSelectedItem(var AMEssage: TDispatchMessageWithValue<TSelectedItem>); message PM_GET_SELECTEDITEM;
    procedure PMSetItemChangeEvent(var AMessage: TDispatchMessageWithValue<TNotifyEvent>); message PM_SET_ITEMCHANGE_EVENT;
    procedure PMPressEnter(var AMessage: TDispatchMessage); message PM_PRESSENTER;
    procedure DoChangeTracking; override;
    procedure RebuildSuggestionList(AText: String);
    procedure RecalculatePopupHeight;
    procedure KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
    procedure DropDownRecalc(ByText: string; Delay: integer = 100); //Delay parameter is a preparation for calling by a thread or a timer
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function _SelectedItem: TSelectedItem;
    property _Items: TStrings read FItems write _SetItems;
    property _ItemIndex: Integer read _GetIndex write _SetIndex;
    property _OnItemChange: TNotifyEvent read FOnItemChange write FOnItemChange;
  end;

  TStyleSuggestEditProxy = class(TPresentationProxy)
  protected
    function CreateReceiver: TObject; override;
  end;

  TEditSuggestHelper = class helper for TEdit
  public type
  private
    function GetIndex: Integer;
    procedure SetIndex(const Value: Integer);
    procedure SetOnItemChange(const Value: TNotifyEvent);
    function GetItems: TStrings;
  public
    procedure AssignItems(const S: TStrings);
    procedure ForceDropDown;
    procedure PressEnter;
    function SelectedItem: TSelectedItem;
    property OnItemChange: TNotifyEvent write SetOnItemChange;
    property ItemIndex: Integer read GetIndex write SetIndex;
    property Items: TStrings read GetItems;
  end;

implementation

uses
  FMX.Presentation.Factory, FMX.Types,
  System.SysUtils,
  System.Math,
  System.Rtti,
  //uDsTimers.FMX,
  {$IFDEF MSWINDOWS}Winapi.Windows,{$ENDIF}
  System.UITypes;

{ TStyleSuggestEditProxy }

function TStyleSuggestEditProxy.CreateReceiver: TObject;
begin
  Result := TStyledSuggestEdit.Create(nil, Model, PresentedControl);
end;

{ TStyledSuggestEdit }

procedure TStyledSuggestEdit.CheckIfTextMatchesSuggestions;
var I: integer;
begin
  if FItemIndex = -1 then
  begin
    I := self.GetListBoxIndexByText(Edit.Text);
    if I <> -1 then
    try
      OnItemClick(nil, FListBox.ListItems[I]); //try-except: maybe missing items if calling from a timer event or within a thread
      FListBox.RemoveObject(FListBox.ListItems[I]);
      RecalculatePopupHeight;
    except
    end;
  end;
end;

constructor TStyledSuggestEdit.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TStringList.Create;
  FItemIndex := -1;
  FPopup := TPopup.Create(self);
  FPopup.Parent := Self;
  FPopup.PlacementTarget := Self;
  FPopup.Placement := TPlacement.Bottom;
  FPopup.Width := Width;
  FListBox := TListBox.Create(self);
  FListBox.Parent := FPopup;
  FListBox.Align := TAlignLayout.Client;
  FListBox.OnItemClick := OnItemClick;
  FDropDownCount := 5;
  FListBox.Width := Self.Width;
  FPopup.Width := Self.Width;
  FLastClickedIndex := -1;
end;

destructor TStyledSuggestEdit.Destroy;
begin
  FPopup := nil;
  FListBox := nil;
  FItems.Free;
  inherited;
end;

procedure TStyledSuggestEdit.DoChangeTracking;
begin
  inherited;
  if Edit.Text <> _SelectedItem.Text then
    FLastClickedIndex := -1;
  if not FDontTrack and (FLastClickedIndex = -1) then
  begin
    _ItemIndex := -1;
    DropDownRecalc(Edit.Text);
  end;
end;

function TStyledSuggestEdit.GetListBoxIndexByText(const AText: string): Integer;
begin
  for Result := 0 to FListBox.Count - 1 do
    if FListBox.ListItems[Result].Text.ToLower = AText.ToLower  then
      Exit;
  Result := -1;
end;

function TStyledSuggestEdit._GetIndex: Integer;
begin
  Result := FItemIndex;
end;

procedure TStyledSuggestEdit.KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  case Key of
    vkReturn:
      if FListBox.Selected <> nil then
      begin
        OnItemClick(FListBox, FListBox.Selected);
      end;
    vkEscape: FPopup.IsOpen := False;
    vkDown: begin
      if FListBox.Selected <> nil then
        FListBox.ItemIndex := Min(FListBox.Count - 1, FListBox.ItemIndex + 1)
      else
      if FListBox.Count > 0 then
        FListBox.ItemIndex := 0;
    end;
    vkUp: begin
      if FListBox.Selected <> nil then
        FListBox.ItemIndex := Max(0, FListBox.ItemIndex - 1);
    end;
  end;
  if Assigned(OnKeyDown) then
    OnKeyDown(Edit, Key, KeyChar, Shift);
end;

procedure TStyledSuggestEdit.MMDataChanged(var AMessage: TDispatchMessageWithValue<TDataRecord>);
var
  Data: TDataRecord;
begin
  Data := AMessage.Value;
  if Data.Value.IsType <TStrings> and (Data.Key = 'suggestions') then
    FItems.Assign(Data.Value.AsType<TStrings>)
end;

procedure TStyledSuggestEdit.OnItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FLastClickedIndex := Item.Tag;
  _ItemIndex := Item.Tag;
  FPopup.IsOpen := Sender = nil; // whenever OnItemClick is being called programmatically `Sender` must be passed as `nil`,
  Edit.SetFocus;                 // otherwise considered as real-user-click and should close popup
end;

procedure TStyledSuggestEdit.PMPressEnter(var AMessage: TDispatchMessage);
var K: word; KC: Char;
begin
  K := vkReturn;
  KC := #13;
  KeyDown(K, KC, []);
end;

procedure TStyledSuggestEdit.PMDropDown(var AMessage: TDispatchMessage);
begin
  inherited;
  DropDownRecalc('',10);
end;

procedure TStyledSuggestEdit.PMGetItemIndex(var AMessage: TDispatchMessageWithValue<Integer>);
begin
  AMessage.Value := self._ItemIndex;
end;

procedure TStyledSuggestEdit.PMGetItems(var AMessage: TDispatchMessageWithValue<TStrings>);
begin
  AMessage.Value := Self._Items;
end;

procedure TStyledSuggestEdit.PMGetSelectedItem(var AMEssage: TDispatchMessageWithValue<TSelectedItem>);
begin
  AMEssage.Value := self._SelectedItem;
end;

procedure TStyledSuggestEdit.PMSetItemChangeEvent(var AMessage: TDispatchMessageWithValue<TNotifyEvent>);
begin
  FOnItemChange := AMessage.Value;
end;

procedure TStyledSuggestEdit.PMSetItemIndex(var AMessage: TDispatchMessageWithValue<Integer>);
begin
  self._ItemIndex := AMessage.Value;
end;

procedure TStyledSuggestEdit.PMSetSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
  inherited;
  FPopup.Width := Width;
end;

procedure TStyledSuggestEdit.RebuildSuggestionList(AText: String);
var
  i: integer;
  Word: string;
begin
  FListBox.Clear;
  FListBox.BeginUpdate;
  AText := AText.ToLower;
  try
    for i := 0 to FItems.Count - 1 do
      if AText.IsEmpty or FItems[i].ToLower.StartsWith(AText) then
      begin
        FListBox.AddObject(TListBoxItem.Create(FListBox));
        FListBox.ListItems[FListBox.Count - 1].Tag := I;
        FListBox.ListItems[FListBox.Count - 1].Data := FItems.Objects[i];
        FListBox.ListItems[FListBox.Count - 1].Text := FItems[i];
      end;
  finally
    FListBox.EndUpdate;
  end;
end;

procedure TStyledSuggestEdit.RecalculatePopupHeight;
begin
  if FListBox.Items.Count > 0 then
  begin
    FPopup.Height := FListBox.ListItems[0].Height * Min(FDropDownCount, FListBox.Items.Count) + FListBox.BorderHeight;
    FPopup.PopupFormSize := TSizeF.Create(FPopup.Width, FPopup.Height);
  end
  else
  begin
    FPopup.Height := 1; // instead this it's possible to hide FPopup.IsOpen := false;
    FPopup.PopupFormSize := TSizeF.Create(FPopup.Width, FPopup.Height);
  end;
end;

function TStyledSuggestEdit._SelectedItem: TSelectedItem;
begin
  if FItemIndex = -1 then
  begin
    Result.Text := '';
    Result.Data := nil;
  end
  else
  begin
    Result.Text := FItems[FItemIndex];
    Result.Data := FItems.Objects[FItemIndex];
  end;
end;

procedure TStyledSuggestEdit._SetIndex(const Value: Integer);
begin
  if (Value >= -1) and (Value < FItems.Count) and (Value <> FItemIndex) then
  begin
    FDontTrack := true;
    FItemIndex := Value;
    if (FItemIndex >= 0) and (Edit.Text <> _SelectedItem.Text) then
    begin
      Edit.Text := _SelectedItem.Text;
      Edit.GoToTextEnd;
    end;
    if Assigned(FOnItemChange) then
      FOnItemChange(Edit);
    FDontTrack := false;
  end;
end;

procedure TStyledSuggestEdit._SetItems(const Value: TStrings);
begin
  FItems := Value;
  _ItemIndex := -1;
end;

procedure TStyledSuggestEdit.DropDownRecalc(ByText: string; Delay: integer);
begin
  // Here is possible to use a timer call or a call in a thread;
  if not self.FDontTrack then
  begin
    Self.RebuildSuggestionList(ByText);
    Self.RecalculatePopupHeight;
    self.FPopup.IsOpen := self.FListBox.Items.Count > 0;
    CheckIfTextMatchesSuggestions;
  end;
end;

{ TEditHelper }

procedure TEditSuggestHelper.PressEnter;
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_PRESSENTER);
end;

function TEditSuggestHelper.SelectedItem: TSelectedItem;
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<TSelectedItem>(PM_GET_SELECTEDITEM, Result);
end;

procedure TEditSuggestHelper.SetIndex(const Value: Integer);
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage<Integer>(PM_SET_ITEMINDEX, Value);
end;

procedure TEditSuggestHelper.SetOnItemChange(const Value: TNotifyEvent);
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage<TNotifyEvent>(PM_SET_ITEMCHANGE_EVENT, Value);
end;

procedure TEditSuggestHelper.ForceDropDown;
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessage(PM_DROP_DOWN);
end;

function TEditSuggestHelper.GetIndex: Integer;
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<Integer>(PM_GET_ITEMINDEX, Result);
end;

function TEditSuggestHelper.GetItems: TStrings;
begin
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<TStrings>(PM_GET_ITEMS, Result);
end;

procedure TEditSuggestHelper.AssignItems(const S: TStrings);
begin
  self.Model.Data['Suggestions'] := TValue.From<TStrings>(S);
end;


initialization
  TPresentationProxyFactory.Current.Register('SuggestEditStyle', TStyleSuggestEditProxy);
finalization
  TPresentationProxyFactory.Current.Unregister('SuggestEditStyle');
end.
