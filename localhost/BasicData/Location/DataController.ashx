<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;

public class Handler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.AddHeader("pragma", "no-cache");
        HttpContext.Current.Response.AddHeader("cache-control", "private");
        HttpContext.Current.Response.CacheControl = "no-cache";

        Valid(context.Request["sys"], context.Request["name"], context.Request["id"]);
    }

   
   public void Valid(string sys, string name,string id)
    {
        string flag = "N";

        try
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Location_SP", new List<IFields>() { dal.CreateIFields().Append("Option","ValidLocation").Append("SYS", sys)
                 .Append("CODE",name).Append("ID",id)}).GetList();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                flag = ds.Tables[0].Rows[0][0].ToString();
            }
        }
        catch
        {
            flag = "Y";
        }

        HttpContext.Current.Response.Write(flag);
    }

 
    public bool IsReusable {
        get {
            return false;
        }
    }

}