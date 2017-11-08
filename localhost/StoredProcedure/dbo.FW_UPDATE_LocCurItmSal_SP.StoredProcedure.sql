USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_LocCurItmSal_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_LocCurItmSal_SP]
AS

/*
���ݵ���˵��
1.���ݴӾ�ϵͳ�е��뵽��ϵͳ�У���ϵͳ������ת

��һ��������ϵͳ�����ݵ��뵽һ����ʱ���У�������һЩ�����ֶΣ�����WHERE��ʹ�õ����ֶΣ�����Ҫ���� COLLATE DATABASE_DEFAULT ����ѡ��
�ڶ��������±���ɾ���ɱ��Ѿ�ɾ�������ݣ��� NOT EXIST���¾�ϵͳ����ͬ�����ݣ� ��Ӧ������ ���±�.ID = �ɱ�.ID AND���±�.STAT = �ɱ�.STAT��
��������ͨ���ɱ�����±�����ݣ���Ӧ������ ���±�.ID = �ɱ�.ID AND���±�.STAT = �ɱ�.STAT��
���Ĳ�: ���±��в���ɱ����������ݣ����Ҳ���һ��ϵͳ����ΨһID�š�
        1.����һ����ʱ������һ��Identity���ֶ�
        2.��WHILEѭ����һ��һ�в��룬�ڲ���ǰ���ô洢��������һ��ID��
          WHILE ���������� Identity�ֶε�ֵ ���� ��ʱ��ļ�¼��

���岽��ɾ����ʱ��
*/

DECLARE  @row INTEGER

/****************************
  CS_Currency <-- T_CUR
  ���Ҷ����
*****************************/

--��һ��
PRINT ' '
PRINT '-------------------- CS_Currency <-- T_CUR ------------------------'
SELECT 
  ROWID
  ,STATION COLLATE DATABASE_DEFAULT AS STATION
  ,CUR_STAT COLLATE DATABASE_DEFAULT AS CUR_STAT
  ,CUR_SYS COLLATE DATABASE_DEFAULT AS CUR_SYS 
  ,CUR_CODE COLLATE DATABASE_DEFAULT AS CUR_CODE 
  ,CUR_DESC,CUR_CNTY,CUR_RATE,CUR_USER,CUR_ID,CUR_NATIVE
INTO #CUR
FROM
  T_CUR

SELECT @row = @@ROWCOUNT
PRINT 'INS@#CUR:' + CAST(@row AS VARCHAR)

--�ڶ���
DELETE FROM
  CS_Currency
WHERE
  NOT EXISTS(
    SELECT NULL FROM #CUR WHERE 
      #CUR.cur_STAT = cs_Currency.cur_STAT AND
      #CUR.cur_SYS = cs_Currency.cur_SYS AND
      #CUR.cur_CODE = cs_Currency.cur_CODE
  )

SELECT @row = @@ROWCOUNT
PRINT 'DEL@CS_Currency:' + CAST(@row AS VARCHAR)

--������
UPDATE
  cs_Currency
SET
   cur_ID = o.CUR_ID
  ,cur_Description = o.CUR_DESC
  ,cur_country = o.CUR_CNTY
  ,cur_Rate = o.CUR_RATE
  ,cur_Native = o.CUR_NATIVE
  ,cur_LstDate = GETDATE()
  ,cur_User = o.CUR_USER
--  ,cur_Buy = o.
--  ,cur_Sell = o.
--  ,cur_BuildIn = o.
--  ,cur_isLocal = o.
--  ,cur_CrDate = o.
FROM
  #CUR o
WHERE
  o.cur_STAT = cs_Currency.cur_STAT AND o.cur_SYS = cs_Currency.cur_SYS AND o.cur_Code = cs_Currency.cur_Code 

SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@CS_Currency:' + CAST(@row AS VARCHAR)

--���Ĳ�
  INSERT INTO cs_Currency(
    cur_ID,cur_SYS,cur_STAT,cur_Code,cur_Description,cur_country,cur_Rate,cur_CrDate,cur_Native,cur_User
    --,cur_Buy,cur_Sell,cur_BuildIn,cur_isLocal,cur_LstDate
  )
  SELECT
    CUR_ID,CUR_SYS,CUR_STAT,CUR_CODE,CUR_DESC,CUR_CNTY,CUR_RATE,GETDATE(),CUR_NATIVE,CUR_USER
  FROM #CUR
  WHERE
    NOT EXISTS(
      SELECT * FROM cs_Currency WHERE #CUR.cur_STAT = cs_Currency.cur_STAT AND #CUR.cur_SYS = cs_Currency.cur_SYS AND #CUR.cur_CODE = cs_Currency.cur_CODE
  ) 
SELECT @row = @@ROWCOUNT
PRINT 'INS@CS_Currency:' + CAST(@row AS VARCHAR)

--���岽
DROP TABLE #CUR

