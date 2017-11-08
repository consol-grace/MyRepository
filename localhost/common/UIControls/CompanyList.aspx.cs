using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using Ext.Net;

public partial class common_UIControls_CompanyList : System.Web.UI.Page
{
    public static string sys = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                txtCode.Text = Request["code"];
                sys = GetSys(Request.UrlReferrer.AbsolutePath);
                BindData();
                txtCode.Focus();
            }
        }
        
    }

    private string GetSys(string str)
    {
        string sys = "";
        if (str.StartsWith("/AirImport/"))
        {
            sys = "AI";
        }
        else if (str.StartsWith("/AirExport/"))
        {
            sys = "AE";
        }
        else if (str.StartsWith("/OceanExport/"))
        {
            sys = "OE";
        }
        else if (str.StartsWith("/OceanImport/"))
        {
            sys = "OI";
        }
        return sys;
    }

    private void BindData()
    {
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "GetCompanyList")
            .Append("Code",txtCode.Text.Trim())
            .Append("Address1",txtAddress.Text.Trim())
            .Append("SYS",all.Checked?"Y":"N") 
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12]) 
            .Append("dept",FSecurityHelper.CurrentUserDataGET()[28]) 
            .Append("FromSys",sys) 

        }).GetTable();

        storeCompany.DataSource = dt;
        storeCompany.DataBind();
        PagingToolbar1.SetPageIndex(1);
    }

    protected void btnfilter_Click(object sender, DirectEventArgs e)
    {
        // bool l = txtCode.SelectOnFocus;
        BindData();

        //if (l)
        //    txtCode.Focus(true, 1);
        //else
        //    txtName.Focus(true, 1);

    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        //bool l = txtCode.SelectOnFocus;
        //int start = (e.Start == -1) ? 0 :e.Start;
        //int limit = (e.Limit == -1) ? 100 : e.Limit;
        BindData();
        //if (l)
        //    txtCode.Focus(true, 1);
        //else
        //    txtName.Focus(true, 1);
    }


}
