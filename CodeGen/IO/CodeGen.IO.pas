unit CodeGen.IO;

interface

Uses
  HsInterfaceEx,
  CodeGenIntf, CodeGen.JSon, CodeGen.Xml;

Type
  IHsUnitGeneratorFileManager = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-935F-DE508EAC5CF7}']
    Procedure SaveToFile(Const AFileName : String);
    Procedure LoadFromFile(Const AFileName : String);

  End;

  IRawIO = Interface(IHsUnitGeneratorFileManager)
    ['{4B61686E-29A0-2112-89C8-EDAEE40AEDE0}']
    Function GetGenerator() : IHsUnitGenerator;
    Property Generator : IHsUnitGenerator Read GetGenerator;

  End;

  IHsUnitGeneratorDataManager = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-859D-54977F760D61}']
    Procedure SaveTo(Const AUnitGenerator : IHsUnitGenerator);
    Procedure LoadFrom(Const AUnitGenerator : IHsUnitGenerator);

  End;

  IJSonIO = Interface(IHsUnitGeneratorDataManager)
    ['{4B61686E-29A0-2112-9D6E-8E394F37AFFD}']
    Function GetGenerator() : IJSonUnitGenerator;
    Property Generator : IJSonUnitGenerator Read GetGenerator;

  End;

  IXmlIO = Interface(IHsUnitGeneratorDataManager)
    ['{4B61686E-29A0-2112-84BF-62FC992B3B05}']
    Function GetGenerator() : IXMLUnitGenerator;
    Property Generator : IXMLUnitGenerator Read GetGenerator;

  End;

  TCodeGenIO = Class(TObject)
  Public
    Class Function CreateRawIO(AGenerator : IHsUnitGenerator) : IRawIO;
    Class Function CreateJSonIO(AGenerator : IJSonUnitGenerator) : IJSonIO;
    Class Function CreateXmlIO(AGenerator : IXMLUnitGenerator) : IXmlIO;

  End;

implementation

Uses Classes, TypInfo,
  CodeGenType;

Type
  TRawIO = Class(TInterfacedObjectEx, IHsUnitGeneratorFileManager, IRawIO)
  Private
    FRawFile : Pointer;

  Protected
    Procedure SaveToFile(Const AFileName : String);
    Procedure LoadFromFile(Const AFileName : String);

    Function GetGenerator() : IHsUnitGenerator;
    Property Generator : IHsUnitGenerator Read GetGenerator;

  Public
    Constructor Create(AGenerator : IHsUnitGenerator); ReIntroduce;

  End;

  TJSonIO = Class(TInterfacedObjectEx, IJSonIO)
  Private
    FJsonFile  : Pointer;
    FIsLoading : Boolean;

  Protected
    Procedure SaveTo(Const AUnitGenerator : IHsUnitGenerator);
    Procedure LoadFrom(Const AUnitGenerator : IHsUnitGenerator);

    Function GetGenerator() : IJSonUnitGenerator;
    Property Generator : IJSonUnitGenerator Read GetGenerator;

  Public
    Constructor Create(AGenerator : IJSonUnitGenerator); ReIntroduce;

  End;

  TXmlIO = Class(TInterfacedObjectEx, IXmlIO)
  Private
    FXmlFile   : Pointer;
    FIsLoading : Boolean;

  Protected
    Procedure SaveTo(Const AUnitGenerator : IHsUnitGenerator);
    Procedure LoadFrom(Const AUnitGenerator : IHsUnitGenerator);

    Function GetGenerator() : IXMLUnitGenerator;
    Property Generator : IXMLUnitGenerator Read GetGenerator;

  Public
    Constructor Create(AGenerator : IXMLUnitGenerator); ReIntroduce;

  End;

Class Function TCodeGenIO.CreateRawIO(AGenerator : IHsUnitGenerator) : IRawIO;
Begin
  Result := TRawIO.Create(AGenerator);
End;

Class Function TCodeGenIO.CreateJSonIO(AGenerator : IJSonUnitGenerator) : IJSonIO;
Begin
  Result := TJSonIO.Create(AGenerator);
End;

Class Function TCodeGenIO.CreateXmlIO(AGenerator : IXMLUnitGenerator) : IXmlIO;
Begin
  Result := TXmlIO.Create(AGenerator);
End;

(******************************************************************************)

Constructor TRawIO.Create(AGenerator : IHsUnitGenerator);
Begin
  InHerited Create(True);
  FRawFile := Pointer(AGenerator);
End;

