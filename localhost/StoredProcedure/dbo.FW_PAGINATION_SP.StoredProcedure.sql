USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_PAGINATION_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Richard       QQ: 1055210005       MSN: richard@diygens.com       Email: richard@diygens.com       WebSite: http://frame.diygens.com
-- Create date: 2011-08-09
-- Description: ͨ�÷�ҳ   �洢����
-- Exmaple & Remark:
/*	T-SQL ����:
		exec FW_PAGINATION_SP @Option = 'total' ,@SqlOrTable = 'MENU'
		
		exec FW_PAGINATION_SP 
			 @Option = 'top'	 
			,@SqlOrTable = 'MENU'       	-- ��Ҫ��ѯ�ı�
			,@Columns = '*'			-- ��Ҫ�õ����ֶ�
			,@Condition = ''		-- ��ѯ����, ���ü�where�ؼ���
			,@OrderByColumn = 'RowID'   	-- ������ֶ��� (�� order by column asc/desc)
			,@OrderByType = 0           	-- ��������� (0Ϊ����,1Ϊ����)
			,@PKColumn = 'RowID'        	-- ��������
			,@PageSize = 3              	-- ��ҳ��С
			,@PageIndex = 1			-- ��ǰҳ
	
	
	ҳ�����:
	--------------------------------------
	protected void ShowList()
    	{
		DataTable dt = new DataTable();
		MssqlFields fields = new MssqlFields();
		fields.Add("Option", "total");
		fields.Add("tableName", "News");
		MssqlDAL dal = new MssqlDAL(DBHelper.WebSiteDB, "DGF_Pagination_SP", fields);
		if (dal["RowsCount"].Tostring() != "0")
		{
		    Int32 PageSize = 60;
		    this.divPager.InnerHtml = PaginationHelper.PaginationNumber(Convert.ToInt32(dal["RecordCount"]), PageSize);
		
		    fields = new MssqlFields();
		    fields.Add("Option", "pager");
		    fields.Add("SqlOrTable", "News");		// -- ��Ҫ��ѯ�ı�
		    fields.Add("Columns", "*");				// -- ��Ҫ�õ����ֶ�
		    fields.Add("Condition", "");			// -- ��ѯ����, ���ü�where�ؼ���
		    fields.Add("OrderByColumn", "n_Id");	// -- ������ֶ��� (�� order by column asc/desc)
		    fields.Add("OrderByType", 1);			// -- ��������� (0Ϊ����,1Ϊ����)
		    fields.Add("PKColumn", "n_Id");			// -- ��������
		    fields.Add("PageSize", PageSize);		// -- ��ҳ��С
		    fields.Add("PageIndex", PaginationHelper.CurrentPageIndex);   // -- �ڼ�ҳ ( ��ǰ��ҳ�� )
		    dal = new MssqlDAL(DBHelper.WebSiteDB, "FW_PAGINATION_SP", fields);
		    this.gvNews.Datasource = dal.GetDataTable();
		    this.gvNews.DataBind();
		}
	}
	--------------------------------------



	���ñ�:		exec FW_PAGINATION_SP @Option='cursor'  @SqlOrTable='select * from FW_USER' ,@PageIndex=1 ,@PageSize=18
	���ô洢����:	exec FW_PAGINATION_SP  @SqlOrTable='exec FW_USER_GetList_SP' ,@PageIndex=1 ,@PageSize=18
 */
-- =============================================
CREATE procedure [dbo].[FW_PAGINATION_SP](@Option varchar(50) = 'total'	 
	,@SqlOrTable varchar(100) = null        -- ��Ҫ��ѯ�ı�
	,@Columns varchar(1000) = '*'		-- ��Ҫ�õ����ֶ�
	,@Condition varchar(1000) = ''          -- ��ѯ����, ���ü�where�ؼ���
	,@OrderByColumn varchar(100) = ''       -- ������ֶ��� (�� order by column asc/desc)
	,@OrderByType bit = 0                  	-- ��������� (0Ϊ����,1Ϊ����)
	,@PKColumn varchar(50) = ''             -- ��������
	,@PageSize int = 18                     -- ��ҳ��С
	,@PageIndex int = 1			-- �ڼ�ҳ
) as
begin
	declare @CmdText varchar(8000)   set @CmdText = ''
	if charindex('select', @SqlOrTable)>0 set @SqlOrTable = replace('({0}) A', '{0}', @SqlOrTable)

	declare @rowcount int	

	if @Option='total'
	begin
		set @CmdText = 'declare @PageCount int, @RowsCount int, @CurrentIndex int   Select @PageCount=0, @RowsCount=0, @CurrentIndex=0
			set @RowsCount = convert(int, (select count(1) RecordCount from '+ @SqlOrTable +'))
			set @PageCount = ceiling(1.0*@RowsCount/'+ str(@PageSize) +') 
			set @CurrentIndex = '+ str(@PageIndex) +'
			select @RowsCount RowsCount, @PageCount PageCount, @CurrentIndex PageIndex '			
		execute(@CmdText)
	end
	-- ����ID���ڶ��ٺ�select top��ҳ,Ч�����
	if @Option='top'
	begin
		declare @strTemp varchar(300)
		declare @strSql varchar(5000)                      -- �ô洢�������ִ�е����
		declare @strOrderType varchar(1000)                -- ����������� (order by column asc����order by column desc)		

		if @OrderByType = 1          -- ����
		begin
			set @strOrderType = ' order by '+@OrderByColumn+' desc'
			set @strTemp = '<(select min'
		end
		else                                   -- ����
		begin
			set @strOrderType = ' order by '+@OrderByColumn+' asc'
			set @strTemp = '>(select max'
		end		
		
		if @PageIndex = 1            --��һҳ
		begin
			if len(@Condition) > 0
				set @strSql = 'select top '+str(@PageSize)+' '+@Columns+' from '+@SqlOrTable+' where '+@Condition+@strOrderType
			else
				set @strSql = 'select top '+str(@PageSize)+' '+@Columns+' from '+@SqlOrTable+@strOrderType
		end
		else                                   -- ����ҳ
		begin
			if len(@Condition)> 0
				set @strSql = 'select top '+str(@PageSize)+' '+@Columns+' from '+@SqlOrTable+'  where '+@Condition+' and '+@PKColumn+@strTemp+'('+@PKColumn+')'+' from (select top '+str((@PageIndex-1)*@PageSize)+' '+@PKColumn+' from '+@SqlOrTable+' where '+@Condition+@strOrderType+') as TabTemp)'+@strOrderType
			else
				set @strSql = 'select top '+str(@PageSize)+' '+@Columns+' from '+@SqlOrTable+'  where '+@PKColumn+@strTemp+'('+@PKColumn+')'+' from (select top '+str((@PageIndex-1)*@PageSize)+' '+@PKColumn+' from '+@SqlOrTable+@strOrderType+') as TabTemp)'+@strOrderType
		end
	
		execute(@strSql)
		--print @strsql
	end	
	-- ����SQL���α�洢���̷�ҳ
	if @Option='cursor'
	begin
		set nocount on
		declare @P1 int --P1���α��id		
		exec sp_cursoropen @P1 output,@SqlOrTable,@scrollopt=1,@ccopt=1, @rowcount=@rowcount output

		select ceiling(1.0*@rowcount/@PageSize) as PageCount,@rowcount as RowsCount,@PageIndex as PageIndex 
		set @PageIndex=(@PageIndex-1)*@PageSize+1

		exec sp_cursorfetch @P1,16,@PageIndex,@PageSize 
		exec sp_cursorclose @P1
		set nocount off
	end
end
GO
