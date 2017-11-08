<%@ WebHandler Language="C#" Class="DataHandler" %>

using System;
using System.Web;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;
using System.Text;
using System.Linq;

public class DataHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        getList(context);
    }


    DataFactory dal = new DataFactory();
    public void getList(HttpContext context)
    {
        string content = string.Empty;
        // context.Cache[context.Request["sys"] + "_" + context.Request["action"]] as DataSet
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields( ).
                Append("Option", context.Request["action"]).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("dept", FSecurityHelper.CurrentUserDataGET()[28]).
                Append("SYS",context.Request["sys"])}).GetList();

        string key = (string.IsNullOrEmpty(context.Request["key"]) ? "" : context.Request["key"].ToUpper()).TrimEnd();

        var list = (from p in ds.Tables[0].AsEnumerable() where p.Field<string>("value").TrimEnd() == key && !string.IsNullOrEmpty(key) select p).AsDataView().ToTable();

        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(list));


    }



    public string getItemList()
    {
        string content = string.Empty;
        return content;
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}