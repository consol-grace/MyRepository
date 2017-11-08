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
using System.Web.Security; 

public partial class common_UIControls_UserControlTop : System.Web.UI.UserControl
{

    protected System.Data.DataView dview, dview1;
    protected int firstCount = 0;
    protected string UserName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        UserName = FSecurityHelper.CurrentUserDataGET()[2];
        this.dview = this.GetMenu().Tables[0].DefaultView;
        this.dview1 = this.GetMenu().Tables[1].DefaultView;
    }
    DataFactory dal = new DataFactory();

    #region GetMenu()   获取菜单   作者: Richard ( 2011-08-19 )
    /// <summary>
    /// 获取菜单
    /// </summary>
    /// <returns></returns>
    private DataSet GetMenu()
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies["MenuList"];
        FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);
        string MenuList = ticket.UserData;  //FSecurityHelper.CurrentUserDataGET()[14]; // menu array list
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "user-get-menu")
            .Append("IDlist", MenuList)
        }).GetList();

        return ds;
    }
    #endregion

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
            Icon = Icon.ArrowNsew,
            Constrain = true,
            Modal = true,
            BodyStyle = "background-color: #fff;",
            Padding = 0,
            Resizable = true,
            Draggable = true,
            Width = Unit.Pixel(width),
            Height = Unit.Pixel(height)

        };
        win.AutoLoad.Url = url;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Render();
        win.Show();
    }

}
