USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_GROUP_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- Create date: 2011-08-02
-- Description: 群组 存储过程
-- =============================================
CREATE procedure [dbo].[FW_GROUP_SP](
    @Option nvarchar(50)='' -- 选项
	,@RowID numeric(18,0) = null   -- 自动编号
	,@RootID nvarchar(50) = null   -- 根群组编号
	,@ParentID nvarchar(50) = null   -- 上一级编号
	,@GroupID nvarchar(2000) = null   -- 群组编号
	,@NameCHS nvarchar(50) = null   -- 名称（中）
	,@NameENG nvarchar(50) = null   -- 名称（英）
	,@Remark nvarchar(250) = null   -- 备注
	,@Creator nvarchar(50) = null   -- 创建者
	,@CreateDate datetime = null   -- 创建时间
	,@Modifier nvarchar(50) = null   -- 修改者
	,@ModifyDate datetime = null   -- 修改时间
	,@IsDelete nvarchar(1) = null   -- 逻辑删除:Y=是,N=否
) as
begin
	if @Option='GroupRoot'
	begin
		select RowID, RootID, ParentID, GroupID, NameCHS, NameENG, Remark from FW_GROUP where IsDelete='N' and ParentID='0'
	end
	if @Option='GroupList'
	begin
		select RowID, RootID, ParentID, GroupID , NameCHS , NameENG, Remark from FW_GROUP where IsDelete='N' and RootID=@RootID
	end
	if @Option='GroupDetail'
	begin
		select A.RootID, A.ParentID, ISNULL((select top 1 NameCHS from FW_GROUP where GroupID=A.ParentID), '根') PNameCHS, A.GroupID, A.NameCHS, A.Remark from FW_GROUP A
		where A.GroupID=@GroupID
	end
	
	if @Option ='update' 
	begin
		if not exists(select 1 from FW_GROUP where GroupID=@GroupID)
		begin
			insert into FW_GROUP(RootID,ParentID,GroupID,NameCHS,NameENG,Remark,Creator) values(@RootID,@ParentID,@GroupID,@NameCHS,@NameENG,@Remark,@Creator)
		end
		else
		begin
			update FW_GROUP set RootID=@RootID,ParentID=@ParentID,NameCHS=@NameCHS,NameENG=@NameENG,Remark=@Remark,Modifier=@Modifier,ModifyDate=getdate() where GroupID=@GroupID
		end
	end
	
	if @Option ='delete' 
	begin
		update FW_GROUP set IsDelete='Y',Modifier=@Modifier,ModifyDate=GETDATE() 
		where GroupID in (select a from fn_ConvertListToTable(@GroupID,','))
	end
    --获取群组ID
    --declare @maxNo varchar(50),@newNo varchar(50)
	--select @maxNo=max(GroupID) from FW_GROUP where len(GroupID)=5 and  GroupID like 'GP'+'%' 
	--if isnull(@maxNo,'')='' set @newNo='GP001'
	--else set @newNo='GP'+right('00'+cast(cast(RIGHT(@maxNo,3) as int)+1 as varchar),3)
	--select @newNo
end
GO
