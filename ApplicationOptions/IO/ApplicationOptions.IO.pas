unit ApplicationOptions.IO;

interface
Uses
  HsStreamEx, ApplicationOptionsIntf;

Type  
  IApplicationOptionsIO = Interface(IApplicationOptions)
    ['{4B61686E-29A0-2112-9826-24716D8A6554}']
//    Function  GetAsString() : String;

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
    Procedure LoadFromFile(Const AFileName : String; Const AEncrypted : Boolean = False);

    Procedure SaveToIni(Const AFileName : String);
    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToJSon(Const AFileName : String);
    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String; Const AEncrypted : Boolean = False);

    Procedure DecryptStream(ASource, ATarget : IStreamEx);
    Procedure EncryptStream(ASource, ATarget : IStreamEx);
    
//    Property AsString : String Read GetAsString;
    Property AsXml    : String Read GetAsXml     Write SetAsXml;
    Property AsJSon   : String Read GetAsJSon    Write SetAsJSon;
    Property AsIni    : String Read GetAsIni     Write SetAsIni;

  End;

  TApplicationOptionsIO = Class(TObject)
  Public
    Class Function CreateAppicaltionOptions() : IApplicationOptionsIO; OverLoad;
    Class Function CreateAppicaltionOptions(AStream : IStreamEx) : IApplicationOptionsIO; OverLoad;
    Class Function CreateAppicaltionOptions(Const AFileName : String) : IApplicationOptionsIO; OverLoad;

  End;

implementation


Uses
  Classes, SysUtils, HsXmlDocEx, HsStringListEx, HsBase64, FastStringFuncs, 
  ApplicationOptionsImpl, ApplicationOptions.Bin, ApplicationOptions.Ini,
  ApplicationOptions.Xml, ApplicationOptions.JSon;

Type
  TApplicationOptionsIOImpl = Class(TApplicationOptions,
    IApplicationOptionsIO, IBinApplicationOptions, IIniApplicationOptions,
    IXmlApplicationOptions, IJSonApplicationOptions)
  Private
    Function GetBinImpl() : IBinApplicationOptions;
    Function GetIniImpl() : IIniApplicationOptions;
    Function GetXmlImpl() : IXmlApplicationOptions;
    Function GetJSonImpl() : IJSonApplicationOptions;

  Protected
    Property BinImpl  : IBinApplicationOptions  Read GetBinImpl  Implements IBinApplicationOptions;
    Property IniImpl  : IIniApplicationOptions  Read GetIniImpl  Implements IIniApplicationOptions;
    Property XmlImpl  : IXmlApplicationOptions  Read GetXmlImpl  Implements IXmlApplicationOptions;
    Property JSonImpl : IJSonApplicationOptions Read GetJSonImpl Implements IJSonApplicationOptions;

    Function  GetAsString() : String;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetAsJSon() : String;
    Procedure SetAsJSon(Const AJSonString : String);

    Function  GetAsIni() : String;
    Procedure SetAsIni(Const AIniString : String);

    Procedure DecryptStream(ASource, ATarget : IStreamEx);
    Procedure EncryptStream(ASource, ATarget : IStreamEx);

    Procedure LoadFromIni(Const AFileName : String);
    Procedure LoadFromXml(Const AFileName : String);
    Procedure LoadFromJSon(Const AFileName : String);
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String; Const AEncrypted : Boolean = False);

    Procedure SaveToIni(Const AFileName : String);
    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToJSon(Const AFileName : String);
    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String; Const AEncrypted : Boolean = False);

  End;

Class Function TApplicationOptionsIO.CreateAppicaltionOptions() : IApplicationOptionsIO;
Begin
  Result := TApplicationOptionsIOImpl.Create();
End;

Class Function TApplicationOptionsIO.CreateAppicaltionOptions(AStream : IStreamEx) : IApplicationOptionsIO;
Begin
  Result := TApplicationOptionsIOImpl.Create();
  Result.LoadFromStream(AStream);
End;

Class Function TApplicationOptionsIO.CreateAppicaltionOptions(Const AFileName : String) : IApplicationOptionsIO;
Var lStrStrm : IStringStreamEx;
    lExt     : String;
Begin
  lStrStrm := TStringStreamEx.Create();
  Try
    lStrStrm.LoadFromFile(AFileName);
    lExt := ExtractFileExt(AFileName);
    If SameText(lExt, '.Ini') Then
    Begin
      Result := CreateAppicaltionOptions();
      Result.AsIni := lStrStrm.DataString;
    End
    Else If SameText(lExt, '.Xml') Then
    Begin
      Result := CreateAppicaltionOptions();
      Result.AsXml := lStrStrm.DataString;
    End
    Else If SameText(lExt, '.JSon') Then
    Begin
      Result := CreateAppicaltionOptions();
      Result.AsJSon := lStrStrm.DataString;
    End
    Else
      Result := CreateAppicaltionOptions(lStrStrm);

    Finally
      lStrStrm := Nil;
  End;
End;

(******************************************************************************)

Function TApplicationOptionsIOImpl.GetBinImpl() : IBinApplicationOptions;
Begin
  Result := TBinApplicationOptions.CreateApplicationOptions();
  Result.Assign(Self);
End;

Function TApplicationOptionsIOImpl.GetIniImpl() : IIniApplicationOptions;
Begin
  Result := TIniApplicationOptions.CreateApplicationOptions();
  Result.Assign(Self);
End;

Function TApplicationOptionsIOImpl.GetXmlImpl() : IXmlApplicationOptions;
Begin
  Result := TXmlApplicationOptions.CreateApplicationOptions();
  Result.Assign(Self);
End;

Function TApplicationOptionsIOImpl.GetJSonImpl() : IJSonApplicationOptions;
Begin
  Result := TJSonApplicationOptions.CreateApplicationOptions();
  Result.Assign(Self);
