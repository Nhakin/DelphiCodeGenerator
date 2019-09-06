unit GlobalOptionsImpl;

interface
Uses
  HsInterfaceEx, HsStringListEx, GlobalOptionsIntf;

Type
  TGlobalOptions = Class(TInterfacedObjectEx, IGlobalOptions)
  Private
    FInterfaceState   : TInterfaceState;
    FWindowState      : Byte;
    FTop              : Integer;
    FLeft             : Integer;
    FHeight           : Integer;
    FWidth            : Integer;
    FTreeViewWidth    : Integer;
    FTreeViewColWidth : Integer;
    FMRUMaxItem       : Byte;
    FMRUList          : IHsStringListEx;
    FReopenLastFile   : Boolean;
    FLastOpenedFile   : String;
    FSkinName         : String;

  Protected
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

    Function  GetMRUList() : IHsStringListEx;
    Procedure SetMRUList(AMRUList : IHsStringListEx);

    Function  GetReopenLastFile() : Boolean;
    Procedure SetReopenLastFile(Const AReopenLastFile : Boolean);

    Function  GetLastOpenedFile() : String;
    Procedure SetLastOpenedFile(Const ALastOpenedFile : String);

    Function  GetSkinName() : String;
    Procedure SetSkinName(Const ASkinName : String);
    
    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property WindowState      : Byte            Read GetWindowState      Write SetWindowState;
    Property Top              : Integer         Read GetTop              Write SetTop;
    Property Left             : Integer         Read GetLeft             Write SetLeft;
    Property Height           : Integer         Read GetHeight           Write SetHeight;
    Property Width            : Integer         Read GetWidth            Write SetWidth;
    Property TreeViewWidth    : Integer         Read GetTreeViewWidth    Write SetTreeViewWidth;
    Property TreeViewColWidth : Integer         Read GetTreeViewColWidth Write SetTreeViewColWidth;
    Property MRUMaxItem       : Byte            Read GetMRUMaxItem       Write SetMRUMaxItem;
    Property MRUList          : IHsStringListEx Read GetMRUList          Write SetMRUList;
    Property ReopenLastFile   : Boolean         Read GetReopenLastFile   Write SetReopenLastFile;
    Property LastOpenedFile   : String          Read GetLastOpenedFile   Write SetLastOpenedFile;
    Property SkinName         : String          Read GetSkinName         Write SetSkinName;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

implementation

Uses
  SysUtils, RtlConsts;

Procedure TGlobalOptions.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState := isCreating;
  FMRUList := THsStringListEx.CreateList();
End;

Procedure TGlobalOptions.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;
  FMRUList := Nil;

  InHerited BeforeDestruction();
End;

Function TGlobalOptions.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TGlobalOptions.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IGlobalOptions;
Begin
  If Supports(ASource, IGlobalOptions, lSrc) Then
  Begin
    FWindowState      := lSrc.WindowState;
    FTop              := lSrc.Top;
    FLeft             := lSrc.Left;
    FHeight           := lSrc.Height;
    FWidth            := lSrc.Width;
    FTreeViewWidth    := lSrc.TreeViewWidth;
    FTreeViewColWidth := lSrc.TreeViewColWidth;
    FMRUMaxItem       := lSrc.MRUMaxItem;
    FMRUList          := lSrc.MRUList;
    FReopenLastFile   := lSrc.ReopenLastFile;
    FLastOpenedFile   := lSrc.LastOpenedFile;
    FSkinName         := lSrc.SkinName;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TGlobalOptions.GetWindowState() : Byte;
Begin
  Result := FWindowState;
End;

Procedure TGlobalOptions.SetWindowState(Const AWindowState : Byte);
Begin
  FWindowState := AWindowState;
End;

Function TGlobalOptions.GetTop() : Integer;
Begin
  Result := FTop;
End;

Procedure TGlobalOptions.SetTop(Const ATop : Integer);
Begin
  FTop := ATop;
End;

Function TGlobalOptions.GetLeft() : Integer;
Begin
  Result := FLeft;
End;

Procedure TGlobalOptions.SetLeft(Const ALeft : Integer);
Begin
  FLeft := ALeft;
End;

Function TGlobalOptions.GetHeight() : Integer;
Begin
  Result := FHeight;
End;

Procedure TGlobalOptions.SetHeight(Const AHeight : Integer);
Begin
  FHeight := AHeight;
End;

Function TGlobalOptions.GetWidth() : Integer;
Begin
  Result := FWidth;
End;

Procedure TGlobalOptions.SetWidth(Const AWidth : Integer);
Begin
  FWidth := AWidth;
End;

Function TGlobalOptions.GetTreeViewWidth() : Integer;
Begin
  Result := FTreeViewWidth;
End;

Procedure TGlobalOptions.SetTreeViewWidth(Const ATreeViewWidth : Integer);
Begin
  FTreeViewWidth := ATreeViewWidth;
End;

Function TGlobalOptions.GetTreeViewColWidth() : Integer;
Begin
  Result := FTreeViewColWidth;
End;

Procedure TGlobalOptions.SetTreeViewColWidth(Const ATreeViewColWidth : Integer);
Begin
  FTreeViewColWidth := ATreeViewColWidth;
End;

Function TGlobalOptions.GetMRUMaxItem() : Byte;
Begin
  Result := FMRUMaxItem;
End;

Procedure TGlobalOptions.SetMRUMaxItem(Const AMRUMaxItem : Byte);
Begin
  FMRUMaxItem := AMRUMaxItem;
End;

Function TGlobalOptions.GetMRUList() : IHsStringListEx;
Begin
  Result := FMRUList;
End;

Procedure TGlobalOptions.SetMRUList(AMRUList : IHsStringListEx);
Begin
  FMRUList.Text := AMRUList.Text;
End;

Function TGlobalOptions.GetReopenLastFile() : Boolean;
Begin
  Result := FReopenLastFile;
End;

Procedure TGlobalOptions.SetReopenLastFile(Const AReopenLastFile : Boolean);
Begin
  FReopenLastFile := AReopenLastFile;
End;

Function TGlobalOptions.GetLastOpenedFile() : String;
Begin
  Result := FLastOpenedFile;
End;

Procedure TGlobalOptions.SetLastOpenedFile(Const ALastOpenedFile : String);
Begin
  FLastOpenedFile := ALastOpenedFile;
End;

Function TGlobalOptions.GetSkinName() : String;
Begin
  Result := FSkinName;
End;

Procedure TGlobalOptions.SetSkinName(Const ASkinName : String);
Begin
  FSkinName := ASkinName;
End;

end.
