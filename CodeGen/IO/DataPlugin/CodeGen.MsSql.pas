unit CodeGen.MsSql;

interface

Uses HsInterfaceEx, CodeGenIntf;

Type
  TDataState = (edsBrowse, edsAdded, edsModified, edsDeleted);

  IMsSqlPropertyDef = Interface(IHsPropertyDef)
    ['{4B61686E-29A0-2112-82F1-19D060AD2EFC}']
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();

    Function  GetId() : Integer;

    Function  GetIdClassDef() : Integer;
    Procedure SetIdClassDef(Const AIdClassDef : Integer);

    Function  GetPosition() : Integer;
    Procedure SetPosition(Const APosition : Integer);

    Property Id                   : Integer Read GetId;
    Property IdClassDef           : Integer Read GetIdClassDef           Write SetIdClassDef;
    Property Position             : Integer Read GetPosition             Write SetPosition;

  End;

  IMsSqlPropertyDefs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-BA1D-7E0CFD7F8F49}']
    Function  Get(Index : Integer) : IMsSqlPropertyDef;
    Procedure Put(Index : Integer; Const Item : IMsSqlPropertyDef);

    Property Items[Index : Integer] : IMsSqlPropertyDef Read Get Write Put; Default;

  End;

  IMsSqlClassDef = Interface(IHsClassCodeGenerator)
    ['{4B61686E-29A0-2112-8A2D-61861E173050}']
    Procedure DisableTracking();
    Procedure EnableTracking();

    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();

    Function  GetId() : Integer;
    Procedure SetId(Const AId : Integer);

    Function  GetIdUnitDef() : Integer;
    Procedure SetIdUnitDef(Const AIdUnitDef : Integer);

    Function  GetPosition() : Integer;
    Procedure SetPosition(Const APosition : Integer);

    Function  GetPropertyDefs() : IMsSqlPropertyDefs;

    Property Id                : Integer            Read GetId        Write SetId;
    Property IdUnitDef         : Integer            Read GetIdUnitDef Write SetIdUnitDef;
    Property Position          : Integer            Read GetPosition  Write SetPosition;
    Property ClsName           : String             Read GetClsName   Write SetClsName;

    Property PropertyDefs      : IMsSqlPropertyDefs Read GetPropertyDefs;

  End;

  IMsSqlClassDefs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B694-D25666AAD728}']
    Procedure Load(Const AId : Integer);

    Function  Get(Index : Integer) : IMsSqlClassDef;
    Procedure Put(Index : Integer; Const Item : IMsSqlClassDef);

    Property Items[Index : Integer] : IMsSqlClassDef Read Get Write Put; Default;

  End;

  IMsSqlTypeDefValue = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A225-28BD74ACCC40}']
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();

    Function  GetId() : Integer;

    Function  GetIdTypeDef() : Integer;
    Procedure SetIdTypeDef(Const AIdTypeDef : Integer);

    Function  GetPosition() : Integer;
    Procedure SetPosition(Const APosition : Integer);

    Function  GetTypeDefValueType() : Integer;
    Procedure SetTypeDefValueType(Const ATypeDefValueType : Integer);

    Function  GetTypeDefValue() : String;
    Procedure SetTypeDefValue(Const ATypeDefValue : String);

    Property Id               : Integer Read GetId;
    Property IdTypeDef        : Integer Read GetIdTypeDef        Write SetIdTypeDef;
    Property Position         : Integer Read GetPosition         Write SetPosition;
    Property TypeDefValueType : Integer Read GetTypeDefValueType Write SetTypeDefValueType;
    Property TypeDefValue     : String  Read GetTypeDefValue     Write SetTypeDefValue;

  End;

  IMsSqlTypeDefValues = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8FBD-7DB35A6ABF6E}']
    Function  Get(Index : Integer) : IMsSqlTypeDefValue;
    Procedure Put(Index : Integer; Const Item : IMsSqlTypeDefValue);

    Property Items[Index : Integer] : IMsSqlTypeDefValue Read Get Write Put; Default;

  End;

  IMsSqlTypeDef = Interface(IHsTypeDef)
    ['{4B61686E-29A0-2112-919F-C13E0A115D88}']
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();

    Function  GetId() : Integer;

    Function  GetIdUnitDef() : Integer;
    Procedure SetIdUnitDef(Const AIdUnitDef : Integer);

    Function  GetPosition() : Integer;
    Procedure SetPosition(Const APosition : Integer);

    Function  GetTypeDefValues() : IMsSqlTypeDefValues;

    Property Id        : Integer Read GetId;
    Property IdUnitDef : Integer Read GetIdUnitDef Write SetIdUnitDef;
    Property Position  : Integer Read GetPosition  Write SetPosition;

    Property TypeDefValues : IMsSqlTypeDefValues Read GetTypeDefValues;

  End;

  IMsSqlTypeDefs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9F84-CFBEBB98C7F1}']
    Function  Get(Index : Integer) : IMsSqlTypeDef;
    Procedure Put(Index : Integer; Const Item : IMsSqlTypeDef);

    Property Items[Index : Integer] : IMsSqlTypeDef Read Get Write Put; Default;

  End;

  IMsSqlUnitDef = Interface(IHsUnitGenerator)
    ['{4B61686E-29A0-2112-8C5D-F1C1DCC262DD}']
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();

    Function  GetId() : Integer;

    Function  GetClassDefs() : IMsSqlClassDefs;
    Function  GetTypeDefs() : IMsSqlTypeDefs;

    Property Id        : Integer         Read GetId;
    Property ClassDefs : IMsSqlClassDefs Read GetClassDefs;
    Property TypeDefs  : IMsSqlTypeDefs  Read GetTypeDefs;

  End;

  TMsSqlCodeGen = Class(TObject)
  Public
    Class Function CreateGenerator() : IMsSqlUnitDef;

  End;


implementation

Uses
  SysUtils, Db, RtlConsts, CodeGenType, CodeGenImpl, dmCodeGen;

