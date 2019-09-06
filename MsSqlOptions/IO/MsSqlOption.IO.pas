unit MsSqlOption.IO;

interface

Uses HsStreamEx, MsSqlOptionIntf;

Type
  IMsSqlOptionsIO = Interface(IMsSqlOptions)
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

  TMsSqlOptionsIO = Class(TObject)
  Public
    Class Function CreateMsSqlOptions() : IMsSqlOptionsIO; OverLoad;
    Class Function CreateMsSqlOptions(AStream : IStreamEx) : IMsSqlOptionsIO; OverLoad;
    Class Function CreateMsSqlOptions(Const AFileName : String) : IMsSqlOptionsIO; OverLoad;

  End;

implementation

Uses
  Classes, SysUtils, HsXmlDocEx, HsStringListEx,
  MsSqlOptionImpl, MsSqlOptions.Bin, MsSqlOptions.Ini,
  MsSqlOptions.Xml, MsSqlOptions.JSon;

Type
  TMsSqlOptionsIOImpl = Class(TMsSqlOptions,
    IMsSqlOptionsIO, IBinMsSqlOptions, IIniMsSqlOptions,
    IXmlMsSqlOptions, IJSonMsSqlOptions)
  Private
    Function GetBinImpl() : IBinMsSqlOptions;
    Function GetIniImpl() : IIniMsSqlOptions;
    Function GetXmlImpl() : IXmlMsSqlOptions;
    Function GetJSonImpl() : IJSonMsSqlOptions;

  Protected
    Property BinImpl  : IBinMsSqlOptions  Read GetBinImpl  Implements IBinMsSqlOptions;
    Property IniImpl  : IIniMsSqlOptions  Read GetIniImpl  Implements IIniMsSqlOptions;
    Property XmlImpl  : IXmlMsSqlOptions  Read GetXmlImpl  Implements IXmlMsSqlOptions;
    Property JSonImpl : IJSonMsSqlOptions Read GetJSonImpl Implements IJSonMsSqlOptions;

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

Class Function TMsSqlOptionsIO.CreateMsSqlOptions() : IMsSqlOptionsIO;
Begin
  Result := TMsSqlOptionsIOImpl.Create();
End;

Class Function TMsSqlOptionsIO.CreateMsSqlOptions(AStream : IStreamEx) : IMsSqlOptionsIO;
Begin
  Result := TMsSqlOptionsIOImpl.Create();
  Result.LoadFromStream(AStream);
End;

Class Function TMsSqlOptionsIO.CreateMsSqlOptions(Const AFileName : String) : IMsSqlOptionsIO;
Var lStrStrm : IStringStreamEx;
    lExt     : String;
Begin
  lStrStrm := TStringStreamEx.Create();
  Try
    lStrStrm.LoadFromFile(AFileName);
    lExt := ExtractFileExt(AFileName);
    If SameText(lExt, '.Ini') Then
    Begin
      Result := CreateMsSqlOptions();
      Result.AsIni := lStrStrm.DataString;
    End
    Else If SameText(lExt, '.Xml') Then
    Begin
      Result := CreateMsSqlOptions();
      Result.AsXml := lStrStrm.DataString;
    End
    Else If SameText(lExt, '.JSon') Then
    Begin
      Result := CreateMsSqlOptions();
      Result.AsJSon := lStrStrm.DataString;
    End
    Else
      Result := CreateMsSqlOptions(lStrStrm);

    Finally
      lStrStrm := Nil;
  End;
End;

(******************************************************************************)

Function TMsSqlOptionsIOImpl.GetBinImpl() : IBinMsSqlOptions;
Begin
  Result := TBinMsSqlOptions.CreateMsSqlOptions();
  Result.Assign(Self);
End;

Function TMsSqlOptionsIOImpl.GetIniImpl() : IIniMsSqlOptions;
Begin
  Result := TIniMsSqlOptions.CreateMsSqlOptions();
  Result.Assign(Self);
End;

Function TMsSqlOptionsIOImpl.GetXmlImpl() : IXmlMsSqlOptions;
Begin
  Result := TXmlMsSqlOptions.CreateMsSqlOptions();
  Result.Assign(Self);
End;

Function TMsSqlOptionsIOImpl.GetJSonImpl() : IJSonMsSqlOptions;
Begin
  Result := TJSonMsSqlOptions.CreateMsSqlOptions();
  Result.Assign(Self);
End;

Function TMsSqlOptionsIOImpl.GetAsString() : String;
Var lLst : IHsStringListEx;
    X    : Integer;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Add('ServerName : ' + ServerName);
    lLst.Add('LoginType : ' + IntToStr(LoginType));
    lLst.Add('UserName : ' + UserName);
    lLst.Add('Password : ' + Password);
    lLst.Add('DataBaseName : ' + DataBaseName);

    Result := lLst.Text;

    Finally
      lLst := Nil;
  End;
End;

Function TMsSqlOptionsIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TMsSqlOptionsIOImpl.SetAsXml(Const AXmlString : String);
Begin
  Assign(TXmlMsSqlOptions.CreateMsSqlOptions(AXmlString));
End;

Function TMsSqlOptionsIOImpl.GetAsJSon() : String;
Begin
  Result := JSonImpl.AsJSon();
End;

Procedure TMsSqlOptionsIOImpl.SetAsJSon(Const AJSonString : String);
Begin
  Assign(TJSonMsSqlOptions.CreateMsSqlOptions(AJSonString));
End;

Function TMsSqlOptionsIOImpl.GetAsIni() : String;
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

Procedure TMsSqlOptionsIOImpl.SetAsIni(Const AIniString : String);
Begin
  Assign(TIniMsSqlOptions.CreateMsSqlOptions(AIniString));
End;

Procedure TMsSqlOptionsIOImpl.LoadFromIni(Const AFileName : String);
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

Procedure TMsSqlOptionsIOImpl.LoadFromXml(Const AFileName : String);
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

Procedure TMsSqlOptionsIOImpl.LoadFromJSon(Const AFileName : String);
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

Procedure TMsSqlOptionsIOImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Assign(TBinMsSqlOptions.CreateMsSqlOptions(ASource));
End;

Procedure TMsSqlOptionsIOImpl.LoadFromFile(Const AFileName : String);
Begin
  Assign(TBinMsSqlOptions.CreateMsSqlOptions(AFileName));
End;

Procedure TMsSqlOptionsIOImpl.SaveToIni(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsIni());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TMsSqlOptionsIOImpl.SaveToXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsXml());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TMsSqlOptionsIOImpl.SaveToJSon(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsJSon());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TMsSqlOptionsIOImpl.SaveToStream(ATarget : IStreamEx);
Begin
  BinImpl.SaveToStream(ATarget);
End;

Procedure TMsSqlOptionsIOImpl.SaveToFile(Const AFileName : String);
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
