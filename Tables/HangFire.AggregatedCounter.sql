CREATE TABLE [HangFire].[AggregatedCounter]
(
[Key] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Value] [bigint] NOT NULL,
[ExpireAt] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [HangFire].[AggregatedCounter] ADD CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED ([Key]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt] ON [HangFire].[AggregatedCounter] ([ExpireAt]) WHERE ([ExpireAt] IS NOT NULL) ON [PRIMARY]
GO
