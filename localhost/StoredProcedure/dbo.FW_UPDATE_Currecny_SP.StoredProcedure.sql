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
    ���Ҷ����
    CS_Currency <-- T_CUR
    
    ��Ӧ�ֶΣ�
    n.cur_STAT = T_CUR.cur_STAT
    n.cur_SYS = T_CUR.cur_SYS
    n.cur_CODE = T_CUR.cur_CODE
  ******************************************/
  
  -- <��һ��>
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
  
  -- <�ڶ���>
  DELETE n 
  FROM CS_Currency n left join #cur o 
          on o.cur_STAT = n.cur_STAT AND o.cur_SYS = n.cur_SYS AND o.cur_CODE = n.cur_CODE
  WHERE o.cur_code is null

  SELECT @row = @@ROWCOUNT
  PRINT 'DEL@CS_Currency:' + CAST(@row AS VARCHAR)
  
  --������
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
  
  --���Ĳ�
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
  
  --���岽
  DROP TABLE #CUR
end
GO
