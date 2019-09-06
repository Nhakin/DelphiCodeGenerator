unit dmCodeGen;

interface

uses
  SysUtils, Classes, DB, ADODB;

Type
  TSQLConnection = Record
    ServerName   : Widestring;
    DatabaseName : Widestring;
    UserName     : Widestring;
    Password     : Widestring;
  End;
  PSQLConnection = ^TSQLConnection;
  
  TAdoObject = Class(TObject)
  Public
    Class Procedure ListAvailableSQLServers(Servers : TStrings);
    Class Procedure DatabasesOnServer(AConnection : TADOConnection; Databases : TStrings);
    Class Procedure TablesOnDataBase(AConnection : TADOConnection; ATableNames : TStrings);

    Class Function  GetConnectionString(Const AConnection : TSQLConnection) : WideString;

  End;

  TCodeGenAdoQuery = Class(TAdoQuery)
  Public
    Constructor Create(AOwner : TComponent); OverRide;

  End;

  TDataModuleCodeGen = class(TDataModule)
    DbCodeGen: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);

  Private
    FConnection : TSQLConnection;

  Published
    Property Connection : TSQLConnection Read FConnection;
    
  Public
    Function CreateCodeGenQuery() : TCodeGenAdoQuery;

    Procedure LoadConfiguration();
    Procedure SaveConfiguration(Const AUpdateConnection : Boolean = False);

  end;

var
  DataModuleCodeGen : TDataModuleCodeGen;

implementation

{$R *.dfm}

Uses IniFiles, Dialogs, Variants, ActiveX, ComObj, AdoInt, OleDB;

{
Enumerating available SQL Servers. Retrieving databases on a SQL Server.
http://delphi.about.com/library/weekly/aa090704a.htm
}
Class Procedure TAdoObject.ListAvailableSQLServers(Servers : TStrings);
Var
  RSCon            : ADORecordsetConstruction;
  Rowset           : IRowset;
  SourcesRowset    : ISourcesRowset;
  SourcesRecordset : _Recordset;
  SourcesName      ,
  SourcesType      : TField;

  Function PtCreateADOObject(Const ClassID: TGUID): IUnknown;
  Var Status: HResult;
      FPUControlWord: Word;
  Begin
    Asm
      FNSTCW FPUControlWord
    End;
    Status := CoCreateInstance(
      CLASS_Recordset,
      Nil,
      CLSCTX_INPROC_SERVER Or CLSCTX_LOCAL_SERVER,
      IUnknown,
      Result);
    Asm
      FNCLEX
      FLDCW FPUControlWord
    End;
    OleCheck(Status);
  End;
Begin
  SourcesRecordset := PtCreateADOObject(CLASS_Recordset) As _Recordset;
  RSCon := SourcesRecordset As ADORecordsetConstruction;
  SourcesRowset := CreateComObject(ProgIDToClassID('SQLOLEDB Enumerator')) As ISourcesRowset;
  OleCheck(SourcesRowset.GetSourcesRowset(Nil, IRowset, 0, Nil, IUnknown(Rowset)));
  RSCon.Rowset := RowSet;
  With TADODataSet.Create(Nil) Do
  Try
    Recordset := SourcesRecordset;
    SourcesName := FieldByName('SOURCES_NAME');
    SourcesType := FieldByName('SOURCES_TYPE');

    Servers.BeginUpdate();
    Try
      While Not EOF Do
      Begin
        If (SourcesType.AsInteger = DBSOURCETYPE_DATASOURCE) And
           (SourcesName.AsString <> '') Then
          Servers.Add(SourcesName.AsString);
        Next;
      End;

      Finally
        Servers.EndUpdate();
    End;

    Finally
      Free();
  End;
End;

Class Procedure TAdoObject.DatabasesOnServer(AConnection : TADOConnection; Databases : TStrings);
Var lRecs : _RecordSet;
Begin
  Databases.Clear();
  With AConnection Do
  Begin
    LoginPrompt := False;
    Try
      Open();
      lRecs := ConnectionObject.OpenSchema(adSchemaCatalogs, EmptyParam, EmptyParam);

      Try
        Databases.BeginUpdate();
        While Not lRecs.Eof Do
        Begin
          Databases.Add(VarToStr(lRecs.Fields['CATALOG_NAME'].Value));
          lRecs.MoveNext();
        End;

        Finally
          Databases.EndUpdate();
      End;

      Close();

      Except
        On e:exception Do
          MessageDlg(e.Message, mtError, [mbOK],0);
    End;
  End;
End;

