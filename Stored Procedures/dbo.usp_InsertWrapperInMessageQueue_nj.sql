SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [dbo].[usp_InsertWrapperInMessageQueue_nj]
  @AcctsToGo varchar(50)  
, @UserID INT  
, @StoredProcName varchar(128) 
AS
  
SET NOCOUNT ON;  
SET ANSI_WARNINGS ON;   
SET ANSI_NULLS ON;

BEGIN TRANSACTION  
  
 
   DECLARE @ProcessSQL XML  
  
   SET @ProcessSQL = (  
   SELECT @AcctsToGo AS AcctsToGo  
   , @UserID AS UserID  
   , @StoredProcName AS StoredProcName  
   FOR XML RAW ('ProcessSQL'), ELEMENTS);  
  
   --Put conversation on queue.  
   INSERT [dbo].[MessageQueue] ([Message]) VALUES(@ProcessSQL)
 
  
  COMMIT TRANSACTION  
GO
