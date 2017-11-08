<%@ WebHandler Language="C#" Class="AllShipmentData" %>

using System;
using System.Web;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;
using Ext.Net;
using System.IO;

public class AllShipmentData : IHttpHandler {
    DataFactory dal = new DataFactory();
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        GetData(context);
    }

    public void GetData(HttpContext context)
    {
       
        //string userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
        string sys = GetSys();
        string allNo = string.IsNullOrEmpty(context.Request["allNo"]) ? "" : context.Request["allNo"].ToUpper();
        string chkAll = string.IsNullOrEmpty(context.Request["chkAll"]) ? "" : context.Request["chkAll"];
        string chkLot = string.IsNullOrEmpty(context.Request["chkLot"]) ? "" : context.Request["chkLot"];
        string chkMaster = string.IsNullOrEmpty(context.Request["chkMaster"]) ? "" : context.Request["chkMaster"];
        string chkHouse = string.IsNullOrEmpty(context.Request["chkHouse"]) ? "" : context.Request["chkHouse"];
        string chkInvoice = string.IsNullOrEmpty(context.Request["chkInvoice"]) ? "" : context.Request["chkInvoice"];
        string chkCtnr = string.IsNullOrEmpty(context.Request["chkCtnr"]) ? "" : context.Request["chkCtnr"];

        string whereStr = "1=0";
        if (chkAll == "chkAll")
        {
            whereStr += " or lotno like '" + allNo + "%' or masterNo like '" + allNo + "%' or houseNo like '" + allNo + "%' or invoiceNo like '" + allNo + "%' or ctnrNo like '" + allNo + "%'";
        }
      
        if (chkLot == "chkLot")
        {
            whereStr += " or lotno like '" + allNo + "%'";
        }
        
        if (chkMaster == "chkMaster")
        {
            whereStr += " or masterNo like '" + allNo + "%'";
        }
        
        if (chkHouse == "chkHouse")
        {
            whereStr += " or houseNo like '" + allNo + "%'";
        }
        
        if (chkInvoice == "chkInvoice")
        {
            whereStr += " or invoiceNo like '" + allNo + "%'";
        }
        
        if (chkCtnr == "chkCtnr")
        {
            whereStr += " or ctnrNo like '" + allNo + "%'";
        }
        
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllShipment_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
             .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
             .Append("SYS", sys) 
             .Append("WhereStr", whereStr)
        }).GetTable();

        string content = Newtonsoft.Json.JsonConvert.SerializeObject(dt, new Newtonsoft.Json.Converters.DataTableConverter());
        context.Response.Write(content);

        //if (dt != null)
        //{
        //    storeList.DataSource = dt;
        //    storeList.DataBind();
        //}
    }
    
    private string GetSys()
    {
        string MenuList = MenuHelper.GetMenu("MenuList");  // FSecurityHelper.CurrentUserDataGET()[14]; // menu array list
        string str = "";
        string sys = "";
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "user-get-menu")
            .Append("IDlist", MenuList)
        }).GetList();

        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            str += ds.Tables[0].Rows[i]["NameENG"].ToString() + ",";
        }

        str = str.Trim().ToUpper();

        if (str.IndexOf("AIR EXPORT") != -1)
        {
            sys += "'AE',";
        }

        if (str.IndexOf("AIR IMPORT") != -1)
        {
            sys += "'AI',";
        }

        if (str.IndexOf("OCEAN EXPORT") != -1)
        {
            sys += "'OE',";
        }

        if (str.IndexOf("OCEAN IMPORT") != -1)
        {
            sys += "'OI',";
        }

        if (str.IndexOf("TRIANGLE") != -1)
        {
            sys += "'AT','OT',";
        }

        if (str.IndexOf("OTHER BUSINESS") != -1)
        {
            sys += "'DM','BK','TK',";
        }

        if (sys != "")
        {
            sys = sys.Substring(0, sys.Length - 1);
        }

        return sys;
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}