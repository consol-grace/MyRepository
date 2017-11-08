USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_OceanImport_HBL_SP]    Script Date: 10/22/2011 13:02:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[FW_OceanImport_HBL_SP] 
		
	@Option nvarchar(30)='',
	@STAT nvarchar(30)='',
	@SYS nvarchar(30)='',
	@User nvarchar(30)='',
	@LotNo nvarchar(30)='',
	@MBL nvarchar(30)='',
	@POL nvarchar(30)='',
	@POD nvarchar(30)='',	
	@ETD nvarchar(30)='',
	@ETA nvarchar(30)='',
	@Vessel nvarchar(30)='',
	@Seed int =0,
	@o_ToMBL int =0,
	@o_ToHBL int =0,
	@o_ROWID int=0,
	@o_Type nvarchar(3)='',
	@o_DONo nvarchar(20)='',
	@o_HBL nvarchar(20)='',
	@o_DG nvarchar(1)='',
	@o_Insurance int=0,
	@o_Sales nvarchar(12)='',
	@o_PaymentMode nvarchar(3)='',
	@o_ServiceMode nvarchar(10)='',
	@o_Carrier nvarchar(12)='',
	@o_Shipper nvarchar(12)='',
	@o_Consignee nvarchar(12)='',
	@o_PartyA nvarchar(12)='',
	@o_PartyB nvarchar(12)='',
	@o_Coloader nvarchar(12)='',
	@o_Discharge nvarchar(12)='',
	@o_Broker nvarchar(12)='',
	@o_LocReceipt nvarchar(12)='',
    @imp_Surrender int=0,
	@imp_Warehouse nvarchar(12)='',
	@imp_StorageFrom datetime=null,
	@imp_StorageTo datetime=null, 
	@imp_PickupDate datetime=null,
	@o_ColoaderHBL nvarchar(30)='',
	@imp_Clearance nvarchar(30)='',
	@o_LocFinal nvarchar(30)='',
	@o_CWT decimal(18,3)=NULL,
	@o_WT decimal(18,3)=NULL,
	@o_CBM decimal(18,3)=NULL,
	@o_PKGS decimal(18,3)=NULL,
	@o_Unit nvarchar(3)=NULL,
	@o_carrierATTN nvarchar(22)=NULL,
	@o_Remark nvarchar(500)='',
	@code  nvarchar(20)=''
