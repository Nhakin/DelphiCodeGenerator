unit CodeGen.JSon;

interface

Uses
  SuperObject, HsSuperObjectEx, CodeGenIntf;

Type
  IJSonProperty = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-AA7B-D1E7EF4418EB}']
    Function  GetPropertyName() : SOString;
    Procedure SetPropertyName(Const APropertyName : SOString);

    Function  GetPropertyType() : SOString;
    Procedure SetPropertyType(Const APropertyType : SOString);

    Function  GetIsReadOnly() : Boolean;
    Procedure SetIsReadOnly(Const AIsReadOnly : Boolean);

    Function  GetPropertyClass() : SOString;
    Procedure SetPropertyClass(Const APropertyClass : SOString);

    //-->dtInterface
    Function  GetInterfaceName() : SOString;
    Procedure SetInterfaceName(Const AInterfaceName : SOString);
    Function  GetInterfaceImplementor() : SOString;
    Procedure SetInterfaceImplementor(Const AInterfaceImplementor : SOString);

    Function  GetIsDataAware() : Boolean;
    Procedure SetIsDataAware(Const AIsDataAware : Boolean);

    Function  GetIsId() : Boolean;
    Procedure SetIsId(Const AIsId : Boolean);

    Function  GetFieldName() : SOString;
    Procedure SetFieldName(Const AFieldName : SOString);

    Function  GetMaxLen() : Integer;
    Procedure SetMaxLen(Const AMaxLen : Integer);

    Property PropertyName  : SOString Read GetPropertyName  Write SetPropertyName;
    Property PropertyType  : SOString Read GetPropertyType  Write SetPropertyType;
    Property IsReadOnly    : Boolean  Read GetIsReadOnly    Write SetIsReadOnly;
    Property IsDataAware   : Boolean  Read GetIsDataAware   Write SetIsDataAware;

    Property PropertyClass : SOString Read GetPropertyClass Write SetPropertyClass;

    //dtInterface
    Property InterfaceName        : SOString Read GetInterfaceName Write SetInterfaceName;
    Property InterfaceImplementor : SOString Read GetInterfaceImplementor Write SetInterfaceImplementor;

    Property IsId          : Boolean  Read GetIsId          Write SetIsId;
    Property FieldName     : SOString Read GetFieldName     Write SetFieldName;

    Property MaxLen        : Integer  Read GetMaxLen        Write SetMaxLen;

  End;

  IJSonProperties = Interface(ISuperObjectExList)
    ['{4B61686E-29A0-2112-A759-8BEBE9B8E341}']
    Function GetItem(Const Index : Integer) : IJSonProperty;

    Function Add() : IJSonProperty; OverLoad;
    Function Add(Const AItem : IJSonProperty) : Integer; OverLoad;

    Property Items[Const Index: Integer] : IJSonProperty Read GetItem; Default;

  End;

  IJSonMsSQLSettings = interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-885A-135567D2944C}']
    Function  GetAdoQueryClassName() : SOString;
    Procedure SetAdoQueryClassName(Value: SOString);

    Function  GetTableName() : SOString;
    Procedure SetTableName(Value: SOString);

    Property AdoQueryClassName : SOString Read GetAdoQueryClassName Write SetAdoQueryClassName;
    Property TableName         : SOString Read GetTableName         Write SetTableName;

  End;

  IJSonSettings = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-B318-8E3D3C73FB9E}']
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

    Function  GetSettingDataType() : SOString;
    Procedure SetSettingDataType(Const ADataType : SOString);

    Property UseCustomClass  : Boolean  Read GetUseCustomClass  Write SetUseCustomClass;
    Property UseInterface    : Boolean  Read GetUseInterface    Write SetUseInterface;
    Property UseStrict       : Boolean  Read GetUseStrict       Write SetUseStrict;
    Property MakeList        : Boolean  Read GetMakeList        Write SetMakeList;
    Property UseEnumerator   : Boolean  Read GetUseEnumerator   Write SetUseEnumerator;
    Property UseNestedClass  : Boolean  Read GetUseNestedClass  Write SetUseNestedClass;
    Property TrackChange     : Boolean  Read GetTrackChange     Write SetTrackChange;
    Property SettingDataType : SOString Read GetSettingDataType Write SetSettingDataType;

  End;

  IJSonProcedureDef = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-A545-2A1A1A6C8A9B}']
    Function  GetProcedureType() : Byte;
    Procedure SetProcedureType(Const AProcedureType : Byte);

    Function  GetProcedureDef() : String;
    Procedure SetProcedureDef(Const AProcedureDef : String);

    Function  GetProcedureImpl() : String;
    Procedure SetProcedureImpl(Const AProcedureImpl : String);

    Property ProcedureType : Byte   Read GetProcedureType  Write SetProcedureType;
    Property ProcedureDef  : String Read GetProcedureDef   Write SetProcedureDef;
    Property ProcedureImpl : String Read GetProcedureImpl  Write SetProcedureImpl;

  End;

  IJSonProcedureDefs = Interface(ISuperObjectExList)
    ['{4B61686E-29A0-2112-95A0-BB1F47498E83}']
    Function GetItem(Const Index : Integer) : IJSonProcedureDef;

    Function Add() : IJSonProcedureDef; OverLoad;
    Function Add(Const AItem : IJSonProcedureDef) : Integer; OverLoad;

    Property Items[Const Index: Integer] : IJSonProcedureDef Read GetItem; Default;

  End;

  IJSonClass = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-8260-25C938CA1DB4}']
    Function  GetClsName() : SOString;
    Procedure SetClsName(Const Value : SOString);

    Function GetSettings() : IJSonSettings;
    Function GetMsSQLSettings() : IJSonMsSQLSettings;
    Function GetProperties() : IJSonProperties;
    Function GetProcedures() : IJSonProcedureDefs;

    Property ClsName       : SOString           Read GetClsName Write SetClsName;
    Property Settings      : IJSonSettings      Read GetSettings;
    Property MsSQLSettings : IJSonMsSQLSettings Read GetMsSQLSettings;
    Property Properties    : IJSonProperties    Read GetProperties;
    Property Procedures    : IJSonProcedureDefs Read GetProcedures;
    
  End;

  IJSonClassCodeGenerators = Interface(ISuperObjectExList)
    ['{4B61686E-29A0-2112-98E8-5E8FFCC3EA52}']
    Function GetItem(Const Index : Integer) : IJSonClass;

    Function Add() : IJSonClass; OverLoad;
    Function Add(Const AItem : IJSonClass) : Integer; OverLoad;

    Property Items[Const Index : Integer] : IJSonClass Read GetItem; Default;

  End;

  IJSonTypeDef = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-B8CF-5DCEFF034A1C}']
    Function  GetTypeDefType() : String;
    Procedure SetTypeDefType(Const ATypeDefType : String);

    Function  GetTypeDefName() : String;
    Procedure SetTypeDefName(Const ATypeDefName : String);

    Function  GetTypeDefValue() : String;
    Procedure SetTypeDefValue(Const ATypeDefValue : String);

    Function GetTypeDefValues() : IJSonProperties;

    Property TypeDefType  : String Read GetTypeDefType  Write SetTypeDefType;
    Property TypeDefName  : String Read GetTypeDefName  Write SetTypeDefName;
    Property TypeDefValue : String Read GetTypeDefValue Write SetTypeDefValue;
    Property TypeDefValues : IJSonProperties Read GetTypeDefValues;

  End;

  IJSonTypeDefs = Interface(ISuperObjectExList)
    ['{4B61686E-29A0-2112-9639-C8804862F7DB}']
    Function GetItem(Const Index : Integer) : IJSonTypeDef;

    Function Add() : IJSonTypeDef; OverLoad;
    Function Add(Const AItem : IJSonTypeDef) : Integer; OverLoad;

    Property Items[Const Index : Integer] : IJSonTypeDef Read GetItem; Default;

  End;

  IJSonUnitGenerator = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-86EC-3B2B47492D4C}']
    Procedure SaveToFile(Const AFileName : String);
    Procedure LoadFromFile(Const AFileName : String);

    Function  GetGenerator() : IHsUnitGenerator;
    Procedure SetGenerator(AGenerator : IHsUnitGenerator);

    Function  GetUnitName() : String;
    Procedure SetUnitName(Const AUnitName : String);

    Function GetTypeDefs() : IJSonTypeDefs;
    Function GetClassDefs() : IJSonClassCodeGenerators;

    Property Generator : IHsUnitGenerator Read GetGenerator Write SetGenerator;
    Property UnitName : String Read GetUnitName Write SetUnitName;

    Property TypeDefs  : IJSonTypeDefs            Read GetTypeDefs;
    Property ClassDefs : IJSonClassCodeGenerators Read GetClassDefs;

  End;

  TJSonCodeGen = Class(TObject)
  Public
    Class Function CreateGenerator(AGenerator : IHsUnitGenerator) : IJSonUnitGenerator; OverLoad;
    Class Function CreateGenerator(AObject : ISuperObject) : IJSonUnitGenerator; OverLoad;
    Class Function CreateGenerator(AJsonString : WideString) : IJSonUnitGenerator; OverLoad;

  End;

