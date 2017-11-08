using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Threading;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using DIYGENS.COM.FRAMEWORK;

/// <summary>
///UpdateUserInfo 的摘要说明
/// </summary>
public class UpdateUserInfo
{
    public UpdateUserInfo()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    public static Thread getWork = null;
    protected static string fileName = "";
    protected static string currentUserName = "";
    protected static string path = "";
    protected static string email = "";
    //protected static EmailInfo info = null;
    protected static string NewFile = "";

    public static void Start()
    {
        //info = new EmailInfo();
        email = FSecurityHelper.CurrentUserDataGET()[3];
        path = HttpContext.Current.Server.MapPath("userfile");
        currentUserName = FSecurityHelper.CurrentUserDataGET()[0].ToString();
        fileName = "UPDATE_USERINFO_" + currentUserName + ".SQL";

        if (getWork == null || getWork.ThreadState == ThreadState.Stopped)
        {
            getWork = new Thread(ExeSql);
            getWork.Start();
        }
    }

    /// <summary>
    /// 创建修改用户信息的SQL文件
    /// </summary>
    public static void CreateFile(string userEmail, string userTel, string userFax, string userExt, string userName, string userNameen)
    {
        //string path = Server.MapPath("userfile"); //"E:\\userfile\\";
        //System.IO.Directory.CreateDirectory(path);

        //DirectoryInfo dir = new DirectoryInfo(path);
        //dir.Create();//自行判断一下是否存在。

        //dir.CreateSubdirectory("old\\");

        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }

        //string sql = string.Format("update FW_USER set Email='{0}' , Tel='{1}' , Ext='{2}' ,Fax='{3}' ,NameCHS='{4}', NameENG='{5}' ,Modifier='{6}', ModifyDate=GETDATE()  where UserName='{6}'"
        //              , txtUserEmail.Text, txtUserTel.Text.ToUpper(), txtUserExt.Text.ToUpper(), txtUserFax.Text.ToUpper(), txtUserName.Text.ToUpper(), txtUserNameen.Text.ToUpper(), currentUserName);

        string sql = string.Format("exec web_center.USGROUP_OPERATION_TEST.dbo.FW_UserManager_SP  @option = 'update1',@username = '{0}',@rowid = null,@email = '{1}',@tel = '{2}',@fax = '{3}',@ext = '{4}',@NameCHS = '{5}',@NameENG = '{6}'"
                     , currentUserName, userEmail, userTel, userFax, userExt, userName, userNameen);
        //string fileName = "UPDATE_USERINFO_" + currentUserName + ".SQL";
        ////实例化一个文件流--->与写入文件相关联 
        //FileStream fs = new FileStream("E:\\" + fileName, FileMode.Create);
        //StreamWriter sw = new StreamWriter(fs);
        ////开始写入
        //sw.Write(sql);
        ////清空缓冲区
        //sw.Flush();
        ////关闭流
        //sw.Close();
        //fs.Close();

