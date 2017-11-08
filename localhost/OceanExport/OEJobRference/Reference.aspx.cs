using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class OceanExport_OEJobRference_Reference : System.Web.UI.Page
{
    protected static string sys = "OE";
    DataFactory dal = new DataFactory();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtETDFrom.Focus();
            ControlBinder.DateFormat(txtETDFrom);
            ControlBinder.DateFormat(txtETDTo);
            string date = DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString().PadLeft(2, '0') + "/01";
            txtETDFrom.RawText = date;
            txtETDFrom.Text = date;
            if (Request["Sys"] != null)
            {
                sys = Request["Sys"];
            }
            ComboboxBinder();
        }
    }

    public void ComboboxBinder()
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", sys.Substring(0, 1));
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", sys.Substring(0, 1));
        
    }

    

    public void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", sys.Substring(0, 1));
    }

    public void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", sys.Substring(0, 1));
    }

    public string href()
    {
        string from = Server.UrlEncode(txtETDFrom.RawText.Trim());
        string to = Server.UrlEncode(txtETDTo.RawText.Trim());
        string dest = Server.UrlEncode(cmbDest.Text);
        string shipper = Server.UrlEncode(cmbShipperCode.Value);
        string consignee = Server.UrlEncode(cmbConsigneeCode.Value);

        string JobNo = Server.UrlEncode(txtJobNo.Text.Trim());
        string MBL = Server.UrlEncode(txtMBL.Text.Trim());
        string HBL = Server.UrlEncode(txtHBL.Text.Trim());
        string Sales = Server.UrlEncode(cmbSalesman.Text);
        string Container = Server.UrlEncode(txtContainer.Text.Trim());
        string Vessel = Server.UrlEncode(txtVessel.Text.Trim());
        string Voyage = Server.UrlEncode(txtVoyage.Text.Trim());
        string coloader = Server.UrlEncode(CmbColoader.Value);

        string hrefValue = "ReferenceGrid.aspx?Sys=" + sys + "&From=" + from + "&To=" + to + "&Dest=" + dest + "&Shipper=" + shipper + "&Consignee=" + consignee;
        hrefValue += "&JobNo=" + JobNo + "&MBL=" + MBL + "&HBL=" + HBL + "&Sales=" + Sales + "&Container=" + Container + "&Vessel=" + Vessel + "&Voyage=" + Voyage + "&Coloader=" + coloader ;
        
        return hrefValue;
    }
    public void btnSearch_Click(object sender, EventArgs e)
    {
        X.AddScript("$('#mainReference').attr('src', '" + href() + "');");
    }
}
