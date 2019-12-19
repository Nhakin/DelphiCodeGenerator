unit Main;

interface

uses
  HsInterfaceEx, CodeGen.VT, ApplicationOptions.IO, SearchTextDlg,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Tabs, ComCtrls, SynEdit, SynMemo, SynEditHighlighter,
  SynHighlighterPas, VirtualTrees, StdCtrls, Menus, ToolWin, ImgList,
  SynEditMiscClasses, SynEditSearch, ActnList, TB2Dock, TB2Toolbar, SpTBXItem,
  SpTBXMDIMRU, SpTBXDkPanels, SpTBXSkins, SpTBXAdditionalSkins, TB2Item,
  SpTBXExControls;

Type
  PInterface = ^IInterfaceEx;
  TFrmMain = class(TForm)
    SynPasSyn: TSynPasSyn;
    imgToolBar: TImageList;
    OpenDialog1: TOpenDialog;
    SynEditSearch: TSynEditSearch;
    alMain: TActionList;
    ActNew: TAction;
    ActOpen: TAction;
    ActSave: TAction;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    SpTBXTbFile: TSpTBXSubmenuItem;
    SpTBXNew: TSpTBXItem;
    SpTBXSave: TSpTBXItem;
    SpTBXOpenTb: TSpTBXSubmenuItem;
    SpTBXMnuFile: TSpTBXSubmenuItem;
    SpTBXItem2: TSpTBXItem;
    SpTBXOpenMnu: TSpTBXItem;
    SpTBXItem4: TSpTBXItem;
    SpTBXRecentMnu: TSpTBXSubmenuItem;
    SpTBXMRU: TSpTBXMRUListItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTBXExit: TSpTBXItem;
    popVTProject: TSpTBXPopupMenu;
    SpTBXAddRemove: TSpTBXTBGroupItem;
    popAddTypeDef: TSpTBXItem;
    popDeleteTypeDef: TSpTBXItem;
    popDataBindingSQLServer: TSpTBXItem;
    popDataBindingJSon: TSpTBXItem;
    popDataBindingHexEditTemplate: TSpTBXItem;
    popAddClass: TSpTBXItem;
    popDeleteClass: TSpTBXItem;
    popAddProperty: TSpTBXItem;
    popDeleteProperty: TSpTBXItem;
    popAddMethod: TSpTBXItem;
    popDeleteMethod: TSpTBXItem;
    popCollapseAll: TSpTBXItem;
    popExpandAll: TSpTBXItem;
    SpTBXTitleBar: TSpTBXTitleBar;
    SpTBXDock: TSpTBXDock;
    SpTBXMain: TSpTBXToolbar;
    SpTBXTBGroupFile: TSpTBXTBGroupItem;
    SpTBXItem1: TSpTBXItem;
    MainMnu: TSpTBXToolbar;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    SpTBXSkinRootMenu: TSpTBXSubmenuItem;
    SpTBXSkinMenu: TSpTBXSkinGroupItem;
    SpTBXStatusBar: TSpTBXStatusBar;
    SpTBXLabelItem1: TSpTBXLabelItem;
    PanMain: TPanel;
    PanTreeView: TPanel;
    vstProject: TVirtualStringTree;
    PanInfos: TPanel;
    Panel1: TPanel;
    tsMain: TTabSet;
    PanPreview: TPanel;
    MemoPreview: TSynMemo;
    SpTBXSplitter1: TSpTBXSplitter;
    SpTBXExpandCollapse: TSpTBXTBGroupItem;
    SpTBXpopTv: TSpTBXTBGroupItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    SpTBXpopTvAddRemove: TSpTBXTBGroupItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    SpTBXpopTvExpandCollapse: TSpTBXTBGroupItem;
    SpTBXDataBinding: TSpTBXTBGroupItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    SpTBXTBGroupTvAddRemove: TSpTBXTBGroupItem;
    SpTBXpopTvDataBinding: TSpTBXSubmenuItem;
    ActSearch: TAction;
    ActSearchNext: TAction;
    ActSearchPrevious: TAction;
    SpTBXTbSearch: TSpTBXTBGroupItem;
    SpTBXSearchPrevious: TSpTBXItem;
    SpTBXSearchNext: TSpTBXItem;
    SpTBXSearch: TSpTBXItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    SpTBXTBGroupItem1: TSpTBXTBGroupItem;
    SpTBXMnuSearch: TSpTBXSubmenuItem;
    SpTBXSaveAs: TSpTBXItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    //Treeview Initialization
    procedure vstProjectInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstProjectInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);

    //Treeview UI
    procedure vstProjectGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure vstProjectBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);

    //Treeview Editor stuff
    procedure vstProjectFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vstProjectNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vstProjectEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vstProjectCreateEditor(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);

    procedure popVTProjectPopup(Sender: TObject);
    procedure popAddPropertyClick(Sender: TObject);
    procedure popDeletePropertyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);

    procedure popAddClassClick(Sender: TObject);
    procedure popDeleteClassClick(Sender: TObject);
    procedure popExpandAllClick(Sender: TObject);
    procedure popCollapseAllClick(Sender: TObject);
    procedure popAddTypeDefClick(Sender: TObject);
    procedure popDeleteTypeDefClick(Sender: TObject);
    procedure popDataBindingSQLServerClick(Sender: TObject);
    procedure popDataBindingJSonClick(Sender: TObject);
    procedure popDataBindingHexEditTemplateClick(Sender: TObject);
    procedure vstProjectKeyAction(Sender: TBaseVirtualTree; var CharCode: Word;
      var Shift: TShiftState; var DoDefault: Boolean);
    procedure popAddMethodClick(Sender: TObject);
    procedure popDeleteMethodClick(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure ActOpenExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SpTBXMRUClick(Sender: TObject; const Filename: WideString);
    procedure SpTBXExitClick(Sender: TObject);
    procedure SpTBXSkinMenuClick(Sender: TObject);
    procedure MainMnuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpTBXMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure popVTProjectClosePopup(Sender: TObject);
    procedure ActSearchExecute(Sender: TObject);
    procedure ActSearchNextExecute(Sender: TObject);
    procedure ActSearchPreviousExecute(Sender: TObject);
    procedure SpTBXSaveAsClick(Sender: TObject);

  private
    FAppOptions : IApplicationOptionsIO;
    FTreeDataEx : IHsVTUnitGeneratorNode;
    FFileName   : String;
    
    Procedure DovstProjectExpandNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; Var Abort: Boolean);
    Procedure UpdatePropertyDefNodeVisible();
    Procedure DoEditorButtonClick(Sender : TObject; Node : PVirtualNode);
    Procedure UpdateButtons(ACurItem : PInterface);

    Procedure DoSearchReplaceText(AReplace: Boolean; ABackwards: Boolean);
    Procedure ShowSearchReplaceDialog(AReplace: Boolean);
    
  public

  end;

var
  FrmMain: TFrmMain;

implementation

Uses TypInfo, Math, SynEditTypes, HsXmlDocEx, HsJSonEx, HsBase64Ex, FastStringFuncs,
  AbZipKit, AbZipTyp, HegFile, DateUtils,
//  SearchOptions.Ini, SearchOptions.Xml, SearchOptions.JSon,
  ApplicationOptions.Ini, ApplicationOptions.Xml, ApplicationOptions.JSon,
  CodeGenType, CodeGenBuilder,
  MsSqlCfgDlg, VTCodeGenEditor, HsStreamEx, HsIniFilesEx;