Type
  TMsSqlPropertyDef = Class(THsPropertyDef, IMsSqlPropertyDef)
  Private
    FId         : Integer;
    FIdClassDef : Integer;
    FPosition   : Integer;
    FDataState  : TDataState;

  Protected
    Function  GetId() : Integer; Virtual;

    Function  GetIdClassDef() : Integer; Virtual;
    Procedure SetIdClassDef(Const AIdClassDef : Integer); Virtual;

    Function  GetPosition() : Integer; Virtual;
    Procedure SetPosition(Const APosition : Integer); Virtual;

    Procedure SetPropertyName(Const APropertyName : String); OverRide;
    Procedure SetPropertyType(Const APropertyType : THsPropertyType); OverRide;
    Procedure SetIsDataAware(Const AIsDataAware : Boolean); OverRide;
    Procedure SetIsReadOnly(Const AIsReadOnly : Boolean); OverRide;
    Procedure SetPropertyClass(Const APropertyClass : String); OverRide;
    Procedure SetInterfaceName(Const AInterfaceName : String); OverRide;
    Procedure SetInterfaceImplementor(Const AInterfaceImplementor : String); OverRide;
    Procedure SetIsId(Const AIsId : Boolean); OverRide;
    Procedure SetFieldName(Const AFieldName : String); OverRide;
    Procedure SetMaxLen(Const AMaxLen : Integer); OverRide;

    Procedure Changed(); Virtual;
    Function  GetModified() : Boolean;
    Procedure Clear();

  Public
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();
    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

  End;

  TMsSqlPropertyDefs = Class(THsPropertyDefs, IMsSqlPropertyDefs)
  Protected
    Function  MyGet(Index : Integer) : IMsSqlPropertyDef;
    Procedure MyPut(Index : Integer; Const Item : IMsSqlPropertyDef);

    Function  IMsSqlPropertyDefs.Get = MyGet;
    Procedure IMsSqlPropertyDefs.Put = MyPut;

  End;

  TMsSqlClassDef = Class(THsClassCodeGenerator, IMsSqlClassDef)
  Private
    FId         : Integer;
    FIdUnitDef  : Integer;
    FPosition   : Integer;
    FIsTracking : Boolean;
    FDataState  : TDataState;

  Protected
    Procedure DisableTracking();
    Procedure EnableTracking();

    Function  GetPropertiesClass() : THsPropertyDefsClass; OverRide;

    Function  GetId() : Integer; Virtual;
    Procedure SetId(Const AId : Integer); Virtual;

    Function  GetIdUnitDef() : Integer; Virtual;
    Procedure SetIdUnitDef(Const AIdUnitDef : Integer); Virtual;

    Function  GetPosition() : Integer; Virtual;
    Procedure SetPosition(Const APosition : Integer); Virtual;

    Procedure SetClsName(Const AClsName : String); OverRide;
    Procedure SetUseInterface(Const AUseInterface : Boolean); OverRide;
    Procedure SetUseCustomClass(Const AUseCustomClass : Boolean); OverRide;
    Procedure SetMakeList(Const AMakeList : Boolean); OverRide;
    Procedure SetTrackChange(Const ATrackChange : Boolean); OverRide;
    Procedure SetDataType(Const ADataType : THsDataSource); OverRide;
    Procedure SetAdoQueryClassName(Const AAdoQueryClassName : String); OverRide;
    Procedure SetTableName(Const ATableName : String); OverRide;

    Function  GetPropertyDefs() : IMsSqlPropertyDefs; OverLoad;

    Procedure Changed(); Virtual;
    Function  GetModified() : Boolean;
    Procedure Clear();

  Public
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();
    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

    Procedure AfterConstruction(); OverRide;
    
  End;

  TMsSqlClassDefs = Class(THsClassCodeGenerators, IMsSqlClassDefs)
  Protected
    Function  MyGet(Index : Integer) : IMsSqlClassDef;
    Procedure MyPut(Index : Integer; Const Item : IMsSqlClassDef);

    Function  IMsSqlClassDefs.Get = MyGet;
    Procedure IMsSqlClassDefs.Put = MyPut;

  Public
    Procedure Load(Const AId : Integer);

  End;

  TMsSqlTypeDef = Class(THsTypeDef, IMsSqlTypeDef)
  Private
    FId          : Integer;
    FIdUnitDef   : Integer;
    FPosition    : Integer;
    FDataState   : TDataState;
    FTypeDefValues : IMsSqlTypeDefValues;

  Protected
    Function  GetId() : Integer; Virtual;

    Function  GetIdUnitDef() : Integer; Virtual;
    Procedure SetIdUnitDef(Const AIdUnitDef : Integer); Virtual;

    Function  GetPosition() : Integer; Virtual;
    Procedure SetPosition(Const APosition : Integer); Virtual;

    Procedure SetTypeDefType(Const ATypeDefType : THsTypeDefType); OverRide;
    Procedure SetTypeDefName(Const ATypeDefName : String); OverRide;

    Function  GetTypeDefValues() : IMsSqlTypeDefValues; Virtual;

    Procedure Changed(); Virtual;
    Function  GetModified() : Boolean;
    Procedure Clear();

  Public
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();
    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

  End;

  TMsSqlTypeDefs = Class(THsTypeDefs, IMsSqlTypeDefs)
  Protected
    Function  Get(Index : Integer) : IMsSqlTypeDef; OverLoad;
    Procedure Put(Index : Integer; Const Item : IMsSqlTypeDef); OverLoad;

  End;

  TMsSqlTypeDefValue = Class(TInterfacedObjectEx, IMsSqlTypeDefValue)
  Private
    FId               : Integer;
    FIdTypeDef        : Integer;
    FPosition         : Integer;
    FTypeDefValueType : Integer;
    FTypeDefValue     : String;
    FDataState        : TDataState;

  Protected
    Function  GetId() : Integer; Virtual;

    Function  GetIdTypeDef() : Integer; Virtual;
    Procedure SetIdTypeDef(Const AIdTypeDef : Integer); Virtual;

    Function  GetPosition() : Integer; Virtual;
    Procedure SetPosition(Const APosition : Integer); Virtual;

    Function  GetTypeDefValueType() : Integer; Virtual;
    Procedure SetTypeDefValueType(Const ATypeDefValueType : Integer); Virtual;

    Function  GetTypeDefValue() : String; Virtual;
    Procedure SetTypeDefValue(Const ATypeDefValue : String); Virtual;

    Procedure Changed(); Virtual;
    Function  GetModified() : Boolean;
    Procedure Clear();

  Public
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();
    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

  End;

  TMsSqlTypeDefValues = Class(TInterfaceListEx, IMsSqlTypeDefValues)
  Protected
    Function  MyGet(Index : Integer) : IMsSqlTypeDefValue;
    Procedure MyPut(Index : Integer; Const Item : IMsSqlTypeDefValue);

    Function  IMsSqlTypeDefValues.Get = MyGet;
    Procedure IMsSqlTypeDefValues.Put = MyPut;

  End;

  TMsSqlUnitDef = Class(THsUnitGenerator, IMsSqlUnitDef)
  Private
    FId        : Integer;
    FDataState : TDataState;

  Protected
    Function  GetTypeDefsClass() : THsTypeDefsClass; OverRide;
    Function  GetCodeGeneratorClass() : THsClassCodeGeneratorsClass; OverRide;

    Function  GetId() : Integer; Virtual;

    Procedure SetUnitName(Const AUnitName : String); OverRide;
    Function  GetClassDefs() : IMsSqlClassDefs; OverLoad;
    Function  GetTypeDefs() : IMsSqlTypeDefs; OverLoad;

    Procedure Changed(); Virtual;
    Function  GetModified() : Boolean;
    Procedure Clear();

  Public
    Procedure New();
    Procedure Load(AId : Integer);
    Procedure Save();
    Procedure Delete();
    Procedure Assign(ASource : TObject); ReIntroduce; OverLoad;

  End;

Class Function TMsSqlCodeGen.CreateGenerator() : IMsSqlUnitDef;
Begin
  Result := TMsSqlUnitDef.Create(True);
End;

(******************************************************************************)

Procedure TMsSqlPropertyDef.Changed();
Begin
  Case FDataState Of
    edsBrowse : FDataState := edsModified;
  End;
End;

Function TMsSqlPropertyDef.GetModified() : Boolean;
Begin
  Result := FDataState <> edsBrowse;
End;

