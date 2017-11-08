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

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������ϱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'OrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'TableName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ϴ��û�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'UserName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ȩ��ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'AuthorityID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ԭ�ļ���' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'OriginFile'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���ļ���' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'NewFile'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ļ���С' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'FileSize'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ϴ�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'UploadDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ע' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'Remarks'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�޸���' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'Modifier'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�޸�ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�߼�ɾ����Y=�ǣ�N=��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebUploadify', @level2type=N'COLUMN',@level2name=N'IsDelete'
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
-- Description: ��վ�ļ��ϴ� �洢����
-- =============================================
CREATE procedure [dbo].[WebUploadify_SP](@Option varchar(50)='list' -- ѡ��
 ,@RowID numeric(18, 0) = null   -- �Զ����
 ,@UserName nvarchar(50) = null   -- �ϴ��û�
 ,@AuthorityID nvarchar(500) = null   -- Ȩ��ID
 ,@OrderID nvarchar(50) = null   -- �������ϱ��
 ,@TableName nvarchar(50) = null   -- ����
 ,@OriginFile nvarchar(500) = null   -- ԭ�ļ���
 ,@NewFile nvarchar(500) = null   -- ���ļ���
 ,@FileSize nvarchar(50) = null   -- �ļ���С
 ,@UploadDate datetime = null   -- �ϴ�����
 ,@Remarks nvarchar(250) = null   -- ��ע
 ,@Creator nvarchar(50) = null   -- ������
 ,@CreateDate datetime = null   -- ����ʱ��
 ,@Modifier nvarchar(50) = null   -- �޸���
 ,@ModifyDate datetime = null   -- �޸�ʱ��
 ,@IsDelete nvarchar(1) = null   -- �߼�ɾ����Y=�ǣ�N=��
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


