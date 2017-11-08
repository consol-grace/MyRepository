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
-- Description: 通用分页   存储过程
-- Exmaple & Remark:
/*	T-SQL 调用:
		exec FW_PAGINATION_SP @Option = 'total' ,@SqlOrTable = 'MENU'
		
		exec FW_PAGINATION_SP 
			 @Option = 'top'	 
			,@SqlOrTable = 'MENU'       	-- 需要查询的表
			,@Columns = '*'			-- 需要得到的字段
			,@Condition = ''		-- 查询条件, 不用加where关键字
			,@OrderByColumn = 'RowID'   	-- 排序的字段名 (即 order by column asc/desc)
			,@OrderByType = 0           	-- 排序的类型 (0为升序,1为降序)
			,@PKColumn = 'RowID'        	-- 主键名称
			,@PageSize = 3              	-- 分页大小
			,@PageIndex = 1			-- 当前页
	
	
	页面调用:
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
		    fields.Add("SqlOrTable", "News");		// -- 需要查询的表
		    fields.Add("Columns", "*");				// -- 需要得到的字段
		    fields.Add("Condition", "");			// -- 查询条件, 不用加where关键字
		    fields.Add("OrderByColumn", "n_Id");	// -- 排序的字段名 (即 order by column asc/desc)
		    fields.Add("OrderByType", 1);			// -- 排序的类型 (0为升序,1为降序)
		    fields.Add("PKColumn", "n_Id");			// -- 主键名称
		    fields.Add("PageSize", PageSize);		// -- 分页大小
		    fields.Add("PageIndex", PaginationHelper.CurrentPageIndex);   // -- 第几页 ( 当前分页号 )
		    dal = new MssqlDAL(DBHelper.WebSiteDB, "FW_PAGINATION_SP", fields);
		    this.gvNews.Datasource = dal.GetDataTable();
		    this.gvNews.DataBind();
		}
	}
	--------------------------------------



	调用表:		exec FW_PAGINATION_SP @Option='cursor'  @SqlOrTable='select * from FW_USER' ,@PageIndex=1 ,@PageSize=18
	调用存储过程:	exec FW_PAGINATION_SP  @SqlOrTable='exec FW_USER_GetList_SP' ,@PageIndex=1 ,@PageSize=18
 */
-- =============================================
CREATE procedure [dbo].[FW_PAGINATION_SP](@Option varchar(50) = 'total'	 
	,@SqlOrTable varchar(100) = null        -- 需要查询的表
	,@Columns varchar(1000) = '*'		-- 需要得到的字段
	,@Condition varchar(1000) = ''          -- 查询条件, 不用加where关键字
	,@OrderByColumn varchar(100) = ''       -- 排序的字段名 (即 order by column asc/desc)
	,@OrderByType bit = 0                  	-- 排序的类型 (0为升序,1为降序)
	,@PKColumn varchar(50) = ''             -- 主键名称
	,@PageSize int = 18                     -- 分页大小
	,@PageIndex int = 1			-- 第几页
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
	-- 利用ID大于多少和select top分页,效率最高
	if @Option='top'
	begin
		declare @strTemp varchar(300)
		declare @strSql varchar(5000)                      -- 该存储过程最后执行的语句
		declare @strOrderType varchar(1000)                -- 排序类型语句 (order by column asc或者order by column desc)		

		if @OrderByType = 1          -- 降序
		begin
			set @strOrderType = ' order by '+@OrderByColumn+' desc'
			set @strTemp = '<(select min'
		end
		else                                   -- 升序
		begin
			set @strOrderType = ' order by '+@OrderByColumn+' asc'
			set @strTemp = '>(select max'
		end		
		
		if @PageIndex = 1            --第一页
		begin
			if len(@Condition) > 0
				set @strSql = 'select top '+str(@PageSize)+' '+@Columns+' from '+@SqlOrTable+' where '+@Condition+@strOrderType
			else
				set @strSql = 'select top '+str(@PageSize)+' '+@Columns+' from '+@SqlOrTable+@strOrderType
		end
		else                                   -- 其他页
		begin
			if len(@Condition)> 0
				set @strSql = 'select top '+str(@PageSize)+' '+@Columns+' from '+@SqlOrTable+'  where '+@Condition+' and '+@PKColumn+@strTemp+'('+@PKColumn+')'+' from (select top '+str((@PageIndex-1)*@PageSize)+' '+@PKColumn+' from '+@SqlOrTable+' where '+@Condition+@strOrderType+') as TabTemp)'+@strOrderType
			else
				set @strSql = 'select top '+str(@PageSize)+' '+@Columns+' from '+@SqlOrTable+'  where '+@PKColumn+@strTemp+'('+@PKColumn+')'+' from (select top '+str((@PageIndex-1)*@PageSize)+' '+@PKColumn+' from '+@SqlOrTable+@strOrderType+') as TabTemp)'+@strOrderType
		end
	
		execute(@strSql)
		--print @strsql
	end	
	-- 利用SQL的游标存储过程分页
	if @Option='cursor'
	begin
		set nocount on
		declare @P1 int --P1是游标的id		
		exec sp_cursoropen @P1 output,@SqlOrTable,@scrollopt=1,@ccopt=1, @rowcount=@rowcount output

		select ceiling(1.0*@rowcount/@PageSize) as PageCount,@rowcount as RowsCount,@PageIndex as PageIndex 
		set @PageIndex=(@PageIndex-1)*@PageSize+1

		exec sp_cursorfetch @P1,16,@PageIndex,@PageSize 
		exec sp_cursorclose @P1
		set nocount off
	end
end
GO
