USE [USGROUP]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetLotNo]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-09-05
-- Description: 
-- =============================================
CREATE FUNCTION [dbo].[fn_GetLotNo](@stat nvarchar(20),@sys nvarchar(20),@date Datetime)
RETURNs nvarchar(100)
as
	begin 
	declare @LotNo nvarchar(30),@maxLotNo nvarchar(30),@ATA varchar(30)
	
	set @ATA=left(convert(varchar(6),@date,12),4)

	set @stat=right(@stat,3)
	
	if (len(@sys)<>2) set @sys='AI'
	
	set @LotNo=''
	set @maxLotNo=''
	select @maxLotNo=max(imp_LotNo) from co_Import where left(imp_LotNo,9)=@Stat+@sys+@ATA
	if(len(@maxLotNo)>1)
	begin
	  set @LotNo=@Stat+@sys+@ATA+ right('00'+cast((cast(right(@maxLotNo,3) as int)+1) as varchar) ,3)
	end
	else
	begin
	  set  @LotNo=@Stat+@sys+@ATA+'001'
	end
    return @LotNo
end
GO
