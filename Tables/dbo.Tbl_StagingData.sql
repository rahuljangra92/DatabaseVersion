CREATE TABLE [dbo].[Tbl_StagingData]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[AccountId] [int] NULL,
[TotalAmount] [decimal] (18, 2) NULL,
[ReceivedOn] [datetime] NOT NULL CONSTRAINT [DF_Tbl_StagingData_StartProcessingOn] DEFAULT (getdate()),
[IsProcessed] [int] NULL CONSTRAINT [DF_Tbl_StagingData_IsProcessed] DEFAULT ((0)),
[UserId] [int] NULL
) ON [PRIMARY]
GO
