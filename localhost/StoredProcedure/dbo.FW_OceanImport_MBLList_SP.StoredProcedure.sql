USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_OceanImport_MBLList_SP]    Script Date: 10/20/2011 10:32:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Micro       QQ: 543661280     
-- Create date: 2011-09-27
-- Description: FW_OceanImport_MBLList_SP 存储过程
-- =============================================
ALTER  procedure [dbo].[FW_OceanImport_MBLList_SP](
    
       @Option nvarchar(50)='Single' -- 选项
	  ,@o_ROWID  int =0
      ,@o_ID   int =null
      ,@o_STAT  nvarchar(12)=''
      ,@o_SYS     nvarchar(2)=''
      ,@o_Seed    nvarchar(20)=null
      ,@o_ToMBL   int =0
      ,@o_ToHBL   int =0
      ,@o_Type     nvarchar(3)=null
      ,@o_BookNo  nvarchar(20)=null
      ,@o_LotNo     nvarchar(20)=null
      ,@o_SerialNo  nvarchar(12)=null
      ,@o_DONo    nvarchar(20)=null
      ,@o_MBL       nvarchar(20)=null
      ,@o_HBL       nvarchar(20)=null
      ,@o_IsMBL    bit=0
      ,@o_IsHBL    bit=0
      ,@o_IsDirect  bit =0
      ,@o_IsPrinted  nchar(1)=null
      ,@o_DG          nchar(1)=null
      ,@o_Insurance  bit =0 
      ,@o_Status     nchar(1)=null
      ,@o_Sales        nvarchar(12)=null
      ,@o_PaymentMode  nvarchar(3)=null
      ,@o_ServiceMode  nvarchar(10)=null
      ,@o_Carrier       nvarchar(12)=null
      ,@o_ColoaderMBL  nvarchar(20)=null
      ,@o_Shipper     nvarchar(12)=null
      ,@o_Consignee  nvarchar(12)=null
      ,@o_PartyA    nvarchar(12)=null
      ,@o_PartyB    nvarchar(12)=null
      ,@o_Coloader  nvarchar(12)=null
      ,@o_Discharge   nvarchar(12)=null
      ,@o_Broker   nvarchar(12)=null
      ,@o_LocReceipt   nvarchar(3)=null
      ,@o_LocPOL       nvarchar(3)=null
      ,@o_LocPOD      nvarchar(3)=null
      ,@o_LocFinal      nvarchar(3)=null
      ,@o_VesselID     int =null
      ,@o_VoyageID   int =null
      ,@o_BCBM      decimal(18,3)=null
      ,@o_ACBM      decimal(18,3)=null
      ,@o_CCBM		decimal(18,3)=null
      ,@o_CBM			decimal(18,3)=null			
      ,@o_BWT		decimal(18,3)=null
      ,@o_AWT		decimal(18,3)=null
      ,@o_CWT		decimal(18,3)=null
      ,@o_WT		decimal(18,3)=null
      ,@o_BPKGS  		decimal(18,3)=null
      ,@o_APKGS		decimal(18,3)=null
      ,@o_CPKGS		decimal(18,3)=null
      ,@o_PKGS		decimal(18,3)=null
      ,@o_Unit          nvarchar(3)=null
      ,@o_CFS			datetime =null
      ,@o_CY			datetime =null
      ,@o_BookDate			datetime =null
      ,@o_ScheduleDate			datetime =null
      ,@o_SailingDATE			datetime =null
      ,@o_ETD			datetime =null
      ,@o_ETA			datetime =null
      ,@o_ATD         datetime =null
      ,@o_ETAFinal  datetime =null
      ,@o_ATA          datetime =null
      ,@o_ClosingDate			datetime =null
      ,@o_Attachment			nchar(1)=null
      ,@o_CtnrInfo				nvarchar(1024)=null
      ,@o_DocumentType    nvarchar(10)=null
      ,@o_CarrierATTN		nvarchar(22)=null
      ,@o_PrintGroup			int =null
      ,@o_CNAME1			nvarchar(43)=null
      ,@o_CNAME2		    nvarchar(43)=null
      ,@o_CTEL1	     nvarchar(43)=null
      ,@o_CTEL2 	    nvarchar(43)=null
      ,@o_CFAX1	    nvarchar(43)=null
      ,@o_CFAX2	    nvarchar(43)=null
      ,@o_CLBILL    nvarchar(12)=null
      ,@o_CLCUR     nvarchar(3)=null
      ,@o_CLEX       decimal(18,5)=null
      ,@o_CLMIN		decimal(18,3)=null
      ,@o_CLRATE	decimal(18,3)=null	
      ,@o_CLTOT		decimal(18,3)=null
      ,@o_PPBILL		varchar(12)=null
      ,@o_PPCUR		nvarchar(3)=null
      ,@o_PPEX		decimal(18,5)=null
      ,@o_PPMIN		decimal(18,3)=null
      ,@o_PPRATE	decimal(18,3)=null
      ,@o_PPTOT		decimal(18,3)=null
      ,@o_SameLocation    bit=null
      ,@o_SameDate			 bit=null
      ,@o_ColoaderHBL    nvarchar(20)=null
      ,@o_Remark				 nvarchar(500)=null	
      ,@o_Active				 bit =null
      ,@o_CrDate				 datetime =null
      ,@o_LstDate				datetime =null
      ,@User					nvarchar(12)=null
      ,@ROWID                nvarchar(1000)=null
      ,@code         nvarchar(20)='',
     @si_ROWID  int =0,
	@si_Stat nvarchar(12)=null,
	@si_Sys nvarchar(2)=null,
	@si_ToMaster int=0,
	@si_ToHouse int=0,
	@si_Seed numeric(18,0)=0,
	@si_Type nvarchar(50)=null,
	@si_LineNo int=0,
	@si_Item nvarchar(6)=null,
	@si_Description nvarchar(100)=null,
	@si_BillTo  nvarchar(12)='',
	@si_ReturnTo nvarchar(12)='',
	@si_Currency nvarchar(6)='',
	@si_ExRate decimal(18,4)=null,
	@si_Percent decimal(18,3)=null,
	@si_QtyKind nvarchar(10)=null,
	@si_Quantity decimal(18,3)=null,
	@si_Min decimal(18,4)=null,
	@si_Rate decimal(18,3)=null,
	@si_Amount decimal(18,4)=null,
	@si_TaxKind nvarchar(6)='',
	@si_Tax nvarchar(6)='',
	@si_Remark nvarchar(6)='',
	@si_ShowIn nvarchar(6)='',
	@si_PPCC int=0,
	@CrDate nvarchar(30)= '',
	@LstDate nvarchar(30)= '',
	@si_Total decimal(18,3)=null,
	@si_Unit nvarchar(3)='',
	@si_User nvarchar(30)='',
	@str nvarchar(30)='',
	@imp_Clearance  nvarchar(30)='',
	@imp_Surrender  nvarchar(30)='',
	@imp_Warehouse nvarchar(30)='',
	@imp_StorageFrom datetime=null,
	@imp_StorageTo  datetime =null,
	@imp_PickupDate datetime =null
) as
begin
		if @Option='Single'
	    begin
			-- MBL Information
			select o_ROWID as RowID, o_Seed as seed, o_LotNo as LotNo, imp_LotNo as impNo,  o_MBL as MBL,o_ServiceMode as ServiceMode,o_PaymentMode as PPD,o_Sales as Salesman,
			o_ColoaderMBL as ColoaderMBL ,'' as Reference,imp_Clearance as Clearance,
			o_Carrier as Carrier,o_Shipper as Shipper,o_Consignee as Consignee,
			o_Discharge as Discharge ,o_Broker as Boroker,o_VesselID as Vessel,o_VoyageID as Voyage,o_LocPOL as Loading,o_LocPOD as Port,o_LocFinal as FinalDest,o_ETD as ETD,
			o_ETA as ETAdischarge,o_ETAFinal as ETAFinal, o_ATD as ATD ,o_ATA as ATA, o_Unit as Unit,
			o_WT as GWT,o_CWT as CWT,o_CBM as CBM,o_PKGS as Piece,o_Unit as Unit, o_CarrierATTN as Container,
			imp_Warehouse as WareHouse,imp_StorageFrom as FreeStorageStart,
			imp_StorageTo as FreeStorageEnd,imp_PickupDate as PickUp,isnull(o_IsDirect,0) as Direct
			from co_OCEAN  as A inner join co_import as B on A.o_Seed=B.imp_Seed  where  o_Type='MBL'  and o_seed=@o_Seed  -- and isnull(o_Active,'1')='1' 
			
			--HBL List  
			select B.o_ROWID as RowID, '<a target="_blank" href="../OceanShipmentJobList/OceanShipmentHouse.aspx?MBL='+Convert(nvarchar(50),B.o_ToMBL)+'&Seed='+Convert(nvarchar(30),B.o_Seed)+'">'+B.o_HBL+'</a>'  as HBL,
			 B.o_Consignee + case when isnull((select top 1 co_Name from cs_Company where co_Code =B.o_Consignee and  co_companykind = 'BASE'  and  co_STAT=B.o_STAT),'')='' then ''  else '   -   '+(select top 1 co_Name from cs_Company where co_Code =B.o_Consignee and  co_companykind = 'BASE'  and  co_STAT=B.o_STAT) end  as Consignee,
			 B.o_LocFinal as  Final ,B.o_ServiceMode as ServiceMode,B.o_CWT as CWT,B.o_CBM as  CBM ,B.o_PKGS as Pleces, B.o_PaymentMode as PPD 
			from co_OCEAN  as A inner join co_OCEAN as B  on  A.o_Seed =B.o_ToMBL  where  B.o_Type='HBL'  and  isnull(B.o_Active,'1')='1'  and B.o_ToMBL=@o_Seed
			
			
			--Local Invoice
			select inv_ROWID as RowID,inv_IsDN as DN,inv_IsCN as CN,
    		'<a  target="_blank" href="../../AirImport/AIShipmentJobList/invoice.aspx?sys='+convert(nvarchar,inv_sys)+'&FL='+convert(nvarchar,isnull(inv_ForeignLocal,'L'))+'&seed='+convert(nvarchar,inv_seed)+'">'+case when isnull(inv_InvoiceNo,'')='' then 'BLANK'  else  convert(nvarchar,inv_InvoiceNo) +'</a>' end as DN_CNNO, 
			--inv_InvoiceNo as DN_CNNO,
			inv_IsVoid as Void,inv_IsPrinted as [Print],
			inv_IsAC as AC,inv_CompanyCode as CompanyCode,inv_CompanyName as CompanyName,inv_Currency as Currency,inv_Total as Amount
			from co_Invoice as A inner join co_OCEAN as B on A.inv_ToMaster =B.o_Seed
			where    inv_ToMaster=@o_Seed  and --isnull(B.o_Active,'1')='1' and
			isnull(inv_Active,'1')='1'
			order by inv_CrDate desc 
			
			--Cost
			select si_ROWID as RowID, si_PPCC as PPD, si_BillTo as CompanyCode,si_BillTo as CompanyName,si_Item as Item,si_Description as [Description],si_Total as Total,si_QtyKind as CalcKind,si_Quantity as Qty,
			si_Unit as Unit,si_Currency as Currency,si_ExRate as EX,si_Rate as Rate,si_Amount as Amount
			from co_ShipmentItem AS A INNER JOIN co_OCEAN  as B ON A.si_ToMaster =B.o_seed 
			where A.si_ToMaster=@o_seed  --and isnull(B.o_active,'1')='1'
			order by si_CRDate desc 			
			
	    end
	    
	    if(@Option ='Void')
	    begin
			   Update co_OCEAN  set  o_Active='0', o_LstDate =getdate()  where  o_Seed=@o_Seed 
	    end
	    
	    if(@Option='Delete_HBL')
	    begin
			   Update co_OCEAN  set o_Active='0', o_LstDate =getdate()  where o_ToMBL=@o_Seed   and o_ROWID not in (select * from dbo.fn_ConvertListToTable(@ROWID,','))
	    end
	    
	     if(@Option='Delete_Invoice')
	    begin
			   Update co_Invoice set inv_Active='0', inv_LstDate =getdate()  where inv_ToMaster=@o_Seed   and inv_ROWID not in (select * from dbo.fn_ConvertListToTable(@ROWID,','))
	    end
	    
	     if(@Option='Delete_Cost')
	    begin
				delete co_ShipmentItem  where  si_ToMaster=@o_Seed   and   si_ROWID not in (select * FROM fn_ConvertListToTable(@ROWID,','))
	    end
	    
	    if(@Option='UpdateCost')
	   begin
			 if(not exists(select 1 from co_ShipmentItem where si_ROWID= @si_ROWID))
			begin
				-- 生成 Seed ID  
			   insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@User)
			   select @si_Seed=@@identity 
			   insert into co_ShipmentItem(si_PPCC,si_Type,si_Stat,si_Sys,si_ToMaster,si_Seed,si_BillTo,si_Item,si_Description,si_QtyKind,si_Quantity,si_Unit,si_Currency,si_ExRate,si_Rate,si_Amount,si_User,si_Total)
			   values(@si_PPCC,@si_Type,@si_Stat,@si_Sys,@si_ToMaster,@si_Seed,@si_BillTo,@si_Item,@si_Description,@si_QtyKind,@si_Quantity,@si_Unit,@si_Currency,@si_ExRate,@si_Rate,@si_Amount,@User,@si_Total) 
			end
			else
			begin
			   update  co_ShipmentItem set si_BillTo=@si_BillTo,si_Item=@si_Item,si_Description=@si_Description,si_QtyKind=@si_QtyKind,si_Quantity=@si_Quantity,
			   si_Unit=@si_Unit,si_Currency=@si_Currency,si_ExRate=@si_ExRate,si_Rate=@si_Rate,si_Amount=@si_Amount,si_Total=@si_Total,si_PPCC=@si_PPCC,
			   si_LstDate=GETDATE() where si_ROWID=@si_ROWID 
			end
	   end 
	   
	  if(@Option='UpdateMBL')
	 begin
	   if(exists(select 1 from co_OCEAN where o_Seed=@o_Seed))
		begin
		  update co_OCEAN set o_MBL=@o_MBL,o_ServiceMode=@o_ServiceMode,o_PaymentMode=@o_PaymentMode,o_Sales=@o_Sales,o_ColoaderMBL=@o_ColoaderMBL,
		  o_LocPOL=@o_LocPOL,o_LocPOD=@o_LocPOD,o_ETA=@o_ETA,o_ETAFinal=@o_ETAFinal,o_ATD=@o_ATD,o_ATA=@o_ATA,
		  o_LocFinal=@o_LocFinal,o_Carrier=@o_Carrier ,o_VesselID=@o_VesselID,o_VoyageID=@o_VoyageID,o_ETD=@o_ETD,--o_LotNo=@o_LotNo,
          o_Shipper=@o_Shipper,o_Consignee=@o_Consignee,o_Discharge=@o_Discharge,o_Broker=@o_Broker,o_WT=@o_WT,o_LstDate=getdate(),
		  o_CWT=@o_CWT,o_CBM=@o_CBM,o_PKGS=@o_PKGS,o_Unit=@o_Unit,o_CarrierATTN=@o_CarrierATTN,o_IsDirect=@o_IsDirect  where o_Seed=@o_Seed
		   --------  更新 Hawb ， Invoice          Author：Micro    2011-10-26 
    	  exec FW_AirImport_Update_SP @sys ='OI', @seed=@o_Seed,@Type='M'    
    	  --------
		  update co_Import set imp_Clearance=@imp_Clearance,imp_Surrender=@imp_Surrender , imp_Warehouse=@imp_Warehouse,imp_StorageFrom=@imp_StorageFrom,imp_StorageTo=@imp_StorageTo,imp_PickupDate=@imp_PickupDate
		  where imp_Seed=@o_Seed 
		  
		  select @o_Seed as o_Seed ,'N' as Flag
		end
		else
		begin
			declare @Date datetime ,@tempSeed nvarchar(30),@tempLotNo nvarchar(30)
		    insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@User)
			select @tempSeed=@@identity 
			select @Date=getdate()
			
			--（此处被修改 ，生成 LotNo      Author：   Micro    2011-10-09）
			-- select  @tempLotNo=dbo.fn_GetLotNo(@air_STAT,@air_SYS,@Date)   
			exec FW_BasicData_IDTable_SP @LotNo=@tempLotNo output,@code=@code,@date=@Date,@stat=@o_STAT,@User=@User
			---------------------------------------------------------------------------------------------------------------------------------------
			
			insert into co_Import(imp_Seed,imp_STAT,imp_SYS,imp_User,imp_CrDate,imp_Active,imp_Clearance,imp_LotNo,imp_Surrender,imp_Warehouse,imp_StorageFrom,imp_StorageTo,imp_PickupDate) 
			values(@tempSeed,@o_STAT,@o_SYS,@User,getdate(),'1',@imp_Clearance,@tempLotNo,@imp_Surrender,@imp_Warehouse,@imp_StorageFrom,@imp_StorageTo,@imp_PickupDate) 
			
			insert into co_OCEAN (o_Type,o_STAT,o_SYS,o_Seed,o_LotNo,o_MBL,o_ServiceMode,o_PaymentMode,o_Sales,o_ColoaderMBL, --Reference 
						     o_LocPOL,o_LocPOD,o_ETA,o_ETAFinal,o_ATD,o_ATA,   o_LocFinal,o_Carrier,o_VesselID,o_VoyageID,o_ETD, o_Shipper,o_Consignee,o_Discharge,o_Broker,o_WT, o_CWT,o_CBM,o_PKGS,o_Unit,o_CarrierATTN,o_IsDirect,o_Active,o_CrDate,o_User,o_isMBL,o_isHBL)
			values(@o_Type,@o_STAT,@o_SYS,@tempSeed,@tempLotNo,@o_MBL,@o_ServiceMode,@o_PaymentMode,@o_Sales,@o_ColoaderMBL,@o_LocPOL,@o_LocPOD,@o_ETA,@o_ETAFinal,@o_ATD,@o_ATA,@o_LocFinal,@o_Carrier,@o_VesselID,@o_VoyageID,@o_ETD, 
					   @o_Shipper,@o_Consignee,@o_Discharge,@o_Broker,@o_WT, @o_CWT,@o_CBM,@o_PKGS,@o_Unit,@o_CarrierATTN,@o_IsDirect,1,getdate(),@User,1,0)
			
			select @tempSeed as o_Seed,'Y'  as Flag
		end
	 end 
end
