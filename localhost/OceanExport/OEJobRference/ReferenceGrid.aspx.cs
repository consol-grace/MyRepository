using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using Ext.Net;
using System.Collections;

public partial class OceanExport_OEJobRference_ReferenceGrid : System.Web.UI.Page
{
    private static string sys = "OE";
    private static string from = "";
    private static string to = "";
    private static string dest = "";
    private static string sales = "";
    private static string shipper = "";
    private static string consignee = "";

    private static string JobNo = "";
    private static string MBL = "";
    private static string HBL = "";
    private static string Sales = "";
    private static string Container = "";
    private static string Vessel = "";
    private static string Voyage = "";
    private static string coloader = "";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        DecodeURL();
        if (CreateTable().Rows.Count > 0)
        {
            gridView.DataSource = CreateTable();
            gridView.DataBind();
        }
        else
        {
            RepList.DataSource = GetHander();
            RepList.DataBind();
            divRep.Visible = true;
        }
    }
    DataFactory dal = new DataFactory();

    private void DecodeURL()
    {
        if (Request["Sys"] != null)
        {
            sys = Request["Sys"];
        }
        if (Request["From"] != null)
        {
            from = Server.UrlDecode(Request["From"]);
            if (from == "")
            {
                from = "1900/01/01";
            }
            else
            {
                from = (string)ControlBinder.getDate(from);
            }
        }
        if (Request["To"] != null)
        {
            to = Server.UrlDecode(Request["To"]);
            if (to == "")
            {
                to = "2100/01/01";
            }
            else
            {
                to = (string)ControlBinder.getDate(to);
            }
        }
        if (Request["Dest"] != null)
        {
            dest = Server.UrlDecode(Request["Dest"]);
        }
        if (Request["Sales"] != null)
        {
            sales = Server.UrlDecode(Request["Sales"]);
        }
        if (Request["Shipper"] != null)
        {
            shipper = Server.UrlDecode(Request["Shipper"]);
        }
        if (Request["Consignee"] != null)
        {
            consignee = Server.UrlDecode(Request["Consignee"]);
        }
        if (Request["JobNo"] != null)
        {
            JobNo = Server.UrlDecode(Request["JobNo"]);
        }
        if (Request["MBL"] != null)
        {
            MBL = Server.UrlDecode(Request["MBL"]);
        }
        if (Request["HBL"] != null)
        {
            HBL = Server.UrlDecode(Request["HBL"]);
        }
       
        if (Request["Container"] != null)
        {
            Container = Server.UrlDecode(Request["Container"]);
        }
        if (Request["Vessel"] != null)
        {
            Vessel = Server.UrlDecode(Request["Vessel"]);
        }
        if (Request["Voyage"] != null)
        {
            Voyage = Server.UrlDecode(Request["Voyage"]);
        }
        if (Request["Coloader"] != null)
        {
            coloader = Server.UrlDecode(Request["Coloader"]);
        }


        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintList")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode","JobReference").Append("prt_sys",sys)
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
        ReportHelper.ExportRepFile("JobReference" + "-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf", true, Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), GetNums("N"));
    }

    protected void LinBtnPrint_Click(object sender, EventArgs e)
    {
        ReportHelper.SetReportDoc(Convert.ToDouble(hidtop.Text), Convert.ToDouble(hidbottom.Text), Convert.ToDouble(hidleft.Text), Convert.ToDouble(hidright.Text), int.Parse(cmbPrintCount.SelectedItem.Value), GetNums("Y"));
        lbltishi.Text = "Printed on  " + DateTime.Now.ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
    }

    private string[] GetNums(string flag)
    {
        string[] nums = null;

        nums = new string[18];
        nums[0] = Server.MapPath("~/Report/CommonReportFile/" + "JobReference" + ".rpt");
        nums[1] = flag;
        nums[2] = CmbPrint.SelectedItem.Value;
        nums[3] = consignee;
        nums[4] = from;
        nums[5] = to;
        nums[6] = dest;
        nums[7] = shipper;
        nums[8] = FSecurityHelper.CurrentUserDataGET()[12];
        nums[9] = sys;
        nums[10] = coloader;
        nums[11] = Container;
        nums[12] = HBL;
        nums[13] = JobNo;
        nums[14] = MBL;
        nums[15] = sales;
        nums[16] = Vessel;
        nums[17] = Voyage;

        return nums;
    }

    public DataSet GetHander()
    {
        return dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Reference_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "Header") 
            .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS",sys)
        }).GetList();
    }
    public DataTable CreateTable()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Reference_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "Header") 
            .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS",sys)
        }).GetList();
        DataTable dt = new DataTable("Reference");

        foreach (DataRow row in ds.Tables[0].Rows)
        {
            DataColumn LOTNO = new DataColumn(row["LOTNO"].ToString());
            DataColumn FLTDATE = new DataColumn(row["FLTDATE"].ToString());
            DataColumn MASTER_NO = new DataColumn(row["MASTER_NO"].ToString());
            DataColumn HOUSE_NO = new DataColumn(row["HOUSE_NO"].ToString());
            DataColumn SHPR = new DataColumn(row["SHPR"].ToString());
            DataColumn CNEE = new DataColumn(row["CNEE"].ToString());
            DataColumn DEPART = new DataColumn(row["DEPART"].ToString());
            DataColumn DEST = new DataColumn(row["DEST"].ToString());
            DataColumn CWT = new DataColumn(row["CWT"].ToString());
            DataColumn Seed = new DataColumn(row["Seed"].ToString());
            DataColumn ToMBL = new DataColumn(row["ToMBL"].ToString());
            DataColumn Cost = new DataColumn(row["Cost"].ToString());
            DataColumn Revenue = new DataColumn(row["Revenue"].ToString());
            dt.Columns.Add(LOTNO);
            dt.Columns.Add(FLTDATE);
            dt.Columns.Add(MASTER_NO);
            dt.Columns.Add(HOUSE_NO);
            dt.Columns.Add(SHPR);
            dt.Columns.Add(CNEE);
            dt.Columns.Add(DEPART);
            dt.Columns.Add(DEST);
            dt.Columns.Add(CWT);
            dt.Columns.Add(Seed);
            dt.Columns.Add(ToMBL);
            dt.Columns.Add(Cost);
            dt.Columns.Add(Revenue);
        }
        DataSet ds1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Reference_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "DataBinder") 
            .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS",sys)
            .Append("Shipper",shipper)
            .Append("Consignee",consignee)
            .Append("DateFrom",from)
            .Append("DateTo",to)
            .Append("Dest",dest)
            .Append("Sales",sales)
            .Append("JobNo",JobNo)
            .Append("Master",MBL)
            .Append("House",HBL)
            .Append("Vessel",Vessel)
            .Append("Voyage",Voyage)
            .Append("Container",Container)
            .Append("Coloader",coloader)
        }).GetList();
        
        foreach (DataRow row in ds1.Tables[0].Rows)
        {
                DataRow dr = dt.NewRow();
                dr[0] = row["mawb_LotNo"].ToString();
                if (row["mawb_Date"].ToString() != "")
                {
                    DateTime dtime = (DateTime)row["mawb_Date"];
                    dr[1] = dtime.ToString("dd/MM/yyyy").Replace("-", "/");
                }
                else
                {
                    dr[1] = "";
                }
                dr[2] = row["mawb_master"];
                dr[3] = row["hawb_HAWB"];
                dr[4] = row["mawb_Shipper"].ToString();
                dr[5] = row["mawb_Consignee"].ToString();
                dr[6] = row["mawb_From"].ToString();
                dr[7] = row["mawb_Dest"].ToString();
                dr[8] = row["mawb_CWT"].ToString();
                dr[9] = row["seedid"].ToString();
                dr[10] = row["hawb_ToMAWB"].ToString();
                dr[11] = row["mawb_MAWBCost"].ToString();
                dr[12] = row["mawb_MAWBInv"].ToString();
                dt.Rows.Add(dr);

        }
        return dt;
    }

    public void gridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.Header)
        {
            if (e.Row.Cells[2].Text == "&nbsp;")
            {
                e.Row.Cells[2].Text = "<a href='javascript:void(0);' onclick=CompanyX.ShowDetail('" + e.Row.Cells[9].Text + "');>" + "### MBL ###" + "</a>";
            }
            else
            {
                e.Row.Cells[2].Text = "<a href='javascript:void(0);' onclick=CompanyX.ShowDetail('" + e.Row.Cells[9].Text + "');>" + e.Row.Cells[2].Text + "</a>";
            }
            for (int i = 1; i <= e.Row.Cells.Count - 1; i++)
            {
                e.Row.Cells[i].Attributes.Add("style", "padding-left:2px; padding-right:2px;text-size:12px;");
            }
            e.Row.Cells[6].Attributes.Add("align", "center");
            e.Row.Cells[7].Attributes.Add("align", "center");
            e.Row.Cells[8].Attributes.Add("align", "right");
            e.Row.Cells[11].Attributes.Add("align", "right");
            e.Row.Cells[12].Attributes.Add("align", "right");
            e.Row.Cells[4].Text = "<div style='width:175px;'><input type='text' style='border:1px;width:99%;background-color:Transparent;' readonly='readonly'  value='" + e.Row.Cells[4].Text + "'></input></div>";
            e.Row.Cells[5].Text = "<div style='width:175px;'><input type='text' style='border:1px;width:99%;background-color:Transparent;' readonly='readonly'  value='" + e.Row.Cells[5].Text + "'></input></div>";
        }
        else
        {
            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                e.Row.Cells[i].Attributes.Add("style", "text-align:center !important;font-weight:bold !important;");
            }
        }
        e.Row.Cells[9].Visible = false;
        e.Row.Cells[10].Visible = false;
    }

    [DirectMethod]
    public void ShowDetail(string id)
    {
        string url1 = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/"));
        string url = "";
        if (Request["Sys"] != null)
        {
            sys = Request["Sys"];
            if (sys == "OE")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/OEJobList/DetailList.aspx?ID=" + id;
            }
            else
            {
                url=url1.Substring(0, url1.LastIndexOf("/")) + "/../OceanImport/OceanShipmentJobList/DetailList.aspx?ID=" + id;
            }
        }
        

        X.AddScript("var win=this.parent.parent.WinView; win.load('" + url + "');win.show();");
    }
}
