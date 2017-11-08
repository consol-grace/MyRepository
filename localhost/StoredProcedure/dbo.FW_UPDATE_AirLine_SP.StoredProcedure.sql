USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_AirLine_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_AirLine_SP]
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
begin  
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
  
  SELECT co_code collate database_default co_code, co_stat collate database_default co_stat, 
         CO_ID, CO_SYS, CO_NAME, CO_CNTY, CO_RECDATE, CO_USER, CO_CARNO
  INTO #AIRLINE
  FROM c_transfer.consol_transfer.dbo.T_CO
  WHERE co_coType = 'AIRLINE'
  ORDER BY co_Code
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#AIRLINE:' + CAST(@row AS VARCHAR)
  
  --�ڶ���
  DELETE n FROM cs_AirLine n
  WHERE NOT EXISTS (SELECT null FROM #AIRLINE o
                    WHERE n.al_Code = o.co_Code
                      AND n.al_Stat = o.co_STAT collate database_default)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DELETE@cs_AirLine:' + CAST(@row AS VARCHAR)
  
  --������
  UPDATE n
  SET al_Code = o.CO_CODE
    , al_Name = o.CO_NAME
    , al_country = o.CO_CNTY
    , al_AirNo = o.co_carNo
  --  , al_CallSign = o.
  --  , al_Active = 1
    , al_CrDate = o.CO_RECDATE
    , al_LstDate = o.CO_RECDATE
    , al_User = o.CO_USER
  FROM #AIRLINE o, cs_AirLine n
  WHERE n.al_Stat = o.co_STAT AND n.al_CODE = o.co_CODE
    
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@cs_AirLine:' + CAST(@row AS VARCHAR)
  
  --���Ĳ�
  INSERT INTO cs_AirLine (al_ID, al_STAT, al_SYS, al_Code, al_Name, al_country, al_AirNo, al_Active, al_CrDate, al_User)
  SELECT CO_ID, CO_STAT, CO_SYS, CO_CODE, CO_NAME, CO_CNTY, CO_CARNo, 1, CO_RECDATE, CO_USER
  FROM #AIRLINE o
  WHERE NOT EXISTS (SELECT * FROM cs_AirLine n
                    WHERE n.al_Stat = o.co_STAT AND n.al_CODE = o.co_CODE) 
  SELECT @row = @@ROWCOUNT
  PRINT 'INSERT@cs_AirLine:' + CAST(@row AS VARCHAR)
  
  
  --���岽
  DROP TABLE #AIRLINE
end
GO
