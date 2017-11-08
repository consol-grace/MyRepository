using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;
using System.Data;
using DIYGENS.COM.DBLL;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using DIYGENS.COM.FRAMEWORK;

/// <summary>
///EmailInfo 的摘要说明
///用于处理收件人以及发送邮件
///GRACE 2015-11-5
/// </summary>
public class EmailInfo
{
    public EmailInfo()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    //public string ID { get; set; } //ID
    //public string MailSubjct { get; set; } //邮件主题
    //public string MailBody { get; set; }  //邮件正文
    //public List<string> MailAddress { get; set; } //接收地址列表
    //public List<string> Filename { get; set; } //附件名
    //public int MailStatus { get; set; } //邮件发送状态  0--未发送 1--发送中 2--发送成功

    ////public static readonly EmailInfo instance = new EmailInfo();//单例

    //private static readonly object obj = new object();

    ////单例
    //private static EmailInfo _instance = null;

    //public static EmailInfo Instance
    //{
    //    get
    //    {
    //        if (_instance == null)
    //        {
    //            lock (obj)
    //            {
    //                if (_instance == null)
    //                    _instance = new EmailInfo();
    //            }
    //        }

    //        return _instance;
    //    }
    //}

    //static EmailInfo()
    //{
    //    int threads = EmailFrom.Instance.GetEmailFromList().Count;//并发线程数量
    //    for (int i = 0; i < threads; i++)
    //    {
    //        Thread getWork = new Thread(StartWork);
    //        getWork.Start();
    //    }
    //}

    //public static void StartWork()
    //{
    //    while (true)
    //    {
    //        List<EmailFrom> efList = EmailFrom.Instance.GetEmailFromList().OrderBy(p => p.status).ToList();
    //        EmailFrom ef = (efList.Count > 0) ? efList[0] : null;

    //        if (ef == null)
    //        {//等待发件人空闲
    //            Thread.Sleep(1000);
    //            //lock (obj)
    //            //    {
    //            //        string path3 = HttpRuntime.AppDomainAppPath + @"AppLogs\EmailRecord.txt";
    //            //        File.AppendAllText(path3, "ef:" + ef + "\r\n");
    //            //    }
    //        }
    //        else
    //        {
    //            EmailInfo ei = GetEmailInfo();
    //            if (ei == null)
    //            {//等待新任务
    //                //lock (obj)
    //                //{
    //                //    string path2 = HttpRuntime.AppDomainAppPath + @"AppLogs\EmailRecord.txt";
    //                //    File.AppendAllText(path2, "ei：" + ei + "ef:" + ef + "\r\n");
    //                //}

    //                Thread.Sleep(1000);
    //            }
    //            else
    //            {
    //                //lock (obj)
    //                //{
    //                //    string path1 = HttpRuntime.AppDomainAppPath + @"AppLogs\EmailRecord.txt";
    //                //    File.AppendAllText(path1, "邮件发送之前：" + "\r\n");
    //                //}

    //                string msg = MailHelper.sendMail(ei.MailSubjct, ei.MailBody, ef.nickName, ei.MailAddress, ef.IP, ei.Filename, ef.userName, ef.pwd, ef.ssl, ef.Port);

    //                //lock (obj)
    //                //{
    //                //     string path1 = HttpRuntime.AppDomainAppPath + @"AppLogs\EmailRecord.txt";
    //                //    File.AppendAllText(path1, "邮件发送MSG：" + msg + " 时间：" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fffff") + "\r\n");
    //                //}


    //                if (msg != "")
    //                {
    //                    string AddrList = ""; //收件人邮箱
    //                    string FileNameList = ""; //文件名
    //                    for (int n = 0; n < ei.MailAddress.Count; n++)
    //                    {
    //                        AddrList += ei.MailAddress[n] + ";";
    //                    }

    //                    AddrList = AddrList.TrimEnd(';');

    //                    for (int i = 0; i < ei.Filename.Count; i++)
    //                    {
    //                        FileNameList += ei.Filename[i] + ";";
    //                    }

    //                    FileNameList = FileNameList.TrimEnd(';');

    //                    lock (obj)
    //                    {
    //                        string path = HttpRuntime.AppDomainAppPath + @"AppLogs\EmailRecord.txt";
    //                        File.AppendAllText(path, "失败原因：" + msg + " 失败时间：" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fffff") + " 发送帐号：" + ef.userName + " 发送IP：" + ef.IP + " 接收帐号：" + AddrList + "\r\n");
    //                        //File.AppendAllText(@"D:\USGROUP\Web\operation-test.consol-hk.com\localhost\AppLogs\EmailRecord.txt", "失败原因：" + msg + " 失败时间：" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fffff") + " 发送帐号：" + ef.userName + " 接收帐号：" + AddrList + "\r\n");
    //                    }

