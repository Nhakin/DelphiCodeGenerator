/**
<summary>Restore diagram 'CodeGen'</summary>
<generated>2015-04-24 16:30</generated>
*/
Print '=== ExportDiagram restore diagram [CodeGen] ==='
If Not Exists (Select * From INFORMATION_SCHEMA.TABLES Where TABLE_NAME = 'sysdiagrams')
Begin
  Create Table [dbo].[sysdiagrams](
    [name] [sysname] Not Null,
    [principal_id] [int] Not Null,
    [diagram_id] [int] Identity(1,1) Not Null,
    [version] [int] Null,
    [definition] [varbinary](max) Null,
    PRIMARY KEY CLUSTERED
    ([diagram_id] ASC) WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF),
    CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED
    ([principal_id] ASC,[name] ASC) WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF)
  )

  Exec sys.sp_addextEndedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
End

Set NoCount On -- Hide (1 row affected) messages
Declare @newid Int
Declare @DiagramSuffix VarChar(50)
 
Print 'Suffix diagram name with date, to ensure uniqueness'
Set @DiagramSuffix = ' ' + LEFT(CONVERT(VARCHAR(23), GETDATE(), 121), 16)
 
Print 'Create row for new diagram'
Begin Try
  Print 'Write diagram CodeGen into new row (and get [diagram_id])'
  Insert Into sysdiagrams ([name], [principal_id], [version], [definition]) Values ('CodeGen'+@DiagramSuffix, 1, 1, 0x)
  Set @newid = SCOPE_IDENTITY()
End Try
Begin Catch
  Print 'XxXxX ' + Error_Message() + ' XxXxX'
  Print 'XxXxX End ExportDiagram -- fix the error before running again XxXxX'
  Return
End Catch
 
