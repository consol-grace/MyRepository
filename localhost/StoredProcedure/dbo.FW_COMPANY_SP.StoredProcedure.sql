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
-- Description: 公司 存储过程
-- =============================================
CREATE  procedure [dbo].[FW_COMPANY_SP](
     @Option varchar(50)='' -- 选项
	,@RowID numeric(18,0) = null   -- 自动编号
	,@CompanyID nvarchar(2000) = null   -- 公司(办公室)编号
	,@NameCHS nvarchar(50) = null   -- 名称(中)
	,@NameENG nvarchar(50) = null   -- 名称(英)
	,@District nvarchar(150) = null   -- 区域
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
