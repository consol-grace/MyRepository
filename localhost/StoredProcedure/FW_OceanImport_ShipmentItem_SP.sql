USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_OceanImport_ShipmentItem_SP]    Script Date: 09/28/2011 12:00:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-09-02
-- Description: 基本资料信息ShipmentItem 存储过程
-- =============================================
ALTER procedure [dbo].[FW_OceanImport_ShipmentItem_SP](
    @Option nvarchar(50)='', -- 选项
	@si_ROWID  int =0,
	@si_Stat nvarchar(12)='',
	@si_Sys nvarchar(2)='',
	@si_ToMaster int=0,
	@si_ToHouse int=0,
	@si_Seed numeric(18,0)=0,
	@si_Type nvarchar(50)='',
	@si_LineNo int=0,
	@si_Item nvarchar(6)='', 
	@si_Description nvarchar(100)='',
	@si_BillTo  nvarchar(12)='',
	@si_ReturnTo nvarchar(12)='',
	@si_Currency nvarchar(6)='',
	@si_ExRate decimal(18,4)=0,
	@si_Percent decimal(18,3)=0,
	@si_QtyKind nvarchar(10)='',
	@si_Quantity decimal(18,3)=0,
	@si_Min decimal(18,4)=0,
	@si_Rate decimal(18,3)=0,
	@si_Amount decimal(18,4)=0,
	@si_TaxKind nvarchar(6)='',
	@si_Tax nvarchar(6)='',
	@si_Remark nvarchar(6)='',
	@si_ShowIn nvarchar(6)='',
	@si_PPCC int=0,
	@CrDate nvarchar(30)= '',
	@LstDate nvarchar(30)= '',
	@User nvarchar(12)= '',
	@si_Total decimal(18,3)=0,
	@ROWID nvarchar(1000)='',
	@si_Unit nvarchar(3)='',
	@si_User nvarchar(30)='',
	@str nvarchar(30)=''
) as
begin
	if @Option='UpdateOther'
	begin
	    if(not exists(select 1 from co_ShipmentItem where si_ROWID= @si_ROWID))
	    begin
	       insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@si_User)
		   select @si_Seed=@@identity 
		   insert into co_ShipmentItem(si_PPCC,si_BillTo,si_Item,si_Description,si_QtyKind,si_Quantity,si_Unit,si_Currency,si_ExRate,si_Rate,si_Amount,si_Seed,si_ToHouse,si_Stat,si_Sys,si_User,si_Type,si_Percent,si_ShowIn,si_CRDate,si_Total)
		   values(@si_PPCC,@si_BillTo,@si_Item,@si_Description,@si_QtyKind,@si_Quantity,@si_Unit,@si_Currency,@si_ExRate,@si_Rate,@si_Amount,@si_Seed,@si_ToHouse,@si_Stat,@si_Sys,@si_User,'OTHER',@si_Percent,@si_ShowIn,getDate(),@si_Total) 
	    end
		else
		begin
		   update  co_ShipmentItem set si_BillTo=@si_BillTo,si_Item=@si_Item,si_Description=@si_Description,si_QtyKind=@si_QtyKind,si_Quantity=@si_Quantity,si_Total=@si_Total,
		   si_Unit=@si_Unit,si_Currency=@si_Currency,si_ExRate=@si_ExRate,si_Rate=@si_Rate,si_Amount=@si_Amount,si_PPCC=@si_PPCC,si_Percent=@si_Percent,si_ShowIn=@si_ShowIn,
		   si_LstDate=GETDATE() where si_ROWID=@si_ROWID 
		end
	end
	if @Option='UpdateCosting'
	begin
	    if(not exists(select 1 from co_ShipmentItem where si_ROWID= @si_ROWID))
	    begin
	       insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@si_User)
		   select @si_Seed=@@identity 
		   insert into co_ShipmentItem(si_PPCC,si_BillTo,si_Item,si_Description,si_QtyKind,si_Quantity,si_Unit,si_Currency,si_ExRate,si_Rate,si_Amount,si_Seed,si_ToHouse,si_Stat,si_Sys,si_User,si_Type,si_Total,si_CRDate)
		   values(@si_PPCC,@si_BillTo,@si_Item,@si_Description,@si_QtyKind,@si_Quantity,@si_Unit,@si_Currency,@si_ExRate,@si_Rate,@si_Amount,@si_Seed,@si_ToHouse,@si_Stat,@si_Sys,@si_User,'COST',@si_Total,getdate()) 
	    end
		else
		begin
		   update  co_ShipmentItem set si_BillTo=@si_BillTo,si_Item=@si_Item,si_Description=@si_Description,si_QtyKind=@si_QtyKind,si_Quantity=@si_Quantity,
		   si_Unit=@si_Unit,si_Currency=@si_Currency,si_ExRate=@si_ExRate,si_Rate=@si_Rate,si_Amount=@si_Amount,si_PPCC=@si_PPCC, si_Total=@si_Total,
		   si_LstDate=GETDATE() where si_ROWID=@si_ROWID 
		end
	end
	if @Option ='DeleteActual' 
	begin
		delete from co_ShipmentItem where si_ToHouse=@si_Seed  and si_Type=@si_Type and si_ROWID  not in (select * from dbo.fn_ConvertListToTable(@str,','))
	end	
end
