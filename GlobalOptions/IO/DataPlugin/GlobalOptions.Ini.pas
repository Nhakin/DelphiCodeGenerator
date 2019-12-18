unit GlobalOptions.Ini;

interface

Uses
  HsInterfaceEx, HsIniFilesEx;

Type
  IIniGlobalOptions = Interface(IHsMemIniFileEx)
    ['{4B61686E-29A0-2112-B802-D797C8607D71}']
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

  TIniGlobalOptions = Class(TObject)
  Public
    Class Function CreateGlobalOptions() : IIniGlobalOptions; OverLoad;
    Class Function CreateGlobalOptions(Const AIniString : String) : IIniGlobalOptions; OverLoad;

  End;

implementation

Uses
  Classes, SysUtils, RtlConsts, HsStringListEx, GlobalOptionsIntf;

Type
  TIniGlobalOptionsImpl = Class(THsMemIniFileEx, IGlobalOptions, IIniGlobalOptions)
  Private
    FGlobalOptionsImpl : Pointer;
    FInterfaceState    : TInterfaceState;

    Function GetGlobalOptionsImpl() : IGlobalOptions;
    Function GetImplementor() : THsCustomIniFileImplementor;

  Protected
    Property Implementor : THsCustomIniFileImplementor Read GetImplementor Implements
      IGlobalOptions, IIniGlobalOptions;
  
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

Class Function TIniGlobalOptions.CreateGlobalOptions() : IIniGlobalOptions;
Begin
  Result := TIniGlobalOptionsImpl.Create('');
End;

Class Function TIniGlobalOptions.CreateGlobalOptions(Const AIniString : String) : IIniGlobalOptions;
Var lLst : TStringList;
Begin
  Result := TIniGlobalOptionsImpl.Create('');
  lLst := TStringList.Create();
  Try
    lLst.Text := AIniString;
    Result.SetStrings(lLst);
    
    Finally
      lLst.Free();
  End;
End;

(******************************************************************************)

Procedure TIniGlobalOptionsImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState    := isCreating;
  FGlobalOptionsImpl := Pointer(IGlobalOptions(Self));
End;

Procedure TIniGlobalOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (IGlobalOptions(FGlobalOptionsImpl) <> IGlobalOptions(Self)) And
     (IGlobalOptions(FGlobalOptionsImpl).InterfaceState <> isDestroying) Then
    With GlobalOptionsImpl Do
    Begin
      WindowState       := ReadInteger('GlobalOption', 'WindowState', 0);
      Top               := ReadInteger('GlobalOption', 'Top', 0);
      Left              := ReadInteger('GlobalOption', 'Left', 0);
      Height            := ReadInteger('GlobalOption', 'Height', 0);
      Width             := ReadInteger('GlobalOption', 'Width', 0);
      TreeViewWidth     := ReadInteger('GlobalOption', 'TreeViewWidth', 0);
      TreeViewColWidth  := ReadInteger('GlobalOption', 'TreeViewColWidth', 0);
      MRUMaxItem        := ReadInteger('GlobalOption', 'MRUMaxItem', 0);
      MRUList.CommaText := ReadString('GlobalOption', 'MRUList', '');
      ReopenLastFile    := ReadBool('GlobalOption', 'ReOpenLastFile', False);
      LastOpenedFile    := ReadString('GlobalOption', 'LastOpenedFile', '');
      SkinName          := ReadString('GlobalOption', 'SkinName', '');
    End;

  InHerited BeforeDestruction();
End;

Function TIniGlobalOptionsImpl.GetGlobalOptionsImpl() : IGlobalOptions;
Begin
  Result := IGlobalOptions(FGlobalOptionsImpl);
End;

Function TIniGlobalOptionsImpl.GetImplementor() : THsCustomIniFileImplementor;
Begin
  Result := InHerited Implementor;
End;

Function TIniGlobalOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TIniGlobalOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IGlobalOptions;
Begin
  If Supports(ASource, IGlobalOptions, lSrc) Then
  Begin
    WriteInteger('GlobalOption', 'WindowState', lSrc.WindowState);
    WriteInteger('GlobalOption', 'Top', lSrc.Top);
    WriteInteger('GlobalOption', 'Left', lSrc.Left);
    WriteInteger('GlobalOption', 'Height', lSrc.Height);
    WriteInteger('GlobalOption', 'Width', lSrc.Width);
    WriteInteger('GlobalOption', 'TreeViewWidth', lSrc.TreeViewWidth);
    WriteInteger('GlobalOption', 'TreeViewColWidth', lSrc.TreeViewColWidth);
    WriteInteger('GlobalOption', 'MRUMaxItem', lSrc.MRUMaxItem);
    WriteString('GlobalOption', 'MRUList', lSrc.MRUList.CommaText);
    WriteBool('GlobalOption', 'ReOpenLastFile', lSrc.ReopenLastFile);
    WriteString('GlobalOption', 'LastOpenedFile', lSrc.LastOpenedFile);
    WriteString('GlobalOption', 'SkinName', lSrc.SkinName);

    If ASyncSource Then
      FGlobalOptionsImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TIniGlobalOptionsImpl.GetWindowState() : Byte;
