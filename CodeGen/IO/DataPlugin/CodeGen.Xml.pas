unit CodeGen.Xml;

interface

Uses Classes, HsXmlDocEx, CodeGenIntf;

Type
  IXMLClassSettings = Interface(IXMLNodeEx)
    ['{B17639D0-190D-4A8D-A964-63E87E8C2728}']
    Function  GetInHeritsFrom() : String;
    Procedure SetInHeritsFrom(Const AInHeritsFrom : String);

    Function  GetUseCustomClass() : Boolean;
    Procedure SetUseCustomClass(Value : Boolean);

    Function  GetUseInterface() : Boolean;
    Procedure SetUseInterface(Value : Boolean);

    Function  GetUseStrict() : Boolean;
    Procedure SetUseStrict(Value : Boolean);

    Function  GetMakeList() : Boolean;
    Procedure SetMakeList(Value : Boolean);

    Function  GetUseEnumerator() : Boolean;
    Procedure SetUseEnumerator(Const AUseEnumerator : Boolean);

    Function  GetUseNestedClass() : Boolean;
    Procedure SetUseNestedClass(Const AUseNestedClass : Boolean);
    
    Function  GetTrackChange() : Boolean;
    Procedure SetTrackChange(Value : Boolean);

    Function  GetDataType() : String;
    Procedure SetDataType(Value : String);

    Property InHeritsFrom   : String     Read GetInHeritsFrom   Write SetInHeritsFrom;
    Property UseCustomClass : Boolean    Read GetUseCustomClass Write SetUseCustomClass;
    Property UseInterface   : Boolean    Read GetUseInterface   Write SetUseInterface;
    Property UseStrict      : Boolean    Read GetUseStrict      Write SetUseStrict;
    Property MakeList       : Boolean    Read GetMakeList       Write SetMakeList;
    Property UseEnumerator  : Boolean    Read GetUseEnumerator  Write SetUseEnumerator;
    Property UseNestedClass : Boolean    Read GetUseNestedClass Write SetUseNestedClass;
    Property TrackChange    : Boolean    Read GetTrackChange    Write SetTrackChange;
    Property DataType       : String     Read GetDataType       Write SetDataType;

  End;

  IXMLMsSQLSettings = Interface(IXMLNodeEx)
    ['{D9A0F233-9293-4EE9-805B-12F97BA53E02}']
    Function  GetAdoQueryClassName() : String;
    Procedure SetAdoQueryClassName(Value : String);

    Function  GetTableName() : String;
    Procedure SetTableName(Value : String);

    Property AdoQueryClassName : String Read GetAdoQueryClassName Write SetAdoQueryClassName;
    Property TableName         : String Read GetTableName         Write SetTableName;

  End;

  IXMLPropertyDef = Interface(IXMLNodeEx)
    ['{89CA564F-1E1E-4985-B8E6-FEF122DACBE5}']
    Function  GetName() : String;
    Procedure SetName(Value : String);

    Function  GetPropertyType() : String;
    Procedure SetPropertyType(Value : String);

    Function  GetIsReadOnly() : Boolean;
    Procedure SetIsReadOnly(Value : Boolean);

    Function  GetIsDataAware() : Boolean;
    Procedure SetIsDataAware(Value : Boolean);

    Function  GetPropertyClass() : String;
    Procedure SetPropertyClass(Value : String);

    //-->dtInterface
    Function  GetInterfaceName() : String;
    Procedure SetInterfaceName(Const AInterfaceName : String);
    Function  GetInterfaceImplementor() : String;
    Procedure SetInterfaceImplementor(Const AInterfaceImplementor : String);
    
    Function  GetIsId() : Boolean;
    Procedure SetIsId(Value : Boolean);

    Function  GetFieldName() : String;
    Procedure SetFieldName(Value : String);

    Function  GetMaxLen() : Integer;
    Procedure SetMaxLen(Value : Integer);

    Function  GetIsBigEndian() : Boolean;
    Procedure SetIsBigEndian(Value: Boolean);

    Property Name          : String  Read GetName          Write SetName;
    Property PropertyType  : String  Read GetPropertyType  Write SetPropertyType;
    Property IsReadOnly    : Boolean Read GetIsReadOnly    Write SetIsReadOnly;
    Property IsDataAware   : Boolean Read GetIsDataAware   Write SetIsDataAware;

    Property PropertyClass : String  Read GetPropertyClass Write SetPropertyClass;

    //dtInterface
    Property InterfaceName        : String Read GetInterfaceName Write SetInterfaceName;
    Property InterfaceImplementor : String Read GetInterfaceImplementor Write SetInterfaceImplementor;
    
    Property IsId          : Boolean     Read GetIsId          Write SetIsId;
    Property FieldName     : String  Read GetFieldName     Write SetFieldName;

    Property MaxLen        : Integer     Read GetMaxLen        Write SetMaxLen;
    Property IsBigEndian   : Boolean     Read GetIsBigEndian   Write SetIsBigEndian;
  End;

  IXMLPropertyDefs = Interface(IXmlNodeCollectionEx)
    ['{5C6C9596-D33E-4456-9561-E24A9A882AC8}']
    Function GetProperty(Index: Integer): IXMLPropertyDef;

    Function Add() : IXMLPropertyDef;
    Function Insert(Const Index: Integer): IXMLPropertyDef;
    Property Properties[Index: Integer]: IXMLPropertyDef Read GetProperty; Default;

  End;

  IXmlProcedureDef = Interface(IXMLNodeEx)
    ['{4B61686E-29A0-2112-B7DF-A54E2D213E91}']
    Function  GetProcedureType() : Byte;
    Procedure SetProcedureType(Const AProcedureType : Byte);

    Function  GetProcedureDef() : String;
    Procedure SetProcedureDef(Const AProcedureDef : String);

    Function  GetProcedureName() : String;
    Procedure SetProcedureName(Const AProcedureName : String);

    Function  GetProcedureParameters() : String;
    Procedure SetProcedureParameters(Const AProcedureParameters : String);

    Function  GetResultType() : String;
    Procedure SetResultType(Const AResultType : String);

    Function  GetProcedureScope() : String;
    Procedure SetProcedureScope(Const AProcedureScope : String);
    
    Function  GetProcedureImpl() : String;
    Procedure SetProcedureImpl(AProcedureImpl : String);

    Function  GetIsVirtual() : Boolean;
    Procedure SetIsVirtual(AIsVirtual : Boolean);

    Function  GetIsAbstract() : Boolean;
    Procedure SetIsAbstract(AIsAbstract : Boolean);

    Function  GetIsOverRide() : Boolean;
    Procedure SetIsOverRide(AIsOverRide : Boolean);

    Function  GetIsReintroduce() : Boolean;
    Procedure SetIsReintroduce(AIsReintroduce : Boolean);

    Function  GetIsOverLoad() : Boolean;
    Procedure SetIsOverLoad(Const AIsOverLoad : Boolean);

    Function  GetShowInInterface() : Boolean;
    Procedure SetShowInInterface(Const AShowInInterface : Boolean);

    Property ProcedureType       : Byte    Read GetProcedureType       Write SetProcedureType;
    Property ProcedureDef        : String  Read GetProcedureDef        Write SetProcedureDef;
    Property ProcedureName       : String  Read GetProcedureName       Write SetProcedureName;
    Property ProcedureParameters : String  Read GetProcedureParameters Write SetProcedureParameters;
    Property ResultType          : String  Read GetResultType          Write SetResultType;
    Property ProcedureScope      : String  Read GetProcedureScope      Write SetProcedureScope;
    Property ProcedureImpl       : String  Read GetProcedureImpl       Write SetProcedureImpl;
    Property IsVirtual           : Boolean Read GetIsVirtual           Write SetIsVirtual;
    Property IsAbstract          : Boolean Read GetIsAbstract          Write SetIsAbstract;
    Property IsOverRide          : Boolean Read GetIsOverRide          Write SetIsOverRide;
    Property IsReintroduce       : Boolean Read GetIsReintroduce       Write SetIsReintroduce;
    Property IsOverLoad          : Boolean Read GetIsOverLoad          Write SetIsOverLoad;
    Property ShowInInterface     : Boolean Read GetShowInInterface     Write SetShowInInterface;

  End;

  IXmlProcedureDefs = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-9C6B-F949AD3F1717}']
    Function GetProcedure(Const Index : Integer) : IXmlProcedureDef;

    Function Add() : IXmlProcedureDef;
    Function Insert(Const Index: Integer) : IXmlProcedureDef;

    Property Items[Const Index: Integer] : IXmlProcedureDef Read GetProcedure; Default;

  End;

  IXMLClassDef = Interface(IXMLNodeEx)
    ['{EBB74DEC-9864-449D-ACA3-3EE6267F4C9B}']
    Function  GetName() : String;
    Procedure SetName(Value: String);

    Function  GetSettings() : IXMLClassSettings;
    Function  GetMsSQLSettings() : IXMLMsSQLSettings;
    Function  GetProperties() : IXMLPropertyDefs;
    Function  GetProcedureDefs() : IXmlProcedureDefs;

    Property Name          : String            Read GetName         Write SetName;
    Property Settings      : IXMLClassSettings Read GetSettings;
    Property MsSQLSettings : IXMLMsSQLSettings Read GetMsSQLSettings;
    Property Properties    : IXMLPropertyDefs  Read GetProperties;
    Property ProcedureDefs : IXmlProcedureDefs Read GetProcedureDefs;

  End;

  IXMLClassCodeGenerators = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-9274-D30AF6B2F804}']
    Function GetClassDef(Index: Integer): IXMLClassDef;

    Function Add() : IXMLClassDef;
    Function Insert(Const Index: Integer): IXMLClassDef;
    Property Items[Index: Integer]: IXMLClassDef Read GetClassDef; Default;

  End;

  IXMLTypeDef = Interface(IXMLNodeEx)
    ['{4B61686E-29A0-2112-BABD-4F0928CB5852}']
    Function  GetTypeDefType() : String;
    Procedure SetTypeDefType(Const ATypeDefType : String);

    Function  GetTypeDefName() : String;
    Procedure SetTypeDefName(Const ATypeDefName : String);

    Function  GetTypeDefValue() : String;
    Procedure SetTypeDefValue(Const ATypeDefValue : String);

    Function GetTypeDefValues() : IXMLPropertyDefs;

    Property TypeDefType  : String Read GetTypeDefType  Write SetTypeDefType;
    Property TypeDefName  : String Read GetTypeDefName  Write SetTypeDefName;
    Property TypeDefValue : String Read GetTypeDefValue Write SetTypeDefValue;
    Property TypeDefValues : IXMLPropertyDefs Read GetTypeDefValues;

  End;

  IXMLTypeDefs = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-9573-1F926A739286}']
    Function MyGetItem(Const Index : Integer) : IXMLTypeDef;

    Function Add() : IXMLTypeDef;
    Function Insert(Const Index: Integer) : IXMLTypeDef;

    Property Items[Const Index: Integer] : IXMLTypeDef Read MyGetItem; Default;

  End;

  IXMLUnitGenerator = Interface(IXMLNodeEx)
    ['{4B61686E-29A0-2112-9870-2A2DF1D314ED}']
    Procedure SaveToFile(Const AFileName : String);
    Procedure LoadFromFile(Const AFileName : String);

    Function  GetGenerator() : IHsUnitGenerator;
    Procedure SetGenerator(AGenerator : IHsUnitGenerator);

    Function  GetUnitName() : String;
    Procedure SetUnitName(Const AUnitName : String);

    Function GetTypeDefs() : IXMLTypeDefs;
    Function GetClassDefs() : IXMLClassCodeGenerators;

    Property Generator : IHsUnitGenerator Read GetGenerator Write SetGenerator;
    Property UnitName : String Read GetUnitName Write SetUnitName;

    Property TypeDefs  : IXMLTypeDefs            Read GetTypeDefs;
    Property ClassDefs : IXMLClassCodeGenerators Read GetClassDefs;

  End;

  TXmlCodeGen = Class(TObject)
  Public
    Class Function CreateGenerator(AGenerator : IHsUnitGenerator) : IXMLUnitGenerator; OverLoad;
    Class Function CreateGenerator(ADocument : IXmlDocumentEx) : IXMLUnitGenerator; OverLoad;
    Class Function CreateGenerator(AXmlString : String) : IXMLUnitGenerator; OverLoad;

  End;

