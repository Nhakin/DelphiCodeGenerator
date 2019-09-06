unit ProcedureEditorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls, ImgList, SynEdit, SynMemo,
  SynEditHighlighter, SynHighlighterPas;

type
  TProcedureEditorDlgDah = class(TForm)
    imgToolBar: TImageList;
    Panel2: TPanel;
    tbMain: TToolBar;
    Panel3: TPanel;
    tbSave: TToolButton;
    tbCancel: TToolButton;
    SBMain: TStatusBar;
    Panel1: TPanel;
    SynPasSyn: TSynPasSyn;
    MemoPreview: TSynMemo;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ProcedureEditorDlgDah: TProcedureEditorDlgDah;

implementation

{$R *.dfm}

end.
