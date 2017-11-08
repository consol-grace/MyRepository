USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_ComboBoxBinder_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[FW_BasicData_ComboBoxBinder_SP] 
		
	 @Option nvarchar(30)='',
	@STAT nvarchar(30)='',
	@SYS nvarchar(30)=''	
AS
BEGIN
	
	 if(@Option='CurrencyList')
	 begin
		select  distinct cur_Code as FieldText , cur_Code as FieldValue  from cs_Currency where cur_Active=1
	 end
	 
	 if(@Option='UnitList')
	 begin
		select distinct  unt_Code as FieldText, unt_Code as FieldValue from cs_Unit where unt_Active =1
	 end	 
	 
	 if(@Option='TypeList')
	 begin
	    select '' as [text],'' as [value] union
		select cfg_Code as [text],cfg_Value as [value]  from cs_systemString where cfg_Type = 'CO_TYPE'  and cfg_active = 1 --order by cfg_Index	
	 end
	 
	 if(@Option='SalesList')
	 begin
	    select '' as [text],'' as [value] union
		select sal_Description as [text], sal_code as [value] from cs_sales where sal_active = 1 and sal_STAT=@STAT		
	 end	
	 
	 if(@Option='GroupList')
	 begin
	   select '' as [text],'' as [value] union
	   select co_name as [text],co_code as [value] from cs_company where co_active = 1  and co_companykind = 'BASE' and co_STAT=@STAT
	   --order by co_name			
	 end
	 if(@Option='CompanyList')
	 begin
	   select '' as [text],'' as [value] union
	   select   top 300 co_name as [text],co_code as [value] from cs_company where co_active = 1  and co_companykind = 'BASE' and co_STAT = @STAT  and co_SYS like @SYS+'%'
	   order by [value]		
	 end
	 if(@Option='CompanyListByName')
	 begin
	   select '' as [text],'' as [value] union
	   select  top 300 co_name as [value],co_code as [text] from cs_company where co_active = 1  and co_companykind = 'BASE' and co_STAT = @STAT  and co_SYS like @SYS+'%'
	   order by [text]
	 end
	 if(@Option='LocationList')
	 begin
	   select '' as [text],'' as [value] union
	   select loc_code as [text], loc_code as [value] from cs_location where loc_stat = @STAT and loc_active = 1 and loc_SYS like @SYS+'%' --order by loc_code		
	 end
	 if @Option='CountryList'
	  begin
	   select '' as [text],'' as [value] union
	   select cy_Name as [text],cy_Code as [value] from cs_Country where cy_Active='1'
	 end
	 if(@Option='CurrencysList')
	 begin
	    --select '' as [text],'' as [value] union
		select cur_Description as [text] , cur_Code as [value]  from cs_Currency where cur_STAT=@STAT and  cur_Active=1 and  cur_SYS like @SYS+'%' 
	 end
	 if(@Option='CurrencysListLocal')
		select  cur_Code as [value] ,cur_Rate as [text]  from cs_currency where cur_sys= 'a'   and cur_active  = 1 and cur_isLocal = 1 and cur_buildIn = 1 and  cur_STAT=@STAT	-- and  --cur_SYS like @SYS+'%' 
					
	 if(@Option='UnitBinding')
	 begin
	    select '' as [text],'' as [value] union
		select unt_Description as [text], unt_Code as [value] from cs_Unit where unt_Active =1 and unt_STAT like @STAT+'%' --and isnull(unt_SYS,'O') LIKE  @SYS+'%'
	 end
	 if(@Option='ItemBinding')
	 begin
	    select '' as [text],'' as [value] union
		select itm_Description as [text], itm_Code as [value] from cs_Item where itm_Active =1 and itm_STAT like @STAT+'%' and itm_SYS like @SYS+'%' 
	 end	
	 if(@Option='QtyKindBinding')
	 begin
	    select '' as [text],'' as [value] union
		select qk_Name as [text], qk_Code as [value] from cs_QuantityKind where qk_Active =1 and qk_STAT like @STAT+'%' and qk_SYS like @SYS+'%' 
	 end	
	 if(@Option='DeptBinding')
	 begin
		select '' as [text], '' as [value] union select  'Base' as [text],'Base' as [value] union select 'AI' as [text],'AI' as [value] 
		union select 'AE' as [text],'AE' as [value] union select 'OI' as [text],'OI' as [value] union select 'OE' as [text],'OE' as [value]
		--sc_Dept as [text], sc_Dept as [value] from co_ShipmentContact where  sc_STAT like @STAT+'%' and sc_SYS like @SYS+'%' 
	 end
	 if(@Option='ForeignKind')
	 begin
	   select '' as [text], 0 as [value] union 
	   select cfg_Value as [text],cfg_index as [value] from cs_SystemString a  where cfg_Type='DNCN'
	   --inner join co_Invoice b on a.cfg_Index=b.inv_payment 
	 end
	 if(@Option='ShipKind')
	 begin
	  select '' as [text], '' as [value] union 
	  select dk_Short as [text],dk_Code as [value] from cs_DomesticKind 
	 end
	 if(@Option='CompanyKind')
	 begin
	   select '' as [text], '' as [value] union 
	   select cfg_Value as [text],cfg_Code as [value] from cs_SystemString a  where cfg_Type='CompanyKind'
	 end		
	 if(@Option='VesselList')
	 begin
		--select '' as [text],'' as [value] union
		select vs_Vessel as [text],vs_ROWID as [value] from co_Vessel  where vs_Active=1
	 end		 
	 if(@Option='VoyageList')
	 begin
		 	select voy_Voyage as [text],voy_ROWID as [value] from co_Vessel as A inner join  co_Voyage as B  on A.vs_Vessel=b.voy_Vessel where  voy_Active=1 and vs_RowID=@STAT 	ORDER BY  voy_Vessel DESC
	 end
	 if(@Option='PPCCList')
	 begin
		select  cfg_Code as [text] , cfg_Rowid as [value]  from cs_systemString where cfg_type = 'bl_paymode'  and cfg_Active=1 order by cfg_index
	 end
	 
	 if(@Option='ServerMode')
	 begin
		select  sm_Code as [value], sm_Description as [text] from cs_ServiceMode  where sm_stat =@STAT and sm_active = 1
	 end
	 
	 if(@Option='Company')
		begin
		 select  co_Code,co_Name,co_Contact,co_Phone,co_Fax,co_Email from cs_company where co_active = 1  and co_companykind = 'BASE' and co_STAT =@STAT   --and co_SYS like @SYS+'%'
		end
	 
	if(@Option='Description')	
	 begin
	  select '' as [text],'' as [value] union
	  select st_Text as [text],st_Short as [value] from cs_SavedText where isnull(st_Active,0)=1 and st_Stat like @STAT+'%' and  st_Sys like @SYS+'%'
	 end 
	 
	 if(@Option='ContainerSize')
	 begin
	   select oc_CtnrSize as [text],oc_CtnrSize as [value]
       from (select  distinct oc_CtnrSize from co_oceanContainer) a
	   --select '' as [text],'' as [value] union select '20G' as [text],'20G' as [value] union
	   --select '40G' as [text],'40G' as [value] union select '40H' as [text],'40H' as [value] 
	 end	 		 
	 		 
END
GO
