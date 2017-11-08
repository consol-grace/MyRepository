<%@ WebHandler Language="C#" Class="ReportContinuousPrint" %>

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
using System.Linq;
using System.IO;
using System.Net;
using System.Threading;
using System.Collections.Generic;
using CrystalDecisions.CrystalReports.Engine;

public class ReportContinuousPrint : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string option = context.Request["option"];
        if (option == "update")
            UpdatePrintList(context);
        else if (option == "checkItem")
            CheckItem();
        else if (option == "checkPrint")
            CheckPrint();
        else
            BatchPrint();
    }

    DataFactory dal = new DataFactory();


    /// <summary>
    /// 更新打印列表
    /// </summary>
    /// <param name="context"></param>
    public void UpdatePrintList(HttpContext context)
    {
        string param = context.Request.Form["param"];
        string sys = context.Request.Form["sys"];
        string seed = context.Request.Form["seed"];
        string stat = FSecurityHelper.CurrentUserDataGET()[12];
        string user = FSecurityHelper.CurrentUserDataGET()[0];
        string[] arry = param.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);

        string Reportseed = DateTime.Now.ToString("yyMMddHHmmssfff");

        List<IFields> list = new List<IFields>();

        foreach (string str in arry)
        {
            string[] type = str.Split(new string[] { "_" }, StringSplitOptions.None);

            list.Add(dal.CreateIFields().Append("option", "update").
             Append("ChkBoxID", str).
             Append("PRG_IsSelect", 1).
             Append("RPG_Seed", type[type.Length - 1]).
             Append("RPG_SeedTo", seed).
             Append("ReportSeed", Reportseed).
             Append("Sys", sys).
             Append("Stat", stat).
             Append("ReportType", type[0]).
             Append("ReportParam", str).
             Append("IsPrinted", 0).
             Append("user", user));
        }

        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ReportPrinting", list).Update();

        context.Response.Write(b.ToString());

    }


    /// <summary>
    /// 检查打印机
    /// </summary>
    public void CheckPrint()
    {
        string strValue = string.Empty;
        string printType = HttpContext.Current.Request["printType"];    //直接打印或者打印成PDF下载

        if (printType == "PDF")
            strValue = "True";
        else
        {
            string seed = HttpContext.Current.Request["seed"];
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ReportPrinting", new List<IFields>() { dal.CreateIFields().
                            Append("option", "checkPrinter").                       
                            Append("RPG_SeedTo", seed) }).GetTable();

            for (int i = 0; i < dt.Rows.Count && dt != null; ++i)
            {
                if (string.IsNullOrEmpty(dt.Rows[i]["prt_PrinterName"].ToString()))
                {
                    strValue += dt.Rows[i]["ReportType"].ToString() + ",";
                }

            }
            if (strValue.Length > 1)
                strValue = strValue.Substring(0, strValue.Length - 1);
            else
                strValue = "True";

        }
        HttpContext.Current.Response.Write(strValue);
    }


    /// <summary>
    /// 批量打印
    /// </summary>
    public void BatchPrint()
    {
        int count = 0;
        int printCount = 1;
        string printType = HttpContext.Current.Request["printType"];    //直接打印或者打印成PDF下载
        string seed = HttpContext.Current.Request["seed"];
        string sys = HttpContext.Current.Request.Form["sys"];

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ReportPrinting", new List<IFields>() { dal.CreateIFields().
                            Append("option", "selectlist").                       
                            Append("RPG_SeedTo", seed) }).GetTable();

        string filePath = "";
        bool isprinted = true;
        string ErrorFile = "";
        string[] filePathList = new string[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count; ++i)
        {
            ReportDocument rdoc=null;
            string remark = "";
            string rowid = dt.Rows[i]["RPG_RowID"].ToString();
            string type = dt.Rows[i]["ReportType"].ToString();
            string repSeed = dt.Rows[i]["ReportSeed"].ToString();
            string printName = dt.Rows[i]["prt_PrinterName"].ToString();
            double top = string.IsNullOrEmpty(dt.Rows[i]["rc_rptTop"].ToString()) ? 0.63 : Convert.ToDouble(dt.Rows[i]["rc_rptTop"]);
            double bottom = string.IsNullOrEmpty(dt.Rows[i]["rc_rptBottom"].ToString()) ? 0.63 : Convert.ToDouble(dt.Rows[i]["rc_rptBottom"]);
            double left = string.IsNullOrEmpty(dt.Rows[i]["rc_rptLeft"].ToString()) ? 0.63 : Convert.ToDouble(dt.Rows[i]["rc_rptLeft"]);
            double right = string.IsNullOrEmpty(dt.Rows[i]["rc_rptRight"].ToString()) ? 0.63 : Convert.ToDouble(dt.Rows[i]["rc_rptRight"]);
            double[] Margin = { top, bottom, left, right };
            string[] arry = dt.Rows[i]["ReportParam"].ToString().Split(new string[] { "_" }, StringSplitOptions.None);
            string[] param = new string[arry.Length];
            for (int z = 0; z < arry.Length; ++z)
            {
                param[z] = arry[arry.Length - z - 1];
                //aram[z] = arry[z];
            }

            string hidInvDraft = printType == "PDF" ? "1" : "0";

            Reportparameters rpm = new Reportparameters(hidInvDraft);
            string[] Nums = rpm.GetNums(type, "Y", printName, param, sys, new System.Web.UI.Page());

            
            if (printType == "PDF")
            {
                //string[] fileParam = { type, param[0], param[1], sys };
                //rdoc = new Print().VirtualPrint(Nums, Margin, printCount, ref filePath, repSeed, ref printName, fileParam);
                for (int n = 0; n < 2; n++)
                {
                    string[] fileParam = { type, param[0], param[1], sys };
                    rdoc = new Print().VirtualPrint(Nums, Margin, printCount, ref filePath, repSeed, ref printName, fileParam);

                    if (filePath != "")
                    {
                        filePathList[i] = filePath;
                    }

                    try
                    {
                        //string lotno1 =(filePathList[i].Substring(filePathList[i].LastIndexOf("/") + 1, filePathList[i].IndexOf("_") - filePathList[i].LastIndexOf("/") - 1)).Substring(0, 12);
                        //string lotno2 = (filePathList[i - 1].Substring(filePathList[i - 1].LastIndexOf("/") + 1, filePathList[i - 1].IndexOf("_") - filePathList[i - 1].LastIndexOf("/") - 1)).Substring(0, 12);

                        string lotno1 = (filePathList[i].Substring(filePathList[i].LastIndexOf("/") + 1, filePathList[i].IndexOf("_") - filePathList[i].LastIndexOf("/") - 1));
                        string lotno2 = (filePathList[i - 1].Substring(filePathList[i - 1].LastIndexOf("/") + 1, filePathList[i - 1].IndexOf("_") - filePathList[i - 1].LastIndexOf("/") - 1));
                        if (lotno1 == lotno2)
                            break;
                        
                        if(n==1)
                        ErrorFile = "Error File:" + filePathList[i] + " || " + filePathList[i - 1];
                    }
                    catch (Exception)
                    {

                        break;
                    }
                   
                }
            }
            else
            {
                if (type.ToUpper() == "INVOICE")
                    UpdateInvoicePrint(param[0], sys);

                if (string.IsNullOrEmpty(printName))
                    rdoc = null;
                else
                    rdoc = new Print().ToPrintPaper(Nums, Margin, printCount, printName);
            }
            try
            {
                if (rdoc != null && rdoc.HasSavedData)
                {
                    isprinted = true;
                    ++count;
                }
                else
                    isprinted = false;
            }
            catch
            {
                isprinted = false;
            }
            remark = isprinted ? "打印成功" : "数据异常，打印失败";


            bool cc = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ReportPrinting", new List<IFields>() { dal.CreateIFields().
                            Append("option", "update").                       
                            Append("RPG_RowID", rowid). 
                            Append("IsPrinted", isprinted). 
                            Append("printName",printName).
                            Append("ReportFile",filePath).
                            Append("Remark",remark) }).Update();

            System.Threading.Thread.Sleep(1000);

        }

        if (printType == "PDF")
        {
            if (!isprinted) return;

            string fileDire = filePath.Substring(0, filePath.LastIndexOf("/"));
            string lotno = filePath.Substring(filePath.LastIndexOf("/") + 1, filePath.IndexOf("_") - filePath.LastIndexOf("/") - 1);
            lotno = lotno.Substring(0, 12);

            string email = FSecurityHelper.CurrentUserDataGET()[3];  //Email 地址
            List<string> addEmail = new List<string>();
            foreach (string str in email.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries))
                addEmail.Add(str);

            //string[] fileStr = filePath.Split(new string[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
            //string attachFile = HttpContext.Current.Server.MapPath(filePath + ".rar");
            //ZipApplication.ZipClass.Zip(HttpContext.Current.Server.MapPath(filePath), attachFile, null);
            //Thread.Sleep(1000);                          

            DirectoryInfo di = new DirectoryInfo(HttpContext.Current.Server.MapPath(fileDire));
            var fileStr = di.GetFiles().OrderBy(p => p.Name);
            if (fileStr.Count() <= 0) return;
            count = fileStr.Count();

            string FileNameList = "", FileDataList = "";

            foreach (FileInfo file in fileStr)
            {
                FileNameList += file.Name + "|";
                FileDataList += ConvertFile.ToBinary(file.FullName) + "|";
            }


            //HttpContext.Current.Response.Write(FileDataList);
            //FileNameList = FileNameList.TrimEnd(';');            
            //EmailInfo info = new EmailInfo();
            //info.MailSubjct = "CONSOL-OP: LotNo# " + lotno;
            //info.MailBody = "<font color='red' size='1'>The mail sent by system, please do not reply.</font>";
            //info.MailAddress = addEmail;
            //info.Filename = attachFile;
            //EmailInfo.AddEmailInfo(info);

            string mailSubjct = "CONSOL-OP: LotNo# " + lotno + " , " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            string mailBody = "<p style=\"color:red;font-size: 11px;\">The mail sent by system, please do not reply.</p>";
                mailBody += "<p style=\"color:red;font-size: 11px;\">"+ErrorFile+"</p>";
            try
            {
                //string cmdtext = "insert into emailinfo (mailsubjct, mailbody, mailaddress, filename,mailtime,mailstatus) values ('" + mailSubjct + "','" + mailBody + "','" + email + "','" + FileNameList + "',getdate(),0)";
                //SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings);
                //con.Open();
                //SqlCommand cmd = new SqlCommand(cmdtext, con);
                //int num = cmd.ExecuteNonQuery();
                //con.Close();
               // EmailInfo e = new EmailInfo();


                //Dictionary<string, string> data = new Dictionary<string, string>();
                //data.Add("action", "sendmail"); //当前执行动作 
                //data.Add("body", mailBody);  //邮件内容 
                //data.Add("subject", mailSubjct); //邮件主题
                //data.Add("Address", email); // 邮件地址，多个地址用分隔符隔开
                //data.Add("strFiles", FileDataList); //邮件附件，多个附件用分隔符隔开（此处不是文件地址，是将文件转化为二进制流并序列化为64位字符串）
                //data.Add("fileName", FileNameList);//附件的文件名称，多个附件名用分隔符隔开（与附件个数一致）
                //data.Add("separator", "|"); //分隔符
                //data.Add("user", FSecurityHelper.CurrentUserDataGET()[0]); //执行发送邮件的用户

                //int sentCount = 2, currindex = 0;
                //while (currindex < sentCount)
                //{
                //    string msg = ExecRequest.call(data, "http://localhost:4880/Handler.ashx");
                //    if (msg == "") break;
                //    Thread.Sleep(2000);
                //    ++currindex;
                //}
                
                EmailInfo e = new EmailInfo();
                e.StartSendEmail(mailBody, mailSubjct, email, FileDataList, FileNameList, FSecurityHelper.CurrentUserDataGET()[0]);

                //nickName=operation@consol-can.com;IP=192.168.1.4;userName=operation@consolidator;pwd=Cncr6530!;ssl=false;port=587
                
            }
            catch (Exception)
            {

            }

            //MailHelper.sendMail("Consolidator operation of LotNo# " + lotno, "<font color='red' size='1'>The mail sent by system, please do not reply.</font>", "benja@consol-hk.com", addEmail, "mail.consol-hk.com", attachFile, "benja@consol-hk.com", "pccw1812", false);
            //MailHelper.sendMail("Consolidator operation of LotNo# " + lotno, "<font color='red' size='1'>The mail sent by system, please do not reply.</font>", "1494049551@qq.com", addEmail, "smtp.qq.com", attachFile, "1494049551@qq.com", "zxcvbnm1.", false);
            //MailHelper.sendMail("Consolidator operation of LotNo# " + lotno, "<font color='red' size='1'>The mail sent by system, please do not reply.</font>", "admin@consol-hk.com", addEmail, "smtp.qq.com", attachFile, "1494049551@qq.com", "zxcvbnm1.", false);
            //MailHelper.sendMail("Consolidator operation of LotNo# " + lotno, "<font color='red' size='1'>The mail sent by system, please do not reply.</font>", "qh279650038@gmail.com", addEmail, "smtp.gmail.com", attachFile, "qh279650038@gmail.com", "qianhao1988820", false);
        }

        HttpContext.Current.Response.Write(count.ToString());
    }




    //public ReportDocument PDFPrint(double top, double bottom, double left, double right, string type, string[] param, string repSeed, ref string filePath, ref string printName)
    //{
    //    printName = null;

    //    try
    //    {
    //        //string folder = Server.MapPath("PDF");

    //        string PaperSize = "";

    //        string fileName = GetfileName(ref PaperSize, type, param[0], param[1]);   // 获取 纸张类型  ，文件名称

    //        if (string.IsNullOrEmpty(fileName))
    //        {
    //            return null;
    //        }

    //        GetPrintName(ref printName, PaperSize);         // 获取可用的打印机名称

    //        UpdatePrinterStatus(printName, 1, type, param[0]);              // 更新打印机状态

    //        PrintImgSetting pis = new PrintImgSetting();    // 配置虚拟打印机 相关属性

    //        // 设置文件类型
    //        string ff = HttpContext.Current.Request["format"];
    //        int format = string.IsNullOrEmpty(ff) ? 4 : Convert.ToInt32(ff);

    //        // 设置文件是否连续显示
    //        string cm = HttpContext.Current.Request["CreateMode"];
    //        int mode = string.IsNullOrEmpty(cm) ? 0 : Convert.ToInt32(cm);

    //        string randomFolder = "/PreviewTemp/" + repSeed;
    //        filePath = randomFolder; // +"/" + fileName.Split(new string[] { "_" }, StringSplitOptions.RemoveEmptyEntries)[0];

    //        MoveFile mf = new MoveFile();
    //        mf.CreateDirectory(HttpContext.Current.Server.MapPath(randomFolder));

    //        //设置文件目录
    //        pis.SetFileFolder(printName, HttpContext.Current.Server.MapPath(randomFolder));
    //        Thread.Sleep(300);
    //        pis.SetFileName(printName, fileName);           //设置文件名称  
    //        Thread.Sleep(300);
    //        pis.SetFileFormat(printName, format);           //设置文件类型
    //        Thread.Sleep(300);
    //        pis.SetCreateMode(printName, mode);             //设置文件连续显示
    //        Thread.Sleep(300);

    //        //print(printName);                             //实现打印功能     
    //        ReportDocument rdoc = ReportHelper.SetReportDoc(top, bottom, left, right, 1, GetNums(type, "Y", printName, param));


    //        //打印机生成的文件路径
    //        string url = randomFolder + "/" + fileName + "." + pis.FileFormat(format);

    //        Thread.Sleep(2000);                             // 等待打印文件读写            

    //        UpdatePrinterStatus(printName, 0, "", "");        // 更新打印机状态

    //        return rdoc;
    //    }
    //    catch (Exception exp)
    //    {
    //        UpdatePrinterStatus(printName, 0, "", "");        // 更新打印机状态
    //        return null;
    //    }
    //}


    ///// <summary>
    ///// 生成文件名
    ///// </summary>
    ///// <returns></returns>
    //public string GetfileName(ref string PaperSize, string type, string seed, string code)
    //{
    //    string strName = "";

    //    // 执行 存储过程  返回 拼合的文件名 
    //    DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_VirtualPrinter_SP", new List<IFields>() { dal.CreateIFields().
    //            Append("option", "GetNo").
    //            Append("RepType",type).
    //            Append("sys",HttpContext.Current.Request["sys"]).
    //            Append("CO_Code",code).
    //            Append("seed",seed) }).GetTable();
    //    if (dt != null && dt.Rows.Count > 0)
    //    {
    //        PaperSize = dt.Rows[0]["PaperSize"].ToString();
    //        strName = dt.Rows[0]["lotno"] + "_" + type + "-" + Replace(dt.Rows[0]["no"].ToString()) + "-" + dt.Rows[0]["seed"];
    //    }
    //    return strName.ToUpper();
    //}


    ///// <summary>
    ///// 打印机列表
    ///// </summary>
    ///// <returns></returns>
    //public DataSet GetList(string paperSize)
    //{
    //    DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_VirtualPrinter_SP", new List<IFields>() { dal.CreateIFields().
    //                 Append("option", "PrinterList").Append("PaperSize",paperSize) }).GetList();
    //    return ds;
    //}

    ///// <summary>
    ///// 更新打印机状态
    ///// </summary>
    ///// <param name="printName"></param>
    //public void UpdatePrinterStatus(string printName, int status, string type, string seed)
    //{
    //    string description = "";
    //    if (status == 1)
    //        description = "当前打印机正在使用，使用者信息：" + FSecurityHelper.CurrentUserDataGET()[0] + "，" + FSecurityHelper.CurrentUserDataGET()[12] + "，报表类型：" + type + "，SeedID :" + seed;

    //    bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_VirtualPrinter_SP", new List<IFields>() { dal.CreateIFields().
    //            Append("option", "UpdateStatus").
    //            Append("status",status).
    //            Append("printName",printName).
    //            Append("Description",description) }).Update();
    //}

    ///// <summary>
    ///// 获取可用打印机列表
    ///// </summary>
    ///// <param name="printName"></param>
    //public void GetPrintName(ref string printName, string paperSize)
    //{
    //    int count = 0;
    //    printName = null;

    //    while (string.IsNullOrEmpty(printName))
    //    {
    //        if (count <= 10)
    //            Thread.Sleep(count * 100);
    //        else if (count > 10)
    //            Thread.Sleep(2000);

    //        DataSet ds = GetList(paperSize);

    //        //存在打印机 获取名称
    //        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
    //        {
    //            printName = ds.Tables[0].Rows[0][0].ToString();
    //        }
    //        ++count;
    //    }
    //}


    ///// <summary>
    ///// 过滤字符串
    ///// </summary>
    ///// <param name="str"></param>
    ///// <returns></returns>
    //public string Replace(string str)
    //{
    //    string[] symbol = { "\\", "/", ":", "*", "?", "<", ">", "\"", "|", "_", "+", ".", ".", "。", "，", ",", "：" };
    //    for (int i = 0; i < symbol.Length; ++i)
    //    {
    //        str = str.Replace(symbol[i], "");
    //    }
    //    return str;
    //}


    //seed_group_type
    private string[] GetNums(string type, string flag, string printName, string[] param)
    {
        string[] nums = null;
        string sys = HttpContext.Current.Request["sys"];
        Reportparameters rp = new Reportparameters();
        nums = rp.GetNums(type, flag, printName, param, sys, new System.Web.UI.Page());
        return nums;
    }


    /// <summary>
    /// select item
    /// </summary>
    public void CheckItem()
    {
        string seed = HttpContext.Current.Request["seed"];
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ReportPrinting", new List<IFields>() { dal.CreateIFields().
                            Append("option", "checkItem").                       
                            Append("RPG_SeedTo", seed) }).GetTable();
        HttpContext.Current.Response.Write(JsonConvert.SerializeObject(dt));
    }

    /// <summary>
    /// Update Invoice
    /// </summary>
    public void UpdateInvoicePrint(object inv_seed, string sys)
    {
        if (!LockDate.IsLock(inv_seed.ToString(), ""))
        {
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "UpdateInvoiceNo").
                            Append("inv_seed",inv_seed).
                            Append("code",FSecurityHelper.CurrentUserDataGET()[4]+sys).
                            Append("inv_STAT",FSecurityHelper.CurrentUserDataGET()[12]).
                            Append("User",FSecurityHelper.CurrentUserDataGET()[0])                     
                            }).Update();
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