Function TRawIO.GetGenerator() : IHsUnitGenerator;
Begin
  Result := IHsUnitGenerator(FRawFile);
End;

Procedure TRawIO.SaveToFile(Const AFileName : String);
Var X, Y : Integer;
    lByte : Byte;
Begin
  With TMemoryStream.Create() Do
  Try
    lByte := 1;
    WriteBuffer(lByte, SizeOf(lByte));

    lByte := Length(Generator.UnitName);
    WriteBuffer(lByte, SizeOf(lByte));
    WriteBuffer(Generator.UnitName[1], lByte);

    lByte := Generator.ClassDefs.Count;
    WriteBuffer(lByte, SizeOf(lByte));

    For X := 0 To lByte - 1 Do
    Begin
      lByte := Length(Generator.ClassDefs[X].ClsName);
      WriteBuffer(lByte, SizeOf(lByte));
      WriteBuffer(Generator.ClassDefs[X].ClsName[1], lByte);

      lByte := 0;
      If Generator.ClassDefs[X].UseCustomClass Then
        lByte := lByte Or 1;
      If Generator.ClassDefs[X].UseInterface Then
        lByte := lByte Or 2;
      If Generator.ClassDefs[X].MakeList Then
        lByte := lByte Or 4;
      If Generator.ClassDefs[X].TrackChange Then
        lByte := lByte Or 8;
      If Generator.ClassDefs[X].UseStrict Then
        lByte := lByte Or 16;

      WriteBuffer(lByte, SizeOf(lByte));

      lByte := Ord(Generator.ClassDefs[X].DataType);
      WriteBuffer(lByte, SizeOf(lByte));

      lByte := Length(Generator.ClassDefs[X].AdoQueryClassName);
      WriteBuffer(lByte, SizeOf(lByte));
      WriteBuffer(Generator.ClassDefs[X].AdoQueryClassName[1], lByte);

      lByte := Length(Generator.ClassDefs[X].TableName);
      WriteBuffer(lByte, SizeOf(lByte));
      WriteBuffer(Generator.ClassDefs[X].TableName[1], lByte);

      lByte := Generator.ClassDefs[X].PropertyDefs.Count;
      WriteBuffer(lByte, SizeOf(lByte));

      For Y := 0 To lByte - 1 Do
        With Generator.ClassDefs[X] Do
        Begin
          lByte := Length(PropertyDefs[Y].PropertyName);
          WriteBuffer(lByte, SizeOf(lByte));
          WriteBuffer(PropertyDefs[Y].PropertyName[1], lByte);

          lByte := 0;
          If PropertyDefs[Y].IsDataAware Then
            lByte := lByte Or 1;
          If PropertyDefs[Y].IsReadOnly Then
            lByte := lByte Or 2;
          If PropertyDefs[Y].IsId Then
            lByte := lByte Or 4;

          WriteBuffer(lByte, SizeOf(lByte));

          lByte := Length(PropertyDefs[Y].PropertyClass);
          WriteBuffer(lByte, SizeOf(lByte));
          WriteBuffer(PropertyDefs[Y].PropertyClass[1], lByte);

          lByte := Length(PropertyDefs[Y].InterfaceName);
          WriteBuffer(lByte, SizeOf(lByte));
          WriteBuffer(PropertyDefs[Y].InterfaceName[1], lByte);

          lByte := Length(PropertyDefs[Y].InterfaceImplementor);
          WriteBuffer(lByte, SizeOf(lByte));
          WriteBuffer(PropertyDefs[Y].InterfaceImplementor[1], lByte);

          lByte := Length(PropertyDefs[Y].FieldName);
          WriteBuffer(lByte, SizeOf(lByte));
          WriteBuffer(PropertyDefs[Y].FieldName[1], lByte);

          lByte := PropertyDefs[Y].MaxLen;
          WriteBuffer(lByte, SizeOf(lByte));
        End;
    End;

    SaveToFile(AFileName);

    Finally
      Free();
  End;
End;

Procedure TRawIO.LoadFromFile(Const AFileName : String);
Var X, Y : Integer;
    lByte : Byte;
    lStr : String;