implementation

Uses Variants, SysUtils, HsInterfaceEx, CodeGen.IO;

Type
  TXMLUnitGenerator = Class(TXMLNodeEx,
    IHsUnitGeneratorFileManager, IXMLUnitGenerator)
  Private
    FGenerator : Pointer;
    FIsLoading : Boolean;

    FIntfEx : TInterfacedObjectEx;
    Function GetImplementor() : TInterfacedObjectEx;

  Protected
    Property IUGFMImpl : TInterfacedObjectEx Read GetImplementor Implements IHsUnitGeneratorFileManager;

    Function _AddRef() : Integer; StdCall;

    Function  GetGenerator() : IHsUnitGenerator;
    Procedure SetGenerator(AGenerator : IHsUnitGenerator);

    Function  GetUnitName() : String;
    Procedure SetUnitName(Const AUnitName : String);

    Function GetTypeDefs() : IXMLTypeDefs;
    Function GetClassDefs() : IXMLClassCodeGenerators;

  Public
    Procedure AfterConstruction(); OverRide;

    Procedure SaveToFile(Const AFileName : String);
    Procedure LoadFromFile(Const AFileName : String);

    Class Function CoCreate(ADocument : IXMLDocumentEx) : IXMLUnitGenerator; OverLoad;
    Class Function CoCreate(AGenerator : IHsUnitGenerator) : IXMLUnitGenerator; OverLoad;
    Class Function CoCreate(ADocument : IXMLDocumentEx; AGenerator : IHsUnitGenerator) : IXMLUnitGenerator; OverLoad;

  End;

  TXMLClassCodeGenerators = Class(TXMLNodeCollectionEx, IXMLClassCodeGenerators)
  Protected
    Function GetClassDef(Index: Integer): IXMLClassDef;

    Function Add() : IXMLClassDef;
    Function Insert(Const Index: Integer): IXMLClassDef;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLTypeDef = Class(TXMLNodeEx, IXMLTypeDef)
  Protected
    Function  GetTypeDefType() : String; Virtual;
    Procedure SetTypeDefType(Const ATypeDefType : String); Virtual;

    Function  GetTypeDefName() : String;
    Procedure SetTypeDefName(Const ATypeDefName : String);

    Function  GetTypeDefValue() : String; Virtual;
    Procedure SetTypeDefValue(Const ATypeDefValue : String); Virtual;

    Function GetTypeDefValues() : IXMLPropertyDefs;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLTypeDefs = Class(TXMLNodeCollectionEx, IXMLTypeDefs)
  Protected
    Function MyGetItem(Const Index : Integer) : IXMLTypeDef;

    Function Add() : IXMLTypeDef;
    Function Insert(Const Index : Integer) : IXMLTypeDef;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlProcedureDef = Class(TXMLNodeEx, IXmlProcedureDef)
  Protected
    Function  GetProcedureType() : Byte; Virtual;
    Procedure SetProcedureType(Const AProcedureType : Byte); Virtual;

    Function  GetProcedureDef() : String; Virtual;
    Procedure SetProcedureDef(Const AProcedureDef : String); Virtual;

    Function  GetProcedureName() : String;
    Procedure SetProcedureName(Const AProcedureName : String);

    Function  GetProcedureParameters() : String;
    Procedure SetProcedureParameters(Const AProcedureParameters : String);

    Function  GetResultType() : String; Virtual;
    Procedure SetResultType(Const AResultType : String); Virtual;

    Function  GetProcedureScope() : String; Virtual;
    Procedure SetProcedureScope(Const AProcedureScope : String); Virtual;

    Function  GetProcedureImpl() : String; Virtual;
    Procedure SetProcedureImpl(AProcedureImpl : String); Virtual;

    Function  GetIsVirtual() : Boolean; Virtual;
    Procedure SetIsVirtual(AIsVirtual : Boolean); Virtual;

    Function  GetIsAbstract() : Boolean; Virtual;
    Procedure SetIsAbstract(AIsAbstract : Boolean); Virtual;

    Function  GetIsOverRide() : Boolean; Virtual;
    Procedure SetIsOverRide(AIsOverRide : Boolean); Virtual;

    Function  GetIsReintroduce() : Boolean; Virtual;
    Procedure SetIsReintroduce(AIsReintroduce : Boolean); Virtual;

    Function  GetIsOverLoad() : Boolean; Virtual;
    Procedure SetIsOverLoad(Const AIsOverLoad : Boolean); Virtual;

    Function  GetShowInInterface() : Boolean; Virtual;
    Procedure SetShowInInterface(Const AShowInInterface : Boolean); Virtual;

  End;

  TXmlProcedureDefs = Class(TXMLNodeCollectionEx, IXmlProcedureDefs)
  Protected
    Function GetProcedure(Const Index : Integer) : IXmlProcedureDef;

    Function Add() : IXmlProcedureDef;
    Function Insert(Const Index : Integer) : IXmlProcedureDef;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLClassDef = Class(TXMLNodeEx, IXMLClassDef)
  Protected
    Function  GetName() : String;
    Procedure SetName(Value: String);

    Function GetSettings() : IXMLClassSettings;
    Function GetMsSQLSettings() : IXMLMsSQLSettings;
    Function GetProperties() : IXMLPropertyDefs;
    Function GetProcedureDefs() : IXmlProcedureDefs;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXMLClassSettings = Class(TXMLNodeEx, IXMLClassSettings)
  Protected
    Function  GetInHeritsFrom() : String;
    Procedure SetInHeritsFrom(Const AInHeritsFrom : String);

    Function  GetUseCustomClass() : Boolean;
    Procedure SetUseCustomClass(Value: Boolean);

    Function  GetUseInterface() : Boolean;
    Procedure SetUseInterface(Value: Boolean);

    Function  GetUseStrict() : Boolean;
    Procedure SetUseStrict(Value : Boolean);

    Function  GetMakeList() : Boolean;
    Procedure SetMakeList(Value: Boolean);

    Function  GetUseEnumerator() : Boolean;
    Procedure SetUseEnumerator(Const AUseEnumerator : Boolean);

    Function  GetUseNestedClass() : Boolean;
    Procedure SetUseNestedClass(Const AUseNestedClass : Boolean);

    Function  GetTrackChange() : Boolean;
    Procedure SetTrackChange(Value: Boolean);

    Function  GetDataType() : String;
    Procedure SetDataType(Value: String);

  End;

  TXMLMsSQLSettings = Class(TXMLNodeEx, IXMLMsSQLSettings)
  Protected
    Function  GetAdoQueryClassName() : String;
    Procedure SetAdoQueryClassName(Value: String);

    Function  GetTableName() : String;
    Procedure SetTableName(Value: String);

  End;

  TXMLPropertyDefs = Class(TXMLNodeCollectionEx, IXMLPropertyDefs)
  Protected
    Function GetProperty(Index: Integer): IXMLPropertyDef;
    Function Add() : IXMLPropertyDef;
    Function Insert(Const Index: Integer): IXMLPropertyDef;

  Public
    Procedure AfterConstruction; OverRide;

  End;

  TXMLPropertyDef = Class(TXMLNodeEx, IXMLPropertyDef)
  Protected
    Function  GetName() : String;
    Procedure SetName(Value: String);

    Function  GetPropertyType() : String;
    Procedure SetPropertyType(Value: String);

    Function  GetIsReadOnly() : Boolean;
    Procedure SetIsReadOnly(Value: Boolean);

    //-->dtClass
    Function  GetPropertyClass() : String;
    Procedure SetPropertyClass(Value: String);

    //-->dtInterface
    Function  GetInterfaceName() : String;
    Procedure SetInterfaceName(Const AInterfaceName : String);
    Function  GetInterfaceImplementor() : String;
    Procedure SetInterfaceImplementor(Const AInterfaceImplementor : String);

    //-->dsMsSql
    Function  GetIsDataAware() : Boolean;
    Procedure SetIsDataAware(Value: Boolean);

    Function  GetIsId() : Boolean;
    Procedure SetIsId(Value: Boolean);

    Function  GetFieldName() : String;
    Procedure SetFieldName(Value: String);

    //-->dtString, dtWideString
    Function  GetMaxLen() : Integer;
    Procedure SetMaxLen(Value: Integer);

    //-->dtWord, dtDWord, dtQWord
    Function  GetIsBigEndian() : Boolean;
    Procedure SetIsBigEndian(Value : Boolean);

  End;