Procedure TMsSqlPropertyDef.Clear();
Begin
  FIdClassDef := 0;
  FPosition   := 0;

  InHerited SetPropertyName('');
  InHerited SetPropertyType(ptByte);
  InHerited SetIsDataAware(False);
  InHerited SetIsReadOnly(False);
  InHerited SetPropertyClass('');
  InHerited SetInterfaceName('');
  InHerited SetInterfaceImplementor('');
  InHerited SetIsId(False);
  InHerited SetFieldName('');
  InHerited SetMaxLen(0);
End;

Procedure TMsSqlPropertyDef.New();
Begin
  Clear();
  FDataState := edsAdded;
End;

Procedure TMsSqlPropertyDef.Load(AId : Integer);
Begin
  With DataModuleCodeGen.CreateCodeGenQuery() Do
  Try
    Sql.Text := 'Select *'#$D#$A + 
                'From PropertyDefs'#$D#$A + 
                'Where Id = :Id';

    Parameters.ParamByName('Id').Value := AId;
    Open();

    If Not IsEmpty Then
      Self.Assign(Fields);

    Finally
      Close();
      Free();
  End;
End;

Procedure TMsSqlPropertyDef.Save();
Begin
  If FDataState > edsBrowse Then
    With DataModuleCodeGen.CreateCodeGenQuery() Do
    Try
      If FDataState In [edsAdded, edsModified] Then
      Begin
        Case FDataState Of
          edsAdded :
          Begin
            Sql.Text := 'Insert Into PropertyDefs ('#$D#$A +
                        'IdClassDef,'#$D#$A +
                        'Position,'#$D#$A +
                        'PropertyName,'#$D#$A +
                        'PropertyType,'#$D#$A +
                        'IsDataAware,'#$D#$A +
                        'IsReadOnly,'#$D#$A +
                        'PropertyClass,'#$D#$A +
                        'InterfaceName,'#$D#$A +
                        'InterfaceImplementor,'#$D#$A +
                        'IsId,'#$D#$A +
                        'FieldName,'#$D#$A +
                        'MaxLen'#$D#$A +
                        ') Values ('#$D#$A +
                        ':IdClassDef,'#$D#$A +
                        ':Position,'#$D#$A +
                        ':PropertyName,'#$D#$A +
                        ':PropertyType,'#$D#$A +
                        ':IsDataAware,'#$D#$A +
                        ':IsReadOnly,'#$D#$A +
                        ':PropertyClass,'#$D#$A +
                        ':InterfaceName,'#$D#$A +
                        ':InterfaceImplementor,'#$D#$A +
                        ':IsId,'#$D#$A +
                        ':FieldName,'#$D#$A +
                        ':MaxLen)'#$D#$A +
                        'Select Scope_Identity() LastAutoIncValue';
          End;

          edsModified :
          Begin
            Sql.Text := 'Update PropertyDefs Set'#$D#$A +
                        'IdClassDef = :IdClassDef,'#$D#$A +
                        'Position = :Position,'#$D#$A +
                        'PropertyName = :PropertyName,'#$D#$A +
                        'PropertyType = :PropertyType,'#$D#$A +
                        'IsDataAware = :IsDataAware,'#$D#$A +
                        'IsReadOnly = :IsReadOnly,'#$D#$A +
                        'PropertyClass = :PropertyClass,'#$D#$A +
                        'InterfaceName = :InterfaceName,'#$D#$A +
                        'InterfaceImplementor = :InterfaceImplementor,'#$D#$A +
                        'IsId = :IsId,'#$D#$A +
                        'FieldName = :FieldName,'#$D#$A +
                        'MaxLen = :MaxLen'#$D#$A +
                        'Where Id = :Id';

            Parameters.ParamByName('Id').Value := FId;
          End;
        End;

        Parameters.ParamByName('IdClassDef').Value           := FIdClassDef;
        Parameters.ParamByName('Position').Value             := FPosition;

        Parameters.ParamByName('PropertyName').Value         := InHerited GetPropertyName();
        Parameters.ParamByName('PropertyType').Value         := InHerited GetPropertyType();
        Parameters.ParamByName('IsDataAware').Value          := InHerited GetIsDataAware();
        Parameters.ParamByName('IsReadOnly').Value           := InHerited GetIsReadOnly();
        Parameters.ParamByName('PropertyClass').Value        := InHerited GetPropertyClass();
        Parameters.ParamByName('InterfaceName').Value        := InHerited GetInterfaceName();
        Parameters.ParamByName('InterfaceImplementor').Value := InHerited GetInterfaceImplementor();
        Parameters.ParamByName('IsId').Value                 := InHerited GetIsId();
        Parameters.ParamByName('FieldName').Value            := InHerited GetFieldName();
        Parameters.ParamByName('MaxLen').Value               := InHerited GetMaxLen();
      End
      Else If FDataState = edsDeleted Then
      Begin
        Sql.Text := 'Delete From PropertyDefs'#$D#$A +
                    'Where Id = :Id';
        Parameters.ParamByName('Id').Value := FId;
      End;

      If FDataState = edsAdded Then
      Begin
        Open();
        FId := FieldByName('LastAutoIncValue').AsInteger;
      End
      Else
        ExecSql();

      Finally
        Free();
    End;
End;

Procedure TMsSqlPropertyDef.Delete();
Begin
  FDataState := edsDeleted;
End;

Procedure TMsSqlPropertyDef.Assign(ASource : TObject);
Var lSrc    : TMsSqlPropertyDef;
    lFields : TFields;
Begin
(*  If ASource Is TMsSqlPropertyDef Then
  Begin
    lSrc := TMsSqlPropertyDef(ASource);

    FId                   := lSrc.Id;
    FIdClassDef           := lSrc.IdClassDef;
    FPosition             := lSrc.Position;
    FPropertyName         := lSrc.PropertyName;
    FPropertyType         := lSrc.PropertyType;
    FIsDataAware          := lSrc.IsDataAware;
    FIsReadOnly           := lSrc.IsReadOnly;
    FPropertyClass        := lSrc.PropertyClass;
    FInterfaceName        := lSrc.InterfaceName;
    FInterfaceImplementor := lSrc.InterfaceImplementor;
    FIsId                 := lSrc.IsId;
    FFieldName            := lSrc.FieldName;
    FMaxLen               := lSrc.MaxLen;
  End
  Else*) If ASource Is TFields Then
  Begin
    lFields := TFields(ASource);

    FId         := lFields.FieldByName('Id').AsInteger;
    FIdClassDef := lFields.FieldByName('IdClassDef').AsInteger;
    FPosition   := lFields.FieldByName('Position').AsInteger;

    InHerited SetPropertyName(lFields.FieldByName('PropertyName').AsString);
    InHerited SetPropertyType(THsPropertyType(lFields.FieldByName('PropertyType').AsInteger));
    InHerited SetIsDataAware(lFields.FieldByName('IsDataAware').AsBoolean);
    InHerited SetIsReadOnly(lFields.FieldByName('IsReadOnly').AsBoolean);
    InHerited SetPropertyClass(lFields.FieldByName('PropertyClass').AsString);
    InHerited SetInterfaceName(lFields.FieldByName('InterfaceName').AsString);
    InHerited SetInterfaceImplementor(lFields.FieldByName('InterfaceImplementor').AsString);
    InHerited SetIsId(lFields.FieldByName('IsId').AsBoolean);
    InHerited SetFieldName(lFields.FieldByName('FieldName').AsString);
    InHerited SetMaxLen(lFields.FieldByName('MaxLen').AsInteger);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TMsSqlPropertyDef.GetId() : Integer;
