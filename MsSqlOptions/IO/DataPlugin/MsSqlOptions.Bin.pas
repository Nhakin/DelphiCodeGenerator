unit MsSqlOptions.Bin;

interface

Uses HsStreamEx, MsSqlOptionIntf;

Type
  IBinMsSqlOptions = Interface(IMsSqlOptions)
    ['{4B61686E-29A0-2112-B13D-1FDFEC663947}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinMsSqlOptions = Class(TObject)
  Public
    Class Function CreateMsSqlOptions() : IBinMsSqlOptions; OverLoad;
    Class Function CreateMsSqlOptions(ABinData : IStreamEx) : IBinMsSqlOptions; OverLoad;
    Class Function CreateMsSqlOptions(Const AFileName : String) : IBinMsSqlOptions; OverLoad;

  End;

implementation

Uses MsSqlOptionImpl;

Type
  TBinMsSqlOptionsImpl = Class(TMsSqlOptions, IBinMsSqlOptions)
  Private
    Procedure ReadFromStreamV01(AStream : IStreamEx);

  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

Class Function TBinMsSqlOptions.CreateMsSqlOptions() : IBinMsSqlOptions;
Begin
  Result := TBinMsSqlOptionsImpl.Create();
End;

Class Function TBinMsSqlOptions.CreateMsSqlOptions(ABinData : IStreamEx) : IBinMsSqlOptions;
Begin
  Result := TBinMsSqlOptionsImpl.Create();
  Result.LoadFromStream(ABinData);
End;

Class Function TBinMsSqlOptions.CreateMsSqlOptions(Const AFileName : String) : IBinMsSqlOptions;
Var lMemStrm : IMemoryStreamEx;
Begin
  lMemStrm := TMemoryStreamEx.Create();
  Try
    lMemStrm.LoadFromFile(AFileName);
    Result := CreateMsSqlOptions(lMemStrm);

    Finally
      lMemStrm := Nil;
  End;
End;

(******************************************************************************)

Procedure TBinMsSqlOptionsImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Case ASource.ReadByte() Of
    1 : ReadFromStreamV01(ASource);
  End;
End;

Procedure TBinMsSqlOptionsImpl.ReadFromStreamV01(AStream : IStreamEx);
Begin
  ServerName   := AStream.ReadAnsiString();
  LoginType    := AStream.ReadByte();
  UserName     := AStream.ReadAnsiString();
  Password     := AStream.ReadAnsiString();
  DataBaseName := AStream.ReadAnsiString();
End;

Procedure TBinMsSqlOptionsImpl.SaveToStream(ATarget : IStreamEx);
Const
  cStreamVersion = 1;
Begin
  ATarget.WriteByte(cStreamVersion);
  ATarget.WriteAnsiString(ServerName);
  ATarget.WriteByte(LoginType);
  ATarget.WriteAnsiString(UserName);
  ATarget.WriteAnsiString(Password);
  ATarget.WriteAnsiString(DataBaseName);
End;

end.
