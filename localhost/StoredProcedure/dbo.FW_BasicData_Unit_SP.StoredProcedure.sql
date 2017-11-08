USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_Unit_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-26
-- Description: 基本资料信息Unit 存储过程
-- =============================================
CREATE procedure [dbo].[FW_BasicData_Unit_SP](
    @Option nvarchar(50)='', -- 选项
	@ROWID int=null,
	@ID int=null,
	@STAT nvarchar(12) =null,
	@SYS nvarchar(2)=NULL,
	@Code nvarchar(3)=null,
	@Short nvarchar(30)=null,
	@Description nvarchar(200)=null,
	@Active int= 0,
	@CrDate varchar(30)= NULL,
	@LstDate varchar(30)= NULL,
	@User nvarchar(12)= NULL
) as
begin
	if @Option='List'
	begin
		select top 100 unt_ROWID as RowID,unt_Code as Code,unt_Short as Short,unt_Description as Description,cast(unt_Active as int ) as Active  
		from cs_Unit where unt_STAT like @STAT+'%' order by unt_CrDate desc 
	end
	if @Option='Update'
	begin
		if(isnull(@ROWID,'')='')
	    begin
		     insert into cs_Unit(unt_Code,unt_Short,unt_Description,unt_Active,unt_CrDate,unt_User,unt_STAT,unt_SYS)
		     values(@Code,@short,@Description,@Active,getdate(),@User,@STAT,@SYS)
	    end
		else
		begin
		   update cs_Unit set unt_Code=@Code,unt_Active=@Active ,unt_Short=@Short,unt_Description=@Description
		   where unt_ROWID=@ROWID
		end
	end
	
	if @Option ='Delete' 
	begin
		delete from cs_Country where cy_Code=@Code
	end
end
GO
