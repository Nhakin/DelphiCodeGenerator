unit ApplicationOptionsIntf;

interface

Uses
  HsInterfaceEx, GlobalOptionsIntf, MsSqlOptionIntf, SearchOptionsIntf;

Type
  IApplicationOptions = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-AFF8-04EED33CAA80}']
    Function GetGlobalOptions() : IGlobalOptions;
    Function GetMsSqlOptions() : IMsSqlOptions;
    Function GetSearchOptions() : ISearchOptions;
    Function GetInterfaceState() : TInterfaceState;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property GlobalOptions  : IGlobalOptions  Read GetGlobalOptions;
    Property MsSqlOptions   : IMsSqlOptions   Read GetMsSqlOptions;
    Property SearchOptions  : ISearchOptions  Read GetSearchOptions;
    Property InterfaceState : TInterfaceState Read GetInterfaceState;

  End;

implementation
{
  WindowState
  Top
  Left
  Height
  Width
  PanTreeViewWidth
  TreeViewColWidth
  MRUMaxItem
  MRUList
}
end.
