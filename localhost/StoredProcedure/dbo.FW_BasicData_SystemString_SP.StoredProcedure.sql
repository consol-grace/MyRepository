USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_SystemString_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[FW_BasicData_SystemString_SP]
		
		@Option nvarchar(30)='List'		
AS
BEGIN
		if(@Option = 'List')
		begin
			 select cfg_ROWID ,cfg_Code ,cfg_value ,cfg_Type from  cs_SystemString order by cfg_ROWID
		end
END
GO
