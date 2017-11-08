USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_AirImport_Invoice_SP]    Script Date: 10/26/2011 16:50:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-09-02
-- Description: 基本资料信息Invoice 存储过程
-- =============================================
ALTER  procedure [dbo].[FW_AirImport_Invoice_SP](  
    @Option nvarchar(50)='getInvoice', -- 选项
	@inv_ROWID  int =0,
	@inv_Stat nvarchar(12)='CON/HKG',
	@inv_Sys nvarchar(2)='AI',
	@inv_Seed numeric(18,0)=1772918,
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
    @inv_FlightNo nvarchar(30)='',
    @islocal varchar(1)='F',
    @cur_code nvarchar(20)='',    
    @code nvarchar(20)='3VIETECTW01',
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
	@inv_ForeignLocal nvarchar(1)=null,
	@inv_Pkgs float=0,
	@inv_UnitDesc nvarchar(30)='',
	@inv_IsCost  bit =0,
	@inv_User nvarchar(20)='' ,
	@str nvarchar(300)='',
	@inv_Ex float=null,
	@load nvarchar(10)=null,
	@final nvarchar(10)=null
	
) as
begin
	if @Option='List'
	begin
		select inv_ROWID as RowID, isnull(inv_IsDN,0)  as DN, isnull(inv_IsCN,0) as CN,'<a target="_blank" href="../../AirImport/AIShipmentJobList/invoice.aspx?sys='+convert(nvarchar,inv_sys)+'&FL='+convert(nvarchar,isnull(inv_ForeignLocal,'L'))+'&seed='+convert(nvarchar,inv_seed)+'">'+case when isnull(inv_InvoiceNo,'')='' then 'BLANK' ELSE convert(nvarchar,inv_InvoiceNo) end  +'</a>' as DN_CNNO,
					isnull(inv_IsVoid,0) as Void, isnull(inv_IsPrinted,0) as [Print],
					isnull(inv_IsAC,0)  as AC,inv_CompanyCode as CompanyCode,inv_CompanyName as CompanyName,inv_Currency as Currency,inv_Total as Amount
		from co_Invoice as B inner join co_Air as A on A.air_seed = B.inv_ToMaster
		where inv_ToMaster = @inv_seed   --A.air_Active='1' and
			and isnull(inv_Active,'1') = '1'
			and isnull(inv_isCost,'1') = '0'
		order by inv_CrDate desc 
	end
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
		delete from co_Invoice where inv_ToHouse=@inv_Seed and inv_Active=1 and inv_IsCost=1  and inv_ROWID not in (select * from dbo.fn_ConvertListToTable(@str,','))
	end	
	if @Option ='DeleteActive' 
	begin
		Update co_Invoice set inv_Active='0',inv_LstDate =getdate() where inv_ToMaster =@inv_ToMaster  and inv_ROWID  not in (select * from dbo.fn_ConvertListToTable(@str,','))
	end	
	
	
	if @Option='Currency'   --获取货币是否本地
	begin
		select cur_isForeign,cur_isLocal,cur_Rate from cs_Currency where cur_STAT=@inv_Stat and  cur_Active=1 and cur_code=@cur_code and  cur_SYS like @inv_Sys+'%' 
	end
	
	if @Option ='Item'
	begin		
		 if(@islocal='F')
		 begin
			select itm_ROWID,itm_Code,itm_Description,itm_FCalcQty as CalcQty,itm_FMin as [Min],itm_FRate as Rate,itm_FAmount as Amount,itm_FRound as [Round],itm_FMarkUp as MarkUp,itm_FMarkDown  as MarkDown from cs_Item where itm_Active =1 and itm_STAT =@inv_Stat and itm_SYS =@inv_SYS 
		 end
		 else
		 begin
			select itm_ROWID,itm_Code,itm_Description,itm_LCalcQty as CalcQty,itm_LMin as [Min],itm_LRate as Rat,itm_LAmount as Amount,itm_LRound as [Round],itm_LMarkUp as MarkUp,itm_LMarkDown  as MarkDown  from cs_Item where itm_Active =1 and itm_STAT =@inv_Stat and itm_SYS =@inv_SYS
		 end
		 
	end
	
	
	if @Option='InvoiceList'
	begin
		 select co_RowID as RowID, co_CODE as Code, co_Name as Company,co_Contact as Contact ,co_Phone as Phone,co_Fax as Fax,co_Address1 as [Address1],co_Address2 as [Address2],co_Address3 as [Address3],co_Address4 as [Address4] from cs_Company  where co_Code=@Code and co_CompanyKind=coalesce('bill','base') and co_STAT=@inv_Stat --and co_STAT=@inv_Stat and co_Active=1
		 select *    from  co_Air  where air_seed=@inv_Seed --and air_SYS='AI'
	end	
	
	if @Option='getInvoice'  --- 获取Invoice information
	begin
	   select co_RowID as RowID, co_CODE as Code, co_Name as Company,co_Contact as Contact ,co_Phone as Phone,co_Fax as Fax,co_Address1 as [Address1],co_Address2 as [Address2],co_Address3 as [Address3],co_Address4 as [Address4] from cs_Company  where co_Code=@Code and co_CompanyKind=coalesce('bill','base') and co_STAT=@inv_Stat --and co_STAT=@inv_Stat and co_Active=1
	   if(@inv_SYS='AI')
	   BEGIN	
		  --select * from co_air order by air_seed desc	   
		  select air_LotNo as LotNo,air_MAWB as M,air_HAWB as H,air_BookNo as Book,air_Sales as Sales,air_Shipper as Shipper , (select co_Name from cs_Company  where co_Code=air_Shipper and co_CompanyKind=coalesce('bill','base') and co_STAT=air_STAT) as ShipperName,
		  air_Consignee as Consignee,(select co_Name from cs_Company  where co_Code=air_Consignee and co_CompanyKind=coalesce('bill','base') and co_STAT=air_STAT) as ConsigneeName,air_Piece as Piece ,air_Unit as Unit,air_Pallet as Pallet,air_Remark as Remark,
		  case when isnull(air_LocReceived,'')='' then air_LocLoad  else air_LocReceived  end  as Depart , case when isnull(air_LocDischarge,'')='' then air_LocFinal else air_LocDischarge end  as Dest,
		  air_Carrier as Carrier,(select co_Name from cs_Company  where co_Code=air_Carrier and co_CompanyKind=coalesce('bill','base') and co_STAT=air_STAT) as CarrierName,air_Flight as Voyage,'' as vessel  ,convert(nvarchar(10),air_ETD,103) as ETD ,convert(nvarchar(10),air_ETA,103) as ETA,air_GWT as GWT, air_VWT as VWT,air_CWT as CWT
		  from  co_Air  where air_seed=@inv_Seed 
	   END		
	   ELSE IF(@inv_SYS='OI')
	   BEGIN
		 --select * from  co_ocean  order by o_seed desc  where o_seed=@inv_Seed 
		 select o_LotNo as LotNo,o_MBL as M,o_HBL as H,o_BookNo as Book,o_Sales as Sales,o_Shipper as Shipper , (select co_Name from cs_Company  where co_Code=o_Shipper and co_CompanyKind=coalesce('bill','base') and co_STAT=o_STAT) as ShipperName,
		 o_Consignee as Consignee,(select co_Name from cs_Company  where co_Code=o_Consignee and co_CompanyKind=coalesce('bill','base') and co_STAT=o_STAT) as ConsigneeName,o_PKGS as Piece ,O_Unit as Unit,o_CarrierATTN as Pallet,O_Remark as Remark,
		 case when isnull(o_LocReceipt,'')=''then o_locPol else o_LocReceipt end as Depart ,o_LocFinal as Dest,
		 o_Carrier as Carrier,(select co_Name from cs_Company  where co_Code=o_Carrier and co_CompanyKind=coalesce('bill','base') and co_STAT=o_STAT) as CarrierName,
		 (select vs_Vessel from co_Vessel where vs_RowID=O_VesselID and vs_Active=1) as vessel,
		 (select voy_Voyage from co_Voyage where voy_RowID=o_VoyageID and voy_Active=1 and voy_stat=o_stat ) as Voyage
		 ,convert(nvarchar(10),o_ETD,103) as ETD ,convert(nvarchar(10),o_ETA,103) as ETA,o_WT as GWT, o_CBM as VWT,o_CWT as CWT,inv_ForeignLocal=@inv_ForeignLocal
		 from  co_ocean  where o_seed=@inv_Seed 
	   END
	end
	
	

	if @Option ='CompanyName'
	begin
		 		 select  co_Name   from cs_Company  where co_Code=@Code and co_CompanyKind=coalesce('bill','base') and co_STAT=@inv_Stat
	end
	
	if @Option ='UpdateInvoice'
	begin
		 if(exists(select 1 from co_Invoice where inv_Seed=@inv_Seed))
		 begin
			update co_Invoice set inv_Address1=@inv_Address1,inv_Address2=@inv_Address1,inv_Address3=@inv_Address3,inv_Address4=@inv_Address4,inv_Phone=@inv_Phone,inv_Contact=@inv_Contact,inv_Fax=@inv_Fax,inv_InvoiceDate=@inv_InvoiceDate,inv_Tax=@inv_Tax,inv_CWT=@inv_CWT,inv_Remark=@inv_Remark,inv_Ex=@inv_Ex  where inv_Seed =@inv_Seed
			select @inv_Seed as 'inv_Seed'
		 end
		 else
		 begin
			insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@User)
			select @inv_seed=@@identity 
			insert into co_Invoice (inv_ToMaster,inv_seed,inv_Stat,inv_SYS,inv_CompanyCode,inv_CompanyName,inv_Address1,
			inv_Address2,inv_Address3,inv_Address4,inv_Phone,inv_Contact,inv_Fax,inv_InvoiceNo,	inv_LotNo,inv_MasterNo,inv_HouseNo,
			inv_Sales,inv_InvoiceDate,inv_Currency,inv_Tax,inv_Shipper,inv_ShipperLine,inv_Consignee,inv_ConsigneeLine,inv_Carrier,
			inv_Vessel,inv_Voyage,inv_ETD,inv_ETA,inv_GWT,inv_VWT,inv_CWT,inv_Pkgs,inv_WTUnit,inv_CrDate,inv_Remark,inv_User,inv_ToHouse,inv_IsCost,inv_FlightNo,inv_Active,inv_ForeignLocal,inv_Ex,inv_Receipt,inv_Load,inv_Discharge,inv_Final)		 
			values(@inv_ToMaster,@inv_seed,@inv_Stat,@inv_SYS,@inv_CompanyCode,@inv_CompanyName,@inv_Address1,@inv_Address2,@inv_Address3,
			@inv_Address4,@inv_Phone,@inv_Contact,@inv_Fax,@inv_InvoiceNo,@inv_LotNo,@inv_MasterNo,@inv_HouseNo,@inv_Sales,@inv_InvoiceDate,
			@inv_Currency,@inv_Tax,@inv_Shipper,@inv_ShipperLine,@inv_Consignee,@inv_ConsigneeLine,@inv_Carrier,@inv_Vessel,@inv_Voyage,@inv_ETD,
			@inv_ETA,@inv_GWT,@inv_VWT,@inv_CWT,@inv_Pkgs,@inv_UnitDesc,getdate(),@inv_Remark,@inv_User,@inv_ToHouse,@inv_IsCost,@inv_FlightNo,1,@inv_ForeignLocal,@inv_Ex,@load,@load,@final,@final)		
			select @inv_seed as 'inv_Seed'
		 end
	end
	
	if @Option ='Delete'
	begin
		 update  co_Invoice  set inv_IsVoid=1  where  inv_seed=@inv_seed
	end

end
