unit SearchOptions.Bin;

Interface

Uses Classes, SysUtils, RTLConsts, HsStreamEx, HsInterfaceEx, HsStringListEx,
  SearchOptionsIntf, SearchOptionsImpl;

Type
  IBinSearchOptions = Interface(ISearchOptions)
    ['{4B61686E-29A0-2112-9588-6B991780171A}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;
    
(******************************************************************************)

Type
  TBinSearchOptions = Class(TObject)
  Public
    Class Function CreateSearchOptions() : IBinSearchOptions; OverLoad;
    Class Function CreateSearchOptions(ABinData : IStreamEx) : IBinSearchOptions; OverLoad;
    Class Function CreateSearchOptions(Const AFileName : String) : IBinSearchOptions; OverLoad;

  End;

Implementation

Type
  TBinSearchOptionsImpl = Class(TSearchOptions, IBinSearchOptions)
  Private Const
    cBackward = 1;
    cCaseSensitive = 2;
    cFromCaret = 4;
    cSelectionOnly = 8;
    cTextAtCaret = 16;
    cWholeWords = 32;

  Private
    Procedure ReadFromStreamV01(AStream : IStreamEx);

  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

Class Function TBinSearchOptions.CreateSearchOptions() : IBinSearchOptions;
Begin
  Result := TBinSearchOptionsImpl.Create();
End;

Class Function TBinSearchOptions.CreateSearchOptions(ABinData : IStreamEx) : IBinSearchOptions;
Begin
  Result := TBinSearchOptionsImpl.Create();
  Result.LoadFromStream(ABinData);
End;

Class Function TBinSearchOptions.CreateSearchOptions(Const AFileName : String) : IBinSearchOptions;
Var lMemStream : IMemoryStreamEx;
Begin
  lMemStream := TMemoryStreamEx.Create();
  Try
    lMemStream.LoadFromFile(AFileName);
    Result := CreateSearchOptions(lMemStream);

    Finally
      lMemStream := Nil;
  End;
End;

(******************************************************************************)

Procedure TBinSearchOptionsImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Case ASource.ReadByte() Of
    1 : ReadFromStreamV01(ASource);
  End;
End;

Procedure TBinSearchOptionsImpl.ReadFromStreamV01(AStream : IStreamEx);
Var lNbItem : Integer;
    lByte   : Byte;
Begin
  lByte := AStream.ReadByte();

  Backward      := lByte And cBackward = cBackward;
  CaseSensitive := lByte And cCaseSensitive = cCaseSensitive;
  FromCaret     := lByte And cFromCaret = cFromCaret;
  SelectionOnly := lByte And cSelectionOnly = cSelectionOnly;
  TextAtCaret   := lByte And cTextAtCaret = cTextAtCaret;
  WholeWords    := lByte And cWholeWords = cWholeWords;

  SearchText := AStream.ReadString();
  AStream.ReadTStrings(SearchTextHistory);
  ReplaceText := AStream.ReadString();
  AStream.ReadTStrings(ReplaceTextHistory);
End;

Procedure TBinSearchOptionsImpl.SaveToStream(ATarget : IStreamEx);
Const
  cStreamVersion = 1;

Var lByte : Byte;
Begin
  lByte := 0;

  If Backward Then
    lByte := lByte Or cBackward;

  If CaseSensitive Then                                      
    lByte := lByte Or cCaseSensitive;

  If FromCaret Then
    lByte := lByte Or cFromCaret;

  If SelectionOnly Then
    lByte := lByte Or cSelectionOnly;

  If TextAtCaret Then
    lByte := lByte Or cTextAtCaret;

  If WholeWords Then
    lByte := lByte Or cWholeWords;

  ATarget.WriteByte(cStreamVersion);
  ATarget.WriteByte(lByte);
  ATarget.WriteString(SearchText);
  ATarget.WriteTStrings(SearchTextHistory);
  ATarget.WriteString(ReplaceText);
  ATarget.WriteTStrings(ReplaceTextHistory);
End;

End.
