unit GlobalOptions.Xml;

interface

Uses
  XmlDoc, HsInterfaceEx, HsXmlDocEx;

Type
  IXmlMRUItem = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-A0F7-D4B530D0EAA0}']
    Function  GetPathId() : Integer;
    Procedure SetPathId(Const APathId : Integer);

    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Property PathId   : Integer Read GetPathId   Write SetPathId;
    Property FileName : String  Read GetFileName Write SetFileName;

  End;

  IXmlMRUItems = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-9990-C1A2B67FAA88}']
    Function GetItem(Const Index : Integer) : IXmlMRUItem;

    Function Add() : IXmlMRUItem;
    Function Insert(Const Index: Integer) : IXmlMRUItem;

    Property Items[Const Index: Integer] : IXmlMRUItem Read GetItem; Default;

  End;

  IXmlGlobalOptions = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-AF9B-C0D2401D1273}']
    Function  GetInterfaceState() : TInterfaceState;

    Function  GetWindowState() : Byte;
    Procedure SetWindowState(Const AWindowState : Byte);

    Function  GetTop() : Integer;
    Procedure SetTop(Const ATop : Integer);

    Function  GetLeft() : Integer;
    Procedure SetLeft(Const ALeft : Integer);

    Function  GetHeight() : Integer;
    Procedure SetHeight(Const AHeight : Integer);

    Function  GetWidth() : Integer;
    Procedure SetWidth(Const AWidth : Integer);

    Function  GetTreeViewWidth() : Integer;
    Procedure SetTreeViewWidth(Const ATreeViewWidth : Integer);

    Function  GetTreeViewColWidth() : Integer;
    Procedure SetTreeViewColWidth(Const ATreeViewColWith : Integer);

    Function  GetMRUMaxItem() : Byte;
    Procedure SetMRUMaxItem(Const AMRUMaxItem : Byte);

    Function  GetMRUList() : IXmlMRUItems;

    Function  GetReopenLastFile() : Boolean;
    Procedure SetReopenLastFile(Const AReopenLastFile : Boolean);

    Function  GetLastOpenedFile() : String;
    Procedure SetLastOpenedFile(Const ALastOpenedFile : String);

    Function  GetSkinName() : String;
    Procedure SetSkinName(Const ASkinName : String);

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property InterfaceState   : TInterfaceState Read GetInterfaceState;
    Property WindowState      : Byte            Read GetWindowState      Write SetWindowState;
    Property Top              : Integer         Read GetTop              Write SetTop;
    Property Left             : Integer         Read GetLeft             Write SetLeft;
    Property Height           : Integer         Read GetHeight           Write SetHeight;
    Property Width            : Integer         Read GetWidth            Write SetWidth;
    Property TreeViewWidth    : Integer         Read GetTreeViewWidth    Write SetTreeViewWidth;
    Property TreeViewColWidth : Integer         Read GetTreeViewColWidth Write SetTreeViewColWidth;
    Property MRUMaxItem       : Byte            Read GetMRUMaxItem       Write SetMRUMaxItem;
    Property MRUList          : IXmlMRUItems    Read GetMRUList;
    Property ReopenLastFile   : Boolean         Read GetReopenLastFile   Write SetReopenLastFile;
    Property LastOpenedFile   : String          Read GetLastOpenedFile   Write SetLastOpenedFile;
    Property SkinName         : String          Read GetSkinName         Write SetSkinName;

  End;

  TXmlGlobalOptions = Class(TObject)
  Public
    Class Function XmlNodeClass() : TXmlNodeClass;
    Class Function CreateGlobalOptions() : IXmlGlobalOptions; OverLoad;
    Class Function CreateGlobalOptions(Const AXmlString : String) : IXmlGlobalOptions; OverLoad;

  End;

implementation

Uses Dialogs,
  SysUtils, Classes, RtlConsts, XmlIntf, GlobalOptionsIntf, HsStringListEx;

