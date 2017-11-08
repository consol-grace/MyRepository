using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wuqi.Webdiyer;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.DBLL;
using Ext.Net;

public partial class Framework_User_list : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            GridBind("");
            ComboboxBind();
        }
    }
    public readonly DataFactory dal = new DataFactory();
    public void GridBind(string str)
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GridBind")
            .Append("STAT",str)
        }).GetList();
        this.gridpanel.GetStore().DataSource = ds;
        this.gridpanel.GetStore().DataBind();
    }
    public void ComboboxBind()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "CompanyBind")
        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            CmbStat.GetStore().DataSource = dt;
            CmbStat.GetStore().DataBind();
        }

        DataTable dtid = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "CompanyIDBind")
        }).GetTable();
        if (dtid != null && dtid.Rows.Count > 0)
        {
            cmbCompany.GetStore().DataSource = dtid;
            cmbCompany.GetStore().DataBind();
        }
    }

    [DirectMethod(Namespace = "CompanyX")]
    public void btnAddSave_Click()
    {
        btnSave_Click();
        ClearText(txtUser);
        ClearText(txtPwd);
        ClearText(txtPwdAgain);
        ClearText(txtFax);
        ClearText(txtNameEn);
        ClearText(txtNameLocal);
        ClearText(txtEmail);
        ClearText(txtTel);
        ClearText(txtRemark);
        cmbCompany.Clear();
        chkActive.Checked = false;
    }

    [DirectMethod(Namespace = "CompanyX")]
    public void btnSave_Click()
    {
        if (CheckNullOrEmpty(txtUser)) return;
        if (CheckNullOrEmpty(txtPwd)) return;
        if (txtPwdAgain.Text.Trim() != txtPwd.Text.Trim())
        {
            txtPwdAgain.Text = "";
            txtPwdAgain.Focus();
            return;
        }

        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { 
                dal.CreateIFields()
            .Append("Option","UpdateUser")
            .Append("UserName",txtUser.Text)
            .Append("RowID",txtRowID.Text)
            .Append("UserPWD",PageHelper.MD5(txtPwd.Text.Trim()))
            .Append("NameCHS",txtNameLocal.Text)
            .Append("NameENG",txtNameEn.Text)
            .Append("CompanyID",cmbCompany.SelectedItem.Text==""?null:cmbCompany.SelectedItem.Text)
            .Append("Email",txtEmail.Text)
            .Append("IsActivation",chkActive.Checked?"Y":"N")
            .Append("Remark",txtRemark.Text)
            .Append("Tel",txtTel.Text)
            .Append("STAT",CmbStat.SelectedItem.Text)
            .Append("Fax",txtFax.Text)
            .Append("Modifier",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("Creator",FSecurityHelper.CurrentUserDataGET()[0])
            }).Update();
        if (b)
        {
            DataTable getMax = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { 
                dal.CreateIFields()
                .Append("Option","GetMax")
            }).GetTable();
            if (getMax != null && getMax.Rows.Count > 0 && txtRowID.Text == "")
            {
                txtRowID.Text = getMax.Rows[0][0].ToString().Trim();
            }
            GridBind("");
        }
        else
        {
            X.Msg.Alert("status", " Save failed ").Show();
        }
    }

    [DirectMethod]
    public void btnCancel_click()
    {
        if (string.IsNullOrEmpty(txtRowID.Text))
        {
            X.Msg.Alert("status", " Please choose to delete lines").Show();
            return;
        }
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
             .Append("Option", "DeleteUser")
             .Append("RowID",txtRowID.Text)
             .Append("Modifier",FSecurityHelper.CurrentUserDataGET()[0])
        }).Update();
        if (b)
        {
            GridBind("");
            RowSelectionModel row = this.gridpanel.GetSelectionModel() as RowSelectionModel;
            row.SelectFirstRow();
        }
        else
        {
            X.Msg.Alert("status", " Delete failed ").Show();
        }
    }

    protected void row_Click(object sender, DirectEventArgs e)
    {
        txtRowID.Text = e.ExtraParams["RowID"];
        CmbStat.SelectedItem.Text = e.ExtraParams["STAT"];
        cmbCompany.Text = e.ExtraParams["CompanyID"];
        txtUser.Text = e.ExtraParams["UserName"];
        txtPwd.Text = e.ExtraParams["UserPWD"];
        txtPwdAgain.Text = e.ExtraParams["UserPWD"];
        txtNameEn.Text = e.ExtraParams["NameENG"];
        txtNameLocal.Text = e.ExtraParams["NameCHS"];
        txtTel.Text = e.ExtraParams["Tel"];
        txtFax.Text = e.ExtraParams["Fax"];
        txtEmail.Text = e.ExtraParams["Email"];
        txtRemark.Text = e.ExtraParams["Remark"];
        chkActive.Checked = e.ExtraParams["IsActivation"].ToUpper() == "Y" ? true : false;
    }

    public void CmbStat_Select(object sender, DirectEventArgs e)
    {
        GridBind(CmbStat.Text);
        cmbCompany.GetStore().RemoveAll();
        DataTable dtid = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "CompanyIDBind")
            .Append("STAT", CmbStat.Text)
        }).GetTable();
        if (dtid != null && dtid.Rows.Count > 0)
        {
            cmbCompany.GetStore().DataSource = dtid;
            cmbCompany.GetStore().DataBind();
        }
        cmbCompany.SelectedIndex = 0;
    }
    /// <summary>
    /// 验证文本是否为空
    /// </summary>
    /// <param name="text"></param>
    /// <returns></returns>
    public bool CheckNullOrEmpty(Ext.Net.TextField text)
    {
        if (string.IsNullOrEmpty(text.Text.Trim()))
        {
            text.Text = "";
            text.Focus();
            return true;
        }
        else
        {
            return false;
        }
    }
    /// <summary>
    /// 验证ComboBox是否为空
    /// </summary>
    /// <param name="text"></param>
    /// <returns></returns>
    public bool CheckNullOrEmpty(Ext.Net.ComboBox text)
    {
        if (string.IsNullOrEmpty(text.Text.Trim()))
        {
            text.Text = "";
            text.Focus();
            return true;
        }
        else
        {
            return false;
        }
    }

    /// <summary>
    /// 清空文本框
    /// </summary>
    /// <param name="text"></param>
    public void ClearText(TextField text)
    {
        text.Clear();
    }
    public void ClearText(TextArea text)
    {
        text.Clear();
    }
}
