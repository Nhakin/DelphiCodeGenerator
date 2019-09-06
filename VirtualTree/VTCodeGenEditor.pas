unit VTCodeGenEditor;

interface

Uses
  Windows, Messages, Classes, Controls,
  VirtualTrees, VTEditors, VTCombos{$IfDef VT60}, VirtualTrees.D2007Types{$EndIf};

Type
  TProjectEditorEvent = Procedure(Sender : TObject; Node : PVirtualNode) Of Object;
  
  TVTProjectEditor = Class(TInterfacedObject, IVTEditLink)
  Private
    FEdit          : TWinControl;
    FTree          : TVirtualStringTree;
    FNode          : PVirtualNode;
    FColumn        : Integer;
    FUseButtonEdit : Boolean;
    FButtonClick   : TProjectEditorEvent;

    Procedure EditKeyDown(Sender : TObject; Var Key : Word; Shift : TShiftState);
    Procedure EditKeyUp(Sender : TObject; Var Key : Word; Shift : TShiftState);
    Procedure EditChange(Sender : TObject);

    Procedure DoButtonClick(Sender : TObject);

  Protected
    Function BeginEdit() : Boolean; StdCall;
    Function CancelEdit() : Boolean; StdCall;
    Function EndEdit() : Boolean; StdCall;

    Function  GetBounds() : TRect; StdCall;
    Procedure SetBounds(R : TRect); StdCall;

    Function  PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex): Boolean; StdCall;
    Procedure ProcessMessage(Var Message: TMessage); StdCall;

  Public
    Property UseButtonEdit : Boolean             Read FUseButtonEdit Write FUseButtonEdit;
    Property OnButtonClick : TProjectEditorEvent Read FButtonClick   Write FButtonClick;

    Destructor Destroy(); OverRide;

  End;

implementation

Uses SysUtils, Mask, ComCtrls, StdCtrls, TypInfo, Dialogs, Graphics,
  HsInterfaceEx, CodeGenType, CodeGen.VT;

Type
  PInterface = ^IInterfaceEx;

Destructor TVTProjectEditor.Destroy();
Begin
  If FEdit.HandleAllocated Then
    PostMessage(FEdit.Handle, CM_RELEASE, 0, 0);

  InHerited Destroy();
End;

Procedure TVTProjectEditor.EditKeyDown(Sender : TObject; Var Key : Word; Shift : TShiftState);
Var CanAdvance : Boolean;
Begin
  Case Key Of
    VK_ESCAPE : Key := 0;

    VK_RETURN :
    Begin
      FTree.EndEditNode();
      Key := 0;
    End;

    VK_UP, VK_DOWN :
    Begin
      CanAdvance := Shift = [];
      If FEdit Is TVirtualStringTreeDropDown Then //TComboBox Then
        CanAdvance := CanAdvance And Not TComboBox(FEdit).DroppedDown;
      If FEdit Is TDateTimePicker Then
        CanAdvance :=  CanAdvance And Not TDateTimePicker(FEdit).DroppedDown;

      If CanAdvance Then
      Begin
        PostMessage(FTree.Handle, WM_KEYDOWN, Key, 0);
        Key := 0;
      End;
    End;
  End;
End;

Procedure TVTProjectEditor.EditKeyUp(Sender : TObject; Var Key : Word; Shift : TShiftState);
Begin
  Case Key Of
    VK_ESCAPE :
    Begin
      FTree.CancelEditNode();
      Key := 0;
    End;
  End;
End;

Procedure TVTProjectEditor.EditChange(Sender : TObject);
Var lPropType : THsPropertyType;
    lTypeDefType : THsTypeDefType;

    lNodeData : PInterface;
    lPropDef  : IHsVTPropertyDefNode;
    lTypeDef  : IHsVTTypeDefNode;
    lSetting  : IHsVTSettingNode;
    lNodeGen  : IHsVTClassCodeGeneratorNode;

    X : Integer;
    lDataSource : THsDataSource;
