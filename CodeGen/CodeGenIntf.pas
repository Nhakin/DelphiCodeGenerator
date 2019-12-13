unit CodeGenIntf;

interface

Uses Classes,
  HsInterfaceEx, CodeGenType;

Type
  IHsPropertyDef = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B949-5A218BE9FB24}']
    //Methods
    Function GetVariableDefinition(Const AIsForRecord : Boolean = False) : String;
    Function GetPropertyDefinition(Const AHaveGetter, AHaveSetter : Boolean) : String;
    Function GetPropertyFunctions(Const AHaveGetter, AHaveSetter, AIsVirtual : Boolean; Const AIsAbstract : Boolean = False; Const AIndent : Integer = 0) : String;
    Function GetPropertyFunctionImplementation(Const AHaveGetter, AHaveSetter, ATrackChange : Boolean; Const ADataType : THsDataSource = dsNone) : String;

    //Property Accessors
    Function  GetPropertyName() : String;
    Procedure SetPropertyName(Const APropertyName : String);
    Function  GetPropertyType() : THsPropertyType;
    Procedure SetPropertyType(Const APropertyType : THsPropertyType);
    Function  GetIsDataAware() : Boolean;
    Procedure SetIsDataAware(Const AIsDataAware : Boolean);
    Function  GetIsReadOnly() : Boolean;
    Procedure SetIsReadOnly(Const AIsReadOnly : Boolean);

    //-->dtObject
    Function  GetPropertyClass() : String;
    Procedure SetPropertyClass(Const APropertyClass : String);

    //-->dtInterface
    Function  GetInterfaceName() : String;
    Procedure SetInterfaceName(Const AInterfaceName : String);
    Function  GetInterfaceImplementor() : String;
    Procedure SetInterfaceImplementor(Const AInterfaceImplementor : String);

    //-->dsMSSql
    Function  GetIsId() : Boolean;
    Procedure SetIsId(Const AIsId : Boolean);
    Function  GetFieldName() : String;
    Procedure SetFieldName(Const AFieldName : String);

    //-->ptString, ptWideString
    Function  GetMaxLen() : Integer;
    Procedure SetMaxLen(Const AMaxLen : Integer);

    //-->ptWord, ptDWord
    Function  GetIsBigEndian() : Boolean;
    Procedure SetIsBigEndian(Const ABigEndian : Boolean);
    
    Property PropertyName  : String          Read GetPropertyName  Write SetPropertyName;
    Property PropertyType  : THsPropertyType Read GetPropertyType  Write SetPropertyType;
    Property IsDataAware   : Boolean         Read GetIsDataAware   Write SetIsDataAware;
    Property IsReadOnly    : Boolean         Read GetIsReadOnly    Write SetIsReadOnly;

    //dtObject
    Property PropertyClass : String          Read GetPropertyClass Write SetPropertyClass;

    //dtInterface
    Property InterfaceName        : String Read GetInterfaceName Write SetInterfaceName;
    Property InterfaceImplementor : String Read GetInterfaceImplementor Write SetInterfaceImplementor;

    //dsMSSql
    Property IsId          : Boolean         Read GetIsId          Write SetIsId;
    Property FieldName     : String          Read GetFieldName     Write SetFieldName;

    //ptString, ptWideString
    Property MaxLen        : Integer         Read GetMaxLen        Write SetMaxLen;

    //-->ptWord, ptDWord
    Property IsBigEndian   : Boolean         Read GetIsBigEndian   Write SetIsBigEndian;

  End;

  IHsPropertyDefs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8FE2-FD93D94484D3}']
    Function  Get(Index: Integer) : IHsPropertyDef;
    Procedure Put(Index: Integer; Const Item: IHsPropertyDef);

    Function  GetHaveConstructor() : Boolean;
    Function  GetHaveDestructor() : Boolean;

    Function Add(Const Item: IHsPropertyDef): Integer; OverLoad;
    Function Add() : IHsPropertyDef; OverLoad;

    Property Items[Index : Integer] : IHsPropertyDef Read Get Write Put; Default;

    Property HaveConstructor : Boolean Read GetHaveConstructor;
    Property HaveDestructor  : Boolean Read GetHaveDestructor;

  End;

  IHsProcedureDef = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B08C-E2C6ABAB483A}']
    Function GetProcedureDefinition(Const AForClass : Boolean = False) : String;

    Function  GetProcedureType() : Byte;
    Procedure SetProcedureType(Const AProcedureType : Byte);

    Function  GetProcedureDef() : String;
    Procedure SetProcedureDef(Const AProcedureDef : String);

    Function  GetProcedureName() : String;
    Procedure SetProcedureName(Const AProcedureName : String);

    Function  GetProcedureParameters() : String;
    Procedure SetProcedureParameters(Const AProcedureParameters : String);

    Function  GetResultType() : THsFunctionResultType;
    Procedure SetResultType(Const AResultType : THsFunctionResultType);

    Function  GetProcedureImpl() : TStrings;

    Function  GetIsReIntroduce() : Boolean;
    Procedure SetIsReIntroduce(Const AIsReIntroduce : Boolean);

    Function  GetIsVirtual() : Boolean;
    Procedure SetIsVirtual(Const AIsVirtual : Boolean);

    Function  GetIsAbstract() : Boolean;
    Procedure SetIsAbstract(Const AIsAbstract : Boolean);

    Function  GetIsOverRide() : Boolean;
    Procedure SetIsOverRide(Const AIsOverRide : Boolean);

    Function  GetIsOverLoad() : Boolean;
    Procedure SetIsOverLoad(Const AIsOverLoad : Boolean);

    Function  GetShowInInterface() : Boolean;
    Procedure SetShowInInterface(Const AShowInInterface : Boolean);

    Function  GetProcedureScope() : THsFunctionScope;
    Procedure SetProcedureScope(Const AProcedureScope : THsFunctionScope);

    Property ProcedureType       : Byte                  Read GetProcedureType       Write SetProcedureType;
    Property ProcedureDef        : String                Read GetProcedureDef        Write SetProcedureDef;
    Property ProcedureName       : String                Read GetProcedureName       Write SetProcedureName;
    Property ProcedureParameters : String                Read GetProcedureParameters Write SetProcedureParameters;
    Property ResultType          : THsFunctionResultType Read GetResultType          Write SetResultType;

    Property IsReIntroduce   : Boolean Read GetIsReIntroduce   Write SetIsReIntroduce;
    Property IsVirtual       : Boolean Read GetIsVirtual       Write SetIsVirtual;
    Property IsAbstract      : Boolean Read GetIsAbstract      Write SetIsAbstract;
    Property IsOverRide      : Boolean Read GetIsOverRide      Write SetIsOverRide;
    Property IsOverLoad      : Boolean Read GetIsOverLoad      Write SetIsOverLoad;
    Property ShowInInterface : Boolean Read GetShowInInterface Write SetShowInInterface;

    Property ProcedureScope : THsFunctionScope Read GetProcedureScope Write SetProcedureScope;

    Property ProcedureImpl       : TStrings              Read GetProcedureImpl;

  End;

  IHsProcedureDefs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9E01-F9B506793DBB}']
    Function  Get(Index : Integer) : IHsProcedureDef;
    Procedure Put(Index : Integer; Const Item : IHsProcedureDef);

    Function Add() : IHsProcedureDef; OverLoad;
    Function Add(Const AItem : IHsProcedureDef) : Integer; OverLoad;

    Property Items[Index : Integer] : IHsProcedureDef Read Get Write Put; Default;

  End;  

  IHsClassCodeGenerator = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-884B-92657332CDFB}']
    //Methods
    Procedure GenerateInterfaceDef(AList : TStringList);
    Procedure GenerateClassDef(AList : TStringList);
    Procedure GenerateClassImpl(AList : TStringList);

    Procedure GenerateMSSqlLoadCode(AList : TStringList);
    Procedure GenerateMSSqlSaveCode(AList : TStringList);
