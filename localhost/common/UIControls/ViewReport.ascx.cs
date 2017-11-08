using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using System.Threading;
using System.IO;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.DBLL;

public partial class ViewReport : System.Web.UI.UserControl
{
    protected string stat;
    protected string type;
    protected string sys;

    protected void Page_Load(object sender, EventArgs e)
    {
        stat = FSecurityHelper.CurrentUserDataGET()[12].Trim();
        type = Request["type"] == "" ? "" : Request["type"].ToUpper();
        sys = Request["sys"] == null ? Request.Url.AbsolutePath.Split('/')[2].Substring(0, 2).ToUpper() : Request["sys"].ToUpper();
    }

    DataFactory dal = new DataFactory();
    public bool IsShowPdfCopy()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_PRINTERCopy_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
             .Append("ReportCode",type)
             .Append("Stat",stat)
             .Append("Sys",sys)
        }).GetTable();

        if (dt != null && dt.Rows.Count > 0)
        {
            if (dt.Rows[0][0].ToString().ToUpper() == "TRUE")
            {
                return true;
            }
        }

        return false;
    }

    /// <summary>
    /// 获取设置文件路径地址
    /// </summary>
    public string PdfPath
    {
        set { hidPath.Value = value; }
        get { return hidPath.Value; } 
    }

    /// <summary>
    /// 获取设置原始文件路径地址
    /// </summary>
    public string OldPath
    {
        set { hidOldPath.Value = value; }
        get { return hidOldPath.Value; }
    }

    /// <summary>
    /// 获取设置报表相关参数
    /// </summary>
    public string NumList
    {
        set { hidNumList.Value = value; }
        get { return hidNumList.Value; }
    }

    /// <summary>
    /// 获取设置报表间距
    /// </summary>
    public string Margin
    {
        set { hidMargin.Value = value; }
        get { return hidMargin.Value; }
    }

}
