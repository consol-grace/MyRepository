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
-- Description: Ȩ�� �洢����
-- =============================================
CREATE procedure [dbo].[FW_PERMISSION_SP](
     @Option varchar(50)='' -- ѡ��
	,@RowID numeric(18,0) = null   -- �Զ����
	,@PermissionID nvarchar(2000) = null   -- Ȩ�ޱ��
	,@NameCHS nvarchar(50) = null   -- ����(��)
	,@NameENG nvarchar(50) = null   -- ����(Ӣ)
	,@Remark nvarchar(250) = null   -- ��ע
	,@Creator nvarchar(50) = null   -- ������
	,@CreateDate datetime = null   -- ����ʱ��
	,@Modifier nvarchar(50) = null   -- �޸���
	,@ModifyDate datetime = null   -- �޸�ʱ��
	,@IsDelete nvarchar(1) = null   -- �߼�ɾ��:Y=��,N=��
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
  --Ȩ��ID
    --declare @maxNo varchar(50),@newNo varchar(50)
	--select @maxNo=max(PermissionID) from FW_PERMISSION where PermissionID like 'PER'+'%' 
	--if isnull(@maxNo,'')='' set @newNo='PER0001'
	--else set @newNo='PER'+right('000'+cast(cast(RIGHT(@maxNo,4) as int)+1 as varchar),4)
    --select @newNo
end
GO
