USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_AirImport_Joblist_SP]    Script Date: 10/26/2011 15:38:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-27
-- Description: AirImport_Joblist 存储过程
-- =============================================
ALTER  procedure [dbo].[FW_AirImport_Joblist_SP](
    @Option nvarchar(50)='', -- 选项
	@air_ROWID int=0,
	@air_ID int=0,
	@air_STAT nvarchar(12) ='',
	@air_SYS nvarchar(2)='',
	@air_Seed numeric(18,0)=0,
	@air_Type int= 0,
	@air_ToMAWB int =0,
	@air_ToHAWB int=0,
	@CrDate nvarchar(30)= '',
	@LstDate nvarchar(30)= '',
	@User nvarchar(12)= '',
	@LastUser nvarchar(12)='',
	@air_MAWB nvarchar(20)='',
	@air_HAWB nvarchar(20)='',
	@air_LotNo nvarchar(20)='',
	@air_BookNo nvarchar(20)='',
	@air_AutoHAWB int=0,
	@air_IsMAWB   int=0,
    @air_IsHAWB int=0,
    @air_IsSub int=0,
    @air_IsUnder int=0,
    @air_IsDirect int=0,
    @air_IsColoadMAWB int=0,
    @air_IsColoadHAWB int=0,
    @air_IsManifest int=0,
    @air_Status int=0,
    @air_DG int =0,
    @air_Insurance int =0,
    @air_Sales nvarchar(12)='',
    @air_EReceipt  datetime=null,
    @air_AReceipt datetime=null,
    @air_FinalDate datetime=null,
    @air_ETD datetime=null,
    @air_ETA datetime=null,
    @air_ATA datetime=null,
	@air_ATD datetime=null,
	@air_Shipper nvarchar(12)='',
	@air_Consignee nvarchar(12)='',
	@air_Carrier nvarchar(12)='',
	@air_Broker nvarchar(12)='',
	@air_CoLoader nvarchar(12)='',
	@air_PartyA nvarchar(12)='',
	@air_PartyB nvarchar(12)='',
	@air_LocReceived nvarchar(3)='',
	@air_LocVia1 nvarchar(3)='',
	@air_LocVia2 nvarchar(3)='',
	@air_LocFinal nvarchar(3)='',
	@air_Flight nvarchar(10)='',
	@air_LocLoad  nvarchar(3)='',
	@air_LocDischarge nvarchar(3)='',
	@air_Airline nvarchar(12)='',
	@air_FlightNo int=0,
	@air_GWT numeric(18,2)=0,
	@air_VWT numeric(18,2)=0,
	@air_CWT numeric(18,2)=0,
	@air_Piece numeric(18,2)=0,
	@air_Unit nvarchar(3)='',
	@air_CBM numeric(18,2)=0,
	@air_Pallet  numeric(18,2)=0,
	@air_NP  nvarchar(1)='',
	@air_Rate  numeric(18,3)=0,
	@air_CompanyReferance nvarchar(100)='',
	@air_CSMode nvarchar(1)='',
	@air_SpecicalDeal nvarchar(1)='',
	@air_Oawbid  int=0,
	@air_Olkid   int=0,
	@air_Oawlink int=0,
	@air_Osnlink int=0,
	@air_Ocslink int=0,
	@air_Active int=0,
	@air_Normal int=0,
	@imp_Clearance nvarchar(20)='',
	@air_Remark nvarchar(2048)='',
	@STAT nvarchar(50)='',
	@imp_Surrender int=0,
	@imp_Warehouse nvarchar(12)='',
	@imp_StorageFrom datetime=null,
	@imp_StorageTo datetime=null, 
	@imp_FreeDays int =0,
	@str nvarchar(1000)=null,
	@code nvarchar(50)='',
	@imp_PickupDate datetime=null
) as
begin
    declare @tempLotNo varchar(30),@tempSeed varchar(30),@Date varchar(30)
	if @Option='List'
	begin		
			select air_ROWID as  RowID,air_IsDirect as Direct ,'<a  target="_blank"  href=mawb.aspx?seed='+cast(air_Seed as varchar)+'>'+ imp_LotNo +'</a>' as LotNo ,air_MAWB as MAWB ,
			air_Shipper + case when isnull((select top 1 co_Name from cs_Company where co_Code =air_Shipper and  co_companykind = 'BASE'  and  co_STAT=air_STAT),'')='' then ''  else '   -   '+(select top 1 co_Name from cs_Company where co_Code =air_Shipper and  co_companykind = 'BASE'  and  co_STAT=air_STAT) end  as Shipper,
			air_Consignee+case when isnull((select top 1 co_Name from cs_Company where co_Code =air_Consignee  and  co_companykind = 'BASE'  and  co_STAT=air_STAT),'')='' then ''  else '   -   '+(select top 1 co_Name from cs_Company where co_Code =air_Consignee  and  co_companykind = 'BASE'  and  co_STAT=air_STAT) end   as Consignee,
			air_Flight as Flight,air_ETA as Arrival ,air_LocLoad as [From],air_LocDischarge as [To],Convert(numeric(18,1),air_GWT) as  GWT ,air_CWT AS CWT
			,CASE WHEN air_Status > 0 THEN 1 ELSE 0 END AS Closed,case when isnull(air_Active,0)=0 then 1 else 0 end  as Void  
			from co_AIR  as A inner join co_import as B   on A.air_Seed=B.imp_Seed  
			where  isnull(convert(varchar(8),air_ETA,112),'') >=  isnull(convert(varchar(8),@air_ETD,112),'')  
			and (isnull(air_Shipper,'') like @air_Shipper+'%' or isnull(air_Consignee,'') like @air_Shipper+'%' )		
			and isnull(air_MAWB,'') like @air_MAWB+'%' 
			and (isnull(air_LocLoad,'') like @air_LocLoad+'%'  or isnull(air_LocDischarge,'') like @air_LocLoad+'%' )		
			and (@air_IsDirect = 1 and isnull(air_IsDirect,'0') = 1 or  @air_Normal = 1 and  isnull(air_IsDirect,'0') = 0) 
			and isnull(air_Active,'0') != @air_Active
			--  Closed  暂时不用 
			--  and (@air_Status = 3 and isnull(air_Status,'0') > 0 or @air_Status = 0 and isnull(air_Status,'0') = 0)
			and air_isMAWB=1 and air_SYS=@air_SYS  and air_STAT=@air_STAT   order by imp_LotNo desc				
	end
	--标头MAWB
	if @Option='MAWBByID'
	begin
	    select air_ROWID as RowID,imp_LotNo as LotNo,air_MAWB as MAWB,air_CompanyReferance as Reference,imp_Clearance as Clearance,air_CoLoader  as Coloader,air_Shipper as Shipper,
	    air_Consignee as Consignee,air_PartyA as Notify1,air_PartyB as Notify2,air_IsDirect as Direct,air_Broker as Discharge,air_Sales as Salesman,
	    air_GWT as GWT,air_VWT as VWT,air_CWT as CWT,air_Piece as Piece,air_Unit as Unit,air_Pallet as Pallet,air_Carrier as Carrier,air_Flight as FlightNo,
	    air_LocLoad as [From],air_LocDischarge as [To],air_ETD as ETD,air_ETA as ETA,air_ATD as ATD,air_ATA as ATA,air_Remark as Remark,
	    air_HAWB as HAWB,air_LocFinal as Final,air_Active as [Action]
	    from co_AIR  as A  inner  join co_import as B on A.air_Seed=B.imp_Seed   where air_seed=@air_ROWID --and isnull(air_Active,'1')='1'
	end
	
	--HAWBList
	if @Option='HAWBList'
	begin
	    select  air_RowID as RowID, air_Seed, air_Shipper as Shipper, 
	    air_Consignee+case when isnull((select top 1 co_Name from cs_Company where co_Code =air_Consignee  and  co_companykind = 'BASE'  and  co_STAT=air_STAT),'')='' then ''  else '   -   '+(select top 1 co_Name from cs_Company where co_Code =air_Consignee  and  co_companykind = 'BASE'  and  co_STAT=air_STAT) end   as Consignee,
	    --air_Consignee as Consignee,
	    air_GWT as GWT,air_VWT as VWT,air_CWT as CWT,air_Piece as Piece,air_Unit as Unit,air_Pallet as Pallet,
	    '<a target="_blank" href="Hawb.aspx?MAWB='+cast(air_ToMAWB as varchar)+'&seed='+cast(air_Seed as varchar)+'">'+air_HAWB+'</a>' as HAWB,air_LocFinal as Final,air_Active as [Action]
	    from co_AIR  where   air_Active=1  and  air_ToMAWB=@air_Seed   -- and  air_isMAWB=1
	end
	if @Option='UpdateMAWB'
	begin
	    if(exists(select 1 from co_AIR where air_seed=@air_ROWID))
	    begin
	    update co_AIR  set  air_MAWB=@air_MAWB,air_CompanyReferance=@air_CompanyReferance,air_CoLoader=@air_CoLoader,
	    air_Shipper=@air_Shipper,air_Consignee=@air_Consignee,air_PartyA=@air_PartyA,air_PartyB=@air_PartyB,air_Broker=@air_Broker,
	    air_Sales=@air_Sales,air_IsDirect=@air_IsDirect,
	    air_GWT=@air_GWT,air_VWT=@air_VWT,air_CWT=@air_CWT,air_Piece=@air_Piece,air_Unit=@air_Unit,air_Pallet=@air_Pallet,air_Carrier=@air_Carrier,
	    air_Flight=@air_Flight,air_LocLoad=@air_LocLoad, air_LocDischarge=@air_LocDischarge,air_ETD=@air_ETD,air_ETA=@air_ETA,air_ATD=@air_ATD,air_ATA=@air_ATA,
	    air_LastUser=@LastUser,air_LstDate=getdate(),air_Remark=@air_Remark where air_seed=@air_ROWID
	    --------  更新 Hawb ， Invoice          Author：Micro    2011-10-26 
	    exec FW_AirImport_Update_SP @sys ='AI', @seed=@air_Seed,@Type='M'    
	    --------
	    update co_Import set imp_Clearance=@imp_Clearance where imp_Seed=@air_Seed
   	    select '' as air_ROWID,'' as air_Seed,'' as air_LotNo
	    end
	    else
	    begin
	    insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@User)
	    select @tempSeed=@@identity 
	    
	    --修改sd_LotNo生成
	    if( isnull(@air_ATD,'')='' and isnull(@air_ATA,'')='')  set @Date=getdate()
	    else if  isnull(@air_ATA,'')<>'' set @Date=@air_ATA else set @Date=@air_ATD
	    
	    --（此处被修改 ，生成 LotNo      Author：   Micro    2011-10-09）
	    -- select  @tempLotNo=dbo.fn_GetLotNo(@air_STAT,@air_SYS,@Date)   
	    exec FW_BasicData_IDTable_SP @LotNo=@tempLotNo output,@code=@code,@date=@Date,@stat=@air_STAT,@User=@User
	    ---------------------------------------------------------------------------------------------------------------------------------------
	    insert into co_Import(imp_Seed,imp_STAT,imp_SYS,imp_User,imp_CrDate,imp_Active,imp_Clearance,imp_LotNo) 
	    values(@tempSeed,@air_STAT,@air_SYS,@User,getdate(),'1',@imp_Clearance,@tempLotNo) 
	    
	    insert into co_AIR(air_Seed,air_LotNo,air_MAWB,air_CompanyReferance,air_Broker,air_CoLoader,air_Shipper,
	    air_Consignee,air_PartyA,air_PartyB,air_IsDirect,air_Sales,
	    air_GWT,air_VWT,air_CWT,air_Piece,air_Unit,air_Pallet,air_Carrier,air_Flight,
	    air_LocLoad ,air_LocDischarge,air_ETD ,air_ETA,air_ATD,air_ATA,air_User,air_CrDate,air_Remark,air_STAT,air_SYS,air_Active,air_isMAWB,air_IsHAWB)
	    values(@tempSeed,@tempLotNo,@air_MAWB,@air_CompanyReferance,@air_Broker,@air_CoLoader,@air_Shipper,
	    @air_Consignee,@air_PartyA,@air_PartyB,@air_IsDirect,@air_Sales,
	    @air_GWT,@air_VWT,@air_CWT,@air_Piece,@air_Unit,@air_Pallet,@air_Carrier,@air_Flight,
	    @air_LocLoad ,@air_LocDischarge,@air_ETD ,@air_ETA,@air_ATD,@air_ATA,@User,getdate(),@air_Remark,@air_STAT,@air_SYS,1,1,0)
	    select @@identity  as air_ROWID,@tempSeed as air_Seed,@tempLotNo  as air_LotNo
	    end
	end
	if @Option='DeleteMAWB'
	begin
		update co_AIR set air_Active='0',air_LastUser=@LastUser,air_LstDate=getdate() where  air_ToMAWB=@air_ToMAWB and air_ROWID not in (select * from dbo.fn_ConvertListToTable(@str,','))
	end
	
	if @Option ='DeleteList'
	begin
		 update co_AIR set air_Active=@air_Active ,air_LastUser=@LastUser,air_LstDate=getdate() where air_Seed=@air_Seed --air_ROWID=@air_ROWID	 
		--update co_AIR SET air_Active='0' , air_LastUser=@LastUser,air_LstDate=getdate() where air_Seed=@air_Seed or air_ToMAWB =@air_Seed
		--Update co_Invoice set inv_Active='0', inv_LstDate =getdate() where inv_ToMaster=@air_Seed
		--Update co_ShipmentRoute set sr_Active='0',sr_LstDate =getdate() where sr_ToMaster=@air_Seed  
	end
	
	
	--- HAWB ----
	if @Option ='UpdateHAWB'
	begin
	    if(exists(select 1 from co_AIR where air_Seed=@air_Seed))
		begin
		     update co_air set 	air_HAWB=@air_HAWB, air_CompanyReferance=@air_CompanyReferance,air_CoLoader=@air_CoLoader, air_Sales=@air_Sales,
								air_Shipper=@air_Shipper,air_Consignee=@air_Consignee,air_PartyA=@air_PartyA,air_PartyB=@air_PartyB,air_Broker=@air_Broker,
								air_DG=@air_DG,air_Insurance=@air_Insurance,air_GWT=@air_GWT, air_VWT=@air_VWT, air_CWT=@air_CWT, air_Piece=@air_Piece, air_Unit=@air_Unit, air_Pallet=@air_Pallet,
								air_LocReceived=@air_LocReceived,air_LocFinal=@air_LocFinal,air_Remark=@air_Remark
		     WHERE air_Seed=@air_Seed
		     update co_Import set imp_Clearance=@imp_Clearance,imp_Surrender=@imp_Surrender , imp_Warehouse=@imp_Warehouse,imp_StorageFrom=@imp_StorageFrom,imp_StorageTo=@imp_StorageTo,imp_FreeDays=@imp_FreeDays,imp_PickupDate=@imp_PickupDate
		     where imp_Seed=@air_Seed 
	         --------  更新 Hawb ， Invoice          Author：Micro    2011-10-26 
    	     exec FW_AirImport_Update_SP @sys ='AI', @seed=@air_Seed,@Type='H'    
    	     --------
		     select @air_Seed as air_Seed ,'N' as Flag , @air_LotNo as LotNo
		end
		else		
		begin
			insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@User)
			select @tempSeed=@@identity 
		    
			--修改sd_LotNo生成
			select @Date=getdate()
			
		    --（此处被修改 ，生成 LotNo      Author：   Micro    2011-10-09）
			--select  @tempLotNo=dbo.fn_GetLotNo(@air_STAT,@air_SYS,@Date)  
			exec FW_BasicData_IDTable_SP @LotNo=@tempLotNo output,@code=@code,@date=@Date,@stat=@air_STAT,@User=@User
			---------------------------------------------------------------------------------------------------------------------------------------

			insert into co_Import(imp_Seed,imp_STAT,imp_SYS,imp_User,imp_CrDate,imp_Active,imp_Clearance,imp_LotNo,imp_Surrender,imp_Warehouse,imp_StorageFrom,imp_StorageTo,imp_FreeDays,imp_PickupDate) 
			values(@tempSeed,@air_STAT,@air_SYS,@User,getdate(),'1',@imp_Clearance,@tempLotNo,@imp_Surrender,@imp_Warehouse,@imp_StorageFrom,@imp_StorageTo,@imp_FreeDays,@imp_PickupDate) 
		    declare  @MawbNo  nvarchar(30)
		    select    @MawbNo=air_MAWB from co_AIR  WHERE air_seed=@air_ToMAWB		    
			insert into co_AIR(air_Seed,air_LotNo,air_HAWB,air_CompanyReferance,air_Insurance,air_LocReceived,air_LocFinal,air_Sales,air_DG,
			air_Shipper,air_Consignee,air_PartyA,air_PartyB,air_CoLoader,air_Broker,air_GWT,air_VWT,air_CWT,air_Piece,air_Unit,air_Pallet,
			air_User,air_CrDate,air_Remark,air_STAT,air_SYS,air_Active,air_ToMAWB,air_IsHAWB,air_MAWB,air_isMAWB)
			values(@tempSeed,@tempLotNo,@air_HAWB,@air_CompanyReferance,@air_Insurance,@air_LocReceived,@air_LocFinal,@air_Sales,@air_DG,
			@air_Shipper,@air_Consignee,@air_PartyA,@air_PartyB,@air_CoLoader,@air_Broker,@air_GWT,@air_VWT,@air_CWT,@air_Piece,@air_Unit,@air_Pallet,
			@User,getdate(),@air_Remark,@air_STAT,@air_SYS,1,@air_ToMAWB,1,@MawbNo,0)
	        --------  更新 Hawb ， Invoice          Author：Micro    2011-10-26 
    	    exec FW_AirImport_Update_SP @sys ='AI', @seed=@tempSeed,@Type='H'    
    	    --------
			select @tempSeed as air_Seed,'Y'  as Flag,@tempLotNo as LotNo
		end
	end
	
end
