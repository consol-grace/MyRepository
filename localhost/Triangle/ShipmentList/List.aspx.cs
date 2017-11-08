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

public partial class Triangle_ShipmentList_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            txtLotNo.Focus();
            ControlBinder.DateFormat(txtFrom);
            ControlBinder.DateFormat(txtTo);
            txtFrom.RawText = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
            txtFrom.Text = DateTime.Now.AddDays(-30).ToString("yyyy/MM/dd");
            DataBinder();
        }
    }
    #region  DataBinder()   Author：Hcy  (2011-09-23)
    void DataBinder()
    {
        try
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Triangle_ShipmentList_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetList")
            .Append("tri_MBL", txtMBL.Text.Trim())
            //.Append("tri_HBL", txtHBL.Text.Trim())
            .Append("tri_LotNo",txtLotNo.Text.Trim())
            .Append("tri_Shipper",txtShipper.Text.Trim())
            //.Append("tri_Consignee", txtCNEE.Text.Trim()) 
            .Append("tri_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("From", ControlBinder.getDate(string.IsNullOrEmpty(txtFrom.RawText)?"1900/01/01":(object)txtFrom.RawText))
            .Append("To", ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText)?DateTime.Now.AddYears(1).ToString("yyyy/MM/dd"):(object)txtTo.RawText)) 
            .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString())
            .Append("tri_Active", chbVoid.Checked?"1":"0")//2014-12-16 Grace (修改查询条件)
            .Append("tri_LocFinal",txtDest.Text.Trim())
        }).GetList();
            storeList.DataSource = ds;
            storeList.DataBind();
            if (FSecurityHelper.CurrentUserDataGET()[27].ToString().ToUpper() == "MANAGER")
            {
                gridList.ColumnModel.SetHidden(12, false);
                gridList.ColumnModel.SetColumnWidth(4, 73);
                gridList.ColumnModel.SetColumnWidth(5, 73);
            }

        }
        catch
        {

        }
    }
    #endregion

    #region storeList_OnRefreshData(object,StoreRefreshDataEventArgs)   Author： Hcy  (2011-09-23)
    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }
    #endregion

    #region   btnFilter_Click(object,DirectEventArgs)   Author： Hcy  (2011-09-23)
    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
    }
    #endregion


    [DirectMethod]
    public void ShowDetail(string id, string sys)
    {
        string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/DetailList.aspx?ID=" + id + "&sys=" + sys;

        X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");
        //X.AddScript("showWin('" + url + "');");
    }


    protected void btnPrint_Click(object sender, EventArgs e)
    {
        object From = ControlBinder.getDate(string.IsNullOrEmpty(txtFrom.RawText) ? "1900/01/01" : (object)txtFrom.RawText);
        object To = ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText) ? DateTime.Now.AddYears(1).ToString("yyyy/MM/dd") : (object)txtTo.RawText);
        //string param = "sys=TG&Shipper=" + Server.UrlEncode(txtShipper.Text.Trim()) + "&MBL=" + Server.UrlEncode(txtMBL.Text.Trim().Replace(" ", "")) + "&HBL=" + Server.UrlEncode(txtHBL.Text.Trim()) + "&LotNo=" + Server.UrlEncode(txtLotNo.Text.Trim());
        // param += "&Consignee=" +Server.UrlEncode(txtCNEE.Text.Trim()) + "&From=" + Server.UrlEncode(From.ToString()) + "&To=" + Server.UrlEncode(To.ToString());

        string param = "sys=TG&Shipper=" + Server.UrlEncode(txtShipper.Text.Trim()) + "&MBL=" + Server.UrlEncode(txtMBL.Text.Trim().Replace(" ", "")) + "&HBL=" + Server.UrlEncode(txtMBL.Text.Trim()) + "&LotNo=" + Server.UrlEncode(txtLotNo.Text.Trim());
        param += "&Consignee=" + Server.UrlEncode(txtShipper.Text.Trim()) + "&From=" + Server.UrlEncode(From.ToString()) + "&To=" + Server.UrlEncode(To.ToString()) + "&Dest=" + Server.UrlEncode(txtDest.Text.Trim());
        string script = "window.open('/AllSystem/PrintLotList.aspx?" + param + "','_blank')";
        X.AddScript(script);
    }

}