Begin
  lNodeData := FTree.GetNodeData(FNode);
  If Assigned(lNodeData) Then
  Begin
    If Supports(lNodeData^, IHsVTPropertyDefNode, lPropDef) Then
    Begin
      lPropType := THsPropertyType(GetEnumValue(TypeInfo(THsPropertyType), GetStrProp(FEdit, 'Text')));

      lPropDef.Settings.NodeSettingByName('MaxLen').SettingVisible               := False;
      lPropDef.Settings.NodeSettingByName('ClassName').SettingVisible            := False;
      lPropDef.Settings.NodeSettingByName('InterfaceName').SettingVisible        := False;
      lPropDef.Settings.NodeSettingByName('InterfaceImplementor').SettingVisible := False;
      lPropDef.Settings.NodeSettingByName('IsBigEndian').SettingVisible          := False;

      Case lPropType Of
        ptString, ptWideString, ptPAnsiChar, ptPWideChar :
        Begin
          lPropDef.Settings.NodeSettingByName('MaxLen').SettingVisible := True;
        End;

        ptObject :
        Begin
          lPropDef.Settings.NodeSettingByName('ClassName').SettingVisible := True;
        End;

        ptInterface :
        Begin
          lPropDef.Settings.NodeSettingByName('InterfaceName').SettingVisible := True;
          lPropDef.Settings.NodeSettingByName('InterfaceImplementor').SettingVisible := True;
        End;

        ptWord, ptDWord :
        Begin
          lPropDef.Settings.NodeSettingByName('IsBigEndian').SettingVisible := True;
        End;
      End;

      FTree.Invalidate();
    End
    Else If Supports(lNodeData^, IHsVTTypeDefNode, lTypeDef) Then
    Begin
      lTypeDefType := THsTypeDefType(GetEnumValue(TypeInfo(THsTypeDefType), GetStrProp(FEdit, 'Text')));
      lTypeDef.Settings.NodeSettingByName('TypeValue').SettingVisible := lTypeDefType <> dtRecord;
      lTypeDef.TypeDefMembers.SettingVisible := lTypeDefType = dtRecord;
      FTree.Invalidate();
    End
    Else If Supports(lNodeData^, IHsVTSettingNode, lSetting) Then
    Begin
      If SameText(lSetting.SettingName, 'DataType') Then
      Begin
        lNodeData := FTree.GetNodeData(FNode.Parent.Parent);

        If Supports(lNodeData^, IHsVTClassCodeGeneratorNode, lNodeGen) Then
        Begin
          lDataSource := THsDataSource(GetEnumValue(lSetting.EnumInfo, GetStrProp(FEdit, 'Text')));

          lNodeGen.MsSQLSettings.SettingVisible := lDataSource = dsMSSql;

          For X := 0 To lNodeGen.PropertyDefs.Count - 1 Do
          Begin
            With lNodeGen.PropertyDefs[X].Settings Do
            Begin
              NodeSettingByName('FieldName').SettingVisible   := lDataSource = dsMSSql;
              NodeSettingByName('IsId').SettingVisible        := lDataSource = dsMSSql;
              NodeSettingByName('IsDataAware').SettingVisible := lDataSource <> dsNone;
            End;
          End;

          FTree.Invalidate();
        End;
      End;
    End;
  End;
End;

Function TVTProjectEditor.BeginEdit() : Boolean;
Begin
  Result := True;
  FEdit.Show();
  FEdit.SetFocus();
End;

Function TVTProjectEditor.CancelEdit() : Boolean;
Begin
  Result := True;
  FEdit.Hide();
  FTree.SetFocus();
End;

Function TVTProjectEditor.EndEdit() : Boolean;
Var S : UnicodeString;
Begin
  Result := True;
  If FEdit Is TMemo Then
  Begin
    S := TMemo(FEdit).Lines.Text;
  End
  Else
  Begin
    S := GetStrProp(FEdit, 'Text');
  End;

  FTree.Text[FNode, FColumn] := S;
  FEdit.Hide();
  FTree.SetFocus();
End;

Function TVTProjectEditor.GetBounds() : TRect;
Begin
  Result := FEdit.BoundsRect;
End;

Procedure TVTProjectEditor.SetBounds(R : TRect);
Var Dummy : Integer;
    lNodeData : PInterface;
Begin
  lNodeData := FTree.GetNodeData(FNode);

  If Assigned(lNodeData) Then
  Begin
    If Supports(lNodeData^, IHsVTClassCodeGeneratorNode) Or
       Supports(lNodeData^, IHsVTUnitGeneratorNode) Then
      FTree.Header.Columns.GetColumnBounds(2, Dummy, R.Right);
    FEdit.BoundsRect := R;
  End
  Else
  Begin
    FTree.Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);
    FEdit.BoundsRect := R;
  End;
End;

Procedure TVTProjectEditor.DoButtonClick(Sender : TObject);
Begin
  If Assigned(FButtonClick) Then
    FButtonClick(FTree, FNode);
End;

Function TVTProjectEditor.PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex) : Boolean;
  Function CreateEdit() : TWinControl;
  Begin
    Result := THsVTEdit.Create(Nil);

    With Result As THsVTEdit Do
    Begin
      Visible   := False;
      Parent    := Tree;
      OnKeyDown := EditKeyDown;
      OnKeyUp   := EditKeyUp;
    End;
  End;

  Function CreateMaskEdit() : TWinControl;
  Begin
    Result := TMaskEdit.Create(Nil);

    With Result As TMaskEdit Do
    Begin
      Visible   := False;
      Parent    := Tree;
      OnKeyDown := EditKeyDown;
      OnKeyUp   := EditKeyUp;
    End;
  End;

  Function CreateMemo() : TWinControl;
  Begin
    Result := TMemo.Create(Nil);

    With Result As TMemo Do
    Begin
      Visible := False;
      Parent  := Tree;
    End;
  End;

  Function CreateButtonEdit() : THsVTButtonEdit;
  Begin
    Result := THsVTButtonEdit.Create(Nil);

    With Result As THsVTButtonEdit Do
    Begin
      Visible := False;
      Parent  := Tree;
    End;
  End;
  
  Function CreateComboBox(Const ACheckSupport : Boolean = False) : TWinControl;
  Begin
    Result := TVirtualStringTreeDropDown.Create(Nil);

    With Result As TVirtualStringTreeDropDown Do
    Begin
      Visible      := False;
      Parent       := Tree;
      OnKeyDown    := EditKeyDown;
      OnKeyUp      := EditKeyUp;
      CheckSupport := ACheckSupport;
    End;
  End;

