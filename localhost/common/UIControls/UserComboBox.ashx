<%@ WebHandler Language="C#" Class="UserComboBox" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Ext.Net;
using System.Text;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Linq;

public class UserComboBox : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request["type"] == "CompanyListByName")
        {
            GetCompanyName(context.Request["query"], context.Request["type"]);
        }
        else
        {
            GetJson(context.Request["query"], context.Request["type"]);
        }
    }

    DataFactory dal = new DataFactory();

    public DataSet GetList()
    {
        DataSet ds = new DataSet();
        string sys = HttpContext.Current.Request["sys"];
        string option = HttpContext.Current.Request["option"];
        string tableName = getTableName(option);
        if (string.IsNullOrEmpty(option))
            return null;

        //if (HttpContext.Current.Cache[sys + "_" + option] == null)
        //{
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option",option).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS",sys)}).GetList();

        //    System.Web.Caching.SqlCacheDependency sqlDep = new System.Web.Caching.SqlCacheDependency(tableName, tableName);

        //    HttpContext.Current.Cache.Insert(sys + "_" + option, ds, sqlDep);
        //}
        //else
        //    ds = HttpContext.Current.Cache[sys + "_" + option] as DataSet;
        return ds;
    }

    public void GetJson(string key, string type)
    {
        int limit = string.IsNullOrEmpty(HttpContext.Current.Request["limit"]) ? 50 : Convert.ToInt32(HttpContext.Current.Request["limit"]);
        int start = string.IsNullOrEmpty(HttpContext.Current.Request["start"]) ? 0 : Convert.ToInt32(HttpContext.Current.Request["start"]);
        string content = string.Empty;
        DataTable dt = new DataTable("NewTable");
        int count = 0;
        try
        {       
            key = string.IsNullOrEmpty(key) ? "" : key.Replace("'", "");

            EnumerableRowCollection<DataRow> list ;

            if (HttpContext.Current.Request["option"].ToUpper() == "COMPANYLIST")
            {
                list = GetList().Tables[0].AsEnumerable().Where(p => p.Field<string>("value").StartsWith(key, true, null) || p.Field<string>("text").StartsWith(key, true, null));
            }
            else
            {
                list = GetList().Tables[0].AsEnumerable().Where(p => p.Field<string>("value").StartsWith(key, true, null));
            }
            
            count = list.Count();
            
            if (list.Count() != 0)
                dt = list.Skip(start).Take(limit).CopyToDataTable();
        }
        catch{    }
            
        finally
        {
            HttpContext.Current.Response.Write(string.Format("{{Total:{1},'table':{0}}}", JSON.Serialize(dt), count));
        }

    }

    
    public void GetCompanyName(string key, string type)
    {
        
        DataTable dt = new DataTable();
        int count = 0;
        try
        {
            //if (!string.IsNullOrEmpty(key))
            //{
                key = string.IsNullOrEmpty(key) ? "" : key.Replace("'", "");

                var list = GetList().Tables[0].AsEnumerable().Where(p => p.Field<string>("value").StartsWith(key, true, null));

                count = list.Count();

                if (list.Count() != 0)
                    dt = list.CopyToDataTable();
            //}
        }

        catch
        {
            
        }
        finally
        {
            HttpContext.Current.Response.Write(string.Format("{{Total:{1},'table':{0}}}", JSON.Serialize(dt), count));
        }

    }


    public string getTableName(string cmdText)
    {
        string TableName = string.Empty;
        switch (cmdText)
        {
            case "CompanyList":     //Company
                TableName = "cs_company";
                break;
            case "CompanyListByName":
                TableName = "cs_company";
                break;
            case "LocationList":      //Location
                TableName = "cs_location";
                break;
            case "SalesList":           //Sales
                TableName = "cs_sales";
                break;
            case "UnitBinding":     //Unit
                TableName = "cs_unit";
                break;
            case "ServerMode":     //ServerMode
                TableName = "cs_servicemode";
                break;
            case "ContainerSize":  //Container
                TableName = "cs_container";
                break;
            default:
                TableName = "cs_company";
                break;

        }
        return TableName;
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}