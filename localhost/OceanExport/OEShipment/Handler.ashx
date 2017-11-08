<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;


public class Handler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        Valid(context.Request["oldname"], context.Request["name"], context.Request["id"]);
    }

    public void Valid(string oldname, string name, string id)
    {
        string flag = "N";

        flag = OEHandler.ValidHBL(oldname, name, id);

        HttpContext.Current.Response.Write(flag);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}