implementation

Uses HsInterfaceEx, CodeGenType, CodeGen.IO;

Type
  TJSonUnitGenerator = Class(TSuperObjectEx,
    IHsUnitGeneratorFileManager, IJSonUnitGenerator)
  Private
    FGenerator : Pointer;
    FIsLoading : Boolean;

    FIntfEx : TInterfacedObjectEx;

  Protected
    Function _AddRef() : Integer; OverRide; StdCall;

    Function  GetUnitName() : String;
    Procedure SetUnitName(Const AUnitName : String);

    Function GetTypeDefs() : IJSonTypeDefs;
    Function GetClassDefs() : IJSonClassCodeGenerators;

    Function  GetGenerator() : IHsUnitGenerator;
    Procedure SetGenerator(AGenerator : IHsUnitGenerator);

  Public
    Procedure AfterConstruction(); OverRide;

    Procedure SaveToFile(Const AFileName : String);
    Procedure LoadFromFile(Const AFileName : String);

    Class Function CoCreate(AObject : ISuperObject) : IJSonUnitGenerator; OverLoad;
    Class Function CoCreate(AGenerator : IHsUnitGenerator) : IJSonUnitGenerator; OverLoad;
    Class Function CoCreate(AObject : ISuperObject; AGenerator : IHsUnitGenerator) : IJSonUnitGenerator; OverLoad;

  End;

  TJSonTypeDef = Class(TSuperObjectEx, IJSonTypeDef)
  Protected
    Function  GetTypeDefType() : String; Virtual;
    Procedure SetTypeDefType(Const ATypeDefType : String); Virtual;

    Function  GetTypeDefName() : String; Virtual;
    Procedure SetTypeDefName(Const ATypeDefName : String); Virtual;

    Function  GetTypeDefValue() : String; Virtual;
    Procedure SetTypeDefValue(Const ATypeDefValue : String); Virtual;

    Function GetTypeDefValues() : IJSonProperties; Virtual;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TJSonTypeDefs = Class(TSuperObjectExList, IJSonTypeDefs)
  Protected
    Function GetItemClass() : TSuperObjectExClass; OverRide;
    Function GetItem(Const Index : Integer) : IJSonTypeDef; OverLoad;

  Public
    Function Add() : IJSonTypeDef; OverLoad;
    Function Add(Const AItem : IJSonTypeDef) : Integer; OverLoad;

    Property Items[Const Index: Integer] : IJSonTypeDef Read GetItem; Default;

  End;

  TJSonClassCodeGenerators = Class(TSuperObjectExList, IJSonClassCodeGenerators)
  Protected
    Function GetItemClass() : TSuperObjectExClass; OverRide;
    Function GetItem(Const Index : Integer) : IJSonClass; OverLoad;

  Public
    Function Add() : IJSonClass; OverLoad;
    Function Add(Const AItem : IJSonClass) : Integer; OverLoad;

    Property Items[Const Index: Integer] : IJSonClass Read GetItem; Default;

  End;

  TJSonClass = Class(TSuperObjectEx, IJSonClass)
  Protected
    Function  GetClsName() : SOString;
    Procedure SetClsName(Const Value : SOString);

    Function GetSettings() : IJSonSettings;
    Function GetMsSQLSettings() : IJSonMsSQLSettings;
    Function GetProperties() : IJSonProperties;
    Function GetProcedures() : IJSonProcedureDefs;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TJSonSettings = Class(TSuperObjectEx, IJSonSettings)
  Protected
    Function  GetUseCustomClass() : Boolean; Virtual;
    Procedure SetUseCustomClass(Const AUseCustomClass : Boolean); Virtual;

    Function  GetUseInterface() : Boolean; Virtual;
    Procedure SetUseInterface(Const AUseInterface : Boolean); Virtual;

    Function  GetUseStrict() : Boolean; Virtual;
    Procedure SetUseStrict(Const AUseStrict : Boolean); Virtual;

    Function  GetMakeList() : Boolean; Virtual;
    Procedure SetMakeList(Const AMakeList : Boolean); Virtual;

    Function  GetUseEnumerator() : Boolean; Virtual;
    Procedure SetUseEnumerator(Const AUseEnumerator : Boolean); Virtual;

    Function  GetUseNestedClass() : Boolean; Virtual;
    Procedure SetUseNestedClass(Const AUseNestedClass : Boolean); Virtual;

    Function  GetTrackChange() : Boolean; Virtual;
    Procedure SetTrackChange(Const ATrackChange : Boolean); Virtual;

    Function  GetSettingDataType() : SOString; Virtual;
    Procedure SetSettingDataType(Const ADataType : SOString); Virtual;

  End;

  TJSonMsSQLSettings = Class(TSuperObjectEx, IJSonMsSQLSettings)
  Protected
    Function  GetAdoQueryClassName() : SOString;
    Procedure SetAdoQueryClassName(Value: SOString);

    Function  GetTableName() : SOString;
    Procedure SetTableName(Value: SOString);

  End;

  TJSonProperty = Class(TSuperObjectEx, IJSonProperty)
  Protected
    Function  GetPropertyName() : SOString; Virtual;
    Procedure SetPropertyName(Const APropertyName : SOString); Virtual;

    Function  GetPropertyType() : SOString; Virtual;
    Procedure SetPropertyType(Const APropertyType : SOString); Virtual;

    Function  GetIsDataAware() : Boolean; Virtual;
    Procedure SetIsDataAware(Const AIsDataAware : Boolean); Virtual;

    Function  GetIsReadOnly() : Boolean; Virtual;
    Procedure SetIsReadOnly(Const AIsReadOnly : Boolean); Virtual;

    Function  GetPropertyClass() : SOString; Virtual;
    Procedure SetPropertyClass(Const APropertyClass : SOString); Virtual;

    Function  GetInterfaceName() : SOString;
    Procedure SetInterfaceName(Const AInterfaceName : SOString);
    Function  GetInterfaceImplementor() : SOString;
    Procedure SetInterfaceImplementor(Const AInterfaceImplementor : SOString);

    Function  GetIsId() : Boolean; Virtual;
    Procedure SetIsId(Const AIsId : Boolean); Virtual;

    Function  GetFieldName() : SOString; Virtual;
    Procedure SetFieldName(Const AFieldName : SOString); Virtual;

    Function  GetMaxLen() : Integer; Virtual;
    Procedure SetMaxLen(Const AMaxLen : Integer); Virtual;

  End;

  TJSonProperties = Class(TSuperObjectExList, IJSonProperties)
  Protected
    Function GetItemClass() : TSuperObjectExClass; OverRide;
    Function GetItem(Const Index : Integer) : IJSonProperty; OverLoad;

  Public
    Function Add() : IJSonProperty; OverLoad;
    Function Add(Const AItem : IJSonProperty) : Integer; OverLoad;

    Property Items[Const Index: Integer] : IJSonProperty Read GetItem; Default;

  End;

  TJSonProcedureDef = Class(TSuperObjectEx, IJSonProcedureDef)
  Protected
    Function  GetProcedureType() : Byte; Virtual;
    Procedure SetProcedureType(Const AProcedureType : Byte); Virtual;

    Function  GetProcedureDef() : String; Virtual;
    Procedure SetProcedureDef(Const AProcedureDef : String); Virtual;

    Function  GetProcedureImpl() : String; Virtual;
    Procedure SetProcedureImpl(Const AProcedureImpl : String); Virtual;

  End;

  TJSonProcedureDefs = Class(TSuperObjectExList, IJSonProcedureDefs)
  Protected
    Function GetItemClass() : TSuperObjectExClass; OverRide;
    Function GetItem(Const Index : Integer) : IJSonProcedureDef; OverLoad;

  Public
    Function Add() : IJSonProcedureDef; OverLoad;
    Function Add(Const AItem : IJSonProcedureDef) : Integer; OverLoad;

    Property Items[Const Index: Integer] : IJSonProcedureDef Read GetItem; Default;

  End;

