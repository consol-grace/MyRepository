using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Threading;


//———————————————————————
//Author        ：Michael Chien
//Create Date   ：2012-12-21
//Description   ：实现文件文件夹操作
//———————————————————————

/// <summary>
///MoveFile 的摘要说明
/// </summary>
public class MoveFile
{
    public MoveFile()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    public MoveFile(string _NewFolder)
    {
        NewFolder = _NewFolder;
    }

    public string NewFolder = @"/Preview";


    /// <summary>
    /// 处理生成的文件，并且返回新文件路径
    /// </summary>
    /// <param name="filepath"></param>
    /// <param name="fileName"></param>
    /// <returns></returns>
    public string GetFilePath(string filePath)
    {
        string _NewFilePath = "";
        if (Exists(filePath))
        {
            string[] _path = filePath.Split(new string[] { "\\" }, StringSplitOptions.RemoveEmptyEntries);
            string fileName = _path[_path.Length - 1];
            //fileName = fileName.Replace("_", "\\");
            //fileName = fileName.Insert(fileName.IndexOf("_"), "\\");
            //fileName = fileName.Remove(fileName.IndexOf("_"), 1);

            string lotno = fileName.Substring(0, 12);
            fileName = fileName.Insert(12, "_");
            fileName = fileName.Replace("__", "_");
            fileName = fileName.Replace("_ ", "_");
            fileName = lotno + "\\" + fileName;

            _NewFilePath = NewFolder + "\\" + fileName;

            CopyFile(filePath, HttpContext.Current.Server.MapPath(_NewFilePath));
        }
        return _NewFilePath;
    }


    /// <summary>
    /// 创建文件夹
    /// </summary>
    /// <param name="filePath">文件路径</param>
    public void CreateDirectory(string filePath)
    {
        string _strpath = null;
        string[] st = filePath.Split(new string[] { "\\" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            for (int l = 0; l < st.Length - 1; ++l)
            {
                _strpath += st[l] + "\\";
                if (!Directory.Exists(_strpath))
                    Directory.CreateDirectory(_strpath);
            }
        }
        catch (Exception exp)
        {
            PrinterLOG.WriterLog(exp.Message, "CreateDirectory", true);
        }
    }


    /// <summary>
    /// 复制文件
    /// </summary>
    /// <param name="filePath">要复制的文件地址</param>
    /// <param name="NfilePath">新的文件地址</param>
    public void CopyFile(string filePath, string NfilePath)
    {
        CreateDirectory(NfilePath);
        //int i = 1;
        while (Exists(filePath) && !Exists(NfilePath))
        {
            try
            {
                //Thread.Sleep(i * 100);
                File.Move(filePath, NfilePath);
                //++i;
            }
            catch (Exception exp)
            {
               // PrinterLOG.WriterLog(exp.Message, "CopyFile", true);
            }
        }

    }


    /// <summary>
    /// 删除文件
    /// </summary>
    /// <param name="filePath">文件完整名称 包含前面的 LotNo</param>
    public void DeleteFile(string filePath)
    {

        filePath = filePath.Substring(filePath.LastIndexOf("\\") + 1);
        string lotNo = "", filename = "";
        if (!string.IsNullOrEmpty(filePath))
        {
            //lotNo = filePath.Substring(0, filePath.IndexOf("_"));
            lotNo = filePath.Substring(0, 12);
            filename = filePath.Insert(12, "_");
            filename = filename.Replace("__", "_");
            filename = filename.Replace("_ ", "_");
            //filename = lotNo + "_" + filePath.Substring(filePath.IndexOf("_") + 1);
            if (Directory.Exists(HttpContext.Current.Server.MapPath(NewFolder + "//" + lotNo)))
            {
                string[] file = Directory.GetFiles(HttpContext.Current.Server.MapPath(NewFolder + "//" + lotNo), filename.Insert(filename.LastIndexOf("."), "*"));
                foreach (string str in file)
                {
                    if (File.Exists(str))
                    {
                        File.Delete(str);
                    }
                }
            }
        }

    }


    /// <summary>
    /// 获取所有相关文件
    /// </summary>
    /// <param name="url"></param>
    /// <returns></returns>
    public string[] GetFilelist(string url)
    {
        try
        {
            url = HttpContext.Current.Server.MapPath(url);

            string path = url.Substring(0, url.LastIndexOf("\\"));
            string name = url.Substring(url.LastIndexOf("\\") + 1);
            string[] filelist = Directory.GetFiles(path, name.Insert(name.LastIndexOf("."), "*"));
            return filelist;
        }
        catch (Exception exp)
        {
            PrinterLOG.WriterLog(exp.Message, "GetFilelist", true);
            return new string[] { "" };
        }
    }


    /// <summary>
    /// 文件是否存在
    /// </summary>
    /// <param name="filePath">文件路径</param>
    /// <returns></returns>
    public bool Exists(string filePath)
    {
        return File.Exists(filePath);
    }

}