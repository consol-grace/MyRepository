using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.CommonLL;
using System.Web.Security; 

public partial class login : PageBase
{
    
    protected override void Page_Load(object sender, EventArgs e)
    {  
        if (!IsPostBack)
        {
            UserName.Focus();
            Response.Write("<script>if(window.top!=window.self){parent.window.location.href = 'login.aspx';}</script>");
            //PageHelper.ExcuteJScript(Page, "if(window.top!=window.self){parent.window.location.href = 'login.aspx';}");
        }
    }


    #region btnLogin_Click(object, EventArgs)   用户登录   作者: Richard ( 2011-08-04 )
    /// <summary>
    /// 用户登录
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = this.UserName.Text.Trim();
        string password = this.UserPWD.Text.Trim();
        if (username == "")
        {
            PageHelper.MsgBox(Page, "User name can't be empty.");
            UserName.Focus();
            return;
        }
        else if (password == "")
        {
            PageHelper.MsgBox(Page, "Password can't be empty.");
            UserPWD.Focus();
            return;
        }
        DateTime dt1 = DateTime.Now;

        string Browser = Request.Browser.Type + "," + Request.Browser.Version;

        DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "user-login")

            .Append("UserName", this.UserName.Text.Trim())
            .Append("UserPWD", PageHelper.MD5(this.UserPWD.Text.Trim()))
            .Append("Browser", Browser)
        }).GetTable();
        //string a = PageHelper.MD5("ynsa9981");
        bool IsLogin = (dt != null && dt.Rows.Count > 0) ? true : false;
        DateTime dt2 = DateTime.Now;
        TimeSpan t = dt2.Subtract(dt1);
        double delay = t.TotalMilliseconds;
        //PageHelper.MsgBox(Page, delay.ToString());
        if (IsLogin == false && delay > 3000)
        {
            PageHelper.MsgBox(Page, "System is timeout,Please try later again.");
            UserPWD.Focus();
            return;
        }
        if (IsLogin)
        {
            //如果为总站系统 Y，标记 islock 为1 的锁住，不让登录系统。如果为分站系统 N ， 当前登录用户不能匹配所属分站系统，锁住,不让登录.
            //if (((dt.Rows[0]["StationSys"].ToString().ToUpper() == "Y" && dt.Rows[0]["IsLockStat"].ToString() == "1") || (dt.Rows[0]["StationSys"].ToString().ToUpper() == "N" && dt.Rows[0]["CompanyID"].ToString().ToUpper() != dt.Rows[0]["CurrStation"].ToString().ToUpper())) && dt.Rows[0]["Dept"].ToString().ToUpper() != "IT")
            //{

            if (((dt.Rows[0]["StationSys"].ToString().ToUpper() == "Y" && dt.Rows[0]["IsLockStat"].ToString() == "1") ||
                (dt.Rows[0]["StationSys"].ToString().ToUpper() == "N" && !dt.Rows[0]["StatList"].ToString().ToUpper().Contains(dt.Rows[0]["CurrStation"].ToString().ToUpper())))
                && dt.Rows[0]["Dept"].ToString().ToUpper() != "IT")
            {
                //对不起，登录失败！当前分站系统用户已经锁定，无法登录到总站系统，请核对后重新登录！
                //Sorry, logon failure! The current station system users have locked and unable to log on to the terminal system, please check log in again!
                PageHelper.MsgBox(Page, "Sorry, logon failure! Please check the login address is correct!");
                UserPWD.Focus();
                return;
            }

            string stat = dt.Rows[0]["STAT"].ToString();

            if (dt.Rows[0]["CurrStation"].ToString() != "")
            {
                string cs = dt.Rows[0]["CurrStation"].ToString();
                if (cs == "PEK" || cs == "SHA" || cs == "SIN" || cs == "XMN")
                {
                    stat = "USG/" + dt.Rows[0]["CurrStation"].ToString();
                }
                else
                {
                    stat = "CON/" + dt.Rows[0]["CurrStation"].ToString();
                }

            }

            #region string[]数组中的数据项位置请勿乱动
            this.ReturnValue = FSecurityHelper.CurrentUserDataSET(new string[] { this.UserName.Text.Trim().ToUpper() // 0
                , dt.Rows[0]["NameCHS"].ToString().ToUpper() // 1
                , dt.Rows[0]["NameENG"].ToString().ToUpper() // 2
                , dt.Rows[0]["Email"].ToString() // 3

                , dt.Rows[0]["CompanyID"].ToString() // 4
                , dt.Rows[0]["CompanyNameCHS"].ToString() // 5
                , dt.Rows[0]["CompanyNameENG"].ToString() // 6
                , dt.Rows[0]["CompanyDistrict"].ToString() // 7

                , dt.Rows[0]["GroupID"].ToString() // 8
                , dt.Rows[0]["GroupNameCHS"].ToString() // 9
                , dt.Rows[0]["GroupNameENG"].ToString() // 10

                , dt.Rows[0]["SYS"].ToString() // 11
                , stat // 12
                , dt.Rows[0]["PermissionList"].ToString() // 13
                , "" //dt.Rows[0]["MenuList"].ToString() // 14
                , dt.Rows[0]["Tel"].ToString() //15
               
                , dt.Rows[0]["Cmp_Tel"].ToString() //16
                , dt.Rows[0]["Cmp_Fax"].ToString() //17
                , dt.Rows[0]["Cmp_Email"].ToString() //18
                , dt.Rows[0]["DimUnit"].ToString() //19        ----AE 
                , dt.Rows[0]["DimFloat"].ToString() //20       ----AE 
                , dt.Rows[0]["AddressCHS"].ToString() //21
                , dt.Rows[0]["AddressENG"].ToString() //22    
                , dt.Rows[0]["DIMRate"].ToString()  //23       ----AE 
                , dt.Rows[0]["AWBArrange"].ToString()  // 24   ----AE 用  默认值
                , dt.Rows[0]["ChinaMode"].ToString()   // 25   是否中国大陆使用
                , dt.Rows[0]["ChineseInvoice"].ToString()   // 26  
                , dt.Rows[0]["UserGrade"].ToString()   // 27  
                , dt.Rows[0]["Dept"].ToString()		   // 28  
				, dt.Rows[0]["StationSys"].ToString()       // 29  ---- 是否为总站系统， Y 是总站系统 ， N 为分站系统
				, dt.Rows[0]["IsServer"].ToString()         // 30  ---- 是否已分开系统， Y 已分开系统 ， N 为没有分开系统
                , dt.Rows[0]["IsLockStat"].ToString()     // 31 -----当前站的用户是否被锁住，不让登录操作  
                , dt.Rows[0]["CurrStation"].ToString()    // 32 -----当前所在的操作系统, 空为香港总站系统 
            });
            #endregion

            MenuHelper.SetMenu(dt.Rows[0]["MenuList"].ToString(), this.UserName.Text.Trim(), "MenuList");
            FSecurityHelper.SignIn(IsLogin, this.UserName.Text.Trim(), 720, false, this.ReturnValue);


        }
        else
        {
            //JScriptlib.MsgBox("User name or password is not correct", ConfigHelper.GetAppSettings("loginUrl"));
            PageHelper.MsgBox(Page, "User name or password is not correct.");
            UserPWD.Focus();
            return;
        }
    }
    #endregion

}
