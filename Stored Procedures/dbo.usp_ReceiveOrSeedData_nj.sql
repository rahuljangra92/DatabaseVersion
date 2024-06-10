SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [dbo].[usp_ReceiveOrSeedData_nj]
AS
declare @accid int=1
,@total_accids int=12

WHILE(@accid<=@total_accids)
BEGIN

DECLARE @i INT;
DECLARE @j INT;
DECLARE @Amount1 decimal(18,2)
DECLARE @Amount2 decimal(18,2)
SET @i = 1;
SET @j = 12;
select @Amount1=FLOOR(@i + RAND()*(@j-@i));
select @Amount2=FLOOR(@i + RAND()*(@j-@i));

INSERT [dbo].[Tbl_RawData]
(Data1, Data2, Data3) 
Values
(@accid,@Amount1,@Amount2)
SET @accid=@accid+1
END
SELECT 'Raw data generated'

GO
