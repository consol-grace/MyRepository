USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_AirFlight_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_AirFlight_SP]
AS
begin
  DECLARE  @row INTEGER
  
  /******************************************
    空运航班表:co_ShipmentRoute <-- G_AWB, T_CSFLG
  
    字段对应关系:
  *******************************************/
  --第一步
  PRINT ' '
  PRINT '-------------------- co_ShipmentRoute <-- T_CSFLG, G_AWB ---[AI]-------------------'
  
  select * into #t_csflg from c_transfer.consol_transfer.dbo.t_csflg
  select * into #g_awb from c_transfer.consol_transfer.dbo.g_awb
  
  SELECT awb_OWN csf_stat, csf_ID, csf_CODE, csf_LINE, csf_TO, csf_CARRIER, csf_NO, AWB_FRLOC, AWB_TOLOC, AWB_DPTDATE, AWB_ARRDATE, AWB_RECDATE, AWB_USER  
  INTO #AIR
  FROM #T_CSFLG f, #G_AWB a
  WHERE csf_CODE = AWB_ID
    and a.station = f.station and 'AI' = 'AE' -- ONLY CAN DO IT FOR AI
  
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INSERT@#AIR:' + CAST(@row AS VARCHAR)
  
  --第二步
  DELETE n FROM co_ShipmentRoute n
  WHERE NOT EXISTS (SELECT * FROM #AIR o
                    WHERE n.sr_Parent = o.csf_Code and n.sr_OrderID = o.csf_line
                      and n.sr_stat = o.csf_stat collate database_default)
  SELECT @row = @@ROWCOUNT
  PRINT 'DELETE@co_ShipmentRoute:' + CAST(@row AS VARCHAR)
  
  --第三步
  UPDATE T
  SET sr_ID = o.CSF_ID
    , sr_Parent = o.CSF_CODE
    , sr_OrderID = o.CSF_LINE
    , sr_carrier = o.CSF_CARRIER
--    , sr_vessel = o.CSF_NO
--    , sr_voyage = o.CSF_NO
    , sr_Flight = o.CSF_CARRIER + Right('000' + cast(o.CSF_NO as nvarchar(10)), case when o.CSF_No > 999 then 4 else 3 end) 
    , sr_From = o.AWB_FRLOC
    , sr_To = o.AWB_TOLOC
    , sr_ETD = o.AWB_DPTDATE
    , sr_ETA = o.AWB_ARRDATE
  --  , sr_Remark = o.
    , sr_CrDate = o.AWB_RECDATE
    , sr_LstDate = o.AWB_RECDATE
    , sr_User = o.AWB_USER
  FROM
    #AIR o, co_ShipmentRoute t
  WHERE t.sr_Stat = o.csf_Stat collate database_default
    AND t.sr_Parent = o.csf_Code 
    AND t.sr_OrderID = o.csf_Line
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@co_ShipmentRoute:' + CAST(@row AS VARCHAR)
  
  --第四步
  DECLARE @RecCount INTEGER
  DECLARE @i INTEGER
  DECLARE @MaxSeed NUMERIC(18, 0)  
  
  --将需要新增的记录放入临时表
  SELECT identity(int, 1, 1) AS ROWID2, *
  INTO #AIR2
  FROM #AIR o
  WHERE NOT EXISTS (SELECT * FROM co_ShipmentRoute n
                    WHERE n.sr_stat = o.csf_stat collate database_default
                      and n.sr_ID = o.csf_id)
  
  SELECT @RecCount = COUNT(*) FROM #AIR2
  PRINT 'INSERT@co_ShipmentRoute:' + CAST(@RecCount AS VARCHAR)
  
  SET @i = 1
  WHILE @i <= @RecCount 
  BEGIN
    EXEC fw_NewSeed_SP @MaxSeed OUTPUT   --生成一个新的Seed
  
    INSERT INTO co_ShipmentRoute
       (sr_Seed, sr_stat, sr_ID, sr_Parent, sr_OrderID, sr_carrier, SR_flight, sr_From, sr_To, sr_ETD, sr_ETA
       , sr_CrDate, sr_LstDate, sr_User)
    SELECT @MaxSeed, CSF_STAT, CSF_ID, CSF_CODE, CSF_LINE, CSF_CARRIER,
           CSF_CARRIER + Right('000' + cast(CSF_NO as nvarchar(10)), case when CSF_No > 999 then 4 else 3 end),
           AWB_FRLOC, AWB_TOLOC, AWB_DPTDATE, AWB_ARRDATE, AWB_RECDATE, AWB_RECDATE, AWB_USER
    FROM #AIR2
    WHERE ROWID2 =  @i
    SET @i =  @i + 1
  end
  
  --第五步
  DROP TABLE #AIR2
  DROP TABLE #AIR
  DROP TABLE #t_csflg
  DROP TABLE #g_awb
end
GO