Class Function TXmlCodeGen.CreateGenerator(AGenerator : IHsUnitGenerator) : IXMLUnitGenerator;
Begin
  Result := TXMLUnitGenerator.CoCreate(AGenerator);
End;

Class Function TXmlCodeGen.CreateGenerator(ADocument : IXMLDocumentEx) : IXMLUnitGenerator;
Begin
  Result := TXMLUnitGenerator.CoCreate(ADocument);
End;

Class Function TXmlCodeGen.CreateGenerator(AXmlString : String) : IXMLUnitGenerator;
Var lXmlDoc : IXmlDocumentEx;
Begin
  lXmlDoc := TXmlDocumentEx.Create(Nil);
  Try
    lXmlDoc.LoadFromXml(AXmlString);
    Result := CreateGenerator(lXmlDoc);
    
    Finally
      lXmlDoc := Nil;
  End;
End;

(******************************************************************************)

Class Function TXMLUnitGenerator.CoCreate(ADocument : IXMLDocumentEx; AGenerator : IHsUnitGenerator) : IXMLUnitGenerator;
Begin
  Result := CoCreate(ADocument);
  Result.Generator := AGenerator;
End;

Class Function TXMLUnitGenerator.CoCreate(ADocument : IXMLDocumentEx) : IXMLUnitGenerator;
Begin
  Result := ADocument.GetDocBinding('UnitDef', TXMLUnitGenerator, '') As IXMLUnitGenerator;
