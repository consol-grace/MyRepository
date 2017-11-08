USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_TINV_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[FW_UPDATE_TINV_SP]
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
  --将旧表放入临时表
  DECLARE @RecCount INTEGER
  DECLARE @i INTEGER
  DECLARE @MaxSeed NUMERIC(18, 0)  
  
  /*************************
  导入Invoice表
  
  
  **************************/
  --DROP TABLE T_INV
  --DELETE FROM co_Invoice
  --DELETE FROM co_InvoiceDetail
  --GO
  
  --第一步 将数据(包括Invoice, InvoiceDetail两个表的数据)放入临时表中 OK
  
  --第二步 删除旧表中已经删除的数据 OK
  
  DELETE n FROM co_Invoice n
  WHERE NOT EXISTS (SELECT NULL FROM T_INV o
                    WHERE o.inv_stat collate database_default = n.inv_stat
                      and o.inv_id = n.inv_id)
  
  /*
  SELECT inv_stat FROM T_INV
  SELECT inv_stat, inv_seed FROM co_Invoice
  SELECT * FROM T_INV, co_invoice WHERE o.inv_stat = n.inv_stat and o.inv_id = n.inv_id
  */
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DELETE@co_invoice:' + CAST(@row AS VARCHAR)
  
  --第三步 通过旧表更新新表中的数据 OK
  UPDATE n
  SET inv_Sys = o.inv_Sys
    , inv_ParentType = o.inv_Type
    , inv_Payment = o.inv_Payment
    , inv_LotNo = o.inv_LotNo
    , inv_ShpNo = o.inv_RefNo
    , inv_MasterNo = o.inv_MAWB
    , inv_HouseNo =  o.inv_HAWB
    , inv_InvoiceNo  = o.inv_InvNo
    , inv_ETD = o.inv_FDate
    , inv_ETA = o.inv_FDate
    , inv_InvoiceDate = o.inv_Date
    , inv_CrDate = o.inv_Date
