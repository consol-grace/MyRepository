/****** Object:  Table [dbo].[WebUploadify]    Script Date: 03/10/2011 17:53:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WebUploadify](
	[RowID] [numeric](18, 0) IDENTITY(100000000000000000,1) NOT NULL,
	[OrderID] [nvarchar](50) NULL,
	[TableName] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[AuthorityID] [nvarchar](500) NULL,
	[OriginFile] [nvarchar](500) NULL,
	[NewFile] [nvarchar](500) NULL,
	[FileSize] [nvarchar](50) NULL,
	[UploadDate] [datetime] NULL,
	[Remarks] [nvarchar](250) NULL,
	[Creator] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[Modifier] [nvarchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[IsDelete] [nvarchar](1) NULL,
 CONSTRAINT [PK_WebUploadify] PRIMARY KEY CLUSTERED 
(
	[RowID] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表中资料编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'OrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'TableName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'UserName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'AuthorityID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原文件名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'OriginFile'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新文件名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'NewFile'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'FileSize'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'UploadDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'Remarks'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'Modifier'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'逻辑删除：Y=是，N=否' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'IsDelete'
GO

ALTER TABLE [dbo].[WebUploadify] ADD  CONSTRAINT [DF_WebUploadify_UploadDate]  DEFAULT (getdate()) FOR [UploadDate]
GO

ALTER TABLE [dbo].[WebUploadify] ADD  CONSTRAINT [DF_WebUploadify_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[WebUploadify] ADD  CONSTRAINT [DF_WebUploadify_IsDelete]  DEFAULT (N'N') FOR [IsDelete]
GO


------------------------------------------------------------------------------------------------------------------------


/****** Object:  StoredProcedure [dbo].[WebUploadify_SP]    Script Date: 03/11/2011 16:02:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:  Richard
-- Create date: 2011-03-10
-- Description: 网站文件上传 存储过程
-- =============================================
CREATE procedure [dbo].[WebUploadify_SP](@Option varchar(50)='list' -- 选项
 ,@RowID numeric(18, 0) = null   -- 自动编号
 ,@UserName nvarchar(50) = null   -- 上传用户
 ,@AuthorityID nvarchar(500) = null   -- 权限ID
 ,@OrderID nvarchar(50) = null   -- 表中资料编号
 ,@TableName nvarchar(50) = null   -- 表名
 ,@OriginFile nvarchar(500) = null   -- 原文件名
 ,@NewFile nvarchar(500) = null   -- 新文件名
 ,@FileSize nvarchar(50) = null   -- 文件大小
 ,@UploadDate datetime = null   -- 上传日期
 ,@Remarks nvarchar(250) = null   -- 备注
 ,@Creator nvarchar(50) = null   -- 创建者
 ,@CreateDate datetime = null   -- 创建时间
 ,@Modifier nvarchar(50) = null   -- 修改者
 ,@ModifyDate datetime = null   -- 修改时间
 ,@IsDelete nvarchar(1) = null   -- 逻辑删除：Y=是，N=否
 ,@RowIDs nvarchar(4000) = null
) as
begin
  declare @CmdText varchar(8000) SET @CmdText = '' 
  if @Option ='list' 
  begin
   set @CmdText = 'select A.RowID, A.UserName,A.AuthorityID,A.OrderID,A.TableName,A.OriginFile,A.NewFile,A.FileSize,A.UploadDate,A.Remarks,A.Creator,A.CreateDate,A.Modifier,A.ModifyDate,A.IsDelete from WebUploadify A where 1=1 '
   if len(@UserName)>0 set @CmdText = @CmdText + ' and A.RowID = ' + CAST(@RowID as varchar)+ ' '
   if len(@UserName)>0 set @CmdText = @CmdText + ' and A.UserName = ''' + @UserName+ ''' '
   if len(@AuthorityID)>0 set @CmdText = @CmdText + ' and A.AuthorityID = ''' + @AuthorityID+ ''' '
   if len(@OrderID)>0 set @CmdText = @CmdText + ' and A.OrderID = ''' + @OrderID+ ''' '
   if len(@TableName)>0 set @CmdText = @CmdText + ' and A.TableName = ''' + @TableName+ ''' '
   if len(@OriginFile)>0 set @CmdText = @CmdText + ' and A.OriginFile = ''' + @OriginFile+ ''' '
   if len(@NewFile)>0 set @CmdText = @CmdText + ' and A.NewFile = ''' + @NewFile+ ''' '
   if len(@FileSize)>0 set @CmdText = @CmdText + ' and A.FileSize = ''' + @FileSize+ ''' '
   if len(@UploadDate)>0 set @CmdText = @CmdText + ' and A.UploadDate = ''' + @UploadDate+ ''' '
   if len(@Remarks)>0 set @CmdText = @CmdText + ' and A.Remarks = ''' + @Remarks+ ''' '
   if len(@Creator)>0 set @CmdText = @CmdText + ' and A.Creator = ''' + @Creator+ ''' '
   if len(@CreateDate)>0 set @CmdText = @CmdText + ' and A.CreateDate = ''' + @CreateDate+ ''' '
   if len(@Modifier)>0 set @CmdText = @CmdText + ' and A.Modifier = ''' + @Modifier+ ''' '
   if len(@ModifyDate)>0 set @CmdText = @CmdText + ' and A.ModifyDate = ''' + @ModifyDate+ ''' '
   if len(@IsDelete)>0 set @CmdText = @CmdText + ' and A.IsDelete = ''' + @IsDelete+ ''' '

   set @CmdText = @CmdText +' order by A.OrderID, A.TableName desc ' 
   execute(@CmdText)
  end

  if @Option ='addnew' 
  begin
   insert into WebUploadify(UserName,AuthorityID,OrderID,TableName,OriginFile,NewFile,FileSize) values(@UserName,@AuthorityID,@OrderID,@TableName,@OriginFile,@NewFile,@FileSize) 
  end

  if @Option ='delete' 
  begin
   delete from WebUploadify where RowID=@RowID
  end

 if @Option ='delete-select' 
  begin
   delete from WebUploadify where charindex(','+cast([RowID] as varchar)+',',','+@RowIDs+',')>0
  end
end


GO


