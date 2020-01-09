unit CodeGenImpl;

interface
Uses
  Classes, HsInterfaceEx,
  CodeGenType, CodeGenIntf,
  CodeGen.IO, CodeGen.Xml, CodeGen.JSon;

Type
  THsCustomGenerator = Class(TInterfacedObjectEx)
  Protected
    Class Function PadR(pStr : String; pLen : Integer; pChar : Char = ' ') : String;
    Class Function PadL(pStr : String; pLen : Integer; pChar : Char = ' ') : String;

    Class Procedure AlignVariables(AList : TStringList);
    Class Procedure AlignProperties(AList : TStringList);
    Class Procedure AlignVariableAssign(AList : TStringList);

  End;

  THsPropertyDef = Class(THsCustomGenerator, IHsPropertyDef)
  Private
    FPropertyName  : String;
    FPropertyType  : THsPropertyType;
    FIsDataAware   : Boolean;
    FIsReadOnly    : Boolean;

    FPropertyClass : String;

    FInterfaceName        : String;
    FInterfaceImplementor : String;

    FIsId          : Boolean;
    FFieldName     : String;

    FMaxLen        : Integer;

    FBigEndian     : Boolean;
    
    Function GetPropertyTypeStr() : String;

  Protected
    //Methods
    Function GetVariableDefinition(Const AIsForRecord : Boolean = False) : String;
    Function GetPropertyDefinition(Const AHaveGetter, AHaveSetter : Boolean) : String;
    Function GetPropertyFunctions(Const AHaveGetter, AHaveSetter, AIsVirtual : Boolean; Const AIsAbstract : Boolean = False; Const AIndent : Integer = 0) : String;
    Function GetPropertyFunctionImplementation(Const AHaveGetter, AHaveSetter, ATrackChange : Boolean; Const ADataType : THsDataSource = dsNone) : String;

    //Properties
    Function  GetPropertyName() : String; Virtual;
    Procedure SetPropertyName(Const APropertyName : String); Virtual;
    Function  GetPropertyType() : THsPropertyType; Virtual;
    Procedure SetPropertyType(Const APropertyType : THsPropertyType); Virtual;
    Function  GetIsDataAware() : Boolean; Virtual;
    Procedure SetIsDataAware(Const AIsDataAware : Boolean); Virtual;
    Function  GetIsReadOnly() : Boolean; Virtual;
    Procedure SetIsReadOnly(Const AIsReadOnly : Boolean); Virtual;

    //-->dtObject
    Function  GetPropertyClass() : String; Virtual;
    Procedure SetPropertyClass(Const APropertyClass : String); Virtual;

    //-->dtInterface
    Function  GetInterfaceName() : String; Virtual;
    Procedure SetInterfaceName(Const AInterfaceName : String); Virtual;
    Function  GetInterfaceImplementor() : String; Virtual;
    Procedure SetInterfaceImplementor(Const AInterfaceImplementor : String); Virtual;

    //-->dsMSSql
    Function  GetIsId() : Boolean; Virtual;
    Procedure SetIsId(Const AIsId : Boolean); Virtual;
    Function  GetFieldName() : String; Virtual;
    Procedure SetFieldName(Const AFieldName : String); Virtual;

    //-->dtString, dtWideString
    Function  GetMaxLen() : Integer; Virtual;
    Procedure SetMaxLen(Const AMaxLen : Integer); Virtual;

    //-->ptWord, ptDWord
    Function  GetIsBigEndian() : Boolean; Virtual;
    Procedure SetIsBigEndian(Const ABigEndian : Boolean); Virtual;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  THsPropertyDefs = Class(TInterfaceListEx, IHsPropertyDefs)
  Strict Private Type
    THsPropertyDefEnumerator = Class(TInterfaceExEnumerator, IHsPropertyDefEnumerator)
    Protected
      Function GetCurrent() : IHsPropertyDef; OverLoad;

    End;

  Protected
    Function  GetEnumerator() : IHsPropertyDefEnumerator; OverLoad;

    Function  Get(Index : Integer) : IHsPropertyDef; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsPropertyDef); OverLoad;

    Function  GetHaveConstructor() : Boolean;
    Function  GetHaveDestructor() : Boolean;

    Function Add(Const Item : IHsPropertyDef): Integer; OverLoad;
    Function Add() : IHsPropertyDef; ReIntroduce; OverLoad;

  End;

  THsProcedureDef = Class(TInterfacedObjectEx, IHsProcedureDef)
  Strict Private Const
    CIsReIntroduce   = 1;
    CIsVirtual       = 2;
    CIsAbstract      = 4;
    CIsOverRide      = 8;
    CIsOverLoad      = 16;
    CShowInInterface = 32;
    CIsFinal         = 64;

  Strict Private
    FProcedureType       : Byte;
    FProcedureDef        : String;
    FProcedureName       : String;
    FProcedureParameters : String;
    FResultType          : THsFunctionResultType;
    FProcedureImpl       : TStrings;
    FProcFlags           : Byte;
    FProcedureScope      : THsFunctionScope;
    
    Function GetResultTypeStr(Const AResultType : THsFunctionResultType) : String;
    
  Protected
    Function GetProcedureDefinition(Const AForClass : Boolean = False; Const AForInterface : Boolean = False) : String; Virtual;

    Function  GetProcedureType() : Byte; Virtual;
    Procedure SetProcedureType(Const AProcedureType : Byte); Virtual;

    Function  GetProcedureDef() : String; Virtual;
    Procedure SetProcedureDef(Const AProcedureDef : String); Virtual;

    Function  GetProcedureName() : String; Virtual;
    Procedure SetProcedureName(Const AProcedureName : String); Virtual;

    Function  GetProcedureParameters() : String; Virtual;
    Procedure SetProcedureParameters(Const AProcedureParameters : String); Virtual;

    Function  GetResultType() : THsFunctionResultType; Virtual;
    Procedure SetResultType(Const AResultType : THsFunctionResultType); Virtual;

    Function  GetProcedureImpl() : TStrings; Virtual;

    Function  GetIsReIntroduce() : Boolean; Virtual;
    Procedure SetIsReIntroduce(Const AIsReIntroduce : Boolean); Virtual;

    Function  GetIsVirtual() : Boolean; Virtual;
    Procedure SetIsVirtual(Const AIsVirtual : Boolean); Virtual;

    Function  GetIsAbstract() : Boolean; Virtual;
    Procedure SetIsAbstract(Const AIsAbstract : Boolean); Virtual;

    Function  GetIsOverRide() : Boolean; Virtual;
    Procedure SetIsOverRide(Const AIsOverRide : Boolean); Virtual;

    Function  GetIsOverLoad() : Boolean; Virtual;
    Procedure SetIsOverLoad(Const AIsOverLoad : Boolean); Virtual;

    Function  GetIsFinal() : Boolean; Virtual;
    Procedure SetIsFinal(Const AIsFinal : Boolean); Virtual;

    Function  GetShowInInterface() : Boolean; Virtual;
    Procedure SetShowInInterface(Const AShowInInterface : Boolean); Virtual;

    Function  GetProcedureScope() : THsFunctionScope; Virtual;
    Procedure SetProcedureScope(Const AProcedureScope : THsFunctionScope); Virtual;

    Procedure Clear();

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  THsProcedureDefs = Class(TInterfaceListEx, IHsProcedureDefs)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IHsProcedureDef; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsProcedureDef); OverLoad;

    Function Add() : IHsProcedureDef; ReIntroduce; OverLoad;
    Function Add(Const AItem : IHsProcedureDef) : Integer; OverLoad;

  End;

  THsPropertyDefsClass = Class Of THsPropertyDefs;
  THsTypeDefsClass = Class Of THsTypeDefs;
  THsProcedureDefsClass = Class Of THsProcedureDefs;
  THsListSettingsClass = Class Of THsListSettings;

  THsListSettings = Class(TInterfacedObjectEx, IHsListSettings)
  Strict Private
    FUseStrict      : Boolean;
    FUseEnumerator  : Boolean;
    FUseNestedClass : Boolean;
    FIsSealed       : Boolean;
    FMethods        : IHsProcedureDefs;

  Protected
    Function  GetProcedureDefsClass() : THsProcedureDefsClass; Virtual;

    Function  GetUseStrict() : Boolean; Virtual;
    Procedure SetUseStrict(Const AUseStrict : Boolean); Virtual;

    Function  GetUseEnumerator() : Boolean; Virtual;
    Procedure SetUseEnumerator(Const AUseEnumerator : Boolean); Virtual;

    Function  GetUseNestedClass() : Boolean; Virtual;
    Procedure SetUseNestedClass(Const AUseNestedClass : Boolean); Virtual;

    Function  GetIsSealed() : Boolean; Virtual;
    Procedure SetIsSealed(Const AIsSealed : Boolean); Virtual;

    Function  GetMethods() : IHsProcedureDefs;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  THsClassCodeGenerator = Class(THsCustomGenerator, IHsClassCodeGenerator)
  Private
    FClsName        : String;
    FInHeritsFrom   : String;
    FUseInterface   : Boolean;
    FUseStrict      : Boolean;
    FUseCustomClass : Boolean;
    FMakeList       : Boolean;
    FListSettings   : IHsListSettings;
    FTrackChange    : Boolean;
    FDataType       : THsDataSource;

    FAdoQueryClassName : String;
    FTableName         : String;

    FPropertyDefs   : IHsPropertyDefs;
    FProcedureDefs  : IHsProcedureDefs;

  Protected
    Function  GetPropertiesClass() : THsPropertyDefsClass; Virtual;
    Function  GetProcedureDefsClass() : THsProcedureDefsClass; Virtual;
    Function  GetListSettingsClass() : THsListSettingsClass; Virtual;

    Function GetFieldAssignType(APropertyType : THsPropertyType) : String;
    Function GetLoadParamType(Const ALoadPrototype : String) : String;

    //Methods
    Procedure GenerateInterfaceDef(AList : TStringList);
    Procedure GenerateClassDef(AList : TStringList);
    Procedure GenerateClassImpl(AList : TStringList);

    Procedure GenerateMSSqlLoadCode(AList : TStringList);
    Procedure GenerateMSSqlSaveCode(AList : TStringList);
    Procedure GenerateMSSqlCreateTableCode(AList : TStringList);

    Function  GenerateUnitCode(Const AUnitName : String) : String;

    //Properties
    Function  GetClsName() : String; Virtual;
    Procedure SetClsName(Const AClsName : String); Virtual;

    Function  GetInHeritsFrom() : String; Virtual;
    Procedure SetInHeritsFrom(Const AInHeritsFrom : String); Virtual;

    Function  GetUseInterface() : Boolean; Virtual;
    Procedure SetUseInterface(Const AUseInterface : Boolean); Virtual;

    Function  GetUseStrict() : Boolean; Virtual;
    Procedure SetUseStrict(Const AUseStrict : Boolean); Virtual;

    Function  GetUseCustomClass() : Boolean; Virtual;
    Procedure SetUseCustomClass(Const AUseCustomClass : Boolean); Virtual;

    Function  GetMakeList() : Boolean; Virtual;
    Procedure SetMakeList(Const AMakeList : Boolean); Virtual;

    Function  GetTrackChange() : Boolean; Virtual;
    Procedure SetTrackChange(Const ATrackChange : Boolean); Virtual;

    Function  GetDataType() : THsDataSource; Virtual;
    Procedure SetDataType(Const ADataType : THsDataSource); Virtual;

    Function  GetAdoQueryClassName() : String; Virtual;
    Procedure SetAdoQueryClassName(Const AAdoQueryClassName : String); Virtual;

    Function  GetTableName() : String; Virtual;
    Procedure SetTableName(Const ATableName : String); Virtual;

    Function  GetPropertyDefs() : IHsPropertyDefs;
    Function  GetProcedureDefs() : IHsProcedureDefs;
    Function  GetListSettings() : IHsListSettings;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  THsClassCodeGenerators = Class(TInterfaceListEx, IHsClassCodeGenerators)
  Protected
    Function  Get(Index : Integer) : IHsClassCodeGenerator; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsClassCodeGenerator); OverLoad;
    Function  Add() : IHsClassCodeGenerator; ReIntroduce; OverLoad;

    Procedure Delete(Const Item : IHsClassCodeGenerator); OverLoad;

  End;

  THsTypeDef = Class(THsCustomGenerator, IHsTypeDef)
  Strict Private
    FTypeDefType  : THsTypeDefType;
    FTypeDefName  : String;
    FTypeDefValue : TStrings;
    FTypeDefMembers : IHsPropertyDefs;

  Protected
    Function GetTypeDefDefinition() : String;

    Function GetPropertiesClass() : THsPropertyDefsClass; Virtual;

    Function  GetTypeDefType() : THsTypeDefType; Virtual;
    Procedure SetTypeDefType(Const ATypeDefType : THsTypeDefType); Virtual;

    Function  GetTypeDefName() : String; Virtual;
    Procedure SetTypeDefName(Const ATypeDefName : String); Virtual;

    Function  GetTypeDefValue() : TStrings; Virtual;
    Procedure SetTypeDefValue(Const ATypeDefValue : TStrings); Virtual;

    Function GetTypeDefMembers() : IHsPropertyDefs;

  Public
    Property TypeDefType    : THsTypeDefType  Read GetTypeDefType  Write SetTypeDefType;
    Property TypeDefName    : String          Read GetTypeDefName  Write SetTypeDefName;
    Property TypeDefValue   : TStrings        Read GetTypeDefValue Write SetTypeDefValue;
    Property TypeDefMembers : IHsPropertyDefs Read GetTypeDefMembers;

    Constructor Create(); ReIntroduce; Virtual;
    Destructor  Destroy(); OverRide;

  End;

  THsTypeDefs = Class(TInterfaceListEx, IHsTypeDefs)
  Protected
    Function  Get(Index : Integer) : IHsTypeDef; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsTypeDef); OverLoad;

    Function Add() : IHsTypeDef; ReIntroduce; OverLoad;

  End;

  THsClassCodeGeneratorsClass = Class Of THsClassCodeGenerators;
  THsUnitGenerator = Class(THsCustomGenerator,
    IHsUnitGenerator, IJSonUnitGenerator, IXMLUnitGenerator)
  Private
    FUnitName  : String;
    FTypeDefs  : IHsTypeDefs;
    FClassDefs : IHsClassCodeGenerators;
    FJSon      : IJSonUnitGenerator;
    FXml       : IXMLUnitGenerator;
    FStates    : TInterfaceStates;

    Function GetJSonIO() : IJSonUnitGenerator;
    Function GetXmlIO() : IXMLUnitGenerator;

  Protected
    Property JSonImpl : IJSonUnitGenerator Read GetJSonIO Implements IJSonUnitGenerator;
    Property XmlImpl  : IXMLUnitGenerator  Read GetXmlIO Implements IXMLUnitGenerator;

  Protected
    Procedure SaveToFile(Const AFileName : String); Virtual;
    Procedure LoadFromFile(Const AFileName : String); Virtual;
    Procedure Assign(Const ASource : IHsUnitGenerator); Virtual;

    Function  GetTypeDefsClass() : THsTypeDefsClass; Virtual;
    Function  GetCodeGeneratorClass() : THsClassCodeGeneratorsClass; Virtual;

    Function  GetUnitName() : String; Virtual;
    Procedure SetUnitName(Const AUnitName : String); Virtual;

    Function GetTypeDefs() : IHsTypeDefs;
    Function GetClassDefs() : IHsClassCodeGenerators;

    Function GetStates() : TInterfaceStates;

    Function  GetAsJSon() : WideString;
    Procedure SetAsJSon(Const AJSonString : WideString);

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

  Public
    Function  GenerateUnitCode() : String;

    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

