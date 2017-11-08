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

public partial class BasicData_Print_fw_printer : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            BindCombox();
            BindGrid();
        }
    }
    public readonly DataFactory dal = new DataFactory();
    #region BindCombox Author:Xup (20120504)
    private void BindCombox()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_PRINTER_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "station")
        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            StoreStat.DataSource = dt;
            StoreStat.DataBind();
        }
    }
    #endregion

    #region BindGrid() Author:Xup (20120504)
    private void BindGrid()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_PRINTER_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "gradbind")
            .Append("prt_STAT",CmbStat.SelectedItem.Value)
        }).GetList();
        GridPanel1.GetStore().DataSource = ds;
        GridPanel1.GetStore().DataBind();
    }
    #endregion

    #region btnAddSave_Click Author:Xup (20120504)
    [DirectMethod(Namespace = "CompanyX")]
    public void btnAddSave_Click()
    {
        btnSave_Click();
        RowSelectionModel row = this.GridPanel1.GetSelectionModel() as RowSelectionModel;
        row.ClearSelections();
        txtRowID.Text = "";
        Textfield2.Text = "";
        Textfield3.Text = "";
        Textfield2.Focus();
    }
    #endregion

    #region btnCancel_click()
    [DirectMethod]
    public void btnCancel_click()
    {
        if (string.IsNullOrEmpty(txtRowID.Text))
        {
            X.Msg.Alert("status", " Please choose to delete lines", new JFunction() { Fn = "textResult" }).Show();
            return;
        }

        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_PRINTER_SP", new List<IFields>() { 
            dal.CreateIFields()
            .Append("Option","delete")
            .Append("prt_ROWID",txtRowID.Text)
            .Append("prt_Modifier",FSecurityHelper.CurrentUserDataGET()[0])
         }).Update();
        BindGrid();
        txtRowID.Text = "";
        Textfield2.Text = "";
        Textfield3.Text = "";
        RowSelectionModel row = this.GridPanel1.GetSelectionModel() as RowSelectionModel;
        row.SelectFirstRow();
    }
    #endregion

    #region btnSave_Click Author:Xup (20120504)
    [DirectMethod(Namespace = "CompanyX")]
    public void btnSave_Click()
    {
        if (string.IsNullOrEmpty(CmbStat.Text.Trim()))
        {
            CmbStat.Text = "";
            CmbStat.Focus();
            return;
        }
        if (this.Textfield2.Text.Trim() == "")
        {
            Textfield2.Text = "";
            Textfield2.Focus();
            return;
        }
        else if (this.Textfield3.Text.Trim() == "")
        {
            Textfield3.Text = "";
            Textfield3.Focus();
            return;
        }

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_PRINTER_SP", new List<IFields>() { 
        dal.CreateIFields()
        .Append("Option","check")
        .Append("prt_ROWID",txtRowID.Text)
        .Append("prt_STAT",CmbStat.SelectedItem.Value)
        .Append("prt_PrinterCode",this.Textfield2.Text.ToUpper())
        .Append("prt_PrinterName",this.Textfield3.Text.ToUpper())
        }).GetTable();

        if (int.Parse(dt.Rows[0][0].ToString().Trim()) == 1)
        {
            X.Msg.Alert("status", "Printer already exists", new JFunction() { Fn = "textResult" }).Show();
            return;
        }
        addSave(dt);

    }

    public void addSave(DataTable dt)
    {
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_PRINTER_SP", new List<IFields>() { 
                dal.CreateIFields()
                .Append("Option","save")
                .Append("prt_ROWID",txtRowID.Text)
                .Append("prt_STAT",CmbStat.SelectedItem.Value)
                .Append("prt_PrinterCode",this.Textfield2.Text.ToUpper())
                .Append("prt_PrinterName",this.Textfield3.Text.ToUpper())
                }).Update();
        if (b)
        {
            if (string.IsNullOrEmpty(txtRowID.Text))
            {
                DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_PRINTER_SP", new List<IFields>() { 
                        dal.CreateIFields()
                        .Append("Option","getMax")
                        }).GetTable();
                if (dt1 != null && dt.Rows.Count > 0 && string.IsNullOrEmpty(txtRowID.Text))
                {
                    txtRowID.Text = dt1.Rows[0][0].ToString().Trim();
                }
            }
        }
        else
        {
            X.Msg.Alert("status", " Save failed ", new JFunction() { Fn = "textResult" }).Show();
        }
        this.Textfield2.Focus();
        BindGrid();
    }
    private MessageBoxButtonsConfig function()
    {
        throw new NotImplementedException();
    }
    #endregion

    #region row_Click event Author:Xup (20120504)
    protected void row_Click(object sender, DirectEventArgs e)
    {
        this.txtRowID.Text = e.ExtraParams["prt_ROWID"];
        this.CmbStat.SelectedItem.Value = e.ExtraParams["prt_STAT"];
        this.Textfield2.Text = e.ExtraParams["prt_PrinterCode"];
        this.Textfield3.Text = e.ExtraParams["prt_PrinterName"];
        this.txtSTAT.Text = e.ExtraParams["prt_STAT"];
        this.txtPrinterCode.Text = e.ExtraParams["prt_PrinterCode"];
        this.txtPrinterName.Text = e.ExtraParams["prt_PrinterName"];
        this.Textfield2.Focus();
    }
    #endregion

    #region ComboBox click event  Author:Xup (20120504)
    public void CmbStat_Select(object sender, DirectEventArgs e)
    { }
    #endregion
}
