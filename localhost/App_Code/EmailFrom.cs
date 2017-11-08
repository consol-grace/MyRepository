using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DIYGENS.COM.FRAMEWORK;

/// <summary>
///EmailFrom 的摘要说明
///发送人邮箱
///GRACE 2015-11-5
/// </summary>
public class EmailFrom
{
    public EmailFrom()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    public string nickName { get; set; } //用户昵称
    public string IP { get; set; } //IP
    public string userName { get; set; } //用户账户
    public string pwd { get; set; } //用户密码
    public bool ssl { get; set; } //是否加密
    public int Port { get; set; } // prot
    public DateTime status { get; set; } //邮箱发送状态

    //public static readonly EmailFrom instance = new EmailFrom();
    private static readonly object obj = new object();
    private static EmailFrom _instance = null;

    public static EmailFrom Instance
    {
        get
        {
            if (_instance == null)
            {
                lock (obj)
                {
                    if (_instance == null)
                        _instance = new EmailFrom();
                }
            }

            return _instance;
        }
    }

    public List<EmailFrom> GetEmailFromList()
    {
        List<EmailFrom> EmailFromList = new List<EmailFrom>();

        int fnum = 0;
        while (true)
        {
            fnum++;
            string webStr = ConfigHelper.GetAppSettings("EmailFroms" + fnum);
            if (webStr == null || webStr == "")
            {
                break;
            }
            else
            {
                string[] EFInfo = webStr.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries);

                EmailFrom e = new EmailFrom();
                e.nickName = EFInfo[0].Split('=')[1].Trim();
                e.IP = EFInfo[1].Split('=')[1].Trim();
                e.userName = EFInfo[2].Split('=')[1].Trim();
                e.pwd = EFInfo[3].Split('=')[1].Trim();
                e.ssl = Convert.ToBoolean(EFInfo[4].Split('=')[1].Trim());
                e.Port = string.IsNullOrEmpty(EFInfo[5].Split('=')[1]) ? 25 : Convert.ToInt32(EFInfo[5].Split('=')[1].Trim());

                lock (EmailFromList)
                {
                    EmailFromList.Add(e);
                }
            }
        }

        return EmailFromList;
    }
}