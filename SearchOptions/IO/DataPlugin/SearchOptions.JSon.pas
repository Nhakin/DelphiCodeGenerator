unit SearchOptions.JSon;

Interface

Uses Classes, SysUtils, RTLConsts, HsJSonEx;

Type
  IJSonSearchOptions = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-AEB3-41A817111A00}']
    Function  GetBackward() : Boolean;
    Procedure SetBackward(Const ABackward : Boolean);

    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Const ACaseSensitive : Boolean);

    Function  GetFromCaret() : Boolean;
    Procedure SetFromCaret(Const AFromCaret : Boolean);

    Function  GetSelectionOnly() : Boolean;
    Procedure SetSelectionOnly(Const ASelectionOnly : Boolean);

    Function  GetTextAtCaret() : Boolean;
    Procedure SetTextAtCaret(Const ATextAtCarret : Boolean);

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

  End;

(******************************************************************************)

  TJSonSearchOptions = Class(TObject)
  Public
    Class Function HsJSonObjectClass() : THsJSonObjectClass;
    Class Function CreateSearchOptions() : IJSonSearchOptions; OverLoad;
    Class Function CreateSearchOptions(Const AJSonString : WideString) : IJSonSearchOptions; OverLoad;
    Class Function CreateSearchOptions(AJsonObject : IHsJSonObject) : IJSonSearchOptions; OverLoad;

  End;

Implementation

Uses HsInterfaceEx, HsStringListEx, SearchOptionsIntf;

Type
  TJSonSearchOptionsImpl = Class(THsJSonObject, ISearchOptions, IJSonSearchOptions)
  Private
    FSearchImpl : Pointer;
    FInterfaceState : TInterfaceState;
    
    Function GetImplementor() : ISearchOptions;

  Protected
    Property SearchImpl : ISearchOptions Read GetImplementor;
  
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
    Procedure Clear(); 

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TJSonSearchOptions.HsJSonObjectClass() : THsJSonObjectClass;
Begin
  Result := TJSonSearchOptionsImpl;
End;

Class Function TJSonSearchOptions.CreateSearchOptions() : IJSonSearchOptions;
Begin
  Result := TJSonSearchOptionsImpl.Create();
End;

Class Function TJSonSearchOptions.CreateSearchOptions(Const AJSonString : WideString) : IJSonSearchOptions;
Begin
  Result := THsJSonObject.GetDocBinding(AJSonString, TJSonSearchOptionsImpl) As IJSonSearchOptions;
End;

Class Function TJSonSearchOptions.CreateSearchOptions(AJsonObject : IHsJSonObject) : IJSonSearchOptions;
Begin
  Result := THsJSonObject.GetDocBinding(AJsonObject, TJSonSearchOptionsImpl) As IJSonSearchOptions;
End;

(******************************************************************************)

Procedure TJSonSearchOptionsImpl.AfterConstruction();
Begin
  FSearchImpl := Pointer(ISearchOptions(Self));
  FInterfaceState := isCreating;

  InHerited AfterConstruction();
End;

Procedure TJSonSearchOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (ISearchOptions(FSearchImpl) <> ISearchOptions(Self)) And
     (ISearchOptions(FSearchImpl).InterfaceState <> isDestroying) Then
    With SearchImpl Do
    Begin
      Backward                     := B['Backward'];
      CaseSensitive                := B['CaseSensitive'];
      FromCaret                    := B['FromCaret'];
      SelectionOnly                := B['SelectionOnly'];
      TextAtCaret                  := B['TextAtCaret'];
      WholeWords                   := B['WholeWords'];
      SearchText                   := S['SearchText'];
      SearchTextHistory.CommaText  := S['SearchTextHistory'];
      ReplaceText                  := S['ReplaceText'];
      ReplaceTextHistory.CommaText := S['ReplaceTextHistory'];
    End;

  InHerited BeforeDestruction();
End;

Function TJSonSearchOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Function TJSonSearchOptionsImpl.GetImplementor() : ISearchOptions;
Begin
  Result := ISearchOptions(FSearchImpl);
End;

Procedure TJSonSearchOptionsImpl.Clear();
Begin
  B['Backward']           := False;
  B['CaseSensitive']      := False;
  B['FromCaret']          := False;
  B['SelectionOnly']      := False;
  B['TextAtCaret']        := False;
  B['WholeWords']         := False;
  S['SearchText']         := '';
  S['SearchTextHistory']  := '';
  S['ReplaceText']        := '';
  S['ReplaceTextHistory'] := '';
End;

