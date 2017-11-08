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

public partial class mframe_index : PageBase
{
    protected System.Data.DataView dview, dview1;
    protected int firstCount = 0;
    protected string UserName = "";
    protected string ifmContentUrl = "";
    protected string webTitle = "";

    protected void Page_PreInit(object sender, EventArgs e)
    {
        CheckBrowser();
    }

    protected override void Page_Load(object sender, EventArgs e)
    {
        UpdateUserInfo.Start();
        UserName = FSecurityHelper.CurrentUserDataGET()[2];
	webTitle = FSecurityHelper.CurrentUserDataGET()[32] == "" ? "" : FSecurityHelper.CurrentUserDataGET()[32] + "-";
        this.dview = this.GetMenu().Tables[0].DefaultView;
        this.dview1 = this.GetMenu().Tables[1].DefaultView;
        if (!IsPostBack)
        {
            BinderStat();
            cmbStat.Text = FSecurityHelper.CurrentUserDataGET()[12];
            selectUserInfo();
        }
    }


    public string CreateMenu()
    {
        string strContent = "";
        this.dview.RowFilter = "MenuID<>'MBD'";
        strContent += "<div id=\"div_Menu_list\">\r\n";
        for (int i = 0; this.dview != null && i < this.dview.Count; i++)
        {
            string reportList = "<div class=\"div_Report_List\"><div><img src=\"../images/nav_layer_01.png\"></div><div style=\"background-image:url(../images/nav_layer_02.png); width:156px;\">";
            string report = "";
            strContent += "<p><a href=\"javascript:void(0);\" class=\"" + this.dview[i]["Remark"] + "\" style=\"cursor: hand\"  onclick='USGROUP.MENU_FRAME.LeftLinkClick(USGROUP.ContextPath+&quot;" + this.dview[i]["Hyperlink"] + "&quot;)'>" + this.dview[i]["NameENG"] + "</a></p>\r\n";
            this.dview1.RowFilter = "ParentID='" + this.dview[i]["MenuID"].ToString() + "'";
            strContent += "<div class=\"list\">\r\n";
            for (int j = 0; this.dview1 != null && j < this.dview1.Count; j++)
            {

                if ("Location,Country".Contains(this.dview1[j]["NameENG"].ToString()))
                    strContent += "<a href=\"javascript:void(0);\" class=\"table_Nav\" onclick='CompanyX.ShowLink(&quot;" + this.dview1[j]["NameENG"] + "&quot;,&quot;" + this.dview1[j]["Hyperlink"] + "&quot;)'> " + this.dview1[j]["NameENG"] + "</a>\r\n";
                else
                {
                    if (this.dview1[j]["NameENG"].ToString().Contains("Report") && this.dview1[j]["RootID"].ToString() != "M11")
                    {
                        report = "<a class=\"Report_List  table_Nav\" href=\"javascript:void(0);\"><span>Report List</span></a>\r\n";
                        reportList += "<a href=\"javascript:void(0);\"  class=\"page_Nav\" onclick='USGROUP.MENU_FRAME.LeftLinkClick(USGROUP.ContextPath+&quot;" + this.dview1[j]["Hyperlink"] + "&quot;)'> " + this.dview1[j]["NameENG"] + "</a>\r\n";
                    }
                    else
                    {
                        strContent += "<a href=\"javascript:void(0);\"  class=\"table_Nav\"  onclick='USGROUP.MENU_FRAME.LeftLinkClick(USGROUP.ContextPath+&quot;" + this.dview1[j]["Hyperlink"] + "&quot;)'>" + this.dview1[j]["NameENG"] + "</a>\r\n";
                    }
                }

            }
            reportList += "</div><div><img src=\"../images/nav_layer_03.png\"></div></div>";
            strContent += report + reportList + "</div>\r\n";

   	    if (i == 0)
            {
                ifmContentUrl = "../" + this.dview[i]["Hyperlink"].ToString();
            }
        }
        strContent += "</div>\r\n";
        return strContent;
    }