{$R *.dfm}

Const
  cApplicationCaption = 'Hs Class Generator';
  STextNotFound = 'Text not found';

procedure TFrmMain.ActNewExecute(Sender: TObject);
begin
  If vstProject.IsEditing Then
    vstProject.EndEditNode();
    
  FTreeDataEx := TVTCodeGen.CreateGenerator();
  vstProject.ReinitNode(Nil, True);
  vstProject.Invalidate();

  MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();

  FFileName := '';
  Caption := cApplicationCaption;
  SpTBXTitleBar.Caption := Caption;
end;

procedure TFrmMain.ActOpenExecute(Sender: TObject);
begin
//Raise Exception.Create('Brise');
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'All Files|*.xml;*.json|Xml Files|*.xml|JSon Files|*.json';

    If Execute() Then
    Begin
      FTreeDataEx.LoadFromFile(FileName);
      MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
      vstProject.ReinitNode(Nil, True);
      UpdatePropertyDefNodeVisible();

      FFileName := FileName;
      SpTBXMRU.MRUAdd(FFileName);

      Caption := cApplicationCaption + ' - ' + ExtractFileName(FFileName);
      SpTBXTitleBar.Caption := Caption;
    End;

    Finally
      Free();
  End;
end;

procedure TFrmMain.ActSaveExecute(Sender: TObject);
Begin
  If FFileName = '' Then
    With TSaveDialog.Create(Self) Do
    Try
      Filter := 'All Files|*.xml;*.json|Xml Files|*.xml|JSon Files|*.json';

      If Execute() Then
      Begin
        FFileName := FileName;
        SpTBXMRU.MRUAdd(FFileName);
        Caption := cApplicationCaption + ' - ' + ExtractFileName(FFileName);
        SpTBXTitleBar.Caption := Caption;
      End;

      Finally
        Free();
    End;

  If FFileName <> '' Then
    FTreeDataEx.SaveToFile(FFileName);
end;

procedure TFrmMain.ActSearchExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(False);
end;

procedure TFrmMain.ActSearchNextExecute(Sender: TObject);
begin
  DoSearchReplaceText(False, False);
end;

procedure TFrmMain.ActSearchPreviousExecute(Sender: TObject);
begin
  DoSearchReplaceText(False, True);
end;

procedure TFrmMain.Button1Click(Sender: TObject);
Var lEnumData : PTypeData;
    lNbByte : Integer;
    lNames  : PByteArray;
    S : String;
begin
  lEnumData := GetTypeData(TypeInfo(TVTColumnOption));

  //ShowMessage(IntToStr(lNbByte));
  lNames := @lEnumData.NameList;
  For lNbByte := lEnumData.MinValue To lEnumData.MaxValue Do
  Begin
    S := S + IntToStr(Round(Power(2, lNbByte))) + ' - ' + Copy(PChar(lNames), 2, lNames[0]) + #$D#$A;
    lNames := @lNames[lNames[0] + 1];
  End;
  ShowMessage(S);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
Var lPath : String;
    lFileName : String;
    X : Integer;
begin
  vstProject.NodeDataSize := SizeOf(PInterface);

  FTreeDataEx := TVTCodeGen.CreateGenerator();
  MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();

  vstProject.RootNodeCount := 1;

  lPath := 'V:\SCModuleEDI\Sources\DelphiCodeGenerator\Bin\';

  lFileName := ChangeFileExt(ParamStr(0), '.xml');
  If FileExists(lFileName) Then
  Begin
    FAppOptions := TApplicationOptionsIO.CreateAppicaltionOptions(lFileName);

    With FAppOptions Do
    Begin
      WindowState := TWindowState(GlobalOptions.WindowState);
      If WindowState <> wsMaximized Then
      Begin
        Top    := GlobalOptions.Top;
        Left   := GlobalOptions.Left;
        Height := GlobalOptions.Height;
        Width  := GlobalOptions.Width;
      End;

      With GlobalOptions Do
      Begin
        PanTreeView.Width                  := TreeViewWidth;
        vstProject.Header.Columns[0].Width := TreeViewColWidth;
        SpTBXMRU.MaxItems                  := MRUMaxItem;

        For X := 0 To MRUList.Count - 1 Do
          SpTBXMRU.MRUAdd(MRUList[X]);

        If ReopenLastFile And FileExists(LastOpenedFile) Then
        Begin
          FFileName := LastOpenedFile;

          FTreeDataEx.LoadFromFile(FFileName);
          MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
          vstProject.ReinitNode(Nil, True);
          UpdatePropertyDefNodeVisible();

          SpTBXMRU.MRUAdd(FFileName);
          Caption := cApplicationCaption + ' - ' + ExtractFileName(FFileName);
          SpTBXTitleBar.Caption := Caption;
        End;

        SkinManager.SetSkin(SkinName);
        If Not SkinManager.IsDefaultSkin Then
          SpTBXTitleBar.Active := True;
      End;
    End;
  End
  Else
    FAppOptions := TApplicationOptionsIO.CreateAppicaltionOptions();
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
Var lFileName : String;
    X : Integer;
begin
  lFileName := ChangeFileExt(ParamStr(0), '.xml');

  With FAppOptions Do
  Begin
    GlobalOptions.WindowState := Ord(WindowState);
    If WindowState <> wsMaximized Then
    Begin
      GlobalOptions.Top    := Top;
      GlobalOptions.Left   := Left;
      GlobalOptions.Height := Height;
      GlobalOptions.Width  := Width;
    End;

    With GlobalOptions Do
    Begin
      TreeViewWidth    := PanTreeView.Width;
      TreeViewColWidth := vstProject.Header.Columns[0].Width;
      MRUMaxItem       := SpTBXMRU.MaxItems;

      MRUList.Clear();
      For X := 0 To SpTBXMRU.Count - 1 Do
        MRUList.Add(TSpTBXMRUItem(SpTBXMRU.Items[X]).MRUString);

      If FFileName <> '' Then
        LastOpenedFile := FFileName;

      SkinName := SkinManager.CurrentSkin.SkinName;
    End;

    FAppOptions.SaveToXml(lFileName);
    FAppOptions.SaveToIni(ChangeFileExt(lFileName, '.Ini'));
    FAppOptions.SaveToJSon(ChangeFileExt(lFileName, '.JSon'));
    FAppOptions.SaveToFile(ChangeFileExt(lFileName, '.Bin'));
    FAppOptions.SaveToFile(ChangeFileExt(lFileName, '.Hex'), True);
  End;

  FTreeDataEx := Nil;
  FAppOptions := Nil;
end;

procedure TFrmMain.MainMnuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Shift = [ssCtrl, ssAlt, ssShift, ssRight] Then
    SpTBXSkinRootMenu.Visible := Not SpTBXSkinRootMenu.Visible
end;

procedure TFrmMain.popAddTypeDefClick(Sender: TObject);
Var lNode : PVirtualNode;

    lNodeData : PInterface;
    lTypeDefs : IHsVTTypeDefsNode;
begin
  lNode := vstProject.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := vstProject.GetNodeData(lNode);
    If Assigned(lNodeData) And
       Supports(lNodeData^, IHsVTTypeDefsNode, lTypeDefs) Then
    Begin
      With lTypeDefs.Add() Do
      Begin
        TypeDefType := dtEnum;
        TypeDefName := 'NewTypeDef';

        vstProject.ReinitNode(lNode, True);
        vstProject.FocusedColumn := 1;
        vstProject.FocusedNode   := lNode.LastChild;

        MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
      End;
    End;
  End;