    //                    Thread.Sleep(10 * 1000);//等待20s
    //                    ef.status = System.DateTime.Now;  //更新发件人状态
    //                    ei.MailStatus = 0;//更新收件人状态变成未发送任务

    //                    UpdateMailStatus(ei);//发送失败 更新任务状态
    //                }
    //                else
    //                {
    //                    string wt = ConfigHelper.GetAppSettings("EmailWaitTime");
    //                    Thread.Sleep(Convert.ToInt32(wt) * 1000);//等待20s
    //                    ef.status = System.DateTime.Now;
    //                    ei.MailStatus = 2;//发送成功

    //                    UpdateMailStatus(ei);//发送成功 删除该任务
    //                }
    //            }
    //        }
    //    }
    //}

    ///// <summary>
    ///// 获取任务
    ///// </summary>
    ///// <returns></returns>
    //public static EmailInfo GetEmailInfo()
    //{
    //    EmailInfo e = new EmailInfo();
    //    lock (obj)
    //    {
    //        DataTable dt = new DataTable();
    //        SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings);
    //        lock (con)
    //        {
    //            string cmdText = "select top 1 * from EmailInfo where MailStatus = 0 order by MailTime";
    //            con.Open();
    //            SqlDataAdapter MyAdapter = new SqlDataAdapter(cmdText, con);
    //            MyAdapter.Fill(dt);
    //            con.Close();
    //        }

    //        if (dt != null && dt.Rows.Count > 0)
    //        {
    //            List<string> addEmail = new List<string>();
    //            foreach (string str in dt.Rows[0]["MailAddress"].ToString().Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries))
    //                addEmail.Add(str);

    //            List<string> attachFile = new List<string>();
    //            //foreach (FileInfo file in fileStr)
    //            //    attachFile.Add(file.FullName);
    //            foreach (string str in dt.Rows[0]["FileName"].ToString().Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries))
    //                attachFile.Add(str);

    //            e.MailSubjct = dt.Rows[0]["MailSubjct"].ToString();
    //            e.MailBody = dt.Rows[0]["MailBody"].ToString();
    //            e.MailAddress = addEmail;
    //            e.Filename = attachFile;
    //            e.ID = dt.Rows[0]["ID"].ToString();

    //            //这里是为了不让多线程拿到同一个任务
    //            e.MailStatus = 1;
    //            UpdateMailStatus(e);
    //        }
    //        else
    //        {
    //            e = null;
    //        }
    //    }
    //    return e;
    //}

    ///// <summary>
    ///// 修改邮件状态 删除任务
    ///// </summary>
    ///// <returns></returns>
    //public static void UpdateMailStatus(EmailInfo e)
    //{
    //    string cmdText = "update EmailInfo set MailStatus = " + e.MailStatus + " where ID = " + e.ID;
    //    SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings);
    //    lock (con)
    //    {
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand(cmdText, con);
    //        int num = cmd.ExecuteNonQuery();
    //        con.Close();
    //    }
    //}

    /// <summary>
    /// 
    /// </summary>
    /// <param name="mailBody">邮件内容</param>
    /// <param name="mailSubjct">邮件主题</param>
    /// <param name="email">邮件地址，多个地址用分隔符隔开</param>
    /// <param name="FileDataList">邮件附件，多个附件用分隔符隔开（此处不是文件地址，是将文件转化为二进制流并序列化为64位字符串）</param>
    /// <param name="FileNameList">附件的文件名称，多个附件名用分隔符隔开（与附件个数一致）</param>
    /// <param name="userName">执行发送邮件的用户</param>
    public void StartSendEmail(string mailBody, string mailSubjct, string email, string FileDataList, string FileNameList,string userName)
    {
        Dictionary<string, string> data = new Dictionary<string, string>();
        data.Add("action", "sendmail"); //当前执行动作 
        data.Add("body", mailBody);   
        data.Add("subject", mailSubjct); 
        data.Add("Address", email); 
        data.Add("strFiles", FileDataList);
        data.Add("fileName", FileNameList);
        data.Add("separator", "|"); //分隔符
        data.Add("user", userName); 

        int sentCount = 2, currindex = 0;
        while (currindex < sentCount)
        {
            string msg = ExecRequest.call(data, "http://localhost:4880/Handler.ashx");
            if (msg == "") break;
            Thread.Sleep(2000);
            ++currindex;
        }
    }
}