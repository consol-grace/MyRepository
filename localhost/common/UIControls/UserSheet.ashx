<%@ WebHandler Language="C#" Class="UserSheet" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using Newtonsoft.Json;


public class UserSheet : IHttpHandler
{


    DataFactory dal = new DataFactory();


    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string type = string.IsNullOrEmpty(context.Request["type"]) ? "" : context.Request["type"].ToLower();
        if (type == "list")
            list(context);
        else if (type == "checkreceive")
            CheckReceive(context);
        else if (type == "update")
            Update(context);
        else if (type == "delete")
            Delete(context);
    }


    public void list(HttpContext context)
    {
        string seed = context.Request["seed"];
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_VerifyVouch_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","list").
                Append("vv_Seed",seed )}).GetTable();
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);

    }


    public void Update(HttpContext context)
    {
        //vv_SYS,vv_STAT,vv_Seed,vv_ToHouse,vv_ToMaster,vv_VerifyNo,vv_Piece, vv_IsReceived,vv_ReceivedDate,vv_User
        string rowid = context.Request["rowid"];
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_VerifyVouch_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","Insert").
                Append("vv_SYS",string.IsNullOrEmpty(context.Request["sysType"])?FSecurityHelper.CurrentUserDataGET()[11]:context.Request["sysType"]).
                Append("vv_STAT",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("vv_Seed",context.Request["seed"]).
                Append("vv_ToHouse",context.Request["H"]).
                Append("vv_ToMaster",context.Request["M"]).
                Append("vv_VerifyNo",context.Request["SheetNo"].ToUpper()).
                Append("vv_Piece",context.Request["Pkg"]).
                Append("vv_IsReceived",context.Request["received"]).
                Append("vv_ReceivedDate",string.IsNullOrEmpty(context.Request["recedate"])?null: ControlBinder.getDate(context.Request["recedate"])).
                Append("vv_User",FSecurityHelper.CurrentUserDataGET()[0]).
                Append("rowid", rowid )}).Update();
        if (b)
            context.Response.Write("Y");
        else
            context.Response.Write("N");

    }

    public void CheckReceive(HttpContext context)
    {
        string rowid = context.Request["rowid"];
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_VerifyVouch_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","CheckReceived").
                Append("vv_Piece",context.Request["Pkg"]).
                Append("vv_VerifyNo",context.Request["SheetNo"].ToUpper()).
                Append("rowid", rowid )}).Update();
        if (b)
            context.Response.Write(DateTime.Now.ToString("dd\\/MM\\/yyyy"));
        else
            context.Response.Write("N");
    }

    public void Delete(HttpContext context)
    {
        string rowid = context.Request["rowid"];
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_VerifyVouch_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","Delete").                
                Append("rowid", rowid )}).Update();
        if (b)
            context.Response.Write("Y");
        else
            context.Response.Write("N");

    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}