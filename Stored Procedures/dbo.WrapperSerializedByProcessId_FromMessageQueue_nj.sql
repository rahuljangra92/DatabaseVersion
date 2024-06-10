SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[WrapperSerializedByProcessId_FromMessageQueue_nj]
AS
DECLARE @message_body XML;  
DECLARE @message_id int;
DECLARE @ExecutionLogId bigint
 
-- BEGIN TRANSACTION;  
WHILE (1=1)  
BEGIN    
SELECT TOP 1 @message_id=[Id], @message_body = CAST([Message] AS XML)
FROM dbo.MessageQueue where InProcess=0  ORDER BY id 

   IF (@@ROWCOUNT = 0)   
   BEGIN   
--     ROLLBACK TRANSACTION;   
     BREAK;   
   END   

    Update dbo.MessageQueue set InProcess=1 where id=@message_id
--Log Call before executing  
        INSERT ExecutionLog  
        (SQLText,Userid,AcctsToGo,BeginDate)  
        SELECT MB.onerow.value('(//StoredProcName)[1]','varchar(100)')+' @UserID = '+ MB.onerow.value('(//UserID)[1]','varchar(20)')+', @AcctsToGo = '''+MB.onerow.value('(//AcctsToGo)[1]','varchar(50)')+''''   
            ,MB.onerow.value('(//UserID)[1]','varchar(20)')  
            ,MB.onerow.value('(//AcctsToGo)[1]','varchar(50)')  
            ,getdate()  
        FROM @message_body.nodes('//ProcessSQL') AS MB(onerow);  
       set @ExecutionLogId=SCOPE_IDENTITY();
--Exec the Stored Procedure  
        DECLARE @SQLString varchar(max)  
        SELECT @SQLString = MB.onerow.value('(//StoredProcName)[1]','varchar(100)')+' @UserID = '+ MB.onerow.value('(//UserID)[1]','varchar(20)')+', @AcctsToGo = '''+MB.onerow.value('(//AcctsToGo)[1]','varchar(50)')+''''+', @ExecutionLogId ='+ ltrim(str(@ExecutionLogId))+''    
        FROM @message_body.nodes('//ProcessSQL') AS MB(onerow);
        EXEC(@SQLString)    
 --Log Finish Time and Success  
        UPDATE ExecutionLog  
        SET EndDate = getdate()  
        ,SuccessFlag = 1  
        WHERE ExecutionLogID =@ExecutionLogId
 -- Clear Message Queue
        delete from [dbo].[MessageQueue] where id=@message_id
--      COMMIT TRANSACTION;
END
GO
