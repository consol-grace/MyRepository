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
using System.IO;

public partial class OceanExport_OEReportFile_ReportPDF : System.Web.UI.Page
{
    private string hdraft = "";
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (string.IsNullOrEmpty(Request["type"]))
            {
                Response.Flush();
                Response.Clear();
                Response.End();
            }

            LoadValue();
            // Preview();

            foreach (string str in Request.QueryString.AllKeys)
                allKey.Value += str + ",";
            allKey.Value = allKey.Value.Substring(0, allKey.Value.Length - 1);


            hidsys.Value = "OE";
            if (Session["Tishi"] != null && Session["Tishi"].ToString() == hidID.Text)
            {
                lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            }
            else
            {
                lbltishi.Text = "";
            }

            chkIsPKGS.Checked = Request["ispkgs"] == "0" ? false : true;

        }

        ViewReport1.NumList = Newtonsoft.Json.JsonConvert.SerializeObject(GetNums("Y"));
        ViewReport1.Margin = "[\"" + Convert.ToDouble(hidtop.Text) + "\",\"" + Convert.ToDouble(hidbottom.Text) + "\",\"" + Convert.ToDouble(hidleft.Text) + "\",\"" + Convert.ToDouble(hidright.Text) + "\"]";
        Title = hidtype.Value + " report preview";


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
        if (Request["HType"] != null && (Request["type"].ToUpper() == "HDRAFT" || Request["type"].ToUpper() == "BILL" || Request["type"].ToUpper() == "ACI" || Request["type"].ToUpper() == "ATTACHLIST"))
        {
            hdraft = Request.QueryString["HType"];
            lbltishi.Hide();
            btnPrint.Show();
            btnDraft.Show();
            btnACI.Show();
            div_Surrendered.Visible = false;

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
        else if (Request["type"].ToUpper() == "SBSDRAFT")
        {
            btnPrint.Hide();
            btnDraft.Hide();
            btnACI.Hide();
            btnAttachList.Hide();

            if (Request["HType"] == "1")
                chkSurrendered.Checked = true;
            else
                chkSurrendered.Checked = false;


        }
        else
        {
            btnPrint.Hide();
            btnDraft.Hide();
            btnACI.Hide();
            btnAttachList.Hide();
            div_Surrendered.Visible = false;

        }
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintList")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode",Request.QueryString["type"]).Append("prt_sys","OE")
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {

            CmbPrint1.DataSource = ds.Tables[0];
            CmbPrint1.DataTextField = "text";
            CmbPrint1.DataValueField = "value";
            CmbPrint1.DataBind();

        }
        if (ds != null && ds.Tables[1].Rows.Count > 0)
        {
            CmbPrint1.Text = ds.Tables[1].Rows[0][0].ToString();
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
            cmbPrintCount1.DataSource = ds.Tables[3];
            cmbPrintCount1.DataValueField = "value";
            cmbPrintCount1.DataTextField = "text";
            cmbPrintCount1.DataBind();

        }
        if (ds != null && ds.Tables.Count > 4)
        {
            if (ds.Tables[4].Rows.Count > 0)
            {
                cmbPrintCount1.Text = ds.Tables[4].Rows[0][0].ToString();
            }
        }
        if (hidtype.Text.ToUpper() == "INVOICE")
        {
            DataSet ckDs = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "CheckDetailData").
                            Append("inv_seed",hidID.Text)}).GetList();
            if (ckDs.Tables[0].Rows[0][0].ToString() == "N")
            {
                LinBtnPDF.Disabled = true;
                LinBtnPrint.Disabled = true;

            }
            else
            {
                LinBtnPDF.Disabled = false;
                LinBtnPrint.Disabled = false;

            }

            DataSet dsInv = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "CheckInvoiceNo").
                            Append("inv_seed",hidID.Text)                 
                            }).GetList();
            showBtnDraft.Visible = true;
            if (dsInv.Tables[0].Rows[0][0].ToString() == "Y")
            {
                chkFlagDraft.Checked = false;
                chkFlagDraft.Visible = false;
                chkFlagDraft.Enabled = true;
                btnInvDraft.Disabled = true;
            }
            else
            {
                showDraft.Visible = true;
            }
        }
    }


    private string[] GetNums(string flag)
    {

        string[] query = allKey.Value.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);

        string[] param = null;
        if (query.Length == 4)
        {   ///?type=Bill&ID=738565&HAttach=1&HType=
            if (query.Contains("HType") || query.Contains("HAttach"))
                param = new string[] { Request["ID"], Request["HAttach"], Request["HType"], Request["type"] };
            else
                param = new string[] { Request["ID"], Request["Company"], Request["Currency"], Request["type"] };
        }
        else
        {
            param = new string[query.Length];
            for (int i = 0; i < query.Length; ++i)
                param[i] = Request[query[query.Length - 1 - i]];
        }

        Reportparameters rpm = new Reportparameters(hidInvDraft.Text);
        return rpm.GetNums(hidtype.Value.ToString(), flag, CmbPrint1.Text, param, hidsys.Value, Page);


        //string[] nums = null;
        //string rpt_Type = "";
        //string rpt_Header = "";
        //if (hidtype.Text == "Invoice")
        //{
        //    nums = new string[7];
        //    nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = hidID.Text;
        //    nums[4] = "O_Invoice";
        //    nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
        //    nums[6] = hidInvDraft.Text;
        //}
        //else if (hidtype.Text == "Manifest")
        //{
        //    rpt_Type = "OE Manifest";
        //    rpt_Header = "CONTAINER MANIFEST";
        //    nums = new string[9];
        //    nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = rpt_Header;
        //    nums[4] = hidID.Text;
        //    nums[5] = rpt_Type;
        //    nums[6] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
        //    nums[7] = FSecurityHelper.CurrentUserDataGET()[15].ToString();
        //    nums[8] = FSecurityHelper.CurrentUserDataGET()[2].ToString();
        //}
        //else if (hidtype.Text == "HDraft" || hidtype.Text == "Bill")
        //{
        //    rpt_Type = "OE HAWB";
        //    nums = new string[7];
        //    if (pdfStatus == 1 && hidtype.Text == "HDraft")
        //    {
        //        pdfStatus = 0;
        //        nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + "pdf.rpt");
        //    }
        //    else
        //    {
        //        nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
        //    }
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = Request["HType"] == null ? "" : Request["HType"];
        //    nums[4] = hidID.Text;
        //    nums[5] = rpt_Type;
        //    nums[6] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
        //}
        //else if (hidtype.Text == "BLSample")
        //{
        //    nums = new string[8];
        //    nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = hidID.Text;
        //    nums[4] = Request["groupid"] == null ? "0" : Request["groupid"];
        //    nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
        //    nums[6] = FSecurityHelper.CurrentUserDataGET()[11].ToString();
        //    nums[7] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
        //}

        //else if (hidtype.Text == "ACI")
        //{
        //    nums = new string[4];
        //    nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = hidID.Text;
        //}
        //else if (hidtype.Text == "AttachList")
        //{
        //    nums = new string[4];
        //    nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = hidID.Text;
        //}

        //else if (hidtype.Text == "PaymentRequest")
        //{
        //    nums = new string[9];
        //    nums[0] = Server.MapPath("~/Report/CommonReportFile/" + hidtype.Text + ".rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = hidID.Text;
        //    nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
        //    nums[5] = "OE";
        //    nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
        //    nums[7] = Request["Company"].ToString();
        //    nums[8] = Request["Currency"].ToString();
        //}
        //else if (hidtype.Text == "ProfitLoss")
        //{
        //    nums = new string[7];
        //    nums[0] = Server.MapPath("~/Report/CommonReportFile/ProfitAndLoss.rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = hidID.Text;
        //    nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
        //    nums[5] = "OE";
        //    nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
        //}
        //else if (hidtype.Text == "Test")
        //{
        //    nums = new string[3];
        //    nums[0] = Server.MapPath("~/Report/CommonReportFile/TestPreview.rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //}
        //else if (hidtype.Text == "ShipmentOrder")
        //{
        //    nums = new string[4];
        //    nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = hidID.Text;
        //}
        //else if (hidtype.Text == "BillForSBS")
        //{
        //    nums = new string[4];
        //    nums[0] = Server.MapPath("~/Report/OEReportFile/" + hidtype.Text + ".rpt");
        //    nums[1] = flag;
        //    nums[2] = CmbPrint1.Text;
        //    nums[3] = hidID.Text;
        //}
        //return nums;
    }

    private void GetPrintMargin()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintMargin")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode",Request.QueryString["type"]).Append("prt_sys","OE").Append("prt_PrinterName",CmbPrint1.SelectedItem.Value)
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            hidtop.Text = ds.Tables[0].Rows[0][0].ToString();
            hidbottom.Text = ds.Tables[0].Rows[0][1].ToString();
            hidleft.Text = ds.Tables[0].Rows[0][2].ToString();
            hidright.Text = ds.Tables[0].Rows[0][3].ToString();
        }
    }

    private int pdfStatus = 0;

    protected void LinBtnPDF_Click(object sender, EventArgs e)
    {

        string pdfpath = ViewReport1.PdfPath.Substring(0, ViewReport1.PdfPath.LastIndexOf("?"));

        if (string.IsNullOrEmpty(pdfpath) || !File.Exists(Server.MapPath(pdfpath)))
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "alert", "文件未能正常读取，导出失败 ！！！", true);
        }
        else
        {
            X.AddScript("isRedirect = 1;WinT();WinShow();");
        }

    }


    [DirectMethod]
    public void btnInvDraft_Click()
    {
        GetPrintMargin();
        hidInvDraft.Text = "1";
        ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount1.Text), GetNums("Y"));
        Session["Tishi"] = hidID.Text;
        lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
        ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "OE", hidtype.Text + "(ID:" + hidID.Text + ")", CmbPrint1.Text);
        X.AddScript("$('#btnInvDraft').removeAttr('disabled')");

    }


    [DirectMethod]
    public void LinBtnPrint_Click()
    {
        GetPrintMargin();
        if (hidtype.Text.ToUpper() == "INVOICE")
        {
            //Invoice预览是否强制显示抬头
            hidInvDraft.Text = "0";
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "CheckInvoiceNo").
                            Append("inv_seed",hidID.Text)
                            .Append("inv_IsPrinted","1")
                            }).GetList();
            if (ds.Tables[0].Rows[0][0].ToString() == "Y")
            {
                ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount1.Text), GetNums("Y"));
                Session["Tishi"] = hidID.Text;
                lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
                ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "OE", hidtype.Text + "(ID:" + hidID.Text + ")", CmbPrint1.Text);
            }
            else
            {
                X.Msg.Confirm("Print confirm", "Are you sure to print?", "if (buttonId == 'yes') { CompanyX.PrintConfirm(); }").Show();
            }
        }
        else
        {
            ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount1.Text), GetNums("Y"));
            Session["Tishi"] = hidID.Text;
            lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "OE", hidtype.Text + "(ID:" + hidID.Text + ")", CmbPrint1.Text);
        }

        X.AddScript("$('#LinBtnPrint').removeAttr('disabled')");

    }

    [DirectMethod]
    public void PrintConfirm()
    {
        if (!LockDate.IsLock(hidID.Text, ""))
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

        ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount1.Text), GetNums("Y"));
        ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "OE", hidtype.Text + "(ID:" + hidID.Text + ")", CmbPrint1.Text);
        X.AddScript("window.location.reload();if(window.opener!=null){window.opener.location.reload();}");
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

    [DirectMethod]
    public void chkSurrendered_CheckedChanged()
    {
        string ispkgs = chkIsPKGS.Checked ? "1" : "0";
        string isSurr = chkSurrendered.Checked ? "1" : "0";
        Response.Redirect("/OceanExport/OEReportFile/ReportPdf.aspx?type=SBSDraft&ID=" + Request["ID"] + "&HAttach=&HType=" + isSurr + "&ispkgs=" + ispkgs);
        //if (chkSurrendered.Checked)
        //{
        //    Response.Redirect("/OceanExport/OEReportFile/ReportPdf.aspx?type=SBSDraft&ID=" + Request["ID"] + "&HAttach=&HType=1");
        //}
        //else
        //{
        //    Response.Redirect("/OceanExport/OEReportFile/ReportPdf.aspx?type=SBSDraft&ID=" + Request["ID"]);

        //}
    }

    [DirectMethod]
    public void chkIsShowPKGS_CheckedChanged()
    {
        string ispkgs = chkIsPKGS.Checked ? "1" : "0";
        string isSurr = chkSurrendered.Checked ? "1" : "0";
        if (Request["type"].ToUpper() == "SBSDRAFT")
            Response.Redirect("/OceanExport/OEReportFile/ReportPdf.aspx?type=SBSDraft&ID=" + Request["ID"] + "&HAttach=&HType=" + isSurr + "&ispkgs=" + ispkgs);

        else
            Response.Redirect("/OceanExport/OEReportFile/ReportPdf.aspx?type=BillForSBS&ID=" + Request["ID"] + "&ispkgs=" + ispkgs);
    }
}