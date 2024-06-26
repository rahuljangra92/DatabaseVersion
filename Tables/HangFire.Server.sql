CREATE TABLE [HangFire].[Server]
(
[Id] [nvarchar] (200) COLLATE Latin1_General_CI_AS NOT NULL,
[Data] [nvarchar] (max) COLLATE Latin1_General_CI_AS NULL,
[LastHeartbeat] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [HangFire].[Server] ADD CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED ([Id]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat] ON [HangFire].[Server] ([LastHeartbeat]) ON [PRIMARY]
GO
