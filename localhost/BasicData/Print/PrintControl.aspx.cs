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


public partial class BasicData_Print_PrintControl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            BindCombox();
            DataBinder("");
        }
    }
    public readonly DataFactory dal = new DataFactory();
    #region BindCombox()
    private void BindCombox()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "PrintForStat")
        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            Store2.DataSource = dt;
            Store2.DataBind();
        }

        DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "PrintForSys")
        }).GetTable();
        if (dt1 != null && dt1.Rows.Count > 0)
        {
            Store3.DataSource = dt1;
            Store3.DataBind();
        }

        DataSet dt2 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>(){
            dal.CreateIFields().Append("Option","PrinterForPrinter")
        }).GetList();
        StorePrinter.DataSource = dt2;
        StorePrinter.DataBind();
    }
    #endregion

    #region  DataBinder()   Author：Hcy  (2011-11-04)
    void DataBinder(string stat)
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "List")
            .Append("prt_STAT",stat)
        }).GetList();

        GridPanel1.GetStore().DataSource = ds;
        GridPanel1.GetStore().DataBind();
    }
    #endregion

    #region   row_Click(object,DirectEventArgs)  Author：Hcy (2011-11-04)
    protected void row_Click(object sender, DirectEventArgs e)
    {
        txtRowID.Text = e.ExtraParams["prt_ROWID"];
        CmbPrinter.setValue(e.ExtraParams["prt_PrinterCode"]);
        CmbPrinter.DisplayField = e.ExtraParams["prt_PrinterCode"];
        CmbPrinter.ValueField = e.ExtraParams["prt_PrinterName"];
        txtRemark.Text = e.ExtraParams["prt_Remark"];
        CmbStat.SelectedItem.Value = e.ExtraParams["prt_STAT"];
        CMbSys.SelectedItem.Value = e.ExtraParams["prt_Sys"];
        txtReportName.Text = e.ExtraParams["prt_Report"];
        prt_PrinterCode.Text = e.ExtraParams["prt_PrinterCode"];
        prt_PrinterName.Text = e.ExtraParams["prt_PrinterName"];
        chkDefault.Checked = e.ExtraParams["prt_IsDefault"].ToString() == "√" ? true : false;
        string top = txtReportTop.Text = e.ExtraParams["rc_rptTop"];
        if (string.IsNullOrEmpty(top))
            txtReportTop.Clear();
        else
            txtReportTop.Text = top;

        string bottom = txtReportBottom.Text = e.ExtraParams["rc_rptBottom"];
        if (string.IsNullOrEmpty(bottom))
            txtReportBottom.Clear();
        else
            txtReportBottom.Text = bottom;
        string left = txtReportLeft.Text = e.ExtraParams["rc_rptLeft"];
        if (string.IsNullOrEmpty(left))
            txtReportLeft.Clear();
        else
            txtReportLeft.Text = left;

        string right = txtReportRight.Text = e.ExtraParams["rc_rptRight"];
        if (string.IsNullOrEmpty(right))
            txtReportRight.Clear();
        else
            txtReportRight.Text = right;

        if (string.IsNullOrEmpty(e.ExtraParams["prt_PrintCount"]))
            txtPrintCount.Clear();
        else
            txtPrintCount.Text = e.ExtraParams["prt_PrintCount"];

        txtStat.Text = e.ExtraParams["prt_STAT"];
        txtSys.Text = e.ExtraParams["prt_Sys"];
        txtReport.Text = e.ExtraParams["prt_Report"];
        txtReportName.Focus();
    }
    #endregion

    #region  btnAddSave_Click(object, EventArgs) Author：Hcy  (2011-11-04)
    [DirectMethod(Namespace = "CompanyX")]
    public void btnAddSave_Click()
    {
        btnSave_Click();
        txtRowID.Text = "";
        txtRemark.Text = "";
        CmbPrinter.setValue("");
        txtReportName.Text = "";
        txtReportTop.Clear();
        txtReportBottom.Clear();
        txtReportLeft.Clear();
        txtReportRight.Clear();
        txtPrintCount.Clear();
        txtReportName.Focus();
        chkDefault.Checked = false;
        RowSelectionModel row = this.GridPanel1.GetSelectionModel() as RowSelectionModel;
        row.ClearSelections();
    }
    #endregion

    #region  btnSave_Click(object, EventArgs) Author：Hcy  (2011-11-04)
    [DirectMethod(Namespace = "CompanyX")]
    public void btnSave_Click()
    {
        if (string.IsNullOrEmpty(CmbPrinter.Text))
        {
            prt_PrinterName.Text = null;
        }
        if (CmbStat.Text.Trim() == "")
        {
            CmbStat.Text = "";
            CmbStat.Focus();
            return;
        }
        //if (CMbSys.Text.Trim() == "")
        //{
        //    CMbSys.Text = "";
        //    CMbSys.Focus();
        //    return;
        //}
        if (txtReportName.Text.Trim() == "")
        {
            txtReportName.Text = "";
            txtReportName.Focus();
            return;
        }
        addCheck();
    }
    #endregion

    #region public void addCheck()
    public void addCheck()
    {
        //DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { 
        //dal.CreateIFields()
        //.Append("Option","check")
        //.Append("prt_ROWID",txtRowID.Text)
        //.Append("prt_STAT",CmbStat.SelectedItem.Value)
        //.Append("prt_Sys",CMbSys.SelectedItem.Value)
        //.Append("prt_ReportCode",txtReportName.Text.ToUpper())
        //}).GetTable();

        //if (int.Parse(dt1.Rows[0][0].ToString().Trim()) == 1)
        //{
        //    X.Msg.Alert("status", "Report already exists").Show();
        //    return;
        //}
        addSave();
        checkDefault();
    }
    #endregion

    #region public void addSave()
    public void addSave()
    {
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields()
         .Append("Option", "Update")
         .Append("prt_PrinterCode",CmbPrinter.Text)
         .Append("prt_PrinterName",prt_PrinterName.Text)
         .Append("prt_Remark",txtRemark.Text.ToUpper())
         .Append("prt_STAT",CmbStat.SelectedItem.Value)
         .Append("prt_Creator",FSecurityHelper.CurrentUserDataGET()[0])
         .Append("prt_Modifier",FSecurityHelper.CurrentUserDataGET()[0])
         .Append("prt_Sys",CMbSys.SelectedItem.Value)
         .Append("prt_ReportCode",txtReportName.Text.ToUpper())
         .Append("prt_ROWID",txtRowID.Text)
         .Append("rc_rptTop",txtReportTop.Text==""?null:txtReportTop.Text)
         .Append("rc_rptBottom",txtReportBottom.Text==""?null:txtReportBottom.Text)
         .Append("rc_rptLeft",txtReportLeft.Text==""?null:txtReportLeft.Text)
         .Append("rc_rptRight",txtReportRight.Text==""?null:txtReportRight.Text)
         .Append("prt_PrintCount",txtPrintCount.Text==""?null:txtPrintCount.Text)
         .Append("prt_IsDefault",chkDefault.Checked? 1:0)
         }).Update();
        if (b)
        {
            txtReportName.Focus();
            DataTable getMax = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { 
                dal.CreateIFields()
                .Append("Option","getMax")
                }).GetTable();
            if (getMax != null && getMax.Rows.Count > 0 && txtRowID.Text == "")
            {
                txtRowID.Text = getMax.Rows[0][0].ToString().Trim();
            }
        }
        else
        {
            X.Msg.Alert("status", " Save failed ", new JFunction() { Fn = "textResult" }).Show();
        }
        DataBinder(CmbStat.Text);
    }
    #endregion

    #region public void checkDefault()
    public void checkDefault()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { 
        dal.CreateIFields()
        .Append("Option","CheckDefault")
        .Append("prt_STAT",CmbStat.SelectedItem.Value)
        .Append("prt_Sys",CMbSys.SelectedItem.Value)
        .Append("prt_ReportCode",txtReportName.Text.ToUpper())
        }).GetTable();

        if (dt.Rows[0][0].ToString() == "0")
        {
            X.Msg.Alert("status", "This report does not have a default printer").Show();
        }
    }
    #endregion

    #region public void btnCancel_Click()
    [DirectMethod]
    public void btnCancel_Click()
    {
        if (string.IsNullOrEmpty(txtRowID.Text))
        {
            X.Msg.Alert("status", " Please choose to delete lines", new JFunction() { Fn = "textResult" }).Show();
            return;
        }
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields()
         .Append("Option", "Delete")
         .Append("prt_ROWID",txtRowID.Text)
         .Append("prt_Modifier",FSecurityHelper.CurrentUserDataGET()[0])
         }).Update();
        if (b)
        {
            DataBinder("");
            txtRowID.Text = "";
            txtRemark.Text = "";
            txtReportName.Text = "";
            txtReportTop.Text = "";
            txtReportBottom.Text = "";
            txtReportLeft.Text = "";
            txtReportRight.Text = "";
            txtPrintCount.Text = "";
            txtReportName.Focus();
            RowSelectionModel row = this.GridPanel1.GetSelectionModel() as RowSelectionModel;
            row.SelectFirstRow();
        }
        else
        {
            X.Msg.Alert("status", " Delete failed ", new JFunction() { Fn = "textResult" }).Show();
        }

    }
    #endregion

    #region  CmbStat_Select()
    public void CmbStat_Select(object sender, DirectEventArgs e)
    {
        DataBinder(CmbStat.Text);
        BindCombox();
    }
    #endregion

    [DirectMethod(Namespace = "CompanyX")]
    public void btnCopyPdf_Click()
    {

        string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/"));
        url = url.Substring(0, url.LastIndexOf("/")) + "/Report/ReportCopy.aspx?isWin=1";

        X.AddScript("winCopyPdf.load('" + url + "');winCopyPdf.show();");
    }
}
