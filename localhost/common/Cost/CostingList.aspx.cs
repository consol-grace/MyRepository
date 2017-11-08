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

public partial class common_Cost_CostingList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            DataBinder();
        }
    }

    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetList")
            .Append("seed", Request["CostingSeed"])
        }).GetList();
        storeList.DataSource = ds;
        storeList.DataBind();

        hidPageSeed.Text = Request["CostingSeed"];
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }

    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
    }

}