end;

procedure TFrmMain.popDeleteTypeDefClick(Sender: TObject);
begin
//
end;

procedure TFrmMain.popAddClassClick(Sender: TObject);
Var lNode : PVirtualNode;

    lNodeData  : PInterface;
    lNodeClsList : IHsVTClassCodeGeneratorsNode;
begin
  lNode := vstProject.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := vstProject.GetNodeData(lNode);
    If Assigned(lNodeData) And
       Supports(lNodeData^, IHsVTClassCodeGeneratorsNode, lNodeClsList) Then
    Begin
      With lNodeClsList.Add() Do
        ClsName := 'MyClass';

      vstProject.ReinitNode(lNode, True);
      vstProject.FocusedColumn := 1;
      vstProject.FocusedNode   := lNode.LastChild;

      MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
      UpdatePropertyDefNodeVisible();
    End;
  End;
end;

procedure TFrmMain.popAddPropertyClick(Sender: TObject);
Var lNode : PVirtualNode;

    lNodeData  : PInterface;
    lNodeProps : IHsVTPropertyDefsNode;
    lNodeGen   : IHsVTClassCodeGeneratorNode;
begin
  lNode := vstProject.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := vstProject.GetNodeData(lNode);
    If Assigned(lNodeData) And
       Supports(lNodeData^, IHsVTPropertyDefsNode, lNodeProps) Then
    Begin
      With lNodeProps.Add() Do
      Begin
        PropertyName := 'Property';
        PropertyType := ptByte;

        lNodeData := vstProject.GetNodeData(lNode.Parent);

        If Supports(lNodeData^, IHsVTClassCodeGeneratorNode, lNodeGen) Then
        Begin
          Settings.NodeSettingByName('IsDataAware').SettingVisible := lNodeGen.DataType <> dsNone;
          Settings.NodeSettingByName('FieldName').SettingVisible   := lNodeGen.DataType = dsMSSql;
          Settings.NodeSettingByName('IsId').SettingVisible        := lNodeGen.DataType = dsMSSql;
        End;
      End;

      vstProject.ReinitNode(lNode, True);
      vstProject.FocusedColumn := 1;
      vstProject.FocusedNode   := lNode.LastChild;
    End;
  End;
end;

Procedure TFrmMain.DovstProjectExpandNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; Var Abort: Boolean);
Begin
  Sender.Expanded[Node] := PBoolean(Data)^;
End;

procedure TFrmMain.Exit1Click(Sender: TObject);
begin
  Close();
end;

procedure TFrmMain.popExpandAllClick(Sender: TObject);
Var lNode : PVirtualNode;
    AExpanded : Boolean;
begin
  lNode := vstProject.GetFirstSelected();
  AExpanded := True;
  vstProject.IterateSubtree(lNode, DovstProjectExpandNode, @AExpanded);//, [], True, True);
end;

procedure TFrmMain.popCollapseAllClick(Sender: TObject);
Var lNode : PVirtualNode;
    AExpanded : Boolean;
begin
  lNode := vstProject.GetFirstSelected();
  AExpanded := False;
  vstProject.IterateSubtree(lNode, DovstProjectExpandNode, @AExpanded);//, [], True, True);
end;

procedure TFrmMain.popDataBindingHexEditTemplateClick(Sender: TObject);
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Xml Files|*.xml';

    If Execute() Then
    Begin
      If TCodeGenBuilder.InitGenerator(dsXml, FTreeDataEx, FileName) Then
      Begin
        vstProject.ReinitNode(Nil, True);
        MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
        UpdatePropertyDefNodeVisible();
      End;
    End;

    Finally
      Free();
  End;
end;

procedure TFrmMain.popDataBindingJSonClick(Sender: TObject);
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'JSon Files|*.json';

    If Execute() Then
    Begin
      If TCodeGenBuilder.InitGenerator(dsJSon, FTreeDataEx, FileName) Then
      Begin
        vstProject.ReinitNode(Nil, True);
        MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
        UpdatePropertyDefNodeVisible();
      End;
    End;

    Finally
      Free();
  End;
end;

procedure TFrmMain.popDataBindingSQLServerClick(Sender: TObject);
begin
  With TCodeGenBuilder.Create() Do
  Try
    FDlgOptions := FAppOptions.MsSqlOptions;

    If InitGenerator(dsMSSql, FTreeDataEx) Then
    Begin
      vstProject.ReinitNode(Nil, True);
      MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
      UpdatePropertyDefNodeVisible();
    End;
    
    Finally
      Free();
  End;
end;

procedure TFrmMain.popDeleteClassClick(Sender: TObject);
Var lNode : PVirtualNode;

    lNodeData  : PInterface;
    lNodeCls : IHsVTClassCodeGeneratorNode;
    lNodeClsList : IHsVTClassCodeGeneratorsNode;
begin
  lNode := vstProject.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := vstProject.GetNodeData(lNode);
    If Assigned(lNodeData) And
       Supports(lNodeData^, IHsVTClassCodeGeneratorNode, lNodeCls) Then
    Begin
      lNodeData := vstProject.GetNodeData(lNode.Parent);
      If Assigned(lNodeData) And
         Supports(lNodeData^, IHsVTClassCodeGeneratorsNode, lNodeClsList) Then
        lNodeClsList.Remove(lNodeCls);

      vstProject.ReinitNode(lNode.Parent, True);
      MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
    End;
  End;
end;

procedure TFrmMain.popAddMethodClick(Sender: TObject);
Var lNode        : PVirtualNode;
    lNodeData    : PInterface;
    lNodeMethods : IHsVTProcedureDefsNode;
begin
  lNode := vstProject.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := vstProject.GetNodeData(lNode);
    If Assigned(lNodeData) And
       Supports(lNodeData^, IHsVTProcedureDefsNode, lNodeMethods) Then
    Begin
      With lNodeMethods.Add() Do
      Begin
        ProcedureName := 'Procedure';
        ResultType    := rtNone;

        ProcedureImpl.Add('Begin');
        ProcedureImpl.Add('');
        ProcedureImpl.Add('End;');
      End;

      vstProject.ReinitNode(lNode, True);
      vstProject.FocusedColumn := 1;
      vstProject.FocusedNode   := lNode.LastChild;
    End;
  End;
end;

procedure TFrmMain.popDeleteMethodClick(Sender: TObject);
Var lNode : PVirtualNode;

    lNodeData  : PInterface;
    lNodeProp  : IHsVTProcedureDefNode;
    lNodeProps : IHsVTProcedureDefsNode;
begin
  lNode := vstProject.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := vstProject.GetNodeData(lNode);
    If Assigned(lNodeData) And
       Supports(lNodeData^, IHsVTProcedureDefNode, lNodeProp) Then
    Begin
      lNodeData := vstProject.GetNodeData(lNode.Parent);
      If Assigned(lNodeData) And
         Supports(lNodeData^, IHsVTProcedureDefsNode, lNodeProps) Then
         lNodeProps.Remove(lNodeProp);

      vstProject.ReinitNode(lNode.Parent, True);
      MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
    End;
  End;
end;

procedure TFrmMain.popDeletePropertyClick(Sender: TObject);
Var lNode : PVirtualNode;

    lNodeData  : PInterface;
    lNodeProp  : IHsVTPropertyDefNode;
    lNodeProps : IHsVTPropertyDefsNode;
