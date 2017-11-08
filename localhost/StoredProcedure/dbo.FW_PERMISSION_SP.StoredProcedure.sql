USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_PERMISSION_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-02
-- Description: 权限 存储过程
-- =============================================
CREATE procedure [dbo].[FW_PERMISSION_SP](
     @Option varchar(50)='' -- 选项
	,@RowID numeric(18,0) = null   -- 自动编号
	,@PermissionID nvarchar(2000) = null   -- 权限编号
	,@NameCHS nvarchar(50) = null   -- 名称(中)
	,@NameENG nvarchar(50) = null   -- 名称(英)
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
  select RowID,PermissionID,NameCHS,NameENG from FW_PERMISSION where IsDelete='N'
  end
  if @Option='Update'
  begin
   if(not exists(select 1 from FW_PERMISSION where PermissionID=@PermissionID))
   begin
     insert into FW_PERMISSION(PermissionID,NameCHS,NameENG,Remark,Creator) values(@PermissionID,@NameCHS,@NameENG,@Remark,@Creator) 
   end
   else
   begin
     update FW_PERMISSION set NameCHS=@NameCHS,NameENG=@NameENG,Remark=@Remark,Modifier=@Modifier,ModifyDate=@ModifyDate 
			where PermissionID=@PermissionID
   end
  end
  if @Option='Delete'
  begin
    update FW_PERMISSION set IsDelete='Y',Modifier=@Modifier,ModifyDate=GETDATE() 
    where PermissionID in (select a from fn_ConvertListToTable(@PermissionID,','))
  end
  --权限ID
    --declare @maxNo varchar(50),@newNo varchar(50)
	--select @maxNo=max(PermissionID) from FW_PERMISSION where PermissionID like 'PER'+'%' 
	--if isnull(@maxNo,'')='' set @newNo='PER0001'
	--else set @newNo='PER'+right('000'+cast(cast(RIGHT(@maxNo,4) as int)+1 as varchar),4)
    --select @newNo
end
GO
