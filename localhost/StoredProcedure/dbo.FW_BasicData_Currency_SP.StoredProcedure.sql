USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_Currency_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-26
-- Description: 基本资料信息Currency 存储过程
-- =============================================
CREATE procedure [dbo].[FW_BasicData_Currency_SP](
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
	@User nvarchar(12)= NULL,
	@Rate nvarchar(30)=null,
	@Buy nvarchar(30)=null,
	@Sell nvarchar(30)=null,
	@Description nvarchar(200)=null,
	@Country nvarchar(50)=null
) as
begin
	if @Option='List'
	begin
		select cur_ROWID as RowID,cur_Code as Code,cast(cur_Active as int ) as Active,cur_Description as  Description,cur_country as Country,
		cast(cur_Rate as decimal(18,3)) as Rate,cur_Buy as Buy,cur_Sell as Sell  from cs_Currency where cur_STAT=@STAT  and cur_SYS like @SYS+'%' order by cur_CrDate desc 
	end
	if @Option='Update'
	begin
	    if(isnull(@ROWID,'')='')
	    begin
		     insert into cs_Currency(cur_Code,cur_Active,cur_CrDate,cur_User,cur_STAT,cur_SYS,cur_Description,cur_country,cur_Rate,cur_Buy,cur_Sell)
		     values(@Code,@Active,getdate(),@User,@STAT,@SYS,@Description,@Country,@Rate,@Buy,@Sell)
	    end
		else
		begin
		   update cs_Currency set cur_Active=@Active ,cur_Code=@Code,cur_Description=@Description,cur_country=@Country,cur_Rate=@Rate,cur_Buy=@Buy,cur_Sell=@Sell
		   where cur_ROWID=@ROWID
		end
	end
	if @Option='GetCountry'
	begin
	   select '' as [text],'' as [value] union
	   select cy_Name as [text],cy_Code as [value] from cs_Country where cy_Active='1'
	end
	if @Option ='Delete' 
	begin
		delete from cs_Currency where cur_ROWID=@ROWID 
	end
end
GO
