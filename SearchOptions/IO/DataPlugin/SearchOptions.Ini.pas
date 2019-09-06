unit SearchOptions.Ini;

interface

Uses
  Classes, HsIniFilesEx;

Type
  IIniSearchOptions = Interface(IIniFileEx)
    ['{4B61686E-29A0-2112-B139-67B9D21979F9}']
    Function  GetBackward() : Boolean;
    Procedure SetBackward(Const ABackward : Boolean);

    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Const ACaseSensitive : Boolean);

    Function  GetFromCaret() : Boolean;
    Procedure SetFromCaret(Const AFromCaret : Boolean);

    Function  GetSelectionOnly() : Boolean;
    Procedure SetSelectionOnly(Const ASelectionOnly : Boolean);

    Function  GetTextAtCaret() : Boolean;
    Procedure SetTextAtCaret(Const ATextAtCaret : Boolean);

    Function  GetWholeWords() : Boolean;
    Procedure SetWholeWords(Const AWholeWords : Boolean);

    Function  GetSearchText() : String;
    Procedure SetSearchText(Const ASearchText : String);

    Function  GetSearchTextHistory() : String;
    Procedure SetSearchTextHistory(Const ASearchTextHistory : String);

    Function  GetReplaceText() : String;
    Procedure SetReplaceText(Const AReplaceText : String);

    Function  GetReplaceTextHistory() : String;
    Procedure SetReplaceTextHistory(Const AReplaceTextHistory : String);

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property Backward           : Boolean Read GetBackward           Write SetBackward;
    Property CaseSensitive      : Boolean Read GetCaseSensitive      Write SetCaseSensitive;
    Property FromCaret          : Boolean Read GetFromCaret          Write SetFromCaret;
    Property SelectionOnly      : Boolean Read GetSelectionOnly      Write SetSelectionOnly;
    Property TextAtCaret        : Boolean Read GetTextAtCaret        Write SetTextAtCaret;
    Property WholeWords         : Boolean Read GetWholeWords         Write SetWholeWords;
    Property SearchText         : String  Read GetSearchText         Write SetSearchText;
    Property SearchTextHistory  : String  Read GetSearchTextHistory  Write SetSearchTextHistory;
    Property ReplaceText        : String  Read GetReplaceText        Write SetReplaceText;
    Property ReplaceTextHistory : String  Read GetReplaceTextHistory Write SetReplaceTextHistory;

    Procedure Clear();
    Procedure Rename(Const FileName : String; Reload : Boolean);
    Procedure GetStrings(List: TStrings);
    Procedure SetStrings(List: TStrings);
    
  End;

(******************************************************************************)

  TIniSearchOptions = Class(TObject)
  Public
    Class Function CreateSearchOptions() : IIniSearchOptions; OverLoad;
    Class Function CreateSearchOptions(Const AIniString : String) : IIniSearchOptions; OverLoad;

  End;

implementation

Uses Dialogs,
  SysUtils, HsInterfaceEx, HsStringListEx, SearchOptionsIntf;

Type
  TIniSearchOptionsImpl = Class(TMemIniFileEx, ISearchOptions, IIniSearchOptions)
  Private
    FSearchImpl : Pointer;
    FInterfaceState : TInterfaceState;
    
    Function GetSearchImplementor() : ISearchOptions;

  Protected
    Property Implementor : TInterfaceExImplementor Read GetImplementor Implements
      ISearchOptions, IIniSearchOptions;
    Property SearchImpl : ISearchOptions Read GetSearchImplementor;

    Function  GetBackward() : Boolean;
    Procedure SetBackward(Const ABackward : Boolean);

    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Const ACaseSensitive : Boolean); OverLoad;

    Function  GetFromCaret() : Boolean;
    Procedure SetFromCaret(Const AFromCaret : Boolean);

    Function  GetSelectionOnly() : Boolean;
    Procedure SetSelectionOnly(Const ASelectionOnly : Boolean);

    Function  GetTextAtCaret() : Boolean;
    Procedure SetTextAtCaret(Const ATextAtCaret : Boolean);

    Function  GetWholeWords() : Boolean;
    Procedure SetWholeWords(Const AWholeWords : Boolean);

    Function  GetSearchText() : String;
    Procedure SetSearchText(Const ASearchText : String);

    Function  GetSearchTextHistory() : String;
    Procedure SetSearchTextHistory(Const ASearchTextHistory : String);

    Function  GetReplaceText() : String;
    Procedure SetReplaceText(Const AReplaceText : String);

    Function  GetReplaceTextHistory() : String;
    Procedure SetReplaceTextHistory(Const AReplaceTextHistory : String);

    Function  GetInterfaceState() : TInterfaceState;
    
    Function  MyGetSearchTextHistory() : IHsStringListEx;
    Procedure MySetSearchTextHistory(Const ASearchTextHistory : IHsStringListEx);

    Function  MyGetReplaceTextHistory() : IHsStringListEx;
    Procedure MySetReplaceTextHistory(Const AReplaceTextHistory : IHsStringListEx);

    Procedure ISearchOptions.SetSearchTextHistory = MySetSearchTextHistory;
    Function  ISearchOptions.GetSearchTextHistory = MyGetSearchTextHistory;
    Procedure ISearchOptions.SetReplaceTextHistory = MySetReplaceTextHistory;
    Function  ISearchOptions.GetReplaceTextHistory = MyGetReplaceTextHistory;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TIniSearchOptions.CreateSearchOptions() : IIniSearchOptions;