End;

Class Function TXMLUnitGenerator.CoCreate(AGenerator : IHsUnitGenerator) : IXMLUnitGenerator;
Begin
  Result := CoCreate(TXmlDocumentEx.Create(Nil), AGenerator);
End;

Procedure TXMLUnitGenerator.AfterConstruction();
Begin
  RegisterChildNode('TypeDefs', TXMLTypeDefs);
  RegisterChildNode('ClassDefs', TXMLClassCodeGenerators);

  FGenerator := Nil;
  FIsLoading := False;
  Inherited AfterConstruction();
End;

Function TXMLUnitGenerator.GetImplementor() : TInterfacedObjectEx;
Begin
  If Not Assigned(FIntfEx) Then
    FIntfEx := TInterfacedObjectEx.Create(True);

  Result := FIntfEx;
End;

Function TXMLUnitGenerator._AddRef() : Integer;
Var lIO : IXmlIO;
Begin
  Result := InHerited _AddRef();

  If Assigned(FGenerator) And Not FIsLoading Then
  Begin
    FIsLoading := True;
    Try
      lIO := TCodeGenIO.CreateXmlIO(Self);
      lIO.LoadFrom(IHsUnitGenerator(FGenerator));

      Finally
        FIsLoading := False;
    End;
  End;
End;

