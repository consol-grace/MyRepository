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
-- Description: ϵͳ���� �洢����
-- =============================================
Create procedure [dbo].[FW_CONFIGURATION_SP](
     @Option varchar(50)='' -- ѡ��
	,@RowID numeric(18,0) = null   -- �Զ����
	,@KeyName nvarchar(2000) = null   -- ����
	,@KeyValue nvarchar(50)=null       --��ֵ
	,@UserName nvarchar(50)=null       --�û���
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
