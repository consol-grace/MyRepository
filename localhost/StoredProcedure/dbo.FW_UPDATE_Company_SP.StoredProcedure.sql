USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_Company_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_Company_SP]
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
    公司表
    cs_Company <-- T_CO 
    对应字段：
    co_ID = co_ID
    co_Stat = co_STAT
    co_SYS = co_SYS
  ******************************************/
  --第一步
  print ' '
  print '-------------------- cs_Company <-- t_co ------------------------'
  
  select identity(int, 1, 1) rowid, *
  into #company
  from c_transfer.consol_transfer.dbo.t_co
  where co_code not like '%?%'
  
  select @row = @@rowcount
  print 'ins@#company:' + cast(@row as varchar)
  
  --第二步
        
  select @row = @@rowcount
  print 'delete@cs_Company:' + cast(@row as varchar)
  
  --第三步
  UPDATE n
  SET co_CODE = o.CO_CODE
    , co_LANG = o.CO_LANG
  --  , co_CompanyKind = N'BASE'
    , co_CompanyType = o.CO_COTYPE
  --, co_Keyword = o.
    , co_CreditTerm = o.CO_CREDIT
    , co_UseOnBL = 1
    , co_UseOnBill = 1
    , co_UseOnOther = 1
    , co_AGENT = o.CO_AGENT
    , co_Group = o.CO_PARENTID
    , co_Name = o.CO_NAME
    , co_Address1 = o.CO_ADD1
    , co_Address2 = o.CO_ADD2
    , co_Address3 = o.CO_TEL
    , co_Address4 = o.CO_FAX
    , co_Location = o.CO_CITY
  --  , co_Phone = o.CO_TEL
  --  , co_Fax = o.CO_FAX
  --, co_Mobile = o.
    , co_Email = o.CO_EMAIL
  --, co_Sales = o.
  --, co_Remark = o.
  --, co_Active = 1
    , co_CrDate = o.CO_RECDATE
  --  , co_LstDate =o.CO_RECDATE 
    , co_User = o.CO_USER
  FROM #COMPANY o, cs_Company n
  WHERE n.co_ID = o.co_ID
    AND n.co_Stat = o.co_STAT collate database_default
    AND n.co_SYS = o.co_SYS collate database_default
    AND n.co_CompanyKind = N'BASE'
    
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@cs_Company:' + CAST(@row AS VARCHAR)
  
  --第四步
  insert into cs_Company (
    co_id, co_stat, co_code, co_lang, co_sys, co_companykind, co_companytype, co_creditterm,
    co_useonBL, co_useOnOther, co_useOnBill, co_agent, co_group, co_name, co_address1, co_address2, co_address3, co_address4,
    co_location, co_email, co_active, co_crdate, co_user, co_parentid,
    co_HaveBill, co_HaveAE, co_HaveAI, co_HaveOE, co_HaveOI
    )
  select  co_id, co_stat, co_code, co_lang, case when len(co_sys) = 0 then null else co_sys end, N'BASE', co_cotype, co_credit, 
          1, 1, 1, co_agent, co_parentid, co_name, co_add1, co_add2, co_tel, co_fax,
          co_city, co_email, 1, co_recdate, co_user, null,
--          case when isnull(co_samebill, 1) = 0 then 1 else 0 end, 
          1, 0, 0, 0, 0
  from #company o
  where not exists (select * from cs_Company n
                    where n.co_id = o.co_id 
                      and n.co_stat = o.co_stat collate database_default
                      and n.co_sys = o.co_sys collate database_default 
                      and n.co_companykind = N'BASE' ) 
  
  select @row = @@rowcount
  print 'insert@cs_Company:' + cast(@row as varchar)
end
GO
