USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_CompanyDetail_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_CompanyDetail_SP]
AS
  /*************************************
    对应关系 STATION = 
    用游标将原数据库中 Contact Pickup 等信息 放入 Remark中
  ***************************************/
begin  
  DECLARE  @row INTEGER

--  drop table #company  
--  drop table #companyDetail

  select identity(int, 1, 1) rowid, *
  into #company
  from c_transfer.consol_transfer.dbo.t_co
  where co_code not like '%?%'

--SAMEBILL = 0 --- HAVE RECORD ON BILL
--SAMEBILL = 1 --- NO RECORD
--HAVEBILL = 1 --- HAVE RECORD ON BILL
--HAVEBILL = 0 --- NO RECORD

  SELECT CD_ID, co_stat cd_stat, co_code cd_code,
          NULLIF(LTRIM(CD1_CONTACT), '') CD1_CONTACT, NULLIF(LTRIM(CD2_CONTACT), '') CD2_CONTACT, 
          NULLIF(LTRIM(CD1_TEL), '')     CD1_TEL,     NULLIF(LTRIM(CD2_TEL), '')     CD2_TEL,
          NULLIF(LTRIM(CD1_FAX), '')     CD1_FAX,     NULLIF(LTRIM(CD2_FAX), '')     CD2_FAX,
          NULLIF(LTRIM(CD1_MOBILE), '')  CD1_MOBILE,  NULLIF(LTRIM(CD2_MOBILE), '')  CD2_MOBILE, 
          NULLIF(LTRIM(CD1_EMAIL), '')   CD1_EMAIL,   NULLIF(LTRIM(CD2_EMAIL), '')   CD2_EMAIL,
          NULLIF(LTRIM(CD3_CONTACT), '') CD3_CONTACT, NULLIF(LTRIM(CD3_ADD1), '')    CD3_ADD1, 
          NULLIF(LTRIM(CD3_ADD2), '')    CD3_ADD2, 
          NULLIF(LTRIM(CD3_TEL), '')     CD3_TEL,     NULLIF(LTRIM(CD3_FAX), '')     CD3_FAX,
          NULLIF(LTRIM(CD4_CONTACT), '') CD4_CONTACT, NULLIF(LTRIM(CD4_ADD1), '')    CD4_ADD1, 
          NULLIF(LTRIM(CD4_ADD2), '')    CD4_ADD2, 
          NULLIF(LTRIM(CD4_TEL), '')     CD4_TEL,     NULLIF(LTRIM(CD4_FAX), '')     CD4_FAX,

          NULLIF(LTRIM(CD5_CONTACT), '') CD5_CONTACT, 
          NULLIF(LTRIM(CD5_ADD1), '')    CD5_ADD1,    NULLIF(LTRIM(CD5_ADD2), '')    CD5_ADD2,
          NULLIF(LTRIM(CD5_ADD3), '')    CD5_ADD3,    NULLIF(LTRIM(CD5_ADD4), '')    CD5_ADD4, 
          NULLIF(LTRIM(CD5_TEL), '')     CD5_TEL,     NULLIF(LTRIM(CD5_FAX), '')     CD5_FAX,
          NULLIF(LTRIM(CD5_MOBILE), '')  CD5_MOBILE,  NULLIF(LTRIM(CD5_EMAIL), '')   CD5_EMAIL,

          NULLIF(LTRIM(CD6_Remark), '')  CD6_Remark 
  into #CompanyDetail
  FROM c_transfer.consol_transfer.dbo.t_coDtl cd, #company co
  where cd_id = co_id and cd.station = co.station
  
  update co SET 
    co_Remark = dbo.FW_UPDATE_CompanyRemark 
                       (cd_id, co_stat, 
                        cd1_Contact, cd2_Contact, cd1_Tel, cd2_Tel, cd1_Fax, cd2_Fax, 
                        cd1_Mobile, cd2_Mobile, cd1_Email, cd2_Email, 
                        cd3_Contact, cd3_add1, cd3_add2, cd3_Tel, cd3_Fax, 
                        cd4_Contact, cd4_add1, cd4_add2, cd4_Tel, cd4_Fax, 
                        cd6_Remark)
  from #CompanyDetail cd, cs_Company co
  where cd.cd_id = co.co_id and co.co_stat = cd.cd_stat collate database_default
    and coalesce(CD1_CONTACT, CD1_TEL, CD1_FAX, CD1_MOBILE, CD1_EMAIL, CD2_CONTACT, CD2_TEL, CD2_FAX, CD2_MOBILE, CD2_EMAIL,
                 CD3_CONTACT, CD3_ADD1, CD3_ADD2, CD3_TEL, CD3_FAX, CD4_CONTACT, CD4_ADD1, CD4_ADD2, CD4_TEL, CD4_FAX, CD6_Remark) is not null

  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@cs_Company Remark:' + CAST(@row AS VARCHAR)

  
