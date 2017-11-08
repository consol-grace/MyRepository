<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using System.Collections.Generic;
using DIYGENS.COM.FRAMEWORK;

public class Handler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        UpdateStationCompany(context);
    }

    public void UpdateStationCompany(HttpContext context)
    {
        string rowid = context.Request["rowid"];
        string station = context.Request["station"];
        string flag = context.Request["flag"];
        string dept = FSecurityHelper.CurrentUserDataGET()[28];
        
        DataFactory dal = new DataFactory();
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() { dal.CreateIFields()
                  .Append("Option", "UpdateStatCompany")
                  .Append("rowid", rowid)
                  .Append("active", flag)
                  .Append("dept", dept)
                  .Append("stat", station) }).Update();
        context.Response.Write(b ? "Y" : "N");

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}