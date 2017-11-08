USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_Airline_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-26
-- Description: 基本资料信息AirLine 存储过程
-- =============================================
CREATE procedure [dbo].[FW_BasicData_Airline_SP](
    @Option nvarchar(50)='', -- 选项
	@ROWID int=0,
	@ID int=0,
	@STAT nvarchar(12) ='',
	@SYS nvarchar(2)='',
	@Code nvarchar(12)='',
	@Name nvarchar(40)='',
	@Active int= 0,
	@CrDate nvarchar(30)= '',
	@LstDate nvarchar(30)= '',
	@User nvarchar(12)= '',
	@Country nvarchar(10)='',
	@AirNo int =0,
	@CallSign nvarchar(50)=''
) as
begin
	if @Option='List'
	begin
		select al_ROWID as RowID,al_Code as Code,cast(al_Active as int ) as Active,al_CallSign as  CallSign,al_country as Country,
		al_AirNo as AirNo,al_Name as Name from cs_Airline where al_STAT=@STAT 
		order by al_CrDate desc 
	end
	if @Option='Update'
	begin
	    if(isnull(@ROWID,'')='')
	    begin
		     insert into cs_Airline(al_Code,al_Active,al_CrDate,al_User,al_STAT,al_SYS,al_CallSign,al_country,al_Name)
		     values(@Code,@Active,getdate(),@User,@STAT,@SYS,@CallSign,@Country,@Name)
	    end
		else
		begin
		   update cs_Airline set al_Active=@Active ,al_Code=@Code,al_Name=@Name,al_country=@Country,al_CallSign=@CallSign
		   where al_ROWID=@ROWID
		end
	end
	if @Option='GetCountry'
	begin
	   select '' as Country,'' as Country union
	   select cy_Name as Country,cy_Code as Country from cs_Country where cy_Active='1'
	end
	if @Option ='Delete' 
	begin
		delete from cs_Airline where al_ROWID=@ROWID 
	end
end
GO
