unit MsSqlOptions.Ini;

interface

Uses HsInterfaceEx, HsIniFilesEx;

Type
  IIniMsSqlOptions = Interface(IMemIniFileEx)
    ['{4B61686E-29A0-2112-970D-1A1B4679D306}']
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

    Function GetInterfaceState() : TInterfaceState; 

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property ServerName     : String          Read GetServerName   Write SetServerName;
    Property LoginType      : Byte            Read GetLoginType    Write SetLoginType;
    Property UserName       : String          Read GetUserName     Write SetUserName;
    Property Password       : String          Read GetPassword     Write SetPassword;
    Property DataBaseName   : String          Read GetDataBaseName Write SetDataBaseName;
    Property InterfaceState : TInterfaceState Read GetInterfaceState;

  End;

  TIniMsSqlOptions = Class(TObject)
  Public
    Class Function CreateMsSqlOptions() : IIniMsSqlOptions; OverLoad;
    Class Function CreateMsSqlOptions(Const AIniString : String) : IIniMsSqlOptions; OverLoad;

  End;

implementation

Uses Classes, SysUtils, MsSqlOptionIntf;

Type
  TIniMsSqlOptionsImpl = Class(TMemIniFileEx, IMsSqlOptions, IIniMsSqlOptions)
  Private
    FSqlOptionsImpl : Pointer;
    FInterfaceState : TInterfaceState;

    Function GetSqlOptionsImpl() : IMsSqlOptions;

  Protected
    Property Implementor : TInterfaceExImplementor Read GetImplementor Implements
      IMsSqlOptions, IIniMsSqlOptions;

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

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TIniMsSqlOptions.CreateMsSqlOptions() : IIniMsSqlOptions;
Begin
  Result := TIniMsSqlOptionsImpl.Create('');
End;

Class Function TIniMsSqlOptions.CreateMsSqlOptions(Const AIniString : String) : IIniMsSqlOptions;
Var lLst : TStringList;
Begin
  Result := TIniMsSqlOptionsImpl.Create('');
  lLst := TStringList.Create();
  Try
    lLst.Text := AIniString;
    Result.SetStrings(lLst);
    
    Finally
      lLst.Free();
  End;
End;

(******************************************************************************)

Procedure TIniMsSqlOptionsImpl.AfterConstruction();
Begin
  FSqlOptionsImpl := Pointer(IMsSqlOptions(Self));
  FInterfaceState := isCreating;

  InHerited AfterConstruction();
End;

Procedure TIniMsSqlOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (IMsSqlOptions(FSqlOptionsImpl) <> IMsSqlOptions(Self)) And
     (IMsSqlOptions(FSqlOptionsImpl).InterfaceState <> isDestroying) Then
    With SqlOptionsImpl Do
    Begin
      ServerName   := ReadString('SqlOptions', 'ServerName', '');
      LoginType    := ReadInteger('SqlOptions', 'LoginType', 0);
      UserName     := ReadString('SqlOptions', 'UserName', '');
      Password     := ReadString('SqlOptions', 'Password', '');
      DataBaseName := ReadString('SqlOptions', 'DataBaseName', '');
    End;

  InHerited BeforeDestruction();
End;

Function TIniMsSqlOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Function TIniMsSqlOptionsImpl.GetSqlOptionsImpl() : IMsSqlOptions;
Begin
  Result := IMsSqlOptions(FSqlOptionsImpl);
End;

Procedure TIniMsSqlOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IMsSqlOptions;
Begin
  If Supports(ASource, IMsSqlOptions, lSrc) Then
  Begin
    WriteString('SqlOptions', 'ServerName', lSrc.ServerName);
    WriteInteger('SqlOptions', 'LoginType', lSrc.LoginType);
    WriteString('SqlOptions', 'UserName', lSrc.UserName);
    WriteString('SqlOptions', 'Password', lSrc.Password);
    WriteString('SqlOptions', 'DataBaseName',lSrc.DataBaseName);

    If ASyncSource Then
      FSqlOptionsImpl := Pointer(lSrc);
  End;
End;

Function TIniMsSqlOptionsImpl.GetServerName() : String;
Begin
  Result := ReadString('SqlOptions', 'ServerName', '');
End;

Procedure TIniMsSqlOptionsImpl.SetServerName(Const AServerName : String);
Begin
  WriteString('SqlOptions', 'ServerName', AServerName);
End;

Function TIniMsSqlOptionsImpl.GetLoginType() : Byte;
Begin
  Result := Byte(ReadInteger('SqlOptions', 'LoginType', 0));
End;

Procedure TIniMsSqlOptionsImpl.SetLoginType(Const ALoginType : Byte);
Begin
  WriteInteger('SqlOptions', 'LoginType', ALoginType);
End;

Function TIniMsSqlOptionsImpl.GetUserName() : String;
Begin
  Result := ReadString('SqlOptions', 'UserName', '');
End;

Procedure TIniMsSqlOptionsImpl.SetUserName(Const AUserName : String);
Begin
  WriteString('SqlOptions', 'UserName', AUserName);
End;

Function TIniMsSqlOptionsImpl.GetPassword() : String;
Begin
  Result := ReadString('SqlOptions', 'Password', '');
End;

Procedure TIniMsSqlOptionsImpl.SetPassword(Const APassword : String);
Begin
  WriteString('SqlOptions', 'Password', APassword);
End;

Function TIniMsSqlOptionsImpl.GetDataBaseName() : String;
Begin
  ReadString('SqlOptions', 'DataBaseName', '');
End;

Procedure TIniMsSqlOptionsImpl.SetDataBaseName(Const ADataBaseName : String);
Begin
  WriteString('SqlOptions', 'DataBaseName', ADataBaseName);
End;

end.