AS
BEGIN
     declare @tempLotNo varchar(30),@tempSeed varchar(30),@Date varchar(30)
	 if(@Option='List')
	 begin
	       -- HBL Information
			select o_ROWID as RowID,o_HBL as HBL,o_MBL as MBL,o_ServiceMode as ServiceMode,o_PaymentMode as PPD,o_Sales as Salesman,o_LotNo as LotNo,
			o_ColoaderHBL as ColoaderHBL ,'' as Reference,isnull(imp_Clearance,0) as Clearance,o_DONo as DO,o_LocReceipt as Receipt, o_LocFinal as FinalDest,
			case when o_DG='1' then 1 else 0 end as DG ,isnull(o_Insurance,0) as Insurance,isnull(imp_Surrender,0) as Surrender,o_Shipper as Shipper,o_Consignee as Consignee,
			o_PartyA as Notify1,o_PartyB as Notify2,o_CoLoader  as Coloader,o_Broker as [Broker],o_WT as GWT,o_CWT as CWT,o_CBM as CBM,
			o_PKGS as Piece,o_Unit as Unit,o_CarrierATTN as Container,imp_Warehouse as WareHouse,imp_StorageFrom as FreeStorageStart,
			imp_StorageTo as FreeStorageEnd,imp_PickupDate as PickUp,o_Remark as Remark		
			from co_OCEAN  as A inner  join co_import as B on A.o_Seed=B.imp_Seed  where o_seed=@seed and isnull(o_Active,'1')='1'
			
			-- Local Invoice
			SELECT inv_RowID as RowID, inv_IsDN as DN,inv_IsCN as CN,
			'<a target="_blank" href="../../AirImport/AIShipmentJobList/invoice.aspx?sys='+convert(nvarchar,inv_sys)+'&FL='+convert(nvarchar,isnull(inv_ForeignLocal,'L'))+'&seed='+convert(nvarchar,inv_seed)+'">'+case when isnull(inv_InvoiceNo,'')='' then 'BLANK' ELSE convert(nvarchar,inv_InvoiceNo) end  +'</a>' as DN_CNNO,
			--inv_InvoiceNo as DN_CNNO, 
			(select top 1 co_name from cs_company where co_code=inv_CompanyCode  and  co_companykind = 'BASE'  and  co_STAT=inv_STAT) as CompanyName ,inv_Currency as Currency,inv_Total as Amount,
			inv_IsVoid as Void,inv_IsPrinted as [Print],inv_IsAC  as AC 
			FROM co_Invoice WHERE inv_ToHouse =@seed and inv_Active=1 and inv_IsCost=0  --and inv_STAT=@stat and inv_sys like @sys+'%'
			
			--Container
			select oc_ROWID as RowID,'<a target="_blank"  href="Container.aspx?ID='+convert(nvarchar,oc_RowID)+'&HBL='+convert(nvarchar,oc_ToHBL)+'">'+ oc_CtnrNo+'</a>'  as Container,oc_CtnrSize as ContainerSize,oc_Piece as PKG,oc_Unit as Unit,oc_GWT as GWT,oc_CBM as CBM
			from co_OCEANContainer  where oc_ToHBL=@seed --and oec_STAT =@stat and oec_sys like @sys+'%'
			
			-- Other Charges
			SELECT  si_ROWID as RowID,si_PPCC as PPD,si_BillTo as CompanyCode,si_Item as Item,si_Description as [Description],si_Total as Total,si_QtyKind as CalcKind,si_Quantity as Qty,
		            si_Unit as Unit,si_Currency as Currency,si_ExRate as EX,si_Rate as Rate,si_Amount as Amount,si_Percent as [Percent],si_ShowIn as Show
		    FROM co_ShipmentItem WHERE si_ToHouse =@seed and  si_Type='other' --and si_STAT =@stat and si_sys like @sys+'%'
		    
		    -- Costing 
			SELECT  si_ROWID as RowID,si_PPCC as PPD,si_BillTo as CompanyCode,si_Item as Item,si_Description as [Description],si_Total as Total,si_QtyKind as CalcKind,si_Quantity as Qty,
		            si_Unit as Unit,si_Currency as Currency,si_ExRate as EX,si_Rate as Rate,si_Amount as Amount
		    FROM co_ShipmentItem WHERE si_ToHouse =@seed  and  si_Type='cost'--and si_STAT =@stat and si_sys like @sys+'%'
		    
			-- Foreign Invoice
			SELECT  inv_RowID as RowID,inv_Payment as Kind,inv_InvoiceDate as [Date],inv_InvoiceNo as DN_CNNO, inv_CompanyCode as CompanyCode,inv_CompanyName as CompanyName,inv_Currency as Currency ,inv_Total as Amount 
			FROM co_Invoice WHERE inv_ToHouse =@seed and inv_Active=1 and inv_IsCost=1  --and inv_STAT=@stat and inv_sys like @sys+'%'
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
			UPDATE co_OCEAN  SET o_Active=0 , o_User =@User , o_LstDate =getdate() where o_seed=@seed
	  end  
	 if(@Option='UpdateHBL')
	 begin
	   if(exists(select 1 from co_OCEAN where o_Seed=@Seed))
		begin
		  update co_OCEAN set o_HBL=@o_HBL,o_ServiceMode=@o_ServiceMode,o_PaymentMode=@o_PaymentMode,o_Sales=@o_Sales,o_ColoaderHBL=@o_ColoaderHBL,
		  o_DONo=@o_DONo,o_LocReceipt=@o_LocReceipt,o_LocFinal=@o_LocFinal,o_DG=@o_DG,o_Insurance=@o_Insurance,
          o_Shipper=@o_Shipper,o_Consignee=@o_Consignee,o_PartyA=@o_PartyA,o_PartyB=@o_PartyB,o_CoLoader=@o_CoLoader,o_Broker=@o_Broker,o_WT=@o_WT,
		  o_CWT=@o_CWT,o_CBM=@o_CBM,o_PKGS=@o_PKGS,o_Unit=@o_Unit,o_CarrierATTN=@o_CarrierATTN,o_Remark=@o_Remark where o_Seed=@Seed
		  --------  更新 Hawb ， Invoice          Author：Micro    2011-10-26 
    	  exec FW_AirImport_Update_SP @sys ='OI', @seed=@Seed,@Type='H'    
    	  --------
		  update co_Import set imp_Clearance=@imp_Clearance,imp_Surrender=@imp_Surrender , imp_Warehouse=@imp_Warehouse,imp_StorageFrom=@imp_StorageFrom,imp_StorageTo=@imp_StorageTo,imp_PickupDate=@imp_PickupDate
		  where imp_Seed=@Seed 
		  select @Seed as o_Seed ,'N' as Flag
		end
		else
		begin
		    insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@User)
			select @tempSeed=@@identity 
			
			select @Date=getdate()
			
			--（此处被修改 ，生成 LotNo      Author：   Micro    2011-10-20）
			-- select  @tempLotNo=dbo.fn_GetLotNo(@STAT,@SYS,@Date)    
			exec FW_BasicData_IDTable_SP @LotNo=@tempLotNo output,@code=@code,@date=@Date,@stat=@STAT,@User=@User
			---------------------------------------------------------------------------------------------------------------------------------------
						
			insert into co_Import(imp_Seed,imp_STAT,imp_SYS,imp_User,imp_CrDate,imp_Active,imp_Clearance,imp_LotNo,imp_Surrender,imp_Warehouse,imp_StorageFrom,imp_StorageTo,imp_PickupDate) 
			values(@tempSeed,@STAT,@SYS,@User,getdate(),'1',@imp_Clearance,@tempLotNo,@imp_Surrender,@imp_Warehouse,@imp_StorageFrom,@imp_StorageTo,@imp_PickupDate) 
			
			insert into co_OCEAN(o_Seed,o_LotNo,o_HBL,o_ServiceMode,o_PaymentMode,o_Sales,o_ColoaderHBL,o_DONo,o_LocReceipt,o_LocFinal,o_DG,o_Insurance,
                       o_Shipper,o_Consignee,o_PartyA,o_PartyB,o_CoLoader,o_Broker,o_WT,o_CWT,o_CBM,o_PKGS,o_Unit,o_CarrierATTN,o_Remark,o_ToMBl,O_STAT,o_SYS,o_Type,o_Active,o_CrDate,o_User,o_isMBL,o_isHBL)
			values(@tempSeed,@tempLotNo,@o_HBL,@o_ServiceMode,@o_PaymentMode,@o_Sales,@o_ColoaderHBL,@o_DONo,@o_LocReceipt,@o_LocFinal,@o_DG,@o_Insurance,@o_Shipper,@o_Consignee,@o_PartyA,@o_PartyB,@o_CoLoader,@o_Broker,
			@o_WT,@o_CWT,@o_CBM,@o_PKGS,@o_Unit,@o_CarrierATTN,@o_Remark,@o_ToMBL,@STAT,@SYS,'HBL',1,getdate(),@User,0,1)
			 --------  更新 Hawb ， Invoice          Author：Micro    2011-10-26 
    	     exec FW_AirImport_Update_SP @sys ='OI', @seed=@tempSeed,@Type='H'    
    	     --------
			select @tempSeed as o_Seed,'Y'  as Flag
		end
	 end 
END
