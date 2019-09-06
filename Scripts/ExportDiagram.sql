Create Procedure [dbo].[ExportDiagram](
  @Name VarChar(128) = Null
)
As
Begin
  Declare @diagram_id Int
  Declare @index Int
  Declare @size Int
  Declare @chunk Int
  Declare @line VarChar(Max)
  -- Set start index, and chunk 'constant' value
  Set @index = 1
  Set @chunk = 32    -- values that work: 2, 6 -- values that fail: 15, 16, 64

  If @name Is Null 
  Begin
    Print 'WARNING! Stored Procedure was called without defined @Name parameter WARNING! ' + CHAR(10)+
    'Please call one of following TSQL to export a specific diagram' + CHAR(10)

    Declare @cnt Int
    Declare @cntMax Int

    Select @cnt=1, @cntMax = Count(*) From dbo.sysdiagrams

    Declare @y nvarchar(100)
    While @cnt <= @cntMax
    Begin --While Loop
      WITH AbfrageLoop AS (Select row_number() OVER (ORDER BY diagram_id) AS Row, * From  dbo.sysdiagrams)
        Select @y=name 
        From AbfrageLoop 
        Where Row=@cnt

      --do something based on the query
      Print 'Exec ExportDiagram @Name = ' + @y

      Select @cnt = @cnt+1
    End --While Loop
    
    Return (-1)
  End

  -- Get PK diagram_id using the diagram's name (which Is what the user Is familiar with)    
  Select @diagram_id=diagram_id, @size=DATALENGTH(definition) 
  From dbo.sysdiagrams  
  Where [name] = @name     
   
  If @diagram_id Is Null   
    Print '/**<error>Diagram name [' + @name + '] could not be found.</error>*/'
  Else -- Diagram exists
  Begin  -- Now with the diagram_id, do all the work
    Print '/**'
    Print '<summary>Restore diagram ''' + @name + '''</summary>'
    Print '<generated>' + LEFT(CONVERT(VARCHAR(23), GETDATE(), 121), 16) + '</generated>'
    Print '*/'

    Print 'Print ''=== ExportDiagram restore diagram [' + @name + '] ==='''
    Print 'If Not Exists (Select * From INFORMATION_SCHEMA.TABLES Where TABLE_NAME = ''sysdiagrams'')
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

  Exec sys.sp_addextEndedproperty @name=N''microsoft_database_tools_support'', @value=1 , @level0type=N''SCHEMA'',@level0name=N''dbo'', @level1type=N''TABLE'',@level1name=N''sysdiagrams''
End

'
    Print 'Set NoCount On'
    Print 'Declare @newid Int'
    Print 'Declare @DiagramSuffix VarChar(50)'        
    Print ''        
    Print 'Print ''Suffix diagram name with date, to ensure uniqueness'''            
    Print 'Set @DiagramSuffix = '' '' + LEFT(CONVERT(VARCHAR(23), GETDATE(), 121), 16)'        
    Print ''        
    Print 'Print ''Create row for new diagram'''       
    -- Output the INSERT that _creates_ the diagram record, with a non-Null [definition],        
    -- important because .WRITE *cannot* be called against a Null value (in the While loop)       
    -- so we insert 0x so that .WRITE has 'something' to appEnd to…        
    Print 'Begin Try'       
    Print '  Print ''Write diagram ' + @name + ' into new row (and get [diagram_id])'''        

    Select @line = '  Insert Into sysdiagrams ([name], [principal_id], [version], [definition])' +
      ' Values (''' + [name] + '''+@DiagramSuffix, ' + CAST (principal_id AS VARCHAR(100)) + ', ' +
      Cast(version AS VarChar(100)) + ', 0x)'
    From dbo.sysdiagrams 
    Where diagram_id = @diagram_id        
    
    Print @line        
    Print '  Set @newid = SCOPE_IDENTITY()'        
    Print 'End Try'        
    Print 'Begin Catch'        
    Print '  Print ''XxXxX '' + Error_Message() + '' XxXxX'''        
    Print '  Print ''XxXxX End ExportDiagram -- fix the error before running again XxXxX'''        
    Print '  Return'        
    Print 'End Catch'        
    Print ''        
    Print 'Print ''Now add all the binary data...'''        
    Print 'Begin Try'        
        
    While @index < @size       
    Begin           
      -- Output as many UPDATE statements as required to appEnd all the diagram binary
      -- data, represented as hexadecimal strings
      Select @line = '  Update sysdiagrams Set [definition] .Write ( ' +
        Upper(sys.fn_varbintohexstr(SubString(definition, @index, @chunk))) +
        ', Null, 0) Where diagram_id = @newid -- index:' + Cast(@index As VarChar(100))
      From sysdiagrams             
      Where diagram_id = @diagram_id

      Print @line
      Set @index = @index + @chunk
    End

    Print 'End Try'
    Print 'Begin Catch'
    Print '  Delete From sysdiagrams Where diagram_id = @newid'
    Print '  Print ''XxXxX '' + Error_Message() + '' XxXxX'''
    Print '  Print ''XxXxX End ExportDiagram -- fix the error before running again XxXxX'''
    Print '  Return'
    Print 'End Catch'
  End
End 