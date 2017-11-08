using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using System.Text.RegularExpressions;
using System.Text;
using System.IO;
using System.Threading;

/// <summary>
///ControlBinder 的摘要说明
/// </summary>
public class ControlBinder : System.Web.UI.Page
{


    public ControlBinder()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    
    static readonly DataFactory dal = new DataFactory();

    public static string CheckMasterVoid(string seed, string type)
    {
        string str = "1";
        DataSet ds = null;
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallTransfer_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "CheckMasterVoid").
                Append("seed", seed).
                Append("type",type)}).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            str = ds.Tables[0].Rows[0][0].ToString();
        }
        return str;
    }

    public static string GetPermissionID(string type)
    {
        string permission = "P000";
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallPermissionControl_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "PermissionControl").
                Append("user", FSecurityHelper.CurrentUserDataGET()[0]).
                Append("type",type)
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            permission = ds.Tables[0].Rows[0][0].ToString();
        }
        return permission;
    }

    /// <summary>
    /// Print Log
    /// </summary>
    /// <param name="username"></param>
    /// <param name="stat"></param>
    /// <param name="sys"></param>
    /// <param name="reportname"></param>
    /// <param name="printname"></param>
    public static void PrintLog(string username, string stat, string sys, string reportname, string printname)
    {
        string getname = username.PadRight(20, '-');
        string getreport = reportname.PadRight(30, '-');
        string getprint = printname == null ? "No Name".PadRight(30, '-') : printname.PadRight(30, '-');
        string statName = stat.Replace("/", "_").ToUpper();
        string dir = HttpContext.Current.Server.MapPath("~/Report/ReportLog/" + statName + "/");
        string str = "";
        if (!Directory.Exists(dir))
        {
            Directory.CreateDirectory(dir);
        }
        string path = dir + DateTime.Now.ToString("yyyyMM") + ".txt";
        str += stat.ToUpper() + "----" + sys.ToUpper() + "------" + getreport + getprint + getname + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.fff") + "\r\n";
        try
        {
            StreamWriter fw = new StreamWriter(path, true);
            fw.Write(str);
            fw.Close();
        }
        catch
        {
        }
    }

    /// <summary>
    /// 写入OTBUG日志(就是在OB系统保存INVOICE的时候 会变成OT系统的)
    /// </summary>
    /// <param name="msg">日志内容</param>
    public void Log(string msg)
    {
        StreamWriter sw = null;
        try
        {
            sw = new StreamWriter(HttpContext.Current.Server.MapPath("~/AppLogs/OTBUGlog_" + DateTime.Now.ToString("yyyyMMdd") +".txt"), true);
            sw.WriteLine(msg + "\r\n");
        }
        catch (Exception exp)
        {
            Thread.Sleep(1000);
            sw = new StreamWriter(HttpContext.Current.Server.MapPath("~/AppLogs/OTBUGlog_" + DateTime.Now.ToString("yyyyMMdd") + ".txt"), true);
            sw.WriteLine(msg + "\r\n");
        }
        finally
        {
            sw.Close();
            sw.Dispose();
        }
    }

    /// <summary>
    /// Store 绑定
    /// </summary>
    /// <param name="store">数据源控件</param>
    /// <param name="Type">存储过程分支</param>
    public static void CmbBinder(Store store, string Type)
    {

        DataSet ds = new DataSet();

        //if (HttpContext.Current.Cache["A" + Type] == null)
        //{
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", Type).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS","A")}).GetList();
        //    HttpContext.Current.Cache.Insert("A" + Type, ds);
        //}
        store.DataSource = ds;
        store.DataBind();
    }
    
    /// <summary>
    /// Store 绑定
    /// </summary>
    /// <param name="store">数据源控件</param>
    /// <param name="Type">存储过程分支</param>
    /// <param name="SYS">当前模块  如： OI</param>
    public static void CmbBinder(Store store, string Type, string SYS)
    {
        DataSet ds = new DataSet();
        //if (HttpContext.Current.Cache[SYS+Type] == null)
        //{
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", Type).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS",SYS)}).GetList();
        //HttpContext.Current.Cache.Insert(SYS+Type, ds);
        //}
        store.DataSource = ds;
        store.DataBind();
    }


    public static void CmbBinder(Store store, string Type, bool flag)
    {
        DataSet ds = new DataSet();
        if (flag == true)
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", Type).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS","A")}).GetList();
        }
        else
        {
            if (HttpContext.Current.Cache[Type] == null)
            {
                ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", Type).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS","A")}).GetList();
                HttpContext.Current.Cache.Insert(Type, ds);
            }
        }

        store.DataSource = ds;
        store.DataBind();
    }

    /// <summary>
    /// 提示信息
    /// </summary>
    /// <param name="b">是否刷新父窗体</param>
    /// <param name="msg">提示信息</param>
    /// <param name="container">信息容器</param>
    public static void pageTitleMsg(bool b, System.Web.UI.Page page, string msg, Ext.Net.Container container)
    {
        //Regex reg = new Regex("<[^>]*>", RegexOptions.Compiled);
        //X.AddScript("document.title='" + reg.Replace(msg, "")+"';");
        string[] keys = page.Request.QueryString.AllKeys;
        foreach (string str in keys)
            if (!string.IsNullOrEmpty(str)) { b = true; break; }
        string title = b ? "Edit " : "New ";
        X.AddScript("document.title='" + title + page.Title + "';");
        container.Html = msg;
        if (b)
            X.AddScript("try{window.opener.Reload();} catch(e){}");
    }

    /// <summary>
    /// 提示信息
    /// </summary>
    /// <param name="page">当前页面 this</param>
    /// <param name="msg">提示信息</param>
    /// <param name="container">信息容器</param>
    public static void pageTitleMsg(System.Web.UI.Page page, string msg, Ext.Net.Container container)
    {
        //Regex reg = new Regex("<[^>]*>", RegexOptions.Compiled);
        bool b = false;
        //X.AddScript("document.title='" + reg.Replace(msg, "") + "';");
        string[] keys = page.Request.QueryString.AllKeys;
        foreach (string str in keys)
            if (!string.IsNullOrEmpty(str)) { b = true; break; }
        string title = b ? "Edit " : "New ";
        X.AddScript("document.title='" + title + page.Title + "';");
        container.Html = msg;
    }

    /// <summary>
    /// 提示信息
    /// </summary>
    /// <param name="b">是否刷新父窗体</param>
    /// <param name="title">框体标题信息</param>
    /// <param name="msg">信息内容</param>
    /// <param name="container">信息容器</param>
    public static void pageTitleMsg(bool b, string title, string msg, Ext.Net.Container container)
    {
        X.AddScript("document.title='" + title + "';");
        container.Html = msg;
        if (b)
            X.AddScript("try{window.opener.Reload();} catch(e){}");
        
        //X.AddScript("if(this.opener==undefined){}else{this.opener.location.reload()}");
    }

    
    public static object getDate(object date)
    {
        string value = string.Empty;
        string Format = "dd/m/Y";
        if (!string.IsNullOrEmpty(date.ToString()))
        {
            string[] str = date.ToString().Split('/');
            if (str.Length != 3)
                str = date.ToString().Split('-');

            if (str.Length == 3)
            {
                if (str[0].Length == 4)
                    value = str[0] + "/" + str[1] + "/" + str[2];
                else
                {
                    //if (Format == "dd/m/Y")
                    //value = str[2] + "/" + str[1] + "/" + str[0];
                    //else if (Format == "m/dd/Y")
                    //    value = str[2] + "/" + str[1] + "/" + str[0];
                    if (Format == "dd/m/Y")
                        value = str[2] + "/" + str[1] + "/" + str[0];
                    else if (Format == "m/dd/Y")
                        value = str[2] + "/" + str[0] + "/" + str[1];

                }
                return value;
            }
            return DBNull.Value;
        }
        else
            return DBNull.Value;
    }



    #region 日期地区格式化 默认为dd/M/Y

    /// <summary>
    /// 日期地区格式化 默认为dd/M/Y
    /// </summary>
    /// <param name="dateField">日期控件</param>
    public static void DateFormat(DateField dateField)
    {

        string Format = "dd/m/Y";
        string AltFormats = string.Empty;
        switch (Format)
        {
            case "dd/m/Y":
                AltFormats = "d/M/Y|d/M|d/M/y|ddmY|ddm|ddmy";
                break;
            case "m/dd/Y":
                AltFormats = "M/d/Y|M/d|M/d/y|mddY|mdd|mddy";
                break;
            case "Y/m/dd":
                AltFormats = "Y/M/d|M/d|y/M/d|Ymdd|mdd";
                break;
            default:
                Format = "m/dd/Y";
                AltFormats = "M/d/Y|M/d|M/d/y|mddY|mdd|mddy";
                break;
        }
        dateField.Format = Format;
        dateField.AltFormats = AltFormats;
    }
    #endregion


    /// <summary>
    /// 获取本地外国货币和汇率
    /// </summary>
    /// <param name="type">f 外国  l 本地  exf ，exl</param>
    /// <param name="sys"></param>
    /// <returns></returns>
    public static string getCurrency(string type, string sys)
    {
        string str = string.Empty;
        try
        {
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Item_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "currency")
        .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
        .Append("SYS",sys[0].ToString())//FSecurityHelper.CurrentUserDataGET()[11].Substring(0,1))
        }).GetTable();
            if (dt != null && dt.Rows.Count > 0)
            {
                str = dt.Rows[0][type].ToString();
            }
        }
        catch
        {
            str = "";
        }
        return str;
    }



    /// <summary>
    /// 更新新的lotNo
    /// </summary>
    /// <param name="code">sys 如果是invoice 还要加上DN或CN</param>
    /// <param name="seed">SeedID</param>
    /// <param name="date">ETD时间，根据这个时间来决定是否</param>
    /// <returns></returns>
    public static string GetNewLotNo(string code, string seed, object date)
    {
        string lotNo = "-1";
        string l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysUpdateLotNo_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "CheckIsAC")
            .Append("seed",seed).Append("code",code)}).GetTable().Rows[0][0].ToString();
        if (l == "0")//表示没有COST过账 即：ISAC=1的记录为0条
        {
            string code1 = (FSecurityHelper.CurrentUserDataGET()[12].Length > 3) ? FSecurityHelper.CurrentUserDataGET()[12].Substring(4, 3) : FSecurityHelper.CurrentUserDataGET()[12];
            lotNo = dal.FactoryDAL(PageHelper.ConnectionStrings, "[FW_SysUpdateLotNo_SP]", new List<IFields>() { dal.CreateIFields()
           
            .Append("code",code1+code)//FSecurityHelper.CurrentUserDataGET()[4].ToString()+code
            .Append("seed",seed)
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("user",FSecurityHelper.CurrentUserDataGET()[0].ToString())
            .Append("date",date)               

            }).GetTable().Rows[0][0].ToString();
        }
        return lotNo;
    }


    /// <summary>
    /// 判断是否显示更新按钮
    /// </summary>
    /// <param name="etd">etd时间 获取月份</param>
    /// <param name="lotNo">lotNo 获取月份</param>
    /// <returns></returns>
    public static bool IsDisplayLotNo(string etd, string lotNo)
    {

        bool b = true;
        int span1 = 0;
        int span11 = 0;
        int span2 = 0;
        int span22 = 0;
        if (string.IsNullOrEmpty(lotNo)) return false;
        if (string.IsNullOrEmpty(etd)) return false;
        try
        {
            span1 = Convert.ToDateTime(etd).Month;
            span11 = Convert.ToInt32(Convert.ToDateTime(etd).ToString("yyyy").Substring(2));
            span2 = Convert.ToInt32(lotNo.Substring(7, 2));
            span22 = Convert.ToInt32(lotNo.Substring(5, 2));
        }
        catch (Exception)
        {
            span2 = Convert.ToInt32(lotNo.Substring(11, 2));
            span22 = Convert.ToInt32(lotNo.Substring(9, 2));
        }

        if ((span1 == span2) && (span11 == span22))
            b = false;
        return b;
    }


    /// <summary>
    /// 创建gridList
    /// </summary>
    /// <param name="dt">数据源</param>
    /// <param name="header">表头</param>
    /// <param name="field">绑定字段</param>
    /// <param name="msg">没有数据时要发送的提示</param>
    public static string gridHtml(DataTable dt, string[] header, string[] field, string msg)
    {
        StringBuilder content = new StringBuilder();

        if (dt == null || dt.Rows.Count == 0)
        {   
            content.Append("<p style=\"text-align:center;line-height:30px;border:solid 1px #99BBE8;\">" + msg + "</p>");
        }
        else
        {
            if (header.Length != field.Length)
                content.Append("<p style=\"text-align:center;line-height:30px;border:solid 1px #99BBE8;\">表头与绑定字符串长度不一致，请检查数据！！！</p>");
            else
            {
                try
                {
                    content.Append("<link href=\"/css/gridHtml.css\" rel=\"stylesheet\" type=\"text/css\" />");
                    content.Append("<table  class=\"table_grid\"  cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n<tr class=\"td_header\">\r\n");
                    for (int i = 0; i < header.Length; ++i)
                    {
                        content.Append("<td>" + header[i].ToString() + "</td>\r\n");
                    }
                    content.Append("</tr>\r\n");
                    for (int i = 0; i < dt.Rows.Count; ++i)
                    {
                        content.Append("<tr class=\"tr_line\">\r\n");

                        for (int j = 0; j < field.Length; ++j)
                        {
                            string[] str = field[j].Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
                            if (str.Length > 1)
                            {
                                content.Append("<td>\r\n");
                                for (int n = 0; n < str.Length; ++n)
                                {
                                    content.Append(dt.Rows[i][str[n]].ToString() + "</br>");
                                }
                                content.Append("</td>\r\n");

                            }
                            else
                            {
                                content.Append("<td>" + dt.Rows[i][field[j]].ToString() + "</td>\r\n");
                            }
                        }
                        content.Append("</tr>\r\n");

                    }
                    content.Append("</table>\r\n");

                }
                catch (Exception exp)
                {
                    content.Remove(0, content.Length);
                    content.Append(exp.Message);
                }
            }
        }

        return content.ToString();

    }

    public static string GetCostTotal(string seed)
    {
        StringBuilder content = new StringBuilder();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","GetCostTotal").
            Append("seed",seed)
        }).GetTable();

        if (dt.Rows[0][0].ToString() == "N")
        {
            content.Append("No Data");
        }
        else
        {
            content.Append("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
            content.Append("<tr style=\"line-height:24px;\"><td style=\"width:50px;text-align:center;\"><b>A/L</b></td><td  style=\"text-align:center;width:80px;\"><b>Company</b></td><td style=\"text-align:center;width:50px;\"><b>Curreny</b></td><td  style=\"text-align:center;width:80px;\"><b>Amount</b></td><td  style=\"text-align:center;width:80px;\"><b>Total</b></td></tr>");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                content.Append("<tr style=\"line-height:24px;\"><td style=\"width:50px;padding-left:5px;\">" + dt.Rows[i]["si_PPCC"].ToString() + "</td><td  style=\"text-align:left;width:80px;padding-left:5px;\">" + dt.Rows[i]["si_BillTo"].ToString() + "</td><td style=\"text-align:center;width:50px;\">" + dt.Rows[i]["si_Currency"].ToString() + "</td><td  style=\"text-align:right;width:80px;padding-right:5px;\">" + dt.Rows[i]["Amount"].ToString() + "</td><td  style=\"text-align:right;width:80px;padding-right:5px;\">" + dt.Rows[i]["Total"].ToString() + "</td></tr>");
            }
            content.Append("</table>");
        }

        return content.ToString();
    }
    /// <summary>
    /// 更新Cost数据
    /// </summary>
    /// <param name="seed"></param>
    /// <param name="sys"></param>
    /// <param name="type"></param>
    public static void UpdateCostData(string seed,string sys,string type)
    {
        dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallUpdateCost_SP", new List<IFields>() { dal.CreateIFields()
            .Append("seed",seed)
            .Append("Sys",sys)
            .Append("Type",type)            
        }).Update();
    }
    
    /// <summary>
    /// 处理字符串函数
    /// </summary>
    /// <param name="str">字符串</param>
    /// <param name="count">截取长度</param>
    /// <returns></returns>
    public static string GetMakeStr(string str,int count)
    {
        string newstr = "", str1 = "", str2 = "";
        int index = count;
        string[] strSplit = str.Replace("\t","").Replace("\r\n", "\n").Replace("\n","^").Split('^');
        for (int i = 0; i < strSplit.Length; i++)
        {
            if (IsChinese(strSplit[i]))
            {
                #region 中文处理
                if (IsFlagCount(strSplit[i],count))
                {
                    str1 = strSplit[i];
                    while (str1.Length > 0)
                    {
                        if (IsFlagCount(str1,count))
                        {
                            int[] getChineseInfo = GetChineseInfo(str1, count);
                            str2 = str1.Substring(0, getChineseInfo[1] + 1);
                            int[] getindex = GetIndex(str2);
                            index = getindex[1];
                            if (getindex[0] == 0||getChineseInfo[1]==getChineseInfo[2])
                            {
                                newstr += str2 + "\n";
                                index = getChineseInfo[1]+1;
                                str1 = str1.Substring(index, str1.Length - index);
                            }
                            else if (getindex[0] == 1)
                            {
                                newstr += str2.Substring(0, index + 1) + "\n";
                                str1 = str1.Substring(index + 1, str1.Length - index - 1);
                            }
                            else
                            {
                                newstr += str2.Substring(0, index) + "\n";
                                str1 = str1.Substring(index, str1.Length - index);
                            }
                            //newstr += str2 + "\n";
                            //str1 = str1.Substring(getChineseInfo[1] + 1, str1.Length - getChineseInfo[1]-1);
                        }
                        else
                        {
                            newstr += str1 + "\n";
                            str1 = "";  
                        }
                    }
                }
                else
                {
                    newstr += strSplit[i] + "\n";
                }
                #endregion
            }
            else
            {
                #region 英文处理
                if (strSplit[i].Length > count)
                {
                    str1 = strSplit[i];
                    while (str1.Length > 0)
                    {
                        if (str1.Length > count)
                        {
                            str2 = str1.Substring(0, count);
                            int[] getindex = GetIndex(str2);
                            index = getindex[1];
                            if (getindex[0] == 0)
                            {
                                newstr += str2 + "\n";
                                index = count;
                                str1 = str1.Substring(index, str1.Length - index);
                            }
                            else if (getindex[0] == 1)
                            {
                                newstr += str2.Substring(0, index + 1) + "\n";
                                str1 = str1.Substring(index + 1, str1.Length - index - 1);
                            }
                            else
                            {
                                newstr += str2.Substring(0, index) + "\n";
                                str1 = str1.Substring(index, str1.Length - index);
                            }
                        }
                        else
                        {
                            newstr += str1 + "\n";
                            str1 = "";
                        }
                    }
                }
                else
                {
                    newstr += strSplit[i] + "\n";
                }
                #endregion
            }
        }
        if (newstr.EndsWith("\n"))
        {
            newstr = newstr.Substring(0, newstr.Length - 1);
        }
        return newstr;
    }
    
    /// <summary>
    /// 判断是否为中文
    /// </summary>
    /// <param name="str">字符串</param>
    /// <returns></returns>
    public static bool IsChinese(string str)
    {
        bool isFlag = false;
        for (int i = 0; i < str.Length; i++)
        {
            //Regex rx = new Regex("^[\u4e00-\u9fa5]$");
            Regex rx = new Regex("^[^\x00-\xff]$");
            if (rx.IsMatch(str.Substring(i, 1)))
            {
                isFlag = true;
                break;
            }
        }
        return isFlag;
    }
    
    /// <summary>
    /// 字符串是否超过一定长度
    /// </summary>
    /// <param name="str"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    public static bool IsFlagCount(string str,int count)
    {
        int cnCount = 0;
        bool flag=false;
        for (int i = 0; i < str.Length; i++)
        {
            Regex rx = new Regex("^[^\x00-\xff]$");
            if (rx.IsMatch(str.Substring(i, 1)))
            {
                cnCount += 1;
            }
        }
        if (count == 10)
        {
            if (cnCount > 6||GetCount(cnCount,count)+(str.Length-cnCount)>count)
            {
                flag = true;
            }
        }
        else if (count == 19)
        {
            if (cnCount > 11 || GetCount(cnCount, count) + (str.Length - cnCount) > count)
            {
                flag = true;
            }
        }
        else if (count == 46)
        {
            if (cnCount > 26 || GetCount(cnCount, count) + (str.Length - cnCount) > count)
            {
                flag = true;
            }
        }
        else
        {
            if (cnCount > count / 2)
            {
                flag = true;
            }
        }

        return flag;
    }
    /// <summary>
    /// 处理含中文信息
    /// </summary>
    /// <param name="str"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    public static int[] GetChineseInfo(string str,int count)
    {
        int[] cninfo = new int[3];
        //是否有中文
        cninfo[0] = 0;
        //一定长度字符串最后一个字符索引位置
        cninfo[1] = 0;
        //最后一个中文索引位置
        cninfo[2] = 0;
        //字符总长度
        int total = 0;
        //中文个数
        int cncount = 0;
        //英文字符个数
        int encount = 0;
        
        for (int i = 0; i < str.Length; i++)
        {
            if (total < count)
            {
                Regex rx = new Regex("^[^\x00-\xff]$");

                if (rx.IsMatch(str.Substring(i, 1)))
                {
                    cninfo[0] = 1;
                    cninfo[2] = i;
                    cncount += 1;
                }
                else
                {
                    encount += 1;
                }
                total = encount + GetCount(cncount,count);
                if (total >= count)
                {
                    cninfo[1] = i;
                }
                
            }
            else
            {
                break;
            }
        }
        return cninfo;
    }
    public static int rate(int count,int total)
   {
       int rate = 0;
       switch (total)
       {
           case 10:
               rate = count == 0 ? 0 : (int)Math.Round(count * 10 * 1.0 / 6, 0);
               break;
           case 19:
               rate = count == 0 ? 0 : (int)Math.Round(count * 19 * 1.0 / 11, 0);
               break;
           case 46:
               rate = count == 0 ? 0 : (int)Math.Round(count * 46 * 1.0 / 26, 0);
               break;
           default:
               rate = count;
               break;
       }
       return rate;
   }
    /// <summary>
    /// 中文所占字符数
    /// </summary>
    /// <param name="count"></param>
    /// <returns></returns>
    public static int GetCount(int index,int count)
    {
        int[] str = null;
        if (count == 10)
        {
            str = new int[] {0,2,3,5,7,8,10};
        }
        else if (count == 19)
        {
            str =new int[] {0,2,3,5,7,8,10,12,14,15,17,19};
        }
        else if (count == 46)
        {
            str = new int[] { 0, 2, 4, 5, 7, 9, 11, 12, 14, 16, 17, 19, 21, 23, 24, 26, 28, 29, 31, 33, 35, 36, 38, 40, 41, 43, 45,46};
        }
        else
        {
            str[index] = index * 2;
        }
        return str[index];
    }
    /// <summary>
    /// 分隔符索引位置
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static int[] GetIndex(string st)
    {
        string str=st;
        int[] index =new int[2];
        index[0] = 0;
        index[1] = 0;
        string char3 = "!,%,-,},],?,), ,(,[,{"; 
        string[] chars3 = char3.Split(',');
        bool flag = false;
        for (int m = 0; m < chars3.Length; m++)
        {
            if (str.TrimEnd().Contains(chars3[m])&&!str.StartsWith(chars3[m]))
            {
                flag = true;
                break;
            }
        }
        if (flag == true)
        {
            int temp1 = 0;
            int temp2 = 0;
            
            //string te = "";
            string char1 = "!,%,-,},],?,), ";
            string char2 = "(,[,{";
            //string char4=" :| ;| \"| \'| ,| .| /";
            string[] chars1 = char1.Split(',');
            string[] chars2 = char2.Split(',');
            //string[] chars4 = char4.Split('|');

            //for (int d = 0; d < chars4.Length; d++)
            //{
            //    if (str.Contains(chars4[d]) && str.LastIndexOf(chars4[d]) > 0)
            //    {
            //        for (int f = str.LastIndexOf(chars4[d]); f < str.LastIndexOf(chars4[d]) + 1; f--)
            //        {
            //            if (str.Substring(f, 1) == " ")
            //            {
            //                te += f.ToString() + ",";
            //            }
            //            else
            //            {
            //                break;
            //            }
            //        }
            //    }
            //}
            
            for (int i = 0; i < chars1.Length; i++)
            {
                //if(chars1[i]==" "&&FlagIndex(str.LastIndexOf(chars1[i]),te))
                //{
                //    continue;
                //}else
                 if (str.LastIndexOf(chars1[i]) >= temp1)
                {
                    temp1 = str.LastIndexOf(chars1[i]);
                }

            }
            for (int j = 0; j < chars2.Length; j++)
            {
                if (str.LastIndexOf(chars2[j]) >= temp2 && !str.StartsWith(chars2[j]))
                {
                    temp2 = str.LastIndexOf(chars2[j]);
                }
            }
            
            if (temp1 >= temp2)
            {
                index[0] = 1;
                index[1] = temp1;
            }
            else
            {
                index[0] = 2;
                index[1] = temp2;
            }
        }
        else
        {
            index[0] = 0;
            index[1] = 0;
        }
        return index;
        
    }

    public static bool FlagIndex(int f,string st)
    {
        bool flag = false;
        string str = st;
        if(str.Length>1)
        {
            str=str.Substring(0,str.Length-1);
        }
        string[] strs = str.Split(',');
        for (int i = 0; i < strs.Length; i++)
        {
            if (f.ToString() == strs[i])
            {
                flag = true;
                break;
            }
        }
        return flag;
    }

    /// <summary>
    /// 绑定CheckBoxGroup绑定(来源表FW_COMPANY) (2014-09-24)
    /// </summary>
    /// <param name="chk">数据源控件</param>
    public static void ChkGroupBind(CheckboxGroup chk)
    {
        DataTable dsCheckBoxGroup = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_FW_COMPANY_BindCheck_SP").GetTable();
        if (dsCheckBoxGroup != null && dsCheckBoxGroup.Rows.Count > 0)
        {
            foreach (DataRow dr in dsCheckBoxGroup.Rows)
            {
                chk.Items.Add(new Checkbox() { Value = dr[1].ToString(), Tag = dr[1].ToString().Trim(), BoxLabel = dr[0].ToString(), LabelAlign = LabelAlign.Right, LabelWidth = 45, Checked = true });
            }
        }
        else
        {
            chk.Items.Add(new Checkbox());
            chk.Hide();
            
            //chk.Dispose();
            //chk.Destroy();
        }

		string dept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
		if (dept == "OP" || dept == "ACCOUNT")
        {
			chk.Hide();
		}
    }
}