Begin
  With TMemoryStream.Create() Do
  Try
    LoadFromFile(AFileName);

    ReadBuffer(lByte, SizeOf(lByte));
    If lByte = 1 Then
    Begin
      ReadBuffer(lByte, SizeOf(lByte));
      SetLength(lStr, lByte);
      ReadBuffer(lStr[1], lByte);
      Generator.UnitName := lStr;

      ReadBuffer(lByte, SizeOf(lByte));
      X := lByte;

      While X > 0 Do
      Begin
        With Generator.ClassDefs.Add() Do
        Begin
          ReadBuffer(lByte, SizeOf(lByte));
          SetLength(lStr, lByte);
          ReadBuffer(lStr[1], lByte);
          ClsName := lStr;

          ReadBuffer(lByte, SizeOf(lByte));
          UseCustomClass := lByte And 1 = 1;
          UseInterface   := lByte And 2 = 2;
          MakeList       := lByte And 4 = 4;
          TrackChange    := lByte And 8 = 8;
          UseStrict      := lByte And 16 = 16;

          ReadBuffer(lByte, SizeOf(lByte));
          DataType := THsDataSource(lByte);

          ReadBuffer(lByte, SizeOf(lByte));
          SetLength(lStr, lByte);
          ReadBuffer(lStr[1], lByte);
          AdoQueryClassName := lStr;

          ReadBuffer(lByte, SizeOf(lByte));
          SetLength(lStr, lByte);
          ReadBuffer(lStr[1], lByte);
          TableName := lStr;

          ReadBuffer(lByte, SizeOf(lByte));
          Y := lByte;

          While Y > 0 Do
          Begin
            With PropertyDefs.Add() Do
            Begin
              ReadBuffer(lByte, SizeOf(lByte));
              SetLength(lStr, lByte);
              ReadBuffer(lStr[1], lByte);
              PropertyName := lStr;

              ReadBuffer(lByte, SizeOf(lByte));

              IsDataAware := lByte And 1 = 1;
              IsReadOnly := lByte And 2 = 2;
              IsId := lByte And 4 = 4;

              ReadBuffer(lByte, SizeOf(lByte));
              SetLength(lStr, lByte);
              ReadBuffer(lStr[1], lByte);
              PropertyClass := lStr;

              ReadBuffer(lByte, SizeOf(lByte));
              SetLength(lStr, lByte);
              ReadBuffer(lStr[1], lByte);
              InterfaceName := lStr;

              ReadBuffer(lByte, SizeOf(lByte));
              SetLength(lStr, lByte);
              ReadBuffer(lStr[1], lByte);
              InterfaceImplementor := lStr;

              ReadBuffer(lByte, SizeOf(lByte));
              SetLength(lStr, lByte);
              ReadBuffer(lStr[1], lByte);
              FieldName := lStr;

              ReadBuffer(lByte, SizeOf(lByte));
              MaxLen := lByte;
            End;

            Dec(Y);
          End;
        End;

        Dec(X);
      End;
    End;  

    Finally
      Free();
  End;
End;

Constructor TJSonIO.Create(AGenerator : IJSonUnitGenerator);
Begin
  InHerited Create(True);

  FJsonFile := Pointer(AGenerator);
  FIsLoading := False;
End;

//-->Dump IJSonUnitGenerator in IHsUnitGenerator
Procedure TJSonIO.SaveTo(Const AUnitGenerator : IHsUnitGenerator);
Var X, Y : Integer;
    lGen : IJSonUnitGenerator;
