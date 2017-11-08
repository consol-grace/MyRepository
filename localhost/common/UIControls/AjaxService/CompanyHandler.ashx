<%@ WebHandler Language="C#" Class="CompanyHandler" %>

using System;
using System.Web;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;
using System.Text;
using System.Linq;

public class CompanyHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string option=string.IsNullOrEmpty(context.Request["option"]) ? "" : context.Request["option"].ToUpper();
        if (option == "COMPANYSEARCHALL")
        {
            getAllList(context);
        }
        else
        {
            getList(context);
        }
    }


    DataFactory dal = new DataFactory();
    public void getList(HttpContext context)
    {
        string type = string.IsNullOrEmpty(context.Request["type"]) ? "" : context.Request["type"].ToUpper();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields( ).
                Append("Option","CompanySearch").
                Append("TYPE",type).
                Append("CODE",context.Request["code"])}).GetTable();
        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(dt));
    }

    public void getAllList(HttpContext context)
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields( ).
                Append("Option","CompanySearchAll").
                Append("CODE",context.Request["code"])}).GetTable();
        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(dt));
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}