<%@ WebHandler Language="C#" Class="DataController" %>

using System;
using System.Web;
using System.Data;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using System.Collections.Generic;
using DIYGENS.COM.FRAMEWORK;

public class DataController : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
    
        CheckedLis(context);
    }
    
    DataFactory dal = new DataFactory();
    
    public void CheckedLis(HttpContext context)
    {
        string isCheck = context.Request["IsCheck"];
        string seedKey = context.Request["SeedKey"];
        string IsCheckAll = context.Request["IsCheckAll"] == "" ? "CheckboxClick" : "CheckedAll";

        DataTable dt = null;
        if (IsCheckAll == "CheckboxClick")//单独的checkbox打勾
        {
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_PRINTERCopy_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "CheckboxClick")
             .Append("IsCheck",isCheck)
             .Append("SeedKey",seedKey)
            }).GetTable();
        }
        else //全选
        {
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_PRINTERCopy_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "CheckedAll")
             .Append("IsCheck",isCheck)
             .Append("AllSeedKey",seedKey)
            }).GetTable();
        }

        if (dt == null || dt.Rows[0][0] == "")
        {
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("N"));
        }
        else
        {
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject("Y"));
        }
          
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}