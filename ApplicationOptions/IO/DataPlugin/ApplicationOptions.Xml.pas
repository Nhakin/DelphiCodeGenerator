unit ApplicationOptions.Xml;

interface

Uses
  HsXmlDocEx, GlobalOptions.Xml, MsSqlOptions.Xml, SearchOptions.Xml;

Type
  IXmlApplicationOptions = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-A243-3C4DAFB1F683}']
    Function GetGlobalOptions() : IXmlGlobalOptions;
    Function GetMsSqlOptions() : IXmlMsSqlOptions;
    Function GetSearchOptions() : IXmlSearchOptions;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

    Property GlobalOptions : IXmlGlobalOptions Read GetGlobalOptions;
    Property MsSqlOptions  : IXmlMsSqlOptions  Read GetMsSqlOptions;
    Property SearchOptions : IXmlSearchOptions Read GetSearchOptions;

  End;

  TXmlApplicationOptions = Class(TObject)
  Public
    Class Function CreateApplicationOptions() : IXmlApplicationOptions; OverLoad;
    Class Function CreateApplicationOptions(AXmlString : String) : IXmlApplicationOptions; OverLoad;

  End;

implementation

Uses
  RtlConsts, SysUtils, XmlIntf, XmlDoc, HsInterfaceEx,
  ApplicationOptionsIntf, GlobalOptionsIntf, MsSqlOptionIntf, SearchOptionsIntf;

Type
  TXmlApplicationOptionsImpl = Class(TXmlNodeEx, IApplicationOptions, IXmlApplicationOptions)
  Private
    FAppOptionsImpl : Pointer;
    FInterfaceState : TInterfaceState;

    Function GetAppOptionsImpl() : IApplicationOptions;

  Protected
    Property AppOptionsImpl : IApplicationOptions Read GetAppOptionsImpl;

    Function GetGlobalOptions() : IXmlGlobalOptions;
    Function GetMsSqlOptions() : IXmlMsSqlOptions;
    Function GetSearchOptions() : IXmlSearchOptions;

    Function MyGetGlobalOptions() : IGlobalOptions;
    Function MyGetMsSqlOptions() : IMsSqlOptions;
    Function MyGetSearchOptions() : ISearchOptions;

    Function GetInterfaceState() : TInterfaceState;
                        
    Function IApplicationOptions.GetGlobalOptions = MyGetGlobalOptions;
    Function IApplicationOptions.GetMsSqlOptions  = MyGetMsSqlOptions;
    Function IApplicationOptions.GetSearchOptions = MyGetSearchOptions;

    Procedure Assign(ASource : IInterface; Const ASyncSource : Boolean = True);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TXmlApplicationOptions.CreateApplicationOptions() : IXmlApplicationOptions;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.Options := lXml.Options + [doNodeAutoIndent];

  Result := (lXml As IXmlDocumentEx).GetDocBinding('ApplicationOptions', TXmlApplicationOptionsImpl) As IXmlApplicationOptions;
End;

Class Function TXmlApplicationOptions.CreateApplicationOptions(AXmlString : String) : IXmlApplicationOptions; 
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.Options := lXml.Options + [doNodeAutoIndent];
  lXml.LoadFromXML(AXmlString);

  Result := (lXml As IXmlDocumentEx).GetDocBinding('ApplicationOptions', TXmlApplicationOptionsImpl) As IXmlApplicationOptions;
End;

(******************************************************************************)

Procedure TXmlApplicationOptionsImpl.AfterConstruction();
Begin
  RegisterChildNode('GlobalOptions', TXmlGlobalOptions.XmlNodeClass);
  RegisterChildNode('MsSqlOptions', TXmlMsSqlOptions.XmlNodeClass);
  RegisterChildNode('SearchOptions', TXmlSearchOptions.XmlNodeClass);

  FInterfaceState := isCreating;
  FAppOptionsImpl := Pointer(IApplicationOptions(Self));

  InHerited AfterConstruction();
End;

Procedure TXmlApplicationOptionsImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  If (IApplicationOptions(FAppOptionsImpl) <> IApplicationOptions(Self)) And
     (IApplicationOptions(FAppOptionsImpl).InterfaceState <> isDestroying) Then
    With AppOptionsImpl Do
    Begin
      GlobalOptions.Assign(Self.GetGlobalOptions());
      MsSqlOptions.Assign(Self.GetMsSqlOptions());
      SearchOptions.Assign(Self.GetSearchOptions());
    End;
      
  InHerited BeforeDestruction();
End;

Function TXmlApplicationOptionsImpl.GetAppOptionsImpl() : IApplicationOptions;
Begin
  Result := IApplicationOptions(FAppOptionsImpl);
End;

Function TXmlApplicationOptionsImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TXmlApplicationOptionsImpl.Assign(ASource : IInterface; Const ASyncSource : Boolean = True);
Var lSrc : IApplicationOptions;
Begin
  If Supports(ASource, IApplicationOptions, lSrc) Then
  Begin
    MyGetGlobalOptions().Assign(lSrc.GlobalOptions, ASyncSource);
    MyGetMsSqlOptions().Assign(lSrc.MsSqlOptions, ASyncSource);
    MyGetSearchOptions().Assign(lSrc.SearchOptions, ASyncSource);

    If ASyncSource Then
      FAppOptionsImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlApplicationOptionsImpl.GetGlobalOptions() : IXmlGlobalOptions;
Begin
  Result := ChildNodes['GlobalOptions'] As IXmlGlobalOptions;
End;

Function TXmlApplicationOptionsImpl.GetMsSqlOptions() : IXmlMsSqlOptions;
Begin
  Result := ChildNodes['MsSqlOptions'] As IXmlMsSqlOptions;
End;

Function TXmlApplicationOptionsImpl.GetSearchOptions() : IXmlSearchOptions;
Begin
  Result := ChildNodes['SearchOptions'] As IXmlSearchOptions;
End;

Function TXmlApplicationOptionsImpl.MyGetGlobalOptions() : IGlobalOptions;
Begin
  Result := GetGlobalOptions() As IGlobalOptions;
End;

Function TXmlApplicationOptionsImpl.MyGetMsSqlOptions() : IMsSqlOptions;
Begin
  Result := GetMsSqlOptions() As IMsSqlOptions;
End;

Function TXmlApplicationOptionsImpl.MyGetSearchOptions() : ISearchOptions;
Begin
  Result := GetSearchOptions() As ISearchOptions;
End;

end.
