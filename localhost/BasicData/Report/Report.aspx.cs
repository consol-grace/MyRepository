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

public partial class BasicData_Report_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            GridBind("");
            ComboboxBind();
        }
    }

    public readonly DataFactory dal = new DataFactory();
    #region GridBind()
    public void GridBind(string stat)
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Report_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "GridBind")  
            .Append("rp_Stat",stat)
        }).GetList();
        this.GridPanel.GetStore().DataSource = ds;
        this.GridPanel.GetStore().DataBind();

    }
    #endregion

    #region ComboboxBind()
    public void ComboboxBind()
    {
        DataSet dsStat = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Report_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "StatBind")            
        }).GetList();
        StoreStat.DataSource = dsStat;
        StoreStat.DataBind();

        DataSet dsSys = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Report_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "SysBind")            
        }).GetList();
        StoreSys.DataSource = dsSys;
        StoreSys.DataBind();
    }
    #endregion

    #region row_Click(object sender, DirectEventArgs e)
    protected void row_Click(object sender, DirectEventArgs e)
    {
        txtRowID.Text = e.ExtraParams["rp_RowID"];
        cmbStat.Text = e.ExtraParams["rp_Stat"];
        cmbSys.Text = e.ExtraParams["rp_Sys"];
        txtReport.Text = e.ExtraParams["rp_ReportCode"];
        txtName.Text = e.ExtraParams["rp_ReportName"];
        txtTitle.Text = e.ExtraParams["rp_Title"];
        txtRptHeader.Text = e.ExtraParams["rp_ReportHeader"];
        txtRptFooter.Text = e.ExtraParams["rp_ReportFooter"];
        txtPageHeader.Text = e.ExtraParams["rp_PageHeader"];
        txtPageFooter.Text = e.ExtraParams["rp_PageFooter"];
        txtCompanyEN.Text = e.ExtraParams["rp_CompanyNameEn"];
        txtCompanyLocal.Text = e.ExtraParams["rp_CompanyNameCN"];
        txtAddressEN.Text = e.ExtraParams["rp_CompanyAddressEn"];
        txtAddressLocal.Text = e.ExtraParams["rp_CompanyAddressCN"];
        txtTelFax.Text = e.ExtraParams["rp_CompanyTelFax"];
        chkCompnayEN.Checked = e.ExtraParams["rp_UseCompanyNameEN"] == "true" ? true : false;
        chkCompanyLocal.Checked = e.ExtraParams["rp_UseCompanyNameCN"] == "true" ? true : false;
        chkAddressEN.Checked = e.ExtraParams["rp_UseCompanyAddressEN"] == "true" ? true : false;
        chkAddressLocal.Checked = e.ExtraParams["rp_UseCompanyAddressCN"] == "true" ? true : false;
        chkTelFax.Checked = e.ExtraParams["rp_UseCompanyTelFax"] == "true" ? true : false;
        string top = e.ExtraParams["rp_MarginTop"] == "" || e.ExtraParams["rp_MarginTop"] == null ? "" : e.ExtraParams["rp_MarginTop"];
        if (string.IsNullOrEmpty(top))
            txtTop.Clear();
        else
            txtTop.Text = top;

        string buttom = txtBottom.Text = e.ExtraParams["rp_MarginBottom"] == "" || e.ExtraParams["rp_MarginBottom"] == null ? null : e.ExtraParams["rp_MarginBottom"];
        if (string.IsNullOrEmpty(buttom))
            txtBottom.Clear();
        else
            txtBottom.Text = buttom;

        string left = txtLeft.Text = e.ExtraParams["rp_MarginLeft"] == "" ? null : e.ExtraParams["rp_MarginLeft"];
        if (string.IsNullOrEmpty(left))
            txtLeft.Clear();
        else
            txtLeft.Text = left;
        string right = txtRight.Text = e.ExtraParams["rp_MarginRight"] == "" ? null : e.ExtraParams["rp_MarginRight"];
        if (string.IsNullOrEmpty(right))
            txtRight.Clear();
        else
            txtRight.Text = right;
    }
    #endregion

    #region btnAddSave_Click(object sender, EventArgs e)
    [DirectMethod(Namespace = "CompanyX")]
    public void btnAddSave_Click()
    {
        btnSave_Click();
        txtRowID.Text = null;
        txtReport.Text = null;
        txtName.Text = null;
        txtTitle.Text = null;
        txtRptHeader.Text = null;
        txtRptFooter.Text = null;
        txtPageFooter.Text = null;
        txtPageHeader.Text = null;
        txtPageFooter.Text = null;
        txtCompanyEN.Text = null;
        txtCompanyLocal.Text = null;
        txtAddressEN.Text = null;
        txtAddressLocal.Text = null;
        txtTelFax.Text = null;
        chkCompnayEN.Checked = false;
        chkCompanyLocal.Checked = false;
        chkAddressEN.Checked = false;
        chkAddressLocal.Checked = false;
        chkTelFax.Checked = false;
        txtTop.Clear();
        txtBottom.Clear();
        txtLeft.Clear();
        txtRight.Clear();
        RowSelectionModel row = this.GridPanel.GetSelectionModel() as RowSelectionModel;
        row.ClearSelections();

    }
    #endregion

    #region btnSave_Click(object sender, EventArgs e)
    [DirectMethod(Namespace = "CompanyX")]
    public void btnSave_Click()
    {
        if (string.IsNullOrEmpty(txtReport.Text))
        {
            txtReport.Text = "";
            txtReport.Focus();
            return;
        }
        CheckReport();
    }
    #endregion

    #region addSave()
    public void addSave()
    {
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Report_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "Update") 
            .Append("rp_RowID",txtRowID.Text)
            .Append("rp_Stat",cmbStat.Text.ToUpper())
            .Append("rp_Sys",cmbSys.Text.ToUpper())
            .Append("rp_ReportCode",txtReport.Text.ToUpper())
            .Append("rp_ReportName",txtName.Text.ToUpper())
            .Append("rp_Title",txtTitle.Text)
            .Append("rp_ReportHeader",txtRptHeader.Text)
            .Append("rp_ReportFooter",txtRptFooter.Text)
            .Append("rp_PageHeader",txtPageHeader.Text)
            .Append("rp_PageFooter",txtPageFooter.Text)
            .Append("rp_CompanyNameEn",txtCompanyEN.Text)
            .Append("rp_CompanyNameCN",txtCompanyLocal.Text)
            .Append("rp_CompanyAddressEn",txtAddressEN.Text)
            .Append("rp_CompanyAddressCN",txtAddressLocal.Text)
            .Append("rp_CompanyTelFax",txtTelFax.Text)
            .Append("rp_MarginTop",txtTop.Text==""||txtTop.Text==null?null:txtTop.Text)
            .Append("rp_MarginBottom",txtBottom.Text==""||txtBottom.Text==null?null:txtBottom.Text)
            .Append("rp_MarginLeft",txtLeft.Text==""||txtLeft.Text==null?null:txtLeft.Text)
            .Append("rp_MarginRight",txtRight.Text==""||txtRight.Text==null?null:txtRight.Text)
            .Append("rp_Creator",FSecurityHelper.CurrentUserDataGET()[0])           
            .Append("rp_UseCompanyNameEN",chkCompnayEN.Checked?1:0)
            .Append("rp_UseCompanyNameCN",chkCompanyLocal.Checked?1:0)
            .Append("rp_UseCompanyAddressEN",chkAddressEN.Checked?1:0)
            .Append("rp_UseCompanyAddressCN",chkAddressLocal.Checked?1:0)
            .Append("rp_UseCompanyTelFax",chkTelFax.Checked?1:0)
            .Append("rp_Modifier",FSecurityHelper.CurrentUserDataGET()[0])
            }).Update();
        if (b)
        {
            DataTable getMax = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Report_SP", new List<IFields>() { 
                dal.CreateIFields()
                .Append("Option","GetMax")
                }).GetTable();
            if (getMax != null && getMax.Rows.Count > 0 && txtRowID.Text == "")
            {
                txtRowID.Text = getMax.Rows[0][0].ToString().Trim();
            }
            GridBind(cmbStat.Text);
        }
        else
        {
            X.Msg.Alert("status", " Save failed ", new JFunction() { Fn = "textResult" }).Show();
        }
        txtReport.Focus();
    }
    #endregion

    #region CheckReport()
    public void CheckReport()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Report_SP", new List<IFields>() { 
        dal.CreateIFields()
        .Append("Option","Check")
        .Append("rp_RowID",txtRowID.Text)
        .Append("rp_Stat",cmbStat.Text)
        .Append("rp_Sys",cmbSys.Text)
        .Append("rp_ReportCode",txtReport.Text)
        }).GetTable();
        if (int.Parse(dt.Rows[0][0].ToString().Trim()) == 1)
        {
            X.Msg.Alert("status", "Report already exists", new JFunction() { Fn = "textResult" }).Show();
            return;
        }
        addSave();
    }
    #endregion

    #region btnCancel_click()
    [DirectMethod]
    public void btnCancel_click()
    {
        if (string.IsNullOrEmpty(txtRowID.Text))
        {
            X.Msg.Alert("status", " Please choose to delete lines", new JFunction() { Fn = "textResult" }).Show();
        }
        else
        {
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Report_SP", new List<IFields>() { dal.CreateIFields()
             .Append("Option", "Delete")
             .Append("rp_ROWID",txtRowID.Text)
             .Append("rp_Modifier",FSecurityHelper.CurrentUserDataGET()[0])
        }).Update();
            if (b)
            {
                cmbStat.Text = "";
                txtRowID.Text = "";
                GridBind("");
                RowSelectionModel row = this.GridPanel.GetSelectionModel() as RowSelectionModel;
                row.SelectFirstRow();
            }
            else
            {
                X.Msg.Alert("status", " Delete failed ", new JFunction() { Fn = "textResult" }).Show();
            }
        }
    }
    #endregion

    #region CmbStat_Select(object sender, DirectEventArgs e)
    public void CmbStat_Select(object sender, DirectEventArgs e)
    {
        GridBind(cmbStat.Text);
    }
    #endregion
}