End;

Function TApplicationOptionsIOImpl.GetAsString() : String;
Var lLst : IHsStringListEx;
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

Function TApplicationOptionsIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TApplicationOptionsIOImpl.SetAsXml(Const AXmlString : String);
Begin
  Assign(TXmlApplicationOptions.CreateApplicationOptions(AXmlString));
End;

Function TApplicationOptionsIOImpl.GetAsJSon() : String;
Begin
  Result := JSonImpl.AsJSon();
End;

Procedure TApplicationOptionsIOImpl.SetAsJSon(Const AJSonString : String);
Begin
  Assign(TJSonApplicationOptions.CreateApplicationOptions(AJSonString));
End;

Function TApplicationOptionsIOImpl.GetAsIni() : String;
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

Procedure TApplicationOptionsIOImpl.SetAsIni(Const AIniString : String);
Begin
  Assign(TIniApplicationOptions.CreateApplicationOptions(AIniString));
End;

Procedure TApplicationOptionsIOImpl.DecryptStream(ASource, ATarget : IStreamEx);
Var lLst       : IHsStringListEx;
    X          : Integer;
    lCurString : String;
    lBase64Str : String;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Text := ASource.ReadString(ASource.Size - ASource.Position);

    For X := 0 To lLst.Count - 1 Do
    Begin
      lCurString := lLst[X];

      While Length(lCurString) > 0 Do
      Begin
        lBase64Str := lBase64Str + Char(HexToInt(Copy(lCurString, 1, 2)));
        lCurString := Copy(lCurString, 3, Length(lCurString));
      End;
    End;

    Finally
      lLst := Nil;
  End;

  Base64DecodeToStream(lBase64Str, TStream(ATarget.InterfaceObject));
  ATarget.Position := 0;
End;

Procedure TApplicationOptionsIOImpl.EncryptStream(ASource, ATarget : IStreamEx);
Var lBytes   : Array Of Byte;
    lStrStrm : IStringStreamEx;
    lHexStr  : String;
Begin
  lHexStr := '';
  SetLength(lBytes, ASource.Size);
  ASource.Position := 0;
  ASource.ReadBuffer(lBytes[0], Length(lBytes));

  lStrStrm := TStringStreamEx.Create();
  Try
    Base64EncodeToStream(@lBytes[0], TStream(lStrStrm.InterfaceObject), Length(lBytes));

    lStrStrm.Position := 0;
    While Not lStrStrm.EoS Do
    Begin
      lHexStr := lHexStr + IntToHex(lStrStrm.ReadByte(), 2);
      If Length(lHexStr) Mod 32 = 0 Then
      Begin
        lHexStr := lHexStr + #$D#$A;
        ATarget.WriteString(lHexStr, False);
        lHexStr := '';
      End;
    End;

    If lHexStr <> '' Then
      ATarget.WriteString(lHexStr, False);

    Finally
      lStrStrm := Nil;
  End;
End;

Procedure TApplicationOptionsIOImpl.LoadFromIni(Const AFileName : String);
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

Procedure TApplicationOptionsIOImpl.LoadFromXml(Const AFileName : String);
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

Procedure TApplicationOptionsIOImpl.LoadFromJSon(Const AFileName : String);
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

Procedure TApplicationOptionsIOImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Assign(TBinApplicationOptions.CreateApplicationOptions(ASource));
End;

Procedure TApplicationOptionsIOImpl.LoadFromFile(Const AFileName : String; Const AEncrypted : Boolean = False);
Var lStrStrm : IStringStreamEx;
    lMemStrm : IMemoryStreamEx;
Begin
  If AEncrypted Then
  Begin
    lStrStrm := TStringStreamEx.Create();
    lMemStrm := TMemoryStreamEx.Create();
    Try
      lStrStrm.LoadFromFile(AFileName);

      DecryptStream(lStrStrm, lMemStrm);
      Assign(TBinApplicationOptions.CreateApplicationOptions(lMemStrm));

      Finally
        lStrStrm := Nil;
        lMemStrm := Nil;
    End;
  End
  Else
    Assign(TBinApplicationOptions.CreateApplicationOptions(AFileName));
End;

Procedure TApplicationOptionsIOImpl.SaveToIni(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsIni());
  Try
    lSStrm.SaveToFile(AFileName);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TApplicationOptionsIOImpl.SaveToXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsXml());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TApplicationOptionsIOImpl.SaveToJSon(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsJSon());
  Try
    lSStrm.SaveToFile(AFileName);
    
    Finally
      lSStrm := Nil;
  End;
End;

Procedure TApplicationOptionsIOImpl.SaveToStream(ATarget : IStreamEx);
Begin
  BinImpl.SaveToStream(ATarget);
End;

Procedure TApplicationOptionsIOImpl.SaveToFile(Const AFileName : String; Const AEncrypted : Boolean = False);
Var lMemStrm : IMemoryStreamEx;
    lStrStrm : IStringStreamEx;
Begin
  If AEncrypted Then
  Begin
    lMemStrm := TMemoryStreamEx.Create();
    lStrStrm := TStringStreamEx.Create();
    Try
      SaveToStream(lMemStrm);
      lMemStrm.Position := 0;

      EncryptStream(lMemStrm, lStrStrm);
      lStrStrm.SaveToFile(AFileName);

      Finally
        lMemStrm := Nil;
        lStrStrm := Nil;
    End;
  End
  Else
  Begin
    lMemStrm := TMemoryStreamEx.Create();
    Try
      SaveToStream(lMemStrm);
      lMemStrm.SaveToFile(AFileName);

      Finally
        lMemStrm := Nil;
    End;
  End;
End;

end.
