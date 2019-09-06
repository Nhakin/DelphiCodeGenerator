unit MsSqlOptions.Xml;

interface

Uses HsXmlDocEx, XmlDoc;

Type
  IXmlMsSqlOptions = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-8CA1-583408FFBAAA}']
    Function  GetServerName() : String;
    Procedure SetServerName(Const AServerName : String);

    Function  GetLoginType() : Byte;
    Procedure SetLoginType(Const ALoginType : Byte);

    Function  GetUserName() : String;
    Procedure SetUserName(Const AUserName : String);

    Function  GetPassword() : String;
    Procedure SetPassword(Const APassword : String);

    Function  GetDataBaseName() : String;
    Procedure SetDataBaseName(Const ADataBaseName : String);

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property ServerName   : String Read GetServerName   Write SetServerName;
    Property LoginType    : Byte   Read GetLoginType    Write SetLoginType;
    Property UserName     : String Read GetUserName     Write SetUserName;
    Property Password     : String Read GetPassword     Write SetPassword;
    Property DataBaseName : String Read GetDataBaseName Write SetDataBaseName;

  End;

  TXmlMsSqlOptions = Class(TObject)
  Public
    Class Function XmlNodeClass() : TXmlNodeClass;
    Class Function CreateMsSqlOptions() : IXmlMsSqlOptions; OverLoad;
    Class Function CreateMsSqlOptions(Const AXmlString : String) : IXmlMsSqlOptions; OverLoad;

  End;

implementation

Uses Variants, SysUtils, RtlConsts, XmlIntf, HsInterfaceEx, MsSqlOptionIntf;

Type
  TXmlMsSqlOptionsImpl = Class(TXmlNodeEx, IMsSqlOptions, IXmlMsSqlOptions)
  Private
    FSqlOptionsImpl : Pointer;
    FInterfaceState : TInterfaceState;

    Function GetSqlOptionsImpl() : IMsSqlOptions;

  Protected
    Property SqlOptionsImpl : IMsSqlOptions Read GetSqlOptionsImpl;

    Function  GetInterfaceState() : TInterfaceState;

    Function  GetServerName() : String;
    Procedure SetServerName(Const AServerName : String);

    Function  GetLoginType() : Byte;
    Procedure SetLoginType(Const ALoginType : Byte);

    Function  GetUserName() : String;
    Procedure SetUserName(Const AUserName : String);

    Function  GetPassword() : String;
    Procedure SetPassword(Const APassword : String);

    Function  GetDataBaseName() : String;
    Procedure SetDataBaseName(Const ADataBaseName : String);

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TXmlMsSqlOptions.XmlNodeClass() : TXmlNodeClass;
Begin
  Result := TXmlMsSqlOptionsImpl;
End;

Class Function TXmlMsSqlOptions.CreateMsSqlOptions() : IXmlMsSqlOptions;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.Options := lXml.Options + [doNodeAutoIndent];

  Result := (lXml As IXmlDocumentEx).GetDocBinding('MsSqlOptions', TXmlMsSqlOptionsImpl) As IXmlMsSqlOptions;
End;

Class Function TXmlMsSqlOptions.CreateMsSqlOptions(Const AXmlString : String) : IXmlMsSqlOptions;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.Options := lXml.Options + [doNodeAutoIndent];
  lXml.LoadFromXML(AXmlString);

  Result := (lXml As IXmlDocumentEx).GetDocBinding('MsSqlOptions', TXmlMsSqlOptionsImpl) As IXmlMsSqlOptions;
End;

Procedure TXmlMsSqlOptionsImpl.AfterConstruction();
Begin
  FSqlOptionsImpl := Pointer(IMsSqlOptions(Self));
  FInterfaceState := isCreating;

  InHerited AfterConstruction();
End;

Procedure TXmlMsSqlOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (IMsSqlOptions(FSqlOptionsImpl) <> IMsSqlOptions(Self)) And
     (IMsSqlOptions(FSqlOptionsImpl).InterfaceState <> isDestroying) Then
    With SqlOptionsImpl Do
    Begin
      ServerName   := ChildNodes['ServerName'].AsString;
      LoginType    := ChildNodes['LoginType'].AsByte;
      UserName     := ChildNodes['UserName'].AsString;
      Password     := ChildNodes['Password'].AsString;
      DataBaseName := ChildNodes['DataBaseName'].AsString;
    End;

  InHerited BeforeDestruction();
End;

Function TXmlMsSqlOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Function TXmlMsSqlOptionsImpl.GetSqlOptionsImpl() : IMsSqlOptions;
Begin
  Result := IMsSqlOptions(FSqlOptionsImpl);
End;

Procedure TXmlMsSqlOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IMsSqlOptions;
Begin
  If Supports(ASource, IMsSqlOptions, lSrc) Then
  Begin
    ChildNodes['ServerName'].NodeValue   := lSrc.ServerName;
    ChildNodes['LoginType'].NodeValue    := lSrc.LoginType;
    ChildNodes['UserName'].NodeValue     := lSrc.UserName;
    ChildNodes['Password'].NodeValue     := lSrc.Password;
    ChildNodes['DataBaseName'].NodeValue := lSrc.DataBaseName;
    
    If ASyncSource Then
      FSqlOptionsImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlMsSqlOptionsImpl.GetServerName() : String;
Begin
  Result := ChildNodes['ServerName'].AsString;
End;

Procedure TXmlMsSqlOptionsImpl.SetServerName(Const AServerName : String);
Begin
  ChildNodes['ServerName'].AsString := AServerName;
End;

Function TXmlMsSqlOptionsImpl.GetLoginType() : Byte;
Begin
  Result := ChildNodes['LoginType'].AsInteger;
End;

Procedure TXmlMsSqlOptionsImpl.SetLoginType(Const ALoginType : Byte);
Begin
  ChildNodes['LoginType'].AsInteger := ALoginType;
End;

Function TXmlMsSqlOptionsImpl.GetUserName() : String;
Begin
  Result := ChildNodes['UserName'].AsString;
End;

Procedure TXmlMsSqlOptionsImpl.SetUserName(Const AUserName : String);
Begin
  ChildNodes['UserName'].AsString := AUserName;
End;

Function TXmlMsSqlOptionsImpl.GetPassword() : String;
Begin
  Result := ChildNodes['Password'].AsString;
End;

Procedure TXmlMsSqlOptionsImpl.SetPassword(Const APassword : String);
Begin
  ChildNodes['Password'].AsString := APassword;
End;

Function TXmlMsSqlOptionsImpl.GetDataBaseName() : String;
Begin
  Result := ChildNodes['DataBaseName'].AsString;
End;

Procedure TXmlMsSqlOptionsImpl.SetDataBaseName(Const ADataBaseName : String);
Begin
  ChildNodes['DataBaseName'].AsString := ADataBaseName;
End;
  
end.