/****************************
  CS_Item <-- T_ITEM
  ��Ŀ�����
*****************************/
PRINT ' '
PRINT '-------------------- CS_Item <-- T_ITEM ------------------------'

--��һ��
SELECT 
  ROWID,STATION
  ,ITM_STAT COLLATE DATABASE_DEFAULT AS ITM_STAT
  ,ITM_SYS COLLATE DATABASE_DEFAULT AS ITM_SYS
  ,ITM_CODE COLLATE DATABASE_DEFAULT AS ITM_CODE
  ,ITM_SHORT,ITM_DESC,ITM_FCUR,ITM_FUNIT,ITM_FMIN,ITM_FRATE,ITM_FAMT,ITM_FRND,ITM_FMRKUP,ITM_LUNIT,ITM_LMIN,ITM_LRATE,ITM_LAMT,ITM_LRND,ITM_LMRKUP,ITM_USER,ITM_LMRKDOWN,ITM_FMRKDOWN,ITM_GUID,ITM_ID
INTO #ITM
FROM
  T_ITEM

SELECT @row = @@ROWCOUNT
PRINT 'INS@#ITM:' + CAST(@row AS VARCHAR)

--�ڶ���
DELETE FROM
  cs_Item
WHERE
  NOT EXISTS(
    SELECT NULL FROM #ITM WHERE 
      #ITM.itm_STAT = cs_Item.itm_STAT
      AND #ITM.itm_SYS = cs_Item.itm_SYS 
      AND #ITM.itm_Code = cs_Item.itm_Code
  )

SELECT @row = @@ROWCOUNT
PRINT 'DEL@CS_ITEM:' + CAST(@row AS VARCHAR)

--������
UPDATE
  cs_Item
SET
   itm_ID = o.ITM_ID
  ,itm_Short = o.ITM_SHORT
  ,itm_Description = o.ITM_DESC
  ,itm_FCurrency = o.ITM_FCUR
  ,itm_FUnit = o.ITM_FUNIT
  ,itm_FMin = o.ITM_FMIN
  ,itm_FRate = o.ITM_FRATE
  ,itm_FAmount = o.ITM_FAMT
  ,itm_FRound = o.ITM_FRND
  ,itm_FMarkUp = o.ITM_FMRKUP
  ,itm_FMarkDown = o.ITM_FMRKDOWN
  ,itm_LUnit = o.ITM_LUNIT
  ,itm_LMin = o.ITM_LMIN
  ,itm_LRate = o.ITM_LRATE
  ,itm_LAmount = o.ITM_LAMT
  ,itm_LRoundUp = o.ITM_LRND
  ,itm_LMarkUp = o.ITM_LMRKUP
  ,itm_LMarkDown = o.ITM_LMRKDOWN
  ,itm_LstDate = GETDATE()
  ,itm_User = o.ITM_USER
FROM
  #ITM o
WHERE
      o.itm_STAT = cs_Item.itm_STAT 
  AND o.itm_SYS = cs_Item.itm_SYS
  AND o.itm_Code = cs_Item.itm_Code

SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@CS_Currency:' + CAST(@row AS VARCHAR)

--���Ĳ�
INSERT INTO cs_Item(
  itm_STAT,itm_SYS
  ,itm_Code,itm_Short,itm_Description
  ,itm_FCurrency,itm_FUnit,itm_FMin,itm_FRate,itm_FAmount,itm_FRound,itm_FMarkUp,itm_FMarkDown
  ,itm_LUnit,itm_LMin,itm_LRate,itm_LAmount,itm_LRoundUp,itm_LMarkUp,itm_LMarkDown
  ,itm_CrDate,itm_User
--,itm_CalcQty
  )
SELECT
  ITM_STAT,ITM_SYS
  ,ITM_CODE,ITM_SHORT,ITM_DESC
  ,ITM_FCUR,ITM_FUNIT,ITM_FMIN,ITM_FRATE,ITM_FAMT,ITM_FRND,ITM_FMRKUP,ITM_FMRKDOWN
  ,ITM_LUNIT,ITM_LMIN,ITM_LRATE,ITM_LAMT,ITM_LRND,ITM_LMRKUP,ITM_LMRKDOWN
  ,GETDATE(),ITM_USER
--,ITM_ID
FROM #ITM
WHERE
  NOT EXISTS(
    SELECT * FROM cs_Item WHERE 
          #ITM.itm_STAT = cs_Item.itm_STAT 
      AND #ITM.itm_SYS = cs_Item.itm_SYS 
      AND #ITM.itm_CODE = cs_Item.itm_CODE
) 
SELECT @row = @@ROWCOUNT
PRINT 'INS@CS_ITEM:' + CAST(@row AS VARCHAR)

--���Ĳ�
DROP TABLE #ITM

/****************************
  CS_LOCATION <-- T_LOC
  ���Ҷ����
*****************************/