Begin
  Result := ReadInteger('GlobalOption', 'WindowState', 0);
End;

Procedure TIniGlobalOptionsImpl.SetWindowState(Const AWindowState : Byte);
Begin
  WriteInteger('GlobalOption', 'WindowState', AWindowState);
End;

Function TIniGlobalOptionsImpl.GetTop() : Integer;
Begin
  Result := ReadInteger('GlobalOption', 'Top', 0);
End;

Procedure TIniGlobalOptionsImpl.SetTop(Const ATop : Integer);
Begin
  WriteInteger('GlobalOption', 'Top', ATop);
End;

Function TIniGlobalOptionsImpl.GetLeft() : Integer;
Begin
  Result := ReadInteger('GlobalOption', 'Left', 0);
End;

Procedure TIniGlobalOptionsImpl.SetLeft(Const ALeft : Integer);
Begin
  WriteInteger('GlobalOption', 'Left', ALeft);
End;

Function TIniGlobalOptionsImpl.GetHeight() : Integer;
Begin
  Result := ReadInteger('GlobalOption', 'Height', 0);
End;

Procedure TIniGlobalOptionsImpl.SetHeight(Const AHeight : Integer);
Begin
  WriteInteger('GlobalOption', 'Height', AHeight);
End;

Function TIniGlobalOptionsImpl.GetWidth() : Integer;
Begin
  Result := ReadInteger('GlobalOption', 'Width', 0);
End;

Procedure TIniGlobalOptionsImpl.SetWidth(Const AWidth : Integer);
Begin
  WriteInteger('GlobalOption', 'Width', AWidth);
End;

Function TIniGlobalOptionsImpl.GetTreeViewWidth() : Integer;
Begin
  Result := ReadInteger('GlobalOption', 'TreeViewWidth', 0);
End;

Procedure TIniGlobalOptionsImpl.SetTreeViewWidth(Const ATreeViewWidth : Integer);
Begin
  WriteInteger('GlobalOption', 'TreeViewWidth', ATreeViewWidth);
End;

Function TIniGlobalOptionsImpl.GetTreeViewColWidth() : Integer;
Begin
  Result := ReadInteger('GlobalOption', 'TreeViewColWitdh', 0);
End;

Procedure TIniGlobalOptionsImpl.SetTreeViewColWidth(Const ATreeViewColWidth : Integer);
Begin
  WriteInteger('GlobalOption', 'TreeViewColWitdh', ATreeViewColWidth);
End;

Function TIniGlobalOptionsImpl.GetMRUMaxItem() : Byte;
Begin
  Result := ReadInteger('GlobalOption', 'MRUMaxItem', 0);
End;

Procedure TIniGlobalOptionsImpl.SetMRUMaxItem(Const AMRUMaxItem : Byte);
Begin
  WriteInteger('GlobalOption', 'MRUMaxItem', AMRUMaxItem);
End;

Function TIniGlobalOptionsImpl.GetMRUList() : String;
Begin
  Result := ReadString('GlobalOption', 'MRUList', '');
End;

Procedure TIniGlobalOptionsImpl.SetMRUList(Const AMRUList : String);
Begin
  WriteString('GlobalOption', 'MRUList', AMRUList);
End;

Function TIniGlobalOptionsImpl.MyGetMRUList() : IHsStringListEx;
Begin
  Result := THsStringListEx.CreateList();
  Result.CommaText := ReadString('GlobalOption', 'MRUList', '');
End;

Procedure TIniGlobalOptionsImpl.MySetMRUList(AMRUList : IHsStringListEx);
Begin
  WriteString('GlobalOption', 'MRUList', AMRUList.CommaText);
End;

Function TIniGlobalOptionsImpl.GetReopenLastFile() : Boolean;
Begin
  Result := ReadBool('GlobalOption', 'ReOpenLastFile', False);
End;

Procedure TIniGlobalOptionsImpl.SetReopenLastFile(Const AReopenLastFile : Boolean);
Begin
  WriteBool('GlobalOption', 'ReOpenLastFile', AReopenLastFile);
End;

Function TIniGlobalOptionsImpl.GetLastOpenedFile() : String;
Begin
  Result := ReadString('GlobalOption', 'LastOpenedFile', '');
End;

Procedure TIniGlobalOptionsImpl.SetLastOpenedFile(Const ALastOpenedFile : String);
Begin
  WriteString('GlobalOption', 'LastOpenedFile', ALastOpenedFile);
End;

Function TIniGlobalOptionsImpl.GetSkinName() : String;
Begin
  Result := ReadString('GlobalOption', 'SkinName', '');
End;

Procedure TIniGlobalOptionsImpl.SetSkinName(Const ASkinName : String);
Begin
  WriteString('GlobalOption', 'SkinName', ASkinName);
End;

end.
