<%@ WebHandler Language="C#" Class="FnManageHandler" %>

using System;
using System.Web;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;
using System.Text;
using System.Linq;

public class FnManageHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string type = string.IsNullOrEmpty(context.Request["type"]) ? "" : context.Request["type"];
        if (type == "isExistName")
        {
            IsExistName(context);
        }
        else
        {
            getList(context);
        }
    }

    DataFactory dal = new DataFactory();
    
    public void getList(HttpContext context)
    {
        string NameOrSeed = string.IsNullOrEmpty(context.Request["NameOrSeed"]) ? "" : context.Request["NameOrSeed"];
        string sys = string.IsNullOrEmpty(context.Request["sys"]) ? "" : context.Request["sys"].ToUpper();
        
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_FunctionManage_SP", new List<IFields>() { dal.CreateIFields( ).
                Append("Option","getFunction").
                Append("Sys",sys).
                Append("Stat",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("User",FSecurityHelper.CurrentUserDataGET()[0]).
                Append("NameOrSeed",NameOrSeed)}).GetTable();

        if (dt != null && dt.Rows.Count > 0)
        {
            if (dt.Rows[0][0].ToString() == "Y")
            {
                context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("true"));
            }
            else
            {
                context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("false"));
            }
        }
        else
        {
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("false"));
        }
    
    }

    public void IsExistName(HttpContext context)
    {
        string name = string.IsNullOrEmpty(context.Request["name"]) ? "" : context.Request["name"].ToUpper();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_FunctionManage_SP", new List<IFields>() { dal.CreateIFields( ).
                Append("Option","isExistName").
                Append("Name",name)}).GetTable();

        if (dt != null && dt.Rows.Count > 0)
        {
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("true"));
        }
        else
        {
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("false")); 
        }
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}