implementation

Uses StrUtils, SysUtils, Math, Dialogs, HsXmlDocEx, SuperObject, 
  TypInfo;

Class Function THsCustomGenerator.PadR(pStr : String; pLen : Integer; pChar : Char = ' ') : String;
Var X : Integer;
Begin
  For X := 1 To pLen - Length(pStr) Do
    pStr := pStr + pChar;
  Result := pStr;
End;

Class Function THsCustomGenerator.PadL(pStr : String; pLen : Integer; pChar : Char = ' ') : String;
Var X : Integer;
Begin
  For X := 1 To pLen - Length(pStr) Do
    pStr := pChar + pStr;
  Result := pStr;
End;

Class Procedure THsCustomGenerator.AlignVariables(AList : TStringList);
Var lPos : Integer;
    X    : Integer;
Begin
  lPos := 0;
  For X := 0 To AList.Count - 1 Do
    lPos := Max(lPos, Pos(':', AList[X]));
  Dec(lPos);

  With TStringList.Create() Do
  Try
    For X := 0 To AList.Count - 1 Do
      Add(
        PadR(
          Copy(AList[X], 1, Pos(':', AList[X]) - 1), lPos) + ' : ' +
          Copy(AList[X], Pos(':', AList[X]) + 1, Length(AList[X])
        )
      );

    AList.Text := Text;

    Finally
      Free();
  End;
End;

Class Procedure THsCustomGenerator.AlignProperties(AList : TStringList);
Var S     : String;
    X, Y  : Integer;
    lStrs : TStringList;

    lMaxVarPos   : Integer;
    lMaxTypePos  : Integer;
    lMaxReadPos  : Integer;
    lMaxWritePos : Integer;
Begin
  lStrs := TStringList.Create();
  Try
    lMaxVarPos   := 0;
    lMaxTypePos  := 0;
    lMaxReadPos  := 0;
    lMaxWritePos := 0;

    For X := 0 To AList.Count - 1 Do
    Begin
      lStrs.Clear();
      ExtractStrings([' ', ':'], [], PChar(AList[X]), lStrs);

      For Y := 0 To lStrs.Count - 1 Do
        lStrs[Y] := Trim(lStrs[Y]);

      For Y := 0 To lStrs.Count - 1 Do
      Begin
        If SameText(lStrs[Y], 'Property') Then
        Begin
          lMaxVarPos  := Max(lMaxVarPos, Length(lStrs[Y + 1]));
          lMaxTypePos := Max(lMaxTypePos, Length(lStrs[Y + 2]));
        End
        Else If SameText(lStrs[Y], 'Read') Then
          lMaxReadPos := Max(lMaxReadPos, Length(lStrs[Y + 1]))
        Else If SameText(lStrs[Y], 'Write') Then
          lMaxWritePos := Max(lMaxWritePos, Length(lStrs[Y + 1]));
      End;
    End;

    For X := 0 To AList.Count - 1 Do
    Begin
      lStrs.Clear();
      ExtractStrings([' ', ':'], [], PChar(AList[X]), lStrs);

      For Y := 0 To lStrs.Count - 1 Do
        lStrs[Y] := Trim(lStrs[Y]);

      S := '    ' + lStrs[0] + ' ' + PadR(lStrs[1], lMaxVarPos) + ' : ' +
           PadR(lStrs[2], lMaxTypePos) + ' ' +
           lStrs[3];

      If lStrs.Count > 5 Then
      Begin
        S := S + ' ' + PadR(lStrs[4], lMaxReadPos) + ' ' +
             lStrs[5] + ' ' + lStrs[6];
      End
      Else
        S := S + ' ' + lStrs[4];

      AList[X] := S;
    End;

    Finally
      lStrs.Free();
  End;
End;

Class Procedure THsCustomGenerator.AlignVariableAssign(AList : TStringList);
Var lStrs : TStringList;
    lMaxLen : Integer;
    X       : Integer;
Begin
  lStrs := TStringList.Create();
  Try
    lMaxLen := 0;

    For X := 0 To AList.Count - 1 Do
    Begin
      lStrs.Clear();
      ExtractStrings([':', '='], [], PChar(AList[X]), lStrs);
      If lStrs.Count > 1 Then
        lMaxLen := Max(lMaxLen, Length(Trim(lStrs[0])));
    End;

    For X := 0 To AList.Count - 1 Do
    Begin
      lStrs.Clear();
      ExtractStrings([':', '='], [], PChar(AList[X]), lStrs);
      If lStrs.Count > 1 Then
        AList[X] := '  ' + PadR(Trim(lStrs[0]), lMaxLen) + ' := ' + lStrs[1]
      Else
        AList[X] := lStrs[0];
    End;

    Finally
      lStrs.Free();
  End;
End;
  
(******************************************************************************)

Procedure THsPropertyDef.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FIsReadOnly  := False;
  FIsDataAware := False;
  FBigEndian   := False;
End;

Function THsPropertyDef.GetPropertyClass() : String;
Begin
  Result := FPropertyClass;
End;

Procedure THsPropertyDef.SetPropertyClass(Const APropertyClass : String);
Begin
  FPropertyClass := APropertyClass;
End;

Function THsPropertyDef.GetInterfaceName() : String;
Begin
  Result := FInterfaceName;
End;

Procedure THsPropertyDef.SetInterfaceName(Const AInterfaceName : String);
Begin
  FInterfaceName := AInterfaceName;
End;

Function THsPropertyDef.GetInterfaceImplementor() : String;
Begin
  Result := FInterfaceImplementor;
End;

Procedure THsPropertyDef.SetInterfaceImplementor(Const AInterfaceImplementor : String);
Begin
  FInterfaceImplementor := AInterfaceImplementor;
End;

Function THsPropertyDef.GetPropertyName() : String;
Begin
  Result := FPropertyName;
End;

Procedure THsPropertyDef.SetPropertyName(Const APropertyName : String);
Begin
  If FPropertyName <> APropertyName Then
  Begin
    If FIsDataAware And
       (SameText(FFieldName, FPropertyName) Or
        SameText(FFieldName, '')) Then
      FFieldName := APropertyName;

    FPropertyName := APropertyName;
  End;
End;

Function THsPropertyDef.GetIsId() : Boolean;
Begin
  Result := FIsId;
End;

Procedure THsPropertyDef.SetIsId(Const AIsId : Boolean);
Begin
  FIsId := AIsId;
End;

Function THsPropertyDef.GetFieldName() : String;
Begin
  Result := FFieldName;
End;

Procedure THsPropertyDef.SetFieldName(Const AFieldName : String);
Begin
  FFieldName := AFieldName;
End;

Function THsPropertyDef.GetPropertyType() : THsPropertyType;
Begin
  Result := FPropertyType;
End;

Procedure THsPropertyDef.SetPropertyType(Const APropertyType : THsPropertyType);
Begin
  FPropertyType := APropertyType;
End;

Function THsPropertyDef.GetIsDataAware() : Boolean;
Begin
  Result := FIsDataAware;
End;

Procedure THsPropertyDef.SetIsDataAware(Const AIsDataAware : Boolean);
Begin
  If FIsDataAware <> AIsDataAware Then
  Begin
    If AIsDataAware And SameText(FFieldName, '') Then
      FFieldName := FPropertyName;

    FIsDataAware := AIsDataAware;
  End;
End;

Function THsPropertyDef.GetIsReadOnly() : Boolean;
Begin
  Result := FIsReadOnly;
End;

Procedure THsPropertyDef.SetIsReadOnly(Const AIsReadOnly : Boolean);
Begin
  FIsReadOnly := AIsReadOnly;
End;

Function THsPropertyDef.GetMaxLen() : Integer;
Begin
  Result := FMaxLen;
End;

Procedure THsPropertyDef.SetMaxLen(Const AMaxLen : Integer);
Begin
  FMaxLen := AMaxLen;
End;

Function THsPropertyDef.GetIsBigEndian() : Boolean;
Begin
  Result := FBigEndian;
End;

Procedure THsPropertyDef.SetIsBigEndian(Const ABigEndian : Boolean);
Begin
  FBigEndian := ABigEndian;
End;

Function THsPropertyDef.GetPropertyTypeStr() : String;
Begin
  Case FPropertyType Of
    ptByte : Result := 'Byte';
    ptInteger, ptAutoInc : Result := 'Integer';
    ptSingle : Result := 'Single';
    ptDouble : Result := 'Double';
    ptExtended : Result := 'Extended';
    ptCurrency : Result := 'Currency';
    ptChar : Result := 'Char';
    ptString : Result := 'String';
    ptWideString : Result := 'WideString';
    ptPAnsiChar : Result := 'PAnsiChar';
    ptPWideChar : Result := 'PWideChar';
    ptDate, ptTime, ptDateTime : Result := 'TDateTime';
    ptBoolean : Result := 'Boolean';
    ptObject : Result := IfThen(FPropertyClass <> '', FPropertyClass, 'TObject');
    ptInterface : Result := IfThen(FInterfaceName <> '', FInterfaceName, 'IInterfaceEx');
    ptWord : Result := 'Word';
    ptDWord : Result := 'DWord';
    ptQWord : Result := 'Int64';
    ptStringList : Result := 'TStrings';

    Else
      Result := 'Variant';
  End;
//    ptVariant, ptClass, ptEnum, ptMethod
End;

Function THsPropertyDef.GetVariableDefinition(Const AIsForRecord : Boolean = False) : String;
Begin
  Case FPropertyType Of
    ptStringList :
    Begin
      If AIsForRecord Then
        Result := FPropertyName + ':TStrings'
      Else
        Result := 'F' + FPropertyName + ':TStrings;';
    End;
    Else
      If AIsForRecord Then
        Result := FPropertyName + ':' + GetPropertyTypeStr() + ';'
      Else
        Result := 'F' + FPropertyName + ':' + GetPropertyTypeStr() + ';';
  End;
End;

Function THsPropertyDef.GetPropertyDefinition(Const AHaveGetter, AHaveSetter : Boolean) : String;
Begin
  Result := 'Property ' + FPropertyName + ':' + GetPropertyTypeStr() + ' Read ';

  If AHaveGetter Then
    Result := Result + 'Get'
  Else
    Result := Result + 'F';

  Result := Result + FPropertyName;

  If FIsReadOnly Then
    Result := Result + ';'
  Else
  Begin
    Result := Result + ' Write ';
    If (AHaveSetter Or ((FPropertyType = ptString) And (FMaxLen > 0))) Then
      Result := Result + 'Set'
    Else
      Result := Result + 'F';

    Result := Result + FPropertyName + ';'
  End;
End;

Function THsPropertyDef.GetPropertyFunctions(Const AHaveGetter, AHaveSetter, AIsVirtual : Boolean; Const AIsAbstract : Boolean = False; Const AIndent : Integer = 0) : String;
Var lStr : String;
Begin
  Result := '';

  With TStringList.Create() Do
  Try
    If AHaveGetter Then
    Begin
      lStr := StringOfChar(' ', AIndent * 2) + 'Function  Get' + FPropertyName + '() : ' + GetPropertyTypeStr() + ';';
      If AIsVirtual Then
        lStr := lStr + ' Virtual;';
      If AIsAbstract Then
        lStr := lStr + ' Abstract;';

      Add(lStr);
    End;

    If Not FIsReadOnly And (AHaveSetter Or ((FPropertyType = ptString) And (FMaxLen > 0))) Then
    Begin
      lStr := StringOfChar(' ', AIndent * 2) + 'Procedure Set' + FPropertyName + '(Const A' + FPropertyName + ' : ' + GetPropertyTypeStr() + ');';
      If AIsVirtual Then
        lStr := lStr + ' Virtual;';
      If AIsAbstract Then
        lStr := lStr + ' Abstract;';

      Add(lStr);
    End;

    Result := Text;

    Finally
      Free();
  End;
End;

