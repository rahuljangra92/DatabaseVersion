SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[usp_TLP_List_Create_All_nj]
@UserId int,  
@AcctIDs VARCHAR(8000) = ''
AS
DECLARE @Response varchar(50)

IF NOT EXISTS ( 
   select * from dbo.ExecutionLog e with (NOLOCK)   
    where isnull(EndDate,'')=''   
      and e.UserID = @UserId  
   )   
  
BEGIN  
    IF(@userId=1)
	BEGIN
	 INSERT [dbo].[Tbl_StagingData] ([AccountId],[TotalAmount],[userId])
     SELECT CAST(Data1 AS INT),CAST(Data2 AS DECIMAL(18,2))+CAST(Data3 AS DECIMAL(18,2)),@userID FROM [dbo].[Tbl_RawData] WHERE Data1 in (1,2,3)
	 DELETE FROM [dbo].[Tbl_RawData] WHERE Data1 in (1,2,3)
	 END
	IF(@userId=2)
	BEGIN
	 INSERT [dbo].[Tbl_StagingData] ([AccountId],[TotalAmount],[userId])
     SELECT CAST(Data1 AS INT),CAST(Data2 AS DECIMAL(18,2))+CAST(Data3 AS DECIMAL(18,2)),@userID FROM [dbo].[Tbl_RawData] WHERE Data1 in (4,5,6)
	 DELETE FROM [dbo].[Tbl_RawData] WHERE Data1 in (4,5,6)
	END
	IF(@userId=3)
	BEGIN
	 INSERT [dbo].[Tbl_StagingData] ([AccountId],[TotalAmount],[userId])
     SELECT CAST(Data1 AS INT),CAST(Data2 AS DECIMAL(18,2))+CAST(Data3 AS DECIMAL(18,2)),@userID FROM [dbo].[Tbl_RawData] WHERE Data1 in (7,8,9)
	 DELETE FROM [dbo].[Tbl_RawData] WHERE Data1 in (7,8,9)
	END
	IF(@userId=4)
	BEGIN
	 INSERT [dbo].[Tbl_StagingData] ([AccountId],[TotalAmount],[userId])
     SELECT CAST(Data1 AS INT),CAST(Data2 AS DECIMAL(18,2))+CAST(Data3 AS DECIMAL(18,2)),@userID FROM [dbo].[Tbl_RawData] WHERE Data1 in (10,11,12)
	 DELETE FROM [dbo].[Tbl_RawData] WHERE Data1 in (10,11,12)
	END

	SET @Response='All data moved into staged table for this user'
END
ELSE
BEGIN
	SET @Response='No new data to process for this user'
END

SELECT @Response Response
GO
