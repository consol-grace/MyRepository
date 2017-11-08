<%@ WebHandler Language="C#" Class="SheetList" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using Newtonsoft.Json;

public class SheetList : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string type = string.IsNullOrEmpty(context.Request["type"]) ? "" : context.Request["type"].ToLower();
        if (type == "list")
            List(context);
    }

    
    DataFactory dal = new DataFactory();

    
    public void List(HttpContext context)
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_VerifyVouch_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","filter").
                Append("vv_VerifyNo",context.Request["sheetNo"] ).
                Append("M",context.Request["MBL"] ).
                Append("stat",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("status",context.Request["Status"])                
        }).GetTable();
        
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content); 
    }
    
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}