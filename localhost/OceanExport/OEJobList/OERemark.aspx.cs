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

public partial class OceanExport_OEJobList_OERemark : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                hidID.Text=Request["ID"];
                DataBinder();
            }
        }
    }
    protected void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Report_OEOutShipment", new List<IFields>() { dal.CreateIFields()
            .Append("option", "GetRemark").Append("inv_id",hidID.Text)
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            txtRemark.Text = ds.Tables[0].Rows[0][0].ToString();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataFactory dal = new DataFactory();
        bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Report_OEOutShipment", new List<IFields>() { dal.CreateIFields()
            .Append("option", "update").Append("inv_id",hidID.Text)
            .Append("bli_BNRemark",ControlBinder.GetMakeStr(txtRemark.Text.TrimEnd().ToUpper(), 80))
        }).Update();
        if (flag == true)
        {
            //X.AddScript("if(window.parent!=null){window.parent.location.reload();}");
            X.AddScript("if(window.parent!=null){window.parent.Refresh();}");
        }
    }
}
