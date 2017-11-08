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

public partial class OceanExport_OEJobList_List : System.Web.UI.Page
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
            ControlBinder.DateFormat(txtETDFrom);
            ControlBinder.DateFormat(txtETDTo);
            txtETDFrom.RawText = DateTime.Now.AddDays(-10).ToString("dd/MM/yyyy");
            txtETDFrom.Text = DateTime.Now.AddDays(-10).ToString("yyyy/MM/dd");
            ControlBinder.CmbBinder(StoreOP, "GetUserListByStat");
            DataBinder();
        }
    }
    #region  DataBinder()   Author：Hcy  (2011-09-23)
    void DataBinder()
    {
         try
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_MBL_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "AssignJobList")
                .Append("o_LotNo", txtLotNo.Text.Trim())
                .Append("o_MBL", txtMBL.Text.Trim())
                .Append("o_LocFinal",txtDest.Text.Trim())
                .Append("o_ETD", ControlBinder.getDate(string.IsNullOrEmpty(txtETDFrom.RawText)?"1900-01-01":(object)txtETDFrom.RawText))
                .Append("o_ETA", ControlBinder.getDate(string.IsNullOrEmpty(txtETDTo.RawText)?DateTime.MaxValue.ToString("yyyy/MM/dd"):(object)txtETDTo.RawText)) 
                .Append("o_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("o_SYS","OE" )
                .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString())
                .Append("o_Shipper", txtShipper.Text.Trim())//2014-12-16 Grace (修改查询条件)
                .Append("o_Active", chbVoid.Checked?"1":"0") 
                .Append("User",cmbOP.Text)
            }).GetList();
            storeList.DataSource = ds;
            storeList.DataBind();

            if (FSecurityHelper.CurrentUserDataGET()[27].ToString().ToUpper() == "MANAGER")
            {
                gridList.ColumnModel.SetHidden(16, false);
                gridList.ColumnModel.SetColumnWidth(6, 68);
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

    public void StoreOP_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreOP, "GetUserListByStat");
    }

    #region   btnFilter_Click(object,DirectEventArgs)   Author： Hcy  (2011-09-23)
    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
    }
    #endregion


    [DirectMethod]
    public void ShowDetail(string id)
    {
        string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/DetailList.aspx?ID=" + id;

        X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");

    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        object ETD = ControlBinder.getDate(string.IsNullOrEmpty(txtETDFrom.RawText) ? "1900/01/01" : (object)txtETDFrom.RawText);
        object ETA = ControlBinder.getDate(string.IsNullOrEmpty(txtETDTo.RawText) ? DateTime.Now.AddYears(1).ToString("yyyy/MM/dd") : (object)txtETDTo.RawText);
        string param = "sys=OE&LotNo=" + Server.UrlEncode(txtLotNo.Text.Trim()) + "&MBL=" + Server.UrlEncode(txtMBL.Text.Trim()) + "&Dest=" + Server.UrlEncode(txtDest.Text.Trim()) + "&ETD=" + Server.UrlEncode(ETD.ToString()) + "&ETA=" + Server.UrlEncode(ETA.ToString()) + "&Shipper=" + Server.UrlEncode(txtShipper.Text.Trim());
        string script = "window.open('/AllSystem/PrintLotList.aspx?" + param + "','_blank')";
        X.AddScript(script);
    }

}
