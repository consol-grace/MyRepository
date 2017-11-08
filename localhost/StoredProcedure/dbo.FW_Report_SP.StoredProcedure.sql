USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_Report_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FW_Report_SP] 
		
	@Option nvarchar(30)='',
	@No nvarchar(100)=''	
AS
BEGIN
	 Create table #aa(a nvarchar(500),b nvarchar(200),c nvarchar(30))
	 if(@Option='test')
	 begin
	    insert into #aa(a,b)
		select top 100 co_name as [text],co_code as [value] from cs_company where co_active = 1  and co_companykind = 'BASE'
	 end
	 
	 if(@Option='test1')
	 begin
	    insert into #aa(a,b)
		select  top 25 unt_Code as FieldText, unt_Code as FieldValue from cs_Unit where unt_Active =1
	 end
	 if(@Option='test2')
	 begin
	    insert into #aa(a,b)
		select  top 25 unt_Code as FieldText, unt_Code as FieldValue from cs_Unit where unt_Active =1
	 end
	 select * from 	#aa	 
END
GO