Begin
  Result := FId;
End;

Function TMsSqlPropertyDef.GetIdClassDef() : Integer;
Begin
  Result := FIdClassDef;
End;

Procedure TMsSqlPropertyDef.SetIdClassDef(Const AIdClassDef : Integer);
Begin
  If FIdClassDef <> AIdClassDef Then
  Begin
    FIdClassDef := AIdClassDef;
    Changed();
  End
End;

Function TMsSqlPropertyDef.GetPosition() : Integer;
Begin
  Result := FPosition;
End;

Procedure TMsSqlPropertyDef.SetPosition(Const APosition : Integer);
Begin
  If FPosition <> APosition Then
  Begin
    FPosition := APosition;
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetPropertyName(Const APropertyName : String);
Begin
  If Length(APropertyName) > 35 Then
    Raise Exception.Create('MaxLength for property PropertyName is : 35');
  If GetPropertyName() <> APropertyName Then
  Begin
    InHerited SetPropertyName(APropertyName);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetPropertyType(Const APropertyType : THsPropertyType);
Begin
  If GetPropertyType() <> APropertyType Then
  Begin
    InHerited SetPropertyType(APropertyType);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetIsDataAware(Const AIsDataAware : Boolean);
Begin
  If GetIsDataAware() <> AIsDataAware Then
  Begin
    InHerited SetIsDataAware(AIsDataAware);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetIsReadOnly(Const AIsReadOnly : Boolean);
Begin
  If GetIsReadOnly() <> AIsReadOnly Then
  Begin
    InHerited SetIsReadOnly(AIsReadOnly);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetPropertyClass(Const APropertyClass : String);
Begin
  If Length(APropertyClass) > 35 Then
    Raise Exception.Create('MaxLength for property PropertyClass is : 35');
  If GetPropertyClass() <> APropertyClass Then
  Begin
    InHerited SetPropertyClass(APropertyClass);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetInterfaceName(Const AInterfaceName : String);
Begin
  If Length(AInterfaceName) > 35 Then
    Raise Exception.Create('MaxLength for property InterfaceName is : 35');
  If GetInterfaceName() <> AInterfaceName Then
  Begin
    InHerited SetInterfaceName(AInterfaceName);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetInterfaceImplementor(Const AInterfaceImplementor : String);
Begin
  If Length(AInterfaceImplementor) > 35 Then
    Raise Exception.Create('MaxLength for property InterfaceImplementor is : 35');
  If GetInterfaceImplementor() <> AInterfaceImplementor Then
  Begin
    InHerited SetInterfaceImplementor(AInterfaceImplementor);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetIsId(Const AIsId : Boolean);
Begin
  If GetIsId() <> AIsId Then
  Begin
    InHerited SetIsId(AIsId);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetFieldName(Const AFieldName : String);
Begin
  If Length(AFieldName) > 128 Then
    Raise Exception.Create('MaxLength for property FieldName is : 128');
  If GetFieldName() <> AFieldName Then
  Begin
    InHerited SetFieldName(AFieldName);
    Changed();
  End
End;

Procedure TMsSqlPropertyDef.SetMaxLen(Const AMaxLen : Integer);
Begin
  If GetMaxLen() <> AMaxLen Then
  Begin
    InHerited SetMaxLen(AMaxLen);
    Changed();
  End
End;

Function TMsSqlPropertyDefs.MyGet(Index : Integer) : IMsSqlPropertyDef;
Begin
  Supports(InHerited Items[Index], IMsSqlPropertyDef, Result);
End;

Procedure TMsSqlPropertyDefs.MyPut(Index : Integer; Const Item : IMsSqlPropertyDef);
Var lInItem : IMsSqlPropertyDef;
Begin
  Supports(Item, IMsSqlPropertyDef, lInItem);
  InHerited Items[Index] := lInItem;
End;

Procedure TMsSqlClassDef.AfterConstruction();
Begin
  InHerited AfterConstruction();
  
  FDataState := edsBrowse;
End;

Procedure TMsSqlClassDef.DisableTracking();
Begin
  FIsTracking := False;
End;

Procedure TMsSqlClassDef.EnableTracking();
Begin
  FIsTracking := True; 
End;

Function TMsSqlClassDef.GetPropertiesClass() : THsPropertyDefsClass;
Begin
  Result := TMsSqlPropertyDefs; 
End;

Procedure TMsSqlClassDef.Changed();
Begin
  If FIsTracking Then
    Case FDataState Of
      edsBrowse : FDataState := edsModified;
    End;
End;

Function TMsSqlClassDef.GetModified() : Boolean;
Begin
  Result := FDataState <> edsBrowse;
End;

Procedure TMsSqlClassDef.Clear();
Begin
  FIdUnitDef      := 0;
  FPosition       := 0;
{  FClsName        := '';
  FUseInterface   := False;
  FUseCustomClass := False;
  FMakeList       := False;
  FTrackChange    := False;
  FDataSourceType := 0;
  FTableName      := '';}
End;

Procedure TMsSqlClassDef.New();
Begin
  Clear();
  FDataState := edsAdded;
End;

Procedure TMsSqlClassDef.Load(AId : Integer);
Begin
  With DataModuleCodeGen.CreateCodeGenQuery() Do
  Try
    Sql.Text := 'Select *'#$D#$A + 
                'From ClassDefs'#$D#$A + 
                'Where Id = :Id';

    Parameters.ParamByName('Id').Value := AId;
    Open();

    If Not IsEmpty Then
      Self.Assign(Fields);

    Finally
      Close();
      Free();
  End;
End;

Procedure TMsSqlClassDef.Save();
Var X : Integer;
    lPropDefs : IMsSqlPropertyDefs;