Procedure TXMLUnitGenerator.SaveToFile(Const AFileName : String);
Begin
  With TStringList.Create() Do
  Try
    Add(FormatXMLData(GetXML()));
    SaveToFile(AFileName);

    Finally
      Free();
  End;
End;

Procedure TXMLUnitGenerator.LoadFromFile(Const AFileName : String);
Var lIO : IXmlIO;
    lXml : IXMLUnitGenerator;
    lDoc : IXmlDocumentEx;
Begin
  If Assigned(FGenerator) And Not FIsLoading Then
  Begin
    FIsLoading := True;
    Try
      lDoc := TXmlDocumentEx.Create(Nil);
      lDoc.LoadFromFile(AFileName);
      lXml := lDoc.GetDocBinding('UnitDef', TXMLUnitGenerator, '') As IXMLUnitGenerator;

      lIO := TCodeGenIO.CreateXmlIO(lXml);
      lIO.SaveTo(IHsUnitGenerator(FGenerator));

      lIO := TCodeGenIO.CreateXmlIO(Self);
      lIO.LoadFrom(IHsUnitGenerator(FGenerator));

      Finally
        FIsLoading := False;
    End;
  End;
End;

Function TXMLUnitGenerator.GetGenerator() : IHsUnitGenerator;
Begin
  Result := IHsUnitGenerator(FGenerator);
End;

Procedure TXMLUnitGenerator.SetGenerator(AGenerator : IHsUnitGenerator);
Var lIO : IXmlIO;
Begin
  FGenerator := Pointer(AGenerator);

  If Assigned(AGenerator) Then
  Begin
    lIO := TCodeGenIO.CreateXmlIO(Self);
    lIO.LoadFrom(AGenerator);
  End;
End;

Function TXMLUnitGenerator.GetUnitName() : String;
Begin
  Result := ChildNodes['UnitName'].AsString;
End;

Procedure TXMLUnitGenerator.SetUnitName(Const AUnitName : String);
Begin
  ChildNodes['UnitName'].AsString := AUnitName;
End;

Function TXMLUnitGenerator.GetTypeDefs() : IXMLTypeDefs;
Begin
  Result := ChildNodes['TypeDefs'] As IXMLTypeDefs;
End;

Function TXMLUnitGenerator.GetClassDefs() : IXMLClassCodeGenerators;
Begin
  Result := ChildNodes['ClassDefs'] As IXMLClassCodeGenerators;
End;

Procedure TXMLClassCodeGenerators.AfterConstruction();
Begin
  RegisterChildNode('ClassDef', TXMLClassDef);
  ItemTag := 'ClassDef';
  ItemInterface := IXMLClassDef;

  InHerited AfterConstruction();
End;

Function TXMLClassCodeGenerators.GetClassDef(Index: Integer): IXMLClassDef;
Begin
  Result := List[Index] As IXMLClassDef;
End;

Function TXMLClassCodeGenerators.Add() : IXMLClassDef;
Begin
  Result := AddItem(-1) As IXMLClassDef;
End;

Function TXMLClassCodeGenerators.Insert(Const Index: Integer): IXMLClassDef;
Begin
  Result := AddItem(Index) As IXMLClassDef;
End;

Procedure TXMLTypeDef.AfterConstruction();
Begin
  RegisterChildNode('TypeDefValues', TXMLPropertyDefs);

  InHerited AfterConstruction();
