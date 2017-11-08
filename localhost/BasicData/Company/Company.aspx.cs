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

public partial class BasicData_Company_Company : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            shipSign.Checked = true;
            GridBind();
        }
    }

    public readonly DataFactory dal = new DataFactory();
    public void GridBind()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_FW_Company_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GridBind")
        }).GetList();
        this.gridpanel.GetStore().DataSource = ds;
        this.gridpanel.GetStore().DataBind();
    }

    protected void row_Click(object sender, DirectEventArgs e)
    {
        txtRowID.Text = e.ExtraParams["RowID"];
        txtId.Text = e.ExtraParams["CompanyID"];
        txtCode.Text = e.ExtraParams["Stat"];
        txtDistrict.Text = e.ExtraParams["District"];
        txtNameEn.Text = e.ExtraParams["NAMEENG"];
        txtNameLocal.Text = e.ExtraParams["NameCHS"];
        txtAddressEn.Text = e.ExtraParams["AddressENG"];
        txtAddressLocal.Text = e.ExtraParams["AddressCHS"];
        txtTel.Text = e.ExtraParams["Tel"];
        txtFax.Text = e.ExtraParams["Fax"];
        txtEmail.Text = e.ExtraParams["Email"];
        string rate = txtDimensionRate.Text = e.ExtraParams["DIMRate"] == "" || e.ExtraParams["DIMRate"] == null ? null : e.ExtraParams["DIMRate"];
        if (string.IsNullOrEmpty(rate))
            txtDimensionRate.Clear();
        else
            txtDimensionRate.Text = rate;

        txtDimensionUnit.Text = e.ExtraParams["DIMUnit"];

        string dimfloat = txtDimensionFloat.Text = e.ExtraParams["DIMFloat"] == "" || e.ExtraParams["DIMFloat"] == null ? null : e.ExtraParams["DIMFloat"];
        if (string.IsNullOrEmpty(dimfloat))
            txtDimensionFloat.Clear();
        else
            txtDimensionFloat.Text = dimfloat;
        txtArrangedText.Text = e.ExtraParams["AWBArrange"];
        chkActive.Checked = e.ExtraParams["IsDelete"].ToUpper().ToString() == "N" ? true : false;
        chkChinaMode.Checked = e.ExtraParams["ChinaMode"] == "false" ? false : true;
        chkChinaInvoice.Checked = e.ExtraParams["ChineseInvoice"] == "false" ? false : true;
        shipSign.Checked = e.ExtraParams["Ship"] == "false" ? false : true;
        conSign.Checked = e.ExtraParams["Com"] == "false" ? false : true;

        FCurrency.Text=e.ExtraParams["FCurrency"];
        LCurrency.Text=e.ExtraParams["LCurrency"];
    }

    [DirectMethod(Namespace = "CompanyX")]
    public void btnAddSave_Click()
    {
        btnSave_Click();
        txtRowID.Text = null;
        txtId.Text = null;
        txtCode.Text = null;
        txtDistrict.Text = null;
        txtNameEn.Text = null;
        txtNameLocal.Text = null;
        txtAddressEn.Text = null;
        txtAddressLocal.Text = null;
        txtTel.Text = null;
        txtFax.Text = null;
        txtEmail.Text = null;
        txtDimensionRate.Clear();
        txtDimensionUnit.Text = null;
        txtDimensionFloat.Clear();
        txtArrangedText.Text = null;
        chkActive.Checked = false;
        chkChinaMode.Checked = false;
        chkChinaInvoice.Checked = false;
        shipSign.Checked = true;
        conSign.Checked = false;
        FCurrency.Text = null;
        LCurrency.Text = null;
        RowSelectionModel row = this.gridpanel.GetSelectionModel() as RowSelectionModel;
        row.ClearSelections();
    }


    [DirectMethod(Namespace = "CompanyX")]
    public void btnSave_Click()
    {
        if (string.IsNullOrEmpty(txtId.Text))
        {
            txtId.Text = "";
            txtId.Focus();
            return;
        }
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_FW_Company_SP", new List<IFields>() { 
                dal.CreateIFields()
            .Append("Option", "Update")
            .Append("RowID",txtRowID.Text)
            .Append("CompanyID",txtId.Text.ToUpper())
            .Append("District",txtDistrict.Text)           
            .Append("Creator",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("Modifier",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("IsDelete",chkActive.Checked?"N":"Y")
            .Append("Tel",txtTel.Text)
            .Append("Fax",txtFax.Text)
            .Append("Email",txtEmail.Text)
            .Append("DIMUnit",txtDimensionUnit.Text==""||txtDimensionUnit.Text==null?"M":txtDimensionUnit.Text)
            .Append("DIMFloat",txtDimensionFloat.Text==""||txtDimensionFloat.Text==null?"3":txtDimensionFloat.Text)
            .Append("AddressCHS",txtAddressLocal.Text.ToUpper())
            .Append("AddressENG",txtAddressEn.Text.ToUpper())
            .Append("DIMRate",txtDimensionRate.Text==""||txtDimensionRate.Text==null?"6000":txtDimensionRate.Text)
            .Append("AWBArrange",txtArrangedText.Text==""||txtArrangedText.Text==null?"AS ARRANGED":txtArrangedText.Text)
            .Append("Stat",txtCode.Text.ToUpper())
            .Append("NameCHS",txtNameLocal.Text.ToUpper())
            .Append("NAMEENG",txtNameEn.Text.ToUpper())
            .Append("ChinaMode",chkChinaMode.Checked?1:0)
            .Append("ChineseInvoice",chkChinaInvoice.Checked?1:0)
            .Append("comSign",conSign.Checked?1:0)
            .Append("shipSign",shipSign.Checked?1:0)
            .Append("FCurrency",FCurrency.Text.Trim().ToUpper())
            .Append("LCurrency",LCurrency.Text.Trim().ToUpper())
        }).Update();

        if (b)
        {
            DataTable getMax = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_FW_Company_SP", new List<IFields>() { 
                dal.CreateIFields()
                .Append("Option","GetMax")
                }).GetTable();
            if (getMax != null && getMax.Rows.Count > 0 && txtRowID.Text == "")
            {
                txtRowID.Text = getMax.Rows[0][0].ToString().Trim();
            }
        }
        else
        {
            X.Msg.Alert("status", " Save failed ").Show();
        }
        GridBind();
    }


    [DirectMethod]
    public void btnCancel_click()
    {
        if (string.IsNullOrEmpty(txtRowID.Text))
        {
            X.Msg.Alert("status", " Please choose to delete lines", new JFunction() { Fn = "textResult" }).Show();
            return;
        }
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_FW_Company_SP", new List<IFields>() { 
                dal.CreateIFields()
            .Append("Option", "Delete")
            .Append("RowID",txtRowID.Text)            
        }).Update();
        if (b)
        {
            GridBind();
        }
        else
        {
            X.Msg.Alert("status", " Delete failed ").Show();
        }
    }
}
