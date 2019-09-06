unit SearchOptionsIntf;

Interface

Uses Classes, SysUtils, RTLConsts, HsInterfaceEx, HsStringListEx;

Type
  ISearchOptions = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8A77-B20FD1382987}']
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

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
    
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
    Property InterfaceState     : TInterfaceState Read GetInterfaceState;

  End;

(******************************************************************************)

Implementation

End.