Begin
  lGen := Generator;
  AUnitGenerator.UnitName := lGen.UnitName;

  AUnitGenerator.TypeDefs.Clear();
  For X := 0 To lGen.TypeDefs.Count - 1 Do
    With AUnitGenerator.TypeDefs.Add() Do
    Begin
      TypeDefName := lGen.TypeDefs[X].TypeDefName;
      TypeDefValue.Text := lGen.TypeDefs[X].TypeDefValue;
      TypeDefType := THsTypeDefType(GetEnumValue(TypeInfo(THsTypeDefType), lGen.TypeDefs[X].TypeDefType));

      For Y := 0 To lGen.TypeDefs[X].TypeDefValues.Count - 1 Do
        With TypeDefMembers.Add() Do
        Begin
          PropertyName := lGen.TypeDefs[X].TypeDefValues[X].PropertyName;
          PropertyType := THsPropertyType(GetEnumValue(TypeInfo(THsPropertyType), lGen.TypeDefs[X].TypeDefValues[X].PropertyType));
        End;
    End;

  AUnitGenerator.ClassDefs.Clear();
  For X := 0 To lGen.ClassDefs.Count - 1 Do
    With AUnitGenerator.ClassDefs.Add() Do
    Begin
      ClsName        := lGen.ClassDefs[X].ClsName;
      UseCustomClass := lGen.ClassDefs[X].Settings.UseCustomClass;
      UseInterface   := lGen.ClassDefs[X].Settings.UseInterface;
      UseStrict      := lGen.ClassDefs[X].Settings.UseStrict;
      MakeList       := lGen.ClassDefs[X].Settings.MakeList;
      TrackChange    := lGen.ClassDefs[X].Settings.TrackChange;
      DataType       := THsDataSource(GetEnumValue(TypeInfo(THsDataSource), lGen.ClassDefs[X].Settings.SettingDataType));

      AdoQueryClassName := lGen.ClassDefs[X].MsSQLSettings.AdoQueryClassName;
      TableName         := lGen.ClassDefs[X].MsSQLSettings.TableName;

      For Y := 0 To lGen.ClassDefs[X].Properties.Count - 1 Do
      Begin
        With PropertyDefs.Add() Do
        Begin
          PropertyName := lGen.ClassDefs[X].Properties[Y].PropertyName;
          PropertyType := THsPropertyType(GetEnumValue(TypeInfo(THsPropertyType), lGen.ClassDefs[X].Properties[Y].PropertyType));
          IsDataAware  := lGen.ClassDefs[X].Properties[Y].IsDataAware;
          IsReadOnly   := lGen.ClassDefs[X].Properties[Y].IsReadOnly;

          PropertyClass := lGen.ClassDefs[X].Properties[Y].PropertyClass;

          InterfaceName := lGen.ClassDefs[X].Properties[Y].InterfaceName;
          InterfaceImplementor := lGen.ClassDefs[X].Properties[Y].InterfaceImplementor;

          IsId          := lGen.ClassDefs[X].Properties[Y].IsId;
          FieldName     := lGen.ClassDefs[X].Properties[Y].FieldName;

          MaxLen        := lGen.ClassDefs[X].Properties[Y].MaxLen;
        End;
      End;

      For Y := 0 To lGen.ClassDefs[X].Procedures.Count - 1 Do
      Begin
        With ProcedureDefs.Add() Do
        Begin
          ProcedureType := lGen.ClassDefs[X].Procedures[Y].ProcedureType;
          ProcedureDef  := lGen.ClassDefs[X].Procedures[Y].ProcedureDef;
          ProcedureImpl.Text := lGen.ClassDefs[X].Procedures[Y].ProcedureImpl;
        End;
      End;
    End;
End;

//-->Dump IHsUnitGenerator in IJSonUnitGenerator
Procedure TJSonIO.LoadFrom(Const AUnitGenerator : IHsUnitGenerator);
Var X, Y : Integer;
    lGen : IJSonUnitGenerator;
