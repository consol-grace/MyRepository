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

public partial class AirExport_AEViewConsol_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    TextHelper tp = new TextHelper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtFlightFrom);
            ControlBinder.DateFormat(txtFlightTo);
            TextHelper tp = new TextHelper();
            string sys = Request["sys"] == null ? "" : Request["sys"];
            txtLotNo.Text = tp.getPre(sys);
            txtFlightFrom.Text = DateTime.Now.AddDays(-3).ToString("yyyy/MM/dd");
            txtFlightFrom.RawText = DateTime.Now.AddDays(-3).ToString("dd/MM/yyyy");
            DataBinder(); 
        }
    }
    void DataBinder()
    {
        txtLotNo.Focus();
        tp.SetFocusAtLast("txtLotNo");
        try
        {
            bool a = txtFlightFrom.RawText.Trim().ToUpper().StartsWith("0001");
            DataFactory dal = new DataFactory();

            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ViewConsol_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List")
                 .Append("air_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("air_MAWB",txtMAWB.Text.Replace(" ","").Trim()).Append("air_LotNo",txtLotNo.Text.Trim())
                 .Append("air_LocFinal",txtDest.Text.Trim()).Append("air_ETD",ControlBinder.getDate( txtFlightFrom.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtFlightFrom.RawText.Trim()))
                 .Append("air_ETA",ControlBinder.getDate( txtFlightTo.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtFlightTo.RawText.Trim()))
                 //2014-12-16 Grace (修改查询条件)
                 //.Append("air_Shipper",cmbShipperCode.Value)
                 //.Append("air_Consignee",cmbConsigneeCode.Value)
                 .Append("air_Shipper",txtShipper.Text.Trim())
                 .Append("air_CoLoader",txtColoader.Text.Trim())
                 .Append("air_Active", chbVoid.Checked?"1":"0") 
                 .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString())

                 
        }).GetList();

        storeList.DataSource = ds;
        storeList.DataBind();

        if (FSecurityHelper.CurrentUserDataGET()[27].ToString().ToUpper() == "MANAGER")
        {
            gridList.ColumnModel.SetHidden(14, false);
            gridList.ColumnModel.SetColumnWidth(8, 70);
            gridList.ColumnModel.SetColumnWidth(9, 70);
            gridList.ColumnModel.SetColumnWidth(10, 70);
        }
        }
        catch
        {
          
        }

    }

    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }


    [DirectMethod]
    public void ShowDetail(string id)
    {

        string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/DetailList.aspx?ID=" + id;

        X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");

    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        object ETD = ControlBinder.getDate(txtFlightFrom.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtFlightFrom.RawText.Trim());
        object ETA = ControlBinder.getDate(txtFlightTo.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtFlightTo.RawText.Trim());
        string param = "sys=AE&MAWB=" + Server.UrlEncode(txtMAWB.Text.Replace(" ", "").Trim()) + "&LotNo=" + Server.UrlEncode(txtLotNo.Text.Trim().Replace(" ", "")) + "&Dest=" + Server.UrlEncode(txtDest.Text.Trim());
        //2014-12-16 Grace (修改查询条件)
        //param += "&ETD=" + Server.UrlEncode(ETD.ToString()) + "&ETA=" + Server.UrlEncode(ETA.ToString()) + "&Shipper=" + Server.UrlEncode(cmbShipperCode.Value) + "&Consignee=" + Server.UrlEncode(cmbConsigneeCode.Value);
        //param += "&Coloader=" + Server.UrlEncode(cmbColoader.Value);
        param += "&ETD=" + Server.UrlEncode(ETD.ToString()) + "&ETA=" + Server.UrlEncode(ETA.ToString()) + "&Shipper=" + Server.UrlEncode(txtShipper.Text.Trim()) + "&Consignee=" + Server.UrlEncode(txtShipper.Text.Trim());
        param += "&Coloader=" + Server.UrlEncode(txtColoader.Text.Trim());
     
        string script = "window.open('/AllSystem/PrintLotList.aspx?" + param + "','_blank')";
        X.AddScript(script);
    }
}
