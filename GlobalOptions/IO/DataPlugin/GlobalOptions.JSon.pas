unit GlobalOptions.JSon;

interface

Uses
  HsInterfaceEx, HsJSonEx;

Type
  IJSonGlobalOptions = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-8579-64F077597A48}']
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

    Function  GetMRUList() : String;
    Procedure SetMRUList(Const AMRUList : String);

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
    Property MRUList          : String          Read GetMRUList          Write SetMRUList;
    Property ReopenLastFile   : Boolean         Read GetReopenLastFile   Write SetReopenLastFile;
    Property LastOpenedFile   : String          Read GetLastOpenedFile   Write SetLastOpenedFile;
    Property SkinName         : String          Read GetSkinName         Write SetSkinName;

  End;

  TJSonGlobalOptions = Class(TObject)
  Public
    Class Function HsJSonObjectClass() : THsJSonObjectClass;
    Class Function CreateGlobalOptions() : IJSonGlobalOptions; OverLoad;
    Class Function CreateGlobalOptions(Const AJSonString : WideString) : IJSonGlobalOptions; OverLoad;
    Class Function CreateGlobalOptions(AJsonObject : IHsJSonObject) : IJSonGlobalOptions; OverLoad;

  End;

implementation

Uses
  SysUtils, RtlConsts, HsStringListEx, GlobalOptionsIntf;

Type
  TJSonGlobalOptionsImpl = Class(THsJSonObject, IGlobalOptions, IJSonGlobalOptions)
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

    Function  GetMRUList() : String;
    Procedure SetMRUList(Const AMRUList : String);

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

Class Function TJSonGlobalOptions.HsJSonObjectClass() : THsJSonObjectClass;
Begin
  Result := TJSonGlobalOptionsImpl;
End;

Class Function TJSonGlobalOptions.CreateGlobalOptions() : IJSonGlobalOptions;
Begin
  Result := TJSonGlobalOptionsImpl.Create();
End;

Class Function TJSonGlobalOptions.CreateGlobalOptions(Const AJSonString : WideString) : IJSonGlobalOptions;
Begin
  Result := THsJSonObject.GetDocBinding(AJSonString, TJSonGlobalOptionsImpl) As IJSonGlobalOptions;
End;

Class Function TJSonGlobalOptions.CreateGlobalOptions(AJSonObject : IHsJSonObject) : IJSonGlobalOptions;
Begin
  Result := THsJSonObject.GetDocBinding(AJSonObject, TJSonGlobalOptionsImpl) As IJSonGlobalOptions;
End;

(******************************************************************************)

Procedure TJSonGlobalOptionsImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState    := isCreating;
  FGlobalOptionsImpl := Pointer(IGlobalOptions(Self));
End;

Procedure TJSonGlobalOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (IGlobalOptions(FGlobalOptionsImpl) <> IGlobalOptions(Self)) And
     (IGlobalOptions(FGlobalOptionsImpl).InterfaceState <> isDestroying) Then
    With GlobalOptionsImpl Do
    Begin
      WindowState       := I['WindowState'];
      Top               := I['Top'];
      Left              := I['Left'];
      Height            := I['Height'];
      Width             := I['Width'];
      TreeViewWidth     := I['TreeViewWidth'];
      TreeViewColWidth  := I['TreeViewColWidth'];
      MRUMaxItem        := I['MRUMaxItem'];
      MRUList.CommaText := S['MRUList'];
      ReopenLastFile    := B['ReopenLastFile'];
      LastOpenedFile    := S['LastOpenedFile'];
      SkinName          := S['SkinName'];
    End;
      
  InHerited BeforeDestruction();
End;

Function TJSonGlobalOptionsImpl.GetGlobalOptionsImpl() : IGlobalOptions;
Begin
  Result := IGlobalOptions(FGlobalOptionsImpl);
End;

Function TJSonGlobalOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TJSonGlobalOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IGlobalOptions;
Begin
  If Supports(ASource, IGlobalOptions, lSrc) Then
  Begin
    I['WindowState']      := lSrc.WindowState;
    I['Top']              := lSrc.Top;
    I['Left']             := lSrc.Left;
    I['Height']           := lSrc.Height;
    I['Width']            := lSrc.Width;
    I['TreeViewWidth']    := lSrc.TreeViewWidth;
    I['TreeViewColWidth'] := lSrc.TreeViewColWidth;
    I['MRUMaxItem']       := lSrc.MRUMaxItem;
    S['MRUList']          := lSrc.MRUList.CommaText;
    B['ReopenLastFile']   := lSrc.ReopenLastFile;
    S['LastOpenedFile']   := lSrc.LastOpenedFile;
    S['SkinName']         := lSrc.SkinName;

    If ASyncSource Then
      FGlobalOptionsImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TJSonGlobalOptionsImpl.GetWindowState() : Byte;