Begin
  If Not FIsLoading Then
  Begin
    FIsLoading := True;
    Try
      lGen := Generator;
      lGen.UnitName := AUnitGenerator.UnitName;

      lGen.TypeDefs.Clear();
      If lGen.TypeDefs.Count = 0 Then
        For X := 0 To AUnitGenerator.TypeDefs.Count - 1 Do
          With lGen.TypeDefs.Add() Do
          Begin
            TypeDefName  := AUnitGenerator.TypeDefs[X].TypeDefName;
            TypeDefValue := AUnitGenerator.TypeDefs[X].TypeDefValue.Text;
            TypeDefType  := GetEnumName(TypeInfo(THsTypeDefType), Ord(AUnitGenerator.TypeDefs[X].TypeDefType));

            For Y := 0 To AUnitGenerator.TypeDefs[X].TypeDefMembers.Count - 1 Do
              With TypeDefValues.Add() Do
              Begin
                PropertyName := AUnitGenerator.TypeDefs[X].TypeDefMembers[Y].PropertyName;
                PropertyType := GetEnumName(TypeInfo(THsPropertyType), Ord(AUnitGenerator.TypeDefs[X].TypeDefMembers[Y].PropertyType));
              End;
          End;

      lGen.ClassDefs.Clear();
      If lGen.ClassDefs.Count = 0 Then
        For X := 0 To AUnitGenerator.ClassDefs.Count - 1 Do
          With lGen.ClassDefs.Add() Do
          Begin
            ClsName := AUnitGenerator.ClassDefs[X].ClsName;

            Settings.UseCustomClass  := AUnitGenerator.ClassDefs[X].UseCustomClass;
            Settings.UseInterface    := AUnitGenerator.ClassDefs[X].UseInterface;
            Settings.UseStrict       := AUnitGenerator.ClassDefs[X].UseStrict;
            Settings.MakeList        := AUnitGenerator.ClassDefs[X].MakeList;
            Settings.TrackChange     := AUnitGenerator.ClassDefs[X].TrackChange;
            Settings.SettingDataType := GetEnumName(TypeInfo(THsDataSource), Ord(AUnitGenerator.ClassDefs[X].DataType));

            MsSQLSettings.AdoQueryClassName := AUnitGenerator.ClassDefs[X].AdoQueryClassName;
            MsSQLSettings.TableName         := AUnitGenerator.ClassDefs[X].TableName;

            For Y := 0 To AUnitGenerator.ClassDefs[X].PropertyDefs.Count - 1 Do
            Begin
              With Properties.Add() Do
              Begin
                PropertyName := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].PropertyName;
                PropertyType := GetEnumName(TypeInfo(THsPropertyType), Ord(AUnitGenerator.ClassDefs[X].PropertyDefs[Y].PropertyType));
                IsDataAware  := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].IsDataAware;
                IsReadOnly   := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].IsReadOnly;

                PropertyClass := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].PropertyClass;

                InterfaceName := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].InterfaceName;
                InterfaceImplementor := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].InterfaceImplementor;

                IsId       := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].IsId;
                FieldName  := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].FieldName;

                MaxLen     := AUnitGenerator.ClassDefs[X].PropertyDefs[Y].MaxLen;
              End;
            End;

            For Y := 0 To AUnitGenerator.ClassDefs[X].ProcedureDefs.Count - 1 Do
            Begin
              With Procedures.Add() Do
              Begin
                ProcedureType := AUnitGenerator.ClassDefs[X].ProcedureDefs[Y].ProcedureType;
                ProcedureDef  := AUnitGenerator.ClassDefs[X].ProcedureDefs[Y].ProcedureDef;
                ProcedureImpl := AUnitGenerator.ClassDefs[X].ProcedureDefs[Y].ProcedureImpl.Text;
              End;
            End;
          End;

      Finally
        FIsLoading := False;
    End;
  End;
End;

Function TJSonIO.GetGenerator() : IJSonUnitGenerator;
Begin
  Result := IJSonUnitGenerator(FJsonFile);
End;

Constructor TXMLIO.Create(AGenerator : IXMLUnitGenerator);
Begin
  InHerited Create(True);

  FXmlFile := Pointer(AGenerator);
  FIsLoading := False;
End;

//-->Dump IXMLUnitGenerator in IHsUnitGenerator
Procedure TXMLIO.SaveTo(Const AUnitGenerator : IHsUnitGenerator);
Var X, Y : Integer;
    lPos : Integer;
