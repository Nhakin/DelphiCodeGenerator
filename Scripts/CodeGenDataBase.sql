USE [CodeGen]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ClassDefs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUnitDef] [int] NULL,
	[Position] [int] NULL,
	[ClassName] [varchar](35) NULL,
	[UseInterface] [bit] NULL,
	[UseCustomClass] [bit] NULL,
	[MakeList] [bit] NULL,
	[TrackChange] [bit] NULL,
	[DataSourceType] [int] NULL,
	[AdoQueryClassName] [varchar](35) NULL,
	[TableName] [varchar](128) NULL,
 CONSTRAINT [PK_ClassDefs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PropertyDefs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdClassDef] [int] NULL,
	[Position] [int] NULL,
	[PropertyName] [varchar](35) NULL,
	[PropertyType] [int] NULL,
	[IsDataAware] [bit] NULL,
	[IsReadOnly] [bit] NULL,
	[PropertyClass] [varchar](35) NULL,
	[InterfaceName] [varchar](35) NULL,
	[InterfaceImplementor] [varchar](35) NULL,
	[IsId] [bit] NULL,
	[FieldName] [varchar](128) NULL,
	[MaxLen] [int] NULL,
 CONSTRAINT [PK_PropertyDefs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TypeDefs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUnitDef] [int] NULL,
	[Position] [int] NULL,
	[TypeDefType] [int] NULL,
	[TypeDefName] [varchar](25) NULL,
 CONSTRAINT [PK_TypeDefs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TypeDefValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTypeDef] [int] NULL,
	[Position] [int] NULL,
	[TypeDefValueType] [int] NULL,
	[TypeDefValue] [varchar](50) NULL,
 CONSTRAINT [PK_TypeDefValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[UnitDefs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [varchar](35) NULL,
 CONSTRAINT [PK_UnitDefs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ClassDefs]  WITH CHECK ADD  CONSTRAINT [FK_ClassDefs_UnitDefs] FOREIGN KEY([IdUnitDef])
REFERENCES [dbo].[UnitDefs] ([Id])
GO

ALTER TABLE [dbo].[ClassDefs] CHECK CONSTRAINT [FK_ClassDefs_UnitDefs]
GO

ALTER TABLE [dbo].[PropertyDefs]  WITH CHECK ADD  CONSTRAINT [FK_PropertyDefs_ClassDefs] FOREIGN KEY([IdClassDef])
REFERENCES [dbo].[ClassDefs] ([Id])
GO

ALTER TABLE [dbo].[PropertyDefs] CHECK CONSTRAINT [FK_PropertyDefs_ClassDefs]
GO

ALTER TABLE [dbo].[TypeDefs]  WITH CHECK ADD  CONSTRAINT [FK_TypeDefs_UnitDefs] FOREIGN KEY([IdUnitDef])
REFERENCES [dbo].[UnitDefs] ([Id])
GO

ALTER TABLE [dbo].[TypeDefs] CHECK CONSTRAINT [FK_TypeDefs_UnitDefs]
GO

ALTER TABLE [dbo].[TypeDefValues]  WITH CHECK ADD  CONSTRAINT [FK_TypeDefValues_TypeDefs] FOREIGN KEY([IdTypeDef])
REFERENCES [dbo].[TypeDefs] ([Id])
GO

ALTER TABLE [dbo].[TypeDefValues] CHECK CONSTRAINT [FK_TypeDefValues_TypeDefs]
GO