Class Function TJSonCodeGen.CreateGenerator(AGenerator : IHsUnitGenerator) : IJSonUnitGenerator;
Begin
  Result := TJSonUnitGenerator.CoCreate(AGenerator);
End;

Class Function TJSonCodeGen.CreateGenerator(AObject : ISuperObject) : IJSonUnitGenerator;
Begin
  Result := TJSonUnitGenerator.CoCreate(AObject);
End;

Class Function TJSonCodeGen.CreateGenerator(AJsonString : WideString) : IJSonUnitGenerator;
Var lJSonDoc : ISuperObject;
Begin
  lJSonDoc := TSuperObject.ParseString(PWideChar(AJsonString), True);
  Try
    Result := CreateGenerator(lJSonDoc);
    Finally
      lJSonDoc := Nil;
  End;
End;

(******************************************************************************)

Class Function TJSonUnitGenerator.CoCreate(AObject : ISuperObject; AGenerator : IHsUnitGenerator) : IJSonUnitGenerator;
Begin
  Result := GetDocBinding(AObject, TJSonUnitGenerator) As IJSonUnitGenerator;
  Result.Generator := AGenerator;
End;

Class Function TJSonUnitGenerator.CoCreate(AObject : ISuperObject) : IJSonUnitGenerator;
Begin
  Result := CoCreate(AObject, Nil);
