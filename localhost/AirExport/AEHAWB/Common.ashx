<%@ WebHandler Language="C#" Class="Common" %>

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

public class Common : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        GetJson(context.Request["key"]);
    }

    DataFactory dal = new DataFactory();
    public DataSet GetList()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWB_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "GetCompanyInfo").
        Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        return ds;
    }


    public void GetJson(string key)
    {
        if (!string.IsNullOrEmpty(key))
        {
            System.Data.DataView dv = GetList().Tables[0].DefaultView;
            dv.RowFilter = "value like '" + key + "%'";
            DataTable dt = dv.ToTable("NewTable");
            HttpContext.Current.Response.Write(JSON.Serialize(dt));
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}