Begin
  AUnitGenerator.UnitName := Generator.UnitName;

  For X := 0 To Generator.TypeDefs.Count - 1 Do
    With AUnitGenerator.TypeDefs.Add() Do
    Begin
      TypeDefType := THsTypeDefType(GetEnumValue(TypeInfo(THsTypeDefType), Generator.TypeDefs[X].TypeDefType));
      TypeDefValue.Text := Generator.TypeDefs[X].TypeDefValue;
      TypeDefName := Generator.TypeDefs[X].TypeDefName;

      For Y := 0 To Generator.TypeDefs[X].TypeDefValues.Count - 1 Do
      Begin
        With TypeDefMembers.Add() Do
        Begin
          PropertyName := Generator.TypeDefs[X].TypeDefValues[Y].Name;
          PropertyType := THsPropertyType(GetEnumValue(TypeInfo(THsPropertyType), Generator.TypeDefs[X].TypeDefValues[Y].PropertyType));
        End;
      End;
    End;

  AUnitGenerator.ClassDefs.Clear();
  For X := 0 To Generator.ClassDefs.Count - 1 Do
    With AUnitGenerator.ClassDefs.Add() Do
    Begin
      ClsName        := Generator.ClassDefs[X].Name;
      InHeritsFrom   := Generator.ClassDefs[X].Settings.InHeritsFrom;
      UseCustomClass := Generator.ClassDefs[X].Settings.UseCustomClass;
      UseInterface   := Generator.ClassDefs[X].Settings.UseInterface;
      UseStrict      := Generator.ClassDefs[X].Settings.UseStrict;
      MakeList       := Generator.ClassDefs[X].Settings.MakeList;
      TrackChange    := Generator.ClassDefs[X].Settings.TrackChange;
      DataType       := THsDataSource(GetEnumValue(TypeInfo(THsDataSource), Generator.ClassDefs.Items[X].Settings.DataType));

      AdoQueryClassName := Generator.ClassDefs[X].MsSQLSettings.AdoQueryClassName;
      TableName         := Generator.ClassDefs[X].MsSQLSettings.TableName;

      For Y := 0 To Generator.ClassDefs.Items[X].Properties.Count - 1 Do
      Begin
        With PropertyDefs.Add() Do
        Begin
          PropertyName := Generator.ClassDefs[X].Properties[Y].Name;
          PropertyType := THsPropertyType(GetEnumValue(TypeInfo(THsPropertyType), Generator.ClassDefs.Items[X].Properties[Y].PropertyType));
          IsDataAware  := Generator.ClassDefs[X].Properties[Y].IsDataAware;
          IsReadOnly   := Generator.ClassDefs[X].Properties[Y].IsReadOnly;

          PropertyClass := Generator.ClassDefs[X].Properties[Y].PropertyClass;

          InterfaceName := Generator.ClassDefs[X].Properties[Y].InterfaceName;
          InterfaceImplementor := Generator.ClassDefs[X].Properties[Y].InterfaceImplementor;

          IsId          := Generator.ClassDefs[X].Properties[Y].IsId;
          FieldName     := Generator.ClassDefs[X].Properties[Y].FieldName;

          MaxLen        := Generator.ClassDefs[X].Properties[Y].MaxLen;
          IsBigEndian   := Generator.ClassDefs[X].Properties[Y].IsBigEndian;
        End;
      End;

      For Y := 0 To Generator.ClassDefs[X].ProcedureDefs.Count - 1 Do
      Begin
        With ProcedureDefs.Add() Do
        Begin
          ProcedureParameters := Generator.ClassDefs[X].ProcedureDefs[Y].ProcedureParameters;
          ProcedureName       := Generator.ClassDefs[X].ProcedureDefs[Y].ProcedureName;
          ProcedureDef        := Generator.ClassDefs[X].ProcedureDefs[Y].ProcedureDef;
          ResultType          := THsFunctionResultType(GetEnumValue(TypeInfo(THsFunctionResultType), Generator.ClassDefs[X].ProcedureDefs[Y].ResultType));
          ProcedureScope      := THsFunctionScope(GetEnumValue(TypeInfo(THsFunctionScope), Generator.ClassDefs[X].ProcedureDefs[Y].ProcedureScope));
          ProcedureImpl.Text  := Generator.ClassDefs[X].ProcedureDefs[Y].ProcedureImpl;
          IsVirtual           := Generator.ClassDefs[X].ProcedureDefs[Y].IsVirtual;
          IsAbstract          := Generator.ClassDefs[X].ProcedureDefs[Y].IsAbstract;
          IsOverRide          := Generator.ClassDefs[X].ProcedureDefs[Y].IsOverRide;
          IsReintroduce       := Generator.ClassDefs[X].ProcedureDefs[Y].IsReIntroduce;
          IsOverLoad          := Generator.ClassDefs[X].ProcedureDefs[Y].IsOverLoad;
          IsFinal             := Generator.ClassDefs[X].ProcedureDefs[Y].IsFinal;
          IsFinal             := Generator.ClassDefs[X].ProcedureDefs[Y].IsFinal;
          IsStatic            := Generator.ClassDefs[X].ProcedureDefs[Y].IsStatic;
          ShowInInterface     := Generator.ClassDefs[X].ProcedureDefs[Y].ShowInInterface;
        End;
      End;

      With Generator.ClassDefs[X].ListSettings Do
      Begin
        ListSettings.UseStrict      := UseStrict;
        ListSettings.UseEnumerator  := UseEnumerator;
        ListSettings.UseNestedClass := UseNestedClass;
        ListSettings.IsSealed       := IsSealed;
        ListSettings.Methods.Clear();

        For Y := 0 To Generator.ClassDefs[X].ListSettings.Methods.Count - 1 Do
        Begin
          With ListSettings.Methods.Add() Do
          Begin
            ProcedureParameters := Generator.ClassDefs[X].ListSettings.Methods[Y].ProcedureParameters;
            ProcedureName       := Generator.ClassDefs[X].ListSettings.Methods[Y].ProcedureName;
            ProcedureDef        := Generator.ClassDefs[X].ListSettings.Methods[Y].ProcedureDef;
            ResultType          := THsFunctionResultType(GetEnumValue(TypeInfo(THsFunctionResultType), Generator.ClassDefs[X].ListSettings.Methods[Y].ResultType));
            ProcedureScope      := THsFunctionScope(GetEnumValue(TypeInfo(THsFunctionScope), Generator.ClassDefs[X].ListSettings.Methods[Y].ProcedureScope));
            ProcedureImpl.Text  := Generator.ClassDefs[X].ListSettings.Methods[Y].ProcedureImpl;
            IsVirtual           := Generator.ClassDefs[X].ListSettings.Methods[Y].IsVirtual;
            IsAbstract          := Generator.ClassDefs[X].ListSettings.Methods[Y].IsAbstract;
            IsOverRide          := Generator.ClassDefs[X].ListSettings.Methods[Y].IsOverRide;
            IsReintroduce       := Generator.ClassDefs[X].ListSettings.Methods[Y].IsReIntroduce;
            IsOverLoad          := Generator.ClassDefs[X].ListSettings.Methods[Y].IsOverLoad;
            IsFinal             := Generator.ClassDefs[X].ListSettings.Methods[Y].IsFinal;
            IsStatic            := Generator.ClassDefs[X].ListSettings.Methods[Y].IsStatic;
            IsInline            := Generator.ClassDefs[X].ListSettings.Methods[Y].IsInLine;
            ShowInInterface     := Generator.ClassDefs[X].ListSettings.Methods[Y].ShowInInterface;
          End;
        End;
      End;
    End;
