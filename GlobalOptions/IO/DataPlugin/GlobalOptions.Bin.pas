unit GlobalOptions.Bin;

interface

Uses
  HsStreamEx, GlobalOptionsIntf;

Type
  IBinGlobalOptions = Interface(IGlobalOptions)
    ['{4B61686E-29A0-2112-B13D-1FDFEC663947}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinGlobalOptions = Class(TObject)
  Public
    Class Function CreateGlobalOptions() : IBinGlobalOptions; OverLoad;
    Class Function CreateGlobalOptions(ABinData : IStreamEx) : IBinGlobalOptions; OverLoad;
    Class Function CreateGlobalOptions(Const AFileName : String) : IBinGlobalOptions; OverLoad;

  End;

implementation

Uses
  Classes, SysUtils, HsStringListEx, GlobalOptionsImpl;

Type
  TBinGlobalOptionsImpl = Class(TGlobalOptions, IBinGlobalOptions)
  Private
    Procedure ReadFromStreamV01(AStream : IStreamEx);
    Procedure ReadFromStreamV02(AStream : IStreamEx);
    Procedure ReadFromStreamV03(AStream : IStreamEx);

  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

Class Function TBinGlobalOptions.CreateGlobalOptions() : IBinGlobalOptions;
Begin
  Result := TBinGlobalOptionsImpl.Create();
End;

Class Function TBinGlobalOptions.CreateGlobalOptions(ABinData : IStreamEx) : IBinGlobalOptions;
Begin
  Result := TBinGlobalOptionsImpl.Create();
  Result.LoadFromStream(ABinData);
End;

Class Function TBinGlobalOptions.CreateGlobalOptions(Const AFileName : String) : IBinGlobalOptions; 
Var lMemStrm : IMemoryStreamEx;
Begin
  lMemStrm := TMemoryStreamEx.Create();
  Try
    lMemStrm.LoadFromFile(AFileName);
    Result := CreateGlobalOptions(lMemStrm);
    
    Finally
      lMemStrm := Nil;
  End;
End;

(******************************************************************************)

Procedure TBinGlobalOptionsImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Case ASource.ReadByte() Of
    1 : ReadFromStreamV01(ASource);
    2 : ReadFromStreamV02(ASource);
    3 : ReadFromStreamV03(ASource);
  End;
End;
  
Procedure TBinGlobalOptionsImpl.ReadFromStreamV01(AStream : IStreamEx);
Begin
  WindowState      := AStream.ReadByte();
  Top              := AStream.ReadInt();
  Left             := AStream.ReadInt();
  Height           := AStream.ReadInt();
  Width            := AStream.ReadInt();
  TreeViewWidth    := AStream.ReadInt();
  TreeViewColWidth := AStream.ReadInt();
  MRUMaxItem       := AStream.ReadByte();
  AStream.ReadTStrings(MRUList);
End;

Procedure TBinGlobalOptionsImpl.ReadFromStreamV02(AStream : IStreamEx);
Begin
  ReadFromStreamV01(AStream);
  ReopenLastFile := AStream.ReadBoolean();
  LastOpenedFile := AStream.ReadString();
  SkinName       := AStream.ReadString();
End;

Procedure TBinGlobalOptionsImpl.ReadFromStreamV03(AStream : IStreamEx);
Var lLstPath  : IHsStringListEx;
    lNbItem   : Byte;
    lPathId   : Byte;
Begin
  WindowState      := AStream.ReadByte();
  Top              := AStream.ReadInt();
  Left             := AStream.ReadInt();
  Height           := AStream.ReadInt();
  Width            := AStream.ReadInt();
  TreeViewWidth    := AStream.ReadInt();
  TreeViewColWidth := AStream.ReadInt();
  MRUMaxItem       := AStream.ReadByte();

  lLstPath := THsStringListEx.CreateList();
  Try
    AStream.ReadTStrings(lLstPath);

    lNbItem := AStream.ReadByte();
    While lNbItem > 0 Do
    Begin
      lPathId := AStream.ReadByte();
      MRUList.Add(lLstPath[lPathId] + AStream.ReadString());
      Dec(lNbItem);
    End;

    Finally
      lLstPath := Nil;
  End;

  ReopenLastFile := AStream.ReadBoolean();
  LastOpenedFile := AStream.ReadString();
  SkinName       := AStream.ReadString();
End;

Procedure TBinGlobalOptionsImpl.SaveToStream(ATarget : IStreamEx);
Const
  cStreamVersion = 3;

Var X : Integer;
    lLstPath : IHsStringListEx;
Begin
  ATarget.WriteByte(cStreamVersion);

  ATarget.WriteByte(WindowState);
  ATarget.WriteInt(Top);
  ATarget.WriteInt(Left);
  ATarget.WriteInt(Height);
  ATarget.WriteInt(Width);
  ATarget.WriteInt(TreeViewWidth);
  ATarget.WriteInt(TreeViewColWidth);
  ATarget.WriteByte(MRUMaxItem);

  lLstPath := THsStringListEx.CreateList();
  Try
    lLstPath.Sorted := True;
    lLstPath.Duplicates := dupIgnore;

    For X := 0 To MRUList.Count - 1 Do
      lLstPath.Add(ExtractFilePath(MRUList[X]));

    ATarget.WriteTStrings(lLstPath);
    ATarget.WriteByte(MRUList.Count);

    For X := 0 To MRUList.Count - 1 Do
    Begin
      ATarget.WriteByte(lLstPath.IndexOf(ExtractFilePath(MRUList[X])));
      ATarget.WriteString(ExtractFileName(MRUList[X]));
    End;

    Finally
      lLstPath := Nil;
  End;
//  ATarget.WriteTStrings(MRUList);
  ATarget.WriteBoolean(ReopenLastFile);
  ATarget.WriteString(LastOpenedFile);
  ATarget.WriteString(SkinName);
End;

end.
