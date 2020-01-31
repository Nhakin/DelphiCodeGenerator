unit CodeGen.VT;

interface

Uses HsInterfaceEx, VirtualTrees, TypInfo, Classes,
  CodeGenType, CodeGenIntf;

Type
  IHsVTSettingNode = Interface;
  TOnValueChangeEvent = Procedure(Sender : IHsVTSettingNode; Const AOldValue : Variant) Of Object;

  IHsVTSettingNode = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-984C-9229C2C817C2}']
    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);
    Function  GetSettingName() : String;
    Procedure SetSettingName(Const ASettingName : String);
    Function  GetSettingValue() : Variant;
    Procedure SetSettingValue(Const ASettingValue : Variant);
    Function  GetSettingType() : THsPropertyType;
    Procedure SetSettingType(Const ASettingType : THsPropertyType);
    Function  GetSettingVisible() : Boolean;
    Procedure SetSettingVisible(Const ASettingVisible : Boolean);
    Function  GetEnumInfo() : PTypeInfo;
    Procedure SetEnumInfo(AEnumInfo : PTypeInfo);

    Function  GetOnChange() : TOnValueChangeEvent;
    Procedure SetOnChange(Const AOnChange : TOnValueChangeEvent);

    Procedure GetEnumNameList(AList : TStrings);

    Property VTNode         : PVirtualNode        Read GetVTNode         Write SetVTNode;
    Property SettingName    : String              Read GetSettingName    Write SetSettingName;
    Property SettingValue   : Variant             Read GetSettingValue   Write SetSettingValue;
    Property SettingType    : THsPropertyType     Read GetSettingType    Write SetSettingType;
    Property SettingVisible : Boolean             Read GetSettingVisible Write SetSettingVisible;
    Property EnumInfo       : PTypeInfo           Read GetEnumInfo       Write SetEnumInfo;

    Property OnChange       : TOnValueChangeEvent Read GetOnChange       Write SetOnChange;

  End;

  IHsVTSettingNodeEnumerator = Interface(IInterfaceExEnumerator)
    ['{4B61686E-29A0-2112-9DF2-A094AD5854C8}']
    Function GetCurrent() : IHsVTSettingNode;
    Property Current : IHsVTSettingNode Read GetCurrent;

  End;

  IHsVTSettingNodes = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9E1A-668F06C33FF8}']
    Function  GetEnumerator() : IHsVTSettingNodeEnumerator;

    Function  Get(Index : Integer) : IHsVTSettingNode;
    Procedure Put(Index : Integer; Const Item : IHsVTSettingNode);

    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(ANode : PVirtualNode);
    Function  GetNodeCaption() : String;
    Procedure SetNodeCaption(Const ACaption : String);
    Function  GetSettingVisible() : Boolean;
    Procedure SetSettingVisible(Const ASettingVisible : Boolean);

    Function  Add() : IHsVTSettingNode;
    Function  AddStringSetting(Const ASettingName : String; Const ASettingValue : String = '') : IHsVTSettingNode;
    Function  AddTStringSetting(Const ASettingName : String; Const ASettingValue : String = '') : IHsVTSettingNode;
    Function  AddIntegerSetting(Const ASettingName : String; Const ASettingValue : Integer = 0) : IHsVTSettingNode;
    Function  AddBooleanSetting(Const ASettingName : String; Const ASettingValue : Boolean = True) : IHsVTSettingNode;
    Function  AddEnumSetting(Const ASettingName : String; AEnumSetting : PTypeInfo) : IHsVTSettingNode;

    Function  NodeSettingByName(Const ANodeSettingName : String) : IHsVTSettingNode;
    Function  IndexOf(Const ANodeSettingName : String) : Integer; OverLoad;

    Property VTNode         : PVirtualNode Read GetVTNode         Write SetVTNode;
    Property NodeCaption    : String       Read GetNodeCaption    Write SetNodeCaption;
    Property SettingVisible : Boolean      Read GetSettingVisible Write SetSettingVisible;
    Property Items[Index : Integer] : IHsVTSettingNode Read Get Write Put; Default;

  End;

  IHsVTPropertyDefsNode = Interface;
  IHsVTPropertyDefNode = Interface(IHsPropertyDef)
    ['{4B61686E-29A0-2112-9BA9-F749487117F0}']
    Function  GetList() : IHsVTPropertyDefsNode;
    Procedure SetList(AList : IHsVTPropertyDefsNode);

    Function  GetSettings() : IHsVTSettingNodes;
    Procedure SetSettings(Const ASettings : IHsVTSettingNodes);

    Procedure GetPropertyTypeList(Const AStrings : TStrings);

    Property List     : IHsVTPropertyDefsNode Read GetList     Write SetList;
    Property Settings : IHsVTSettingNodes     Read GetSettings Write SetSettings;

  End;

  IHsVTPropertyDefsNode = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8FE2-CAA7D94484D3}']
    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);

    Function  GetSettingVisible() : Boolean;
    Procedure SetSettingVisible(Const ASettingVisible : Boolean);

    Function  Get(Index: Integer) : IHsVTPropertyDefNode;
    Procedure Put(Index: Integer; Const Item: IHsVTPropertyDefNode);

    Function Add() : IHsVTPropertyDefNode;

    Property Items[Index : Integer] : IHsVTPropertyDefNode Read Get Write Put; Default;

    Property VTNode         : PVirtualNode        Read GetVTNode         Write SetVTNode;
    Property SettingVisible : Boolean             Read GetSettingVisible Write SetSettingVisible;

  End;

  IHsVTTypeDefNode = Interface(IHsTypeDef)
    ['{4B61686E-29A1-2112-8FE2-CAA7D94484D3}']
    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);

    Function  GetSettings() : IHsVTSettingNodes;
    Procedure SetSettings(Const ASettings : IHsVTSettingNodes);

    Function  GetSettingsVisible() : Boolean;
    Procedure SetSettingsVisible(Const ASettingsVisible : Boolean);

    Procedure GetTypeDefList(Const AStrings : TStrings);
    Function GetTypeDefMembers() : IHsVTPropertyDefsNode;

    Property VTNode   : PVirtualNode      Read GetVTNode   Write SetVTNode;
    Property Settings : IHsVTSettingNodes Read GetSettings Write SetSettings;
    Property SettingsVisible : Boolean Read GetSettingsVisible Write SetSettingsVisible;
    Property TypeDefMembers : IHsVTPropertyDefsNode Read GetTypeDefMembers;

  End;

  IHsVTTypeDefsNode = Interface(IInterfaceListEx)
    ['{4B61686E-29A2-2112-8FE2-CAA7D94484D3}']
    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);

    Function  GetSettingsVisible() : Boolean;
    Procedure SetSettingsVisible(Const ASettingsVisible : Boolean);

    Function  Get(Index: Integer) : IHsVTTypeDefNode;
    Procedure Put(Index: Integer; Const Item: IHsVTTypeDefNode);

    Function Add() : IHsVTTypeDefNode;

    Property Items[Index : Integer] : IHsVTTypeDefNode Read Get Write Put; Default;

    Property VTNode          : PVirtualNode Read GetVTNode          Write SetVTNode;
    Property SettingsVisible : Boolean      Read GetSettingsVisible Write SetSettingsVisible;

  End;

  IHsVTProcedureDefNode = Interface(IHsProcedureDef)
    ['{4B61686E-29A0-2112-B7AA-2494F2F6FE37}']
    Function  GetSettings() : IHsVTSettingNodes;
    Procedure SetSettings(Const ASettings : IHsVTSettingNodes);

    Property Settings : IHsVTSettingNodes Read GetSettings Write SetSettings;

  End;

  IHsVTProcedureDefsNode = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-A81F-9F5B547FE42B}']
    Function  Get(Index : Integer) : IHsVTProcedureDefNode;
    Procedure Put(Index : Integer; Const Item : IHsVTProcedureDefNode);

    Function Add() : IHsVTProcedureDefNode; OverLoad;
    Function Add(Const AItem : IHsVTProcedureDefNode) : Integer; OverLoad;

    Property Items[Index : Integer] : IHsVTProcedureDefNode Read Get Write Put; Default;

  End;

  IHsVTListSettingsNode = Interface(IHsListSettings)
    ['{4B61686E-29A0-2112-9583-02A0574151BC}']
    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);

    Function  GetMethods() : IHsVTProcedureDefsNode;

    Function  GetSettings() : IHsVTSettingNodes;

    Function  GetSettingsVisible() : Boolean;
    Procedure SetSettingsVisible(Const ASettingsVisible : Boolean);

    Property VTNode          : PVirtualNode           Read GetVTNode          Write SetVTNode;
    Property Methods         : IHsVTProcedureDefsNode Read GetMethods;
    Property Settings        : IHsVTSettingNodes      Read GetSettings;
    Property SettingsVisible : Boolean                Read GetSettingsVisible Write SetSettingsVisible;

  End;

  IHsVTClassCodeGeneratorNode = Interface(IHsClassCodeGenerator)
    ['{4B61686E-29A0-2112-8433-CAA70629FB4A}']
    Function  GetSettings() : IHsVTSettingNodes;
    Procedure SetSettings(Const ASettings : IHsVTSettingNodes);
    Function  GetMsSQLSettings() : IHsVTSettingNodes;
    Procedure SetMsSQLSettings(Const ASettings : IHsVTSettingNodes);

    Function  GetPropertyDefs() : IHsVTPropertyDefsNode;
    Function  GetProcedureDefs() : IHsVTProcedureDefsNode;
    Function  GetListSettings() : IHsVTListSettingsNode;

    Procedure Assign(ASource : IHsClassCodeGenerator);

    Property Settings      : IHsVTSettingNodes Read GetSettings      Write SetSettings;
    Property MsSQLSettings : IHsVTSettingNodes Read GetMsSQLSettings Write SetMsSQLSettings;

    Property PropertyDefs  : IHsVTPropertyDefsNode  Read GetPropertyDefs;
    Property ProcedureDefs : IHsVTProcedureDefsNode Read GetProcedureDefs;
    Property ListSettings  : IHsVTListSettingsNode  Read GetListSettings;

  End;

  IHsVTClassCodeGeneratorsNode = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9C2D-E37B8A199328}']
    Function  Get(Index: Integer) : IHsVTClassCodeGeneratorNode;
    Procedure Put(Index: Integer; Const Item: IHsVTClassCodeGeneratorNode);

    Function Add() : IHsVTClassCodeGeneratorNode;

    Property Items[Index : Integer] : IHsVTClassCodeGeneratorNode Read Get Write Put; Default;

  End;

  IHsVTUnitGeneratorNode = Interface(IHsUnitGenerator)
    ['{4B61686E-29A0-2112-92B3-2A799B63E291}']
    Function GetTypeDefs() : IHsVTTypeDefsNode;
    Function GetClassDefs() : IHsVTClassCodeGeneratorsNode;

    Property TypeDefs : IHsVTTypeDefsNode Read GetTypeDefs;
    Property ClassDefs : IHsVTClassCodeGeneratorsNode Read GetClassDefs;

  End;

  TVTCodeGen = Class(TObject)
  Public
    Class Function CreateGenerator() : IHsVTUnitGeneratorNode;

  End;

