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

public partial class BasicData_Customer_company_report_reportView : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DecodeURL();
            hidtype.Value = Request.QueryString["type"];
            CrystalReportViewer1.ReportSource = CompanyView.Preview("N", Convert.ToInt32(Request["Copies"]), Request["reportType"], Request.QueryString["type"], Request.QueryString["sort"], Request.QueryString["print"], this);
            CrystalReportViewer1.DataBind();
        }
    }

    protected void LinBtnPrint_Click(object sender, EventArgs e)
    {
        //GetPrintMargin();
        //if (hidtype.Value.ToUpper() == "INVOICE")
        //{
        //    //Invoice预览是否强制显示抬头
        //    hidInvDraft.Value = "0";
        //    DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
        //                    Append("Option", "CheckInvoiceNo").
        //                    Append("inv_seed",hidID.Value) 
        //                    .Append("inv_IsPrinted","1")
        //                    }).GetList();
        //    if (ds.Tables[0].Rows[0][0].ToString() == "Y")
        //    {
        //        ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Value), Convert.ToDouble(hidbottom.Value), Convert.ToDouble(hidleft.Value), Convert.ToDouble(hidright.Value), int.Parse(Request.QueryString["Copies"]), GetNums("Y"));
        //        Session["Tishi"] = hidID.Value;
        //        //lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
        //        ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "AI", hidtype.Value + "(ID:" + hidID.Value + ")", Request.QueryString["print"]);
        //    }
        //    else
        //    {
        //        X.Msg.Confirm("Print confirm", "Are you sure to print?", "if (buttonId == 'yes') { CompanyX.PrintConfirm(); }").Show();
        //    }
        //}
        //else
        //{
        //    ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Value), Convert.ToDouble(hidbottom.Value), Convert.ToDouble(hidleft.Value), Convert.ToDouble(hidright.Value), int.Parse(Request.QueryString["Copies"]), GetNums("Y"));
        //    Session["Tishi"] = hidID.Value;
        //    //lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
        //    ControlBinder.PrintLog(FSecurityHelper.CurrentUserDataGET()[0], FSecurityHelper.CurrentUserDataGET()[12], "AI", hidtype.Value + "(ID:" + hidID.Value + ")", Request.QueryString["print"]);
        //}
    }
    private void DecodeURL()
    {
        if (Request["Copies"] != null)
        {
            hidCopies.Value = Request["Copies"];
        }
        if (Request["type"] != null)
        {
            hidtype.Value = Request["type"];
        }
        if (Request["sort"] != null)
        {
            hidSort.Value = Request["sort"];
        }
        if (Request["print"] != null)
        {
            hidPrint.Value = Request["print"];
        }

    }
}
