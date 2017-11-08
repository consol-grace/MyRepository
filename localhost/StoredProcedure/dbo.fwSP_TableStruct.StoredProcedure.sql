USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fwSP_TableStruct]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- ===============================================================================================================
-- Author: Benjamin ( 2011-06-29 )   QQ: 664722420   MSN: benjayung@hotmail.com   Email: benjayung@hotmail.com
-- ALTER date: 2011-06-29
-- 说明: FwFn_Table2附加的源素,快速寫入表名,給FwFn_Table2使用
-- ===============================================================================================================
create procedure [dbo].[fwSP_TableStruct]
  @TableName nvarchar(50)
as
begin
  delete from fwTB_TableStruct
  insert into fwTB_TableStruct values (coalesce(@TableName, ''))
end
GO