End;

Class Function TJSonUnitGenerator.CoCreate(AGenerator : IHsUnitGenerator) : IJSonUnitGenerator;
Begin
  Result := CoCreate(TSuperObjectEx.Create(), AGenerator);
End;

Procedure TJSonUnitGenerator.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('TypeDefs', TJSonTypeDefs);
  RegisterChildNode('ClassDefs', TJSonClassCodeGenerators);

  FGenerator := Nil;
  FIsLoading := False;
End;

Function TJSonUnitGenerator._AddRef() : Integer;
Var lIO : IJSonIO;
Begin
  Result := InHerited _AddRef();

  If Assigned(FGenerator) And Not FIsLoading Then
  Begin
    FIsLoading := True;
    Try
      lIO := TCodeGenIO.CreateJSonIO(Self);
      lIO.LoadFrom(IHsUnitGenerator(FGenerator));

      Finally
        FIsLoading := False;
    End;
  End;
End;

Function TJSonUnitGenerator.GetGenerator() : IHsUnitGenerator;
Begin
  Result := IHsUnitGenerator(FGenerator);
End;

Procedure TJSonUnitGenerator.SetGenerator(AGenerator : IHsUnitGenerator);
Var lIO : IJSonIO;
Begin
  FGenerator := Pointer(AGenerator);

  If Assigned(AGenerator) Then
  Begin
    lIO := TCodeGenIO.CreateJSonIO(Self);
    lIO.LoadFrom(AGenerator);
  End;
