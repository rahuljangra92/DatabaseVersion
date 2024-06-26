SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[sp_getUser]
as
select TOP 1 * from DemoTable1
GO
