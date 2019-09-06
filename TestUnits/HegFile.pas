unit HegFile;

Interface

Uses Windows, Classes, SysUtils, RTLConsts, HsInterfaceEx, HsStreamEx;

Type
  GraphicObjectType = (gotEnd, gotRectangle, gotCircle, gotGroup = 10, gotTriangle, gotPolygon);

  IPoint = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9D9C-EB75F01AC457}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetX() : Single;
    Procedure SetX(Const AX : Single);

    Function  GetY() : Single;
    Procedure SetY(Const AY : Single);

    Property X : Single Read GetX Write SetX;
    Property Y : Single Read GetY Write SetY;

  End;

  IPoints = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8434-EDABB3A00708}']
    Function  Get(Index : Integer) : IPoint;
    Procedure Put(Index : Integer; Const Item : IPoint);

    Function Add() : IPoint; OverLoad;
    Function Add(Const AItem : IPoint) : Integer; OverLoad;

    Property Items[Index : Integer] : IPoint Read Get Write Put; Default;

  End;

  IFileHeader = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-BA9F-1EE9572B625D}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetFileSign() : DWord;
    Procedure SetFileSign(Const AFileSign : DWord);

    Function  GetFileVersion() : Byte;
    Procedure SetFileVersion(Const AFileVersion : Byte);

    Function  GetCreationDate() : TDateTime;
    Procedure SetCreationDate(Const ACreationDate : TDateTime);

    Function  GetModificationDate() : TDateTime;
    Procedure SetModificationDate(Const AModificationDate : TDateTime);

    Function  GetColorTableAddress() : DWord;
    Procedure SetColorTableAddress(Const AColorTableAddress : DWord);

    Property FileSign          : DWord     Read GetFileSign          Write SetFileSign;
    Property FileVersion       : Byte      Read GetFileVersion       Write SetFileVersion;
    Property CreationDate      : TDateTime Read GetCreationDate      Write SetCreationDate;
    Property ModificationDate  : TDateTime Read GetModificationDate  Write SetModificationDate;
    Property ColorTableAddress : DWord     Read GetColorTableAddress Write SetColorTableAddress;

  End;

  ICustomGraphicObjectHeader = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A88B-41DAC6894425}']
    Function GetPos() : IPoint;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property Pos : IPoint Read GetPos;

  End;

  IGraphicObjectHeader = Interface(ICustomGraphicObjectHeader)
    ['{4B61686E-29A0-2112-BBFF-35D3E0C9121B}']
    Function  GetColorId() : Word;
    Procedure SetColorId(Const AColorId : Word);

    Property ColorId : Word Read GetColorId Write SetColorId;

  End;

  IGroupObjectHeader = Interface(ICustomGraphicObjectHeader)
    ['{4B61686E-29A0-2112-89C4-EBB1E3DD39A9}']
    Function  GetObjectCount() : Word;
    Procedure SetObjectCount(Const AObjectCount : Word);

    Property ObjectCount : Word Read GetObjectCount Write SetObjectCount;

  End;

  ICustomGraphicObject = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9DC2-A0E555B15386}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetObjectType() : GraphicObjectType;
    Procedure SetObjectType(Const AObjectType : GraphicObjectType);

    Function  GetObjectFlags() : Byte;
    Procedure SetObjectFlags(Const AObjectFlags : Byte);

    Property ObjectType  : GraphicObjectType Read GetObjectType  Write SetObjectType;
    Property ObjectFlags : Byte              Read GetObjectFlags Write SetObjectFlags;

  End;

  IGraphicObject = Interface(ICustomGraphicObject)
    ['{4B61686E-29A0-2112-A92C-87226B5F3612}']
    Function GetHeader() : IGraphicObjectHeader;

    Property Header : IGraphicObjectHeader Read GetHeader;

  End;

  IGraphicObjects = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-91F0-9922936844FD}']
    Function  Get(Index : Integer) : ICustomGraphicObject;
    Procedure Put(Index : Integer; Const Item : ICustomGraphicObject);

    Function Add(AObjectType : GraphicObjectType) : ICustomGraphicObject; OverLoad;
    Function Add(Const AItem : ICustomGraphicObject) : Integer; OverLoad;

    Property Items[Index : Integer] : ICustomGraphicObject Read Get Write Put; Default;

  End;

  IRectangle = Interface(IGraphicObject)
    ['{4B61686E-29A0-2112-8426-FA4424D90D75}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetWidth() : Single;
    Procedure SetWidth(Const AWidth : Single);

    Function  GetHeight() : Single;
    Procedure SetHeight(Const AHeight : Single);

    Property Width  : Single Read GetWidth  Write SetWidth;
    Property Height : Single Read GetHeight Write SetHeight;

  End;

  ICircle = Interface(IGraphicObject)
    ['{4B61686E-29A0-2112-AFF1-677F276FEEEC}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetRadius() : Single;
    Procedure SetRadius(Const ARadius : Single);

    Property Radius : Single Read GetRadius Write SetRadius;

  End;

  IGroup = Interface(ICustomGraphicObject)
    ['{4B61686E-29A0-2112-ACC8-B44CE6031677}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetHeader() : IGroupObjectHeader;
    Function  GetSubObject() : IGraphicObjects;

    Property Header    : IGroupObjectHeader Read GetHeader;
    Property SubObject : IGraphicObjects    Read GetSubObject;

  End;

  ITriangle = Interface(IGraphicObject)
    ['{4B61686E-29A0-2112-A2F4-2AF9406841AA}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetPoint() : IPoints;

    Property Point : IPoints Read GetPoint;

  End;

  IPolygon = Interface(IGraphicObject)
    ['{4B61686E-29A0-2112-90AB-7BD1D87FBE9A}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetPointCount() : Byte;
    Function  GetPoint() : IPoints;

    Property PointCount : Byte    Read GetPointCount;
    Property Point      : IPoints Read GetPoint;

  End;

  IColor = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9C81-C74993387AA6}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetColorName() : String;
    Procedure SetColorName(Const AColorName : String);

    Function  GetRed() : Byte;
    Procedure SetRed(Const ARed : Byte);

    Function  GetGreen() : Byte;
    Procedure SetGreen(Const AGreen : Byte);

    Function  GetBlue() : Byte;
    Procedure SetBlue(Const ABlue : Byte);

    Property ColorName : String Read GetColorName Write SetColorName;
    Property Red       : Byte   Read GetRed       Write SetRed;
    Property Green     : Byte   Read GetGreen     Write SetGreen;
    Property Blue      : Byte   Read GetBlue      Write SetBlue;

  End;

  IColorTable = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B4C8-882F35F5195E}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  Get(Index : Integer) : IColor;
    Procedure Put(Index : Integer; Const Item : IColor);

    Function Add() : IColor; OverLoad;
    Function Add(Const AItem : IColor) : Integer; OverLoad;

    Property Items[Index : Integer] : IColor Read Get Write Put; Default;

  End;

  IFileFooter = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B4B4-6C979153D4C8}']
    Procedure LoadFromStream(ASource : IStreamEx; Const AFileVersion : Integer);
    Procedure SaveToStream(ATarget : IStreamEx; Const AFileVersion : Integer);

    Function  GetRectangleCount() : Word;
    Procedure SetRectangleCount(Const ARectangleCount : Word);

    Function  GetCircleCount() : Word;
    Procedure SetCircleCount(Const ACircleCount : Word);

    Function  GetGroupCount() : Word;
    Procedure SetGroupCount(Const AGroupCount : Word);

    Function  GetTriangleCount() : Word;
    Procedure SetTriangleCount(Const ATriangleCount : Word);

    Function  GetPolygonCount() : Word;
    Procedure SetPolygonCount(Const APolygonCount : Word);

    Function  GetCrc32() : DWord;
    Procedure SetCrc32(Const ACrc32 : DWord);

    Property RectangleCount : Word  Read GetRectangleCount Write SetRectangleCount;
    Property CircleCount    : Word  Read GetCircleCount    Write SetCircleCount;
    Property GroupCount     : Word  Read GetGroupCount     Write SetGroupCount;
    Property TriangleCount  : Word  Read GetTriangleCount  Write SetTriangleCount;
    Property PolygonCount   : Word  Read GetPolygonCount   Write SetPolygonCount;
    Property Crc32          : DWord Read GetCrc32          Write SetCrc32;

  End;

  IHegFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-88CC-72575D3404D0}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetHeader() : IFileHeader;

    Function  GetColorTable() : IColorTable;

    Function  GetGraphicObject() : IGraphicObjects;

    Function  GetFooter() : IFileFooter;

    Property Header        : IFileHeader     Read GetHeader;
    Property ColorTable    : IColorTable     Read GetColorTable;
    Property GraphicObject : IGraphicObjects Read GetGraphicObject;
    Property Footer        : IFileFooter     Read GetFooter;

  End;

(******************************************************************************)

  TPoint = Class(TInterfacedObjectEx, IPoint)
  Private
    FX : Single;
    FY : Single;
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  Protected
    Function  GetX() : Single; Virtual;
    Procedure SetX(Const AX : Single); Virtual;

    Function  GetY() : Single; Virtual;
    Procedure SetY(Const AY : Single); Virtual;

  End;

  TPoints = Class(TInterfaceListEx, IPoints)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IPoint; OverLoad;
    Procedure Put(Index : Integer; Const Item : IPoint); OverLoad;

    Function Add() : IPoint; OverLoad;
    Function Add(Const AItem : IPoint) : Integer; OverLoad;

  End;

  TFileHeader = Class(TInterfacedObjectEx, IFileHeader)
  Private
    FFileSign          : DWord;
    FFileVersion       : Byte;
    FCreationDate      : TDateTime;
    FModificationDate  : TDateTime;
    FColorTableAddress : DWord;

  Protected
    Function  GetFileSign() : DWord; 
    Procedure SetFileSign(Const AFileSign : DWord); 

    Function  GetFileVersion() : Byte; 
    Procedure SetFileVersion(Const AFileVersion : Byte); 

    Function  GetCreationDate() : TDateTime; 
    Procedure SetCreationDate(Const ACreationDate : TDateTime); 

    Function  GetModificationDate() : TDateTime; 
    Procedure SetModificationDate(Const AModificationDate : TDateTime); 

    Function  GetColorTableAddress() : DWord; 
    Procedure SetColorTableAddress(Const AColorTableAddress : DWord);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TCustomGraphicObjectHeader = Class(TInterfacedObjectEx, ICustomGraphicObjectHeader)
  Private
    FPos : IPoint;
    
  Protected
    Function GetPos() : IPoint;

    Procedure LoadFromStream(ASource : IStreamEx); Virtual; Abstract;
    Procedure SaveToStream(ATarget : IStreamEx); Virtual; Abstract;

  Public
    Constructor Create(); ReIntroduce; Virtual;
    Destructor Destroy(); OverRide;

  End;

  TGraphicObjectHeader = Class(TCustomGraphicObjectHeader, IGraphicObjectHeader)
  Private
    FColorId : Word;

  Protected
    Procedure LoadFromStream(ASource : IStreamEx); OverRide;
    Procedure SaveToStream(ATarget : IStreamEx); OverRide;

    Function  GetColorId() : Word;
    Procedure SetColorId(Const AColorId : Word);

  End;

  TGroupObjectHeader = Class(TCustomGraphicObjectHeader, IGroupObjectHeader)
  Private
    FObjectCount : Word;

  Protected
    Procedure LoadFromStream(ASource : IStreamEx); OverRide;
    Procedure SaveToStream(ATarget : IStreamEx); OverRide;

    Function  GetObjectCount() : Word;
    Procedure SetObjectCount(Const AObjectCount : Word);

  End;
    
  TCustomGraphicObject = Class(TInterfacedObjectEx, ICustomGraphicObject)
  Private
    FObjectType  : GraphicObjectType;
    FObjectFlags : Byte;

  Protected
    Function  GetObjectType() : GraphicObjectType; 
    Procedure SetObjectType(Const AObjectType : GraphicObjectType); 

    Function  GetObjectFlags() : Byte; 
    Procedure SetObjectFlags(Const AObjectFlags : Byte); 

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TGraphicObject = Class(TCustomGraphicObject, IGraphicObject)
  Private
    FHeader : IGraphicObjectHeader;

  Protected
    Function GetHeader() : IGraphicObjectHeader;

  Public
    Constructor Create(); ReIntroduce; Virtual;
    Destructor Destroy(); OverRide;

  End;

  TGraphicObjects = Class(TInterfaceListEx, IGraphicObjects)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ICustomGraphicObject; OverLoad;
    Procedure Put(Index : Integer; Const Item : ICustomGraphicObject); OverLoad;

    Function Add(AObjectType : GraphicObjectType) : ICustomGraphicObject; OverLoad;
    Function Add(Const AItem : ICustomGraphicObject) : Integer; OverLoad;

  End;

  TRectangle = Class(TGraphicObject, IRectangle)
  Private
    FWidth  : Single;
    FHeight : Single;

  Protected
    Function  GetWidth() : Single; 
    Procedure SetWidth(Const AWidth : Single); 

    Function  GetHeight() : Single; 
    Procedure SetHeight(Const AHeight : Single);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TCircle = Class(TGraphicObject, ICircle)
  Private
    FRadius : Single;

  Protected
    Function  GetRadius() : Single; 
    Procedure SetRadius(Const ARadius : Single);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TGroup = Class(TCustomGraphicObject, IGroup)
  Private
    FHeader    : IGroupObjectHeader;
    FSubObject : IGraphicObjects;

  Protected
    Function  GetHeader() : IGroupObjectHeader;
    Function  GetSubObject() : IGraphicObjects;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  Public
    Constructor Create(); ReIntroduce; Virtual;
    Destructor Destroy(); OverRide;

  End;

  TTriangle = Class(TGraphicObject, ITriangle)
  Private
    FPoint : IPoints;

  Protected
    Function  GetPoint() : IPoints; Virtual;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  Public
    Constructor Create(); ReIntroduce; Virtual;
    Destructor Destroy(); OverRide;

  End;

  TPolygon = Class(TGraphicObject, IPolygon)
  Private
    FPoint : IPoints;

  Protected
    Function  GetPointCount() : Byte; Virtual;
    Function  GetPoint() : IPoints; Virtual;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  Public
    Constructor Create(); ReIntroduce; Virtual;
    Destructor Destroy(); OverRide;

  End;

  TColor = Class(TInterfacedObjectEx, IColor)
  Private
    FColorName : String;
    FRed       : Byte;
    FGreen     : Byte;
    FBlue      : Byte;

  Protected
    Function  GetColorName() : String; 
    Procedure SetColorName(Const AColorName : String); 

    Function  GetRed() : Byte; 
    Procedure SetRed(Const ARed : Byte); 

    Function  GetGreen() : Byte; 
    Procedure SetGreen(Const AGreen : Byte); 

    Function  GetBlue() : Byte; 
    Procedure SetBlue(Const ABlue : Byte); 

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TColorTable = Class(TInterfaceListEx, IColorTable)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IColor; OverLoad;
    Procedure Put(Index : Integer; Const Item : IColor); OverLoad;

    Function Add() : IColor; OverLoad;
    Function Add(Const AItem : IColor) : Integer; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TFileFooter = Class(TInterfacedObjectEx, IFileFooter)
  Private
    FRectangleCount : Word;
    FCircleCount    : Word;
    FGroupCount     : Word;
    FTriangleCount  : Word;
    FPolygonCount   : Word;
    FCrc32          : DWord;

  Protected
    Function  GetRectangleCount() : Word; Virtual;
    Procedure SetRectangleCount(Const ARectangleCount : Word); Virtual;

    Function  GetCircleCount() : Word; Virtual;
    Procedure SetCircleCount(Const ACircleCount : Word); Virtual;

    Function  GetGroupCount() : Word; Virtual;
    Procedure SetGroupCount(Const AGroupCount : Word); Virtual;

    Function  GetTriangleCount() : Word; Virtual;
    Procedure SetTriangleCount(Const ATriangleCount : Word); Virtual;

    Function  GetPolygonCount() : Word; Virtual;
    Procedure SetPolygonCount(Const APolygonCount : Word); Virtual;

    Function  GetCrc32() : DWord; Virtual;
    Procedure SetCrc32(Const ACrc32 : DWord); Virtual;

    Procedure LoadFromStream(ASource : IStreamEx; Const AFileVersion : Integer);
    Procedure SaveToStream(ATarget : IStreamEx; Const AFileVersion : Integer);

  End;

  THegFile = Class(TInterfacedObjectEx, IHegFile)
  Private
    FHeader        : IFileHeader;
    FColorTable    : IColorTable;
    FGraphicObject : IGraphicObjects;
    FFooter        : IFileFooter;

  Protected
    Function  GetHeader() : IFileHeader; 
    Function  GetColorTable() : IColorTable;
    Function  GetGraphicObject() : IGraphicObjects;
    Function  GetFooter() : IFileFooter;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  Public
    Constructor Create(); ReIntroduce; Virtual;
    Destructor Destroy(); OverRide;

  End;

Implementation

Uses Dialogs;

Procedure TPoint.LoadFromStream(ASource : IStreamEx);
Begin
  FX := ASource.ReadSingle();
  FY := ASource.ReadSingle();
End;

Procedure TPoint.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteSingle(FX);
  ATarget.WriteSingle(FY);
End;

Function TPoint.GetX() : Single;
Begin
  Result := FX;
End;

Procedure TPoint.SetX(Const AX : Single);
Begin
  FX := AX;
End;

Function TPoint.GetY() : Single;
Begin
  Result := FY;
End;

Procedure TPoint.SetY(Const AY : Single);
Begin
  FY := AY;
End;

Function TPoints.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TPoint;
End;

Function TPoints.Get(Index : Integer) : IPoint;
Begin
  Result := InHerited Items[Index] As IPoint;
End;

Procedure TPoints.Put(Index : Integer; Const Item : IPoint);
Begin
  InHerited Items[Index] := Item;
End;

Function TPoints.Add() : IPoint;
Begin
  Result := InHerited Add() As IPoint;
End;

Function TPoints.Add(Const AItem : IPoint) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TFileHeader.LoadFromStream(ASource : IStreamEx);
Begin
  FFileSign          := ASource.ReadDWord();
  If FFileSign = $16091977 Then
    FFileVersion := ASource.ReadByte;
  FCreationDate      := ASource.ReadSingle();
  FModificationDate  := ASource.ReadSingle();
  FColorTableAddress := ASource.ReadDWord();
End;

Procedure TFileHeader.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteDWord(FFileSign);
  ATarget.WriteByte(FFileVersion);
  ATarget.WriteSingle(FCreationDate);
  ATarget.WriteSingle(FModificationDate);
  ATarget.WriteDWord(FColorTableAddress);
End;

Function TFileHeader.GetFileSign() : DWord;
Begin
  Result := FFileSign;
End;

Procedure TFileHeader.SetFileSign(Const AFileSign : DWord);
Begin
  FFileSign := AFileSign;
End;

Function TFileHeader.GetFileVersion() : Byte;
Begin
  Result := FFileVersion;
End;

Procedure TFileHeader.SetFileVersion(Const AFileVersion : Byte);
Begin
  FFileVersion := AFileVersion;
End;

Function TFileHeader.GetCreationDate() : TDateTime;
Begin
  Result := FCreationDate;
End;

Procedure TFileHeader.SetCreationDate(Const ACreationDate : TDateTime);
Begin
  FCreationDate := ACreationDate;
End;

Function TFileHeader.GetModificationDate() : TDateTime;
Begin
  Result := FModificationDate;
End;

Procedure TFileHeader.SetModificationDate(Const AModificationDate : TDateTime);
Begin
  FModificationDate := AModificationDate;
End;

Function TFileHeader.GetColorTableAddress() : DWord;
Begin
  Result := FColorTableAddress;
End;

Procedure TFileHeader.SetColorTableAddress(Const AColorTableAddress : DWord);
Begin
  FColorTableAddress := AColorTableAddress;
End;

Constructor TCustomGraphicObjectHeader.Create();
Begin
  InHerited Create();

  FPos := TPoint.Create();
End;

Destructor TCustomGraphicObjectHeader.Destroy();
Begin
  FPos := Nil;

  InHerited Destroy();
End;

Function TCustomGraphicObjectHeader.GetPos() : IPoint;
Begin
  Result := FPos;
End;

Procedure TGraphicObjectHeader.LoadFromStream(ASource : IStreamEx);
Begin
  FColorId := ASource.ReadWord();
  FPos.LoadFromStream(ASource);
End;

Procedure TGraphicObjectHeader.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteWord(FColorId);
  FPos.SaveToStream(ATarget);
End;

Function TGraphicObjectHeader.GetColorId() : Word;
Begin
  Result := FColorId;
End;

Procedure TGraphicObjectHeader.SetColorId(Const AColorId : Word);
Begin
  FColorId := AColorId;
End;

Procedure TGroupObjectHeader.LoadFromStream(ASource : IStreamEx);
Begin
  FObjectCount := ASource.ReadWord();
  FPos.LoadFromStream(ASource);
End;

Procedure TGroupObjectHeader.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteWord(FObjectCount);
  FPos.SaveToStream(ATarget);
End;

Function TGroupObjectHeader.GetObjectCount() : Word;
Begin
  Result := FObjectCount;
End;

Procedure TGroupObjectHeader.SetObjectCount(Const AObjectCount : Word);
Begin
  FObjectCount := AObjectCount;
End;

Procedure TCustomGraphicObject.LoadFromStream(ASource : IStreamEx);
Begin
  FObjectType  := GraphicObjectType(ASource.ReadByte());
  FObjectFlags := ASource.ReadByte();
End;

Procedure TCustomGraphicObject.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteByte(Ord(FObjectType));
  ATarget.WriteByte(FObjectFlags);
End;

Function TCustomGraphicObject.GetObjectType() : GraphicObjectType;
Begin
  Result := FObjectType;
End;

Procedure TCustomGraphicObject.SetObjectType(Const AObjectType : GraphicObjectType);
Begin
  FObjectType := AObjectType;
End;

Function TCustomGraphicObject.GetObjectFlags() : Byte;
Begin
  Result := FObjectFlags;
End;

Procedure TCustomGraphicObject.SetObjectFlags(Const AObjectFlags : Byte);
Begin
  FObjectFlags := AObjectFlags;
End;

Function TGraphicObjects.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TCustomGraphicObject;
End;

Constructor TGraphicObject.Create();
Begin
  InHerited Create();

  FHeader := TGraphicObjectHeader.Create();
End;

Destructor TGraphicObject.Destroy();
Begin
  FHeader := Nil;

  InHerited Destroy();
End;

Function TGraphicObject.GetHeader() : IGraphicObjectHeader;
Begin
  Result := FHeader;
End;

Function TGraphicObjects.Get(Index : Integer) : ICustomGraphicObject;
Begin
  Result := InHerited Items[Index] As ICustomGraphicObject;
End;

Procedure TGraphicObjects.Put(Index : Integer; Const Item : ICustomGraphicObject);
Begin
  InHerited Items[Index] := Item;
End;

Function TGraphicObjects.Add(AObjectType : GraphicObjectType) : ICustomGraphicObject;
Begin
  Case AObjectType Of
    gotEnd : Result := TCustomGraphicObject.Create();
    gotRectangle : Result := TRectangle.Create();
    gotCircle : Result := TCircle.Create();
    gotGroup : Result := TGroup.Create();
    gotTriangle : Result := TTriangle.Create();
    gotPolygon : Result := TPolygon.Create();
  End;

  InHerited Add(Result);
End;

Function TGraphicObjects.Add(Const AItem : ICustomGraphicObject) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TRectangle.LoadFromStream(ASource : IStreamEx);
Begin
  GetHeader().LoadFromStream(ASource);
  FWidth  := ASource.ReadSingle();
  FHeight := ASource.ReadSingle();
End;

Procedure TRectangle.SaveToStream(ATarget : IStreamEx);
Begin
  GetHeader().SaveToStream(ATarget);
  ATarget.WriteSingle(FWidth);
  ATarget.WriteSingle(FHeight);
End;

Function TRectangle.GetWidth() : Single;
Begin
  Result := FWidth;
End;

Procedure TRectangle.SetWidth(Const AWidth : Single);
Begin
  FWidth := AWidth;
End;

Function TRectangle.GetHeight() : Single;
Begin
  Result := FHeight;
End;

Procedure TRectangle.SetHeight(Const AHeight : Single);
Begin
  FHeight := AHeight;
End;

Procedure TCircle.LoadFromStream(ASource : IStreamEx);
Begin
  GetHeader().LoadFromStream(ASource);
  FRadius := ASource.ReadSingle();
End;

Procedure TCircle.SaveToStream(ATarget : IStreamEx);
Begin
  GetHeader().SaveToStream(ATarget);
  ATarget.WriteSingle(FRadius);
End;

Function TCircle.GetRadius() : Single;
Begin
  Result := FRadius;
End;

Procedure TCircle.SetRadius(Const ARadius : Single);
Begin
  FRadius := ARadius;
End;

Constructor TGroup.Create();
Begin
  InHerited Create();

  FHeader    := TGroupObjectHeader.Create();
  FSubObject := TGraphicObjects.Create();
End;

Destructor TGroup.Destroy();
Begin
  FHeader    := Nil; 
  FSubObject := Nil;

  InHerited Destroy();
End;

Function TGroup.GetHeader() : IGroupObjectHeader;
Begin
  Result := FHeader;
End;

Procedure TGroup.LoadFromStream(ASource : IStreamEx);
Var X : Integer;
    lObjType : GraphicObjectType;
    lObjFlag : Byte;
    lCurObj  : ICustomGraphicObject;
Begin
  FHeader.LoadFromStream(ASource);

  For X := 0 To FHeader.ObjectCount - 1 Do
  Begin
    lObjType := GraphicObjectType(ASource.ReadByte());
    lObjFlag := ASource.ReadByte();
    lCurObj := FSubObject.Add(lObjType);
    Case lObjType Of
      gotRectangle : (lCurObj As IRectangle).LoadFromStream(ASource);
      gotCircle : (lCurObj As ICircle).LoadFromStream(ASource);
      gotGroup : (lCurObj As IGroup).LoadFromStream(ASource);
      gotTriangle : (lCurObj As ITriangle).LoadFromStream(ASource);
      gotPolygon : (lCurObj As IPolygon).LoadFromStream(ASource);
    End;

    lCurObj.ObjectType  := lObjType;
    lCurObj.ObjectFlags := lObjFlag;
  End;
End;

Procedure TGroup.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteWord(FSubObject.Count);
  FHeader.Pos.SaveToStream(ATarget);
  For X := 0 To FSubObject.Count - 1 Do
    Case FSubObject[X].ObjectType Of
      gotRectangle : (FSubObject[X] As IRectangle).SaveToStream(ATarget);
      gotCircle : (FSubObject[X] As ICircle).SaveToStream(ATarget);
      gotGroup : (FSubObject[X] As IGroup).SaveToStream(ATarget);
      gotTriangle : (FSubObject[X] As ITriangle).SaveToStream(ATarget);
      gotPolygon : (FSubObject[X] As IPolygon).SaveToStream(ATarget);
    End;
End;

Function TGroup.GetSubObject() : IGraphicObjects;
Begin
  Result := FSubObject;
End;

Constructor TTriangle.Create();
Begin
  InHerited Create();

  FPoint := TPoints.Create();
End;

Destructor TTriangle.Destroy();
Begin
  FPoint := Nil;

  InHerited Destroy();
End;

Procedure TTriangle.LoadFromStream(ASource : IStreamEx);
Var X : Integer;
Begin
  GetHeader().LoadFromStream(ASource);
  For X := 1 To 3 Do
    FPoint.Add().LoadFromStream(ASource);
End;

Procedure TTriangle.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  GetHeader().SaveToStream(ATarget);
  For X := 0 To FPoint.Count - 1 Do
    FPoint[X].SaveToStream(ATarget);
End;

Function TTriangle.GetPoint() : IPoints;
Begin
  Result := FPoint;
End;

Constructor TPolygon.Create();
Begin
  InHerited Create();

  FPoint := TPoints.Create();
End;

Destructor TPolygon.Destroy();
Begin
  FPoint := Nil;

  InHerited Destroy();
End;

Procedure TPolygon.LoadFromStream(ASource : IStreamEx);
Var lNbItem : Integer;
Begin
  GetHeader().LoadFromStream(ASource);
  lNbItem := ASource.ReadByte();
  While lNbItem > 0 Do
  Begin
    FPoint.Add().LoadFromStream(ASource);
    Dec(lNbItem);
  End;
End;

Procedure TPolygon.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  GetHeader().SaveToStream(ATarget);
  ATarget.WriteByte(FPoint.Count);
  For X := 0 To FPoint.Count - 1 Do
    FPoint[X].SaveToStream(ATarget);
End;

Function TPolygon.GetPointCount() : Byte;
Begin
  Result := FPoint.Count;
End;

Function TPolygon.GetPoint() : IPoints;
Begin
  Result := FPoint;
End;

Procedure TColor.LoadFromStream(ASource : IStreamEx);
Var lColorName : String;
    X : Integer;
Begin
  lColorName := ASource.ReadString(13);
  For X := 1 To Length(lColorName) Do
    If lColorName[X] <> #0 Then
      FColorName := FColorName + lColorName[X]
    Else
      Break;
      
  FRed       := ASource.ReadByte();
  FGreen     := ASource.ReadByte();
  FBlue      := ASource.ReadByte();
End;

Procedure TColor.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteString(FColorName, False);
  ATarget.WriteByte(FRed);
  ATarget.WriteByte(FGreen);
  ATarget.WriteByte(FBlue);
End;

Function TColor.GetColorName() : String;
Begin
  Result := FColorName;
End;

Procedure TColor.SetColorName(Const AColorName : String);
Begin
  FColorName := AColorName;
End;

Function TColor.GetRed() : Byte;
Begin
  Result := FRed;
End;

Procedure TColor.SetRed(Const ARed : Byte);
Begin
  FRed := ARed;
End;

Function TColor.GetGreen() : Byte;
Begin
  Result := FGreen;
End;

Procedure TColor.SetGreen(Const AGreen : Byte);
Begin
  FGreen := AGreen;
End;

Function TColor.GetBlue() : Byte;
Begin
  Result := FBlue;
End;

Procedure TColor.SetBlue(Const ABlue : Byte);
Begin
  FBlue := ABlue;
End;

Function TColorTable.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TColor;
End;

Function TColorTable.Get(Index : Integer) : IColor;
Begin
  Result := InHerited Items[Index] As IColor;
End;

Procedure TColorTable.Put(Index : Integer; Const Item : IColor);
Begin
  InHerited Items[Index] := Item;
End;

Function TColorTable.Add() : IColor;
Begin
  Result := InHerited Add() As IColor;
End;

Function TColorTable.Add(Const AItem : IColor) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TColorTable.LoadFromStream(ASource : IStreamEx);
Var lNbItem : Word;
Begin
  lNbItem := ASource.ReadWord();
  While lNbItem > 0 Do
  Begin
    Add().LoadFromStream(ASource);
    Dec(lNbItem);
  End;
End;

Procedure TColorTable.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteWord(Count);
  For X := 0 To Count - 1 Do
    Get(X).SaveToStream(ATarget);
End;

Procedure TFileFooter.LoadFromStream(ASource : IStreamEx; Const AFileVersion : Integer);
Begin
  FRectangleCount := ASource.ReadWord();
  FCircleCount    := ASource.ReadWord();
  FGroupCount     := ASource.ReadWord();
  FTriangleCount  := ASource.ReadWord();
  If AFileVersion > 2 Then
    FPolygonCount := ASource.ReadWord();
  FCrc32          := ASource.ReadDWord();
End;

Procedure TFileFooter.SaveToStream(ATarget : IStreamEx; Const AFileVersion : Integer);
Begin
  ATarget.WriteWord(FRectangleCount);
  ATarget.WriteWord(FCircleCount);
  ATarget.WriteWord(FGroupCount);
  ATarget.WriteWord(FTriangleCount);
  If AFileVersion > 2 Then
    ATarget.WriteWord(FPolygonCount);
  ATarget.WriteDWord(FCrc32);
End;

Function TFileFooter.GetRectangleCount() : Word;
Begin
  Result := FRectangleCount;
End;

Procedure TFileFooter.SetRectangleCount(Const ARectangleCount : Word);
Begin
  FRectangleCount := ARectangleCount;
End;

Function TFileFooter.GetCircleCount() : Word;
Begin
  Result := FCircleCount;
End;

Procedure TFileFooter.SetCircleCount(Const ACircleCount : Word);
Begin
  FCircleCount := ACircleCount;
End;

Function TFileFooter.GetGroupCount() : Word;
Begin
  Result := FGroupCount;
End;

Procedure TFileFooter.SetGroupCount(Const AGroupCount : Word);
Begin
  FGroupCount := AGroupCount;
End;

Function TFileFooter.GetTriangleCount() : Word;
Begin
  Result := FTriangleCount;
End;

Procedure TFileFooter.SetTriangleCount(Const ATriangleCount : Word);
Begin
  FTriangleCount := ATriangleCount;
End;

Function TFileFooter.GetPolygonCount() : Word;
Begin
  Result := FPolygonCount;
End;

Procedure TFileFooter.SetPolygonCount(Const APolygonCount : Word);
Begin
  FPolygonCount := APolygonCount;
End;

Function TFileFooter.GetCrc32() : DWord;
Begin
  Result := FCrc32;
End;

Procedure TFileFooter.SetCrc32(Const ACrc32 : DWord);
Begin
  FCrc32 := ACrc32;
End;

Constructor THegFile.Create();
Begin
  InHerited Create();

  FHeader        := TFileHeader.Create();
  FColorTable    := TColorTable.Create();
  FGraphicObject := TGraphicObjects.Create();
  FFooter        := TFileFooter.Create();
End;

Destructor THegFile.Destroy();
Begin
  FHeader        := Nil;
  FColorTable    := Nil;
  FGraphicObject := Nil;
  FFooter        := Nil;

  InHerited Destroy();
End;

Procedure THegFile.LoadFromStream(ASource : IStreamEx);
Var lObjType : GraphicObjectType;
    lObjFlag : Byte;
    lCurObj  : ICustomGraphicObject;
Begin
  FHeader.LoadFromStream(ASource);

  Repeat
    lObjType := GraphicObjectType(ASource.ReadByte());
    lObjFlag := ASource.ReadByte();
    lCurObj := FGraphicObject.Add(lObjType);
    Case lObjType Of
      gotRectangle : (lCurObj As IRectangle).LoadFromStream(ASource);
      gotCircle : (lCurObj As ICircle).LoadFromStream(ASource);
      gotGroup : (lCurObj As IGroup).LoadFromStream(ASource);
      gotTriangle : (lCurObj As ITriangle).LoadFromStream(ASource);
      gotPolygon : (lCurObj As IPolygon).LoadFromStream(ASource);
    End;

    lCurObj.ObjectType  := lObjType;
    lCurObj.ObjectFlags := lObjFlag;
  Until lObjType = gotEnd;

  FColorTable.LoadFromStream(ASource);
  If FHeader.FileSign = $16091977 Then
    FFooter.LoadFromStream(ASource, FHeader.FileVersion);
End;

Procedure THegFile.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
    lTerm : ICustomGraphicObject;
Begin
  FHeader.SaveToStream(ATarget);

  For X := 0 To FGraphicObject.Count - 1 Do
    Case FGraphicObject[X].ObjectType Of
      gotRectangle : (FGraphicObject[X] As IRectangle).SaveToStream(ATarget);
      gotCircle : (FGraphicObject[X] As ICircle).SaveToStream(ATarget);
      gotGroup : (FGraphicObject[X] As IGroup).SaveToStream(ATarget);
      gotTriangle : (FGraphicObject[X] As ITriangle).SaveToStream(ATarget);
      gotPolygon : (FGraphicObject[X] As IPolygon).SaveToStream(ATarget);
    End;

  lTerm := TCustomGraphicObject.Create();
  Try
    lTerm.SaveToStream(ATarget);
    Finally
      lTerm := Nil;
  End;

  FColorTable.SaveToStream(ATarget);
  FFooter.SaveToStream(ATarget, FHeader.FileVersion);
End;

Function THegFile.GetHeader() : IFileHeader;
Begin
  Result := FHeader;
End;

Function THegFile.GetColorTable() : IColorTable;
Begin
  Result := FColorTable;
End;

Function THegFile.GetGraphicObject() : IGraphicObjects;
Begin
  Result := FGraphicObject;
End;

Function THegFile.GetFooter() : IFileFooter;
Begin
  Result := FFooter;
End;

End.
