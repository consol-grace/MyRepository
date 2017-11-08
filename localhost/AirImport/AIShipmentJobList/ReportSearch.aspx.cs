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

public partial class AirImport_AIShipmentJobList_ReportSearch : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    //private  string sys = "AI";
    //private string type = "DNCN";
    //private string from = "";
    //private string to = "";
    //private string dest = "";
    //private string sales = "";
    //private string shipper = "";
    //private string consignee = "";
  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadValue();
            Preview();
        }
    }

    private void Preview()
    {
        CrystalDecisions.CrystalReports.Engine.ReportDocument doc = ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), GetNums("N"));
        CrystalReportViewer1.ReportSource = doc;
        CrystalReportViewer1.DataBind();
    }

    private string[] GetNums(string flag)
    {
        string[] nums = null;
        if (hidtype.Text == "DNCN")
        {
            nums = new string[11];
            nums[0] = Server.MapPath("~/Report/CommonReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidconsignee.Text;
            nums[4] = hidfrom.Text;
            nums[5] = hidto.Text;
            nums[6] = "";
            nums[7] = hiddest.Text;
            nums[8] = hidshipper.Text;
            nums[9] = FSecurityHelper.CurrentUserDataGET()[12];
            nums[10] = hidsys.Text;
            //nums[11] = hidsys.Text;
            //nums[12] = FSecurityHelper.CurrentUserDataGET()[12];
        }
        else if (hidtype.Text == "AShipment")
        {
            nums = new string[10];
            nums[0] = Server.MapPath("~/Report/CommonReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidconsignee.Text;
            nums[4] = hidfrom.Text;
            nums[5] = hidto.Text;
            nums[6] = hiddest.Text;
            nums[7] = hidshipper.Text;
            nums[8] = FSecurityHelper.CurrentUserDataGET()[12];
            nums[9] = hidsys.Text;
        }
        else if (hidtype.Text == "OShipment")
        {
            nums = new string[10];
            nums[0] = Server.MapPath("~/Report/CommonReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidconsignee.Text;
            nums[4] = hidfrom.Text;
            nums[5] = hidto.Text;
            nums[6] = hiddest.Text;
            nums[7] = hidshipper.Text;
            nums[8] = FSecurityHelper.CurrentUserDataGET()[12];
            nums[9] = hidsys.Text;
        }
        else if (hidtype.Text == "ALLShipment")
        {
            nums = new string[10];
            nums[0] = Server.MapPath("~/Report/CommonReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidconsignee.Text;
            nums[4] = hidfrom.Text;
            nums[5] = hidto.Text;
            nums[6] = hiddest.Text;
            nums[7] = hidshipper.Text;
            nums[8] = FSecurityHelper.CurrentUserDataGET()[12];
            nums[9] = hidsys.Text;
        }
        else if (hidtype.Text == "SALES")
        {
            nums = new string[11];
            nums[0] = Server.MapPath("~/Report/CommonReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidsys.Text;
            nums[4] = hidsales.Text;
            nums[5] = FSecurityHelper.CurrentUserDataGET()[12];
            nums[6] = hidfrom.Text;
            nums[7] = hidto.Text;
            nums[8] = hidconsignee.Text;
            nums[9] = hiddest.Text;
            nums[10] = hidshipper.Text;
        }
        else if (hidtype.Text == "OP")
        {
            nums = new string[11];
            nums[0] = Server.MapPath("~/Report/CommonReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidsys.Text;
            nums[4] = hidsales.Text;
            nums[5] = FSecurityHelper.CurrentUserDataGET()[12];
            nums[6] = hidfrom.Text;
            nums[7] = hidto.Text;
            nums[8] = hidconsignee.Text;
            nums[9] = hiddest.Text;
            nums[10] = hidshipper.Text;
        }
        else if (hidtype.Text == "House")
        {
            nums = new string[11];
            nums[0] = Server.MapPath("~/Report/CommonReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidsys.Text;
            nums[4] = hidsales.Text;
            nums[5] = FSecurityHelper.CurrentUserDataGET()[12];
            nums[6] = hidfrom.Text;
            nums[7] = hidto.Text;
            nums[8] = hidconsignee.Text;
            nums[9] = hiddest.Text;
            nums[10] = hidshipper.Text;
            //nums[10] = FSecurityHelper.CurrentUserDataGET()[12];
            //nums[11] = hidsys.Text;
            //nums[12] = hiddest.Text;
        }
        return nums;
    }

    private void LoadValue()
    {
        if (Request["Sys"] != null)
        {
            hidsys.Text = Request["Sys"];
        }
        if (Request["Type"] != null)
        {
            hidtype.Text = Request["Type"];
        }
        if (Request["From"] != null)
        {
            hidfrom.Text = Server.UrlDecode(Request["From"]);
            if (hidfrom.Text == "")
            {
                hidfrom.Text = "1900/01/01";
            }
            else
            {
                hidfrom.Text = (string)ControlBinder.getDate(hidfrom.Text);
            }
        }
        if (Request["To"] != null)
        {
            hidto.Text = Server.UrlDecode(Request["To"]);
            if (hidto.Text == "")
            {
                hidto.Text = "2100/01/01";
            }
            else
            {
                hidto.Text = (string)ControlBinder.getDate(hidto.Text);
            }
        }
        if (Request["Dest"] != null)
        {
            hiddest.Text = Server.UrlDecode(Request["Dest"]);
        }
        if (Request["Sales"] != null)
        {
            hidsales.Text = Server.UrlDecode(Request["Sales"]);
        }
        if (Request["Shipper"] != null)
        {
            hidshipper.Text = Server.UrlDecode(Request["Shipper"]);
        }
        if (Request["Consignee"] != null)
        {
            hidconsignee.Text = Server.UrlDecode(Request["Consignee"]);
        }

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintList")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode",hidtype.Text).Append("prt_sys",hidsys.Text.ToUpper()=="SYS"?"":hidsys.Text)
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
        if (ds != null && ds.Tables[3].Rows.Count > 0)
        {
            storeCopies.DataSource = ds.Tables[3];
            storeCopies.DataBind();
        }
        if (ds != null && ds.Tables.Count > 4)
        {
            if (ds.Tables[4].Rows.Count > 0)
            {
                cmbPrintCount.SelectedItem.Value = ds.Tables[4].Rows[0][0].ToString();
            }
        }

    }

    protected void LinBtnPDF_Click(object sender, EventArgs e)
    {
        ReportHelper.ExportRepFile(hidtype.Text + "-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf", true, Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), GetNums("N"));
    }

 protected void LinBtnExcel_Click(object sender, EventArgs e)
    {
        ReportHelper.ExportRepFile(hidtype.Text + "-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls", true, Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), GetNums("N"));
    }    

    protected void LinBtnPrint_Click(object sender, EventArgs e)
    {
        ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount.SelectedItem.Value), GetNums("Y"));
        lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
    }
}