Begin
  If FDataState > edsBrowse Then
    With DataModuleCodeGen.CreateCodeGenQuery() Do
    Try
      If FDataState In [edsAdded, edsModified] Then
      Begin
        Case FDataState Of
          edsAdded :
          Begin
            Sql.Text := 'Insert Into ClassDefs ('#$D#$A +
                        'IdUnitDef,'#$D#$A +
                        'Position,'#$D#$A +
                        'ClassName,'#$D#$A +
                        'UseInterface,'#$D#$A +
                        'UseCustomClass,'#$D#$A +
                        'MakeList,'#$D#$A +
                        'TrackChange,'#$D#$A +
                        'DataSourceType,'#$D#$A +
                        'AdoQueryClassName,'#$D#$A +
                        'TableName'#$D#$A +
                        ') Values ('#$D#$A +
                        ':IdUnitDef,'#$D#$A +
                        ':Position,'#$D#$A +
                        ':ClsName,'#$D#$A +
                        ':UseInterface,'#$D#$A +
                        ':UseCustomClass,'#$D#$A +
                        ':MakeList,'#$D#$A +
                        ':TrackChange,'#$D#$A +
                        ':DataSourceType,'#$D#$A +
                        ':AdoQueryClassName,'#$D#$A +
                        ':TableName)'#$D#$A +
                        'Select Scope_Identity() LastAutoIncValue';
          End;

          edsModified :
          Begin
            Sql.Text := 'Update ClassDefs Set'#$D#$A +
                        'IdUnitDef = :IdUnitDef,'#$D#$A +
                        'Position = :Position,'#$D#$A +
                        'ClassName = :ClsName,'#$D#$A +
                        'UseInterface = :UseInterface,'#$D#$A +
                        'UseCustomClass = :UseCustomClass,'#$D#$A +
                        'MakeList = :MakeList,'#$D#$A +
                        'TrackChange = :TrackChange,'#$D#$A +
                        'DataSourceType = :DataSourceType,'#$D#$A +
                        'AdoQueryClassName = :AdoQueryClassName,'#$D#$A +
                        'TableName = :TableName'#$D#$A +
                        'Where Id = :Id';

            Parameters.ParamByName('Id').Value := FId;
          End;
        End;

        Parameters.ParamByName('IdUnitDef').Value         := FIdUnitDef;
        Parameters.ParamByName('Position').Value          := FPosition;

        Parameters.ParamByName('ClsName').Value           := InHerited GetClsName();
        Parameters.ParamByName('UseInterface').Value      := InHerited GetUseInterface();
        Parameters.ParamByName('UseCustomClass').Value    := InHerited GetUseCustomClass();
        Parameters.ParamByName('MakeList').Value          := InHerited GetMakeList();
        Parameters.ParamByName('TrackChange').Value       := InHerited GetTrackChange();
        Parameters.ParamByName('DataSourceType').Value    := Ord(InHerited GetDataType());
        Parameters.ParamByName('AdoQueryClassName').Value := InHerited GetAdoQueryClassName();
        Parameters.ParamByName('TableName').Value         := InHerited GetTableName();
      End
      Else If FDataState = edsDeleted Then
      Begin
        Sql.Text := 'Delete From ClassDefs'#$D#$A +
                    'Where Id = :Id';
        Parameters.ParamByName('Id').Value := FId;
      End;

      If FDataState = edsAdded Then
      Begin
        Open();
        FId := FieldByName('LastAutoIncValue').AsInteger;
      End
      Else
        ExecSql();

      lPropDefs := GetPropertyDefs();
      For X := 0 To lPropDefs.Count - 1 Do
      Begin
        If FDataState = edsDeleted Then
          lPropDefs[X].Delete()
        Else
        Begin
          lPropDefs[X].IdClassDef := FId;
          lPropDefs[X].Position   := X + 1;
        End;

        lPropDefs[X].Save();
      End;

      Finally
        Free();
    End;
End;

Procedure TMsSqlClassDef.Delete();
Begin
  FDataState := edsDeleted;
End;

Procedure TMsSqlClassDef.Assign(ASource : TObject);
Var lSrc    : TMsSqlClassDef;
    lFields : TFields;
Begin
(*
  If ASource Is TMsSqlClassDef Then
  Begin
    lSrc := TMsSqlClassDef(ASource);

    FId                := lSrc.Id;
    FIdUnitDef         := lSrc.IdUnitDef;
    FPosition          := lSrc.Position;
    FClsName           := lSrc.ClsName;
    FUseInterface      := lSrc.UseInterface;
    FUseCustomClass    := lSrc.UseCustomClass;
    FMakeList          := lSrc.MakeList;
    FTrackChange       := lSrc.TrackChange;
    FDataSourceType    := lSrc.DataSourceType;
    FAdoQueryClassName := lSrc.AdoQueryClassName;
    FTableName         := lSrc.TableName;
    FPropertyDefs      := lSrc.PropertyDefs;
  End
  Else*) If ASource Is TFields Then
  Begin
    lFields := TFields(ASource);

    FId        := lFields.FieldByName('Id').AsInteger;
    FIdUnitDef := lFields.FieldByName('IdUnitDef').AsInteger;

    InHerited SetClsName(lFields.FieldByName('ClassName').AsString);
    InHerited SetUseInterface(lFields.FieldByName('UseInterface').AsBoolean);
    InHerited SetUseCustomClass(lFields.FieldByName('UseCustomClass').AsBoolean);
    InHerited SetMakeList(lFields.FieldByName('MakeList').AsBoolean);
    InHerited SetTrackChange(lFields.FieldByName('TrackChange').AsBoolean);
    InHerited SetDataType(THsDataSource(lFields.FieldByName('DataSourceType').AsInteger));
    InHerited SetAdoQueryClassName(lFields.FieldByName('AdoQueryClassName').AsString);
    InHerited SetTableName(lFields.FieldByName('TableName').AsString);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TMsSqlClassDef.GetId() : Integer;
Begin
  Result := FId;
End;

Procedure TMsSqlClassDef.SetId(Const AId : Integer); 
Begin
  If FId <> AId Then
  Begin
    FId := AId;
    Changed();
  End
End;

Function TMsSqlClassDef.GetIdUnitDef() : Integer;
Begin
  Result := FIdUnitDef;
End;

Procedure TMsSqlClassDef.SetIdUnitDef(Const AIdUnitDef : Integer);
Begin
  If FIdUnitDef <> AIdUnitDef Then
  Begin
    FIdUnitDef := AIdUnitDef;
    Changed();
  End
End;

Function TMsSqlClassDef.GetPosition() : Integer;
Begin
  Result := FPosition;
End;

Procedure TMsSqlClassDef.SetPosition(Const APosition : Integer);
Begin
  If FPosition <> APosition Then
  Begin
    FPosition := APosition;
    Changed();
  End
End;

Procedure TMsSqlClassDef.SetClsName(Const AClsName : String);
Begin
  If Length(AClsName) > 35 Then
    Raise Exception.Create('MaxLength for property ClsName is : 35');
  If GetClsName() <> AClsName Then
  Begin
    InHerited SetClsName(AClsName);
    Changed();
  End
End;

Procedure TMsSqlClassDef.SetUseInterface(Const AUseInterface : Boolean);
Begin
  If GetUseInterface() <> AUseInterface Then
  Begin
    InHerited SetUseInterface(AUseInterface);
    Changed();
  End
End;

Procedure TMsSqlClassDef.SetUseCustomClass(Const AUseCustomClass : Boolean);
Begin
  If GetUseCustomClass() <> AUseCustomClass Then
  Begin
    InHerited SetUseCustomClass(AUseCustomClass);
    Changed();
  End
End;

Procedure TMsSqlClassDef.SetMakeList(Const AMakeList : Boolean);
Begin
  If GetMakeList() <> AMakeList Then
  Begin
    InHerited SetMakeList(AMakeList);
    Changed();
  End
End;

Procedure TMsSqlClassDef.SetTrackChange(Const ATrackChange : Boolean);
Begin
  If GetTrackChange() <> ATrackChange Then
  Begin
    InHerited SetTrackChange(ATrackChange);
    Changed();
  End
End;

Procedure TMsSqlClassDef.SetDataType(Const ADataType : THsDataSource);
Begin
  If GetDataType() <> ADataType Then
  Begin
    InHerited SetDataType(ADataType);
    Changed();
  End
End;

