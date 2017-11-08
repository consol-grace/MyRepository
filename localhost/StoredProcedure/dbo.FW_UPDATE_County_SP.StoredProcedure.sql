USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_County_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_County_SP]
AS
/*
数据导入说明
1.数据从旧系统中导入到新系统中，旧系统正常运转

第一步：将旧系统的数据导入到一个临时表中，并增加一些辅助字段，对于WHERE中使用到得字段，还需要增加 COLLATE DATABASE_DEFAULT 排序选项
第二步：因这已定為全世界唯一數據的表,現在所以CY_ID沒有用处.
				也改為只拿不重覆的數據為导入对象
<***********
第二步：在新表中删除旧表已经删除的数据，用 NOT EXIST（新旧系统都相同的数据） 对应条件是 【新表.ID = 旧表.ID AND　新表.STAT = 旧表.STAT】
第三步：通过旧表更新新表的数据，对应条件是 【新表.ID = 旧表.ID AND　新表.STAT = 旧表.STAT】
第四步: 在新表中插入旧表新增的数据，并且插入一个系统级的唯一ID号。
        1.建立一个临时表，增加一个Identity的字段
        2.用WHILE循环，一行一行插入，在插入前先用存储过程生产一个ID号
          WHILE 结束条件是 Identity字段的值 等于 临时表的记录数
***********>
第五步：删除临时表
*/
begin
/******************************************
  国家代码标
  cs_Country <-- T_CNTY 
  对应字段：
  cy_Code = cy_Code
******************************************/
  DECLARE  @row INTEGER

  -- < 第一步 >
  PRINT '-------------------- cs_Country <-- T_CNTY ------------------------'
  SELECT identity(int, 1, 1) ROWID, *
  INTO #CNTY
  FROM C_TRANSFER.CONSOL_TRANSFER.dbo.T_CNTY

  -- < 第二步 >
  INSERT INTO cs_Country (cy_Code, cy_Name, cy_Active, cy_CrDate, cy_User)
		select c.CNY_CODE, c.CNY_NAME, case when len(isnull(c.cny_code, '')) < 2 or isnumeric(c.cny_code) = 1 then 0 else 1 end, GETDATE(), max(CNY_USER)
		from (select cny_code, max(len(cny_name)) cny_name
    			from #cnty
    			group by cny_code) x,
    			#cnty c
		where x.cny_code = c.cny_code and x.cny_name = len(c.cny_name)
	    and c.cny_code not in (SELECT cy_code collate database_default FROM cs_Country) 
	    and len(isnull(c.cny_code, '')) > 0
		group by c.CNY_CODE, c.CNY_NAME 
		order by c.cny_code

  SELECT @row = @@ROWCOUNT
  PRINT 'INSERT@CS_Country:' + CAST(@row AS VARCHAR)

  -- < 第三步 >
  DROP TABLE #CNTY
end
GO
