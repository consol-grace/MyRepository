<%@ WebHandler Language="C#" Class="SysCheckHBLNO" %>

using System;
using System.Web;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using Newtonsoft.Json;
using System.Data;


public class SysCheckHBLNO : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        List(context);
    }

    DataFactory dal = new DataFactory();

    public void List(HttpContext context)
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllSystem_CheckHBLNo_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","checkhbl").
                Append("HBLNo",context.Request["value"] ).
                Append("seed",string.IsNullOrEmpty(context.Request["seed"])?"0":context.Request["seed"]).
                Append("sys",context.Request["sys"] ).
                Append("stat",FSecurityHelper.CurrentUserDataGET()[12].ToString())
        }).GetTable();

        string content = "-1";
        if (dt != null && dt.Rows.Count > 0)
            content = dt.Rows[0][0].ToString();

        context.Response.Write(content);
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}