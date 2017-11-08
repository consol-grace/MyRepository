USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_TINVDTL_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_TINVDTL_SP]
AS
begin  
  DECLARE  @row INTEGER
  DECLARE @RecCount INTEGER
  DECLARE @i INTEGER
  DECLARE @MaxSeed NUMERIC(18, 0)  
  /*************************
    导入InvoiceDetail表
    对应条件
    id_stat = inv_stat 站点相同
    id_id = ind_id     ID相同
  **************************/

  --第一步 删除旧表中已经删除的数据 OK
  DELETE n FROM co_InvoiceDetail n
  WHERE NOT EXISTS (SELECT NULL FROM T_INVDTL o 
                    WHERE id_stat = o.inv_Stat collate database_default AND id_id = o.ind_id)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DELETE@co_InvoiceDetail:' + CAST(@row AS VARCHAR)
  
  --第三步 通过旧表更新新表中的数据 
  --需要考虑当前更新的字段是否完整，足够
  UPDATE n
  SET id_Parent = o.IND_CODE
    , id_Item = o.IND_ITEM
    , id_Description = o.IND_DESC
    , id_CurrencyOld = o.IND_OCUR
    , id_Currency = o.IND_CUR
    , id_ExRate = o.IND_EX
    , id_Qty = o.IND_QTY
    , id_Min = o.IND_MIN
    , id_Rate = o.IND_RATE
    , id_Amount = o.IND_AMT
    , id_TaxAmount = o.IND_TAXAMT
    , id_NetTotal = o.IND_NET
    , id_Percent = o.IND_PERCENT
    , id_ActTotal = o.IND_ACT
    , id_TaxQty = o.IND_QTY
    , id_TaxRate = o.IND_TAX
    , id_TaxTotal = o.IND_TAXAMT
  FROM co_InvoiceDetail n, T_INVDTL o, co_Invoice i
  WHERE o.inv_stat collate database_default = id_stat AND o.ind_id = id_id
    and o.inv_stat collate database_default = i.inv_stat AND o.ind_code = i.inv_id
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@co_InvoiceDetail:' + CAST(@row AS VARCHAR)
/*  
  --第四步 将旧表中新增的记录插入到新表中
  --将旧表放入临时表
  SET @RecCount = 0
  SET @MaxSeed = 0
  
  --将需要新增的记录放入临时表
  SELECT identity(int, 1, 1) as ROWID2, *
  INTO #InvDetail2
  FROM T_INVDTL d
  WHERE NOT EXISTS (SELECT * FROM co_InVoiceDetail d2
                    WHERE d.inv_stat = d2.id_stat  
                      AND d.ind_id = d2.id_id) 
  
  SELECT @RecCount = COUNT(*) FROM #InvDetail2
  PRINT 'INSERT@co_InvoiceDetail:' + CAST(@RecCount AS VARCHAR)
  
  SET @i = 1
  WHILE @i <= @RecCount 
  BEGIN
*/
--    EXEC fw_NewSeed_SP @MaxSeed OUTPUT   --生成一个新的Seed
    INSERT INTO co_InvoiceDetail
      (id_id, id_Parent, id_Item, id_Description, id_CurrencyOld, id_Currency, id_ExRate
      , id_Qty, id_Min, id_Rate, id_Amount, id_TaxAmount, id_NetTotal, id_Percent, id_ActTotal
      , id_TaxQty, id_TaxRate, id_TaxTotal
      , id_Seed
      , id_STAT 
      , id_SYS
  --    , id_ToMAWB  
  --    , id_ToHAWB  
      , id_CrDate  
      , id_LstDate  
      , id_User    )
    SELECT  IND_ID, IND_CODE, IND_ITEM, IND_DESC, IND_OCUR, IND_CUR, IND_EX
          , IND_QTY, IND_MIN, IND_RATE, IND_AMT, IND_TAXAMT, IND_NET, IND_PERCENT, IND_ACT
          , IND_QTY, IND_TAX, IND_TAXAMT
          , i.inv_Seed
          , i.inv_Stat
          , i.inv_SYS
      --    , inv_ToMaster
      --    , inv_ToHouse
          , inv_Date
          , inv_Date
          , i.inv_User
    FROM T_INVDTL d, co_Invoice i
    WHERE d.inv_stat collate database_default = i.inv_stat 
      AND d.ind_code = i.inv_id
      and NOT EXISTS (SELECT * FROM co_InVoiceDetail d2
                      WHERE d.inv_stat collate database_default = d2.id_stat  
                        AND d.ind_id = d2.id_id) 

  SELECT @row = @@ROWCOUNT
  PRINT 'Insert@co_InvoiceDetail:' + CAST(@row AS VARCHAR)

  --WHERE ROWID2 = @i
--    SET @i =  @i + 1
--  END
end
GO
