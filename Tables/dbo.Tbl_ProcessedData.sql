CREATE TABLE [dbo].[Tbl_ProcessedData]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[AccountId] [int] NULL,
[PreviousBalance] [decimal] (18, 2) NULL,
[CashAtBank] [decimal] (18, 2) NULL,
[ReceivedOn] [datetime] NULL CONSTRAINT [DF_ProcessedData_ReceivedOn] DEFAULT (getdate()),
[UserId] [int] NULL
) ON [PRIMARY]
GO
