using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class BasicData_Customer_detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ControlBinder.ChkGroupBind(this.tblChkGroup);

        if (!IsPostBack)
        {
            if (!X.IsAjaxRequest)
            {

                InitCmb();
                hidRowID.Text = string.IsNullOrEmpty(Request["rowid"]) ? "0" : Request["rowid"];
            }

            CheckGroupClear();  //2014-12-12 Grace 
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            DataShow();
        }
    }

    DataFactory dal = new DataFactory();

    public string dep = FSecurityHelper.CurrentUserDataGET()[28];
    public string currStation = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
    void InitCmb()
    {
        if (!(dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN"))
        {
            ControlBinder.CmbBinder(storeType, "TypeListByOP", "");
            cmbFromUser.Disabled = false;
        }
        else
        { ControlBinder.CmbBinder(storeType, "TypeList", ""); }

        ControlBinder.CmbBinder(storeLocation, "LocationList", "");
        ControlBinder.CmbBinder(storeSales, "SalesList", "");
        ControlBinder.CmbBinder(storeFromUser, "GetUserList", "");
        //ControlBinder.CmbBinder(StoreCountry, "CountryList", "");
        //Location.Template.Html = template.Html;
        //Sales.Template.Html = template.Html;
        //CmbCountry.Template.Html = template.Html;
        txtCCompany.AllowBlank = false;
        biCompany.AllowBlank = false;

    }

    void ListStat()
    {
        //DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() { dal.CreateIFields()
        //          .Append("Option", "StatModified")
        //          .Append("code", Code.Text.Trim())
        //          .Append("stat", FSecurityHelper.CurrentUserDataGET()[12]) }).GetTable();
        //if (dt != null && dt.Rows.Count > 0)
        //{
        //    int currindex = 0;
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        ChkSyncStat.Items.Add(new System.Web.UI.WebControls.ListItem(dr["Stat"].ToString()));
        //        ChkSyncStat.Items[currindex].Selected = Convert.ToBoolean(dr["selectList"]);
        //        ++currindex;
        //    }
        //}
    }


    public DataSet getList()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Detail")
            .Append("ROWID",hidRowID.Text)
            .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("Code",string.IsNullOrEmpty(Request["code"])?"No Data":Request["code"])       
        }).GetList();
        return ds;
    }

    public void DataShow()
    {
        DataSet ds = getList();
        if (ds != null)
        {
            #region BASE
            if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
            {
                hidRowID.Text = ds.Tables[0].Rows[0]["co_RowID"].ToString();
                Code.Text = ds.Tables[0].Rows[0]["co_Code"].ToString();
                hidChageCode.Text = ds.Tables[0].Rows[0]["co_Code"].ToString();
                //cmbType.Text = ds.Tables[0].Rows[0]["co_CompanyType"].ToString();
                cmbType.Value = ds.Tables[0].Rows[0]["co_CompanyType"].ToString();
                //cmbType.setValue(ds.Tables[0].Rows[0]["co_CompanyType"].ToString());
                hidChangeType.Text = ds.Tables[0].Rows[0]["co_CompanyType"].ToString();
                //Location.Text = ds.Tables[0].Rows[0]["co_Location"].ToString();
                Location.setValue(ds.Tables[0].Rows[0]["co_Location"].ToString());
                //Sales.Text = ds.Tables[0].Rows[0]["co_Sales"].ToString();
                Sales.setValue(ds.Tables[0].Rows[0]["co_Sales"].ToString());
                geCompany.Text = ds.Tables[0].Rows[0]["co_Name"].ToString();
                geKeyword.Text = ds.Tables[0].Rows[0]["co_Keyword"].ToString();

                geAddress1.Text = ds.Tables[0].Rows[0]["co_Address1"].ToString();
                geAddress2.Text = ds.Tables[0].Rows[0]["co_Address2"].ToString();
                geAddress3.Text = ds.Tables[0].Rows[0]["co_Address3"].ToString();
                geAddress4.Text = ds.Tables[0].Rows[0]["co_Address4"].ToString();

                geContact.Text = ds.Tables[0].Rows[0]["co_Contact"].ToString();
                gePhone.Text = ds.Tables[0].Rows[0]["co_Phone"].ToString();
                geFax.Text = ds.Tables[0].Rows[0]["co_Fax"].ToString();
                geMobile.Text = ds.Tables[0].Rows[0]["co_Mobile"].ToString();
                geEmail.Text = ds.Tables[0].Rows[0]["co_Email"].ToString();
                string remark = ds.Tables[0].Rows[0]["co_Remark"].ToString().Trim();
                Remark.Text = remark;

                string str = ds.Tables[0].Rows[0]["co_Address"].ToString().Replace("\"", "&quot;");
                geAWB.InnerHtml = ds.Tables[0].Rows[0]["co_Address"].ToString();
                //Group.setValue(ds.Tables[0].Rows[0]["co_Group"]);

                X.AddScript("geAWB(\"" + str + "\");");

                chkIsValid.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["co_isvalid"].ToString());
                bool bill = Convert.ToBoolean(ds.Tables[0].Rows[0]["bill"].ToString());
                bool ai = Convert.ToBoolean(ds.Tables[0].Rows[0]["ai"].ToString());
                bool ae = Convert.ToBoolean(ds.Tables[0].Rows[0]["ae"].ToString());
                bool oi = Convert.ToBoolean(ds.Tables[0].Rows[0]["oi"].ToString());
                bool oe = Convert.ToBoolean(ds.Tables[0].Rows[0]["oe"].ToString());
                bool sameBill = Convert.ToBoolean(ds.Tables[0].Rows[0]["co_SameBill"]);
                bool haveChinese = Convert.ToBoolean(ds.Tables[0].Rows[0]["co_HaveChinese"]);

                cmbFromUser.Text = ds.Tables[0].Rows[0]["co_RequestFrom"].ToString().Trim();

                //chkAE.Checked = ae;
                //chkAI.Checked = ai;
                chkBILL.Checked = true;
                //chkOE.Checked = oe;
                //chkOI.Checked = oi;
                chbBill.Checked = sameBill;
                chbChinese.Checked = haveChinese;

                if (sameBill) { X.AddScript("ReadOnly('BILLDisplay',true);"); } else { X.AddScript("ReadOnly('BILLDisplay',false);"); }
                if (haveChinese) { X.AddScript("$('#div_china').show();"); } else { X.AddScript("$('#div_china').hide();"); }

                //if (bill) { X.AddScript("$('#chkBILL').attr('checked',true);ShowOne('BILL');"); } else { X.AddScript("$('#chkBILL').attr('checked',false);"); }
                //if (ai) { };//X.AddScript("$('#chkAI').attr('checked','" + ai + "');ShowOne('AI');"); }
                //if (ae) { };//X.AddScript("$('#chkAE').attr('checked','" + ae + "');ShowOne('AE');"); }
                //if (oi) { };//X.AddScript("$('#chkOI').attr('checked','" + oi + "');ShowOne('OI');"); }
                //if (oe) { };//X.AddScript("$('#chkOE').attr('checked','" + oe + "');ShowOne('OE');"); }
                
                string cotype= ds.Tables[0].Rows[0]["co_CompanyType"].ToString().ToUpper();
                if ((cotype == "BRANCH" || cotype == "AG_CL") && (dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN") && currStation=="Y")
                {
                    chkIsSales.Checked = ds.Tables[0].Rows[0]["isSales"].ToString() == "Y" ? true : false;
                    X.AddScript("$('#td_sales1,#td_sales2').show();");
                }

                string[] statlist = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["StatList"].ToString()) ? new string[] { } : ds.Tables[0].Rows[0]["StatList"].ToString().Split(',');
                CheckGroupClear();

                foreach (string _strstat in statlist)
                {
                    for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
                    {
                        if (tblChkGroup.Items[i].Tag.ToString().Trim().ToUpper() == _strstat.Trim().ToUpper())
                        {
                            tblChkGroup.Items[i].Checked = true;
                            break;
                        }
                    }
                }

                geState.Text = ds.Tables[0].Rows[0]["co_State"].ToString();
                geZIP.Text = ds.Tables[0].Rows[0]["co_ZipCode"].ToString();
                geCountry.Text = ds.Tables[0].Rows[0]["co_Country"].ToString();
                txtUsCode.Text = ds.Tables[0].Rows[0]["co_USCode"].ToString();
                string type = ds.Tables[0].Rows[0]["co_CompanyType"].ToString();
                X.AddScript("ReadOnlyByType('" + type + "');");

                div_bottom.Html = "<p class=\"\">Status : Edit the record of <span>" + Code.Text + "</span>. </p>";
                Code.Disabled = true;
                Code.Focus(true);
                Readonly("Y");

            }
            else
            {
                X.AddScript("ReadOnly('BILLDisplay',true);");
                div_bottom.Html = "<p class=\"\">Status : New company record. </p>";
                X.AddScript("CancelClick();");
                Code.Disabled = false;
                cmbType.Focus();
                Readonly("N");
            }

            #endregion
            #region BILL
            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
            {
                biCompany.Text = ds.Tables[1].Rows[0]["co_Name"].ToString();
                biPaymentto.Text = ds.Tables[1].Rows[0]["co_PaymentTo"].ToString();
                biCredit.Text = ds.Tables[1].Rows[0]["co_CreditTerm"].ToString();
                biAddress1.Text = ds.Tables[1].Rows[0]["co_Address1"].ToString();
                biAddress2.Text = ds.Tables[1].Rows[0]["co_Address2"].ToString();
                biAddress3.Text = ds.Tables[1].Rows[0]["co_Address3"].ToString();
                biAddress4.Text = ds.Tables[1].Rows[0]["co_Address4"].ToString();

                biContact.Text = ds.Tables[1].Rows[0]["co_Contact"].ToString();
                biPhone.Text = ds.Tables[1].Rows[0]["co_Phone"].ToString();
                biFax.Text = ds.Tables[1].Rows[0]["co_Fax"].ToString();
                biEmail.Text = ds.Tables[1].Rows[0]["co_Email"].ToString();
                //biRemark.InnerText = ds.Tables[1].Rows[0]["co_Remark"].ToString();

                biState.Text = ds.Tables[1].Rows[0]["co_State"].ToString();
                biZIP.Text = ds.Tables[1].Rows[0]["co_ZipCode"].ToString();
                biCountry.Text = ds.Tables[1].Rows[0]["co_Country"].ToString();


            }
            #endregion
            #region AI
            if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
            {
                aiCompany.Text = ds.Tables[2].Rows[0]["co_Name"].ToString();
                aiAddress1.Text = ds.Tables[2].Rows[0]["co_Address1"].ToString();
                aiAddress2.Text = ds.Tables[2].Rows[0]["co_Address2"].ToString();
                aiAddress3.Text = ds.Tables[2].Rows[0]["co_Address3"].ToString();
                aiAddress4.Text = ds.Tables[2].Rows[0]["co_Address4"].ToString();

                aiContact.Text = ds.Tables[2].Rows[0]["co_Contact"].ToString();
                aiPhone.Text = ds.Tables[2].Rows[0]["co_Phone"].ToString();
                aiFax.Text = ds.Tables[2].Rows[0]["co_Fax"].ToString();
                aiEmail.Text = ds.Tables[2].Rows[0]["co_Email"].ToString();


            }
            #endregion
            #region AE
            if (ds.Tables[3] != null && ds.Tables[3].Rows.Count > 0)
            {
                aeCompany.Text = ds.Tables[3].Rows[0]["co_Name"].ToString();
                aeAddress1.Text = ds.Tables[3].Rows[0]["co_Address1"].ToString();
                aeAddress2.Text = ds.Tables[3].Rows[0]["co_Address2"].ToString();
                aeAddress3.Text = ds.Tables[3].Rows[0]["co_Address3"].ToString();
                aeAddress4.Text = ds.Tables[3].Rows[0]["co_Address4"].ToString();

                aeContact.Text = ds.Tables[3].Rows[0]["co_Contact"].ToString();
                aePhone.Text = ds.Tables[3].Rows[0]["co_Phone"].ToString();
                aeFax.Text = ds.Tables[3].Rows[0]["co_Fax"].ToString();
                aeEmail.Text = ds.Tables[3].Rows[0]["co_Email"].ToString();
                aeAWB.InnerHtml = ds.Tables[3].Rows[0]["co_Address"].ToString();
            }
            #endregion
            #region OI
            if (ds.Tables[4] != null && ds.Tables[4].Rows.Count > 0)
            {
                oiCompany.Text = ds.Tables[4].Rows[0]["co_Name"].ToString();
                oiAddress1.Text = ds.Tables[4].Rows[0]["co_Address1"].ToString();
                oiAddress2.Text = ds.Tables[4].Rows[0]["co_Address2"].ToString();
                oiAddress3.Text = ds.Tables[4].Rows[0]["co_Address3"].ToString();
                oiAddress4.Text = ds.Tables[4].Rows[0]["co_Address4"].ToString();

                oiContact.Text = ds.Tables[4].Rows[0]["co_Contact"].ToString();
                oiPhone.Text = ds.Tables[4].Rows[0]["co_Phone"].ToString();
                oiFax.Text = ds.Tables[4].Rows[0]["co_Fax"].ToString();
                oiEmail.Text = ds.Tables[4].Rows[0]["co_Email"].ToString();

            }
            #endregion
            #region OE
            if (ds.Tables[5] != null && ds.Tables[5].Rows.Count > 0)
            {
                oeCompany.Text = ds.Tables[5].Rows[0]["co_Name"].ToString();
                oeAddress1.Text = ds.Tables[5].Rows[0]["co_Address1"].ToString();
                oeAddress2.Text = ds.Tables[5].Rows[0]["co_Address2"].ToString();
                oeAddress3.Text = ds.Tables[5].Rows[0]["co_Address3"].ToString();
                oeAddress4.Text = ds.Tables[5].Rows[0]["co_Address4"].ToString();

                oeContact.Text = ds.Tables[5].Rows[0]["co_Contact"].ToString();
                oePhone.Text = ds.Tables[5].Rows[0]["co_Phone"].ToString();
                oeFax.Text = ds.Tables[5].Rows[0]["co_Fax"].ToString();
                oeEmail.Text = ds.Tables[5].Rows[0]["co_Email"].ToString();
                oeAWB.InnerHtml = ds.Tables[5].Rows[0]["co_Address"].ToString();
            }
            #endregion
            #region Chinese
            if (ds.Tables[6] != null && ds.Tables[6].Rows.Count > 0)
            {
                txtCCompany.Text = ds.Tables[6].Rows[0]["co_Name"].ToString();
                txtCAddress1.Text = ds.Tables[6].Rows[0]["co_Address1"].ToString();
                txtCAddress2.Text = ds.Tables[6].Rows[0]["co_Address2"].ToString();
                txtCAddress3.Text = ds.Tables[6].Rows[0]["co_Address3"].ToString();
                txtCAddress4.Text = ds.Tables[6].Rows[0]["co_Address4"].ToString();

                txtCContact.Text = ds.Tables[6].Rows[0]["co_Contact"].ToString();
                txtCPhone.Text = ds.Tables[6].Rows[0]["co_Phone"].ToString();
                txtCFax.Text = ds.Tables[6].Rows[0]["co_Fax"].ToString();
                txtCEmail.Text = ds.Tables[6].Rows[0]["co_Email"].ToString();
                //cngeAWB.InnerHtml = ds.Tables[6].Rows[0]["co_Address"].ToString();

                txtCState.Text = ds.Tables[6].Rows[0]["co_State"].ToString();
                txtCZIP.Text = ds.Tables[6].Rows[0]["co_ZipCode"].ToString();
                txtCCountry.Text = ds.Tables[6].Rows[0]["co_Country"].ToString();


            }
            #endregion
        }

        ListStat();

    }

    /// <summary>
    /// 清空Checkbox
    /// </summary>
    private void CheckGroupClear()
    {
        for (int ii = 0; ii < tblChkGroup.Items.Count(); ++ii)
            tblChkGroup.Items[ii].Checked = false;
    }


    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        bool bFlag = true;

        string strStat = "";
        for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
        {
            if (!tblChkGroup.Items[i].Checked)
                strStat += tblChkGroup.Items[i].Tag.Trim() + ",";
        }
        strStat = strStat.Length > 0 ? strStat.Substring(0, strStat.Length - 1) : strStat;

        if (string.IsNullOrEmpty(cmbType.Text))
        {
            cmbType.Text = "";
            cmbType.Focus(true);
            div_bottom.Html = "<p class='error'>Status: Error message , The type can't for empty .</p>";
            return;
        }

        if (string.IsNullOrEmpty(Code.Text.Trim()))
        {
            Code.Text = "";
            Code.Focus(true);
            div_bottom.Html = "<p class='error'>Status: Error message , The code can't for empty .</p>";
            return;
        }

        if (string.IsNullOrEmpty(cmbFromUser.Text.Trim()))
        {
            cmbFromUser.Text = "";
            cmbFromUser.Focus(true);
            div_bottom.Html = "<p class='error'>Status: Error message , The request from can't for empty .</p>";
            return;
        }

        if (System.Text.RegularExpressions.Regex.Matches(Code.Text.Trim().ToString(), @"[A-Za-z0-9/]").Count != Code.Text.Trim().Length)
        {
            div_bottom.Html = "<p class='error'>Status: Error message , The code can't contain special symbols .</p>";
            return;
        }


        //if (string.IsNullOrEmpty(Location.Text))
        //{
        //    Location.Text = "";
        //    Location.Focus(true);
        //    div_bottom.Html = "<p class='error'>Status: Error message , The location can't for empty .</p>";
        //    return;
        //}

        int len = 0;
        string strflag = BaseCheckCode.CheckType(cmbType.Text, Code.Text, ref len);
        if (strflag != "Y" && (string.IsNullOrEmpty(hidRowID.Value.ToString()) || hidRowID.Value == "0"))
        {
            X.AddScript("$('#Code').attr('validata', 'false').addClass('bottom_line');");
            div_bottom.Html = "<p class='error'>Status: Error message , The code length must be " + len + " .</p>";
            return;
        }
        //if (dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN")
        //{
        //    if (strflag != "Y")
        //    {
        //        X.AddScript("$('#Code').attr('validata', 'false').addClass('bottom_line');");
        //        div_bottom.Html = "<p class='error'>Status: Error message , The code length must be " + len + " .</p>";
        //        return;
        //    }
        //}
        //else
        //{
        //    if (strflag != "Y" && (string.IsNullOrEmpty(hidRowID.Value.ToString()) || hidRowID.Value == "0"))
        //    {
        //        X.AddScript("$('#Code').attr('validata', 'false').addClass('bottom_line');");
        //        div_bottom.Html = "<p class='error'>Status: Error message , The code length must be " + len + " .</p>";
        //        return;
        //    }
        //}

        if (string.IsNullOrEmpty(geCompany.Text))
        {
            geCompany.Text = "";
            geCompany.Focus();
            div_bottom.Html = "<p class='error'>Status: Error message , The company name can't for empty .</p>";
            return;
        }

        if (string.IsNullOrEmpty(biCompany.Text))
        {
            biCompany.Text = "";
            biCompany.Focus();
            X.AddScript("$(document).scrollTop('150');");
            div_bottom.Html = "<p class='error'>Status: Error message , ( Billing Information ) The company name can't for empty .</p>";
            return;
        }

        if (string.IsNullOrEmpty(txtCCompany.Text) && chbChinese.Checked)
        {
            txtCCompany.Text = "";
            txtCCompany.Focus();
            X.AddScript("$(document).scrollTop('400');");
            div_bottom.Html = "<p class='error'>Status: Error message , ( Chinese Information ) The company name can't for empty .</p>";
            return;
        }

        if (Request.Form["hidRowID"] != "0" && !string.IsNullOrEmpty(Request.Form["hidRowID"]))//更新
        {
            #region  //update
            List<IFields> fields = new List<IFields>();
            fields.Add(dal.CreateIFields().Append("Option", "Update")
            .Append("ROWID", hidRowID.Text)
            .Append("ParentID", "0")
            .Append("Code", Code.Text.ToUpper().Trim())
            .Append("CompanyType", cmbType.Value)
            .Append("Location", Location.Value)
            .Append("Sales", Sales.Value)
                .Append("HaveAE", chkAE.Checked)
                .Append("HaveOE", chkOE.Checked)
                .Append("HaveAI", chkAI.Checked)
                .Append("HaveOI", chkOI.Checked)
                .Append("HaveBILL", chkBILL.Checked).Append("co_SameBill", chbBill.Checked)
                .Append("co_HaveChinese", chbChinese.Checked)

                .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS", DBNull.Value)
                .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                //Ge
                .Append("Name", geCompany.Text.ToUpper().Trim())
                .Append("Address1", geAddress1.Text.ToUpper().Trim())
                .Append("Address2", geAddress2.Text.ToUpper().Trim())
                .Append("Address3", geAddress3.Text.ToUpper().Trim())
                .Append("Address4", geAddress4.Text.ToUpper().Trim())
                .Append("Contact", geContact.Text.ToUpper().Trim())
                .Append("Phone", gePhone.Text.ToUpper().Trim())
                .Append("Fax", geFax.Text.ToUpper().Trim())
                .Append("Mobile", geMobile.Text.ToUpper().Trim())
                .Append("Email", geEmail.Text.Trim())
                .Append("Keyword", geKeyword.Text.ToUpper().Trim())
                //.Append("Group", Group.Value)
                .Append("co_State", geState.Text.ToUpper().Trim())
                .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                .Append("co_Country", geCountry.Text.ToUpper().Trim())
                .Append("Remark", Remark.Text.ToUpper().Trim())
                .Append("co_isvalid", chkIsValid.Checked)
                .Append("co_RequestFrom", cmbFromUser.Text)
                .Append("dept", dep)
                .Append("statstr", strStat)
                .Append("transforSales", chkIsSales.Checked&&(dep.ToUpper()=="IT"||dep.ToUpper()=="ADMIN") ? "Y" : "N")

            );

            if (chkBILL.Checked)
            {

                fields.Add(dal.CreateIFields().Append("Option", "Update")
                    .Append("Code", Code.Text.ToUpper().Trim())
                    .Append("CompanyType", cmbType.Value)
                    .Append("Location", Location.Value)
                    .Append("Sales", Sales.Value)
                    .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                    .Append("SYS", DBNull.Value).Append("co_SameBill", chbBill.Checked)
                    .Append("co_HaveChinese", chbChinese.Checked)
                    .Append("co_isvalid", chkIsValid.Checked)
                    .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("CompanyKind", "BILL")
                    .Append("ParentID", hidRowID.Text.ToUpper().Trim())
                    .Append("ROWID", hidRowID.Text.ToUpper().Trim())
                    .Append("co_PaymentTo", biPaymentto.Text.ToUpper().Trim())
                    .Append("CreditTerm", biCredit.Text.ToUpper().Trim())
                    .Append("Name", biCompany.Text.ToUpper().Trim())
                    .Append("Address1", biAddress1.Text.ToUpper().Trim())
                    .Append("Address2", biAddress2.Text.ToUpper().Trim())
                    .Append("Address3", biAddress3.Text.ToUpper().Trim())
                    .Append("Address4", biAddress4.Text.ToUpper().Trim())
                    .Append("Contact", biContact.Text.ToUpper().Trim())
                    .Append("Phone", biPhone.Text.ToUpper().Trim())
                    .Append("Fax", biFax.Text.ToUpper().Trim())
                    .Append("co_State", biState.Text.ToUpper().Trim())
                    .Append("co_ZipCode", biZIP.Text.ToUpper().Trim())
                    .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                    .Append("co_Country", biCountry.Text.ToUpper().Trim())
                    .Append("Email", biEmail.Text.Trim()));
            }
            if (chkAE.Checked)
            {
                fields.Add(dal.CreateIFields().Append("Option", "Update")
                   .Append("ROWID", hidRowID.Text)
                   .Append("Code", Code.Text.ToUpper().Trim())
                   .Append("CompanyType", cmbType.Value)
                   .Append("Location", Location.Value)
                   .Append("Sales", Sales.Value)
                   .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                   .Append("SYS", DBNull.Value)
                   .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                   .Append("CompanyKind", "AE").Append("co_SameBill", chbBill.Checked)
                   .Append("co_HaveChinese", chbChinese.Checked)
                   .Append("co_isvalid", chkIsValid.Checked)
                   .Append("ParentID", hidRowID.Text)
                   .Append("Name", aeCompany.Text.ToUpper().Trim())
                   .Append("Address1", aeAddress1.Text.ToUpper().Trim())
                   .Append("Address2", aeAddress2.Text.ToUpper().Trim())
                   .Append("Address3", aeAddress3.Text.ToUpper().Trim())
                   .Append("Address4", aeAddress4.Text.ToUpper().Trim())
                   .Append("Contact", aeContact.Text.ToUpper().Trim())
                   .Append("Phone", aePhone.Text.ToUpper().Trim())
                   .Append("Fax", aeFax.Text.ToUpper().Trim())
                   .Append("co_State", geState.Text.ToUpper().Trim())
                   .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                   .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                   .Append("co_Country", geCountry.Text.ToUpper().Trim())
                   .Append("Email", aeEmail.Text.Trim())
                    //.Append("Remark", Request.Form["aeAWB"])
                );
            }
            if (chkAI.Checked)
            {
                fields.Add(dal.CreateIFields().Append("Option", "Update")
                  .Append("ROWID", hidRowID.Text)
                  .Append("Code", Code.Text.ToUpper().Trim())
                  .Append("CompanyType", cmbType.Value)
                  .Append("Location", Location.Value)
                  .Append("Sales", Sales.Value)
                  .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                  .Append("SYS", DBNull.Value)
                  .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                  .Append("CompanyKind", "AI").Append("co_SameBill", chbBill.Checked)
                  .Append("co_HaveChinese", chbChinese.Checked)
                  .Append("co_isvalid", chkIsValid.Checked)
                  .Append("ParentID", hidRowID.Text.ToUpper().Trim())
                  .Append("Name", aiCompany.Text.ToUpper().Trim())
                  .Append("Address1", aiAddress1.Text.ToUpper().Trim())
                  .Append("Address2", aiAddress2.Text.ToUpper().Trim())
                  .Append("Address3", aiAddress3.Text.ToUpper().Trim())
                  .Append("Address4", aiAddress4.Text.ToUpper().Trim())
                  .Append("Contact", aiContact.Text.ToUpper().Trim())
                  .Append("Phone", aiPhone.Text.ToUpper().Trim())
                  .Append("Fax", aiFax.Text.ToUpper().Trim())
                  .Append("co_State", geState.Text.ToUpper().Trim())
                  .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                  .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                  .Append("co_Country", geCountry.Text.ToUpper().Trim())
                  .Append("Email", aiEmail.Text.Trim()));
            }
            if (chkOE.Checked)
            {
                fields.Add(dal.CreateIFields().Append("Option", "Update")
                      .Append("CompanyKind", "OE")
                      .Append("Code", Code.Text.ToUpper().Trim())
                      .Append("CompanyType", cmbType.Value)
                      .Append("Location", Location.Value)
                      .Append("Sales", Sales.Value).Append("co_SameBill", chbBill.Checked)
                      .Append("co_HaveChinese", chbChinese.Checked)
                      .Append("co_isvalid", chkIsValid.Checked)
                      .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                      .Append("SYS", DBNull.Value)
                      .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                      .Append("ROWID", hidRowID.Text.ToUpper().Trim())
                      .Append("ParentID", hidRowID.Text.ToUpper().Trim())
                      .Append("Name", oeCompany.Text.ToUpper().Trim())
                      .Append("Address1", oeAddress1.Text.ToUpper().Trim())
                      .Append("Address2", oeAddress2.Text.ToUpper().Trim())
                      .Append("Address3", oeAddress3.Text.ToUpper().Trim())
                      .Append("Address4", oeAddress4.Text.ToUpper().Trim())
                      .Append("Contact", oeContact.Text.ToUpper().Trim())
                      .Append("Phone", oePhone.Text.ToUpper().Trim())
                      .Append("Fax", oeFax.Text.ToUpper().Trim())
                      .Append("co_State", geState.Text.ToUpper().Trim())
                      .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                      .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                      .Append("co_Country", geCountry.Text.ToUpper().Trim())
                      .Append("Email", oeEmail.Text.Trim())
                    // .Append("Remark", Request.Form["oeAWB"])
               );
            }
            if (chkOI.Checked)
            {
                fields.Add(dal.CreateIFields().Append("Option", "Update")
                    .Append("ROWID", hidRowID.Text.ToUpper().Trim())
                    .Append("Code", Code.Text.ToUpper().Trim())
                    .Append("CompanyType", cmbType.Value)
                    .Append("Location", Location.Value)
                    .Append("Sales", Sales.Value)
                    .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                    .Append("SYS", DBNull.Value)
                    .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                    .Append("CompanyKind", "OI").Append("co_SameBill", chbBill.Checked)
                    .Append("co_HaveChinese", chbChinese.Checked)
                    .Append("co_isvalid", chkIsValid.Checked)
                    .Append("ParentID", hidRowID.Text.ToUpper().Trim())
                    .Append("Name", oiCompany.Text.ToUpper().Trim())
                    .Append("Address1", oiAddress1.Text.ToUpper().Trim())
                    .Append("Address2", oiAddress2.Text.ToUpper().Trim())
                    .Append("Address3", oiAddress3.Text.ToUpper().Trim())
                    .Append("Address4", oiAddress4.Text.ToUpper().Trim())
                    .Append("Contact", oiContact.Text.ToUpper().Trim())
                    .Append("Phone", oiPhone.Text.ToUpper().Trim())
                    .Append("Fax", oiFax.Text.ToUpper().Trim())
                    .Append("co_State", geState.Text.ToUpper().Trim())
                    .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                    .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                    .Append("co_Country", geCountry.Text.ToUpper().Trim())
                    .Append("Email", oiEmail.Text.Trim()));
            }
            //Chinese
            if (chbChinese.Checked)
            {
                fields.Add(dal.CreateIFields().Append("Option", "Update")
                    .Append("ROWID", hidRowID.Text.ToUpper().Trim())
                    .Append("Code", Code.Text.ToUpper().Trim())
                    .Append("CompanyType", cmbType.Value)
                    .Append("Location", Location.Value)
                    .Append("Sales", Sales.Value)
                                    .Append("co_SameBill", chbBill.Checked)
                    .Append("co_HaveChinese", chbChinese.Checked)
                    .Append("co_isvalid", chkIsValid.Checked)
                    .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                    .Append("SYS", DBNull.Value)
                    .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                    .Append("CompanyKind", "CN")
                    .Append("ParentID", hidRowID.Text.ToUpper().Trim())
                    .Append("Name", txtCCompany.Text.ToUpper().Trim())
                    .Append("Address1", txtCAddress1.Text.ToUpper().Trim())
                    .Append("Address2", txtCAddress2.Text.ToUpper().Trim())
                    .Append("Address3", txtCAddress3.Text.ToUpper().Trim())
                    .Append("Address4", txtCAddress4.Text.ToUpper().Trim())
                    .Append("Contact", txtCContact.Text.ToUpper().Trim())
                    .Append("Phone", txtCPhone.Text.ToUpper().Trim())
                    .Append("Fax", txtCFax.Text.ToUpper().Trim())
                    .Append("co_State", txtCState.Text.ToUpper().Trim())
                    .Append("co_ZipCode", txtCZIP.Text.ToUpper().Trim())
                    .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                    .Append("co_Country", txtCCountry.Text.ToUpper().Trim())
                    .Append("Email", txtCEmail.Text.Trim()));
            }

            bFlag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", fields).Update();
            #endregion
        }
        else//添加
        {
            #region //insert
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS",DBNull.Value)
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                //标头
                .Append("Code",Code.Text.ToUpper().Trim())
                .Append("CompanyKind", "BASE")
                .Append("CompanyType",cmbType.Value)
                .Append("Location",Location.Value)
                .Append("Sales",Sales.Value)
                .Append("HaveAE", chkAE.Checked)
                .Append("HaveOE", chkOE.Checked)
                .Append("HaveAI", chkAI.Checked)
                .Append("HaveOI", chkOI.Checked)
                //.Append("HaveBILL",true)
                .Append("HaveBILL", chkBILL.Checked)
                .Append("co_SameBill",chbBill.Checked)
                .Append("co_HaveChinese",chbChinese.Checked)
                //Ge
                .Append("Name",geCompany.Text.ToUpper().Trim())
                .Append("Address1", geAddress1.Text.ToUpper().Trim())
                .Append("Address2", geAddress2.Text.ToUpper().Trim())
                .Append("Address3", geAddress3.Text.ToUpper().Trim())
                .Append("Address4", geAddress4.Text.ToUpper().Trim())
                .Append("Contact",geContact.Text.ToUpper().Trim())
                .Append("Phone",gePhone.Text.ToUpper().Trim())
                .Append("Fax",geFax.Text.ToUpper().Trim())
                .Append("Mobile",geMobile.Text.ToUpper().Trim())
                .Append("Email",geEmail.Text.Trim())
                .Append("Keyword",geKeyword.Text.ToUpper().Trim())
                .Append("Remark",Remark.Text.ToUpper())
                .Append("co_State",geState.Text.ToUpper().Trim())
                .Append("co_ZipCode",geZIP.Text.ToUpper().Trim())
                .Append("co_USCode",txtUsCode.Text.ToUpper().Trim())
                .Append("co_Country",geCountry.Text.ToUpper().Trim())
                //.Append("Group",Group.Value)
                .Append("co_isvalid",chkIsValid.Checked)
                .Append("co_RequestFrom",cmbFromUser.Text)
                .Append("dept", dep)
                .Append("statstr", strStat)
                .Append("transforSales", chkIsSales.Checked&&(dep.ToUpper()=="IT"||dep.ToUpper()=="ADMIN") ? "Y" : "N")

            }).GetList();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                string RowID = ds.Tables[0].Rows[0][0].ToString();

                hidRowID.Text = RowID;

                List<IFields> fl = new List<IFields>();
                //Bill

                if (chkBILL.Checked)
                {
                    fl.Add(dal.CreateIFields().Append("Option", "Update")
                        //标头
                     .Append("Code", Code.Text.ToUpper().Trim().Trim())
                     .Append("CompanyType", cmbType.Value)
                     .Append("Location", Location.Value)
                     .Append("Sales", Sales.Value)
                     .Append("HaveAE", "0")
                     .Append("HaveOE", "0")
                     .Append("HaveAI", "0")
                     .Append("HaveOI", "0")
                     .Append("co_SameBill", chbBill.Checked)
                     .Append("co_HaveChinese", chbChinese.Checked)

                     .Append("HaveBILL", chkBILL.Checked)
                     .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                     .Append("SYS", DBNull.Value)
                     .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                     .Append("CompanyKind", "BILL")
                     .Append("ParentID", RowID)

                     .Append("co_PaymentTo", biPaymentto.Text.ToUpper().Trim())
                     .Append("CreditTerm", biCredit.Text.ToUpper().Trim())
                     .Append("Name", biCompany.Text.ToUpper().Trim())
                     .Append("Address1", biAddress1.Text.ToUpper().Trim())
                     .Append("Address2", biAddress2.Text.ToUpper().Trim())
                     .Append("Address3", biAddress3.Text.ToUpper().Trim())
                     .Append("Address4", biAddress4.Text.ToUpper().Trim())
                     .Append("Contact", biContact.Text.ToUpper().Trim())
                     .Append("Phone", biPhone.Text.ToUpper().Trim())
                     .Append("Fax", biFax.Text.ToUpper().Trim())
                        //.Append("Remark", biRemark.Text.ToUpper().Trim())
                     .Append("co_State", biState.Text.ToUpper().Trim())
                     .Append("co_ZipCode", biZIP.Text.ToUpper().Trim())
                     .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                     .Append("co_Country", biCountry.Text.ToUpper().Trim())
                     .Append("co_isvalid", chkIsValid.Checked)
                     .Append("Email", biEmail.Text.Trim()));

                }
                //AE
                if (chkAE.Checked)
                {
                    fl.Add(dal.CreateIFields().Append("Option", "Update")
                        //标头
                  .Append("Code", Code.Text.ToUpper().Trim())
                  .Append("CompanyType", cmbType.Value)
                  .Append("Location", Location.Value)
                  .Append("Sales", Sales.Value)
                  .Append("HaveAE", "1")
                  .Append("HaveOE", "0")
                  .Append("HaveAI", "0")
                  .Append("HaveOI", "0")
                  .Append("co_SameBill", chbBill.Checked)
                  .Append("co_HaveChinese", chbChinese.Checked)
                  .Append("co_isvalid", chkIsValid.Checked)
                  .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                  .Append("SYS", DBNull.Value)
                  .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                  .Append("CompanyKind", "AE")
                  .Append("ParentID", RowID)
                  .Append("Name", aeCompany.Text.ToUpper().Trim())
                  .Append("Address1", aeAddress1.Text.ToUpper().Trim())
                  .Append("Address2", aeAddress2.Text.ToUpper().Trim())
                  .Append("Address3", aeAddress3.Text.ToUpper().Trim())
                  .Append("Address4", aeAddress4.Text.ToUpper().Trim())
                  .Append("Contact", aeContact.Text.ToUpper().Trim())
                  .Append("Phone", aePhone.Text.ToUpper().Trim())
                  .Append("Fax", aeFax.Text.ToUpper().Trim())
                  .Append("co_State", geState.Text.ToUpper().Trim())
                  .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                  .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                  .Append("co_Country", geCountry.Text.ToUpper().Trim())

                  .Append("Email", aeEmail.Text.Trim()));

                }
                //AI
                if (chkAI.Checked)
                {
                    fl.Add(dal.CreateIFields().Append("Option", "Update")
                        //标头
                         .Append("Code", Code.Text.ToUpper().Trim().Trim())
                         .Append("CompanyType", cmbType.Value)
                         .Append("Location", Location.Value)
                         .Append("Sales", Sales.Value)
                         .Append("HaveAE", "0")
                         .Append("HaveOE", "0")
                         .Append("HaveAI", "1")
                         .Append("HaveOI", "0").Append("co_SameBill", chbBill.Checked)
                         .Append("co_HaveChinese", chbChinese.Checked)
                         .Append("co_isvalid", chkIsValid.Checked)
                         .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                         .Append("SYS", DBNull.Value)
                         .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                         .Append("CompanyKind", "AI")
                         .Append("ParentID", RowID)
                         .Append("Name", aiCompany.Text.ToUpper().Trim())
                         .Append("Address1", aiAddress1.Text.ToUpper().Trim())
                         .Append("Address2", aiAddress2.Text.ToUpper().Trim())
                         .Append("Address3", aiAddress3.Text.ToUpper().Trim())
                         .Append("Address4", aiAddress4.Text.ToUpper().Trim())
                         .Append("Contact", aiContact.Text.ToUpper().Trim())
                         .Append("Phone", aiPhone.Text.ToUpper().Trim())
                         .Append("Fax", aiFax.Text.ToUpper().Trim())
                          .Append("co_State", geState.Text.ToUpper().Trim())
                          .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                          .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                          .Append("co_Country", geCountry.Text.ToUpper().Trim())
                         .Append("Email", aiEmail.Text.Trim()));

                }
                //OE
                if (chkOE.Checked)
                {
                    fl.Add(dal.CreateIFields().Append("Option", "Update")
                        //标头
                         .Append("Code", Code.Text.ToUpper().Trim().Trim())
                         .Append("CompanyType", cmbType.Value)
                         .Append("Location", Location.Value)
                         .Append("Sales", Sales.Value)
                         .Append("HaveAE", "0")
                         .Append("HaveOE", "1")
                         .Append("HaveAI", "0")
                         .Append("HaveOI", "0").Append("co_SameBill", chbBill.Checked)
                         .Append("co_HaveChinese", chbChinese.Checked)
                         .Append("co_isvalid", chkIsValid.Checked)
                         .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                         .Append("SYS", DBNull.Value)
                         .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                         .Append("CompanyKind", "OE")
                         .Append("ParentID", RowID)
                         .Append("Name", oeCompany.Text.ToUpper().Trim())
                         .Append("Address1", oeAddress1.Text.ToUpper().Trim())
                         .Append("Address2", oeAddress2.Text.ToUpper().Trim())
                         .Append("Address3", oeAddress3.Text.ToUpper().Trim())
                         .Append("Address4", oeAddress4.Text.ToUpper().Trim())
                         .Append("Contact", oeContact.Text.ToUpper().Trim())
                         .Append("Phone", oePhone.Text.ToUpper().Trim())
                         .Append("Fax", oeFax.Text.ToUpper().Trim())
                          .Append("co_State", geState.Text.ToUpper().Trim())
                          .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                          .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                          .Append("co_Country", geCountry.Text.ToUpper().Trim())
                         .Append("Email", oeEmail.Text.Trim()));

                }
                //OI
                if (chkOI.Checked)
                {
                    fl.Add(dal.CreateIFields().Append("Option", "Update")
                        //标头
                         .Append("Code", Code.Text.ToUpper().Trim().Trim())
                         .Append("CompanyType", cmbType.Value)
                         .Append("Location", Location.Value)
                         .Append("Sales", Sales.Value)
                         .Append("HaveAE", "0")
                         .Append("HaveOE", "0")
                         .Append("HaveAI", "0")
                         .Append("HaveOI", "1").Append("co_SameBill", chbBill.Checked)
                         .Append("co_HaveChinese", chbChinese.Checked)
                         .Append("co_isvalid", chkIsValid.Checked)
                         .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                         .Append("SYS", DBNull.Value)
                         .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                         .Append("CompanyKind", "OI")
                         .Append("ParentID", RowID)
                         .Append("Name", oiCompany.Text.ToUpper().Trim())
                         .Append("Address1", oiAddress1.Text.ToUpper().Trim())
                         .Append("Address2", oiAddress2.Text.ToUpper().Trim())
                         .Append("Address3", oiAddress3.Text.ToUpper().Trim())
                         .Append("Address4", oiAddress4.Text.ToUpper().Trim())
                         .Append("Contact", oiContact.Text.ToUpper().Trim())
                         .Append("Phone", oiPhone.Text.ToUpper().Trim())
                         .Append("Fax", oiFax.Text.ToUpper().Trim())
                          .Append("co_State", geState.Text.ToUpper().Trim())
                          .Append("co_ZipCode", geZIP.Text.ToUpper().Trim())
                          .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                          .Append("co_Country", geCountry.Text.ToUpper().Trim())
                         .Append("Email", oiEmail.Text.Trim()));

                }
                //Chinese
                if (chbChinese.Checked)
                {
                    fl.Add(dal.CreateIFields().Append("Option", "Update")
                        //标头
                           .Append("Code", Code.Text.ToUpper().Trim().Trim())
                           .Append("CompanyType", cmbType.Value)
                           .Append("Location", Location.Value)
                           .Append("Sales", Sales.Value)
                           .Append("HaveAE", "0")
                           .Append("HaveOE", "0")
                           .Append("HaveAI", "0")
                           .Append("HaveOI", "0").Append("co_SameBill", chbBill.Checked)
                           .Append("co_HaveChinese", chbChinese.Checked)
                           .Append("co_isvalid", chkIsValid.Checked)
                           .Append("HaveBILL", chkBILL.Checked)
                           .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                           .Append("SYS", DBNull.Value)
                           .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                           .Append("CompanyKind", "CN")
                           .Append("ParentID", RowID)
                           .Append("Name", txtCCompany.Text.ToUpper().Trim())
                           .Append("Address1", txtCAddress1.Text.ToUpper().Trim())
                           .Append("Address2", txtCAddress2.Text.ToUpper().Trim())
                           .Append("Address3", txtCAddress3.Text.ToUpper().Trim())
                           .Append("Address4", txtCAddress4.Text.ToUpper().Trim())
                           .Append("Contact", txtCContact.Text.ToUpper().Trim())
                           .Append("Phone", txtCPhone.Text.ToUpper().Trim())
                           .Append("Fax", txtCFax.Text.ToUpper().Trim())
                          .Append("co_State", txtCState.Text.ToUpper().Trim())
                          .Append("co_ZipCode", txtCZIP.Text.ToUpper().Trim())
                          .Append("co_USCode", txtUsCode.Text.ToUpper().Trim())
                          .Append("co_Country", txtCCountry.Text.ToUpper().Trim())
                          .Append("Email", txtCEmail.Text.Trim()));
                }

                if (fl.Count > 0)
                {
                    bFlag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", fl).Update();
                }
            #endregion
            }
        }
        if (bFlag)
        {

            if (i == 1)
            {
                X.AddScript("CancelClick();");
                X.Redirect("detail.aspx?control=" + Request["control"] + "&code=&scrollTop=100");
            }
            else
            {
                if (!string.IsNullOrEmpty(Request["control"]))
                {
                    X.AddScript("window.parent.ChildCallBack(Request(\"control\"), $(\"#Code\").val());");
                    return;
                }
            }
            //X.Msg.Alert("Status", " saved successful ! ", new JFunction { Handler = "Code.focus(true);" }).Show();
            div_bottom.Html = "<p class='success'>Status: Saved successful .</p>";
            hidChageCode.Text = Code.Text.Trim();
            hidChangeType.Text = cmbType.Text;
            Code.Disabled = true;

        }
        else
        {
            //X.Msg.Alert("Status", " Error, saved failed ! ", new JFunction { Handler = "Code.focus(true);" }).Show();
            div_bottom.Html = "<p class='error'>Status: Error, saved failed .</p>";

        }

        //DataShow();
        //Code.Focus(true);
        cmbType.Focus(true);

    }

    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        chbBill.Checked = true;
        chbChinese.Checked = false;
        X.AddScript("BtnCancel();");
        DataShow();
    }

    int i = 0;
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        i = 1;
        btnSave_Click(sender, e);
        //hidRowID.Text = "0";
        //X.Redirect("detail.aspx?control=" + Request["control"] + "&code=&scrollTop=100");
        //control=CmbNotify1Code&code=CON/HKGO&scrollTop=100

    }

    public XTemplate template
    {
        get
        {
            XTemplate xt = new XTemplate();
            xt.Html = "<tpl for=\".\">" +
                                                       "<tpl if=\"[xindex] == 1\">" +
                                                           "<table class=\"cbStates-list\">" +
                                                               "<tr>" +
                                                                    "<th>value</th>" +
                                                                   "<th>text</th>" +
                                                               "</tr>" +
                                                       "</tpl>" +
                                                           "<tr class=\"list-item\">" +
                                                           "<td style=\"padding:3px 0px; width:30%\">{value}</td>" +
                                                           "<td style=\"padding:3px 0px; width:70%\">{text}</td>" +
                                                       "</tr>" +
                                                       "<tpl if=\"[xcount-xindex]==0\">" +
                                                               "</table>" +
                                                       "</tpl></tpl>";
            return xt;
        }
    }


    [DirectMethod(Namespace = "CompanyX")]
    public void ChangeTypeEidtCode()
    {
        //if (dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN")
        if (dep.ToUpper() == "IT")
        {
            //if (hidChangeType.Text.Trim().ToUpper() == cmbType.Text.Trim().ToUpper())
            //    Code.Disabled = true;
            //else
            Code.Disabled = false;
        }
    }


    public void Readonly(string type)
    {
        type = type.ToUpper();
        if (!((dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN") && currStation == "Y"))
        {
            cmbType.Disabled = true;
            Location.Disabled = true;
            Sales.Disabled = true;

            Next.Disabled = true;
            Cancel.Disabled = true;
            //button.Disabled = true;
            cmbFromUser.Disabled = true;
            geKeyword.Disabled = true;            
            chkBILL.Disabled = true;
            chbChinese.Disabled = true;
            chkIsValid.Disabled = true;
            if (type == "N")
                form1.Disabled = true;
            X.AddScript("ReadOnlyAll('" + type + "');");
        }
    }


    [DirectMethod(Namespace = "CompanyX")]
    public void SyncCompany(string stat)
    {
        if (dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN")
        {
            if (!string.IsNullOrEmpty(Code.Text.Trim()))
            {
                bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "[FW_BasicData_Company_SP]", new List<IFields>() { dal.CreateIFields()
                    .Append("Option", "UpdateCompanyStat")
                    .Append("stat",stat.ToUpper())
                    .Append("code",Code.Text.ToUpper().Trim())
                    .Append("CompanyType",cmbType.Text.ToUpper())
                    .Append("user", FSecurityHelper.CurrentUserDataGET()[0])}).Update();
            }
        }
    }

}