begin
  lNode := vstProject.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := vstProject.GetNodeData(lNode);
    If Assigned(lNodeData) And
       Supports(lNodeData^, IHsVTPropertyDefNode, lNodeProp) Then
    Begin
      lNodeData := vstProject.GetNodeData(lNode.Parent);
      If Assigned(lNodeData) And
         Supports(lNodeData^, IHsVTPropertyDefsNode, lNodeProps) Then
         lNodeProps.Remove(lNodeProp);

      vstProject.ReinitNode(lNode.Parent, True);
      MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
    End;
  End;
end;

procedure TFrmMain.popVTProjectClosePopup(Sender: TObject);
begin
  vstProject.Invalidate();
end;

procedure TFrmMain.popVTProjectPopup(Sender: TObject);
Var lNode : PVirtualNode;
    lNodeData : PInterface;
begin
  lNode := vstProject.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := vstProject.GetNodeData(lNode);
    UpdateButtons(lNodeData);
    If Assigned(lNodeData) Then
    Begin
      If Not (
          Supports(lNodeData^, IHsVTTypeDefsNode) Or
          Supports(lNodeData^, IHsVTClassCodeGeneratorsNode) Or
          Supports(lNodeData^, IHsVTClassCodeGeneratorNode) Or
          Supports(lNodeData^, IHsVTPropertyDefsNode) Or
          Supports(lNodeData^, IHsVTPropertyDefNode) Or
          Supports(lNodeData^, IHsVTProcedureDefsNode) Or
          Supports(lNodeData^, IHsVTProcedureDefNode)
      ) Then
        Abort;
    End
    Else
      Abort;
  End
  Else
    Abort;
end;

procedure TFrmMain.SpTBXExitClick(Sender: TObject);
begin
  Close();
end;

procedure TFrmMain.SpTBXSaveAsClick(Sender: TObject);
begin
  With TSaveDialog.Create(Self) Do
  Try
    Filter := 'All Files|*.xml;*.json|Xml Files|*.xml|JSon Files|*.json';

    If Execute() Then
    Begin
      FFileName := FileName;
      SpTBXMRU.MRUAdd(FFileName);
      Caption := cApplicationCaption + ' - ' + ExtractFileName(FFileName);
      SpTBXTitleBar.Caption := Caption;
    End;

    Finally
      Free();
  End;

  If FFileName <> '' Then
    FTreeDataEx.SaveToFile(FFileName);
end;

procedure TFrmMain.SpTBXMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ([ssCtrl, ssAlt, ssShift, ssRight] * Shift  = Shift) And (Button = mbRight) Then
  Begin
    With vstProject.Header.Columns[3] Do
      If coVisible In Options Then
        Options := Options - [coVisible]
      Else
        Options := Options + [coVisible];
  End;
end;

procedure TFrmMain.SpTBXMRUClick(Sender: TObject; const Filename: WideString);
begin
  If FileExists(Filename) Then
  Begin
    FTreeDataEx.LoadFromFile(Filename);
    MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
    vstProject.ReinitNode(Nil, True);
    UpdatePropertyDefNodeVisible();

    FFileName := FileName;
    Caption := cApplicationCaption + ' - ' + ExtractFileName(FFileName);
    SpTBXTitleBar.Caption := Caption;
  End;
end;

procedure TFrmMain.SpTBXSkinMenuClick(Sender: TObject);
begin
  SpTBXTitleBar.Active := Not SameText(TSpTBXItem(Sender).Caption, 'Default');
end;

Procedure TFrmMain.UpdatePropertyDefNodeVisible();
Var X, Y : Integer;
Begin
  For X := 0 To FTreeDataEx.ClassDefs.Count - 1 Do
    With FTreeDataEx.ClassDefs[X] Do
    Begin
      MsSQLSettings.SettingVisible := DataType In [dsMSSql];
      ListSettings.SettingsVisible := MakeList;
      
      For Y := 0 To PropertyDefs.Count - 1 Do
        With PropertyDefs[Y], Settings Do
        Begin
          NodeSettingByName('IsDataAware').SettingVisible := DataType <> dsNone;

          NodeSettingByName('ClassName').SettingVisible   := PropertyType In [ptObject];

          NodeSettingByName('InterfaceName').SettingVisible := PropertyType In [ptInterface];
          NodeSettingByName('InterfaceImplementor').SettingVisible := PropertyType In [ptInterface];

          NodeSettingByName('FieldName').SettingVisible   := DataType In [dsMSSql];
          NodeSettingByName('IsId').SettingVisible        := DataType In [dsMSSql];

          NodeSettingByName('MaxLen').SettingVisible      := PropertyType In [ptString, ptWideString];
          NodeSettingByName('IsBigEndian').SettingVisible := PropertyType In [ptWord, ptDWord, ptQWord];
        End;
    End;
End;

(*
  TTypeData = packed record
    case TTypeKind of
      tkUnknown, tkLString, tkWString, tkVariant: ();
      tkInteger, tkChar, tkEnumeration, tkSet, tkWChar: (
        OrdType: TOrdType;
        case TTypeKind of
          tkInteger, tkChar, tkEnumeration, tkWChar: (
            MinValue: Longint;
            MaxValue: Longint;
            case TTypeKind of
              tkInteger, tkChar, tkWChar: ();
              tkEnumeration: (
                BaseType: PPTypeInfo;
				NameList: ShortStringBase;
        EnumUnitName: ShortStringBase));
          tkSet: (
            CompType: PPTypeInfo));
      tkFloat: (
        FloatType: TFloatType);
      tkString: (
        MaxLength: Byte);
      tkClass: (
        ClassType: TClass;
        ParentInfo: PPTypeInfo;
        PropCount: SmallInt;
        UnitName: ShortStringBase;
       {PropData: TPropData});
      tkMethod: (
        MethodKind: TMethodKind;
        ParamCount: Byte;
        ParamList: array[0..1023] of Char
       {ParamList: array[1..ParamCount] of
          record
            Flags: TParamFlags;
            ParamName: ShortString;
            TypeName: ShortString;
          end;
        ResultType: ShortString});
      tkInterface: (
        IntfParent : PPTypeInfo; { ancestor }
        IntfFlags : TIntfFlagsBase;
        Guid : TGUID;
        IntfUnit : ShortStringBase;
       {PropData: TPropData});
      tkInt64: (
        MinInt64Value, MaxInt64Value: Int64);
	  tkDynArray: (
		elSize: Longint;
		elType: PPTypeInfo;       // nil if type does not require cleanup
		varType: Integer;         // Ole Automation varType equivalent
		elType2: PPTypeInfo;      // independent of cleanup
    DynUnitName: ShortStringBase);
  end;
*)

procedure TFrmMain.ToolButton1Click(Sender: TObject);
Var lTypeData  : PTypeData;
    lEnumNames : PByteArray;
    X          : Integer;
    lLst : TStringList;
    lStrStrm : IStringStreamEx;
    lMemStrm : IMemoryStreamEx;
    lBase64Str : String;
    lBase64Data : Array Of Byte;
    lCurString : String;
    lZip : TAbZipKit;

    lHegFile : IHegFile;
    lDate : TDateTime;
begin
  //376680

Exit;
  lMemStrm := TMemoryStreamEx.Create();
  Try
    lMemStrm.LoadFromFile('Y:\Temp\DateFormat.hex');
{
    ShowMessage(FormatDateTime('yyyy-mm-dd hh:mm:ss', lMemStrm.ReadDateTime(dtNormalTimeT)));
    lMemStrm.Seek($18, soFromBeginning);
    ShowMessage(FormatDateTime('yyyy-mm-dd hh:mm:ss', lMemStrm.ReadDateTime(dtSystemTime)));
}
    lMemStrm.Seek($4, soFromBeginning);
    ShowMessage(IntToStr(lMemStrm.ReadDWord()));