implementation

Uses SysUtils, Dialogs,
  CodeGenImpl;

Type
  THsVTSettingNode = Class(TInterfacedObjectEx, IHsVTSettingNode)
  Private
    FVTNode         : PVirtualNode;
    FSettingName    : String;
    FSettingValue   : Variant;
    FSettingType    : THsPropertyType;
    FSettingVisible : Boolean;
    FEnumInfo       : PTypeInfo;

    FOnChange : TOnValueChangeEvent;

  Protected
    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);
    Function  GetSettingName() : String;
    Procedure SetSettingName(Const ASettingName : String);
    Function  GetSettingValue() : Variant;
    Procedure SetSettingValue(Const ASettingValue : Variant);
    Function  GetSettingType() : THsPropertyType;
    Procedure SetSettingType(Const ASettingType : THsPropertyType);
    Function  GetSettingVisible() : Boolean;
    Procedure SetSettingVisible(Const ASettingVisible : Boolean);
    Function  GetEnumInfo() : PTypeInfo;
    Procedure SetEnumInfo(AEnumInfo : PTypeInfo);

    Function  GetOnChange() : TOnValueChangeEvent;
    Procedure SetOnChange(Const AOnChange : TOnValueChangeEvent);

    Property VTNode         : PVirtualNode    Read GetVTNode         Write SetVTNode;
    Property SettingName    : String          Read GetSettingName    Write SetSettingName;
    Property SettingValue   : Variant         Read GetSettingValue   Write SetSettingValue;
    Property SettingType    : THsPropertyType Read GetSettingType    Write SetSettingType;
    Property SettingVisible : Boolean         Read GetSettingVisible Write SetSettingVisible;
    Property EnumInfo       : PTypeInfo       Read GetEnumInfo       Write SetEnumInfo;

    Property OnChange : TOnValueChangeEvent Read FOnChange Write FOnChange;

    Procedure GetEnumNameList(AList : TStrings);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  THsVTSettingNodes = Class(TInterfaceListEx, IHsVTSettingNodes)
  Strict Private Type
    THsVTSettingNodeEnumerator = Class(TInterfaceExEnumerator, IHsVTSettingNodeEnumerator)
    Protected
      Function GetCurrent() : IHsVTSettingNode; OverLoad;

    End;
      
  Strict Private
    FVTNode : PVirtualNode;
    FNodeCaption : String;
    FSettingVisible : Boolean;

  Protected
    Function  GetEnumerator() : IHsVTSettingNodeEnumerator; OverLoad;

    Function  Get(Index : Integer) : IHsVTSettingNode; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsVTSettingNode); OverLoad;
    Function  Add() : IHsVTSettingNode; OverLoad;
    Function  IndexOf(Const ANodeSettingName : String) : Integer; OverLoad;

    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(ANode : PVirtualNode);
    Function  GetNodeCaption() : String;
    Procedure SetNodeCaption(Const ACaption : String);
    Function  GetSettingVisible() : Boolean;
    Procedure SetSettingVisible(Const ASettingVisible : Boolean);

    Function  AddStringSetting(Const ASettingName : String; Const ASettingValue : String = '') : IHsVTSettingNode;
    Function  AddTStringSetting(Const ASettingName : String; Const ASettingValue : String = '') : IHsVTSettingNode;
    Function  AddIntegerSetting(Const ASettingName : String; Const ASettingValue : Integer = 0) : IHsVTSettingNode;
    Function  AddBooleanSetting(Const ASettingName : String; Const ASettingValue : Boolean = True) : IHsVTSettingNode;
    Function  AddEnumSetting(Const ASettingName : String; AEnumSetting : PTypeInfo) : IHsVTSettingNode;

    Function  NodeSettingByName(Const ANodeSettingName : String) : IHsVTSettingNode;

    Property Items[Index : Integer] : IHsVTSettingNode Read Get Write Put;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  THsVTPropertyDefNode = Class(THsPropertyDef, IHsVTPropertyDefNode)
  Private
    FList     : Pointer;
    FSettings : IHsVTSettingNodes;

    Procedure DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);

  Protected
    Function  GetList() : IHsVTPropertyDefsNode;
    Procedure SetList(AList : IHsVTPropertyDefsNode);

    Function  GetSettings() : IHsVTSettingNodes;
    Procedure SetSettings(Const ASettings : IHsVTSettingNodes);

    Procedure GetPropertyTypeList(Const AStrings : TStrings);

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

    Procedure SetIsBigEndian(Const ABigEndian : Boolean); OverRide;

    Property PropertyName : String Read GetPropertyName Write SetPropertyName;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

    Constructor Create(Const AList : IHsVTPropertyDefsNode); ReIntroduce;

  End;

  THsVTPropertyDefsNode = Class(THsPropertyDefs, IHsVTPropertyDefsNode)
  Strict Private
    FVTNode         : PVirtualNode;
    FSettingVisible : Boolean;

  Protected
    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);

    Function  GetSettingVisible() : Boolean;
    Procedure SetSettingVisible(Const ASettingVisible : Boolean);

    Function  Get(Index : Integer) : IHsVTPropertyDefNode; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsVTPropertyDefNode); OverLoad;
    Function  Add() : IHsVTPropertyDefNode; OverLoad;

  End;

  THsVTProcedureDef = Class(THsProcedureDef, IHsVTProcedureDefNode)
  Private
    FSettings : IHsVTSettingNodes;

    Procedure DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);
    Procedure DoOnCodeChange(Sender : TObject);

  Protected
    Function  GetSettings() : IHsVTSettingNodes;
    Procedure SetSettings(Const ASettings : IHsVTSettingNodes);

    Procedure SetProcedureName(Const AProcedureName : String); OverRide;
    Procedure SetProcedureParameters(Const AProcedureParameters : String); OverRide;
    Procedure SetResultType(Const AResultType : THsFunctionResultType); OverRide;

    Procedure SetIsReIntroduce(Const AIsReIntroduce : Boolean); OverRide;
    Procedure SetIsVirtual(Const AIsVirtual : Boolean); OverRide;
    Procedure SetIsAbstract(Const AIsAbstract : Boolean); OverRide;
    Procedure SetIsOverRide(Const AIsOverRide : Boolean); OverRide;
    Procedure SetIsOverLoad(Const AIsOverLoad : Boolean); OverRide;
    Procedure SetIsFinal(Const AIsFinal : Boolean); OverRide;
    Procedure SetIsStatic(Const AIsStatic : Boolean); OverRide;
    Procedure SetIsInline(Const AIsInline : Boolean); OverRide;

    Procedure SetShowInInterface(Const AShowInInterface : Boolean); OverRide;

    Procedure SetProcedureScope(Const AProcedureScope : THsFunctionScope); OverRide;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  THsVTProcedureDefs = Class(THsProcedureDefs, IHsVTProcedureDefsNode)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : IHsVTProcedureDefNode; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsVTProcedureDefNode); OverLoad;

    Function Add() : IHsVTProcedureDefNode; OverLoad;
    Function Add(Const AItem : IHsVTProcedureDefNode) : Integer; OverLoad;

  End;

  THsVTListSettingsNode = Class(THsListSettings, IHsVTListSettingsNode)
  Strict Private
    FVTNode          : PVirtualNode;
    FSettings        : IHsVTSettingNodes;
    FSettingsVisible : Boolean;

    Procedure DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);

  Protected
    Function GetProcedureDefsClass() :  THsProcedureDefsClass; OverRide;

    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);

    Function  GetMethods() : IHsVTProcedureDefsNode; OverLoad;

    Function  GetSettings() : IHsVTSettingNodes;

    Function  GetSettingsVisible() : Boolean;
    Procedure SetSettingsVisible(Const ASettingsVisible : Boolean);

    Procedure SetUseStrict(Const AUseStrict : Boolean); OverRide;
    Procedure SetUseEnumerator(Const AUseEnumerator : Boolean); OverRide;
    Procedure SetUseNestedClass(Const AUseNestedClass : Boolean); OverRide;
    Procedure SetIsSealed(Const AIsSealed : Boolean); OverRide;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  THsVTClassCodeGeneratorNode = Class(THsClassCodeGenerator, IHsVTClassCodeGeneratorNode)
  Private
    FSettings      : IHsVTSettingNodes;
    FMsSQLSettings : IHsVTSettingNodes;

    Procedure DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);

  Protected
    Function  GetPropertiesClass() : THsPropertyDefsClass; OverRide;
    Function  GetProcedureDefsClass() : THsProcedureDefsClass; OverRide;
    Function  GetListSettingsClass() : THsListSettingsClass; OverRide;

    Function GetPropertyDefs() : IHsVTPropertyDefsNode; OverLoad;
    Function GetProcedureDefs() : IHsVTProcedureDefsNode; OverLoad;
    Function GetListSettings() : IHsVTListSettingsNode; OverLoad;

    Procedure Assign(ASource : IHsClassCodeGenerator);

    Function  GetSettings() : IHsVTSettingNodes;
    Procedure SetSettings(Const ASettings : IHsVTSettingNodes);

    Function  GetMsSQLSettings() : IHsVTSettingNodes;
    Procedure SetMsSQLSettings(Const ASettings : IHsVTSettingNodes);

    //Properties
    Procedure SetInHeritsFrom(Const AInHeritsFrom : String); OverRide;
    Procedure SetUseInterface(Const AUseInterface : Boolean); OverRide;
    Procedure SetUseStrict(Const AUseStrict : Boolean); OverRide;
    Procedure SetUseCustomClass(Const AUseCustomClass : Boolean); OverRide;
    Procedure SetMakeList(Const AMakeList : Boolean); OverRide;
    Procedure SetTrackChange(Const ATrackChange : Boolean); OverRide;
    Procedure SetDataType(Const ADataType : THsDataSource); OverRide;
    Procedure SetAdoQueryClassName(Const AAdoQueryClassName : String); OverRide;
    Procedure SetTableName(Const ATableName : String); OverRide;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  THsVTClassCodeGeneratorsNode = Class(THsClassCodeGenerators, IHsVTClassCodeGeneratorsNode)
  Protected
    Function  Get(Index: Integer) : IHsVTClassCodeGeneratorNode; OverLoad;
    Procedure Put(Index: Integer; Const Item: IHsVTClassCodeGeneratorNode); OverLoad;

    Function  Add() : IHsVTClassCodeGeneratorNode; OverLoad;

  End;

  THsVTTypeDefNode = Class(THsTypeDef, IHsVTTypeDefNode)
  Private
    FVTNode         : PVirtualNode;
    FSettingVisible : Boolean;
    FSettings       : IHsVTSettingNodes;

    Procedure DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);

  Protected
    Function GetPropertiesClass() : THsPropertyDefsClass; OverRide;

    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);

    Procedure SetTypeDefValue(Const ATypeDefValue : TStrings); OverRide;

    Function  GetSettings() : IHsVTSettingNodes;
    Procedure SetSettings(Const ASettings : IHsVTSettingNodes);

    Function  GetSettingsVisible() : Boolean;
    Procedure SetSettingsVisible(Const ASettingsVisible : Boolean);

    Procedure GetTypeDefList(Const AStrings : TStrings);
    Function GetTypeDefMembers() : IHsVTPropertyDefsNode; OverLoad;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  THsVTTypeDefsNode = Class(THsTypeDefs, IHsVTTypeDefsNode)
  Private
    FVTNode         : PVirtualNode;
    FSettingVisible : Boolean;

  Protected
    Function  GetVTNode() : PVirtualNode;
    Procedure SetVTNode(AVTNode : PVirtualNode);

    Function  GetSettingsVisible() : Boolean;
    Procedure SetSettingsVisible(Const ASettingsVisible : Boolean);

    Function  Get(Index: Integer) : IHsVTTypeDefNode; OverLoad;
    Procedure Put(Index: Integer; Const Item: IHsVTTypeDefNode); OverLoad;

    Function Add() : IHsVTTypeDefNode; OverLoad;

  End;

  THsVTUnitGeneratorNode = Class(THsUnitGenerator, IHsVTUnitGeneratorNode)
  Protected
    Procedure Assign(Const ASource : IHsUnitGenerator); OverRide;
    Procedure LoadFromFile(Const AFileName : String); OverRide;

    Function GetTypeDefsClass() : THsTypeDefsClass; OverRide;
    Function GetCodeGeneratorClass() : THsClassCodeGeneratorsClass; OverRide;

    Function GetTypeDefs() : IHsVTTypeDefsNode; OverLoad;
    Function GetClassDefs() : IHsVTClassCodeGeneratorsNode; OverLoad;

  End;