End;

//-->Dump IHsUnitGenerator in IXMLUnitGenerator
Procedure TXMLIO.LoadFrom(Const AUnitGenerator : IHsUnitGenerator);
Var X, Y : Integer;
    lGen : IXMLUnitGenerator;
Begin
  If Not FIsLoading Then
  Begin
    FIsLoading := True;
    Try
      lGen := Generator;
      lGen.UnitName := AUnitGenerator.UnitName;

      lGen.TypeDefs.Clear();
      For X := 0 To AUnitGenerator.TypeDefs.Count - 1 Do
      Begin
        With lGen.TypeDefs.Add() Do
        Begin
          TypeDefType  := GetEnumName(TypeInfo(THsTypeDefType), Ord(AUnitGenerator.TypeDefs[X].TypeDefType));
          TypeDefValue := AUnitGenerator.TypeDefs[X].TypeDefValue.Text;
          TypeDefName  := AUnitGenerator.TypeDefs[X].TypeDefName;

          For Y := 0 To AUnitGenerator.TypeDefs[X].TypeDefMembers.Count - 1 Do
          Begin
            With TypeDefValues.Add() Do
            Begin
              Name := AUnitGenerator.TypeDefs[X].TypeDefMembers[Y].PropertyName;
              PropertyType := GetEnumName(TypeInfo(THsPropertyType), Ord(AUnitGenerator.TypeDefs[X].TypeDefMembers[Y].PropertyType))
            End;
          End;
        End;
      End;

      lGen.ClassDefs.Clear();
      For X := 0 To AUnitGenerator.ClassDefs.Count - 1 Do
      Begin
        With lGen.ClassDefs.Add() Do
        Begin
          Name         := AUnitGenerator.ClassDefs[X].ClsName;

          Settings.InHeritsFrom   := AUnitGenerator.ClassDefs[X].InHeritsFrom;
          Settings.UseCustomClass := AUnitGenerator.ClassDefs[X].UseCustomClass;
          Settings.UseInterface   := AUnitGenerator.ClassDefs[X].UseInterface;
          Settings.UseStrict      := AUnitGenerator.ClassDefs[X].UseStrict;
          Settings.MakeList       := AUnitGenerator.ClassDefs[X].MakeList;
          Settings.TrackChange    := AUnitGenerator.ClassDefs[X].TrackChange;
          Settings.DataType       := GetEnumName(TypeInfo(THsDataSource), Ord(AUnitGenerator.ClassDefs[X].DataType));

          If AUnitGenerator.ClassDefs[X].DataType = dsMSSql Then
          Begin
            MsSQLSettings.AdoQueryClassName := AUnitGenerator.ClassDefs[X].AdoQueryClassName;
            MsSQLSettings.TableName         := AUnitGenerator.ClassDefs[X].TableName;
          End;

          For Y := 0 To AUnitGenerator.ClassDefs[X].PropertyDefs.Count - 1 Do
          Begin
            With Properties.Add(), AUnitGenerator.ClassDefs[X] Do
            Begin
              Name := PropertyDefs[Y].PropertyName;
              PropertyType := GetEnumName(TypeInfo(THsPropertyType), Ord(PropertyDefs[Y].PropertyType));
              IsReadOnly  := PropertyDefs[Y].IsReadOnly;

              If PropertyDefs[Y].PropertyType = ptClass Then
                PropertyClass := PropertyDefs[Y].PropertyClass;

              If PropertyDefs[Y].PropertyType = ptInterface Then
              Begin
                InterfaceName := PropertyDefs[Y].InterfaceName;
                InterfaceImplementor := PropertyDefs[Y].InterfaceImplementor;
              End;

              //If AUnitGenerator.ClassDefs[X].DataType = dsNone Then //?!? -> 20-07-2018
                IsDataAware := PropertyDefs[Y].IsDataAware;

              If AUnitGenerator.ClassDefs[X].DataType = dsMSSql Then
              Begin
                IsId := PropertyDefs[Y].IsId;
                FieldName := PropertyDefs[Y].FieldName;
              End;
              
              If PropertyDefs[Y].PropertyType In [ptString, ptWideString, ptPAnsiChar, ptPWideChar] Then
                MaxLen := PropertyDefs[Y].MaxLen;

              If PropertyDefs[Y].PropertyType In [ptWord, ptDWord, ptQWord] Then
                IsBigEndian := PropertyDefs[Y].IsBigEndian;
            End;
          End;

          For Y := 0 To AUnitGenerator.ClassDefs[X].ProcedureDefs.Count - 1 Do
          Begin
            With ProcedureDefs.Add(), AUnitGenerator.ClassDefs[X] Do
            Begin
              ProcedureParameters := ProcedureDefs[Y].ProcedureParameters;
              ProcedureName       := ProcedureDefs[Y].ProcedureName;
              ProcedureImpl       := ProcedureDefs[Y].ProcedureImpl.Text;
              ResultType          := GetEnumName(TypeInfo(THsFunctionResultType), Ord(ProcedureDefs[Y].ResultType));
              ProcedureScope      := GetEnumName(TypeInfo(THsFunctionScope), Ord(ProcedureDefs[Y].ProcedureScope));
              IsVirtual           := ProcedureDefs[Y].IsVirtual;
              IsAbstract          := ProcedureDefs[Y].IsAbstract;
              IsOverRide          := ProcedureDefs[Y].IsOverRide;
              IsReintroduce       := ProcedureDefs[Y].IsReIntroduce;
              IsOverLoad          := ProcedureDefs[Y].IsOverLoad;
              IsFinal             := ProcedureDefs[Y].IsFinal;
              IsStatic            := ProcedureDefs[Y].IsStatic;
              IsInline            := ProcedureDefs[Y].IsInLine;
              ShowInInterface     := ProcedureDefs[Y].ShowInInterface;
            End;
          End;

          If AUnitGenerator.ClassDefs[X].MakeList Then
            With AUnitGenerator.ClassDefs[X].ListSettings Do
            Begin
              ListSettings.UseStrict      := UseStrict;
              ListSettings.UseEnumerator  := UseEnumerator;
              ListSettings.UseNestedClass := UseNestedClass;
              ListSettings.IsSealed       := IsSealed;
              ListSettings.Methods.Clear();

              For Y := 0 To AUnitGenerator.ClassDefs[X].ListSettings.Methods.Count - 1 Do
              Begin
                With ListSettings.Methods.Add() Do
                Begin
                  ProcedureParameters := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].ProcedureParameters;
                  ProcedureName       := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].ProcedureName;
                  ProcedureImpl       := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].ProcedureImpl.Text;
                  ResultType          := GetEnumName(TypeInfo(THsFunctionResultType), Ord(AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].ResultType));
                  ProcedureScope      := GetEnumName(TypeInfo(THsFunctionScope), Ord(AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].ProcedureScope));
                  IsVirtual           := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].IsVirtual;
                  IsAbstract          := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].IsAbstract;
                  IsOverRide          := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].IsOverRide;
                  IsReintroduce       := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].IsReIntroduce;
                  IsOverLoad          := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].IsOverLoad;
                  IsFinal             := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].IsFinal;
                  IsStatic            := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].IsStatic;
                  IsInline            := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].IsInLine;
                  ShowInInterface     := AUnitGenerator.ClassDefs[X].ListSettings.Methods[Y].ShowInInterface;
                End;
              End;
            End;
        End;
      End;

      Finally
        FIsLoading := False;
    End;
  End;
End;

Function TXMLIO.GetGenerator() : IXMLUnitGenerator;
Begin
  Result := IXMLUnitGenerator(FXmlFile);
End;

end.
