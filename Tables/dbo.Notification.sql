CREATE TABLE [dbo].[Notification]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[NotificationType] [int] NULL,
[NotificationMessage] [nvarchar] (150) COLLATE Latin1_General_CI_AS NULL,
[SubmittedById] [int] NULL,
[SubmittedToId] [int] NULL,
[SubmittedOn] [datetime] NULL CONSTRAINT [DF_Notification_SubmittedOn] DEFAULT (getdate()),
[Status] [int] NULL
) ON [PRIMARY]
GO