--    , inv_LstDate = o.inv_Date
    , inv_Sales = o.inv_RepUsr
    , inv_Receipt = o.inv_Depart
    , inv_Load = o.inv_Dest
    , inv_Discharge = o.inv_Dest
    , inv_Final = o.inv_Dest
    , inv_CompanyCode = o.inv_Company
    , inv_CompanyName = o.inv_CoName
    , inv_Address1 = o.inv_Add1
    , inv_Address2 = o.inv_Add2
    , inv_Address3 = o.inv_Add3
    , inv_Address4 = o.inv_Add4
    , inv_Phone = o.inv_Tel
    , inv_Fax = o.inv_Fax
    , inv_Contact = o.inv_Contact
    , inv_Shipper = o.inv_Shipper
    , inv_ShipperLine = o.inv_Shpr
    , inv_Consignee = o.inv_Consignee
    , inv_ConsigneeLine = o.inv_Cnee
    , inv_Carrier = o.inv_Carrier
    , inv_FlightNo = o.inv_No
    , inv_GWT = o.inv_Gwt
    , inv_VWT = o.inv_Vwt
    , inv_CWT = o.inv_Cwt
    , inv_WTUnit = o.inv_WtUnit
    , inv_Pkgs = o.inv_Carton
    , inv_UnitDesc = o.inv_Ctndesc
    , inv_Currency = o.inv_cur
    , inv_Tax = o.inv_tax
    , inv_TaxTotal = o.inv_Taxtot
    , inv_NetTotal = o.inv_Nettot
    , inv_ActTotal = o.inv_Acttot
    , inv_Total = o.inv_Total
    , inv_Remark = o.inv_memo
    , inv_User = o.inv_User
    , inv_OWNER = o.inv_Own
    , inv_Status = o.inv_State
  --  , inv_Seed = o.inv_Seed
    , inv_Vessel = CASE WHEN o.cstrIndex> 0 THEN SUBSTRING(o.inv_Voyage, 1, o.cstrIndex-1) END
    , inv_Voyage = CASE WHEN o.cstrIndex> 0 THEN SUBSTRING(o.inv_Voyage, o.cstrIndex+1, LEN(o.inv_Voyage)-o.cstrIndex) END
    , inv_ToMaster = CASE WHEN o.inv_ShpType = 1 THEN o.Inv_ShpID ELSE NULL END 
    , inv_ToHouse = CASE WHEN o.inv_ShpType = 2 THEN o.Inv_ShpID ELSE NULL END
    , inv_IsDN = CASE o.inv_Payment WHEN 1 THEN 1 WHEN 2 THEN 0 ELSE NULL END
    , inv_IsCN = CASE o.inv_Payment WHEN 2 THEN 1 WHEN 1 THEN 0 ELSE NULL END
    , inv_IsLocal = CASE WHEN o.inv_stat = 'CON/HKG' AND o.INV_CUR = 'HKD' THEN 1 WHEN o.inv_stat <> 'CON/HKG' AND o.INV_CUR = 'RMB' THEN 1 ELSE 0 END
    , inv_IsForeign = CASE WHEN o.inv_stat = 'CON/HKG' AND o.INV_CUR = 'HKD' THEN 0 WHEN o.inv_stat <> 'CON/HKG' AND o.INV_CUR = 'RMB' THEN 0 ELSE 1 END
    , inv_ForeignLocal = CASE WHEN o.inv_stat = 'CON/HKG' AND o.INV_CUR = 'HKD' THEN 'L' WHEN o.inv_stat <> 'CON/HKG' AND o.INV_CUR = 'RMB' THEN 'L' ELSE 'F' END
    , inv_IsOutstand = CASE WHEN o.inv_state=0 THEN 1 ELSE 0 END
    , inv_IsVoid = CASE WHEN o.inv_state=1 THEN 1 ELSE 0 END
    , inv_IsRecalled = CASE WHEN o.inv_state=2 THEN 1 ELSE 0 END
    , inv_IsPrinted = CASE WHEN o.inv_state in (3, 4) THEN 1 ELSE 0 END
    , inv_IsAC = CASE WHEN o.inv_state in (4, 5) THEN 1 ELSE 0 END
    , inv_Factor = CASE o.inv_Payment WHEN 1 THEN 1 WHEN 2 THEN -1 ELSE NULL END
  FROM T_INV o, co_invoice n
  WHERE o.inv_stat collate database_default = n.inv_stat AND o.inv_id = n.inv_id
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@co_Invoice:' + CAST(@row AS VARCHAR)
  
  --在新表中插入旧表新增的数据

  
  --将需要新增的记录放入临时表
  SELECT identity(int, 1, 1) AS ROWID2, *
  INTO #Inv2
  FROM T_INV o
  WHERE NOT EXISTS (SELECT ISNULL(inv_ID, 0) FROM co_InVoice n
                    WHERE o.inv_stat collate database_default = n.inv_stat  
                      AND o.inv_id = n.inv_id) 
  
  SELECT @RecCount = COUNT(*) FROM #INV2
  PRINT 'INSERT@co_Invoice:' + CAST(@RecCount AS VARCHAR)
  
  SET @i = 1
  WHILE @i <= @RecCount 
  BEGIN
    EXEC fw_NewSeed_SP @MaxSeed OUTPUT   --生成一个新的Seed
    --一条一条新增记录
    INSERT INTO co_invoice
      ( inv_id, inv_Stat, inv_Sys, inv_ParentType, inv_Payment 
      , inv_LotNo, inv_ShpNo, inv_MasterNo, inv_HouseNo, inv_InvoiceNo 
      , inv_ETD, inv_ETA, inv_InvoiceDate, inv_CrDate, inv_Sales, inv_Receipt, inv_Load, inv_Discharge, inv_Final
      , inv_CompanyCode, inv_CompanyName, inv_Address1, inv_Address2, inv_Address3, inv_Address4, inv_Phone, inv_Fax, inv_Contact
      , inv_Shipper, inv_ShipperLine, inv_Consignee, inv_ConsigneeLine, inv_Carrier, inv_FlightNo
      , inv_GWT, inv_VWT, inv_CWT, inv_WTUnit, inv_Pkgs, inv_UnitDesc, inv_Currency, inv_Tax
      , inv_TaxTotal, inv_NetTotal, inv_ActTotal, inv_Total, inv_Remark, inv_User, inv_OWNER, inv_Status  
      , inv_Seed
      , inv_Vessel
      , inv_Voyage  
      , inv_ToMaster
      , inv_ToHouse
      , inv_IsDN
      , inv_IsCN
      , inv_IsLocal
      , inv_IsForeign
      , inv_ForeignLocal
      , inv_IsOutstand
      , inv_IsVoid
      , inv_IsRecalled
      , inv_IsPrinted
      , inv_IsAC
      , inv_Factor, inv_active
    --  , inv_IsPreforma, inv_PreInvoiceNo, inv_PreVersion, inv_ToInvoice
    )
    SELECT
       inv_id, isnull(inv_stat, ''), inv_Sys, inv_Type, inv_Payment 
      , inv_LotNo, inv_RefNo, inv_MAWB, inv_HAWB, inv_InvNo 
      , inv_FDate, inv_FDate, inv_Date, inv_Date, inv_RepUsr, inv_Depart, inv_Depart, inv_Dest, inv_Dest 
      , isnull(inv_Company, ''), inv_CoName, inv_Add1, inv_Add2, inv_Add3, inv_Add4, inv_Tel, inv_Fax, inv_Contact
      , Inv_Shipper, inv_Shpr, inv_Consignee, inv_Cnee, inv_Carrier, inv_carrier
      , inv_Gwt, inv_Vwt, inv_Cwt, inv_WtUnit, inv_Carton, inv_Ctndesc, inv_cur, inv_tax
      , inv_Taxtot, inv_Nettot, inv_Acttot, inv_Total, inv_memo, inv_User, inv_Own, inv_State  
      , @MaxSeed AS Seed
      , CASE WHEN cstrIndex> 0 THEN SUBSTRING(inv_Voyage, 1, cstrIndex-1) END Voyage
      , CASE WHEN cstrIndex> 0 THEN SUBSTRING(inv_Voyage, cstrIndex+1, LEN(inv_Voyage)-cstrIndex) END Vessel  
      , CASE WHEN inv_ShpType = 1 THEN Inv_ShpID ELSE NULL END ToMaster
      , CASE WHEN inv_ShpType = 2 THEN Inv_ShpID ELSE NULL END ToHouse
      , CASE inv_Payment WHEN 1 THEN 1 WHEN 2 THEN 0 ELSE NULL END IsDN
      , CASE inv_Payment WHEN 2 THEN 1 WHEN 1 THEN 0 ELSE NULL END IsCN
      , CASE WHEN inv_stat = 'CON/HKG' AND INV_CUR = 'HKD' THEN 1 WHEN inv_stat <> 'CON/HKG' AND INV_CUR = 'RMB' THEN 1 ELSE 0 END IsLocal
      , CASE WHEN inv_stat = 'CON/HKG' AND INV_CUR = 'HKD' THEN 0 WHEN inv_stat <> 'CON/HKG' AND INV_CUR = 'RMB' THEN 0 ELSE 1 END IsForeign
      , CASE WHEN inv_stat = 'CON/HKG' AND INV_CUR = 'HKD' THEN 'L' WHEN inv_stat <> 'CON/HKG' AND INV_CUR = 'RMB' THEN 'L' ELSE 'F' END ForeignLocal
      , CASE WHEN inv_state=0 THEN 1 ELSE 0 END IsOutstand
      , CASE WHEN inv_state=1 THEN 1 ELSE 0 END IsVoid
      , CASE WHEN inv_state=2 THEN 1 ELSE 0 END IsRecalled
      , CASE WHEN inv_state in (3, 4) THEN 1 ELSE 0 END IsPrinted
      , CASE WHEN inv_state in (4, 5) THEN 1 ELSE 0 END IsAC
      , CASE inv_Payment WHEN 1 THEN 1 WHEN 2 THEN -1 ELSE NULL END Factor
      , 1
    FROM #INV2
    WHERE ROWID2 = @i
  
    if @i % 2000 = 0
       PRINT @i

    SET @i =  @i + 1
  end
  DROP TABLE #inv2
  
end
GO
