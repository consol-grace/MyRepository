USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_AirImport_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_AirImport_SP]
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
  DECLARE @RecCount INTEGER
  DECLARE @i INTEGER
  DECLARE @MaxSeed NUMERIC(18, 0)  
  
  /******************************************
    空运提单表:co_AIR <-- G_AWB
  
    字段对应关系:
    co_AIR.air_ID = G_AWB.awb_id
    co_AIR.air_stat = G_AWB.AWB_OWN
  *******************************************/
  --第一步
  PRINT ' '
  PRINT '-------------------- co_AIR <-- G_AWB ------------------------'
  SELECT STATION --, ROWID
    , AWB_OWN COLLATE DATABASE_DEFAULT AS AWB_STAT 
    , AWB_ID, AWB_TYPE, AWB_SHPID, AWB_SHPTYPE, AWB_STATE, AWB_CSID, AWB_CSTYPE, AWB_MAWB, AWB_HAWB, AWB_AILOT, AWB_LOTNO, AWB_REFNO
    , AWB_RECDATE, AWB_USER, AWB_CARRIER, AWB_SHIPPER, AWB_CNEE, AWB_NOTIFY1, AWB_NOTIFY2, AWB_TO1, AWB_DPTDATE, AWB_ARRDATE, AWB_FLTNO
    , AWB_FRLOC, AWB_TOLOC, AWB_GWT, AWB_VWT, AWB_CWT, AWB_RCP, AWB_SALES, AWB_CUR, AWB_CHGS
  INTO #AIR
  FROM c_transfer.consol_transfer.dbo.G_AWB
  -------------------------------------------------    
  SELECT @row = @@ROWCOUNT
  PRINT 'INSERT@#AIR:' + CAST(@row AS VARCHAR)


  --第二步
  DELETE FROM co_Air
  WHERE NOT EXISTS (SELECT * FROM #AIR 
                    WHERE co_AIR.air_ID = #AIR.awb_id 
                      AND co_AIR.air_stat = #AIR.awb_stat)
  -------------------------------------------------  
  SELECT @row = @@ROWCOUNT
  PRINT 'DELETE@co_AIR:' + CAST(@row AS VARCHAR)


  DELETE FROM co_Import
  WHERE NOT EXISTS (SELECT * FROM #AIR 
                    WHERE co_Import.imp_ID = #AIR.AWB_ID
                      AND co_Import.imp_stat = #AIR.AWB_STAT)
  -------------------------------------------------  
  SELECT @row = @@ROWCOUNT
  PRINT 'DELETE@co_Import:' + CAST(@row AS VARCHAR)

  
  --第三步
  UPDATE co_AIR
  SET
     air_SYS = N'AI'
    , air_ToMAWB = o.AWB_CSID
    , air_ToHAWB = o.AWB_SHPID -- ALL NULL
    , air_Type = o.AWB_SHPTYPE -- ALL NULL
    , air_MAWB = o.AWB_MAWB
    , air_HAWB = o.AWB_HAWB
    , air_LotNo = o.AWB_LOTNO 
    , air_BookNo = o.AWB_REFNO
    , air_AutoHAWB = 0 -- FALSE
    , air_IsMAWB = CASE o.AWB_TYPE WHEN 1 THEN 1 WHEN 2 THEN 0 END
    , air_IsHAWB = CASE o.AWB_TYPE WHEN 1 THEN 0 WHEN 2 THEN 1 END
    , air_IsSub = 0 -- FALSE
    , air_IsUnder = 0 -- FALSE
    , air_IsDirect = CASE WHEN o.AWB_CSTYPE = 2 THEN 1 ELSE 0 END
    , air_IsColoadMAWB = 0 -- FALSE
    , air_IsColoadHAWB = 0 -- FALSE
    , air_IsManifest = 0 -- FALSE
    , air_Status = (select st_ROWID from cs_status where st_Code = 'SETTLE') --o.AWB_STATE
    , air_DG = 0
    , air_Insurance = 0
    , air_Sales = o.AWB_SALES
    , air_Ereceipt = o.AWB_RECDATE
    , air_ETD = o.AWB_DPTDATE
    , air_ETA = o.AWB_ARRDATE
--    , air_ATD = o.AWB_DPTDATE
    , air_ATA = o.AWB_ARRDATE
    , air_Shipper = o.AWB_SHIPPER
    , air_Consignee = o.AWB_CNEE
    , air_Carrier = substring(o.AWB_FLTNO, 1, 2)  --o.AWB_CARRIER
  --  , air_Broker = o.
  --  , air_CoLoader = o.AWB_COLOADER
    , air_PartyA = o.AWB_NOTIFY1
    , air_PartyB = o.AWB_NOTIFY2
    , air_LocReceived = o.AWB_FRLOC
    , air_LocLoad = o.AWB_FRLOC
  --  , air_LocVia1 = o.
  --  , air_LocVia2 = o.
    , air_LocDischarge = o.AWB_TOLOC
    , air_LocFinal = o.AWB_TOLOC
    , air_Airline = o.AWB_CARRIER
--    , air_FlightNo = substring(o.AWB_FLTNO, 3, 10)--o.AWB_FLTNO
    , air_Flight = o.AWB_FLTNO
    , air_GWT = o.AWB_GWT
    , air_VWT = o.AWB_VWT
    , air_CWT = o.AWB_CWT
    , air_Piece = o.AWB_RCP
    , air_Unit = N'KG'
  --  , air_CBM = o.AWB_CBM
  --  , air_Pallet = o.AWB_PALET
  --  , air_NP = o.AWB_NP
  --  , air_Rate = o.AWB_RATE
  --  , air_CompanyReferance = o.AWB_REFCO
  --  , air_CSMode = o.AWB_CSMODE
  --  , air_SpecicalDeal = o.AWB_SNDEAL
      , air_Oawbid = o.AWB_ID
  --  , air_Olkid = o.
  --  , air_Oawlink = o.
  --  , air_Osnlink = o.
  --  , air_Ocslink = o.
--    , air_LastUser = o.AWB_USER
    , air_CrDate = o.AWB_RECDATE
    , air_LstDate = o.AWB_RECDATE
    , air_User = o.AWB_USER
  FROM #AIR o
  WHERE co_AIR.air_id = o.awb_id
    AND co_AIR.air_stat = o.awb_stat
  -------------------------------------------------      
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@co_AIR:' + CAST(@row AS VARCHAR)


  UPDATE co_Import
  SET imp_Seed = air_Seed
    , imp_ToMaster = AWB_CSID
    , imp_ToHouse = AWB_SHPID
    , imp_LotNo = AWB_AILOT
    , imp_CrDate = AWB_RECDATE
    , imp_User = AWB_USER
  FROM #AIR, co_AIR
  WHERE imp_ID = air_ID
    AND imp_ID = AWB_ID
    AND imp_STAT = AWB_STAT
    AND imp_STAT = air_STAT
  -------------------------------------------------      
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@co_Import:' + CAST(@row AS VARCHAR)

  
  
  --将需要新增的记录放入临时表
  SELECT identity(int, 1, 1) AS ROWID2, *
  INTO #AIR2
  FROM #AIR
  WHERE NOT EXISTS (SELECT * FROM co_Air 
                    WHERE co_AIR.air_id = #AIR.awb_id 
                      AND co_AIR.air_stat = #AIR.awb_stat) 
  
  SELECT @RecCount = COUNT(*) FROM #AIR2
  PRINT 'INSERT@co_AIR:' + CAST(@RecCount AS VARCHAR)
  
  --第四步
  SET @i = 1
  WHILE @i <= @RecCount 
  BEGIN
    EXEC fw_NewSeed_SP @MaxSeed OUTPUT   --生成一个新的Seed
  
    INSERT INTO co_AIR(
      air_id, air_ToMAWB, air_ToHAWB, air_Type, air_MAWB, air_HAWB, air_LotNo, air_BookNo, air_Status, air_Sales
     , air_EReceipt, air_ETD, air_ETA , air_Shipper, air_Consignee, air_Carrier, air_PartyA, air_PartyB
     , air_LocReceived, air_LocLoad, air_LocDischarge, air_LocFinal, air_Airline, air_Flight
     , air_GWT, air_VWT, air_CWT, air_Piece, air_LastUser, air_CrDate, air_LstDate, air_User 
     , air_stat
     , air_SYS 
     , air_Seed 
     , air_Unit 
     , air_AutoHAWB 
     , air_IsSub 
     , air_IsUnder 
     , air_IsColoadMAWB 
     , air_IsColoadHAWB 
     , air_IsManifest 
     , air_IsMAWB 
     , air_IsHAWB 
     , air_IsDirect
  --  , air_DG, air_Insurance, air_Broker, air_LocVia1 , air_LocVia2 , air_Oawbid , air_Olkid , air_Oawlink, air_Osnlink , air_Ocslink = o.
    )
    SELECT
       AWB_ID, AWB_CSID, AWB_SHPID, AWB_SHPTYPE, AWB_MAWB, AWB_HAWB, AWB_LOTNO, AWB_REFNO, AWB_STATE, AWB_SALES
      , AWB_RECDATE, AWB_DPTDATE, AWB_ARRDATE, AWB_SHIPPER, AWB_CNEE, AWB_CARRIER, AWB_NOTIFY1, AWB_NOTIFY2
      , AWB_FRLOC, AWB_FRLOC, AWB_TOLOC , AWB_TOLOC , AWB_CARRIER, AWB_FLTNO
      , AWB_GWT, AWB_VWT, AWB_CWT, AWB_RCP, AWB_USER, AWB_RECDATE, AWB_RECDATE, AWB_USER
      , AWB_STAT
      , N'AI'
      , @MaxSeed
      , 'KG'
      , 0 --AUTOHAWB
      , 0 --ISSub
      , 0 --ISUnder
      , 0 --ISColoadMAWB
      , 0 --IsColoadHAWB
      , 0 --ISManifest
      , CASE AWB_TYPE WHEN 2 THEN 1 WHEN 1 THEN 0 END
      , CASE AWB_TYPE WHEN 1 THEN 1 WHEN 2 THEN 0 END
      , CASE WHEN AWB_CSTYPE = 2 THEN 1 ELSE 0 END   
    FROM #AIR2 WHERE ROWID2 =  @i
    SET @i =  @i + 1
  end

  --第四步
  INSERT INTO co_Import (imp_ID, imp_STAT, imp_SYS, imp_Seed, imp_ToMaster, imp_ToHouse, imp_LotNo, 
              imp_Surrender, imp_active, imp_CrDate, imp_User)

  SELECT AWB_ID, AWB_STAT, N'AI', a.air_seed, AWB_CSID, AWB_SHPID, AWB_AILOT, 
         0, 1, AWB_RECDATE, AWB_USER
  FROM #AIR ai inner join co_Air a on a.air_id = ai.awb_id and a.air_stat = ai.awb_stat
               left join co_Import imp on imp.imp_id = a.air_id and imp.imp_stat = a.air_Stat
  where imp_seed is null

  -------------------------------------------------      
  SELECT @row = @@ROWCOUNT
  PRINT 'INSERT@co_Import:' + CAST(@row AS VARCHAR)
  
  --第五步
  DROP TABLE #AIR2

/******************************************
  空运提单表:co_Import <-- G_AWB

  字段对应关系:
  co_Import.imp_ID = G_AWB.awb_id
  co_AIR.air_stat = G_AWB.AWB_OWN
*******************************************/
  PRINT ' '
  PRINT '-------------------- co_Import <-- G_AWB ------------------------'

  DROP TABLE #AIR
end
GO