End;

Function TXMLTypeDef.GetTypeDefValues() : IXMLPropertyDefs;
Begin
  Result := ChildNodes['TypeDefValues'] As IXMLPropertyDefs;
End;

Function TXMLTypeDef.GetTypeDefType() : String;
Begin
  Result := ChildNodes['TypeDefType'].Text;
End;

Procedure TXMLTypeDef.SetTypeDefType(Const ATypeDefType : String);
Begin
  ChildNodes['TypeDefType'].AsString := ATypeDefType;
End;

Function TXMLTypeDef.GetTypeDefName() : String;
Begin
  Result := ChildNodes['TypeDefName'].AsString;
End;

Procedure TXMLTypeDef.SetTypeDefName(Const ATypeDefName : String);
Begin
  ChildNodes['TypeDefName'].AsString := ATypeDefName;
End;

Function TXMLTypeDef.GetTypeDefValue() : String;
Begin
  Result := ChildNodes['TypeDefValue'].AsString;
End;

Procedure TXMLTypeDef.SetTypeDefValue(Const ATypeDefValue : String);
Begin
  ChildNodes['TypeDefValue'].AsString := ATypeDefValue;
End;

Procedure TXMLTypeDefs.AfterConstruction();
Begin
  RegisterChildNode('TypeDef', TXMLTypeDef);
  ItemTag := 'TypeDef';
  ItemInterface := IXMLTypeDef;

  InHerited AfterConstruction();
End;

Function TXMLTypeDefs.MyGetItem(Const Index : Integer) : IXMLTypeDef;
Begin
  Result := List[Index] As IXMLTypeDef;
End;

Function TXMLTypeDefs.Add() : IXMLTypeDef;
Begin
  Result := AddItem(-1) As IXMLTypeDef;
End;

Function TXMLTypeDefs.Insert(Const Index : Integer) : IXMLTypeDef;
Begin
  Result := AddItem(Index) As IXMLTypeDef;
End;

Function TXmlProcedureDef.GetProcedureType() : Byte;
Begin
  Result := ChildNodes['ProcedureType'].AsByte;
End;

Procedure TXmlProcedureDef.SetProcedureType(Const AProcedureType : Byte);
Begin
  ChildNodes['ProcedureType'].AsByte := AProcedureType;
End;

Function TXmlProcedureDef.GetProcedureDef() : String;
Begin
  Result := ChildNodes['ProcedureDef'].AsString;
End;

Procedure TXmlProcedureDef.SetProcedureDef(Const AProcedureDef : String);
Begin
  ChildNodes['ProcedureDef'].AsString := AProcedureDef;
End;

Function TXmlProcedureDef.GetProcedureName() : String;
Begin
  Result := ChildNodes['ProcedureName'].AsString;
End;

Procedure TXmlProcedureDef.SetProcedureName(Const AProcedureName : String);
Begin
  ChildNodes['ProcedureName'].AsString := AProcedureName;
End;

Function TXmlProcedureDef.GetProcedureParameters() : String;
Begin
  Result := ChildNodes['Parameters'].AsString;
End;

Procedure TXmlProcedureDef.SetProcedureParameters(Const AProcedureParameters : String);
Begin
  ChildNodes['Parameters'].AsString := AProcedureParameters;
End;

Function TXmlProcedureDef.GetResultType() : String;
Begin
  Result := ChildNodes['ResultType'].AsString;
End;

Procedure TXmlProcedureDef.SetResultType(Const AResultType : String);
Begin
  ChildNodes['ResultType'].AsString := AResultType;
End;

Function TXmlProcedureDef.GetProcedureScope() : String;
Begin
  Result := ChildNodes['Scope'].AsString;
End;

Procedure TXmlProcedureDef.SetProcedureScope(Const AProcedureScope : String);
Begin
  ChildNodes['Scope'].AsString := AProcedureScope;
End;

Function TXmlProcedureDef.GetProcedureImpl() : String;
Begin
  Result := ChildNodes['ProcedureImpl'].AsString;
End;

Procedure TXmlProcedureDef.SetProcedureImpl(AProcedureImpl : String);
Begin
  ChildNodes['ProcedureImpl'].AsString := AProcedureImpl;
End;

Function  TXmlProcedureDef.GetIsVirtual() : Boolean;
Begin
  Result := ChildNodes['IsVirtual'].AsBoolean;
End;

Procedure TXmlProcedureDef.SetIsVirtual(AIsVirtual : Boolean);
Begin
  ChildNodes['IsVirtual'].AsBoolean := AIsVirtual;
End;

Function  TXmlProcedureDef.GetIsAbstract() : Boolean;
Begin
  Result := ChildNodes['IsAbstract'].AsBoolean;
End;

Procedure TXmlProcedureDef.SetIsAbstract(AIsAbstract : Boolean);
Begin
  ChildNodes['IsAbstract'].AsBoolean := AIsAbstract;
End;

Function  TXmlProcedureDef.GetIsOverRide() : Boolean;
Begin
  Result := ChildNodes['IsOverRide'].AsBoolean;
End;

Procedure TXmlProcedureDef.SetIsOverRide(AIsOverRide : Boolean);
Begin
  ChildNodes['IsOverRide'].AsBoolean := AIsOverRide;
End;

Function  TXmlProcedureDef.GetIsReintroduce() : Boolean;
Begin
  Result := ChildNodes['IsReIntroduce'].AsBoolean;
