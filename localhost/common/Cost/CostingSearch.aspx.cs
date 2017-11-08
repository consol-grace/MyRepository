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

public partial class common_Cost_CostingSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtDateFrom);
            ControlBinder.DateFormat(txtDateTo);
            txtDateFrom.RawText = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
            txtDateFrom.Text = DateTime.Now.AddDays(-30).ToString("yyyy/MM/dd");
            hidPostSeed.Text= Request["postseed"] == null ? "" : Request["postseed"];
            if (hidPostSeed.Text != "")
            {
                txtDateFrom.Text = "";
            }
        }
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                DataBinder();

            }
        }
    }
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        if (hidPostSeed.Text != "")
        {
            DataSet dsDefault = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetDefaultValue")
            .Append("stat", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("seed", hidPostSeed.Text)
            }).GetList();
            if (dsDefault != null && dsDefault.Tables[0].Rows.Count > 0)
            {
                txtLotNo.Text = dsDefault.Tables[0].Rows[0][0].ToString();
                txtMBL.Text = dsDefault.Tables[0].Rows[0][1].ToString();
                txtHBL.Text = dsDefault.Tables[0].Rows[0][2].ToString();
            }
        }
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetCostList")
            .Append("stat", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("cxh_Company", cmbShipperCode.Value)
            .Append("cxh_InvoiceNo",txtInvNo.Text.Trim())
            .Append("cxd_LotNo", txtLotNo.Text.Trim())
            .Append("cxd_Master", txtMBL.Text.Trim())
            .Append("cxd_House", txtHBL.Text.Trim())
            .Append("seed", hidPostSeed.Text)
            .Append("DateFrom",ControlBinder.getDate(txtDateFrom.RawText.StartsWith("0001")?DBNull.Value:(object)txtDateFrom.RawText))
            .Append("DateTo",ControlBinder.getDate(txtDateTo.RawText.StartsWith("0001")?DBNull.Value:(object)txtDateTo.RawText))
        }).GetList();
        storeList.DataSource = ds;
        storeList.DataBind();
    }

    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        hidPostSeed.Text = "";
        DataBinder();
    }

    protected void btnReset_Click(object sender, DirectEventArgs e)
    {
        hidPostSeed.Text = "";
        cmbShipperCode.Value = "";
        txtInvNo.Text = "";
        txtLotNo.Text = "";
        txtMBL.Text = "";
        txtHBL.Text = "";
        txtDateFrom.RawText = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
        txtDateFrom.Text = DateTime.Now.AddDays(-30).ToString("yyyy/MM/dd");
        txtDateTo.Text = "";
        X.AddScript("$('#cmbShipperCode').focus();");

    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        hidPostSeed.Text = "";
        DataBinder();
    }
}
