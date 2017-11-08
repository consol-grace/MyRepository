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


public partial class OceanImport_OIJobList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            TextHelper tp = new TextHelper();
            string sys = Request["sys"] == null ? "" : Request["sys"];
            txtLotNo.Text = tp.getPre(sys);
            txtLotNo.Focus();
            tp.SetFocusAtLast("txtLotNo");
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
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Ocean_OIJobList_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "OIJobList")
                .Append("LotNo", txtLotNo.Text.Trim())
                .Append("MBL", txtMBL.Text.Trim())
                .Append("POL", txtPOL.Text.Trim())
                //.Append("POD", txtPOD.Text.Trim())
                .Append("Vessel", txtVessel.Text.Trim())
                .Append("From", ControlBinder.getDate(string.IsNullOrEmpty(txtFrom.RawText)?"1900/01/01":(object)txtFrom.RawText))
                .Append("To", ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText)?DateTime.Now.AddYears(1).ToString("yyyy/MM/dd"):(object)txtTo.RawText)) 
                .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("SYS","OI" )
                .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString())
                .Append("o_Shipper", txtShipper.Text.Trim())//2014-12-18 Grace (修改查询条件)
                .Append("o_Active", chbVoid.Checked?"1":"0") 
            }).GetList();
            storeList.DataSource = ds;
            storeList.DataBind();

            if (FSecurityHelper.CurrentUserDataGET()[27].ToString().ToUpper() == "MANAGER")
            {
                gridList.ColumnModel.SetHidden(13, false);
                gridList.ColumnModel.SetColumnWidth(7, 68);
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


    //#region  btnCNTR_Click(object , DirectEventArgs)    Author  : Micro  (2011-10-21)
    //protected void btnCNTR_Click(object sender, DirectEventArgs e)
    //{         
    //    RowSelectionModel sm = this.gridList.SelectionModel.Primary as RowSelectionModel;
    //    foreach (SelectedRow row in sm.SelectedRows)
    //    {
    //        X.AddScript("window.open('ContainerList.aspx?seed=" + e.ExtraParams["seed"] + "','_blank')");
    //        return;
    //    }
    //    X.Msg.Alert("Status", "please select  row ?").Show();
    //}
    //#endregion

    [DirectMethod]
    public void ShowDetail(string id)
    {
        string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/DetailList.aspx?ID=" + id;

        X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");

    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        object From = ControlBinder.getDate(string.IsNullOrEmpty(txtFrom.RawText) ? "1900/01/01" : (object)txtFrom.RawText);
        object To = ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText) ? DateTime.Now.AddYears(1).ToString("yyyy/MM/dd") : (object)txtTo.RawText);
        //2014-12-18 Grace (修改查询条件)
        //string param = "sys=OI&LotNo=" + Server.UrlEncode(txtLotNo.Text.Trim()) + "&MBL=" + Server.UrlEncode(txtMBL.Text.Trim()) + "&POL=" + Server.UrlEncode(txtPOL.Text.Trim()) + "&POD=" + Server.UrlEncode(txtPOD.Text.Trim());
        string param = "sys=OI&LotNo=" + Server.UrlEncode(txtLotNo.Text.Trim()) + "&MBL=" + Server.UrlEncode(txtMBL.Text.Trim()) + "&POL=" + Server.UrlEncode(txtPOL.Text.Trim()) + "&Shipper=" + Server.UrlEncode(txtShipper.Text.Trim());
        param += "&Vessel=" + Server.UrlEncode(txtVessel.Text.Trim()) + "&From=" + Server.UrlEncode(From.ToString()) + "&To=" + Server.UrlEncode(To.ToString());
        string script = "window.open('/AllSystem/PrintLotList.aspx?" + param + "','_blank')";
        X.AddScript(script);
    }
}
