using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web;
using DIYGENS.COM.FRAMEWORK;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Web.Security; 

/// <summary>
///PageHelper 的摘要说明
/// </summary>
public class PageHelper
{
    #region 通用成员   作者: Richard ( 2011-07-17 )

    #region ConnectionStrings   数据库连线   作者: Richard ( 2011-07-11 )
    /// <summary>
    /// 数据库连线
    /// </summary>
    public static string ConnectionStrings
    {
        get
        {
            return ConfigHelper.GetAppSettings("ConnectionStrings");
        }
    }
    #endregion

    #region SplitToJSON(bool, string)   逗号分隔的字串   作者: Richard ( 2011-07-17 )
    /// <summary>
    /// 逗号分隔的字串
    /// </summary>
    /// <param name="splitor"></param>
    /// <returns></returns>
    public static string SplitToJSON(bool isSuccess, string splitor)
    {
        string data = string.Empty;
        if (splitor.IndexOf(",") == -1)
        {
            data = ("[{\"Option\":\"" + isSuccess.ToString() + "\",\"RowID\":\"{0}\"}]").Replace("{0}", splitor);
        }
        else
        {
            string[] list = splitor.Split(',');
            for (int i = 0; i < list.Length; i++) data += (",{\"Option\":\"" + isSuccess.ToString() + "\",\"RowID\":\"{0}\"}").Replace("{0}", list[i]);
            data = "[" + data.Substring(1, data.Length - 1) + "]";
        }
        return data;
    }
    #endregion

    #region MD5(string)   MD5加密   作者: Richard ( 2011-07-17 )
    /// <summary>
    /// MD5加密
    /// </summary>
    /// <param name="encrypt"></param>
    /// <returns></returns>
    public static string MD5(string encrypt)
    {
        return new Securitylib().EncryptMD5(encrypt);
    }
    #endregion

    #region Encrypt(object)   对称加密   作者: Richard ( 2011-07-17 )
    /// <summary>
    /// 对称加密
    /// </summary>
    /// <param name="encrypt"></param>
    /// <returns></returns>
    public static string Encrypt(object encrypt)
    {
        return new Securitylib().Encrypt(encrypt);
    }
    #endregion

    #region Decrypt(object)   对称解密   作者: Richard ( 2011-07-17 )
    /// <summary>
    /// 对称解密
    /// </summary>
    /// <param name="encrypt"></param>
    /// <returns></returns>
    public static string Decrypt(object encrypt)
    {
        return new Securitylib().Decrypt(encrypt);
    }
    #endregion

    #region ME   类的实例   作者: Richard ( 2011-06-21 )
    private static PageHelper _ME { set; get; }
    /// <summary>
    /// 类的实例
    /// </summary>
    public static PageHelper ME
    {
        get
        {
            if (_ME == null) _ME = new PageHelper();
            return _ME;
        }
    }
    #endregion

    #region IsAdmin()   是否管理员   作者: Rihcard ( 2011-06-21 )
    /// <summary>
    /// 是否管理员
    /// </summary>
    public static bool IsAdmin
    {
        get
        {
            string GroupID = string.Empty, PermissionID = string.Empty;
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["MenuList"];
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);
                GroupID = FSecurityHelper.CurrentUserDataGET()[5];   // GroupID
                PermissionID = ticket.UserData;//FSecurityHelper.CurrentUserDataGET()[14];   // PermissionID
            }
            catch
            {
                GroupID = string.Empty;
                PermissionID = string.Empty;
            }
            bool bFlag = false;
            if (!string.IsNullOrEmpty(GroupID)) bFlag = (GroupID == "G1" && PermissionID.IndexOf("P999") != -1) ? true : false;

            return bFlag;
        }
    }

    #endregion

    #endregion

    public PageHelper()
    {

    }

    public static DataSet GetDs(string name,string[] nums,object[] values)
    {
        DataSet ds;
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConnectionStrings);
        con.Open();
        System.Data.SqlClient.SqlCommand com = new System.Data.SqlClient.SqlCommand();
        com.Connection = con;
        com.CommandTimeout = 180;
        com.CommandType = CommandType.StoredProcedure;
        com.CommandText = name;

        for(int i=0;i<nums.Length;i++)
        {
          System.Data.SqlClient.SqlParameter sp=new System.Data.SqlClient.SqlParameter("@"+nums[i],System.Data.SqlDbType.NVarChar);
          sp.Value = values[i];
          com.Parameters.Add(sp);
        }
        
        System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(com);
        ds = new DataSet();
        da.Fill(ds);
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        return ds;
    }


    #region Builder 类   作者： Richard ( 2011-08-08 )
    /// <summary>
    /// 绑定类
    /// </summary>
    public class Builder
    {
        private static DataFactory dbAll = new DataFactory();

        /// <summary>
        /// 绑定公司
        /// </summary>
        /// <param name="ctrl"></param>
        public static void FW_COMPANY(DropDownList ctrl)
        {
            DataTable dt = dbAll.FactoryDAL(PageHelper.ConnectionStrings, "FW_FRAMEWORK_SP", new List<IFields>() { dbAll.CreateIFields().Append("Option", "builder_FW_COMPANY") }).GetTable();
            ctrl.Items.Clear();
            for (int i = 0; dt != null && i < dt.Rows.Count; i++) {
                DataRow row = dt.Rows[i];
                ctrl.Items.Add(new ListItem(row["NameCHS"].ToString(), row["CompanyID"].ToString()));
            }
            ctrl.Items.Insert(0, new ListItem("select a option", ""));
        }
    }
    #endregion
    #region Object[] 类   作者： Hcy ( 2011-08-24 )
    /// <summary>
    /// Object[]
    /// </summary>
    public static Object[,] Data(DataTable dt)
    {
        if (dt != null && dt.Rows.Count > 0)
        {
            int rowscount = 0, columnscount = 0;
            rowscount = dt.Rows.Count;
            columnscount = dt.Columns.Count;
            object[,] data = new Object[rowscount,columnscount];
            for (int i = 0; i < rowscount; i++)
            {
                for (int j = 0; j < columnscount; j++)
                {
                    data[i, j] = dt.Rows[i][j];
                }
            }
            return data;
        }
        else
        {
            return null;
        }
    }
    #endregion


    #region Message 提示
    public static void ExcuteJScript(Page page, object code)
    {
        ScriptManager.RegisterClientScriptBlock(page, typeof(string), "ExcuteJScript", code.ToString(), true);
    }
    public static void MsgBox(Page page, string message)
    {
        message = "alert(\"" + message + "\"); \n";
        ExcuteJScript(page, message);
    }
    public static void MsgBox(Page page, string message, string url)
    {
        message = "alert(\"" + message + "\"); \n";
        if (message != "" && message != null)
            message += "window.location = \"" + url + "\"; \n";
        ExcuteJScript(page, message);
    }
    //ExcuteJScript(Page, "window.open('../test.aspx?Action=Edit&No=" + ds.Tables[0].Rows[0][0].ToString() + "&No1=" + ds.Tables[0].Rows[0][1].ToString() + "','','top=100,left=50,height=650,width=1000,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,directories=no,resizable=no');");
    #endregion

}
