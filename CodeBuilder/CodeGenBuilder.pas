unit CodeGenBuilder;

interface

Uses SuperObject, XMLIntf, CodeGenType, CodeGenImpl, CodeGenIntf, MsSqlOptionIntf;

Type
  TCodeGenBuilder = Class(THsCustomGenerator)
  Strict Private
    Class Function InternalAddTypeDef(AGen : IHsUnitGenerator) : IHsTypeDef;
    Class Function InternalAddClassDef(AGen : IHsUnitGenerator) : IHsClassCodeGenerator;
    Class Function InternalAddPropertyDef(AClsDef : IHsClassCodeGenerator) : IHsPropertyDef;
    Class Function InternalAddProcedureDef(AClsDef : IHsClassCodeGenerator) : IHsProcedureDef;

    Class Procedure LoadMsSql(AOut : IHsUnitGenerator);
    Class Procedure LoadJSon(AIn : ISuperObject; AOut : IHsUnitGenerator);
    Class Procedure LoadXml(AIn : IXMLDocument; AOut : IHsUnitGenerator);
    Class Procedure LoadHexEditTemplate(AIn : IXmlDocument; AOut : IHsUnitGenerator);

  Public Class Var
    FDlgOptions : IMsSqlOptions;

  Public
    Class Function InitGenerator(Const ADataType : THsDataSource; AOut : IHsUnitGenerator; Const AFileName : String = '') : Boolean;

  End;

implementation

Uses Dialogs,
  Controls, AdoDb, AdoInt, SysUtils, Forms, TypInfo,
  HEBinFileFormatImpl,
  Classes, HsSuperObjectEx, MsSqlCfgDlg, XmlDoc, CodeGen.VT;

Class Function TCodeGenBuilder.InitGenerator(Const ADataType : THsDataSource; AOut : IHsUnitGenerator; Const AFileName : String = '') : Boolean;
Var lSO  : ISuperObject;
    lXml : IXMLDocument;
    lNbClsDef : Integer;
Begin
  Result := False;

  If Assigned(AOut) Then
  Begin
    lNbClsDef := AOut.ClassDefs.Count;
    
    Case ADataType Of
      dsMSSql :
      Begin
        LoadMsSql(AOut);
      End;
    
      dsXML :
      Begin
        lXml := LoadXMLDocument(AFileName);
        Try
          If Assigned(lXml.ChildNodes.FindNode('binary_file_format')) Then
            LoadHexEditTemplate(lXml, AOut)
          Else
            LoadXml(lXml, AOut);

          Finally
            lXml := Nil;
        End;
      End;

      dsJSon :
      Begin
        lSO := TSuperObject.ParseFile(AFileName, True);
        Try
          LoadJSon(lSO, AOut);
        
          Finally
            lSO := Nil;
        End;
      End;

      Else //dsNone, dsFile
        Raise Exception.Create('DataType not supported : ' + GetEnumName(TypeInfo(THsDataSource), Ord(ADataType)));
    End;

    Result := AOut.ClassDefs.Count > lNbClsDef;
  End;
End;

Class Function TCodeGenBuilder.InternalAddClassDef(AGen : IHsUnitGenerator) : IHsClassCodeGenerator;
Var lVTGen : IHsVTUnitGeneratorNode;
Begin
  If Supports(AGen, IHsVTUnitGeneratorNode, lVTGen) Then
    Result := lVTGen.ClassDefs.Add()
  Else
    Result := AGen.ClassDefs.Add();
End;

Class Function TCodeGenBuilder.InternalAddTypeDef(AGen : IHsUnitGenerator) : IHsTypeDef;
Var lVTGen : IHsVTUnitGeneratorNode;
Begin
  If Supports(AGen, IHsVTUnitGeneratorNode, lVTGen) Then
    Result := lVTGen.TypeDefs.Add()
  Else
    Result := AGen.TypeDefs.Add();
End;

Class Function TCodeGenBuilder.InternalAddPropertyDef(AClsDef : IHsClassCodeGenerator) : IHsPropertyDef;
Var lVTClsDef : IHsVTClassCodeGeneratorNode;
Begin
  If Supports(AClsDef, IHsVTClassCodeGeneratorNode, lVTClsDef) Then
    Result := lVTClsDef.PropertyDefs.Add()
  Else
    Result := AClsDef.PropertyDefs.Add();
End;

