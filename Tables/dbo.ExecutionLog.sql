CREATE TABLE [dbo].[ExecutionLog]
(
[ExecutionLogID] [int] NOT NULL IDENTITY(1, 1),
[SQLText] [varchar] (max) COLLATE Latin1_General_CI_AS NULL,
[UserID] [int] NULL,
[AcctsToGo] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[BeginDate] [datetime] NULL CONSTRAINT [DF_ExecutionLog_BeginDate] DEFAULT (getdate()),
[EndDate] [datetime] NULL,
[SuccessFlag] [int] NULL,
[ProcessingStep] [varchar] (100) COLLATE Latin1_General_CI_AS NULL,
[ProcessingStepTime] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExecutionLog] ADD CONSTRAINT [PK_ExecutionLog] PRIMARY KEY CLUSTERED ([ExecutionLogID]) ON [PRIMARY]
GO
