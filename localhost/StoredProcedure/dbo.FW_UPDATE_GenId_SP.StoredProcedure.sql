USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_GenId_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_GenId_SP]
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
    �Զ������ᵥ�ű�:CS_IDTable <-- T_GenID
  
    �ֶζ�Ӧ��ϵ:
    CS_IDTable.idt_CODE = T_GenID.GEN_TYPE
    CS_IDTable.idt_STAT = T_GenID.GEN_STAT
  *******************************************/
  --��һ��
  PRINT ' '
  PRINT '-------------------- CS_IDTable <-- T_GenID ------------------------'
  SELECT STATION
    , GEN_STAT COLLATE DATABASE_DEFAULT AS GEN_STAT
    , GEN_TYPE COLLATE DATABASE_DEFAULT AS GEN_CODE  -- TYPE CHANGE TO CODE
    , GEN_SYS COLLATE DATABASE_DEFAULT AS GEN_SYS
    , GEN_DATE, GEN_NO
  INTO #GEN
  FROM c_transfer.consol_transfer.dbo.T_GenID
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#GEN:' + CAST(@row AS VARCHAR)
  
  --�ڶ���
  DELETE FROM CS_IDTable
  WHERE NOT EXISTS (SELECT NULL FROM #GEN 
                    WHERE CS_IDTable.idt_stat = #Gen.GEN_stat
                      AND CS_IDTable.idt_code = #Gen.GEN_code)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DEL@CS_IDTable:' + CAST(@row AS VARCHAR)
  
  --������
  UPDATE cs_IDTable
  SET idt_sys = o.GEN_SYS
    , idt_Date = o.GEN_DATE
    , idt_No = o.GEN_NO
    , idt_LstDate = GETDATE()
    , idt_User = N'admin'
  FROM #GEN o
  WHERE CS_IDTable.idt_stat = o.GEN_stat
    AND CS_IDTable.idt_code = o.GEN_code 
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@CS_IdTable:' + CAST(@row AS VARCHAR)
  
  --���Ĳ�
  INSERT INTO cs_IdTable (idt_stat, idt_code, idt_sys, idt_Date, idt_No, idt_CrDate, idt_User)
  SELECT GEN_STAT, GEN_CODE, GEN_SYS, GEN_DATE, GEN_NO, GETDATE(), N'admin'
  FROM #GEN
  WHERE NOT EXISTS (SELECT * FROM cs_IdTable 
                    WHERE CS_IDTable.idt_stat = #GEN.GEN_stat 
                      AND CS_IDTable.idt_code = #GEN.GEN_code) 

  SELECT @row = @@ROWCOUNT
  PRINT 'INS@CS_IdTable:' + CAST(@row AS VARCHAR)
  
  --���岽
  DROP TABLE #GEN
  
  /******************************************
    �Զ������ᵥ���ͱ�:CS_IDFormat <-- T_GenID
  
    �ֶζ�Ӧ��ϵ:
    CS_IDTable.idt_CODE = T_GenID.GEN_TYPE
    CS_IDTable.idt_STAT = T_GenID.GEN_STAT
  ���⣺SYS �ֶ��� NULL
  *******************************************/
  
  --��һ��
  PRINT ' '
  PRINT '-------------------- CS_IDFormat <-- T_GenID ------------------------'
  SELECT  idt_stat COLLATE DATABASE_DEFAULT AS GEN_STAT
        , idt_sys COLLATE DATABASE_DEFAULT AS GEN_SYS
        , idt_code COLLATE DATABASE_DEFAULT AS GEN_CODE -- TYPE CHANGE TO CODE
  INTO #GENFormat
  FROM cs_IdTable
  GROUP BY idt_stat, idt_sys, idt_code
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#GEN:' + CAST(@row AS VARCHAR)
  
  --�ڶ���
  DELETE FROM CS_IDFormat
  WHERE NOT EXISTS (SELECT * FROM #GENFormat 
                    WHERE CS_IDFormat.idf_stat = #GENFormat.gen_stat
            --          AND CS_IDFormat.idf_sys = #GENFormat.gen_sys
                      AND CS_IDFormat.idf_code = #GENFormat.gen_code)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DEL@CS_IDFormat:' + CAST(@row AS VARCHAR)
  
  --������ û��Update�Ĳ���
  PRINT 'UPDATE@CS_IdFormat: NULL'
  
  --���Ĳ�
  INSERT INTO cs_IdFormat(idf_stat, idf_sys, idf_code, idf_format, idf_CrDate, idf_User)
  SELECT gen_stat, gen_sys, gen_code, 'yymm',  GETDATE(), N'admin'
  FROM #GENFormat
  WHERE NOT EXISTS (SELECT * FROM cs_IdFormat 
                    WHERE CS_IDFormat.idf_stat = #GENFormat.gen_stat
              --    AND CS_IDFormat.idf_sys = #GENFormat.gen_sys
                      AND CS_IDFormat.idf_code = #GENFormat.gen_code)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@CS_IdFormat:' + CAST(@row AS VARCHAR)
  
  --���岽
  DROP TABLE #GENFormat
end
GO
