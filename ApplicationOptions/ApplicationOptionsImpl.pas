unit ApplicationOptionsImpl;

interface

Uses
  HsInterfaceEx, ApplicationOptionsIntf, GlobalOptionsIntf, MsSqlOptionIntf, SearchOptionsIntf;

Type
  TApplicationOptions = Class(TInterfacedObjectEx, IApplicationOptions)
  Private
    FGlobalOptions  : IGlobalOptions;
    FMsSqlOptions   : IMsSqlOptions;
    FSearchOptions  : ISearchOptions;
    FInterfaceState : TInterfaceState;

  Protected
    Function GetGlobalOptions() : IGlobalOptions;
    Function GetMsSqlOptions() : IMsSqlOptions;
    Function GetSearchOptions() : ISearchOptions;

    Function GetInterfaceState() : TInterfaceState;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property GlobalOptions : IGlobalOptions Read GetGlobalOptions;
    Property MsSqlOptions  : IMsSqlOptions  Read GetMsSqlOptions;
    Property SearchOptions : ISearchOptions Read GetSearchOptions;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

implementation

Uses
  SysUtils, RtlConsts, GlobalOptionsImpl, MsSqlOptionImpl, SearchOptionsImpl;

Procedure TApplicationOptions.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState := isCreating;
End;

Procedure TApplicationOptions.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  InHerited BeforeDestruction();
End;

Procedure TApplicationOptions.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IApplicationOptions;
Begin
  If Supports(ASource, IApplicationOptions, lSrc) Then
  Begin
    GlobalOptions.Assign(lSrc.GlobalOptions, ASyncSource);
    MsSqlOptions.Assign(lSrc.MsSqlOptions, ASyncSource);
    SearchOptions.Assign(lSrc.SearchOptions, ASyncSource);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TApplicationOptions.GetGlobalOptions() : IGlobalOptions;
Begin
  If Not Assigned(FGlobalOptions) Then
    FGlobalOptions := TGlobalOptions.Create();
  Result := FGlobalOptions;
End;

Function TApplicationOptions.GetMsSqlOptions() : IMsSqlOptions;
Begin
  If Not Assigned(FMsSqlOptions) Then
    FMsSqlOptions := TMsSqlOptions.Create();
  Result := FMsSqlOptions;
End;

Function TApplicationOptions.GetSearchOptions() : ISearchOptions;
Begin
  If Not Assigned(FSearchOptions) Then
    FSearchOptions := TSearchOptions.Create();
  Result := FSearchOptions;
End;

Function TApplicationOptions.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

end.
