unit HsStringListEx;

Interface

Uses Windows, Classes, HsInterfaceEx;

Type
  IHsStringListEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-815F-BEE64E0577DD}']
    //TStrings
    Function  GetCommaText() : String;
    Procedure SetCommaText(Const Value : String);
    Function  GetDelimiter() : Char;
    Procedure SetDelimiter(Const Value : Char);
    Function  GetDelimitedText() : String;
    Procedure SetDelimitedText(Const Value : String);
    Function  GetName(Index : Integer) : String;
    Function  GetQuoteChar() : Char;
    Procedure SetQuoteChar(Const Value : Char);
    Function  GetNameValueSeparator() : Char;
    Procedure SetNameValueSeparator(Const Value : Char);
    Function  GetValueFromIndex(Index : Integer) : String;
    Procedure SetValueFromIndex(Index : Integer; Const Value : String);
    Function  GetValue(Const Name : String) : String;
    Procedure SetValue(Const Name, Value : String);

    Function  GetCapacity() : Integer;
    Procedure SetCapacity(NewCapacity : Integer);
    Function  Get(Index : Integer) : String;
    Procedure Put(Index : Integer; Const S : String);
    Function  GetCount() : Integer;
    Function  GetObject(Index : Integer) : TObject;
    Procedure PutObject(Index : Integer; AObject : TObject);
    Function  GetTextStr() : String;
    Procedure SetTextStr(Const Value : String);

    Function  Add(Const S : String) : Integer;
    Function  AddObject(Const S : String; AObject : TObject) : Integer;
    Procedure Append(Const S : String);
    Procedure AddStrings(Strings : TStrings);
    Procedure BeginUpdate();
    Procedure Clear();
    Procedure Delete(Index : Integer);
    Procedure EndUpdate();
    Function  Equals(Strings : TStrings) : Boolean;
    Procedure Exchange(Index1, Index2 : Integer);
    Function  GetText() : Pchar;
    Function  IndexOf(Const S : String) : Integer;
    Function  IndexOfName(Const Name : String) : Integer;
    Function  IndexOfObject(AObject : TObject) : Integer;
    Procedure Insert(Index : Integer; Const S : String);
    Procedure InsertObject(Index : Integer; Const S : String; AObject : TObject);
    Procedure LoadFromFile(Const FileName : String);
    Procedure LoadFromStream(Stream : TStream);
    Procedure Move(CurIndex, NewIndex : Integer);
    Procedure SaveToFile(Const FileName : String);
    Procedure SaveToStream(Stream : TStream);
    Procedure SetText(Text : Pchar);

    Property Count              : Integer Read GetCount;
    Property Capacity           : Integer Read GetCapacity           Write SetCapacity;
    Property CommaText          : String  Read GetCommaText          Write SetCommaText;
    Property Delimiter          : Char    Read GetDelimiter          Write SetDelimiter;
    Property DelimitedText      : String  Read GetDelimitedText      Write SetDelimitedText;
    Property NameValueSeparator : Char    Read GetNameValueSeparator Write SetNameValueSeparator;
    Property QuoteChar          : Char    Read GetQuoteChar          Write SetQuoteChar;
    Property Text               : String  Read GetTextStr            Write SetTextStr;

    Property Names[Index: Integer]: String Read GetName;
    Property Objects[Index: Integer]: TObject Read GetObject Write PutObject;
    Property Values[Const Name: String]: String Read GetValue Write SetValue;
    Property ValueFromIndex[Index: Integer]: String Read GetValueFromIndex Write SetValueFromIndex;
    Property Strings[Index: Integer]: String Read Get Write Put; Default;

    //TStringList
    Function  GetDuplicates() : TDuplicates;
    Procedure SetDuplicates(Const Value : TDuplicates);
    Function  GetSorted() : Boolean;
    Procedure SetSorted(Const Value : Boolean);
    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Const Value : Boolean);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(Const AOnChange : TNotifyEvent);
    Function  GetOnChanging() : TNotifyEvent;
    Procedure SetOnChanging(Const AOnChanging : TNotifyEvent);

    Function  Find(Const S : String; Var Index : Integer) : Boolean;
    Procedure Sort();
    Procedure CustomSort(Compare : TStringListSortCompare);

    Property Duplicates    : TDuplicates  Read GetDuplicates    Write SetDuplicates;
    Property Sorted        : Boolean      Read GetSorted        Write SetSorted;
    Property CaseSensitive : Boolean      Read GetCaseSensitive Write SetCaseSensitive;
    Property OnChange      : TNotifyEvent Read GetOnChange      Write SetOnChange;
    Property OnChanging    : TNotifyEvent Read GetOnChanging    Write SetOnChanging;

    //Function AddInterface(Const S : String; AInterface : IInterface) : Integer;

  End;

  THsStringListEx = Class(TObject)
  Public
    Class Function CreateList() : IHsStringListEx;

  End;

Implementation

Uses SysUtils;