Print 'Now add all the binary data...'
Begin Try
  Update sysdiagrams Set [definition] .Write ( 0XD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900, Null, 0) Where diagram_id = @newid -- index:1
  Update sysdiagrams Set [definition] .Write ( 0X0600000000000000000000000100000001000000000000000010000002000000, Null, 0) Where diagram_id = @newid -- index:33
  Update sysdiagrams Set [definition] .Write ( 0X01000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:65
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:97
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:129
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:161
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:193
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:225
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:257
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:289
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:321
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:353
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:385
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:417
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:449
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:481
  Update sysdiagrams Set [definition] .Write ( 0XFDFFFFFF0F000000FEFFFFFF0400000005000000100000000700000008000000, Null, 0) Where diagram_id = @newid -- index:513
  Update sysdiagrams Set [definition] .Write ( 0X090000000A0000000B0000000C0000000D0000000E000000FEFFFFFFFEFFFFFF, Null, 0) Where diagram_id = @newid -- index:545
  Update sysdiagrams Set [definition] .Write ( 0X1100000012000000130000001400000015000000160000001700000018000000, Null, 0) Where diagram_id = @newid -- index:577
  Update sysdiagrams Set [definition] .Write ( 0XFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:609
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:641
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:673
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:705
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:737
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:769
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:801
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:833
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:865
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:897
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:929
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:961
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:993
  Update sysdiagrams Set [definition] .Write ( 0X52006F006F007400200045006E00740072007900000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1025
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1057
  Update sysdiagrams Set [definition] .Write ( 0X16000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1089
  Update sysdiagrams Set [definition] .Write ( 0X000000000000000000000000300E50A5B27ED001030000004016000000000000, Null, 0) Where diagram_id = @newid -- index:1121
  Update sysdiagrams Set [definition] .Write ( 0X6600000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1153
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1185
  Update sysdiagrams Set [definition] .Write ( 0X04000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1217
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000009E04000000000000, Null, 0) Where diagram_id = @newid -- index:1249
  Update sysdiagrams Set [definition] .Write ( 0X6F00000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1281
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1313
  Update sysdiagrams Set [definition] .Write ( 0X040002010100000004000000FFFFFFFF00000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1345
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000060000000810000000000000, Null, 0) Where diagram_id = @newid -- index:1377
  Update sysdiagrams Set [definition] .Write ( 0X010043006F006D0070004F0062006A0000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1409
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1441
  Update sysdiagrams Set [definition] .Write ( 0X12000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:1473
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000130000005F00000000000000, Null, 0) Where diagram_id = @newid -- index:1505
  Update sysdiagrams Set [definition] .Write ( 0X0100000002000000030000000400000005000000060000000700000008000000, Null, 0) Where diagram_id = @newid -- index:1537
  Update sysdiagrams Set [definition] .Write ( 0X090000000A0000000B0000000C0000000D0000000E0000000F00000010000000, Null, 0) Where diagram_id = @newid -- index:1569
  Update sysdiagrams Set [definition] .Write ( 0X1100000012000000FEFFFFFF14000000FEFFFFFF160000001700000018000000, Null, 0) Where diagram_id = @newid -- index:1601
  Update sysdiagrams Set [definition] .Write ( 0X190000001A0000001B0000001C0000001D0000001E0000001F00000020000000, Null, 0) Where diagram_id = @newid -- index:1633
  Update sysdiagrams Set [definition] .Write ( 0X2100000022000000230000002400000025000000260000002700000028000000, Null, 0) Where diagram_id = @newid -- index:1665
  Update sysdiagrams Set [definition] .Write ( 0X290000002A0000002B0000002C0000002D0000002E0000002F00000030000000, Null, 0) Where diagram_id = @newid -- index:1697
  Update sysdiagrams Set [definition] .Write ( 0X3100000032000000330000003400000035000000360000003700000038000000, Null, 0) Where diagram_id = @newid -- index:1729
  Update sysdiagrams Set [definition] .Write ( 0X390000003A0000003B0000003C0000003D0000003E0000003F00000040000000, Null, 0) Where diagram_id = @newid -- index:1761
  Update sysdiagrams Set [definition] .Write ( 0X4100000042000000430000004400000045000000460000004700000048000000, Null, 0) Where diagram_id = @newid -- index:1793
  Update sysdiagrams Set [definition] .Write ( 0X49000000FEFFFFFFFEFFFFFF4C0000004D0000004E0000004F00000050000000, Null, 0) Where diagram_id = @newid -- index:1825
  Update sysdiagrams Set [definition] .Write ( 0X51000000520000005300000054000000550000005600000057000000FEFFFFFF, Null, 0) Where diagram_id = @newid -- index:1857
  Update sysdiagrams Set [definition] .Write ( 0XFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:1889
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:1921
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:1953
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:1985
  Update sysdiagrams Set [definition] .Write ( 0XFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, Null, 0) Where diagram_id = @newid -- index:2017
  Update sysdiagrams Set [definition] .Write ( 0X000434000A1E500C050000800D0000000F00FFFF460000000D000000007D0000, Null, 0) Where diagram_id = @newid -- index:2049
  Update sysdiagrams Set [definition] .Write ( 0XF2850000205A0000D7BC00003D7E00002DCDFFFFFEDAFFFFDE805B10F195D011, Null, 0) Where diagram_id = @newid -- index:2081
  Update sysdiagrams Set [definition] .Write ( 0XB0A000AA00BDCB5C0000080030000000000200000300000038002B0000000900, Null, 0) Where diagram_id = @newid -- index:2113
  Update sysdiagrams Set [definition] .Write ( 0X0000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D5, Null, 0) Where diagram_id = @newid -- index:2145
  Update sysdiagrams Set [definition] .Write ( 0X52F8A0327DB2D86295428D98273C25A2DA2D00002C0043200000000000000000, Null, 0) Where diagram_id = @newid -- index:2177
  Update sysdiagrams Set [definition] .Write ( 0X000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B84, Null, 0) Where diagram_id = @newid -- index:2209
  Update sysdiagrams Set [definition] .Write ( 0X0D9C00002C0043200000000000000000000051444DD2011FD1118E63006097D2, Null, 0) Where diagram_id = @newid -- index:2241
  Update sysdiagrams Set [definition] .Write ( 0XDF4834C9D2777977D811907000065B840D9C0D000000A4030000008D01000000, Null, 0) Where diagram_id = @newid -- index:2273
  Update sysdiagrams Set [definition] .Write ( 0X3400A50900000700008001000000A40200000080000009000080536368477269, Null, 0) Where diagram_id = @newid -- index:2305
  Update sysdiagrams Set [definition] .Write ( 0X6400AE15000006180000436C6173734465667300000000003400A50900000700, Null, 0) Where diagram_id = @newid -- index:2337
  Update sysdiagrams Set [definition] .Write ( 0X008002000000AA020000008000000C00008053636847726964000C3000002A12, Null, 0) Where diagram_id = @newid -- index:2369
  Update sysdiagrams Set [definition] .Write ( 0X000050726F70657274794465667300003000A50900000700008003000000A202, Null, 0) Where diagram_id = @newid -- index:2401
  Update sysdiagrams Set [definition] .Write ( 0X000000800000080000805363684772696400CCF7FFFF96000000547970654465, Null, 0) Where diagram_id = @newid -- index:2433
  Update sysdiagrams Set [definition] .Write ( 0X667300003800A50900000700008004000000AC020000008000000D0000805363, Null, 0) Where diagram_id = @newid -- index:2465
  Update sysdiagrams Set [definition] .Write ( 0X684772696473CCF7FFFFF41A00005479706544656656616C7565730800000000, Null, 0) Where diagram_id = @newid -- index:2497
  Update sysdiagrams Set [definition] .Write ( 0X3000A50900000700008005000000A20200000080000008000080536368477269, Null, 0) Where diagram_id = @newid -- index:2529
  Update sysdiagrams Set [definition] .Write ( 0X64735613000096000000556E69744465667300007000A5090000070000800600, Null, 0) Where diagram_id = @newid -- index:2561
  Update sysdiagrams Set [definition] .Write ( 0X0000520000000180000046000080436F6E74726F6C730D1E00006C0A00005265, Null, 0) Where diagram_id = @newid -- index:2593
  Update sysdiagrams Set [definition] .Write ( 0X6C6174696F6E20ABA0464B5F436C617373446566735F556E697444656673A0BB, Null, 0) Where diagram_id = @newid -- index:2625
  Update sysdiagrams Set [definition] .Write ( 0X20656E74726520ABA0556E697444656673A0BB20657420ABA0436C6173734465, Null, 0) Where diagram_id = @newid -- index:2657
  Update sysdiagrams Set [definition] .Write ( 0X6673A0BB231800002800B50100000700008007000000310000005D0000000280, Null, 0) Where diagram_id = @newid -- index:2689
  Update sysdiagrams Set [definition] .Write ( 0X0000436F6E74726F6C7353200000E811000000006C00A5090000070000800800, Null, 0) Where diagram_id = @newid -- index:2721
  Update sysdiagrams Set [definition] .Write ( 0X0000520000000180000044000080436F6E74726F6C73F40D0000710500005265, Null, 0) Where diagram_id = @newid -- index:2753
  Update sysdiagrams Set [definition] .Write ( 0X6C6174696F6E20ABA0464B5F54797065446566735F556E697444656673A0BB20, Null, 0) Where diagram_id = @newid -- index:2785
  Update sysdiagrams Set [definition] .Write ( 0X656E74726520ABA0556E697444656673A0BB20657420ABA05479706544656673, Null, 0) Where diagram_id = @newid -- index:2817
  Update sysdiagrams Set [definition] .Write ( 0XA0BB00002800B50100000700008009000000310000005B00000002800000436F, Null, 0) Where diagram_id = @newid -- index:2849
  Update sysdiagrams Set [definition] .Write ( 0X6E74726F6C73B30A0000B707000000007800A5090000070000800A0000005200, Null, 0) Where diagram_id = @newid -- index:2881
  Update sysdiagrams Set [definition] .Write ( 0X0000018000004E000080436F6E74726F6C73D62B00001F1B000052656C617469, Null, 0) Where diagram_id = @newid -- index:2913
  Update sysdiagrams Set [definition] .Write ( 0X6F6E20ABA0464B5F50726F7065727479446566735F436C61737344656673A0BB, Null, 0) Where diagram_id = @newid -- index:2945
  Update sysdiagrams Set [definition] .Write ( 0X20656E74726520ABA0436C61737344656673A0BB20657420ABA050726F706572, Null, 0) Where diagram_id = @newid -- index:2977
  Update sysdiagrams Set [definition] .Write ( 0X747944656673A0BB000000002800B5010000070000800B000000310000006500, Null, 0) Where diagram_id = @newid -- index:3009
  Update sysdiagrams Set [definition] .Write ( 0X000002800000436F6E74726F6C73EC260000AF1A000000007800A50900000700, Null, 0) Where diagram_id = @newid -- index:3041
  Update sysdiagrams Set [definition] .Write ( 0X00800C00000052000000018000004E000080436F6E74726F6C73FFFEFFFF8211, Null, 0) Where diagram_id = @newid -- index:3073
  Update sysdiagrams Set [definition] .Write ( 0X000052656C6174696F6E20ABA0464B5F5479706544656656616C7565735F5479, Null, 0) Where diagram_id = @newid -- index:3105
  Update sysdiagrams Set [definition] .Write ( 0X706544656673A0BB20656E74726520ABA05479706544656673A0BB20657420AB, Null, 0) Where diagram_id = @newid -- index:3137
  Update sysdiagrams Set [definition] .Write ( 0XA05479706544656656616C756573A0BB000000002800B5010000070000800D00, Null, 0) Where diagram_id = @newid -- index:3169
  Update sysdiagrams Set [definition] .Write ( 0X0000310000006500000002800000436F6E74726F6C73E8EFFFFFE81600000000, Null, 0) Where diagram_id = @newid -- index:3201
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:3233
  Update sysdiagrams Set [definition] .Write ( 0X0100FEFF030A0000FFFFFFFF0000000000000000000000000000000017000000, Null, 0) Where diagram_id = @newid -- index:3265
  Update sysdiagrams Set [definition] .Write ( 0X4D6963726F736F66742044445320466F726D20322E300010000000456D626564, Null, 0) Where diagram_id = @newid -- index:3297
  Update sysdiagrams Set [definition] .Write ( 0X646564204F626A6563740000000000F439B27100000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:3329
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:3361
  Update sysdiagrams Set [definition] .Write ( 0X0C0000002DCDFFFFFEDAFFFF0100260000007300630068005F006C0061006200, Null, 0) Where diagram_id = @newid -- index:3393
  Update sysdiagrams Set [definition] .Write ( 0X65006C0073005F00760069007300690062006C0065000000010000000B000000, Null, 0) Where diagram_id = @newid -- index:3425
  Update sysdiagrams Set [definition] .Write ( 0X1F00000017F5FFFF57ECFFFF56540000A96A0000640000000000000000000000, Null, 0) Where diagram_id = @newid -- index:3457
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000010000000100000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:3489
  Update sysdiagrams Set [definition] .Write ( 0X000000000000D002000006002800000041006300740069007600650054006100, Null, 0) Where diagram_id = @newid -- index:3521
  Update sysdiagrams Set [definition] .Write ( 0X62006C00650056006900650077004D006F006400650000000100000008000400, Null, 0) Where diagram_id = @newid -- index:3553
  Update sysdiagrams Set [definition] .Write ( 0X2143341208000000541700002423000078563412070000001401000043006C00, Null, 0) Where diagram_id = @newid -- index:3585
  Update sysdiagrams Set [definition] .Write ( 0X610073007300440065006600730000000000000000E079400000000000001040, Null, 0) Where diagram_id = @newid -- index:3617
  Update sysdiagrams Set [definition] .Write ( 0X0100000000000000000000000E00000005000000180100000000000000000000, Null, 0) Where diagram_id = @newid -- index:3649
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000F80000000000000005000000000000000000000002000000, Null, 0) Where diagram_id = @newid -- index:3681
  Update sysdiagrams Set [definition] .Write ( 0X0000000000E0794000000000000000000000000000E079400000000000000040, Null, 0) Where diagram_id = @newid -- index:3713
  Update sysdiagrams Set [definition] .Write ( 0X040000002000000030000000000000000000000000C079400000000000001040, Null, 0) Where diagram_id = @newid -- index:3745
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000040000000000000004000000000000000000100000000000000, Null, 0) Where diagram_id = @newid -- index:3777
  Update sysdiagrams Set [definition] .Write ( 0X0500000000000000400000000100000000000000000000400000000000001040, Null, 0) Where diagram_id = @newid -- index:3809
  Update sysdiagrams Set [definition] .Write ( 0X0400000020000000200000000000000000000000010000000500000054000000, Null, 0) Where diagram_id = @newid -- index:3841
  Update sysdiagrams Set [definition] .Write ( 0X2C0000002C0000002C000000340000000000000000000000A7290000511F0000, Null, 0) Where diagram_id = @newid -- index:3873
  Update sysdiagrams Set [definition] .Write ( 0X000000002D0100000B0000000C000000070000001C010000F708000053070000, Null, 0) Where diagram_id = @newid -- index:3905
  Update sysdiagrams Set [definition] .Write ( 0X49020000D0020000FE010000DD04000047040000850200004704000064050000, Null, 0) Where diagram_id = @newid -- index:3937
  Update sysdiagrams Set [definition] .Write ( 0XB103000000000000010000005417000024230000000000000900000009000000, Null, 0) Where diagram_id = @newid -- index:3969
  Update sysdiagrams Set [definition] .Write ( 0X02000000020000001C010000AA0A00000000000001000000F21300004E060000, Null, 0) Where diagram_id = @newid -- index:4001
  Update sysdiagrams Set [definition] .Write ( 0X00000000010000000100000002000000020000001C010000F708000001000000, Null, 0) Where diagram_id = @newid -- index:4033
  Update sysdiagrams Set [definition] .Write ( 0X00000000F2130000080400000000000000000000000000000200000002000000, Null, 0) Where diagram_id = @newid -- index:4065
  Update sysdiagrams Set [definition] .Write ( 0X1C010000F7080000000000000000000055320000DD2300000000000000000000, Null, 0) Where diagram_id = @newid -- index:4097
  Update sysdiagrams Set [definition] .Write ( 0X0D00000004000000040000001C010000F70800009B0A00008106000078563412, Null, 0) Where diagram_id = @newid -- index:4129
  Update sysdiagrams Set [definition] .Write ( 0X040000005C00000001000000010000000B000000000000000100000002000000, Null, 0) Where diagram_id = @newid -- index:4161
  Update sysdiagrams Set [definition] .Write ( 0X030000000400000005000000060000000700000008000000090000000A000000, Null, 0) Where diagram_id = @newid -- index:4193
  Update sysdiagrams Set [definition] .Write ( 0X04000000640062006F0000000A00000043006C00610073007300440065006600, Null, 0) Where diagram_id = @newid -- index:4225
  Update sysdiagrams Set [definition] .Write ( 0X7300000021433412080000005417000075280000785634120700000014010000, Null, 0) Where diagram_id = @newid -- index:4257
  Update sysdiagrams Set [definition] .Write ( 0X500072006F00700065007200740079004400650066007300000067002C002000, Null, 0) Where diagram_id = @newid -- index:4289
  Update sysdiagrams Set [definition] .Write ( 0X430075006C0074007500720065003D006E00650075007400720061006C002C00, Null, 0) Where diagram_id = @newid -- index:4321
  Update sysdiagrams Set [definition] .Write ( 0X20005000750062006C00690063004B006500790054006F006B0065006E003D00, Null, 0) Where diagram_id = @newid -- index:4353
  Update sysdiagrams Set [definition] .Write ( 0X6200300033006600350066003700660031003100640035003000610033006100, Null, 0) Where diagram_id = @newid -- index:4385
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:4417
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:4449
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:4481
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000100000005000000, Null, 0) Where diagram_id = @newid -- index:4513
  Update sysdiagrams Set [definition] .Write ( 0X540000002C0000002C0000002C000000340000000000000000000000A7290000, Null, 0) Where diagram_id = @newid -- index:4545
  Update sysdiagrams Set [definition] .Write ( 0XDD230000000000002D0100000D0000000C000000070000001C010000F7080000, Null, 0) Where diagram_id = @newid -- index:4577
  Update sysdiagrams Set [definition] .Write ( 0X5307000049020000D0020000FE010000DD040000470400008502000047040000, Null, 0) Where diagram_id = @newid -- index:4609
  Update sysdiagrams Set [definition] .Write ( 0X64050000B103000000000000010000005417000075280000000000000B000000, Null, 0) Where diagram_id = @newid -- index:4641
  Update sysdiagrams Set [definition] .Write ( 0X0B00000002000000020000001C010000AA0A00000000000001000000F2130000, Null, 0) Where diagram_id = @newid -- index:4673
  Update sysdiagrams Set [definition] .Write ( 0X4E06000000000000010000000100000002000000020000001C010000F7080000, Null, 0) Where diagram_id = @newid -- index:4705
  Update sysdiagrams Set [definition] .Write ( 0X0100000000000000F21300000804000000000000000000000000000002000000, Null, 0) Where diagram_id = @newid -- index:4737
  Update sysdiagrams Set [definition] .Write ( 0X020000001C010000F7080000000000000000000055320000DD23000000000000, Null, 0) Where diagram_id = @newid -- index:4769
  Update sysdiagrams Set [definition] .Write ( 0X000000000D00000004000000040000001C010000F70800009B0A000081060000, Null, 0) Where diagram_id = @newid -- index:4801
  Update sysdiagrams Set [definition] .Write ( 0X78563412040000006200000001000000010000000B0000000000000001000000, Null, 0) Where diagram_id = @newid -- index:4833
  Update sysdiagrams Set [definition] .Write ( 0X0200000003000000040000000500000006000000070000000800000009000000, Null, 0) Where diagram_id = @newid -- index:4865
  Update sysdiagrams Set [definition] .Write ( 0X0A00000004000000640062006F0000000D000000500072006F00700065007200, Null, 0) Where diagram_id = @newid -- index:4897
  Update sysdiagrams Set [definition] .Write ( 0X7400790044006500660073000000214334120800000054170000A31300007856, Null, 0) Where diagram_id = @newid -- index:4929
  Update sysdiagrams Set [definition] .Write ( 0X341207000000140100005400790070006500440065006600730000006E006400, Null, 0) Where diagram_id = @newid -- index:4961
  Update sysdiagrams Set [definition] .Write ( 0X6F00770073002E0046006F0072006D0073002C00200056006500720073006900, Null, 0) Where diagram_id = @newid -- index:4993
  Update sysdiagrams Set [definition] .Write ( 0X6F006E003D0034002E0030002E0030002E0030002C002000430075006C007400, Null, 0) Where diagram_id = @newid -- index:5025
  Update sysdiagrams Set [definition] .Write ( 0X7500720065003D006E00650075007400720061006C002C002000500075006200, Null, 0) Where diagram_id = @newid -- index:5057
  Update sysdiagrams Set [definition] .Write ( 0X6C00690063004B006500790054006F006B0065006E003D006200370037006100, Null, 0) Where diagram_id = @newid -- index:5089
  Update sysdiagrams Set [definition] .Write ( 0X3500630035003600310039003300340065003000380039000000000000000000, Null, 0) Where diagram_id = @newid -- index:5121
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:5153
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:5185
  Update sysdiagrams Set [definition] .Write ( 0X00000100000005000000540000002C0000002C0000002C000000340000000000, Null, 0) Where diagram_id = @newid -- index:5217
  Update sysdiagrams Set [definition] .Write ( 0X000000000000A729000039160000000000002D010000070000000C0000000700, Null, 0) Where diagram_id = @newid -- index:5249
  Update sysdiagrams Set [definition] .Write ( 0X00001C010000F70800005307000049020000D0020000FE010000DD0400004704, Null, 0) Where diagram_id = @newid -- index:5281
  Update sysdiagrams Set [definition] .Write ( 0X0000850200004704000064050000B1030000000000000100000054170000A313, Null, 0) Where diagram_id = @newid -- index:5313
  Update sysdiagrams Set [definition] .Write ( 0X000000000000030000000300000002000000020000001C010000AA0A00000000, Null, 0) Where diagram_id = @newid -- index:5345
  Update sysdiagrams Set [definition] .Write ( 0X000001000000F21300004E060000000000000100000001000000020000000200, Null, 0) Where diagram_id = @newid -- index:5377
  Update sysdiagrams Set [definition] .Write ( 0X00001C010000F70800000100000000000000F213000008040000000000000000, Null, 0) Where diagram_id = @newid -- index:5409
  Update sysdiagrams Set [definition] .Write ( 0X00000000000002000000020000001C010000F708000000000000000000005532, Null, 0) Where diagram_id = @newid -- index:5441
  Update sysdiagrams Set [definition] .Write ( 0X0000DD23000000000000000000000D00000004000000040000001C010000F708, Null, 0) Where diagram_id = @newid -- index:5473
  Update sysdiagrams Set [definition] .Write ( 0X00009B0A00008106000078563412040000005A00000001000000010000000B00, Null, 0) Where diagram_id = @newid -- index:5505
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000100000002000000030000000400000005000000060000000700, Null, 0) Where diagram_id = @newid -- index:5537
  Update sysdiagrams Set [definition] .Write ( 0X000008000000090000000A00000004000000640062006F000000090000005400, Null, 0) Where diagram_id = @newid -- index:5569
  Update sysdiagrams Set [definition] .Write ( 0X79007000650044006500660073000000214334120800000054170000BD160000, Null, 0) Where diagram_id = @newid -- index:5601
  Update sysdiagrams Set [definition] .Write ( 0X7856341207000000140100005400790070006500440065006600560061006C00, Null, 0) Where diagram_id = @newid -- index:5633
  Update sysdiagrams Set [definition] .Write ( 0X75006500730000006E0061006D0065002C002000760061006C00750065002000, Null, 0) Where diagram_id = @newid -- index:5665
  Update sysdiagrams Set [definition] .Write ( 0X460052004F004D0020007300790073002E0065007800740065006E0064006500, Null, 0) Where diagram_id = @newid -- index:5697
  Update sysdiagrams Set [definition] .Write ( 0X64005F00700072006F0070006500720074006900650073002000570048004500, Null, 0) Where diagram_id = @newid -- index:5729
  Update sysdiagrams Set [definition] .Write ( 0X520045002000280063006C0061007300730020003D0020003100290020004100, Null, 0) Where diagram_id = @newid -- index:5761
  Update sysdiagrams Set [definition] .Write ( 0X4E004400200028006D0061006A006F0072005F006900640020003D0020004F00, Null, 0) Where diagram_id = @newid -- index:5793
  Update sysdiagrams Set [definition] .Write ( 0X42004A004500430054005F004900440028004E0027005B00640062006F005D00, Null, 0) Where diagram_id = @newid -- index:5825
  Update sysdiagrams Set [definition] .Write ( 0X2E005B005400610062006C0065005F0031005D00270029002900000000000000, Null, 0) Where diagram_id = @newid -- index:5857
  Update sysdiagrams Set [definition] .Write ( 0X000000000100000005000000540000002C0000002C0000002C00000034000000, Null, 0) Where diagram_id = @newid -- index:5889
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000A729000039160000000000002D010000070000000C000000, Null, 0) Where diagram_id = @newid -- index:5921
  Update sysdiagrams Set [definition] .Write ( 0X070000001C010000F70800005307000049020000D0020000FE010000DD040000, Null, 0) Where diagram_id = @newid -- index:5953
  Update sysdiagrams Set [definition] .Write ( 0X47040000850200004704000064050000B1030000000000000100000054170000, Null, 0) Where diagram_id = @newid -- index:5985
  Update sysdiagrams Set [definition] .Write ( 0XBD16000000000000050000000500000002000000020000001C010000AA0A0000, Null, 0) Where diagram_id = @newid -- index:6017
  Update sysdiagrams Set [definition] .Write ( 0X0000000001000000F21300004E06000000000000010000000100000002000000, Null, 0) Where diagram_id = @newid -- index:6049
  Update sysdiagrams Set [definition] .Write ( 0X020000001C010000F70800000100000000000000F21300000804000000000000, Null, 0) Where diagram_id = @newid -- index:6081
  Update sysdiagrams Set [definition] .Write ( 0X000000000000000002000000020000001C010000F70800000000000000000000, Null, 0) Where diagram_id = @newid -- index:6113
  Update sysdiagrams Set [definition] .Write ( 0X55320000DD23000000000000000000000D00000004000000040000001C010000, Null, 0) Where diagram_id = @newid -- index:6145
  Update sysdiagrams Set [definition] .Write ( 0XF70800009B0A0000810600007856341204000000640000000100000001000000, Null, 0) Where diagram_id = @newid -- index:6177
  Update sysdiagrams Set [definition] .Write ( 0X0B00000000000000010000000200000003000000040000000500000006000000, Null, 0) Where diagram_id = @newid -- index:6209
  Update sysdiagrams Set [definition] .Write ( 0X0700000008000000090000000A00000004000000640062006F0000000E000000, Null, 0) Where diagram_id = @newid -- index:6241
  Update sysdiagrams Set [definition] .Write ( 0X5400790070006500440065006600560061006C00750065007300000021433412, Null, 0) Where diagram_id = @newid -- index:6273
  Update sysdiagrams Set [definition] .Write ( 0X080000002E1700008D0C000078563412070000001401000055006E0069007400, Null, 0) Where diagram_id = @newid -- index:6305
  Update sysdiagrams Set [definition] .Write ( 0X440065006600730000004C0045004300540020006E0061006D0065002C002000, Null, 0) Where diagram_id = @newid -- index:6337
  Update sysdiagrams Set [definition] .Write ( 0X760061006C00750065002000460052004F004D0020007300790073002E006500, Null, 0) Where diagram_id = @newid -- index:6369
  Update sysdiagrams Set [definition] .Write ( 0X7800740065006E006400650064005F00700072006F0070006500720074006900, Null, 0) Where diagram_id = @newid -- index:6401
  Update sysdiagrams Set [definition] .Write ( 0X650073002000570048004500520045002000280063006C006100730073002000, Null, 0) Where diagram_id = @newid -- index:6433
  Update sysdiagrams Set [definition] .Write ( 0X3D00200031002900200041004E004400200028006D0061006A006F0072005F00, Null, 0) Where diagram_id = @newid -- index:6465
  Update sysdiagrams Set [definition] .Write ( 0X6900640020003D0020004F0042004A004500430054005F004900440028004E00, Null, 0) Where diagram_id = @newid -- index:6497
  Update sysdiagrams Set [definition] .Write ( 0X27005B00640062006F005D002E005B005400610062006C0065005F0031005D00, Null, 0) Where diagram_id = @newid -- index:6529
  Update sysdiagrams Set [definition] .Write ( 0X270029002900000000000000000000000100000005000000540000002C000000, Null, 0) Where diagram_id = @newid -- index:6561
  Update sysdiagrams Set [definition] .Write ( 0X2C0000002C000000340000000000000000000000A72900003916000000000000, Null, 0) Where diagram_id = @newid -- index:6593
  Update sysdiagrams Set [definition] .Write ( 0X2D010000070000000C000000070000001C010000F70800005307000049020000, Null, 0) Where diagram_id = @newid -- index:6625
  Update sysdiagrams Set [definition] .Write ( 0XD0020000FE010000DD04000047040000850200004704000064050000B1030000, Null, 0) Where diagram_id = @newid -- index:6657
  Update sysdiagrams Set [definition] .Write ( 0X00000000010000002E1700008D0C000000000000020000000200000002000000, Null, 0) Where diagram_id = @newid -- index:6689
  Update sysdiagrams Set [definition] .Write ( 0X020000001C0100009B0A00000000000001000000F21300004E06000000000000, Null, 0) Where diagram_id = @newid -- index:6721
  Update sysdiagrams Set [definition] .Write ( 0X010000000100000002000000020000001C010000F70800000100000000000000, Null, 0) Where diagram_id = @newid -- index:6753
  Update sysdiagrams Set [definition] .Write ( 0XF21300000804000000000000000000000000000002000000020000001C010000, Null, 0) Where diagram_id = @newid -- index:6785
  Update sysdiagrams Set [definition] .Write ( 0XF7080000000000000000000055320000DD23000000000000000000000D000000, Null, 0) Where diagram_id = @newid -- index:6817
  Update sysdiagrams Set [definition] .Write ( 0X04000000040000001C010000F70800009B0A0000810600007856341204000000, Null, 0) Where diagram_id = @newid -- index:6849
  Update sysdiagrams Set [definition] .Write ( 0X5A00000001000000010000000B00000000000000010000000200000003000000, Null, 0) Where diagram_id = @newid -- index:6881
  Update sysdiagrams Set [definition] .Write ( 0X0400000005000000060000000700000008000000090000000A00000004000000, Null, 0) Where diagram_id = @newid -- index:6913
  Update sysdiagrams Set [definition] .Write ( 0X640062006F0000000900000055006E0069007400440065006600730000000200, Null, 0) Where diagram_id = @newid -- index:6945
  Update sysdiagrams Set [definition] .Write ( 0X0B00A41F0000230D0000A41F0000061800000000000002000000F0F0F0000000, Null, 0) Where diagram_id = @newid -- index:6977
  Update sysdiagrams Set [definition] .Write ( 0X000000000000000000000000000001000000070000000000000053200000E811, Null, 0) Where diagram_id = @newid -- index:7009
  Update sysdiagrams Set [definition] .Write ( 0X00009D0C000058010000320000000100000200009D0C00005801000002000000, Null, 0) Where diagram_id = @newid -- index:7041
  Update sysdiagrams Set [definition] .Write ( 0X0000050000800800008001000000150001000000900144420100065461686F6D, Null, 0) Where diagram_id = @newid -- index:7073
  Update sysdiagrams Set [definition] .Write ( 0X61150046004B005F0043006C0061007300730044006500660073005F0055006E, Null, 0) Where diagram_id = @newid -- index:7105
  Update sysdiagrams Set [definition] .Write ( 0X0069007400440065006600730002000B005613000008070000200F0000080700, Null, 0) Where diagram_id = @newid -- index:7137
  Update sysdiagrams Set [definition] .Write ( 0X000000000002000000F0F0F00000000000000000000000000000000000010000, Null, 0) Where diagram_id = @newid -- index:7169
  Update sysdiagrams Set [definition] .Write ( 0X000900000000000000B30A0000B7070000810C0000580100002F000000010000, Null, 0) Where diagram_id = @newid -- index:7201
  Update sysdiagrams Set [definition] .Write ( 0X020000810C000058010000020000000000FFFFFF000800008001000000150001, Null, 0) Where diagram_id = @newid -- index:7233
  Update sysdiagrams Set [definition] .Write ( 0X000000900144420100065461686F6D61140046004B005F005400790070006500, Null, 0) Where diagram_id = @newid -- index:7265
  Update sysdiagrams Set [definition] .Write ( 0X44006500660073005F0055006E0069007400440065006600730002000B00022D, Null, 0) Where diagram_id = @newid -- index:7297
  Update sysdiagrams Set [definition] .Write ( 0X0000B61C00000C300000B61C00000000000002000000F0F0F000000000000000, Null, 0) Where diagram_id = @newid -- index:7329
  Update sysdiagrams Set [definition] .Write ( 0X00000000000000000000010000000B00000000000000EC260000AF1A0000350F, Null, 0) Where diagram_id = @newid -- index:7361
  Update sysdiagrams Set [definition] .Write ( 0X00005801000032000000010000020000350F000058010000020000000000FFFF, Null, 0) Where diagram_id = @newid -- index:7393
  Update sysdiagrams Set [definition] .Write ( 0XFF000800008001000000150001000000900144420100065461686F6D61190046, Null, 0) Where diagram_id = @newid -- index:7425
  Update sysdiagrams Set [definition] .Write ( 0X004B005F00500072006F007000650072007400790044006500660073005F0043, Null, 0) Where diagram_id = @newid -- index:7457
  Update sysdiagrams Set [definition] .Write ( 0X006C00610073007300440065006600730002000B009600000039140000960000, Null, 0) Where diagram_id = @newid -- index:7489
  Update sysdiagrams Set [definition] .Write ( 0X00F41A00000000000002000000F0F0F000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7521
  Update sysdiagrams Set [definition] .Write ( 0X00010000000D00000000000000E8EFFFFFE8160000FF0F000058010000320000, Null, 0) Where diagram_id = @newid -- index:7553
  Update sysdiagrams Set [definition] .Write ( 0X00010000020000FF0F000058010000020000000000FFFFFF0008000080010000, Null, 0) Where diagram_id = @newid -- index:7585
  Update sysdiagrams Set [definition] .Write ( 0X00150001000000900144420100065461686F6D61190046004B005F0054007900, Null, 0) Where diagram_id = @newid -- index:7617
  Update sysdiagrams Set [definition] .Write ( 0X70006500440065006600560061006C007500650073005F005400790070006500, Null, 0) Where diagram_id = @newid -- index:7649
  Update sysdiagrams Set [definition] .Write ( 0X4400650066007300000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7681
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7713
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7745
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7777
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7809
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7841
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7873
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7905
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7937
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:7969
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8001
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8033
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8065
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8097
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8129
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8161
  Update sysdiagrams Set [definition] .Write ( 0X0300440064007300530074007200650061006D00000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8193
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8225
  Update sysdiagrams Set [definition] .Write ( 0X160002000300000006000000FFFFFFFF00000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8257
  Update sysdiagrams Set [definition] .Write ( 0X000000000000000000000000000000000000000015000000240D000000000000, Null, 0) Where diagram_id = @newid -- index:8289
  Update sysdiagrams Set [definition] .Write ( 0X53006300680065006D0061002000550044005600200044006500660061007500, Null, 0) Where diagram_id = @newid -- index:8321
  Update sysdiagrams Set [definition] .Write ( 0X6C00740000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8353
  Update sysdiagrams Set [definition] .Write ( 0X26000200FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8385
  Update sysdiagrams Set [definition] .Write ( 0X00000000000000000000000000000000000000004A0000001600000000000000, Null, 0) Where diagram_id = @newid -- index:8417
  Update sysdiagrams Set [definition] .Write ( 0X440053005200450046002D0053004300480045004D0041002D0043004F004E00, Null, 0) Where diagram_id = @newid -- index:8449
  Update sysdiagrams Set [definition] .Write ( 0X540045004E005400530000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8481
  Update sysdiagrams Set [definition] .Write ( 0X2C0002010500000007000000FFFFFFFF00000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8513
  Update sysdiagrams Set [definition] .Write ( 0X00000000000000000000000000000000000000004B0000000803000000000000, Null, 0) Where diagram_id = @newid -- index:8545
  Update sysdiagrams Set [definition] .Write ( 0X53006300680065006D0061002000550044005600200044006500660061007500, Null, 0) Where diagram_id = @newid -- index:8577
  Update sysdiagrams Set [definition] .Write ( 0X6C007400200050006F0073007400200056003600000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8609
  Update sysdiagrams Set [definition] .Write ( 0X36000200FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:8641
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000580000001200000000000000, Null, 0) Where diagram_id = @newid -- index:8673
  Update sysdiagrams Set [definition] .Write ( 0X000031000000200000005400610062006C00650056006900650077004D006F00, Null, 0) Where diagram_id = @newid -- index:8705
  Update sysdiagrams Set [definition] .Write ( 0X640065003A00300000000100000008003A00000034002C0030002C0032003800, Null, 0) Where diagram_id = @newid -- index:8737
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C0032003200390035002C0031002C0031003800370035002C00, Null, 0) Where diagram_id = @newid -- index:8769
  Update sysdiagrams Set [definition] .Write ( 0X35002C0031003200340035000000200000005400610062006C00650056006900, Null, 0) Where diagram_id = @newid -- index:8801
  Update sysdiagrams Set [definition] .Write ( 0X650077004D006F00640065003A00310000000100000008001E00000032002C00, Null, 0) Where diagram_id = @newid -- index:8833
  Update sysdiagrams Set [definition] .Write ( 0X30002C003200380034002C0030002C0032003700330030000000200000005400, Null, 0) Where diagram_id = @newid -- index:8865
  Update sysdiagrams Set [definition] .Write ( 0X610062006C00650056006900650077004D006F00640065003A00320000000100, Null, 0) Where diagram_id = @newid -- index:8897
  Update sysdiagrams Set [definition] .Write ( 0X000008001E00000032002C0030002C003200380034002C0030002C0032003200, Null, 0) Where diagram_id = @newid -- index:8929
  Update sysdiagrams Set [definition] .Write ( 0X390035000000200000005400610062006C00650056006900650077004D006F00, Null, 0) Where diagram_id = @newid -- index:8961
  Update sysdiagrams Set [definition] .Write ( 0X640065003A00330000000100000008001E00000032002C0030002C0032003800, Null, 0) Where diagram_id = @newid -- index:8993
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C0032003200390035000000200000005400610062006C006500, Null, 0) Where diagram_id = @newid -- index:9025
  Update sysdiagrams Set [definition] .Write ( 0X56006900650077004D006F00640065003A00340000000100000008003E000000, Null, 0) Where diagram_id = @newid -- index:9057
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C003200380034002C0030002C0032003200390035002C003100, Null, 0) Where diagram_id = @newid -- index:9089
  Update sysdiagrams Set [definition] .Write ( 0X32002C0032003700310035002C00310031002C00310036003600350000000200, Null, 0) Where diagram_id = @newid -- index:9121
  Update sysdiagrams Set [definition] .Write ( 0X00000200000000000000000000000000000000000000D0020000060028000000, Null, 0) Where diagram_id = @newid -- index:9153
  Update sysdiagrams Set [definition] .Write ( 0X4100630074006900760065005400610062006C00650056006900650077004D00, Null, 0) Where diagram_id = @newid -- index:9185
  Update sysdiagrams Set [definition] .Write ( 0X6F00640065000000010000000800040000003100000020000000540061006200, Null, 0) Where diagram_id = @newid -- index:9217
  Update sysdiagrams Set [definition] .Write ( 0X6C00650056006900650077004D006F00640065003A0030000000010000000800, Null, 0) Where diagram_id = @newid -- index:9249
  Update sysdiagrams Set [definition] .Write ( 0X3A00000034002C0030002C003200380034002C0030002C003200320039003500, Null, 0) Where diagram_id = @newid -- index:9281
  Update sysdiagrams Set [definition] .Write ( 0X2C0031002C0031003800370035002C0035002C00310032003400350000002000, Null, 0) Where diagram_id = @newid -- index:9313
  Update sysdiagrams Set [definition] .Write ( 0X00005400610062006C00650056006900650077004D006F00640065003A003100, Null, 0) Where diagram_id = @newid -- index:9345
  Update sysdiagrams Set [definition] .Write ( 0X00000100000008001E00000032002C0030002C003200380034002C0030002C00, Null, 0) Where diagram_id = @newid -- index:9377
  Update sysdiagrams Set [definition] .Write ( 0X32003700330030000000200000005400610062006C0065005600690065007700, Null, 0) Where diagram_id = @newid -- index:9409
  Update sysdiagrams Set [definition] .Write ( 0X4D006F00640065003A00320000000100000008001E00000032002C0030002C00, Null, 0) Where diagram_id = @newid -- index:9441
  Update sysdiagrams Set [definition] .Write ( 0X3200380034002C0030002C003200320039003500000020000000540061006200, Null, 0) Where diagram_id = @newid -- index:9473
  Update sysdiagrams Set [definition] .Write ( 0X6C00650056006900650077004D006F00640065003A0033000000010000000800, Null, 0) Where diagram_id = @newid -- index:9505
  Update sysdiagrams Set [definition] .Write ( 0X1E00000032002C0030002C003200380034002C0030002C003200320039003500, Null, 0) Where diagram_id = @newid -- index:9537
  Update sysdiagrams Set [definition] .Write ( 0X0000200000005400610062006C00650056006900650077004D006F0064006500, Null, 0) Where diagram_id = @newid -- index:9569
  Update sysdiagrams Set [definition] .Write ( 0X3A00340000000100000008003E00000034002C0030002C003200380034002C00, Null, 0) Where diagram_id = @newid -- index:9601
  Update sysdiagrams Set [definition] .Write ( 0X30002C0032003200390035002C00310032002C0032003700310035002C003100, Null, 0) Where diagram_id = @newid -- index:9633
  Update sysdiagrams Set [definition] .Write ( 0X31002C0031003600360035000000030000000300000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:9665
  Update sysdiagrams Set [definition] .Write ( 0X000000000000D002000006002800000041006300740069007600650054006100, Null, 0) Where diagram_id = @newid -- index:9697
  Update sysdiagrams Set [definition] .Write ( 0X62006C00650056006900650077004D006F006400650000000100000008000400, Null, 0) Where diagram_id = @newid -- index:9729
  Update sysdiagrams Set [definition] .Write ( 0X000031000000200000005400610062006C00650056006900650077004D006F00, Null, 0) Where diagram_id = @newid -- index:9761
  Update sysdiagrams Set [definition] .Write ( 0X640065003A00300000000100000008003A00000034002C0030002C0032003800, Null, 0) Where diagram_id = @newid -- index:9793
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C0032003200390035002C0031002C0031003800370035002C00, Null, 0) Where diagram_id = @newid -- index:9825
  Update sysdiagrams Set [definition] .Write ( 0X35002C0031003200340035000000200000005400610062006C00650056006900, Null, 0) Where diagram_id = @newid -- index:9857
  Update sysdiagrams Set [definition] .Write ( 0X650077004D006F00640065003A00310000000100000008001E00000032002C00, Null, 0) Where diagram_id = @newid -- index:9889
  Update sysdiagrams Set [definition] .Write ( 0X30002C003200380034002C0030002C0032003700330030000000200000005400, Null, 0) Where diagram_id = @newid -- index:9921
  Update sysdiagrams Set [definition] .Write ( 0X610062006C00650056006900650077004D006F00640065003A00320000000100, Null, 0) Where diagram_id = @newid -- index:9953
  Update sysdiagrams Set [definition] .Write ( 0X000008001E00000032002C0030002C003200380034002C0030002C0032003200, Null, 0) Where diagram_id = @newid -- index:9985
  Update sysdiagrams Set [definition] .Write ( 0X390035000000200000005400610062006C00650056006900650077004D006F00, Null, 0) Where diagram_id = @newid -- index:10017
  Update sysdiagrams Set [definition] .Write ( 0X640065003A00330000000100000008001E00000032002C0030002C0032003800, Null, 0) Where diagram_id = @newid -- index:10049
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C0032003200390035000000200000005400610062006C006500, Null, 0) Where diagram_id = @newid -- index:10081
  Update sysdiagrams Set [definition] .Write ( 0X56006900650077004D006F00640065003A00340000000100000008003E000000, Null, 0) Where diagram_id = @newid -- index:10113
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C003200380034002C0030002C0032003200390035002C003100, Null, 0) Where diagram_id = @newid -- index:10145
  Update sysdiagrams Set [definition] .Write ( 0X32002C0032003700310035002C00310031002C00310036003600350000000400, Null, 0) Where diagram_id = @newid -- index:10177
  Update sysdiagrams Set [definition] .Write ( 0X00000400000000000000000000000000000000000000D0020000060028000000, Null, 0) Where diagram_id = @newid -- index:10209
  Update sysdiagrams Set [definition] .Write ( 0X4100630074006900760065005400610062006C00650056006900650077004D00, Null, 0) Where diagram_id = @newid -- index:10241
  Update sysdiagrams Set [definition] .Write ( 0X6F00640065000000010000000800040000003100000020000000540061006200, Null, 0) Where diagram_id = @newid -- index:10273
  Update sysdiagrams Set [definition] .Write ( 0X6C00650056006900650077004D006F00640065003A0030000000010000000800, Null, 0) Where diagram_id = @newid -- index:10305
  Update sysdiagrams Set [definition] .Write ( 0X3A00000034002C0030002C003200380034002C0030002C003200320039003500, Null, 0) Where diagram_id = @newid -- index:10337
  Update sysdiagrams Set [definition] .Write ( 0X2C0031002C0031003800370035002C0035002C00310032003400350000002000, Null, 0) Where diagram_id = @newid -- index:10369
  Update sysdiagrams Set [definition] .Write ( 0X00005400610062006C00650056006900650077004D006F00640065003A003100, Null, 0) Where diagram_id = @newid -- index:10401
  Update sysdiagrams Set [definition] .Write ( 0X00000100000008001E00000032002C0030002C003200380034002C0030002C00, Null, 0) Where diagram_id = @newid -- index:10433
  Update sysdiagrams Set [definition] .Write ( 0X32003700330030000000200000005400610062006C0065005600690065007700, Null, 0) Where diagram_id = @newid -- index:10465
  Update sysdiagrams Set [definition] .Write ( 0X4D006F00640065003A00320000000100000008001E00000032002C0030002C00, Null, 0) Where diagram_id = @newid -- index:10497
  Update sysdiagrams Set [definition] .Write ( 0X3200380034002C0030002C003200320039003500000020000000540061006200, Null, 0) Where diagram_id = @newid -- index:10529
  Update sysdiagrams Set [definition] .Write ( 0X6C00650056006900650077004D006F00640065003A0033000000010000000800, Null, 0) Where diagram_id = @newid -- index:10561
  Update sysdiagrams Set [definition] .Write ( 0X1E00000032002C0030002C003200380034002C0030002C003200320039003500, Null, 0) Where diagram_id = @newid -- index:10593
  Update sysdiagrams Set [definition] .Write ( 0X0000200000005400610062006C00650056006900650077004D006F0064006500, Null, 0) Where diagram_id = @newid -- index:10625
  Update sysdiagrams Set [definition] .Write ( 0X3A00340000000100000008003E00000034002C0030002C003200380034002C00, Null, 0) Where diagram_id = @newid -- index:10657
  Update sysdiagrams Set [definition] .Write ( 0X30002C0032003200390035002C00310032002C0032003700310035002C003100, Null, 0) Where diagram_id = @newid -- index:10689
  Update sysdiagrams Set [definition] .Write ( 0X31002C0031003600360035000000050000000500000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:10721
  Update sysdiagrams Set [definition] .Write ( 0X000000000000D002000006002800000041006300740069007600650054006100, Null, 0) Where diagram_id = @newid -- index:10753
  Update sysdiagrams Set [definition] .Write ( 0X62006C00650056006900650077004D006F006400650000000100000008000400, Null, 0) Where diagram_id = @newid -- index:10785
  Update sysdiagrams Set [definition] .Write ( 0X000031000000200000005400610062006C00650056006900650077004D006F00, Null, 0) Where diagram_id = @newid -- index:10817
  Update sysdiagrams Set [definition] .Write ( 0X640065003A00300000000100000008003A00000034002C0030002C0032003800, Null, 0) Where diagram_id = @newid -- index:10849
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C0032003200390035002C0031002C0031003800370035002C00, Null, 0) Where diagram_id = @newid -- index:10881
  Update sysdiagrams Set [definition] .Write ( 0X35002C0031003200340035000000200000005400610062006C00650056006900, Null, 0) Where diagram_id = @newid -- index:10913
  Update sysdiagrams Set [definition] .Write ( 0X650077004D006F00640065003A00310000000100000008001E00000032002C00, Null, 0) Where diagram_id = @newid -- index:10945
  Update sysdiagrams Set [definition] .Write ( 0X30002C003200380034002C0030002C0032003700310035000000200000005400, Null, 0) Where diagram_id = @newid -- index:10977
  Update sysdiagrams Set [definition] .Write ( 0X610062006C00650056006900650077004D006F00640065003A00320000000100, Null, 0) Where diagram_id = @newid -- index:11009
  Update sysdiagrams Set [definition] .Write ( 0X000008001E00000032002C0030002C003200380034002C0030002C0032003200, Null, 0) Where diagram_id = @newid -- index:11041
  Update sysdiagrams Set [definition] .Write ( 0X390035000000200000005400610062006C00650056006900650077004D006F00, Null, 0) Where diagram_id = @newid -- index:11073
  Update sysdiagrams Set [definition] .Write ( 0X640065003A00330000000100000008001E00000032002C0030002C0032003800, Null, 0) Where diagram_id = @newid -- index:11105
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C0032003200390035000000200000005400610062006C006500, Null, 0) Where diagram_id = @newid -- index:11137
  Update sysdiagrams Set [definition] .Write ( 0X56006900650077004D006F00640065003A00340000000100000008003E000000, Null, 0) Where diagram_id = @newid -- index:11169
  Update sysdiagrams Set [definition] .Write ( 0X34002C0030002C003200380034002C0030002C0032003200390035002C003100, Null, 0) Where diagram_id = @newid -- index:11201
  Update sysdiagrams Set [definition] .Write ( 0X32002C0032003700310035002C00310031002C00310036003600350000000600, Null, 0) Where diagram_id = @newid -- index:11233
  Update sysdiagrams Set [definition] .Write ( 0X000006000000000000003C00000001126F1801000000640062006F0000004600, Null, 0) Where diagram_id = @newid -- index:11265
  Update sysdiagrams Set [definition] .Write ( 0X4B005F0043006C0061007300730044006500660073005F0055006E0069007400, Null, 0) Where diagram_id = @newid -- index:11297
  Update sysdiagrams Set [definition] .Write ( 0X440065006600730000000000000000000000C402000000000700000007000000, Null, 0) Where diagram_id = @newid -- index:11329
  Update sysdiagrams Set [definition] .Write ( 0X060000000800000001770D2518770D250000000000000000AD0F000001000008, Null, 0) Where diagram_id = @newid -- index:11361
  Update sysdiagrams Set [definition] .Write ( 0X00000008000000000000003A00000001096F1801000000640062006F00000046, Null, 0) Where diagram_id = @newid -- index:11393
  Update sysdiagrams Set [definition] .Write ( 0X004B005F00540079007000650044006500660073005F0055006E006900740044, Null, 0) Where diagram_id = @newid -- index:11425
  Update sysdiagrams Set [definition] .Write ( 0X0065006600730000000000000000000000C40200000000090000000900000008, Null, 0) Where diagram_id = @newid -- index:11457
  Update sysdiagrams Set [definition] .Write ( 0X0000000800000001760D2518760D250000000000000000AD0F00000100000A00, Null, 0) Where diagram_id = @newid -- index:11489
  Update sysdiagrams Set [definition] .Write ( 0X00000A00000000000000440000000100270001000000640062006F0000004600, Null, 0) Where diagram_id = @newid -- index:11521
  Update sysdiagrams Set [definition] .Write ( 0X4B005F00500072006F007000650072007400790044006500660073005F004300, Null, 0) Where diagram_id = @newid -- index:11553
  Update sysdiagrams Set [definition] .Write ( 0X6C00610073007300440065006600730000000000000000000000C40200000000, Null, 0) Where diagram_id = @newid -- index:11585
  Update sysdiagrams Set [definition] .Write ( 0X0B0000000B0000000A0000000800000001780D2558780D250000000000000000, Null, 0) Where diagram_id = @newid -- index:11617
  Update sysdiagrams Set [definition] .Write ( 0XAD0F00000100000C0000000C0000000000000044000000010027000100000064, Null, 0) Where diagram_id = @newid -- index:11649
  Update sysdiagrams Set [definition] .Write ( 0X0062006F00000046004B005F005400790070006500440065006600560061006C, Null, 0) Where diagram_id = @newid -- index:11681
  Update sysdiagrams Set [definition] .Write ( 0X007500650073005F005400790070006500440065006600730000000000000000, Null, 0) Where diagram_id = @newid -- index:11713
  Update sysdiagrams Set [definition] .Write ( 0X000000C402000000000D0000000D0000000C0000000800000001770D2598770D, Null, 0) Where diagram_id = @newid -- index:11745
  Update sysdiagrams Set [definition] .Write ( 0X250000000000000000AD0F0000010000140000000A0000000100000002000000, Null, 0) Where diagram_id = @newid -- index:11777
  Update sysdiagrams Set [definition] .Write ( 0X5D000000700000000C00000003000000040000001D0000001C00000008000000, Null, 0) Where diagram_id = @newid -- index:11809
  Update sysdiagrams Set [definition] .Write ( 0X0500000003000000600000006300000006000000050000000100000029000000, Null, 0) Where diagram_id = @newid -- index:11841
  Update sysdiagrams Set [definition] .Write ( 0X2000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:11873
  Update sysdiagrams Set [definition] .Write ( 0X010003000000000000000C0000000B0000004E61BC0000000000000000000000, Null, 0) Where diagram_id = @newid -- index:11905
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:11937
  Update sysdiagrams Set [definition] .Write ( 0XDBE6B0E91C81D011AD5100A0C90F573900000200E04A4FA5B27ED00102020000, Null, 0) Where diagram_id = @newid -- index:11969
  Update sysdiagrams Set [definition] .Write ( 0X10484500000000000000000000000000000000007E0100004400610074006100, Null, 0) Where diagram_id = @newid -- index:12001
  Update sysdiagrams Set [definition] .Write ( 0X200053006F0075007200630065003D0053004500420041005300540049004500, Null, 0) Where diagram_id = @newid -- index:12033
  Update sysdiagrams Set [definition] .Write ( 0X4E002D00480050005C00530051004C0045005800500052004500530053003B00, Null, 0) Where diagram_id = @newid -- index:12065
  Update sysdiagrams Set [definition] .Write ( 0X49006E0069007400690061006C00200043006100740061006C006F0067003D00, Null, 0) Where diagram_id = @newid -- index:12097
  Update sysdiagrams Set [definition] .Write ( 0X43006F0064006500470065006E003B0049006E00740065006700720061007400, Null, 0) Where diagram_id = @newid -- index:12129
  Update sysdiagrams Set [definition] .Write ( 0X650064002000530065006300750072006900740079003D005400720075006500, Null, 0) Where diagram_id = @newid -- index:12161
  Update sysdiagrams Set [definition] .Write ( 0X3B004D0075006C007400690070006C0065004100630074006900760065005200, Null, 0) Where diagram_id = @newid -- index:12193
  Update sysdiagrams Set [definition] .Write ( 0X6500730075006C00740053006500740073003D00460061006C00730065003B00, Null, 0) Where diagram_id = @newid -- index:12225
  Update sysdiagrams Set [definition] .Write ( 0X5000610063006B00650074002000530069007A0065003D003400300039003600, Null, 0) Where diagram_id = @newid -- index:12257
  Update sysdiagrams Set [definition] .Write ( 0X3B004100700070006C00690063006100740069006F006E0020004E0061006D00, Null, 0) Where diagram_id = @newid -- index:12289
  Update sysdiagrams Set [definition] .Write ( 0X65003D0022004D006900630072006F0073006F00660074002000530051004C00, Null, 0) Where diagram_id = @newid -- index:12321
  Update sysdiagrams Set [definition] .Write ( 0X200053006500720076006500720020004D0061006E006100670065006D006500, Null, 0) Where diagram_id = @newid -- index:12353
  Update sysdiagrams Set [definition] .Write ( 0X6E0074002000530074007500640069006F002200000000800500100000004300, Null, 0) Where diagram_id = @newid -- index:12385
  Update sysdiagrams Set [definition] .Write ( 0X6F0064006500470065006E000000000226001400000043006C00610073007300, Null, 0) Where diagram_id = @newid -- index:12417
  Update sysdiagrams Set [definition] .Write ( 0X4400650066007300000008000000640062006F000000000226001A0000005000, Null, 0) Where diagram_id = @newid -- index:12449
  Update sysdiagrams Set [definition] .Write ( 0X72006F0070006500720074007900440065006600730000000800000064006200, Null, 0) Where diagram_id = @newid -- index:12481
  Update sysdiagrams Set [definition] .Write ( 0X6F00000000022600120000005400790070006500440065006600730000000800, Null, 0) Where diagram_id = @newid -- index:12513
  Update sysdiagrams Set [definition] .Write ( 0X0000640062006F000000000226001C0000005400790070006500440065006600, Null, 0) Where diagram_id = @newid -- index:12545
  Update sysdiagrams Set [definition] .Write ( 0X560061006C00750065007300000008000000640062006F000000000224001200, Null, 0) Where diagram_id = @newid -- index:12577
  Update sysdiagrams Set [definition] .Write ( 0X000055006E00690074004400650066007300000008000000640062006F000000, Null, 0) Where diagram_id = @newid -- index:12609
  Update sysdiagrams Set [definition] .Write ( 0X01000000D68509B3BB6BF2459AB8371664F0327008004E0000007B0031003600, Null, 0) Where diagram_id = @newid -- index:12641
  Update sysdiagrams Set [definition] .Write ( 0X3300340043004400440037002D0030003800380038002D003400320045003300, Null, 0) Where diagram_id = @newid -- index:12673
  Update sysdiagrams Set [definition] .Write ( 0X2D0039004600410032002D004200360044003300320035003600330042003900, Null, 0) Where diagram_id = @newid -- index:12705
  Update sysdiagrams Set [definition] .Write ( 0X310044007D000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12737
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12769
  Update sysdiagrams Set [definition] .Write ( 0X010003000000000000000C0000000B0000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12801
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12833
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12865
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12897
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12929
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12961
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:12993
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13025
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13057
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13089
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13121
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13153
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13185
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13217
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13249
  Update sysdiagrams Set [definition] .Write ( 0X0000000000000000000000000000000000000000000000000000000000000000, Null, 0) Where diagram_id = @newid -- index:13281
  Update sysdiagrams Set [definition] .Write ( 0X62885214, Null, 0) Where diagram_id = @newid -- index:13313
End Try
Begin Catch
  Delete From sysdiagrams Where diagram_id = @newid
  Print 'XxXxX ' + Error_Message() + ' XxXxX'
  Print 'XxXxX End ExportDiagram -- fix the error before running again XxXxX'
  Return
End Catch