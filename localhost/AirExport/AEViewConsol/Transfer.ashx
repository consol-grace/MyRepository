<%@ WebHandler Language="C#" Class="Transfer" %>

using System;
using System.Web;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using System.Collections.Generic;
using DIYGENS.COM.FRAMEWORK;

public class Transfer : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string type = context.Request["type"];
        if (type == "transfer")
            Update(context);


    }
    DataFactory dal = new DataFactory();

    public void Update(HttpContext context)
    {
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysCreaterXML_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "transfer").
        Append("air_Exported", 1).
        Append("sys", context.Request["sys"]).
        Append("seed",context.Request["seed"])}).Update();
        context.Response.Write(b.ToString());
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}