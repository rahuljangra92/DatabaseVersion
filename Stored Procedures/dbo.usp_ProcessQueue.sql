SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[usp_ProcessQueue]
AS
declare @queue_type int
select @queue_type= [QueueType] from [dbo].[QueueConfig]
--SELECT @queue_type
IF(@queue_type=1)-- SERVICE BROKER QUEUE
EXEC [dbo].[WrapperSerializedByProcessId_nj]
ELSE IF(@queue_type=2)-- Message QUEUE
EXEC [dbo].[WrapperSerializedByProcessId_FromMessageQueue_nj]
GO
