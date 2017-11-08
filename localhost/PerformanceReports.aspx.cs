using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.DBLL;
using Ext.Net;

public partial class PerformanceReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                txtBeginDate.Text = DateTime.Now.ToString("yyyy-MM-01");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                BinderDrpList();
                BinderDataList();
            }
        }
    }

    static readonly DataFactory dal = new DataFactory();

    #region///绑定下拉列表
    public void BinderDrpList()
    {
        DataSet ds = new DataSet();
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllSystem_PerformanceReports_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "Department").
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]) }).GetList();
        drpDepartment.DataSource = ds.Tables[0];
        drpDepartment.DataTextField = "UserName";
        drpDepartment.DataValueField = "UserName";
        drpDepartment.DataBind();
    }
    #endregion

    #region///绑定查询数据
    /// <summary>
    /// 绑定数据
    /// </summary>
    public void BinderDataList()
    {
        string beginDate = string.IsNullOrEmpty(txtBeginDate.Text) ? "1900/01/01" : DateTime.Parse(txtBeginDate.Text).ToString("yyyy/MM/dd");
        string endDate = string.IsNullOrEmpty(txtEndDate.Text) ? DateTime.Now.ToString("yyyy/MM/dd") : DateTime.Parse(txtEndDate.Text).ToString("yyyy/MM/dd");

        labStat.Text = FSecurityHelper.CurrentUserDataGET()[12].Substring(4).ToUpper() + " " + drpDepartment.Text.ToUpper() + " (" + DateTime.Parse(beginDate).ToString("yyyy/MM/dd") + " ~ " + DateTime.Parse(endDate).ToString("yyyy/MM/dd") + "）";
        labReprot.Text = "Performance reports";
        labCompany.Text = "CONSOLIDATOR INTERNATIONAL CO.LTD.";

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllSystem_PerformanceReports_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "List").
                Append("BeginDate", DateTime.Parse(beginDate+" 0:00:00")).
                Append("EndDate",DateTime.Parse(endDate+" 23:59:59")).
                Append("Department", drpDepartment.Text).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]) }).GetList();
        CreateTable(ds);
    }

    /// <summary>
    /// 创建数据表格
    /// </summary>
    /// <param name="ds">数据源</param>
    public void CreateTable(DataSet ds)
    {
        //CreateHeader
        string strContent = "";

        if (ds != null && ds.Tables.Count > 0)
        {
            strContent = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n";
            if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
            {
                strContent += "<tr class='tr_header'>\r\n";
                for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
                {
                    strContent += "<td>" + ds.Tables[0].Rows[0][i].ToString().ToUpper() + "</td>\r\n";
                }
                strContent += "</tr>\r\n";
            }
            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[1].Rows.Count; ++i)
                {
                    if (i == ds.Tables[1].Rows.Count - 1)
                        strContent += "<tr class='tr_footer'>\r\n";
                    else
                        strContent += "<tr class='tr_item'>\r\n";
                    for (int j = 0; j < ds.Tables[1].Columns.Count; ++j)
                    {
                        if (ds.Tables[1].Columns[j].ColumnName == "CWT" || ds.Tables[1].Columns[j].ColumnName == "CBM" || ds.Tables[1].Columns[j].ColumnName == "CONSOL")
                            strContent += "<td class=\"td_" + ds.Tables[1].Columns[j].ColumnName + "\"><span>" +string.Format("{0:N3}",ds.Tables[1].Rows[i][j]) + "</span></td>\r\n";
                        else
                            strContent += "<td class=\"td_" + ds.Tables[1].Columns[j].ColumnName + "\"><span>" + ds.Tables[1].Rows[i][j].ToString().ToUpper() + "</span></td>\r\n";
                    }
                    strContent += "</tr>\r\n";
                }
            }
            strContent += "</table>\r\n";
        }

        ltlContent.Text = strContent;

    }
    #endregion

    #region///Buttion查询事件
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BinderDataList();
    }
    #endregion
}
