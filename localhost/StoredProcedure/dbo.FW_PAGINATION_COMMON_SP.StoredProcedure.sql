USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_PAGINATION_COMMON_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Richard       QQ: 1055210005       MSN: richard@diygens.com       Email: richard@diygens.com       WebSite: http://frame.diygens.com
-- Create date: 2011-08-09
-- Description: 通用分页   存储过程
-- Exmaple:
-- 	调用表:		exec FW_PAGINATION_COMMON_SP 'select * from FW_USER' ,1 ,18
--	调用存储过程:	exec FW_PAGINATION_COMMON_SP 'exec FW_USER_SP @Option=''list'' ' ,1 ,18
-- =============================================
CREATE procedure [dbo].[FW_PAGINATION_COMMON_SP](@sqlstr varchar(8000) -- 查询字符串
	,@currentpage int	-- 第N页
	,@pagesize int		-- 每页行数
) as
begin
	set nocount on
	declare @rowcount int ,@P1 int --P1是游标的id
	exec sp_cursoropen @P1 output,@sqlstr,@scrollopt=1,@ccopt=1,@rowcount=@rowcount output
	select ceiling(1.0*@rowcount/@pagesize) as PageCount ,@rowcount as RowsCount ,@currentpage as PageIndex 
	set @currentpage=(@currentpage-1)*@pagesize+1
	exec sp_cursorfetch @P1,16,@currentpage,@pagesize 
	exec sp_cursorclose @P1
	set nocount off
end
GO