Class Function TCodeGenBuilder.InternalAddProcedureDef(AClsDef : IHsClassCodeGenerator) : IHsProcedureDef;
Var lVTClsDef : IHsVTClassCodeGeneratorNode;
Begin
  If Supports(AClsDef, IHsVTClassCodeGeneratorNode, lVTClsDef) Then
    Result := lVTClsDef.ProcedureDefs.Add()
  Else
    Result := AClsDef.ProcedureDefs.Add();
End;

Class Procedure TCodeGenBuilder.LoadMsSql(AOut : IHsUnitGenerator);
Var lTblList : TStringList;
    lStr     : String;
    X        : Integer;
    lClass   : IHsClassCodeGenerator;
Begin
  With TFrmMsSqlCfg.Create(Nil) Do
  Try
    DlgOptions := FDlgOptions;
    
    If ShowModal() = mrOK Then
    Begin
      lTblList := TStringList.Create();
      Try
        GetSelectedTables(lTblList);

        If lTblList.Count > 0 Then
        Begin
          lStr := '';
          For X := 0 To lTblList.Count - 1 Do
          Begin
            lStr := lStr + AnsiQuotedStr(lTblList[X], '''');
            If X < lTblList.Count - 1 Then
              lStr := lStr + ', ';
          End;

          With TAdoQuery.Create(Nil) Do
          Try
            ConnectionString := ConnStr;
            Sql.Text := 'Select Cast(Row_Number() Over (Order By st.Name, sc.Column_Id) As Int)RowId, sc.Column_Id ColId, ss.Name SchemaName,  st.Name TableName, sc.Name FieldName,'#$D#$A +
                        '  Case When sc.System_Type_Id In (167, 231) Then sc.Max_Length Else 0 End MaxLen,'#$D#$A +
                        '  Case When sc.System_Type_Id In (52, 56, 127) Then '#$D#$A +
                        '    Case When Is_Identity = 1 Then ''ptAutoInc'' Else ''ptInteger'' End'#$D#$A +
                        '  When sc.System_Type_Id In (35, 167, 231) Then ''ptString'''#$D#$A +
                        '  When sc.System_Type_Id In (40, 58, 61) Then ''ptDateTime'''#$D#$A +
                        '  When sc.System_Type_Id = 62 Then ''ptDouble'''#$D#$A +
                        '  When sc.System_Type_Id = 104 Then ''ptBoolean'''#$D#$A +
                        '  When sc.System_Type_Id = 60 Then ''ptCurrency'''#$D#$A +
                        '  When sc.System_Type_Id = 175 Then ''ptChar'''#$D#$A +
                        '  When sc.System_Type_Id = 36 Then ''ptGUID'''#$D#$A +
                        '  Else ''ptVariant'' End FieldType, '#$D#$A +
                        '  IsPrimaryKey, IsForeingKey'#$D#$A +
                        'From sys.Columns sc'#$D#$A +
                        'Inner Join sys.Tables st On st.Object_Id = sc.Object_Id'#$D#$A +
                        'Inner Join sys.Schemas ss On ss.Schema_Id = st.Schema_Id'#$D#$A +
                        'Cross Apply ('#$D#$A +
                        '  Select Cast(Case When Count(*) > 0 Then 1 Else 0 End As Bit)'#$D#$A +
                        '  From sys.Key_Constraints sk'#$D#$A +
                        '  Inner Join sys.index_columns si On si.Object_Id = sk.Parent_Object_Id And si.Index_Id = sk.Unique_Index_Id'#$D#$A +
                        '  Where sk.Parent_Object_Id = st.Object_Id And si.Column_Id = sc.Column_Id'#$D#$A +
                        ') pk (IsPrimaryKey)'#$D#$A +
                        'Cross Apply ('#$D#$A +
                        '  Select Count(*)'#$D#$A +
                        '  From sys.Foreign_Keys fk'#$D#$A +
                        '  Inner Join sys.Foreign_Key_Columns fkc On fkc.Constraint_Object_Id = fk.Object_Id'#$D#$A +
                        '  Where fk.Parent_Object_Id = st.Object_Id And Parent_Column_Id = sc.Column_Id'#$D#$A +
                        ') fk (IsForeingKey)'#$D#$A +
                        'Where st.Name In (' + lStr + ')';
            Open();

            lStr := '';
            While Not Eof Do
            Begin
              If lStr <> FieldByName('TableName').AsString Then
              Begin
                lStr := FieldByName('TableName').AsString;
                lClass := InternalAddClassDef(AOut);
                //AOut.ClassDefs.Add();

                With lClass Do
                Begin
                  TableName         := lStr;
                  ClsName           := StringReplace(TableName, '_', '', [rfReplaceAll]);
                  UseCustomClass    := True;
                  UseInterface      := False;
                  DataType          := dsMSSql;
                  AdoQueryClassName := 'TAdoQuery';
                  TrackChange       := True;
                  MakeList          := True;
                End;
              End;

              //With lClass.PropertyDefs.Add() Do
              With InternalAddPropertyDef(lClass) Do
              Begin
                IsId         := FieldByName('IsPrimaryKey').AsBoolean;
                FieldName    := FieldByName('FieldName').AsString;
                PropertyName := StringReplace(FieldName, '_', '', [rfReplaceAll]);
                PropertyType := THsPropertyType(GetEnumValue(TypeInfo(THsPropertyType), FieldByName('FieldType').AsString));
                MaxLen       := FieldByName('MaxLen').AsInteger;
                IsDataAware  := True;
                IsReadOnly   := IsId;
              End;

              Next();
            End;

            Finally
              Close();
              Free();
          End;
        End;

        Finally
          lTblList.Free();
      End;
    End;

    Finally
      Free();
  End;
End;

Class Procedure TCodeGenBuilder.LoadJSon(AIn : ISuperObject; AOut : IHsUnitGenerator);
Var lGen : IHsUnitGenerator Absolute AOut;

  Procedure InternalInitGenerator(AIn : ISuperObject; AOut : IHsClassCodeGenerator);
  Const
    lHsType : Array[TSuperType] Of THsPropertyType = (
      THsPropertyType(-1), ptBoolean, ptDouble, ptCurrency, ptInteger,
      ptObject, THsPropertyType(-1), ptString, THsPropertyType(-1)
    );

  Var lIte : TSuperObjectIter;
      lClsDef : IHsClassCodeGenerator;
  Begin
    If ObjectFindFirstEx(AIn, lIte) = 0 Then
    Try
      Repeat
        Case lIte.val.DataType Of
          stBoolean..stInt, stString :
          Begin
            With InternalAddPropertyDef(AOut) Do
            Begin
              PropertyName := lIte.key;
              PropertyType := lHsType[lIte.val.DataType];
            End;
          End;

          stArray :
          Begin
            If AIn.A[lIte.key].Length > 0 Then
              Case AIn.A[lIte.key][0].DataType Of
                stObject :
                Begin
                  With InternalAddPropertyDef(AOut) Do
                  Begin
                    PropertyName  := lIte.key;
                    PropertyType  := ptInterface;
                    InterfaceName := 'I' + lIte.key + 's';
                    InterfaceImplementor := 'T' + lIte.key + 's';
                    IsReadOnly    := True;
                  End;

                  lClsDef := InternalAddClassDef(lGen);
                  lClsDef.ClsName := lIte.key;
                  lClsDef.DataType := dsJSon;
                  lClsDef.MakeList := True;
                  InternalInitGenerator(AIn.A[lIte.key][0], lClsDef);
                End;
              End;
          End;

          stObject :
          Begin
            lClsDef := InternalAddClassDef(lGen);
            lClsDef.ClsName := lIte.key;
            lClsDef.DataType := dsJSon;
            InternalInitGenerator(lIte.val, lClsDef);
          End;
        End;
      Until ObjectFindNextEx(lIte) <> 0;

      Finally
        ObjectFindClose(lIte);
    End;
  End;

Var lClsDef : IHsClassCodeGenerator;
Begin
  If Assigned(lGen) Then
  Begin
    lClsDef := InternalAddClassDef(lGen);
    lClsDef.DataType := dsJSon;
    InternalInitGenerator(AIn, lClsDef);

    If lClsDef.PropertyDefs.Count = 0 Then
      lGen.ClassDefs.Delete(lClsDef);
  End;
End;

Class Procedure TCodeGenBuilder.LoadXml(AIn : IXMLDocument; AOut : IHsUnitGenerator);
Begin

End;

Class Procedure TCodeGenBuilder.LoadHexEditTemplate(AIn : IXmlDocument; AOut : IHsUnitGenerator);
Var lGen : IHsUnitGenerator Absolute AOut;
    lLstFor : TStringList;

  Function IsNumeric(AString : String) : Boolean;
  Var X : Integer;
  Begin
    Result := True;

    For X := 1 To Length(AString) Do
    Begin
      If Not (AString[X] In [#$30..#$39]) Then
      Begin
        Result := False;
        Break;
      End;
    End;
  End;

  Function FindNodeData(AStartPoint : IXMLNode; ADataName : String) : IXMLData;
  Var X : Integer;
      lData : IXMLData;
  Begin
    Result := Nil;

    For X := 0 To AStartPoint.ChildNodes.Count - 1 Do
      If Supports(AStartPoint.ChildNodes[X], IXMLData, lData) And
         SameText(lData.Name, ADataName) Then
      Begin
        Result := lData;
        Break;
      End;
  End;

  Procedure BuildStreamCode(AIn : IXmlNode; AClassDef : IHsClassCodeGenerator);
  Var X          : Integer;
      lData      ,
      lData2     : IXmlData;
      lUseStruct : IXmlUseStruct;
      lFor       : IXmlFor;

      lLoad    ,
      lSave    : IHsProcedureDef;

      lLoadStr ,
      lSaveStr : String;
      lTmpList : TStringList;

//      lDbgNode : IXmlNode;
  Begin
    lTmpList := TStringList.Create();
    Try
      lLoad := InternalAddProcedureDef(AClassDef);
      lSave := InternalAddProcedureDef(AClassDef);

      lLoad.ProcedureType := 1;
      lLoad.ProcedureDef := 'LoadFromStream(ASource : IStreamEx);';
      lLoad.ProcedureImpl.Add('Begin');

      lSave.ProcedureType := 1;
      lSave.ProcedureDef := 'SaveToStream(ATarget : IStreamEx);';

      For X := 0 To AIn.ChildNodes.Count - 1 Do
        If Supports(AIn.ChildNodes[X], IXmlFor) Then
        Begin
          lSave.ProcedureImpl.Add('Var X : Integer;');
          Break;
        End;
      lSave.ProcedureImpl.Add('Begin');

      For X := 0 To AIn.ChildNodes.Count - 1 Do
//      Begin
//        lDbgNode := AIn.ChildNodes[X];
//        ShowMessage(lDbgNode.XML);
//      End;
//Exit;
        If Supports(AIn.ChildNodes[X], IXmlData, lData) Then
        Begin
          lLoadStr := PadL('', 2) + 'F' + lData.Name + ':=ASource.';
          lSaveStr := PadL('', 2) + 'ATarget.';

          If SameText(lData.DataType, 'int') Then
            Case StrToIntDef(lData.Len, 1) Of
              1 :
              Begin
                lLoadStr := lLoadStr + 'ReadByte();';
                lSaveStr := lSaveStr + 'WriteByte(F' + lData.Name + ');';
              End;

              2 :
              Begin
                If SameText(lData.ByteOrder, 'Big') Then
                Begin
                  lLoadStr := lLoadStr + 'ReadWord(True);';
                  lSaveStr := lSaveStr + 'WriteWord(F' + lData.Name + ', True);';
                End
                Else
                Begin
                  lLoadStr := lLoadStr + 'ReadWord();';
                  lSaveStr := lSaveStr + 'WriteWord(F' + lData.Name + ');';
                End;
              End;

              4 :
              Begin
                If SameText(lData.ByteOrder, 'Big') Then
                Begin
                  lLoadStr := lLoadStr + 'ReadDWord(True);';
                  lSaveStr := lSaveStr + 'WriteDWord(F' + lData.Name + ', True);';
                End
                Else
                Begin
                  lLoadStr := lLoadStr + 'ReadDWord();';
                  lSaveStr := lSaveStr + 'WriteDWord(F' + lData.Name + ');';
                End;
              End;

              8 :
              Begin
                If SameText(lData.ByteOrder, 'Big') Then
                Begin
                  lLoadStr := lLoadStr + 'ReadInt64(True);';
                  lSaveStr := lSaveStr + 'WriteInt64(F' + lData.Name + ', True);';
                End
                Else
                Begin
                  lLoadStr := lLoadStr + 'ReadInt64();';
                  lSaveStr := lSaveStr + 'WriteInt64(F' + lData.Name + ');';
                End;
              End;
            End
          Else If SameText(lData.DataType, 'real') Then
          Begin
            Case StrToIntDef(lData.Len, 4) Of
              4 :
              Begin
                lLoadStr := lLoadStr + 'ReadSingle();';
                lSaveStr := lSaveStr + 'WriteSingle(F' + lData.Name + ');';
              End;

              8 :
              Begin
                lLoadStr := lLoadStr + 'ReadFloat();';
                lSaveStr := lSaveStr + 'WriteFloat(F' + lData.Name + ');';
              End;              
            End;
          End
          Else If SameText(lData.DataType, 'string') {Or
                  SameText(lData.DataType, 'HsString')} Then
          Begin
            If IsNumeric(lData.Len) Then
              lLoadStr := lLoadStr + 'ReadString(' + lData.Len + ');'
            Else
            Begin
              lData2 := FindNodeData(AIn, lData.Len);
              If Assigned(lData2) Then
                lLoadStr := lLoadStr + 'ReadString(F' + lData.Len + ');'
              Else
                lLoadStr := lLoadStr + 'ReadString();';
            End;

            lSaveStr := lSaveStr + 'WriteString(F' + lData.Name + ', False);';
          End;{
          Else If SameText(lData.DataType, 'HsStringListEx') Then
          Begin
            lLoadStr := lLoadStr + 'ReadTStrings(ASource);';
            lSaveStr := lSaveStr + 'WriteTStrings(F' + lData.Name + ', False);';
          End;}

          lTmpList.Add(lLoadStr);
          lSave.ProcedureImpl.Add(lSaveStr);
        End
        Else If Supports(AIn.ChildNodes[X], IXMLUseStruct, lUseStruct) Then
        Begin
          If SameText(lUseStruct.TypeName, 'HsString') Then
          Begin
            lTmpList.Add(PadL('', 2) + 'F' + lUseStruct.Name + ':=ASource.ReadString();');
            lSave.ProcedureImpl.Add(PadL('', 2) + 'ATarget.WriteString(F'+ lUseStruct.Name + ');');
          End
          Else If SameText(lUseStruct.TypeName, 'HsStringListEx') Then
          Begin
            lTmpList.Add(PadL('', 2) + 'ASource.ReadTStrings(F' + lUseStruct.Name + ');');
            lSave.ProcedureImpl.Add(PadL('', 2) + 'ATarget.WriteTStrings(F'+ lUseStruct.Name + ');');
          End
          Else
          Begin
            lTmpList.Add(PadL('', 2) + 'F' + lUseStruct.Name + '.LoadFromStream(ASource);');
            lSave.ProcedureImpl.Add(PadL('', 2) + 'F' + lUseStruct.Name + '.SaveToStream(ATarget);');
          End;
        End
        Else If Supports(AIn.ChildNodes[X], IXMLFor, lFor) Then
        Begin
          If IsNumeric(lFor.Count) Then
          Begin

          End
          Else
          Begin
            lData := FindNodeData(AIn, lFor.Count);
            If Assigned(lData) Then
            Begin
              lTmpList.Add(PadL('', 2) + 'While F' + lData.Name + ' > 0 Do');
              lTmpList.Add(PadL('', 2) + 'Begin');
              lTmpList.Add(PadL('', 4) + 'F' + lFor.Name + '.Add().LoadFromStream(ASource);');
              lTmpList.Add(PadL('', 4) + 'Dec(F' + lData.Name + ');');
              lTmpList.Add(PadL('', 2) + 'End;');
              lTmpList.Add(PadL('', 2) + 'F' + lData.Name + ' := F' + lFor.Name + '.Count;');

              lSave.ProcedureImpl.Add(PadL('', 2) + 'For X := 0 To F' + lData.Name + ' Do');
              lSave.ProcedureImpl.Add(PadL('', 4) + 'F' + lFor.Name + '[X].SaveToStream(ATarget);');
            End;
          End;
        End;

        AlignVariableAssign(lTmpList);
        For X := 0 To lTmpList.Count - 1 Do
          lLoad.ProcedureImpl.Add(lTmpList[X]);

        lLoad.ProcedureImpl.Add('End;');
        lSave.ProcedureImpl.Add('End;');

      Finally
        lTmpList.Free();
    End;
  End;

  Procedure InternalInitGenerator(AIn : IXmlNode; AOut : IHsClassCodeGenerator);
  Var X, Y : Integer;

      lClsDef : IHsClassCodeGenerator;

      lDefineStruct : IXMLDefineStruct;
      lUseStruct    : IXMLUseStruct;
      lStruct       : IXMLStruct;
      lData         : IXMLData;
      lFor          : IXMLFor;
      lJump         : IXMLJump;
      lSwitch       : IXMLSwitch;
  Begin
    If Supports(AIn, IXMLDefineStruct, lDefineStruct) Then
    Begin
      If Not (SameText(lDefineStruct.TypeName, 'HsString') Or
              SameText(lDefineStruct.TypeName, 'HsStringListEx')) Then
      Begin
        lClsDef := InternalAddClassDef(lGen);
        lClsDef.DataType := dsNone;
        lClsDef.ClsName := lDefineStruct.TypeName;
        lClsDef.UseInterface := True;

        For X := 0 To AIn.ChildNodes.Count - 1 Do
          InternalInitGenerator(AIn.ChildNodes[X], lClsDef);

        BuildStreamCode(AIn, lClsDef);
      End;
    End
    Else If Supports(AIn, IXMLData, lData) Then
    Begin
      With InternalAddPropertyDef(AOut) Do
      Begin
        PropertyName := lData.Name;
        If SameText(lData.DataType, 'int') Then
        Begin
          Case StrToIntDef(lData.Len, 1) Of
            1 : PropertyType := ptByte;
            2 : PropertyType := ptWord;
            4 : PropertyType := ptDWord;
            8 : PropertyType := ptQWord;
          End;
          IsBigEndian := SameText(lData.ByteOrder, 'big');
        End
        Else If SameText(lData.DataType, 'real') Then
          Case StrToIntDef(lData.Len, 4) Of
            4 : PropertyType := ptSingle;
            8 : PropertyType := ptDouble;
          End
        Else If SameText(lData.DataType, 'string') Or
                SameText(lData.DataType, 'HsString') Then
          PropertyType := ptString;
      End;
    End
    Else If Supports(AIn, IXMLStruct, lStruct) Then
    Begin
      With InternalAddPropertyDef(AOut) Do
      Begin
        PropertyName         := lStruct.Name;
        IsReadOnly           := True;
        PropertyType         := ptInterface;
        PropertyClass        := 'T' + lStruct.Name;
        InterfaceName        := 'I' + lStruct.Name;
        InterfaceImplementor := 'T' + lStruct.Name;
      End;

      lClsDef := InternalAddClassDef(lGen);
      lClsDef.DataType     := dsNone;
      lClsDef.ClsName      := lStruct.Name;
      lClsDef.UseInterface := True;

      For Y := 0 To AIn.ChildNodes.Count - 1 Do
        InternalInitGenerator(AIn.ChildNodes[Y], lClsDef);

      BuildStreamCode(lStruct, lClsDef);
    End
    Else If Supports(AIn, IXMLUseStruct, lUseStruct) Then
    Begin
      With InternalAddPropertyDef(AOut) Do
      Begin
        If SameText(lUseStruct.TypeName, 'HsString') Then
        Begin
          PropertyName := lUseStruct.Name;
          PropertyType := ptString;
        End
        Else
        Begin
          PropertyName         := lUseStruct.Name;
          PropertyType         := ptInterface;
          IsReadOnly           := True;
          PropertyClass        := 'T' + lUseStruct.TypeName;
          InterfaceName        := 'I' + lUseStruct.TypeName;
          InterfaceImplementor := 'T' + lUseStruct.TypeName;
        End
      End;
    End
    Else If Supports(AIn, IXMLJump, lJump) Then
    Begin
      For X := 0 To AIn.ChildNodes.Count - 1 Do
        InternalInitGenerator(AIn.ChildNodes[X], AOut);
    End
    Else If Supports(AIn, IXMLSwitch, lSwitch) Then
    Begin
      For X := 0 To lSwitch.Count - 1 Do
        For Y := 0 To lSwitch.Cases[X].ChildNodes.Count - 1 Do
          InternalInitGenerator(lSwitch.Cases[X].ChildNodes[Y], AOut);
    End
    Else If Supports(AIn, IXMLFor, lFor) Then
    Begin
      For X := 0 To lFor.ChildNodes.Count - 1 Do
        If Supports(lFor.ChildNodes[X], IXMLUseStruct, lUseStruct) Then
        Begin
          With InternalAddPropertyDef(AOut) Do
          Begin
            PropertyName         := lFor.Name;
            IsReadOnly           := True;
            PropertyType         := ptInterface;
            PropertyClass        := 'T' + lUseStruct.TypeName + 's';
            InterfaceName        := 'I' + lUseStruct.TypeName + 's';
            InterfaceImplementor := 'T' + lUseStruct.TypeName + 's';
          End;

          lLstFor.Add(UpperCase(lUseStruct.TypeName));
        End
        Else If Supports(lFor.ChildNodes[X], IXmlStruct, lStruct) Then
        Begin
          With InternalAddPropertyDef(AOut) Do
          Begin
            PropertyName := lFor.Name;
            IsReadOnly   := True;
            PropertyType := ptInterface;

            If lStruct.Name = '' Then
            Begin
              PropertyClass        := 'T' + lFor.Name + 's';
              InterfaceName        := 'I' + lFor.Name + 's';
              InterfaceImplementor := 'T' + lFor.Name + 's';
            End
            Else
            Begin
              PropertyClass        := 'T' + lStruct.Name + 's';
              InterfaceName        := 'I' + lStruct.Name + 's';
              InterfaceImplementor := 'T' + lStruct.Name + 's';
            End;
          End;

          lClsDef := InternalAddClassDef(lGen);
          lClsDef.DataType     := dsNone;
          If lStruct.Name = '' Then
            lClsDef.ClsName := lFor.Name
          Else
            lClsDef.ClsName := lStruct.Name;
          lClsDef.MakeList     := True;
          lClsDef.UseInterface := True;

          For Y := 0 To lFor.ChildNodes[X].ChildNodes.Count - 1 Do
            InternalInitGenerator(lFor.ChildNodes[X].ChildNodes[Y], lClsDef);

          BuildStreamCode(lStruct, lClsDef);
        End
        Else If Supports(lFor.ChildNodes[X], IXMLDefineStruct, lDefineStruct) Then
        Begin
          With InternalAddPropertyDef(AOut) Do
          Begin
            PropertyName         := lFor.Name;
            IsReadOnly           := True;
            PropertyType         := ptInterface;
            PropertyClass        := 'T' + lDefineStruct.TypeName + 's';
            InterfaceName        := 'I' + lDefineStruct.TypeName + 's';
            InterfaceImplementor := 'T' + lDefineStruct.TypeName + 's';
          End;

          lClsDef := InternalAddClassDef(lGen);
          lClsDef.DataType     := dsNone;
          lClsDef.ClsName      := lDefineStruct.TypeName;
          lClsDef.MakeList     := True;
          lClsDef.UseInterface := True;

          For Y := 0 To lFor.ChildNodes[X].ChildNodes.Count - 1 Do
            InternalInitGenerator(lFor.ChildNodes[X].ChildNodes[Y], lClsDef);
        End;
    End;
  End;

Var lHETemplate : IXMLBinaryFileFormat;
    X : Integer;
Begin
  If Assigned(lGen) Then
  Begin
    lHETemplate := GetBinaryFileFormat(AIn);
    lLstFor := TStringList.Create();
    Try
      For X := 0 To lHETemplate.ChildNodes.Count - 1 Do
        If Supports(lHETemplate.ChildNodes[X], IXMLDefineStruct) Then
          InternalInitGenerator(lHETemplate.ChildNodes[X], Nil);

      For X := 0 To lGen.ClassDefs.Count - 1 Do
        With InternalAddTypeDef(lGen) Do
        Begin
          TypeDefType := dtForwardInterface;
          TypeDefName := 'I' + lGen.ClassDefs[X].ClsName;

          lGen.ClassDefs[X].MakeList := lGen.ClassDefs[X].MakeList Or (lLstFor.IndexOf(UpperCase(lGen.ClassDefs[X].ClsName)) > -1);
          If lGen.ClassDefs[X].MakeList Then
            With InternalAddTypeDef(lGen) Do
            Begin
              TypeDefType := dtForwardInterface;
              TypeDefName := 'I' + lGen.ClassDefs[X].ClsName + 's';
            End;
        End;

      Finally
        lHETemplate := Nil;
        lLstFor.Free();
    End;
  End;
End;

(*
//--> List Foreign Keys
'Select ForeignKeyName.*, PrimaryData.*, ForeignData.*'#$D#$A +
'From sys.foreign_key_columns fkc'#$D#$A +
'Cross Apply ('#$D#$A +
'  Select TableName, Name ForeignKeyName'#$D#$A +
'  From sys.foreign_keys fk'#$D#$A +
'  Cross Apply ('#$D#$A +
'    Select Name TableName'#$D#$A +
'    From sys.Tables st'#$D#$A +
'    Where Object_Id = fk.Parent_Object_Id'#$D#$A +
'  ) TableName'#$D#$A +
'  Where Object_Id = fkc.Constraint_Object_Id'#$D#$A +
') ForeignKeyName'#$D#$A +
'Cross Apply ('#$D#$A +
'  Select Name PrimaryTable, PrimaryCol'#$D#$A +
'  From sys.Tables st'#$D#$A +
'  Cross Apply ('#$D#$A +
'    Select Name PrimaryCol'#$D#$A +
'    From sys.Columns sc'#$D#$A +
'    Where Object_Id = st.Object_Id And Column_Id = Parent_Column_Id'#$D#$A +
'  ) ca'#$D#$A +
'  Where Object_Id = fkc.Parent_Object_Id'#$D#$A +
') PrimaryData'#$D#$A +
'Cross Apply ('#$D#$A +
'  Select Name ForeignTable, ForeignCol'#$D#$A +
'  From sys.Tables st'#$D#$A +
'  Cross Apply ('#$D#$A +
'    Select Name ForeignCol'#$D#$A +
'    From sys.Columns sc'#$D#$A +
'    Where Object_Id = st.Object_Id And Column_Id = Referenced_Column_Id'#$D#$A +
'  ) ca'#$D#$A +
'  Where Object_Id = fkc.Referenced_Object_Id'#$D#$A +
') ForeignData';

//--> Fill Columns
'Select sc.Column_Id ColId, ss.Name + ''.'' + st.Name TableName, sc.Name FieldName,'#$D#$A +
'  Case When sc.System_Type_Id In (167, 231) Then sc.Max_Length Else 0 End MaxLen,'#$D#$A +
'  Case '#$D#$A +
'    When sc.System_Type_Id In (52, 56, 127) Then ''ptInteger'''#$D#$A +
'    When sc.System_Type_Id In (35, 167, 231) Then ''ptString'''#$D#$A +
'    When sc.System_Type_Id In (40, 58, 61) Then ''ptDateTime'''#$D#$A +
'    When sc.System_Type_Id = 62 Then ''ptDouble'''#$D#$A +
'    When sc.System_Type_Id = 104 Then ''ptBoolean'''#$D#$A +
'    When sc.System_Type_Id = 60 Then ''ptCurrency'''#$D#$A +
'    When sc.System_Type_Id = 175 Then ''ptChar'''#$D#$A +
'    When sc.System_Type_Id = 36 Then ''ptGUID'''#$D#$A +
'    Else ''ptVariant'''#$D#$A +
'  End FieldType'#$D#$A +
'From sys.Columns sc'#$D#$A +
'Inner Join sys.Tables st On st.Object_Id = sc.Object_Id'#$D#$A +
'Inner Join sys.Schemas ss On ss.Schema_Id = st.Schema_Id'#$D#$A +
'--Where st.Name In (''Edi_Files'', ''EDI_FileValidateErrors'')'#$D#$A +
'Order By st.Name, Column_Id';

    While Not Eof Do
    Begin
      If lTblName <> FieldByName('TableName').AsString Then
      Begin
        lTblName := FieldByName('TableName').AsString;
        lClass := lGenerator.ClassDefs.Add();

        With lClass Do
        Begin
          TableName := lTblName;
          ClsName := StringReplace(TableName, '_', '', [rfReplaceAll]);
          UseCustomClass := True;
          UseInterface := False;//True;
          DataType := dsMSSql;
          AdoQueryClassName := 'TScAdoQuery';
          TrackChange := True;
          MakeList := True;
        End;
      End;

      With lClass.PropertyDefs.Add() Do
      Begin
        FieldName    := FieldByName('FieldName').AsString;
        PropertyName := StringReplace(FieldName, '_', '', [rfReplaceAll]);
        PropertyType := THsPropertyType(GetEnumValue(TypeInfo(THsPropertyType), FieldByName('FieldType').AsString));
        MaxLen       := FieldByName('MaxLen').AsInteger;
        IsDataAware  := True;
      End;

      Next();
    End;
*)
end.
