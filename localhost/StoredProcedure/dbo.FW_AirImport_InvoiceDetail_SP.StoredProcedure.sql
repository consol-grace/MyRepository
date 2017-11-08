USE [USGROUP]
GO
if exists (select * from sysobjects where name = 'FW_AirImport_InvoiceDetail_SP')
	drop proc FW_AirImport_InvoiceDetail_SP
go

/****** Object:  StoredProcedure [dbo].[FW_AirImport_InvoiceDetail_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FW_AirImport_InvoiceDetail_SP] 
	
      @Option nvarchar(30)='list'
	  ,@id_ROWID int =0
      ,@id_ID  int =0
      ,@id_STAT nvarchar(12)=''
      ,@id_SYS  nvarchar(2)=''
      ,@id_Seed int =0
      ,@id_ToMAWB int =0
      ,@id_ToHAWB  int =0
      ,@id_Parent  int =0
      ,@id_Item  nvarchar(6)=''
      ,@id_Description nvarchar(100)=''
      ,@id_CurrencyOld  nvarchar(3)=''
      ,@id_Currency  nvarchar(3)=''
      ,@id_ExRate   float =0.000
      ,@id_QtyKind  nvarchar(8)=''
      ,@id_Qty   float =0.000
      ,@id_Min     float =null
      ,@id_Rate   float =null
      ,@id_Amount  float =null
      ,@id_TaxQtyKind nvarchar(8)=''
      ,@id_TaxQty   float =0.000
      ,@id_TaxRate  float =0.000
      ,@id_TaxAmount  float =0.000
      ,@id_NetTotal  float =0.000
      ,@id_TaxTotal  float =0.000
      ,@id_Percent  float =0.000
      ,@id_ActTotal  float =0.000
      ,@id_CrDate  datetime=null
      ,@id_LstDate datetime =null
      ,@id_User  nvarchar(12)=''
      ,@inv_ActTotal  float =0.0
      ,@inv_Total  float =0.0
      ,@inv_Factor  int =1
      ,@inv_Payment int=1
      ,@inv_IsDN bit=1
      ,@inv_IsCN bit=0
	  ,@ROWID  nvarchar(1000)=''
AS
BEGIN
	  
	  if(@Option='List')
	  begin
			select id_RowID as RowID, id_Item as ItemCode,id_Description as [Description],id_QtyKind as CalBy, id_Min as [Min], 
				   id_Rate as Rate,id_Amount as Amount,id_Percent as [Percent],id_NetTotal as NetTotal,
				   id_taxqty  as Tax , id_TaxTotal as TaxTotal ,id_ActTotal as Total  
			from co_InvoiceDetail where id_Seed =@id_Seed			   	
	  end
	  
	  if(@Option='Single')
	  begin
			--select  *  from  co_Invoice  where  inv_Seed=@id_Seed
		  select  inv_seed,  inv_InvoiceNo as InvoiceNo, inv_LotNo as LotNo,inv_MasterNo as M,inv_HouseNo as H, '' as Book , inv_Sales  as  Sales ,inv_InvoiceDate as InvoiceDate,inv_Currency  as Currency , inv_Tax as Tax,
		  inv_Shipper as Shipper , inv_ShipperLine as ShipperName ,inv_Consignee as Consignee, inv_ConsigneeLine as ConsigneeName , inv_Carrier as Carrier ,(select co_Name from cs_Company  where co_Code=inv_Carrier and co_CompanyKind=coalesce('bill','base') and co_STAT=inv_STAT) as CarrierName,
		  inv_Vessel as Vessel, inv_Voyage as Voyage, inv_FlightNo as FlightNo ,convert(nvarchar(10),inv_ETD,103) as ETD ,convert(nvarchar(10),inv_ETA,103) as ETA , inv_GWT as GWT, inv_VWT as VWT, inv_CWT as CWT, inv_WTUnit as Unit , inv_Pkgs as pkgs , inv_Phone as Phone, inv_Fax as Fax, inv_Contact as Contact,
		  case when  isnull(inv_ForeignLocal,'L')='L' then 'Local' else 'Foreign' end as  FL,  inv_CompanyCode as code , inv_CompanyName as Company, inv_Address1 as Address1,inv_Address2 as Address2,inv_Address3 as Address3,inv_Address4 as Address4, inv_Remark as Remark,
		  case when  inv_Factor=1 then 'Invoice'  else 'Credit Note' end as  Factor ,inv_Ex as Ex,case when isnull(inv_Receipt,'')='' then inv_Load else inv_Receipt end as Depart,
		  case when isnull(inv_Discharge,'')='' then inv_Final else inv_Discharge end as Dest
		  from  co_Invoice  where  inv_Seed=@id_Seed
	  end
	  
	  
	  if(@Option='Update')
	  begin
			if(exists(select 1 from co_InvoiceDetail where id_RowID =@id_RowID))
			begin
				update co_InvoiceDetail set id_Item=@id_Item,id_Description=@id_Description,id_Min=@id_Min,id_Rate=@id_Rate,id_Amount=@id_Amount,id_Percent=@id_Percent,
					   id_NetTotal=@id_NetTotal,id_TaxTotal=@id_TaxTotal,id_LstDate=getdate(),id_QtyKind=@id_QtyKind,id_TaxQty=@id_TaxQty,id_ActTotal=@id_ActTotal
			    where  id_RowID=@id_RowID 
			end
			else
			begin
				insert into co_InvoiceDetail (id_Parent,id_STAT,id_SYS,id_Seed,id_Item,id_Description,id_QtyKind,id_Min,id_Rate,id_Amount,id_Percent,id_NetTotal,id_TaxQty,id_TaxTotal,id_ActTotal,id_CrDate,id_User)
				values (@id_Parent,@id_STAT,@id_SYS,@id_Seed,@id_Item,@id_Description,@id_QtyKind,@id_Min,@id_Rate,@id_Amount,@id_Percent,@id_NetTotal,@id_TaxQty,@id_TaxTotal,@id_ActTotal,getdate(),@id_User)
			end
			
			------- ¸üÐÂ Invoice 
			update  co_Invoice set inv_ActTotal =@inv_ActTotal,inv_Total =@inv_Total,inv_Factor=@inv_Factor,inv_Payment=@inv_Payment,inv_IsDN=@inv_IsDN,inv_IsCN=@inv_IsCN where inv_Seed =@id_Seed
			
	  end
	  
	  if(@Option='Delete')
	  begin
			delete co_InvoiceDetail  where  id_Seed=@id_Seed and   id_ROWID not in (SELECT * FROM fn_ConvertListToTable(@ROWID,','))			
			--delete co_InvoiceDetail  where id_ROWID=@id_ROWID
	  end
	  if(@Option ='DeleteAll')
	  begin
			delete co_InvoiceDetail  where id_Seed=@id_Seed
	  end  
	  
	  
END
GO
