USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_Currecny_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_Currecny_SP]
AS
begin
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
    货币定义表：
    CS_Currency <-- T_CUR
    
    对应字段：
    n.cur_STAT = T_CUR.cur_STAT
    n.cur_SYS = T_CUR.cur_SYS
    n.cur_CODE = T_CUR.cur_CODE
  ******************************************/
  
  -- <第一步>
  PRINT ' '
  PRINT '-------------------- CS_Currency <-- T_CUR ------------------------'
  SELECT STATION COLLATE DATABASE_DEFAULT AS STATION
    , CUR_STAT COLLATE DATABASE_DEFAULT AS CUR_STAT
    , CUR_SYS COLLATE DATABASE_DEFAULT AS CUR_SYS 
    , CUR_CODE COLLATE DATABASE_DEFAULT AS CUR_CODE 
    , CUR_DESC, CUR_CNTY, CUR_RATE, CUR_USER, CUR_ID, CUR_NATIVE
  INTO #CUR
  FROM C_TRANSFER.CONSOL_TRANSFER.dbo.T_CUR
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#CUR:' + CAST(@row AS VARCHAR)
  
  -- <第二步>
  DELETE n 
  FROM CS_Currency n left join #cur o 
          on o.cur_STAT = n.cur_STAT AND o.cur_SYS = n.cur_SYS AND o.cur_CODE = n.cur_CODE
  WHERE o.cur_code is null

  SELECT @row = @@ROWCOUNT
  PRINT 'DEL@CS_Currency:' + CAST(@row AS VARCHAR)
  
  --第三步
  UPDATE n
  SET
     cur_ID = o.CUR_ID
    , cur_Description = o.CUR_DESC
    , cur_country = o.CUR_CNTY
    , cur_Rate = o.CUR_RATE
    , cur_Native = o.CUR_NATIVE
--    , cur_LstDate = GETDATE()
    , cur_User = o.CUR_USER
    , cur_Buy = o.CUR_RATE
    , cur_Sell = o.CUR_RATE
    , cur_BuildIn = case when o.cur_stat = 'CON/HKG' and o.cur_code = 'HKD' then 1 when o.cur_stat <> 'CON/HKG' and o.cur_code = 'RMB' then 1 when o.cur_code = 'USD' then 1 else 0 end
    , cur_isLocal = case when o.cur_stat = 'CON/HKG' and o.cur_code = 'HKD' then 1 when o.cur_stat <> 'CON/HKG' and o.cur_code = 'RMB' then 1 else 0 end
    , cur_isForeign = case when o.cur_code = 'USD' then 1 else 0 end
  --  , cur_CrDate = o.
  FROM
    #CUR o, cs_Currency n
  WHERE
    o.cur_STAT = n.cur_STAT AND o.cur_SYS = n.cur_SYS AND o.cur_Code = n.cur_Code 
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@CS_Currency:' + CAST(@row AS VARCHAR)
  
  --第四步
    INSERT INTO cs_Currency 
      (cur_ID, cur_SYS, cur_STAT, cur_Code, cur_Description, cur_country, cur_Rate, cur_CrDate, cur_Native, 
      cur_Active, cur_User, cur_Buy, cur_Sell, cur_BuildIn, cur_isLocal, cur_isForeign)--, cur_LstDate)
      SELECT o.CUR_ID, o.CUR_SYS, o.CUR_STAT, o.CUR_CODE, o.CUR_DESC, o.CUR_CNTY, o.CUR_RATE, GETDATE(), o.CUR_NATIVE, 
             case when len(isnull(o.cur_code, '')) < 2 or isnumeric(o.cur_code) = 1 then 0 else 1 end, o.CUR_USER, o.CUR_RATE, o.CUR_RATE,
             case when o.cur_stat = 'CON/HKG' and o.cur_code = 'HKD' then 1 when o.cur_stat <> 'CON/HKG' and o.cur_code = 'RMB' then 1 when o.cur_code = 'USD' then 1 else 0 end,
             case when o.cur_stat = 'CON/HKG' and o.cur_code = 'HKD' then 1 when o.cur_stat <> 'CON/HKG' and o.cur_code = 'RMB' then 1 else 0 end,
             case when o.cur_code = 'USD' then 1 else 0 end
      FROM #CUR o left join CS_Currency n on o.cur_STAT = n.cur_STAT AND o.cur_SYS = n.cur_SYS AND o.cur_CODE = n.cur_CODE
      WHERE n.cur_code is null
	      and len(isnull(o.cur_code, '')) > 0
      order by o.cur_stat, o.cur_sys, o.cur_code

    SELECT @row = @@ROWCOUNT
    PRINT 'INS@CS_Currency:' + CAST(@row AS VARCHAR)
  
  --第五步
  DROP TABLE #CUR
end
GO