Class Function TVTCodeGen.CreateGenerator() : IHsVTUnitGeneratorNode;
Begin
  Result := THsVTUnitGeneratorNode.Create(True);
End;

(******************************************************************************)

Procedure THsVTSettingNode.AfterConstruction();
Begin
  InHerited AfterConstruction();
  FSettingVisible := True;
End;

Function THsVTSettingNode.GetOnChange() : TOnValueChangeEvent;
Begin
  Result := FOnChange;
End;

Procedure THsVTSettingNode.SetOnChange(Const AOnChange : TOnValueChangeEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure THsVTSettingNode.GetEnumNameList(AList : TStrings);
Var lEnumData : PTypeData;
    X : Integer;
    lNames : PByteArray;
Begin
  If Assigned(AList) And Assigned(FEnumInfo) Then
  Begin
    AList.Clear();
    lEnumData := GetTypeData(FEnumInfo);
    If Assigned(lEnumData) Then
    Begin
      lNames := @lENumData.NameList;

      For X := lEnumData.MinValue To lEnumData.MaxValue Do
      Begin
        AList.Add(Copy(PChar(lNames), 2, lNames[0]));
        lNames := @lNames[lNames[0] + 1];
      End; 
    End;
  End;
End;

Function THsVTSettingNode.GetVTNode() : PVirtualNode;
Begin
  Result := FVTNode
End;

Procedure THsVTSettingNode.SetVTNode(AVTNode : PVirtualNode);
Begin
  FVTNode := AVTNode;
End;

Function THsVTSettingNode.GetSettingName() : String;
Begin
  Result := FSettingName;
End;

Procedure THsVTSettingNode.SetSettingName(Const ASettingName : String);
Begin
  FSettingName := ASettingName;
  If Assigned(FOnChange) Then
    FOnChange(Self, FSettingName);
End;

Function THsVTSettingNode.GetSettingValue() : Variant;
Begin
  Result := FSettingValue;
End;

Procedure THsVTSettingNode.SetSettingValue(Const ASettingValue : Variant);
Begin
  FSettingValue := ASettingValue;
  If Assigned(FOnChange) Then
    FOnChange(Self, FSettingValue);
End;

Function THsVTSettingNode.GetSettingType() : THsPropertyType;
Begin
  Result := FSettingType;
End;

Procedure THsVTSettingNode.SetSettingType(Const ASettingType : THsPropertyType);
Begin
  FSettingType := ASettingType;
End;

Function THsVTSettingNode.GetSettingVisible() : Boolean;
Begin
  If Assigned(FVTNode) Then
    Result := vsVisible In FVTNode.States
  Else
    Result := FSettingVisible;
End;

Procedure THsVTSettingNode.SetSettingVisible(Const ASettingVisible : Boolean);
Begin
  If Assigned(FVTNode) Then
  Begin
    If ASettingVisible Then
      FVTNode.States := FVTNode.States + [vsVisible]
    Else
      FVTNode.States := FVTNode.States - [vsVisible];
  End
  Else
    FSettingVisible := ASettingVisible;
End;

Function THsVTSettingNode.GetEnumInfo() : PTypeInfo;
Begin
  Result := FEnumInfo;
End;

Procedure THsVTSettingNode.SetEnumInfo(AEnumInfo : PTypeInfo);
Begin
  FEnumInfo := AEnumInfo;
End;

Function THsVTSettingNodes.THsVTSettingNodeEnumerator.GetCurrent() : IHsVTSettingNode;
Begin
  Result := InHerited Current As IHsVTSettingNode;
End;

Procedure THsVTSettingNodes.AfterConstruction();
Begin
  InHerited AfterConstruction();
  
  FVTNode := Nil;
  FNodeCaption := 'Settings';
  FSettingVisible := True;
End;

Function THsVTSettingNodes.GetEnumerator() : IHsVTSettingNodeEnumerator;
Begin
  Result := THsVTSettingNodeEnumerator.Create(Self);
End;

Function THsVTSettingNodes.Get(Index : Integer) : IHsVTSettingNode;
Begin
  Supports(InHerited Items[Index], IHsVTSettingNode, Result);
End;

Procedure THsVTSettingNodes.Put(Index : Integer; Const Item : IHsVTSettingNode);
Var lInItem : IHsVTSettingNode;
Begin
  Supports(Item, IHsVTSettingNode, lInItem);
  InHerited Items[Index] := lInItem;
End;

Function THsVTSettingNodes.Add() : IHsVTSettingNode;
Begin
  Result := THsVTSettingNode.Create();
  InHerited Add(Result);
End;

Function THsVTSettingNodes.AddStringSetting(Const ASettingName : String; Const ASettingValue : String = '') : IHsVTSettingNode;
Begin
  Result := Add();

  Result.SettingType  := ptString;
  Result.SettingName  := ASettingName;
  Result.SettingValue := ASettingValue;
End;

Function THsVTSettingNodes.AddTStringSetting(Const ASettingName : String; Const ASettingValue : String = '') : IHsVTSettingNode;
Begin
  Result := Add();

  Result.SettingType  := ptStringList;
  Result.SettingName  := ASettingName;
  Result.SettingValue := ASettingValue;
End;

Function THsVTSettingNodes.AddIntegerSetting(Const ASettingName : String; Const ASettingValue : Integer = 0) : IHsVTSettingNode;
Begin
  Result := Add();

  Result.SettingType  := ptInteger;
  Result.SettingName  := ASettingName;
  Result.SettingValue := ASettingValue;
End;

Function THsVTSettingNodes.AddBooleanSetting(Const ASettingName : String; Const ASettingValue : Boolean = True) : IHsVTSettingNode;
Begin
  Result := Add();

  Result.SettingType  := ptBoolean;
  Result.SettingName  := ASettingName;
  Result.SettingValue := ASettingValue;
End;

Function THsVTSettingNodes.AddEnumSetting(Const ASettingName : String; AEnumSetting : PTypeInfo) : IHsVTSettingNode;
Begin
  Result := Add();
  Result.SettingType := ptEnum;
  Result.SettingName := ASettingName;
  Result.EnumInfo    := AEnumSetting;
End;

Function THsVTSettingNodes.IndexOf(Const ANodeSettingName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;
  
  For X := 0 To Count - 1 Do
    If SameText(Items[X].SettingName, ANodeSettingName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Function THsVTSettingNodes.GetVTNode() : PVirtualNode;
Begin
  Result := FVTNode;
End;

Procedure THsVTSettingNodes.SetVTNode(ANode : PVirtualNode);
Begin
  If FVTNode <> ANode Then
  Begin
    FVTNode := ANode;
    If FSettingVisible Then
      FVTNode.States := FVTNode.States + [vsVisible]
    Else
      FVTNode.States := FVTNode.States - [vsVisible];
  End;
End;

Function THsVTSettingNodes.GetNodeCaption() : String;
Begin
  Result := FNodeCaption;
End;

Procedure THsVTSettingNodes.SetNodeCaption(Const ACaption : String);
Begin
  FNodeCaption := ACaption;
End;

Function THsVTSettingNodes.GetSettingVisible() : Boolean;
Begin
  If Assigned(FVTNode) Then
    Result := vsVisible In FVTNode.States
  Else
    Result := FSettingVisible;
End;

Procedure THsVTSettingNodes.SetSettingVisible(Const ASettingVisible : Boolean);
Begin
  If Assigned(FVTNode) Then
  Begin
    If ASettingVisible Then
      FVTNode.States := FVTNode.States + [vsVisible]
    Else
      FVTNode.States := FVTNode.States - [vsVisible];
  End
  Else
    FSettingVisible := ASettingVisible;
End;

Function THsVTSettingNodes.NodeSettingByName(Const ANodeSettingName : String) : IHsVTSettingNode;
Var lItem : IHsVTSettingNode;
Begin
  Result := Nil;

  For lItem In IHsVTSettingNodes(Self) Do
    If SameText(lItem.SettingName, ANodeSettingName) Then
    Begin
      Result := lItem;
      Break;
    End;

  If Result = Nil Then
    ShowMessage('Setting not found : ' + ANodeSettingName);
//!!
//  If Not Assigned(Result) Then
//    Result := THsVTSettingNode.Create();
    //AddStringSetting(ANodeSettingName);
End;

Constructor THsVTPropertyDefNode.Create(Const AList : IHsVTPropertyDefsNode);
Begin
  InHerited Create();

//  FList := Pointer(AList);
End;

Procedure THsVTPropertyDefNode.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FSettings := THsVTSettingNodes.Create();

  With FSettings.AddStringSetting('ClassName') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := False;
  End;

  With FSettings.AddStringSetting('InterfaceName') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := False;
  End;

  With FSettings.AddStringSetting('InterfaceImplementor') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := False;
  End;

  With FSettings.AddBooleanSetting('IsDataAware') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := False;
  End;

  With FSettings.AddBooleanSetting('IsId') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := False;
    SettingValue   := False;
  End;

  With FSettings.AddStringSetting('FieldName') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := False;
  End;

  With FSettings.AddIntegerSetting('MaxLen') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := False;
  End;

  With FSettings.AddBooleanSetting('IsBigEndian') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := False;
    SettingValue   := False;
  End;

  With FSettings.AddBooleanSetting('IsReadOnly') Do
  Begin
    OnChange     := DoSetSettingProperties;
    SettingValue := False;
  End;
End;

Procedure THsVTPropertyDefNode.BeforeDestruction();
Begin
  FSettings := Nil;

  InHerited BeforeDestruction();
End;

Procedure THsVTPropertyDefNode.GetPropertyTypeList(Const AStrings : TStrings);
Var lTypeData  : PTypeData;
    lEnumNames : PByteArray;
    X          : Integer;
Begin
  AStrings.Clear();

  lTypeData := GetTypeData(TypeInfo(THsPropertyType));
  lEnumNames := @lTypeData.NameList;
  For X := lTypeData.MinValue To lTypeData.MaxValue Do
  Begin
    AStrings.Add(Copy(PChar(lEnumNames), 2, lEnumNames[0]));
    lEnumNames := @lEnumNames[lEnumNames[0] + 1];
  End;
End;

Procedure THsVTPropertyDefNode.DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);
Begin
  If SameText(Sender.SettingName, 'ClassName') Then
    InHerited SetPropertyClass(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'InterfaceName') Then
    InHerited SetInterfaceName(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'InterfaceImplementor') Then
    InHerited SetInterfaceImplementor(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'PropertyName') Then
    InHerited SetPropertyName(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'FieldName') Then
    InHerited SetFieldName(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'MaxLen') Then
    InHerited SetMaxLen(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsBigEndian') Then
    InHerited SetIsBigEndian(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsReadOnly') Then
    InHerited SetIsReadOnly(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsId') Then
    InHerited SetIsId(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsDataAware') Then
    InHerited SetIsDataAware(Sender.SettingValue);
End;

Procedure THsVTPropertyDefNode.SetPropertyClass(Const APropertyClass : String);
Begin
  FSettings.NodeSettingByName('ClassName').SettingValue := APropertyClass;
  InHerited SetPropertyClass(APropertyClass);
End;

Procedure THsVTPropertyDefNode.SetInterfaceName(Const AInterfaceName : String);
Begin
  FSettings.NodeSettingByName('InterfaceName').SettingValue := AInterfaceName;
  InHerited SetInterfaceName(AInterfaceName);
End;

Procedure THsVTPropertyDefNode.SetInterfaceImplementor(Const AInterfaceImplementor : String);
Begin
  FSettings.NodeSettingByName('InterfaceImplementor').SettingValue := AInterfaceImplementor;
  InHerited SetInterfaceImplementor(AInterfaceImplementor);
End;

Procedure THsVTPropertyDefNode.SetPropertyName(Const APropertyName : String);
Begin
  If FSettings.NodeSettingByName('IsDataAware').SettingValue And
     (SameText(FSettings.NodeSettingByName('FieldName').SettingValue, PropertyName) Or
      SameText(FSettings.NodeSettingByName('FieldName').SettingValue, '')) Then
    FSettings.NodeSettingByName('FieldName').SettingValue := APropertyName;

  InHerited SetPropertyName(APropertyName);
End;

Procedure THsVTPropertyDefNode.SetIsId(Const AIsId : Boolean);
Begin
  FSettings.NodeSettingByName('IsId').SettingValue := AIsId;
  InHerited SetIsId(AIsId);
End;

Procedure THsVTPropertyDefNode.SetFieldName(Const AFieldName : String);
Begin
  FSettings.NodeSettingByName('FieldName').SettingValue := AFieldName;
  InHerited SetFieldName(AFieldName);
End;

Procedure THsVTPropertyDefNode.SetPropertyType(Const APropertyType : THsPropertyType);
Begin
//!!  FSettings.NodeBySettingName('PropertyType').SettingValue := APropertyType;
  InHerited SetPropertyType(APropertyType);
End;

Procedure THsVTPropertyDefNode.SetIsDataAware(Const AIsDataAware : Boolean);
Begin
  FSettings.NodeSettingByName('IsDataAware').SettingValue := AIsDataAware;
  InHerited SetIsDataAware(AIsDataAware);
End;

Procedure THsVTPropertyDefNode.SetIsReadOnly(Const AIsReadOnly : Boolean);
Begin
  FSettings.NodeSettingByName('IsReadOnly').SettingValue := AIsReadOnly;
  InHerited SetIsReadOnly(AIsReadOnly);
End;

Procedure THsVTPropertyDefNode.SetMaxLen(Const AMaxLen : Integer);
Begin
  FSettings.NodeSettingByName('MaxLen').SettingValue := AMaxLen;
  InHerited SetMaxLen(AMaxLen);
End;

Procedure THsVTPropertyDefNode.SetIsBigEndian(Const ABigEndian : Boolean);
Begin
  FSettings.NodeSettingByName('IsBigEndian').SettingValue := ABigEndian;
  InHerited SetIsBigEndian(ABigEndian);
End;

Function THsVTPropertyDefNode.GetList() : IHsVTPropertyDefsNode;
Begin
  Result := IHsVTPropertyDefsNode(FList);
End;

Procedure THsVTPropertyDefNode.SetList(AList : IHsVTPropertyDefsNode);
Begin
  FList := Pointer(AList);
End;

Function THsVTPropertyDefNode.GetSettings() : IHsVTSettingNodes;
Begin
  Result := FSettings;
End;

Procedure THsVTPropertyDefNode.SetSettings(Const ASettings : IHsVTSettingNodes);
Begin
  FSettings := ASettings;
End;

Function THsVTPropertyDefsNode.GetVTNode() : PVirtualNode;
Begin
  Result := FVTNode;
End;

Procedure THsVTPropertyDefsNode.SetVTNode(AVTNode : PVirtualNode);
Begin
  FVTNode := AVTNode;
End;

Function THsVTPropertyDefsNode.GetSettingVisible() : Boolean;
Begin
  If Assigned(FVTNode) Then
    Result := vsVisible In FVTNode.States
  Else
    Result := FSettingVisible;
End;

Procedure THsVTPropertyDefsNode.SetSettingVisible(Const ASettingVisible : Boolean);
Begin
  If Assigned(FVTNode) Then
  Begin
    If ASettingVisible Then
      FVTNode.States := FVTNode.States + [vsVisible]
    Else
      FVTNode.States := FVTNode.States - [vsVisible];
  End
  Else
    FSettingVisible := ASettingVisible;
End;

Function THsVTPropertyDefsNode.Get(Index : Integer) : IHsVTPropertyDefNode;
Begin
  Result := InHerited Items[Index] As IHsVTPropertyDefNode;
End;

Procedure THsVTPropertyDefsNode.Put(Index : Integer; Const Item : IHsVTPropertyDefNode);
Begin
  InHerited Items[Index] := Item;
End;

Function THsVTPropertyDefsNode.Add() : IHsVTPropertyDefNode;
Begin
  Result := THsVTPropertyDefNode.Create(Self);

  InHerited Add(Result);
End;

Procedure THsVTProcedureDef.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FSettings := THsVTSettingNodes.Create();

  With FSettings.AddStringSetting('ProcedureName') Do
  Begin
    SettingVisible := False;
    OnChange       := DoSetSettingProperties;
  End;

  FSettings.AddStringSetting('Parameters').OnChange := DoSetSettingProperties;
  FSettings.AddTStringSetting('Code');
  FSettings.AddEnumSetting('ReturnType', TypeInfo(THsFunctionResultType)).OnChange := DoSetSettingProperties;
  FSettings.AddEnumSetting('Scope', TypeInfo(THsFunctionScope)).OnChange := DoSetSettingProperties;

  FSettings.AddBooleanSetting('ShowInInterface').OnChange := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsReIntroduce').OnChange   := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsVirtual').OnChange       := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsAbstract').OnChange      := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsOverRide').OnChange      := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsOverLoad').OnChange      := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsFinal').OnChange         := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsStatic').OnChange        := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsInline').OnChange        := DoSetSettingProperties;

  TStringList(InHerited GetProcedureImpl()).OnChange := DoOnCodeChange;

  SetIsReIntroduce(False);
  SetIsVirtual(False);
  SetIsAbstract(False);
  SetIsOverRide(False);
  SetIsOverLoad(False);
  SetIsFinal(False);
  SetIsStatic(False);
  SetIsInline(False);
  SetProcedureScope(fsPublic);
  SetShowInInterface(True);
End;

Procedure THsVTProcedureDef.DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);
Begin
  If SameText(Sender.SettingName, 'ProcedureName') Then
    InHerited SetProcedureName(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'Parameters') Then
    InHerited SetProcedureParameters(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'ReturnType') Then
    InHerited SetResultType(THsFunctionResultType(GetEnumValue(TypeInfo(THsFunctionResultType), Sender.SettingValue)))
  Else If SameText(Sender.SettingName, 'IsReIntroduce') Then
    InHerited SetIsReIntroduce(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsVirtual') Then
    InHerited SetIsVirtual(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsAbstract') Then
    InHerited SetIsAbstract(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsOverRide') Then
    InHerited SetIsOverRide(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsOverLoad') Then
    InHerited SetIsOverLoad(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsFinal') Then
    InHerited SetIsFinal(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsStatic') Then
    InHerited SetIsStatic(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsInline') Then
    InHerited SetIsInline(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'Scope') Then
    InHerited SetProcedureScope(THsFunctionScope(GetEnumValue(TypeInfo(THsFunctionScope), Sender.SettingValue)))
  Else If SameText(Sender.SettingName, 'ShowInInterface') Then
    InHerited SetShowInInterface(Sender.SettingValue);
End;

Procedure THsVTProcedureDef.DoOnCodeChange(Sender : TObject);
Var lImpl : TStrings;
Begin
  lImpl := GetProcedureImpl();
  If Assigned(lImpl) Then
    FSettings.NodeSettingByName('Code').SettingValue := lImpl.Text;
End;

Function THsVTProcedureDef.GetSettings() : IHsVTSettingNodes;
Begin
  Result := FSettings;
End;

Procedure THsVTProcedureDef.SetSettings(Const ASettings : IHsVTSettingNodes);
Begin
  FSettings := ASettings;
End;

Procedure THsVTProcedureDef.SetProcedureName(Const AProcedureName : String);
Begin
  FSettings.NodeSettingByName('ProcedureName').SettingValue := AProcedureName;
  InHerited SetProcedureName(AProcedureName);
End;

Procedure THsVTProcedureDef.SetProcedureParameters(Const AProcedureParameters : String);
Begin
  FSettings.NodeSettingByName('Parameters').SettingValue := AProcedureParameters;
  InHerited SetProcedureParameters(AProcedureParameters);
End;

Procedure THsVTProcedureDef.SetResultType(Const AResultType : THsFunctionResultType);
Begin
  FSettings.NodeSettingByName('ReturnType').SettingValue :=
    GetEnumName(TypeInfo(THsFunctionResultType), Ord(AResultType));
  InHerited SetResultType(AResultType);
End;

Procedure THsVTProcedureDef.SetIsReIntroduce(Const AIsReIntroduce : Boolean);
Begin
  FSettings.NodeSettingByName('IsReIntroduce').SettingValue := AIsReIntroduce;
  InHerited SetIsReIntroduce(AIsReIntroduce);
End;

Procedure THsVTProcedureDef.SetIsVirtual(Const AIsVirtual : Boolean);
Begin
  FSettings.NodeSettingByName('IsVirtual').SettingValue := AIsVirtual;
  InHerited SetIsVirtual(AIsVirtual);
End;

Procedure THsVTProcedureDef.SetIsAbstract(Const AIsAbstract : Boolean);
Begin
  FSettings.NodeSettingByName('IsAbstract').SettingValue := AIsAbstract;
  InHerited SetIsAbstract(AIsAbstract);
End;

Procedure THsVTProcedureDef.SetIsOverRide(Const AIsOverRide : Boolean);
Begin
  FSettings.NodeSettingByName('IsOverRide').SettingValue := AIsOverRide;
  InHerited SetIsOverRide(AIsOverRide);
End;

Procedure THsVTProcedureDef.SetIsOverLoad(Const AIsOverLoad : Boolean);
Begin
  FSettings.NodeSettingByName('IsOverLoad').SettingValue := AIsOverLoad;
  InHerited SetIsOverLoad(AIsOverLoad);
End;

Procedure THsVTProcedureDef.SetIsFinal(Const AIsFinal : Boolean);
Begin
  FSettings.NodeSettingByName('IsFinal').SettingValue := AIsFinal;
  InHerited SetIsFinal(AIsFinal);
End;

Procedure THsVTProcedureDef.SetIsStatic(Const AIsStatic : Boolean);
Begin
  FSettings.NodeSettingByName('IsStatic').SettingValue := AIsStatic;
  InHerited SetIsStatic(AIsStatic);
End;

Procedure THsVTProcedureDef.SetIsInline(Const AIsInline : Boolean);
Begin
  FSettings.NodeSettingByName('IsInline').SettingValue := AIsInline;
  InHerited SetIsInline(AIsInline);
End;

Procedure THsVTProcedureDef.SetShowInInterface(Const AShowInInterface : Boolean);
Begin
  FSettings.NodeSettingByName('ShowInInterface').SettingValue := AShowInInterface;
  InHerited SetShowInInterface(AShowInInterface);
End;

Procedure THsVTProcedureDef.SetProcedureScope(Const AProcedureScope : THsFunctionScope);
Begin
  FSettings.NodeSettingByName('Scope').SettingValue :=
    GetEnumName(TypeInfo(THsFunctionScope), Ord(AProcedureScope));
  InHerited SetProcedureScope(AProcedureScope);
End;

Function THsVTProcedureDefs.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := THsVTProcedureDef;
End;

Function THsVTProcedureDefs.Get(Index : Integer) : IHsVTProcedureDefNode;
Begin
  Result := InHerited Items[Index] As IHsVTProcedureDefNode;
End;

Procedure THsVTProcedureDefs.Put(Index : Integer; Const Item : IHsVTProcedureDefNode);
Begin
  InHerited Items[Index] := Item;
End;

Function THsVTProcedureDefs.Add() : IHsVTProcedureDefNode;
Begin
  Result := InHerited Add() As IHsVTProcedureDefNode;
End;

Function THsVTProcedureDefs.Add(Const AItem : IHsVTProcedureDefNode) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function THsVTListSettingsNode.GetProcedureDefsClass() :  THsProcedureDefsClass;
Begin
  Result := THsVTProcedureDefs;
End;


Function THsVTListSettingsNode.GetVTNode() : PVirtualNode;
Begin
  Result := FVTNode;
End;

Procedure THsVTListSettingsNode.SetVTNode(AVTNode : PVirtualNode);
Begin
  If FVTNode <> AVTNode Then
  Begin
    FVTNode := AVTNode;
    If FSettingsVisible Then
      FVTNode.States := FVTNode.States + [vsVisible]
    Else
      FVTNode.States := FVTNode.States - [vsVisible];
  End;
End;

Procedure THsVTListSettingsNode.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FSettings := THsVTSettingNodes.Create();

  FSettings.AddBooleanSetting('UseStrict').OnChange      := DoSetSettingProperties;
  FSettings.AddBooleanSetting('UseEnumerator').OnChange  := DoSetSettingProperties;
  FSettings.AddBooleanSetting('UseNestedClass').OnChange := DoSetSettingProperties;
  FSettings.AddBooleanSetting('IsSealed').OnChange       := DoSetSettingProperties;

  FSettingsVisible := False;

  SetUseStrict(False);
  SetUseEnumerator(False);
  SetUseNestedClass(False);
  SetIsSealed(False);
End;

Procedure THsVTListSettingsNode.BeforeDestruction();
Begin
  FSettings := Nil;

  InHerited BeforeDestruction();
End;

Function THsVTListSettingsNode.GetMethods() : IHsVTProcedureDefsNode;
Begin
  Result := InHerited GetMethods() As IHsVTProcedureDefsNode;
End;

Function THsVTListSettingsNode.GetSettings() : IHsVTSettingNodes;
Begin
  Result := FSettings;
End;

Function THsVTListSettingsNode.GetSettingsVisible() : Boolean;
Begin
  If Assigned(FVTNode) Then
    Result := vsVisible In FVTNode.States
  Else
    Result := FSettingsVisible;
End;

Procedure THsVTListSettingsNode.SetSettingsVisible(Const ASettingsVisible : Boolean);
Begin
  If Assigned(FVTNode) Then
  Begin
    If ASettingsVisible Then
      FVTNode.States := FVTNode.States + [vsVisible]
    Else
      FVTNode.States := FVTNode.States - [vsVisible];
  End
  Else
    FSettingsVisible := ASettingsVisible;
End;

Procedure THsVTListSettingsNode.DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);
Begin
  If SameText(Sender.SettingName, 'UseStrict') Then
    InHerited SetUseStrict(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'UseEnumerator') Then
    InHerited SetUseEnumerator(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'UseNestedClass') Then
    InHerited SetUseNestedClass(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'IsSealed') Then
    InHerited SetIsSealed(Sender.SettingValue);
End;

Procedure THsVTListSettingsNode.SetUseStrict(Const AUseStrict : Boolean);
Begin
  FSettings.NodeSettingByName('UseStrict').SettingValue := AUseStrict;
  InHerited SetUseStrict(AUseStrict);
End;

Procedure THsVTListSettingsNode.SetUseEnumerator(Const AUseEnumerator : Boolean);
Begin
  FSettings.NodeSettingByName('UseEnumerator').SettingValue := AUseEnumerator;
  InHerited SetUseEnumerator(AUseEnumerator);
End;

Procedure THsVTListSettingsNode.SetUseNestedClass(Const AUseNestedClass : Boolean);
Begin
  FSettings.NodeSettingByName('UseNestedClass').SettingValue := AUseNestedClass;
  InHerited SetUseNestedClass(AUseNestedClass);
End;

Procedure THsVTListSettingsNode.SetIsSealed(Const AIsSealed : Boolean);
Begin
  FSettings.NodeSettingByName('IsSealed').SettingValue := AIsSealed;
  InHerited SetIsSealed(AIsSealed);
End;

Procedure THsVTClassCodeGeneratorNode.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FSettings := THsVTSettingNodes.Create();
  FSettings.AddStringSetting('InHeritsFrom').OnChange    := DoSetSettingProperties;
  FSettings.AddBooleanSetting('UseCustomClass').OnChange := DoSetSettingProperties;
  FSettings.AddBooleanSetting('UseInterface').OnChange   := DoSetSettingProperties;
  FSettings.AddBooleanSetting('UseStrict').OnChange      := DoSetSettingProperties;
  FSettings.AddBooleanSetting('MakeList').OnChange       := DoSetSettingProperties;
  FSettings.AddBooleanSetting('TrackChange').OnChange    := DoSetSettingProperties;
  FSettings.AddEnumSetting('DataType', TypeInfo(THsDataSource)).OnChange := DoSetSettingProperties;

  FMsSQLSettings := THsVTSettingNodes.Create();
  FMsSQLSettings.NodeCaption := 'MsSQLSettings';
  FMsSQLSettings.AddStringSetting('AdoQueryClassName').OnChange := DoSetSettingProperties;
  FMsSQLSettings.AddStringSetting('TableName').OnChange := DoSetSettingProperties;

  SetClsName('MyClass');
  SetUseInterface(False);
  SetUseStrict(False);
  SetUseCustomClass(False);
  SetMakeList(False);
  SetTrackChange(False);
  SetDataType(dsNone);

  SetAdoQueryClassName('TAdoQuery');
  SetTableName('');
End;

Procedure THsVTClassCodeGeneratorNode.BeforeDestruction();
Begin
  FSettings := Nil;
  FMsSQLSettings := Nil;
  
  InHerited BeforeDestruction();
End;

Procedure THsVTClassCodeGeneratorNode.Assign(ASource : IHsClassCodeGenerator);
Var X : Integer;
Begin
  SetClsName(ASource.ClsName);
  SetUseInterface(ASource.UseInterface);
  SetUseStrict(ASource.UseStrict);
  SetUseCustomClass(ASource.UseCustomClass);
  SetMakeList(ASource.MakeList);
  SetTrackChange(ASource.TrackChange);
  SetDataType(ASource.DataType);
  SetAdoQueryClassName(ASource.AdoQueryClassName);
  SetTableName(ASource.TableName); 

  For X := 0 To ASource.PropertyDefs.Count - 1 Do
  Begin
    With GetPropertyDefs().Add() Do
    Begin
      PropertyName  := ASource.PropertyDefs[X].PropertyName;
      PropertyType  := ASource.PropertyDefs[X].PropertyType;
      IsReadOnly    := ASource.PropertyDefs[X].IsReadOnly;
      IsDataAware   := ASource.PropertyDefs[X].IsDataAware;

      PropertyClass := ASource.PropertyDefs[X].PropertyClass;

      InterfaceName        := ASource.PropertyDefs[X].InterfaceName;
      InterfaceImplementor := ASource.PropertyDefs[X].InterfaceImplementor;

      IsId          := ASource.PropertyDefs[X].IsId;
      FieldName     := ASource.PropertyDefs[X].FieldName;

      MaxLen        := ASource.PropertyDefs[X].MaxLen;
    End;
  End;
End;

Procedure THsVTClassCodeGeneratorNode.DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);
Begin
  If SameText(Sender.SettingName, 'InHeritsFrom') Then
    InHerited SetInHeritsFrom(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'UseCustomClass') Then
    InHerited SetUseCustomClass(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'UseInterface') Then
    InHerited SetUseInterface(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'UseStrict') Then
    InHerited SetUseStrict(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'MakeList') Then
    InHerited SetMakeList(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'TrackChange') Then
    InHerited SetTrackChange(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'DataType') Then
    InHerited SetDataType(THsDataSource(GetEnumValue(TypeInfo(THsDataSource), Sender.SettingValue)))
  Else If SameText(Sender.SettingName, 'TableName') Then
    InHerited SetTableName(Sender.SettingValue)
  Else If SameText(Sender.SettingName, 'AdoQueryClassName') Then
    InHerited SetAdoQueryClassName(Sender.SettingValue);
End;

Function THsVTClassCodeGeneratorNode.GetPropertyDefs() : IHsVTPropertyDefsNode;
Begin
  Result := InHerited GetPropertyDefs() As IHsVTPropertyDefsNode;
End;

Function THsVTClassCodeGeneratorNode.GetProcedureDefs() : IHsVTProcedureDefsNode;
Begin
  Result := InHerited GetProcedureDefs() As IHsVTProcedureDefsNode;
End;

Function THsVTClassCodeGeneratorNode.GetListSettings() : IHsVTListSettingsNode;
Begin
  Result := InHerited GetListSettings() As IHsVTListSettingsNode;
End;

Function THsVTClassCodeGeneratorNode.GetPropertiesClass() : THsPropertyDefsClass;
Begin
  Result := THsVTPropertyDefsNode;
End;

Function THsVTClassCodeGeneratorNode.GetProcedureDefsClass() : THsProcedureDefsClass;
Begin
  Result := THsVTProcedureDefs;
End;

Function THsVTClassCodeGeneratorNode.GetListSettingsClass() : THsListSettingsClass;
Begin
  Result := THsVTListSettingsNode;
End;

Procedure THsVTClassCodeGeneratorNode.SetInHeritsFrom(Const AInHeritsFrom : String);
Begin
{//!!}  FSettings.NodeSettingByName('InHeritsFrom').SettingValue := AInHeritsFrom;
  InHerited SetInHeritsFrom(AInHeritsFrom);
End;

Procedure THsVTClassCodeGeneratorNode.SetUseInterface(Const AUseInterface : Boolean);
Begin
{//!!}  FSettings.NodeSettingByName('UseInterface').SettingValue := AUseInterface;
  InHerited SetUseInterface(AUseInterface);
End;

Procedure THsVTClassCodeGeneratorNode.SetUseStrict(Const AUseStrict : Boolean);
Begin
{//!!}  FSettings.NodeSettingByName('UseStrict').SettingValue := AUseStrict;
  InHerited SetUseStrict(AUseStrict);
End;

Procedure THsVTClassCodeGeneratorNode.SetUseCustomClass(Const AUseCustomClass : Boolean);
Begin
{//!!}  FSettings.NodeSettingByName('UseCustomClass').SettingValue := AUseCustomClass;
  InHerited SetUseCustomClass(AUseCustomClass);
End;

Procedure THsVTClassCodeGeneratorNode.SetMakeList(Const AMakeList : Boolean);
Begin
{//!!}  FSettings.NodeSettingByName('MakeList').SettingValue := AMakeList;
  InHerited SetMakeList(AMakeList);
End;

Procedure THsVTClassCodeGeneratorNode.SetTrackChange(Const ATrackChange : Boolean);
Begin
{//!!}  FSettings.NodeSettingByName('TrackChange').SettingValue := ATrackChange;
  InHerited SetTrackChange(ATrackChange);
End;

Procedure THsVTClassCodeGeneratorNode.SetDataType(Const ADataType : THsDataSource);
Begin
  FSettings.NodeSettingByName('DataType').SettingValue :=
    GetEnumName(TypeInfo(THsDataSource), Ord(ADataType));
  InHerited SetDataType(ADataType);
End;

Procedure THsVTClassCodeGeneratorNode.SetAdoQueryClassName(Const AAdoQueryClassName : String);
Begin
  FMsSQLSettings.NodeSettingByName('AdoQueryClassName').SettingValue := AAdoQueryClassName;
  InHerited SetAdoQueryClassName(AAdoQueryClassName);
End;

Procedure THsVTClassCodeGeneratorNode.SetTableName(Const ATableName : String);
Begin
  FMsSQLSettings.NodeSettingByName('TableName').SettingValue := ATableName;
  InHerited SetTableName(ATableName);
End;

Function THsVTClassCodeGeneratorNode.GetSettings() : IHsVTSettingNodes;
Begin
  Result := FSettings;
End;

Procedure THsVTClassCodeGeneratorNode.SetSettings(Const ASettings : IHsVTSettingNodes);
Begin
  FSettings := ASettings;
End;

Function THsVTClassCodeGeneratorNode.GetMsSQLSettings() : IHsVTSettingNodes;
Begin
  Result := FMsSQLSettings;
End;

Procedure THsVTClassCodeGeneratorNode.SetMsSQLSettings(Const ASettings : IHsVTSettingNodes);
Begin
  FMsSQLSettings := ASettings;
End;

Procedure THsVTTypeDefNode.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FSettings := THsVTSettingNodes.Create();
(*
  With FSettings.AddStringSetting('TypeValue') Do
  Begin
    OnChange       := DoSetSettingProperties;
    SettingVisible := True;
  End;
*)
  With FSettings.Add() Do
  Begin
    SettingType  := ptString;//ptStringList;
    SettingName  := 'TypeValue';
    SettingValue := '';

    OnChange       := DoSetSettingProperties;
    SettingVisible := True;
  End;
End;

Function THsVTTypeDefNode.GetPropertiesClass() : THsPropertyDefsClass;
Begin
  Result := THsVTPropertyDefsNode;
End;

Procedure THsVTTypeDefNode.DoSetSettingProperties(Sender : IHsVTSettingNode; Const AOldValue : Variant);
Begin
  If SameText(Sender.SettingName, 'TypeValue') Then
    InHerited TypeDefValue.Text := Sender.SettingValue;
End;

Procedure THsVTTypeDefNode.SetTypeDefValue(Const ATypeDefValue : TStrings);
Begin
  InHerited SetTypeDefValue(ATypeDefValue);

  FSettings.NodeSettingByName('TypeValue').SettingValue := ATypeDefValue.Text;
End;

Function THsVTTypeDefNode.GetSettings() : IHsVTSettingNodes;
Begin
  Result := FSettings;
End;

Procedure THsVTTypeDefNode.SetSettings(Const ASettings : IHsVTSettingNodes);
Begin
  FSettings := ASettings;
End;

Function THsVTTypeDefNode.GetVTNode() : PVirtualNode;
Begin
  Result := FVTNode;
End;

Procedure THsVTTypeDefNode.SetVTNode(AVTNode : PVirtualNode);
Begin
  FVTNode := AVTNode;
End;

Function THsVTTypeDefNode.GetSettingsVisible() : Boolean;
Begin
  If Assigned(FVTNode) Then
    Result := vsVisible In FVTNode.States
  Else
    Result := FSettingVisible;
End;

Procedure THsVTTypeDefNode.SetSettingsVisible(Const ASettingsVisible : Boolean);
Begin
  If Assigned(FVTNode) Then
  Begin
    If ASettingsVisible Then
      FVTNode.States := FVTNode.States + [vsVisible]
    Else
      FVTNode.States := FVTNode.States - [vsVisible];
  End
  Else
    FSettingVisible := ASettingsVisible;
End;

Procedure THsVTTypeDefNode.GetTypeDefList(Const AStrings : TStrings);
Var lTypeData  : PTypeData;
    lEnumNames : PByteArray;
    X          : Integer;
Begin
  AStrings.Clear();

  lTypeData := GetTypeData(TypeInfo(THsTypeDefType));
  lEnumNames := @lTypeData.NameList;
  For X := lTypeData.MinValue To lTypeData.MaxValue Do
  Begin
    AStrings.Add(Copy(PChar(lEnumNames), 2, lEnumNames[0]));
    lEnumNames := @lEnumNames[lEnumNames[0] + 1];
  End;
End;

Function THsVTTypeDefNode.GetTypeDefMembers() : IHsVTPropertyDefsNode;
Begin
  Result := InHerited GetTypeDefMembers() As IHsVTPropertyDefsNode;
End;

Function THsVTTypeDefsNode.GetVTNode() : PVirtualNode;
Begin
  Result := FVTNode;
End;

Procedure THsVTTypeDefsNode.SetVTNode(AVTNode : PVirtualNode);
Begin
  FVTNode := AVTNode;
End;

Function THsVTTypeDefsNode.GetSettingsVisible() : Boolean;
Begin
  If Assigned(FVTNode) Then
    Result := vsVisible In FVTNode.States
  Else
    Result := FSettingVisible;
End;

Procedure THsVTTypeDefsNode.SetSettingsVisible(Const ASettingsVisible : Boolean);
Begin
  If Assigned(FVTNode) Then
  Begin
    If ASettingsVisible Then
      FVTNode.States := FVTNode.States + [vsVisible]
    Else
      FVTNode.States := FVTNode.States - [vsVisible];
  End
  Else
    FSettingVisible := ASettingsVisible;
End;

Function THsVTTypeDefsNode.Get(Index: Integer) : IHsVTTypeDefNode;
Begin
  Result := InHerited Get(Index) As IHsVTTypeDefNode;
End;

Procedure THsVTTypeDefsNode.Put(Index: Integer; Const Item: IHsVTTypeDefNode);
Begin
  InHerited Put(Index, Item);
End;

Function THsVTTypeDefsNode.Add() : IHsVTTypeDefNode;
Begin
  Result := THsVTTypeDefNode.Create();
  InHerited Add(Result);
End;

Function THsVTClassCodeGeneratorsNode.Get(Index: Integer) : IHsVTClassCodeGeneratorNode;
Begin
  Result := InHerited Items[Index] As IHsVTClassCodeGeneratorNode;
End;

Procedure THsVTClassCodeGeneratorsNode.Put(Index: Integer; Const Item: IHsVTClassCodeGeneratorNode);
Begin
  InHerited Items[Index] := Item;
End;

Function THsVTClassCodeGeneratorsNode.Add() : IHsVTClassCodeGeneratorNode;
Begin
  Result := THsVTClassCodeGeneratorNode.Create();
  InHerited Add(Result);
End;

Procedure THsVTUnitGeneratorNode.Assign(Const ASource : IHsUnitGenerator);
Var X, Y : Integer;
Begin
  SetUnitName(ASource.UnitName);

  GetTypeDefs().Clear();
  For X := 0 To ASource.TypeDefs.Count - 1 Do
    With GetTypeDefs().Add() Do
    Begin
      TypeDefType  := ASource.TypeDefs[X].TypeDefType;
      TypeDefName  := ASource.TypeDefs[X].TypeDefName;
      TypeDefValue := ASource.TypeDefs[X].TypeDefValue;

      For Y := 0 To ASource.TypeDefs[X].TypeDefMembers.Count - 1 Do
        With TypeDefMembers.Add() Do
        Begin
          PropertyName := ASource.TypeDefs[X].TypeDefMembers[Y].PropertyName;
          PropertyType := ASource.TypeDefs[X].TypeDefMembers[Y].PropertyType;
        End;
    End;

  GetClassDefs().Clear();
  For X := 0 To ASource.ClassDefs.Count - 1 Do
    With GetClassDefs().Add() Do
    Begin
      ClsName        := ASource.ClassDefs[X].ClsName;
      InHeritsFrom   := Asource.ClassDefs[X].InHeritsFrom;
      UseCustomClass := ASource.ClassDefs[X].UseCustomClass;
      UseInterface   := ASource.ClassDefs[X].UseInterface;
      UseStrict      := ASource.ClassDefs[X].UseStrict;
      MakeList       := ASource.ClassDefs[X].MakeList;
      TrackChange    := ASource.ClassDefs[X].TrackChange;
      DataType       := ASource.ClassDefs[X].DataType;

      TableName := ASource.ClassDefs[X].TableName;
      AdoQueryClassName := ASource.ClassDefs[X].AdoQueryClassName;

      For Y := 0 To ASource.ClassDefs[X].PropertyDefs.Count - 1 Do
      Begin
        With PropertyDefs.Add() Do
        Begin
          PropertyName  := ASource.ClassDefs[X].PropertyDefs[Y].PropertyName;
          PropertyType  := ASource.ClassDefs[X].PropertyDefs[Y].PropertyType;
          IsReadOnly    := ASource.ClassDefs[X].PropertyDefs[Y].IsReadOnly;
          IsDataAware   := ASource.ClassDefs[X].PropertyDefs[Y].IsDataAware;

          PropertyClass := ASource.ClassDefs[X].PropertyDefs[Y].PropertyClass;

          InterfaceName        := ASource.ClassDefs[X].PropertyDefs[Y].InterfaceName;
          InterfaceImplementor := ASource.ClassDefs[X].PropertyDefs[Y].InterfaceImplementor;

          IsId          := ASource.ClassDefs[X].PropertyDefs[Y].IsId;
          FieldName     := ASource.ClassDefs[X].PropertyDefs[Y].FieldName;

          MaxLen        := ASource.ClassDefs[X].PropertyDefs[Y].MaxLen;
          IsBigEndian   := ASource.ClassDefs[X].PropertyDefs[Y].IsBigEndian;
        End;
      End;

      For Y := 0 To ASource.ClassDefs[X].ProcedureDefs.Count - 1 Do
      Begin
        With ProcedureDefs.Add() Do
        Begin
          ProcedureParameters := ASource.ClassDefs[X].ProcedureDefs[Y].ProcedureParameters;
          ProcedureName       := ASource.ClassDefs[X].ProcedureDefs[Y].ProcedureName;
          ProcedureImpl.Text  := ASource.ClassDefs[X].ProcedureDefs[Y].ProcedureImpl.Text;
          ResultType          := ASource.ClassDefs[X].ProcedureDefs[Y].ResultType;
          ProcedureScope      := ASource.ClassDefs[X].ProcedureDefs[Y].ProcedureScope;
          IsVirtual           := ASource.ClassDefs[X].ProcedureDefs[Y].IsVirtual;
          IsAbstract          := ASource.ClassDefs[X].ProcedureDefs[Y].IsAbstract;
          IsOverRide          := ASource.ClassDefs[X].ProcedureDefs[Y].IsOverRide;
          IsReintroduce       := ASource.ClassDefs[X].ProcedureDefs[Y].IsReIntroduce;
          IsOverLoad          := ASource.ClassDefs[X].ProcedureDefs[Y].IsOverLoad;
          IsFinal             := ASource.ClassDefs[X].ProcedureDefs[Y].IsFinal;
          ShowInInterface     := ASource.ClassDefs[X].ProcedureDefs[Y].ShowInInterface;
        End;
      End;

      With ListSettings Do
      Begin
        UseStrict      := ASource.ClassDefs[X].ListSettings.UseStrict;
        UseEnumerator  := ASource.ClassDefs[X].ListSettings.UseEnumerator;
        UseNestedClass := ASource.ClassDefs[X].ListSettings.UseNestedClass;
        IsSealed       := ASource.ClassDefs[X].ListSettings.IsSealed;

        Methods.Clear();
        For Y := 0 To ASource.ClassDefs[X].ListSettings.Methods.Count - 1 Do
        Begin
          With Methods.Add() Do
          Begin
            ProcedureParameters := ASource.ClassDefs[X].ListSettings.Methods[Y].ProcedureParameters;
            ProcedureName       := ASource.ClassDefs[X].ListSettings.Methods[Y].ProcedureName;
            ProcedureImpl.Text  := ASource.ClassDefs[X].ListSettings.Methods[Y].ProcedureImpl.Text;
            ResultType          := ASource.ClassDefs[X].ListSettings.Methods[Y].ResultType;
            ProcedureScope      := ASource.ClassDefs[X].ListSettings.Methods[Y].ProcedureScope;
            IsVirtual           := ASource.ClassDefs[X].ListSettings.Methods[Y].IsVirtual;
            IsAbstract          := ASource.ClassDefs[X].ListSettings.Methods[Y].IsAbstract;
            IsOverRide          := ASource.ClassDefs[X].ListSettings.Methods[Y].IsOverRide;
            IsReintroduce       := ASource.ClassDefs[X].ListSettings.Methods[Y].IsReIntroduce;
            IsOverLoad          := ASource.ClassDefs[X].ListSettings.Methods[Y].IsOverLoad;
            IsFinal             := ASource.ClassDefs[X].ListSettings.Methods[Y].IsFinal;
            ShowInInterface     := ASource.ClassDefs[X].ListSettings.Methods[Y].ShowInInterface;
          End;
        End;
      End;
    End;
End;

Procedure THsVTUnitGeneratorNode.LoadFromFile(Const AFileName : String);
Var lLoader : IHsUnitGenerator;
Begin
  lLoader := THsUnitGenerator.Create();
  Try
    lLoader.LoadFromFile(AFileName);
    Assign(lLoader);

    Finally
      lLoader := Nil;
  End;
End;

Function THsVTUnitGeneratorNode.GetTypeDefsClass() : THsTypeDefsClass;
Begin
  Result := THsVTTypeDefsNode;
End;

Function THsVTUnitGeneratorNode.GetCodeGeneratorClass() : THsClassCodeGeneratorsClass;
Begin
  Result := THsVTClassCodeGeneratorsNode;
End;

Function THsVTUnitGeneratorNode.GetTypeDefs() : IHsVTTypeDefsNode;
Begin
  Result := InHerited GetTypeDefs() As IHsVTTypeDefsNode;
End;

Function THsVTUnitGeneratorNode.GetClassDefs() : IHsVTClassCodeGeneratorsNode;
Begin
  Result := InHerited GetClassDefs() As IHsVTClassCodeGeneratorsNode;
End;

end.
