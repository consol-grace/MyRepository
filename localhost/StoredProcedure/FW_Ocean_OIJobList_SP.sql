USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_Ocean_OIJobList_SP]    Script Date: 10/22/2011 19:15:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[FW_Ocean_OIJobList_SP] 
		
	@Option nvarchar(30)='',
	@STAT nvarchar(30)='',
	@SYS nvarchar(30)='',
	@LotNo nvarchar(30)='',
	@MBL nvarchar(30)='',
	@POL nvarchar(30)='',
	@POD nvarchar(30)='',	
	@ETD nvarchar(30)='',
	@ETA nvarchar(30)='',
	@Vessel nvarchar(30)='',
	@seed  nvarchar(30)=''
AS
BEGIN  
	
	 if(@Option='OIJobList')
	 begin
		select c.*,d.voy_Vessel as Vessel,d.voy_Voyage as Voyage from (select o_ROWID  as RowID, o_ETD as ETD,o_ETA as ETA , o_seed as seed , '<a target="_blank"  href="../OceanLot/List.aspx?seed='+convert(nvarchar,o_seed)+'">' + convert(nvarchar,o_LotNo)+'</a>'  as LotNo,o_LocPOL as POL,o_LocPOD as POD,o_MBL as MBL,o_ServiceMode as ServiceMode,
		o_PaymentMode as PPCC ,o_VoyageID --,b.voy_Vessel as Vessel,b.voy_Voyage as Voyage
		from co_OCEAN as a inner join co_import as b on a.o_seed =b.imp_seed where o_Active=1 and o_isMBL=1  and isnull(o_LotNo,'') like @LotNo+'%' and isnull(o_MBL,'') like @MBL+'%'
		and isnull(o_LocPOL,'') like @POL+'%' and isnull(o_LocPOD,'') like @POD+'%' and case when isnull(@ETD,'')='' then '' else @ETD end<=Convert(varchar(8),o_ETD,112) 
		and case when isnull(@ETA,'')='' then '' else @ETA end<=Convert(varchar(8),o_ETA,112)  and isnull(o_STAT,'') like @STAT+'%' 
		and isnull(o_SYS,'') like @SYS+'%')as C left join co_Voyage as d on c.o_VoyageID=d.voy_ROWID where isnull(d.voy_Vessel,'') like @Vessel+'%' order by seed DESC
	 end	 
	 
	 if(@Option='ContainerList')
	 begin
			select b.* from co_OCEAN  as A ,co_OCEAN as B ,co_OceanContainer as C
			where A.o_Seed =B.o_ToMBL  and B.o_Type='HBL' and b.o_seed=c.oc_ToHBL and  b.o_stat=@stat   and b.o_sys=@sys  and  isnull(B.o_Active,'1')='1'  and B.o_ToMBL=@seed
	 end
	 
END