End;

Procedure TJSonUnitGenerator.SaveToFile(Const AFileName : String);
Begin
  InHerited SaveTo(AFileName, True);
End;

Procedure TJSonUnitGenerator.LoadFromFile(Const AFileName : String);
Var lIO : IJSonIO;
Begin
  If Assigned(FGenerator) And Not FIsLoading Then
  Begin
    FIsLoading := True;
    Try
      lIO := TCodeGenIO.CreateJSonIO(CoCreate(ParseFile(AFileName, True)));
      lIO.SaveTo(IHsUnitGenerator(FGenerator));

      lIO := TCodeGenIO.CreateJSonIO(Self);
      lIO.LoadFrom(IHsUnitGenerator(FGenerator));

      Finally
        FIsLoading := False;
    End;
  End;
End;

Function TJSonUnitGenerator.GetUnitName() : String;
Begin
  Result := S['UnitName'];
End;

Procedure TJSonUnitGenerator.SetUnitName(Const AUnitName : String);
Begin
  S['UnitName'] := AUnitName;
End;

Function TJSonUnitGenerator.GetTypeDefs() : IJSonTypeDefs;
Begin
  If O['TypeDefs'] = Nil Then
    O['TypeDefs'] := TJSonTypeDefs.Create(stArray);
  Result := O['TypeDefs'] As IJSonTypeDefs;
