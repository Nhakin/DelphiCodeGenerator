Unit SearchTextDlg;

{x$I SynEdit.inc}

Interface

Uses
  SearchOptionsIntf,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

Type
  TTextSearchDialog = Class(TForm)
    btnCancel: TButton;
    btnOK: TButton;
    cbRegularExpression: TCheckBox;
    cbReplaceText: TComboBox;
    cbSearchCaseSensitive: TCheckBox;
    cbSearchFromCursor: TCheckBox;
    cbSearchSelectedOnly: TCheckBox;
    cbSearchText: TComboBox;
    cbSearchWholeWords: TCheckBox;
    gbSearchOptions: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    PanSearch: TPanel;
    PanReplace: TPanel;
    PanOptions: TPanel;
    rgSearchDirection: TRadioGroup;

    Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);

  Private                       
    FIsReplaceDialog : Boolean;
    FSeachOption : ISearchOptions;

    Function  GetSearchOptions() : ISearchOptions;
    Procedure SetSearchOptions(ASearchOptions : ISearchOptions);

    Function  GetIsReplaceDialog() : Boolean;
    Procedure SetIsReplaceDialog(Value: Boolean);

    Function  GetSearchBackwards() : Boolean;
    Procedure SetSearchBackwards(Value: Boolean);

    Function  GetSearchCaseSensitive() : Boolean;
    Procedure SetSearchCaseSensitive(Value: Boolean);

    Function  GetSearchFromCursor() : Boolean;
    Procedure SetSearchFromCursor(Value: Boolean);

    Function  GetSearchInSelection() : Boolean;
    Procedure SetSearchInSelection(Value: Boolean);

    Function  GetSearchText() : String;
    Procedure SetSearchText(Value: String);

    Function  GetSearchTextHistory() : String;
    Procedure SetSearchTextHistory(Value: String);

    Function  GetSearchWholeWords() : Boolean;
    Procedure SetSearchWholeWords(Value: Boolean);

    Function  GetSearchRegularExpression() : Boolean;
    Procedure SetSearchRegularExpression(Const Value: Boolean);

    Function  GetReplaceText() : String;
    Procedure SetReplaceText(Value: String);

    Function  GetReplaceTextHistory() : String;
    Procedure SetReplaceTextHistory(Value: String);

  Public
    Property IsReplaceDialog : Boolean        Read GetIsReplaceDialog Write SetIsReplaceDialog;
    Property SearchOptions   : ISearchOptions Read GetSearchOptions   Write SetSearchOptions;

  End;

Implementation

{$R *.DFM}

Function TTextSearchDialog.GetSearchOptions() : ISearchOptions;
Begin
  Result := FSeachOption;
End;

Procedure TTextSearchDialog.SetSearchOptions(ASearchOptions : ISearchOptions);
Begin
  FSeachOption := ASearchOptions;

  If FSeachOption.Backward Then
    rgSearchDirection.ItemIndex   := 1
  Else
    rgSearchDirection.ItemIndex   := 0;

  cbSearchCaseSensitive.Checked := FSeachOption.CaseSensitive;
  cbSearchFromCursor.Checked    := FSeachOption.FromCaret;
  cbSearchSelectedOnly.Checked  := FSeachOption.SelectionOnly;
  cbSearchText.Items.Text       := FSeachOption.SearchTextHistory.Text;
  cbSearchText.Text             := FSeachOption.SearchText;
  cbSearchWholeWords.Checked    := FSeachOption.WholeWords;
  cbReplaceText.Items.Text      := FSeachOption.ReplaceTextHistory.Text;
  cbReplaceText.Text            := FSeachOption.ReplaceText;
End;

Procedure TTextSearchDialog.SetReplaceText(Value: String);
Begin
  cbReplaceText.Text := Value;
End;

Function TTextSearchDialog.GetIsReplaceDialog() : Boolean;
Begin
  Result := FIsReplaceDialog;
End;

Procedure TTextSearchDialog.SetIsReplaceDialog(Value: Boolean);
Begin
  FIsReplaceDialog := Value;
  If Value Then
  Begin
    PanReplace.Visible := True;
    Caption := 'Replace text';
  End;
End;

Function TTextSearchDialog.GetSearchBackwards: Boolean;
Begin
  Result := rgSearchDirection.ItemIndex = 1;
End;

Function TTextSearchDialog.GetSearchCaseSensitive: Boolean;
Begin
  Result := cbSearchCaseSensitive.Checked;
End;

