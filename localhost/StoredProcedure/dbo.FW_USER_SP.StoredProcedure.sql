USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_USER_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280       
-- Create date: 2011-08-02
-- Description: 用户 存储过程
-- =============================================
CREATE procedure [dbo].[FW_USER_SP](@Option varchar(50)='list' -- 选项
	,@IDlist varchar(8000) = null
	,@RowID numeric(18,0) = null   -- 自动编号                      
	,@UserName nvarchar(50) = null   -- 用户名或帐号                  
	,@UserPWD nvarchar(50) = null   -- 密码
	,@NameCHS nvarchar(50) = null   -- 名称(中)
	,@NameENG nvarchar(50) = null   -- 名称(英)
	,@CompanyID nvarchar(50) = null   -- 公司(办公室)编号
	,@Email nvarchar(50) = null   -- 电子邮箱                      
	,@Question nvarchar(150) = null   -- 安全问题                      
	,@Answer nvarchar(150) = null   -- 问题答案                      
	,@IsActivation nvarchar(1) = null   -- 是否激活:Y=是,N=否            
	,@Remark nvarchar(250) = null   -- 备注                          
	,@Creator nvarchar(50) = null   -- 创建者                        
	,@CreateDate datetime = null   -- 创建时间                      
	,@Modifier nvarchar(50) = null   -- 修改者                        
	,@ModifyDate datetime = null   -- 修改时间                      
	,@IsDelete nvarchar(1) = null   -- 逻辑删除:Y=是,N=否
	,@RowIDs varchar(8000) = null     
) as
begin
	declare @CmdText varchar(8000), @SqlText varchar(8000)   select @CmdText = '', @SqlText = ''
	
	if @Option='dropdownlist'
	begin
		if len(isnull(@CompanyID,''))=0
		begin
			select CompanyID from FW_USER group by CompanyID
		end
		else
		begin
			select RowID, UserName, UserPWD, NameCHS, NameENG, CompanyID, Email, Question, Answer
				, IsActivation, SYS, STAT, Remark, Creator, CreateDate, Modifier, ModifyDate, IsDelete
			from FW_USER where IsDelete='N' and CompanyID=@CompanyID
		end		
	end

	--获取用户登录信息
	if @Option='user-login'
	begin
		create table #loginTemp(CompanyID nvarchar(50), CompanyNameCHS nvarchar(50), CompanyNameENG nvarchar(50), CompanyDistrict nvarchar(150)
			, UserName nvarchar(50), UserPWD nvarchar(50), NameCHS nvarchar(50), NameENG nvarchar(50), Email nvarchar(50), GroupID varchar(50), GroupNameCHS varchar(50), GroupNameENG varchar(50), 
			[SYS] nvarchar(50), STAT nvarchar(50), PermissionList varchar(8000), MenuList varchar(8000)
		)

		insert into #loginTemp(CompanyID,UserName,UserPWD,NameCHS,NameENG,Email,[SYS],STAT) 
		select CompanyID, UserName, UserPWD, NameCHS, NameENG, Email,[SYS], STAT from FW_USER where UserName=@UserName and UserPWD=@UserPWD

		--更新用户所在的群组
		update #loginTemp set GroupID=b.GroupID ,GroupNameCHS=c.NameCHS ,GroupNameENG=c.NameENG
		from #loginTemp a
		inner join (select n.GroupID, m.UserName from FW_USER m inner join FW_GROUP_USER n on m.UserName=n.UserName and m.UserName=@UserName) b on a.UserName=b.UserName
		inner join FW_GROUP c on c.GroupID=b.GroupID

		--更新用户所在的公司
		update #loginTemp set CompanyNameCHS=b.NameCHS,CompanyNameENG=b.NameENG,CompanyDistrict=b.District
		from #loginTemp a
		inner join FW_COMPANY b on b.CompanyID=a.CompanyID 

		--更新用户的权限
		select @CmdText=@CmdText + PermissionID +',' from FW_GROUP_PERMISSION where GroupID=(select top 1 GroupID from #loginTemp)
		if(LEN(@CmdText)>1) set @CmdText=left(@CmdText,len(@CmdText)-1)

		--更新用户菜单
		select @SqlText=@SqlText+MenuID+',' from FW_GROUP_MENU where GroupID=(select top 1 GroupID from #loginTemp)
        		if(LEN(@SqlText)>1) set @SqlText=left(@SqlText,len(@SqlText)-1)
        
		update #loginTemp set PermissionList=@CmdText,MenuList=@SqlText
		
		select * from #loginTemp

	end
	
	-- 验证原密码是否正确
	if @Option='check-pwd'
	begin
		select 1 from FW_USER where UserName=@UserName and UserPWD=@UserPWD
	end
	-- 修改密码
	if @Option='modify-pwd'
	begin
		update FW_USER set UserPWD=@UserPWD ,Modifier=@Modifier,ModifyDate=getdate() where UserName=@UserName
	end

	if @Option ='list' 
	begin
		set @CmdText = 'select A.RowID,A.UserName,A.UserPWD,A.NameCHS,A.NameENG,A.Email,A.Question,A.Answer,A.IsActivation,case A.IsActivation when ''Y'' then ''是'' else ''否'' end  Activation,A.CompanyID,B.NameCHS CompanyNameCHS,A.Remark,A.Creator,A.CreateDate,A.Modifier,A.ModifyDate,A.IsDelete from FW_USER A inner join FW_COMPANY B on B.CompanyID=A.CompanyID where A.IsDelete=''N'' '
		if len(@RowID)>0 set @CmdText = @CmdText + ' and A.RowID = ' + cast(@RowID as varchar) + ' '
		if len(@UserName)>0 set @CmdText = @CmdText + ' and A.UserName = ''' + @UserName+ ''' '
		if len(@UserPWD)>0 set @CmdText = @CmdText + ' and A.UserPWD = ''' + @UserPWD+ ''' '
		if len(@Email)>0 set @CmdText = @CmdText + ' and A.Email = ''' + @Email+ ''' '
		if len(@Question)>0 set @CmdText = @CmdText + ' and A.Question = ''' + @Question+ ''' '
		if len(@Answer)>0 set @CmdText = @CmdText + ' and A.Answer = ''' + @Answer+ ''' '
		if len(@IsActivation)>0 set @CmdText = @CmdText + ' and A.IsActivation = ''' + @IsActivation+ ''' '
		if len(@Remark)>0 set @CmdText = @CmdText + ' and A.Remark = ''' + @Remark+ ''' '
		if len(@Creator)>0 set @CmdText = @CmdText + ' and A.Creator = ''' + @Creator+ ''' '
		if len(@CreateDate)>0 set @CmdText = @CmdText + ' and A.CreateDate = ''' + @CreateDate+ ''' '
		if len(@Modifier)>0 set @CmdText = @CmdText + ' and A.Modifier = ''' + @Modifier+ ''' '
		if len(@ModifyDate)>0 set @CmdText = @CmdText + ' and A.ModifyDate = ''' + @ModifyDate+ ''' '
		if len(@IsDelete)>0 set @CmdText = @CmdText + ' and A.IsDelete = ''' + @IsDelete+ ''' '
		
		set @CmdText = @CmdText +' order by A.RowID desc ' 
		execute(@CmdText)
	end
	
	if @Option ='update' 
	begin
		if not exists(select 1 from FW_USER A where A.UserName=@UserName)
		begin
			if len(@UserName)=0 set @UserName=dbo.Fn_NewCode('FW_USER','K')

			insert into FW_USER(UserName,NameCHS,NameENG,CompanyID,Email,Question,Answer,IsActivation,Remark,Creator) 
			values(@UserName,@NameCHS,@NameENG,@CompanyID,@Email,@Question,@Answer,@IsActivation,@Remark,@Creator) 
		end
		else
		begin
			update FW_USER set NameCHS=@NameCHS, NameENG=@NameENG, CompanyID=@CompanyID, Email=@Email,Question=@Question,Answer=@Answer,IsActivation=@IsActivation
				,Remark=@Remark,Modifier=@Modifier,ModifyDate=getdate()
			where UserName=@UserName
		end
	end
	
	if @Option ='delete' 
	begin
		begin transaction myTrans
		declare myCursor cursor for select item from Fn_ArrayList(@IDlist,',')
		open myCursor
		declare @ID nvarchar(50)
		fetch myCursor into @ID
		while(@@fetch_status=0)
		begin
			if not exists(select 1 from FW_USER A where A.UserName=@ID)
			begin
				delete from FW_USER where UserName=@ID
			end
			else
			begin
				update FW_USER set IsDelete='Y', Modifier=@Modifier, ModifyDate=getdate() where UserName=@ID
			end
		
			fetch next from myCursor into @ID
		end
		close myCursor
		deallocate myCursor
		
		if @@error>0 rollback transaction myTrans else commit transaction myTrans
	end

end
GO
