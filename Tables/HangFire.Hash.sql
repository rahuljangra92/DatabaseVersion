CREATE TABLE [HangFire].[Hash]
(
[Key] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Field] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Value] [nvarchar] (max) COLLATE Latin1_General_CI_AS NULL,
[ExpireAt] [datetime2] NULL
) ON [PRIMARY]
GO
ALTER TABLE [HangFire].[Hash] ADD CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED ([Key], [Field]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash] ([ExpireAt]) WHERE ([ExpireAt] IS NOT NULL) ON [PRIMARY]
GO
