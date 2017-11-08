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
	数据导入说明
	1.数据从旧系统中导入到新系统中，旧系统正常运转
	
	第一步：将旧系统的数据导入到一个临时表中，并增加一些辅助字段，对于WHERE中使用到得字段，还需要增加 COLLATE DATABASE_DEFAULT 排序选项
	第二步：在新表中删除旧表已经删除的数据，用 NOT EXIST（新旧系统都相同的数据） 对应条件是 【新表.ID = 旧表.ID AND　新表.STAT = 旧表.STAT】
	第三步：通过旧表更新新表的数据，对应条件是 【新表.ID = 旧表.ID AND　新表.STAT = 旧表.STAT】
	第四步: 在新表中插入旧表新增的数据，并且插入一个系统级的唯一ID号。
	        1.建立一个临时表，增加一个Identity的字段
	        2.用WHILE循环，一行一行插入，在插入前先用存储过程生产一个ID号
	          WHILE 结束条件是 Identity字段的值 等于 临时表的记录数
	
	第五步：删除临时表
	*/
begin	
	DECLARE  @row INTEGER
	
	/******************************************
	  自动生产提单号表:CS_Unit <-- T_Unit
	
	  字段对应关系:
	  CS_Unit.unt_CODE = T_Unit.unt_Code
	  CS_Unit.unt_STAT = T_Unit.unt_STAT
	*******************************************/
	
	--第一步
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
	
	--第二步
	DELETE FROM
	  CS_Unit
	WHERE NOT EXISTS (SELECT NULL FROM #UNIT 
                    WHERE CS_UNIT.unt_code = #UNIT.unt_code
              	      AND CS_UNIT.unt_stat = #UNIT.unt_stat)
	SELECT @row = @@ROWCOUNT
	PRINT 'DEL@CS_UNIT:' + CAST(@row AS VARCHAR)
	
	--第三步
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
	
	--第四步
	INSERT INTO cs_UNIT(unt_STAT,unt_SYS,unt_Code,unt_Type,unt_Short,unt_Description,unt_Rate,unt_CrDate,unt_User,unt_id, unt_active)
	SELECT UNT_STAT,UNT_SYS,UNT_CODE,UNT_TYPE,UNT_SHORT,UNT_DESC,UNT_RATE,GETDATE(),N'ADMIN',unt_id, 
         case when len(isnull(unt_code, '')) < 1 then 0 else 1 end
	FROM #UNIT
	WHERE NOT EXISTS (SELECT * FROM cs_UNIT 
                    WHERE CS_UNIT.unt_code = #UNIT.unt_code AND CS_UNIT.unt_stat = #UNIT.unt_stat) 
	
	SELECT @row = @@ROWCOUNT
	PRINT 'INS@CS_UNIT:' + CAST(@row AS VARCHAR)
	
	--第五步
	DROP TABLE #UNIT
end
GO
