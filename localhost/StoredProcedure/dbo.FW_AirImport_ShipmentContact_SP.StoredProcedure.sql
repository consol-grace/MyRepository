USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_AirImport_ShipmentContact_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE [dbo].[FW_AirImport_ShipmentContact_SP]
	  @Option nvarchar(30)=''
	  ,@sc_ROWID int =0      
      ,@sc_Parent int =0
      ,@sc_Stat nvarchar(12)=''
      ,@sc_Sys  nvarchar(2)=''
      ,@sc_Seed int =0
      ,@sc_ToMaster int =0
      ,@sc_ToHouse int =0
      ,@sc_Type nvarchar(20) =''
      ,@sc_Company  nvarchar(12)=''
      ,@sc_Dept   nvarchar(12) =''
      ,@sc_Contact nvarchar(43)=''
      ,@sc_mobile  nvarchar(43)=''
      ,@sc_Email  nvarchar(43)=''
      ,@sc_Address1  nvarchar(43)=''
      ,@sc_Address2  nvarchar(43)=''
      ,@sc_Address3  nvarchar(43)=''
      ,@sc_Address4  nvarchar(43)=''
      ,@sc_Phone  nvarchar(43)=''
      ,@sc_Fax    nvarchar(43)=''
      ,@sc_Country  nvarchar(3)=''
      ,@sc_Date  datetime =null
      ,@sc_Time  datetime =null
      ,@sc_Remark  nvarchar(1024)=''
      ,@sc_CrDate  datetime=null
      ,@sc_LstDate  datetime=null
      ,@sc_User  nvarchar(12)='',
      @str nvarchar(300)=''
AS
BEGIN
	 if(@Option='Update')
	 begin
		if(exists(select 1 from co_ShipmentContact where sc_RowID=@sc_RowID))
		begin
			update co_ShipmentContact set sc_Type=@sc_Type,sc_Company=@sc_Company, sc_Dept=@sc_Dept
			where sc_RowID=@sc_RowID
		end
		else
		begin
			 -- Éú³É Seed ID  
		     insert into cs_Seed(sd_CrDate,sd_User) values(getdate(),@sc_User)
		     select @sc_Seed=@@identity 
			 insert into co_ShipmentContact(sc_Type,sc_Company,sc_Dept,sc_Stat,sc_Sys,sc_Seed,sc_ToHouse)
			 values(@sc_Type,@sc_Company,@sc_Dept,@sc_Stat,@sc_Sys,@sc_Seed,@sc_ToHouse)
		end		
	 end
	 if @Option ='DeleteActual' 
	 begin
		delete from co_ShipmentContact where sc_ToHouse=@sc_Seed and sc_RowID not in (select * from dbo.fn_ConvertListToTable(@str,','))
	 end	
END
GO
