USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_GenId_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_GenId_SP]
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
    自动生产提单号表:CS_IDTable <-- T_GenID
  
    字段对应关系:
    CS_IDTable.idt_CODE = T_GenID.GEN_TYPE
    CS_IDTable.idt_STAT = T_GenID.GEN_STAT
  *******************************************/
  --第一步
  PRINT ' '
  PRINT '-------------------- CS_IDTable <-- T_GenID ------------------------'
  SELECT STATION
    , GEN_STAT COLLATE DATABASE_DEFAULT AS GEN_STAT
    , GEN_TYPE COLLATE DATABASE_DEFAULT AS GEN_CODE  -- TYPE CHANGE TO CODE
    , GEN_SYS COLLATE DATABASE_DEFAULT AS GEN_SYS
    , GEN_DATE, GEN_NO
  INTO #GEN
  FROM c_transfer.consol_transfer.dbo.T_GenID
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#GEN:' + CAST(@row AS VARCHAR)
  
  --第二步
  DELETE FROM CS_IDTable
  WHERE NOT EXISTS (SELECT NULL FROM #GEN 
                    WHERE CS_IDTable.idt_stat = #Gen.GEN_stat
                      AND CS_IDTable.idt_code = #Gen.GEN_code)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DEL@CS_IDTable:' + CAST(@row AS VARCHAR)
  
  --第三步
  UPDATE cs_IDTable
  SET idt_sys = o.GEN_SYS
    , idt_Date = o.GEN_DATE
    , idt_No = o.GEN_NO
    , idt_LstDate = GETDATE()
    , idt_User = N'admin'
  FROM #GEN o
  WHERE CS_IDTable.idt_stat = o.GEN_stat
    AND CS_IDTable.idt_code = o.GEN_code 
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@CS_IdTable:' + CAST(@row AS VARCHAR)
  
  --第四步
  INSERT INTO cs_IdTable (idt_stat, idt_code, idt_sys, idt_Date, idt_No, idt_CrDate, idt_User)
  SELECT GEN_STAT, GEN_CODE, GEN_SYS, GEN_DATE, GEN_NO, GETDATE(), N'admin'
  FROM #GEN
  WHERE NOT EXISTS (SELECT * FROM cs_IdTable 
                    WHERE CS_IDTable.idt_stat = #GEN.GEN_stat 
                      AND CS_IDTable.idt_code = #GEN.GEN_code) 

  SELECT @row = @@ROWCOUNT
  PRINT 'INS@CS_IdTable:' + CAST(@row AS VARCHAR)
  
  --第五步
  DROP TABLE #GEN
  
  /******************************************
    自动生产提单类型表:CS_IDFormat <-- T_GenID
  
    字段对应关系:
    CS_IDTable.idt_CODE = T_GenID.GEN_TYPE
    CS_IDTable.idt_STAT = T_GenID.GEN_STAT
  问题：SYS 字段是 NULL
  *******************************************/
  
  --第一步
  PRINT ' '
  PRINT '-------------------- CS_IDFormat <-- T_GenID ------------------------'
  SELECT  idt_stat COLLATE DATABASE_DEFAULT AS GEN_STAT
        , idt_sys COLLATE DATABASE_DEFAULT AS GEN_SYS
        , idt_code COLLATE DATABASE_DEFAULT AS GEN_CODE -- TYPE CHANGE TO CODE
  INTO #GENFormat
  FROM cs_IdTable
  GROUP BY idt_stat, idt_sys, idt_code
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#GEN:' + CAST(@row AS VARCHAR)
  
  --第二步
  DELETE FROM CS_IDFormat
  WHERE NOT EXISTS (SELECT * FROM #GENFormat 
                    WHERE CS_IDFormat.idf_stat = #GENFormat.gen_stat
            --          AND CS_IDFormat.idf_sys = #GENFormat.gen_sys
                      AND CS_IDFormat.idf_code = #GENFormat.gen_code)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DEL@CS_IDFormat:' + CAST(@row AS VARCHAR)
  
  --第三步 没有Update的操作
  PRINT 'UPDATE@CS_IdFormat: NULL'
  
  --第四步
  INSERT INTO cs_IdFormat(idf_stat, idf_sys, idf_code, idf_format, idf_CrDate, idf_User)
  SELECT gen_stat, gen_sys, gen_code, 'yymm',  GETDATE(), N'admin'
  FROM #GENFormat
  WHERE NOT EXISTS (SELECT * FROM cs_IdFormat 
                    WHERE CS_IDFormat.idf_stat = #GENFormat.gen_stat
              --    AND CS_IDFormat.idf_sys = #GENFormat.gen_sys
                      AND CS_IDFormat.idf_code = #GENFormat.gen_code)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@CS_IdFormat:' + CAST(@row AS VARCHAR)
  
  --第五步
  DROP TABLE #GENFormat
end
GO