End;

Procedure TXmlProcedureDef.SetIsReintroduce(AIsReintroduce : Boolean);
Begin
  ChildNodes['IsReIntroduce'].AsBoolean := AIsReintroduce;
End;

Function TXmlProcedureDef.GetIsOverLoad() : Boolean;
Begin
  Result := ChildNodes['IsOverLoad'].AsBoolean;
End;

Procedure TXmlProcedureDef.SetIsOverLoad(Const AIsOverLoad : Boolean);
Begin
  ChildNodes['IsOverLoad'].AsBoolean := AIsOverLoad;
End;

Function TXmlProcedureDef.GetShowInInterface() : Boolean;
Begin
//  If Assigned(ChildNodes.FindNode('ShowInInterface')) Then
    Result := ChildNodes['ShowInInterface'].AsBoolean
//  Else
//    Result := False;
End;

Procedure TXmlProcedureDef.SetShowInInterface(Const AShowInInterface : Boolean);
Begin
  ChildNodes['ShowInInterface'].AsBoolean := AShowInInterface;
End;

Procedure TXmlProcedureDefs.AfterConstruction();
Begin
  RegisterChildNode('Procedure', TXmlProcedureDef);
  ItemTag       := 'Procedure';
  ItemInterface := IXmlProcedureDef;

  InHerited AfterConstruction();
End;

Function TXmlProcedureDefs.GetProcedure(Const Index : Integer) : IXmlProcedureDef;
Begin
  Result := List[Index] As IXmlProcedureDef;
End;

Function TXmlProcedureDefs.Add() : IXmlProcedureDef;
Begin
  Result := AddItem(-1) As IXmlProcedureDef;
End;

Function TXmlProcedureDefs.Insert(Const Index : Integer) : IXmlProcedureDef;
Begin
  Result := AddItem(Index) As IXmlProcedureDef;
End;

Procedure TXMLClassDef.AfterConstruction();
Begin
  RegisterChildNode('Settings', TXMLClassSettings);
  RegisterChildNode('MsSQLSettings', TXMLMsSQLSettings);
  RegisterChildNode('Properies', TXMLPropertyDefs);
  RegisterChildNode('Procedures', TXmlProcedureDefs);

  Inherited AfterConstruction();
End;

Function TXMLClassDef.GetName() : String;
Begin
  Result := AttributeNodes['Name'].AsString;
End;

Procedure TXMLClassDef.SetName(Value: String);
Begin
  SetAttribute('Name', Value);
End;

Function TXMLClassDef.GetSettings() : IXMLClassSettings;
Begin
  Result := ChildNodes['Settings'] As IXMLClassSettings;
End;

Function TXMLClassDef.GetMsSQLSettings() : IXMLMsSQLSettings;
Begin
  Result := ChildNodes['MsSQLSettings'] As IXMLMsSQLSettings;
End;

Function TXMLClassDef.GetProperties() : IXMLPropertyDefs;
Begin
  Result := ChildNodes['Properies'] As IXMLPropertyDefs;
End;

Function TXMLClassDef.GetProcedureDefs() : IXmlProcedureDefs;
Begin
  Result := ChildNodes['Procedures'] As IXmlProcedureDefs;
End;

Function TXMLClassSettings.GetInHeritsFrom() : String;
Begin
  Result := ChildNodes['InHeritsFrom'].AsString;
End;

Procedure TXMLClassSettings.SetInHeritsFrom(Const AInHeritsFrom : String);
Begin
  ChildNodes['InHeritsFrom'].AsString := AInHeritsFrom;
End;

Function TXMLClassSettings.GetUseCustomClass() : Boolean;
Begin
  Result := ChildNodes['UseCustomClass'].AsBoolean;
End;

Procedure TXMLClassSettings.SetUseCustomClass(Value: Boolean);
Begin
  ChildNodes['UseCustomClass'].AsBoolean := Value;
End;

Function TXMLClassSettings.GetUseInterface() : Boolean;
Begin
  Result := ChildNodes['UseInterface'].AsBoolean;
End;

Procedure TXMLClassSettings.SetUseInterface(Value: Boolean);
Begin
  ChildNodes['UseInterface'].AsBoolean := Value;
End;

Function TXMLClassSettings.GetUseStrict() : Boolean;
Begin
  Result := ChildNodes['UseStrict'].AsBoolean;
End;

Procedure TXMLClassSettings.SetUseStrict(Value : Boolean);
Begin
  ChildNodes['UseStrict'].AsBoolean := Value;
End;

Function TXMLClassSettings.GetMakeList() : Boolean;
Begin
  Result := ChildNodes['MakeList'].AsBoolean;
End;

Procedure TXMLClassSettings.SetMakeList(Value: Boolean);
Begin
  ChildNodes['MakeList'].AsBoolean := Value;
End;

Function TXMLClassSettings.GetUseEnumerator() : Boolean;
Begin
  Result := ChildNodes['UseEnumerator'].AsBoolean;
End;

Procedure TXMLClassSettings.SetUseEnumerator(Const AUseEnumerator : Boolean);
Begin
  ChildNodes['UseEnumerator'].AsBoolean := AUseEnumerator;
End;

Function TXMLClassSettings.GetUseNestedClass() : Boolean;
Begin
  Result := ChildNodes['UseNestedClass'].AsBoolean;
End;

Procedure TXMLClassSettings.SetUseNestedClass(Const AUseNestedClass : Boolean);
Begin
  ChildNodes['UseNestedClass'].AsBoolean := AUseNestedClass;
