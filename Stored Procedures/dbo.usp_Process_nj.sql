SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[usp_Process_nj]
  @UserID int,  
  @AcctsToGo varchar(50) = ''
  ,@ExecutionLogID bigint
AS

  WAITFOR DELAY '00:00:05';

  Update dbo.executionlog   
  Set ProcessingStep = 'Stage 1 - Initialize',  
  ProcessingStepTime = getdate()  
  from dbo.executionlog   
  where ExecutionlogID = @ExecutionLogID  

  WAITFOR DELAY '00:00:05';

  Update dbo.executionlog   
  Set ProcessingStep = 'Stage 2 - Stage data check',  
  ProcessingStepTime = getdate()  
  from dbo.executionlog   
  where ExecutionlogID = @ExecutionLogID  

  WAITFOR DELAY '00:00:05';

  Update dbo.executionlog   
  Set ProcessingStep = 'Stage 3 - Data Validation',  
  ProcessingStepTime = getdate()  
  from dbo.executionlog   
  where ExecutionlogID = @ExecutionLogID  

  Declare @ReconDateTime datetime 
/*
  Declare @ExecutionLogID int  
 
 
  ;With cTop as (  
      select Ranking  = Dense_Rank () Over (Partition by UserID Order by BeginDate desc)  
       , *   
      from dbo.ExecutionLog e with (NOLOCK)  
       where SQLText like  '%[usp_Process]%'   
         and e.UserID = @UserID   
         and e.AcctsToGo=@AcctsToGo  
         and e.EndDate is null  
  
  )  
   Select @ExecutionLogID = ExecutionLogID,   
     @ReconDateTime =BeginDate   
      from ctop   
      where Ranking = 1  
  */
  Select @ReconDateTime =BeginDate   
  from  dbo.ExecutionLog e with (NOLOCK)     
  where ExecutionLogID = @ExecutionLogID

  IF NOT EXISTS (  
    select *   
    from dbo.ExecutionLog  el  
    where EndDate is null   
    and UserID = @UserID   
    and el.ExecutionLogID <>@ExecutionLogID  
    )  
  
  Begin  



   WAITFOR DELAY '00:00:05';

  Update dbo.executionlog   
  Set ProcessingStep = 'Stage 4 - Data Processing to main table',  
  ProcessingStepTime = getdate()  
  from dbo.executionlog   
  where ExecutionlogID = @ExecutionLogID  

  INSERT [dbo].[Tbl_ProcessedData](AccountId, CashAtBank, UserId)
  SELECT AccountId, TotalAmount, UserId FROM [dbo].[Tbl_StagingData] WHERE UserId=@UserId

  WAITFOR DELAY '00:00:05';

  Update dbo.executionlog   
  Set ProcessingStep = 'Stage 5 - Final process/data clean up',  
  ProcessingStepTime = getdate()  
  from dbo.executionlog   
  where ExecutionlogID = @ExecutionLogID 

  delete FROM [dbo].[Tbl_StagingData] WHERE UserId=@UserId

  WAITFOR DELAY '00:00:05';

 Update dbo.executionlog   
  Set ProcessingStep = 'Update Acct Processing List',  
  --EndDate=getdate(),
  ProcessingStepTime = getdate()  
  from dbo.executionlog   
  where ExecutionlogID = @ExecutionLogID  

  END
GO
