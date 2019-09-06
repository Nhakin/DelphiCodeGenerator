unit SearchOptionsImpl;

interface

Uses SearchOptionsIntf, HsInterfaceEx, HsStringListEx;

Type
  TSearchOptions = Class(TInterfacedObjectEx, ISearchOptions)
  Private
    FBackward           : Boolean;
    FCaseSensitive      : Boolean;
    FFromCaret          : Boolean;
    FSelectionOnly      : Boolean;
    FTextAtCaret       : Boolean;
    FWholeWords         : Boolean;
    FSearchText         : String;
    FSearchTextHistory  : IHsStringListEx;
    FReplaceText        : String;
    FReplaceTextHistory : IHsStringListEx;
    FInterfaceState     : TInterfaceState;
    
  Protected
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

    Function  GetSearchTextHistory() : IHsStringListEx;
    Procedure SetSearchTextHistory(Const ASearchTextHistory : IHsStringListEx);

    Function  GetReplaceText() : String; 
    Procedure SetReplaceText(Const AReplaceText : String); 

    Function  GetReplaceTextHistory() : IHsStringListEx; 
    Procedure SetReplaceTextHistory(Const AReplaceTextHistory : IHsStringListEx); 

    Function  GetInterfaceState() : TInterfaceState;

    Procedure Clear();
    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
    
  Public
    Property Backward           : Boolean         Read GetBackward           Write SetBackward;
    Property CaseSensitive      : Boolean         Read GetCaseSensitive      Write SetCaseSensitive;
    Property FromCaret          : Boolean         Read GetFromCaret          Write SetFromCaret;
    Property SelectionOnly      : Boolean         Read GetSelectionOnly      Write SetSelectionOnly;
    Property TextAtCaret        : Boolean         Read GetTextAtCaret        Write SetTextAtCaret;
    Property WholeWords         : Boolean         Read GetWholeWords         Write SetWholeWords;
    Property SearchText         : String          Read GetSearchText         Write SetSearchText;
    Property SearchTextHistory  : IHsStringListEx Read GetSearchTextHistory  Write SetSearchTextHistory;
    Property ReplaceText        : String          Read GetReplaceText        Write SetReplaceText;
    Property ReplaceTextHistory : IHsStringListEx Read GetReplaceTextHistory Write SetReplaceTextHistory;
  
    Constructor Create(); ReIntroduce;
    Destructor Destroy(); OverRide;

  End;

implementation

Uses SysUtils;

Constructor TSearchOptions.Create();
Begin
  InHerited Create();

  FSearchTextHistory  := THsStringListEx.CreateList();
  FReplaceTextHistory := THsStringListEx.CreateList();
  FInterfaceState     := isCreating;
End;

Destructor TSearchOptions.Destroy();
Begin
  FSearchTextHistory  := Nil;
  FReplaceTextHistory := Nil;
  FInterfaceState     := isDestroying;

  InHerited Destroy();
End;

Function TSearchOptions.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TSearchOptions.Clear();
Begin
  FBackward      := False;
  FCaseSensitive := False;
  FFromCaret     := False;
  FSelectionOnly := False;
  FTextAtCaret   := False;
  FWholeWords    := False;
  FSearchText    := '';
  FReplaceText   := '';
End;

Procedure TSearchOptions.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : ISearchOptions;
Begin
  If Supports(ASource, ISearchOptions, lSrc) Then
  Begin
    FBackward                     := lSrc.Backward;
    FCaseSensitive                := lSrc.CaseSensitive;
    FFromCaret                    := lSrc.FromCaret;
    FSelectionOnly                := lSrc.SelectionOnly;
    FTextAtCaret                  := lSrc.TextAtCaret;
    FWholeWords                   := lSrc.WholeWords;
    FSearchText                   := lSrc.SearchText;
    FSearchTextHistory.CommaText  := lSrc.SearchTextHistory.CommaText;
    FReplaceText                  := lSrc.ReplaceText;
    FReplaceTextHistory.CommaText := lSrc.ReplaceTextHistory.CommaText;
  End;
End;

Function TSearchOptions.GetBackward() : Boolean;
Begin
  Result := FBackward;
End;

Procedure TSearchOptions.SetBackward(Const ABackward : Boolean);
Begin
  FBackward := ABackward;
End;

Function TSearchOptions.GetCaseSensitive() : Boolean;
Begin
  Result := FCaseSensitive;
End;

Procedure TSearchOptions.SetCaseSensitive(Const ACaseSensitive : Boolean);
Begin
  FCaseSensitive := ACaseSensitive;
End;

Function TSearchOptions.GetFromCaret() : Boolean;
Begin
  Result := FFromCaret;
End;

Procedure TSearchOptions.SetFromCaret(Const AFromCaret : Boolean);
Begin
  FFromCaret := AFromCaret;
End;

Function TSearchOptions.GetSelectionOnly() : Boolean;
Begin
  Result := FSelectionOnly;
End;

Procedure TSearchOptions.SetSelectionOnly(Const ASelectionOnly : Boolean);
Begin
  FSelectionOnly := ASelectionOnly;
End;

Function TSearchOptions.GetTextAtCaret() : Boolean;
Begin
  Result := FTextAtCaret;
End;

Procedure TSearchOptions.SetTextAtCaret(Const ATextAtCarret : Boolean);
Begin
  FTextAtCaret := ATextAtCarret;
End;

Function TSearchOptions.GetWholeWords() : Boolean;
Begin
  Result := FWholeWords;
End;

Procedure TSearchOptions.SetWholeWords(Const AWholeWords : Boolean);
Begin
  FWholeWords := AWholeWords;
End;

Function TSearchOptions.GetSearchText() : String;
Begin
  Result := FSearchText;
End;

Procedure TSearchOptions.SetSearchText(Const ASearchText : String);
Begin
  FSearchText := ASearchText;
End;

Function TSearchOptions.GetSearchTextHistory() : IHsStringListEx;
Begin
  Result := FSearchTextHistory;
End;

Procedure TSearchOptions.SetSearchTextHistory(Const ASearchTextHistory : IHsStringListEx);
Begin
  FSearchTextHistory.Text := ASearchTextHistory.Text;
End;

Function TSearchOptions.GetReplaceText() : String;
Begin
  Result := FReplaceText;
End;

Procedure TSearchOptions.SetReplaceText(Const AReplaceText : String);
Begin
  FReplaceText := AReplaceText;
End;

Function TSearchOptions.GetReplaceTextHistory() : IHsStringListEx;
Begin
  Result := FReplaceTextHistory;
End;

Procedure TSearchOptions.SetReplaceTextHistory(Const AReplaceTextHistory : IHsStringListEx);
Begin
  FReplaceTextHistory.Text := AReplaceTextHistory.Text;
End;
  
end.
