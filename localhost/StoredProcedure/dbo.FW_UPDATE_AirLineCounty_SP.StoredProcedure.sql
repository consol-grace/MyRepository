USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_AirLineCounty_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_AirLineCounty_SP]
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

DECLARE  @row INTEGER

/******************************************
  航班表
  cs_AirLine <-- T_CO "co_Type = AIRLINE "
  对应字段：
  ai_ID = co_ID
  ai_Stat = co_STAT
  ai_SYS = co_SYS
******************************************/
--第一步
PRINT ' '
PRINT '-------------------- CS_AirLine <-- T_CO ------------------------'

SELECT 
  *
INTO #AIRLINE
FROM
  T_CO
WHERE
  co_coType = 'AIRLINE'
ORDER BY co_Code

SELECT @row = @@ROWCOUNT
PRINT 'INS@#AIRLINE:' + CAST(@row AS VARCHAR)

--第二步
DELETE FROM
  cs_AirLine
WHERE
  NOT EXISTS(
    SELECT * FROM #AIRLINE WHERE 
     al_ID = co_ID
     AND al_Stat = co_STAT
     AND al_SYS = co_SYS
  )

SELECT @row = @@ROWCOUNT
PRINT 'DELETE@cs_AirLine:' + CAST(@row AS VARCHAR)

--第三步
UPDATE
  cs_AirLine
SET
  al_Code = o.CO_CODE
  ,al_Name = o.CO_NAME
  ,al_country = o.CO_CNTY
--  ,al_AirNo = o.
--  ,al_CallSign = o.
  ,al_Active = 1
  ,al_CrDate = o.CO_RECDATE
  ,al_LstDate = o.CO_RECDATE
  ,al_User = o.CO_USER
FROM
  #AIRLINE o
WHERE
  cs_AirLine.al_ID = o.co_ID AND cs_AirLine.al_Stat = o.co_STAT AND cs_AirLine.al_SYS = o.co_SYS
  
SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@cs_AirLine:' + CAST(@row AS VARCHAR)

--第四步
  INSERT INTO cs_AirLine(
    al_ID,al_STAT,al_SYS,al_Code,al_Name,al_country
--    ,al_AirNo,al_CallSign
    ,al_Active,al_CrDate,al_LstDate,al_User
  )
  SELECT
    CO_ID,CO_STAT,CO_SYS,CO_CODE,CO_NAME,CO_CNTY
    ,1,CO_RECDATE,CO_RECDATE,CO_USER
  FROM #AIRLINE
  WHERE
    NOT EXISTS(
      SELECT * FROM cs_AirLine WHERE 
        cs_AirLine.al_ID = #AIRLINE.co_ID AND cs_AirLine.al_Stat = #AIRLINE.co_STAT AND cs_AirLine.al_SYS = #AIRLINE.co_SYS      
  ) 
SELECT @row = @@ROWCOUNT
PRINT 'INSERT@cs_AirLine:' + CAST(@row AS VARCHAR)


--第五步
DROP TABLE #AIRLINE

/******************************************
  国家代码标
  cs_Country <-- T_CNTY 
  对应字段：
  cy_ID = cny_ID
  cy_Stat = cny_STAT
******************************************/
--第一步
PRINT ' '
PRINT '-------------------- cs_Country <-- T_CNTY ------------------------'

SELECT 
  *
INTO #CNTY
FROM
  T_CNTY


SELECT @row = @@ROWCOUNT
PRINT 'INS@#CNTY:' + CAST(@row AS VARCHAR)

--第二步
DELETE FROM
  cs_Country
WHERE
  NOT EXISTS(
    SELECT * FROM #CNTY WHERE 
      cy_ID = cny_ID
      AND cy_Stat = cny_STAT
    )

SELECT @row = @@ROWCOUNT
PRINT 'DELETE@cs_Country:' + CAST(@row AS VARCHAR)

--第三步
UPDATE
  cs_Country
SET
  cy_Code = o.CNY_CODE
  ,cy_Name = o.CNY_NAME
  ,cy_Active = 1
--  ,cy_CrDate = 
  ,cy_LstDate = GETDATE()
  ,cy_User = o.CNY_USER
FROM
  #CNTY o
WHERE
  cs_Country.cy_ID = o.CNY_ID AND cs_Country.cy_Stat = o.CNY_STAT
  
SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@cs_Country:' + CAST(@row AS VARCHAR)

--第四步
  INSERT INTO cs_Country(
    cy_ID,cy_STAT,cy_SYS,cy_Code,cy_Name
--    ,al_AirNo,al_CallSign
    ,cy_Active,cy_CrDate,cy_User
  )
  SELECT
    CNY_ID,CNY_STAT,ISNULL(CNY_SYS,''),CNY_CODE,CNY_NAME
    ,1,GETDATE(),CNY_USER
  FROM #CNTY
  WHERE
    NOT EXISTS(
      SELECT * FROM cs_Country WHERE 
        cs_Country.cy_ID = #CNTY.CNY_ID AND cs_Country.cy_Stat = #CNTY.CNY_STAT     
  ) 
SELECT @row = @@ROWCOUNT
PRINT 'INSERT@CS_Country:' + CAST(@row AS VARCHAR)


--第五步
DROP TABLE #CNTY
GO
