USE [USGROUP]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ConvertListToTable]    Script Date: 09/21/2011 17:26:04 ******/
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-02
-- Description: 根据分割类型返回一个表
-- =============================================
Create FUNCTION [dbo].[fn_ConvertListToTable](@strList nvarchar(2000),@strLimitor nvarchar(5))
RETURNs @temps TABLE (a nvarchar(100))
as
	begin 
	declare @i int 
	set @strList=rtrim(ltrim(@strList)) 
	set @i=charindex(@strLimitor,@strList) 

	while @i>=1
	begin
		 insert @temps values(left(@strList,@i-1)) 
			set @strList=substring(@strList,@i+1,len(@strList)-@i) 
			set @i=charindex(@strLimitor,@strList) 
	end 

	if @strList<>'' 
		insert @temps values(@strList) 
	return 


end
GO
