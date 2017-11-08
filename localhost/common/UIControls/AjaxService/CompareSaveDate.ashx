<%@ WebHandler Language="C#" Class="CompareSaveDate" %>

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

public class CompareSaveDate : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        CheckIsSave(context);
    }

    public void CheckIsSave(HttpContext context)
    {
        string sys = string.IsNullOrEmpty(context.Request["sys"]) ? "" : context.Request["sys"].ToUpper();
        string time = string.IsNullOrEmpty(context.Request["time"]) ? "" : context.Request["time"].ToString();
        
        if (LockDate.IsSave(sys, time))
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