//    ShowMessage(FormatDateTime('yyyy-mm-dd hh:mm:ss', lMemStrm.ReadDateTime(dtTimeT51)));

    Finally
      lMemStrm := Nil;
  End;
Exit;
  lHegFile := THegFile.Create();
  lMemStrm := TMemoryStreamEx.Create();
  Try
    lMemStrm.LoadFromFile('Y:\Temp\tutorial.HEG');
    lHegFile.LoadFromStream(lMemStrm);

    Finally
      lHegFile := Nil;
      lMemStrm := Nil;
  End;
Exit;
(*
  lZip := TAbZipKit.Create(Nil);
  lMemStrm := TMemoryStreamEx.Create();
  lStrStrm := TStringStreamEx.Create();
  Try
    lZip.OpenArchive('Config.zip');
    lZip.Password := 'krecos1990';
    lZip.ExtractToStream('Config', TStream(lStrStrm.InterfaceObject));

    lStrStrm.Position := 0;
    FAppOptions.DecryptStream(lStrStrm, lMemStrm);
    FAppOptions.LoadFromStream(lMemStrm);
    lZip.CloseArchive();

    Finally
      lZip.Free();
      lMemStrm := Nil;
      lStrStrm := Nil;
  End;
Exit;
  lZip := TAbZipKit.Create(Nil);
  lMemStrm := TMemoryStreamEx.Create();
  Try
    lMemStrm.LoadFromFile('DelphiCodeGenerator.Hex');

    lZip.CompressionMethodToUse := smDeflated;
    lZip.DeflationOption        := doMaximum;
    lZip.FileName               := 'Config.zip';
    lZip.Password               := 'krecos1990';
    lZip.AddFromStream('Config', TStream(lMemStrm.InterfaceObject));
    lZip.CloseArchive();

    Finally
      lZip.Free();
      lMemStrm := Nil;
  End;
Exit;
*)
{  lLst := TStringList.Create();
  Try
    lLst.LoadFromFile('DelphiCodeGenerator.xml');
    lIo := TXmlApplicationOptions.CreateApplicationOptions(lLst.Text);
    ShowMessage(lIo.GlobalOptions.MRUList[0].FileName);

    Finally
      lIo := Nil;
  End;
//  ShowMessage(FAppOptions.AsXml);
Exit;}
  lLst := TStringList.Create();
  Try
    lLst.LoadFromFile('Z:\Temp\HegFile2.xml');
    lLst.Text := FormatXMLData(lLst.Text);
    lLst.SaveToFile('Z:\Temp\HegFile2.xml');

    Finally
      lLst.Free();
  End;
Exit;
{
  lOptions := TSearchParametersIO.CreateParameters('00SearchOpt.ini');
  lOptions.SaveToXml('00SearchOpt.Xml');
  lOptions.SaveToJSon('00SearchOpt.JSon');
  lOptions.SaveToFile('00SearchOpt.Bin');
}
Exit;
  lTypeData := GetTypeData(GetTypeData(TypeInfo(THsFunctionFlags)).CompType^);
  lEnumNames := @lTypeData.NameList;
  With TStringList.Create() Do
  Try
    For X := lTypeData.MinValue To lTypeData.MaxValue Do
    Begin
      Add(Copy(PChar(lEnumNames), 2, lEnumNames[0]));
      lEnumNames := @lEnumNames[lEnumNames[0] + 1];
    End;

    ShowMessage(Text);
    
    Finally
      Free();
  End;
end;

procedure TFrmMain.vstProjectBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
Var lNodeData : PInterface;
begin
  lNodeData := Sender.GetNodeData(Node);
  If Assigned(lNodeData) Then
  Begin
    If Supports(lNodeData^, IHsVTPropertyDefsNode) Or
       Supports(lNodeData^, IHsVTSettingNodes) Or
       Supports(lNodeData^, IHsVTClassCodeGeneratorsNode) Or
       Supports(lNodeData^, IHsVTTypeDefsNode) Or
       Supports(lNodeData^, IHsVTProcedureDefsNode) Or
       (Supports(lNodeData^, IHsVTSettingNode) And (Column = 1)) Or
       Supports(lNodeData^, IHsVTListSettingsNode) Then
    Begin
      TargetCanvas.Brush.Color := clBtnFace;
      TargetCanvas.FillRect(CellRect);
    End;{
    Else
    Begin
      TargetCanvas.Brush.Color := clNavy;//clInfoBk;
      TargetCanvas.FillRect(CellRect);
    End;}
  End;
end;

Procedure TFrmMain.DoEditorButtonClick(Sender : TObject; Node : PVirtualNode);
Var lNodeData : PInterface;
    lSetting  : IHsVTSettingNode;
Begin
  lNodeData := TBaseVirtualTree(Sender).GetNodeData(Node);

  If Assigned(lNodeData) And Supports(lNodeData^, IHsVTSettingNode, lSetting) Then
  Begin
    ShowMessage(lSetting.SettingValue);
  End;
//  ShowMessage('Dah');
End;

Procedure TFrmMain.vstProjectCreateEditor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; Out EditLink: IVTEditLink);
Var lEditor : TVTProjectEditor;
Begin
  lEditor               := TVTProjectEditor.Create();
  lEditor.UseButtonEdit := True;
  lEditor.OnButtonClick := DoEditorButtonClick;

  EditLink              := lEditor;
End;

procedure TFrmMain.vstProjectEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
Var lNodeData : PInterface;
begin
  Allowed := True;
  lNodeData := Sender.GetNodeData(Node);

  If Assigned(lNodeData) Then
  Begin
    If (Supports(lNodeData^, IHsVTSettingNode) Or
        Supports(lNodeData^, IHsVTPropertyDefsNode) Or
        Supports(lNodeData^, IHsVTSettingNodes) Or
        Supports(lNodeData^, IHsVTClassCodeGeneratorsNode)Or
        Supports(lNodeData^, IHsVTTypeDefsNode)) And
       (Column = 1) Then
       Allowed := False;
  End;
end;

Procedure TFrmMain.DoSearchReplaceText(AReplace: Boolean; ABackwards: Boolean);
Var
  Options: TSynSearchOptions;
Begin
//  Statusbar.SimpleText := '';
  If AReplace Then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  Else
    Options := [];

  If FAppOptions.SearchOptions.Backward Then
    Include(Options, ssoBackwards);

  If FAppOptions.SearchOptions.CaseSensitive Then
    Include(Options, ssoMatchCase);

  If Not FAppOptions.SearchOptions.FromCaret Then
    Include(Options, ssoEntireScope);

  If FAppOptions.SearchOptions.SelectionOnly Then
    Include(Options, ssoSelectedOnly);

  If FAppOptions.SearchOptions.WholeWords Then
    Include(Options, ssoWholeWord);

  MemoPreview.SearchEngine := SynEditSearch;

  If MemoPreview.SearchReplace(FAppOptions.SearchOptions.SearchText, FAppOptions.SearchOptions.ReplaceText, Options) = 0 Then
  Begin
    MessageBeep(MB_ICONASTERISK);
