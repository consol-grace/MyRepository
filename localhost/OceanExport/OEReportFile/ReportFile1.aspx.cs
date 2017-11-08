using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DIYGENS.COM.DBLL;
using System.Drawing;
using DIYGENS.COM.FRAMEWORK;
using System.Data;
using Ext.Net;

public partial class OceanExport_OEReportFile_ReportFile : System.Web.UI.Page
{
    private  string hdraft = "";
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            LoadValue();
            Preview();
            if (Session["Tishi"] != null && Session["Tishi"].ToString() == hidID.Text)
            {
                lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            }
            else
            {
                lbltishi.Text = "";
            }
        }

    }
    private void LoadValue()
    {
        hdraft = "";
        if (!string.IsNullOrEmpty(Request.QueryString["type"]))
        {
            hidtype.Text = Request.QueryString["type"];
            
        }
        if (!string.IsNullOrEmpty(Request.QueryString["ID"]))
        {
            hidID.Text = Request.QueryString["ID"];
        }
        if (Request["HType"] != null)
        {
            hdraft = Request.QueryString["HType"];
            lbltishi.Hide();
            btnPrint.Show();
            btnDraft.Show();
            btnACI.Show();
            if (!string.IsNullOrEmpty(Request.QueryString["HAttach"]))
            {
                if (Request["HAttach"] == "1")
                {
                    btnAttachList.Show();
                }
                else
                {
                    btnAttachList.Hide();
                }
            }
        }
        else
        {
            btnPrint.Hide();
            btnDraft.Hide();
            btnACI.Hide();
            btnAttachList.Hide();
        }
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
        if (ds != null && ds.Tables[2].Rows.Count > 0)
        {
            hidtop.Text = ds.Tables[2].Rows[0][0].ToString();
            hidbottom.Text = ds.Tables[2].Rows[0][1].ToString();
            hidleft.Text = ds.Tables[2].Rows[0][2].ToString();
            hidright.Text = ds.Tables[2].Rows[0][3].ToString();
        }
        if (ds != null && ds.Tables.Count > 3)
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
        if (hidtype.Text.ToUpper() == "INVOICE")
        {
            DataSet ckDs = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "CheckDetailData").
                            Append("inv_seed",hidID.Text)}).GetList();
            if (ckDs.Tables[0].Rows[0][0].ToString() == "N")
            {
                LinBtnPDF.Visible = false;
                LinBtnPrint.Visible = false;
            }
            else
            {
                LinBtnPDF.Visible = true;
                LinBtnPrint.Visible = true;
            }
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
        string rpt_Type = "";
        string rpt_Header = "";
        if (hidtype.Text == "Invoice")
        {
            nums = new string[6];
            nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidID.Text;
            nums[4] = "O_Invoice";
            nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
        }
        else if (hidtype.Text == "Manifest")
        {
            rpt_Type = "OE Manifest";
            rpt_Header = "CONTAINER MANIFEST";
            nums = new string[9];
            nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = rpt_Header;
            nums[4] = hidID.Text;
            nums[5] = rpt_Type;
            nums[6] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
            nums[7] = FSecurityHelper.CurrentUserDataGET()[15].ToString();
            nums[8] = FSecurityHelper.CurrentUserDataGET()[2].ToString();
        }
        else if (hidtype.Text == "HDraft" || hidtype.Text == "Bill")
        {
            rpt_Type = "OE HAWB";
            nums = new string[7];
            if (pdfStatus == 1&&hidtype.Text == "HDraft")
            {
                pdfStatus = 0;
                nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + "pdf.rpt");
            }
            else
            {
                nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
            }
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hdraft;
            nums[4] = hidID.Text;
            nums[5] = rpt_Type;
            nums[6] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
        }
        else if (hidtype.Text == "BLSample")
        {
            nums = new string[4];
            nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidID.Text;
        }
        else if (hidtype.Text == "ACI")
        {
            nums = new string[4];
            nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidID.Text;
        }
        else if (hidtype.Text == "AttachList")
        {
            nums = new string[4];
            nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
            nums[1] = flag;
            nums[2] = CmbPrint.SelectedItem.Value;
            nums[3] = hidID.Text;
        }
        return nums;
    }


    private int pdfStatus = 0;
    protected void LinBtnPDF_Click(object sender, EventArgs e)
    {
        if (hidtype.Text.ToUpper() == "INVOICE")
        {
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "UpdateInvoiceNo").
                            Append("inv_seed",hidID.Text).
                            Append("code",FSecurityHelper.CurrentUserDataGET()[4]+"OE").
                            Append("inv_STAT",FSecurityHelper.CurrentUserDataGET()[12]).
                            Append("User",FSecurityHelper.CurrentUserDataGET()[0])                     
                            }).Update();
            Session["Tishi"] = hidID.Text;
        }
        pdfStatus = 1;
        ReportHelper.ExportRepFile(hidtype.Text + "-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf", true, Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), GetNums("N"));
    }

    protected void LinBtnPrint_Click(object sender, EventArgs e)
    {
        if (hidtype.Text.ToUpper() == "INVOICE")
        {
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "UpdateInvoiceNo").
                            Append("inv_seed",hidID.Text).
                            Append("code",FSecurityHelper.CurrentUserDataGET()[4]+"OE").
                            Append("inv_STAT",FSecurityHelper.CurrentUserDataGET()[12]).
                            Append("User",FSecurityHelper.CurrentUserDataGET()[0])                     
                            }).Update();
            
        }
        Session["Tishi"] = hidID.Text;
        ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount.SelectedItem.Value), GetNums("Y"));
        if (hidtype.Text == "Invoice")
        {
            X.AddScript("window.location.reload();window.opener.location.reload();");
        }
        lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
    }

    #region    btnPrint_Click()     Author：Hcy   (2012-04-03)
    protected void btnPrint_Click(object sender, DirectEventArgs e)
    {
        X.Redirect("../OEReportFile/ReportFile.aspx?type=Bill&ID=" + Request["ID"] + "&HAttach=" + Request["HAttach"] + "&HType=" + Request["HType"]);
    }
    #endregion

    #region    btnDraft_Click()     Author：Hcy   (2012-04-03)
    protected void btnDraft_Click(object sender, DirectEventArgs e)
    {
        X.Redirect("../OEReportFile/ReportFile.aspx?type=HDraft&ID=" + Request["ID"] + "&HAttach=" + Request["HAttach"] + "&HType=" + Request["HType"]);

    }
    #endregion

    #region    btnACI_Click()     Author：Hcy   (2012-04-03)
    protected void btnACI_Click(object sender, DirectEventArgs e)
    {
        X.Redirect("../OEReportFile/ReportFile.aspx?type=ACI&ID=" + Request["ID"] + "&HAttach=" + Request["HAttach"] + "&HType=" + Request["HType"]);

    }
    #endregion

    #region    btnAttachList_Click()     Author：Hcy   (2012-04-03)
    protected void btnAttachList_Click(object sender, DirectEventArgs e)
    {
        X.Redirect("../OEReportFile/ReportFile.aspx?type=AttachList&ID=" + Request["ID"] + "&HAttach=" + Request["HAttach"] + "&HType=" + Request["HType"]);
    }
    #endregion

}