Type
  TXmlMRUItem = Class(TXmlNodeEx, IXmlMRUItem)
  Protected
    Function  GetPathId() : Integer;
    Procedure SetPathId(Const APathId : Integer);

    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String); 

  End;

  TXmlMRUItems = Class(TXMLNodeCollectionEx, IXmlMRUItems)
  Protected
    Function GetItem(Const Index : Integer) : IXmlMRUItem;

    Function Add() : IXmlMRUItem;
    Function Insert(Const Index : Integer) : IXmlMRUItem;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlGlobalOptionsImpl = Class(TXmlNodeEx, IGlobalOptions, IXmlGlobalOptions)
  Private
    FGlobalOptionsImpl : Pointer;
    FInterfaceState    : TInterfaceState;

    Function GetGlobalOptionsImpl() : IGlobalOptions;

  Protected
    Property GlobalOptionsImpl : IGlobalOptions Read GetGlobalOptionsImpl;

    Function  GetInterfaceState() : TInterfaceState;

    Function  GetWindowState() : Byte;
    Procedure SetWindowState(Const AWindowState : Byte); 

    Function  GetTop() : Integer; 
    Procedure SetTop(Const ATop : Integer); 

    Function  GetLeft() : Integer; 
    Procedure SetLeft(Const ALeft : Integer); 

    Function  GetHeight() : Integer; 
    Procedure SetHeight(Const AHeight : Integer); 

    Function  GetWidth() : Integer; 
    Procedure SetWidth(Const AWidth : Integer); 

    Function  GetTreeViewWidth() : Integer; 
    Procedure SetTreeViewWidth(Const ATreeViewWidth : Integer); 

    Function  GetTreeViewColWidth() : Integer;
    Procedure SetTreeViewColWidth(Const ATreeViewColWidth : Integer);

    Function  GetMRUMaxItem() : Byte; 
    Procedure SetMRUMaxItem(Const AMRUMaxItem : Byte); 

    Function  GetMRUList() : IXmlMRUItems;

    Function  MyGetMRUList() : IHsStringListEx;
    Procedure MySetMRUList(AMRUList : IHsStringListEx);

    Function  IGlobalOptions.GetMRUList = MyGetMRUList;
    Procedure IGlobalOptions.SetMRUList = MySetMRUList;

    Function  GetReopenLastFile() : Boolean;
    Procedure SetReopenLastFile(Const AReopenLastFile : Boolean);

    Function  GetLastOpenedFile() : String;
    Procedure SetLastOpenedFile(Const ALastOpenedFile : String);

    Function  GetSkinName() : String;
    Procedure SetSkinName(Const ASkinName : String);

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TXmlGlobalOptions.XmlNodeClass() : TXmlNodeClass;
Begin
  Result := TXmlGlobalOptionsImpl;
End;

Class Function TXmlGlobalOptions.CreateGlobalOptions() : IXmlGlobalOptions;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.Options := lXml.Options + [doNodeAutoIndent];
  Result := (lXml As IXmlDocumentEx).GetDocBinding('GlobalOptions', TXmlGlobalOptionsImpl) As IXmlGlobalOptions;
End;

Class Function TXmlGlobalOptions.CreateGlobalOptions(Const AXmlString : String) : IXmlGlobalOptions;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.Options := lXml.Options + [doNodeAutoIndent];
  lXml.LoadFromXML(AXmlString);
  Result := (lXml As IXmlDocumentEx).GetDocBinding('GlobalOptions', TXmlGlobalOptionsImpl) As IXmlGlobalOptions;
End;

(******************************************************************************)

Function TXmlMRUItem.GetPathId() : Integer;
Begin
  Result := ChildNodes['PathId'].AsInteger;
End;

Procedure TXmlMRUItem.SetPathId(Const APathId : Integer);
Begin
  ChildNodes['PathId'].AsInteger := APathId;
End;

Function TXmlMRUItem.GetFileName() : String;
Begin
  Result := ChildNodes['FileName'].AsString;
End;

Procedure TXmlMRUItem.SetFileName(Const AFileName : String);
Begin
  ChildNodes['FileName'].AsString := AFileName;
End;

Procedure TXmlMRUItems.AfterConstruction();
Begin
  RegisterChildNode('MRUItem', TXmlMRUItem);
  ItemTag       := 'MRUItem';
  ItemInterface := IXmlMRUItem;

  InHerited AfterConstruction();
End;

Function TXmlMRUItems.GetItem(Const Index : Integer) : IXmlMRUItem;
Begin
  Result := List[Index] As IXmlMRUItem;
End;

Function TXmlMRUItems.Add() : IXmlMRUItem;
Begin
  Result := AddItem(-1) As IXmlMRUItem;
End;

Function TXmlMRUItems.Insert(Const Index : Integer) : IXmlMRUItem;
Begin
  Result := AddItem(Index) As IXmlMRUItem;
End;

Procedure TXmlGlobalOptionsImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState := isCreating;

  RegisterChildNode('MRUList', TXmlMRUItems);

  FGlobalOptionsImpl := Pointer(IGlobalOptions(Self));
