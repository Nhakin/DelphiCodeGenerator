program DelphiCodeGenerator;

uses
  Forms,
  VTCodeGenEditor in 'VirtualTree\VTCodeGenEditor.pas',
  VTCombos in 'VirtualTree\VTCombos.pas',
  VTEditors in 'VirtualTree\VTEditors.pas',
  Main in 'Main.pas' {FrmMain},
  MsSqlCfgDlg in 'MsSqlCfgDlg.pas' {FrmMsSqlCfg},
  SuperObject in 'SuperObject.pas',
  dmCodeGen in 'dmCodeGen.pas' {DataModuleCodeGen: TDataModule},
  HEBinFileFormatImpl in 'HEBinFileFormatImpl.pas',
  uArmy in 'TestUnits\uArmy.pas',
  CodeGenImpl in 'CodeGen\CodeGenImpl.pas',
  CodeGenIntf in 'CodeGen\CodeGenIntf.pas',
  CodeGenType in 'CodeGen\CodeGenType.pas',
  HsClipBoardEx in 'HsUnits\HsClipBoardEx.pas',
  HsEncodingEx in 'HsUnits\HsEncodingEx.pas',
  HsInterfaceEx in 'HsUnits\HsInterfaceEx.pas',
  HsSuperObjectEx in 'HsUnits\HsSuperObjectEx.pas',
  HsXmlDocEx in 'HsUnits\HsXmlDocEx.pas',
  CodeGenBuilder in 'CodeBuilder\CodeGenBuilder.pas',
  CodeGen.IO in 'CodeGen\IO\CodeGen.IO.pas',
  CodeGen.JSon in 'CodeGen\IO\DataPlugin\CodeGen.JSon.pas',
  CodeGen.Xml in 'CodeGen\IO\DataPlugin\CodeGen.Xml.pas',
  CodeGen.MsSql in 'CodeGen\IO\DataPlugin\CodeGen.MsSql.pas',
  CodeGen.VT in 'CodeGen\IO\DataPlugin\CodeGen.VT.pas',
  ProcedureEditorDlg in 'ProcedureEditorDlg.pas' {FrmProcedureEditorDlg},
  SearchTextDlg in 'SearchTextDlg.pas' {TextSearchDialog},
  SearchOptionsIntf in 'SearchOptions\SearchOptionsIntf.pas',
  SearchOptionsImpl in 'SearchOptions\SearchOptionsImpl.pas',
  SearchOptions.Xml in 'SearchOptions\IO\DataPlugin\SearchOptions.Xml.pas',
  SearchOptions.JSon in 'SearchOptions\IO\DataPlugin\SearchOptions.JSon.pas',
  SearchOptions.Bin in 'SearchOptions\IO\DataPlugin\SearchOptions.Bin.pas',
  SearchOptions.IO in 'SearchOptions\IO\SearchOptions.IO.pas',
  HsIniFilesEx in 'HsUnits\HsIniFilesEx.pas',
  SearchOptions.Ini in 'SearchOptions\IO\DataPlugin\SearchOptions.Ini.pas',
  MsSqlOptionIntf in 'MsSqlOptions\MsSqlOptionIntf.pas',
  MsSqlOptionImpl in 'MsSqlOptions\MsSqlOptionImpl.pas',
  MsSqlOptions.Xml in 'MsSqlOptions\IO\DataPlugin\MsSqlOptions.Xml.pas',
  MsSqlOptions.JSon in 'MsSqlOptions\IO\DataPlugin\MsSqlOptions.JSon.pas',
  MsSqlOptions.Bin in 'MsSqlOptions\IO\DataPlugin\MsSqlOptions.Bin.pas',
  MsSqlOptions.Ini in 'MsSqlOptions\IO\DataPlugin\MsSqlOptions.Ini.pas',
  MsSqlOption.IO in 'MsSqlOptions\IO\MsSqlOption.IO.pas',
  ApplicationOptionsIntf in 'ApplicationOptions\ApplicationOptionsIntf.pas',
  ApplicationOptionsImpl in 'ApplicationOptions\ApplicationOptionsImpl.pas',
  ApplicationOptions.JSon in 'ApplicationOptions\IO\DataPlugin\ApplicationOptions.JSon.pas',
  ApplicationOptions.Xml in 'ApplicationOptions\IO\DataPlugin\ApplicationOptions.Xml.pas',
  ApplicationOptions.IO in 'ApplicationOptions\IO\ApplicationOptions.IO.pas',
  ApplicationOptions.Ini in 'ApplicationOptions\IO\DataPlugin\ApplicationOptions.Ini.pas',
  ApplicationOptions.Bin in 'ApplicationOptions\IO\DataPlugin\ApplicationOptions.Bin.pas',
  GlobalOptionsIntf in 'GlobalOptions\GlobalOptionsIntf.pas',
  GlobalOptionsImpl in 'GlobalOptions\GlobalOptionsImpl.pas',
  GlobalOptions.Xml in 'GlobalOptions\IO\DataPlugin\GlobalOptions.Xml.pas',
  GlobalOptions.JSon in 'GlobalOptions\IO\DataPlugin\GlobalOptions.JSon.pas',
  GlobalOptions.Ini in 'GlobalOptions\IO\DataPlugin\GlobalOptions.Ini.pas',
  GlobalOptions.Bin in 'GlobalOptions\IO\DataPlugin\GlobalOptions.Bin.pas',
  GlobalOptions.IO in 'GlobalOptions\IO\GlobalOptions.IO.pas',
  HsBase64 in 'HsUnits\HsBase64.pas',
  FastStringFuncs in 'HsUnits\FastStringFuncs.pas',
  FastStrings in 'HsUnits\FastStrings.pas',
  HegFile in 'TestUnits\HegFile.pas',
  SynHighlighterPas in '..\..\ComponentD2007\SynEdit\Source\SynHighlighterPas.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleCodeGen, DataModuleCodeGen);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
