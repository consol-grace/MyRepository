USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_AirLineCounty_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_AirLineCounty_SP]
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

/******************************************
  �����
  cs_AirLine <-- T_CO "co_Type = AIRLINE "
  ��Ӧ�ֶΣ�
  ai_ID = co_ID
  ai_Stat = co_STAT
  ai_SYS = co_SYS
******************************************/
--��һ��
PRINT ' '
PRINT '-------------------- CS_AirLine <-- T_CO ------------------------'

SELECT 
  *
INTO #AIRLINE
FROM
  T_CO
WHERE
  co_coType = 'AIRLINE'
ORDER BY co_Code

SELECT @row = @@ROWCOUNT
PRINT 'INS@#AIRLINE:' + CAST(@row AS VARCHAR)

--�ڶ���
DELETE FROM
  cs_AirLine
WHERE
  NOT EXISTS(
    SELECT * FROM #AIRLINE WHERE 
     al_ID = co_ID
     AND al_Stat = co_STAT
     AND al_SYS = co_SYS
  )

SELECT @row = @@ROWCOUNT
PRINT 'DELETE@cs_AirLine:' + CAST(@row AS VARCHAR)

--������
UPDATE
  cs_AirLine
SET
  al_Code = o.CO_CODE
  ,al_Name = o.CO_NAME
  ,al_country = o.CO_CNTY
--  ,al_AirNo = o.
--  ,al_CallSign = o.
  ,al_Active = 1
  ,al_CrDate = o.CO_RECDATE
  ,al_LstDate = o.CO_RECDATE
  ,al_User = o.CO_USER
FROM
  #AIRLINE o
WHERE
  cs_AirLine.al_ID = o.co_ID AND cs_AirLine.al_Stat = o.co_STAT AND cs_AirLine.al_SYS = o.co_SYS
  
SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@cs_AirLine:' + CAST(@row AS VARCHAR)

--���Ĳ�
  INSERT INTO cs_AirLine(
    al_ID,al_STAT,al_SYS,al_Code,al_Name,al_country
--    ,al_AirNo,al_CallSign
    ,al_Active,al_CrDate,al_LstDate,al_User
  )
  SELECT
    CO_ID,CO_STAT,CO_SYS,CO_CODE,CO_NAME,CO_CNTY
    ,1,CO_RECDATE,CO_RECDATE,CO_USER
  FROM #AIRLINE
  WHERE
    NOT EXISTS(
      SELECT * FROM cs_AirLine WHERE 
        cs_AirLine.al_ID = #AIRLINE.co_ID AND cs_AirLine.al_Stat = #AIRLINE.co_STAT AND cs_AirLine.al_SYS = #AIRLINE.co_SYS      
  ) 
SELECT @row = @@ROWCOUNT
PRINT 'INSERT@cs_AirLine:' + CAST(@row AS VARCHAR)


--���岽
DROP TABLE #AIRLINE

/******************************************
  ���Ҵ����
  cs_Country <-- T_CNTY 
  ��Ӧ�ֶΣ�
  cy_ID = cny_ID
  cy_Stat = cny_STAT
******************************************/
--��һ��
PRINT ' '
PRINT '-------------------- cs_Country <-- T_CNTY ------------------------'

SELECT 
  *
INTO #CNTY
FROM
  T_CNTY


SELECT @row = @@ROWCOUNT
PRINT 'INS@#CNTY:' + CAST(@row AS VARCHAR)

--�ڶ���
DELETE FROM
  cs_Country
WHERE
  NOT EXISTS(
    SELECT * FROM #CNTY WHERE 
      cy_ID = cny_ID
      AND cy_Stat = cny_STAT
    )

SELECT @row = @@ROWCOUNT
PRINT 'DELETE@cs_Country:' + CAST(@row AS VARCHAR)

--������
UPDATE
  cs_Country
SET
  cy_Code = o.CNY_CODE
  ,cy_Name = o.CNY_NAME
  ,cy_Active = 1
--  ,cy_CrDate = 
  ,cy_LstDate = GETDATE()
  ,cy_User = o.CNY_USER
FROM
  #CNTY o
WHERE
  cs_Country.cy_ID = o.CNY_ID AND cs_Country.cy_Stat = o.CNY_STAT
  
SELECT @row = @@ROWCOUNT
PRINT 'UPDATE@cs_Country:' + CAST(@row AS VARCHAR)

--���Ĳ�
  INSERT INTO cs_Country(
    cy_ID,cy_STAT,cy_SYS,cy_Code,cy_Name
--    ,al_AirNo,al_CallSign
    ,cy_Active,cy_CrDate,cy_User
  )
  SELECT
    CNY_ID,CNY_STAT,ISNULL(CNY_SYS,''),CNY_CODE,CNY_NAME
    ,1,GETDATE(),CNY_USER
  FROM #CNTY
  WHERE
    NOT EXISTS(
      SELECT * FROM cs_Country WHERE 
        cs_Country.cy_ID = #CNTY.CNY_ID AND cs_Country.cy_Stat = #CNTY.CNY_STAT     
  ) 
SELECT @row = @@ROWCOUNT
PRINT 'INSERT@CS_Country:' + CAST(@row AS VARCHAR)


--���岽
DROP TABLE #CNTY
GO
