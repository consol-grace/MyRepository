USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_OceanImport_Voyage_SP]    Script Date: 09/23/2011 14:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[FW_OceanImport_Voyage_SP] 
	
	  @Option nvarchar(30)='Single'
	  ,@voy_ROWID int=0
      ,@voy_ID  int =0
      ,@voy_Parent  int =null
      ,@voy_Stat  nvarchar(12)=null
      ,@voy_Sys   nvarchar(2) =null
      ,@voy_Status  nchar(1)=null
      ,@voy_Vessel  nvarchar(30)=null
      ,@voy_Voyage   nvarchar(20)=null
      ,@voy_Carrier  nvarchar(12)=null
      ,@voy_Discharge  nvarchar(12)=null
      ,@voy_POL  nvarchar(3)=null
      ,@voy_POD  nvarchar(3)=null
      ,@voy_Date  datetime=null
      ,@voy_Onboard   datetime=null
      ,@voy_Sailing   datetime=null
      ,@voy_CFS   datetime =null
      ,@voy_CY    datetime =null
      ,@voy_ETD   datetime =null
      ,@voy_ETA   datetime =null
      ,@voy_CLOSE  datetime=null
      ,@voy_PORT1  nvarchar(3)=null
      ,@voy_PORT2  nvarchar(3)=null
      ,@voy_PORT3  nvarchar(3)=null
      ,@voy_ONBOARD1  datetime =null
      ,@voy_ONBOARD2  datetime =null
      ,@voy_ONBOARD3  datetime =null
      ,@voy_Remark    nvarchar(1024)=null
      ,@voy_Active	  bit=0	
      ,@voy_CrDate	  datetime=null	
      ,@voy_LstDate	  datetime=null	
      ,@voy_User	  nvarchar(12)=null
      ,@vr_ROWID	  int =null
      ,@vr_ToVoyage	  int =null
      ,@vr_OrderID	  int =null
      ,@vr_POL		  nvarchar(3)=null	
      ,@vr_POD		  nvarchar(3)=null	
      ,@vr_ETD		  datetime=null	
      ,@vr_ETA		  datetime=null		
AS
BEGIN
	if(@Option='List')
	begin
		select  voy_ROWID as RowID,  voy_Voyage as Voyage,voy_ETD as ETD,voy_POL as POL,voy_POD as POD FROM co_Voyage  as A 
		inner join co_Vessel as B  on A.voy_Parent=B.vs_RowID 
		WHERE  voy_Vessel = @voy_Vessel  order by voy_voyage asc
	end
	
	if(@Option ='Single')
	begin
		if(exists(select 1 from co_Voyage where voy_ROWID=@voy_ROWID))
		begin
			select voy_ROWID,voy_Vessel,voy_Voyage,voy_POL,voy_POD,voy_Onboard,voy_CFS,voy_CY,voy_ETD,voy_ETA, voy_Active FROM co_Voyage  where voy_ROWID=@voy_ROWID
    		select vr_ROWID as RowID,vr_POL as POL,vr_POD as POD,vr_ETD as ETD,vr_ETA as ETA from co_VoyageRoute where vr_ToVoyage=@voy_ROWID
		end
		else
		begin
			select '' as voy_ROWID,'' as voy_Vessel,'' as voy_Voyage,'' as voy_POL,'' as voy_POD,'' as voy_Onboard,'' as voy_CFS,'' as voy_CY,'' as voy_ETD,'' as voy_ETA,'True' as  voy_Active
    		select vr_ROWID as RowID,vr_POL as POL,vr_POD as POD,vr_ETD as ETD,vr_ETA as ETA from co_VoyageRoute where vr_ToVoyage=@voy_ROWID
		end
	end	
	
	if(@Option='Update')
	begin
		if(exists(select 1 from co_Voyage where voy_ROWID=@voy_ROWID))
		begin
			update co_Voyage set voy_Voyage=@voy_Voyage,voy_POL=@voy_POL,voy_POD=@voy_POD,voy_ETD=@voy_ETD,voy_ETA=@voy_ETA,voy_Onboard=@voy_Onboard,voy_CFS=@voy_CFS,voy_CY=@voy_CY,voy_Active=@voy_Active,voy_LstDate=getdate() 
			where voy_ROWID=@voy_ROWID
			select @voy_ROWID as RowID
		end
		else
		begin
		    insert into co_Voyage(voy_Parent,voy_Stat,voy_Sys,voy_Vessel,voy_Voyage,voy_POL,voy_POD,voy_Onboard,voy_ETD,voy_ETA,voy_CFS,voy_CY,voy_Active,voy_CrDate,voy_User,voy_Status)	
		    values(@voy_Parent,@voy_Stat,@voy_Sys,@voy_Vessel,@voy_Voyage,@voy_POL,@voy_POD,@voy_Onboard,@voy_ETD,@voy_ETA,@voy_CFS,@voy_CY,@voy_Active,getdate(),@voy_User,1)	
		    select @@identity as RowID
		end	
	end
	
	if(@Option='UpdateList')
	begin
		--if(exists(select 1 from co_VoyageRoute where vr_ROWID=@vr_ROWID))
		--begin
			--update co_VoyageRoute set vr_POL=@vr_POL,vr_POD=@vr_POD,vr_ETD=@vr_ETD,vr_ETA=@vr_ETA,vr_LstDate=GETDATE(),vr_User=@voy_User where vr_ROWID=@vr_ROWID
		--end
		--else
		--begin
			insert into co_VoyageRoute (vr_Tovoyage, vr_OrderID,  vr_POL,vr_POD,vr_ETD,vr_ETA,vr_CrDate,vr_User) values(@vr_Tovoyage,@vr_OrderID,@vr_POL,@vr_POD,@vr_ETD,@vr_ETA,getDate(),@voy_User)
	end	
	
	if(@Option='DeleteAll')
	begin
			--删除所有，重新插入
	    	delete co_VoyageRoute where vr_Tovoyage=@vr_Tovoyage
	end
	
	
END