Class Procedure TAdoObject.TablesOnDataBase(AConnection : TADOConnection; ATableNames : TStrings);
Var lRecs : _Recordset;
Begin
{
  With TAdoQuery.Create(Nil) Do
  Try
    Connection := AConnection;
    Sql.Text := 'Select * From sys.Tables';
    Open();

    While Not Eof Do
    Begin
      ATableNames.Add(FieldByName('Name').AsString);
      Next();
    End;

    Finally
      Free();
  End;
}
  ATableNames.Clear();

  With AConnection Do
  Begin
    LoginPrompt := False;
    Open();
    lRecs := ConnectionObject.OpenSchema(adSchemaTables, VarArrayOf([Null, Null, Null, 'Table']), EmptyParam);

    Try
      ATableNames.BeginUpdate();

      While Not lRecs.Eof Do
      Begin
        ATableNames.Add(lRecs.Fields['Table_Name'].Value);
        lRecs.MoveNext();
      End;

      Finally
        ATableNames.EndUpdate();
    End;
    Close();
  End;
End;

Class Function TAdoObject.GetConnectionString(Const AConnection : TSQLConnection) : WideString;
Begin
{
  Result := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;';
  Result := Result + 'Data Source=' + AConnection.ServerName + ';';
  If AConnection.DatabaseName <> '' Then
    Result := Result + 'Initial Catalog=' + AConnection.DatabaseName + ';';

  If (AConnection.UserName <> '') And (AConnection.Password <> '') Then
  Begin
    Result := Result + 'uid=' + AConnection.UserName + ';';
    Result := Result + 'pwd=' + AConnection.Password + ';';
  End;
}
{
  ConnectionString := 'Provider=SQLOLEDB.1;' +
                      'Persist Security Info=True;' +
                      'User ID=' + ReadString(DBaseSect, 'User', '') + ';' +
                      'Password=' + szDecryptStr(ReadString(DBaseSect, 'PassWord', ''), 'mm3781799') + ';' +
                      'Initial Catalog=' + ReadString(DBaseSect, 'DBaseName', '') + ';' +
                      'Data Source=' + ReadString(DBaseSect, 'ServerName', '') + ';' +
                      'Application Name=TmhoADO';
}
  Result :=  'Provider=SQLOLEDB.1;Persist Security Info=True;' +
             'Data Source=' + AConnection.ServerName + ';';
  If AConnection.DatabaseName <> '' Then
    Result := Result + 'Initial Catalog=' + AConnection.DatabaseName + ';';
  If (AConnection.UserName <> '') And (AConnection.Password <> '') Then
  Begin
    Result := Result + 'User ID=' + AConnection.UserName + ';';
    Result := Result + 'Password=' + AConnection.Password + ';';
  End;
End;

(******************************************************************************)

Constructor TCodeGenAdoQuery.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  If AOwner Is TAdoConnection Then
    Connection := TAdoConnection(AOwner);
End;

procedure TDataModuleCodeGen.DataModuleCreate(Sender: TObject);
begin
  LoadConfiguration();

  DbCodeGen.Connected := False;
  DbCodeGen.ConnectionString := TAdoObject.GetConnectionString(FConnection);
end;

Procedure TDataModuleCodeGen.LoadConfiguration();
Begin
  If FileExists(ChangeFileExt(ParamStr(0), '.cfg')) Then
    With TIniFile.Create(ChangeFileExt(ParamStr(0), '.cfg')) Do
    Try
      FConnection.ServerName   := ReadString('DataBase', 'ServerName', '');
      FConnection.DatabaseName := ReadString('DataBase', 'DatabaseName', '');
      FConnection.UserName     := ReadString('DataBase', 'UserName', '');
      FConnection.Password     := ReadString('DataBase', 'Password', '');

      Finally
        Free();
    End;
End;

Procedure TDataModuleCodeGen.SaveConfiguration(Const AUpdateConnection : Boolean = False);
Begin
  With TIniFile.Create(ChangeFileExt(ParamStr(0), '.cfg')) Do
  Try
    WriteString('DataBase', 'ServerName', FConnection.ServerName);
    WriteString('DataBase', 'DatabaseName', FConnection.DatabaseName);
    WriteString('DataBase', 'UserName', FConnection.UserName);
    WriteString('DataBase', 'Password', FConnection.Password);

    Finally
      Free();
  End;

  If AUpdateConnection Then
  Begin
    DbCodeGen.Connected := False;
    DbCodeGen.ConnectionString := TAdoObject.GetConnectionString(FConnection)
  End;
End;

Function TDataModuleCodeGen.CreateCodeGenQuery() : TCodeGenAdoQuery;
Begin
  Result := TCodeGenAdoQuery.Create(DbCodeGen);
End;

end.
