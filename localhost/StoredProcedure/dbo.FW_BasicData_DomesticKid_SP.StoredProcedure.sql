USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_DomesticKid_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		<Author,Micro>
-- Create date: <Create Date, 2011-08-26>
-- Description:	<Description, FW_BasicData_DomesticKid_SP基本信息管理>
-- =============================================
CREATE PROCEDURE  [dbo].[FW_BasicData_DomesticKid_SP]
	
	@Option nvarchar(30)='List',
	@dk_ROWID int=0,
	@dk_ID int=0,
	@dk_STAT nvarchar(12)='',
	@dk_SYS  nvarchar(2)='',
	@dk_Code  nvarchar(6)='',
	@dk_Short nvarchar(10)='',
	@dk_Description nvarchar(20)='',
	@dk_Active bit=0,
	@dk_CrDate datetime=null,
	@dk_LstDate datetime =null,
	@dk_User nvarchar(12)=''
		
AS
BEGIN
	
	if(@Option='List')
	begin
		select dk_ROWID ,dk_Code,dk_Short,dk_Description ,dk_Active from cs_DomesticKind order by dk_ROWID ASC
	end
	
	if(@Option='single')
	begin
		select dk_ROWID ,dk_Code,dk_Short,dk_Description ,dk_Active from cs_DomesticKind where dk_ROWID=@dk_ROWID
	end
	
	if(@Option ='AddModify')
	begin
			   --Modify
		if(exists (select 1 from cs_DomesticKind where dk_ROWID=@dk_ROWID))
		begin 
			 update cs_DomesticKind set dk_Code=@dk_Code, dk_Short=@dk_Short,dk_Description=@dk_Description, dk_Active=@dk_Active,dk_LstDate=getdate() where dk_ROWID=@dk_ROWID
		end
		else
		begin  -- Insert
			 insert  cs_DomesticKind (dk_Code,dk_Short,dk_Description,dk_Active,dk_CrDate) values(@dk_Code,@dk_Short,@dk_Description,@dk_Active,getdate())
		end
	end
	
END
GO
