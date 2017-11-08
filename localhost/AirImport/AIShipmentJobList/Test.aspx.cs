using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using DIYGENS.COM.DBLL;

public partial class AirImport_AIShipmentJobList_Test : System.Web.UI.Page
{
    protected static string type = "";
    protected static string id = "";
    protected static string printName = "";
    public DataSet ds = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
            LoadValue();
            GetList();
        //}
    }
    private void LoadValue()
    {
        if (!string.IsNullOrEmpty(Request.QueryString["type"]))
        {
            type = Request.QueryString["type"];
        }
        if (!string.IsNullOrEmpty(Request.QueryString["ID"]))
        {
            id = Request.QueryString["ID"];
        }
        printName = "Konica IP-432 PCL6 CHT"; 
    }
    private void GetList()
    {
        ExecPro();
        DataFactory dal = new DataFactory();
        ds= dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ReportList_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "GetList")
        }).GetList();
    }

    private void ExecPro()
    {
        if (!string.IsNullOrEmpty(Request.QueryString["ID"]))
        {
            string rpt_RptFooter = "PAYMENT TERM:" + "\n\r" + " PAYMENT PLEASE MAKE PAYABLE TO:\"CONSOLIDATOR INTERNATIONAL CO.,LTD.\"" +
        "\n\r" + " IF THERE IS ANY ERRORS,PLEASE NOTIFY US WITHIN SEVEN(7) DAYS." + "\n\r" +
        " NOTE:CHEQUE SUBJECT TO CLEARING" + "\n\r" + "PAYMENT ACCOUNT:" + "\n\r" + "UBANK 2587898788898";
            //执行存储过程
            DataFactory dal = new DataFactory();
            dal.FactoryDAL(PageHelper.ConnectionStrings, "pro_invReport", new List<IFields>() { dal.CreateIFields().Append("INV_ID", id)
        .Append("rpt_Header","").Append("rpt_RptHeader","").Append("rpt_Footer","").Append("rpt_RptFooter",rpt_RptFooter)}).GetList();
        }

    }
}
 