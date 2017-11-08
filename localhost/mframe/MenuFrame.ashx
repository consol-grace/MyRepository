<%@ WebHandler Language="C#" Class="MenuFrame" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.FRAMEWORK;
using System.Data;
using DIYGENS.COM.DBLL;
using System.Text;
using System.Web.Security;

public class MenuFrame : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.AddHeader("pragma", "no-cache");
        HttpContext.Current.Response.AddHeader("cache-control", "private");
        HttpContext.Current.Response.CacheControl = "no-cache";
        GetMenuList(context.Request["key"].ToUpper());
    }


    public void GetMenuList(string key)
    {
        string strContent = "<script src='/common/Global/TopMenu.js' type='text/javascript'></script>";
        var linq = GetMenu().Tables[0].AsEnumerable().Count(p => p.Field<string>("MenuID") == "MBD");
        if (linq == 1)
        {
            //var list3 = GetMenu().Tables[1].AsEnumerable().Where(p => p.Field<string>("ParentID") == "MBD").Where(p => p.Field<string>("Remark") =="").Where(p => p.Field<string>("Remark").Contains(key)).ToList();
            var list3 = (from lq in GetMenu().Tables[1].AsEnumerable() where lq.Field<string>("ParentID") == "MBD" && (lq.Field<string>("Remark") == "" || lq.Field<string>("Remark").ToUpper().Contains(string.IsNullOrEmpty(key) ? "NULL" : key)) select lq).ToList();

            if (list3.Count > 0)
            {

                if (string.IsNullOrEmpty(key))
                {
                    strContent += "<div id='div_content' style='position:absolute;top:43px;left:700px;'><table align='center'>\r\n";

                    strContent += "<tr>\r\n";
                    foreach (DataRow row in list3)
                    {
                        string dep = FSecurityHelper.CurrentUserDataGET()[28];

                        if (!(dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN") && (row["NameENG"].ToString().ToUpper() == "LOCATION" || row["NameENG"].ToString().ToUpper() == "USER"))
                        { continue; }

                        if (!Convert.ToBoolean(FSecurityHelper.CurrentUserDataGET()[25]) && row["NameENG"].ToString() == "核 销 单")
                        {
                            continue;
                        }

                        if (row["NameENG"].ToString().Length > 8)
                        {
                            strContent += @"<td align='center'><span class='menu_btn_02' align='center'>" + "<a  href=\"javascript:void(0)\" onclick='CompanyX.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + HttpContext.Current.Request["key"] + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                        }
                        else if (row["NameENG"].ToString() == "核 销 单")
                        {
                            strContent += @"<td align='center'><span class='menu_btn' align='center'>" + "<a  style='font-family:微软雅黑; font-size: 10px !important;' href=\"javascript:void(0)\" onclick='CompanyX.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + HttpContext.Current.Request["key"] + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                        }
                        else
                        {
                            strContent += @"<td align='center'><span class='menu_btn' align='center'>" + "<a  href=\"javascript:void(0)\" onclick='CompanyX.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + HttpContext.Current.Request["key"] + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                        }
                    }
                    strContent += "</tr>\r\n";
                    strContent += "</table></div>";

                }
                else
                {
                    string div = string.Empty;
                    strContent += "<div id='div_content' style='position:absolute;top:17px;right:8px; '><table border='0'>\r\n<tr algin='center'>\r\n";
                    div = "<div id='div' class='menu_bg_01' style= 'display:none;position:absolute;right:-5px; z-index:99 '><table border='0' align='center'>";
                    foreach (DataRow row in list3)
                    {
                        string dep = FSecurityHelper.CurrentUserDataGET()[28];

                        if (!(dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN") && (row["NameENG"].ToString().ToUpper() == "LOCATION" || row["NameENG"].ToString().ToUpper() == "USER"))
                        { continue; }

                        if (!Convert.ToBoolean(FSecurityHelper.CurrentUserDataGET()[25]) && row["NameENG"].ToString() == "核 销 单")
                        {
                            continue;
                        }

                        if (row["flag"].ToString() == "1")
                        {
                            if (row["NameENG"].ToString().ToUpper() == "COMBINE COST")
                            {
                                strContent += @"<td align='center'><span class='menu_btn_02' align='center'>" + "<a  href=\"javascript:void(0)\" onclick='CompanyX.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + HttpContext.Current.Request["key"] + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                            }
                            else if (row["NameENG"].ToString() == "核 销 单")
                            {
                                strContent += @"<td align='center'><span class='menu_btn' align='center'>" + "<a  style='font-family:微软雅黑; font-size: 10px !important;' href=\"javascript:void(0)\" onclick='CompanyX.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + HttpContext.Current.Request["key"] + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                            }
                            else 
                            {
                                strContent += @"<td align='center'><span class='menu_btn' align='center'>" + "<a  href=\"javascript:void(0)\" onclick='CompanyX.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + HttpContext.Current.Request["key"] + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                            }
                        }
                        else
                        {
                            div += @"<tr><td class='menu_btn_02' style='padding-top:2px' align='center'>" + "<a  href=\"javascript:void(0)\" onclick='CompanyX.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + HttpContext.Current.Request["key"] + "\")'>" + row["NameENG"] + "</a></td></tr>";
                        }
                    }
                    div += "<tr><td class='menu_bg_02' style='position:absolute;left:0px;bottom:-10px;'></td></tr></table></div>";
                    strContent += "\r\n<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div id='outer'style='position:absolute;top:26px; z-index:99; text-align:right;'><img src='/images/menu/down_01.png' id='img'/>" + div + "</div></td></tr>\r\n</table></div>";

                }

            }
        }
        HttpContext.Current.Response.Write(strContent);
    }

    /// <summary>
    /// 获取菜单
    /// </summary>
    /// <returns></returns>
    private DataSet GetMenu()
    {
        DataFactory dal = new DataFactory();
        string MenuList = MenuHelper.GetMenu("MenuList");  // FSecurityHelper.CurrentUserDataGET()[14]; // menu array list
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "user-get-menu")
            .Append("IDlist", MenuList)
        }).GetList();
        return ds;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}