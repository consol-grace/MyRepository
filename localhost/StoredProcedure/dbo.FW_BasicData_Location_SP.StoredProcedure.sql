USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_Location_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-26
-- Description: 基本资料信息Location 存储过程
-- =============================================
CREATE procedure [dbo].[FW_BasicData_Location_SP](
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
	@City nvarchar(20)=null,
	@Country nvarchar(50)=null,
	@Currency nvarchar(50)=null,
	@AirAgent nvarchar(50)=null,
	@AirAgent1 nvarchar(50)=null,
	@OceanAgent nvarchar(50)=null,
	@OceanAgent1 nvarchar(50)=null
) as
begin
	if @Option='List'
	begin
		select loc_ROWID as RowID,loc_Code as Code,loc_Name as Name,cast(loc_Active as int ) as Active ,loc_City as City,loc_Country as Country
		,loc_Currency as Currency,loc_AirAgent as AIR,loc_AirAgent as Air1,loc_SeaAgent as OCEAN,loc_SeaAgent as OCEAN1 
		from cs_Location  where loc_STAT=@STAT and loc_SYS like @SYS+'%' order by loc_CrDate desc 
	end
	if @Option='Update'
	begin
		if(isnull(@ROWID,'')='')
	    begin
		     insert into cs_Location(loc_Code,loc_Name,loc_Active,loc_CrDate,loc_User,loc_STAT,loc_SYS,loc_Country,loc_Currency,loc_AirAgent,loc_SeaAgent,loc_City)
		     values(@Code,@Name,@Active,getdate(),@User,@STAT,@SYS,@Country,@Currency,@AirAgent,@OceanAgent,@City)
	    end
		else
		begin
		   update cs_Location set loc_Name=@Name,loc_Active=@Active ,loc_Code=@Code ,loc_City=@City,loc_Country=@Country,loc_Currency=@Currency,
		   loc_AirAgent=@AirAgent,loc_SeaAgent=@OceanAgent where loc_ROWID=@ROWID
		end
	end
	
	if @Option ='Delete' 
	begin
		delete from cs_Country where cy_Code=@Code
	end
end
GO