Type
  THsStringListExImpl = Class(TStringList, IHsStringListEx)
  Private
    FStringListImpl  : TInterfaceExImplementor;

    FOnChange        : TNotifyEvent;
    FOnChanging      : TNotifyEvent;

  Protected
    Procedure AfterConstruction(); OverRide;

    Function GetStringListImpl() : TInterfaceExImplementor;
    Property StringListImpl : TInterfaceExImplementor Read GetStringListImpl Implements IHsStringListEx;

    //IStringList
    Function  GetCommaText() : String;
    Procedure SetCommaText(Const Value : String);
    Function  GetDelimiter() : Char;
    Procedure SetDelimiter(Const Value : Char);
    Function  GetDelimitedText() : String;
    Procedure SetDelimitedText(Const Value : String);
    Function  GetName(Index : Integer): String;
    Function  GetQuoteChar() : Char;
    Procedure SetQuoteChar(Const Value : Char);
    Function  GetNameValueSeparator() : Char;
    Procedure SetNameValueSeparator(Const Value : Char);
    Function  GetValueFromIndex(Index : Integer): String;
    Procedure SetValueFromIndex(Index : Integer; Const Value: String);
    Function  GetValue(Const Name : String): String;
    Procedure SetValue(Const Name, Value :  String);
    Function  GetDuplicates() : TDuplicates;
    Procedure SetDuplicates(Const Value : TDuplicates);
    Function  GetSorted() : Boolean;
    Procedure SetSorted(Const Value : Boolean);
    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Const Value : Boolean);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(Const AOnChange : TNotifyEvent);
    Function  GetOnChanging() : TNotifyEvent;
    Procedure SetOnChanging(Const AOnChanging : TNotifyEvent);

  End;

Class Function THsStringListEx.CreateList() : IHsStringListEx;
Begin
  Result := THsStringListExImpl.Create();
End;

Procedure THsStringListExImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();
End;

Function THsStringListExImpl.GetStringListImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FStringListImpl) Then
    FStringListImpl := TInterfaceExImplementor.Create(Self);
  Result := FStringListImpl;
End;

Function THsStringListExImpl.GetCommaText() : String;
Begin
  Result := InHerited CommaText;
End;

Procedure THsStringListExImpl.SetCommaText(Const Value : String);
Begin
  InHerited CommaText := Value;
End;

Function THsStringListExImpl.GetDelimiter() : Char;
Begin
  Result := InHerited Delimiter;
End;

Procedure THsStringListExImpl.SetDelimiter(Const Value : Char);
Begin
  InHerited Delimiter := Value;
End;

Function THsStringListExImpl.GetDelimitedText() : String;
Begin
  Result := InHerited DelimitedText;
End;

Procedure THsStringListExImpl.SetDelimitedText(Const Value : String);
Begin
  InHerited DelimitedText := Value;
End;

Function THsStringListExImpl.GetName(Index : Integer) : String;
Begin
  Result := InHerited Names[Index];
End;

Function THsStringListExImpl.GetQuoteChar() : Char;
Begin
  Result := InHerited QuoteChar;
End;

Procedure THsStringListExImpl.SetQuoteChar(Const Value : Char);
Begin
  InHerited QuoteChar := Value;
End;

Function THsStringListExImpl.GetNameValueSeparator() : Char;
Begin
  Result := InHerited NameValueSeparator;
End;

Procedure THsStringListExImpl.SetNameValueSeparator(Const Value : Char);
Begin
  InHerited NameValueSeparator := Value;
End;

Function THsStringListExImpl.GetValueFromIndex(Index : Integer) : String;
Begin
  Result := InHerited ValueFromIndex[Index];
End;

Procedure THsStringListExImpl.SetValueFromIndex(Index : Integer; Const Value : String);
Begin
  InHerited ValueFromIndex[Index] := Value;
End;

Function THsStringListExImpl.GetValue(Const Name : String) : String;
Begin
  Result := InHerited Values[Name];
End;

Procedure THsStringListExImpl.SetValue(Const Name, Value : String);
Begin
  InHerited Values[Name] := Value;
End;

Function THsStringListExImpl.GetDuplicates() : TDuplicates;
Begin
  Result := InHerited Duplicates;
End;

Procedure THsStringListExImpl.SetDuplicates(Const Value : TDuplicates);
Begin
  InHerited Duplicates := Value;
End;

Function THsStringListExImpl.GetSorted() : Boolean;
Begin
  Result := InHerited Sorted;
End;

Procedure THsStringListExImpl.SetSorted(Const Value : Boolean);
Begin
  InHerited Sorted := Value;
End;

Function THsStringListExImpl.GetCaseSensitive() : Boolean;
Begin
  Result := InHerited CaseSensitive;
End;

Procedure THsStringListExImpl.SetCaseSensitive(Const Value : Boolean);
Begin
  InHerited CaseSensitive := Value;
End;

Function THsStringListExImpl.GetOnChange() : TNotifyEvent;
Begin
  Result := InHerited OnChange;
End;

Procedure THsStringListExImpl.SetOnChange(Const AOnChange : TNotifyEvent);
Begin
  InHerited OnChange := AOnChange;
End;

Function THsStringListExImpl.GetOnChanging() : TNotifyEvent;
Begin
  Result := InHerited OnChanging;
End;

Procedure THsStringListExImpl.SetOnChanging(Const AOnChanging : TNotifyEvent);
Begin
  InHerited OnChanging := AOnChanging;
End;

End.