--��һ��
PRINT ' '
PRINT '-------------------- CS_LOCATION <-- T_LOC ------------------------'
SELECT 
  ROWID,STATION
  ,LOC_STAT COLLATE DATABASE_DEFAULT AS LOC_STAT
  ,LOC_SYS COLLATE DATABASE_DEFAULT AS LOC_SYS
  ,LOC_CODE COLLATE DATABASE_DEFAULT AS LOC_CODE
  ,LOC_NAME,LOC_CNTY,LOC_CUR,LOC_IATA,LOC_USER,LOC_ID
INTO #LOC
FROM
  T_LOC

SELECT @row = @@ROWCOUNT
PRINT 'INS@#LOC:' + CAST(@row AS VARCHAR)

--�ڶ���
DELETE FROM
  CS_Location
WHERE
  NOT EXISTS(
    SELECT NULL FROM #LOC WHERE 
      #LOC.loc_STAT = cs_Location.loc_STAT AND
      #LOC.loc_SYS = cs_Location.loc_SYS AND
      #LOC.loc_CODE = cs_Location.loc_CODE
  )

SELECT @row = @@ROWCOUNT
PRINT 'DEL@CS_Location:' + CAST(@row AS VARCHAR)

--������
UPDATE
  cs_Location
SET
   loc_id = o.LOC_ID
  ,loc_Name = o.LOC_NAME
  ,loc_Country = o.LOC_CNTY
  ,loc_Currency = o.LOC_CUR
  ,loc_IATA = o.LOC_IATA
  ,loc_LstDate = GETDATE()
  ,loc_User = o.LOC_USER
FROM
  #LOC o
WHERE
  o.LOC_STAT = cs_Location.LOC_STAT AND o.LOC_SYS = cs_Location.LOC_SYS AND o.loc_Code = cs_Location.loc_Code 

SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@CS_Location:' + CAST(@row AS VARCHAR)

--���Ĳ�
  INSERT INTO cs_Location(
    loc_ID,loc_STAT,loc_SYS,loc_Code,loc_Name,loc_Country,loc_Currency,loc_IATA,loc_CrDate,loc_User
  )
  SELECT
    LOC_ID,LOC_STAT,LOC_SYS,LOC_CODE,LOC_NAME,LOC_CNTY,LOC_CUR,LOC_IATA,GETDATE(),LOC_USER
  FROM #LOC
  WHERE
    NOT EXISTS(
      SELECT * FROM cs_Location
      WHERE #loc.loc_stat = cs_Location.loc_stat AND #LOC.loc_sys = cs_Location.loc_sys AND #LOC.loc_code = cs_Location.loc_code
  ) 

SELECT @row = @@ROWCOUNT
PRINT 'INS@CS_Location:' + CAST(@row AS VARCHAR)

--���岽
DROP TABLE #LOC

/****************************
  CS_SALES <-- G_SALES
  ������Ա�����
*****************************/

--��һ��
PRINT ' '
PRINT '-------------------- CS_SALES <-- G_SALES ------------------------'
SELECT 
  ROWID,STATION
  ,SAL_CODE COLLATE DATABASE_DEFAULT AS SAL_CODE
  ,SAL_STAT COLLATE DATABASE_DEFAULT AS SAL_STAT
  ,SAL_SYS COLLATE DATABASE_DEFAULT AS SAL_SYS
  ,SAL_DESC COLLATE DATABASE_DEFAULT AS SAL_DESC
INTO #SALES
FROM
  G_SALES

SELECT @row = @@ROWCOUNT
PRINT 'INS@#SALES:' + CAST(@row AS VARCHAR)

--�ڶ���
DELETE FROM
  CS_SALES
WHERE
  NOT EXISTS(
    SELECT NULL FROM #SALES WHERE 
      #SALES.sal_STAT = cs_Sales.sal_STAT
      AND #SALES.sal_CODE = cs_Sales.sal_CODE
  )

SELECT @row = @@ROWCOUNT
PRINT 'DEL@CS_Sales:' + CAST(@row AS VARCHAR)

--������
UPDATE
  cs_Sales
SET
  sal_Description = o.SAL_DESC
  ,sal_LstDate = GETDATE()
FROM
  #SALES o
WHERE
  o.SAL_STAT = cs_Sales.SAL_STAT AND o.sal_Code = cs_Sales.sal_Code 

SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@CS_Sales:' + CAST(@row AS VARCHAR)

--���Ĳ�
  INSERT INTO cs_Sales(
    sal_Code,sal_Description,sal_STAT,sal_SYS,sal_User,sal_CrDate
  )
  SELECT
    SAL_CODE,SAL_DESC,SAL_STAT,SAL_SYS,N'Admin',GETDATE()
  FROM #SALES
  WHERE
    NOT EXISTS(
      SELECT * FROM cs_Sales
      WHERE #Sales.sal_stat = cs_Sales.sal_stat AND #Sales.sal_code = cs_Sales.sal_code
  ) 

SELECT @row = @@ROWCOUNT
PRINT 'INS@CS_Sales:' + CAST(@row AS VARCHAR)

--���岽
DROP TABLE #Sales
GO
