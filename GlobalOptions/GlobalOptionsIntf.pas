unit GlobalOptionsIntf;

interface

Uses
  HsInterfaceEx, HsStringListEx;

Type
  IGlobalOptions = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-AC8F-0E637FB21A6E}']
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

    Function  GetMRUList() : IHsStringListEx;
    Procedure SetMRUList(AMRUList : IHsStringListEx);

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
    Property MRUList          : IHsStringListEx Read GetMRUList          Write SetMRUList;
    Property ReopenLastFile   : Boolean         Read GetReopenLastFile   Write SetReopenLastFile;
    Property LastOpenedFile   : String          Read GetLastOpenedFile   Write SetLastOpenedFile;
    Property SkinName         : String          Read GetSkinName         Write SetSkinName;

  End;

implementation

end.
