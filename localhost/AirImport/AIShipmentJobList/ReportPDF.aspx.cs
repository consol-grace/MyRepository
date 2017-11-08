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

public partial class AirImport_AIShipmentJobList_ReportPDF : System.Web.UI.Page
{
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
            foreach (string str in Request.QueryString.AllKeys)
                allKey.Value += str + ",";
            allKey.Value = allKey.Value.Substring(0, allKey.Value.Length - 1);


            hidsys.Value = "AI";


            LoadValue();
            //Preview();
            if (Session["Tishi"] != null && Session["Tishi"].ToString() == hidID.Text)
            {
                lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            }
            else
            {
                lbltishi.Text = "";
            }
        }
        ViewReport1.NumList = Newtonsoft.Json.JsonConvert.SerializeObject(GetNums("Y"));
        ViewReport1.Margin = "[\"" + Convert.ToDouble(hidtop.Text) + "\",\"" + Convert.ToDouble(hidbottom.Text) + "\",\"" + Convert.ToDouble(hidleft.Text) + "\",\"" + Convert.ToDouble(hidright.Text) + "\"]";
        Title = hidtype.Text + " report preview";


    }
    private void LoadValue()
    {
        if (!string.IsNullOrEmpty(Request.QueryString["type"]))
        {
            hidtype.Text = Request.QueryString["type"];

        }
        if (!string.IsNullOrEmpty(Request.QueryString["ID"]))
        {
            hidID.Text = Request.QueryString["ID"];
        }

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintList")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode",Request.QueryString["type"]).Append("prt_sys","AI")
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
        if (ds != null && ds.Tables[3].Rows.Count > 0)
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
                chkFlagDraft.Disabled = true;
                btnInvDraft.Disabled = true;
            }
        }
    }

    //private void Preview()
    //{
    //    CrystalDecisions.CrystalReports.Engine.ReportDocument doc = ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), GetNums("N"));
    //    CrystalReportViewer1.ReportSource = doc;
    //    CrystalReportViewer1.DataBind();
    //}

    private void GetPrintMargin()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintMargin")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode",Request.QueryString["type"]).Append("prt_sys","AI")
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            hidtop.Text = ds.Tables[0].Rows[0][0].ToString();
            hidbottom.Text = ds.Tables[0].Rows[0][1].ToString();
            hidleft.Text = ds.Tables[0].Rows[0][2].ToString();
            hidright.Text = ds.Tables[0].Rows[0][3].ToString();
        }
    }

    private string[] GetNums(string flag)
    {
        string[] query = allKey.Value.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);

        string[] param = null;

        if (query.Length == 4)
        {
            param = new string[] { Request["ID"], Request["Company"], Request["Currency"], Request["type"] };
        }
        else
        {
            param = new string[query.Length];
            for (int i = 0; i < query.Length; ++i)
                param[i] = Request[query[query.Length - 1 - i]];
        }

        Reportparameters rpm = new Reportparameters(hidInvDraft.Text);
        return rpm.GetNums(hidtype.Value.ToString(), flag, CmbPrint1.Text, param, hidsys.Value.ToString(), Page);

    }

    protected void LinBtnPDF_Click(object sender, EventArgs e)
    {
        //if (hidtype.Text == "Invoice")
        //{
        //    bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
        //                    Append("Option", "UpdateInvoiceNo").
        //                    Append("inv_seed",hidID.Text).
        //                    Append("code",FSecurityHelper.CurrentUserDataGET()[4]+"AI").
        //                    Append("inv_STAT",FSecurityHelper.CurrentUserDataGET()[12]).
        //                    Append("User",FSecurityHelper.CurrentUserDataGET()[0])                     
        //                    }).Update();
        //}
        //Session["Tishi"] = hidID.Text;
        //Invoice预览是否强制显示抬头
        hidInvDraft.Text = "1";
        ReportHelper.ExportRepFile(hidtype.Text + "-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf", true, Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), GetNums("N"));
    }

    protected void btnInvDraft_Click(object sender, EventArgs e)
    {
        GetPrintMargin();
        hidInvDraft.Text = "1";
        ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount1.Text), GetNums("Y"));
        Session["Tishi"] = hidID.Text;
        lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
        ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "AI", hidtype.Text + "(ID:" + hidID.Text + ")", CmbPrint1.Text);
    }

    protected void LinBtnPrint_Click(object sender, EventArgs e)
    {
        GetPrintMargin();
        if (hidtype.Text.ToUpper() == "INVOICE")
        {
            //Invoice预览是否强制显示抬头
            hidInvDraft.Text = "0";
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "CheckInvoiceNo").
                            Append("inv_seed",hidID.Text)                 
                            }).GetList();
            if (ds.Tables[0].Rows[0][0].ToString() == "Y")
            {
                ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount1.Text), GetNums("Y"));
                Session["Tishi"] = hidID.Text;
                lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
                ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "AI", hidtype.Text + "(ID:" + hidID.Text + ")", CmbPrint1.Text);
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
            ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "AI", hidtype.Text + "(ID:" + hidID.Text + ")", CmbPrint1.Text);
        }


    }

    [DirectMethod]
    public void PrintConfirm()
    {
        if (!LockDate.IsLock(hidID.Text, ""))
        {
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "UpdateInvoiceNo").
                            Append("inv_seed",hidID.Text).
                            Append("code",FSecurityHelper.CurrentUserDataGET()[4]+"AI").
                            Append("inv_STAT",FSecurityHelper.CurrentUserDataGET()[12]).
                            Append("User",FSecurityHelper.CurrentUserDataGET()[0])                     
                            }).Update();
        }
        Session["Tishi"] = hidID.Text;

        //ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount1.Text), GetNums("Y"));
        ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "AI", hidtype.Text + "(ID:" + hidID.Text + ")", CmbPrint1.Text);
        X.AddScript("window.location.reload();if(window.opener!=null){window.opener.location.reload();}");
    }
}

