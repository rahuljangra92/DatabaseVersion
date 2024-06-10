SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[WrapperSerializedByProcessId_nj]
AS
DECLARE @message_body XML;  
DECLARE @message_type_name VARCHAR(130)  
DECLARE @ConversationGroup UNIQUEIDENTIFIER  
DECLARE @Conversation_Handle UNIQUEIDENTIFIER  
  
DECLARE @ProcessID INT;  
DECLARE @ConversationHandle UNIQUEIDENTIFIER;  
DECLARE @result INT;  
DECLARE @Rows INT;  
DECLARE @Error INT;  
  
  WHILE (1=1)  
  BEGIN  
  
-- BEGIN TRANSACTION;  
    
   WAITFOR  
   (RECEIVE TOP (1)   
   @message_type_name = message_type_name  
   , @message_body = CAST(message_body AS XML)  
   , @Conversation_Handle = conversation_handle            
   FROM dbo.SBWorkFlow  
      ), TIMEOUT 5000;   
   
   IF (@@ROWCOUNT = 0)   
   BEGIN   
--     ROLLBACK TRANSACTION;   
     BREAK;   
   END   
   
  IF @message_type_name = 'CallSP'  
       BEGIN  
  
--Log Call before executing  
        INSERT ExecutionLog  
        (SQLText,Userid,AcctsToGo,BeginDate)  
        SELECT MB.onerow.value('(//StoredProcName)[1]','varchar(100)')+' @UserID = '+ MB.onerow.value('(//UserID)[1]','varchar(20)')+', @AcctsToGo = '''+MB.onerow.value('(//AcctsToGo)[1]','varchar(50)')+''''   
            ,MB.onerow.value('(//UserID)[1]','varchar(20)')  
            ,MB.onerow.value('(//AcctsToGo)[1]','varchar(50)')  
            ,getdate()  
        FROM @message_body.nodes('//ProcessSQL') AS MB(onerow);  
  
--Exec the Stored Procedure  
        DECLARE @SQLString varchar(max)  
        SELECT @SQLString = MB.onerow.value('(//StoredProcName)[1]','varchar(100)')+' @UserID = '+ MB.onerow.value('(//UserID)[1]','varchar(20)')+', @AcctsToGo = '''+MB.onerow.value('(//AcctsToGo)[1]','varchar(50)')+''''   
                          FROM @message_body.nodes('//ProcessSQL') AS MB(onerow);  
        EXEC (@SQLString)    
 --Log Finish Time and Success  
        UPDATE ExecutionLog  
        SET EndDate = getdate()  
        ,SuccessFlag = 1  
        WHERE ExecutionLogID = SCOPE_IDENTITY()  
         END CONVERSATION @ConversationHandle;  
       END  
  
      ELSE IF @message_type_name =   
      N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog'  
       BEGIN  
         END CONVERSATION @ConversationHandle;  
       END  
  
      ELSE IF @message_type_name =  
      N'http://schemas.microsoft.com/SQL/ServiceBroker/Error'   
  
       BEGIN  
         END CONVERSATION @ConversationHandle;  
       END  
        
--      COMMIT TRANSACTION;  
         
    END  
GO
