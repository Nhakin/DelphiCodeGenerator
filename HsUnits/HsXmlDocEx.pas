unit HsXmlDocEx;

interface

Uses SysUtils, XmlDom, XmlDoc, XmlIntf, HsInterfaceEx;

Type
  IXmlNodeEx = Interface;

  IXmlNodeCollectionEx = Interface(IXmlNodeCollection)
    ['{A657BDB8-9BAC-4E8F-8FD7-E4E0F914D805}']

  End;

  IXmlNodeListEx = Interface(IXmlNodeList)
    ['{4B61686E-29A0-2112-B0F9-AC06CC566B8A}']
    Function GetNode(Const IndexOrName: OleVariant) : IXmlNodeEx;

    Function First() : IXmlNodeEx;
    Function Last() : IXmlNodeEx;
    
    Property Nodes[Const IndexOrName: OleVariant] : IXmlNodeEx Read GetNode; Default;

  End;

  IXmlDocumentEx = Interface(IXmlDocument)
    ['{4B61686E-29A0-2112-BEBE-F039CC566B87}']
    Function GetDocumentElement() : IXmlNodeEx;
    Procedure SetDocumentElement(Const Value : IXmlNodeEx);
    Function GetDocumentNode() : IXmlNodeEx;
    Function GetChildNodes() : IXmlNodeListEx;

    Function SelectNode(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeEx;
    Function SelectNodes(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeListEx;

    Property DocumentElement : IXmlNodeEx     Read GetDocumentElement Write SetDocumentElement;
    Property Node            : IXmlNodeEx     Read GetDocumentNode;
    Property ChildNodes      : IXmlNodeListEx Read GetChildNodes;
  End;

  IXmlNodeEx = Interface(IXmlNode)
    ['{4B61686E-29A0-2112-B94C-F039CC566B87}']
    Function GetChildNodes() : IXmlNodeListEx;
    Function GetAttributeNodes() : IXmlNodeListEx;
    Function GetOwnerDocument() : IXmlDocumentEx;
    Function GetParentNode() : IXmlNodeEx;

    Function PreviousSibling() : IXmlNodeEx;
    Function NextSibling() : IXmlNodeEx;

    Property ChildNodes     : IXmlNodeListEx Read GetChildNodes;
    Property AttributeNodes : IXmlNodeListEx Read GetAttributeNodes;
    Property OwnerDocument  : IXmlDocumentEx Read GetOwnerDocument;
    property ParentNode     : IXmlNodeEx     Read GetParentNode;

    Function  GetAsString() : String;
    Procedure SetAsString(Const AString : String);

    Function  GetAsByte() : Byte;
    Procedure SetAsByte(Const AByte : Byte);

    Function  GetAsInteger() : Integer;
    Procedure SetAsInteger(Const AInteger : Integer);

    Function  GetAsFloat() : Double;
    Procedure SetAsFloat(Const AFloat : Double);

    Function  GetAsCurrency() : Currency;
    Procedure SetAsCurrency(Const ACurrency : Currency);

    Function  GetAsBoolean() : Boolean;
    Procedure SetAsBoolean(Const ABoolean : Boolean);

    Function  GetAsDateTime() : TDateTime;
    Procedure SetAsDateTime(Const ADateTime : TDateTime);

    Property AsString   : String    Read GetAsString   Write SetAsString;
    Property AsByte     : Byte      Read GetAsByte     Write SetAsByte;
    Property AsInteger  : Integer   Read GetAsInteger  Write SetAsInteger;
    Property AsFloat    : Double    Read GetAsFloat    Write SetAsFloat;
    Property AsCurrency : Currency  Read GetAsCurrency Write SetAsCurrency;
    Property AsBoolean  : Boolean   Read GetAsBoolean  Write SetAsBoolean;
    Property AsDateTime : TDateTime Read GetAsDateTime Write SetAsDateTime;

  End;

  TXmlDocumentEx = Class(TXmlDocument, IXmlDocumentEx)
  Private
    FDocumentNode : IXMLNodeEx;

  Protected
    Function GetDocumentElement() : IXmlNodeEx; OverLoad;
    Procedure SetDocumentElement(Const Value : IXmlNodeEx); OverLoad;
    Function GetDocumentNode() : IXmlNodeEx; OverLoad;
    Function GetChildNodes() : IXmlNodeListEx; OverLoad;

    Function SelectNode(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeEx;
    Function SelectNodes(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeListEx;

    Property DocumentElement : IXmlNodeEx Read GetDocumentElement Write SetDocumentElement;
    Property Node            : IXmlNodeEx Read GetDocumentNode;
    Property ChildNodes      : IXmlNodeListEx Read GetChildNodes;

  End;

  TXmlNodeEx = Class(TXmlNode, IInterfaceEx, IXmlNodeEx)
  Private
    FFmtSettings : TFormatSettings;

  Protected //TXmlNode
    Function CreateChildList() : IXMLNodeList; OverRide;
    Function CreateAttributeList() : IXMLNodeList; OverRide;
    Function CreateChildNode(Const ADOMNode: IDOMNode) : IXMLNode; OverRide;
    Function CreateAttributeNode(const ADOMNode: IDOMNode): IXMLNode; OverRide;

  Protected //IInterfaceEx
    Function IsImplementorOf(Const I : IInterfaceEx) : Boolean;

    Function GetInterfaceObject() : TObject;
    Function GetRefCount() : Integer;
    Function GetController() : IInterfaceEx;

    Function  GetIsContained() : Boolean;
    Procedure SetIsContained(Const AIsContained : Boolean);

    Function  GetHaveRefCount() : Boolean;
    Procedure SetHaveRefCount(Const AHaveRefCount : Boolean);

  Protected //IXmlNodeEx
    Function GetChildNodes() : IXMLNodeListEx; OverLoad; Virtual;
    Function GetAttributeNodes() : IXMLNodeListEx; OverLoad; Virtual;
    Function GetOwnerDocument() : IXmlDocumentEx; OverLoad; Virtual;
    Function GetParentNode() : IXmlNodeEx; OverLoad; Virtual;

    Function PreviousSibling() : IXmlNodeEx; OverLoad;
    Function NextSibling() : IXmlNodeEx; OverLoad;

    Function  GetAsString() : String; Virtual;
    Procedure SetAsString(Const AString : String); Virtual;

    Function  GetAsByte() : Byte;
    Procedure SetAsByte(Const AByte : Byte);

    Function  GetAsInteger() : Integer; Virtual;
    Procedure SetAsInteger(Const AInteger : Integer); Virtual;

    Function  GetAsFloat() : Double; Virtual;
    Procedure SetAsFloat(Const AFloat : Double); Virtual;

    Function  GetAsCurrency() : Currency; Virtual;
    Procedure SetAsCurrency(Const ACurrency : Currency); Virtual;

    Function  GetAsBoolean() : Boolean; Virtual;
    Procedure SetAsBoolean(Const ABoolean : Boolean); Virtual;

    Function  GetAsDateTime() : TDateTime; Virtual;
    Procedure SetAsDateTime(Const ADateTime : TDateTime); Virtual;

    Property NodeValue      : OleVariant     Read GetNodeValue Write SetNodeValue;
    Property ChildNodes     : IXmlNodeListEx Read GetChildNodes;
    Property AttributeNodes : IXmlNodeListEx Read GetAttributeNodes;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlNodeListEx = Class(TXmlNodeList, IXmlNodeListEx)
  Protected
    Function GetNode(Const IndexOrName: OleVariant) : IXmlNodeEx; OverLoad;
    Function First() : IXmlNodeEx; OverLoad;
    Function Last() : IXmlNodeEx; OverLoad;

  End;

  TXMLNodeCollectionEx = Class(TXmlNodeCollection, IInterfaceEx, IXmlNodeEx, IXmlNodeCollectionEx)
  Private
    FIntfEx : TInterfaceExImplementor;

    Function GetImplementor() : TInterfaceExImplementor;

  Protected
    Function CreateChildNode(Const ADOMNode: IDOMNode) : IXMLNode; OverRide;

    Function  GetAsString() : String; Virtual; Abstract;
    Procedure SetAsString(Const AString : String); Virtual; Abstract;

    Function  GetAsByte() : Byte; Virtual; Abstract;
    Procedure SetAsByte(Const AByte : Byte); Virtual; Abstract;

    Function  GetAsInteger() : Integer; Virtual; Abstract;
    Procedure SetAsInteger(Const AInteger : Integer); Virtual; Abstract;

    Function  GetAsFloat() : Double; Virtual; Abstract;
    Procedure SetAsFloat(Const AFloat : Double); Virtual; Abstract;

    Function  GetAsCurrency() : Currency; Virtual; Abstract;
    Procedure SetAsCurrency(Const ACurrency : Currency); Virtual; Abstract;

    Function  GetAsBoolean() : Boolean; Virtual; Abstract;
    Procedure SetAsBoolean(Const ABoolean : Boolean); Virtual; Abstract;

    Function  GetAsDateTime() : TDateTime; Virtual; Abstract;
    Procedure SetAsDateTime(Const ADateTime : TDateTime); Virtual; Abstract;

  Protected
    Property IntfExImpl : TInterfaceExImplementor Read GetImplementor Implements IInterfaceEx;

    Function GetChildNodes() : IXMLNodeListEx; OverLoad; Virtual;
    Function GetAttributeNodes() : IXMLNodeListEx; OverLoad; Virtual;
    Function GetOwnerDocument() : IXmlDocumentEx; OverLoad; Virtual;
    Function GetParentNode() : IXmlNodeEx; OverLoad; Virtual;

    Function PreviousSibling() : IXmlNodeEx; OverLoad;
    Function NextSibling() : IXmlNodeEx; OverLoad;

  End;

Function FormatXMLData(Const AXmlData : DOMString) : DOMString;
Function LoadXMLData(Const AXmlData : DOMString) : IXmlDocumentEx;
Function LoadXMLDocument(Const FileName : DOMString): IXmlDocumentEx;
Function NewXMLDocument(Version : DOMString = '1.0') : IXmlDocumentEx;

implementation

Uses Dialogs,
  XSBuiltIns, Variants;

Function FormatXMLData(Const AXmlData : DOMString) : DOMString;
Begin
  Result := XmlDoc.FormatXMLData(AXmlData);
End;

Function LoadXMLData(Const AXmlData : DOMString) : IXmlDocumentEx;
Begin
  Result := TXmlDocumentEx.Create(Nil);
  Result.LoadFromXML(AXmlData);
End;

Function LoadXMLDocument(Const FileName : DOMString) : IXmlDocumentEx;
Begin
  Result := TXmlDocumentEx.Create(FileName);
End;

Function NewXMLDocument(Version : DOMString = '1.0') : IXmlDocumentEx;
Begin
  Result := TXmlDocumentEx.Create(nil);
  Result.Active := True;
  If Version <> '' Then
    Result.Version := Version;
End;

{$Hints Off}
Type
  TXmlDocumentAccess = Class(TXmlDocument);
  TXmlNodeAccess = Class(TXmlNode);

  TXmlNodeHack = Class(TInterfacedObject)
  Private
    FAttributeNodes    : IXMLNodeList;
    FChildNodes        : IXMLNodeList;
    FChildNodeClasses  : TNodeClassArray;

  End;
{$Hints On}

Function TXmlDocumentEx.GetDocumentNode() : IXmlNodeEx;
Var
  DocNodeObject : TXMLNodeEx;
Begin
  CheckActive();
  If Not Assigned(FDocumentNode) Then
  Begin
    DocNodeObject := TXMLNodeEx.Create(DOMDocument, Nil, Self);
    FDocumentNode := DocNodeObject;
    TXmlNodeHack(DocNodeObject).FChildNodeClasses := InHerited DocBindingInfo;
  End;

  Result := FDocumentNode;
End;

Function TXmlDocumentEx.GetChildNodes() : IXmlNodeListEx;
Begin
  Result := Node.ChildNodes As IXmlNodeListEx;
End;

Function TXmlDocumentEx.GetDocumentElement() : IXmlNodeEx;
Begin
  CheckActive();
  Result := Nil;
  If Node.HasChildNodes Then
  Begin
    Result := Node.ChildNodes.Last;
    While Assigned(Result) And (Result.NodeType <> ntElement) Do
      Result := Result.PreviousSibling();
  End;
End;

Procedure TXmlDocumentEx.SetDocumentElement(Const Value : IXmlNodeEx);
Var OldDocElement : IXmlNodeEx;
Begin
  CheckActive();
  OldDocElement := GetDocumentElement();
  If Assigned(OldDocElement) Then
    Node.ChildNodes.ReplaceNode(OldDocElement, Value)
  Else
    Node.ChildNodes.Add(Value);
End;

{
  https://msdn.microsoft.com/en-us/library/ms256122.aspx
}
Function TXmlDocumentEx.SelectNode(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeEx;
Var lList : IXmlNodeListEx;
Begin
  lList := SelectNodes(ANodePath, ARoot);
  If Assigned(lList) And (lList.Count > 0) Then
    Result := lList[0]
  Else
    Result := Nil;
End;

Function TXmlDocumentEx.SelectNodes(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeListEx;
Var intfSelect : IDomNodeSelect;
    intfAccess : IXmlNodeAccess;
    dnlResult  : IDomNodeList;
    X          : Integer;
Begin
  Result := Nil;

  If Not Assigned(ARoot) Then
    ARoot := DocumentElement;

  If Supports(ARoot, IXmlNodeAccess, intfAccess) And
     Supports(ARoot.DOMNode, IDomNodeSelect, intfSelect) Then
  Begin
    dnlResult := intfSelect.SelectNodes(ANodePath);

    If Assigned(dnlResult) Then
    Begin
      Result := TXmlNodeListEx.Create(intfAccess.GetNodeObject, '', Nil);

      For X := 0 To dnlResult.Length - 1 Do
        Result.Add(TXmlNodeEx.Create(dnlResult.Item[X], Nil, Self));
    End;
  End;
End;

Procedure TXmlNodeEx.AfterConstruction();
Begin
  InHerited AfterConstruction();

  GetLocaleFormatSettings(0, FFmtSettings);

  FFmtSettings.ThousandSeparator := #0;
  FFmtSettings.DecimalSeparator := '.';
End;

Function TXmlNodeEx.CreateChildList() : IXMLNodeList;
Var X       : Integer;
    lResult : TXmlNodeListEx;
Begin
  lResult := TXmlNodeListEx.Create(Self, GetNamespaceURI, ChildListNotify);
  For X := 0 To DOMNode.ChildNodes.Length - 1 Do
    lResult.List.Add(CreateChildNode(DOMNode.ChildNodes[X]));

  Result := lResult;
End;

Function TXmlNodeEx.CreateAttributeList() : IXMLNodeList;
Var X       : Integer;
    lResult : TXmlNodeListEx;
Begin
  lResult := TXMLNodeListEx.Create(Self, '', AttributeListNotify);
  If Assigned(DOMNode.Attributes) Then
    For X := 0 To DOMNode.Attributes.Length - 1 Do
      lResult.List.Add(CreateAttributeNode(DOMNode.Attributes[X]));

  Result := lResult;
End;

Function TXmlNodeEx.CreateChildNode(Const ADOMNode: IDOMNode) : IXMLNode;
Var X : Integer;
    lChildNodeClass: TXMLNodeClass;
Begin
  If Assigned(HostNode) Then
    Result := TXmlNodeAccess(HostNode).CreateChildNode(ADOMNode)
  Else
  Begin
    lChildNodeClass := TXmlDocumentAccess(OwnerDocument).GetChildNodeClass(ADOMNode);

    If lChildNodeClass = Nil Then
    Begin
      lChildNodeClass := TXMLNodeEx;

      For X := 0 to Length(ChildNodeClasses) - 1 Do
        With ChildNodeClasses[X] Do
          If NodeMatches(ADOMNode, NodeName, NamespaceURI) Then
          Begin
            lChildNodeClass := NodeClass;
            Break;
          End;
    End;

    Result := lChildNodeClass.Create(ADOMNode, Self, OwnerDocument);
  End;
End;

Function TXmlNodeEx.CreateAttributeNode(Const ADOMNode: IDOMNode) : IXMLNode;
Begin
  Result := TXMLNodeEx.Create(ADOMNode, Nil, OwnerDocument)
End;

Function TXmlNodeEx.IsImplementorOf(Const I : IInterfaceEx) : Boolean;
Begin
  Result := I.InterfaceObject = Self;
End;

Function TXmlNodeEx.GetInterfaceObject() : TObject;
Begin
  Result := Self;
End;

Function TXmlNodeEx.GetRefCount() : Integer;
Begin
  Result := InHerited RefCount;
End;

Function TXmlNodeEx.GetController() : IInterfaceEx;
Begin
  Result := Nil;
End;

Function TXmlNodeEx.GetIsContained() : Boolean;
Begin
  Result := False;
End;

Procedure TXmlNodeEx.SetIsContained(Const AIsContained : Boolean);
Begin

End;

Function TXmlNodeEx.GetHaveRefCount() : Boolean;
Begin
  Result := True;
End;

Procedure TXmlNodeEx.SetHaveRefCount(Const AHaveRefCount : Boolean);
Begin

End;

Function TXmlNodeEx.GetChildNodes() : IXMLNodeListEx;
Begin
  Result := InHerited GetChildNodes() As IXmlNodeListEx;
End;

Function TXmlNodeEx.GetAttributeNodes() : IXMLNodeListEx;
Begin
  Result := InHerited GetAttributeNodes() As IXmlNodeListEx;
End;

Function TXmlNodeEx.GetOwnerDocument() : IXmlDocumentEx;
Begin
  If Assigned(OwnerDocument) Then
    OwnerDocument.GetInterface(IXmlDocumentEx, Result);
End;

Function TXmlNodeEx.GetParentNode() : IXmlNodeEx;
Begin
  Result := InHerited GetParentNode() As IXmlNodeEx;
End;

Function TXmlNodeEx.PreviousSibling() : IXmlNodeEx;
Begin
  Result := InHerited PreviousSibling() As IXmlNodeEx;
End;

Function TXmlNodeEx.NextSibling() : IXmlNodeEx;
Begin
  Result := InHerited NextSibling() As IXmlNodeEx;
End;

Function TXmlNodeEx.GetAsString() : String;
Begin
  Result := GetText();
End;

Procedure TXmlNodeEx.SetAsString(Const AString : String);
Begin
  NodeValue := AString;
End;

Function TXmlNodeEx.GetAsByte() : Byte;
Begin
  If VarIsNull(NodeValue) Then
    Result := 0
  Else
    Result := NodeValue;
End;

Procedure TXmlNodeEx.SetAsByte(Const AByte : Byte);
Begin
  NodeValue := AByte;
End;

Function TXmlNodeEx.GetAsInteger() : Integer;
Begin
  If VarIsNull(NodeValue) Then
    Result := 0
  Else
    Result := NodeValue;
End;

Procedure TXmlNodeEx.SetAsInteger(Const AInteger : Integer);
Begin
  NodeValue := AInteger;
End;

Function TXmlNodeEx.GetAsFloat() : Double;
Begin
  If VarIsNull(NodeValue) Then
    Result := 0
  Else
  Begin
    If Not TryStrToFloat(NodeValue, Result, FFmtSettings) Then
      Raise Exception.Create('Invalid floating point value.');
  End;
End;

Procedure TXmlNodeEx.SetAsFloat(Const AFloat : Double);
Begin
  NodeValue := AFloat;
End;

Function TXmlNodeEx.GetAsCurrency() : Currency;
Begin
  Result := GetAsFloat();
End;

Procedure TXmlNodeEx.SetAsCurrency(Const ACurrency : Currency);
Begin
  NodeValue := ACurrency;
End;

Function TXmlNodeEx.GetAsBoolean() : Boolean;
Begin
  If VarIsNull(NodeValue) Then
    Result := False
  Else If VarIsStr(NodeValue) Then
    Result := StrToBoolDef(NodeValue, False)
  Else If VarIsNumeric(NodeValue) Then
    Result := NodeValue <> 0
  Else
    Raise Exception.Create('Invalid data type ' + IntToStr(VarType(NodeValue)) + '.');
End;

Procedure TXmlNodeEx.SetAsBoolean(Const ABoolean : Boolean);
Begin
  NodeValue := ABoolean;
End;

Function TXmlNodeEx.GetAsDateTime() : TDateTime;
Begin
  If VarIsNull(NodeValue) Then
    Result := 0
  Else
  Begin
    With TXSDateTime.Create() Do
    Try
      XSToNative(ChildNodes['OrderDate'].NodeValue);
      Result := AsDateTime;

      Finally
        Free();
    End;
  End;
End;

Procedure TXmlNodeEx.SetAsDateTime(Const ADateTime : TDateTime);
Begin
  With TXSDateTime.Create() Do
  Try
    AsDateTime := ADateTime;
    NodeValue := NativeToXS;

    Finally
      Free();
  End;
End;

(******************************************************************************)

Function TXmlNodeListEx.GetNode(Const IndexOrName: OleVariant) : IXmlNodeEx;
Begin
  Result := InHerited GetNode(IndexOrName) As IXmlNodeEx;
End;

Function TXmlNodeListEx.First() : IXmlNodeEx;
Begin
  Result := InHerited First() As IXmlNodeEx;
End;

Function TXmlNodeListEx.Last() : IXmlNodeEx;
Begin
  Result := InHerited Last() As IXmlNodeEx;
End;

Function TXMLNodeCollectionEx.CreateChildNode(Const ADOMNode: IDOMNode) : IXMLNode;
Var X : Integer;
    lChildNodeClass: TXMLNodeClass;
Begin
  If Assigned(HostNode) Then
    Result := TXmlNodeAccess(HostNode).CreateChildNode(ADOMNode)
  Else
  Begin
    lChildNodeClass := TXmlDocumentAccess(OwnerDocument).GetChildNodeClass(ADOMNode);

    If lChildNodeClass = Nil Then
    Begin
      lChildNodeClass := TXMLNodeEx;

      For X := 0 to Length(ChildNodeClasses) - 1 Do
        With ChildNodeClasses[X] Do
          If NodeMatches(ADOMNode, NodeName, NamespaceURI) Then
          Begin
            lChildNodeClass := NodeClass;
            Break;
          End;
    End;

    Result := lChildNodeClass.Create(ADOMNode, Self, OwnerDocument);
  End;
End;

Function TXMLNodeCollectionEx.GetImplementor() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfEx) Then
    FIntfEx := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfEx;
End;

Function TXMLNodeCollectionEx.GetChildNodes() : IXMLNodeListEx;
Begin
  Result := InHerited GetChildNodes() As IXmlNodeListEx;
End;

Function TXMLNodeCollectionEx.GetAttributeNodes() : IXMLNodeListEx;
Begin
  Result := InHerited GetAttributeNodes() As IXmlNodeListEx;
End;

Function TXMLNodeCollectionEx.GetOwnerDocument() : IXmlDocumentEx;
Begin
  If Assigned(OwnerDocument) Then
    OwnerDocument.GetInterface(IXmlDocumentEx, Result);
End;

Function TXMLNodeCollectionEx.GetParentNode() : IXmlNodeEx;
Begin
  Result := InHerited GetParentNode() As IXmlNodeEx;
End;

Function TXMLNodeCollectionEx.PreviousSibling() : IXmlNodeEx;
Begin
  Result := InHerited PreviousSibling() As IXmlNodeEx;
End;

Function TXMLNodeCollectionEx.NextSibling() : IXmlNodeEx;
Begin
  Result := InHerited NextSibling() As IXmlNodeEx;
End;

end.