//    Statusbar.SimpleText := STextNotFound;

    If ssoBackwards In Options Then
      MemoPreview.BlockEnd := MemoPreview.BlockBegin
    Else
      MemoPreview.BlockBegin := MemoPreview.BlockEnd;

    MemoPreview.CaretXY := MemoPreview.BlockBegin;
  End;
End;

Procedure TFrmMain.ShowSearchReplaceDialog(AReplace: Boolean);
Var lSearchDlg : TTextSearchDialog;
Begin
  lSearchDlg := TTextSearchDialog.Create(Self);

  With lSearchDlg Do
  Try
    IsReplaceDialog := AReplace;

    // start with last search text
    If FAppOptions.SearchOptions.TextAtCaret Then
    Begin
      // if something is selected search for that text
      If MemoPreview.SelAvail And (MemoPreview.BlockBegin.Line = MemoPreview.BlockEnd.Line) Then
        FAppOptions.SearchOptions.SearchText := MemoPreview.SelText
      Else
        FAppOptions.SearchOptions.SearchText := MemoPreview.GetWordAtRowCol(MemoPreview.CaretXY);
    End;

    SearchOptions   := FAppOptions.SearchOptions;

    If ShowModal = mrOK Then
    Begin
      If SearchOptions.SearchText <> '' Then
        DoSearchReplaceText(AReplace, SearchOptions.Backward);
    End;

    Finally
      Release();
  End;
End;

Procedure TFrmMain.UpdateButtons(ACurItem : PInterface);
Begin
  popAddTypeDef.Enabled     := False;
  popDeleteTypeDef.Enabled  := False;
  popAddClass.Enabled       := False;
  popDeleteClass.Enabled    := False;
  popAddProperty.Enabled    := False;
  popDeleteProperty.Enabled := False;
  popAddMethod.Enabled      := False;
  popDeleteMethod.Enabled   := False;

  If Assigned(ACurItem) Then
  Begin
    If Supports(ACurItem^, IHsVTTypeDefsNode) Then
      popAddTypeDef.Enabled := True
    Else If Supports(ACurItem^, IHsVTClassCodeGeneratorsNode) Then
      popAddClass.Enabled := True
    Else If Supports(ACurItem^, IHsVTClassCodeGeneratorNode) Then
      popDeleteClass.Enabled := True
    Else If Supports(ACurItem^, IHsVTPropertyDefsNode) Then
      popAddProperty.Enabled := True
    Else If Supports(ACurItem^, IHsVTPropertyDefNode) Then
      popDeleteProperty.Enabled := True
    Else If Supports(ACurItem^, IHsVTProcedureDefsNode) Then
      popAddMethod.Enabled := True
    Else If Supports(ACurItem^, IHsVTProcedureDefNode) Then
      popDeleteMethod.Enabled := True;
  End;
End;

procedure TFrmMain.vstProjectFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
Var lNodeData : PInterface;
begin
  If Sender.IsEditing Then
    Sender.EndEditNode();

  If Assigned(Node) Then
  Begin
    lNodeData := Sender.GetNodeData(Node);
    If Supports(lNodeData^, IHsVTUnitGeneratorNode) Then
      Sender.EditNode(Node, 1)
    Else If Supports(lNodeData^, IHsVTClassCodeGeneratorNode) Then
      Sender.EditNode(Node, 1)
    Else If Supports(lNodeData^, IHsVTProcedureDefNode) Then
      Sender.EditNode(Node, 1)
    Else If Supports(lNodeData^, IHsVTPropertyDefNode) Or
            Supports(lNodeData^, IHsVTTypeDefNode) Then
      Sender.EditNode(Node, Column)
    Else If Supports(lNodeData^, IHsVTSettingNode) And (Sender.FocusedColumn = 2) Then
      Sender.EditNode(Node, 2);

    UpdateButtons(lNodeData);
  End;
end;

procedure TFrmMain.vstProjectGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
Var lNodeData : PInterface;

    lNodeUnit     : IHsVTUnitGeneratorNode;
    lNodeTypeDef  : IHsVTTypeDefNode;
    lNodeTypeDefs : IHsVTTypeDefsNode;
    lNodeClsList  : IHsVTClassCodeGeneratorsNode;
    lNodeCls      : IHsVTClassCodeGeneratorNode;
    lNodeProps    : IHsVTPropertyDefsNode;
    lNodeProp     : IHsVTPropertyDefNode;
    lMethods      : IHsVTProcedureDefsNode;
    lMethod       : IHsVTProcedureDefNode;     
    lNodeSettings : IHsVTSettingNodes;
    lNodeSetting  : IHsVTSettingNode;
    lNodeListSettings : IHsVTListSettingsNode;
begin
  CellText := '';

  lNodeData := Sender.GetNodeData(Node);
  If Assigned(lNodeData) Then
  Begin
    If Supports(lNodeData^, IHsVTUnitGeneratorNode, lNodeUnit) Then
    Begin
      If Column = 1 Then
        CellText := lNodeUnit.UnitName;
    End
    Else If Supports(lNodeData^, IHsVTTypeDefsNode, lNodeTypeDefs) Then
    Begin
      If Column = 1 Then
        CellText := 'TypeDefs';
    End
    Else If Supports(lNodeData^, IHsVTTypeDefNode, lNodeTypeDef) Then
    Begin
      If Column = 1 Then
        CellText := lNodeTypeDef.TypeDefName
      Else If Column = 2 Then
        CellText := GetEnumName(TypeInfo(THsTypeDefType), Ord(lNodeTypeDef.TypeDefType));
    End
    Else If Supports(lNodeData^, IHsVTClassCodeGeneratorsNode, lNodeClsList) Then
    Begin
      If Column = 1 Then
        CellText := 'Classes';
    End
    Else If Supports(lNodeData^, IHsVTClassCodeGeneratorNode, lNodeCls) Then
    Begin
      If Column = 1 Then
        CellText := lNodeCls.ClsName;
    End
    Else If Supports(lNodeData^, IHsVTSettingNodes, lNodeSettings) Then
    Begin
      If Column = 1 Then
        CellText := lNodeSettings.NodeCaption;//+ '(' + IntToStr(lNodeSettings.Count) + ')';
    End
    Else If Supports(lNodeData^, IHsVTSettingNode, lNodeSetting) Then
    Begin
      If Column = 1 Then
        CellText := lNodeSetting.SettingName
      Else If Column = 2 Then
      Begin
        If lNodeSetting.SettingType = ptStringList Then
          CellText := '(TStrings)'
        Else
          CellText := VarToStr(lNodeSetting.SettingValue);

        If CellText = '' Then
          CellText := ' ';
      End;
    End
    Else If Supports(lNodeData^, IHsVTPropertyDefsNode, lNodeProps) Then
    Begin
      If Column = 1 Then
        CellText := 'Properties (' + IntToStr(lNodeProps.Count) + ')';
    End
    Else If Supports(lNodeData^, IHsVTProcedureDefsNode, lMethods) Then
    Begin
      If Column = 1 Then
        CellText := 'Methods (' + IntToStr(lMethods.Count) + ')';
    End
    Else If Supports(lNodeData^, IHsVTProcedureDefNode, lMethod) Then
    Begin
      If Column = 1 Then
        CellText := lMethod.ProcedureName;
    End
    Else If Supports(lNodeData^, IHsVTPropertyDefNode, lNodeProp) Then
    Begin
      If Column = 1 Then
        CellText := lNodeProp.PropertyName
      Else If Column = 2 Then
        CellText := GetEnumName(TypeInfo(THsPropertyType), Ord(lNodeProp.PropertyType));
    End
    Else If Supports(lNodeData^, IHsVTListSettingsNode, lNodeListSettings) Then
    Begin
      If Column = 1 Then
        CellText := 'List Settings';
    End 
    Else
      CellText := '- ' + GetInterfaceName(lNodeData^);

    If Column = 3 Then
      CellText := GetInterfaceName(lNodeData^);
  End;
