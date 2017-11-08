USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_County_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_County_SP]
AS
/*
���ݵ���˵��
1.���ݴӾ�ϵͳ�е��뵽��ϵͳ�У���ϵͳ������ת

��һ��������ϵͳ�����ݵ��뵽һ����ʱ���У�������һЩ�����ֶΣ�����WHERE��ʹ�õ����ֶΣ�����Ҫ���� COLLATE DATABASE_DEFAULT ����ѡ��
�ڶ����������Ѷ���ȫ����Ψһ�����ı�,�F������CY_ID�]���ô�.
				Ҳ�Ğ�ֻ�ò��ظ��Ĕ����鵼�����
<***********
�ڶ��������±���ɾ���ɱ��Ѿ�ɾ�������ݣ��� NOT EXIST���¾�ϵͳ����ͬ�����ݣ� ��Ӧ������ ���±�.ID = �ɱ�.ID AND���±�.STAT = �ɱ�.STAT��
��������ͨ���ɱ�����±�����ݣ���Ӧ������ ���±�.ID = �ɱ�.ID AND���±�.STAT = �ɱ�.STAT��
���Ĳ�: ���±��в���ɱ����������ݣ����Ҳ���һ��ϵͳ����ΨһID�š�
        1.����һ����ʱ������һ��Identity���ֶ�
        2.��WHILEѭ����һ��һ�в��룬�ڲ���ǰ���ô洢��������һ��ID��
          WHILE ���������� Identity�ֶε�ֵ ���� ��ʱ��ļ�¼��
***********>
���岽��ɾ����ʱ��
*/
begin
/******************************************
  ���Ҵ����
  cs_Country <-- T_CNTY 
  ��Ӧ�ֶΣ�
  cy_Code = cy_Code
******************************************/
  DECLARE  @row INTEGER

  -- < ��һ�� >
  PRINT '-------------------- cs_Country <-- T_CNTY ------------------------'
  SELECT identity(int, 1, 1) ROWID, *
  INTO #CNTY
  FROM C_TRANSFER.CONSOL_TRANSFER.dbo.T_CNTY

  -- < �ڶ��� >
  INSERT INTO cs_Country (cy_Code, cy_Name, cy_Active, cy_CrDate, cy_User)
		select c.CNY_CODE, c.CNY_NAME, case when len(isnull(c.cny_code, '')) < 2 or isnumeric(c.cny_code) = 1 then 0 else 1 end, GETDATE(), max(CNY_USER)
		from (select cny_code, max(len(cny_name)) cny_name
    			from #cnty
    			group by cny_code) x,
    			#cnty c
		where x.cny_code = c.cny_code and x.cny_name = len(c.cny_name)
	    and c.cny_code not in (SELECT cy_code collate database_default FROM cs_Country) 
	    and len(isnull(c.cny_code, '')) > 0
		group by c.CNY_CODE, c.CNY_NAME 
		order by c.cny_code

  SELECT @row = @@ROWCOUNT
  PRINT 'INSERT@CS_Country:' + CAST(@row AS VARCHAR)

  -- < ������ >
  DROP TABLE #CNTY
end
GO
