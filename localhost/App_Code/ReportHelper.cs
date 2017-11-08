using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Text;
using System.IO;


/// <summary>
///ReportHelper 的摘要说明
/// </summary>
public class ReportHelper
{
    public ReportHelper()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }
    #region Report examples  Author ：hcy   (2011-09-19)
    /*
     * 直接打印
     * string[] nums = new String[5];
        nums[0] = Server.MapPath("~/Report/ReportFile/test.rpt"); //报表路径
        nums[1] = "Y";  //是否打印
        nums[2] = "Konica IP-432 PCL6 CHT"; //打印机名称
        nums[3] = "test"; //参数
        nums[4] = "";     //参数
        ReportHelper.SetReportDoc(nums);
    */
    /*
     * 报表预览
     * string[] nums = new String[5];
        nums[0] = Server.MapPath("~/Report/ReportFile/test.rpt"); //报表路径
        nums[1] = "N";  //是否打印
        nums[2] = "Konica IP-432 PCL6 CHT"; //打印机名称
        nums[3] = "test"; //参数
        nums[4] = "";     //参数
        CrystalDecisions.CrystalReports.Engine.ReportDocument doc = ReportHelper.SetReportDoc(nums);
        CrystalReportViewer1.ReportSource = doc;
        CrystalReportViewer1.DataBind();
    */
    /*
    * 报表导出
    * string[] nums = new String[5];
       nums[0] = Server.MapPath("~/Report/ReportFile/test.rpt"); //报表路径
       nums[1] = "N";  //是否打印
       nums[2] = "Konica IP-432 PCL6 CHT"; //打印机名称
       nums[3] = "test"; //参数
       nums[4] = "";     //参数
       ReportHelper.ExportRepFile("test.pdf", nums); //第一种方式：导出，不保存在服务器
       ReportHelper.ExportRepFile("test.pdf",true/false ,nums); //第二种方式：导出，保存在服务器，ViewFlag 是否预览
       ReportHelper.ExportRepFile("test.pdf","test/",true/false ,nums); //第三种方式：导出，保存在服务器，ViewFlag 是否预览,url 自定义文件路径
   */
    #endregion

    #region 定义连接报表服务参数   Author ：hcy   (2011-09-14)
    public class ConReportServer
    {
        public readonly static string RServer = "192.168.1.3"; 
        public readonly static string RUserid = "consol";
        public readonly static string RPassword ="B2e5n14-";
        public readonly static string RDataBase = "USGROUP_OPERATION_TEST";  //"USGROUP";
    }
    #endregion

    #region SetReportServer()   Author ：hcy   (2011-09-14)
    public  static TableLogOnInfo LoginInfo()
    {
        TableLogOnInfo LoginInfo = new TableLogOnInfo(); 

        LoginInfo.ConnectionInfo.ServerName = ConReportServer.RServer; //ConfigurationManager.AppSettings["RServer"];
        LoginInfo.ConnectionInfo.DatabaseName = ConReportServer.RDataBase; //ConfigurationManager.AppSettings["RDataBase"];
        LoginInfo.ConnectionInfo.UserID = ConReportServer.RUserid; //ConfigurationManager.AppSettings["RUserid"];
        LoginInfo.ConnectionInfo.Password = ConReportServer.RPassword; //ConfigurationManager.AppSettings["RPassword"];

        return LoginInfo; 
    }
    #endregion

    #region SetReportDoc(nums[0]=报表路径 num[1]=是否打印(Y,N) num[2]=打印机名称 num[>=3]=数据参数)   Author ：hcy   (2011-09-15)
    public static ReportDocument SetReportDoc(params string[] nums)
    {
        ReportDocument doc = new ReportDocument();
        try 
        {
            string ReportPath = nums[0].ToString();
            doc.Load(ReportPath);
            for (int i =3; i < nums.Length; i++)
            {
                string paramValue = nums[i].ToString();
                ParameterDiscreteValue pdv = new ParameterDiscreteValue();
                pdv.Value = paramValue;
                ParameterValues pv = new ParameterValues();
                pv.Add(pdv);
                doc.DataDefinition.ParameterFields[i - 3].ApplyCurrentValues(pv);
            }
            if (doc.Database.Tables.Count > 0)
            {
                //for (int i = 0; i < doc.Database.Tables.Count; i++)
                //{
                //    doc.Database.Tables[i].ApplyLogOnInfo(LoginInfo());
                //}
                doc.Database.Tables[0].ApplyLogOnInfo(LoginInfo());
            }

            //Sections sections = doc.ReportDefinition.Sections;
            //foreach (Section section in sections)
            //{
            //    ReportObjects reportObjects = section.ReportObjects;
            //    foreach (ReportObject reportObject in reportObjects)
            //    {
            //        if (reportObject.Kind == ReportObjectKind.SubreportObject)
            //        {
            //            SubreportObject subreportObject = (SubreportObject)reportObject;
            //            ReportDocument subReportDocument = subreportObject.OpenSubreport(subreportObject.SubreportName);
            //            if (subReportDocument.Database.Tables.Count > 0)
            //            {
            //                for (int i = 0; i < subReportDocument.Database.Tables.Count; i++)
            //                {
            //                    subReportDocument.Database.Tables[i].ApplyLogOnInfo(LoginInfo());
            //                }
            //                //subReportDocument.Database.Tables[0].ApplyLogOnInfo(LoginInfo());
            //            }
            //        }
            //    }
            //}

            if (nums[1].ToString().StartsWith ("Y"))
            {
                //打印机名字
                doc.PrintOptions.PrinterName = nums[2].ToString();

                //设置打印边距
                //PageMargins margins;
                //margins = doc.PrintOptions.PageMargins;
                //margins.topMargin = 240; //567
                //margins.leftMargin = 240;
                //margins.rightMargin = 240;
                //margins.bottomMargin = 240;
                //doc.PrintOptions.ApplyPageMargins(margins);

                if (nums[1].ToString() == "Y1")
                {
                    doc.PrintOptions.PaperSize = PaperSize.PaperA4;
                }
                //else
                //{
                //    doc.PrintOptions.PaperOrientation = PaperOrientation.DefaultPaperOrientation;
                //    doc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize;
                //}

                //打印份数，是否逐份打印,打印第一页，最后一页
                doc.PrintToPrinter(1, false, 0, 0);
            }
        }
        catch
        {
           
        }
        return doc;
    }
    #endregion

    #region SetReportDoc(nums[0]=报表路径 num[1]=是否打印(Y,N) num[2]=打印机名称 num[>=3]=数据参数)   Author ：hcy   (2011-09-15)
    public static ReportDocument SetReportDoc(double top, double bottom, double left, double right, params string[] nums)
    {
        ReportDocument doc = new ReportDocument();
        try
        {
            string ReportPath = nums[0].ToString();
            doc.Load(ReportPath);

            for (int i = 3; i < nums.Length; i++)
            {
                string paramValue = nums[i].ToString();
                ParameterDiscreteValue pdv = new ParameterDiscreteValue();
                pdv.Value = paramValue;
                ParameterValues pv = new ParameterValues();
                pv.Add(pdv);
                doc.DataDefinition.ParameterFields[i - 3].ApplyCurrentValues(pv);
            }
            if (doc.Database.Tables.Count > 0)
            {
                //for (int i = 0; i < doc.Database.Tables.Count; i++)
                //{
                //    doc.Database.Tables[i].ApplyLogOnInfo(LoginInfo());
                //}
                doc.Database.Tables[0].ApplyLogOnInfo(LoginInfo());
            }


            //Sections sections = doc.ReportDefinition.Sections;
            //foreach (Section section in sections)
            //{
            //    ReportObjects reportObjects = section.ReportObjects;
            //    foreach (ReportObject reportObject in reportObjects)
            //    {
            //        if (reportObject.Kind == ReportObjectKind.SubreportObject)
            //        {
            //            SubreportObject subreportObject = (SubreportObject)reportObject;
            //            ReportDocument subReportDocument = subreportObject.OpenSubreport(subreportObject.SubreportName);
            //            if (subReportDocument.Database.Tables.Count > 0)
            //            {
            //                for (int i = 0; i < subReportDocument.Database.Tables.Count; i++)
            //                {
            //                    subReportDocument.Database.Tables[i].ApplyLogOnInfo(LoginInfo());
            //                }
            //                //subReportDocument.Database.Tables[0].ApplyLogOnInfo(LoginInfo());
            //            }
            //        }
            //    }
            //}

            if (nums[1].ToString().StartsWith("Y"))
            {
                //打印机名字
                doc.PrintOptions.PrinterName = nums[2].ToString();

                //设置打印边距
                PageMargins margins;
                margins = doc.PrintOptions.PageMargins;
                margins.topMargin = Convert.ToInt32(top * 567); //567
                margins.leftMargin = Convert.ToInt32(left * 567);
                margins.rightMargin = Convert.ToInt32(right * 567);
                margins.bottomMargin = Convert.ToInt32(bottom * 567);
                doc.PrintOptions.ApplyPageMargins(margins);

                if (nums[1].ToString() == "Y1")
                {
                    doc.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
                    doc.PrintOptions.PaperSize = PaperSize.PaperLetter;
                }

                //打印份数，是否逐份打印,打印第一页，最后一页
                doc.PrintToPrinter(1, false, 0, 0);
            }
        }
        catch
        {

        }
        return doc;
    }
    #endregion

    #region SetReportDoc(nums[0]=报表路径 num[1]=是否打印(Y,N) num[2]=打印机名称 num[>=3]=数据参数)   Author ：hcy   (2011-09-15)
    public static ReportDocument SetReportDoc(double top, double bottom, double left, double right, int printCount, params string[] nums)
    {
        ReportDocument doc = new ReportDocument();
        try
        {
            string ReportPath = nums[0].ToString();
            doc.Load(ReportPath);
            for (int i = 3; i < nums.Length; i++)
            {
                string paramValue = nums[i].ToString();
                ParameterDiscreteValue pdv = new ParameterDiscreteValue();
                pdv.Value = paramValue;
                ParameterValues pv = new ParameterValues();
                pv.Add(pdv);
                doc.DataDefinition.ParameterFields[i - 3].ApplyCurrentValues(pv);
            }
            if (doc.Database.Tables.Count > 0)
            {
                //for (int i = 0; i < doc.Database.Tables.Count; i++)
                //{
                //    doc.Database.Tables[i].ApplyLogOnInfo(LoginInfo());
                //}
                doc.Database.Tables[0].ApplyLogOnInfo(LoginInfo());
            }

            string msgStr = "【" + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss fff") + "】  加载报表 \r\n";
            PrinterLOG.WriterLog(msgStr, nums[2], false);

            //Sections sections = doc.ReportDefinition.Sections;
            //foreach (Section section in sections)
            //{
            //    ReportObjects reportObjects = section.ReportObjects;
            //    foreach (ReportObject reportObject in reportObjects)
            //    {
            //        if (reportObject.Kind == ReportObjectKind.SubreportObject)
            //        {
            //            SubreportObject subreportObject = (SubreportObject)reportObject;
            //            ReportDocument subReportDocument = subreportObject.OpenSubreport(subreportObject.SubreportName);
            //            if (subReportDocument.Database.Tables.Count > 0)
            //            {
            //                for (int i = 0; i < subReportDocument.Database.Tables.Count; i++)
            //                {
            //                    subReportDocument.Database.Tables[i].ApplyLogOnInfo(LoginInfo());
            //                }
            //                //subReportDocument.Database.Tables[0].ApplyLogOnInfo(LoginInfo());
            //            }
            //        }
            //    }
            //}

            //打印机名字
            doc.PrintOptions.PrinterName = nums[2].ToString();

            //设置打印边距
            PageMargins margins;
            margins = doc.PrintOptions.PageMargins;
            margins.topMargin = Convert.ToInt32(top * 567); //567
            margins.leftMargin = Convert.ToInt32(left * 567);
            margins.rightMargin = Convert.ToInt32(right * 567);
            margins.bottomMargin = Convert.ToInt32(bottom * 567);
            doc.PrintOptions.ApplyPageMargins(margins);

            if (nums[1].ToString().StartsWith("Y"))
            {              
                //if (nums[1].ToString() == "Y1")
                //{
                //    doc.PrintOptions.PaperSize = PaperSize.PaperA4;
                //}
                //else
                //{
                //    doc.PrintOptions.PaperOrientation = PaperOrientation.DefaultPaperOrientation;
                //    doc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize;
                //}

                //打印份数，是否逐份打印,打印第一页，最后一页
                if (printCount > 20) { printCount = 1; }
                doc.PrintToPrinter(printCount, false, 0, 0);
            }
        }
        catch (Exception exp)
        {
            PrinterLOG.WriterLog(exp.Message, nums[2].ToString(), true);
            doc = null;
        }
        return doc;
    }
    #endregion

    #region SetReportDoc(nums[0]=报表路径 num[1]=是否打印(Y,N) num[2]=打印机名称 num[>=3]=数据参数)   Author ：hcy   (2011-09-15)
    public static ReportDocument SetReportDoc(DataSet ds,params string[] nums)
    {
        ReportDocument doc = new ReportDocument();
        try
        {
            string ReportPath = nums[0].ToString();
            doc.Load(ReportPath);
            if (doc.Database.Tables.Count > 0)
            {
                //for (int i = 0; i < doc.Database.Tables.Count; i++)
                //{
                //    doc.Database.Tables[i].ApplyLogOnInfo(LoginInfo());
                //}
                doc.Database.Tables[0].ApplyLogOnInfo(LoginInfo());
            }
            doc.SetDataSource(ds);
            if (nums[1].ToString().StartsWith("Y"))
            {
                //打印机名字
                doc.PrintOptions.PrinterName = nums[2].ToString();

                //设置打印边距
                //PageMargins margins;
                //margins = doc.PrintOptions.PageMargins;
                //margins.topMargin = 240; //567
                //margins.leftMargin = 240;
                //margins.rightMargin = 240;
                //margins.bottomMargin = 240;
                //doc.PrintOptions.ApplyPageMargins(margins);

                if (nums[1].ToString() == "Y1")
                {
                    doc.PrintOptions.PaperSize = PaperSize.PaperA4;
                }
                //else
                //{
                //    doc.PrintOptions.PaperOrientation = PaperOrientation.DefaultPaperOrientation;
                //    doc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize;
                //}

                //打印份数，是否逐份打印,打印第一页，最后一页
                doc.PrintToPrinter(1, false, 0, 0);
            }
        }
        catch
        {

        }
        return doc;
    }
    #endregion

    #region ExportRepFile(string DocumentName, params string[] nums) 生成报表文件(pdf,doc,xls,txt),不保存在服务器   Author ：hcy   (2011-09-15)
    public static void ExportRepFile(string DocumentName, params string[] nums)
    {
        ReportDocument rDoc = SetReportDoc(nums);
        string ExtFile = DocumentName.Substring(DocumentName.LastIndexOf(".") + 1, 3).ToLower();
        string FileName = DocumentName.Substring(0, DocumentName.LastIndexOf(".")).ToLower();

        if (ExtFile == "pdf")
        {
            //设置打印边距
            //PageMargins margins;
            //margins = rDoc.PrintOptions.PageMargins;
            //margins.topMargin = 357; //567
            //margins.leftMargin = 240;
            //margins.rightMargin = 240;
            //margins.bottomMargin = 357;
            //rDoc.PrintOptions.ApplyPageMargins(margins);

            if (nums[1].ToString() == "N1")
            {
                rDoc.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
                rDoc.PrintOptions.PaperSize = PaperSize.PaperLetter;
            }
            //else
            //{
            //    rDoc.PrintOptions.PaperOrientation = PaperOrientation.DefaultPaperOrientation;
            //    rDoc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize;
            //}
 
            rDoc.ExportToHttpResponse(ExportFormatType.PortableDocFormat, HttpContext.Current.Response, true, FileName);
        }
        else if (ExtFile == "doc")
        {
            rDoc.ExportToHttpResponse(ExportFormatType.WordForWindows, HttpContext.Current.Response, true, FileName);
        }
        else if (ExtFile == "xls")
        {
            rDoc.ExportToHttpResponse(ExportFormatType.Excel, HttpContext.Current.Response, true, FileName);
        }
        else if (ExtFile == "rtf")
        {
            rDoc.ExportToHttpResponse(ExportFormatType.RichText, HttpContext.Current.Response, true, FileName);
        }
        else
        {
            rDoc.ExportToHttpResponse(ExportFormatType.WordForWindows, HttpContext.Current.Response, true, FileName);
        }
    }
    #endregion

    #region ExportRepFile(string DocumentName, params string[] nums) 生成报表文件(pdf,doc,xls,txt),不保存在服务器   Author ：hcy   (2011-09-15)
    public static void ExportRepFile(string DocumentName, double top, double bottom, double left, double right, params string[] nums)
    {
        ReportDocument rDoc = SetReportDoc(nums);
        string ExtFile = DocumentName.Substring(DocumentName.LastIndexOf(".") + 1, 3).ToLower();
        string FileName = DocumentName.Substring(0, DocumentName.LastIndexOf(".")).ToLower();

        if (ExtFile == "pdf")
        {
            //设置打印边距
            PageMargins margins;
            margins = rDoc.PrintOptions.PageMargins;
            margins.topMargin = Convert.ToInt32(top * 567); //567
            margins.leftMargin = Convert.ToInt32(left * 567);
            margins.rightMargin = Convert.ToInt32(right * 567);
            margins.bottomMargin = Convert.ToInt32(bottom * 567);
            rDoc.PrintOptions.ApplyPageMargins(margins);


            if (nums[1].ToString() == "N1")
            {
                rDoc.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
                rDoc.PrintOptions.PaperSize = PaperSize.PaperLetter;
            }
            //else
            //{
            //    rDoc.PrintOptions.PaperOrientation = PaperOrientation.DefaultPaperOrientation;
            //    rDoc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize;
            //}

            rDoc.ExportToHttpResponse(ExportFormatType.PortableDocFormat, HttpContext.Current.Response, true, FileName);
        }
        else if (ExtFile == "doc")
        {
            rDoc.ExportToHttpResponse(ExportFormatType.WordForWindows, HttpContext.Current.Response, true, FileName);
        }
        else if (ExtFile == "xls")
        {
            rDoc.ExportToHttpResponse(ExportFormatType.Excel, HttpContext.Current.Response, true, FileName);
        }
        else if (ExtFile == "rtf")
        {
            rDoc.ExportToHttpResponse(ExportFormatType.RichText, HttpContext.Current.Response, true, FileName);
        }
        else
        {
            rDoc.ExportToHttpResponse(ExportFormatType.WordForWindows, HttpContext.Current.Response, true, FileName);
        }
    }
    #endregion

    #region ExportRepFile(string DocumentName,bool ViewFlag,params string[] nums) 生成报表文件(pdf,doc,xls,txt),保存在服务器   Author ：hcy   (2011-09-15)
    public static void ExportRepFile(string DocumentName,bool ViewFlag,params string[] nums)
    {
        //检查文件路径是否存在
        string virtualPath = "~/UploadFile/ReportFileTemp/" + DateTime.Now.ToString("yyyyMM") + "/";
        string path = HttpContext.Current.Server.MapPath(virtualPath);
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }

        //检查文件是否存在,存在重新生成
        if (File.Exists(path + DocumentName))
        {
            File.Delete(path + DocumentName);
        }

        ReportDocument rDoc = SetReportDoc(nums);
        DiskFileDestinationOptions file = new DiskFileDestinationOptions();

        file.DiskFileName = path + DocumentName;
        rDoc.ExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
        rDoc.ExportOptions.DestinationOptions = file;
        string ExtFile = DocumentName.Substring(DocumentName.LastIndexOf(".") + 1, 3).ToLower();

        if (ExtFile == "pdf")
        {
            //设置打印边距
            //PageMargins margins;
            //margins = rDoc.PrintOptions.PageMargins;
            //margins.topMargin = 1; //567
            //margins.leftMargin = 240;
            //margins.rightMargin = 240;
            //margins.bottomMargin = 1;
            //rDoc.PrintOptions.ApplyPageMargins(margins);

            if (nums[1].ToString() == "N1")
            {
                rDoc.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
                rDoc.PrintOptions.PaperSize = PaperSize.PaperLetter;
            }
            //else
            //{
            //    rDoc.PrintOptions.PaperOrientation = PaperOrientation.DefaultPaperOrientation;
            //    rDoc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize;
            //}

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;

        }
        else if (ExtFile == "doc")
        {

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.WordForWindows;
        }
        else if (ExtFile == "xls")
        {

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.ExcelRecord;
        }
        else if (ExtFile == "rtf")
        {
            rDoc.ExportOptions.ExportFormatType = ExportFormatType.RichText;
        }
        else
        {
            rDoc.ExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
        }
        rDoc.Export();

        if (ViewFlag == true)
        {
            HttpContext.Current.Response.Redirect(virtualPath+ DocumentName);
        }
    }
    #endregion

    #region ExportRepFile(string DocumentName,bool ViewFlag,params string[] nums) 生成报表文件(pdf,doc,xls,txt),保存在服务器   Author ：hcy   (2011-09-15)
    public static void ExportRepFile(string DocumentName, bool ViewFlag, double top, double bottom, double left, double right, params string[] nums)
    {
        //检查文件路径是否存在
        string virtualPath = "~/UploadFile/ReportFileTemp/" + DateTime.Now.ToString("yyyyMM") + "/";
        string path = HttpContext.Current.Server.MapPath(virtualPath);
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }

        //检查文件是否存在,存在重新生成
        if (File.Exists(path + DocumentName))
        {
            File.Delete(path + DocumentName);
        }

        ReportDocument rDoc = SetReportDoc(nums);
        DiskFileDestinationOptions file = new DiskFileDestinationOptions();

        file.DiskFileName = path + DocumentName;
        rDoc.ExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
        rDoc.ExportOptions.DestinationOptions = file;
        string ExtFile = DocumentName.Substring(DocumentName.LastIndexOf(".") + 1, 3).ToLower();

        if (ExtFile == "pdf")
        {
            //设置打印边距
            PageMargins margins;
            margins = rDoc.PrintOptions.PageMargins;
            margins.topMargin = Convert.ToInt32(top * 567); //567
            margins.leftMargin = Convert.ToInt32(left * 567);
            margins.rightMargin = Convert.ToInt32(right * 567);
            margins.bottomMargin = Convert.ToInt32(bottom * 567);
            rDoc.PrintOptions.ApplyPageMargins(margins);

            if (nums[1].ToString() == "N1")
            {
                rDoc.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
                rDoc.PrintOptions.PaperSize = PaperSize.PaperLetter;
            }
            //else
            //{
            //    rDoc.PrintOptions.PaperOrientation = PaperOrientation.DefaultPaperOrientation;
            //    rDoc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize;
            //}

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;

        }
        else if (ExtFile == "doc")
        {

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.WordForWindows;
        }
        else if (ExtFile == "xls")
        {

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.ExcelRecord;
        }
        else if (ExtFile == "rtf")
        {
            rDoc.ExportOptions.ExportFormatType = ExportFormatType.RichText;
        }
        else
        {
            rDoc.ExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
        }
        rDoc.Export();

        if (ViewFlag == true)
        {
            HttpContext.Current.Response.Redirect(virtualPath + DocumentName);           
        }
    }
    #endregion

    #region ExportRepFile(string DocumentName,string url, bool ViewFlag ,params string[] nums) 生成报表文件(pdf,doc,xls,txt),保存在服务器,自定义保存文件路径   Author ：hcy   (2011-09-15)
    public static void ExportRepFile(string DocumentName,string url, bool ViewFlag ,params string[] nums)
    { 
        //检查文件路径是否存在
        string virtualPath = "~/UploadFile/ReportFile/" + (url.EndsWith("/") ? url : (url + "/"));
        string path = HttpContext.Current.Server.MapPath(virtualPath);
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }

        //检查文件是否存在,存在重新生成
        if (File.Exists(path + DocumentName))
        {
            File.Delete(path + DocumentName);
        }

        ReportDocument rDoc = SetReportDoc(nums);
        DiskFileDestinationOptions file = new DiskFileDestinationOptions();

        file.DiskFileName = path + DocumentName;
        rDoc.ExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
        rDoc.ExportOptions.DestinationOptions = file;
        string ExtFile = DocumentName.Substring(DocumentName.LastIndexOf(".") + 1, 3).ToLower();

        if (ExtFile == "pdf")
        {
            //设置打印边距
            //PageMargins margins;
            //margins = rDoc.PrintOptions.PageMargins;
            //margins.topMargin = 1; //567
            //margins.leftMargin = 240;
            //margins.rightMargin = 240;
            //margins.bottomMargin = 1;
            //rDoc.PrintOptions.ApplyPageMargins(margins);

            if (nums[1].ToString() == "N1")
            {
                rDoc.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
                rDoc.PrintOptions.PaperSize = PaperSize.PaperLetter;
            }
            //else
            //{
            //    rDoc.PrintOptions.PaperOrientation = PaperOrientation.DefaultPaperOrientation;
            //    rDoc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize;
            //}

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;

        }
        else if (ExtFile == "doc")
        {

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.WordForWindows;
        }
        else if (ExtFile == "xls")
        {

            rDoc.ExportOptions.ExportFormatType = ExportFormatType.ExcelRecord;
        }
        else if (ExtFile == "rtf")
        {
            rDoc.ExportOptions.ExportFormatType = ExportFormatType.RichText;
        }
        else
        {
            rDoc.ExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
        }
        rDoc.Export();

        if (ViewFlag == true)
        {
            HttpContext.Current.Response.Redirect(virtualPath + DocumentName);
        }
    }
    #endregion


}