--    IF LEN(@Remark) > 12
--      INSERT INTO #DTLRemark(CDID, STATION, Remark) VALUES(@CDID, @STATION, @Remark)

  
  /******************************************
    处理公司表中的层次结构
  ******************************************/
  --第一步，删除BASE层已经被删除，没有对应关系的BILLING
  delete n 
  from cs_Company n
  where n.co_companyKind <> 'BASE' 
  and n.co_ParentID not in (select co_ROWID from cs_company where co_companykind = 'BASE' ) 
  SELECT @row = @@ROWCOUNT
  PRINT 'CLEAR@cs_Company:Dirty Record ' + CAST(@row AS VARCHAR)

  --第二步，创建新的BILLING

  INSERT INTO CS_COMPANY  (CO_ID, CO_STAT, CO_CODE, CO_SYS, co_CompanyKind, CO_ParentID, CO_companyType, co_name, 
                           CO_Address1, CO_Address2, CO_Address3, CO_Address4, CO_Contact, CO_Phone, CO_FAX, CO_Email, 
                           co_user, co_crdate, co_location, co_HaveBill, co_HaveAE, co_HaveAI, co_HaveOE, co_HaveOI, co_active)
  select o.*, 0,0,0,0,0, 1
  from (select CO_ID, CO_STAT, CO_CODE, CO_SYS, CompanyKind co_companykind, CO_ROWID, CO_companyType, co_name, CO_Address1, CO_Address2, CO_Address3, CO_Address4, CO_Contact, CO_Phone, CO_FAX, CO_Email, co_User, co_crdate, co_location
        from (select 'BILL' CompanyKind  
--              union all select 'AE' 
--              union all select 'AI' 
--              union all select 'OE' 
--              union all select 'OI'
             ) ck, 
             cs_company c
        where c.co_companyKind = 'BASE'
       ) o left join cs_company n
  on o.co_stat = n.co_stat and o.co_id = n.co_id and o.co_companyKind = n.co_companyKind
  where n.co_code is null
  SELECT @row = @@ROWCOUNT
  PRINT 'INSERT@cs_Company:BILLING ' + CAST(@row AS VARCHAR)

  --第四步，将T_CODTL表中的BILLING内容（CD5_*）更新到cs_Company

--******************************************************************************************************************
  UPDATE CO
  SET CO_Address1 = CD5_Add1, CO_Address2 = CD5_Add3, CO_Address3 = CD5_Add3, CO_Address4 = CD5_Add4, 
      CO_Phone = CD5_TEL, CO_FAX = CD5_FAX, CO_Email = CD5_EMAIL
  FROM cs_Company co, #CompanyDetail cd
  WHERE CD_ID = CO_ID
    and co.co_stat = cd.cd_stat collate database_default
    AND CO_CompanyKind = 'BILL'
    and coalesce(CD5_Add1, CD5_Add3, CD5_Add3, CD5_Add4, CD5_TEL, CD5_FAX, CD5_EMAIL) is not null
  
  SELECT @row = @@ROWCOUNT
  PRINT 'UPDATE@cs_Company:Address ' + CAST(@row AS VARCHAR)
  
  delete from cs_CompanyRelate
  insert into cs_CompanyRelate
  select co_id, co_parentid, co_companykind, co_stat from cs_company where co_parentid <> 0

  --第五步
  DROP TABLE #COMPANY
  DROP TABLE #COMPANYDetail
end
GO
