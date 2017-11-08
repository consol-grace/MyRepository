<%@ WebHandler Language="C#" Class="DropDownList" %>

using System;
using System.Web;
using Newtonsoft.Json;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;
using System.Text;
using System.Linq;


public class DropDownList : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.AddHeader("pragma", "no-cache"); 
        HttpContext.Current.Response.CacheControl = "no-cache"; 
      
        getJSON(context);
    }

    DataFactory dal = new DataFactory();

    public void getJSON(HttpContext context)
    {
        string cmdText = context.Request["action"];
        string sys = context.Request["sys"];
        DataSet ds = null;

        //if (context.Cache[sys + "_" + cmdText] == null || (DataSet)context.Cache[sys + "_" + cmdText]==null)
        //{
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields( ).
                Append("Option", cmdText).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS",sys)}).GetList();
        //    context.Cache.Insert(sys + "_" + cmdText, ds);
        //}
        //ds = context.Cache[sys + "_" + cmdText] as DataSet;
        string key = context.Request["q"].ToUpper();

        var list = (from p in ds.Tables[0].AsEnumerable() where p.Field<string>("value").StartsWith(key, StringComparison.CurrentCulture) select p).AsDataView().ToTable();

        if (cmdText.ToUpper() == "CompanyListByName".ToUpper() || cmdText.ToUpper() == "CompanyList".ToUpper())
            list = (from p in ds.Tables[0].AsEnumerable() where p.Field<string>("value").StartsWith(key)&&!string.IsNullOrEmpty(key) select p).AsDataView().ToTable();

        context.Response.Write(getJSON(list));
    }


    private string getJSON(DataTable list)
    {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.Rows.Count && list != null; ++i)
        {
            for (int j = 0; j < list.Columns.Count; ++j)
            {
                sb.Append(list.Rows[i]["value"] + "|");
            }
            sb.Remove(sb.Length - 1, 1).Append("\n");
        }
        return sb.ToString();
    }


    public void getList(HttpContext context)
    {
        string cmdText = context.Request["action"];
        string sys = context.Request["sys"];
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields( ).
                Append("Option", cmdText).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS",sys)}).GetList();

        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(ds));
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}