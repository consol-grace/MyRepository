USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_OceanImport_Invoice_SP]    Script Date: 09/28/2011 11:55:12 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-09-02
-- Description: 基本资料信息Invoice 存储过程
-- =============================================
ALTER  procedure [dbo].[FW_OceanImport_Invoice_SP](  
    @Option nvarchar(50)='', -- 选项
	@inv_ROWID  int =0,
	@inv_Stat nvarchar(12)='',
	@inv_Sys nvarchar(2)='',
	@inv_Seed numeric(18,0)=0,
	@inv_ToMaster int =0,
	@inv_ToHouse int =0, 
	@inv_IsDN int =0,
	@inv_IsCN int =0,
	@inv_IsVoid int =0,
	@inv_IsPrinted int =0,
	@inv_IsAC int =0,
	@inv_LotNo nvarchar(20)='',
	@inv_CompanyCode  nvarchar(12)='',
	@inv_CompanyName nvarchar(43)='',
	@inv_Currency nvarchar(3)='',
	@inv_Total decimal(18,3)=0,
	@inv_Active int =0,
	@CrDate nvarchar(30)= '',
	@LstDate nvarchar(30)= '',
	@User nvarchar(12)= '',
	@inv_InvoiceNo nvarchar(20)='',
    @inv_Payment nvarchar(30)='',
    @inv_InvoiceDate datetime=null,
    @inv_Tax  float =0.0,
    @inv_CWT  float =0.0,
    @inv_Remark nvarchar(1024)='',
    
    @islocal varchar(1)='F',
    @cur_code nvarchar(20)='',    
    @code nvarchar(20)='',
    

	@inv_Address1 nvarchar(50)='',
	@inv_Address2 nvarchar(50)='',
	@inv_Address3 nvarchar(50)='',
	@inv_Address4 nvarchar(50)='',
	@inv_Phone nvarchar(50)='',
	@inv_Contact nvarchar(50)='',
	@inv_Fax nvarchar(50)='',


	@inv_MasterNo nvarchar(50)='',
	@inv_HouseNo nvarchar(50)='',
	@inv_Sales nvarchar(50)='',



	@inv_Shipper nvarchar(50)='',
	@inv_ShipperLine nvarchar(50)='',
	@inv_Consignee nvarchar(50)='',
	@inv_ConsigneeLine nvarchar(50)='',
	@inv_Carrier nvarchar(50)='',
	@inv_Vessel nvarchar(50)='',
	@inv_Voyage nvarchar(50)='',
	@inv_ETD datetime=null,
	@inv_ETA datetime =null,
	@inv_GWT float=0.0,
	@inv_VWT float=0.0,

	@inv_Pkgs float=0,
	@inv_UnitDesc nvarchar(30)='',

	@inv_User nvarchar(20)='' ,
	@str nvarchar(300)=''    
	
) as
begin
	if @Option='Update'
	begin
	select ''
	    if(not exists(select 1 from co_Invoice where inv_ROWID=@inv_ROWID))
	    begin
		    insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@inv_User)
			select @inv_seed=@@identity 
		    insert into co_Invoice(inv_InvoiceNo,inv_CompanyName,inv_CompanyCode,inv_Currency,inv_Total,inv_Payment,inv_InvoiceDate,inv_CrDate,inv_User,inv_Stat,inv_Sys,inv_Seed,inv_ToHouse,inv_IsCost,inv_Active)
		    values(@inv_InvoiceNo,@inv_CompanyName,@inv_CompanyCode,@inv_Currency,@inv_Total,@inv_Payment,@inv_InvoiceDate,getdate(),@inv_User,@inv_Stat,@inv_Sys,@inv_Seed,@inv_ToHouse,1,1)
	    end
		else
		begin
		   update  co_Invoice set  inv_InvoiceNo=@inv_InvoiceNo,inv_CompanyName=@inv_CompanyName,inv_CompanyCode=@inv_CompanyCode,inv_Currency=@inv_Currency,inv_Total=@inv_Total,
				   inv_Payment=@inv_Payment,inv_InvoiceDate=@inv_InvoiceDate,inv_LstDate=GETDATE() where inv_ROWID=@inv_ROWID 
				   --(select top 1 cfg_Index from cs_SystemString where cfg_Value=@inv_Payment)
		end
	end
	if @Option ='DeleteActual' 
	begin
		update co_Invoice set   inv_Active=0   where inv_ToHouse=@inv_Seed  and inv_IsCost=1  and inv_ROWID not in (select * from dbo.fn_ConvertListToTable(@str,','))
	end	
	
	if @Option ='DeleteActualLocal' 
	begin
		update co_Invoice set   inv_Active=0   where inv_ToHouse=@inv_Seed  and inv_IsCost=0  and inv_ROWID not in (select * from dbo.fn_ConvertListToTable(@str,','))
	end	
	
end