End;

Function TJSonUnitGenerator.GetClassDefs() : IJSonClassCodeGenerators;
Begin
  If O['ClassDefs'] = Nil Then
    O['ClassDefs'] := TJSonClassCodeGenerators.Create(stArray);
  Result := O['ClassDefs'] As IJSonClassCodeGenerators;
End;

Procedure TJSonTypeDef.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('TypeDefValues', TJSonProperties);
End;

Function TJSonTypeDef.GetTypeDefType() : String;
Begin
  Result := S['TypeDefType'];
End;

Procedure TJSonTypeDef.SetTypeDefType(Const ATypeDefType : String);
Begin
  S['TypeDefType'] := ATypeDefType;
End;

Function TJSonTypeDef.GetTypeDefName() : String;
Begin
  Result := S['TypeDefName'];
End;

Procedure TJSonTypeDef.SetTypeDefName(Const ATypeDefName : String);
Begin
  S['TypeDefName'] := ATypeDefName;
End;

Function TJSonTypeDef.GetTypeDefValue() : String;
Begin
  Result := S['TypeDefValue'];
End;

Procedure TJSonTypeDef.SetTypeDefValue(Const ATypeDefValue : String);
Begin
  S['TypeDefValue'] := ATypeDefValue;
End;

Function TJSonTypeDef.GetTypeDefValues() : IJSonProperties;
Begin
  If O['TypeDefValues'] = Nil Then
    O['TypeDefValues'] := TJSonProperties.Create(stArray);
  Result := O['TypeDefValues'] As IJSonProperties;
End;

Function TJSonTypeDefs.GetItemClass() : TSuperObjectExClass;
Begin
  Result := TJSonTypeDef;
End;

Function TJSonTypeDefs.GetItem(Const Index : Integer) : IJSonTypeDef;
Begin
  Result := InHerited GetItem(Index) As IJSonTypeDef;
End;

Function TJSonTypeDefs.Add() : IJSonTypeDef;
Begin
  Result := InHerited Add() As IJSonTypeDef;
End;

Function TJSonTypeDefs.Add(Const AItem : IJSonTypeDef) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TJSonClassCodeGenerators.Add() : IJSonClass;
Begin
  Result := TJSonClass.Create(stObject);
  InHerited Add(Result);
End;

Function TJSonClassCodeGenerators.Add(Const AItem : IJSonClass) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TJSonClassCodeGenerators.GetItemClass() : TSuperObjectExClass;
Begin
  Result := TJSonClass;
End;

Function TJSonClassCodeGenerators.GetItem(Const Index : Integer) : IJSonClass;
Begin
  Result := InHerited GetItem(Index) As IJSonClass;
End;

Procedure TJSonClass.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('Settings', TJSonSettings);
  RegisterChildNode('Properties', TJSonProperties);
  RegisterChildNode('Procedures', TJSonProcedureDefs);
  RegisterChildNode('MsSQLSettings', TJSonMsSQLSettings);
End;

Function TJSonClass.GetClsName() : SOString;
Begin
  Result := S['ClsName'];
End;

Procedure TJSonClass.SetClsName(Const Value : SOString);
Begin
  S['ClsName'] := Value;
End;

Function TJSonClass.GetSettings() : IJSonSettings;
Begin
  If O['Settings'] = Nil Then
    O['Settings'] := TJSonSettings.Create();
  Result := O['Settings'] As IJSonSettings;
End;

