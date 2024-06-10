CREATE TABLE [dbo].[Tbl_RawData]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Data1] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Data2] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Data3] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IsProcessed] [bit] NULL CONSTRAINT [DF_Tbl_RawData_IsProcessed] DEFAULT ((0)),
[ReceivedOn] [datetime] NULL CONSTRAINT [DF_RawData_ReceivedOn] DEFAULT (getdate()),
[ProcessedOn] [datetime] NULL
) ON [PRIMARY]
GO