end;

procedure TFrmMain.vstProjectInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
Var lNodeData    : PInterface;
    lNodeProp    : IHsVTPropertyDefNode;
    lNodeCount   : IInterfaceListEx;
    lMethods     : IHsVTProcedureDefsNode;
    lMethod      : IHsVTProcedureDefNode;
    lLstSettings : IHsVTListSettingsNode;
begin
  lNodeData := Sender.GetNodeData(Node);
  If Assigned(lNodeData) Then
  Begin
    If Supports(lNodeData^, IHsVTUnitGeneratorNode) Then
      ChildCount := 2
    Else If Supports(lNodeData^, IHsVTTypeDefNode) Then
      ChildCount := 2
    Else If Supports(lNodeData^, IHsVTClassCodeGeneratorNode) Then
      ChildCount := 5
    Else If Supports(lNodeData^, IHsVTPropertyDefNode, lNodeProp) Then
      ChildCount := lNodeProp.Settings.Count
    Else If Supports(lNodeData^, IInterfaceListEx, lNodeCount) Then
      ChildCount := lNodeCount.Count
    Else If Supports(lNodeData^, IHsVTProcedureDefsNode, lMethods) Then
      ChildCount := lMethods.Count
    Else If Supports(lNodeData^, IHsVTProcedureDefNode, lMethod) Then
      ChildCount := lMethod.Settings.Count
    Else If Supports(lNodeData^, IHsVTListSettingsNode, lLstSettings) Then
      ChildCount := lLstSettings.Settings.Count + 1;
  End;
end;

procedure TFrmMain.vstProjectInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
Var lNodeData     : PInterface;
    lNodeUnit     : IHsVTUnitGeneratorNode;
    lNodeTypeDefs : IHsVTTypeDefsNode;
    lNodeTypeDef  : IHsVTTypeDefNode;
    lNodeClsList  : IHsVTClassCodeGeneratorsNode;
    lNodeCls      : IHsVTClassCodeGeneratorNode;
    lNodeProps    : IHsVTPropertyDefsNode;
    lNodeProp     : IHsVTPropertyDefNode;
    lNodeMethods  : IHsVTProcedureDefsNode;
    lNodeMethod   : IHsVTProcedureDefNode;
    lNodeSettings : IHsVTSettingNodes;
    lLstSettings  : IHsVTListSettingsNode;
begin
  If Assigned(ParentNode) Then
  Begin
    lNodeData := Sender.GetNodeData(ParentNode);
    If Assigned(lNodeData) Then
    Begin
      If Supports(lNodeData^, IHsVTUnitGeneratorNode, lNodeUnit) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
        Begin
          If Node.Index = 0 Then
          Begin
            PPointer(lNodeData)^ := Pointer(lNodeUnit.TypeDefs);

            If lNodeUnit.TypeDefs.Count > 0 Then
              InitialStates := InitialStates + [ivsHasChildren];
          End
          Else
          Begin
            PPointer(lNodeData)^ := Pointer(lNodeUnit.ClassDefs);

            If lNodeUnit.ClassDefs.Count > 0 Then
              InitialStates := InitialStates + [ivsHasChildren];
          End;
        End;
      End
      Else If Supports(lNodeData^, IHsVTTypeDefNode, lNodeTypeDef) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
        Begin
          If Node.Index = 0 Then
          Begin
            PPointer(lNodeData)^ := Pointer(lNodeTypeDef.Settings[Node.Index] As IHsVTSettingNode);
            lNodeTypeDef.Settings[Node.Index].VTNode := Node;
          End
          Else If Node.Index = 1 Then
          Begin //<-- Icitte Ciboire
            PPointer(lNodeData)^ := Pointer(lNodeTypeDef.TypeDefMembers As IHsVTPropertyDefsNode);
            lNodeTypeDef.TypeDefMembers.VTNode := Node;

            If lNodeTypeDef.TypeDefType <> dtRecord Then
              Node.States := Node.States - [vsVisible];
            If lNodeTypeDef.TypeDefMembers.Count > 0 Then
              InitialStates := InitialStates + [ivsHasChildren];
          End;
        End;
      End
      Else If Supports(lNodeData^, IHsVTTypeDefsNode, lNodeTypeDefs) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
          PPointer(lNodeData)^ := Pointer(lNodeTypeDefs[Node.Index] As IHsVTTypeDefNode);
        lNodeTypeDefs[Node.Index].VTNode := Node;
        InitialStates := InitialStates + [ivsHasChildren];
      End
      Else If Supports(lNodeData^, IHsVTClassCodeGeneratorNode, lNodeCls) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
        Begin
          If Node.Index = 0 Then
          Begin
            PPointer(lNodeData)^ := Pointer(lNodeCls.Settings);

            lNodeCls.Settings.VTNode := Node;
            If lNodeCls.Settings.Count > 0 Then
              InitialStates := InitialStates + [ivsHasChildren];
          End
          Else If Node.Index = 1 Then
          Begin
            PPointer(lNodeData)^ := Pointer(lNodeCls.MsSQLSettings);

            lNodeCls.MsSQLSettings.VTNode := Node;
            If lNodeCls.MsSQLSettings.Count > 0 Then
              InitialStates := InitialStates + [ivsHasChildren];
//            Node.States := Node.States - [vsVisible];
          End
          Else If Node.Index = 2 Then
          Begin
            PPointer(lNodeData)^ := Pointer(lNodeCls.ListSettings);
            lNodeCls.ListSettings.VTNode := Node;
            InitialStates := InitialStates + [ivsHasChildren];
