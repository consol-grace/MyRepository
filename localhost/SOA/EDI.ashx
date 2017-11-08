<%@ WebHandler Language="C#" Class="EDI" %>

using System;
using System.Web;
using System.Net.EDI;

public class EDI : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        var urlReferrer = context.Request.UrlReferrer;
        //if (urlReferrer == null || urlReferrer.Host != context.Request.Url.Host)
        //{
        //    context.Response.Write("{\"code\":\"400\",\"message\":\"无效请求\"}");
        //    return;
        //}


        string action = string.IsNullOrEmpty(context.Request["action"]) ? "" : context.Request["action"];
        ExecSQL(context);

        if (action.ToUpper() == "CREATEEDILOG")
            CreateEDILog(context);
        else if (action.ToUpper() == "CREATEFILE")
            CreateEDIFile(context);
        else if (action.ToUpper() == "USERINFO")
            SelectUserInfo(context);
        else if (action.ToUpper() == "EXECSQL")
            ExecSQL(context);
        else if (HttpUtility.UrlDecode(action).ToUpper() == "SAVEFILE")
            SaveFile(context);
    }


    /// <summary>
    /// 写入日志到表
    /// </summary>
    /// <param name="context"></param>
    public void CreateEDILog(HttpContext context)
    {
        string param = context.Request["param"];
        EDIEntity edi = EDIDateConvert<EDIEntity>.DeserializeJSON(param);
        string msg = System.Net.EDI.EDILOG.UpdateLog(edi);
        context.Response.Write(msg);
    }


    /// <summary>
    /// 生成EDI XML文件
    /// </summary>
    /// <param name="context"></param>
    public void CreateEDIFile(HttpContext context)
    {
        string stat = context.Request["stat"];
        string sys = context.Request["sys"];
        string seed = context.Request["seed"];
        string groupid = context.Request["groupid"];
        string user = context.Request["user"];
        string Vtype = "P";// context.Request["Vtype"];

        System.Net.EDI.EDIFile edifile = new System.Net.EDI.EDIFile();
        string msg = edifile.CreateFile(seed, groupid, stat, sys, user, Vtype);

        //EDIMessageEntity edi = EDIDateConvert<EDIMessageEntity>.DeserializeJSON(msg);

        context.Response.Write(msg);
    }


    /// <summary>
    /// 获取用户信息
    /// </summary>
    /// <param name="context"></param>
    public void SelectUserInfo(HttpContext context)
    {
        string value = context.Request["value"];
        context.Response.Write(UserInfo.GetUserInfo(value));
    }

    /// <summary>
    /// 保存文件到本地
    /// </summary>
    public void SaveFile(HttpContext context)
    {
        try
        {
            string content = HttpUtility.UrlDecode(context.Request["content"]);        //文件内容     
            string fileName = HttpUtility.UrlDecode(context.Request["filename"]);      //文件名 
            string filepath = HttpUtility.UrlDecode(context.Request["filepath"]);      //文件路径
            string dir = HttpUtility.UrlDecode(context.Request["dir"]);                //文件目录
            string actionType = HttpUtility.UrlDecode(context.Request["actionType"]);  //覆盖或者备份
            string backupDir = HttpUtility.UrlDecode(context.Request["backupDir"]);    //备份的文件夹

            filepath = filepath[filepath.Length - 1] == '\\' ? filepath : filepath + "\\";
            dir = dir[dir.Length - 1] == '\\' ? dir : dir + "\\";

            if (!System.IO.Directory.Exists(filepath + dir))
                System.IO.Directory.CreateDirectory(filepath + dir);

            string str = "";
            if (actionType == "BUCKUP")     //备份
            {
                backupDir = backupDir[backupDir.Length - 1] == '\\' ? backupDir : backupDir + "\\";
                backupDir = filepath + dir + backupDir;
                if (!System.IO.Directory.Exists(backupDir))
                    System.IO.Directory.CreateDirectory(backupDir);

                str = fileName.Substring(0, fileName.LastIndexOf("_"));
                string[] files = System.IO.Directory.GetFiles(filepath + dir, str + "*.xml");
                foreach (string f in files)
                {
                    string name = System.IO.Path.GetFileName(f);
                    System.IO.File.Move(f, backupDir + name);
                }
            }

            System.IO.StreamWriter sw = new System.IO.StreamWriter(filepath + dir + fileName, false);
            sw.Write(content);
            sw.Close();
            sw.Dispose();
            context.Response.Write("");
        }
        catch (Exception exp)
        {
            context.Response.Write(exp.Message);
        }
    }

    public void ExecSQL(HttpContext context)
    {
        System.Net.EDI.EDIFile.ExecSQL(); 
    }
    
    
    
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}