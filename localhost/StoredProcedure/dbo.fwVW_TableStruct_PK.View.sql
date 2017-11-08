USE [USGROUP]
GO
/****** Object:  View [dbo].[fwVW_TableStruct_PK]    Script Date: 09/21/2011 17:26:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- ===============================================================================================================
-- Author: Benjamin ( 2011-06-29 )   QQ: 664722420   MSN: benjayung@hotmail.com   Email: benjayung@hotmail.com
-- ALTER date: 2011-06-29
-- 说明: 视图查询主键字段
-- ===============================================================================================================
create view [dbo].[fwVW_TableStruct_PK]
as 
  select *
  from fwfn_table2('PrimaryKey', '')
GO
