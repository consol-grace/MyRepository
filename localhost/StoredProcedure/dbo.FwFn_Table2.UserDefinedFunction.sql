USE [USGROUP]
GO
/****** Object:  UserDefinedFunction [dbo].[FwFn_Table2]    Script Date: 09/21/2011 17:26:04 ******/
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================================================================================
-- Author: Benjamin ( 2011-06-29 )   QQ: 664722420   MSN: benjayung@hotmail.com   Email: benjayung@hotmail.com
-- ALTER date: 2011-06-29
-- Description: 查询表结构
-- 例: select * from FwFn_Table2(@Option nvarchar(50), 'FW_MENU')
-- ===============================================================================================================
create function [dbo].[FwFn_Table2](@Option nvarchar(50), @Table nvarchar(50))
returns @TabStruct table(RowID int IDENTITY(1, 1) primary key
  , TableName nvarchar(100) collate database_default 
  , TableRemark nvarchar(500) collate database_default
  , OrderID int
  , FieldName nvarchar(50) collate database_default
  , AutoID nvarchar(50) collate database_default
  , PrimaryKey nvarchar(50) collate database_default
  , DataType nvarchar(50) collate database_default
  , Length nvarchar(50) collate database_default
  , Prec nvarchar(50) collate database_default
  , Scale nvarchar(50) collate database_default
  , AllowNulls nvarchar(50) collate database_default
  , Defaults nvarchar(50) collate database_default
  , FieldRemark nvarchar(50) collate database_default
  , Collation nvarchar(50) collate database_default
  , DataTypeLine nvarchar(100) collate database_default 
  , DataTypeLine2 nvarchar(100) collate database_default 
  , NotNullLine nvarchar(50) collate database_default 
  , PrimaryKeyLine nvarchar(50) collate database_default 
) as 
begin
  if @Table = ''  --解決不能外部連接的数据庫存使用问题
    set @Table = coalesce((select TableName from fwTB_TableStruct), '')

  begin -- 提出所有字段
    insert into @TabStruct(TableName, TableRemark, OrderID, FieldName, AutoID, PrimaryKey, DataType, Length, Prec, Scale, AllowNulls, Defaults, FieldRemark, Collation)
    select * from (
    select 
      TableName   = d.name, 
      TableRemark = cast((case when a.colorder = 1 then isnull(f.value, '') else '' end) as nvarchar), 
      OrderID     = a.colorder, 
      FieldName   = a.name, 
      AutoID      = case when COLUMNPROPERTY( a.id, a.name, 'IsIdentity') = 1 then '√'else '' end, 
      PrimaryKey  = case when exists (select top 1 0 from sysobjects pk 
																			         join   sysindexes i on pk.name = i.name
																			         join   sysindexkeys ik on i.id = ik.id and i.indid = ik.indid
																			where pk.xtype = 'PK' and pk.parent_obj = d.id and d.id = i.id and  ik.colid = a.colid) then '√' else '' end,
      DataType    = h.name, 
      Length      = a.length,
      Prec        = COLUMNPROPERTY(a.id, a.name, 'PRECISION'), 
      Scale       = isnull(COLUMNPROPERTY(a.id, a.name, 'Scale'), 0), 
      AllowNulls  = case when a.isnullable = 1 then '√'else '' end, 
      Defaults    = isnull(e.text, ''), 
      FieldRemark = cast((isnull(g.[value], '')) as nvarchar) + b.name,
      Collation   = case when a.collation is not null then ' collate ' + a.Collation else '' end
    FROM  syscolumns a
    left  join systypes b      on a.xusertype = b.xusertype
    left  join systypes h      on h.xusertype = b.xtype
    inner join sysobjects d    on a.id = d.id and d.xtype = 'U' and d.name <> 'dtproperties'
    left  join syscomments e   on a.cdefault = e.id
    left  join sysproperties g on a.id = g.id and a.colid = g.smallid 
    left  join sysproperties f on d.id = f.id and f.smallid = 0
    where (d.name = @Table or @Table = '')
    ) x where (PrimaryKey <> '' and @Option = 'primarykey') or (@Option = 'Struct') or (PrimaryKey = '' and @Option = 'nonkey')
  end

  begin -- 产生SQL文法语句,可以再加速,日后有时间请主要动提出修改
    update @TabStruct
      set DataTypeLine  = ' '+ DataType 
                        + case when Datatype in ('Int', 'float', 'bigint', 'bit', 'datetime', 'timestamp', 'smallint') then '' 
                               when Datatype in ('nvarchar', 'varchar', 'nchar', 'char') then '(' + Prec + ')'
                               when Datatype in ('Decimal') then '(' + Prec + ', ' + Scale +  ')' else '' end
        , DataTypeLine2  = ' '+ case when DataType in ('varchar', 'char') and PrimaryKey <> '' then 'n' else '' end + DataType
                        + case when Datatype in ('Int', 'float', 'bigint', 'bit', 'datetime', 'timestamp', 'smallint') then '' 
                               when Datatype in ('nvarchar', 'varchar', 'nchar', 'char') then '(' + Prec + ')'
                               when Datatype in ('Decimal') then '(' + Prec + ', ' + Scale +  ')' else '' end
        , NotNullLine = case AllowNulls when  '' then ' not null' else '' end
        , PrimaryKeyLine = case PrimaryKey when '' then '' else ' primary key' end
  end
 
  return
end
GO