Function TJSonClass.GetMsSQLSettings() : IJSonMsSQLSettings;
Begin
  If O['MsSQLSettings'] = Nil Then
    O['MsSQLSettings'] := TJSonMsSQLSettings.Create();
  Result := O['MsSQLSettings'] As IJSonMsSQLSettings;
End;

Function TJSonClass.GetProperties() : IJSonProperties;
Begin
  If O['Properties'] = Nil Then
    O['Properties'] := TJSonProperties.Create(stArray);
  Result := O['Properties'] As IJSonProperties;
End;

Function TJSonClass.GetProcedures() : IJSonProcedureDefs;
Begin
  If O['Procedures'] = Nil Then
    O['Procedures'] := TJSonProcedureDefs.Create(stArray);
  Result := O['Procedures'] As IJSonProcedureDefs;
End;

Function TJSonSettings.GetUseCustomClass() : Boolean;
Begin
  Result := B['UseCustomClass'];
End;

Procedure TJSonSettings.SetUseCustomClass(Const AUseCustomClass : Boolean);
Begin
  B['UseCustomClass'] := AUseCustomClass;
End;

Function TJSonSettings.GetUseInterface() : Boolean;
Begin
  Result := B['UseInterface'];
End;

Procedure TJSonSettings.SetUseInterface(Const AUseInterface : Boolean);
Begin
  B['UseInterface'] := AUseInterface;
End;

Function TJSonSettings.GetUseStrict() : Boolean;
Begin
  Result := B['UseStrict'];
End;

Procedure TJSonSettings.SetUseStrict(Const AUseStrict : Boolean);
Begin
  B['UseStrict'] := AUseStrict;
End;

Function TJSonSettings.GetMakeList() : Boolean;
Begin
  Result := B['MakeList'];
End;

Procedure TJSonSettings.SetMakeList(Const AMakeList : Boolean);
Begin
  B['MakeList'] := AMakeList;
End;

Function TJSonSettings.GetUseEnumerator() : Boolean;
Begin
  Result := B['UseEnumerator'];
End;

Procedure TJSonSettings.SetUseEnumerator(Const AUseEnumerator : Boolean);
Begin
  B['UseEnumerator'] := AUseEnumerator;
End;

Function TJSonSettings.GetUseNestedClass() : Boolean;
Begin
  Result := B['UseNestedClass'];
End;

Procedure TJSonSettings.SetUseNestedClass(Const AUseNestedClass : Boolean);
Begin
  B['UseNestedClass'] := AUseNestedClass;
End;

Function TJSonSettings.GetTrackChange() : Boolean;
Begin
  Result := B['TrackChange'];
End;

Procedure TJSonSettings.SetTrackChange(Const ATrackChange : Boolean);
Begin
  B['TrackChange'] := ATrackChange;
End;

Function TJSonSettings.GetSettingDataType() : SOString;
Begin
  Result := S['DataType'];
End;

Procedure TJSonSettings.SetSettingDataType(Const ADataType : SOString);
Begin
  S['DataType'] := ADataType;
End;

Function TJSonMsSQLSettings.GetAdoQueryClassName() : SOString;
Begin
  Result := S['AdoQueryClassName'];
End;

Procedure TJSonMsSQLSettings.SetAdoQueryClassName(Value: SOString);
Begin
  S['AdoQueryClassName'] := Value;
End;

Function TJSonMsSQLSettings.GetTableName() : SOString;
Begin
  Result := S['TableName'];
End;

Procedure TJSonMsSQLSettings.SetTableName(Value: SOString);
Begin
  S['TableName'] := Value;
End;

Function TJSonProperty.GetPropertyName() : SOString;
Begin
  Result := S['Name'];
End;

Procedure TJSonProperty.SetPropertyName(Const APropertyName : SOString);
Begin
  S['Name'] := APropertyName;
End;

Function TJSonProperty.GetPropertyType() : SOString;
Begin
  Result := S['PropertyType'];
End;

Procedure TJSonProperty.SetPropertyType(Const APropertyType : SOString);
Begin
  S['PropertyType'] := APropertyType;
End;

Function TJSonProperty.GetIsReadOnly() : Boolean;
Begin
  Result := B['IsReadOnly'];
