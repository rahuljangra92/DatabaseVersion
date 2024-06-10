CREATE TABLE [dbo].[MessageQueue]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Message] [xml] NULL,
[InsertedOn] [datetime] NULL CONSTRAINT [DF_MessageQueue_InsertedOn] DEFAULT (getdate()),
[InProcess] [int] NULL CONSTRAINT [DF_MessageQueue_InProcess] DEFAULT ((0))
) ON [PRIMARY]
GO
