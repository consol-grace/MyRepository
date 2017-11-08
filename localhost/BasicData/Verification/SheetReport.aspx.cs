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

public partial class BasicData_Verification_SheetReport : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadValue();
            Preview();
        }
        if (Session["Tishi"] != null && Session["Tishi"].ToString() == "1")
        {
            lbltishi.Text = "Printed  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
        }
        else
        {
            lbltishi.Text = "";
        }
    }
    private void Preview()
    {
        CrystalDecisions.CrystalReports.Engine.ReportDocument doc = ReportHelper.SetReportDoc(GetNums("N"));
        CrystalReportViewer1.ReportSource = doc;
        CrystalReportViewer1.DataBind();
    }
   

    private string[] GetNums(string flag)
    {
        string[] nums = null;
        nums = new string[8];
        nums[0] = Server.MapPath("~/Report/CommonReportFile/Verify.rpt");
        nums[1] = flag;
        nums[2] = CmbPrint.SelectedItem.Value;
        nums[3] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
        nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
        nums[5] = hidsheetNo.Text;
        nums[6] = hidmbl.Text;
        nums[7] = hidstatus.Text;
        return nums;
    }

    private void LoadValue()
    {
        if (Request["sheetNo"] != null)
        {
            hidsheetNo.Text = Request["sheetNo"];
        }
        if (Request["mbl"] != null)
        {
            hidmbl.Text = Request["mbl"];
        }
        if (Request["status"] != null)
        {
            hidstatus.Text = Request["status"];
        }

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintList")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode","Verify").Append("prt_sys","")
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
        if (ds != null && ds.Tables[2].Rows.Count > 0)
        {
            hidtop.Text = ds.Tables[2].Rows[0][0].ToString();
            hidbottom.Text = ds.Tables[2].Rows[0][1].ToString();
            hidleft.Text = ds.Tables[2].Rows[0][2].ToString();
            hidright.Text = ds.Tables[2].Rows[0][3].ToString();
        }
        
    }

    protected void LinBtnPDF_Click(object sender, EventArgs e)
    {
        Session["Tishi"] = "1";
        ReportHelper.ExportRepFile("Verify" + "-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf", true, GetNums("N"));
    }

    protected void LinBtnPrint_Click(object sender, EventArgs e)
    {
        Session["Tishi"] = "1";
        ReportHelper.SetReportDoc(GetNums("Y"));
        lbltishi.Text = "Printed  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
    }
}
