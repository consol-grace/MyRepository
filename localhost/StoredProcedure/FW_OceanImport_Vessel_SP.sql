
USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_OceanImport_Vessel_SP]    Script Date: 09/23/2011 15:19:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[FW_OceanImport_Vessel_SP] 
	  @Option nvarchar(30)=''
	  ,@voy_ROWID int=0
	  ,@vs_ROWID int =0
      ,@vs_Active int=0
      ,@vs_User	  nvarchar(12)=''
      ,@vs_Vessel nvarchar(30)=''
AS
BEGIN
	if(@Option='List')
	begin
		select top 20
		 b.vs_ROWID as vs_RowID,a.voy_ROWID as RowID,b.vs_Vessel as Vessel,a.voy_Voyage as Voyage 
		FROM co_Voyage a right  join co_Vessel b 
		on a.voy_Vessel =b.vs_Vessel
		--union 
		--select vs_RowID ,0 as RowID,vs_Vessel as Vessel ,'' as Voyage from co_Vessel
	end
	if(@Option='GetList')
	begin
	   if(@voy_ROWID=0)
	   begin
	     select b.vs_Vessel,b.vs_Active,b.vs_ROWID,'' as voy_Carrier,'' as voy_Voyage ,'' as voy_POL,'' as voy_POD,null as voy_Onboard,null as voy_ETD,null as voy_ETA,null as voy_CFS,null as voy_CY 
	      from co_Vessel b 
	      where vs_ROWID=@vs_ROWID
	   end
	   else
	   begin
	      select b.vs_Vessel,b.vs_Active,b.vs_ROWID,a.voy_Carrier,voy_Voyage ,voy_POL,voy_POD,voy_Onboard,voy_ETD,voy_ETA,voy_CFS,voy_CY 
	      from co_Voyage a inner join  co_Vessel b on a.voy_Vessel =b.vs_Vessel
	      where voy_ROWID=@voy_ROWID
	   end
	end
	
	if(@Option='Update')
	begin
		if(exists(select 1 from co_Vessel where vs_ROWID=@vs_ROWID))
		begin
			update co_Vessel set vs_Vessel=@vs_Vessel,vs_Active=@vs_Active,vs_LstDate=getdate() 
			where vs_ROWID=@vs_ROWID
		end
		else
		begin
		    insert into co_Vessel(vs_Vessel,vs_Active,vs_CrDate)	
		    values(@vs_Vessel,@vs_Active,getdate())	
		end
		
	end
	
END
