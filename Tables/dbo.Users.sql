CREATE TABLE [dbo].[Users]
(
[UserId] [int] NOT NULL,
[UserFirstName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[UserLastName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[UserName] [varchar] (50) COLLATE Latin1_General_CI_AS NULL,
[IsActive] [int] NULL
) ON [PRIMARY]
GO
