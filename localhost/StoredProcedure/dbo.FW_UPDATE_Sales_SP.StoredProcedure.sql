USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_Sales_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_Sales_SP]
AS

/*
数据导入说明
1.数据从旧系统中导入到新系统中，旧系统正常运转

第一步：将旧系统的数据导入到一个临时表中，并增加一些辅助字段，对于WHERE中使用到得字段，还需要增加 COLLATE DATABASE_DEFAULT 排序选项
第二步：在新表中删除旧表已经删除的数据，用 NOT EXIST（新旧系统都相同的数据） 对应条件是 【新表.ID = 旧表.ID AND　新表.STAT = 旧表.STAT】
第三步：通过旧表更新新表的数据，对应条件是 【新表.ID = 旧表.ID AND　新表.STAT = 旧表.STAT】
第四步: 在新表中插入旧表新增的数据，并且插入一个系统级的唯一ID号。
        1.建立一个临时表，增加一个Identity的字段
        2.用WHILE循环，一行一行插入，在插入前先用存储过程生产一个ID号
          WHILE 结束条件是 Identity字段的值 等于 临时表的记录数

第五步：删除临时表
*/
begin
  DECLARE  @row INTEGER
  
  /******************************************
    销售人员定义表:CS_SALES <-- G_SALES
  
    字段对应关系:
    n.sal_STAT = G_SALES.sal_STAT
    n.sal_CODE = G_SALES.sal_CODE
  *******************************************/
  
  --第一步
  print ' '
  print '-------------------- cs_sales <-- g_sales ------------------------'

  select station
    , sal_code collate database_default as sal_code
    , sal_stat collate database_default as sal_stat
    , sal_sys collate database_default as sal_sys
    , sal_desc collate database_default as sal_desc
  into #sales
  from c_transfer.consol_transfer.dbo.g_sales
  
  select @row = @@rowcount
  print 'ins@#sales:' + cast(@row as varchar)
  
  --第二步
  delete n 
  from cs_sales n
  where not exists (select null from #sales o
                    where o.sal_stat = n.sal_stat
                      and o.sal_code = n.sal_code)
  
  select @row = @@rowcount
  print 'del@cs_sales:' + cast(@row as varchar)
  
  --第三步
  UPDATE n
  SET sal_Description = o.SAL_DESC
    , sal_LstDate = GETDATE()
  FROM #SALES o, cs_Sales n
  WHERE o.SAL_STAT = n.SAL_STAT AND o.sal_Code = n.sal_Code 
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@CS_Sales:' + CAST(@row AS VARCHAR)
  
  --第四步
    INSERT INTO cs_Sales
      (sal_Code, sal_Description, sal_STAT, sal_SYS, sal_User, sal_CrDate, Sal_id, sal_active, sal_USGROUP)
    SELECT SAL_CODE, SAL_DESC, SAL_STAT, SAL_SYS, N'ADMIN', GETDATE(), 0,
           case when len(isnull(sal_Code, '')) < 1 or isnumeric(sal_Code) = 1 then 0 else 1 end,
           case when sal_code like ('CON/%') or sal_code like ('USG/%') or sal_desc like ('CON/%') or sal_desc like ('USG/%') then 1 else 0 end
    FROM #SALES o
    WHERE NOT EXISTS (SELECT * FROM cs_Sales n
                      WHERE o.sal_stat = n.sal_stat 
                        AND o.sal_code = n.sal_code
                     ) 
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@CS_Sales:' + CAST(@row AS VARCHAR)
  
  --第五步
  DROP TABLE #Sales
end
GO
