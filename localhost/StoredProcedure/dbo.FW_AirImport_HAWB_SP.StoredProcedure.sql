USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_AirImport_HAWB_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE  [dbo].[FW_AirImport_HAWB_SP]  
	
    @Option nvarchar (30)='List',
    @seed   int =0,
	@stat   nvarchar (10)='',
	@sys    nvarchar (10)='',
	@User   nvarchar (30)='',
	@RowID  int=0
	
AS
BEGIN
	 
	  if(@Option='List')   
	  begin
			-- HAWB Information
			select  air_ROWID as RowID,air_HAWB as HAWB,air_MAWB as MAWB,air_LotNo as LotNo, air_CompanyReferance as Reference,isnull(imp_Clearance,0) as Clearance,air_CoLoader  as Coloader,air_Shipper as Shipper,
					air_Consignee as Consignee,air_PartyA as Notify1,air_PartyB as Notify2,air_Broker as [Broker],air_Sales as Salesman,
					air_GWT as GWT,air_VWT as VWT,air_CWT as CWT,air_Piece as Piece,air_Unit as Unit,air_Pallet as Pallet,
					air_Remark as Remark,air_LocFinal as FinalDest,air_DG as DG,isnull(air_Insurance,0) as Insurance ,air_LocReceived as Receipt,isnull(imp_Surrender,0) as Surrender,
					imp_Warehouse as WareHouse,imp_StorageFrom as FreeStorageStart,imp_StorageTo as FreeStorageEnd,imp_FreeDays as FreeStorage,imp_PickupDate as PickUp
			from co_AIR  as A left join co_import as B on A.air_Seed=B.imp_Seed  where air_seed=@seed --and isnull(air_Active,'1')='1'
			
			-- Local Invoice
			SELECT inv_RowID as RowID, inv_IsDN as DN,inv_IsCN as CN,
			'<a  target="_blank" href="invoice.aspx?sys='+convert(nvarchar,inv_sys)+'&FL='+convert(nvarchar,isnull(inv_ForeignLocal,'L'))+'&seed='+convert(nvarchar,inv_seed)+'">'+case when isnull(inv_InvoiceNo,'')='' then 'BLANK'  else  convert(nvarchar,inv_InvoiceNo) +'</a>' end as DN_CNNO, 
			(select top 1 co_name from cs_company where co_code=inv_CompanyCode) as CompanyName ,inv_Currency as Currency,inv_Total as Amount,
			inv_IsVoid as Void,inv_IsPrinted as [Print],inv_IsAC as AC 
			FROM co_Invoice WHERE inv_ToHouse =@seed and inv_Active=1 and inv_IsCost=0 --and inv_STAT=@stat and inv_sys like @sys+'%'
			
			-- Local Costing 
			SELECT  si_ROWID as RowID,si_BillTo as CompanyCode,si_Item as Item,si_Description as [Description],si_Total as Total,si_QtyKind as CalcKind,si_Quantity as Qty,
		            si_Unit as Unit,si_Currency as Currency,si_ExRate as EX,si_Rate as Rate,si_Amount as Amount
		    FROM co_ShipmentItem WHERE si_ToHouse =@seed  --and si_STAT =@stat and si_sys like @sys+'%'
		
			-- Foreign Invoice
			SELECT  inv_RowID as RowID,inv_Payment as Kind,inv_InvoiceDate as [Date],inv_InvoiceNo as DN_CNNO, inv_CompanyCode as CompanyCode,inv_CompanyName as CompanyName,inv_Currency as Currency ,inv_Total as Amount 
			FROM co_Invoice WHERE inv_ToHouse =@seed and inv_Active=1 and inv_IsCost=1 --and inv_STAT=@stat and inv_sys like @sys+'%'
			--select cfg_Value from cs_SystemString where cfg_Index=inv_Payment and  cfg_Type='DNCN'
		
			-- Domestic Information
			SELECT sr_RowID as RowID,sr_ShipKind as Kind, sr_Carrier as CompanyCode, sr_To as Dest ,sr_Voyage as Voyage,sr_ETD as ETD, sr_ETA as ETA FROM co_ShipmentRoute 
			WHERE sr_ToHouse=@seed and sr_Active=1 --and sr_STAT=@stat 
		
			-- Contact Information
			SELECT  sc_RowID as RowID,sc_Type as Kind , sc_Company as CompanyCode ,sc_Dept as Dept,sc_Contact as Contact ,sc_Phone as Phone ,sc_Fax as Fax,sc_Email as Email  
			FROM co_ShipmentContact WHERE sc_ToHouse=@seed --and sc_STAT =@stat and sc_sys like @sys+'%'
			
	  end	  
	  
	  if(@Option='Delete')
	  begin
			UPDATE co_AIR  SET air_Active=0 , air_LastUser =@User , air_LstDate =getdate() where air_seed=@seed
	  end  
	 
	 	
END
GO