Function THsPropertyDef.GetPropertyFunctionImplementation(Const AHaveGetter, AHaveSetter, ATrackChange : Boolean; Const ADataType : THsDataSource = dsNone) : String;
  Procedure GetJSonGetterCode(AList : TStringList);
  Begin
    Case FPropertyType Of
      ptInteger, ptByte : AList.Add('  Result := I[''' + FPropertyName + '''];');
      ptDouble : AList.Add('  Result := D[''' + FPropertyName + '''];');
      ptCurrency : AList.Add('  Result := C[''' + FPropertyName + '''];');
      ptString, ptWideString : AList.Add('  Result := S[''' + FPropertyName + '''];');
      ptBoolean : AList.Add('  Result := B[''' + FPropertyName + '''];');
      ptInterface :
      Begin
        AList.Add('  If O[''' + FPropertyName + '''] = Nil Then');
        AList.Add('    O[''' + FPropertyName + '''] := ' + FInterfaceImplementor + '.Create();');
        AList.Add('');
        AList.Add('  Result := O[''' + FPropertyName + '''] As ' + FInterfaceName);
      End;
    End;
  End;

  Procedure GetXmlGetterCode(AList : TStringList);
  Begin
    Case FPropertyType Of
      ptInteger, ptSingle, ptByte : AList.Add('  Result := ChildNodes[''' + FPropertyName + '''].AsInteger;');
      ptDouble : AList.Add('  Result := ChildNodes[''' + FPropertyName + '''].AsFloat;');
      ptCurrency : AList.Add('  Result := ChildNodes[''' + FPropertyName + '''].AsCurrency;');
      ptDate, ptTime, ptDateTime : AList.Add('  Result := ChildNodes[''' + FPropertyName + '''].AsDateTime;');
      ptBoolean : AList.Add('  Result := ChildNodes[''' + FPropertyName + '''].AsBoolean;');
      ptString, ptWideString : AList.Add('  Result := ChildNodes[''' + FPropertyName + '''].AsString;');
      ptInterface : AList.Add('  Result := ChildNodes[''' + FPropertyName + '''] As ' + FInterfaceName + ';');
    End;
  End;

  Procedure GetJSonSetterCode(AList : TStringList);
  Begin
    Case FPropertyType Of
      ptInteger, ptByte :
      Begin
        If ATrackChange Then
        Begin
          AList.Add('  If I[''' + FPropertyName + '''] <> A' + FPropertyName + ' Then');
          AList.Add('  Begin');
          AList.Add('    I[''' + FPropertyName + '''] := A' + FPropertyName + ';');
        End
        Else
          AList.Add('  I[''' + FPropertyName + '''] := A' + FPropertyName + ';');
      End;

      ptDouble :
      Begin
        If ATrackChange Then
        Begin
          AList.Add('  If D[''' + FPropertyName + '''] <> A' + FPropertyName + ' Then');
          AList.Add('  Begin');
          AList.Add('    D[''' + FPropertyName + '''] := A' + FPropertyName + ';');
        End
        Else
          AList.Add('  D[''' + FPropertyName + '''] := A' + FPropertyName + ';');
      End;

      ptCurrency :
      Begin
        If ATrackChange Then
        Begin
          AList.Add('  If C[''' + FPropertyName + '''] <> A' + FPropertyName + ' Then');
          AList.Add('  Begin');
          AList.Add('    C[''' + FPropertyName + '''] := A' + FPropertyName + ';');
        End
        Else
          AList.Add('  C[''' + FPropertyName + '''] := A' + FPropertyName + ';');
      End;

      ptString, ptWideString :
      Begin
        If ATrackChange Then
        Begin
          AList.Add('  If S[''' + FPropertyName + '''] <> A' + FPropertyName + ' Then');
          AList.Add('  Begin');
          AList.Add('    S[''' + FPropertyName + '''] := A' + FPropertyName + ';');
        End
        Else
          AList.Add('  S[''' + FPropertyName + '''] := A' + FPropertyName + ';');
      End;

      ptBoolean :
      Begin
        If ATrackChange Then
        Begin
          AList.Add('  If B[''' + FPropertyName + '''] <> A' + FPropertyName + ' Then');
          AList.Add('  Begin');
          AList.Add('    B[''' + FPropertyName + '''] := A' + FPropertyName + ';');
        End
        Else
          AList.Add('  B[''' + FPropertyName + '''] := A' + FPropertyName + ';');
      End;

      ptInterface :
      Begin
        AList.Add('  O[''' + FPropertyName + '''] := A' + FPropertyName + ';');
      End;
    End;
  End;

  Procedure GetXmlSetterCode(AList : TStringList);
  Begin
    Case FPropertyType Of
      ptInteger, ptSingle, ptByte : AList.Add('  ChildNodes[''' + FPropertyName + '''].AsInteger := A' + FPropertyName + ';');
      ptDouble : AList.Add('  ChildNodes[''' + FPropertyName + '''].AsFloat := A' + FPropertyName + ';');
      ptCurrency : AList.Add('  ChildNodes[''' + FPropertyName + '''].AsCurrency := A' + FPropertyName + ';');
      ptDate, ptTime, ptDateTime : AList.Add('  ChildNodes[''' + FPropertyName + '''].AsDateTime := A' + FPropertyName + ';');
      ptBoolean : AList.Add('  ChildNodes[''' + FPropertyName + '''].AsBoolean := A' + FPropertyName + ';');
      ptString, ptWideString : AList.Add('  ChildNodes[''' + FPropertyName + '''].AsString := A' + FPropertyName + ';');
    End;
  End;

Var lResult : TStringList;
Begin
  Result := '';
  lResult := TStringList.Create();
  With lResult Do
  Try
    If AHaveGetter Then
    Begin
      Add('Function T%ClassName%.Get' + FPropertyName + '() : ' + GetPropertyTypeStr() + ';');
      Add('Begin');
      Case ADataType Of
        dsJSon : GetJSonGetterCode(lResult);
        dsXML : GetXmlGetterCode(lResult);

        Else
          Add('  Result := F' + FPropertyName + ';');
      End;
      Add('End;');
    End;

    If Not FIsReadOnly And (AHaveSetter Or ((FPropertyType = ptString) And (FMaxLen > 0))) Then
    Begin
      Add('');

      Add('Procedure T%ClassName%.Set' + FPropertyName + '(Const A' + FPropertyName + ' : ' + GetPropertyTypeStr() + ');');
      Add('Begin');

      If (FPropertyType = ptString) And (FMaxLen > 0) Then
      Begin
        Add('  If Length(A' + FPropertyName + ') > ' + IntToStr(FMaxLen) + ' Then');
        Add('    Raise Exception.Create(''MaxLength for property ' + FPropertyName + ' is : ' + IntToStr(FMaxLen) + ''');');
      End;

      If ATrackChange Then
      Begin
        Case ADataType Of
          dsJSon : GetJSonSetterCode(lResult);
          dsXml : GetXmlSetterCode(lResult);
          
          Else
            Add('  If F' + FPropertyName + ' <> A' + FPropertyName + ' Then');
            Add('  Begin');
            Add('    F' + FPropertyName + ' := A' + FPropertyName + ';');
        End;
        Add('    Changed();');
        Add('  End;');
      End
      Else
      Begin
        Case ADataType Of
          dsJSon : GetJSonSetterCode(lResult);
          dsXml : GetXmlSetterCode(lResult);

          Else
            Add('  F' + FPropertyName + ' := A' + FPropertyName + ';');
        End;
      End;

      Add('End;');
    End;

    Result := Text;

    Finally
      Free();
  End;
End;

(******************************************************************************)

Function THsPropertyDefs.THsPropertyDefEnumerator.GetCurrent() : IHsPropertyDef;
Begin
  Result := InHerited Current As IHsPropertyDef;
End;

Function THsPropertyDefs.GetEnumerator() : IHsPropertyDefEnumerator;
Begin
  Result := THsPropertyDefEnumerator.Create(Self);
End;

Function THsPropertyDefs.GetHaveConstructor() : Boolean;
Var lItem : IHsPropertyDef;
Begin
  Result := False;

  For lItem In IHsPropertyDefs(Self) Do
    If lItem.PropertyType In [ptObject, ptInterface, ptStringList] Then
    Begin
      Result := True;
      Break;
    End;
End;

Function THsPropertyDefs.GetHaveDestructor() : Boolean;
Var lItem : IHsPropertyDef;
Begin
  Result := False;

  For lItem In IHsPropertyDefs(Self) Do
    If lItem.PropertyType In [ptObject, ptInterface, ptStringList] Then
    Begin
      Result := True;
      Break;
    End;
End;

Function THsPropertyDefs.Get(Index : Integer) : IHsPropertyDef;
Begin
  Result := InHerited Items[Index] As IHsPropertyDef;
End;

Procedure THsPropertyDefs.Put(Index : Integer; Const Item : IHsPropertyDef);
Begin
  InHerited Items[Index] := Item;
End;

Function THsPropertyDefs.Add(Const Item : IHsPropertyDef) : Integer;
Begin
  Result := InHerited Add(Item);
End;

Function THsPropertyDefs.Add() : IHsPropertyDef;
Begin
  Result := THsPropertyDef.Create();
  InHerited Add(Result As IHsPropertyDef);
End;

Procedure THsListSettings.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FMethods := GetProcedureDefsClass().Create();
End;

Procedure THsListSettings.BeforeDestruction();
Begin
  FMethods := Nil;

  InHerited BeforeDestruction();
End;

Function THsListSettings.GetProcedureDefsClass() :  THsProcedureDefsClass;
Begin
  Result := THsProcedureDefs;
End;

Function THsListSettings.GetUseStrict() : Boolean;
Begin
  Result := FUseStrict;
End;

Procedure THsListSettings.SetUseStrict(Const AUseStrict : Boolean);
Begin
  FUseStrict := AUseStrict;
End;

Function THsListSettings.GetUseEnumerator() : Boolean;
Begin
  Result := FUseEnumerator;
End;

Procedure THsListSettings.SetUseEnumerator(Const AUseEnumerator : Boolean);
Begin
  FUseEnumerator := AUseEnumerator;
End;

Function THsListSettings.GetUseNestedClass() : Boolean;
Begin
  Result := FUseNestedClass;
End;

Procedure THsListSettings.SetUseNestedClass(Const AUseNestedClass : Boolean);
Begin
  FUseNestedClass := AUseNestedClass;
End;

Function THsListSettings.GetIsSealed() : Boolean;
Begin
  Result := FIsSealed;
End;

Procedure THsListSettings.SetIsSealed(Const AIsSealed : Boolean);
Begin
  FIsSealed := AIsSealed;
End;

Function THsListSettings.GetMethods() : IHsProcedureDefs;
Begin
  Result := FMethods;
End;

Procedure THsClassCodeGenerator.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FPropertyDefs   := GetPropertiesClass().Create();
  FProcedureDefs  := GetProcedureDefsClass().Create();
  FListSettings   := GetListSettingsClass().Create();

  FUseInterface   := False;
  FUseStrict      := False;
  FUseCustomClass := False;
  FMakeList       := False;
  FTrackChange    := False;
  FDataType       := dsNone;

  FAdoQueryClassName := '';
  FTableName         := '';
End;

Procedure THsClassCodeGenerator.BeforeDestruction();
Begin
  FPropertyDefs  := Nil;
  FProcedureDefs := Nil;
  FListSettings  := Nil;
    
  InHerited BeforeDestruction();
End;

Function THsClassCodeGenerator.GetPropertiesClass() : THsPropertyDefsClass;
Begin
  Result := THsPropertyDefs;
End;

Function  THsClassCodeGenerator.GetProcedureDefsClass() : THsProcedureDefsClass;
Begin
  Result := THsProcedureDefs;
End;

Function THsClassCodeGenerator.GetListSettingsClass() : THsListSettingsClass;
Begin
  Result := THsListSettings;
End;

Function THsClassCodeGenerator.GetClsName() : String;
Begin
  Result := FClsName;
End;

Procedure THsClassCodeGenerator.SetClsName(Const AClsName : String);
Begin
  FClsName := AClsName;
End;

Function THsClassCodeGenerator.GetInHeritsFrom() : String;
Begin
  Result := FInHeritsFrom;
End;

Procedure THsClassCodeGenerator.SetInHeritsFrom(Const AInHeritsFrom : String);
Begin
  FInHeritsFrom := AInHeritsFrom;
End;

Function THsClassCodeGenerator.GetUseInterface() : Boolean;
Begin
  Result := FUseInterface;
End;

Procedure THsClassCodeGenerator.SetUseInterface(Const AUseInterface : Boolean);
Begin
  FUseInterface := AUseInterface;
End;

Function THsClassCodeGenerator.GetUseStrict() : Boolean;
Begin
  Result := FUseStrict;
End;

Procedure THsClassCodeGenerator.SetUseStrict(Const AUseStrict : Boolean);
Begin
  FUseStrict := AUseStrict;
End;

Function THsClassCodeGenerator.GetUseCustomClass() : Boolean;
Begin
  Result := FUseCustomClass;
End;

Procedure THsClassCodeGenerator.SetUseCustomClass(Const AUseCustomClass : Boolean);
Begin
  FUseCustomClass := AUseCustomClass;
End;

Function THsClassCodeGenerator.GetMakeList() : Boolean;
Begin
  Result := FMakeList;
End;

Procedure THsClassCodeGenerator.SetMakeList(Const AMakeList : Boolean);
Begin
  FMakeList := AMakeList;
End;

Function THsClassCodeGenerator.GetTrackChange() : Boolean;
Begin
  Result := FTrackChange;
End;

Procedure THsClassCodeGenerator.SetTrackChange(Const ATrackChange : Boolean);
Begin
  FTrackChange := ATrackChange;
End;

Function THsClassCodeGenerator.GetDataType() : THsDataSource;
Begin
  Result := FDataType;
End;

Procedure THsClassCodeGenerator.SetDataType(Const ADataType : THsDataSource);
Begin
  FDataType := ADataType;
End;

Function THsClassCodeGenerator.GetTableName() : String;
Begin
  Result := FTableName;
End;

Function THsClassCodeGenerator.GetAdoQueryClassName() : String;
Begin
  Result := FAdoQueryClassName;
End;

Procedure THsClassCodeGenerator.SetAdoQueryClassName(Const AAdoQueryClassName : String);
Begin
  FAdoQueryClassName := AAdoQueryClassName;
End;

Procedure THsClassCodeGenerator.SetTableName(Const ATableName : String);
Begin
  FTableName := ATableName;
End;

Function THsClassCodeGenerator.GetPropertyDefs() : IHsPropertyDefs;
Begin
  Result := FPropertyDefs;
End;

Function THsClassCodeGenerator.GetProcedureDefs() : IHsProcedureDefs;
Begin
  Result := FProcedureDefs;
End;

Function THsClassCodeGenerator.GetListSettings() : IHsListSettings;
Begin
  Result := FListSettings;
End;

Procedure THsClassCodeGenerator.GenerateInterfaceDef(AList : TStringList);
Const
  MagicGuid = 2383012921268594798;
Var lGuidRec : Packed Record
      Case Boolean Of
        True : (Guid : TGuid);
        False : (Int1, Int2 : Int64);
    End;
    X : Integer;
    lTmpList : TStringList;
    lLstHaveProc : Boolean;
