using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.IO;

/// <summary>
///PrinterLOG 的摘要说明
/// </summary>
public class PrinterLOG
{
    public PrinterLOG()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    /// <summary>
    /// 将错误日志写入到文件并且可选择是否邮件提示
    /// </summary>
    /// <param name="msg">错误提示信息</param>
    /// <param name="printerName">当前打印机</param>
    /// <param name="sendmail">是否发送mail</param>
    public static void WriterLog(string msg, string printerName, bool sendmail)
    {
        try
        {
            StreamWriter sw = new StreamWriter(HttpContext.Current.Server.MapPath("~/AppLogs/Printerlog." + printerName + "." + DateTime.Now.ToString("yyyy-MM-dd") + ".txt"), true);
            sw.WriteLine(msg + "\r\n");
            sw.Close();
            sw.Dispose();

            if (sendmail)
                SendMail(printerName, msg);
        }
        catch(Exception exp)
        {
            
        }
    }


    public static void WriterLog(string msg)
    {
        try
        {
            StreamWriter sw = new StreamWriter(HttpContext.Current.Server.MapPath("~/AppLogs/Test" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt"), true);
            sw.WriteLine(msg + "\r\n");
            sw.Close();
            sw.Dispose();

        }
        catch (Exception exp)
        {

        }
    }


    private static void SendMail(string PrinterName, string exceptionMsg)
    {
        MailHelper.sendMail("Error ,Operation System Print preview failed", "Print preview is not successful, the current printer is \"<b>" + PrinterName + "\"</b></hr><p style='background:#ececec;padding:8px 5px;margin:0px;'>Error message: " + exceptionMsg + "</p></br><font color='red' size='1'>The mail sent by system, please do not reply.</font>", "admin@consol-hk.com", new List<string> { "279650038@qq.com" }, "mail.consol-hk.com", new List<string> { "" }, "benja@consol-hk.com", "pccw1812", false);
    }

}
