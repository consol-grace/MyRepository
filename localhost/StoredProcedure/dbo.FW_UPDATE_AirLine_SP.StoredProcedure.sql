USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_AirLine_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_AirLine_SP]
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
  
  SELECT co_code collate database_default co_code, co_stat collate database_default co_stat, 
         CO_ID, CO_SYS, CO_NAME, CO_CNTY, CO_RECDATE, CO_USER, CO_CARNO
  INTO #AIRLINE
  FROM c_transfer.consol_transfer.dbo.T_CO
  WHERE co_coType = 'AIRLINE'
  ORDER BY co_Code
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#AIRLINE:' + CAST(@row AS VARCHAR)
  
  --第二步
  DELETE n FROM cs_AirLine n
  WHERE NOT EXISTS (SELECT null FROM #AIRLINE o
                    WHERE n.al_Code = o.co_Code
                      AND n.al_Stat = o.co_STAT collate database_default)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DELETE@cs_AirLine:' + CAST(@row AS VARCHAR)
  
  --第三步
  UPDATE n
  SET al_Code = o.CO_CODE
    , al_Name = o.CO_NAME
    , al_country = o.CO_CNTY
    , al_AirNo = o.co_carNo
  --  , al_CallSign = o.
  --  , al_Active = 1
    , al_CrDate = o.CO_RECDATE
    , al_LstDate = o.CO_RECDATE
    , al_User = o.CO_USER
  FROM #AIRLINE o, cs_AirLine n
  WHERE n.al_Stat = o.co_STAT AND n.al_CODE = o.co_CODE
    
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@cs_AirLine:' + CAST(@row AS VARCHAR)
  
  --第四步
  INSERT INTO cs_AirLine (al_ID, al_STAT, al_SYS, al_Code, al_Name, al_country, al_AirNo, al_Active, al_CrDate, al_User)
  SELECT CO_ID, CO_STAT, CO_SYS, CO_CODE, CO_NAME, CO_CNTY, CO_CARNo, 1, CO_RECDATE, CO_USER
  FROM #AIRLINE o
  WHERE NOT EXISTS (SELECT * FROM cs_AirLine n
                    WHERE n.al_Stat = o.co_STAT AND n.al_CODE = o.co_CODE) 
  SELECT @row = @@ROWCOUNT
  PRINT 'INSERT@cs_AirLine:' + CAST(@row AS VARCHAR)
  
  
  --第五步
  DROP TABLE #AIRLINE
end
GO
