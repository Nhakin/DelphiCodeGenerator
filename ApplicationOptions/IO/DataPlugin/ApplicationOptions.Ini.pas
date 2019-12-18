unit ApplicationOptions.Ini;

interface

Uses
  HsIniFilesEx, GlobalOptions.Ini, MsSqlOptions.Ini, SearchOptions.Ini;

Type
  IIniApplicationOptions = Interface(IHsMemIniFileEx)
    ['{4B61686E-29A0-2112-97BC-EB0895DBF0FF}']
    Function GetGlobalOptions() : IIniGlobalOptions;
    Function GetMsSqlOptions() : IIniMsSqlOptions;
    Function GetSearchOptions() : IIniSearchOptions;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property GlobalOptions : IIniGlobalOptions Read GetGlobalOptions;
    Property MsSqlOptions  : IIniMsSqlOptions  Read GetMsSqlOptions;
    Property SearchOptions : IIniSearchOptions Read GetSearchOptions;

  End;

  TIniApplicationOptions = Class(TObject)
  Public
    Class Function CreateApplicationOptions() : IIniApplicationOptions; OverLoad;
    Class Function CreateApplicationOptions(Const AIniString : String) : IIniApplicationOptions; OverLoad;

  End;

implementation

Uses 
  Classes, SysUtils, RtlConsts,
  HsInterfaceEx, ApplicationOptionsIntf, GlobalOptionsIntf, MsSqlOptionIntf, SearchOptionsIntf;
  
Type
  TIniApplicationOptionsImpl = Class(THsMemIniFileEx, IApplicationOptions, IIniApplicationOptions)
  Private
    FAppOptionsImpl : Pointer;
    FInterfaceState : TInterfaceState;

    FIniGlobalOptions : IIniGlobalOptions;
    FIniMsSqlOptions : IIniMsSqlOptions;
    FIniSearchParameters : IIniSearchOptions;

    Function GetAppOptionsImpl() : IApplicationOptions;
    Function GetImplementor() : THsCustomIniFileImplementor;

  Protected
    Property AppOptionsImpl : IApplicationOptions Read GetAppOptionsImpl;

    Property Implementor : THsCustomIniFileImplementor Read GetImplementor Implements
      IApplicationOptions, IIniApplicationOptions;
  
    Function GetGlobalOptions() : IIniGlobalOptions;
    Function GetMsSqlOptions() : IIniMsSqlOptions;
    Function GetSearchOptions() : IIniSearchOptions;

    Function MyGetGlobalOptions() : IGlobalOptions;
    Function MyGetMsSqlOptions() : IMsSqlOptions;
    Function MyGetSearchOptions() : ISearchOptions;

    Function GetInterfaceState() : TInterfaceState;

    Function IApplicationOptions.GetGlobalOptions = MyGetGlobalOptions;
    Function IApplicationOptions.GetMsSqlOptions  = MyGetMsSqlOptions;
    Function IApplicationOptions.GetSearchOptions = MyGetSearchOptions;
    
    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

  Public
    Procedure GetStrings(List: TStrings);
    Procedure SetStrings(List: TStrings);

    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TIniApplicationOptions.CreateApplicationOptions() : IIniApplicationOptions;
Begin
  Result := TIniApplicationOptionsImpl.Create('');
End;

Class Function TIniApplicationOptions.CreateApplicationOptions(Const AIniString : String) : IIniApplicationOptions;
Var lLst : TStringList;
Begin
  Result := TIniApplicationOptionsImpl.Create('');
  lLst := TStringList.Create();
  Try
    lLst.Text := AIniString;
    Result.SetStrings(lLst);
    
    Finally
      lLst.Free();
  End;
End;

(******************************************************************************)

Procedure TIniApplicationOptionsImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState := isCreating;
  FAppOptionsImpl := Pointer(IApplicationOptions(Self));
End;

Procedure TIniApplicationOptionsImpl.BeforeDestruction();
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

Function TIniApplicationOptionsImpl.GetAppOptionsImpl() : IApplicationOptions;
Begin
  Result := IApplicationOptions(FAppOptionsImpl);
End;

Function TIniApplicationOptionsImpl.GetImplementor() : THsCustomIniFileImplementor;
Begin
  Result := InHerited Implementor;
End;

Function TIniApplicationOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TIniApplicationOptionsImpl.GetStrings(List: TStrings);
Begin
  List.Clear();
  GetGlobalOptions().GetStrings(List);
  GetMsSqlOptions().GetStrings(List);
  GetSearchOptions().GetStrings(List);
End;

Procedure TIniApplicationOptionsImpl.SetStrings(List: TStrings);
Var lLst : TStringList;
Begin
  InHerited SetStrings(List);

  lLst := TStringList.Create();
  Try
    ReadSectionValues('GlobalOptions', lLst);
    lLst.Insert(0, '[GlobalOptions]');
    GetGlobalOptions().SetStrings(lLst);

    ReadSectionValues('SqlOptions', lLst);
    lLst.Insert(0, '[SqlOptions]');
    GetMsSqlOptions().SetStrings(lLst);

    ReadSectionValues('SearchOptions', lLst);
    lLst.Insert(0, '[SearchOptions]');
    GetSearchOptions().SetStrings(lLst);
    
    Finally
      lLst.Free();
  End;

  Clear();
End;

Procedure TIniApplicationOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
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

Function TIniApplicationOptionsImpl.GetGlobalOptions() : IIniGlobalOptions;
Begin
  If Not Assigned(FIniGlobalOptions) Then
    FIniGlobalOptions := TIniGlobalOptions.CreateGlobalOptions();
  Result := FIniGlobalOptions;
End;

Function TIniApplicationOptionsImpl.GetMsSqlOptions() : IIniMsSqlOptions;
Begin
  If Not Assigned(FIniMsSqlOptions) Then
    FIniMsSqlOptions := TIniMsSqlOptions.CreateMsSqlOptions();
  Result := FIniMsSqlOptions;
End;

Function TIniApplicationOptionsImpl.GetSearchOptions() : IIniSearchOptions;
Begin
  If Not Assigned(FIniSearchParameters) Then
    FIniSearchParameters := TIniSearchOptions.CreateSearchOptions();
  Result := FIniSearchParameters;
End;

Function TIniApplicationOptionsImpl.MyGetGlobalOptions() : IGlobalOptions;
Begin
  Result := GetGlobalOptions() As IGlobalOptions;
End;

Function TIniApplicationOptionsImpl.MyGetMsSqlOptions() : IMsSqlOptions;
Begin
  Result := GetMsSqlOptions() As IMsSqlOptions;
End;

Function TIniApplicationOptionsImpl.MyGetSearchOptions() : ISearchOptions;
Begin
  Result := GetSearchOptions() As ISearchOptions;
End;

end.
