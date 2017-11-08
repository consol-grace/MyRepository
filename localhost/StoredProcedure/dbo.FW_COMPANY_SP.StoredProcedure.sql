USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_COMPANY_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-02
-- Description: ��˾ �洢����
-- =============================================
CREATE  procedure [dbo].[FW_COMPANY_SP](
     @Option varchar(50)='' -- ѡ��
	,@RowID numeric(18,0) = null   -- �Զ����
	,@CompanyID nvarchar(2000) = null   -- ��˾(�칫��)���
	,@NameCHS nvarchar(50) = null   -- ����(��)
	,@NameENG nvarchar(50) = null   -- ����(Ӣ)
	,@District nvarchar(150) = null   -- ����
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
  select RowID,CompanyID,NameCHS,NameENG,District from FW_COMPANY where IsDelete='N'
  end
  if @Option='Update'
  begin
   if(not exists(select 1 from FW_COMPANY where CompanyID=@CompanyID))
   begin
     insert into FW_COMPANY(CompanyID,NameCHS,NameENG,District,Remark,Creator) values(@CompanyID,@NameCHS,@NameENG,@District,@Remark,@Creator) 
   end
   else
   begin
     update FW_COMPANY set NameCHS=@NameCHS,NameENG=@NameENG,District=@District,Remark=@Remark,Modifier=@Modifier,ModifyDate=@ModifyDate 
			where CompanyID=@CompanyID
   end
  end
  if @Option='Delete'
  begin
    update FW_COMPANY set IsDelete='Y',Modifier=@Modifier,ModifyDate=GETDATE() 
    where CompanyID in (select a from fn_ConvertListToTable(@CompanyID,','))
  end
end
GO
