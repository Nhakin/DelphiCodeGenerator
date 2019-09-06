unit SearchOptions.IO;

interface

Uses
  SearchOptionsIntf, HsStreamEx;

Type
  ISearchOptionsIO = Interface(ISearchOptions)
    ['{4B61686E-29A0-2112-936B-862CB6C6E88F}']
    Function  GetAsString() : String;
    
    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetAsJSon() : String;
    Procedure SetAsJSon(Const AJSonString : String);

    Function  GetAsIni() : String;
    Procedure SetAsIni(Const AIniString : String);
    
    Procedure LoadFromIni(Const AFileName : String);
    Procedure LoadFromXml(Const AFileName : String);
    Procedure LoadFromJSon(Const AFileName : String);
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToIni(Const AFileName : String);
    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToJSon(Const AFileName : String);
    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Property AsString : String Read GetAsString;
    Property AsXml    : String Read GetAsXml     Write SetAsXml;
    Property AsJSon   : String Read GetAsJSon    Write SetAsJSon;
    Property AsIni    : String Read GetAsIni     Write SetAsIni;

  End;

(******************************************************************************)

  TSearchOptionsIO = Class(TObject)
  Public
    Class Function CreateSearchOptions() : ISearchOptionsIO; OverLoad;
    Class Function CreateSearchOptions(AStream : IStreamEx) : ISearchOptionsIO; OverLoad;
    Class Function CreateSearchOptions(Const AFileName : String) : ISearchOptionsIO; OverLoad;

  End;

implementation

Uses
  Classes, SysUtils, HsXmlDocEx, HsStringListEx,
  SearchOptionsImpl, SearchOptions.Bin, SearchOptions.Ini,
  SearchOptions.Xml, SearchOptions.JSon;

Type
  TSearchOptionsIOImpl = Class(TSearchOptions,
    ISearchOptionsIO, IBinSearchOptions, IIniSearchOptions,
    IXmlSearchOptions, IJSonSearchOptions)
  Private
    Function GetBinImpl() : IBinSearchOptions;
    Function GetIniImpl() : IIniSearchOptions;
    Function GetXmlImpl() : IXmlSearchOptions;
    Function GetJSonImpl() : IJSonSearchOptions;

  Protected
    Property BinImpl  : IBinSearchOptions  Read GetBinImpl  Implements IBinSearchOptions;
    Property IniImpl  : IIniSearchOptions  Read GetIniImpl  Implements IIniSearchOptions;
    Property XmlImpl  : IXmlSearchOptions  Read GetXmlImpl  Implements IXmlSearchOptions;
    Property JSonImpl : IJSonSearchOptions Read GetJSonImpl Implements IJSonSearchOptions;

    Function  GetAsString() : String;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetAsJSon() : String;
    Procedure SetAsJSon(Const AJSonString : String);

    Function  GetAsIni() : String;
    Procedure SetAsIni(Const AIniString : String);

    Procedure LoadFromIni(Const AFileName : String);
    Procedure LoadFromXml(Const AFileName : String);
    Procedure LoadFromJSon(Const AFileName : String);
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToIni(Const AFileName : String);
    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToJSon(Const AFileName : String);
    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

  End;

Class Function TSearchOptionsIO.CreateSearchOptions() : ISearchOptionsIO;
Begin
  Result := TSearchOptionsIOImpl.Create();
End;

Class Function TSearchOptionsIO.CreateSearchOptions(AStream : IStreamEx) : ISearchOptionsIO;
Begin
  Result := TSearchOptionsIOImpl.Create();
  Result.LoadFromStream(AStream);
End;

Class Function TSearchOptionsIO.CreateSearchOptions(Const AFileName : String) : ISearchOptionsIO;
Var lStrStrm : IStringStreamEx;
    lExt     : String;
Begin
  lStrStrm := TStringStreamEx.Create();
  Try
    lStrStrm.LoadFromFile(AFileName);
    lExt := ExtractFileExt(AFileName);
    If SameText(lExt, '.Ini') Then
    Begin
      Result := CreateSearchOptions();
      Result.AsIni := lStrStrm.DataString;
    End
    Else If SameText(lExt, '.Xml') Then
    Begin
      Result := CreateSearchOptions();
      Result.AsXml := lStrStrm.DataString;
    End
    Else If SameText(lExt, '.JSon') Then
    Begin
      Result := CreateSearchOptions();
      Result.AsJSon := lStrStrm.DataString;
    End
    Else
      Result := CreateSearchOptions(lStrStrm);

    Finally
      lStrStrm := Nil;
  End;
