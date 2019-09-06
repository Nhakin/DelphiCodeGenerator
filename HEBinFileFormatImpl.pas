Unit HEBinFileFormatImpl;

Interface

Uses xmldom, XMLDoc, XMLIntf;

Type
  IXMLBinaryFileFormat = Interface;
  IXMLDefineStruct = Interface;
  IXMLDefineStructList = Interface;
  IXMLStruct = Interface;
  IXMLStructList = Interface;
  IXMLUseStruct = Interface;
  IXMLUseStructList = Interface;
  IXMLFor = Interface;
  IXMLForList = Interface;
  IXMLIf = Interface;
  IXMLIfList = Interface;
  IXMLSwitch = Interface;
  IXMLSwitchList = Interface;
  IXMLCase = Interface;
  IXMLJump = Interface;
  IXMLJumpList = Interface;
  IXMLEval = Interface;
  IXMLEvalList = Interface;
  IXMLData = Interface;
  IXMLDataList = Interface;

  IXMLBinaryFileFormat = Interface(IXMLNode)
    ['{9656492F-C7AB-4E47-B7BA-2F2D80900A56}']
    Function GetName() : Widestring;
    Function GetWebSite() : Widestring;
    Function GetDefaultByteOrder() : Widestring;
    Function GetDefaultReadOnly() : Widestring;
    Function GetDefaultCharSet() : Widestring;
    Function GetAllowEditing() : Widestring;
    Function GetExpr() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetComment() : Widestring;

    Procedure SetName(Value : Widestring);
    Procedure SetWebSite(Value : Widestring);
    Procedure SetDefaultByteOrder(Value : Widestring);
    Procedure SetDefaultReadOnly(Value : Widestring);
    Procedure SetDefaultCharSet(Value : Widestring);
    Procedure SetAllowEditing(Value : Widestring);
    Procedure SetExpr(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Function GetDefineStructList() : IXMLDefineStructList;
    Function GetStructList() : IXMLStructList;
    Function GetUseStructList() : IXMLUseStructList;
    Function GetForList() : IXMLForList;
    Function GetIfList() : IXMLIfList;
    Function GetSwitchList() : IXMLSwitchList;
    Function GetJumpList() : IXMLJumpList;
    Function GetEvalList() : IXMLEvalList;
    Function GetDataList() : IXMLDataList;

    Property Name             : Widestring Read GetName             Write SetName;
    Property WebSite          : Widestring Read GetWebSite          Write SetWebSite;
    Property DefaultByteOrder : Widestring Read GetDefaultByteOrder Write SetDefaultByteOrder;
    Property DefaultReadOnly  : Widestring Read GetDefaultReadOnly  Write SetDefaultReadOnly;
    Property DefaultCharSet   : Widestring Read GetDefaultCharSet   Write SetDefaultCharSet;
    Property AllowEditing     : Widestring Read GetAllowEditing     Write SetAllowEditing;
    Property Expr             : Widestring Read GetExpr             Write SetExpr;
    Property TypeName         : Widestring Read GetTypeName         Write SetTypeName;
    Property Comment          : Widestring Read GetComment          Write SetComment;

    Property DefineStructList : IXMLDefineStructList Read GetDefineStructList;
    Property StructList       : IXMLStructList       Read GetStructList;
    Property UseStructList    : IXMLUseStructList    Read GetUseStructList;
    Property ForList          : IXMLForList          Read GetForList;
    Property IfList           : IXMLIfList           Read GetIfList;
    Property SwitchList       : IXMLSwitchList       Read GetSwitchList;
    Property JumpList         : IXMLJumpList         Read GetJumpList;
    Property EvalList         : IXMLEvalList         Read GetEvalList;
    Property DataList         : IXMLDataList         Read GetDataList;

  End;

  IXMLDefineStruct = Interface(IXMLNode)
    ['{3075294E-885B-434C-A5F4-6C7EFFD3A156}']
    Function GetExpr() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetPack() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStructList;
    Function GetUseStruct() : IXMLUseStructList;
    Function GetForProc() : IXMLForList;
    Function GetIfProc() : IXMLIfList;
    Function GetSwitch() : IXMLSwitchList;
    Function GetJump() : IXMLJumpList;
    Function GetEval() : IXMLEvalList;
    Function GetData() : IXMLDataList;

    Procedure SetExpr(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetPack(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Property Expr      : Widestring        Read GetExpr     Write SetExpr;
    Property TypeName  : Widestring        Read GetTypeName Write SetTypeName;
    Property Pack      : Widestring        Read GetPack     Write SetPack;
    Property Comment   : Widestring        Read GetComment  Write SetComment;
    Property Struct    : IXMLStructList    Read GetStruct;
    Property UseStruct : IXMLUseStructList Read GetUseStruct;
    Property ForProc   : IXMLForList       Read GetForProc;
    Property IfProc    : IXMLIfList        Read GetIfProc;
    Property Switch    : IXMLSwitchList    Read GetSwitch;
    Property Jump      : IXMLJumpList      Read GetJump;
    Property Eval      : IXMLEvalList      Read GetEval;
    Property Data      : IXMLDataList      Read GetData;

  End;

  IXMLDefineStructList = Interface(IXMLNodeCollection)
    ['{25A0B28B-4D9B-4903-81CA-3C1308CFCCE8}']
    Function Add() : IXMLDefineStruct;
    Function Insert(Const Index : Integer) : IXMLDefineStruct;
    Function GetItem(Index : Integer) : IXMLDefineStruct;
    Property Items[Index : Integer] : IXMLDefineStruct Read GetItem; Default;

  End;

  IXMLStruct = Interface(IXMLNode)
    ['{203CE014-20DE-47BE-A975-877198A2932D}']
    Function GetName() : Widestring;
    Function GetExpr() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetPack() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStructList;
    Function GetUseStruct() : IXMLUseStructList;
    Function GetForProc() : IXMLForList;
    Function GetIfProc() : IXMLIfList;
    Function GetSwitch() : IXMLSwitchList;
    Function GetJump() : IXMLJumpList;
    Function GetEval() : IXMLEvalList;
    Function GetData() : IXMLDataList;

    Procedure SetName(Value : Widestring);
    Procedure SetExpr(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetPack(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Property Name      : Widestring        Read GetName     Write SetName;
    Property Expr      : Widestring        Read GetExpr     Write SetExpr;
    Property TypeName  : Widestring        Read GetTypeName Write SetTypeName;
    Property Pack      : Widestring        Read GetPack     Write SetPack;
    Property Comment   : Widestring        Read GetComment  Write SetComment;
    Property Struct    : IXMLStructList    Read GetStruct;
    Property UseStruct : IXMLUseStructList Read GetUseStruct;
    Property ForProc   : IXMLForList       Read GetForProc;
    Property IfProc    : IXMLIfList        Read GetIfProc;
    Property Switch    : IXMLSwitchList    Read GetSwitch;
    Property Jump      : IXMLJumpList      Read GetJump;
    Property Eval      : IXMLEvalList      Read GetEval;
    Property Data      : IXMLDataList      Read GetData;

  End;

  IXMLStructList = Interface(IXMLNodeCollection)
    ['{7A1FDAF4-F95B-45C9-B364-2301CA0EA909}']
    Function Add() : IXMLStruct;
    Function Insert(Const Index : Integer) : IXMLStruct;
    Function GetItem(Index : Integer) : IXMLStruct;

    Property Items[Index : Integer] : IXMLStruct Read GetItem; Default;

  End;

  IXMLUseStruct = Interface(IXMLNode)
    ['{39C0CA39-F5F5-4EFB-A3D4-6E3887FBA6D6}']
    Function GetName() : Widestring;
    Function GetExpr() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetComment() : Widestring;

    Procedure SetName(Value : Widestring);
    Procedure SetExpr(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Property Name     : Widestring Read GetName     Write SetName;
    Property Expr     : Widestring Read GetExpr     Write SetExpr;
    Property TypeName : Widestring Read GetTypeName Write SetTypeName;
    Property Comment  : Widestring Read GetComment  Write SetComment;

  End;

  IXMLUseStructList = Interface(IXMLNodeCollection)
    ['{441A69F4-4797-41FC-960B-6A92D235D116}']
    Function Add() : IXMLUseStruct;
    Function Insert(Const Index : Integer) : IXMLUseStruct;
    Function GetItem(Index : Integer) : IXMLUseStruct;
    Property Items[Index : Integer] : IXMLUseStruct Read GetItem; Default;

  End;

  IXMLFor = Interface(IXMLNode)
    ['{778FF856-F77B-4FB1-8B7F-5DF8FE8C8735}']
    Function GetName() : Widestring;
    Function GetCount() : Widestring;
    Function GetStopTest() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStruct;
    Function GetUseStruct() : IXMLUseStruct;
    Function GetForProc() : IXMLFor;
    Function GetIfProc() : IXMLIf;
    Function GetSwitch() : IXMLSwitch;
    Function GetJump() : IXMLJump;
    Function GetEval() : IXMLEval;
    Function GetData() : IXMLData;

    Procedure SetName(Value : Widestring);
    Procedure SetCount(Value : Widestring);
    Procedure SetStopTest(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Property Name      : Widestring    Read GetName     Write SetName;
    Property Count     : Widestring    Read GetCount    Write SetCount;
    Property StopTest  : Widestring    Read GetStopTest Write SetStopTest;
    Property TypeName  : Widestring    Read GetTypeName Write SetTypeName;
    Property Comment   : Widestring    Read GetComment  Write SetComment;
    Property Struct    : IXMLStruct    Read GetStruct;
    Property UseStruct : IXMLUseStruct Read GetUseStruct;
    Property ForProc   : IXMLFor       Read GetForProc;
    Property IfProc    : IXMLIf        Read GetIfProc;
    Property Switch    : IXMLSwitch    Read GetSwitch;
    Property Jump      : IXMLJump      Read GetJump;
    Property Eval      : IXMLEval      Read GetEval;
    Property Data      : IXMLData      Read GetData;
    
  End;

  IXMLForList = Interface(IXMLNodeCollection)
    ['{D45BA522-49F8-4DB2-B7E3-B02D1A5BE7BF}']
    Function Add() : IXMLFor;
    Function Insert(Const Index : Integer) : IXMLFor;
    Function GetItem(Index : Integer) : IXMLFor;

    Property Items[Index : Integer] : IXMLFor Read GetItem; Default;

  End;

  IXMLIf = Interface(IXMLNode)
    ['{12A672AC-DD63-44F8-90B4-CFC94C3AB32C}']
    Function GetTest() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStruct;
    Function GetUseStruct() : IXMLUseStruct;
    Function GetForProc() : IXMLFor;
    Function GetIfProc() : IXMLIf;
    Function GetSwitch() : IXMLSwitch;
    Function GetJump() : IXMLJump;
    Function GetEval() : IXMLEval;
    Function GetData() : IXMLData;
    Function GetElseProc() : Widestring;

    Procedure SetTest(Value : Widestring);
    Procedure SetComment(Value : Widestring);
    Procedure SetElseProc(Value : Widestring);

    Property Test      : Widestring    Read GetTest     Write SetTest;
    Property Comment   : Widestring    Read GetComment  Write SetComment;
    Property Struct    : IXMLStruct    Read GetStruct;
    Property UseStruct : IXMLUseStruct Read GetUseStruct;
    Property ForProc   : IXMLFor       Read GetForProc;
    Property IfProc    : IXMLIf        Read GetIfProc;
    Property Switch    : IXMLSwitch    Read GetSwitch;
    Property Jump      : IXMLJump      Read GetJump;
    Property Eval      : IXMLEval      Read GetEval;
    Property Data      : IXMLData      Read GetData;
    Property ElseProc  : Widestring    Read GetElseProc Write SetElseProc;

  End;

  IXMLIfList = Interface(IXMLNodeCollection)
    ['{8FB55D60-D8BE-4E5C-ACEC-1C8E0E32F816}']
    Function Add : IXMLIf;
    Function Insert(Const Index : Integer) : IXMLIf;
    Function GetItem(Index : Integer) : IXMLIf;

    Property Items[Index: Integer]: IXMLIf Read GetItem; Default;

  End;

  IXMLSwitch = Interface(IXMLNodeCollection)
    ['{E1D2D625-C4FB-4A4E-9135-6E1D80279AE2}']
    Function GetTest() : Widestring;
    Function GetComment() : Widestring;
    Function GetCases(Index : Integer): IXMLCase;

    Procedure SetTest(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Function Add() : IXMLCase;
    Function Insert(Const Index : Integer) : IXMLCase;

    Property Test    : Widestring Read GetTest    Write SetTest;
    Property Comment : Widestring Read GetComment Write SetComment;
    Property Cases[Index : Integer] : IXMLCase Read GetCases; Default;

  End;

  IXMLSwitchList = Interface(IXMLNodeCollection)
    ['{6DE77FE1-23CA-4BC3-B6CB-6B441EEC4A42}']
    Function Add() : IXMLSwitch;
    Function Insert(Const Index : Integer) : IXMLSwitch;
    Function GetItem(Index : Integer) : IXMLSwitch;

    Property Items[Index: Integer]: IXMLSwitch Read GetItem; Default;
  End;

  IXMLCase = Interface(IXMLNode)
    ['{869997E2-5F74-4D0A-AC29-DB579EDD74BE}']
    Function GetRange() : Widestring;
    Function GetStruct() : IXMLStruct;
    Function GetUseStruct() : IXMLUseStruct;
    Function GetForProc() : IXMLFor;
    Function GetIfProc() : IXMLIf;
    Function GetSwitch() : IXMLSwitch;
    Function GetJump() : IXMLJump;
    Function GetEval() : IXMLEval;
    Function GetData() : IXMLData;

    Procedure SetRange(Value : Widestring);

    Property Range     : Widestring    Read GetRange Write SetRange;
    Property Struct    : IXMLStruct    Read GetStruct;
    Property UseStruct : IXMLUseStruct Read GetUseStruct;
    Property ForProc   : IXMLFor       Read GetForProc;
    Property IfProc    : IXMLIf        Read GetIfProc;
    Property Switch    : IXMLSwitch    Read GetSwitch;
    Property Jump      : IXMLJump      Read GetJump;
    Property Eval      : IXMLEval      Read GetEval;
    Property Data      : IXMLData      Read GetData;
    
  End;

  IXMLJump = Interface(IXMLNode)
    ['{207CCFA4-640C-411C-A81A-E656CBCC0E9B}']
    Function GetOffset() : Widestring;
    Function GetOrigin() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStruct;
    Function GetUseStruct() : IXMLUseStruct;
    Function GetForProc() : IXMLFor;
    Function GetIfProc() : IXMLIf;
    Function GetSwitch() : IXMLSwitch;
    Function GetJump() : IXMLJump;
    Function GetEval() : IXMLEval;
    Function GetData() : IXMLData;

    Procedure SetOffset(Value : Widestring);
    Procedure SetOrigin(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Property Offset    : Widestring    Read GetOffset  Write SetOffset;
    Property Origin    : Widestring    Read GetOrigin  Write SetOrigin;
    Property Comment   : Widestring    Read GetComment Write SetComment;
    Property Struct    : IXMLStruct    Read GetStruct;
    Property UseStruct : IXMLUseStruct Read GetUseStruct;
    Property ForProc   : IXMLFor       Read GetForProc;
    Property IfProc    : IXMLIf        Read GetIfProc;
    Property Switch    : IXMLSwitch    Read GetSwitch;
    Property Jump      : IXMLJump      Read GetJump;
    Property Eval      : IXMLEval      Read GetEval;
    Property Data      : IXMLData      Read GetData;
    
  End;

  IXMLJumpList = Interface(IXMLNodeCollection)
    ['{2CE2754B-38DD-459D-A6FA-73F3411B8EFE}']
    Function Add() : IXMLJump;
    Function Insert(Const Index : Integer) : IXMLJump;
    Function GetItem(Index : Integer) : IXMLJump;

    Property Items[Index: Integer]: IXMLJump Read GetItem; Default;

  End;

  IXMLEval = Interface(IXMLNode)
    ['{7C4D3376-150B-4117-B72D-C2917DA5D8FF}']
    Function GetExpr() : Widestring;
    Function GetDisplayError() : Widestring;
    Function GetDisplayResult() : Widestring;
    Function GetComment() : Widestring;

    Procedure SetExpr(Value : Widestring);
    Procedure SetDisplayError(Value : Widestring);
    Procedure SetDisplayResult(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Property Expr          : Widestring Read GetExpr          Write SetExpr;
    Property DisplayError  : Widestring Read GetDisplayError  Write SetDisplayError;
    Property DisplayResult : Widestring Read GetDisplayResult Write SetDisplayResult;
    Property Comment       : Widestring Read GetComment       Write SetComment;

  End;

  IXMLEvalList = Interface(IXMLNodeCollection)
    ['{1426A71A-70A7-40AC-A92D-A6BFCD422535}']
    Function Add() : IXMLEval;
    Function Insert(Const Index : Integer) : IXMLEval;
    Function GetItem(Index : Integer) : IXMLEval;

    Property Items[Index : Integer] : IXMLEval Read GetItem; Default;

  End;

  IXMLData = Interface(IXMLNode)
    ['{CB434279-270C-459C-90C3-AEAA218C09FE}']
    Function GetName() : Widestring;
    Function GetDataType() : Widestring;
    Function GetFormat() : Widestring;
    Function GetLen() : Widestring;
    Function GetBits() : Widestring;
    Function GetDirection() : Widestring;
    Function GetStraddle() : Widestring;
    Function GetByteOrder() : Widestring;
    Function GetReadOnly() : Widestring;
    Function GetDomain() : Widestring;
    Function GetHide() : Widestring;
    Function GetDisplay() : Widestring;
    Function GetUnits() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetComment() : Widestring;

    Procedure SetName(Value : Widestring);
    Procedure SetDataType(Value : Widestring);
    Procedure SetFormat(Value : Widestring);
    Procedure SetLen(Value : Widestring);
    Procedure SetBits(Value : Widestring);
    Procedure SetDirection(Value : Widestring);
    Procedure SetStraddle(Value : Widestring);
    Procedure SetByteOrder(Value : Widestring);
    Procedure SetReadOnly(Value : Widestring);
    Procedure SetDomain(Value : Widestring);
    Procedure SetHide(Value : Widestring);
    Procedure SetDisplay(Value : Widestring);
    Procedure SetUnits(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Property Name      : Widestring Read GetName      Write SetName;
    Property DataType  : Widestring Read GetDataType  Write SetDataType;
    Property Format    : Widestring Read GetFormat    Write SetFormat;
    Property Len       : Widestring Read GetLen       Write SetLen;
    Property Bits      : Widestring Read GetBits      Write SetBits;
    Property Direction : Widestring Read GetDirection Write SetDirection;
    Property Straddle  : Widestring Read GetStraddle  Write SetStraddle;
    Property ByteOrder : Widestring Read GetByteOrder Write SetByteOrder;
    Property ReadOnly  : Widestring Read GetReadOnly  Write SetReadOnly;
    Property Domain    : Widestring Read GetDomain    Write SetDomain;
    Property Hide      : Widestring Read GetHide      Write SetHide;
    Property Display   : Widestring Read GetDisplay   Write SetDisplay;
    Property Units     : Widestring Read GetUnits     Write SetUnits;
    Property TypeName  : Widestring Read GetTypeName  Write SetTypeName;
    Property Comment   : Widestring Read GetComment   Write SetComment;
    
  End;

  IXMLDataList = Interface(IXMLNodeCollection)
    ['{4B9C6E15-6314-4BB1-87D9-70DF6F23683F}']
    Function Add() : IXMLData;
    Function Insert(Const Index : Integer) : IXMLData;
    Function GetItem(Index : Integer) : IXMLData;

    Property Items[Index : Integer] : IXMLData Read GetItem; Default;

  End;

(******************************************************************************)

  TXMLBinaryFileFormat = Class(TXMLNode, IXMLBinaryFileFormat)
  Private
    FDefineStructList : IXMLDefineStructList;
    FStructList       : IXMLStructList;
    FUseStructList    : IXMLUseStructList;
    FForList          : IXMLForList;
    FIfList           : IXMLIfList;
    FSwitchList       : IXMLSwitchList;
    FJumpList         : IXMLJumpList;
    FEvalList         : IXMLEvalList;
    FDataList         : IXMLDataList;

  Protected
    Function GetName() : Widestring;
    Function GetWebSite() : Widestring;
    Function GetDefaultByteOrder() : Widestring;
    Function GetDefaultReadOnly() : Widestring;
    Function GetDefaultCharSet() : Widestring;
    Function GetAllowEditing() : Widestring;
    Function GetExpr() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetComment() : Widestring;

    Procedure SetName(Value : Widestring);
    Procedure SetWebSite(Value : Widestring);
    Procedure SetDefaultByteOrder(Value : Widestring);
    Procedure SetDefaultReadOnly(Value : Widestring);
    Procedure SetDefaultCharSet(Value : Widestring);
    Procedure SetAllowEditing(Value : Widestring);
    Procedure SetExpr(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetComment(Value : Widestring);

    Function GetDefineStructList() : IXMLDefineStructList;
    Function GetStructList() : IXMLStructList;
    Function GetUseStructList() : IXMLUseStructList;
    Function GetForList() : IXMLForList;
    Function GetIfList() : IXMLIfList;
    Function GetSwitchList() : IXMLSwitchList;
    Function GetJumpList() : IXMLJumpList;
    Function GetEvalList() : IXMLEvalList;
    Function GetDataList() : IXMLDataList;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLDefineStructType = Class(TXMLNode, IXMLDefineStruct)
  Private
    FStruct    : IXMLStructList;
    FUseStruct : IXMLUseStructList;
    FForProc   : IXMLForList;
    FIfProc    : IXMLIfList;
    FSwitch    : IXMLSwitchList;
    FJump      : IXMLJumpList;
    FEval      : IXMLEvalList;
    FData      : IXMLDataList;

  Protected
    Function GetExpr() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetPack() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStructList;
    Function GetUseStruct() : IXMLUseStructList;
    Function GetForProc() : IXMLForList;
    Function GetIfProc() : IXMLIfList;
    Function GetSwitch() : IXMLSwitchList;
    Function GetJump() : IXMLJumpList;
    Function GetEval() : IXMLEvalList;
    Function GetData() : IXMLDataList;

    Procedure SetExpr(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetPack(Value : Widestring);
    Procedure SetComment(Value : Widestring);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLDefineStructTypeList = Class(TXMLNodeCollection, IXMLDefineStructList)
  Protected
    Function Add() : IXMLDefineStruct;
    Function Insert(Const Index : Integer) : IXMLDefineStruct;
    Function GetItem(Index : Integer) : IXMLDefineStruct;

  End;

  TXMLStructType = Class(TXMLNode, IXMLStruct)
  Private
    FStruct    : IXMLStructList;
    FUseStruct : IXMLUseStructList;
    FForProc   : IXMLForList;
    FIfProc    : IXMLIfList;
    FSwitch    : IXMLSwitchList;
    FJump      : IXMLJumpList;
    FEval      : IXMLEvalList;
    FData      : IXMLDataList;

  Protected
    Function GetName() : Widestring;
    Function GetExpr() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetPack() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStructList;
    Function GetUseStruct() : IXMLUseStructList;
    Function GetForProc() : IXMLForList;
    Function GetIfProc() : IXMLIfList;
    Function GetSwitch() : IXMLSwitchList;
    Function GetJump() : IXMLJumpList;
    Function GetEval() : IXMLEvalList;
    Function GetData() : IXMLDataList;

    Procedure SetName(Value : Widestring);
    Procedure SetExpr(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetPack(Value : Widestring);
    Procedure SetComment(Value : Widestring);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLStructTypeList = Class(TXMLNodeCollection, IXMLStructList)
  Protected
    Function Add() : IXMLStruct;
    Function Insert(Const Index : Integer) : IXMLStruct;
    Function GetItem(Index : Integer) : IXMLStruct;

  End;

  TXMLUseStructType = Class(TXMLNode, IXMLUseStruct)
  Protected
    Function GetName() : Widestring;
    Function GetExpr() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetComment() : Widestring;

    Procedure SetName(Value : Widestring);
    Procedure SetExpr(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetComment(Value : Widestring);

  End;

  TXMLUseStructTypeList = Class(TXMLNodeCollection, IXMLUseStructList)
  Protected
    Function Add() : IXMLUseStruct;
    Function Insert(Const Index : Integer) : IXMLUseStruct;
    Function GetItem(Index : Integer) : IXMLUseStruct;

  End;

  TXMLForType = Class(TXMLNode, IXMLFor)
  Protected
    Function GetName() : Widestring;
    Function GetCount() : Widestring;
    Function GetStopTest() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStruct;
    Function GetUseStruct() : IXMLUseStruct;
    Function GetForProc() : IXMLFor;
    Function GetIfProc() : IXMLIf;
    Function GetSwitch() : IXMLSwitch;
    Function GetJump() : IXMLJump;
    Function GetEval() : IXMLEval;
    Function GetData() : IXMLData;

    Procedure SetName(Value : Widestring);
    Procedure SetCount(Value : Widestring);
    Procedure SetStopTest(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetComment(Value : Widestring);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLForTypeList = Class(TXMLNodeCollection, IXMLForList)
  Protected
    Function Add() : IXMLFor;
    Function Insert(Const Index : Integer) : IXMLFor;
    Function GetItem(Index : Integer) : IXMLFor;

  End;

  TXMLIfType = Class(TXMLNode, IXMLIf)
  Protected
    Function GetTest() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStruct;
    Function GetUseStruct() : IXMLUseStruct;
    Function GetForProc() : IXMLFor;
    Function GetIfProc() : IXMLIf;
    Function GetSwitch() : IXMLSwitch;
    Function GetJump() : IXMLJump;
    Function GetEval() : IXMLEval;
    Function GetData() : IXMLData;
    Function GetElseProc() : Widestring;

    Procedure SetTest(Value : Widestring);
    Procedure SetComment(Value : Widestring);
    Procedure SetElseProc(Value : Widestring);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLIfTypeList = Class(TXMLNodeCollection, IXMLIfList)
  Protected
    Function Add() : IXMLIf;
    Function Insert(Const Index : Integer) : IXMLIf;
    Function GetItem(Index : Integer) : IXMLIf;

  End;

  TXMLSwitchType = Class(TXMLNodeCollection, IXMLSwitch)
  Protected
    Function GetTest() : Widestring;
    Function GetComment() : Widestring;
    Function GetCases(Index : Integer) : IXMLCase;
    Procedure SetTest(Value : Widestring);
    Procedure SetComment(Value : Widestring);
    Function Add() : IXMLCase;
    Function Insert(Const Index : Integer) : IXMLCase;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLSwitchTypeList = Class(TXMLNodeCollection, IXMLSwitchList)
  Protected
    Function Add() : IXMLSwitch;
    Function Insert(Const Index : Integer) : IXMLSwitch;
    Function GetItem(Index : Integer) : IXMLSwitch;
    
  End;

  TXMLCaseType = Class(TXMLNode, IXMLCase)
  Protected
    Function GetRange() : Widestring;
    Function GetStruct() : IXMLStruct;
    Function GetUseStruct() : IXMLUseStruct;
    Function GetForProc() : IXMLFor;
    Function GetIfProc() : IXMLIf;
    Function GetSwitch() : IXMLSwitch;
    Function GetJump() : IXMLJump;
    Function GetEval() : IXMLEval;
    Function GetData() : IXMLData;

    Procedure SetRange(Value : Widestring);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLJumpType = Class(TXMLNode, IXMLJump)
  Protected
    Function GetOffset() : Widestring;
    Function GetOrigin() : Widestring;
    Function GetComment() : Widestring;
    Function GetStruct() : IXMLStruct;
    Function GetUseStruct() : IXMLUseStruct;
    Function GetForProc() : IXMLFor;
    Function GetIfProc() : IXMLIf;
    Function GetSwitch() : IXMLSwitch;
    Function GetJump() : IXMLJump;
    Function GetEval() : IXMLEval;
    Function GetData() : IXMLData;

    Procedure SetOffset(Value : Widestring);
    Procedure SetOrigin(Value : Widestring);
    Procedure SetComment(Value : Widestring);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLJumpTypeList = Class(TXMLNodeCollection, IXMLJumpList)
  Protected
    Function Add() : IXMLJump;
    Function Insert(Const Index : Integer) : IXMLJump;
    Function GetItem(Index : Integer) : IXMLJump;

  End;

  TXMLEvalType = Class(TXMLNode, IXMLEval)
  Protected
    Function GetExpr() : Widestring;
    Function GetDisplayError() : Widestring;
    Function GetDisplayResult() : Widestring;
    Function GetComment() : Widestring;

    Procedure SetExpr(Value : Widestring);
    Procedure SetDisplayError(Value : Widestring);
    Procedure SetDisplayResult(Value : Widestring);
    Procedure SetComment(Value : Widestring);

  End;

  TXMLEvalTypeList = Class(TXMLNodeCollection, IXMLEvalList)
  Protected
    Function Add() : IXMLEval;
    Function Insert(Const Index : Integer) : IXMLEval;
    Function GetItem(Index : Integer) : IXMLEval;

  End;

  TXMLDataType = Class(TXMLNode, IXMLData)
  Protected
    Function GetName() : Widestring;
    Function GetDataType() : Widestring;
    Function GetFormat() : Widestring;
    Function GetLen() : Widestring;
    Function GetBits() : Widestring;
    Function GetDirection() : Widestring;
    Function GetStraddle() : Widestring;
    Function GetByteOrder() : Widestring;
    Function GetReadOnly() : Widestring; OverLoad;
    Function GetDomain() : Widestring;
    Function GetHide() : Widestring;
    Function GetDisplay() : Widestring;
    Function GetUnits() : Widestring;
    Function GetTypeName() : Widestring;
    Function GetComment() : Widestring;

    Procedure SetName(Value : Widestring);
    Procedure SetDataType(Value : Widestring);
    Procedure SetFormat(Value : Widestring);
    Procedure SetLen(Value : Widestring);
    Procedure SetBits(Value : Widestring);
    Procedure SetDirection(Value : Widestring);
    Procedure SetStraddle(Value : Widestring);
    Procedure SetByteOrder(Value : Widestring);
    Procedure SetReadOnly(Value : Widestring); OverLoad;
    Procedure SetDomain(Value : Widestring);
    Procedure SetHide(Value : Widestring);
    Procedure SetDisplay(Value : Widestring);
    Procedure SetUnits(Value : Widestring);
    Procedure SetTypeName(Value : Widestring);
    Procedure SetComment(Value : Widestring);
    
  End;

  TXMLDataTypeList = Class(TXMLNodeCollection, IXMLDataList)
  Protected
    Function Add() : IXMLData;
    Function Insert(Const Index : Integer) : IXMLData;
    Function GetItem(Index : Integer) : IXMLData;
    
  End;

{ Global Functions }

Function GetBinaryFileFormat(Doc: IXMLDocument): IXMLBinaryFileFormat;
Function LoadBinaryFileFormat(Const FileName: Widestring): IXMLBinaryFileFormat;
Function NewBinaryFileFormat() : IXMLBinaryFileFormat;

Const
  TargetNamespace = '';

Implementation

{ Global Functions }

Function GetBinaryFileFormat(Doc: IXMLDocument): IXMLBinaryFileFormat;
Begin
  Result := Doc.GetDocBinding('binary_file_format', TXMLBinaryFileFormat, TargetNamespace) As IXMLBinaryFileFormat;
End;

Function LoadBinaryFileFormat(Const FileName: Widestring): IXMLBinaryFileFormat;
Begin
  Result := LoadXMLDocument(FileName).GetDocBinding('binary_file_format', TXMLBinaryFileFormat, TargetNamespace) As IXMLBinaryFileFormat;
End;

Function NewBinaryFileFormat() : IXMLBinaryFileFormat;
Begin
  Result := NewXMLDocument.GetDocBinding('binary_file_format', TXMLBinaryFileFormat, TargetNamespace) As IXMLBinaryFileFormat;
End;

{ TXMLBinary_file_formatType }
Procedure TXMLBinaryFileFormat.AfterConstruction;
Begin
  RegisterChildNode('define_struct', TXMLDefineStructType);
  RegisterChildNode('struct', TXMLStructType);
  RegisterChildNode('use_struct', TXMLUseStructType);
  RegisterChildNode('for', TXMLForType);
  RegisterChildNode('if', TXMLIfType);
  RegisterChildNode('switch', TXMLSwitchType);
  RegisterChildNode('jump', TXMLJumpType);
  RegisterChildNode('eval', TXMLEvalType);
  RegisterChildNode('data', TXMLDataType);

  FDefineStructList := CreateCollection(TXMLDefineStructTypeList, IXMLDefineStruct, 'define_struct') As IXMLDefineStructList;
  FStructList       := CreateCollection(TXMLStructTypeList, IXMLStruct, 'struct') As IXMLStructList;
  FUseStructList    := CreateCollection(TXMLUseStructTypeList, IXMLUseStruct, 'use_struct') As IXMLUseStructList;
  FForList          := CreateCollection(TXMLForTypeList, IXMLFor, 'for') As IXMLForList;
  FIfList           := CreateCollection(TXMLIfTypeList, IXMLIf, 'if') As IXMLIfList;
  FSwitchList       := CreateCollection(TXMLSwitchTypeList, IXMLSwitch, 'switch') As IXMLSwitchList;
  FJumpList         := CreateCollection(TXMLJumpTypeList, IXMLJump, 'jump') As IXMLJumpList;
  FEvalList         := CreateCollection(TXMLEvalTypeList, IXMLEval, 'eval') As IXMLEvalList;
  FDataList         := CreateCollection(TXMLDataTypeList, IXMLData, 'data') As IXMLDataList;

  InHerited;
End;

Function TXMLBinaryFileFormat.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLBinaryFileFormat.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLBinaryFileFormat.GetWebSite: Widestring;
Begin
  Result := AttributeNodes['web_site'].Text;
End;

Procedure TXMLBinaryFileFormat.SetWebSite(Value: Widestring);
Begin
  SetAttribute('web_site', Value);
End;

Function TXMLBinaryFileFormat.GetDefaultByteOrder: Widestring;
Begin
  Result := AttributeNodes['default_byte_order'].Text;
End;

Procedure TXMLBinaryFileFormat.SetDefaultByteOrder(Value: Widestring);
Begin
  SetAttribute('default_byte_order', Value);
End;

Function TXMLBinaryFileFormat.GetDefaultReadOnly: Widestring;
Begin
  Result := AttributeNodes['default_read_only'].Text;
End;

Procedure TXMLBinaryFileFormat.SetDefaultReadOnly(Value: Widestring);
Begin
  SetAttribute('default_read_only', Value);
End;

Function TXMLBinaryFileFormat.GetDefaultCharSet: Widestring;
Begin
  Result := AttributeNodes['default_char_set'].Text;
End;

Procedure TXMLBinaryFileFormat.SetDefaultCharSet(Value: Widestring);
Begin
  SetAttribute('default_char_set', Value);
End;

Function TXMLBinaryFileFormat.GetAllowEditing: Widestring;
Begin
  Result := AttributeNodes['allow_editing'].Text;
End;

Procedure TXMLBinaryFileFormat.SetAllowEditing(Value: Widestring);
Begin
  SetAttribute('allow_editing', Value);
End;

Function TXMLBinaryFileFormat.GetExpr: Widestring;
Begin
  Result := AttributeNodes['expr'].Text;
End;

Procedure TXMLBinaryFileFormat.SetExpr(Value: Widestring);
Begin
  SetAttribute('expr', Value);
End;

Function TXMLBinaryFileFormat.GetTypeName: Widestring;
Begin
  Result := AttributeNodes['type_name'].Text;
End;

Procedure TXMLBinaryFileFormat.SetTypeName(Value: Widestring);
Begin
  SetAttribute('type_name', Value);
End;

Function TXMLBinaryFileFormat.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLBinaryFileFormat.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

Function TXMLBinaryFileFormat.GetDefineStructList: IXMLDefineStructList;
Begin
  Result := FDefineStructList;
End;

Function TXMLBinaryFileFormat.GetStructList: IXMLStructList;
Begin
  Result := FStructList;
End;

Function TXMLBinaryFileFormat.GetUseStructList: IXMLUseStructList;
Begin
  Result := FUseStructList;
End;

Function TXMLBinaryFileFormat.GetForList: IXMLForList;
Begin
  Result := FForList;
End;

Function TXMLBinaryFileFormat.GetIfList: IXMLIfList;
Begin
  Result := FIfList;
End;

Function TXMLBinaryFileFormat.GetSwitchList: IXMLSwitchList;
Begin
  Result := FSwitchList;
End;

Function TXMLBinaryFileFormat.GetJumpList: IXMLJumpList;
Begin
  Result := FJumpList;
End;

Function TXMLBinaryFileFormat.GetEvalList: IXMLEvalList;
Begin
  Result := FEvalList;
End;

Function TXMLBinaryFileFormat.GetDataList: IXMLDataList;
Begin
  Result := FDataList;
End;

{ TXMLDefineStructType }
Procedure TXMLDefineStructType.AfterConstruction;
Begin
  RegisterChildNode('struct', TXMLStructType);
  RegisterChildNode('use_struct', TXMLUseStructType);
  RegisterChildNode('for', TXMLForType);
  RegisterChildNode('if', TXMLIfType);
  RegisterChildNode('switch', TXMLSwitchType);
  RegisterChildNode('jump', TXMLJumpType);
  RegisterChildNode('eval', TXMLEvalType);
  RegisterChildNode('data', TXMLDataType);

  FStruct    := CreateCollection(TXMLStructTypeList, IXMLStruct, 'struct') As IXMLStructList;
  FUseStruct := CreateCollection(TXMLUseStructTypeList, IXMLUseStruct, 'use_struct') As IXMLUseStructList;
  FForProc   := CreateCollection(TXMLForTypeList, IXMLFor, 'for') As IXMLForList;
  FIfProc    := CreateCollection(TXMLIfTypeList, IXMLIf, 'if') As IXMLIfList;
  FSwitch    := CreateCollection(TXMLSwitchTypeList, IXMLSwitch, 'switch') As IXMLSwitchList;
  FJump      := CreateCollection(TXMLJumpTypeList, IXMLJump, 'jump') As IXMLJumpList;
  FEval      := CreateCollection(TXMLEvalTypeList, IXMLEval, 'eval') As IXMLEvalList;
  FData      := CreateCollection(TXMLDataTypeList, IXMLData, 'data') As IXMLDataList;

  InHerited;
End;

Function TXMLDefineStructType.GetExpr: Widestring;
Begin
  Result := AttributeNodes['expr'].Text;
End;

Procedure TXMLDefineStructType.SetExpr(Value: Widestring);
Begin
  SetAttribute('expr', Value);
End;

Function TXMLDefineStructType.GetTypeName: Widestring;
Begin
  Result := AttributeNodes['type_name'].Text;
End;

Procedure TXMLDefineStructType.SetTypeName(Value: Widestring);
Begin
  SetAttribute('type_name', Value);
End;

Function TXMLDefineStructType.GetPack: Widestring;
Begin
  Result := AttributeNodes['pack'].Text;
End;

Procedure TXMLDefineStructType.SetPack(Value: Widestring);
Begin
  SetAttribute('pack', Value);
End;

Function TXMLDefineStructType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLDefineStructType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

Function TXMLDefineStructType.GetStruct: IXMLStructList;
Begin
  Result := FStruct;
End;

Function TXMLDefineStructType.GetUseStruct: IXMLUseStructList;
Begin
  Result := FUseStruct;
End;

Function TXMLDefineStructType.GetForProc: IXMLForList;
Begin
  Result := FForProc;
End;

Function TXMLDefineStructType.GetIfProc: IXMLIfList;
Begin
  Result := FIfProc;
End;

Function TXMLDefineStructType.GetSwitch: IXMLSwitchList;
Begin
  Result := FSwitch;
End;

Function TXMLDefineStructType.GetJump: IXMLJumpList;
Begin
  Result := FJump;
End;

Function TXMLDefineStructType.GetEval: IXMLEvalList;
Begin
  Result := FEval;
End;

Function TXMLDefineStructType.GetData: IXMLDataList;
Begin
  Result := FData;
End;

{ TXMLDefine_structTypeList }
Function TXMLDefineStructTypeList.Add: IXMLDefineStruct;
Begin
  Result := AddItem(-1) As IXMLDefineStruct;
End;

Function TXMLDefineStructTypeList.Insert(Const Index: Integer): IXMLDefineStruct;
Begin
  Result := AddItem(Index) As IXMLDefineStruct;
End;
Function TXMLDefineStructTypeList.GetItem(Index: Integer): IXMLDefineStruct;
Begin
  Result := List[Index] As IXMLDefineStruct;
End;

{ TXMLStructType }
Procedure TXMLStructType.AfterConstruction;
Begin
  RegisterChildNode('struct', TXMLStructType);
  RegisterChildNode('use_struct', TXMLUseStructType);
  RegisterChildNode('for', TXMLForType);
  RegisterChildNode('if', TXMLIfType);
  RegisterChildNode('switch', TXMLSwitchType);
  RegisterChildNode('jump', TXMLJumpType);
  RegisterChildNode('eval', TXMLEvalType);
  RegisterChildNode('data', TXMLDataType);

  FStruct    := CreateCollection(TXMLStructTypeList, IXMLStruct, 'struct') As IXMLStructList;
  FUseStruct := CreateCollection(TXMLUseStructTypeList, IXMLUseStruct, 'use_struct') As IXMLUseStructList;
  FForProc   := CreateCollection(TXMLForTypeList, IXMLFor, 'for') As IXMLForList;
  FIfProc    := CreateCollection(TXMLIfTypeList, IXMLIf, 'if') As IXMLIfList;
  FSwitch    := CreateCollection(TXMLSwitchTypeList, IXMLSwitch, 'switch') As IXMLSwitchList;
  FJump      := CreateCollection(TXMLJumpTypeList, IXMLJump, 'jump') As IXMLJumpList;
  FEval      := CreateCollection(TXMLEvalTypeList, IXMLEval, 'eval') As IXMLEvalList;
  FData      := CreateCollection(TXMLDataTypeList, IXMLData, 'data') As IXMLDataList;

  InHerited;
End;

Function TXMLStructType.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLStructType.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLStructType.GetExpr: Widestring;
Begin
  Result := AttributeNodes['expr'].Text;
End;

Procedure TXMLStructType.SetExpr(Value: Widestring);
Begin
  SetAttribute('expr', Value);
End;

Function TXMLStructType.GetTypeName: Widestring;
Begin
  Result := AttributeNodes['type_name'].Text;
End;

Procedure TXMLStructType.SetTypeName(Value: Widestring);
Begin
  SetAttribute('type_name', Value);
End;

Function TXMLStructType.GetPack: Widestring;
Begin
  Result := AttributeNodes['pack'].Text;
End;

Procedure TXMLStructType.SetPack(Value: Widestring);
Begin
  SetAttribute('pack', Value);
End;

Function TXMLStructType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLStructType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

Function TXMLStructType.GetStruct: IXMLStructList;
Begin
  Result := FStruct;
End;

Function TXMLStructType.GetUseStruct: IXMLUseStructList;
Begin
  Result := FUseStruct;
End;

Function TXMLStructType.GetForProc: IXMLForList;
Begin
  Result := FForProc;
End;

Function TXMLStructType.GetIfProc: IXMLIfList;
Begin
  Result := FIfProc;
End;

Function TXMLStructType.GetSwitch: IXMLSwitchList;
Begin
  Result := FSwitch;
End;

Function TXMLStructType.GetJump: IXMLJumpList;
Begin
  Result := FJump;
End;

Function TXMLStructType.GetEval: IXMLEvalList;
Begin
  Result := FEval;
End;

Function TXMLStructType.GetData: IXMLDataList;
Begin
  Result := FData;
End;

{ TXMLStructTypeList }
Function TXMLStructTypeList.Add: IXMLStruct;
Begin
  Result := AddItem(-1) As IXMLStruct;
End;

Function TXMLStructTypeList.Insert(Const Index: Integer): IXMLStruct;
Begin
  Result := AddItem(Index) As IXMLStruct;
End;
Function TXMLStructTypeList.GetItem(Index: Integer): IXMLStruct;
Begin
  Result := List[Index] As IXMLStruct;
End;

{ TXMLUse_structType }
Function TXMLUseStructType.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLUseStructType.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLUseStructType.GetExpr: Widestring;
Begin
  Result := AttributeNodes['expr'].Text;
End;

Procedure TXMLUseStructType.SetExpr(Value: Widestring);
Begin
  SetAttribute('expr', Value);
End;

Function TXMLUseStructType.GetTypeName: Widestring;
Begin
  Result := AttributeNodes['type_name'].Text;
End;

Procedure TXMLUseStructType.SetTypeName(Value: Widestring);
Begin
  SetAttribute('type_name', Value);
End;

Function TXMLUseStructType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLUseStructType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

{ TXMLUse_structTypeList }
Function TXMLUseStructTypeList.Add: IXMLUseStruct;
Begin
  Result := AddItem(-1) As IXMLUseStruct;
End;

Function TXMLUseStructTypeList.Insert(Const Index: Integer): IXMLUseStruct;
Begin
  Result := AddItem(Index) As IXMLUseStruct;
End;
Function TXMLUseStructTypeList.GetItem(Index: Integer): IXMLUseStruct;
Begin
  Result := List[Index] As IXMLUseStruct;
End;

{ TXMLForType }
Procedure TXMLForType.AfterConstruction;
Begin
  RegisterChildNode('struct', TXMLStructType);
  RegisterChildNode('use_struct', TXMLUseStructType);
  RegisterChildNode('for', TXMLForType);
  RegisterChildNode('if', TXMLIfType);
  RegisterChildNode('switch', TXMLSwitchType);
  RegisterChildNode('jump', TXMLJumpType);
  RegisterChildNode('eval', TXMLEvalType);
  RegisterChildNode('data', TXMLDataType);

  InHerited;
End;

Function TXMLForType.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLForType.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLForType.GetCount: Widestring;
Begin
  Result := AttributeNodes['count'].Text;
End;

Procedure TXMLForType.SetCount(Value: Widestring);
Begin
  SetAttribute('count', Value);
End;

Function TXMLForType.GetStopTest: Widestring;
Begin
  Result := AttributeNodes['stop_test'].Text;
End;

Procedure TXMLForType.SetStopTest(Value: Widestring);
Begin
  SetAttribute('stop_test', Value);
End;

Function TXMLForType.GetTypeName: Widestring;
Begin
  Result := AttributeNodes['type_name'].Text;
End;

Procedure TXMLForType.SetTypeName(Value: Widestring);
Begin
  SetAttribute('type_name', Value);
End;

Function TXMLForType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLForType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

Function TXMLForType.GetStruct: IXMLStruct;
Begin
  Result := ChildNodes['struct'] As IXMLStruct;
End;

Function TXMLForType.GetUseStruct: IXMLUseStruct;
Begin
  Result := ChildNodes['use_struct'] As IXMLUseStruct;
End;

Function TXMLForType.GetForProc: IXMLFor;
Begin
  Result := ChildNodes['for'] As IXMLFor;
End;

Function TXMLForType.GetIfProc: IXMLIf;
Begin
  Result := ChildNodes['if'] As IXMLIf;
End;

Function TXMLForType.GetSwitch: IXMLSwitch;
Begin
  Result := ChildNodes['switch'] As IXMLSwitch;
End;

Function TXMLForType.GetJump: IXMLJump;
Begin
  Result := ChildNodes['jump'] As IXMLJump;
End;

Function TXMLForType.GetEval: IXMLEval;
Begin
  Result := ChildNodes['eval'] As IXMLEval;
End;

Function TXMLForType.GetData: IXMLData;
Begin
  Result := ChildNodes['data'] As IXMLData;
End;

{ TXMLForTypeList }
Function TXMLForTypeList.Add: IXMLFor;
Begin
  Result := AddItem(-1) As IXMLFor;
End;

Function TXMLForTypeList.Insert(Const Index: Integer): IXMLFor;
Begin
  Result := AddItem(Index) As IXMLFor;
End;
Function TXMLForTypeList.GetItem(Index: Integer): IXMLFor;
Begin
  Result := List[Index] As IXMLFor;
End;

{ TXMLIfType }
Procedure TXMLIfType.AfterConstruction;
Begin
  RegisterChildNode('struct', TXMLStructType);
  RegisterChildNode('use_struct', TXMLUseStructType);
  RegisterChildNode('for', TXMLForType);
  RegisterChildNode('if', TXMLIfType);
  RegisterChildNode('switch', TXMLSwitchType);
  RegisterChildNode('jump', TXMLJumpType);
  RegisterChildNode('eval', TXMLEvalType);
  RegisterChildNode('data', TXMLDataType);

  InHerited;
End;

Function TXMLIfType.GetTest: Widestring;
Begin
  Result := AttributeNodes['test'].Text;
End;

Procedure TXMLIfType.SetTest(Value: Widestring);
Begin
  SetAttribute('test', Value);
End;

Function TXMLIfType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLIfType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

Function TXMLIfType.GetStruct: IXMLStruct;
Begin
  Result := ChildNodes['struct'] As IXMLStruct;
End;

Function TXMLIfType.GetUseStruct: IXMLUseStruct;
Begin
  Result := ChildNodes['use_struct'] As IXMLUseStruct;
End;

Function TXMLIfType.GetForProc: IXMLFor;
Begin
  Result := ChildNodes['for'] As IXMLFor;
End;

Function TXMLIfType.GetIfProc: IXMLIf;
Begin
  Result := ChildNodes['if'] As IXMLIf;
End;

Function TXMLIfType.GetSwitch: IXMLSwitch;
Begin
  Result := ChildNodes['switch'] As IXMLSwitch;
End;

Function TXMLIfType.GetJump: IXMLJump;
Begin
  Result := ChildNodes['jump'] As IXMLJump;
End;

Function TXMLIfType.GetEval: IXMLEval;
Begin
  Result := ChildNodes['eval'] As IXMLEval;
End;

Function TXMLIfType.GetData: IXMLData;
Begin
  Result := ChildNodes['data'] As IXMLData;
End;

Function TXMLIfType.GetElseProc: Widestring;
Begin
  Result := ChildNodes['else'].Text;
End;

Procedure TXMLIfType.SetElseProc(Value: Widestring);
Begin
  ChildNodes['else'].NodeValue := Value;
End;

{ TXMLIfTypeList }
Function TXMLIfTypeList.Add: IXMLIf;
Begin
  Result := AddItem(-1) As IXMLIf;
End;

Function TXMLIfTypeList.Insert(Const Index: Integer): IXMLIf;
Begin
  Result := AddItem(Index) As IXMLIf;
End;

Function TXMLIfTypeList.GetItem(Index: Integer): IXMLIf;
Begin
  Result := List[Index] As IXMLIf;
End;

{ TXMLSwitchType }
Procedure TXMLSwitchType.AfterConstruction;
Begin
  RegisterChildNode('case', TXMLCaseType);
  ItemTag := 'case';
  ItemInterface := IXMLCase;

  InHerited;
End;

Function TXMLSwitchType.GetTest: Widestring;
Begin
  Result := AttributeNodes['test'].Text;
End;

Procedure TXMLSwitchType.SetTest(Value: Widestring);
Begin
  SetAttribute('test', Value);
End;

Function TXMLSwitchType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLSwitchType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

Function TXMLSwitchType.GetCases(Index: Integer): IXMLCase;
Begin
  Result := List[Index] As IXMLCase;
End;

Function TXMLSwitchType.Add: IXMLCase;
Begin
  Result := AddItem(-1) As IXMLCase;
End;

Function TXMLSwitchType.Insert(Const Index: Integer): IXMLCase;
Begin
  Result := AddItem(Index) As IXMLCase;
End;

{ TXMLSwitchTypeList }
Function TXMLSwitchTypeList.Add: IXMLSwitch;
Begin
  Result := AddItem(-1) As IXMLSwitch;
End;

Function TXMLSwitchTypeList.Insert(Const Index: Integer): IXMLSwitch;
Begin
  Result := AddItem(Index) As IXMLSwitch;
End;
Function TXMLSwitchTypeList.GetItem(Index: Integer): IXMLSwitch;
Begin
  Result := List[Index] As IXMLSwitch;
End;

{ TXMLCaseType }
Procedure TXMLCaseType.AfterConstruction;
Begin
  RegisterChildNode('struct', TXMLStructType);
  RegisterChildNode('use_struct', TXMLUseStructType);
  RegisterChildNode('for', TXMLForType);
  RegisterChildNode('if', TXMLIfType);
  RegisterChildNode('switch', TXMLSwitchType);
  RegisterChildNode('jump', TXMLJumpType);
  RegisterChildNode('eval', TXMLEvalType);
  RegisterChildNode('data', TXMLDataType);

  InHerited;
End;

Function TXMLCaseType.GetRange: Widestring;
Begin
  Result := AttributeNodes['range'].Text;
End;

Procedure TXMLCaseType.SetRange(Value: Widestring);
Begin
  SetAttribute('range', Value);
End;

Function TXMLCaseType.GetStruct: IXMLStruct;
Begin
  Result := ChildNodes['struct'] As IXMLStruct;
End;

Function TXMLCaseType.GetUseStruct: IXMLUseStruct;
Begin
  Result := ChildNodes['use_struct'] As IXMLUseStruct;
End;

Function TXMLCaseType.GetForProc: IXMLFor;
Begin
  Result := ChildNodes['for'] As IXMLFor;
End;

Function TXMLCaseType.GetIfProc: IXMLIf;
Begin
  Result := ChildNodes['if'] As IXMLIf;
End;

Function TXMLCaseType.GetSwitch: IXMLSwitch;
Begin
  Result := ChildNodes['switch'] As IXMLSwitch;
End;

Function TXMLCaseType.GetJump: IXMLJump;
Begin
  Result := ChildNodes['jump'] As IXMLJump;
End;

Function TXMLCaseType.GetEval: IXMLEval;
Begin
  Result := ChildNodes['eval'] As IXMLEval;
End;

Function TXMLCaseType.GetData: IXMLData;
Begin
  Result := ChildNodes['data'] As IXMLData;
End;

{ TXMLJumpType }
Procedure TXMLJumpType.AfterConstruction;
Begin
  RegisterChildNode('struct', TXMLStructType);
  RegisterChildNode('use_struct', TXMLUseStructType);
  RegisterChildNode('for', TXMLForType);
  RegisterChildNode('if', TXMLIfType);
  RegisterChildNode('switch', TXMLSwitchType);
  RegisterChildNode('jump', TXMLJumpType);
  RegisterChildNode('eval', TXMLEvalType);
  RegisterChildNode('data', TXMLDataType);
  
  InHerited;
End;

Function TXMLJumpType.GetOffset: Widestring;
Begin
  Result := AttributeNodes['offset'].Text;
End;

Procedure TXMLJumpType.SetOffset(Value: Widestring);
Begin
  SetAttribute('offset', Value);
End;

Function TXMLJumpType.GetOrigin: Widestring;
Begin
  Result := AttributeNodes['origin'].Text;
End;

Procedure TXMLJumpType.SetOrigin(Value: Widestring);
Begin
  SetAttribute('origin', Value);
End;

Function TXMLJumpType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLJumpType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

Function TXMLJumpType.GetStruct: IXMLStruct;
Begin
  Result := ChildNodes['struct'] As IXMLStruct;
End;

Function TXMLJumpType.GetUseStruct: IXMLUseStruct;
Begin
  Result := ChildNodes['use_struct'] As IXMLUseStruct;
End;

Function TXMLJumpType.GetForProc: IXMLFor;
Begin
  Result := ChildNodes['for'] As IXMLFor;
End;

Function TXMLJumpType.GetIfProc: IXMLIf;
Begin
  Result := ChildNodes['if'] As IXMLIf;
End;

Function TXMLJumpType.GetSwitch: IXMLSwitch;
Begin
  Result := ChildNodes['switch'] As IXMLSwitch;
End;

Function TXMLJumpType.GetJump: IXMLJump;
Begin
  Result := ChildNodes['jump'] As IXMLJump;
End;

Function TXMLJumpType.GetEval: IXMLEval;
Begin
  Result := ChildNodes['eval'] As IXMLEval;
End;

Function TXMLJumpType.GetData: IXMLData;
Begin
  Result := ChildNodes['data'] As IXMLData;
End;

{ TXMLJumpTypeList }
Function TXMLJumpTypeList.Add: IXMLJump;
Begin
  Result := AddItem(-1) As IXMLJump;
End;

Function TXMLJumpTypeList.Insert(Const Index: Integer): IXMLJump;
Begin
  Result := AddItem(Index) As IXMLJump;
End;

Function TXMLJumpTypeList.GetItem(Index: Integer): IXMLJump;
Begin
  Result := List[Index] As IXMLJump;
End;

{ TXMLEvalType }
Function TXMLEvalType.GetExpr: Widestring;
Begin
  Result := AttributeNodes['expr'].Text;
End;

Procedure TXMLEvalType.SetExpr(Value: Widestring);
Begin
  SetAttribute('expr', Value);
End;

Function TXMLEvalType.GetDisplayError: Widestring;
Begin
  Result := AttributeNodes['display_error'].Text;
End;

Procedure TXMLEvalType.SetDisplayError(Value: Widestring);
Begin
  SetAttribute('display_error', Value);
End;

Function TXMLEvalType.GetDisplayResult: Widestring;
Begin
  Result := AttributeNodes['display_result'].Text;
End;

Procedure TXMLEvalType.SetDisplayResult(Value: Widestring);
Begin
  SetAttribute('display_result', Value);
End;

Function TXMLEvalType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLEvalType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

{ TXMLEvalTypeList }
Function TXMLEvalTypeList.Add: IXMLEval;
Begin
  Result := AddItem(-1) As IXMLEval;
End;

Function TXMLEvalTypeList.Insert(Const Index: Integer): IXMLEval;
Begin
  Result := AddItem(Index) As IXMLEval;
End;

Function TXMLEvalTypeList.GetItem(Index: Integer): IXMLEval;
Begin
  Result := List[Index] As IXMLEval;
End;

{ TXMLDataType }
Function TXMLDataType.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLDataType.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLDataType.GetDataType: Widestring;
Begin
  Result := AttributeNodes['type'].Text;
End;

Procedure TXMLDataType.SetDataType(Value: Widestring);
Begin
  SetAttribute('type', Value);
End;

Function TXMLDataType.GetFormat: Widestring;
Begin
  Result := AttributeNodes['format'].Text;
End;

Procedure TXMLDataType.SetFormat(Value: Widestring);
Begin
  SetAttribute('format', Value);
End;

Function TXMLDataType.GetLen: Widestring;
Begin
  Result := AttributeNodes['len'].Text;
End;

Procedure TXMLDataType.SetLen(Value: Widestring);
Begin
  SetAttribute('len', Value);
End;

Function TXMLDataType.GetBits: Widestring;
Begin
  Result := AttributeNodes['bits'].Text;
End;

Procedure TXMLDataType.SetBits(Value: Widestring);
Begin
  SetAttribute('bits', Value);
End;

Function TXMLDataType.GetDirection: Widestring;
Begin
  Result := AttributeNodes['direction'].Text;
End;

Procedure TXMLDataType.SetDirection(Value: Widestring);
Begin
  SetAttribute('direction', Value);
End;

Function TXMLDataType.GetStraddle: Widestring;
Begin
  Result := AttributeNodes['straddle'].Text;
End;

Procedure TXMLDataType.SetStraddle(Value: Widestring);
Begin
  SetAttribute('straddle', Value);
End;

Function TXMLDataType.GetByteOrder: Widestring;
Begin
  Result := AttributeNodes['byte_order'].Text;
End;

Procedure TXMLDataType.SetByteOrder(Value: Widestring);
Begin
  SetAttribute('byte_order', Value);
End;

Function TXMLDataType.GetReadOnly: Widestring;
Begin
  Result := AttributeNodes['read_only'].Text;
End;

Procedure TXMLDataType.SetReadOnly(Value: Widestring);
Begin
  SetAttribute('read_only', Value);
End;

Function TXMLDataType.GetDomain: Widestring;
Begin
  Result := AttributeNodes['domain'].Text;
End;

Procedure TXMLDataType.SetDomain(Value: Widestring);
Begin
  SetAttribute('domain', Value);
End;

Function TXMLDataType.GetHide: Widestring;
Begin
  Result := AttributeNodes['hide'].Text;
End;

Procedure TXMLDataType.SetHide(Value: Widestring);
Begin
  SetAttribute('hide', Value);
End;

Function TXMLDataType.GetDisplay: Widestring;
Begin
  Result := AttributeNodes['display'].Text;
End;

Procedure TXMLDataType.SetDisplay(Value: Widestring);
Begin
  SetAttribute('display', Value);
End;

Function TXMLDataType.GetUnits: Widestring;
Begin
  Result := AttributeNodes['units'].Text;
End;

Procedure TXMLDataType.SetUnits(Value: Widestring);
Begin
  SetAttribute('units', Value);
End;

Function TXMLDataType.GetTypeName: Widestring;
Begin
  Result := AttributeNodes['type_name'].Text;
End;

Procedure TXMLDataType.SetTypeName(Value: Widestring);
Begin
  SetAttribute('type_name', Value);
End;

Function TXMLDataType.GetComment: Widestring;
Begin
  Result := AttributeNodes['comment'].Text;
End;

Procedure TXMLDataType.SetComment(Value: Widestring);
Begin
  SetAttribute('comment', Value);
End;

{ TXMLDataTypeList }
Function TXMLDataTypeList.Add: IXMLData;
Begin
  Result := AddItem(-1) As IXMLData;
End;

Function TXMLDataTypeList.Insert(Const Index: Integer): IXMLData;
Begin
  Result := AddItem(Index) As IXMLData;
End;

Function TXMLDataTypeList.GetItem(Index: Integer): IXMLData;
Begin
  Result := List[Index] As IXMLData;
End;

End.

