<%@ WebHandler Language="C#" Class="ViewReport" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using System.Threading;
using System.IO;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.DBLL;
using System.Web.SessionState;


public class ViewReport : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "text/plain";
        context.Response.CacheControl = "no-cache";

        string nums = context.Request["nums"];
        GetNums = (string[])Newtonsoft.Json.JsonConvert.DeserializeObject(nums, Type.GetType("System.String[]"));
        string margin = context.Request["margin"];
        GetMargin = (double[])Newtonsoft.Json.JsonConvert.DeserializeObject(margin, Type.GetType("System.Double[]"));

        Binder();

    }

    public string[] GetNums = null;     // 报表参数
    public double[] GetMargin = null;   // 报表间距
    public int printCount = 1;          // 打印份数


    public void Binder()
    {
        string reportType = HttpContext.Current.Request["type"];
        string seed = HttpContext.Current.Request["ID"];
        string code = HttpContext.Current.Request["Company"];
        string sys = HttpContext.Current.Request["sys"];

        Print print = new Print();
        string url = "", printName = "";
        string[] fileParam = { reportType, seed, code, sys };

        string format = HttpContext.Current.Request["format"];
        if (format == "7")
        {
            string[] nums = GetNums;
            nums[1] = "N";
            string PaperSize = "";

            string fileName = print.GetfileName(ref PaperSize, fileParam);   // 获取 纸张类型  ，文件名称
            if (fileParam[0].ToLower() == "blsample" && Convert.ToInt32(GetNums[4]) > -1)
                fileName = fileName.Insert(fileName.LastIndexOf("_"), "_" + GetNums[4]);

            url = "/UploadFile/ReportFileTemp/" + DateTime.Now.ToString("yyyyMM");
            ReportHelper.ExportRepFile(fileName + ".pdf", false, GetMargin[0], GetMargin[1], GetMargin[2], GetMargin[3], nums);
            HttpContext.Current.Response.Write(url + "/" + fileName + ".pdf?datetime=null");
        }
        else
        {
            ReportDocument rdoc = print.VirtualPrint(GetNums, GetMargin, printCount, ref url, "", ref printName, fileParam);

            if (rdoc != null && rdoc.HasSavedData) { print.Setframe(url); }
            else { HttpContext.Current.Response.Write("/common/uicontrols/error.gif?datetime=" + DateTime.Now.ToString("yyyyMMddhhmmssfff")); }
        }
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
