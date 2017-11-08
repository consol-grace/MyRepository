USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_Sales_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_Sales_SP]
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
    ������Ա�����:CS_SALES <-- G_SALES
  
    �ֶζ�Ӧ��ϵ:
    n.sal_STAT = G_SALES.sal_STAT
    n.sal_CODE = G_SALES.sal_CODE
  *******************************************/
  
  --��һ��
  print ' '
  print '-------------------- cs_sales <-- g_sales ------------------------'

  select station
    , sal_code collate database_default as sal_code
    , sal_stat collate database_default as sal_stat
    , sal_sys collate database_default as sal_sys
    , sal_desc collate database_default as sal_desc
  into #sales
  from c_transfer.consol_transfer.dbo.g_sales
  
  select @row = @@rowcount
  print 'ins@#sales:' + cast(@row as varchar)
  
  --�ڶ���
  delete n 
  from cs_sales n
  where not exists (select null from #sales o
                    where o.sal_stat = n.sal_stat
                      and o.sal_code = n.sal_code)
  
  select @row = @@rowcount
  print 'del@cs_sales:' + cast(@row as varchar)
  
  --������
  UPDATE n
  SET sal_Description = o.SAL_DESC
    , sal_LstDate = GETDATE()
  FROM #SALES o, cs_Sales n
  WHERE o.SAL_STAT = n.SAL_STAT AND o.sal_Code = n.sal_Code 
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@CS_Sales:' + CAST(@row AS VARCHAR)
  
  --���Ĳ�
    INSERT INTO cs_Sales
      (sal_Code, sal_Description, sal_STAT, sal_SYS, sal_User, sal_CrDate, Sal_id, sal_active, sal_USGROUP)
    SELECT SAL_CODE, SAL_DESC, SAL_STAT, SAL_SYS, N'ADMIN', GETDATE(), 0,
           case when len(isnull(sal_Code, '')) < 1 or isnumeric(sal_Code) = 1 then 0 else 1 end,
           case when sal_code like ('CON/%') or sal_code like ('USG/%') or sal_desc like ('CON/%') or sal_desc like ('USG/%') then 1 else 0 end
    FROM #SALES o
    WHERE NOT EXISTS (SELECT * FROM cs_Sales n
                      WHERE o.sal_stat = n.sal_stat 
                        AND o.sal_code = n.sal_code
                     ) 
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@CS_Sales:' + CAST(@row AS VARCHAR)
  
  --���岽
  DROP TABLE #Sales
end
GO
