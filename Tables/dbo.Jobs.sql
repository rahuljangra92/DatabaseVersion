CREATE TABLE [dbo].[Jobs]
(
[Id] [int] NULL,
[Job] [nchar] (10) COLLATE Latin1_General_CI_AS NULL,
[IsExecuted] [nchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Executiontime] [datetime] NULL
) ON [PRIMARY]
GO