Function TTextSearchDialog.GetSearchFromCursor: Boolean;
Begin
  Result := cbSearchFromCursor.Checked;
End;

Function TTextSearchDialog.GetSearchInSelection: Boolean;
Begin
  Result := cbSearchSelectedOnly.Checked;
End;

Function TTextSearchDialog.GetSearchRegularExpression: Boolean;
Begin
  Result := cbRegularExpression.Checked;
End;

Function TTextSearchDialog.GetSearchText: String;
Begin
  Result := cbSearchText.Text;
End;

Function TTextSearchDialog.GetSearchTextHistory: String;
Var
  i: Integer;
Begin
  Result := '';
  For i := 0 To cbSearchText.Items.Count - 1 Do
  Begin
    If i >= 10 Then
      Break;

    If i > 0 Then
      Result := Result + #13#10;

    Result := Result + cbSearchText.Items[i];
  End;
End;

Function TTextSearchDialog.GetSearchWholeWords: Boolean;
Begin
  Result := cbSearchWholeWords.Checked;
End;

Procedure TTextSearchDialog.SetSearchBackwards(Value: Boolean);
Begin
  rgSearchDirection.ItemIndex := Ord(Value);
End;

Procedure TTextSearchDialog.SetSearchCaseSensitive(Value: Boolean);
Begin
  cbSearchCaseSensitive.Checked := Value;
End;

Procedure TTextSearchDialog.SetSearchFromCursor(Value: Boolean);
Begin
  cbSearchFromCursor.Checked := Value;
End;

Procedure TTextSearchDialog.SetSearchInSelection(Value: Boolean);
Begin
  cbSearchSelectedOnly.Checked := Value;
End;

Procedure TTextSearchDialog.SetSearchText(Value: String);
Begin
  cbSearchText.Text := Value;
End;

Procedure TTextSearchDialog.SetSearchTextHistory(Value: String);
Begin
  cbSearchText.Items.Text := Value;
End;

Procedure TTextSearchDialog.SetSearchWholeWords(Value: Boolean);
Begin
  cbSearchWholeWords.Checked := Value;
End;

Procedure TTextSearchDialog.SetSearchRegularExpression(
  Const Value: Boolean);
Begin
  cbRegularExpression.Checked := Value;
End;

Function TTextSearchDialog.GetReplaceText() : String;
Begin
  Result := cbReplaceText.Text;
End;

Function TTextSearchDialog.GetReplaceTextHistory() : String;
Var i : Integer;
Begin
  Result := '';
  For i := 0 To cbReplaceText.Items.Count - 1 Do
  Begin
    If i >= 10 Then
      Break;

    If i > 0 Then
      Result := Result + #13#10;

    Result := Result + cbReplaceText.Items[i];
  End;
End;

Procedure TTextSearchDialog.SetReplaceTextHistory(Value: String);
Begin
  cbReplaceText.Items.Text := Value;
End;

Procedure TTextSearchDialog.FormCloseQuery(Sender: TObject;
  Var CanClose: Boolean);
Var s : String;
    X : Integer;
Begin
  If ModalResult = mrOK Then
  Begin
    s := cbSearchText.Text;
    
    If s <> '' Then
    Begin
      X := cbSearchText.Items.IndexOf(s);
      If X > -1 Then
      Begin
        cbSearchText.Items.Delete(X);
        cbSearchText.Items.Insert(0, s);
        cbSearchText.Text := s;
      End
      Else
        cbSearchText.Items.Insert(0, s);
    End;

    FSeachOption.Backward                := rgSearchDirection.ItemIndex = 1;
    FSeachOption.CaseSensitive           := cbSearchCaseSensitive.Checked;
    FSeachOption.FromCaret               := cbSearchFromCursor.Checked;
    FSeachOption.SelectionOnly           := cbSearchSelectedOnly.Checked;
    If cbSearchText.Items.Count > 10 Then
    Begin
      FSeachOption.SearchTextHistory.Clear();
      For X := 0 To 9 Do
        FSeachOption.SearchTextHistory.Add(cbSearchText.Items[X]);
    End
    Else
      FSeachOption.SearchTextHistory.Text  := cbSearchText.Items.Text;

    FSeachOption.SearchText              := cbSearchText.Text;
    FSeachOption.WholeWords              := cbSearchWholeWords.Checked;
    FSeachOption.ReplaceTextHistory.Text := cbReplaceText.Items.Text;
    FSeachOption.ReplaceText             := cbReplaceText.Text;
  End;
End;

End.

