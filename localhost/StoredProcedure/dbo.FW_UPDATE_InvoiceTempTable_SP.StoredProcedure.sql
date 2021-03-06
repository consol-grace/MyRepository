USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_InvoiceTempTable_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_InvoiceTempTable_SP]
as
begin
  DECLARE @row INTEGER

  if exists ( select * from sysobjects where name = 'T_INV')
    DROP TABLE T_INV
  if exists ( select * from sysobjects where name = 'T_INVDTL')
    DROP TABLE T_INVDTL

  SELECT ISNULL(PATINDEX('%/%', inv_voyage), 0) cstrIndex
    , STATION COLLATE DATABASE_DEFAULT AS STATION
    , isnull(INV_STAT, '') inv_stat, INV_SYS
    , INV_ID, INV_SHPTYPE, INV_SHPID, INV_TYPE, INV_PAYMENT, INV_LOTNO, INV_REFNO, INV_STATE, INV_RECALL, INV_MAWB, INV_HAWB, INV_INVNO, INV_FDATE, INV_DATE
    , INV_REPUSR, INV_DEPART, INV_DEST, isnull(INV_COMPANY, '') inv_company, coalesce(INV_CONAME, '')  inv_coname, INV_ADD1, INV_ADD2, INV_ADD3, INV_ADD4, INV_TEL, INV_FAX, INV_CONTACT, INV_SHIPPER, INV_CONSIGNEE
    , INV_CARRIER, INV_VOYAGE, INV_NO, INV_GWT, INV_VWT, INV_CWT, INV_WTUNIT, INV_MEMO, INV_CARTON, INV_CTNDESC, INV_CUR, INV_TAX, INV_TAXTOT, INV_NETTOT
    , INV_ACTTOT, INV_TOTAL, INV_USER, INV_OWN, INV_SHPR, INV_CNEE, INV_FL
  INTO T_INV
  FROM c_transfer.consol_transfer.dbo.T_INV order by inv_id desc
  
  --SELECT * FROM T_INV
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@T_INV:' + CAST(@row AS VARCHAR)

  SELECT IND_ID, IND_CODE, IND_ITEM, IND_DESC, IND_OCUR, IND_CUR, IND_AMT, IND_MIN, IND_RATE, IND_TAX, IND_TAXAMT, IND_NET, IND_ACT, IND_EX, IND_QTY, IND_UNIT, IND_PERCENT
    , OID.STATION, isnull(inv_Stat, '') inv_stat, inv_SYS, inv_Date, inv_User
  INTO T_INVDTL
  FROM T_INV OI, c_transfer.consol_transfer.dbo.T_INVDTL OID
  WHERE OI.STATION = OID.STATION collate database_default AND OI.INV_ID = OID.IND_CODE

  SELECT @row = @@ROWCOUNT
  PRINT 'INS@T_INVDTL:' + CAST(@row AS VARCHAR)
end
GO