Begin
  Result := TIniSearchOptionsImpl.Create('');
End;

Class Function TIniSearchOptions.CreateSearchOptions(Const AIniString : String) : IIniSearchOptions;
Var lLst : TStringList;
Begin
  Result := TIniSearchOptionsImpl.Create('');
  lLst := TStringList.Create();
  Try
    lLst.Text := AIniString;
    Result.SetStrings(lLst);

    Finally
      lLst.Free();
  End;
End;

(******************************************************************************)

Procedure TIniSearchOptionsImpl.AfterConstruction();
Begin
  FSearchImpl := Pointer(ISearchOptions(Self));
  FInterfaceState := isCreating;

  InHerited AfterConstruction();
End;

Procedure TIniSearchOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (ISearchOptions(FSearchImpl) <> ISearchOptions(Self)) And
     (ISearchOptions(FSearchImpl).InterfaceState <> isDestroying) Then
    With SearchImpl Do
    Begin
      Backward                     := ReadBool('SearchOptions', 'Backward', False);
      CaseSensitive                := ReadBool('SearchOptions', 'CaseSensitive', False);
      FromCaret                    := ReadBool('SearchOptions', 'FromCaret', False);
      SelectionOnly                := ReadBool('SearchOptions', 'SelectionOnly', False);
      TextAtCaret                  := ReadBool('SearchOptions', 'TextAtCaret', False);
      WholeWords                   := ReadBool('SearchOptions', 'WholeWords', False);
      SearchText                   := ReadString('SearchOptions', 'SearchText', '');
      SearchTextHistory.CommaText  := ReadString('SearchOptions', 'SearchTextHistory', '');
      ReplaceText                  := ReadString('SearchOptions', 'ReplaceText', '');
      ReplaceTextHistory.CommaText := ReadString('SearchOptions', 'ReplaceTextHistory', '');
    End;

  InHerited BeforeDestruction();
End;

Function TIniSearchOptionsImpl.GetSearchImplementor() : ISearchOptions;
Begin
  Result := ISearchOptions(FSearchImpl);
End;

Function TIniSearchOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TIniSearchOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : ISearchOptions;
Begin
  If Supports(ASource, ISearchOptions, lSrc) Then
  Begin
    WriteBool('SearchOptions', 'Backward', lSrc.Backward);
    WriteBool('SearchOptions', 'CaseSensitive', lSrc.CaseSensitive);
    WriteBool('SearchOptions', 'FromCaret', lSrc.FromCaret);
    WriteBool('SearchOptions', 'SelectionOnly', lSrc.SelectionOnly);
    WriteBool('SearchOptions', 'TextAtCaret', lSrc.TextAtCaret);
    WriteBool('SearchOptions', 'WholeWords', lSrc.WholeWords);
    WriteString('SearchOptions', 'SearchText', lSrc.SearchText);
    WriteString('SearchOptions', 'SearchTextHistory', lSrc.SearchTextHistory.CommaText);
    WriteString('SearchOptions', 'ReplaceText', lSrc.ReplaceText);
    WriteString('SearchOptions', 'ReplaceTextHistory', lSrc.ReplaceTextHistory.CommaText);

    If ASyncSource Then
      FSearchImpl := Pointer(lSrc);
  End;
End;

Function TIniSearchOptionsImpl.GetBackward() : Boolean;
Begin
  Result := ReadBool('SearchOptions', 'Backward', False);
End;

