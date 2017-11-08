USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_Sales_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-26
-- Description: 基本资料信息Sales 存储过程
-- =============================================
CREATE procedure [dbo].[FW_BasicData_Sales_SP](
    @Option nvarchar(50)='', -- 选项
	@ROWID int=0,
	@ID int=0,
	@STAT nvarchar(12) ='',
	@SYS nvarchar(2)='',
	@Code nvarchar(12)='',
	@Name nvarchar(30)='',
	@Active int= 0,
	@CrDate nvarchar(30)= '',
	@LstDate nvarchar(30)= '',
	@User nvarchar(12)= '',
	@Company nvarchar(12)='',
	@USGroup int=0
) as
begin
	if @Option='List'   
	begin
		select sal_ROWID as RowID,sal_Code as Code,cast(sal_Active as int ) as Active,sal_Description as  Name,sal_Company as Company,
		cast(sal_USGroup as int ) as USGroup  from cs_Sales  where sal_STAT=@STAT
		order by sal_CrDate desc 
	end
	if @Option='Update'
	begin
	    if(isnull(@ROWID,'')='')
	    begin
		     insert into cs_Sales(sal_Code,sal_Active,sal_CrDate,sal_User,sal_STAT,sal_SYS,sal_Description,sal_Company,sal_USGroup)
		     values(@Code,@Active,getdate(),@User,@STAT,@SYS,@Name,@Company,@USGroup)
	    end
		else
		begin
		   update cs_Sales set sal_Active=@Active ,sal_Code=@Code,sal_Description=@Name,sal_Company=@Company,sal_USGroup=@USGroup
		   where sal_ROWID=@ROWID
		end
	end
	if @Option ='Delete' 
	begin
		delete from cs_Sales where sal_ROWID=@ROWID 
	end
end
GO
