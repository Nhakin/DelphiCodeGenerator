unit GlobalOptions.IO;

interface

Uses HsStreamEx, GlobalOptionsIntf;

Type
  IGlobalOptionsIO = Interface(IGlobalOptions)
    ['{4B61686E-29A0-2112-B94E-31367246CA47}']
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

  TGlobalOptionsIO = Class(TObject)
  Public
    Class Function CreateGlobalOptions() : IGlobalOptionsIO; OverLoad;
    Class Function CreateGlobalOptions(AStream : IStreamEx) : IGlobalOptionsIO; OverLoad;
    Class Function CreateGlobalOptions(Const AFileName : String) : IGlobalOptionsIO; OverLoad;

  End;

implementation

Uses
  Classes, SysUtils, HsXmlDocEx, HsStringListEx,
  GlobalOptionsImpl, GlobalOptions.Bin, GlobalOptions.Ini,
  GlobalOptions.Xml, GlobalOptions.JSon;

Type
  TGlobalOptionsIOImpl = Class(TGlobalOptions,
    IGlobalOptionsIO, IBinGlobalOptions, IIniGlobalOptions,
    IXmlGlobalOptions, IJSonGlobalOptions)
  Private
    Function GetBinImpl() : IBinGlobalOptions;
    Function GetIniImpl() : IIniGlobalOptions;
    Function GetXmlImpl() : IXmlGlobalOptions;
    Function GetJSonImpl() : IJSonGlobalOptions;

  Protected
    Property BinImpl  : IBinGlobalOptions  Read GetBinImpl  Implements IBinGlobalOptions;
    Property IniImpl  : IIniGlobalOptions  Read GetIniImpl  Implements IIniGlobalOptions;
    Property XmlImpl  : IXmlGlobalOptions  Read GetXmlImpl  Implements IXmlGlobalOptions;
    Property JSonImpl : IJSonGlobalOptions Read GetJSonImpl Implements IJSonGlobalOptions;

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

Class Function TGlobalOptionsIO.CreateGlobalOptions() : IGlobalOptionsIO;
Begin
  Result := TGlobalOptionsIOImpl.Create();
End;

Class Function TGlobalOptionsIO.CreateGlobalOptions(AStream : IStreamEx) : IGlobalOptionsIO;
Begin
  Result := TGlobalOptionsIOImpl.Create();
  Result.LoadFromStream(AStream);
End;

Class Function TGlobalOptionsIO.CreateGlobalOptions(Const AFileName : String) : IGlobalOptionsIO;
Var lStrStrm : IStringStreamEx;
    lExt     : String;
Begin
  lStrStrm := TStringStreamEx.Create();
  Try
    lStrStrm.LoadFromFile(AFileName);
    lExt := ExtractFileExt(AFileName);
    If SameText(lExt, '.Ini') Then
    Begin
      Result := CreateGlobalOptions();
      Result.AsIni := lStrStrm.DataString;
    End
    Else If SameText(lExt, '.Xml') Then
    Begin
      Result := CreateGlobalOptions();
      Result.AsXml := lStrStrm.DataString;
    End
    Else If SameText(lExt, '.JSon') Then
    Begin
      Result := CreateGlobalOptions();
      Result.AsJSon := lStrStrm.DataString;
    End
    Else
      Result := CreateGlobalOptions(lStrStrm);

    Finally
      lStrStrm := Nil;
  End;
End;

(******************************************************************************)

Function TGlobalOptionsIOImpl.GetBinImpl() : IBinGlobalOptions;
Begin
  Result := TBinGlobalOptions.CreateGlobalOptions();
  Result.Assign(Self);
End;

Function TGlobalOptionsIOImpl.GetIniImpl() : IIniGlobalOptions;
Begin
  Result := TIniGlobalOptions.CreateGlobalOptions();
  Result.Assign(Self);
End;

Function TGlobalOptionsIOImpl.GetXmlImpl() : IXmlGlobalOptions;
Begin
  Result := TXmlGlobalOptions.CreateGlobalOptions();
  Result.Assign(Self);
End;

Function TGlobalOptionsIOImpl.GetJSonImpl() : IJSonGlobalOptions;
Begin
  Result := TJSonGlobalOptions.CreateGlobalOptions();
  Result.Assign(Self);
End;

Function TGlobalOptionsIOImpl.GetAsString() : String;
Var lLst : IHsStringListEx;
    X    : Integer;
Begin
  lLst := THsStringListEx.CreateList();
  Try
{
    lLst.Add('ServerName : ' + ServerName);
    lLst.Add('LoginType : ' + IntToStr(LoginType));
    lLst.Add('UserName : ' + UserName);
    lLst.Add('Password : ' + Password);
    lLst.Add('DataBaseName : ' + DataBaseName);
}
    Result := lLst.Text;

    Finally
      lLst := Nil;
  End;
End;

Function TGlobalOptionsIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TGlobalOptionsIOImpl.SetAsXml(Const AXmlString : String);
Begin
  Assign(TXmlGlobalOptions.CreateGlobalOptions(AXmlString));
End;

Function TGlobalOptionsIOImpl.GetAsJSon() : String;
Begin
  Result := JSonImpl.AsJSon();
End;

Procedure TGlobalOptionsIOImpl.SetAsJSon(Const AJSonString : String);
Begin
  Assign(TJSonGlobalOptions.CreateGlobalOptions(AJSonString));
End;

Function TGlobalOptionsIOImpl.GetAsIni() : String;
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

Procedure TGlobalOptionsIOImpl.SetAsIni(Const AIniString : String);
Begin
  Assign(TIniGlobalOptions.CreateGlobalOptions(AIniString));
End;

Procedure TGlobalOptionsIOImpl.LoadFromIni(Const AFileName : String);
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

Procedure TGlobalOptionsIOImpl.LoadFromXml(Const AFileName : String);
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

Procedure TGlobalOptionsIOImpl.LoadFromJSon(Const AFileName : String);
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

Procedure TGlobalOptionsIOImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Assign(TBinGlobalOptions.CreateGlobalOptions(ASource));
End;

Procedure TGlobalOptionsIOImpl.LoadFromFile(Const AFileName : String);
Begin
  Assign(TBinGlobalOptions.CreateGlobalOptions(AFileName));
End;

Procedure TGlobalOptionsIOImpl.SaveToIni(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsIni());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TGlobalOptionsIOImpl.SaveToXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsXml());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TGlobalOptionsIOImpl.SaveToJSon(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsJSon());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TGlobalOptionsIOImpl.SaveToStream(ATarget : IStreamEx);
Begin
  BinImpl.SaveToStream(ATarget);
End;

Procedure TGlobalOptionsIOImpl.SaveToFile(Const AFileName : String);
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
