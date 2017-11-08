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
using Ext.Net;

public partial class common_UIControls_UserControlTop : System.Web.UI.UserControl
{

    protected System.Data.DataView dview, dview1;
    protected int firstCount = 0;
    protected string UserName = "";

    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public string sys
    {
        get { return ViewState["key"] as string; }
        set { ViewState["key"] = value; }
    }

    public string GetMenuList(string key)
    {
        string strContent = string.Empty;
        string strContent1 = string.Empty;
        string str = string.Empty;
        string div = string.Empty;
        var linq = GetMenu().Tables[0].AsEnumerable().Count(p => p.Field<string>("MenuID") == "MBD");
        if (linq == 1)
        {
            var list3 = (from lq in GetMenu().Tables[1].AsEnumerable() where lq.Field<string>("ParentID") == "MBD" && (lq.Field<string>("Remark") == "" || lq.Field<string>("Remark").Contains(string.IsNullOrEmpty(key) ? "NULL" : key)) select lq).ToList();
            if (list3.Count > 0)
            {
                str += "<div id='div_content' style='position:absolute;top:40px;right:8px;z-index:99'><table border='0'>\r\n<tr algin='center'>\r\n";
                div = "<div id='div' align='left' class='menu_bg_01' style= 'display:none;position:absolute;right:-5px; z-index:99 '><table border='0' align='center'>";
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
                            str += @"<td align='center'><span class='menu_btn_02' align='center'>" + "<a  href=\"javascript:void(0)\" onclick='CompanyX.UserControlTop1.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + sys + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                        }
                        else if (row["NameENG"].ToString() == "核 销 单")
                        {
                            str += @"<td align='center'><span class='menu_btn' align='center'>" + "<a style='font-family:微软雅黑; font-size: 10px !important;' href=\"javascript:void(0)\" onclick='CompanyX.UserControlTop1.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + sys + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                        }
                        else
                        {
                            str += @"<td align='center'><span class='menu_btn' align='center'>" + "<a  href=\"javascript:void(0)\" onclick='CompanyX.UserControlTop1.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + sys + "\")'>" + row["NameENG"] + "</a></span></td>\r\n";
                        }
                    }
                    else
                    {
                        div += @"<tr><td><span class='menu_btn_02' align='center'>" + "<a  href=\"javascript:void(0)\" onclick='CompanyX.UserControlTop1.ShowLink(\"" + row["NameENG"] + "\",\"" + row["Hyperlink"] + "?sys=" + sys + "\")'>" + row["NameENG"] + "</a></span></td></tr>";
                    }
                }
                div += "</table></div>";
                str += "\r\n<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div id='outer' style='position:absolute;top:2px; z-index:99;text-align:right;'><img src='/images/menu/down_01.png' id='img' style='width:18px;'/>" + div + "</div></td></tr>\r\n</table></div>";

            }
        }
        return str;
    }

    /// <summary>
    /// 获取菜单
    /// </summary>
    /// <returns></returns>
    private DataSet GetMenu()
    {
        DataFactory dal = new DataFactory();
        string MenuList = MenuHelper.GetMenu("MenuList"); // menu array list
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "user-get-menu")
            .Append("IDlist", MenuList)
        }).GetList();
        return ds;
    }



    DataFactory dal = new DataFactory();



    [DirectMethod]
    public void ShowLink(string title, string content)
    {
        string[] temp = content.Split(',');
        int width = 0, height = 0;
        string url = "";
        if (temp.Length > 2)
        {
            width = int.Parse(temp[0]);
            height = int.Parse(temp[1]);
            url = temp[2];
        }
        else
        {
            width = 600;
            height = 400;
            url = content;
        }
        var win = new Window
        {
            ID = "winShow",
            Title = title,
            Icon = Icon.Application,
            Constrain = true,
            Modal = true,
            BodyStyle = "background-color: #fff;",
            Padding = 0,
            Resizable = false,
            Draggable = false,
            Width = Unit.Pixel(width),
            Height = Unit.Pixel(height),
            CloseAction = CloseAction.Close


        };
        win.On("close", new JFunction("window.parent.window.document.body.style.overflow ='auto';window.parent.ChildCallBack('','','');"));

        win.AutoLoad.Url = url;
        win.AutoLoad.Mode = LoadMode.IFrame;
        X.AddScript("window.parent.window.document.body.style.overflow ='hidden';");
        win.Render(this.Page);
        win.Dispose();
        //win.Show();
    }

}