Var lNodeData : PInterface;
    lPropDef  : IHsVTPropertyDefNode;
    lTypeDef  : IHsVTTypeDefNode;
    lSetting  : IHsVTSettingNode;
Begin
  Result  := True;
  FTree   := Tree As TVirtualStringTree;
  FNode   := Node;
  FColumn := Column;

  If Assigned(FEdit) Then
    FreeAndNil(FEdit);

  lNodeData := FTree.GetNodeData(Node);
  If Assigned(lNodeData) Then
  Begin
    If Supports(lNodeData^, IHsVTPropertyDefNode, lPropDef) Then
    Begin
      If Column = 1 Then
      Begin
        FEdit := CreateEdit();

        With FEdit As THsVTEdit Do
          Text := FTree.Text[Node, Column];
      End
      Else
      Begin
        FEdit := CreateComboBox();

        With FEdit As TVirtualStringTreeDropDown Do
        Begin
          OnChange := EditChange;
          lPropDef.GetPropertyTypeList(Items);
          ItemIndex := Ord(lPropDef.PropertyType);
        End;
      End;
    End
    Else If Supports(lNodeData^, IHsVTTypeDefNode, lTypeDef) Then
    Begin
      If Column = 1 Then
      Begin
        FEdit := CreateEdit();

        With FEdit As THsVTEdit Do
          Text := Trim(FTree.Text[Node, Column]);
      End
      Else
      Begin
        FEdit := CreateComboBox();

        With FEdit As TVirtualStringTreeDropDown Do
        Begin
          OnChange := EditChange;
          lTypeDef.GetTypeDefList(Items);
          ItemIndex := Ord(lTypeDef.TypeDefType);
        End;
      End;
    End
    Else If Supports(lNodeData^, IHsVTSettingNode, lSetting) Then
    Begin
      Case lSetting.SettingType Of
        ptStringList :
        Begin
          If FUseButtonEdit Then
          Begin
            FEdit := CreateButtonEdit();

            With FEdit As THsVTButtonEdit Do
            Begin
              ButtonCaption := '...';
              OnButtonClick := DoButtonClick;
              ReadOnly      := True;
              Color         := clBtnFace;
              Text          := '(TStrings)';
            End;
          End
          Else
          Begin
            FEdit := CreateMemo();

            With FEdit As TMemo Do
              Lines.Text := FTree.Text[Node, Column];
          End;
        End;

        ptBoolean :
        Begin
          FEdit := CreateComboBox();

          With FEdit As TVirtualStringTreeDropDown Do
          Begin
            DropDownCount := 2;
            Items.Add('True');
            Items.Add('False');
            ItemIndex := Items.IndexOf(BoolToStr(lSetting.SettingValue, True));
          End;
        End;

        ptByte, ptInteger, ptSingle :
        Begin
          FEdit := CreateMaskEdit();

          With FEdit As TMaskEdit Do
          Begin
            EditMask  := '9999';
            Text      := FTree.Text[Node, Column];
          End;
        End;

        ptEnum :
        Begin
          FEdit := CreateComboBox();

          With FEdit As TVirtualStringTreeDropDown Do
          Begin
            OnChange := EditChange;
            lSetting.GetEnumNameList(Items);
            ItemIndex := GetEnumValue(lSetting.EnumInfo, lSetting.SettingValue);
          End;
        End;

        Else
          FEdit := CreateEdit();

          With FEdit As THsVTEdit Do
            Text := Trim(FTree.Text[Node, Column]);
      End;
    End
    Else
    Begin
      FEdit := CreateEdit();

      With FEdit As THsVTEdit Do
        Text := FTree.Text[Node, Column];
    End;
  End
  Else
    Result := False;
(*
    vtDate:
    Begin
      FEdit := TDateTimePicker.Create(Nil);

      With FEdit As TDateTimePicker Do
      Begin
        Visible                     := False;
        Parent                      := Tree;
        CalColors.MonthBackColor    := clWindow;
        CalColors.TextColor         := clBlack;
        CalColors.TitleBackColor    := clBtnShadow;
        CalColors.TitleTextColor    := clBlack;
        CalColors.TrailingTextColor := clBtnFace;
        Date                        := StrToDate(Data.Value);
        OnKeyDown                   := EditKeyDown;
        OnKeyUp                     := EditKeyUp;
      End;
    End;

    Else
      Result := False;
  End;
*)
End;

Procedure TVTProjectEditor.ProcessMessage(Var Message: TMessage);
Begin
  FEdit.WindowProc(Message);
End;

end.
