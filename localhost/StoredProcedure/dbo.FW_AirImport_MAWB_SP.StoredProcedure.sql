USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_AirImport_MAWB_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-09-02
-- Description: 基本资料信息ShipmentItem 存储过程
-- =============================================
ALTER  procedure [dbo].[FW_AirImport_MAWB_SP](
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
	@si_BillTo  nvarchar(6)='',
	@si_ReturnTo nvarchar(6)='',
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
	@si_Unit nvarchar(3)=''
) as
begin
	if @Option='List'
	begin
		select si_ROWID as RowID,si_BillTo as CompanyCode,si_BillTo as CompanyName,si_Item as Item,si_Description as [Description],si_Total as Total,si_QtyKind as CalcKind,si_Quantity as Qty,
		si_Unit as Unit,si_Currency as Currency,si_ExRate as EX,si_Rate as Rate,si_Amount as Amount
		from co_ShipmentItem where si_ToMaster=@si_Seed 
		order by si_CRDate desc 
	end
	if @Option='Update'
	begin
	    if(isnull(@si_ROWID,'')='')
	    begin
		   insert into co_ShipmentItem(si_BillTo,si_Item,si_Description,si_QtyKind,si_Quantity,si_Unit,si_Currency,si_ExRate,si_Rate,si_Amount)
		   values(@si_BillTo,@si_Item,@si_Description,@si_QtyKind,@si_Quantity,@si_Unit,@si_Currency,@si_ExRate,@si_Rate,@si_Amount) 
	    end
		else
		begin
		   update  co_ShipmentItem set si_BillTo=@si_BillTo,si_Item=@si_Item,si_Description=@si_Description,si_QtyKind=@si_QtyKind,si_Quantity=@si_Quantity,
		   si_Unit=@si_Unit,si_Currency=@si_Currency,si_ExRate=@si_ExRate,si_Rate=@si_Rate,si_Amount=@si_Amount,
		   si_LstDate=GETDATE() where si_ROWID=@si_ROWID 
		end
	end
	
end
GO
