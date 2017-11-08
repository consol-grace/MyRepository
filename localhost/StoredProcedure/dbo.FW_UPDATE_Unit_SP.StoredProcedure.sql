USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_Unit_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_Unit_SP]
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
	  �Զ������ᵥ�ű�:CS_Unit <-- T_Unit
	
	  �ֶζ�Ӧ��ϵ:
	  CS_Unit.unt_CODE = T_Unit.unt_Code
	  CS_Unit.unt_STAT = T_Unit.unt_STAT
	*******************************************/
	
	--��һ��
	PRINT ' '
	PRINT '-------------------- CS_Unit <-- T_Unit ------------------------'
	SELECT STATION
	  ,UNT_CODE COLLATE DATABASE_DEFAULT AS UNT_CODE
	  ,UNT_STAT COLLATE DATABASE_DEFAULT AS UNT_STAT
	  ,UNT_TYPE,UNT_DESC,UNT_RATE,UNT_SYS,UNT_SHORT,UNT_ID
	INTO #UNIT
	FROM C_TRANSFER.CONSOL_TRANSFER.dbo.T_Unit
	
	SELECT @row = @@ROWCOUNT
	PRINT 'INS@#UNIT:' + CAST(@row AS VARCHAR)
	
	--�ڶ���
	DELETE FROM
	  CS_Unit
	WHERE NOT EXISTS (SELECT NULL FROM #UNIT 
                    WHERE CS_UNIT.unt_code = #UNIT.unt_code
              	      AND CS_UNIT.unt_stat = #UNIT.unt_stat)
	SELECT @row = @@ROWCOUNT
	PRINT 'DEL@CS_UNIT:' + CAST(@row AS VARCHAR)
	
	--������
	UPDATE cs_Unit
	SET unt_Code = o.unt_Code
	  ,unt_Type = o.unt_Type
	  ,unt_Short = o.unt_Short
	  ,unt_Description = o.unt_Desc
	  ,unt_Rate = o.unt_Rate
	  ,unt_LstDate = GETDATE()
	  ,unt_User = N'ADMIN'
	--  ,unt_SYS = o.
	FROM #UNIT o
	WHERE CS_UNIT.unt_code = o.unt_code AND CS_UNIT.unt_stat = o.unt_stat
	
	SELECT @row = @@ROWCOUNT
	PRINT 'UPDATE@CS_UNIT:' + CAST(@row AS VARCHAR)
	
	--���Ĳ�
	INSERT INTO cs_UNIT(unt_STAT,unt_SYS,unt_Code,unt_Type,unt_Short,unt_Description,unt_Rate,unt_CrDate,unt_User,unt_id, unt_active)
	SELECT UNT_STAT,UNT_SYS,UNT_CODE,UNT_TYPE,UNT_SHORT,UNT_DESC,UNT_RATE,GETDATE(),N'ADMIN',unt_id, 
         case when len(isnull(unt_code, '')) < 1 then 0 else 1 end
	FROM #UNIT
	WHERE NOT EXISTS (SELECT * FROM cs_UNIT 
                    WHERE CS_UNIT.unt_code = #UNIT.unt_code AND CS_UNIT.unt_stat = #UNIT.unt_stat) 
	
	SELECT @row = @@ROWCOUNT
	PRINT 'INS@CS_UNIT:' + CAST(@row AS VARCHAR)
	
	--���岽
	DROP TABLE #UNIT
end
GO
