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

public partial class AirImport_AIShipmentJobList_Report : System.Web.UI.Page
{
    //protected static string sys = "AI";
    //protected static string type = "DNCN";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["sys"] != null)
            {
                hidsys.Text = Request["sys"];
                if (hidsys.Text.ToUpper() == "SYS")
                {
                    lblLoc.Visible = true;
                    lblDest.Visible = false;
                }
            }
            if (Request["type"] != null)
            {
                hidtype.Text = Request["type"];
            }
            ControlBinder.DateFormat(txtETDFrom);
            ControlBinder.DateFormat(txtETDTo);
            string date = DateTime.Now.Year.ToString()+ "/"+ DateTime.Now.Month.ToString().PadLeft(2,'0') + "/01";
            txtETDFrom.RawText = date;
            txtETDFrom.Text = date;
            if (hidtype.Text == "SALES") 
            {
                lblCNEE.Visible = true;
                lblSHPR.Visible = true;
                cmbShipperCode.Visible = true;
                cmbConsigneeCode.Visible = true;
                divSales.Style.Add("display", "none");
                ControlBinder.CmbBinder(StoreSalesman, "SalesList", hidsys.Text.Substring(0, 1));
                ControlBinder.CmbBinder(StoreLocation, "LocationList", hidsys.Text.Substring(0, 1));
            }
            else if (hidtype.Text == "House") 
            {                
                lblSalesman.Visible = false;
                divSales.Style.Add("display", "none");
                divSalesman.Style.Add("display", "none");
                ControlBinder.CmbBinder(StoreSalesman, "SalesList", hidsys.Text.Substring(0, 1));
                ControlBinder.CmbBinder(StoreLocation, "LocationList", hidsys.Text.Substring(0, 1));
            }
            else if(hidtype.Text == "OP")
            {
                LblOP.Visible = true;
                lblSalesman.Visible = false;
                divSales.Style.Add("display", "none");
                divSalesman.Style.Add("display", "none");
                divOP.Style.Add("display", "block");
                ControlBinder.CmbBinder(StoreSalesman, "SalesList", hidsys.Text.Substring(0, 1));
                ControlBinder.CmbBinder(StoreLocation, "LocationList", hidsys.Text.Substring(0, 1));
                ControlBinder.CmbBinder(StoreOP, "GetUserListByStat");
            }
            else
            {
                lblSalesman.Visible = false;
                divSalesman.Style.Add("display", "none");
                divSales.Style.Add("display", "none");
                ControlBinder.CmbBinder(StoreLocation, "LocationList", hidsys.Text.Substring(0, 1));
            }
        }
    }

    public void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", hidsys.Text.Substring(0, 1));
    }

    public void StoreOP_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreOP, "GetUserListByStat");
    }

    public void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", hidsys.Text.Substring(0, 1));
    }

    public string href()
    {
        string from = Server.UrlEncode(txtETDFrom.RawText.Trim());
        string to = Server.UrlEncode(txtETDTo.RawText.Trim());
        //string dest = Server.UrlEncode(type=="SALES"?cmbSales.Text:cmbDest.Text);
        string dest = Server.UrlEncode(cmbDest.Text);
        string sales = Server.UrlEncode(hidtype.Text == "OP" ?cmbOP.Text:cmbSalesman.Text);
        string shipper = Server.UrlEncode(cmbShipperCode.Value);
        string consignee = Server.UrlEncode(cmbConsigneeCode.Value);

        string hrefValue = "ReportSearch.aspx?Sys=" + hidsys.Text + "&Type=" + hidtype.Text + "&From=" + from + "&To=" + to + "&Dest=" + dest + "&Sales=" + sales + "&Shipper=" + shipper + "&Consignee=" + consignee;

        return hrefValue;        
    }

    #region   btnFilter_Click(object,DirectEventArgs)   Author： Hcy  (2012-04-27)
    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        string src = href();
        X.AddScript("$('#mainReport').attr('src', '" + src + "');");
    }
    #endregion
    public string setTitle()
    {
        string title=string.Empty;
        switch (hidtype.Text)
        {
            case "AShipment": title = hidsys.Text + "- Shipment Report"; break;
            case "OShipment": title = hidsys.Text + "- Shipment Report"; break;
            //case "SALES": title = hidsys.Text + "- Salesman Report"; break;
            //case "DNCN": title = hidsys.Text + "- D/N & C/N Report"; break;
            case "SALES":
                title = hidsys.Text.ToUpper() == "SYS" ? "Salesman Report" : hidsys.Text + "- Salesman Report"; break;
            case "DNCN":
                title = hidsys.Text.ToUpper() == "SYS" ? "D/N & C/N Report" : hidsys.Text + "- D/N & C/N Report"; break;
            //case "House": title = hidsys.Text + "- HBL Report"; break;
            case "House":
                title = hidsys.Text.ToUpper() == "SYS" ? "HBL Report" : hidsys.Text + "- HBL Report"; break;
            //case "OP": title = hidsys.Text + "- Operator Report"; break;
            case "OP":
                title = hidsys.Text.ToUpper() == "SYS" ? "Operator Report" : hidsys.Text + "- Operator Report"; break;
            case "ALLShipment": title = "Shipment Report"; break;
        }
        return title; 
    }    
}
