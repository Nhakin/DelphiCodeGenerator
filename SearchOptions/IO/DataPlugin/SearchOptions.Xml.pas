unit SearchOptions.Xml;

Interface

Uses Classes, SysUtils, HsXmlDocEx, XmlDoc;

Type
  IXmlSearchOptions = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-9709-21664052D150}']
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

  TXmlSearchOptions = Class(TObject)
  Public
    Class Function XmlNodeClass() : TXmlNodeClass;
    Class Function CreateSearchOptions() : IXmlSearchOptions; OverLoad;
    Class Function CreateSearchOptions(Const AXmlString : String) : IXmlSearchOptions; OverLoad;

  End;

Implementation

Uses 
  Variants, XmlIntf, HsInterfaceEx, HsStringListEx, SearchOptionsIntf;

Type
  TXmlSearchParametersImpl = Class(TXmlNodeEx, ISearchOptions, IXmlSearchOptions)
  Private
    FSearchImpl : Pointer;
    FInterfacestate : TInterfaceState;
    
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

Class Function TXmlSearchOptions.XmlNodeClass() : TXmlNodeClass;
Begin
  Result := TXmlSearchParametersImpl;
End;

Class Function TXmlSearchOptions.CreateSearchOptions() : IXmlSearchOptions;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.Options := lXml.Options + [doNodeAutoIndent];

  Result := (lXml As IXmlDocumentEx).GetDocBinding('SearchOptions', TXmlSearchParametersImpl) As IXmlSearchOptions;
End;

Class Function TXmlSearchOptions.CreateSearchOptions(Const AXmlString : String) : IXmlSearchOptions;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.Options := lXml.Options + [doNodeAutoIndent];
  lXml.LoadFromXML(AXmlString);
  Result := (lXml As IXmlDocumentEx).GetDocBinding('SearchOptions', TXmlSearchParametersImpl) As IXmlSearchOptions;
End;

(******************************************************************************)

Procedure TXmlSearchParametersImpl.AfterConstruction();
Begin
  FSearchImpl := Pointer(ISearchOptions(Self));
  FInterfaceState := isCreating;
  
  InHerited AfterConstruction();
End;

Procedure TXmlSearchParametersImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (ISearchOptions(FSearchImpl) <> ISearchOptions(Self)) And
     (ISearchOptions(FSearchImpl).InterfaceState <> isDestroying) Then
    With SearchImpl Do
    Begin
      Backward                     := ChildNodes['Backward'].AsBoolean;
      CaseSensitive                := ChildNodes['CaseSensitive'].AsBoolean;
      FromCaret                    := ChildNodes['FromCaret'].AsBoolean;
      SelectionOnly                := ChildNodes['SelectionOnly'].AsBoolean;
      TextAtCaret                  := ChildNodes['TextAtCaret'].AsBoolean;
      WholeWords                   := ChildNodes['WholeWords'].AsBoolean;
      SearchText                   := ChildNodes['SearchText'].AsString;
      SearchTextHistory.CommaText  := ChildNodes['SearchTextHistory'].AsString;
      ReplaceText                  := ChildNodes['ReplaceText'].AsString;
      ReplaceTextHistory.CommaText := ChildNodes['ReplaceTextHistory'].AsString;
    End;

  InHerited BeforeDestruction();
End;

Function TXmlSearchParametersImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfacestate;
End;

Function TXmlSearchParametersImpl.GetImplementor() : ISearchOptions;
Begin
  Result := ISearchOptions(FSearchImpl);
End;

Procedure TXmlSearchParametersImpl.Clear();
Begin
  ChildNodes['Backward'].NodeValue           := Null;
  ChildNodes['CaseSensitive'].NodeValue      := Null;
  ChildNodes['FromCaret'].NodeValue          := Null;
  ChildNodes['SelectionOnly'].NodeValue      := Null;
  ChildNodes['TextAtCarret'].NodeValue       := Null;
  ChildNodes['WholeWords'].NodeValue         := Null;
  ChildNodes['SearchText'].NodeValue         := Null;
  ChildNodes['SearchTextHistory'].NodeValue  := Null;
  ChildNodes['ReplaceText'].NodeValue        := Null;
  ChildNodes['ReplaceTextHistory'].NodeValue := Null;
End;

Procedure TXmlSearchParametersImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : ISearchOptions;
Begin
  If Supports(ASource, ISearchOptions, lSrc) Then
  Begin
    ChildNodes['Backward'].AsBoolean          := lSrc.Backward;
    ChildNodes['CaseSensitive'].AsBoolean     := lSrc.CaseSensitive;
    ChildNodes['FromCaret'].AsBoolean         := lSrc.FromCaret;
    ChildNodes['SelectionOnly'].AsBoolean     := lSrc.SelectionOnly;
    ChildNodes['TextAtCaret'].AsBoolean       := lSrc.TextAtCaret;
    ChildNodes['WholeWords'].AsBoolean        := lSrc.WholeWords;
    ChildNodes['SearchText'].AsString         := lSrc.SearchText;
    ChildNodes['SearchTextHistory'].AsString  := lSrc.SearchTextHistory.CommaText;
    ChildNodes['ReplaceText'].AsString        := lSrc.ReplaceText;
    ChildNodes['ReplaceTextHistory'].AsString := lSrc.ReplaceTextHistory.CommaText;

    If ASyncSource Then
      FSearchImpl := Pointer(lSrc);
  End;