        System.IO.File.WriteAllText(path + "\\" + fileName, sql);
    }

    /// <summary>
    /// 读取SQL文件里的SQL
    /// </summary>
    public static string ReadFile()
    {
        //string fileName = "UPDATE_USERINFO_" + currentUserName + ".SQL";
        string text = "";
        if (System.IO.File.Exists(path + "\\" + fileName))//System.IO.File.Exists("E:\\userfile\\" + fileName)
        {
            try
            {
                text = System.IO.File.ReadAllText(path + "\\" + fileName, System.Text.Encoding.UTF8);
            }
            catch (Exception err)
            {
                // throw;
            }

        }
        return text;
    }

    /// <summary>
    /// 将执行过的SQL文件移动到OLD里备份
    /// </summary>
    public static void RemoveFile(bool flag)
    {
        string NewPath = "";
        if (flag)
        {
            NewPath = path + "\\success";
            if (!Directory.Exists(path + "\\success"))
            {
                Directory.CreateDirectory(path + "\\success");
              
            }
        }
        else
        {
            NewPath = path + "\\fail";
            if (!Directory.Exists(path + "\\fail"))
            {
                Directory.CreateDirectory(path + "\\fail");
            }
        }

        string OldFile, Date;
        // string fileName = "UPDATE_USERINFO_" + currentUserName + ".SQL";
        //OldFile = Server.MapPath(".") + "\\myText.txt";
        //NewFile = Server.MapPath(".") + "\\myTextCopy.txt";
        DateTime d = System.DateTime.Now;
        Date = d.Year + d.Month.ToString("00") + d.Day.ToString("00") + "_" + d.Hour.ToString("00") + d.Minute.ToString("00");
        OldFile = path + "\\" + fileName;//"E:\\userfile\\" + fileName;
        //NewFile = path + "\\old\\" + "UPDATE_USERINFO_" + currentUserName + "_" + Date + ".SQL";//Server.MapPath("userfile") + "\\old\\" + fileName;//"E:\\userfile\\old\\" + fileName;
        NewFile = NewPath + "\\" + "UPDATE_USERINFO_" + currentUserName + "_" + Date + ".SQL";
     
        //if (File.Exists(NewFile))
        //{
        //    File.Delete(NewFile);
        //}

        try
        {
            File.Move(OldFile, NewFile);
        }
        catch (Exception err)
        {
            //throw;
        }
    }

    /// <summary>
    /// 执行读取到的SQL
    /// </summary>
    public static void ExeSql()
    {
        //while (true)
        //{
        //string path = "E:\\userfile\\";//Server.MapPath("userfile");
        int i = 0;
        while (i < 3)//如果执行3次失败的话就发送邮件
        {
            i++;
            if (Directory.Exists(path))
            {
                string[] dir = Directory.GetFiles(path);
                foreach (string name in dir)
                {
                    string sql = ReadFile();//System.IO.File.ReadAllText(name, System.Text.Encoding.UTF8);
                    if (sql != "")
                    {
                        bool y = false;
                        //string str = "server=192.168.1.3;user id=consol;password=B2e5n14-;database=USGROUP_OPERATION_TEST;pooling=true;min pool size=3;max pool size=10;packet size=3072";
                        using (SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings))
                        {
                            con.Open();
                            SqlCommand com = new SqlCommand(sql, con);
                            int x = com.ExecuteNonQuery();

                            if (x > 0)
                                y = true;
                        }

                        if (y)
                        {
                            RemoveFile(y);
                            getWork = null;
                            break;
                        }
                        else
                        {
                            if (i == 3)
                            {
                                RemoveFile(y);
                                //string email = "245135336@qq.com"; //FSecurityHelper.CurrentUserDataGET()[3];//   //Email 地址 FSecurityHelper.CurrentUserDataGET()[3]
                                //List<string> addEmail = new List<string>();
                                //foreach (string str in email.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries))
                                //    addEmail.Add(str);


                                ////MailHelper.sendMail("UserInfo modify failed", "<font color='red' size='1'>The mail sent by system, please do not reply.</font>", "245135336@qq.com", addEmail, "1494049551@qq.com", null, "1494049551@qq.com", "zxcvbnm1.", false);

                                //if (System.IO.File.Exists(NewFile))//System.IO.File.Exists("E:\\userfile\\" + fileName)
                                //{
                                //    //List<string> attachFile = new List<string>();
                                //    //attachFile.Add(NewFile);

                                //    //EmailInfo info = new EmailInfo();
                                //    info.MailSubjct = "UPDATE USER : User information updated to HKG was failed.";
                                //    info.MailBody = "<font color='red' size='1'>" + sql + "</font>";
                                //    info.MailAddress = addEmail;
                                //    info.Filename = null;
                                //    //EmailInfo.AddEmailInfo(info);
                                //}

                                string email = "245135336@qq.com";  //Email 地址 it@consol-szx.com
                                //List<string> addEmail = new List<string>();
                                //foreach (string str in email.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries))
                                //    addEmail.Add(str);

                                //string[] fileStr = filePath.Split(new string[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                //string attachFile = HttpContext.Current.Server.MapPath(filePath + ".rar");
                                //ZipApplication.ZipClass.Zip(HttpContext.Current.Server.MapPath(filePath), attachFile, null);
                                //Thread.Sleep(1000);                          

                                //DirectoryInfo di = new DirectoryInfo(HttpContext.Current.Server.MapPath(fileDire));
                                //var fileStr = di.GetFiles().OrderBy(p => p.Name);
                                //if (fileStr.Count() <= 0) return;
                                //count = fileStr.Count();

                                string FileNameList = "", FileDataList = "";

                                //foreach (FileInfo file in fileStr)
                                //{
                                //    FileNameList += file.Name + "|";
                                //    FileDataList += ConvertFile.ToBinary(file.FullName) + "|";
                                //}


                                //HttpContext.Current.Response.Write(FileDataList);
                                //FileNameList = FileNameList.TrimEnd(';');            
                                //EmailInfo info = new EmailInfo();
                                //info.MailSubjct = "CONSOL-OP: LotNo# " + lotno;
                                //info.MailBody = "<font color='red' size='1'>The mail sent by system, please do not reply.</font>";
                                //info.MailAddress = addEmail;
                                //info.Filename = attachFile;
                                //EmailInfo.AddEmailInfo(info);

                                string mailSubjct = "UPDATE USER : User information updated to HKG was failed.";
                                string mailBody = "<font color='red' size='1'>" + sql + "</font>";

                                try
                                {
                                 
                                    //string cmdText = "insert into EmailInfo (MailSubjct, MailBody, MailAddress, FileName,MailTime,MailStatus) values ('" + mailSubjct + "','" + mailBody + "','" + email + "','" + FileNameList + "',GETDATE(),0)";
                                    //SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings);
                                    //con.Open();
                                    //SqlCommand cmd = new SqlCommand(cmdText, con);
                                    //int num = cmd.ExecuteNonQuery();
                                    //con.Close();
                                    //EmailInfo e = new EmailInfo();
                                 
                                    //int j = 0;
                                    //string msg = "1";
                                    //while (msg !="" && j !=3)
                                    //{
                                    //    j++;
                                    //    Dictionary<string, string> data = new Dictionary<string, string>();
                                    //    data.Add("action", "sendmail"); //当前执行动作 
                                    //    data.Add("body", mailBody);  //邮件内容
                                    //    data.Add("subject", mailSubjct); //邮件主题
                                    //    data.Add("Address", email); // 邮件地址，多个地址用分隔符隔开
                                    //    data.Add("strFiles", FileDataList); //邮件附件，多个附件用分隔符隔开（此处不是文件地址，是将文件转化为二进制流并序列化为64位字符串）
                                    //    data.Add("fileName", FileNameList);//附件的文件名称，多个附件名用分隔符隔开（与附件个数一致）
                                    //    data.Add("separator", "|"); //分隔符
                                    //    data.Add("user", currentUserName); //执行发送邮件的用户

                                    //    msg = ExecRequest.call(data, "http://localhost:4880/Handler.ashx");
                                    //}

                                    EmailInfo e = new EmailInfo();
                                    e.StartSendEmail(mailBody, mailSubjct, email, FileDataList, FileNameList, currentUserName);
                                }
                                catch (Exception)
                                {

                                }

                            }
                            //for (int i = 0; i < 3; i++)
                            //{
                            //    ExeSql();
                            //}
                        }
                    }
                }
                //Thread.Sleep(10 * 1000); 
                //System.Threading.CancellationTokenSource cts = new CancellationTokenSource();
            }
        }

        //ReloadDate();
    }

}