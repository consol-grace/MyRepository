USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_FRAMEWORK_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Richard       QQ: 1055210005       MSN: richard@diygens.com       Email: richard@diygens.com       WebSite: http://frame.diygens.com
-- Create date: 2011-03-18
-- Description: Framework �洢����
-- =============================================
CREATE procedure [dbo].[FW_FRAMEWORK_SP](@Option varchar(50)='list' -- ѡ��
	,@IDlist varchar(8000) = null
	,@CompanyID nvarchar(50) = null -- ��˾ID
	,@UserName nvarchar(50) = null -- �û���
	,@GroupID nvarchar(50) = null   -- Ⱥ��ID
	,@MenuID nvarchar(50) = null   -- �˵�ID
	,@Remark nvarchar(250) = null   -- ��ע                          
	,@Creator nvarchar(50) = null   -- ������                        
	,@CreateDate datetime = null   -- ����ʱ��                      
	,@Modifier nvarchar(50) = null   -- �޸���                        
	,@ModifyDate datetime = null   -- �޸�ʱ��                      
	,@IsDelete nvarchar(1) = null   -- �߼�ɾ��:Y=��,N=��
	,@RowIDs varchar(8000) = null     
) as
begin
	declare @CmdText varchar(8000) SET @CmdText = '' 

	-- START �ܿ��û�
	if @Option='groupuser-company'
	begin		
		select A.CompanyID, B.NameCHS ,B.NameENG ,B.District from (select A.CompanyID from FW_USER A group by A.CompanyID) A
		inner join FW_COMPANY B on A.CompanyID=B.CompanyID
	end
	
	if @Option='groupuser-list'
	begin
		select A.CompanyID, A.UserName, A.NameCHS, A.NameENG from FW_USER A where A.IsDelete='N' and A.CompanyID=@CompanyID
	end
	if @Option='groupuser-checked'
	begin
		select @CmdText=@CmdText+','+A.UserName from FW_GROUP_USER A where A.GroupID=@GroupID and CompanyID=@CompanyID
		select substring(@CmdText, 2, len(@CmdText)) IDlist
	end

	if @Option='groupuser-update'
	begin		
		begin transaction myTrans
		if len(@IDlist)>0
		begin
			delete from FW_GROUP_USER where GroupID=@GroupID and CompanyID=@CompanyID and charindex(','+UserName+',',','+ @IDlist +',')>0
			insert into FW_GROUP_USER(GroupID, CompanyID, UserName) select @GroupID GroupID, @CompanyID CompanyID, item from Fn_ArrayList(@IDlist,',')
		end
		else
		begin
			delete from FW_GROUP_USER where GroupID=@GroupID and CompanyID=@CompanyID
		end

		if(@@error>0) rollback transaction myTrans else commit transaction myTrans
	end
	-- END   �ܿ��û�
	

	-- START �ܿ�Ȩ��
	if @Option='grouppermission-list'
	begin
		select A.PermissionID, A.NameCHS, A.NameENG, A.Remark from FW_PERMISSION A where A.IsDelete='N'
	end
	if @Option='grouppermission-checked'
	begin
		select @CmdText=@CmdText+','+A.PermissionID from FW_GROUP_PERMISSION A where A.GroupID=@GroupID
		select substring(@CmdText, 2, len(@CmdText)) IDlist
	end

	if @Option='grouppermission-update'
	begin
		begin transaction myTrans
		if len(@IDlist)>0
		begin
			delete from FW_GROUP_PERMISSION where GroupID=@GroupID and charindex(','+PermissionID+',',','+ @IDlist +',')>0
			insert into FW_GROUP_PERMISSION(GroupID, PermissionID) select @GroupID GroupID, item from Fn_ArrayList(@IDlist,',')
		end
		else
		begin
			delete from FW_GROUP_PERMISSION where GroupID=@GroupID
		end

		if(@@error>0) rollback transaction myTrans else commit transaction myTrans
	end
	-- END   �ܿ�Ȩ��

	
	-- START �ܿز˵�
	if @Option='groupmenu-root'
	begin		
		select A.RootID, A.ParentID, A.MenuID, A.NameCHS, A.NameENG, A.Hyperlink from FW_MENU A where A.IsDelete='N' and A.ParentID='0'
	end
	
	if @Option='groupmenu-list'
	begin
		select A.RootID, A.ParentID, A.MenuID, A.NameCHS, A.NameENG, A.Hyperlink from FW_MENU A 
		where A.IsDelete='N' and A.RootID=@MenuID
	end
	if @Option='groupmenu-checked'
	begin
		select @CmdText=@CmdText+','+A.MenuID from FW_GROUP_MENU A where A.GroupID=@GroupID
		select substring(@CmdText, 2, len(@CmdText)) IDlist
	end

	if @Option='groupmenu-update'
	begin
		begin transaction myTrans
		delete from FW_GROUP_MENU where GroupID=@GroupID and charindex(','+MenuID+',',','+ @IDlist +',')>0
		insert into FW_GROUP_MENU(GroupID, MenuID) values(@GroupID,@IDlist)

		if(@@error>0) rollback transaction myTrans else commit transaction myTrans
	end
	if @Option='groupmenu-delete'
	begin
		delete from FW_GROUP_MENU where GroupID=@GroupID and MenuID=@MenuID
	end
	-- END   �ܿز˵�
	


	

	
	-- ���ز˵�
	if @Option ='menu-root'
	begin
		select M.ParentID, M.MenuID, M.NameCHS, M.NameENG, M.Hyperlink
		from FW_GROUP_MENU GM inner join FW_MENU M on M.MenuID=GM.MenuID where M.ParentID='0' and GM.GroupID=@GroupID
	end
	if @Option ='menu-item'
	begin		
		select RootID, ParentID, MenuID, NameCHS, NameENG, LevelIndex, Hyperlink from FW_MENU where RootID=@MenuID and ParentID<>'0'
	end


	-- Buider FW_COMPANY
	if @Option ='builder_FW_COMPANY'
	begin
		select CompanyID, NameCHS, NameENG from FW_COMPANY
	end
end
GO