End;

Procedure TXmlGlobalOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (IGlobalOptions(FGlobalOptionsImpl) <> IGlobalOptions(Self)) And
     (IGlobalOptions(FGlobalOptionsImpl).InterfaceState <> isDestroying) Then
    With GlobalOptionsImpl Do
    Begin
      WindowState       := ChildNodes['WindowState'].AsByte;
      Top               := ChildNodes['Top'].AsInteger;
      Left              := ChildNodes['Left'].AsInteger;
      Height            := ChildNodes['Height'].AsInteger;
      Width             := ChildNodes['Width'].AsInteger;
      TreeViewWidth     := ChildNodes['TreeViewWidth'].AsInteger;
      TreeViewColWidth  := ChildNodes['TreeViewColWidth'].AsInteger;
      MRUMaxItem        := ChildNodes['MRUMaxItem'].AsByte;
      MRUList.CommaText := MyGetMRUList().CommaText;
      ReOpenLastFile    := ChildNodes['ReOpenLastFile'].AsBoolean;
      LastOpenedFile    := ChildNodes['LastOpenedFile'].AsString;
      SkinName          := ChildNodes['SkinName'].AsString;
    End;

  InHerited BeforeDestruction();
End;

Function TXmlGlobalOptionsImpl.GetGlobalOptionsImpl() : IGlobalOptions;
Begin
  Result := IGlobalOptions(FGlobalOptionsImpl);
End;

Function TXmlGlobalOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TXmlGlobalOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IGlobalOptions;
    lLst : IHsStringListEx;
    X    : Integer;
Begin
  If Supports(ASource, IGlobalOptions, lSrc) Then
  Begin
    ChildNodes['WindowState'].NodeValue      := lSrc.WindowState;
    ChildNodes['Top'].NodeValue              := lSrc.Top;
    ChildNodes['Left'].NodeValue             := lSrc.Left;
    ChildNodes['Height'].NodeValue           := lSrc.Height;
    ChildNodes['Width'].NodeValue            := lSrc.Width;
    ChildNodes['TreeViewWidth'].NodeValue    := lSrc.TreeViewWidth;
    ChildNodes['TreeViewColWidth'].NodeValue := lSrc.TreeViewColWidth;
    ChildNodes['MRUMaxItem'].NodeValue       := lSrc.MRUMaxItem;

    lLst := THsStringListEx.CreateList();
    Try
      lLst.CaseSensitive := False;
      lLst.Sorted := True;
      lLst.Duplicates := dupIgnore;

      For X := 0 To lSrc.MRUList.Count - 1 Do
        If lLst.IndexOf(ExtractFilePath(lSrc.MRUList[X])) = -1 Then
          lLst.Add(ExtractFilePath(lSrc.MRUList[X]));

      ChildNodes['MRUPathList'].NodeValue := lLst.CommaText;

      With GetMruList() Do
        For X := 0 To lSrc.MRUList.Count - 1 Do
          With Add() Do
          Begin
            PathId   := lLst.IndexOf(ExtractFilePath(lSrc.MRUList[X]));
            FileName := ExtractFileName(lSrc.MRUList[X]);
          End;

      Finally
        lLst := Nil;
    End;

//    ChildNodes['MRUList'].NodeValue          := lSrc.MRUList.CommaText;
    ChildNodes['ReOpenLastFile'].NodeValue   := lSrc.ReopenLastFile;
    ChildNodes['LastOpenedFile'].NodeValue   := lSrc.LastOpenedFile;
    ChildNodes['SkinName'].NodeValue         := lSrc.SkinName;

    If ASyncSource Then
      FGlobalOptionsImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlGlobalOptionsImpl.GetWindowState() : Byte;
Begin
  Result := ChildNodes['WindowState'].AsInteger;
End;

Procedure TXmlGlobalOptionsImpl.SetWindowState(Const AWindowState : Byte);
Begin
  ChildNodes['WindowState'].AsInteger := AWindowState;
End;

Function TXmlGlobalOptionsImpl.GetTop() : Integer;
Begin
  Result := ChildNodes['Top'].AsInteger;
End;

Procedure TXmlGlobalOptionsImpl.SetTop(Const ATop : Integer);
Begin
  ChildNodes['Top'].AsInteger := ATop;
End;

Function TXmlGlobalOptionsImpl.GetLeft() : Integer;
Begin
  Result := ChildNodes['Left'].AsInteger;
End;

Procedure TXmlGlobalOptionsImpl.SetLeft(Const ALeft : Integer);
Begin
  ChildNodes['Left'].AsInteger := ALeft;
