unit HsIniFilesEx;

interface

Uses Classes, IniFiles, HsInterfaceEx;

Type
  IIniFileEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B72A-B73AA07E1B01}']
    Function  SectionExists(Const Section : String) : Boolean;
    Function  ReadString(Const Section, Ident, Default : String) : String;
    Procedure WriteString(Const Section, Ident, Value : String);
    Function  ReadInteger(Const Section, Ident : String; Default : Longint) : Longint;
    Procedure WriteInteger(Const Section, Ident : String; Value : Longint);
    Function  ReadBool(Const Section, Ident : String; Default : Boolean) : Boolean;
    Procedure WriteBool(Const Section, Ident : String; Value : Boolean);
    Function  ReadBinaryStream(Const Section, Name : String; Value : TStream) : Integer;
    Procedure WriteBinaryStream(Const Section, Name : String; Value : TStream);
    Function  ReadDate(Const Section, Name : String; Default : TDateTime) : TDateTime;
    Procedure WriteDate(Const Section, Name : String; Value : TDateTime);
    Function  ReadDateTime(Const Section, Name : String; Default : TDateTime) : TDateTime;
    Procedure WriteDateTime(Const Section, Name : String; Value : TDateTime);
    Function  ReadFloat(Const Section, Name : String; Default : Double) : Double;
    Procedure WriteFloat(Const Section, Name : String; Value : Double);
    Function  ReadTime(Const Section, Name : String; Default : TDateTime) : TDateTime;
    Procedure WriteTime(Const Section, Name : String; Value : TDateTime);
    Procedure ReadSection(Const Section : String; Strings : TStrings);
    Procedure ReadSections(Strings : TStrings);
    Procedure EraseSection(Const Section : String);
    Procedure ReadSectionValues(Const Section : String; Strings : TStrings);
    Procedure DeleteKey(Const Section, Ident : String);
    Procedure UpdateFile();
    Function  ValueExists(Const Section, Ident : String) : Boolean;

  End;

  IMemIniFileEx = Interface(IIniFileEx)
    ['{4B61686E-29A0-2112-8EEF-F87F2BFE6F3E}']
    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Value: Boolean);

    Procedure Clear();
    Procedure Rename(Const FileName : String; Reload : Boolean);
    Procedure GetStrings(List: TStrings);
    Procedure SetStrings(List: TStrings);

    Property CaseSensitive : Boolean Read GetCaseSensitive Write SetCaseSensitive;

  End;

  TIniFileEx = Class(TIniFile, IIniFileEx)
  Private
    FImplementor : TInterfaceExImplementor;

  Protected
    Function GetImplementor() : TInterfaceExImplementor;
    Property Implementor : TInterfaceExImplementor Read GetImplementor Implements IInifileEx;

  Public
    Destructor Destroy(); OverRide;

  End;

  TMemIniFileEx = Class(TMemIniFile, IMemIniFileEx)
  Private
    FImplementor : TInterfaceExImplementor;

  Protected
    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Value: Boolean);

    Function GetImplementor() : TInterfaceExImplementor;
    Property Implementor : TInterfaceExImplementor Read GetImplementor Implements IMemIniFileEx;

  End;

implementation

Uses SysUtils;

Destructor TIniFileEx.Destroy();
Begin
  InHerited Destroy();
End;

Function TIniFileEx.GetImplementor() : TInterfaceExImplementor;
Begin
  If Not Assigned(FImplementor) Then
    FImplementor := TInterfaceExImplementor.Create(Self);
  Result := FImplementor;
End;

Function TMemIniFileEx.GetImplementor() : TInterfaceExImplementor;
Begin
  If Not Assigned(FImplementor) Then
    FImplementor := TInterfaceExImplementor.Create(Self);
  Result := FImplementor;
End;

Function TMemIniFileEx.GetCaseSensitive() : Boolean;
Begin
  Result := InHerited CaseSensitive;
End;

Procedure TMemIniFileEx.SetCaseSensitive(Value: Boolean);
Begin
  InHerited CaseSensitive := Value;
End;

end.
