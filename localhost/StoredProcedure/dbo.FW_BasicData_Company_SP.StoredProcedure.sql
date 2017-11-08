USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_BasicData_Company_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:  Hcy       QQ: 543661280     
-- ALTER  date: 2011-08-27
-- Description: 基本资料信息Company 存储过程
-- =============================================
CREATE procedure [dbo].[FW_BasicData_Company_SP](
    @Option nvarchar(50)='', -- 选项
	@ROWID int=0,
	@STAT nvarchar(12) ='',
	@SYS nvarchar(2)='',
	@Code nvarchar(12)='',
	@Active int= 0,
	@CrDate nvarchar(30)= '',
	@LstDate nvarchar(30)= '',
	@User nvarchar(12)= '',
	@ParentID int=0,
	@LANG int=0,
	@HaveBill int =0,
	@HaveAE int=0,
	@HaveAI int =0,
	@HaveOE int =0,
	@HaveOI int =0,
	@CompanyKind nvarchar(8)='',
	@CompanyType nvarchar(8)='',
	@Keyword nvarchar(100)='',
	@CreditTerm nvarchar(100)='',
	@UseOnBL int=0,
	@UseOnBill int =0,
	@UseOnOther int =0,
	@AGENT nvarchar(12)='',
	@Group int =0,
	@Name nvarchar(43)='',
	@Address1 nvarchar(43)='',
	@Address2 nvarchar(43)='',
	@Address3 nvarchar(43)='',
	@Address4 nvarchar(43)='',
	@Location nvarchar(3)='',
	@Contact nvarchar(43)='',
	@Phone  nvarchar(43)='',
	@Fax  nvarchar(43)='',
	@Mobile nvarchar(43)='',
	@Email nvarchar(60)='',
	@Sales nvarchar(12)='',
	@Remark nvarchar(1024)=''
) as
begin
	if @Option='List'
	begin
	    select ROWID,'<a href=detail.aspx?rowid='+cast(ROWID as varchar)+'>'+Code+'</a>' as Code,Name,[Type],Remark
	    from (
		select   co_ROWID as ROWID, co_CODE  as Code,co_Name as Name,co_CompanyType as [Type],co_Remark as Remark  from cs_Company
		where co_companykind = 'BASE' and  co_CODE like @Code+'%'  and co_Name  like @Name+'%' and co_STAT=@STAT and co_SYS=@SYS
		--order by co_CrDate desc
		)a
	end
	
	if @Option='Update'
	begin
	    if(isnull(@ROWID,'')='')
	    begin
	        if(@ParentID='0')
	        begin
		     insert into cs_Company(co_Code,co_Active,co_CrDate,co_User,co_STAT,co_SYS,co_ParentID,co_LANG,co_HaveBill,co_HaveAE,co_HaveAI,co_HaveOE
		     ,co_HaveOI,co_CompanyKind,co_CompanyType,co_Keyword,co_CreditTerm,co_UseOnBL,co_UseOnBill,co_UseOnOther,co_AGENT,co_Group,co_Name,co_Address1,
		     co_Address2,co_Address3,co_Address4,co_Location,co_Contact,co_Phone,co_Fax,co_Mobile,co_Email,co_Sales,co_Remark)
		     values(@Code,@Active,@CrDate,@User,@STAT,@SYS,@ParentID,@LANG,@HaveBill,@HaveAE,@HaveAI,@HaveOE,@HaveOI,@CompanyKind,@CompanyType,@Keyword,@CreditTerm,
		     @UseOnBL,@UseOnBill,@UseOnOther,@AGENT,@Group,@Name,@Address1,@Address2,@Address3,@Address4,@Location,@Contact,@Phone,@Fax,@Mobile,@Email,@Sales,@Remark)
		     select @@identity as ROWID
		    end
		    else
		    begin
		      insert into cs_Company(co_Code,co_Active,co_CrDate,co_User,co_STAT,co_SYS,co_ParentID,co_LANG,co_HaveBill,co_HaveAE,co_HaveAI,co_HaveOE
		     ,co_HaveOI,co_CompanyKind,co_CompanyType,co_Keyword,co_CreditTerm,co_UseOnBL,co_UseOnBill,co_UseOnOther,co_AGENT,co_Group,co_Name,co_Address1,
		     co_Address2,co_Address3,co_Address4,co_Location,co_Contact,co_Phone,co_Fax,co_Mobile,co_Email,co_Sales,co_Remark)
		     values(@Code,@Active,@CrDate,@User,@STAT,@SYS,@ParentID,@LANG,@HaveBill,@HaveAE,@HaveAI,@HaveOE,@HaveOI,@CompanyKind,@CompanyType,@Keyword,@CreditTerm,
		     @UseOnBL,@UseOnBill,@UseOnOther,@AGENT,@Group,@Name,@Address1,@Address2,@Address3,@Address4,@Location,@Contact,@Phone,@Fax,@Mobile,@Email,@Sales,@Remark)
		    end
	    end
		else
		begin
		   if(@ParentID='0')
		   begin
		   update cs_Company set co_Code=@COde,co_Active=@Active,co_User=@User,
		   co_LANG=@LANG,co_HaveBill=@HaveBill,co_HaveAE=@HaveAE,co_HaveAI=@HaveAI,co_HaveOE=@HaveOE,co_HaveOI=@HaveOI,
		   co_CompanyType=@CompanyType,co_Keyword=@Keyword,co_CreditTerm=@CreditTerm,
		   co_UseOnBL=@UseOnBL,co_UseOnBill=@UseOnBill,co_UseOnOther=@UseOnOther,co_AGENT=@AGENT,co_Group=@Group,co_Name=@Name,co_Address1=@Address1,
		   co_Address2=@Address2,co_Address3=@Address3,co_Address4=@Address4,co_Location=@Location,co_Contact=@Contact,co_Phone=@Phone,co_Fax=@Fax,
		   co_Mobile=@Mobile,co_Email=@Email,co_Sales=@Sales,co_Remark=@Remark where co_ROWID=@ROWID
		   end
		   else
		   begin
		    if(exists(select 1 from cs_Company where co_ParentID=@ROWID and co_CompanyKind=@CompanyKind))
		    begin
		    update cs_Company set co_Code=@COde,co_Active=@Active,co_User=@User,
		   co_LANG=@LANG,co_HaveBill=@HaveBill,co_HaveAE=@HaveAE,co_HaveAI=@HaveAI,co_HaveOE=@HaveOE,co_HaveOI=@HaveOI,
		   co_CompanyType=@CompanyType,co_Keyword=@Keyword,co_CreditTerm=@CreditTerm,
		   co_UseOnBL=@UseOnBL,co_UseOnBill=@UseOnBill,co_UseOnOther=@UseOnOther,co_AGENT=@AGENT,co_Group=@Group,co_Name=@Name,co_Address1=@Address1,
		   co_Address2=@Address2,co_Address3=@Address3,co_Address4=@Address4,co_Location=@Location,co_Contact=@Contact,co_Phone=@Phone,co_Fax=@Fax,
		   co_Mobile=@Mobile,co_Email=@Email,co_Sales=@Sales,co_Remark=@Remark where co_ParentID=@ROWID and co_CompanyKind=@CompanyKind
		   end
		   else
		   begin
		     insert into cs_Company(co_Code,co_Active,co_CrDate,co_User,co_STAT,co_SYS,co_ParentID,co_LANG,co_HaveBill,co_HaveAE,co_HaveAI,co_HaveOE
		     ,co_HaveOI,co_CompanyKind,co_CompanyType,co_Keyword,co_CreditTerm,co_UseOnBL,co_UseOnBill,co_UseOnOther,co_AGENT,co_Group,co_Name,co_Address1,
		     co_Address2,co_Address3,co_Address4,co_Location,co_Contact,co_Phone,co_Fax,co_Mobile,co_Email,co_Sales,co_Remark)
		     values(@Code,@Active,@CrDate,@User,@STAT,@SYS,@ParentID,@LANG,@HaveBill,@HaveAE,@HaveAI,@HaveOE,@HaveOI,@CompanyKind,@CompanyType,@Keyword,@CreditTerm,
		     @UseOnBL,@UseOnBill,@UseOnOther,@AGENT,@Group,@Name,@Address1,@Address2,@Address3,@Address4,@Location,@Contact,@Phone,@Fax,@Mobile,@Email,@Sales,@Remark)
		   end
		   end
		end
	end
	
	if @Option ='Detail' 
	begin
	   if(@Group='0')
	   begin
		select 
		co_Code,co_Address1,co_Name,co_Contact,co_Phone,co_Fax,co_Mobile,co_Email,co_CompanyKind,co_CompanyType,
		co_ParentID,co_LANG,co_HaveBill,co_HaveAE,co_HaveAI,co_HaveOE,co_HaveOI,co_CompanyKind,co_CompanyType,co_Keyword,co_CreditTerm,co_UseOnBL,co_UseOnBill,co_UseOnOther,co_AGENT,co_Group,co_Name,
		co_Address2,co_Address3,co_Address4,co_Location,co_Contact,co_Phone,co_Fax,co_Mobile,co_Email,co_Sales,co_Remark,
	   (isnull(co_Name,'')+'<br>'+isnull(co_Address1,'')+'<br>'+isnull(co_Address2,'')+'<br>'+isnull(co_Address3,'')+'<br>'+isnull(co_Address4,'')) as co_Address
	   from cs_Company where co_ROWID=@ROWID 
		--select  distinct  co_ParentID from cs_Company  order by co_ROWID desc 
		--select top 12 * from cs_Company  where co_CompanyKind='BASE' 'NORMAL'
		end
		else
		begin
		 select 
		co_Code,co_Address1,co_Name,co_Contact,co_Phone,co_Fax,co_Mobile,co_Email,co_CompanyKind,co_CompanyType,
		co_ParentID,co_LANG,co_HaveBill,co_HaveAE,co_HaveAI,co_HaveOE,co_HaveOI,co_CompanyKind,co_CompanyType,co_Keyword,co_CreditTerm,co_UseOnBL,co_UseOnBill,co_UseOnOther,co_AGENT,co_Group,co_Name,
		co_Address2,co_Address3,co_Address4,co_Location,co_Contact,co_Phone,co_Fax,co_Mobile,co_Email,co_Sales,co_Remark,
	   (isnull(co_Name,'')+'<br>'+isnull(co_Address1,'')+'<br>'+isnull(co_Address2,'')+'<br>'+isnull(co_Address3,'')+'<br>'+isnull(co_Address4,'')) as co_Address
	    from cs_Company where co_ParentID=@ROWID and co_CompanyKind=@CompanyKind
		end
	end
	
end
GO
