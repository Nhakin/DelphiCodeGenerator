Unit uArmy;

Interface

Uses Classes, SysUtils, RTLConsts, SuperObject, HsSuperObjectEx, Contnrs;

Type
  IWeapon = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-9BC4-39581F01B4DD}']
    Function  GetWeaponName() : String;
    Procedure SetWeaponName(Const AWeaponName : String);

    Function  GetWeaponType() : Byte;
    Procedure SetWeaponType(Const AWeaponType : Byte);

    Property WeaponName : String Read GetWeaponName Write SetWeaponName;
    Property WeaponType : Byte   Read GetWeaponType Write SetWeaponType;

  End;

  IWeapons = Interface(ISuperObjectExList)
    ['{4B61686E-29A0-2112-89BC-4A790787E502}']
    Function GetItem(Const Index : Integer) : IWeapon;

    Function Add() : IWeapon; OverLoad;
    Function Add(Const AItem : IWeapon) : Integer; OverLoad;

    Property Items[Const Index: Integer] : IWeapon Read GetItem; Default;

  End;

  ISoldier = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-9D47-069D3FE8C4E8}']
    Function  GetSoldierId() : Integer;
    Procedure SetSoldierId(Const ASoldierId : Integer);

    Function  GetSoldierName() : String;
    Procedure SetSoldierName(Const ASoldierName : String);

    Function  GetWeapons() : IWeapons;

    Property SoldierId   : Integer  Read GetSoldierId   Write SetSoldierId;
    Property SoldierName : String   Read GetSoldierName Write SetSoldierName;
    Property Weapons     : IWeapons Read GetWeapons;

  End;

(******************************************************************************)

  TWeapon = Class(TSuperObjectEx, IWeapon)
  Protected
    Function  GetWeaponName() : String; Virtual;
    Procedure SetWeaponName(Const AWeaponName : String); Virtual;

    Function  GetWeaponType() : Byte; Virtual;
    Procedure SetWeaponType(Const AWeaponType : Byte); Virtual;

    Procedure Clear(); ReIntroduce; OverLoad;

  Public
    Property WeaponName : String Read GetWeaponName Write SetWeaponName;
    Property WeaponType : Byte   Read GetWeaponType Write SetWeaponType;

    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

  End;

  TWeapons = Class(TSuperObjectExList, IWeapons)
  Protected
    Function GetItemClass() : TSuperObjectExClass; OverRide;
    Function GetItem(Const Index : Integer) : IWeapon; OverLoad;

  Public
    Function Add() : IWeapon; OverLoad;
    Function Add(Const AItem : IWeapon) : Integer; OverLoad;

    Property Items[Const Index: Integer] : IWeapon Read GetItem; Default;

  End;

  TSoldier = Class(TSuperObjectEx, ISoldier)
  Protected
    Function  GetSoldierId() : Integer; Virtual;
    Procedure SetSoldierId(Const ASoldierId : Integer); Virtual;

    Function  GetSoldierName() : String; Virtual;
    Procedure SetSoldierName(Const ASoldierName : String); Virtual;

    Function  GetWeapons() : IWeapons; Virtual;

    Procedure Clear(); ReIntroduce; OverLoad;

  Public
    Property SoldierId   : Integer  Read GetSoldierId   Write SetSoldierId;
    Property SoldierName : String   Read GetSoldierName Write SetSoldierName;
    Property Weapons     : IWeapons Read GetWeapons;

    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

    Procedure AfterConstruction(); OverRide;

    Destructor Destroy(); OverRide;

  End;

Implementation

Procedure TWeapon.Clear();
Begin
  S['WeaponName'] := '';
  I['WeaponType'] := 0;
End;

Procedure TWeapon.Assign(ASource : TObject);
Var lSrc : TWeapon;
Begin
  If ASource Is TWeapon Then
  Begin
    lSrc := TWeapon(ASource);

    S['WeaponName'] := lSrc.WeaponName;
    I['WeaponType'] := lSrc.WeaponType;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TWeapon.GetWeaponName() : String;
Begin
  Result := S['WeaponName'];
End;

Procedure TWeapon.SetWeaponName(Const AWeaponName : String);
Begin
  S['WeaponName'] := AWeaponName;
End;

Function TWeapon.GetWeaponType() : Byte;
Begin
  Result := I['WeaponType'];
End;

Procedure TWeapon.SetWeaponType(Const AWeaponType : Byte);
Begin
  I['WeaponType'] := AWeaponType;
End;

Function TWeapons.Add() : IWeapon;
Begin
  Result := TWeapon.Create(stObject);
  InHerited Add(Result);
End;

Function TWeapons.Add(Const AItem : IWeapon) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TWeapons.GetItemClass() : TSuperObjectExClass;
Begin
  Result := TWeapon;
End;

Function TWeapons.GetItem(Const Index : Integer) : IWeapon;
Begin
  Result := InHerited Items[Index] As IWeapon;
End;
Procedure TSoldier.AfterConstruction();
Begin
  InHerited AfterConstruction();

  O['Weapons'] := TWeapons.Create() As IWeapons;
  RegisterChildNode('Weapons', TWeapons);
End;

Destructor TSoldier.Destroy();
Begin
  O['Weapons'] := Nil;

  InHerited Destroy();
End;

Procedure TSoldier.Clear();
Begin
  I['SoldierId']   := 0;
  S['SoldierName'] := '';
  O['Weapons']     := TWeapons.Create() As IWeapons;
End;

Procedure TSoldier.Assign(ASource : TObject);
Var lSrc : TSoldier;
Begin
  If ASource Is TSoldier Then
  Begin
    lSrc := TSoldier(ASource);

    I['SoldierId']   := lSrc.SoldierId;
    S['SoldierName'] := lSrc.SoldierName;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TSoldier.GetSoldierId() : Integer;
Begin
  Result := I['SoldierId'];
End;

Procedure TSoldier.SetSoldierId(Const ASoldierId : Integer);
Begin
  I['SoldierId'] := ASoldierId;
End;

Function TSoldier.GetSoldierName() : String;
Begin
  Result := S['SoldierName'];
End;

Procedure TSoldier.SetSoldierName(Const ASoldierName : String);
Begin
  If Length(ASoldierName) > 25 Then
    Raise Exception.Create('MaxLength for property SoldierName is : 25');
  S['SoldierName'] := ASoldierName;
End;

Function TSoldier.GetWeapons() : IWeapons;
Begin
  If O['Weapons'] = Nil Then
    O['Weapons'] := TWeapons.Create();

  Result := O['Weapons'] As IWeapons
End;

End.
