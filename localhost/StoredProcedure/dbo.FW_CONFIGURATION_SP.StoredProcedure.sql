USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_CONFIGURATION_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-02
-- Description: 系统配置 存储过程
-- =============================================
Create procedure [dbo].[FW_CONFIGURATION_SP](
     @Option varchar(50)='' -- 选项
	,@RowID numeric(18,0) = null   -- 自动编号
	,@KeyName nvarchar(2000) = null   -- 键名
	,@KeyValue nvarchar(50)=null       --键值
	,@UserName nvarchar(50)=null       --用户名
	,@Remark nvarchar(250) = null   -- 备注
	,@Creator nvarchar(50) = null   -- 创建者
	,@CreateDate datetime = null   -- 创建时间
	,@Modifier nvarchar(50) = null   -- 修改者
	,@ModifyDate datetime = null   -- 修改时间
	,@IsDelete nvarchar(1) = null   -- 逻辑删除:Y=是,N=否
) as
begin
 if @Option='GetList'
  begin
  select RowID,KeyName,KeyValue,UserName,Remark from FW_CONFIGURATION where IsDelete='N'
  end
  if @Option='Update'
  begin
   if(not exists(select 1 from FW_CONFIGURATION where KeyName=@KeyName))
   begin
     insert into FW_CONFIGURATION(KeyName,KeyValue,Remark,Creator) values(@KeyName,@KeyValue,@Remark,@Creator) 
   end
   else
   begin
     update FW_CONFIGURATION set KeyValue=@KeyValue,Remark=@Remark,Modifier=@Modifier,ModifyDate=@ModifyDate 
			where KeyName=@KeyName
   end
  end
  if @Option='Delete'
  begin
    update FW_CONFIGURATION set IsDelete='Y',Modifier=@Modifier,ModifyDate=GETDATE() 
    where KeyName in (select a from fn_ConvertListToTable(@KeyName,','))
  end
end
GO
