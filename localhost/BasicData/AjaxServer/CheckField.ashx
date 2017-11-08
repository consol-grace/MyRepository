<%@ WebHandler Language="C#" Class="CheckField" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;

public class CheckField : IHttpHandler
{
    public string desCode;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.AddHeader("pragma", "no-cache");
        HttpContext.Current.Response.AddHeader("cache-control", "private");
        HttpContext.Current.Response.CacheControl = "no-cache";

        if (context.Request["type"] == "ITEMDESC")
        {
            desCode = context.Request["desCode"];
        }
        
        CheckCode(context.Request["type"], context.Request["code"], context.Request["sys"], context.Request["rowid"]);

    }

    //修改时间2014-09-20 Grace
    public void CheckCode(string type, string code, string sys, string rowid)
    {
        string flag = "N";

        try
        {
            if (string.IsNullOrEmpty(code))
            {
                flag = "N";
            }
            else if (type == "ITEMDESC")
            {
                flag = BaseCheckCode.CheckIsExist(type, code, sys, rowid, desCode);
            }
            else
            {
                flag = BaseCheckCode.CheckIsExist(type, code, sys, rowid);
            }
        }
        catch
        {
            flag = "N";
        }

        HttpContext.Current.Response.Write(flag);
    }



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}