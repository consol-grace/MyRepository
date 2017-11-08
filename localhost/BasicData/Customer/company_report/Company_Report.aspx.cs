using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Data;
using Ext.Net;

public partial class BasicData_Customer_compant_report_Company_Report : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                cmbType.Value = "";
                cmborder.Value = "NAME";
                LoadValue();
                //Preview();     
                active();
            }
        }
    }

    private void LoadValue()
    {
      
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintList")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode",Request.QueryString["type"]).Append("prt_sys","OE")
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            Store2.DataSource = ds.Tables[0];
            Store2.DataBind();
        }
        if (ds != null && ds.Tables[1].Rows.Count > 0)
        {
            CmbPrint.SelectedItem.Value = ds.Tables[1].Rows[0][0].ToString();
        }
        if (ds != null && ds.Tables[3].Rows.Count > 0)
        {
            storeCopies.DataSource = ds.Tables[3];
            storeCopies.DataBind();
        }
        DataTable dsType = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "TypeList")
        }).GetTable();
        if (ds != null && dsType.Rows.Count > 0)
        {
            storeType.DataSource = dsType;
            storeType.DataBind();
        }
    }


    protected void LinBtnRefresh_Click(object sender, EventArgs e)
    {
        active();
    }

    protected void active()
    {
        string url = "reportView.aspx?reportType=CompanyList&Copies=" + (string.IsNullOrEmpty(cmbPrintCount.Text) ? "1" : cmbPrintCount.Text) + "&type=" + cmbType.Text + "&sort=" + cmborder.Value + "&print=" + CmbPrint.Text;
        X.AddScript("$('#reportView').attr('src','" + url + "');");
    }

    protected void LinBtnPrint_Click(object sender, EventArgs e)
    {
      
        CompanyView.Preview("Y", Convert.ToInt32(cmbPrintCount.Value),Request["Type"].ToString(), cmbType.Text, cmborder.Text, CmbPrint.Text, this);
        //lbltishi.Text = "Printed:" + DateTime.Now.ToString("yyyy/MM/dd H:mm:ss");
    }

    protected void LinBtnExcel_Click(object sender, EventArgs e)
    {
        ReportHelper.ExportRepFile("CompanyList-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls", true, CompanyView.GetNums("N", CmbPrint.Text, cmbType.Text, cmborder.Text, this));
    }
}
