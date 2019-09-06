unit ApplicationOptions.JSon;

interface

Uses
  HsJSonEx, GlobalOptions.JSon, MsSqlOptions.JSon, SearchOptions.JSon;

Type
  IJSonApplicationOptions = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-B4D4-BCCC17D2E0CA}']
    Function GetGlobalOptions() : IJSonGlobalOptions;
    Function GetMsSqlOptions() : IJSonMsSqlOptions;
    Function GetSearchOptions() : IJSonSearchOptions;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property GlobalOptions : IJSonGlobalOptions Read GetGlobalOptions;
    Property MsSqlOptions  : IJSonMsSqlOptions  Read GetMsSqlOptions;
    Property SearchOptions : IJSonSearchOptions Read GetSearchOptions;

  End;

  TJSonApplicationOptions = Class(TObject)
  Public
    Class Function CreateApplicationOptions() : IJSonApplicationOptions; OverLoad;
    Class Function CreateApplicationOptions(Const AJSonString : String) : IJSonApplicationOptions; OverLoad;

  End;

implementation

Uses
  SysUtils, RTLConsts, HsInterfaceEx,
  ApplicationOptionsIntf, GlobalOptionsIntf, MsSqlOptionIntf, SearchOptionsIntf;

Type
  TJSonApplicationOptionsImpl = Class(THsJSonObject, IApplicationOptions, IJSonApplicationOptions)
  Private
    FAppOptionsImpl : Pointer;
    FInterfaceState : TInterfaceState;

    Function GetAppOptionsImpl() : IApplicationOptions;
    
  Protected
    Property AppOptionsImpl : IApplicationOptions Read GetAppOptionsImpl;

    Function GetGlobalOptions() : IJSonGlobalOptions;
    Function GetMsSqlOptions() : IJSonMsSqlOptions;
    Function GetSearchOptions() : IJSonSearchOptions;

    Function MyGetGlobalOptions() : IGlobalOptions;
    Function MyGetMsSqlOptions() : IMsSqlOptions;
    Function MyGetSearchOptions() : ISearchOptions;

    Function GetInterfaceState() : TInterfaceState;

    Function IApplicationOptions.GetGlobalOptions  = MyGetGlobalOptions;
    Function IApplicationOptions.GetMsSqlOptions  = MyGetMsSqlOptions;
    Function IApplicationOptions.GetSearchOptions = MyGetSearchOptions;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TJSonApplicationOptions.CreateApplicationOptions() : IJSonApplicationOptions;
Begin
  Result := TJSonApplicationOptionsImpl.Create();
End;

Class Function TJSonApplicationOptions.CreateApplicationOptions(Const AJSonString : String) : IJSonApplicationOptions;
Begin
  Result := THsJSonObject.GetDocBinding(AJSonString, TJSonApplicationOptionsImpl) As IJSonApplicationOptions;
End;

(******************************************************************************)

Procedure TJSonApplicationOptionsImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('GloballOptions', TJSonGlobalOptions.HsJSonObjectClass);
  RegisterChildNode('MsSqlOptions', TJSonMsSqlOptions.HsJSonObjectClass);
  RegisterChildNode('SearchOptions', TJSonSearchOptions.HsJSonObjectClass);

  FInterfaceState := isCreating;
  FAppOptionsImpl := Pointer(IApplicationOptions(Self));
End;

Procedure TJSonApplicationOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (IApplicationOptions(FAppOptionsImpl) <> IApplicationOptions(Self)) And
     (IApplicationOptions(FAppOptionsImpl).InterfaceState <> isDestroying) Then
    With AppOptionsImpl Do
    Begin
      GlobalOptions.Assign(Self.GetGlobalOptions());
      MsSqlOptions.Assign(Self.GetMsSqlOptions());
      SearchOptions.Assign(Self.GetSearchOptions());
    End;

  InHerited BeforeDestruction();
End;

Function TJSonApplicationOptionsImpl.GetAppOptionsImpl() : IApplicationOptions;
Begin
  Result := IApplicationOptions(FAppOptionsImpl);
End;

Function TJSonApplicationOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TJSonApplicationOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IApplicationOptions;
Begin
  If Supports(ASource, IApplicationOptions, lSrc) Then
  Begin
    MyGetGlobalOptions().Assign(lSrc.GlobalOptions, ASyncSource);
    MyGetMsSqlOptions().Assign(lSrc.MsSqlOptions, ASyncSource);
    MyGetSearchOptions().Assign(lSrc.SearchOptions, ASyncSource);

    If ASyncSource Then
      FAppOptionsImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TJSonApplicationOptionsImpl.GetGlobalOptions() : IJSonGlobalOptions;
Begin
  If Not Assigned(O['GloballOptions']) Then
    O['GloballOptions'] := TJSonGlobalOptions.CreateGlobalOptions();
  Result := O['GloballOptions'] As IJSonGlobalOptions;
End;

Function TJSonApplicationOptionsImpl.GetMsSqlOptions() : IJSonMsSqlOptions;
Begin
  If Not Assigned(O['MsSqlOptions']) Then
    O['MsSqlOptions'] := TJSonMsSqlOptions.CreateMsSqlOptions();
  Result := O['MsSqlOptions'] As IJSonMsSqlOptions;
End;

Function TJSonApplicationOptionsImpl.GetSearchOptions() : IJSonSearchOptions;
Begin
  If Not Assigned(O['SearchOptions']) Then
    O['SearchOptions'] := TJSonSearchOptions.CreateSearchOptions();
  Result := O['SearchOptions'] As IJSonSearchOptions;
End;

Function TJSonApplicationOptionsImpl.MyGetGlobalOptions() : IGlobalOptions;
Begin
  Result := GetGlobalOptions() As IGlobalOptions;
End;

Function TJSonApplicationOptionsImpl.MyGetMsSqlOptions() : IMsSqlOptions;
Begin
  Result := GetMsSqlOptions() As IMsSqlOptions;
End;

Function TJSonApplicationOptionsImpl.MyGetSearchOptions() : ISearchOptions;
Begin
  Result := GetSearchOptions() As ISearchOptions;
End;

end.