Procedure TMsSqlClassDef.SetAdoQueryClassName(Const AAdoQueryClassName : String);
Begin
  If GetAdoQueryClassName <> AAdoQueryClassName Then
  Begin
    InHerited SetAdoQueryClassName(AAdoQueryClassName);
    Changed();
  End
End;

Procedure TMsSqlClassDef.SetTableName(Const ATableName : String);
Begin
  If Length(ATableName) > 128 Then
    Raise Exception.Create('MaxLength for property TableName is : 128');
  If GetTableName() <> ATableName Then
  Begin
    InHerited SetTableName(ATableName);
    Changed();
  End
End;

Function TMsSqlClassDef.GetPropertyDefs() : IMsSqlPropertyDefs;
Begin
  Result := InHerited GetPropertyDefs() As IMsSqlPropertyDefs;
End;

Procedure TMsSqlClassDefs.Load(Const AId : Integer);
Var lClsDef : IMsSqlClassDef;
Begin
  With DataModuleCodeGen.CreateCodeGenQuery() Do
  Try
    Sql.Text := 'Select *'#$D#$A +
                'From ClassDefs'#$D#$A +
                'Where IdUnitDef = :Id';

    Parameters.ParamByName('Id').Value := AId;
    Open();

    While Not Eof Do
    Begin
      lClsDef := TMsSqlClassDef.Create(True);
      lClsDef.DisableTracking();
      Try
        lClsDef.Id                := FieldByName('Id').AsInteger;
        lClsDef.ClsName           := FieldByName('ClassName').AsString;
        lClsDef.UseInterface      := FieldByName('UseInterface').AsBoolean;
        lClsDef.UseCustomClass    := FieldByName('UseCustomClass').AsBoolean;
        lClsDef.MakeList          := FieldByName('MakeList').AsBoolean;
        lClsDef.TrackChange       := FieldByName('TrackChange').AsBoolean;
        lClsDef.DataType          := THsDataSource(FieldByName('DataSourceType').AsInteger);
        lClsDef.AdoQueryClassName := FieldByName('AdoQueryClassName').AsString;
        lClsDef.TableName         := FieldByName('TableName').AsString;

        Finally
          lClsDef.EnableTracking();
      End;

      InHerited Add(lClsDef);

      Next();
    End;

    Finally
      Close();
      Free();
  End;

  InHerited Add(lClsDef);
End;

Function TMsSqlClassDefs.MyGet(Index : Integer) : IMsSqlClassDef;
Begin
  Supports(InHerited Items[Index], IMsSqlClassDef, Result);
End;

Procedure TMsSqlClassDefs.MyPut(Index : Integer; Const Item : IMsSqlClassDef);
Var lInItem : IMsSqlClassDef;
Begin
  Supports(Item, IMsSqlClassDef, lInItem);
  InHerited Items[Index] := lInItem;
End;

Procedure TMsSqlTypeDef.Changed();
Begin
  Case FDataState Of
    edsBrowse : FDataState := edsModified;
  End;
End;

Function TMsSqlTypeDef.GetModified() : Boolean;
Begin
  Result := FDataState <> edsBrowse;
End;

Procedure TMsSqlTypeDef.Clear();
Begin
  FIdUnitDef   := 0;
  FPosition    := 0;

  InHerited SetTypeDefType(dtEnum);
  InHerited SetTypeDefName('');
End;

Procedure TMsSqlTypeDef.New();
Begin
  Clear();
  FDataState := edsAdded;
End;

Procedure TMsSqlTypeDef.Load(AId : Integer);
Begin
  With DataModuleCodeGen.CreateCodeGenQuery() Do
  Try
    Sql.Text := 'Select *'#$D#$A + 
                'From TypeDefs'#$D#$A + 
                'Where Id = :Id';

    Parameters.ParamByName('Id').Value := AId;
    Open();

    If Not IsEmpty Then
      Self.Assign(Fields);

    Finally
      Close();
      Free();
  End;
End;

Procedure TMsSqlTypeDef.Save();
Var X : Integer;
    lTDValues : IMsSqlTypeDefValues;
Begin
  If FDataState > edsBrowse Then
    With DataModuleCodeGen.CreateCodeGenQuery() Do
    Try
      If FDataState In [edsAdded, edsModified] Then
      Begin
        Case FDataState Of
          edsAdded :
          Begin
            Sql.Text := 'Insert Into TypeDefs ('#$D#$A +
                        'IdUnitDef,'#$D#$A +
                        'Position,'#$D#$A +
                        'TypeDefType,'#$D#$A +
                        'TypeDefName'#$D#$A +
                        ') Values ('#$D#$A +
                        ':IdUnitDef,'#$D#$A +
                        ':Position,'#$D#$A +
                        ':TypeDefType,'#$D#$A +
                        ':TypeDefName)'#$D#$A +
                        'Select Scope_Identity() LastAutoIncValue';
          End;

          edsModified :
          Begin
            Sql.Text := 'Update TypeDefs Set'#$D#$A +
                        'IdUnitDef = :IdUnitDef,'#$D#$A +
                        'Position = :Position,'#$D#$A +
                        'TypeDefType = :TypeDefType,'#$D#$A +
                        'TypeDefName = :TypeDefName'#$D#$A +
                        'Where Id = :Id';

            Parameters.ParamByName('Id').Value := FId;
          End;
        End;

        Parameters.ParamByName('IdUnitDef').Value   := FIdUnitDef;
        Parameters.ParamByName('Position').Value    := FPosition;
        Parameters.ParamByName('TypeDefType').Value := Ord(InHerited GetTypeDefType());
        Parameters.ParamByName('TypeDefName').Value := InHerited GetTypeDefName();
      End
      Else If FDataState = edsDeleted Then
      Begin
        Sql.Text := 'Delete From TypeDefs'#$D#$A +
                    'Where Id = :Id';
        Parameters.ParamByName('Id').Value := FId;
      End;

      If FDataState = edsAdded Then
      Begin
        Open();
        FId := FieldByName('LastAutoIncValue').AsInteger;
      End
      Else
        ExecSql();

      lTDValues := GetTypeDefValues();
      For X := 0 To lTDValues.Count - 1 Do
      Begin
        If FDataState = edsDeleted Then
          lTDValues[X].Delete()
        Else
        Begin

        End;

        lTDValues[X].Save();
      End;

      Finally
        Free();
    End;
End;

Procedure TMsSqlTypeDef.Delete();
Begin
  FDataState := edsDeleted;
End;

Procedure TMsSqlTypeDef.Assign(ASource : TObject);
Var lSrc    : TMsSqlTypeDef;
    lFields : TFields;
Begin
(*  If ASource Is TMsSqlTypeDef Then
  Begin
    lSrc := TMsSqlTypeDef(ASource);

    FId          := lSrc.Id;
    FIdUnitDef   := lSrc.IdUnitDef;
    FPosition    := lSrc.Position;
    FTypeDefType := lSrc.TypeDefType;
    FTypeDefName := lSrc.TypeDefName;
  End
  Else*) If ASource Is TFields Then
  Begin
    lFields := TFields(ASource);

    FId        := lFields.FieldByName('Id').AsInteger;
    FIdUnitDef := lFields.FieldByName('IdUnitDef').AsInteger;

    InHerited SetTypeDefType(THsTypeDefType(lFields.FieldByName('TypeDefType').AsInteger));
    InHerited SetTypeDefName(lFields.FieldByName('TypeDefName').AsString);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TMsSqlTypeDef.GetId() : Integer;
