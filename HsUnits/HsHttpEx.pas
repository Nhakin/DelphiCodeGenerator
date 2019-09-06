unit HsHttpEx;

interface

Uses Classes, IdComponent, IdHTTP, HsInterfaceEx;

Type
  THsIdHTTPExOnProgress = Procedure(Const AFileName : String; Const ACurProgress, AMaxValue : Int64) Of Object;

  IHsIdHTTPEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A722-5CC6839C3C2A}']
    Function  GetOnProgress() : THsIdHTTPExOnProgress;
    Procedure SetOnProgress(Const AValue : THsIdHTTPExOnProgress);

    Procedure Get(AURL : String; AResponseContent : TStream);

    Property OnProgress : THsIdHTTPExOnProgress Read GetOnProgress Write SetOnProgress;
    
  End;

  THsIdHTTPEx = Class(TIdHTTP, IHsIdHTTPEx)
  Private
    FIntfImpl : TInterfaceExImplementor;

    FFileName   : String;
    FMaxWork    : Int64;
    FOnProgress : THsIdHTTPExOnProgress;

    Function GetImpl() : TInterfaceExImplementor;

    Procedure DoOnWork(ASender : TObject; AWorkMode : TWorkMode; AWorkCount : Int64);
    Procedure DoOnWorkBegin(ASender : TObject; AWorkMode : TWorkMode; AWorkCountMax : Int64);

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetImpl Implements IHsIdHTTPEx;

    Procedure DoRequest(Const AMethod : TIdHTTPMethod;
      AURL : String; ASource, AResponseContent : TStream;
      AIgnoreReplies : Array Of SmallInt); OverRide;

    //IHsIdHTTPEx
    Function  GetOnProgress() : THsIdHTTPExOnProgress;
    Procedure SetOnProgress(Const AValue : THsIdHTTPExOnProgress);

  Public
    Constructor Create(AOwner : TComponent); ReIntroduce;

  End;

implementation

Uses SysUtils, Forms;

Constructor THsIdHTTPEx.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  InHerited OnWork := DoOnWork;
  InHerited OnWorkBegin := DoOnWorkBegin;
End;

Function THsIdHTTPEx.GetImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self);
  Result := FIntfImpl;
End;

Function THsIdHTTPEx.GetOnProgress() : THsIdHTTPExOnProgress;
Begin
  Result := FOnProgress;
End;

Procedure THsIdHTTPEx.SetOnProgress(Const AValue : THsIdHTTPExOnProgress);
Begin
  FOnProgress := AValue;
End;

Procedure THsIdHTTPEx.DoRequest(Const AMethod : TIdHTTPMethod;
  AURL : String; ASource, AResponseContent : TStream;
  AIgnoreReplies : Array Of SmallInt);
Begin
  FFileName := ExtractFileName(StringReplace(AURL, '/', '\', [rfReplaceAll]));
  InHerited DoRequest(AMethod, AURL, ASource, AResponseContent, AIgnoreReplies);
End;

Procedure THsIdHTTPEx.DoOnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
Begin
  Application.ProcessMessages();
  If Assigned(FOnProgress) Then
    FOnProgress(FFileName, AWorkCount, FMaxWork);
End;

Procedure THsIdHTTPEx.DoOnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
Begin
  FMaxWork := AWorkCountMax;
End;

end.
