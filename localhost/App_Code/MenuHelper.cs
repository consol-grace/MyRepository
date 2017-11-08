using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using DIYGENS.COM.FRAMEWORK;

/// <summary>
/// Summary description for MenuHelper
/// </summary>
public class MenuHelper
{
    public MenuHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void SetMenu(string menustr, string user, string cookiename)
    {
        FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, user, DateTime.Now, DateTime.Now.AddMinutes((double)720), false, menustr);
        string str = FormsAuthentication.Encrypt(ticket);
        HttpCookie cookie = new HttpCookie(cookiename + "_" + ConfigHelper.GetAppSettings("CookieName"), str);
        cookie.Expires = ticket.Expiration;//设置过期时间
        HttpContext.Current.Response.Cookies.Add(cookie);
    }

    public static string GetMenu(string cookiename)
    {
        string menuStr = "";
        HttpCookie cookie = HttpContext.Current.Request.Cookies[cookiename + "_" + ConfigHelper.GetAppSettings("CookieName")];
        if (cookie != null)
        {
            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);
            menuStr = ticket.UserData;
        }
        else
        {
            HttpContext.Current.Response.Redirect("/login.aspx");
        }
        return menuStr;
    }

}