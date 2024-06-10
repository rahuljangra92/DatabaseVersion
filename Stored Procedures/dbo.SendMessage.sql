SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[SendMessage]    
 @NotificationMessage nvarchar(100)   
,@SubmittedById int=1
,@SubmittedToId int=2
As    
declare @ID int  
  
INSERT into Notification (NotificationType,NotificationMessage,[SubmittedById],[SubmittedToId],[SubmittedOn],[Status])     
VALUES (1,@NotificationMessage,@SubmittedById,@SubmittedToId,getdate(),0)     
  
SET @ID= SCOPE_IDENTITY()    
  
  
Select  @ID Id,'Message Sent' Msg
GO
