USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_OceanImport_ShipmentRoute_SP]    Script Date: 09/28/2011 12:00:49 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-26
-- Description: 基本资料信息ShipmentRoute 存储过程
-- =============================================
ALTER  procedure [dbo].[FW_OceanImport_ShipmentRoute_SP](
    @Option nvarchar(50)='', -- 选项
	@sr_ROWID int=0,
	@sr_Stat nvarchar(12)='',
	@sr_Parent int=0,
	@sr_Seed numeric(18,0)=0, 
	@sr_ToMaster int=0,
	@sr_ToHouse int=0,
	@sr_OrderID int=0,
	@sr_Carrier nvarchar(12)='',
	@sr_Vessel nvarchar(30)='',
	@sr_Voyage nvarchar(20)='',
	@sr_Flight nvarchar(10)='',
	@sr_From nvarchar(3)='',
	@sr_To nvarchar(3)='', 
	@sr_ETD datetime=null,
	@sr_ETA datetime=null,
	@sr_ATD datetime=null,
	@sr_ATA datetime=null,
	@CrDate nvarchar(30)= '',
	@LstDate nvarchar(30)= '',
	@User nvarchar(12)= '',
	@ROWID   nvarchar(1000)='',
	@sr_ShipKind nvarchar(20)='',
	@str nvarchar(300)='',
	@sr_User nvarchar(30)='',
	@sr_Sys nvarchar(30)=''
) as
begin
	if @Option='Update'
	begin
	    if(exists(select 1 from co_ShipmentRoute where sr_RowID=@sr_RowID))
		begin
		   update  co_ShipmentRoute set sr_ShipKind=@sr_ShipKind, sr_Carrier=@sr_Carrier, sr_To=@sr_To ,sr_ETD=@sr_ETD,sr_ETA=@sr_ETA,sr_Voyage=@sr_Voyage,
		   sr_LstDate=GETDATE() where sr_ROWID=@sr_ROWID 
		end
		else
		begin
			 -- 生成 Seed ID  
			 insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@sr_User)
			 select @sr_Seed=@@identity 
			 -- 插入FlightRoute
			 insert into co_ShipmentRoute (sr_Stat,sr_Seed,sr_OrderID,sr_ShipKind,sr_Carrier,sr_Voyage,sr_To,sr_ETD,sr_ETA,sr_Active,sr_CrDate,sr_User,sr_ToHouse)
			 values(@sr_Stat,@sr_Seed,0,@sr_ShipKind,@sr_Carrier,@sr_Voyage,@sr_To,@sr_ETD,@sr_ETA,1,getdate(),@sr_User,@sr_ToHouse)
		end
	end
	if @Option ='DeleteActual' 
	 begin
		delete from co_ShipmentRoute where sr_ToHouse=@sr_Seed and sr_RowID not in (select * from dbo.fn_ConvertListToTable(@str,','))
	 end
	
end
