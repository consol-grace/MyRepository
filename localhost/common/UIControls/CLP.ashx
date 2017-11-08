<%@ WebHandler Language="C#" Class="CLP" %>

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
using System.Collections.Generic;
using System.Text.RegularExpressions;

public class CLP : IHttpHandler
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
        else if (type == "hbllist")
            HblList(context);
        else if (type == "updatelist")
            Updatelist(context);
    }


    public void list(HttpContext context)
    {
        string seed = context.Request["seed"];
        string cntrNo = context.Request["CntrNo"];
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_CLP_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","list").
                Append("vv_CntrNo",cntrNo).
                Append("M",seed )}).GetTable();
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);

    }


    public void Update(HttpContext context)
    {
        //vv_SYS,vv_STAT,vv_Seed,vv_ToHouse,vv_ToMaster,vv_VerifyNo,vv_Piece, vv_IsReceived,vv_ReceivedDate,vv_User
        string isrec = "0";
        object recDate = context.Request["rec"];
        if (!string.IsNullOrEmpty(recDate.ToString()))
        {
            isrec = "1";
            recDate = Convert.ToDateTime(recDate).ToString("yyyy-MM-dd");
        }
        else
        {
            recDate = DBNull.Value;
        }
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_CLP_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","Insert").
                Append("vv_CntrNo",context.Request["CntrNo"]).
                Append("vv_SYS",FSecurityHelper.CurrentUserDataGET()[11]).
                Append("vv_STAT",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("vv_Seed",context.Request["tombl"]).
                Append("vv_ToMaster",context.Request["tombl"]).
                Append("vv_VerifyNo",context.Request["subMBL"].ToUpper()).
                Append("vv_Piece",string.IsNullOrEmpty(context.Request["pkg"])?DBNull.Value:(object)context.Request["pkg"]).
                Append("vv_gwt",string.IsNullOrEmpty(context.Request["gwt"])?DBNull.Value:(object)context.Request["gwt"]).
                Append("vv_cbm",string.IsNullOrEmpty(context.Request["cbm"])?DBNull.Value:(object)context.Request["cbm"]).
                Append("vv_require",context.Request["req"].ToUpper()).
                Append("vv_factory",context.Request["goods"].ToUpper()).
                Append("vv_hbl",context.Request["hbl"].ToUpper()).
                Append("vv_User",FSecurityHelper.CurrentUserDataGET()[0]).
                Append("vv_IsReceived",isrec).
                Append("vv_ReceivedDate",recDate).
                Append("rowid", context.Request["rowid"] )}).Update();
        if (b)
            context.Response.Write("Y");
        else
            context.Response.Write("N");

    }

    public void CheckReceive(HttpContext context)
    {
        string rowid = context.Request["rowid"];
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_CLP_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","CheckReceived").
                Append("status",context.Request["status"]).
                Append("rowid", rowid )}).Update();
        if (b)
            context.Response.Write(DateTime.Now.ToString("dd\\/MM\\/yyyy"));
        else
            context.Response.Write("N");
    }

    public void Delete(HttpContext context)
    {
        string rowid = context.Request["rowid"];
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_CLP_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","Delete").                
                Append("rowid", rowid )}).Update();
        if (b)
            context.Response.Write("Y");
        else
            context.Response.Write("N");

    }

    public void HblList(HttpContext context)
    {
        string seed = context.Request["seed"];
        string cntrNo = context.Request["CntrNo"];
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_CLP_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                Append("Option","getListHbl").
                Append("vv_CntrNo",cntrNo).
                Append("M",seed )}).GetTable();
        string content = JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);
    }


    public void Updatelist(HttpContext context)
    {
        string strContent =  context.Request["content"];

        List<IFields> list = new List<IFields>();
        System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        var dic = jss.Deserialize<List<vv_CLP>>(strContent);

        foreach (vv_CLP values in dic)
        {
            string isrec = "0";
            object recDate = values.vv_ReceivedDate;
            if (!string.IsNullOrEmpty(recDate.ToString()))
            {
                isrec = "1";
                recDate = Convert.ToDateTime(recDate).ToString("yyyy-MM-dd");
            }
            else
            {
                recDate = DBNull.Value;
            }
            list.Add(dal.CreateIFields().
                Append("Option", "Insert").
                Append("vv_CntrNo", values.vv_CntrNo.ToString().ToUpper()).
                Append("vv_SYS", FSecurityHelper.CurrentUserDataGET()[11]).
                Append("vv_STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("vv_Seed", values.vv_ToMaster).
                Append("vv_ToMaster", values.vv_ToMaster).
                Append("vv_VerifyNo", values.vv_VerifyNo.ToString().ToUpper()).
                Append("vv_Piece", string.IsNullOrEmpty(values.vv_Piece.ToString()) ? DBNull.Value : values.vv_Piece).
                Append("vv_gwt", string.IsNullOrEmpty(values.vv_gwt.ToString()) ? DBNull.Value : values.vv_gwt).
                Append("vv_cbm", string.IsNullOrEmpty(values.vv_cbm.ToString()) ? DBNull.Value : values.vv_cbm).
                Append("vv_require", values.vv_require.ToString().ToUpper()).
                Append("vv_factory", values.vv_factory.ToString().ToUpper()).
                Append("vv_hbl", values.vv_hbl.ToString().ToUpper()).
                Append("vv_User", FSecurityHelper.CurrentUserDataGET()[0]).
                Append("vv_isMain",values.vv_isMain).
                Append("vv_IsReceived", isrec).
                Append("status",values.status).
                Append("vv_ReceivedDate", recDate).
                Append("vv_DeclarationNo", values.vv_DirationNo.ToString().ToUpper()).
                Append("vv_ExpressNo", values.vv_ExpressNo.ToString().ToUpper()).
                Append("vv_Remark", values.vv_Remark.ToString().ToUpper()).
                Append("rowid", values.vv_rowid));
        }

        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_CLP_SP", list).Update();

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