End;

Function TXMLClassSettings.GetTrackChange() : Boolean;
Begin
  Result := ChildNodes['TrackChange'].AsBoolean;
End;

Procedure TXMLClassSettings.SetTrackChange(Value: Boolean);
Begin
  ChildNodes['TrackChange'].AsBoolean := Value;
End;

Function TXMLClassSettings.GetDataType() : String;
Begin
  Result := ChildNodes['DataType'].AsString;
End;

Procedure TXMLClassSettings.SetDataType(Value: String);
Begin
  ChildNodes['DataType'].AsString := Value;
End;

Function TXMLMsSQLSettings.GetAdoQueryClassName() : String;
Begin
  Result := ChildNodes['AdoQueryClassName'].AsString;
End;

Procedure TXMLMsSQLSettings.SetAdoQueryClassName(Value: String);
Begin
  ChildNodes['AdoQueryClassName'].AsString := Value;
End;

Function TXMLMsSQLSettings.GetTableName() : String;
Begin
  Result := ChildNodes['TableName'].AsString;
End;

Procedure TXMLMsSQLSettings.SetTableName(Value: String);
Begin
  ChildNodes['TableName'].AsString := Value;
End;

Procedure TXMLPropertyDefs.AfterConstruction();
Begin
  RegisterChildNode('Property', TXMLPropertyDef);
  ItemTag := 'Property';
  ItemInterface := IXMLPropertyDef;
  Inherited;
End;

Function TXMLPropertyDefs.GetProperty(Index: Integer): IXMLPropertyDef;
Begin
  Result := List[Index] As IXMLPropertyDef;
End;

Function TXMLPropertyDefs.Add() : IXMLPropertyDef;
Begin
  Result := AddItem(-1) As IXMLPropertyDef;
End;

Function TXMLPropertyDefs.Insert(Const Index: Integer): IXMLPropertyDef;
Begin
  Result := AddItem(Index) As IXMLPropertyDef;
End;

Function TXMLPropertyDef.GetName() : String;
Begin
  Result := AttributeNodes['Name'].AsString;
End;

Procedure TXMLPropertyDef.SetName(Value: String);
Begin
  SetAttribute('Name', Value);
End;

Function TXMLPropertyDef.GetPropertyType() : String;
Begin
  Result := AttributeNodes['PropertyType'].AsString;
End;

Procedure TXMLPropertyDef.SetPropertyType(Value: String);
Begin
  SetAttribute('PropertyType', Value);
End;

Function TXMLPropertyDef.GetPropertyClass(): String;
Begin
  Result := ChildNodes['PropertyClass'].AsString;
End;

Procedure TXMLPropertyDef.SetPropertyClass(Value: String);
Begin
  ChildNodes['PropertyClass'].AsString := Value;
End;

Function TXMLPropertyDef.GetInterfaceName() : String;
Begin
  Result := ChildNodes['InterfaceName'].AsString;
End;

Procedure TXMLPropertyDef.SetInterfaceName(Const AInterfaceName : String);
Begin
  ChildNodes['InterfaceName'].AsString := AInterfaceName;
End;

Function TXMLPropertyDef.GetInterfaceImplementor() : String;
Begin
  Result := ChildNodes['InterfaceImplementor'].AsString;
End;

Procedure TXMLPropertyDef.SetInterfaceImplementor(Const AInterfaceImplementor : String);
Begin
  ChildNodes['InterfaceImplementor'].AsString := AInterfaceImplementor;
End;

Function TXMLPropertyDef.GetIsDataAware() : Boolean;
Begin
  Result := ChildNodes['IsDataAware'].AsBoolean;
End;

Procedure TXMLPropertyDef.SetIsDataAware(Value: Boolean);
Begin
  ChildNodes['IsDataAware'].AsBoolean := Value;
End;

Function TXMLPropertyDef.GetIsId() : Boolean;
Begin
  Result := ChildNodes['IsId'].AsBoolean;
End;

Procedure TXMLPropertyDef.SetIsId(Value: Boolean);
Begin
  ChildNodes['IsId'].AsBoolean := Value;
End;

Function TXMLPropertyDef.GetFieldName() : String;
Begin
  Result := ChildNodes['FieldName'].AsString;
End;

Procedure TXMLPropertyDef.SetFieldName(Value: String);
Begin
  ChildNodes['FieldName'].AsString := Value;
End;

Function TXMLPropertyDef.GetMaxLen() : Integer;
Begin
  Result := ChildNodes['MaxLen'].AsInteger;
End;

Procedure TXMLPropertyDef.SetMaxLen(Value: Integer);
Begin
  ChildNodes['MaxLen'].AsInteger := Value;
End;

Function TXMLPropertyDef.GetIsBigEndian() : Boolean;
Begin
  Result := ChildNodes['IsBigEndian'].AsBoolean;
End;

Procedure TXMLPropertyDef.SetIsBigEndian(Value : Boolean);
Begin
  ChildNodes['IsBigEndian'].AsBoolean := Value;
End;

Function TXMLPropertyDef.GetIsReadOnly() : Boolean;
Begin
  Result := ChildNodes['IsReadOnly'].AsBoolean;
End;

Procedure TXMLPropertyDef.SetIsReadOnly(Value: Boolean);
Begin
  ChildNodes['IsReadOnly'].AsBoolean := Value;
End;

end.
