Unit MsSqlCfgDlg;

Interface

Uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, ADODB, VirtualTrees,
  CodeGenIntf, dmCodeGen, MsSqlOptionIntf;

Type
  TFrmMsSqlCfg = Class(TForm)
    panMain: TPanel;
    panButtons: TPanel;
    btnOk:  TBitBtn;
    btnCancel: TBitBtn;
    pcMain: TPageControl;
    tsConnection: TTabSheet;
    TestConButton: TBitBtn;
    tsTables: TTabSheet;
    vstTable: TVirtualStringTree;
    PanSqlSettings: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cboServers: TComboBox;
    cboDatabases: TComboBox;
    gbLoginInfo: TGroupBox;
    rbIntegratedSecurity: TRadioButton;
    rbLoginInfo: TRadioButton;
    ledUserName: TLabeledEdit;
    ledPassword: TLabeledEdit;

    Procedure rbLoginInfoClick(Sender: TObject);
    Procedure rbIntegratedSecurityClick(Sender: TObject);
    Procedure btnOKClick(Sender: TObject);
    Procedure TestConButtonClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure cboServersDropDown(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vstTableInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstTableGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure cboDatabasesDropDown(Sender: TObject);

  Private
    FDlgOptions : IMsSqlOptions; 
    FLstTables : TStringList;
    FPrevServerName : String;

    Function GetConnStr() : Widestring;

    Procedure SetDlgOptions(ADlgOptions : IMsSqlOptions);
    
  Protected
    Function GetSqlConnection() : TSqlConnection; Virtual;

  Published
    Property DlgOptions : IMsSqlOptions Read FDlgOptions Write SetDlgOptions;

  Public
    Property ConnStr : Widestring Read GetConnStr;

    Procedure GetSelectedTables(ATableList : TStringList);

  End;

  TFrmCodeGenMsSqlCfg = Class(TFrmMsSqlCfg)
    Procedure btnOKClick(Sender: TObject);

  Public
    Constructor Create(AOwner : TComponent); OverRide;

  End;

Implementation

{$R *.dfm}

Uses DB, Variants, ActiveX, ComObj, AdoInt, OleDB,
  CodeGenType, TypInfo;

Procedure TFrmMsSqlCfg.GetSelectedTables(ATableList : TStringList);
Var lNode : PVirtualNode;
Begin
  ATableList.Clear();
  lNode := vstTable.RootNode.FirstChild;
  While Assigned(lNode) Do
  Begin
    If lNode.CheckState = csCheckedNormal Then
      ATableList.Add(FLstTables[lNode.Index]);

    lNode := lNode.NextSibling;
  End;
End;

(******************************************************************************)

Procedure TFrmMsSqlCfg.FormCreate(Sender: TObject);
Begin
  FLstTables := TStringList.Create();
  FPrevServerName := '';
End;

Procedure TFrmMsSqlCfg.SetDlgOptions(ADlgOptions : IMsSqlOptions);
Begin
  FDlgOptions                  := ADlgOptions;
  cboServers.Text              := FDlgOptions.ServerName;
  rbIntegratedSecurity.Checked := FDlgOptions.LoginType = 1;
  rbLoginInfo.Checked          := FDlgOptions.LoginType = 2;
  ledUserName.Text             := FDlgOptions.UserName;
  ledPassword.Text             := FDlgOptions.Password;
  cboDatabases.Text            := FDlgOptions.DataBaseName;
End;

procedure TFrmMsSqlCfg.FormDestroy(Sender: TObject);
begin
  If Assigned(FDlgOptions) Then
  Begin
    FDlgOptions.ServerName := cboServers.Text;
    If rbIntegratedSecurity.Checked Then
      FDlgOptions.LoginType := 1
    Else
      FDlgOptions.LoginType := 2;
    FDlgOptions.UserName     := ledUserName.Text;
    FDlgOptions.Password     := ledPassword.Text;
    FDlgOptions.DataBaseName := cboDatabases.Text;
  End;
  
  FreeAndNil(FLstTables);
end;

Procedure TFrmMsSqlCfg.rbLoginInfoClick(Sender: TObject);
Begin
  ledUserName.Enabled := True;
  ledPassword.Enabled := True;
End;

Procedure TFrmMsSqlCfg.rbIntegratedSecurityClick(Sender: TObject);
Begin
  ledUserName.Enabled := False;
  ledPassword.Enabled := False;
End;

procedure TFrmMsSqlCfg.cboDatabasesDropDown(Sender: TObject);
Var lConn : TADOConnection;
begin
  If FPrevServerName <> cboServers.Text Then
  Begin
    Screen.Cursor := crSQLWait;
    FPrevServerName := cboServers.Text;
    lConn := TADOConnection.Create(Self);
    Try
      lConn.ConnectionString := ConnStr;
      TAdoObject.DatabasesOnServer(lConn, cboDatabases.Items);

      Finally
        lConn.Free();
        Screen.Cursor := crDefault;
    End;
  End;
end;

procedure TFrmMsSqlCfg.cboServersDropDown(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  Try
    TAdoObject.ListAvailableSQLServers(cboServers.Items);

    Finally
      Screen.Cursor := crDefault;
  End;
end;

Procedure TFrmMsSqlCfg.btnOKClick(Sender: TObject);
Begin
  With GetSqlConnection() Do
    If (ServerName  = '') Or (DatabaseName = '') Then
      ModalResult:= mrNone
    Else
      ModalResult := mrOk;
End;

Procedure TFrmMsSqlCfg.TestConButtonClick(Sender: TObject);
Begin
(*
  With TAdoConnection.Create(Nil) Do
  Try
    LoginPrompt := False;
    ConnectionString := ConnStr;
    If (sc.ServerName = '') Or (sc.DatabaseName = '') Then
      MessageDlg('Select at least a Server and a Database!', mtWarning, [mbOK],0)
    Else
    Begin
      Try
        Open();
        Close();
        MessageDlg('Connection successful!',mtInformation, [mbOK],0);

        Except
          On E:Exception Do
            MessageDlg(e.Message, mtError, [mbOK],0);
      End;
    End;

    Finally
      If Connected Then
        Close();

      Free();
  End;
*)
End;

procedure TFrmMsSqlCfg.vstTableGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
  CellText := FLstTables[Node.Index];
end;

procedure TFrmMsSqlCfg.vstTableInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.CheckType  := ctCheckBox;
  Node.CheckState := csUncheckedNormal;
end;

Function TFrmMsSqlCfg.GetSqlConnection() : TSqlConnection;
Begin
  FillChar(Result, SizeOf(Result), #0);

  Result.ServerName := cboServers.Text;
  If cboDatabases.ItemIndex <> -1 Then
    Result.DatabaseName := cboDatabases.Items[cboDatabases.ItemIndex]
  Else
    Result.DatabaseName := '';

  If rbLoginInfo.Checked Then
  Begin
    Result.UserName := ledUserName.Text;
    Result.Password := ledPassword.Text;
  End
  Else
  Begin
    Result.UserName := '';
    Result.Password := '';
  End;
End;

Function TFrmMsSqlCfg.GetConnStr() : Widestring;
Begin
  Result := TAdoObject.GetConnectionString(GetSqlConnection());
End;

procedure TFrmMsSqlCfg.pcMainChange(Sender: TObject);
Var lConn : TAdoConnection;
begin
  If pcMain.ActivePage = tsTables Then
  Begin
    lConn := TADOConnection.Create(Self);
    Try
      lConn.ConnectionString := ConnStr;
      TAdoObject.TablesOnDataBase(lConn, FLstTables);
      vstTable.RootNodeCount := FLstTables.Count;

      Finally
        lConn.Free();
    End;
  End;
end;

Constructor TFrmCodeGenMsSqlCfg.Create(AOwner : TComponent);
Var lConnection : TAdoConnection;
Begin
  InHerited Create(AOwner);

  PanSqlSettings.Parent := Self;
  pcMain.Visible := False;
  Caption := 'Configuration';

  Height := 292;
  Width := 315;

  cboServers.Text := DataModuleCodeGen.Connection.ServerName;
  If cboServers.Text <> '' Then
  Begin
    If DataModuleCodeGen.Connection.DatabaseName <> '' Then
    Begin
      lConnection := TAdoConnection.Create(Self);
      lConnection.ConnectionString := ConnStr;
      Try
        TAdoObject.DatabasesOnServer(lConnection, cboDatabases.Items);
        cboDatabases.ItemIndex := cboDatabases.Items.IndexOf(DataModuleCodeGen.Connection.DatabaseName);
        FPrevServerName := cboServers.Text;

        Finally
          lConnection.Free();
      End;
    End;
  End;

  If (DataModuleCodeGen.Connection.UserName <> '') And
     (DataModuleCodeGen.Connection.Password <> '') Then
  Begin
    ledUserName.Text := DataModuleCodeGen.Connection.UserName;
    ledPassword.Text := DataModuleCodeGen.Connection.Password;
    rbLoginInfoClick(Self);
  End
  Else
  Begin
    ledUserName.Text := '';
    ledPassword.Text := '';
    rbIntegratedSecurityClick(Self);
  End;
End;

Procedure TFrmCodeGenMsSqlCfg.btnOKClick(Sender: TObject);
Var lConnection : TSQLConnection;
Begin
  lConnection := GetSqlConnection();

  PSQLConnection(@DataModuleCodeGen.Connection)^.ServerName   := lConnection.ServerName;
  PSQLConnection(@DataModuleCodeGen.Connection)^.DatabaseName := lConnection.DatabaseName;
  PSQLConnection(@DataModuleCodeGen.Connection)^.UserName     := lConnection.UserName;
  PSQLConnection(@DataModuleCodeGen.Connection)^.Password     := lConnection.Password;

  DataModuleCodeGen.SaveConfiguration(True);
End;

(*
    OnIncrementalSearch := DoOnIncrementalSearch;
    IncrementalSearch := isAll;
    IncrementalSearchDirection := sdForward;
    IncrementalSearchStart := ssFocusedNode;

Procedure TFrmEDIListeFichiers.DoOnIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode;
  Const SearchText: WideString; Var Result: Integer);
Var S, S2 : String;
    lNode : IVTEdiNodeEx;
    lNodeData : PInterface;
Begin
  S := SearchText;
  With (Sender As TVirtualStringTree) Do
    S2 := Text[Node, Header.MainColumn];
  Result := StrLIComp(
              PChar(S),
              PChar(S2),
              Min(Length(SearchText), Length(S2))
            );
End;
*)

(*
Kahn-Portable\SqlExpress
Sebastien-HP\SqlExpress
*)
End.