End;

Procedure TJSonProperty.SetIsReadOnly(Const AIsReadOnly : Boolean);
Begin
  B['IsReadOnly'] := AIsReadOnly;
End;

Function TJSonProperty.GetPropertyClass() : SOString;
Begin
  Result := S['PropertyClass'];
End;

Procedure TJSonProperty.SetPropertyClass(Const APropertyClass : SOString);
Begin
  S['PropertyClass'] := APropertyClass;
End;

Function TJSonProperty.GetInterfaceName() : SOString;
Begin
  Result := S['InterfaceName'];
End;

Procedure TJSonProperty.SetInterfaceName(Const AInterfaceName : SOString);
Begin
  S['InterfaceName'] := AInterfaceName;
End;

Function TJSonProperty.GetInterfaceImplementor() : SOString;
Begin
  Result := S['InterfaceImplementor'];
End;

Procedure TJSonProperty.SetInterfaceImplementor(Const AInterfaceImplementor : SOString);
Begin
  S['InterfaceImplementor'] := AInterfaceImplementor;
End;

Function TJSonProperty.GetIsDataAware() : Boolean;
Begin
  Result := B['IsDataAware'];
End;

Procedure TJSonProperty.SetIsDataAware(Const AIsDataAware : Boolean);
Begin
  B['IsDataAware'] := AIsDataAware;
End;

Function TJSonProperty.GetIsId() : Boolean;
Begin
  Result := B['IsId'];
End;

Procedure TJSonProperty.SetIsId(Const AIsId : Boolean);
Begin
  B['IsId'] := AIsId;
End;

Function TJSonProperty.GetFieldName() : SOString;
Begin
  Result := S['FieldName'];
End;

Procedure TJSonProperty.SetFieldName(Const AFieldName : SOString);
Begin
  S['FieldName'] := AFieldName;
End;

Function TJSonProperty.GetMaxLen() : Integer;
Begin
  Result := I['MaxLen'];
End;

Procedure TJSonProperty.SetMaxLen(Const AMaxLen : Integer);
Begin
  I['MaxLen'] := AMaxLen;
End;

Function TJSonProperties.Add() : IJSonProperty;
Begin
  Result := TJSonProperty.Create(stObject);
  InHerited Add(Result);
End;

Function TJSonProperties.Add(Const AItem : IJSonProperty) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TJSonProperties.GetItemClass() : TSuperObjectExClass;
Begin
  Result := TJSonProperty;
End;

Function TJSonProperties.GetItem(Const Index : Integer) : IJSonProperty;
Begin
  Result := InHerited GetItem(Index) As IJSonProperty;
End;

Function TJSonProcedureDef.GetProcedureType() : Byte;
Begin
  Result := I['ProcedureType'];
End;

Procedure TJSonProcedureDef.SetProcedureType(Const AProcedureType : Byte);
Begin
  I['ProcedureType'] := AProcedureType;
End;

Function TJSonProcedureDef.GetProcedureDef() : String;
Begin
  Result := S['ProcedureDef'];
End;

Procedure TJSonProcedureDef.SetProcedureDef(Const AProcedureDef : String);
Begin
  S['ProcedureDef'] := AProcedureDef;
End;

Function TJSonProcedureDef.GetProcedureImpl() : String;
Begin
  Result := S['ProcedureImpl'];
End;

Procedure TJSonProcedureDef.SetProcedureImpl(Const AProcedureImpl : String);
Begin
  S['ProcedureImpl'] := AProcedureImpl;
End;

Function TJSonProcedureDefs.Add() : IJSonProcedureDef;
Begin
  Result := TJSonProcedureDef.Create(stObject);
  InHerited Add(Result);
End;

Function TJSonProcedureDefs.Add(Const AItem : IJSonProcedureDef) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TJSonProcedureDefs.GetItemClass() : TSuperObjectExClass;
Begin
  Result := TJSonProcedureDef;
End;

Function TJSonProcedureDefs.GetItem(Const Index : Integer) : IJSonProcedureDef;
Begin
  Result := InHerited Items[Index] As IJSonProcedureDef;
End;

end.
