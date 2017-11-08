<%@ WebHandler Language="C#" Class="CompareLockDate" %>

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

public class CompareLockDate : IHttpHandler {

    DataFactory dal = new DataFactory();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        CheckIsLock(context);
    }

    public void CheckIsLock(HttpContext context)
    {
        string seed = string.IsNullOrEmpty(context.Request["seed"]) ? "" : context.Request["seed"].ToUpper();
        string id = string.IsNullOrEmpty(context.Request["id"]) ? "" : context.Request["id"].ToUpper();
        if(LockDate.IsLock(seed, id))
        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("true"));
        else
        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("false"));
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}