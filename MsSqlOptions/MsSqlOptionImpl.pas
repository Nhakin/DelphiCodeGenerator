unit MsSqlOptionImpl;

interface

Uses HsInterfaceEx, MsSqlOptionIntf;

Type
  TMsSqlOptions = Class(TInterfacedObjectEx, IMsSqlOptions)
  Private
    FServerName     : String;
    FLoginType      : Byte;
    FUserName       : String;
    FPassword       : String;
    FDataBaseName   : String;
    FInterfaceState : TInterfaceState;

  Protected
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

    Procedure Clear();

    Property ServerName   : String Read GetServerName   Write SetServerName;
    Property LoginType    : Byte   Read GetLoginType    Write SetLoginType;
    Property UserName     : String Read GetUserName     Write SetUserName;
    Property Password     : String Read GetPassword     Write SetPassword;
    Property DataBaseName : String Read GetDataBaseName Write SetDataBaseName;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;
    
  End;

implementation

Uses SysUtils, RTLConsts;

Procedure TMsSqlOptions.AfterConstruction();
Begin
  InHerited AfterConstruction();
  FInterfaceState := isCreating;
End;

Procedure TMsSqlOptions.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;
  InHerited BeforeDestruction();
End;

Function TMsSqlOptions.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TMsSqlOptions.Clear();
Begin
  FServerName   := '';
  FLoginType    := 0;
  FUserName     := '';
  FPassword     := '';
  FDataBaseName := '';
End;

Procedure TMsSqlOptions.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IMsSqlOptions;
Begin
  If Supports(ASource, IMsSqlOptions, lSrc) Then
  Begin
    FServerName   := lSrc.ServerName;
    FLoginType    := lSrc.LoginType;
    FUserName     := lSrc.UserName;
    FPassword     := lSrc.Password;
    FDataBaseName := lSrc.DataBaseName;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TMsSqlOptions.GetServerName() : String;
Begin
  Result := FServerName;
End;

Procedure TMsSqlOptions.SetServerName(Const AServerName : String);
Begin
  FServerName := AServerName;
End;

Function TMsSqlOptions.GetLoginType() : Byte;
Begin
  Result := FLoginType;
End;

Procedure TMsSqlOptions.SetLoginType(Const ALoginType : Byte);
Begin
  FLoginType := ALoginType;
End;

Function TMsSqlOptions.GetUserName() : String;
Begin
  Result := FUserName;
End;

Procedure TMsSqlOptions.SetUserName(Const AUserName : String);
Begin
  FUserName := AUserName;
End;

Function TMsSqlOptions.GetPassword() : String;
Begin
  Result := FPassword;
End;

Procedure TMsSqlOptions.SetPassword(Const APassword : String);
Begin
  FPassword := APassword;
End;

Function TMsSqlOptions.GetDataBaseName() : String;
Begin
  Result := FDataBaseName;
End;

Procedure TMsSqlOptions.SetDataBaseName(Const ADataBaseName : String);
Begin
  FDataBaseName := ADataBaseName;
End;

end.
