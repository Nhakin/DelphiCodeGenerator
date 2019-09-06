unit ApplicationOptions.Bin;

interface

Uses
  HsStreamEx, ApplicationOptionsIntf;

Type
  IBinApplicationOptions = Interface(IApplicationOptions)
    ['{4B61686E-29A0-2112-8A0D-0AF655E0CC9D}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinApplicationOptions = Class(TObject)
  Public
    Class Function CreateApplicationOptions() : IBinApplicationOptions; OverLoad;
    Class Function CreateApplicationOptions(ABinData : IStreamEx) : IBinApplicationOptions; OverLoad;
    Class Function CreateApplicationOptions(Const AFileName : String) : IBinApplicationOptions; OverLoad;

  End;

implementation

Uses
  ApplicationOptionsImpl, GlobalOptions.Bin, MsSqlOptions.Bin, SearchOptions.Bin;

Type
  TBinApplicationOptionsImpl = Class(TApplicationOptions, IBinApplicationOptions)
  Private
    Procedure ReadFromStreamV01(AStream : IStreamEx);

  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

Class Function TBinApplicationOptions.CreateApplicationOptions() : IBinApplicationOptions;
Begin
  Result := TBinApplicationOptionsImpl.Create();
End;

Class Function TBinApplicationOptions.CreateApplicationOptions(ABinData : IStreamEx) : IBinApplicationOptions;
Begin
  Result := TBinApplicationOptionsImpl.Create();
  Result.LoadFromStream(ABinData);
End;

Class Function TBinApplicationOptions.CreateApplicationOptions(Const AFileName : String) : IBinApplicationOptions;
Var lMemStrm : IMemoryStreamEx;
Begin
  lMemStrm := TMemoryStreamEx.Create();
  Try
    lMemStrm.LoadFromFile(AFileName);
    Result := CreateApplicationOptions(lMemStrm);
    
    Finally
      lMemStrm := Nil;
  End;
End;

(******************************************************************************)

Procedure TBinApplicationOptionsImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Case ASource.ReadByte() Of
    1 : ReadFromStreamV01(ASource);
  End;
End;

Procedure TBinApplicationOptionsImpl.ReadFromStreamV01(AStream : IStreamEx);
Var lGlobalOpt : IBinGlobalOptions;
    lMsSqlOpt  : IBinMsSqlOptions;
    lSrchOpt   : IBinSearchOptions;
Begin
  lGlobalOpt := TBinGlobalOptions.CreateGlobalOptions();
  Try
    lGlobalOpt.LoadFromStream(AStream);
    GlobalOptions.Assign(lGlobalOpt, False);

    Finally
      lGlobalOpt := Nil;
  End;

  lMsSqlOpt := TBinMsSqlOptions.CreateMsSqlOptions();
  Try
    lMsSqlOpt.LoadFromStream(AStream);
    MsSqlOptions.Assign(lMsSqlOpt, False);

    Finally
      lMsSqlOpt := Nil;
  End;

  lSrchOpt := TBinSearchOptions.CreateSearchOptions();
  Try
    lSrchOpt.LoadFromStream(AStream);
    SearchOptions.Assign(lSrchOpt, False);

    Finally
      lSrchOpt := Nil;
  End;
End;

Procedure TBinApplicationOptionsImpl.SaveToStream(ATarget : IStreamEx);
Const
  cStreamVersion = 1;

Var lGlobalOpt : IBinGlobalOptions;
    lMsSqlOpt  : IBinMsSqlOptions;
    lSrchOpt   : IBinSearchOptions;
Begin
  ATarget.WriteByte(cStreamVersion);

  lGlobalOpt := TBinGlobalOptions.CreateGlobalOptions();
  Try
    lGlobalOpt.Assign(GlobalOptions, False);
    lGlobalOpt.SaveToStream(ATarget);

    Finally
      lGlobalOpt := Nil;
  End;

  lMsSqlOpt := TBinMsSqlOptions.CreateMsSqlOptions();
  Try
    lMsSqlOpt.Assign(MsSqlOptions, False);
    lMsSqlOpt.SaveToStream(ATarget);

    Finally
      lMsSqlOpt := Nil;
  End;

  lSrchOpt := TBinSearchOptions.CreateSearchOptions();
  Try
    lSrchOpt.Assign(SearchOptions, False);
    lSrchOpt.SaveToStream(ATarget);

    Finally
      lSrchOpt := Nil;
  End;
End;

end.