End;

(******************************************************************************)

Function TSearchOptionsIOImpl.GetBinImpl() : IBinSearchOptions;
Begin
  Result := TBinSearchOptions.CreateSearchOptions();
  Result.Assign(Self);
End;

Function TSearchOptionsIOImpl.GetIniImpl() : IIniSearchOptions;
Begin
  Result := TIniSearchOptions.CreateSearchOptions();
  Result.Assign(Self);
End;

Function TSearchOptionsIOImpl.GetXmlImpl() : IXmlSearchOptions;
Begin
  Result := TXmlSearchOptions.CreateSearchOptions();
  Result.Assign(Self);
End;

Function TSearchOptionsIOImpl.GetJSonImpl() : IJSonSearchOptions;
Begin
  Result := TJSonSearchOptions.CreateSearchOptions();
  Result.Assign(Self);
End;

Function TSearchOptionsIOImpl.GetAsString() : String;
Var lLst : IHsStringListEx;
    X    : Integer;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Add('Backward : ' + BoolToStr(Backward, True));
    lLst.Add('CaseSensitive : ' + BoolToStr(CaseSensitive, True));
    lLst.Add('FromCaret : ' + BoolToStr(FromCaret, True));
    lLst.Add('SelectionOnly : ' + BoolToStr(SelectionOnly, True));
    lLst.Add('TextAtCaret : ' + BoolToStr(TextAtCaret, True));
    lLst.Add('SearchText : ' + SearchText);
    lLst.Add('SearchTextHistory : ');
    For X := 0 To SearchTextHistory.Count - 1 Do
      lLst.Add('  ' + SearchTextHistory[X]);
    lLst.Add('ReplaceText : ' + ReplaceText);
    lLst.Add('ReplaceTextHistory : ');
    For X := 0 To ReplaceTextHistory.Count - 1 Do
      lLst.Add('  ' + ReplaceTextHistory[X]);

    Result := lLst.Text;

    Finally
      lLst := Nil;
  End;
End;

Function TSearchOptionsIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TSearchOptionsIOImpl.SetAsXml(Const AXmlString : String);
Begin
  Assign(TXmlSearchOptions.CreateSearchOptions(AXmlString));
End;

Function TSearchOptionsIOImpl.GetAsJSon() : String;
Begin
  Result := JSonImpl.AsJSon();
End;

Procedure TSearchOptionsIOImpl.SetAsJSon(Const AJSonString : String);
Begin
  Assign(TJSonSearchOptions.CreateSearchOptions(AJSonString));
End;

Function TSearchOptionsIOImpl.GetAsIni() : String;
Var lLst : TStringList;
Begin
  lLst := TStringList.Create();
  Try
    IniImpl.GetStrings(lLst);
    Result := lLst.Text;

    Finally
      lLst.Free();
  End;
End;

Procedure TSearchOptionsIOImpl.SetAsIni(Const AIniString : String);
Begin
  Assign(TIniSearchOptions.CreateSearchOptions(AIniString));
End;

Procedure TSearchOptionsIOImpl.LoadFromIni(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create();
  Try
    lSStrm.LoadFromFile(AFileName);
    SetAsIni(lSStrm.DataString);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSearchOptionsIOImpl.LoadFromXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create();
  Try
    lSStrm.LoadFromFile(AFileName);
    SetAsXml(lSStrm.DataString);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSearchOptionsIOImpl.LoadFromJSon(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create();
  Try
    lSStrm.LoadFromFile(AFileName);
    SetAsJSon(lSStrm.DataString);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSearchOptionsIOImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Assign(TBinSearchOptions.CreateSearchOptions(ASource));
End;

Procedure TSearchOptionsIOImpl.LoadFromFile(Const AFileName : String);
Begin
  Assign(TBinSearchOptions.CreateSearchOptions(AFileName));
End;

Procedure TSearchOptionsIOImpl.SaveToIni(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsIni());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSearchOptionsIOImpl.SaveToXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsXml());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSearchOptionsIOImpl.SaveToJSon(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsJSon());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSearchOptionsIOImpl.SaveToStream(ATarget : IStreamEx);
Begin
  BinImpl.SaveToStream(ATarget);
End;

Procedure TSearchOptionsIOImpl.SaveToFile(Const AFileName : String);
Var lMemStrm : IMemoryStreamEx;
Begin
  lMemStrm := TMemoryStreamEx.Create();
  Try
    SaveToStream(lMemStrm);
    lMemStrm.SaveToFile(AFileName);

    Finally
      lMemStrm := Nil;
  End;
End;

end.
