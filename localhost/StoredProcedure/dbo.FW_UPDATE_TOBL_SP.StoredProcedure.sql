USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_TOBL_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_TOBL_SP]
AS

DECLARE  @row INTEGER

/******************************************
  提单表
  CO_OCEAN <-- TO_BL 
  CO_BLINFO <-- TO_BL 
  CL_BLDETAIL <-- TO_BL 
  对应关系
  o_ID = bl_id
  o_stat = bl_stat
  o_sys = bl_sys 
  BL_SYS = 'OI'
******************************************/
--第一步
PRINT ' '
PRINT '-------------------- CO_OCEAN <-- TO_BL ------------------------'

SELECT 
  *
INTO #TOBL
FROM
  TO_BL
WHERE BL_SYS = 'OI' --只转换 OI ，OE在其它地方转换

SELECT @row = @@ROWCOUNT
PRINT 'INS@#TOBL:' + CAST(@row AS VARCHAR)

--第二步
DELETE FROM
  CO_OCEAN
WHERE
  NOT EXISTS(
    SELECT * FROM #TOBL WHERE 
        o_ID = bl_id
    AND o_stat = bl_stat
    AND o_sys = bl_sys
  )

SELECT @row = @@ROWCOUNT
PRINT 'DELETE@CO_OCEAN:' + CAST(@row AS VARCHAR)

--第三步
UPDATE
  CO_OCEAN
SET
   o_ToMBL = o.BL_TOMBL
  ,o_ToHBL = o.BL_TOHBL
  ,o_Type = o.BL_BLTYPE
  ,o_BookNo = o.BL_BKNO
  ,o_LotNo = o.BL_LOTNO
  ,o_SerialNo = o.BL_SN
  ,o_DONo = o.BL_DONO
  ,o_MBL = o.BL_MBL
  ,o_HBL = o.BL_HBL
  ,o_IsPrinted = CASE o.BL_DOHBL WHEN 0 THEN 1 ELSE 0 END
  ,o_DG = o.BL_DG
--  ,o_Insurance = o.
  ,o_Status = o.BL_STATE
  ,o_Sales = o.BL_SALES
  ,o_PaymentMode = o.BL_PAYMODE
  ,o_ServiceMode = o.BL_SERMODE
  ,o_Carrier = o.BL_CARRIER
  ,o_Shipper = o.BL_SHPR
  ,o_Consignee = o.BL_CNEE
  ,o_PartyA = o.BL_PARTYA
  ,o_PartyB = o.BL_PARTYB
  ,o_Coloader = o.BL_COLOAD
  ,o_Discharge = o.BL_LOCDISCHG
  ,o_Broker = o.BL_BROKER
  ,o_LocReceipt = o.BL_LOCRECE
  ,o_LocPOL = o.BL_LOCLOAD
  ,o_LocPOD = o.BL_LOCDISCHG
  ,o_LocFinal = o.BL_LOCFINAL
  ,o_VesselID = o.BL_VSID
  ,o_VoyageID = o.BL_VAID
  ,o_BCBM = o.BL_BKCBM
  ,o_ACBM = o.BL_ACTCBM
  ,o_CCBM = o.BL_CCBM
  ,o_CBM = o.BL_CBM
  ,o_BWT = o.BL_BKWT
  ,o_AWT = o.BL_ACTWT
  ,o_CWT = o.BL_CWT
  ,o_WT = o.BL_WT
  ,o_BPKGS = o.BL_BKPKGS
  ,o_APKGS = o.BL_ACTPKGS
  ,o_CPKGS = o.BL_CPKGS
  ,o_PKGS = o.BL_PKGS
  ,o_Unit = o.BL_UNIT
  ,o_CFS = o.BL_CFS
  ,o_CY = o.BL_CY
  ,o_BookDate = o.BL_BKDATE
  ,o_ScheduleDate = o.BL_SCHDATE
  ,o_SailingDATE = o.BL_SAILDATE
  ,o_ETD = o.BL_ETD
  ,o_ETA = o.BL_ETA
  ,o_ClosingDate = o.BL_CLOSE
  ,o_Attachment = o.BL_ATTACH
  ,o_CtnrInfo = o.BL_CNTRINFO
  ,o_DocumentType = o.BL_DOCTYPE
  ,o_CarrierATTN = o.BL_CARRATTN
  ,o_PrintGroup = o.BL_GROUP
  ,o_CrDate = o.BL_RECDATE
  ,o_LstDate = o.BL_RECDATE
  ,o_User = o.BL_RECBY
  ,o_CNAME1 = o.BL_CNAME1
  ,o_CNAME2 = o.BL_CNAME2
  ,o_CTEL1 = o.BL_CTEL1
  ,o_CTEL2 = o.BL_CTEL2
  ,o_CFAX1 = o.BL_CFAX1
  ,o_CFAX2 = o.BL_CFAX2
  ,o_CLBILL = o.BL_CLBILL
  ,o_CLCUR = o.BL_CLCUR
  ,o_CLEX = o.BL_CLEX
  ,o_CLMIN = o.BL_CLMIN
  ,o_CLRATE = o.BL_CLRATE
  ,o_CLTOT = o.BL_CLTOT
  ,o_PPBILL = o.BL_PPBILL
  ,o_PPCUR = o.BL_PPCUR
  ,o_PPEX = o.BL_PPEX
  ,o_PPMIN = o.BL_PPMIN
  ,o_PPRATE = o.BL_PPRATE
  ,o_PPTOT = o.BL_PPTOT
  ,o_SAMELOCATION = o.BL_SAMELOC
  ,o_SAMEDATE = o.BL_SAMEDATE
  ,o_ColoaderHBL = o.BL_COLOADERHBL
