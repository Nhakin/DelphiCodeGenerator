unit CodeGenType;

interface

Type
  THsTypeDefType = ( {dtVariable, dtConst,} dtEnum, dtSet, dtRecord,
    dtForwardClass, dtForwardInterface, dtEvent
  );
  THsDataSource = (dsNone, dsFile, dsMSSql, dsXML, dsJSon);
  THsDataSources = Set Of THsDataSource;
  THsPropertyType = (
                      ptByte, ptInteger, ptSingle,
                      ptDouble, ptExtended, ptCurrency,
                      ptChar, ptString, ptWideString,
                      ptPAnsiChar, ptPWideChar,
                      ptStringList,
                      ptDate, ptTime, ptDateTime,
                      ptBoolean, ptVariant,
                      ptInterface, ptObject, ptClass, ptEnum,
                      ptMethod, ptGUID, ptAutoInc, ptWord, ptDWord, ptQWord,
                      ptSet
                    );

  THsFunctionResultType = (
                            rtNone, rtByte, rtInteger, rtSingle,
                            rtDouble, rtExtended, rtCurrency,
                            rtChar, rtString, rtWideString,
                            rtPAnsiChar, rtPWideChar,
                            rtStringList, rtDate, rtTime, rtDateTime,
                            rtBoolean, rtClass
                          );
  THsFunctionFlag = (
                      ffReIntroduce, ffVirtual, ffAbstract, ffOverRide, ffOverLaod
                    );
  THsFunctionFlags = Set Of THsFunctionFlag;
  THsFunctionScope = (
                       fsPrivate, fsProtected, fsPublic,
                       fsStrictPrivate, fsStrictProtected
                     );
                    
implementation

end.
