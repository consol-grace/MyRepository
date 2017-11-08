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
    ��˾��
    cs_Company <-- T_CO 
    ��Ӧ�ֶΣ�
    co_ID = co_ID
    co_Stat = co_STAT
    co_SYS = co_SYS
  ******************************************/
  --��һ��
  print ' '
  print '-------------------- cs_Company <-- t_co ------------------------'
  
  select identity(int, 1, 1) rowid, *
  into #company
  from c_transfer.consol_transfer.dbo.t_co
  where co_code not like '%?%'
  
  select @row = @@rowcount
  print 'ins@#company:' + cast(@row as varchar)
  
  --�ڶ���
        
  select @row = @@rowcount
  print 'delete@cs_Company:' + cast(@row as varchar)
  
  --������
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
  
  --���Ĳ�
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