End;

Function TXmlGlobalOptionsImpl.GetHeight() : Integer;
Begin
  Result := ChildNodes['Height'].AsInteger;
End;

Procedure TXmlGlobalOptionsImpl.SetHeight(Const AHeight : Integer);
Begin
  ChildNodes['Height'].AsInteger := AHeight;
End;

Function TXmlGlobalOptionsImpl.GetWidth() : Integer;
Begin
  Result := ChildNodes['Width'].AsInteger;
End;

Procedure TXmlGlobalOptionsImpl.SetWidth(Const AWidth : Integer);
Begin
  ChildNodes['Width'].AsInteger := AWidth;
End;

Function TXmlGlobalOptionsImpl.GetTreeViewWidth() : Integer;
Begin
  Result := ChildNodes['TreeViewWidth'].AsInteger;
End;

Procedure TXmlGlobalOptionsImpl.SetTreeViewWidth(Const ATreeViewWidth : Integer);
Begin
  ChildNodes['TreeViewWidth'].AsInteger := ATreeViewWidth;
End;

Function TXmlGlobalOptionsImpl.GetTreeViewColWidth() : Integer;
Begin
  Result := ChildNodes['TreeViewColWidth'].AsInteger;
End;

Procedure TXmlGlobalOptionsImpl.SetTreeViewColWidth(Const ATreeViewColWidth : Integer);
Begin
  ChildNodes['TreeViewColWidth'].AsInteger := ATreeViewColWidth;
End;

Function TXmlGlobalOptionsImpl.GetMRUMaxItem() : Byte;
Begin
  Result := ChildNodes['MRUMaxItem'].AsInteger;
End;

Procedure TXmlGlobalOptionsImpl.SetMRUMaxItem(Const AMRUMaxItem : Byte);
Begin
  ChildNodes['MRUMaxItem'].AsInteger := AMRUMaxItem;
End;

Function TXmlGlobalOptionsImpl.GetMRUList() : IXmlMRUItems;
Begin
  Result := ChildNodes['MRUList'] As IXmlMRUItems;
End;

Function TXmlGlobalOptionsImpl.MyGetMRUList() : IHsStringListEx;
Var lLstPath : IHsStringListEx;
    lLstMru  : IHsStringListEx;
    X        : Integer;
    lPathId  : Integer;
Begin
  Result := THsStringListEx.CreateList();

  lLstPath := THsStringListEx.CreateList();
  lLstMru  := THsStringListEx.CreateList();
  Try
    lLstPath.CommaText := ChildNodes['MRUPathList'].AsString;

    With LoadXMLData(ChildNodes['MRUList'].Xml).ChildNodes['MRUList'] Do
      For X := 0 To ChildNodes.Count - 1 Do
      Begin
        lPathId := ChildNodes[X].ChildNodes['PathId'].AsInteger;
        lLstMru.Add(lLstPath[lPathId] + ChildNodes[X].ChildNodes['FileName'].AsString);
      End;

    Result.CommaText := lLstMru.CommaText;

    Finally
      lLstPath := Nil;
      lLstMru  := Nil;
  End;
End;

Procedure TXmlGlobalOptionsImpl.MySetMRUList(AMRUList : IHsStringListEx);
Begin
  ChildNodes['MRUList'].AsString := AMRUList.CommaText;
End;

Function TXmlGlobalOptionsImpl.GetReopenLastFile() : Boolean;
Begin
  Result := ChildNodes['ReOpenLastFile'].AsBoolean;
End;

Procedure TXmlGlobalOptionsImpl.SetReopenLastFile(Const AReopenLastFile : Boolean);
Begin
  ChildNodes['ReOpenLastFile'].AsBoolean := AReopenLastFile;
End;

Function TXmlGlobalOptionsImpl.GetLastOpenedFile() : String;
Begin
  Result := ChildNodes['LastOpenedFile'].AsString;
End;

Procedure TXmlGlobalOptionsImpl.SetLastOpenedFile(Const ALastOpenedFile : String);
Begin
  ChildNodes['LastOpenedFile'].AsString := ALastOpenedFile;
End;

Function TXmlGlobalOptionsImpl.GetSkinName() : String;
Begin
  Result := ChildNodes['SkinName'].AsString;
End;

Procedure TXmlGlobalOptionsImpl.SetSkinName(Const ASkinName : String);
Begin
  ChildNodes['SkinName'].AsString := ASkinName;
End;

end.