Begin
  If FInHeritsFrom <> '' Then
    AList.Add('  I' + FClsName + ' = Interface(I' + Copy(FInHeritsFrom, 2, Length(FInHeritsFrom)) + ')')
  Else If FDataType = dsJSon Then
    AList.Add('  I' + FClsName + ' = Interface(ISuperObjectEx)')
  Else If FDataType = dsXML Then
    AList.Add('  I' + FClsName + ' = Interface(IXmlNodeEx)')
  Else
    AList.Add('  I' + FClsName + ' = Interface(IInterfaceEx)');

  CreateGUID(lGuidRec.Guid);
  lGuidRec.Int1 := MagicGuid;
  AList.Add('    [''' + GUIDToString(lGuidRec.Guid) + ''']');

  For X := 0 To FPropertyDefs.Count - 1 Do
    AList.Add(FPropertyDefs[X].GetPropertyFunctions(True, True, False, False, 2));

  For X := 0 To FProcedureDefs.Count - 1 Do
    If FProcedureDefs[X].ShowInInterface Then
      AList.Add('    ' + FProcedureDefs[X].GetProcedureDefinition(True, True));

  If FPropertyDefs.Count > 0 Then
  Begin
    AList.Add('');
    lTmpList := TStringList.Create();
    Try
      For X := 0 To FPropertyDefs.Count - 1 Do
        lTmpList.Add(FPropertyDefs[X].GetPropertyDefinition(True, True));
      AlignProperties(lTmpList);
      For X := 0 To lTmpList.Count - 1 Do
        AList.Add(lTmpList[X]);
      Finally
        lTmpList.Free();
    End;
    AList.Add('');
  End;
  AList.Add('  End;');
  AList.Add('');

  If FMakeList Then
  Begin
    If FListSettings.UseEnumerator And (FDataType = dsNone) Then
    Begin
      CreateGUID(lGuidRec.Guid);
      lGuidRec.Int1 := MagicGuid;

      AList.Add('  I' + FClsName + 'Enumerator = Interface(IInterfaceExEnumerator)');
      AList.Add('    [''' + GUIDToString(lGuidRec.Guid) + ''']');
      AList.Add('    Function GetCurrent() : I' + FClsName + ';');
      AList.Add('    Property Current : I' + FClsName + ' Read GetCurrent;');
      AList.Add('');
      AList.Add('  End;');
      AList.Add('');
    End;

    If FDataType = dsJSon Then
      AList.Add('  I' + FClsName + 's = Interface(ISuperObjectExList)')
    Else If FDataType = dsXML Then
      AList.Add('  I' + FClsName + 's = Interface(IXmlNodeCollectionEx)')
    Else
      AList.Add('  I' + FClsName + 's = Interface(IInterfaceListEx)');

    CreateGUID(lGuidRec.Guid);
    lGuidRec.Int1 := MagicGuid;
    AList.Add('    [''' + GUIDToString(lGuidRec.Guid) + ''']');

    If (FDataType = dsJSon) Then
    Begin
      AList.Add('    Function GetItem(Const Index : Integer) : I' + FClsName + ';');
      AList.Add('');
      AList.Add('    Function Add() : I' + FClsName + '; OverLoad;');
      AList.Add('    Function Add(Const AItem : I' + FClsName + ') : Integer; OverLoad;');
      AList.Add('');
      AList.Add('    Property Items[Const Index: Integer] : I' + FClsName + ' Read MyGetItem; Default;');
    End
    Else If FDataType = dsXML Then
    Begin
      AList.Add('    Function GetItem(Const Index : Integer) : I' + FClsName + ';');
      AList.Add('');
      AList.Add('    Function Add() : I' + FClsName + ';');
      AList.Add('    Function Insert(Const Index: Integer) : I' + FClsName + ';');
      AList.Add('');
      AList.Add('    Property Items[Const Index: Integer] : I' + FClsName + ' Read GetItem; Default;');
    End
    Else
    Begin
      If FListSettings.UseEnumerator Then
      Begin
        AList.Add('    Function  GetEnumerator() : I' + FClsName + 'Enumerator;');
        AList.Add('');
      End;

      AList.Add('    Function  Get(Index : Integer) : I' + FClsName + ';');
      AList.Add('    Procedure Put(Index : Integer; Const Item : I' + FClsName + ');');
      AList.Add('');
      AList.Add('    Function Add() : I' + FClsName + '; OverLoad;');
      AList.Add('    Function Add(Const AItem : I' + FClsName + ') : Integer; OverLoad;');
      AList.Add('');

      lLstHaveProc := False;
      For X := 0 To FListSettings.Methods.Count - 1 Do
        If FListSettings.Methods[X].ShowInInterface Then
        Begin
          AList.Add('    ' + FListSettings.Methods[X].GetProcedureDefinition(True, True));
          lLstHaveProc := True;
        End;

      If lLstHaveProc Then
        AList.Add('');      
      AList.Add('    Property Items[Index : Integer] : I' + FClsName + ' Read Get Write Put; Default;');
    End;
    AList.Add('');
    AList.Add('  End;');
    AList.Add('');
  End;
End;

Function THsClassCodeGenerator.GetFieldAssignType(APropertyType : THsPropertyType) : String;
Begin
  Case APropertyType Of
    ptByte, ptBoolean : Result := 'AsBoolean';
    ptInteger, ptAutoInc : Result := 'AsInteger';
    ptSingle, ptDouble, ptExtended : Result := 'AsFloat';
    ptCurrency : Result := 'AsCurrency';
    ptChar, ptString, ptWideString : Result := 'AsString';
    ptDate, ptTime, ptDateTime : Result := 'AsDateTime';
  End;
End;

Function THsClassCodeGenerator.GetLoadParamType(Const ALoadPrototype : String) : String;
Var X : Integer;
Begin
  Result := ALoadPrototype;
  For X := 0 To FPropertyDefs.Count - 1 Do
  Begin
    If FPropertyDefs[X].IsId Then
    Begin
      Case FPropertyDefs[X].PropertyType Of
        ptInteger, ptAutoInc : Result := StringReplace(Result, '%DataType%', 'Integer', [rfReplaceAll, rfIgnoreCase]);
        Else
          Result := StringReplace(Result, '%DataType%', 'String', [rfReplaceAll, rfIgnoreCase]);
      End;

      Break;
    End;
  End;

  Result := StringReplace(Result, '%DataType%', 'String', [rfReplaceAll, rfIgnoreCase]);
End;

Procedure THsClassCodeGenerator.GenerateClassDef(AList : TStringList);
Var lTmpList   : TStringList;
    X          : Integer;
    lPrivFunc  ,
    lProtFunc  ,
    lPublFunc  ,
    lSPrivFunc ,
    lSProtFunc : IHsProcedureDefs;
Begin
//FProcedureDefs.Count - 1

  lPrivFunc  := THsProcedureDefs.Create();
  lProtFunc  := THsProcedureDefs.Create();
  lPublFunc  := THsProcedureDefs.Create();
  lSPrivFunc := THsProcedureDefs.Create();
  lSProtFunc := THsProcedureDefs.Create();

  For X := 0 To FProcedureDefs.Count - 1 Do
    If FProcedureDefs[X].ProcedureScope = fsPrivate Then
      lPrivFunc.Add(FProcedureDefs[X])
    Else If FProcedureDefs[X].ProcedureScope = fsProtected Then
      lProtFunc.Add(FProcedureDefs[X])
    Else If FProcedureDefs[X].ProcedureScope = fsPublic Then
      lPublFunc.Add(FProcedureDefs[X])
    Else If FProcedureDefs[X].ProcedureScope = fsStrictPrivate Then
      lSPrivFunc.Add(FProcedureDefs[X])
    Else If FProcedureDefs[X].ProcedureScope = fsStrictProtected Then
      lSProtFunc.Add(FProcedureDefs[X]);

  If FMakeList And FListSettings.UseNestedClass And (FDataType = dsNone) Then
  Begin
    lTmpList := TStringList.Create();
    Try
      AList.Add('  T' + FClsName + 'List = Class(TInterfaceListEx, I' + FClsName + 's)');
      If FUseStrict Then
        AList.Add('  Strict Private Type')
      Else
        AList.Add('  Private Type');
  (**)
      If FListSettings.UseEnumerator Then
      Begin
        If FListSettings.IsSealed Then
          AList.Add('    T' + FClsName + 'Enumerator = Class Sealed(TInterfaceExEnumerator, I' + FClsName + 'Enumerator)')
        Else
          AList.Add('    T' + FClsName + 'Enumerator = Class(TInterfaceExEnumerator, I' + FClsName + 'Enumerator)');

        AList.Add('    Protected');
        AList.Add('      Function GetCurrent() : I' + FClsName + '; OverLoad;');
        AList.Add('');
        AList.Add('    End;');
        AList.Add('');
      End;

      If FListSettings.IsSealed Then
        AList.Add('    T' + FClsName + 'Item = Class Sealed(TInterfacedObjectEx, I' + FClsName + ')')
      Else
        AList.Add('    T' + FClsName + 'Item = Class(TInterfacedObjectEx, I' + FClsName + ')');

      If FUseStrict Then
        AList.Add('    Strict Private')
      Else
        AList.Add('    Private');

      lTmpList.Clear();

      If FTrackChange Then
        lTmpList.Add('      FDataState:TDataState;');

      For X := 0 To FPropertyDefs.Count - 1 Do
        lTmpList.Add('      ' + FPropertyDefs.Items[X].GetVariableDefinition());

      If lTmpList.Count > 0 Then
      Begin
        AlignVariables(lTmpList);

        For X := 0 To lTmpList.Count - 1 Do
          AList.Add(lTmpList[X]);

        AList.Add('');
      End;

      If lSPrivFunc.Count > 0 Then
      Begin
        If Not FUseStrict Then
          AList.Add('    Strict Private');

        For X := 0 To lSPrivFunc.Count - 1 Do
          AList.Add('      ' + lSPrivFunc[X].GetProcedureDefinition(True));
        AList.Add('');
      End;

      If lPrivFunc.Count > 0 Then
      Begin
        AList.Add('    Private');

        For X := 0 To lPrivFunc.Count - 1 Do
          AList.Add('      ' + lPrivFunc[X].GetProcedureDefinition(True));
        AList.Add('');
      End;

      If lSProtFunc.Count > 0 Then
      Begin
        AList.Add('    Strict Protected');

        For X := 0 To lSPrivFunc.Count - 1 Do
          AList.Add('      ' + lSPrivFunc[X].GetProcedureDefinition(True));
        AList.Add('');
      End;

      AList.Add('    Protected');
  //-->
      For X := 0 To FPropertyDefs.Count - 1 Do
        AList.Add(FPropertyDefs.Items[X].GetPropertyFunctions(True, True, False, False, 3));

      For X := 0 To lProtFunc.Count - 1 Do
        AList.Add('      ' + lProtFunc[X].GetProcedureDefinition(True));
      If lProtFunc.Count > 0 Then
        AList.Add('');
        
      If FTrackChange Then
      Begin
        AList.Add('      Procedure Changed();');
        AList.Add('      Function  GetModified() : Boolean;');
        AList.Add('');
      End;

      AList.Add('      Procedure Clear();');
      AList.Add('      Procedure Assign(ASource : TObject); ReIntroduce; Virtual;');

      If FPropertyDefs.HaveConstructor Or FPropertyDefs.HaveDestructor Then
      Begin
        AList.Add('');
        AList.Add('    Public');
      End;

      For X := 0 To lPublFunc.Count - 1 Do
        AList.Add('      ' + lPublFunc[X].GetProcedureDefinition(True));
      If lPublFunc.Count > 0 Then
        AList.Add('');

      If FPropertyDefs.HaveConstructor Then
        AList.Add('      Procedure AfterConstruction(); OverRide;');

      If FPropertyDefs.HaveDestructor And Not (FDataType In [dsXML]) Then
        AList.Add('      Procedure BeforeDestruction(); OverRide;');

      If FPropertyDefs.HaveConstructor Or FPropertyDefs.HaveDestructor Then
        AList.Add('');

      AList.Add('    End;');
      AList.Add('');
  (**)
      AList.Add('  Protected');
      AList.Add('    Function GetItemClass() : TInterfacedObjectExClass; OverRide;');
      If FListSettings.UseEnumerator Then
        AList.Add('    Function GetEnumerator() : I' + FClsName + 'Enumerator; OverLoad;');
      AList.Add('');
      AList.Add('    Function  Get(Index : Integer) : I' + FClsName + '; OverLoad;');
      AList.Add('    Procedure Put(Index : Integer; Const Item : I' + FClsName + '); OverLoad;');
      AList.Add('');
      AList.Add('    Function Add() : I' + FClsName + '; OverLoad;');
      AList.Add('    Function Add(Const AItem : I' + FClsName + ') : Integer; OverLoad;');
      AList.Add('');

      For X := 0 To FListSettings.Methods.Count - 1 Do
        AList.Add('    ' + FListSettings.Methods[X].GetProcedureDefinition(True));
      If FListSettings.Methods.Count > 0 Then
        AList.Add('');

      AList.Add('  End;');

      Finally
        lTmpList.Free();
    End;
  End
  Else
  Begin
    lTmpList := TStringList.Create();
    Try
      If FUseInterface Or (FDataType In [dsJSon, dsXML]) Then
      Begin
        If FInHeritsFrom <> '' Then
        Begin
          If FUseCustomClass Then
            AList.Add('  TCustom' + FClsName + ' = Class(' + FInHeritsFrom + ', I' + FClsName + ')')
          Else
            AList.Add('  T' + FClsName + ' = Class(' + FInHeritsFrom + ', I' + FClsName + ')')
        End
        Else Case FDataType Of
          dsJSon :
          Begin
            If FUseCustomClass Then
              AList.Add('  TCustom' + FClsName + ' = Class(TSuperObjectEx, I' + FClsName + ')')
            Else
              AList.Add('  T' + FClsName + ' = Class(TSuperObjectEx, I' + FClsName + ')');
          End;

          dsXML :
          Begin
            AList.Add('  T' + FClsName + ' = Class(TXmlNodeEx, I' + FClsName + ')');
          End;

          Else
            If FUseCustomClass Then
              AList.Add('  TCustom' + FClsName + ' = Class(TInterfacedObjectEx, I' + FClsName + ')')
            Else
              AList.Add('  T' + FClsName + ' = Class(TInterfacedObjectEx, I' + FClsName + ')');
        End;
      End
      Else
      Begin
        If FUseCustomClass Then
          AList.Add('  TCustom' + FClsName + ' = Class(TPersistent)')
        Else
          AList.Add('  T' + FClsName + ' = Class(TPersistent)');
      End;

      //Variables
      If Not (FDataType In [dsJSon, dsXML]) Then
      Begin
        If FUseStrict Then
          AList.Add('  Strict Private')
        Else
          AList.Add('  Private');

        lTmpList.Clear();
        For X := 0 To FPropertyDefs.Count - 1 Do
          lTmpList.Add('    ' + FPropertyDefs.Items[X].GetVariableDefinition());
      End;

      If FTrackChange Then
        lTmpList.Add('    FDataState:TDataState;');

      AlignVariables(lTmpList);
      For X := 0 To lTmpList.Count - 1 Do
        AList.Add(lTmpList[X]);

      For X := 0 To lPrivFunc.Count - 1 Do
        AList.Add(PadL('', 4) + lPrivFunc[X].GetProcedureDefinition(True));

      If Not (FDataType In [dsJSon, dsXML]) Or FTrackChange Then
        AList.Add('');
      If Not FUseInterface And FUseStrict Then
        AList.Add('  Strict Protected')
      Else
        AList.Add('  Protected');

      For X := 0 To FPropertyDefs.Count - 1 Do
      Begin
        If Trim(FPropertyDefs.Items[X].GetPropertyFunctions(
          FUseInterface Or (FDataType In [dsJSon, dsXML]),
          FUseInterface Or FTrackChange Or (FDataType In [dsJSon, dsXML]),
          True, False, 2)) <> '' Then
          AList.Add(FPropertyDefs.Items[X].GetPropertyFunctions(
            FUseInterface Or (FDataType In [dsJSon, dsXML]),
            FUseInterface Or FTrackChange Or (FDataType In [dsJSon, dsXML]),
            True, False, 2));
      End;

      If FTrackChange Then
      Begin
        AList.Add('    Procedure Changed(); Virtual;');
        AList.Add('    Function  GetModified() : Boolean;');
      End;
      AList.Add('    Procedure Clear();');
      AList.Add('');

      For X := 0 To lProtFunc.Count - 1 Do
        AList.Add(PadL('', 4) + lProtFunc[X].GetProcedureDefinition(True));

      If lProtFunc.Count > 0 Then
        AList.Add('');
      
      //If Not (FDataType In [dsJSon, dsXML]) Then
      Begin
        If Not FUseCustomClass Then
          AList.Add('  Published');

        lTmpList.Clear();
        For X := 0 To FPropertyDefs.Count - 1 Do
          lTmpList.Add('    ' + FPropertyDefs.Items[X].GetPropertyDefinition(
            FUseInterface Or (FDataType In [dsJSon, dsXML]),
            FUseInterface Or FTrackChange Or (FDataType In [dsJSon, dsXML])));
      End;

      AlignProperties(lTmpList);
      For X := 0 To lTmpList.Count - 1 Do
        AList.Add(lTmpList[X]);

      AList.Add('');
      AList.Add('  Public');
      If FDataType = dsMSSql Then
      Begin
        AList.Add('    Procedure New();');
        AList.Add(GetLoadParamType('    Procedure Load(AId : %DataType%);'));
        AList.Add('    Procedure Save();');
        AList.Add('    Procedure Delete();');
        AList.Add('    Procedure CreateTable();');
      End;
      AList.Add('    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;');
      AList.Add('');

      For X := 0 To lPublFunc.Count - 1 Do
        AList.Add(PadL('', 4) + lPublFunc[X].GetProcedureDefinition(True));

      If lPublFunc.Count > 0 Then
        AList.Add('');

      If FPropertyDefs.HaveConstructor Then
      Begin
        If FDataType In [dsJSon, dsXML] Then
          AList.Add('    Procedure AfterConstruction(); OverRide;')
        Else
          AList.Add('    Constructor Create(); ReIntroduce; Virtual;');

        AList.Add('');
      End;

      If FPropertyDefs.HaveDestructor And Not (FDataType In [dsXML]) Then
      Begin
        AList.Add('    Destructor Destroy(); OverRide;');
        AList.Add('');
      End;

      AList.Add('  End;');

      If FUseCustomClass {And Not (FDataType In [dsJSon, dsXML])} Then
      Begin
        AList.Add('');

        AList.Add('  T' + FClsName + ' = Class(TCustom' + FClsName + ')');
        AList.Add('  Published');
        For X := 0 To FPropertyDefs.Count - 1 Do
          AList.Add('    Property ' + FPropertyDefs[X].PropertyName + ';');
        AList.Add('');
        AList.Add('  End;');
      End;

      {$Region ' Lists '}
      If FMakeList Then
      Begin
        If FListSettings.UseEnumerator And (FDataType = dsNone) Then
        Begin
          AList.Add('');
          AList.Add('  T' + FClsName + 'Enumerator = Class(TInterfaceExEnumerator, I' + FClsName + 'Enumerator)');
          AList.Add('  Protected');
          AList.Add('    Function GetCurrent() : I' + FClsName + '; OverLoad;');
          AList.Add('');
          AList.Add('  End;');
        End;

        AList.Add('');

        If FDataType = dsJSon Then
        Begin
          AList.Add('  T' + FClsName + 's = Class(TSuperObjectExList, I' + FClsName + 's)');
          AList.Add('  Protected');
          AList.Add('    Function GetItemClass() : TSuperObjectExClass; OverRide;');
          AList.Add('    Function GetItem(Const Index : Integer) : I' + FClsName + '; OverLoad;');
          AList.Add('');
          AList.Add('  Public');
          AList.Add('    Function Add() : I' + FClsName + '; OverLoad;');
          AList.Add('    Function Add(Const AItem : I' + FClsName + ') : Integer; OverLoad;');
          AList.Add('');
          AList.Add('    Property Items[Const Index: Integer] : I' + FClsName + ' Read MyGetItem; Default;');
          AList.Add('');
          AList.Add('  End;');
        End
        Else If FDataType = dsXML Then
        Begin
          AList.Add('  T' + FClsName + 's = Class(TXMLNodeCollectionEx, I' + FClsName + 's)');
          AList.Add('  Protected');
          AList.Add('    Function GetItem(Const Index : Integer) : I' + FClsName + ';');
          AList.Add('');
          AList.Add('    Function Add() : I' + FClsName + ';');
          AList.Add('    Function Insert(Const Index : Integer) : I' + FClsName + ';');
          AList.Add('');
          AList.Add('  Public');
          AList.Add('    Procedure AfterConstruction(); OverRide;');
          AList.Add('');
          AList.Add('  End;');
        End
        Else If FUseInterface Then
        Begin
          AList.Add('  T' + FClsName + 's = Class(TInterfaceListEx, I' + FClsName + 's)');
          AList.Add('  Protected');
          AList.Add('    Function GetItemClass() : TInterfacedObjectExClass; OverRide;');
          If FListSettings.UseEnumerator Then
            AList.Add('    Function GetEnumerator() : I' + FClsName + 'Enumerator; OverLoad;');
          AList.Add('');
          AList.Add('    Function  Get(Index : Integer) : I' + FClsName + '; OverLoad;');
          AList.Add('    Procedure Put(Index : Integer; Const Item : I' + FClsName + '); OverLoad;');
          AList.Add('');
          AList.Add('    Function Add() : I' + FClsName + '; OverLoad;');
          AList.Add('    Function Add(Const AItem : I' + FClsName + ') : Integer; OverLoad;');
          AList.Add('');
          AList.Add('  End;');
        End
        Else
        Begin
          AList.Add('  T' + FClsName + 's = Class(TObjectList)');
          AList.Add('  Protected');
          AList.Add('    Function  GetItem(Index : Integer) : T' + FClsName + ';');
          AList.Add('    Procedure SetItem(Index : Integer; Const Item: T' + FClsName + ');');
          AList.Add('');
          AList.Add('  Public');
          AList.Add('    Property Items[Index : Integer] : T' + FClsName + ' Read GetItem Write SetItem; Default;');
          AList.Add('');
          AList.Add('  End;');
        End;
      End;
      {$EndRegion}

      Finally
        lTmpList.Free();

        lPrivFunc := Nil;
        lProtFunc := Nil;
        lPublFunc := Nil;
    End;
  End;
End;

Procedure THsClassCodeGenerator.GenerateClassImpl(AList : TStringList);
Var lClsName : String;
    lTmpList : TStringList;
    X        : Integer;
Begin
  lTmpList := TStringList.Create();
  Try
    If FMakeList And FListSettings.UseNestedClass Then
    Begin
      FUseCustomClass := False;
      FUseInterface   := True;
      FDataType       := dsNone;
    End;

    Begin
      If FUseCustomClass Then
        lClsName := 'Custom';
      lClsName := lClsName + FClsName;

      {$Region ' Constructor / Destructor '}
      If FPropertyDefs.HaveConstructor Then
      Begin
        If (FDataType In [dsJSon, dsXML]) Or FListSettings.UseNestedClass Then
        Begin
          If FListSettings.UseNestedClass Then
            AList.Add('Procedure T' + FClsName + 'List.T' + FClsName + 'Item.AfterConstruction();')
          Else
            AList.Add('Procedure T' + lClsName + '.AfterConstruction();');
          AList.Add('Begin');
          AList.Add('  InHerited AfterConstruction();');
        End
        Else
        Begin
          AList.Add('Constructor T' + lClsName + '.Create();');
          AList.Add('Begin');
          AList.Add('  InHerited Create();');
        End;

        AList.Add('');
        For X := 0 To FPropertyDefs.Count - 1 Do
          Case FPropertyDefs[X].PropertyType Of
            ptObject :
              lTmpList.Add('  F' +
                FPropertyDefs[X].PropertyName + ':=' +
                FPropertyDefs[X].PropertyClass + '.Create();');
            ptInterface :
            Begin
              If FDataType = dsJSon Then
              Begin
                lTmpList.Add('  O[''' +
                  FPropertyDefs[X].PropertyName + ''']:=' +
                  FPropertyDefs[X].InterfaceImplementor +
                  '.Create() As ' + FPropertyDefs[X].InterfaceName + ';');
              End
              Else If FDataType <> dsXML Then
                lTmpList.Add('  F' +
                  FPropertyDefs[X].PropertyName + ':=' +
                  FPropertyDefs[X].InterfaceImplementor + '.Create();');
            End;
            ptStringList :
              lTmpList.Add('  F' + FPropertyDefs[X].PropertyName + ':=TStringList.Create();');
          End;

        AlignVariableAssign(lTmpList);
        For X := 0 To lTmpList.Count - 1 Do
          AList.Add(lTmpList[X]);

        For X := 0 To FPropertyDefs.Count - 1 Do
          Case FPropertyDefs[X].PropertyType Of
            ptObject : ;

            ptInterface :
            Begin
              If FDataType In [dsXML, dsJSon] Then
                AList.Add('  RegisterChildNode(''' + FPropertyDefs[X].PropertyName + ''', ' + FPropertyDefs[X].InterfaceImplementor + ');');
            End;
          End;
        AList.Add('End;');
        AList.Add('');
      End;

      If FPropertyDefs.HaveDestructor And Not (FDataType In [dsXML]) Then
      Begin
        If FListSettings.UseNestedClass Then
          AList.Add('Procedure T' + FClsName + 'List.T' + FClsName + 'Item.BeforeDestruction();')
        Else
          AList.Add('Destructor T' + lClsName + '.Destroy();');
        AList.Add('Begin');
        For X := 0 To FPropertyDefs.Count - 1 Do
          Case FPropertyDefs[X].PropertyType Of
            ptObject, ptStringList :
            Begin
              AList.Add('  If Assigned(F' + FPropertyDefs[X].PropertyName + ') Then');
              AList.Add('    FreeAndNil(F' + FPropertyDefs[X].PropertyName + ');');
            End;
            ptInterface :
            Begin
              Case FDataType Of
                dsJSon :
                Begin
                  AList.Add('  O[''' +
                    FPropertyDefs[X].PropertyName + '''] := Nil;');
                End
                Else
                  AList.Add('  F' +
                    FPropertyDefs[X].PropertyName + ' := Nil;');
              End;
            End;
          End;
        AList.Add('');

        If FListSettings.UseNestedClass Then
          AList.Add('  InHerited BeforeDestruction();')
        Else
          AList.Add('  InHerited Destroy();');
        AList.Add('End;');
        AList.Add('');
      End;
      {$EndRegion}

      If FTrackChange Then
      Begin
        If FListSettings.UseNestedClass Then
          AList.Add('Procedure T' + FClsName + 'List.T' + FClsName + 'Item.Changed();')
        Else
          AList.Add('Procedure T' + lClsName + '.Changed();');

        AList.Add('Begin');
        AList.Add('  Case FDataState Of');
        AList.Add('    edsBrowse : FDataState := edsModified;');
        AList.Add('  End;');
        AList.Add('End;');
        AList.Add('');

        If FListSettings.UseNestedClass Then
          AList.Add('Function T' + FClsName + 'List.T' + FClsName + 'Item.GetModified() : Boolean;')
        Else
          AList.Add('Function T' + lClsName + '.GetModified() : Boolean;');
        AList.Add('Begin');
        AList.Add('  Result := FDataState <> edsBrowse;');
        AList.Add('End;');
        AList.Add('');
      End;

      lTmpList.Clear();
      If FListSettings.UseNestedClass Then
        AList.Add('Procedure T' + FClsName + 'List.T' + FClsName + 'Item.Clear();')
      Else
        AList.Add('Procedure T' + lClsName + '.Clear();');

      AList.Add('Begin');
      If FDataType = dsJSon Then
      Begin
        For X := 0 To FPropertyDefs.Count - 1 Do
          Case FPropertyDefs[X].PropertyType Of
            ptByte, ptInteger, ptSingle : lTmpList.Add('I[''' + FPropertyDefs[X].PropertyName + ''']:=0;');
            ptDouble, ptExtended : lTmpList.Add('D[''' + FPropertyDefs[X].PropertyName + ''']:=0;');
            ptCurrency : lTmpList.Add('C[''' + FPropertyDefs[X].PropertyName + ''']:=0;');
            ptDate, ptTime, ptDateTime : ;
            ptChar, ptString, ptWideString : lTmpList.Add('S[''' + FPropertyDefs[X].PropertyName + ''']:='''';');
            ptBoolean : lTmpList.Add('B[''' + FPropertyDefs[X].PropertyName + ''']:=False;');
            ptObject :
              lTmpList.Add('O[''' + FPropertyDefs[X].PropertyName + ''']:=' +
                FPropertyDefs[X].PropertyClass + '.Create();');
            ptInterface :
              lTmpList.Add('O[''' + FPropertyDefs[X].PropertyName + ''']:=' +
                FPropertyDefs[X].InterfaceImplementor + '.Create() As ' +
                FPropertyDefs[X].InterfaceName + ';'
              );
          End;
      End
      Else If FDataType = dsXML Then
      Begin
        For X := 0 To FPropertyDefs.Count - 1 Do
          lTmpList.Add('ChildNodes[''' + FPropertyDefs[X].PropertyName + '''].NodeValue:=Null;');
      End
      Else
      Begin
        For X := 0 To FPropertyDefs.Count - 1 Do
          Case FPropertyDefs[X].PropertyType Of
            ptByte, ptInteger, ptSingle,
            ptDouble, ptExtended, ptCurrency,
            ptDate, ptTime, ptDateTime,
            ptWord, ptDWord, ptQWord : lTmpList.Add('F' + FPropertyDefs[X].PropertyName + ':=0;');
            ptChar : lTmpList.Add('F' + FPropertyDefs[X].PropertyName + ':=#0;');
            ptString, ptWideString : lTmpList.Add('F' + FPropertyDefs[X].PropertyName + ':='''';');
            ptBoolean : lTmpList.Add('F' + FPropertyDefs[X].PropertyName + ':=False;');
          End;
      End;

      AlignVariableAssign(lTmpList);
      For X := 0 To lTmpList.Count - 1 Do
        AList.Add(lTmpList[X]);

      AList.Add('End;');
      AList.Add('');
    
      {$Region ' MsSql Procs '}
      If FDataType In [dsMSSql] Then
      Begin
        AList.Add('Procedure T' + lClsName + '.New();');
        AList.Add('Begin');
        AList.Add('  Clear();');
        If FTrackChange Then
          AList.Add('  FDataState := edsAdded;');
        AList.Add('End;');
        AList.Add('');

        For X := 0 To FPropertyDefs.Count - 1 Do
          If FPropertyDefs[X].IsId Then
          Begin
            Case FPropertyDefs[X].PropertyType Of
              ptInteger : AList.Add('Procedure T' + lClsName + '.Load(AId : Integer);');
              ptString  : AList.Add('Procedure T' + lClsName + '.Load(AId : String);');
            End;

            Break;
          End;

  //      AList.Add(GetLoadParamType('Procedure T' + lClsName + '.Load(AId : %DataType%);'));
        AList.Add(GetLoadParamType('Procedure T' + lClsName + '.Load(AId : %DataType%);'));
        AList.Add('Begin');
        lTmpList.Clear();
        If FDataType = dsMSSql Then
        Begin
          GenerateMSSqlLoadCode(lTmpList);
          For X := 0 To lTmpList.Count - 1 Do
            AList.Add(lTmpList[X]);
        End;
        AList.Add('End;');
        AList.Add('');

        AList.Add('Procedure T' + lClsName + '.Save();');
        AList.Add('Begin');
        lTmpList.Clear();
        If FDataType = dsMSSql Then
        Begin
          GenerateMSSqlSaveCode(lTmpList);
          For X := 0 To lTmpList.Count - 1 Do
            AList.Add(lTmpList[X]);
        End;
        AList.Add('End;');
        AList.Add('');

        AList.Add('Procedure T' + lClsName + '.Delete();');
        AList.Add('Begin');
        AList.Add('  FDataState := edsDeleted;');
        AList.Add('End;');
        AList.Add('');

        AList.Add('Procedure T' + lClsName + '.CreateTable();');
        AList.Add('Begin');
        lTmpList.Clear();
        If FDataType = dsMSSql Then
        Begin
          GenerateMSSqlCreateTableCode(lTmpList);
          For X := 0 To lTmpList.Count - 1 Do
            AList.Add(lTmpList[X]);
        End;
        AList.Add('End;');
        AList.Add('');
      End;
      {$EndRegion}

      If FListSettings.UseNestedClass Then
        AList.Add('Procedure T' + FClsName + 'List.T' + FClsName + 'Item.Assign(ASource : TObject);')
      Else
        AList.Add('Procedure T' + lClsName + '.Assign(ASource : TObject);');

      lTmpList.Clear();
      If FDataType In [dsJSon] Then
      Begin
        lTmpList.Add('Var lSrc:T' + lClsName + ';');
      End
      Else
      Begin
        lTmpList.Add('Var lSrc:T' + lClsName + ';');
        If FDataType = dsMSSql Then
          lTmpList.Add('    lFields:TFields;');
      End;

      AlignVariables(lTmpList);
      For X := 0 To lTmpList.Count - 1 Do
        AList.Add(lTmpList[X]);

      AList.Add('Begin');
      AList.Add('  If ASource Is T' + lClsName + ' Then');
      AList.Add('  Begin');
      AList.Add('    lSrc := T' + lClsName + '(ASource);');
      AList.Add('');

      If FDataType = dsJSon Then
      Begin
        lTmpList.Clear();
        For X := 0 To FPropertyDefs.Count - 1 Do
          Case FPropertyDefs[X].PropertyType Of
            ptByte, ptInteger, ptSingle : lTmpList.Add('I[''' + FPropertyDefs[X].PropertyName + ''']:=lSrc.' + FPropertyDefs[X].PropertyName + ';');
            ptDouble, ptExtended : lTmpList.Add('D[''' + FPropertyDefs[X].PropertyName + ''']:=lSrc.' + FPropertyDefs[X].PropertyName + ';');
            ptCurrency : lTmpList.Add('C[''' + FPropertyDefs[X].PropertyName + ''']:=lSrc.' + FPropertyDefs[X].PropertyName + ';');
            ptDate, ptTime, ptDateTime : ;
            ptChar, ptString, ptWideString : lTmpList.Add('S[''' + FPropertyDefs[X].PropertyName + ''']:=lSrc.' + FPropertyDefs[X].PropertyName + ';');
            ptBoolean : lTmpList.Add('B[''' + FPropertyDefs[X].PropertyName + ''']:=lSrc.' + FPropertyDefs[X].PropertyName + ';');
          End;
      End
      Else If FDataType = dsXML Then
      Begin
        lTmpList.Clear();
        For X := 0 To FPropertyDefs.Count - 1 Do
          lTmpList.Add('ChildNodes[''' + FPropertyDefs[X].PropertyName + '''].NodeValue:=lSrc.' + FPropertyDefs[X].PropertyName + ';');
      End
      Else
      Begin
        lTmpList.Clear();
        For X := 0 To FPropertyDefs.Count - 1 Do
          lTmpList.Add('F' + FPropertyDefs[X].PropertyName + ':=lSrc.' + FPropertyDefs[X].PropertyName + ';');
      End;

      AlignVariableAssign(lTmpList);
      For X := 0 To lTmpList.Count - 1 Do
        AList.Add('  ' + lTmpList[X]);
      AList.Add('  End');

      If FDataType = dsMSSql Then
      Begin
        AList.Add('  Else If ASource Is TFields Then');
        AList.Add('  Begin');
        AList.Add('    lFields := TFields(ASource);');
        AList.Add('');
        lTmpList.Clear();
        For X := 0 To FPropertyDefs.Count - 1 Do
          If FPropertyDefs[X].IsDataAware Then
            lTmpList.Add( 'F' + FPropertyDefs[X].PropertyName +
                          ':=lFields.FieldByName(''' +
                          FPropertyDefs[X].FieldName + ''').' +
                          GetFieldAssignType(FPropertyDefs[X].PropertyType) + ';');

        AlignVariableAssign(lTmpList);
        For X := 0 To lTmpList.Count - 1 Do
          AList.Add('  ' + lTmpList[X]);
        AList.Add('  End');
      End;
      AList.Add('  Else'); //EConvertError -> SysUtils, SAssignError -> RTLConst
      AList.Add('    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);');
      AList.Add('End;');
      AList.Add('');

      For X := 0 To FProcedureDefs.Count - 1 Do
      Begin
        If FListSettings.UseNestedClass Then
          AList.Add(StringReplace(FProcedureDefs[X].GetProcedureDefinition(False), '%ClassName%', 'T' + FClsName + 'List.T' + FClsName + 'Item', [rfReplaceAll, rfIgnoreCase]))
        Else
          AList.Add(StringReplace(FProcedureDefs[X].GetProcedureDefinition(False), '%ClassName%', lClsName, [rfReplaceAll, rfIgnoreCase]));
        AList.Add(FProcedureDefs[X].ProcedureImpl.Text);
      End;

      lTmpList.Clear();
      For X := 0 To FPropertyDefs.Count - 1 Do
        If Trim(FPropertyDefs.Items[X].GetPropertyFunctionImplementation(
          FUseInterface Or (FDataType In [dsJSon, dsXml]),
          FUseInterface Or FTrackChange Or (FDataType In [dsJSon, dsXml]),
          FTrackChange, FDataType)) <> '' Then
          If FListSettings.UseNestedClass Then
            lTmpList.Add(StringReplace(FPropertyDefs.Items[X].GetPropertyFunctionImplementation(
              FUseInterface Or (FDataType In [dsJSon, dsXml]),
              FUseInterface Or FTrackChange Or (FDataType In [dsJSon, dsXml]),
              FTrackChange, FDataType), '%ClassName%', FClsName + 'List.T' + FClsName + 'Item', [rfReplaceAll, rfIgnoreCase]))
          Else
            lTmpList.Add(StringReplace(FPropertyDefs.Items[X].GetPropertyFunctionImplementation(
              FUseInterface Or (FDataType In [dsJSon, dsXml]),
              FUseInterface Or FTrackChange Or (FDataType In [dsJSon, dsXml]),
              FTrackChange, FDataType), '%ClassName%', lClsName, [rfReplaceAll, rfIgnoreCase]));

      //AddFormat
      For X := 0 To lTmpList.Count - 1 Do
        AList.Add(lTmpList[X]);

      {$Region ' Lists '}
      If FMakeList Then
      Begin
        If FDataType = dsJSon Then
        Begin
          AList.Add('Function T' + FClsName + 's.Add() : I' + FClsName + ';');
          AList.Add('Begin');
          AList.Add('  Result := T' + FClsName + '.Create(stObject);');
          AList.Add('  InHerited Add(Result);');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + FClsName + 's.Add(Const AItem : I' + FClsName + ') : Integer;');
          AList.Add('Begin');
          AList.Add('  Result := InHerited Add(AItem);');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + FClsName + 's.GetItemClass() : TSuperObjectExClass;');
          AList.Add('Begin');
          AList.Add('  Result := T' + FClsName + ';');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + FClsName + 's.GetItem(Const Index : Integer) : I' + FClsName + ';');
          AList.Add('Begin');
          AList.Add('  Result := InHerited Items[Index] As I' + FClsName + ';');
          AList.Add('End;');
        End
        Else If FDataType = dsXML Then
        Begin
          AList.Add('Procedure T' + FClsName + 's.AfterConstruction();');
          AList.Add('Begin');
          AList.Add('  RegisterChildNode(''' + FClsName + ''', T' + FClsName + ');');
          AList.Add('  ItemTag       := ''' + FClsName + ''';');
          AList.Add('  ItemInterface := I' + FClsName + ';');
          AList.Add('');
          AList.Add('  InHerited AfterConstruction();');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + FClsName + 's.GetItem(Const Index : Integer) : I' + FClsName + ';');
          AList.Add('Begin');
          AList.Add('  Result := List[Index] As I' + FClsName  + ';');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + FClsName + 's.Add() : I' + FClsName + ';');
          AList.Add('Begin');
          AList.Add('  Result := AddItem(-1) As I' + FClsName + ';');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + FClsName + 's.Insert(Const Index : Integer) : I' + FClsName + ';');
          AList.Add('Begin');
          AList.Add('  Result := AddItem(Index) As I' + FClsName + ';');
          AList.Add('End;');
        End
        Else If FUseInterface Then
        Begin
          If FListSettings.UseEnumerator Then
          Begin
            If FListSettings.UseNestedClass Then
              AList.Add('Function T' + FClsName + 'List.T' + FClsName + 'Enumerator.GetCurrent() : I' + FClsName + ';')
            Else
              AList.Add('Function T' + FClsName + 'Enumerator.GetCurrent() : I' + FClsName + ';');
            AList.Add('Begin');
            AList.Add('  Result := InHerited Current As I' + FClsName + ';');
            AList.Add('End;');
            AList.Add('');

            If FListSettings.UseNestedClass Then
              AList.Add('Function T' + FClsName + 'List.GetEnumerator() : I' + FClsName + 'Enumerator;')
            Else
              AList.Add('Function T' + FClsName + 's.GetEnumerator() : I' + FClsName + 'Enumerator;');

            AList.Add('Begin');
            AList.Add('  Result := T' + FClsName + 'Enumerator.Create(Self);');
            AList.Add('End;');
            AList.Add('');
          End;

          If FListSettings.UseNestedClass Then
            lClsName := FClsName + 'List'
          Else
            lClsName := FClsName + 's';

          AList.Add('Function T' + lClsName + '.GetItemClass() : TInterfacedObjectExClass;');
          AList.Add('Begin');
          AList.Add('  Result := T' + FClsName + ';');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + lClsName + '.Get(Index : Integer) : I' + FClsName + ';');
          AList.Add('Begin');
          AList.Add('  Result := InHerited Items[Index] As I' + FClsName + ';');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Procedure T' + lClsName + '.Put(Index : Integer; Const Item : I' + FClsName + ');');
          AList.Add('Begin');
          AList.Add('  InHerited Items[Index] := Item;');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + lClsName + '.Add() : I' + FClsName + ';');
          AList.Add('Begin');
          AList.Add('  Result := InHerited Add() As I' + FClsName + ';');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Function T' + lClsName + '.Add(Const AItem : I' + FClsName + ') : Integer;');
          AList.Add('Begin');
          AList.Add('  Result := InHerited Add(AItem);');
          AList.Add('End;');
          AList.Add('');
          For X := 0 To FListSettings.Methods.Count - 1 Do
          Begin
            AList.Add(StringReplace(FProcedureDefs[X].GetProcedureDefinition(False), '%ClassName%', lClsName, [rfReplaceAll, rfIgnoreCase]));
            AList.Add(FProcedureDefs[X].ProcedureImpl.Text);
            AList.Add('');
          End;
        End
        Else
        Begin
          AList.Add('Function T' + FClsName + 's.GetItem(Index : Integer) : T' + FClsName + ';');
          AList.Add('Begin');
          AList.Add('  Result := InHerited Items[Index] As T' + FClsName + ';');
          AList.Add('End;');
          AList.Add('');
          AList.Add('Procedure T' + FClsName + 's.SetItem(Index : Integer; Const Item : T' + FClsName + ');');
          AList.Add('Begin');
          AList.Add('  InHerited Items[Index] := Item;');
          AList.Add('End;');
        End;
      End;
      {$EndRegion}
    End;

    Finally
      lTmpList.Free();
  End;
End;

Procedure THsClassCodeGenerator.GenerateMSSqlLoadCode(AList : TStringList);
Var X : Integer;
Begin
  AList.Add('  With ' + FAdoQueryClassName + '.Create(Nil) Do');
  AList.Add('  Try');
  AList.Add('    Sql.Text := ''Select *''#$D#$A + ');
  AList.Add('                ''From ' + FTableName + '''#$D#$A + ');

  For X := 0 To FPropertyDefs.Count - 1 Do
    If FPropertyDefs[X].IsId Then
    Begin
      AList.Add( '                ''Where ' +
                 FPropertyDefs[X].FieldName + ' = :' +
                 FPropertyDefs[X].PropertyName + ''';'
                 );
      AList.Add('');
      AList.Add( '    Parameters.ParamByName(''' +
                 FPropertyDefs[X].PropertyName + ''').Value := AId;');

      Break;
    End;

  AList.Add('    Open();');
  AList.Add('');
  AList.Add('    If Not IsEmpty Then');
  AList.Add('      Self.Assign(Fields);');
  AList.Add('');
  AList.Add('    Finally');
  AList.Add('      Close();');
  AList.Add('      Free();');
  AList.Add('  End;');
End;

Procedure THsClassCodeGenerator.GenerateMSSqlSaveCode(AList : TStringList);
Var X           : Integer;
    lTmpList    : TStringList;
    lProps      : IHsPropertyDefs;
    lPrimaryKey : IHsPropertyDef;
Begin
  lProps := THsPropertyDefs.Create();
  Try
    For X := 0 To FPropertyDefs.Count - 1 Do
    Begin
      If FPropertyDefs[X].IsDataAware Then
        lProps.Add(FPropertyDefs[X]);
      If FPropertyDefs[X].IsId Then
        lPrimaryKey := FPropertyDefs[X];
    End;
    AList.Add('  If FDataState > edsBrowse Then');
    AList.Add('    With ' + FAdoQueryClassName + '.Create(Nil) Do');
    AList.Add('    Try');
    AList.Add('      If FDataState In [edsAdded, edsModified] Then');
    AList.Add('      Begin');
    AList.Add('        Case FDataState Of');
    AList.Add('          edsAdded :');
    AList.Add('          Begin');

    //InsertQuery
    AList.Add('            Sql.Text := ''Insert Into ' + FTableName + ' (''#$D#$A + ');
    For X := 0 To lProps.Count - 1 Do
    Begin
      If lProps[X].PropertyType <> ptAutoInc Then
      Begin
        If X < lProps.Count - 1 Then
          AList.Add('                        ''' + lProps[X].FieldName + ',''#$D#$A + ')
        Else
          AList.Add('                        ''' + lProps[X].FieldName + '''#$D#$A + ');
      End;
    End;

    AList.Add('                        '') Values (''#$D#$A +');
    For X := 0 To lProps.Count - 1 Do
    Begin
      If lProps[X].PropertyType <> ptAutoInc Then
      Begin
        If X < lProps.Count - 1 Then
          AList.Add('                        '':' + lProps[X].PropertyName + ',''#$D#$A + ')
        Else
        Begin
          If Assigned(lPrimaryKey) And (lPrimaryKey.PropertyType = ptAutoInc) Then
          Begin
            AList.Add('                        '':' + lProps[X].PropertyName + ')''#$D#$A + ');
            AList.Add('                        ''Select Scope_Identity() LastAutoIncValue'';');
          End
          Else
            AList.Add('                        '':' + lProps[X].PropertyName + ')'';');
        End;
      End;
    End;

    AList.Add('          End;');
    AList.Add('');
    AList.Add('          edsModified :');
    AList.Add('          Begin');
    //UpdateQuery
    AList.Add('            Sql.Text := ''Update ' + FTableName + ' Set''#$D#$A + ');
    For X := 0 To lProps.Count - 1 Do
      If Not lProps[X].IsId Then
      Begin
        If X < lProps.Count - 1 Then
          AList.Add('                        ''' + lProps[X].FieldName + ' = :' + lProps[X].PropertyName + ',''#$D#$A + ')
        Else
          AList.Add('                        ''' + lProps[X].FieldName + ' = :' + lProps[X].PropertyName + '''#$D#$A + ');
      End;

    If Assigned(lPrimaryKey) Then
    Begin
      AList.Add('                        ''Where ' + lPrimaryKey.FieldName + ' = :' + lPrimaryKey.PropertyName + ''';');
      AList.Add('');
      AList.Add('            Parameters.ParamByName(''' + lPrimaryKey.PropertyName + ''').Value := F' + lPrimaryKey.PropertyName + ';');
    End;

    AList.Add('          End;');
    AList.Add('        End;');
    AList.Add('');

    //ParamAssign
    lTmpList := TStringList.Create();
    Try
      For X := 0 To lProps.Count - 1 Do
      Begin
        If (lProps[X].PropertyType <> ptAutoInc) Then
          lTmpList.Add('Parameters.ParamByName(''' + lProps[X].PropertyName + ''').Value:=F' + lProps[X].PropertyName + ';');
      End;
      AlignVariableAssign(lTmpList);
      For X := 0 To lTmpList.Count - 1 Do
        AList.Add('      ' + lTmpList[X]);
      Finally
        lTmpList.Free();
    End;

    AList.Add('      End');
    AList.Add('      Else If FDataState = edsDeleted Then');
    AList.Add('      Begin');
    //DeleteQuery
    AList.Add('        Sql.Text := ''Delete From ' + FTableName + '''#$D#$A + ');
    If Assigned(lPrimaryKey) Then
    Begin
      AList.Add('                    ''Where ' + lPrimaryKey.FieldName + ' = :' + lPrimaryKey.PropertyName + ''';');
      AList.Add('        Parameters.ParamByName(''' + lPrimaryKey.PropertyName + ''').Value := F' + lPrimaryKey.PropertyName + ';');
    End;
    AList.Add('      End;');
    AList.Add('');

    If Assigned(lPrimaryKey) And
       (lPrimaryKey.PropertyType = ptAutoInc) Then
    Begin
      AList.Add(PadL('', 6) + 'If FDataState = edsAdded Then');
      AList.Add(PadL('', 6) + 'Begin');
      AList.Add(PadL('', 6) + '  Open();');
      AList.Add(PadL('', 6) + '  F' + lPrimaryKey.PropertyName + ' := FieldByName(''LastAutoIncValue'').AsInteger;');
      AList.Add(PadL('', 6) + 'End');
      AList.Add(PadL('', 6) + 'Else');
      AList.Add(PadL('', 6) + '  ExecSql();');
    End
    Else
      AList.Add('      ExecSql();');

    AList.Add('');
    AList.Add('      Finally');
    AList.Add('        Free();');
    AList.Add('    End;');

    Finally
      lProps := Nil
  End;
End;

Procedure THsClassCodeGenerator.GenerateMSSqlCreateTableCode(AList : TStringList);
  Function GetFieldType(APropertyType : THsPropertyType) : String;
  Begin
    Case APropertyType Of
      ptByte : Result := 'SmallInt';
      ptBoolean : Result := 'Bit';
      ptInteger :  Result := 'Integer';
      ptAutoInc : Result := 'Integer Identity(1, 1)';
      ptSingle, ptDouble, ptExtended : Result := 'Float';
      ptCurrency : Result := 'Money';
      ptChar, ptString, ptWideString : Result := 'VarChar';
      ptDate, ptTime, ptDateTime : Result := 'DateTime';
    End;
  End;

Var lProps      : IHsPropertyDefs;
    lPrimaryKey : IHsPropertyDef;
    X           : Integer;
    lStr        : String;
Begin
  lProps := THsPropertyDefs.Create();
  Try
    For X := 0 To FPropertyDefs.Count - 1 Do
    Begin
      If FPropertyDefs[X].IsDataAware Then
        lProps.Add(FPropertyDefs[X]);
      If FPropertyDefs[X].IsId Then
        lPrimaryKey := FPropertyDefs[X];
    End;

    AList.Add('  With ' + FAdoQueryClassName + '.Create(Nil) Do');
    AList.Add('  Try');
    AList.Add('    Sql.Text := ''Create Table ' + FTableName + ' (''#$D#$A + ');

    For X := 0 To lProps.Count - 1 Do
    Begin
      lStr := '                ''  ' + lProps[X].FieldName + ' ' + GetFieldType(lProps[X].PropertyType);
      If lProps[X].PropertyType In [ptChar, ptString, ptWideString] Then
      Begin
        If lProps[X].MaxLen > 0 Then
          lStr := lStr + '(' + IntToStr(lProps[X].MaxLen) + ')'
        Else
          lStr := lStr + '(Max)';
      End;

      If (X < lProps.Count - 1) Or Assigned(lPrimaryKey) Then
        lStr := lStr + ',';

      AList.Add(lStr + '''#$D#$A + ');
    End;

    If Assigned(lPrimaryKey) Then
    Begin
      AList.Add('                ''  Constraint Pk' + FTableName + ' Primary Key Clustered''#$D#$A + ');
      AList.Add('                ''  (' + lPrimaryKey.FieldName + ' Asc)''#$D#$A + ');
    End;
    AList.Add('                '')'';');
    AList.Add('    ExecSql();');
    AList.Add('');
    AList.Add('    Finally');
    AList.Add('      Free();');
    AList.Add('  End;');

    Finally
      lProps := Nil;
  End;
End;

Function THsClassCodeGenerator.GenerateUnitCode(Const AUnitName : String) : String;
Var lTmpList : TStringList;
    lUseList : String;
Begin
Exit;
  lTmpList := TStringList.Create();
  Try
    lTmpList.Add('Unit ' + AUnitName + ';');
    lTmpList.Add('');
    lTmpList.Add('Interface');
    lTmpList.Add('');

    lUseList := 'Classes, SysUtils, RTLConsts';
    If FDataType = dsJSon Then
      lUseList := lUseList + ', HsJSonEx'
    Else If FDataType = dsXML Then
      lUseList := lUseList + ', HsXmlDocEx'
    Else If FUseInterface Then
      lUseList := lUseList + ', HsInterfaceEx'
    Else If FMakeList Then
      lUseList := lUseList + ', Contnrs';
    lUseList := lUseList + ';';

    lTmpList.Add('Uses ' + lUseList);
    lTmpList.Add('');
    lTmpList.Add('Type');
    lTmpList.Add('//  TDataState = (edsBrowse, edsAdded, edsModified, edsDeleted);');
    lTmpList.Add('');

    If FUseInterface Or (FDataType = dsJSon) Then
      GenerateInterfaceDef(lTmpList);

    GenerateClassDef(lTmpList);

    lTmpList.Add('');
    lTmpList.Add('Implementation');
    lTmpList.Add('');

    GenerateClassImpl(lTmpList);
    lTmpList.Add('');
    lTmpList.Add('End.');

    Result := lTmpList.Text;

    Finally
      lTmpList.Free();
  End;
End;

Constructor THsTypeDef.Create();
Begin
  InHerited Create();

  FTypeDefValue := TStringList.Create();
End;

Destructor THsTypeDef.Destroy();
Begin
  FreeAndNil(FTypeDefValue);
  FTypeDefMembers := Nil;

  InHerited Destroy();
End;

Function THsTypeDef.GetTypeDefDefinition() : String;
Const
  lTypeDefDefStr : Array[THsTypeDefType] Of String = (
    '%s = (%s);',
    '%s = Set Of %s;',
    '',
    '%s = Class(%s);',
    '%s = Interface(%s);',
    '%s = Procedure(%s) Of Object;'
  );

Var X : Integer;
    lTmpList : TStringList;
Begin
(*
  THsTypeDefType = ( {dtVariable, dtConst,} dtEnum, dtSet, dtRecord,
    dtForwardClass, dtForwardInterface, dtEvent
  );
*)
  If FTypeDefType = dtRecord Then
  Begin
    lTmpList := TStringList.Create();
    Try
      For X := 0 To FTypeDefMembers.Count - 1 Do
        lTmpList.Add(PadL('', 4) + FTypeDefMembers[X].GetVariableDefinition(True));
      AlignVariables(lTmpList);

      lTmpList.Insert(0, PadL('', 2) + FTypeDefName + ' = Record');
      lTmpList.Add(PadL('', 2) + 'End;');

      Result := lTmpList.Text;

      Finally
        lTmpList.Free();
    End;
  End
  Else If FTypeDefType = dtForwardInterface Then
    Result := FTypeDefName + ' = Interface;'
  Else If FTypeDefValue.Count > 0 Then
    Result := PadL('', 2) + Format(lTypeDefDefStr[FTypeDefType], [FTypeDefName, FTypeDefValue[0]]);
End;

Function THsTypeDef.GetTypeDefType() : THsTypeDefType;
Begin
  Result := FTypeDefType;
End;

Procedure THsTypeDef.SetTypeDefType(Const ATypeDefType : THsTypeDefType);
Begin
  FTypeDefType := ATypeDefType;
End;

Function THsTypeDef.GetTypeDefName() : String;
Begin
  Result := FTypeDefName;
End;

Procedure THsTypeDef.SetTypeDefName(Const ATypeDefName : String);
Begin
  FTypeDefName := ATypeDefName;
End;

Function THsTypeDef.GetTypeDefValue() : TStrings;
Begin
  Result := FTypeDefValue;
End;

Procedure THsTypeDef.SetTypeDefValue(Const ATypeDefValue : TStrings);
Begin
  FTypeDefValue.Assign(ATypeDefValue);
End;

Function THsTypeDef.GetTypeDefMembers() : IHsPropertyDefs;
Begin
  If Not Assigned(FTypeDefMembers) Then
    FTypeDefMembers := GetPropertiesClass().Create();
  Result := FTypeDefMembers;
End;

Function THsTypeDef.GetPropertiesClass() : THsPropertyDefsClass;
Begin
  Result := THsPropertyDefs;
End;

Function THsTypeDefs.Add() : IHsTypeDef;
Begin
  Result := THsTypeDef.Create();
  InHerited Add(Result);
End;

Function THsTypeDefs.Get(Index : Integer) : IHsTypeDef;
Begin
  Supports(InHerited Items[Index], IHsTypeDef, Result);
End;

Procedure THsTypeDefs.Put(Index : Integer; Const Item : IHsTypeDef);
Var lInItem : IHsTypeDef;
Begin
  Supports(Item, IHsTypeDef, lInItem);
  InHerited Items[Index] := lInItem;
End;

Procedure THsProcedureDef.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FProcedureImpl := TStringList.Create();
End;

Procedure THsProcedureDef.BeforeDestruction();
Begin
  FreeAndNil(FProcedureImpl);

  InHerited BeforeDestruction();
End;

Procedure THsProcedureDef.Clear();
Begin
  FProcedureType := 0;
  FProcedureDef  := '';
  FProcedureImpl.Clear();
End;

Function THsProcedureDef.GetProcedureType() : Byte;
Begin
  Result := FProcedureType;
End;

Procedure THsProcedureDef.SetProcedureType(Const AProcedureType : Byte);
Begin
  FProcedureType := AProcedureType;
End;

Function THsProcedureDef.GetProcedureDef() : String;
Begin
  Result := FProcedureDef;
  //<ProcedureDef>LoadFromStream(ASource : IStreamEx);</ProcedureDef>
End;

Procedure THsProcedureDef.SetProcedureDef(Const AProcedureDef : String);
Var lPos : Integer;
Begin
  FProcedureDef := AProcedureDef;

  If FProcedureDef <> '' Then
  Begin
    lPos := Pos('(', FProcedureDef);
    If lPos > 0 Then
    Begin
      FProcedureParameters := Copy(FProcedureDef, lPos + 1, Length(FProcedureDef));
      lPos := Pos(')', FProcedureParameters);

      If lPos > 0 Then
        FProcedureParameters := Copy(FProcedureParameters, 1, lPos - 1);
    End;

    lPos := Pos('(', FProcedureDef);
    If lPos > 1 Then
      FProcedureName := Copy(FProcedureDef, 1, lPos - 1);
  End;
End;

Function THsProcedureDef.GetProcedureName() : String;
Begin
  Result := FProcedureName;
End;

Procedure THsProcedureDef.SetProcedureName(Const AProcedureName : String);
Begin
  FProcedureName := AProcedureName;
End;

Function THsProcedureDef.GetProcedureParameters() : String;
Begin
  Result := FProcedureParameters;
End;

Procedure THsProcedureDef.SetProcedureParameters(Const AProcedureParameters : String);
Begin
  FProcedureParameters := AProcedureParameters;
End;

Function THsProcedureDef.GetProcedureImpl() : TStrings;
Begin
  Result := FProcedureImpl;
End;

Function THsProcedureDef.GetIsReIntroduce() : Boolean;
Begin
  Result := FProcFlags And CIsReIntroduce = CIsReIntroduce;
End;

Procedure THsProcedureDef.SetIsReIntroduce(Const AIsReIntroduce : Boolean);
Begin
  If AIsReIntroduce Then
    FProcFlags := FProcFlags Or CIsReIntroduce
  Else If FProcFlags And CIsReIntroduce = CIsReIntroduce Then
    FProcFlags := FProcFlags Xor CIsReIntroduce;
End;

Function THsProcedureDef.GetIsVirtual() : Boolean;
Begin
  Result := FProcFlags And CIsVirtual = CIsVirtual;
End;

Procedure THsProcedureDef.SetIsVirtual(Const AIsVirtual : Boolean);
Begin
  If AIsVirtual Then
    FProcFlags := FProcFlags Or CIsVirtual
  Else If FProcFlags And CIsVirtual = CIsVirtual Then
    FProcFlags := FProcFlags Xor CIsVirtual;
End;

Function THsProcedureDef.GetIsAbstract() : Boolean;
Begin
  Result := FProcFlags And CIsAbstract = CIsAbstract;
End;

Procedure THsProcedureDef.SetIsAbstract(Const AIsAbstract : Boolean);
Begin
  If AIsAbstract Then
    FProcFlags := FProcFlags Or CIsAbstract
  Else If FProcFlags And CIsAbstract = CIsAbstract Then
    FProcFlags := FProcFlags Xor CIsAbstract;
End;

Function THsProcedureDef.GetIsOverRide() : Boolean;
Begin
  Result := FProcFlags And CIsOverRide = CIsOverRide;
End;

Procedure THsProcedureDef.SetIsOverRide(Const AIsOverRide : Boolean);
Begin
  If AIsOverRide Then
    FProcFlags := FProcFlags Or CIsOverRide
  Else If FProcFlags And CIsOverRide = CIsOverRide Then
    FProcFlags := FProcFlags Xor CIsOverRide;
End;

Function THsProcedureDef.GetIsOverLoad() : Boolean;
Begin
  Result := FProcFlags And CIsOverLoad = CIsOverLoad;
End;

Procedure THsProcedureDef.SetIsOverLoad(Const AIsOverLoad : Boolean);
Begin
  If AIsOverLoad Then
    FProcFlags := FProcFlags Or CIsOverLoad
  Else If FProcFlags And CIsOverLoad = CIsOverLoad Then
    FProcFlags := FProcFlags Xor CIsOverLoad;
End;

Function THsProcedureDef.GetIsFinal() : Boolean;
Begin
  Result := FProcFlags And CIsFinal = CIsFinal;
End;

Procedure THsProcedureDef.SetIsFinal(Const AIsFinal : Boolean);
Begin
  If AIsFinal Then
    FProcFlags := FProcFlags Or CIsFinal
  Else If FProcFlags And CIsFinal = CIsFinal Then
    FProcFlags := FProcFlags Xor CIsFinal;
End;

Function THsProcedureDef.GetShowInInterface() : Boolean;
Begin
  Result := FProcFlags And CShowInInterface = CShowInInterface;
End;

Procedure THsProcedureDef.SetShowInInterface(Const AShowInInterface : Boolean);
Begin
  If AShowInInterface Then
    FProcFlags := FProcFlags Or CShowInInterface
  Else If FProcFlags And CShowInInterface = CShowInInterface Then
    FProcFlags := FProcFlags Xor CShowInInterface;
End;

Function THsProcedureDef.GetProcedureScope() : THsFunctionScope;
Begin
  Result := FProcedureScope;
End;

Procedure THsProcedureDef.SetProcedureScope(Const AProcedureScope : THsFunctionScope);
Begin
  FProcedureScope := AProcedureScope;
End;

Function THsProcedureDef.GetResultType() : THsFunctionResultType;
Begin
  Result := FResultType;
End;

Procedure THsProcedureDef.SetResultType(Const AResultType : THsFunctionResultType);
Begin
  FResultType := AResultType;
End;

Function THsProcedureDef.GetResultTypeStr(Const AResultType : THsFunctionResultType) : String;
Const
  ResultTypeStr : Array[THsFunctionResultType] Of String = (
    '',
    'Byte',
    'Integer',
    'Single',
    'Double',
    'Extended',
    'Currency',
    'Char',
    'String',
    'WideString',
    'PAnsiChar',
    'PWideChar',
    'TStringList',
    'Date',
    'Time',
    'DateTime',
    'Boolean',
    '<ClassName>'
  );
Begin
  Result := ResultTypeStr[AResultType];
End;

Function THsProcedureDef.GetProcedureDefinition(Const AForClass : Boolean = False; Const AForInterface : Boolean = False) : String;
Begin
  If FResultType = rtNone Then
    Result := 'Procedure '
  Else
    Result := 'Function ';

  If Not AForClass Then
    Result := Result + 'T%ClassName%.';

  Result := Result + FProcedureName + '(' + FProcedureParameters + ')';

  If FResultType <> rtNone Then
    Result := Result + ' : ' + GetResultTypeStr(FResultType);

  If Not AForInterface And AForClass Then
  Begin
    If GetIsReIntroduce() Then
      Result := Result + '; ReIntroduce';

    If GetIsVirtual() Then
      Result := Result + '; Virtual';

    If GetIsAbstract() Then
      Result := Result + '; Abstract';

    If GetIsOverRide() Then
      Result := Result + '; OverRide';

    If GetIsFinal() Then
      Result := Result + '; Final';
  End;

  If AForClass And GetIsOverLoad() Then
    Result := Result + '; OverLoad';

  Result := Result + ';';
End;

Function THsProcedureDefs.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := THsProcedureDef;
End;

Function THsProcedureDefs.Get(Index : Integer) : IHsProcedureDef;
Begin
  Result := InHerited Items[Index] As IHsProcedureDef;
End;

Procedure THsProcedureDefs.Put(Index : Integer; Const Item : IHsProcedureDef);
Begin
  InHerited Items[Index] := Item;
End;

Function THsProcedureDefs.Add() : IHsProcedureDef;
Begin
  Result := InHerited Add() As IHsProcedureDef;
End;

Function THsProcedureDefs.Add(Const AItem : IHsProcedureDef) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function THsClassCodeGenerators.Get(Index : Integer) : IHsClassCodeGenerator;
Begin
  Supports(InHerited Items[Index], IHsClassCodeGenerator, Result);
End;

Procedure THsClassCodeGenerators.Put(Index : Integer; Const Item : IHsClassCodeGenerator);
Var lInItem : IHsClassCodeGenerator;
Begin
  Supports(Item, IHsClassCodeGenerator, lInItem);
  InHerited Items[Index] := lInItem As IHsClassCodeGenerator;
End;

Function THsClassCodeGenerators.Add() : IHsClassCodeGenerator;
Begin
  Result := THsClassCodeGenerator.Create();
  InHerited Add(Result);
End;

Procedure THsClassCodeGenerators.Delete(Const Item : IHsClassCodeGenerator);
Begin
  InHerited Delete(IndexOf(Item));
End;

Procedure THsUnitGenerator.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FClassDefs := GetCodeGeneratorClass().Create();
  FTypeDefs  := GetTypeDefsClass().Create(); 
  FUnitName := 'NewUnit';
End;

Procedure THsUnitGenerator.BeforeDestruction();
Begin
  Include(FStates, isDestroying);
  FClassDefs := Nil;
  FTypeDefs := Nil;
  FJSon := Nil;
  FXml  := Nil;

  InHerited BeforeDestruction();
End;

Function THsUnitGenerator.GetStates() : TInterfaceStates;
Begin
  Result := FStates;
End;

Function THsUnitGenerator.GetJSonIO() : IJSonUnitGenerator;
Begin
  If Not Assigned(FJSon) Then
    FJSon := TJSonCodeGen.CreateGenerator(Self);

  FJSon.Generator := Self;
  Result := FJSon;
End;

Function THsUnitGenerator.GetXmlIO() : IXMLUnitGenerator;
Begin
  If Not Assigned(FXml) Then
    FXml := TXmlCodeGen.CreateGenerator(Self);

  FXml.Generator := Self;
  Result := FXml;
End;

Function THsUnitGenerator.GetAsJSon() : WideString;
Begin
  Result := JSonImpl.AsJSon(True);
End;

Procedure THsUnitGenerator.SetAsJSon(Const AJSonString : WideString);
Var lJSonIO : IJSonIO;
    lSO : ISuperObject;
Begin
  Try
    lSO := TSuperObject.ParseString(PWideChar(AJSonString), True);

    lJSonIO := TCodeGenIO.CreateJSonIO(
      TJSonCodeGen.CreateGenerator(lSO)
    );
//    lJSonIO := TCodeGenIO.CreateJSonIO(TJsonCodeGen.CreateGenerator(AJSonString));
    lJSonIO.SaveTo(Self);

    Finally
      lJSonIO := Nil;
  End;
End;

Function THsUnitGenerator.GetAsXml() : String;
Begin
  Result := FormatXMLData(XmlImpl.XML);
End;

Procedure THsUnitGenerator.SetAsXml(Const AXmlString : String);
Var lXmlIO : IXmlIO;
    lXmlDoc : IXmlDocumentEx;
Begin
  lXmlIO := TCodeGenIO.CreateXmlIO(TXmlCodeGen.CreateGenerator(AXmlString));
  Try
    lXmlIO.SaveTo(Self);

    Finally
      lXmlIO  := Nil;
  End;
End;

Function THsUnitGenerator.GenerateUnitCode() : String;
Var lTmpList : TStringList;
    lUseList : String;
    X        : Integer;

    lDataSources  : THsDataSources;
    lUseInterface : Boolean;
    lMakeList     : Boolean;
Begin
  lTmpList := TStringList.Create();
  Try
    lTmpList.Add('Unit ' + FUnitName + ';');
    lTmpList.Add('');
    lTmpList.Add('Interface');
    lTmpList.Add('');

    lDataSources  := [];
    lUseInterface := False;
    lMakeList     := False;
    For X := 0 To FClassDefs.Count - 1 Do
    Begin
      lDataSources  := lDataSources + [FClassDefs[X].DataType];
      lUseInterface := lUseInterface Or
                       (FClassDefs[X].UseInterface And Not (FClassDefs[X].DataType In [dsJSon, dsXML]));
      lMakeList     := lMakeList Or
                       (FClassDefs[X].MakeList And Not (FClassDefs[X].UseInterface Or (FClassDefs[X].DataType In [dsJSon, dsXML])));
    End;

    lUseList := 'Classes, SysUtils, RTLConsts';
    If lDataSources * [dsJSon] <> [] Then
      lUseList := lUseList + ', HsJSonEx';
    If lDataSources * [dsXML] <> [] Then
      lUseList := lUseList + ', HsXmlDocEx';
    If lUseInterface Then
      lUseList := lUseList + ', HsInterfaceEx';
    If lMakeList Then
      lUseList := lUseList + ', Contnrs';

    lUseList := lUseList + ';';

    lTmpList.Add('Uses ' + lUseList);
    lTmpList.Add('');
    lTmpList.Add('Type');
    lTmpList.Add('//  TDataState = (edsBrowse, edsAdded, edsModified, edsDeleted);');
    lTmpList.Add('');

    For X := 0 To FTypeDefs.Count - 1 Do
      lTmpList.Add(PadL('', 2) + FTypeDefs[X].GetTypeDefDefinition());
    If FTypeDefs.Count > 0 Then
      lTmpList.Add('');

    For X := 0 To FClassDefs.Count - 1 Do
      If FClassDefs[X].UseInterface Or (FClassDefs[X].DataType In [dsJSon, dsXML]) Then
        FClassDefs[X].GenerateInterfaceDef(lTmpList);

    For X := 0 To FClassDefs.Count - 1 Do
      If FClassDefs[X].UseInterface Or (FClassDefs[X].DataType In [dsJSon, dsXML]) Then
      Begin
        lTmpList.Add('(******************************************************************************)');
        lTmpList.Add('');
        Break;
      End;

    For X := 0 To FClassDefs.Count - 1 Do
    Begin
      FClassDefs[X].GenerateClassDef(lTmpList);
      lTmpList.Add('');
    End;

    lTmpList.Add('Implementation');
    lTmpList.Add('');

    For X := 0 To FClassDefs.Count - 1 Do
      FClassDefs[X].GenerateClassImpl(lTmpList);

    lTmpList.Add('');
    lTmpList.Add('End.');

    Result := lTmpList.Text;

    Finally
      lTmpList.Free();
  End;
End;

Procedure THsUnitGenerator.SaveToFile(Const AFileName : String);
Var lIO : IHsUnitGeneratorFileManager;
Begin
  With TStringList.Create() Do
  Try
    If SameText(ExtractFileExt(AFileName), '.xml') Then
    Begin
      Text := GetAsXml();
      SaveToFile(AFileName);
    End
    Else If SameText(ExtractFileExt(AFileName), '.json') Then
    Begin
      Text := GetAsJSon();
      SaveToFile(AFileName);
    End
    Else
    Begin
      lIO := TCodeGenIO.CreateRawIO(Self);
      lIO.SaveToFile(AFileName);
    End;

    Finally
      Free();
  End;
End;

Procedure THsUnitGenerator.LoadFromFile(Const AFileName : String);
Var lIO : IHsUnitGeneratorFileManager;
Begin
  With TStringList.Create() Do
  Try
    LoadFromFile(AFileName);

    If SameText(ExtractFileExt(AFileName), '.xml') Then
      SetAsXml(Text)
    Else If SameText(ExtractFileExt(AFileName), '.json') Then
      SetAsJSon(Text)
    Else
    Begin
      lIO := TCodeGenIO.CreateRawIO(Self);
      lIO.LoadFromFile(AFileName);
    End;

    Finally
      Free();
  End;
End;

Procedure THsUnitGenerator.Assign(Const ASource : IHsUnitGenerator);
Var X, Y : Integer;
Begin
  GetTypeDefs().Clear();
  GetClassDefs().Clear();

  SetUnitName(ASource.UnitName);

  For X := 0 To ASource.TypeDefs.Count - 1 Do
    With GetTypeDefs().Add() Do
    Begin
      TypeDefName := ASource.TypeDefs[X].TypeDefName;
      TypeDefType := ASource.TypeDefs[X].TypeDefType;
      TypeDefValue.Assign(ASource.TypeDefs[X].TypeDefValue);

      For Y := 0 To ASource.TypeDefs[X].TypeDefMembers.Count - 1 Do
        With TypeDefMembers.Add() Do
        Begin
          PropertyName := ASource.TypeDefs[X].TypeDefMembers[Y].PropertyName;
          PropertyType := ASource.TypeDefs[X].TypeDefMembers[Y].PropertyType;
        End;
    End;

  For X := 0 To ASource.ClassDefs.Count - 1 Do
    With GetClassDefs().Add() Do
    Begin
      ClsName           := ASource.ClassDefs[X].ClsName;
      UseCustomClass    := ASource.ClassDefs[X].UseCustomClass;
      UseInterface      := ASource.ClassDefs[X].UseInterface;
      MakeList          := ASource.ClassDefs[X].MakeList;
      TrackChange       := ASource.ClassDefs[X].TrackChange;
      DataType          := ASource.ClassDefs[X].DataType;
      AdoQueryClassName := ASource.ClassDefs[X].AdoQueryClassName;
      TableName         := ASource.ClassDefs[X].TableName;

      For Y := 0 To ASource.ClassDefs[X].PropertyDefs.Count - 1 Do
        With PropertyDefs.Add() Do
        Begin
          PropertyName         := ASource.ClassDefs[X].PropertyDefs[Y].PropertyName;
          PropertyType         := ASource.ClassDefs[X].PropertyDefs[Y].PropertyType;
          IsDataAware          := ASource.ClassDefs[X].PropertyDefs[Y].IsDataAware;
          IsReadOnly           := ASource.ClassDefs[X].PropertyDefs[Y].IsReadOnly;
          PropertyClass        := ASource.ClassDefs[X].PropertyDefs[Y].PropertyClass;
          InterfaceName        := ASource.ClassDefs[X].PropertyDefs[Y].InterfaceName;
          InterfaceImplementor := ASource.ClassDefs[X].PropertyDefs[Y].InterfaceImplementor;
          IsId                 := ASource.ClassDefs[X].PropertyDefs[Y].IsId;
          FieldName            := ASource.ClassDefs[X].PropertyDefs[Y].FieldName;
          MaxLen               := ASource.ClassDefs[X].PropertyDefs[Y].MaxLen;
        End;
    End;
End;

Function THsUnitGenerator.GetTypeDefsClass() : THsTypeDefsClass;
Begin
  Result := THsTypeDefs;
End;

Function THsUnitGenerator.GetCodeGeneratorClass() : THsClassCodeGeneratorsClass;
Begin
  Result := THsClassCodeGenerators;
End;

Function THsUnitGenerator.GetTypeDefs() : IHsTypeDefs;
Begin
  Result := FTypeDefs;
End;

Function THsUnitGenerator.GetClassDefs() : IHsClassCodeGenerators;
Begin
  Result := FClassDefs As IHsClassCodeGenerators;
End;

Function THsUnitGenerator.GetUnitName() : String;
Begin
  Result := FUnitName;
End;

Procedure THsUnitGenerator.SetUnitName(Const AUnitName : String);
Begin
  FUnitName := AUnitName;
End;

end.