Procedure TJSonSearchOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : ISearchOptions;
Begin
  If Supports(ASource, ISearchOptions, lSrc) Then
  Begin
    B['Backward']           := lSrc.Backward;
    B['CaseSensitive']      := lSrc.CaseSensitive;
    B['FromCaret']          := lSrc.FromCaret;
    B['SelectionOnly']      := lSrc.SelectionOnly;
    B['TextAtCaret']        := lSrc.TextAtCaret;
    B['WholeWords']         := lSrc.WholeWords;
    S['SearchText']         := lSrc.SearchText;
    S['SearchTextHistory']  := lSrc.SearchTextHistory.CommaText;
    S['ReplaceText']        := lSrc.ReplaceText;
    S['ReplaceTextHistory'] := lSrc.ReplaceTextHistory.CommaText;

    If ASyncSource Then
      FSearchImpl := Pointer(lSrc);
  End;
End;

Function TJSonSearchOptionsImpl.GetBackward() : Boolean;
Begin
  Result := B['Backward'];
End;

Procedure TJSonSearchOptionsImpl.SetBackward(Const ABackward : Boolean);
Begin
  B['Backward'] := ABackward;
End;

Function TJSonSearchOptionsImpl.GetCaseSensitive() : Boolean;
Begin
  Result := B['CaseSensitive'];
End;

Procedure TJSonSearchOptionsImpl.SetCaseSensitive(Const ACaseSensitive : Boolean);
Begin
  B['CaseSensitive'] := ACaseSensitive;
End;

Function TJSonSearchOptionsImpl.GetFromCaret() : Boolean;
Begin
  Result := B['FromCaret'];
End;

Procedure TJSonSearchOptionsImpl.SetFromCaret(Const AFromCaret : Boolean);
Begin
  B['FromCaret'] := AFromCaret;
End;

Function TJSonSearchOptionsImpl.GetSelectionOnly() : Boolean;
Begin
  Result := B['SelectionOnly'];
End;

Procedure TJSonSearchOptionsImpl.SetSelectionOnly(Const ASelectionOnly : Boolean);
Begin
  B['SelectionOnly'] := ASelectionOnly;
End;

Function TJSonSearchOptionsImpl.GetTextAtCaret() : Boolean;
Begin
  Result := B['TextAtCaret'];
End;

Procedure TJSonSearchOptionsImpl.SetTextAtCaret(Const ATextAtCaret : Boolean);
Begin
  B['TextAtCaret'] := ATextAtCaret;
End;

Function TJSonSearchOptionsImpl.GetWholeWords() : Boolean;
Begin
  Result := B['WholeWords'];
End;

Procedure TJSonSearchOptionsImpl.SetWholeWords(Const AWholeWords : Boolean);
Begin
  B['WholeWords'] := AWholeWords;
End;

Function TJSonSearchOptionsImpl.GetSearchText() : String;
Begin
  Result := S['SearchText'];
End;

Procedure TJSonSearchOptionsImpl.SetSearchText(Const ASearchText : String);
Begin
  S['SearchText'] := ASearchText;
End;

Function TJSonSearchOptionsImpl.GetSearchTextHistory() : String;
Begin
  Result := S['SearchTextHistory'];
End;

Procedure TJSonSearchOptionsImpl.SetSearchTextHistory(Const ASearchTextHistory : String);
Begin
  S['SearchTextHistory'] := ASearchTextHistory;
End;

Function TJSonSearchOptionsImpl.GetReplaceText() : String;
Begin
  Result := S['ReplaceText'];
End;

Procedure TJSonSearchOptionsImpl.SetReplaceText(Const AReplaceText : String);
Begin
  S['ReplaceText'] := AReplaceText;
End;

Function TJSonSearchOptionsImpl.GetReplaceTextHistory() : String;
Begin
  Result := S['ReplaceTextHistory'];
End;

Procedure TJSonSearchOptionsImpl.SetReplaceTextHistory(Const AReplaceTextHistory : String);
Begin
  S['ReplaceTextHistory'] := AReplaceTextHistory;
End;

Function TJSonSearchOptionsImpl.MyGetSearchTextHistory() : IHsStringListEx;
Begin
  Result := THsStringListEx.CreateList();
  Result.CommaText := S['SearchTextHistory'];
End;

Procedure TJSonSearchOptionsImpl.MySetSearchTextHistory(Const ASearchTextHistory : IHsStringListEx);
Begin
  S['SearchTextHistory'] := ASearchTextHistory.CommaText;
End;

Function TJSonSearchOptionsImpl.MyGetReplaceTextHistory() : IHsStringListEx;
Begin
  Result := THsStringListEx.CreateList();
  Result.CommaText := S['ReplaceTextHistory'];
End;

Procedure TJSonSearchOptionsImpl.MySetReplaceTextHistory(Const AReplaceTextHistory : IHsStringListEx);
Begin
  S['ReplaceTextHistory'] := AReplaceTextHistory.CommaText;
End;

End.