    #region GetMenu()   获取菜单   作者: Richard ( 2011-08-19 )
    /// <summary>
    /// 获取菜单
    /// </summary>
    /// <returns></returns>
    private DataSet GetMenu()
    {
        string MenuList = MenuHelper.GetMenu("MenuList");  // FSecurityHelper.CurrentUserDataGET()[14]; // menu array list
        DataSet ds = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() { this.CreateIFields().Append("Option", "user-get-menu")
            .Append("IDlist", MenuList)
        }).GetList();

        return ds;
    }
    #endregion
    //protected void lkLogout_Click(object sender, EventArgs e)
    //{
    //    FSecurityHelper.SignOutAJAX();
    //    Response.Redirect("~/login.aspx");
    //}
    protected void lkbtn_Click(object sender, EventArgs e)
    {
        X.Msg.Confirm("Information", "Are you sure logout?", "if (buttonId == 'yes') { CompanyX.Logout(); } else {  }").Show();
    }

    [DirectMethod]
    public void Logout()
    {
        FSecurityHelper.SignOutAJAX();
        Response.Redirect("~/login.aspx");
    }

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


    public void CheckBrowser()
    {
        HttpBrowserCapabilities b = Request.Browser;

        string browser = b.Browser;
        string version = b.Version;
        if (browser.ToUpper() == "IE" && (version == "6.0" || version == "7.0"))
        {
            Response.Write("<html style=\"overflow:hidden\"><head><title>CONSOLDATOR</title></head><body style=\"overflow:hidden\"><div id='1111' style='width:100%; height:100%; top:0px; left:0px; position: absolute;z-index:99999;background-color:#fff; text-align:center'><div style='margin:20% auto; width:500px;text-align:center; line-height:25px;font-size:12px;overflow:hidden'>对不起，您使用的浏览器版本(" + b.Type + ")过低，可能会出现兼容性问题，为了您更好的使用本系统，建议请使用 IE8 或 IE8 以上浏览器，下载地址：<a target='_blank' href='http://windows.microsoft.com/zh-CN/internet-explorer/downloads/ie-8'>http://www.microsoft.com</a></div></div></body></html>");
            Response.Flush();
            Response.End();
            Response.Clear();
        }
    }


    //重新插入数据
    public void btnOK_Click(object sender, DirectEventArgs e)
    {
        //if (FSecurityHelper.CurrentUserDataGET()[8] != "G01")
        //    return;
        //if (FSecurityHelper.CurrentUserDataGET()[29] == "Y" && JSON.Deserialize(e.ExtraParams["IsLockStat"]).ToString() == "1")
        if (((FSecurityHelper.CurrentUserDataGET()[29].ToUpper() == "Y" && JSON.Deserialize(e.ExtraParams["IsLockStat"]).ToString() == "1") || (FSecurityHelper.CurrentUserDataGET()[29].ToUpper() == "N" && JSON.Deserialize(e.ExtraParams["CompanyID"]).ToString().ToUpper() != FSecurityHelper.CurrentUserDataGET()[32].ToUpper())) && FSecurityHelper.CurrentUserDataGET()[28].ToUpper() != "IT")
        {
            //对不起，登录失败！当前分站系统用户已经锁定，无法登录到总站系统，请核对后重新登录！
            //Sorry, logon failure! The current station system users have locked and unable to log on to the terminal system, please check log in again!
            Ext.Net.X.MessageBox.Alert("Status", "Sorry, the operation failed.", new JFunction { Handler = "location.reload();" }).Show();
            return;
        }

        this.ReturnValue = FSecurityHelper.CurrentUserDataSET(new string[] { 
                  FSecurityHelper.CurrentUserDataGET()[0] // 0
                , FSecurityHelper.CurrentUserDataGET()[1] // 1
                , FSecurityHelper.CurrentUserDataGET()[2] // 2
                , FSecurityHelper.CurrentUserDataGET()[3] // 3

                , JSON.Deserialize(e.ExtraParams["CompanyID"]).ToString() // 4
                , JSON.Deserialize(e.ExtraParams["NameCHS"]).ToString() // 5
                , JSON.Deserialize(e.ExtraParams["NAMEENG"]).ToString() // 6
                , JSON.Deserialize(e.ExtraParams["District"]).ToString() // 7

                , FSecurityHelper.CurrentUserDataGET()[8]  // 8
                , FSecurityHelper.CurrentUserDataGET()[9]  // 9
                , FSecurityHelper.CurrentUserDataGET()[10] // 10

                , FSecurityHelper.CurrentUserDataGET()[11] // 11
                , JSON.Deserialize(e.ExtraParams["Stat"]).ToString() // 12
                , FSecurityHelper.CurrentUserDataGET()[13] // 13  
                , "" //FSecurityHelper.CurrentUserDataGET()[14] // 14
                , FSecurityHelper.CurrentUserDataGET()[15] //15
               
                , JSON.Deserialize(e.ExtraParams["Tel"]).ToString() //16
                , JSON.Deserialize(e.ExtraParams["Fax"]).ToString() //17
                , JSON.Deserialize(e.ExtraParams["Email"]).ToString() //18
                , JSON.Deserialize(e.ExtraParams["DIMUnit"]).ToString() //19          ----AE 
                , JSON.Deserialize(e.ExtraParams["DIMFloat"]).ToString() //20         ----AE 
                , JSON.Deserialize(e.ExtraParams["AddressCHS"]).ToString() //21
                , JSON.Deserialize(e.ExtraParams["AddressENG"]).ToString() //22    
                , JSON.Deserialize(e.ExtraParams["DIMRate"]).ToString() //23          ----AE 
                , JSON.Deserialize(e.ExtraParams["AWBArrange"]).ToString() //24       ----AE 用  默认值
                , JSON.Deserialize(e.ExtraParams["ChinaMode"]).ToString() //25       是否中国大陆使用 
                , JSON.Deserialize(e.ExtraParams["ChineseInvoice"]).ToString() //26       Chinese Invoice 
                , FSecurityHelper.CurrentUserDataGET()[27]  //27
                , FSecurityHelper.CurrentUserDataGET()[28]  //28
                , FSecurityHelper.CurrentUserDataGET()[29]  //29
                , JSON.Deserialize(e.ExtraParams["IsServer"]).ToString() //30      
                , JSON.Deserialize(e.ExtraParams["IsLockStat"]).ToString() //31      
                , FSecurityHelper.CurrentUserDataGET()[32]  //32                 

         });

        FSecurityHelper.SignIn(true, FSecurityHelper.CurrentUserDataGET()[0], 720, false, this.ReturnValue);

    }

    DataFactory dal = new DataFactory();
    public void BinderStat()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "[FW_BasicData_ChangeStat_SP]", new List<IFields>() { dal.CreateIFields()
            .Append("username", FSecurityHelper.CurrentUserDataGET()[0].ToString())}).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 1)
            {
                hidStat.Value = "Y";
            }
            storeStat.DataSource = ds.Tables[0];
            storeStat.DataBind();
        }
    }


    #region /// 用户基本信息操作
    //更新用户信息
    public void btnUserOK_Click(object sender, DirectEventArgs e)
    {
        //更新的当前站的数据库的USER表
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_UserManager_SP", new List<IFields>() { dal.CreateIFields()
            .Append("username", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            .Append("email", txtUserEmail.Text)
            .Append("option", "update")
            .Append("NameCHS", txtUserName.Text.ToUpper())
            .Append("NameENG", txtUserNameen.Text.ToUpper())
            .Append("tel", txtUserTel.Text.ToUpper())
            .Append("ext", txtUserExt.Text.ToUpper())
            .Append("fax", txtUserFax.Text.ToUpper())  }).Update();
        if (b)
        {
            //用线程更新的香港数据库的USER表
          //  UpdateUserInfo.Start();
            UpdateUserInfo.CreateFile(txtUserEmail.Text, txtUserTel.Text.ToUpper(), txtUserFax.Text.ToUpper(), txtUserExt.Text.ToUpper(), txtUserName.Text.ToUpper(), txtUserNameen.Text.ToUpper());
      
            ReloadDate();
            X.AddScript("location.reload();");
        }
    }

    /// <summary>
    /// 获取用户基本信息
    /// </summary>
    [DirectMethod]
    public void selectUserInfo()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_UserManager_SP", new List<IFields>() { dal.CreateIFields()
            .Append("username", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            .Append("email", txtUserEmail.Text)
            .Append("option", "select")  }).GetTable();

        if (dt != null && dt.Rows.Count > 0)
        {
            txtUserEmail.Text = dt.Rows[0]["Email"].ToString();
            txtUserTel.Text = dt.Rows[0]["Tel"].ToString();
            txtUserExt.Text = dt.Rows[0]["Ext"].ToString();
            txtUserFax.Text = dt.Rows[0]["Fax"].ToString();
            txtUserName.Text = dt.Rows[0]["NameCHS"].ToString();
            txtUserNameen.Text = dt.Rows[0]["NameENG"].ToString();
        }
    }

    #endregion


    public void ReloadDate()
    {
        this.ReturnValue = FSecurityHelper.CurrentUserDataSET(new string[] { 
                  FSecurityHelper.CurrentUserDataGET()[0] // 0
                , txtUserName.Text.ToUpper() //FSecurityHelper.CurrentUserDataGET()[1] // 1
                , txtUserNameen.Text.ToUpper() //FSecurityHelper.CurrentUserDataGET()[2] // 2
                , txtUserEmail.Text //FSecurityHelper.CurrentUserDataGET()[3] // 3

                , FSecurityHelper.CurrentUserDataGET()[4] // 4
                , FSecurityHelper.CurrentUserDataGET()[5] // 5
                , FSecurityHelper.CurrentUserDataGET()[6] // 6
                , FSecurityHelper.CurrentUserDataGET()[7] // 7

                , FSecurityHelper.CurrentUserDataGET()[8]  // 8
                , FSecurityHelper.CurrentUserDataGET()[9]  // 9
                , FSecurityHelper.CurrentUserDataGET()[10] // 10

                , FSecurityHelper.CurrentUserDataGET()[11] // 11
                , FSecurityHelper.CurrentUserDataGET()[12] // 12
                , FSecurityHelper.CurrentUserDataGET()[13] // 13
                , "" //FSecurityHelper.CurrentUserDataGET()[14] // 14
                , FSecurityHelper.CurrentUserDataGET()[15] //15
               
                , FSecurityHelper.CurrentUserDataGET()[16] //16
                , FSecurityHelper.CurrentUserDataGET()[17] //17
                , FSecurityHelper.CurrentUserDataGET()[18] //18
                , FSecurityHelper.CurrentUserDataGET()[19] //19          ----AE 
                , FSecurityHelper.CurrentUserDataGET()[20] //20         ----AE 
                , FSecurityHelper.CurrentUserDataGET()[21] //21
                , FSecurityHelper.CurrentUserDataGET()[22] //22    
                , FSecurityHelper.CurrentUserDataGET()[23] //23          ----AE 
                , FSecurityHelper.CurrentUserDataGET()[24] //24       ----AE 用  默认值
                , FSecurityHelper.CurrentUserDataGET()[25] //25       是否中国大陆使用 
                , FSecurityHelper.CurrentUserDataGET()[26] //26       Chinese Invoice 
                , FSecurityHelper.CurrentUserDataGET()[27]  //27                 
                , FSecurityHelper.CurrentUserDataGET()[28]  //28
                , FSecurityHelper.CurrentUserDataGET()[29]  //29
                , FSecurityHelper.CurrentUserDataGET()[30]  //30
                , FSecurityHelper.CurrentUserDataGET()[31]  //31
                , FSecurityHelper.CurrentUserDataGET()[32]  //32

         });


        FSecurityHelper.SignIn(true, FSecurityHelper.CurrentUserDataGET()[0], 120, false, this.ReturnValue);

    }

}
