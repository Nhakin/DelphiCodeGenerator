unit MsSqlOptions.JSon;

interface

Uses HsInterfaceEx, HsJSonEx;

Type
  IJSonMsSqlOptions = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-985D-ED943858FDBC}']
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

    Function  GetInterfaceState() : TInterfaceState;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
    
    Property ServerName     : String          Read GetServerName   Write SetServerName;
    Property LoginType      : Byte            Read GetLoginType    Write SetLoginType;
    Property UserName       : String          Read GetUserName     Write SetUserName;
    Property Password       : String          Read GetPassword     Write SetPassword;
    Property DataBaseName   : String          Read GetDataBaseName Write SetDataBaseName;
    Property InterfaceState : TInterfaceState Read GetInterfaceState;

  End;

  TJSonMsSqlOptions = Class(TObject)
  Public
    Class Function HsJSonObjectClass() : THsJSonObjectClass;
    Class Function CreateMsSqlOptions() : IJSonMsSqlOptions; OverLoad;
    Class Function CreateMsSqlOptions(Const AJSonString : WideString) : IJSonMsSqlOptions; OverLoad;
  
  End;

implementation

Uses RTLConsts, SysUtils, MsSqlOptionIntf;

Type
  TJSonMsSqlOptionsImpl = Class(THsJSonObject, IMsSqlOptions, IJSonMsSqlOptions)
  Private
    FSqlOptionsImpl : Pointer;
    FInterfaceState : TInterfaceState;

    Function GetSqlOptionsImpl() : IMsSqlOptions;

  Protected
    Property SqlOptionsImpl : IMsSqlOptions Read GetSqlOptionsImpl;

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

    Function  GetInterfaceState() : TInterfaceState;

    Procedure Clear();

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TJSonMsSqlOptions.HsJSonObjectClass() : THsJSonObjectClass;
Begin
  Result := TJSonMsSqlOptionsImpl;
End;

Class Function TJSonMsSqlOptions.CreateMsSqlOptions() : IJSonMsSqlOptions;
Begin
  Result := TJSonMsSqlOptionsImpl.Create();
End;

Class Function TJSonMsSqlOptions.CreateMsSqlOptions(Const AJSonString : WideString) : IJSonMsSqlOptions;
Begin
  Result := THsJSonObject.GetDocBinding(AJSonString, TJSonMsSqlOptionsImpl) As IJSonMsSqlOptions;
End;

(******************************************************************************)
  
Procedure TJSonMsSqlOptionsImpl.AfterConstruction();
Begin
  FSqlOptionsImpl := Pointer(IMsSqlOptions(Self));
  FInterfaceState := isCreating;

  InHerited AfterConstruction();
End;

Procedure TJSonMsSqlOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (IMsSqlOptions(FSqlOptionsImpl) <> IMsSqlOptions(Self)) And
     (IMsSqlOptions(FSqlOptionsImpl).InterfaceState <> isDestroying) Then
    With SqlOptionsImpl Do
    Begin
      ServerName   := S['ServerName'];
      LoginType    := I['LoginType'];
      UserName     := S['UserName'];
      Password     := S['Password'];
      DataBaseName := S['DataBaseName'];
    End;

  InHerited BeforeDestruction();
End;

Function TJSonMsSqlOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Function TJSonMsSqlOptionsImpl.GetSqlOptionsImpl() : IMsSqlOptions;
Begin
  Result := IMsSqlOptions(FSqlOptionsImpl);
End;
  
Procedure TJSonMsSqlOptionsImpl.Clear();
Begin
  S['ServerName']     := '';
  I['LoginType']      := 0;
  S['UserName']       := '';
  S['Password']       := '';
  S['DataBaseName']   := '';
  S['InterfaceState'] := '';
End;

Procedure TJSonMsSqlOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IMsSqlOptions;
Begin
  If Supports(ASource, IMsSqlOptions, lSrc) Then
  Begin
    S['ServerName']   := lSrc.ServerName;
    I['LoginType']    := lSrc.LoginType;
    S['UserName']     := lSrc.UserName;
    S['Password']     := lSrc.Password;
    S['DataBaseName'] := lSrc.DataBaseName;

    If ASyncSource Then
      FSqlOptionsImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TJSonMsSqlOptionsImpl.GetServerName() : String;
Begin
  Result := S['ServerName'];
End;

Procedure TJSonMsSqlOptionsImpl.SetServerName(Const AServerName : String);
Begin
  S['ServerName'] := AServerName;
End;

Function TJSonMsSqlOptionsImpl.GetLoginType() : Byte;
Begin
  Result := I['LoginType'];
End;

Procedure TJSonMsSqlOptionsImpl.SetLoginType(Const ALoginType : Byte);
Begin
  I['LoginType'] := ALoginType;
End;

Function TJSonMsSqlOptionsImpl.GetUserName() : String;
Begin
  Result := S['UserName'];
End;

Procedure TJSonMsSqlOptionsImpl.SetUserName(Const AUserName : String);
Begin
  S['UserName'] := AUserName;
End;

Function TJSonMsSqlOptionsImpl.GetPassword() : String;
Begin
  Result := S['Password'];
End;

Procedure TJSonMsSqlOptionsImpl.SetPassword(Const APassword : String);
Begin
  S['Password'] := APassword;
End;

Function TJSonMsSqlOptionsImpl.GetDataBaseName() : String;
Begin
  Result := S['DataBaseName'];
End;

Procedure TJSonMsSqlOptionsImpl.SetDataBaseName(Const ADataBaseName : String);
Begin
  S['DataBaseName'] := ADataBaseName;
End;
  
end.