Begin
  Result := I['WindowState'];
End;

Procedure TJSonGlobalOptionsImpl.SetWindowState(Const AWindowState : Byte);
Begin
  I['WindowState'] := AWindowState;
End;

Function TJSonGlobalOptionsImpl.GetTop() : Integer;
Begin
  Result := I['Top'];
End;

Procedure TJSonGlobalOptionsImpl.SetTop(Const ATop : Integer);
Begin
  I['Top'] := ATop;
End;

Function TJSonGlobalOptionsImpl.GetLeft() : Integer;
Begin
  Result := I['Left'];
End;

Procedure TJSonGlobalOptionsImpl.SetLeft(Const ALeft : Integer);
Begin
  I['Left'] := ALeft;
End;

Function TJSonGlobalOptionsImpl.GetHeight() : Integer;
Begin
  Result := I['Height'];
End;

Procedure TJSonGlobalOptionsImpl.SetHeight(Const AHeight : Integer);
Begin
  I['Height'] := AHeight;
End;

Function TJSonGlobalOptionsImpl.GetWidth() : Integer;
Begin
  Result := I['Width'];
End;

Procedure TJSonGlobalOptionsImpl.SetWidth(Const AWidth : Integer);
Begin
  I['Width'] := AWidth;
End;

Function TJSonGlobalOptionsImpl.GetTreeViewWidth() : Integer;
Begin
  Result := I['TreeViewWidth'];
End;

Procedure TJSonGlobalOptionsImpl.SetTreeViewWidth(Const ATreeViewWidth : Integer);
Begin
  I['TreeViewWidth'] := ATreeViewWidth;
End;

Function TJSonGlobalOptionsImpl.GetTreeViewColWidth() : Integer;
Begin
  Result := I['TreeViewColWidth'];
End;

Procedure TJSonGlobalOptionsImpl.SetTreeViewColWidth(Const ATreeViewColWidth : Integer);
Begin
  I['TreeViewColWidth'] := ATreeViewColWidth;
End;

Function TJSonGlobalOptionsImpl.GetMRUMaxItem() : Byte;
Begin
  Result := I['MRUMaxItem'];
End;

Procedure TJSonGlobalOptionsImpl.SetMRUMaxItem(Const AMRUMaxItem : Byte);
Begin
  I['MRUMaxItem'] := AMRUMaxItem;
End;

Function TJSonGlobalOptionsImpl.GetMRUList() : String;
Begin
  Result := S['MRUList'];
End;

Procedure TJSonGlobalOptionsImpl.SetMRUList(Const AMRUList : String);
Begin
  S['MRUList'] := AMRUList;
End;

Function TJSonGlobalOptionsImpl.MyGetMRUList() : IHsStringListEx;
Begin
  Result := THsStringListEx.CreateList();
  Result.CommaText := S['MRUList'];
End;

Procedure TJSonGlobalOptionsImpl.MySetMRUList(AMRUList : IHsStringListEx);
Begin
  S['MRUList'] := AMRUList.CommaText;
End;

Function TJSonGlobalOptionsImpl.GetReopenLastFile() : Boolean;
Begin
  Result := B['ReopenLastFile'];
End;

Procedure TJSonGlobalOptionsImpl.SetReopenLastFile(Const AReopenLastFile : Boolean);
Begin
  B['ReopenLastFile'] := AReopenLastFile;
End;

Function TJSonGlobalOptionsImpl.GetLastOpenedFile() : String;
Begin
  Result := S['LastOpenedFile'];
End;

Procedure TJSonGlobalOptionsImpl.SetLastOpenedFile(Const ALastOpenedFile : String);
Begin
  S['LastOpenedFile'] := ALastOpenedFile;
End;

Function TJSonGlobalOptionsImpl.GetSkinName() : String;
Begin
  Result := S['SkinName'];
End;

Procedure TJSonGlobalOptionsImpl.SetSkinName(Const ASkinName : String);
Begin
  S['SkinName'] := ASkinName;
End;

end.
