SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[usp_PopulateProcessing_nj]
@UserId int
AS

IF NOT EXISTS (  
select * from dbo.ExecutionLog e with (NOLOCK)   
where ISNULL(EndDate,'')='' and e.UserID = @UserID )   
BEGIN
	declare @queue_type int
	select @queue_type= [QueueType] from [dbo].[QueueConfig]

	IF(@queue_type=1)--SERVICE BROKER QUEUE
	BEGIN  
	EXEC [Alerts].[dbo].[usp_InsertWrapperServiceBroker_nj] @AcctsToGo = '', @UserID=@UserID, @StoredProcName = '[Alerts].[dbo].[usp_Process_nj]';  
	END
	ELSE IF(@queue_type=2) -- MESSAGE QUEUE
	BEGIN
	EXEC [Alerts].[dbo].[usp_InsertWrapperInMessageQueue_nj] @AcctsToGo = '', @UserID=@UserID, @StoredProcName = '[Alerts].[dbo].[usp_Process_nj]';  
	END
SELECT 'Populate Processing Running'
END
ELSE
BEGIN
SELECT 'Populate Processing ALREADY Running'
END
GO
