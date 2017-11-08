using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;
using System.IO;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.DBLL;
using CrystalDecisions.CrystalReports.Engine;

/// <summary>
///VirtualPrint 的摘要说明
/// </summary>
public class Print1
{

    public Print1()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

        
    /// <summary>
    /// 虚拟打印
    /// </summary>
    /// <param name="GetNums">报表相关参数</param>
    /// <param name="GetMargin">打印机边距数组</param>
    /// <param name="printCount">打印份数</param>
    /// <param name="url">ref 虚拟打印生成的文件路径</param>
    /// <param name="printName">ref 打印机名称</param>
    /// <param name="fielParam">生成文件名的参数数组</param>
    /// <returns>实现打印并返回ReportDocument</returns>
    public ReportDocument VirtualPrint(string[] GetNums, double[] GetMargin, int printCount, ref string url,string folder, ref string printName, string[] fileParam)
    {

        ReportDocument doc = new ReportDocument();
        try
        {
            //string folder = Server.MapPath("PDF");

            string PaperSize = "";

            string fileName = GetfileName(ref PaperSize, fileParam);   // 获取 纸张类型  ，文件名称
            if (fileParam[0].ToLower() == "blsample" && Convert.ToInt32(GetNums[4]) > -1)
                fileName = fileName.Insert(fileName.LastIndexOf("_"), "_" + GetNums[4]);
            
            if (string.IsNullOrEmpty(fileName))
            {                
                return null;
            }

            GetPrintName(ref printName, PaperSize);         // 获取可用的打印机名称

            UpdatePrinterStatus(printName, 1,fileParam);              // 更新打印机状态

            //PrintImgSetting pis = new PrintImgSetting();    // 配置虚拟打印机 相关属性

            // 设置文件类型
            string ff = HttpContext.Current.Request["format"];
            int format = string.IsNullOrEmpty(ff) ? 4 : Convert.ToInt32(ff);

            //文件打印像素
            int size = 240;

            // 设置文件是否连续显示
            string cm = HttpContext.Current.Request["CreateMode"];
            int mode = string.IsNullOrEmpty(cm) ? 0 : Convert.ToInt32(cm);

            string randomFolder = "/PreviewTemp/" + (string.IsNullOrEmpty(folder) ? DateTime.Now.ToString("hhmmssffff") : folder);

            MoveFile mf = new MoveFile();
            mf.CreateDirectory(HttpContext.Current.Server.MapPath(randomFolder));

            //设置文件目录
            PrintImgSetting.PIS.SetFileFolder(printName, HttpContext.Current.Server.MapPath(randomFolder));
            Thread.Sleep(300);
            PrintImgSetting.PIS.SetFileName(printName, fileName);           //设置文件名称  
            Thread.Sleep(300);
            PrintImgSetting.PIS.SetFileFormat(printName, format);           //设置文件路径
            Thread.Sleep(300);
            PrintImgSetting.PIS.SetCreateMode(printName, mode);             //设置文件连续显示
            Thread.Sleep(300);

            doc = ToPrintPaper(GetNums, GetMargin, printCount, printName);  //实现打印功能     

            //打印机生成的文件路径
            url = randomFolder + "/" + fileName + "." + PrintImgSetting.PIS.FileFormat(format);

            Thread.Sleep(2000);                             // 等待打印文件读写            

            UpdatePrinterStatus(printName, 0,fileParam);              // 更新打印机状态

            return doc;
            //Setframe(url);

        }
        catch (Exception exp)
        {
            UpdatePrinterStatus(printName, 0,fileParam);              // 更新打印机状态
            return null;
            //HttpContext.Current.Response.Write(exp.Message);
            //HttpContext.Current.Response.Flush();
            //HttpContext.Current.Response.Close();
        }
    }

    /// <summary>
    ///  打印报表
    /// </summary>
    /// <param name="printName"></param>
    /// <param name="GetNums"></param>
    /// <param name="GetMargin"></param>
    /// <param name="printCount"></param>
    /// <returns>实现打印并返回ReportDocument</returns>
    public ReportDocument ToPrintPaper(string[] GetNums, double[] GetMargin, int printCount, string printName)
    {
        string[] nums = GetNums;
        nums[2] = printName;
        ReportDocument doc = ReportHelper.SetReportDoc(GetMargin[0], GetMargin[1], GetMargin[2], GetMargin[3], printCount, nums);
        return doc;
    }


    DataFactory dal = new DataFactory();


