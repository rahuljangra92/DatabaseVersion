CREATE TABLE [HangFire].[List]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[Key] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Value] [nvarchar] (max) COLLATE Latin1_General_CI_AS NULL,
[ExpireAt] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [HangFire].[List] ADD CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED ([Key], [Id]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List] ([ExpireAt]) WHERE ([ExpireAt] IS NOT NULL) ON [PRIMARY]
GO