Begin
  Result := FId;
End;

Function TMsSqlTypeDef.GetIdUnitDef() : Integer;
Begin
  Result := FIdUnitDef;
End;

Procedure TMsSqlTypeDef.SetIdUnitDef(Const AIdUnitDef : Integer);
Begin
  If FIdUnitDef <> AIdUnitDef Then
  Begin
    FIdUnitDef := AIdUnitDef;
    Changed();
  End
End;

Function TMsSqlTypeDef.GetPosition() : Integer;
Begin
  Result := FPosition;
End;

Procedure TMsSqlTypeDef.SetPosition(Const APosition : Integer);
Begin
  If FPosition <> APosition Then
  Begin
    FPosition := APosition;
    Changed();
  End
End;

Procedure TMsSqlTypeDef.SetTypeDefType(Const ATypeDefType : THsTypeDefType);
Begin
  If GetTypeDefType() <> ATypeDefType Then
  Begin
    InHerited SetTypeDefType(ATypeDefType);
    Changed();
  End
End;

Procedure TMsSqlTypeDef.SetTypeDefName(Const ATypeDefName : String);
Begin
  If Length(ATypeDefName) > 25 Then
    Raise Exception.Create('MaxLength for property TypeDefName is : 25');
  If GetTypeDefName() <> ATypeDefName Then
  Begin
    InHerited SetTypeDefName(ATypeDefName);
    Changed();
  End
End;

Function TMsSqlTypeDef.GetTypeDefValues() : IMsSqlTypeDefValues;
Begin
  If Not Assigned(FTypeDefValues) Then
    FTypeDefValues := TMsSqlTypeDefValues.Create(True);
  Result := FTypeDefValues;
End;

Function TMsSqlTypeDefs.Get(Index : Integer) : IMsSqlTypeDef;
Begin
  Supports(InHerited Items[Index], IMsSqlTypeDef, Result);
End;

Procedure TMsSqlTypeDefs.Put(Index : Integer; Const Item : IMsSqlTypeDef);
Var lInItem : IMsSqlTypeDef;
Begin
  Supports(Item, IMsSqlTypeDef, lInItem);
  InHerited Items[Index] := lInItem;
End;

Procedure TMsSqlTypeDefValue.Changed();
Begin
  Case FDataState Of
    edsBrowse : FDataState := edsModified;
  End;
End;

Function TMsSqlTypeDefValue.GetModified() : Boolean;
Begin
  Result := FDataState <> edsBrowse;
End;

Procedure TMsSqlTypeDefValue.Clear();
Begin
  FIdTypeDef        := 0;
  FPosition         := 0;
  FTypeDefValueType := 0;
  FTypeDefValue     := '';
End;

Procedure TMsSqlTypeDefValue.New();
Begin
  Clear();
  FDataState := edsAdded;
End;

Procedure TMsSqlTypeDefValue.Load(AId : Integer);
Begin
  With DataModuleCodeGen.CreateCodeGenQuery() Do
  Try
    Sql.Text := 'Select *'#$D#$A + 
                'From TypeDefValues'#$D#$A + 
                'Where Id = :Id';

    Parameters.ParamByName('Id').Value := AId;
    Open();

    If Not IsEmpty Then
      Self.Assign(Fields);

    Finally
      Close();
      Free();
  End;
End;

Procedure TMsSqlTypeDefValue.Save();
Begin
  If FDataState > edsBrowse Then
    With DataModuleCodeGen.CreateCodeGenQuery() Do
    Try
      If FDataState In [edsAdded, edsModified] Then
      Begin
        Case FDataState Of
          edsAdded :
          Begin
            Sql.Text := 'Insert Into TypeDefValues ('#$D#$A +
                        'IdTypeDef,'#$D#$A +
                        'Position,'#$D#$A +
                        'TypeDefValueType,'#$D#$A +
                        'TypeDefValue'#$D#$A +
                        ') Values ('#$D#$A +
                        ':IdTypeDef,'#$D#$A +
                        ':Position,'#$D#$A +
                        ':TypeDefValueType,'#$D#$A +
                        ':TypeDefValue)'#$D#$A +
                        'Select Scope_Identity() LastAutoIncValue';
          End;

          edsModified :
          Begin
            Sql.Text := 'Update TypeDefValues Set'#$D#$A +
                        'IdTypeDef = :IdTypeDef,'#$D#$A +
                        'Position = :Position,'#$D#$A +
                        'TypeDefValueType = :TypeDefValueType,'#$D#$A +
                        'TypeDefValue = :TypeDefValue'#$D#$A +
                        'Where Id = :Id';

            Parameters.ParamByName('Id').Value := FId;
          End;
        End;

        Parameters.ParamByName('IdTypeDef').Value        := FIdTypeDef;
        Parameters.ParamByName('Position').Value         := FPosition;
        Parameters.ParamByName('TypeDefValueType').Value := FTypeDefValueType;
        Parameters.ParamByName('TypeDefValue').Value     := FTypeDefValue;
      End
      Else If FDataState = edsDeleted Then
      Begin
        Sql.Text := 'Delete From TypeDefValues'#$D#$A +
                    'Where Id = :Id';
        Parameters.ParamByName('Id').Value := FId;
      End;

      If FDataState = edsAdded Then
      Begin
        Open();
        FId := FieldByName('LastAutoIncValue').AsInteger;
      End
      Else
        ExecSql();

      Finally
        Free();
    End;
End;

Procedure TMsSqlTypeDefValue.Delete();
Begin
  FDataState := edsDeleted;
End;

Procedure TMsSqlTypeDefValue.Assign(ASource : TObject);
Var lSrc    : TMsSqlTypeDefValue;
    lFields : TFields;
Begin
(*  If ASource Is TMsSqlTypeDefValue Then
  Begin
    lSrc := TMsSqlTypeDefValue(ASource);

    FId               := lSrc.Id;
    FIdTypeDef        := lSrc.IdTypeDef;
    FPosition         := lSrc.Position;
    FTypeDefValueType := lSrc.TypeDefValueType;
    FTypeDefValue     := lSrc.TypeDefValue;
  End
  Else*) If ASource Is TFields Then
  Begin
    lFields := TFields(ASource);

    FId               := lFields.FieldByName('Id').AsInteger;
    FIdTypeDef        := lFields.FieldByName('IdTypeDef').AsInteger;
    FPosition         := lFields.FieldByName('Position').AsInteger;
    FTypeDefValueType := lFields.FieldByName('TypeDefValueType').AsInteger;
    FTypeDefValue     := lFields.FieldByName('TypeDefValue').AsString;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TMsSqlTypeDefValue.GetId() : Integer;
Begin
  Result := FId;
End;

Function TMsSqlTypeDefValue.GetIdTypeDef() : Integer;
Begin
  Result := FIdTypeDef;
End;

Procedure TMsSqlTypeDefValue.SetIdTypeDef(Const AIdTypeDef : Integer);
Begin
  If FIdTypeDef <> AIdTypeDef Then
  Begin
    FIdTypeDef := AIdTypeDef;
    Changed();
  End
