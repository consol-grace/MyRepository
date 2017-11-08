USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_Item_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Micro>
-- Create date: <Create Date,,2011-08-26>
-- Description:	<Description, Item基本信息管理>
-- =============================================
CREATE PROCEDURE [dbo].[FW_BasicData_Item_SP]
		
	   @Option nvarchar(30)='List'	
      ,@itm_ROWID  int =0
      ,@itm_ID   int =0
      ,@itm_STAT nvarchar(12)=''
      ,@itm_SYS  nvarchar(2)=''
      ,@itm_Code  nvarchar(6)=''
      ,@itm_Short  nvarchar(8)=''
      ,@itm_Description  nvarchar(30)=''
      ,@itm_FCurrency nvarchar(3)=''
      ,@itm_FCalcQty  nvarchar(8)=''
      ,@itm_FUnit nvarchar(3)=''
      ,@itm_FMin  decimal(18,3)=0
      ,@itm_FRate  decimal(18,3)=0
      ,@itm_FAmount decimal(18,3)=0
      ,@itm_FRound  smallint =0
      ,@itm_FMarkUp bit =0
      ,@itm_FMarkDown bit =0
      ,@itm_LCurrency nvarchar(3)=''
      ,@itm_LCalcQty nvarchar(8)=''
      ,@itm_LUnit  nvarchar(3)=''
      ,@itm_LMin  decimal(18,3)=0
      ,@itm_LRate decimal(18,4)=0
      ,@itm_LAmount  decimal(18,3)=0
      ,@itm_LRound  smallint =0
      ,@itm_LMarkUp bit=0
      ,@itm_LMarkDown bit=0
      ,@itm_Active bit =0
      ,@itm_CrDate datetime =null
      ,@itm_LstDate datetime =null
      ,@itm_User nvarchar(12)=''
AS
BEGIN
	
		if(@Option='List')
		begin
			if(isnull(@itm_ROWID,'')='')
			begin			
			select  itm_ROWID, itm_Code,itm_Short,itm_Description,itm_FUnit,itm_Active,
					  'By:'+itm_FCalcQty +'  Min:'+ Convert(nvarchar(10),itm_FMin)+'  Rate:'+ Convert(nvarchar(10),itm_FRate) as Fvalues ,itm_FRound,
					  'By:'+itm_LCalcQty +'  Min:'+ Convert(nvarchar(10),itm_LMin)+'  Rate:'+ Convert(nvarchar(10),itm_lRate) as Lvalues ,itm_LRound, itm_User 			  
					  from cs_Item where itm_STAT=@itm_STAT and itm_SYS=@itm_SYS
					  order by itm_ROWID
			end
			else
			begin
			select * from cs_Item where itm_ROWID=@itm_ROWID order by itm_ROWID
			end
		end	   
		
		if(@Option='AddModify') 
		begin
			if(exists(select 1 from cs_Item where itm_ROWID=@itm_ROWID))
			 -- Modify
			 begin 
				update cs_Item  set  
					  itm_Code=@itm_Code, 
					  itm_Short=@itm_Short,
					  itm_Description=@itm_Description,
					  itm_FCurrency=@itm_FCurrency,
					  itm_FCalcQty=@itm_FCalcQty,
					  itm_FUnit=@itm_FUnit,
					  itm_FMin=@itm_FMin,
					  itm_FRate=@itm_FRate,
					  itm_FAmount=@itm_FAmount,
					  itm_FRound=@itm_FRound,
					  itm_FMarkUp=@itm_FMarkUp,
					  itm_FMarkDown=@itm_FMarkDown,
					  itm_LCurrency=@itm_LCurrency,
					  itm_LCalcQty=@itm_LCalcQty,
					  itm_LUnit=@itm_LUnit,
					  itm_LMin=@itm_LMin,
					  itm_LRate=@itm_LRate,
					  itm_LAmount=@itm_LAmount,
					  itm_LRound=@itm_LRound,
					  itm_LMarkUp=@itm_LMarkUp,
					  itm_LMarkDown=@itm_LMarkDown,
					  itm_Active=@itm_Active,
					  --itm_CrDate=getdate(),
					  itm_LstDate=getdate(),
					  itm_User=@itm_User
				where itm_ROWID=@itm_ROWID
			end
			else
			begin  -- Insert
				     insert into  cs_Item  (itm_Code,itm_Short,itm_Description,itm_FCurrency,
					  itm_FCalcQty,itm_FUnit,itm_FMin,itm_FRate,itm_FAmount,itm_FRound,
					  itm_FMarkUp,itm_FMarkDown,itm_LCurrency,itm_LCalcQty, itm_LUnit,
					  itm_LMin,itm_LRate,itm_LAmount,itm_LRound,itm_LMarkUp,itm_LMarkDown,
					  itm_Active, itm_CrDate,itm_User,itm_STAT,itm_SYS) 
					  values (@itm_Code, @itm_Short,@itm_Description,@itm_FCurrency,
					  @itm_FCalcQty,@itm_FUnit,@itm_FMin,@itm_FRate,@itm_FAmount,@itm_FRound,
					  @itm_FMarkUp,@itm_FMarkDown,@itm_LCurrency,@itm_LCalcQty,@itm_LUnit,
					  @itm_LMin,@itm_LRate,@itm_LAmount,@itm_LRound,@itm_LMarkUp,@itm_LMarkDown,
					  @itm_Active,getdate(),@itm_User,@itm_STAT,@itm_SYS)					  
			end
		end
END
GO
