<%@ WebHandler Language="C#" Class="ViewReport_Tools" %>
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


public class ViewReport_Tools : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.CacheControl = "no-cache";
        if (context.Request["option"] == "getpagesize")
            GetPageSize();
        if (context.Request["option"] == "move")
            Move();
    }


    /// <summary>
    /// 获取相关文件个数
    /// </summary>
    public void GetPageSize()
    {
        //string url = "/AAA/SZXOE1208001/MANIFEST-SZX1206001-CTNR0025202-291121.pdf?ddddd"; //HttpContext.Current.Request["filepath"];  //移动后的地址
        string url = HttpContext.Current.Request["filepath"];  //移动后的地址
        url = url.Substring(0, url.LastIndexOf("?"));
        MoveFile mf = new MoveFile();
        
        string[] str = mf.GetFilelist(url);
        HttpContext.Current.Response.Write(str.Length.ToString());
    }

    /// <summary>
    /// 移动所有匹配文件
    /// </summary>
    public void Move()
    {
        //PDF/HKGOE1212001_INVOICE--291516.PDF?datetime=2013013101
        ///Preview/SZXOE1301001/SZXOE1301001_SZMAN1301001_INV 8975.GIF?datetime=/PreviewTemp/0423405400/
        string url = HttpContext.Current.Request["filepath"];  //移动后的地址
        if (url.Contains("error.gif")) { HttpContext.Current.Response.Write("1"); return; }
        string parm = url.Substring(url.LastIndexOf("=") + 1);
        url = url.Substring(0, url.LastIndexOf("?"));
        string[] s = url.Split(new string[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
        //url = parm + s[1] + "_" + s[2];  //文件原始地址;
        url = parm + s[2];  //文件原始地址;
        if (!File.Exists(HttpContext.Current.Server.MapPath(url.Insert(url.LastIndexOf("."),"2"))))
            url = parm + s[2].Remove(12, 1);
        int length = 2;
        int page = 1;
        while (length > 0)
        {

            MoveFile mf = new MoveFile();
            mf.NewFolder = "/Preview";
            //string[] str = mf.GetFilelist(url);
            //length = str.Length;

            string PdfPath = "", strpath = "";
            strpath = HttpContext.Current.Server.MapPath(url.Insert(url.LastIndexOf("."), length.ToString()));
            
            if (File.Exists(strpath))
            {
                bool b = true;
                while (string.IsNullOrEmpty(PdfPath) || b)
                {
                    string path = mf.GetFilePath(strpath).Replace("\\", "/");
                    PdfPath = path;
                    FileInfo info = new FileInfo(HttpContext.Current.Server.MapPath(PdfPath));
                    if (info.Exists && info.Length > 1000)
                        b = false;
                }
                ++length;
                ++page;
            }
            else
            {
                Thread.Sleep(1000);
                if (!File.Exists(strpath))
                {
                    if (Directory.Exists(HttpContext.Current.Server.MapPath(parm)))
                    {
                        Directory.Delete(HttpContext.Current.Server.MapPath(parm), true);
                    }
                    length = 0;
                }
            }
        }
        HttpContext.Current.Response.Write(page.ToString());

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}