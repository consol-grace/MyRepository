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
            hidsys.Text = Request["Sys"];
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
        if (Request["JobNo"] != null)
        {
            hidJob.Text = Server.UrlDecode(Request["JobNo"]);
        }
        if (Request["MBL"] != null)
        {
            hidMbl.Text = Server.UrlDecode(Request["MBL"]);
        }
        if (Request["HBL"] != null)
        {
            hidHbl.Text = Server.UrlDecode(Request["HBL"]);
        }
       
        if (Request["Container"] != null)
        {
            hidContainer.Text = Server.UrlDecode(Request["Container"]);
        }
        if (Request["Vessel"] != null)
        {
            hidVessel.Text = Server.UrlDecode(Request["Vessel"]);
        }
        if (Request["Voyage"] != null)
        {
            hidVoyage.Text = Server.UrlDecode(Request["Voyage"]);
        }
        if (Request["Coloader"] != null)
        {
            hidColoader.Text = Server.UrlDecode(Request["Coloader"]);
        }


        
    }

    public DataSet GetHander()
    {
        return dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllSystem_Reference_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "Header") 
            .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS",hidsys.Text)
        }).GetList();
    }
    public DataTable CreateTable()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllSystem_Reference_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "Header") 
            .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS",hidsys.Text)
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
        DataSet ds1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllSystem_Reference_SP", new List<IFields>() {
            dal.CreateIFields()
            .Append("Option", "DataBinder") 
            .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS",hidsys.Text)
            .Append("Shipper",hidshipper.Text)
            .Append("Consignee",hidconsignee.Text)
            .Append("DateFrom",hidfrom.Text)
            .Append("DateTo",hidto.Text)
            .Append("Dest",hiddest.Text)
            .Append("Sales",hidsales.Text)
            .Append("JobNo",hidJob.Text)
            .Append("Master",hidMbl.Text)
            .Append("House",hidHbl.Text)
            .Append("Vessel",hidVessel.Text)
            .Append("Voyage",hidVoyage.Text)
            .Append("Container",hidContainer.Text)
            .Append("Coloader",hidColoader.Text)
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
                e.Row.Cells[2].Text = "<a href='javascript:void(0);' onclick=showurl('"+GetUrl(e.Row.Cells[9].Text)+"')>" + "### MBL ###" + "</a>";
            }
            else
            {
                e.Row.Cells[2].Text = "<a href='javascript:void(0);' onclick=showurl('" + GetUrl(e.Row.Cells[9].Text) + "')>" + e.Row.Cells[2].Text + "</a>";
            }
            for (int i = 1; i <= e.Row.Cells.Count - 1; i++)
            {
                e.Row.Cells[i].Attributes.Add("style", "padding-left:2px; padding-right:2px;text-size:12px;");
            }
            e.Row.Cells[6].Attributes.Add("align", "center");
            e.Row.Cells[7].Attributes.Add("align", "center");
            e.Row.Cells[8].Attributes.Add("align", "right");
            e.Row.Cells[11].Attributes.Add("style", "text-align:right !important; width:75px  !important; ");
            e.Row.Cells[12].Attributes.Add("style", "text-align:right !important; width:75px !important;");
            e.Row.Cells[3].Text = "<div style='width:70px;'><input type='text' style='border:1px;width:100%;background-color:Transparent;' readonly='readonly'  value='" + e.Row.Cells[3].Text + "'></input></div>";
            e.Row.Cells[4].Text = "<div style='width:120px;'><input type='text' style='border:1px;width:100%;background-color:Transparent;' readonly='readonly'  value='" + e.Row.Cells[4].Text + "'></input></div>";
            e.Row.Cells[5].Text = "<div style='width:120px;'><input type='text' style='border:1px;width:100%;background-color:Transparent;' readonly='readonly'  value='" + e.Row.Cells[5].Text + "'></input></div>";
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
            hidsys.Text = Request["Sys"];
            if (hidsys.Text == "OE")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../OceanExport/OEJobList/DetailList.aspx?ID=" + id;
            }
            else if (hidsys.Text == "OI")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../OceanImport/OceanShipmentJobList/DetailList.aspx?ID=" + id;
            }
            else if (hidsys.Text == "AE")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../AirExport/AEViewConsol/DetailList.aspx?ID=" + id;
            }
            else if (hidsys.Text == "AI")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../AirImport/AIShipmentJobList/DetailList.aspx?ID=" + id;
            }
            else
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../OceanImport/OceanShipmentJobList/DetailList.aspx?ID=" + id;
            }
        }
        

        X.AddScript("var win=this.parent.parent.WinView; win.load('" + url + "');win.show();");
    }

    private string GetUrl(string id)
    {
        string url1 = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/"));
        string url = "";
        if (Request["Sys"] != null)
        {
            hidsys.Text = Request["Sys"];
            if (hidsys.Text == "OE")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../OceanExport/OEJobList/DetailList.aspx?ID=" + id;
            }
            else if (hidsys.Text == "OI")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../OceanImport/OceanShipmentJobList/DetailList.aspx?ID=" + id;
            }
            else if (hidsys.Text == "AE")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../AirExport/AEViewConsol/DetailList.aspx?ID=" + id;
            }
            else if (hidsys.Text == "AI")
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../AirImport/AIShipmentJobList/DetailList.aspx?ID=" + id;
            }
            else
            {
                url = url1.Substring(0, url1.LastIndexOf("/")) + "/../OceanImport/OceanShipmentJobList/DetailList.aspx?ID=" + id;
            }
        }
        return url;
    }
}