    /// <summary>
    /// 生成文件名
    /// </summary>
    /// <param name="PaperSize">纸张类型</param>
    /// <param name="type">报表类型</param>
    /// <param name="seed">seedID</param>
    /// <param name="code">公司Code</param>
    /// <param name="sys">系统</param>
    /// <returns>返回生成的文件名</returns>
    public string GetfileName(ref string PaperSize, string[] param)
    {
        string type = param[0];
        string seed = param[1];
        string code = param[2];
        string sys = param[3];
        string strName = "";

        // 执行 存储过程  返回 拼合的文件名 
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_VirtualPrinter_SP", new List<IFields>() { dal.CreateIFields().
                Append("option", "GetNo").
                Append("RepType",type).
                Append("sys",sys).
                Append("CO_Code",code).
                Append("seed",seed) }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            PaperSize = ds.Tables[0].Rows[0]["PaperSize"].ToString();
            strName = ds.Tables[0].Rows[0]["lotno"] + "_" + Replace(ds.Tables[0].Rows[0]["no"].ToString()) + "_" + ds.Tables[1].Rows[0]["type"] + ds.Tables[0].Rows[0]["seed"].ToString().Substring(ds.Tables[0].Rows[0]["seed"].ToString().Length-4);
            strName = strName.Replace("__", "_");
        }
        return strName.ToUpper();
    }


    /// <summary>
    /// 打印机列表
    /// </summary>
    /// <returns></returns>
    public DataSet GetList(string paperSize)
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_VirtualPrinter_SP", new List<IFields>() { dal.CreateIFields().
                     Append("option", "PrinterList").Append("PaperSize",paperSize) }).GetList();
        return ds;
    }


    /// <summary>
    /// 更新打印机状态
    /// </summary>
    /// <param name="printName"></param>
    public void UpdatePrinterStatus(string printName, int status, string[] param)
    {
        string description = "";
        if (status == 1)
            description = "当前打印机正在使用，使用者信息：" + FSecurityHelper.CurrentUserDataGET()[0] + "，" + FSecurityHelper.CurrentUserDataGET()[12] + "，报表类型：" +param[0] + "，SeedID :" + param[1];

        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_VirtualPrinter_SP", new List<IFields>() { dal.CreateIFields().
                Append("option", "UpdateStatus").
                Append("status",status).
                Append("printName",printName).
                Append("Description",description) }).Update();
    }


    /// <summary>
    /// 获取可用打印机列表
    /// </summary>
    /// <param name="printName"></param>
    public void GetPrintName(ref string printName, string paperSize)
    {
        int count = 0;
        printName = null;

        while (string.IsNullOrEmpty(printName))
        {
            if (count <= 10)
                Thread.Sleep(count * 100);
            else if (count > 10)
                Thread.Sleep(2000);

            DataSet ds = GetList(paperSize);

            //存在打印机 获取名称
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                printName = ds.Tables[0].Rows[0][0].ToString();
            }
            ++count;
        }
    }


    /// <summary>
    /// 动态设置Iframe路径
    /// </summary> 
    /// <param name="url">url</param>
    public void Setframe(string url)
    {
        string parm = url.Substring(0, url.LastIndexOf("/") + 1);
        string PdfPath = "";
        bool exist = true;
        DateTime dt1 = new DateTime();
        while (exist)
        {
            if (File.Exists(HttpContext.Current.Server.MapPath(url)))
            {
                bool b = true;
                int i = 0;
                while (string.IsNullOrEmpty(PdfPath) || b)
                {
                    MoveFile mf = new MoveFile("/Preview");
                    mf.DeleteFile(HttpContext.Current.Server.MapPath(url));
                    string path = mf.GetFilePath(HttpContext.Current.Server.MapPath(url)).Replace("\\", "/");
                    PdfPath = path;
                    FileInfo info = new FileInfo(HttpContext.Current.Server.MapPath(PdfPath));
                    if (info.Exists && info.Length > 1000)
                    {
                        b = false;
                        exist = false;
                    }
                    ++i;
                    Thread.Sleep(i * 100);
                }
            }
            else
            {
                TimeSpan ts = new DateTime() - dt1;
                if (ts.Minutes == 60)
                {
                    break;
                }
                exist = true;
                Thread.Sleep(3000);
            }
        }

        HttpContext.Current.Response.Write(PdfPath + "?datetime=" + parm);
    }


    /// <summary>
    /// 过滤字符串
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string Replace(string str)
    {
        string[] symbol = { "\\", "/", ":", "*", "?", "<", ">", "\"", "|", "+", ".", ".", "。", "，", ",", "：" };
        for (int i = 0; i < symbol.Length; ++i)
        {
            str = str.Replace(symbol[i], "");
        }
        return str;
    }

}