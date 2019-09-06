unit HsCheckSumEx;

interface

Uses Windows, Classes;

//http://www.nayuki.io/page/forcing-a-files-crc-to-any-value
Function GetCrc32Value(Const AFileName : String) : DWord; OverLoad;
Function GetCrc32Value(Const AStream : TStream) : DWord; OverLoad;
Function SetCrc32(Const AFileName : String; Const AOffSet : UInt64; ACrc32 : DWord) : Boolean;

implementation

Uses Dialogs,
  SysUtils, Types, HsStreamEx;

Const
  PolyNominal = $104C11DB7;

Function ReverseDWord(AInteger : DWord) : DWord;
Var X : Integer;
Begin
  Result := 0;
  For X := 0 To 31 Do
  Begin
    Result   := (Result Shl 1) Or (AInteger And 1);
    AInteger := AInteger Shr 1;
  End;
End;

Function HsCrc32Value(AStream : TStream) : DWord; OverLoad;
Var lBuffer : Array[0..1024] Of Byte;
    lByteRead : Integer;
    X, Y : Integer;
Begin
  Result := $FFFFFFFF;
  AStream.Position := 0;
  Repeat
    lByteRead := AStream.Read(lBuffer, SizeOf(lBuffer));
    For X := 0 To lByteRead - 1 Do
      For Y := 0 To 7 Do
      Begin
        Result := Result Xor (lBuffer[X] Shr Y) Shl 31;

        If Result And (1 Shl 31) = 0 Then
          Result := Result Shl 1
        Else
          Result := (Result Shl 1) Xor PolyNominal;
      End;
  Until lByteRead <> SizeOf(lBuffer);

  Result := Not Result;
End;

Function HsCrc32Value(AFileName : String) : DWord; OverLoad;
Var lFileStream : TFileStream;
Begin
  lFileStream := TFileStream.Create(AFileName, fmOpenRead + fmShareDenyNone);
  Try
    Result := HsCrc32Value(lFileStream);
    Finally
      lFileStream.Free();
  End;
End;

Function GetCrc32Value(Const AFileName : String) : DWord;
Begin
  Result := ReverseDWord(HsCrc32Value(AFileName));
End;

Function GetCrc32Value(Const AStream : TStream) : DWord;
Begin
  Result := ReverseDWord(HsCrc32Value(AStream));
End;

(******************************************************************************)

Function MultiplyMod(AInt1, AInt2 : Int64) : Int64;
Begin
  Result := 0;
  While AInt2 <> 0 Do
  Begin
    Result := Result Xor (AInt1 * (AInt2 And 1));
    AInt2 := AInt2 Shr 1;
    AInt1 := AInt1 Shl 1;
    If AInt1 And $100000000 <> 0 Then
      AInt1 := AInt1 Xor PolyNominal;
  End;
End;
	
Function GetDegree(AInt : Int64) : Integer;
Begin
  Result := 0;
  While True Do
  Begin
    If AInt Shr Result = 1 Then
      Break;
    Inc(Result);// := Result + 1;
  End;
End;

Function DivideAndRemainder(AInt1, AInt2 : Int64) : TInt64DynArray;
Var lDeg : Integer;
    Z    : Int64;
    I    : Integer;
Begin
  Z := 0;
  lDeg := GetDegree(AInt2);
  SetLength(Result, 2);
  For I := GetDegree(AInt1) - lDeg DownTo 0 Do
  Begin
    If AInt1 And (1 Shl (I + lDeg)) <> 0 Then
    Begin
      AInt1 := AInt1 Xor (AInt2 Shl I);
      Z := Z Or (1 Shl I);
    End;
  End;
  Result[0] := Z;
  Result[1] := AInt1;
End;

Function ReciprocalMod(AInt : Int64) : Int64;
Var A, B, C, Y : Int64;
    lDivRem : TInt64DynArray;
Begin
  Y := AInt;
  AInt := PolyNominal;
  A := 0;
  B := 1;

  While Y <> 0 Do
  Begin
    lDivRem := DivideAndRemainder(AInt, Y);
    C := A Xor MultiplyMod(lDivRem[0], B);
    AInt := Y;
    Y := lDivRem[1];
    A := B;
    B := C;
  End;

  If AInt = 1 Then
    Result := A
  Else
    Raise Exception.Create('Reciprocal does not exist.');
End;

Function PowMod(AInt1, AInt2 : Int64) : Int64;
Begin
  Result := 1;
  While AInt2 <> 0 Do
  Begin
    If AInt2 And 1 <> 0 Then
      Result := MultiplyMod(Result, AInt1);
    AInt1 := MultiplyMod(AInt1, AInt1);
    AInt2 := AInt2 Shr 1;
  End;
//  Result := Result;
End;

Function SetCrc32(Const AFileName : String; Const AOffSet : UInt64; ACrc32 : DWord) : Boolean;
Var lOriCrc     : DWord;
    lNewCrc     : DWord;
    lDelta      : Integer;
    lFileStream : TFileStream;
    lBytes      : Array[0..4] Of Byte;
    X           : Integer;
Begin
  Result := False;
  If FileExists(AFileName) Then
  Begin
    lFileStream := TFileStream.Create(AFileName, fmOpenReadWrite + fmShareDenyNone);
    Try
      If AOffSet + 4 <= lFileStream.Size Then
      Begin
        lNewCrc := ReverseDWord(ACrc32);
        lOriCrc := HsCrc32Value(lFileStream);
        lDelta  := ReverseDWord(MultiplyMod(ReciprocalMod(PowMod(2, (lFileStream.Size - AOffSet) * 8)), lOriCrc Xor lNewCrc And $FFFFFFFF));

        lFileStream.Seek(AOffSet, soFromBeginning);
        lFileStream.Read(lBytes[0], 4);

        For X := Low(lBytes) To High(lBytes) Do
          lBytes[X] := lBytes[X] Xor lDelta Shr (X * 8);

        lFileStream.Seek(AOffSet, soFromBeginning);
        lFileStream.WriteBuffer(lBytes[0], 4);

        Result := HsCrc32Value(AFileName) = lNewCrc;
      End
      Else
        Raise Exception.Create('Invalid Offset.');

      Finally
        lFileStream.Free();
    End;
  End
  Else
    Raise Exception.Create('Error file does not exist : ' + AFileName);
End;

end.
