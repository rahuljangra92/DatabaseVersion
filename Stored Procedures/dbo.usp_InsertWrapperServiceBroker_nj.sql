SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [dbo].[usp_InsertWrapperServiceBroker_nj]
  @AcctsToGo varchar(50)  
, @UserID INT  
, @StoredProcName varchar(128) 
AS
  
SET NOCOUNT ON;  
SET ANSI_WARNINGS ON;   
SET ANSI_NULLS ON;

BEGIN TRANSACTION  
  
   DECLARE @dlgHandle UNIQUEIDENTIFIER  
  
   BEGIN DIALOG CONVERSATION @dlgHandle  
    FROM SERVICE SBWrapperServiceIN  
    TO SERVICE 'SBWrapperServiceOut'  
    ON CONTRACT SBTasks   
    WITH ENCRYPTION=OFF;
  
   DECLARE @ProcessSQL XML  
  
   SET @ProcessSQL = (  
   SELECT @AcctsToGo AS AcctsToGo  
   , @UserID AS UserID  
   , @StoredProcName AS StoredProcName  
   FOR XML RAW ('ProcessSQL'), ELEMENTS);  
  
   --Put conversation on que.  
   SEND ON CONVERSATION @dlgHandle MESSAGE TYPE CallSP (@ProcessSQL);  
   END CONVERSATION @dlgHandle;  
  
  COMMIT TRANSACTION  
GO