//            lNodeCls.ListSettings.SettingsVisible := False;
          End
          Else If Node.Index = 3 Then
          Begin
            PPointer(lNodeData)^ := Pointer(lNodeCls.PropertyDefs);

            If lNodeCls.PropertyDefs.Count > 0 Then
              InitialStates := InitialStates + [ivsHasChildren];
          End
          Else If Node.Index = 4 Then
          Begin
            PPointer(lNodeData)^ := Pointer(lNodeCls.ProcedureDefs);

            If lNodeCls.ProcedureDefs.Count > 0 Then
              InitialStates := InitialStates + [ivsHasChildren];
          End;
        End;
      End
      Else If Supports(lNodeData^, IHsVTClassCodeGeneratorsNode, lNodeClsList) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
          PPointer(lNodeData)^ := Pointer(lNodeClsList[Node.Index] As IHsVTClassCodeGeneratorNode);
        InitialStates := InitialStates + [ivsHasChildren];
      End
      Else If Supports(lNodeData^, IHsVTSettingNodes, lNodeSettings) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
          PPointer(lNodeData)^ := Pointer(lNodeSettings[Node.Index]);
      End
      Else If Supports(lNodeData^, IHsVTPropertyDefsNode, lNodeProps) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
          PPointer(lNodeData)^ := Pointer(lNodeProps[Node.Index]);

        lNodeData := Sender.GetNodeData(ParentNode.Parent);
        If Not Supports(lNodeData^, IHsVTTypeDefNode) Then
        Begin
          If lNodeProps[Node.Index].Settings.Count > 0 Then
            InitialStates := InitialStates + [ivsHasChildren];
        End;
      End
      Else If Supports(lNodeData^, IHsVTPropertyDefNode, lNodeProp) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
        Begin
          PPointer(lNodeData)^ := Pointer(lNodeProp.Settings[Node.Index]);
          If Not lNodeProp.Settings[Node.Index].SettingVisible Then
            Node.States := Node.States - [vsVisible];
          lNodeProp.Settings[Node.Index].VTNode := Node;
        End;
      End
      Else If Supports(lNodeData^, IHsVTProcedureDefsNode, lNodeMethods) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
          PPointer(lNodeData)^ := Pointer(lNodeMethods[Node.Index]);

        If lNodeMethods[Node.Index].Settings.Count > 0 Then
          InitialStates := InitialStates + [ivsHasChildren];
      End
      Else If Supports(lNodeData^, IHsVTProcedureDefNode, lNodeMethod) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);
        If Assigned(lNodeData) Then
        Begin
          PPointer(lNodeData)^ := Pointer(lNodeMethod.Settings[Node.Index]);
          If Not lNodeMethod.Settings[Node.Index].SettingVisible Then
            Node.States := Node.States - [vsVisible];
          lNodeMethod.Settings[Node.Index].VTNode := Node;
        End;
      End
      Else If Supports(lNodeData^, IHsVTListSettingsNode, lLstSettings) Then
      Begin
        lNodeData := Sender.GetNodeData(Node);

        If Assigned(lNodeData) Then
        Begin
          If Node.Index < lLstSettings.Settings.Count Then
            PPointer(lNodeData)^ := Pointer(lLstSettings.Settings[Node.Index])
          Else
          Begin
            PPointer(lNodeData)^ := Pointer(lLstSettings.Methods);
            If lLstSettings.Methods.Count > 0 Then
              InitialStates := InitialStates + [ivsHasChildren];
          End;
        End;
      End;
    End;
  End
  Else
  Begin
    lNodeData := Sender.GetNodeData(Node);
    PPointer(lNodeData)^ := Pointer(FTreeDataEx);
    InitialStates := InitialStates + [ivsHasChildren];
  End;

  InitialStates := InitialStates + [ivsExpanded];
end;

procedure TFrmMain.vstProjectKeyAction(Sender: TBaseVirtualTree;
  var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
Var lNode : PVirtualNode;
    lNodeData : PInterface;
    lList : IInterfaceListEx;
begin
  DoDefault := True;

  lNode := Sender.GetFirstSelected();
  If Assigned(lNode) Then
  Begin
    lNodeData := Sender.GetNodeData(lNode);
    If (Supports(lNodeData^, IHsVTClassCodeGeneratorNode) Or
        Supports(lNodeData^, IHsVTPropertyDefNode)) And
       (ssCtrl In Shift) Then
    Begin
      lNodeData := Sender.GetNodeData(lNode.Parent);
      If Supports(lNodeData^, IInterfaceListEx, lList) Then
        Case CharCode Of
          VK_UP :
          Begin
            If Assigned(lNode.PrevSibling) Then
            Begin
              lList.Exchange(lNode.Index, lNode.Index - 1);
              Sender.MoveTo(lNode, lNode.PrevSibling, amInsertBefore, False);
              MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
            End;
          End;

          VK_DOWN :
          Begin
            If Assigned(lNode.NextSibling) Then
            Begin
              lList.Exchange(lNode.Index, lNode.Index + 1);
              Sender.MoveTo(lNode, lNode.NextSibling, amInsertAfter, False);
              MemoPreview.Text := FTreeDataEx.GenerateUnitCode();
            End;
          End;
        End;
    End;
  End;
end;

procedure TFrmMain.vstProjectNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
Var lNodeData : PInterface;

    lNodeUnit     : IHsVTUnitGeneratorNode;
    lNodeTypeDef  : IHsVTTypeDefNode;
    lNodeClass    : IHsVTClassCodeGeneratorNode;
    lNodeSetting  : IHsVTSettingNode;
    lNodeProperty : IHsVTPropertyDefNode;
    lNodeMethod   : IHsVTProcedureDefNode;
begin
  lNodeData := Sender.GetNodeData(Node);
  If Assigned(lNodeData) Then
  Begin
    If Supports(lNodeData^, IHsVTUnitGeneratorNode, lNodeUnit) Then
    Begin
      If Column = 1 Then
        lNodeUnit.UnitName := NewText;
      MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
    End
    Else If Supports(lNodeData^, IHsVTClassCodeGeneratorNode, lNodeClass) Then
    Begin
      If lNodeClass.ClsName <> NewText Then
      Begin
        lNodeClass.ClsName := NewText;
        MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
      End;
    End
    Else If Supports(lNodeData^, IHsVTSettingNode, lNodeSetting) Then
    Begin
      If Column = 1 Then
      Begin
        If lNodeSetting.SettingName <> NewText Then
        Begin
          lNodeSetting.SettingName := NewText;
          MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
        End;
      End
      Else If Column = 2 Then
      Begin
        If lNodeSetting.SettingValue <> NewText Then
        Begin
          lNodeSetting.SettingValue := NewText;
          MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
        End;
      End;
    End
    Else If Supports(lNodeData^, IHsVTTypeDefNode, lNodeTypeDef) Then
    Begin
      If Column = 1 Then
        lNodeTypeDef.TypeDefName := NewText
      Else If Column = 2 Then
        lNodeTypeDef.TypeDefType := THsTypeDefType(GetEnumValue(TypeInfo(THsTypeDefType), NewText));

      MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
    End
    Else If Supports(lNodeData^, IHsVTPropertyDefNode, lNodeProperty) Then
    Begin
      If Column = 1 Then
        lNodeProperty.PropertyName := NewText
      Else If Column = 2 Then
        lNodeProperty.PropertyType := THsPropertyType(GetEnumValue(TypeInfo(THsPropertyType), NewText));

      MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
    End
    Else If Supports(lNodeData^, IHsVTProcedureDefNode, lNodeMethod) Then
    Begin
      If lNodeMethod.ProcedureName <> NewText Then
      Begin
        lNodeMethod.ProcedureName := NewText;
        MemoPreview.Lines.Text := FTreeDataEx.GenerateUnitCode();
      End;
    End;
  End;
end;

Initialization
  RegisterInterface('IHsVTSettingNode', IHsVTSettingNode);
  RegisterInterface('IHsVTSettingNodes', IHsVTSettingNodes);
  RegisterInterface('IHsVTPropertyDefNode', IHsVTPropertyDefNode);
  RegisterInterface('IHsVTPropertyDefsNode', IHsVTPropertyDefsNode);
  RegisterInterface('IHsVTClassCodeGeneratorNode', IHsVTClassCodeGeneratorNode);
  RegisterInterface('IHsVTClassCodeGeneratorsNode', IHsVTClassCodeGeneratorsNode);
  RegisterInterface('IHsVTUnitGeneratorNode', IHsVTUnitGeneratorNode);
  RegisterInterface('IHsVTTypeDefsNode', IHsVTTypeDefsNode);
  RegisterInterface('IHsVTTypeDefNode', IHsVTTypeDefNode);
  RegisterInterface('IHsVTProcedureDefsNode', IHsVTProcedureDefsNode);
  RegisterInterface('IHsVTProcedureDefNode', IHsVTProcedureDefNode);
  RegisterInterface('IHsVTListSettingsNode', IHsVTListSettingsNode);

end.
