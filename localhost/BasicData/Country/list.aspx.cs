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


public partial class BasicData_Country_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData();
        }
    }

    protected void BindData()
    {
        
        var store = this.GridPanel1.GetStore();
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Country_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")

        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            store.DataSource = dt;
            store.DataBind();
            Code.Focus();
        }
       
    }
    protected void Binding(object sender, DirectEventArgs e)
    {
        BindData();
    }
}
