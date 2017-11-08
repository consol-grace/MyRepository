<%@ WebHandler Language="C#" Class="gridHtml" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Ext.Net;
using System.Text;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Linq;
using Newtonsoft.Json;
using System.Web;
using System.IO;
using System.Threading;

public class gridHtml : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string type = string.IsNullOrEmpty(context.Request["type"]) ? "" : context.Request["type"].ToUpper();
        if (type == "COPY")
        {
            CopyInvoice(context);
        }
        else if (type == "OFFICAL")
        {
            OfficalInv(context);
        }
        else if (type == "HAWB")
        {
            ChangeHAWB(context);
        }
        else if (type == "CONTAINERLIST")
        {
            GetContainerList(context);
        }
        else if (type == "UPDATEGROUPBY")
        {
            UpdateGroupBy(context);
        }
        else if (type == "GETGROUPLIST")
        {
            GetGroupList(context);
        }
        else if (type == "GETCOSTGROUP")
        {
            GetCostGroup(context);
        }
        else if (type == "GETPAYMENT")
        {
            GetPayment(context);
        }
        else if (type == "LOCKCOST")
        {
            LockCost(context);
        }
        else if (type == "CHANGESUBMBL")
            ChangeSubMBL(context);
        else if (type == "ChkCtnrIsMain".ToUpper())
        {
            ChkCtnrIsMain(context);
        }
        else if (type == "LOG")
            Log(context);
    }

    DataFactory dal = new DataFactory();

    public void LockCost(HttpContext context)
    {

        string seed = context.Request["seed"];
        string sys = context.Request["sys"];
        bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallLockCost_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","LockCost")
            .Append("seed",seed)
            .Append("sys",sys)
        }).Update();
        if (flag)
        {
            context.Response.Write("Y");
        }
        else
        {
            context.Response.Write("N");
        }
    }
    
    public void GetPayment(HttpContext context)
    {

        string seed = context.Request["payseed"];
        string sys=context.Request["paysys"];
        string type=context.Request["paytype"];
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallPayment_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","GetPaymentList").
            Append("seed",seed).
            Append("Type",type).
            Append("Sys",sys)
        }).GetTable();
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);
    }
    
    public void GetCostGroup(HttpContext context)
    {

        string seed = context.Request["costgroupseed"];
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","GetCostTotal").
            Append("seed",seed)
        }).GetTable();
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);
    }
    
    public void GetGroupList(HttpContext context)
    {

        string seed = context.Request["grouplistseed"];
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOE_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","GetGroupList").
            Append("id",seed)
        }).GetTable();
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);
    }
    
    public void UpdateGroupBy(HttpContext context)
    {

        string seed = context.Request["groupseed"];
        string groupby=context.Request["groupvalue"];
        bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOE_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","UpdateGroupby")
            .Append("GroupBy",groupby)
            .Append("id",seed)
        }).Update();
        if (flag)
        {
            context.Response.Write("Y");
        }
        else
        {
           context.Response.Write("N");
        }
    }
    
    public void GetContainerList(HttpContext context)
    {

        string seed = context.Request["seed"];
        string cnno=context.Request["cnno"];
        string isvoid=context.Request["isvoid"];
        string sys=context.Request["sys"];
       
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetContainerList_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("mblseed",seed).
            Append("cnno",cnno).
            Append("sys",sys).
            Append("ShowVoid",isvoid)
        }).GetTable();
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);
    }

    public void ChkCtnrIsMain(HttpContext context)
    {
        string tombl = context.Request["tombl"];
        string rowid = context.Request["rowid"];
        string isMain =context.Request["ismain"];

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","UpdateIsMain").
            Append("oc_ToMBL",tombl).
            Append("oc_isMain",isMain).
            Append("oc_ROWID",rowid)
        }).GetTable();
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);        
    }
    
    public void CopyInvoice(HttpContext context)
    {

        string seed = context.Request["seed"];
        if (string.IsNullOrEmpty(seed))
        {
            context.Response.Write("N");
        }
        else
        {
            DataTable ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","copyinvoice").
                Append("inv_LotNo",seed)}).GetTable();
            if (ds != null && ds.Rows.Count > 0)
                context.Response.Write("Y");
            else
                context.Response.Write("N");
        }
        
    }

    
    public void OfficalInv(HttpContext context)
    {
        string seed = context.Request["seed"];
        if (string.IsNullOrEmpty(seed))
        {
            context.Response.Write("N");
        }
        else
        {
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","officalInv").
                Append("inv_seed",seed).
                Append("user",FSecurityHelper.CurrentUserDataGET()[0].ToString()).
                Append("offical",context.Request["offical"].ToUpper())}).Update();
            if (b)
                context.Response.Write("Y");
            else
                context.Response.Write("N");
        }   
    }


    public void ChangeHAWB(HttpContext context)
    {
        string seed = context.Request["seed"];
        if (string.IsNullOrEmpty(seed))
        {
            context.Response.Write("K");
        }
        else
        {
            string flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForAE_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","updateHAWB").                
                Append("id",seed).
                Append("stat",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("No",context.Request["hawbNo"].ToUpper())}).Rows[0].ToString();

            context.Response.Write(flag);
        }
    }

    /// <summary>
    /// Update subMBL no
    /// </summary>
    /// <param name="context"></param>
    public void ChangeSubMBL(HttpContext context)
    {
        bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","updateSubMBL").
                Append("subMBL",context.Request["subMBL"].Trim().ToUpper()).
                Append("seed", context.Request["seed"])}).Update();
        context.Response.Write(flag.ToString());
    }

    /// <summary>
    /// 写入日志
    /// </summary>
    /// <param name="msg">日志内容</param>
    public static void Log(HttpContext context)
    {
        string msg = context.Request["msg"].ToString();
        ControlBinder c = new ControlBinder();
        c.Log(msg);
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}