End;

Function TXmlSearchParametersImpl.GetBackward() : Boolean;
Begin
  Result := ChildNodes['Backward'].AsBoolean;
End;

Procedure TXmlSearchParametersImpl.SetBackward(Const ABackward : Boolean);
Begin
  ChildNodes['Backward'].AsBoolean := ABackward;
End;

Function TXmlSearchParametersImpl.GetCaseSensitive() : Boolean;
Begin
  Result := ChildNodes['CaseSensitive'].AsBoolean;
End;

Procedure TXmlSearchParametersImpl.SetCaseSensitive(Const ACaseSensitive : Boolean);
Begin
  ChildNodes['CaseSensitive'].AsBoolean := ACaseSensitive;
End;

Function TXmlSearchParametersImpl.GetFromCaret() : Boolean;
Begin
  Result := ChildNodes['FromCaret'].AsBoolean;
End;

Procedure TXmlSearchParametersImpl.SetFromCaret(Const AFromCaret : Boolean);
Begin
  ChildNodes['FromCaret'].AsBoolean := AFromCaret;
End;

Function TXmlSearchParametersImpl.GetSelectionOnly() : Boolean;
Begin
  Result := ChildNodes['SelectionOnly'].AsBoolean;
End;

Procedure TXmlSearchParametersImpl.SetSelectionOnly(Const ASelectionOnly : Boolean);
Begin
  ChildNodes['SelectionOnly'].AsBoolean := ASelectionOnly;
End;

Function TXmlSearchParametersImpl.GetTextAtCaret() : Boolean;
Begin
  Result := ChildNodes['TextAtCaret'].AsBoolean;
End;

Procedure TXmlSearchParametersImpl.SetTextAtCaret(Const ATextAtCaret : Boolean);
Begin
  ChildNodes['TextAtCaret'].AsBoolean := ATextAtCaret;
End;

Function TXmlSearchParametersImpl.GetWholeWords() : Boolean;
Begin
  Result := ChildNodes['WholeWords'].AsBoolean;
End;

Procedure TXmlSearchParametersImpl.SetWholeWords(Const AWholeWords : Boolean);
Begin
  ChildNodes['WholeWords'].AsBoolean := AWholeWords;
End;

Function TXmlSearchParametersImpl.GetSearchText() : String;
Begin
  Result := ChildNodes['SearchText'].AsString;
End;

Procedure TXmlSearchParametersImpl.SetSearchText(Const ASearchText : String);
Begin
  ChildNodes['SearchText'].AsString := ASearchText;
End;

Function TXmlSearchParametersImpl.GetSearchTextHistory() : String;
Begin
  Result := ChildNodes['SearchTextHistory'].AsString;
End;

Procedure TXmlSearchParametersImpl.SetSearchTextHistory(Const ASearchTextHistory : String);
Begin
  ChildNodes['SearchTextHistory'].AsString := ASearchTextHistory;
End;

Function TXmlSearchParametersImpl.GetReplaceText() : String;
Begin
  Result := ChildNodes['ReplaceText'].AsString;
End;

Procedure TXmlSearchParametersImpl.SetReplaceText(Const AReplaceText : String);
Begin
  ChildNodes['ReplaceText'].AsString := AReplaceText;
End;

Function TXmlSearchParametersImpl.GetReplaceTextHistory() : String;
Begin
  Result := ChildNodes['ReplaceTextHistory'].AsString;
End;

Procedure TXmlSearchParametersImpl.SetReplaceTextHistory(Const AReplaceTextHistory : String);
Begin
  ChildNodes['ReplaceTextHistory'].AsString := AReplaceTextHistory;
End;

Function TXmlSearchParametersImpl.MyGetSearchTextHistory() : IHsStringListEx;
Begin
  Result := THsStringListEx.CreateList();
  Result.CommaText := ChildNodes['SearchTextHistory'].AsString;
End;

Procedure TXmlSearchParametersImpl.MySetSearchTextHistory(Const ASearchTextHistory : IHsStringListEx);
Begin
  ChildNodes['SearchTextHistory'].AsString := ASearchTextHistory.CommaText;
End;

Function TXmlSearchParametersImpl.MyGetReplaceTextHistory() : IHsStringListEx;
Begin
  Result := THsStringListEx.CreateList();
  Result.CommaText := ChildNodes['ReplaceTextHistory'].AsString;
End;

Procedure TXmlSearchParametersImpl.MySetReplaceTextHistory(Const AReplaceTextHistory : IHsStringListEx);
Begin
  ChildNodes['ReplaceTextHistory'].AsString := AReplaceTextHistory.CommaText;
End;

End.

