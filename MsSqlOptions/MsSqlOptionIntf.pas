unit MsSqlOptionIntf;

interface

Uses HsInterfaceEx;

Type
  IMsSqlOptions = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-BF63-925A85632C49}']
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
  
implementation

end.
