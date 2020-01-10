Create View vwColDefs As
Select Row_Number() Over (Order By st.Name, sc.Column_Id)RowId, sc.Column_Id ColId, ss.Name SchemaName,  st.Name TableName, sc.Name FieldName,
  Case When sc.System_Type_Id In (167, 231) Then sc.Max_Length Else 0 End MaxLen,
  Case 
    When sc.System_Type_Id In (52, 56, 127) Then 
	  Case When Is_Identity = 1 Then 'ptAutoInc' Else 'ptInteger' End
    When sc.System_Type_Id In (35, 167, 231) Then 'ptString'
    When sc.System_Type_Id In (40, 58, 61) Then 'ptDateTime'
    When sc.System_Type_Id = 62 Then 'ptDouble'
    When sc.System_Type_Id = 104 Then 'ptBoolean'
    When sc.System_Type_Id = 60 Then 'ptCurrency'
    When sc.System_Type_Id = 175 Then 'ptChar'
    When sc.System_Type_Id = 36 Then 'ptGUID'
    Else 'ptVariant'
  End FieldType,
  Case When IsNull(IsPk, 0) > 0 Then Cast(1 As Bit) Else Cast(0 As Bit) End IsPrimaryKey
From sys.Columns sc
Inner Join sys.Tables st On st.Object_Id = sc.Object_Id
Inner Join sys.Schemas ss On ss.Schema_Id = st.Schema_Id
Cross Apply (
  Select Count(*)IsPk
  From sys.key_constraints sk
  Cross Apply (
    Select *
    From sys.index_columns si
    Where si.Object_Id = sk.Parent_Object_Id And si.Index_Id = sk.Unique_Index_Id
  ) si
  Where sk.Parent_Object_Id = st.Object_Id And si.Column_Id = sc.Column_Id
)pk
Where st.Name <> 'SysDiagrams'