FROM
  #TOBL o
WHERE
      o_ID = bl_id
  AND o_stat = bl_stat
  AND o_sys = bl_sys

SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@co_OCEAN:' + CAST(@row AS VARCHAR)

--第四步
SELECT 
  identity(int, 1,1) AS ROWID2,*
INTO #TOBL2
FROM #TOBL
WHERE
  NOT EXISTS(SELECT * FROM co_OCEAN WHERE #TOBL.bl_stat = co_OCEAN.o_stat AND #TOBL.bl_sys = co_OCEAN.o_sys AND #TOBL.bl_id = co_OCEAN.o_id) 

DECLARE @RecCount INT
SELECT @RecCount = COUNT(*) FROM #TOBL2
PRINT 'INSERT@co_OCEAN:' + CAST(@RecCount AS VARCHAR)

DECLARE @i INT
DECLARE @MaxSeed INT
SET @i = 1
WHILE @i <= @RecCount 
BEGIN
  EXEC fw_NewSeed_SP @MaxSeed OUTPUT   --生成一个新的Seed

  INSERT INTO co_OCEAN(
     o_ID,o_STAT,o_SYS,o_Seed  --o_RowID,
    ,o_ToMBL,o_ToHBL,o_Type,o_BookNo,o_LotNo,o_DONo,o_MBL,o_HBL,o_IsPrinted,o_DG,o_Status,o_SerialNo--o_Insurance
    ,o_Sales,o_PaymentMode,o_ServiceMode,o_Carrier,o_Shipper,o_Consignee,o_PartyA,o_PartyB,o_Coloader
    ,o_Discharge,o_Broker,o_LocReceipt,o_LocPOL,o_LocPOD,o_LocFinal,o_VesselID,o_VoyageID
    ,o_BCBM,o_ACBM,o_CCBM,o_CBM,o_BWT,o_AWT,o_CWT,o_WT,o_BPKGS,o_APKGS,o_CPKGS,o_PKGS,o_Unit
    ,o_CFS,o_CY,o_BookDate,o_ScheduleDate,o_SailingDATE,o_ETD,o_ETA,o_ClosingDate
    ,o_Attachment,o_CtnrInfo,o_DocumentType,o_CrDate,o_LstDate,o_User,o_PrintGroup,o_CarrierATTN
    ,o_CNAME1,o_CNAME2,o_CTEL1,o_CTEL2,o_CFAX1,o_CFAX2,o_CLBILL,o_CLCUR,o_CLEX,o_CLMIN,o_CLRATE
    ,o_CLTOT,o_PPBILL,o_PPCUR,o_PPEX,o_PPMIN,o_PPRATE,o_PPTOT,o_SAMELOCATION,o_SAMEDATE,o_ColoaderHBL
  )
  SELECT
      BL_ID,BL_STAT,BL_SYS,@MaxSeed
     ,BL_TOMBL,BL_TOHBL,BL_BLTYPE,BL_BKNO,BL_LOTNO,BL_DONO,BL_MBL,BL_HBL,CASE BL_DOHBL WHEN 0 THEN 1 ELSE 0 END,BL_DG,BL_STATE,BL_SN
     ,BL_SALES,BL_PAYMODE,BL_SERMODE,BL_CARRIER,BL_SHPR,BL_CNEE,BL_PARTYA,BL_PARTYB,BL_COLOAD 
     ,BL_DISCHG,BL_BROKER,BL_LOCRECE,BL_LOCLOAD,BL_LOCDISCHG,BL_LOCFINAL,BL_VSID,BL_VAID 
     ,BL_BKCBM,BL_ACTCBM,BL_CCBM,BL_CBM,BL_BKWT,BL_ACTWT,BL_CWT,BL_WT,BL_BKPKGS,BL_BKPKGS,BL_CPKGS,BL_PKGS,BL_UNIT 
     ,BL_CFS,BL_CY,BL_BKDATE,BL_SCHDATE,BL_SAILDATE,BL_ETD,BL_ETA,BL_CLOSE
     ,BL_ATTACH,BL_CNTRINFO,BL_DOCTYPE,BL_RECDATE,BL_RECDATE,BL_RECBY,BL_GROUP,BL_CARRATTN
     ,BL_CNAME1,BL_CNAME2,BL_CTEL1,BL_CTEL2,BL_CFAX1,BL_CFAX2,BL_CLBILL,BL_CLCUR,BL_CLEX,BL_CLMIN,BL_CLRATE
     ,BL_CLTOT,BL_PPBILL,BL_PPCUR,BL_PPEX,BL_PPMIN,BL_PPRATE,BL_PPTOT,BL_SAMELOC,BL_SAMEDATE,BL_COLOADERHBL
  FROM #TOBL2
  WHERE ROWID2 = @i

  SET @i =  @i + 1
END

--第五步
DROP TABLE #TOBL2

SELECT 
  identity(int,1,1) ROWID,o.o_seed,bl.*
INTO #TOBL3
FROM
  TO_BL bl,CO_OCEAN o
WHERE
  bl.bl_stat = o.o_stat AND bl.bl_sys = o.o_sys AND bl.bl_id = o.o_id
  AND bl.BL_SYS = 'OI' --只转换 OI 的记录

SELECT @row = @@ROWCOUNT
PRINT 'INSERT@#TOBL3:' + CAST(@row AS VARCHAR)

/******************************************
  提单表
  CO_BLDetail <-- TO_BL 
  对应关系
  bld_ID = bl_id
  bld_stat = bl_stat
  bld_sys = bl_sys
******************************************/
PRINT ' '
PRINT '-------------------- CO_BLDetail <-- TO_BL ------------------------'

DELETE FROM co_BLDetail
WHERE bld_Seed NOT IN(SELECT o_Seed FROM #TOBL3)

SELECT @row = @@ROWCOUNT
PRINT 'DELETE@co_BLDetail:' + CAST(@row AS VARCHAR)

UPDATE co_BLDetail
SET
   bld_GWT = o.BL_IGWT01
  ,bld_VWT = o.BL_IVWT01
  ,bld_Mark01 = o.BL_IMARK01
  ,bld_Mark02 = o.BL_IMARK02
  ,bld_Mark03 = o.BL_IMARK03
  ,bld_Mark04 = o.BL_IMARK04
  ,bld_Mark05 = o.BL_IMARK05
  ,bld_Mark06 = o.BL_IMARK06
  ,bld_Mark07 = o.BL_IMARK07
  ,bld_Mark08 = o.BL_IMARK08
  ,bld_Mark09 = o.BL_IMARK09
  ,bld_Mark10 = o.BL_IMARK10
  ,bld_Mark11 = o.BL_IMARK11
  ,bld_Mark12 = o.BL_IMARK12
  ,bld_Mark13 = o.BL_IMARK13
  ,bld_Mark14 = o.BL_IMARK14
  ,bld_Mark15 = o.BL_IMARK15
  ,bld_Mark16 = o.BL_IMARK16
  ,bld_Mark17 = o.BL_IMARK17
  ,bld_Mark18 = o.BL_IMARK18
  ,bld_Mark19 = o.BL_IMARK19
  ,bld_Mark20 = o.BL_IMARK20
  ,bld_Mark21 = o.BL_IMARK21
  ,bld_PKGS01 = o.BL_IPKG01
  ,bld_PKGS02 = o.BL_IPKG02
  ,bld_PKGS03 = o.BL_IPKG03
  ,bld_PKGS04 = o.BL_IPKG04
  ,bld_PKGS05 = o.BL_IPKG05
  ,bld_PKGS06 = o.BL_IPKG06
  ,bld_PKGS07 = o.BL_IPKG07
  ,bld_PKGS08 = o.BL_IPKG08
  ,bld_PKGS09 = o.BL_IPKG09
  ,bld_PKGS10 = o.BL_IPKG10
  ,bld_PKGS11 = o.BL_IPKG11
  ,bld_PKGS12 = o.BL_IPKG12
  ,bld_PKGS13 = o.BL_IPKG13
  ,bld_PKGS14 = o.BL_IPKG14
  ,bld_PKGS15 = o.BL_IPKG15
  ,bld_PKGS16 = o.BL_IPKG16
  ,bld_PKGS17 = o.BL_IPKG17
  ,bld_PKGS18 = o.BL_IPKG18
  ,bld_PKGS19 = o.BL_IPKG19
  ,bld_PKGS20 = o.BL_IPKG20
  ,bld_PKGS21 = o.BL_IPKG21
  ,bld_Desc01 = o.BL_IDESC01
  ,bld_Desc02 = o.BL_IDESC02
  ,bld_Desc03 = o.BL_IDESC03
  ,bld_Desc04 = o.BL_IDESC04
  ,bld_Desc05 = o.BL_IDESC05
  ,bld_Desc06 = o.BL_IDESC06
  ,bld_Desc07 = o.BL_IDESC07
  ,bld_Desc08 = o.BL_IDESC08
  ,bld_Desc09 = o.BL_IDESC09
  ,bld_Desc10 = o.BL_IDESC10
  ,bld_Desc11 = o.BL_IDESC11
  ,bld_Desc12 = o.BL_IDESC12
  ,bld_Desc13 = o.BL_IDESC13
  ,bld_Desc14 = o.BL_IDESC14
  ,bld_Desc15 = o.BL_IDESC15
  ,bld_Desc16 = o.BL_IDESC16
  ,bld_Desc17 = o.BL_IDESC17
  ,bld_Desc18 = o.BL_IDESC18
  ,bld_Desc19 = o.BL_IDESC19
  ,bld_Desc20 = o.BL_IDESC20
  ,bld_Desc21 = o.BL_IDESC21
  ,bld_Freight1 = o.BL_FDESC1
  ,bld_Freight2 = o.BL_FDESC2
  ,bld_Freight3 = o.BL_FDESC3
  ,bld_Freight4 = o.BL_FDESC4
  ,bld_Freight5 = o.BL_FDESC5
  ,bld_Freight6 = o.BL_FDESC6
  ,bld_Freight7 = o.BL_FDESC7
  ,bld_Freight8 = o.BL_FDESC8
  ,bld_Freight9 = o.BL_FDESC9
  ,bld_Freight10 = o.BL_FDESC10
  ,bld_FCC1 = o.BL_FCL1
  ,bld_FCC2 = o.BL_FCL2
  ,bld_FCC3 = o.BL_FCL3
  ,bld_FCC4 = o.BL_FCL4
  ,bld_FCC5 = o.BL_FCL5
  ,bld_FCC6 = o.BL_FCL6
  ,bld_FCC7 = o.BL_FCL7
  ,bld_FCC8 = o.BL_FCL8
  ,bld_FCC9 = o.BL_FCL9
  ,bld_FCC10 = o.BL_FCL10
  ,bld_FCCTotal = o.BL_FCLTOT
  ,bld_FPP1 = o.BL_FPPD1
  ,bld_FPP2 = o.BL_FPPD2
  ,bld_FPP3 = o.BL_FPPD3
  ,bld_FPP4 = o.BL_FPPD4
  ,bld_FPP5 = o.BL_FPPD5
  ,bld_FPP6 = o.BL_FPPD6
  ,bld_FPP7 = o.BL_FPPD7
  ,bld_FPP8 = o.BL_FPPD8
  ,bld_FPP9 = o.BL_FPPD9
  ,bld_FPP10 = o.BL_FPPD10
  ,bld_FPPTotal = o.BL_FPPDTOT
  ,bld_CrDate = o.BL_RECDATE
  ,bld_LstDate = o.BL_RECDATE
  ,bld_User = o.BL_RECBY
  ,bld_NoDetail = o.BL_NoDetail
FROM #TOBL3 o
WHERE 
  bld_Seed = o.o_Seed
--  AND bld_ID = bl_ID
--  AND bld_STAT = bl_stat
--  AND bld_SYS = bl_sys  

SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@co_BLDetail:' + CAST(@row AS VARCHAR)
 
INSERT INTO co_BLDetail(
   bld_ID,bld_STAT,bld_SYS,bld_Seed
  ,bld_GWT,bld_VWT
  ,bld_Mark01,bld_Mark02,bld_Mark03,bld_Mark04,bld_Mark05,bld_Mark06,bld_Mark07,bld_Mark08,bld_Mark09,bld_Mark10,bld_Mark11,bld_Mark12,bld_Mark13,bld_Mark14,bld_Mark15,bld_Mark16,bld_Mark17,bld_Mark18,bld_Mark19,bld_Mark20,bld_Mark21
  ,bld_PKGS01,bld_PKGS02,bld_PKGS03,bld_PKGS04,bld_PKGS05,bld_PKGS06,bld_PKGS07,bld_PKGS08,bld_PKGS09,bld_PKGS10,bld_PKGS11,bld_PKGS12,bld_PKGS13,bld_PKGS14,bld_PKGS15,bld_PKGS16,bld_PKGS17,bld_PKGS18,bld_PKGS19,bld_PKGS20,bld_PKGS21
  ,bld_Desc01,bld_Desc02,bld_Desc03,bld_Desc04,bld_Desc05,bld_Desc06,bld_Desc07,bld_Desc08,bld_Desc09,bld_Desc10,bld_Desc11,bld_Desc12,bld_Desc13,bld_Desc14,bld_Desc15,bld_Desc16,bld_Desc17,bld_Desc18,bld_Desc19,bld_Desc20,bld_Desc21
  ,bld_Freight1,bld_Freight2,bld_Freight3,bld_Freight4,bld_Freight5,bld_Freight6,bld_Freight7,bld_Freight8,bld_Freight9,bld_Freight10
  ,bld_FCC1,bld_FCC2,bld_FCC3,bld_FCC4,bld_FCC5,bld_FCC6,bld_FCC7,bld_FCC8,bld_FCC9,bld_FCC10,bld_FCCTotal
  ,bld_FPP1,bld_FPP2,bld_FPP3,bld_FPP4,bld_FPP5,bld_FPP6,bld_FPP7,bld_FPP8,bld_FPP9,bld_FPP10,bld_FPPTotal
  ,bld_CrDate,bld_LstDate,bld_User,bld_NoDetail
  )
SELECT
   BL_ID,BL_STAT,BL_SYS,o_Seed
  ,BL_IGWT01,BL_IVWT01
  ,BL_IMARK01,BL_IMARK02,BL_IMARK03,BL_IMARK04,BL_IMARK05,BL_IMARK06,BL_IMARK07,BL_IMARK08,BL_IMARK09,BL_IMARK10,BL_IMARK11,BL_IMARK12,BL_IMARK13,BL_IMARK14,BL_IMARK15,BL_IMARK16,BL_IMARK17,BL_IMARK18,BL_IMARK19,BL_IMARK20,BL_IMARK21
  ,BL_IPKG01,BL_IPKG02,BL_IPKG03,BL_IPKG04,BL_IPKG05,BL_IPKG06,BL_IPKG07,BL_IPKG08,BL_IPKG09,BL_IPKG10,BL_IPKG11,BL_IPKG12,BL_IPKG13,BL_IPKG14,BL_IPKG15,BL_IPKG16,BL_IPKG17,BL_IPKG18,BL_IPKG19,BL_IPKG20,BL_IPKG21
  ,BL_IDESC01,BL_IDESC02,BL_IDESC03,BL_IDESC04,BL_IDESC05,BL_IDESC06,BL_IDESC07,BL_IDESC08,BL_IDESC09,BL_IDESC10,BL_IDESC11,BL_IDESC12,BL_IDESC13,BL_IDESC14,BL_IDESC15,BL_IDESC16,BL_IDESC17,BL_IDESC18,BL_IDESC19,BL_IDESC20,BL_IDESC21
  ,BL_FDESC1,BL_FDESC2,BL_FDESC3,BL_FDESC4,BL_FDESC5,BL_FDESC6,BL_FDESC7,BL_FDESC8,BL_FDESC9,BL_FDESC10
  ,BL_FCL1,BL_FCL2,BL_FCL3,BL_FCL4,BL_FCL5,BL_FCL6,BL_FCL7,BL_FCL8,BL_FCL9,BL_FCL10,BL_FCLTOT
  ,BL_FPPD1,BL_FPPD2,BL_FPPD3,BL_FPPD4,BL_FPPD5,BL_FPPD6,BL_FPPD7,BL_FPPD8,BL_FPPD9,BL_FPPD10,BL_FPPDTOT
  ,BL_RECDATE,BL_RECDATE,BL_RECBY,BL_NoDetail
FROM
  #TOBL3
WHERE
  o_Seed NOT IN (SELECT bld_Seed FROM co_BLDetail)
--  NOT EXISTS(SELECT * FROM co_BLDetail WHERE #TOBL3.bl_stat = co_BLDetail.bld_stat AND #TOBL3.bl_sys = co_BLDetail.bld_sys AND #TOBL3.bl_id = co_BLDetail.bld_id)   

SELECT @row = @@ROWCOUNT
PRINT 'INSERT@co_BLDetail:' + CAST(@row AS VARCHAR)

/******************************************
  提单表
  CO_BLInfo <-- TO_BL 
  对应关系
  bli_ID = bl_id
  bli_stat = bl_stat
  bli_sys = bl_sys
******************************************/
PRINT ' '
PRINT '-------------------- CO_BLInfo <-- TO_BL ------------------------'

DELETE FROM co_BLInfo
WHERE bli_Seed NOT IN(SELECT o_Seed FROM #TOBL3)

SELECT @row = @@ROWCOUNT
PRINT 'DELETE@co_BLInfo:' + CAST(@row AS VARCHAR)

UPDATE co_BLInfo
SET
   bli_ID = o.bl_id
  ,bli_STAT = o.bl_stat
  ,bli_SYS = o.bl_sys
  ,bli_Xshipper = o.BL_MSHPR
  ,bli_ShipperCode = o.BL_SHPR
  ,bli_Shipper1 = o.BL_LSHPR1
  ,bli_Shipper2 = o.BL_LSHPR2
  ,bli_Shipper3 = o.BL_LSHPR3
  ,bli_Shipper4 = o.BL_LSHPR4
  ,bli_Shipper5 = o.BL_LSHPR5
  ,bli_XConsignee = o.BL_MCNEE
  ,bli_ConsigneeCode = o.BL_CNEE
  ,bli_Consignee1 = o.BL_LCNEE1
  ,bli_Consignee2 = o.BL_LCNEE2
  ,bli_Consignee3 = o.BL_LCNEE3
  ,bli_Consignee4 = o.BL_LCNEE4
  ,bli_Consignee5 = o.BL_LCNEE5
  ,bli_Consignee6 = o.BL_LCNEE6
  ,bli_XPartyA = o.BL_MPARTY
  ,bli_PartyACode = o.BL_PARTYA
  ,bli_PartyA1 = o.BL_LPARTYA1
  ,bli_PartyA2 = o.BL_LPARTYA2
  ,bli_PartyA3 = o.BL_LPARTYA3
  ,bli_PartyA4 = o.BL_LPARTYA4
  ,bli_PartyA5 = o.BL_LPARTYA5
  ,bli_PartyA6 = o.BL_LPARTYA6
  ,bli_PartyBCode = o.BL_PARTYB
  ,bli_PartyB1 = o.BL_LPARTYB1
  ,bli_PartyB2 = o.BL_LPARTYB2
  ,bli_PartyB3 = o.BL_LPARTYB3
  ,bli_PartyB4 = o.BL_LPARTYB4
  ,bli_PartyB5 = o.BL_LPARTYB5
  ,bli_PartyB6 = o.BL_LPARTYB6
  ,bli_XExpInst = o.BL_MINSTR
  ,bli_ExpInst1 = o.BL_LINST1
  ,bli_ExpInst2 = o.BL_LINST2
  ,bli_ExpInst3 = o.BL_LINST3
  ,bli_ExpInst4 = o.BL_LINST4
  ,bli_Xdischarge = o.BL_MDISCHG
  ,bli_Discharge1 = o.BL_DISCHG1
  ,bli_Discharge2 = o.BL_DISCHG2
  ,bli_Discharge3 = o.BL_DISCHG3
  ,bli_Discharge4 = o.BL_DISCHG4
  ,bli_Discharge5 = o.BL_DISCHG5
  ,bli_Discharge6 = o.BL_DISCHG6
  ,bli_Receipt = o.BL_RECDEST
  ,bli_Carriage = o.BL_CARRIAGE
  ,bli_Vessel = o.BL_VESSEL
  ,bli_Voyage = o.BL_VOYAGE
  ,bli_POL = o.BL_LOADDEST
  ,bli_POD = o.BL_DISDEST
  ,bli_Final = o.BL_FINDEST
  ,bli_InlandRouting = o.BL_ROUTING
  ,bli_ShipperRef = o.BL_SREFNO
  ,bli_BLCount = o.BL_BLCOUNT
  ,bli_Signature1 = o.BL_SIGN1
  ,bli_Signature2 = o.BL_SIGN2
--  ,bli_ByUser = o.
--  ,bli_ByDate = o.
--  ,bli_CrDate = o.
--  ,bli_LstDate = o.
--  ,bli_User = o.
FROM
  #TOBL3 o
WHERE
  bli_Seed = o.o_Seed

SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@co_BLInfo:' + CAST(@row AS VARCHAR)

INSERT INTO CO_BLINFO(
   bli_ID,bli_STAT,bli_SYS,bli_Seed
  ,bli_Xshipper,bli_ShipperCode,bli_Shipper1,bli_Shipper2,bli_Shipper3,bli_Shipper4,bli_Shipper5
  ,bli_XConsignee,bli_ConsigneeCode,bli_Consignee1,bli_Consignee2,bli_Consignee3,bli_Consignee4,bli_Consignee5,bli_Consignee6
  ,bli_XPartyA,bli_PartyACode,bli_PartyA1,bli_PartyA2,bli_PartyA3,bli_PartyA4,bli_PartyA5,bli_PartyA6
  ,bli_PartyBCode,bli_PartyB1,bli_PartyB2,bli_PartyB3,bli_PartyB4,bli_PartyB5,bli_PartyB6
  ,bli_XExpInst,bli_ExpInst1,bli_ExpInst2,bli_ExpInst3,bli_ExpInst4
  ,bli_Xdischarge,bli_Discharge1,bli_Discharge2,bli_Discharge3,bli_Discharge4,bli_Discharge5,bli_Discharge6
  ,bli_Receipt,bli_Carriage,bli_Vessel,bli_Voyage,bli_POL,bli_POD,bli_Final
  ,bli_InlandRouting,bli_ShipperRef,bli_BLCount,bli_Signature1,bli_Signature2
--  ,bli_ByUser,bli_ByDate,bli_CrDate,bli_LstDate,bli_User
  )
SELECT
   BL_ID,BL_STAT,BL_SYS,o_Seed
  ,BL_MSHPR,BL_SHPR,BL_LSHPR1,BL_LSHPR2,BL_LSHPR3,BL_LSHPR4,BL_LSHPR5
  ,BL_MCNEE,BL_CNEE,BL_LCNEE1,BL_LCNEE2,BL_LCNEE3,BL_LCNEE4,BL_LCNEE5,BL_LCNEE6
  ,BL_MPARTY,BL_PARTYA,BL_LPARTYA1,BL_LPARTYA2,BL_LPARTYA3,BL_LPARTYA4,BL_LPARTYA5,BL_LPARTYA6
  ,BL_PARTYB,BL_LPARTYB1,BL_LPARTYB2,BL_LPARTYB3,BL_LPARTYB4,BL_LPARTYB5,BL_LPARTYB6
  ,BL_MINSTR,BL_LINST1,BL_LINST2,BL_LINST3,BL_LINST4
  ,BL_MDISCHG,BL_DISCHG1,BL_DISCHG2,BL_DISCHG3,BL_DISCHG4,BL_DISCHG5,BL_DISCHG6
  ,BL_RECDEST,BL_CARRIAGE,BL_VESSEL,BL_VOYAGE,BL_LOADDEST,BL_DISDEST,BL_FINDEST
  ,BL_ROUTING,BL_SREFNO,BL_BLCOUNT,BL_SIGN1,BL_SIGN2  
FROM #TOBL3
WHERE 
  o_Seed NOT IN (SELECT bli_Seed FROM co_BLInfo)

SELECT @row = @@ROWCOUNT
PRINT 'INSERT@co_BLInfo:' + CAST(@row AS VARCHAR)


/******************************************
  提单表
  CO_Import <-- TO_BL 
  对应关系
  bli_ID = bl_id
  bli_stat = bl_stat
  bli_sys = bl_sys
******************************************/
PRINT ' '
PRINT '-------------------- CO_Import <-- TO_BL ------------------------'

DELETE FROM
  co_Import
WHERE
  imp_Seed NOT IN (SELECT o_Seed FROM #TOBL3)

SELECT @row = @@ROWCOUNT
PRINT 'DELETE@co_Import:' + CAST(@row AS VARCHAR)

UPDATE co_Import
SET
   imp_STAT = o.BL_STAT
  ,imp_SYS = o.BL_SYS
  ,imp_ToMaster = o.BL_TOMBL
  ,imp_ToHouse = o.BL_TOHBL
  ,imp_ToCtnr = o.BL_TOCN
  ,imp_LotNo = o.BL_LOTNO
  ,imp_Surrender = o.BL_SURREND
  ,imp_Warehouse = o.BL_WH
  ,imp_StorageFrom = o.BL_FREEFROM
  ,imp_StorageTo = o.BL_FREETO
  ,imp_FreeDays = CONVERT(INT,ISNULL(o.BL_FREETO,0)) -  CONVERT(INT,ISNULL(o.BL_FREEFROM,0))
--  ,imp_PickupDate = o.
--  ,imp_Clearance = o.
--  ,imp_Remark = o.
  ,imp_CrDate = o.BL_RECDATE
  ,imp_LstDate = o.BL_RECDATE
  ,imp_User = o.BL_RECBY
FROM
  #TOBL3 o 
WHERE
  imp_Seed =o.o_Seed

SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@co_Import:' + CAST(@row AS VARCHAR)

INSERT INTO co_Import(
   imp_STAT,imp_SYS,imp_Seed
  ,imp_ToMaster,imp_ToHouse,imp_ToCtnr,imp_LotNo
  ,imp_Warehouse,imp_Surrender,imp_StorageFrom,imp_StorageTo
  ,imp_FreeDays
--,imp_PickupDate,imp_Clearance,imp_Remark
  ,imp_CrDate,imp_LstDate,imp_User
  )
SELECT
  BL_STAT,BL_SYS,o_Seed
 ,BL_TOMBL,BL_TOHBL,BL_TOCN,BL_LOTNO
 ,BL_WH,BL_SURREND,BL_FREEFROM,BL_FREETO
 ,CONVERT(INT,ISNULL(BL_FREETO,0)) -  CONVERT(INT,ISNULL(BL_FREEFROM,0))
 ,BL_RECDATE,BL_RECDATE,BL_RECBY
FROM
  #TOBL3
WHERE
  o_Seed NOT IN (SELECT imp_Seed FROM co_Import)

SELECT @row = @@ROWCOUNT
PRINT 'INSERT@co_Import:' + CAST(@row AS VARCHAR)
GO
