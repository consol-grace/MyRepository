using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;
using System.Threading;

/// <summary>
/// Summary description for PrintZanSetting
/// </summary>
public class PrintZanSetting
{
    public PrintZanSetting()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    private readonly static string filePath = @"C:\Users\Public\Documents\zvprt50\";
    private readonly static string appPath = HttpRuntime.AppDomainAppPath+"PRINTFILE.BAT";


    public static void PrintSetting(string printName, string folderPath, string fileName, string filetype)
    {
        PrintSettingSave(printName, folderPath, fileName);
        //PrintSettingApp(printName, folderPath +"\\"+ fileName + "." + filetype + ".temp");
    }

    private static void PrintSettingSave(string printName, string folderPath, string fileName)
    {
        string path = filePath + printName + "\\save.ini";

        Dictionary<string, string> list = new Dictionary<string, string>();
        list.Add("folder=", folderPath);
        list.Add("basefilename=", fileName);
        ReadandWriter(path, printName, list);

    }


    private static void PrintSettingApp(string printName, string parameters)
    {
        string path = filePath + printName + "\\app.ini";

        Dictionary<string, string> list = new Dictionary<string, string>();
        list.Add("name=", appPath);
        list.Add("parameters=", parameters);
        list.Add("enableapp=", "1");
        list.Add("rundefaultapp=", "0");
        list.Add("waitappcompletion=", "0");
        list.Add("apptimeoutinterval=", "1");
        ReadandWriter(path, printName, list);
    }




    private static void ReadandWriter(string path, string printName, Dictionary<string, string> list)
    {
        try
        {
            StreamReader sr = new StreamReader(path);
            string content = "", line = "";
            while (sr.Peek() != -1)
            {
                line = sr.ReadLine();
                foreach (string key in list.Keys)
                {
                    if (line.StartsWith(key))
                        line = key + list[key];
                }

                content += line + "\r\n";

            }

            sr.Close();
            sr.Dispose();

            StreamWriter sw = new StreamWriter(path, false);
            sw.Write(content);
            sw.Close();
            sw.Dispose();
        }
        catch (Exception exp)
        {
            PrinterLOG.WriterLog(exp.Message, "_PrintSetting_" + printName, false);
        }
    }

}