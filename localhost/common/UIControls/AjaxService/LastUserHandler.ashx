<%@ WebHandler Language="C#" Class="LastUserHandler" %>

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
using Ext.Net;

public class LastUserHandler : IHttpHandler {
    
    DataFactory dal = new DataFactory();
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        GetUser(context);
    }

    public void GetUser(HttpContext context)
    {
        string seed = string.IsNullOrEmpty(context.Request["seed"]) ? "" : context.Request["seed"].ToUpper();
        string id = string.IsNullOrEmpty(context.Request["id"]) ? "" : context.Request["id"].ToUpper();

        if (seed != "" || id != "")
        {
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BindUSER_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields()
                .Append("Seed",seed)
                .Append("ID",id)}).GetTable();

            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(dt));
        }
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}