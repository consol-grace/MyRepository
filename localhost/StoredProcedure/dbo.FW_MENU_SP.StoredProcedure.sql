USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_MENU_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-02
-- Description: 菜单 存储过程
-- =============================================
CREATE procedure [dbo].[FW_MENU_SP](
    @Option nvarchar(50)='' -- 选项
	,@IDlist varchar(8000) = null
	,@RowID numeric(18,0) = null   -- 自动编号
	,@RootID nvarchar(50) = null   -- 根菜单编号
	,@ParentID nvarchar(50) = null   -- 上一级编号
	,@MenuID nvarchar(2000) = null   -- 菜单编号
	,@NameCHS nvarchar(50) = null   -- 名称（中）
	,@NameENG nvarchar(50) = null   -- 名称（英）
	,@Hyperlink nvarchar(250)=null  --菜单超链接
	,@OrderBy numeric(18,2)=100.00  -- 排序
	,@LevelIndex int = null             --菜单级别
	,@Remark nvarchar(250) = null   -- 备注
	,@Creator nvarchar(50) = null   -- 创建者
	,@CreateDate datetime = null   -- 创建时间
	,@Modifier nvarchar(50) = null   -- 修改者
	,@ModifyDate datetime = null   -- 修改时间
	,@IsDelete nvarchar(1) = null   -- 逻辑删除:Y=是,N=否
) as
begin
	if @Option='MenuRoot'
	begin
		select RowID, RootID, ParentID, MenuID, NameCHS, NameENG, Hyperlink,Remark from FW_MENU where IsDelete='N' and ParentID='0'
		order by OrderBy
	end
	if @Option='MenuList'
	begin
		select RowID, RootID, ParentID, MenuID , NameCHS , NameENG,Hyperlink, Remark from FW_MENU where IsDelete='N' and RootID=@RootID
		order by OrderBy
	end
	if @Option='MenuDetail'
	begin
		select RootID,ParentID,MenuID,NameCHS,NameENG,Hyperlink,OrderBy,LevelIndex,Remark from FW_MENU 
		where MenuID=@MenuID 
	end
	
	if @Option ='update' 
	begin
		if not exists(select 1 from FW_MENU where MenuID=@MenuID)
		begin
			insert into FW_MENU(RootID,ParentID,MenuID,NameCHS,NameENG,Hyperlink,OrderBy,LevelIndex,Remark,Creator) 
			values(@RootID,@ParentID,@MenuID,@NameCHS,@NameENG,@Hyperlink,@OrderBy,@LevelIndex,@Remark,@Creator)
		end
		else
		begin
			update FW_MENU set RootID=@RootID,ParentID=@ParentID,NameCHS=@NameCHS,NameENG=@NameENG,Hyperlink=@Hyperlink,OrderBy=@OrderBy,LevelIndex=@LevelIndex,Remark=@Remark,Modifier=@Modifier,ModifyDate=getdate() 
			where MenuID=@MenuID
		end
	end
	
	if @Option ='delete' 
	begin
		update FW_MENU set IsDelete='Y',Modifier=@Modifier,ModifyDate=GETDATE() 
		where MenuID in (select a from fn_ConvertListToTable(@MenuID,','))      
	end
    if @Option='user-get-menu'
	begin
		select RowID,RootID,ParentID,MenuID,NameCHS,NameENG,Hyperlink,OrderBy,LevelIndex,Remark,Creator,CreateDate,Modifier,ModifyDate,IsDelete
		from FW_MENU where IsDelete='N' and ParentID='0' and charindex(','+MenuID+',', ','+@IDlist+',')>0

		select RowID,RootID,ParentID,MenuID,NameCHS,NameENG,Hyperlink,OrderBy,LevelIndex,Remark,Creator,CreateDate,Modifier,ModifyDate,IsDelete
		from FW_MENU where IsDelete='N' and ParentID<>'0' and charindex(','+MenuID+',', ','+@IDlist+',')>0
	end
end
GO