//    Function  GenerateUnitCode(Const AUnitName : String) : String;

    //Properties
    Function  GetClsName() : String;
    Procedure SetClsName(Const AClsName : String);

    Function  GetInHeritsFrom() : String;
    Procedure SetInHeritsFrom(Const AInHeritsFrom : String);
    
    Function  GetUseCustomClass() : Boolean;
    Procedure SetUseCustomClass(Const AUseCustomClass : Boolean);

    Function  GetUseInterface() : Boolean;
    Procedure SetUseInterface(Const AUseInterface : Boolean);

    Function  GetUseStrict() : Boolean;
    Procedure SetUseStrict(Const AUseStrict : Boolean);

    Function  GetMakeList() : Boolean;
    Procedure SetMakeList(Const AMakeList : Boolean);

    Function  GetUseEnumerator() : Boolean;
    Procedure SetUseEnumerator(Const AUseEnumerator : Boolean);

    Function  GetUseNestedClass() : Boolean;
    Procedure SetUseNestedClass(Const AUseNestedClass : Boolean);

    Function  GetTrackChange() : Boolean;
    Procedure SetTrackChange(Const ATrackChange : Boolean);

    Function  GetDataType() : THsDataSource;
    Procedure SetDataType(Const ADataType : THsDataSource);

    Function  GetAdoQueryClassName() : String;
    Procedure SetAdoQueryClassName(Const AAdoQueryClassName : String);
    Function  GetTableName() : String;
    Procedure SetTableName(Const ATableName : String);

    Function  GetPropertyDefs() : IHsPropertyDefs;
    Function  GetProcedureDefs() : IHsProcedureDefs;

    Property ClsName        : String        Read GetClsName        Write SetClsName;
    Property InHeritsFrom   : String        Read GetInHeritsFrom   Write SetInHeritsFrom;
    Property UseCustomClass : Boolean       Read GetUseCustomClass Write SetUseCustomClass;
    Property UseInterface   : Boolean       Read GetUseInterface   Write SetUseInterface;
    Property UseStrict      : Boolean       Read GetUseStrict      Write SetUseStrict;
    Property MakeList       : Boolean       Read GetMakeList       Write SetMakeList;
    Property UseEnumerator  : Boolean       Read GetUseEnumerator  Write SetUseEnumerator;
    Property UseNestedClass : Boolean       Read GetUseNestedClass Write SetUseNestedClass;
    Property TrackChange    : Boolean       Read GetTrackChange    Write SetTrackChange;
    Property DataType       : THsDataSource Read GetDataType       Write SetDataType;

    Property AdoQueryClassName : String Read GetAdoQueryClassName Write SetAdoQueryClassName;
    Property TableName         : String Read GetTableName         Write SetTableName;

    Property PropertyDefs  : IHsPropertyDefs  Read GetPropertyDefs;
    Property ProcedureDefs : IHsProcedureDefs Read GetProcedureDefs;

  End;

  IHsClassCodeGenerators = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9274-D30AF6B2F804}']
    Function  Get(Index: Integer) : IHsClassCodeGenerator;
    Procedure Put(Index: Integer; Const Item: IHsClassCodeGenerator);

    Function Add() : IHsClassCodeGenerator;
    Procedure Delete(Const Item : IHsClassCodeGenerator);

    Property Items[Index : Integer] : IHsClassCodeGenerator Read Get Write Put; Default;

  End;

  IHsTypeDef = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A281-766170F91AE1}']
    Function GetTypeDefDefinition() : String;

    Function  GetTypeDefType() : THsTypeDefType;
    Procedure SetTypeDefType(Const ATypeDefType : THsTypeDefType);

    Function  GetTypeDefName() : String;
    Procedure SetTypeDefName(Const ATypeDefName : String);

    Function  GetTypeDefValue() : TStrings;
    Procedure SetTypeDefValue(Const ATypeDefValue : TStrings);

    Function GetTypeDefMembers() : IHsPropertyDefs;

    Property TypeDefType  : THsTypeDefType Read GetTypeDefType  Write SetTypeDefType;
    Property TypeDefName  : String         Read GetTypeDefName  Write SetTypeDefName;
    Property TypeDefValue : TStrings       Read GetTypeDefValue Write SetTypeDefValue;

    Property TypeDefMembers : IHsPropertyDefs Read GetTypeDefMembers;

  End;

  IHsTypeDefs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B5D8-EDB7ADC29BF4}']
    Function  Get(Index : Integer) : IHsTypeDef;
    Procedure Put(Index : Integer; Const Item : IHsTypeDef);

    Function Add() : IHsTypeDef;

    Property Items[Index : Integer] : IHsTypeDef Read Get Write Put; Default;

  End;

  IHsUnitGenerator = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A553-9DDB6B2732C7}']
    Function  GenerateUnitCode() : String;
    Procedure SaveToFile(Const AFileName : String);
    Procedure LoadFromFile(Const AFileName : String);
    Procedure Assign(Const ASource : IHsUnitGenerator);

    Function  GetUnitName() : String;
    Procedure SetUnitName(Const AUnitName : String);

    Function GetTypeDefs() : IHsTypeDefs;
    Function GetClassDefs() : IHsClassCodeGenerators;

    Function GetStates() : TInterfaceStates;

    Function  GetAsJSon() : WideString;
    Procedure SetAsJSon(Const AJSonString : WideString);

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Property UnitName : String Read GetUnitName Write SetUnitName;

    Property TypeDefs : IHsTypeDefs Read GetTypeDefs;
    Property ClassDefs : IHsClassCodeGenerators Read GetClassDefs;
    Property States : TInterfaceStates Read GetStates;

    Property AsJSon : WideString Read GetAsJSon Write SetAsJSon;
    Property AsXml  : String Read GetAsXml Write SetAsXml;

  End;

  THsUnitGenerator = Class(TObject)
  Public
    Class Function CreateGenerator() : IHsUnitGenerator;

  End;

implementation

Uses
  CodeGenImpl;

Class Function THsUnitGenerator.CreateGenerator() : IHsUnitGenerator;
Begin
  Result := CodeGenImpl.THsUnitGenerator.Create(True);
End;  

end.
