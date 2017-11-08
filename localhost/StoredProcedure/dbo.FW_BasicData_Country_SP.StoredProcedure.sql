USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_Country_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-22
-- Description: 基本资料信息Country 存储过程
-- =============================================
CREATE procedure [dbo].[FW_BasicData_Country_SP](
    @Option nvarchar(50)='', -- 选项
	@ROWID int=null,
	@ID int=null,
	@STAT nvarchar(12) =null,
	@SYS nvarchar(2)=NULL,
	@Code nvarchar(3)=null,
	@Name nvarchar(30)=null,
	@Active int= 0,
	@CrDate varchar(30)= NULL,
	@LstDate varchar(30)= NULL,
	@User nvarchar(12)= NULL
) as
begin
	if @Option='List'
	begin
		select cy_ROWID as RowID,cy_Code as Code,cy_Name as Name,cast(cy_Active as int ) as Active  from cs_Country order by cy_CrDate desc 
	end
	if @Option='Update'
	begin
	    if(isnull(@ROWID,'')='')
	    begin
	       if (not exists(select 1 from cs_Country where cy_Code=@Code))
		   begin
		     insert into cs_Country(cy_Code,cy_Name,cy_Active,cy_CrDate,cy_User,cy_STAT,cy_SYS)
		     values(@Code,@Name,@Active,getdate(),@User,@STAT,@SYS)
		   end
	    end
		else
		begin
		   if(not exists(select 1 from cs_Country where  cy_ROWID<>@ROWID and cy_Code=@Code))
		   begin
		   update cs_Country set cy_Name=@Name,cy_Active=@Active ,cy_Code=@Code 
		   where cy_ROWID=@ROWID
		   end
		end
	end
	
	if @Option ='Delete' 
	begin
		delete from cs_Country where cy_Code=@Code
	end
end
GO