Procedure TIniSearchOptionsImpl.SetBackward(Const ABackward : Boolean);
Begin
  WriteBool('SearchOptions', 'Backward', ABackward);
End;

Function TIniSearchOptionsImpl.GetCaseSensitive() : Boolean;
Begin
  Result := ReadBool('SearchOptions', 'CaseSensitive', False);
End;

Procedure TIniSearchOptionsImpl.SetCaseSensitive(Const ACaseSensitive : Boolean);
Begin
  WriteBool('SearchOptions', 'CaseSensitive', ACaseSensitive);
End;

Function TIniSearchOptionsImpl.GetFromCaret() : Boolean;
Begin
  Result := ReadBool('SearchOptions', 'FromCaret', False);
End;

Procedure TIniSearchOptionsImpl.SetFromCaret(Const AFromCaret : Boolean);
Begin
  WriteBool('SearchOptions', 'FromCaret', AFromCaret);
End;

Function TIniSearchOptionsImpl.GetSelectionOnly() : Boolean;
Begin
  Result := ReadBool('SearchOptions', 'SelectionOnly', False);
End;

Procedure TIniSearchOptionsImpl.SetSelectionOnly(Const ASelectionOnly : Boolean);
Begin
  WriteBool('SearchOptions', 'SelectionOnly', ASelectionOnly);
End;

Function TIniSearchOptionsImpl.GetTextAtCaret() : Boolean;
Begin
  Result := ReadBool('SearchOptions', 'TextAtCaret', False);
End;

Procedure TIniSearchOptionsImpl.SetTextAtCaret(Const ATextAtCaret : Boolean);
Begin
  WriteBool('SearchOptions', 'TextAtCaret', ATextAtCaret);
End;

Function TIniSearchOptionsImpl.GetWholeWords() : Boolean;
Begin
  Result := ReadBool('SearchOptions', 'WholeWords', False);
End;

Procedure TIniSearchOptionsImpl.SetWholeWords(Const AWholeWords : Boolean);
Begin
  WriteBool('SearchOptions', 'WholeWords', AWholeWords);
End;

Function TIniSearchOptionsImpl.GetSearchText() : String;
Begin
  Result := ReadString('SearchOptions', 'SearchText', '');
End;

Procedure TIniSearchOptionsImpl.SetSearchText(Const ASearchText : String);
Begin
  WriteString('SearchOptions', 'SearchText', ASearchText);
End;

Function TIniSearchOptionsImpl.GetSearchTextHistory() : String;
Begin
  Result := ReadString('SearchOptions', 'SearchTextHistory', '');
End;

Procedure TIniSearchOptionsImpl.SetSearchTextHistory(Const ASearchTextHistory : String);
Begin
  WriteString('SearchOptions', 'SearchText', ASearchTextHistory);
End;

Function TIniSearchOptionsImpl.MyGetSearchTextHistory() : IHsStringListEx;
Begin
  Result := THsStringListEx.CreateList();
  Result.CommaText := ReadString('SearchOptions', 'SearchTextHistory', '');
End;

Procedure TIniSearchOptionsImpl.MySetSearchTextHistory(Const ASearchTextHistory : IHsStringListEx);
Begin
  WriteString('SearchOptions', 'SearchTextHistory', ASearchTextHistory.CommaText);
End;

Function TIniSearchOptionsImpl.GetReplaceText() : String;
Begin
  Result := ReadString('SearchOptions', 'ReplaceText', '');
End;

Procedure TIniSearchOptionsImpl.SetReplaceText(Const AReplaceText : String);
Begin
  WriteString('SearchOptions', 'ReplaceText', AReplaceText);
End;

Function TIniSearchOptionsImpl.GetReplaceTextHistory() : String;
Begin
  Result := ReadString('SearchOptions', 'ReplaceTextHistory', '');
End;

Procedure TIniSearchOptionsImpl.SetReplaceTextHistory(Const AReplaceTextHistory : String);
Begin
  WriteString('SearchOptions', 'SearchTextHistory', AReplaceTextHistory);
End;

Function TIniSearchOptionsImpl.MyGetReplaceTextHistory() : IHsStringListEx;
Begin
  Result := THsStringListEx.CreateList();
  Result.CommaText := ReadString('SearchOptions', 'ReplaceTextHistory', '');
End;

Procedure TIniSearchOptionsImpl.MySetReplaceTextHistory(Const AReplaceTextHistory : IHsStringListEx);
Begin
  WriteString('SearchOptions', 'ReplaceTextHistory', AReplaceTextHistory.CommaText);
End;

end.
