USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_OceanImport_Container_SP]    Script Date: 10/22/2011 14:52:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[FW_OceanImport_Container_SP] 
	  @Option nvarchar(30)=''
      ,@oc_CtnrNo  nvarchar(30)=''
      ,@oc_CtnrSize nvarchar(10)=''
      ,@oc_SealNo nvarchar(20)=''
      ,@oc_STAT nvarchar(20)=''
      ,@oc_SYS nvarchar(20)=''
      ,@oc_ToHBL int=0
      ,@oc_Servicemode nvarchar(20)=''
      ,@oc_SONo  nvarchar(20)=''
      ,@oc_CBM decimal(18,3)=0
      ,@oc_GWT decimal(18,3)=0
      ,@oc_OrderNoOfPackage nvarchar(2000)=''
      ,@oc_OrderDescription nvarchar(2000)=''
      ,@oc_Active int=1
      ,@oc_LstDate datetime=null
      ,@oc_User nvarchar(30)=''
      ,@oc_Remark  nvarchar(1000)=''
      ,@oc_OrderMarks nvarchar(2000)=''
      ,@oc_Seed int=0
      ,@oc_ROWID int=0
      ,@oc_Piece decimal(18,3)=0
      ,@oc_Unit nvarchar(3)=''
      ,@st_ROWID int=0
      ,@st_Stat nvarchar(12)=''
      ,@st_Sys nvarchar(10)=''
      ,@st_Short nvarchar(100)=''
      ,@st_Text nvarchar(2048)=''
      ,@st_User nvarchar(12)=''
      ,@st_Active int=0
      ,@IDList nvarchar(200)=''
      ,@STAT nvarchar(20)=''
      ,@SYS nvarchar(10)=''
AS
BEGIN
	if(@Option='List')
	begin
		select oc_CtnrNo,oc_CtnrSize,oc_SealNo,oc_Servicemode,oc_SONo,oc_GWT,oc_CBM,oc_Piece,oc_Unit,
		oc_Remark,oc_OrderMarks,oc_OrderNoOfPackage,oc_OrderDescription,oc_Seed,oc_ToHBL,oc_Seed,oc_ROWID
		from co_OceanContainer where oc_ROWID=@oc_ROWID
	end
	if(@Option='Update')
	begin
		if(exists(select 1 from co_OceanContainer where oc_ROWID=@oc_ROWID))
		begin
			update co_OceanContainer set oc_CtnrNo=@oc_CtnrNo,oc_CtnrSize=@oc_CtnrSize,oc_SealNo=@oc_SealNo,oc_Servicemode=@oc_Servicemode,
			oc_SONo=@oc_SONo,oc_GWT=@oc_GWT,oc_CBM=@oc_CBM,oc_Remark=@oc_Remark,oc_OrderMarks=@oc_OrderMarks,oc_OrderNoOfPackage=@oc_OrderNoOfPackage,
			oc_OrderDescription=@oc_OrderDescription,oc_LstDate=getdate(),oc_User=@oc_User,oc_Piece=@oc_Piece,oc_Unit=@oc_Unit
			where oc_ROWID=@oc_ROWID
			select @oc_ROWID as RowID ,  'Update' as Flag 
		end
		else
		begin
		    insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@oc_User)		    
		    select @oc_Seed=@@identity 
		    
		    insert into co_OceanContainer(oc_CtnrNo,oc_CtnrSize,oc_SealNo,oc_Servicemode,oc_SONo,oc_GWT,oc_CBM,oc_Remark,oc_OrderMarks,
		    oc_OrderNoOfPackage,oc_OrderDescription,oc_CrDate,oc_User,oc_Seed,oc_ToHBL,oc_STAT,oc_SYS,oc_Piece,oc_Unit)	
		    values(@oc_CtnrNo,@oc_CtnrSize,@oc_SealNo,@oc_Servicemode,@oc_SONo,@oc_GWT,@oc_CBM,@oc_Remark,@oc_OrderMarks,
		    @oc_OrderNoOfPackage,@oc_OrderDescription,getdate(),@oc_User,@oc_Seed,@oc_ToHBL,@oc_STAT,@oc_SYS,@oc_Piece,@oc_Unit)	
		    select  @@identity as RowID, 'Insert' as Flag
		end
	end
	if(@Option='Delete')
	begin
	   --update co_OceanContainer set oc_Active=1 ,oc_LstDate=getdate(),oc_User=@oc_User where oc_ROWID=@oc_ROWID
	   delete from  co_OceanContainer where oc_ROWID=@oc_ROWID
	end
	if(@Option='DesList')
	begin
	  select st_ROWID,st_Text,st_Short from dbo.cs_SavedText 
	  where isnull(st_Active,0)=1 --and st_Stat like @st_Stat+'%' and  st_Sys like @st_Sys+'%'
	  order by st_CrDate desc
	end
	if(@Option='DesListOne')
	begin
	  select st_ROWID,st_Text,st_Short from dbo.cs_SavedText  where st_ROWID=@st_ROWID
	end
	if(@Option='DesUpdate')
	begin
	  if(exists(select 1 from dbo.cs_SavedText where st_ROWID=@st_ROWID))
	  begin
		update cs_SavedText set st_Text=@st_Text where st_ROWID=@st_ROWID
	  end
	  else
	  begin
	    insert into cs_SavedText(st_Stat,st_Sys,st_Short,st_Text,st_Active,st_CrDate,st_User)
	    values(@st_Stat,@st_Sys,@st_Short,@st_Text,1,getdate(),@st_User)
	  end
	end
	if(@Option='DesDelete')
	begin
	  --delete from  cs_SavedText where st_ROWID=@st_ROWID
	  update cs_SavedText set st_Active=0,st_LstDate=getdate(),st_User=@st_User where st_ROWID=@st_ROWID
	end
	
	--if(@Option='Description')	
	-- begin
	--  select '' as [text],'' as [value] union
	--  select st_Text as [text],st_Short as [value] from cs_SavedText where isnull(st_Active,0)=1 and st_Stat like @STAT+'%' and  st_Sys like @SYS+'%'
	-- end 
	if(@Option='GetContainerListByMBL')
	begin
        select o_LotNo,o_MBL,convert(varchar(10),o_ETD,120) as O_ETD from co_ocean where o_Seed=@oc_Seed
        select b.o_ETD,b.o_HBL,a.oc_ROWID,a.oc_CtnrNo,a.oc_SealNo,a.oc_SONo,a.oc_CtnrSize,a.oc_CBM,a.oc_GWT,a.oc_Piece
        from co_oceanContainer a inner join co_ocean  b
        on a.oc_ToHBL=b.o_Seed where  b.o_ToMBL=@oc_Seed
	end
	
	if(@Option='UpdateContainerListByMBL')
	begin
	  update co_oceanContainer set  oc_CtnrNo=@oc_CtnrNo,oc_SealNo=@oc_SealNo,oc_CtnrSize=@oc_CtnrSize,oc_SONo=@oc_SONo 
      where oc_ROWID in (select a from dbo.fn_ConvertListToTable(@IDList,','))
	end
	
	if @Option ='DeleteActual' 
	begin
		delete from co_oceanContainer where oc_ToHBL=@oc_Seed  and oc_ROWID  not in (select * from dbo.fn_ConvertListToTable(@IDList,','))
	end	
END