End;

Function TMsSqlTypeDefValue.GetPosition() : Integer;
Begin
  Result := FPosition;
End;

Procedure TMsSqlTypeDefValue.SetPosition(Const APosition : Integer);
Begin
  If FPosition <> APosition Then
  Begin
    FPosition := APosition;
    Changed();
  End
End;

Function TMsSqlTypeDefValue.GetTypeDefValueType() : Integer;
Begin
  Result := FTypeDefValueType;
End;

Procedure TMsSqlTypeDefValue.SetTypeDefValueType(Const ATypeDefValueType : Integer);
Begin
  If FTypeDefValueType <> ATypeDefValueType Then
  Begin
    FTypeDefValueType := ATypeDefValueType;
    Changed();
  End
End;

Function TMsSqlTypeDefValue.GetTypeDefValue() : String;
Begin
  Result := FTypeDefValue;
End;

Procedure TMsSqlTypeDefValue.SetTypeDefValue(Const ATypeDefValue : String);
Begin
  If Length(ATypeDefValue) > 50 Then
    Raise Exception.Create('MaxLength for property TypeDefValue is : 50');
  If FTypeDefValue <> ATypeDefValue Then
  Begin
    FTypeDefValue := ATypeDefValue;
    Changed();
  End
End;

Function TMsSqlTypeDefValues.MyGet(Index : Integer) : IMsSqlTypeDefValue;
Begin
  Supports(InHerited Items[Index], IMsSqlTypeDefValue, Result);
End;

Procedure TMsSqlTypeDefValues.MyPut(Index : Integer; Const Item : IMsSqlTypeDefValue);
Var lInItem : IMsSqlTypeDefValue;
Begin
  Supports(Item, IMsSqlTypeDefValue, lInItem);
  InHerited Items[Index] := lInItem;
End;

Function TMsSqlUnitDef.GetTypeDefsClass() : THsTypeDefsClass;
Begin
  Result := TMsSqlTypeDefs;
End;

Function TMsSqlUnitDef.GetCodeGeneratorClass() : THsClassCodeGeneratorsClass;
Begin
  Result := TMsSqlClassDefs;
End;

Procedure TMsSqlUnitDef.Changed();
Begin
  Case FDataState Of
    edsBrowse : FDataState := edsModified;
  End;
End;

Function TMsSqlUnitDef.GetModified() : Boolean;
Begin
  Result := FDataState <> edsBrowse;
End;

Procedure TMsSqlUnitDef.Clear();
Begin
  InHerited SetUnitName('');
End;

Procedure TMsSqlUnitDef.New();
Begin
  Clear();
  FDataState := edsAdded;
End;

Procedure TMsSqlUnitDef.Load(AId : Integer);
Begin
  With DataModuleCodeGen.CreateCodeGenQuery() Do
  Try
    Sql.Text := 'Select *'#$D#$A +
                'From UnitDefs'#$D#$A +
                'Where Id = :Id';

    Parameters.ParamByName('Id').Value := AId;
    Open();

    If Not IsEmpty Then
      Self.Assign(Fields);
    FDataState := edsBrowse;

    Finally
      Close();
      Free();
  End;
End;

Procedure TMsSqlUnitDef.Save();
Var X : Integer;
    lClsDefs : IMsSqlClassDefs;
    lTypeDefs : IMsSqlTypeDefs;
Begin
  If FDataState > edsBrowse Then
    With DataModuleCodeGen.CreateCodeGenQuery() Do
    Try
      If FDataState In [edsAdded, edsModified] Then
      Begin
        Case FDataState Of
          edsAdded :
          Begin
            Sql.Text := 'Insert Into UnitDefs ('#$D#$A +
                        'UnitName'#$D#$A +
                        ') Values ('#$D#$A +
                        ':UnitName)'#$D#$A +
                        'Select Scope_Identity() LastAutoIncValue';
          End;

          edsModified :
          Begin
            Sql.Text := 'Update UnitDefs Set'#$D#$A +
                        'UnitName = :UnitName'#$D#$A +
                        'Where Id = :Id';

            Parameters.ParamByName('Id').Value := FId;
          End;
        End;

        Parameters.ParamByName('UnitName').Value := InHerited GetUnitName();

      End
      Else If FDataState = edsDeleted Then
      Begin
        Sql.Text := 'Delete From UnitDefs'#$D#$A +
                    'Where Id = :Id';
        Parameters.ParamByName('Id').Value := FId;
      End;

      If FDataState In [edsAdded, edsModified] Then
      Begin
        If FDataState = edsAdded Then
        Begin
          Open();
          FId := FieldByName('LastAutoIncValue').AsInteger;
        End
        Else
          ExecSql();
      End;

      lTypeDefs := GetTypeDefs();
      For X := 0 To lTypeDefs.Count - 1 Do
      Begin
        If FDataState = edsDeleted Then
          lTypeDefs[X].Delete()
        Else
        Begin
          lTypeDefs[X].IdUnitDef := FId;
          lTypeDefs[X].Position  := X + 1;
        End;

        lTypeDefs[X].Save();
      End;

      lClsDefs := GetClassDefs();
      For X := 0 To lClsDefs.Count - 1 Do
      Begin
        If FDataState = edsDeleted Then
          lClsDefs[X].Delete()
        Else
        Begin
          lClsDefs[X].IdUnitDef := FId;
          lClsDefs[X].Position  := X + 1;
        End;

        lClsDefs[X].Save();
      End;

      If FDataState = edsDeleted Then
        ExecSql();
        
      Finally
        Free();
    End;
End;

Procedure TMsSqlUnitDef.Delete();
Begin
  FDataState := edsDeleted;
End;

Procedure TMsSqlUnitDef.Assign(ASource : TObject);
Var lSrc    : TMsSqlUnitDef;
    lFields : TFields;
Begin
(*  If ASource Is TMsSqlUnitDef Then
  Begin
    lSrc := TMsSqlUnitDef(ASource);

    FId        := lSrc.Id;
    FUnitName  := lSrc.UnitName;
    FClassDefs := lSrc.ClassDefs;
    FTypeDefs  := lSrc.TypeDefs;
  End
  Else*) If ASource Is TFields Then
  Begin
    lFields := TFields(ASource);

    FId := lFields.FieldByName('Id').AsInteger;
    GetClassDefs().Load(FId);
    
    InHerited SetUnitName(lFields.FieldByName('UnitName').AsString);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TMsSqlUnitDef.GetId() : Integer;
Begin
  Result := FId;
End;

Procedure TMsSqlUnitDef.SetUnitName(Const AUnitName : String);
Begin
  If Length(AUnitName) > 35 Then
    Raise Exception.Create('MaxLength for property UnitName is : 35');
  If GetUnitName() <> AUnitName Then
  Begin
    InHerited SetUnitName(AUnitName);
    Changed();
  End
End;

Function TMsSqlUnitDef.GetClassDefs() : IMsSqlClassDefs;
Begin
  Result := InHerited GetClassDefs() As IMsSqlClassDefs;
End;

Function TMsSqlUnitDef.GetTypeDefs() : IMsSqlTypeDefs;
Begin
  Result := InHerited GetTypeDefs() As IMsSqlTypeDefs;
End;

end.
