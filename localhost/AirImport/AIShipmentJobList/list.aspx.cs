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


public partial class AirImport_AIShipmentJobList_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtFrom);
            ControlBinder.DateFormat(txtTo);
            string sys = Request["sys"] == null ? "" : Request["sys"];
            txtLotNo.Text = tp.getPre(sys);
            ControlsInit();
            DataBinder();
        }
    }

    DataFactory dal = new DataFactory();
    TextHelper tp = new TextHelper();

    /// <summary>
    /// Grid 绑定
    /// </summary>
    #region  DataBinder()   Author：Micro  (2011-09-01)
    void DataBinder()
    {
        try
        {

        object from = ControlBinder.getDate(string.IsNullOrEmpty(txtFrom.RawText) ? "1900/01/01" : (object)txtFrom.RawText);
        object to = ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText) ? DateTime.Now.AddYears(1).ToString("yyyy/MM/dd") : (object)txtTo.RawText);

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Joblist_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "List")
            .Append("from", from)
            .Append("to",to)
            .Append("air_LotNo",txtLotNo.Text.Trim())
            .Append("air_SYS","AI")
            .Append("air_STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("air_Shipper", txtShipper.Text.Trim())
            .Append("air_MAWB", txtMawb.Text.Trim().Replace(" ",""))
            //.Append("air_LocLoad", cmbFrom.Text.Trim())
            .Append("air_LocLoad", txtDest.Text.Trim()) //2014-12-16 Grace (修改查询条件)
            .Append("air_Normal",chbNormal.Checked?1:0)
            .Append("air_IsDirect", chbDirect.Checked?"1":"0")
            .Append("air_Status", chbClosed.Checked?"10":"0")
            .Append("air_Active", chbVoid.Checked?"1":"0") 
            .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString())
        }).GetList();
            storeList.DataSource = ds;
            storeList.DataBind();
            if (FSecurityHelper.CurrentUserDataGET()[27].ToString().ToUpper() == "MANAGER")
            {
                gridList.ColumnModel.SetHidden(15, false);
                gridList.ColumnModel.SetColumnWidth(4, 74);
                gridList.ColumnModel.SetColumnWidth(5, 80);
            }

        }
        catch
        {

        }
    }
    #endregion


    /// <summary>
    /// 初始化控件
    /// </summary>
    #region  ControlsInit()   Author：Micro  (2011-09-01)
    void ControlsInit()
    {
        txtFrom.RawText = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
        txtFrom.Text = DateTime.Now.AddMonths(-1).ToString("yyyy/MM/dd");

        txtLotNo.Focus();
        tp.SetFocusAtLast("txtLotNo");
        //ControlBinder.CmbBinder(StoreFrom, "LocationList");//2014-12-16 Grace (修改查询条件)
    }
    #endregion
     
    /// <summary>
    /// 查询
    /// </summary>   
    #region   btnFilter_Click(object,DirectEventArgs)   Author：Micro  (2011-09-01)
    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
         DataBinder();
    }
    #endregion


    /// <summary>
    /// 刷新数据源
    /// </summary>    
    #region storeList_OnRefreshData(object,StoreRefreshDataEventArgs)   Author： Micro  (2011-09-01)
    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        int start = (e.Start == -1) ? 0 :e.Start;
        int limit = (e.Limit == -1) ? 100 : e.Limit;
        DataBinder();
    }
    #endregion

    [DirectMethod]
    public void ShowDetail(string id)
    {

        string url =Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/DetailList.aspx?ID=" + id;

        X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");

    }


    protected void btnPrint_Click(object sender, EventArgs e)
    {
        object from = ControlBinder.getDate(string.IsNullOrEmpty(txtFrom.RawText) ? "1900/01/01" : (object)txtFrom.RawText);
        object to = ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText) ? DateTime.Now.AddYears(1).ToString("yyyy/MM/dd") : (object)txtTo.RawText);

        //2014-12-16 Grace (修改查询条件)
        //string param = "sys=AI&air_Shipper=" + Server.UrlEncode(txtShipper.Text.Trim()) + "&air_MAWB=" + Server.UrlEncode(txtMawb.Text.Trim().Replace(" ", "")) + "&air_LocLoad=" + Server.UrlEncode(cmbFrom.Text.Trim()) + "&air_Normal=" + (chbNormal.Checked ? "1" : "0") + "&air_IsDirect=" + (chbDirect.Checked ? "1" : "0");
        string param = "sys=AI&air_Shipper=" + Server.UrlEncode(txtShipper.Text.Trim()) + "&air_MAWB=" + Server.UrlEncode(txtMawb.Text.Trim().Replace(" ", "")) + "&air_LocLoad=" + Server.UrlEncode(txtDest.Text.Trim()) + "&air_Normal=" + (chbNormal.Checked ? "1" : "0") + "&air_IsDirect=" + (chbDirect.Checked ? "1" : "0");
        param += "&air_Status=" + (chbClosed.Checked ? "10" : "0") + "&air_Active=" + (chbVoid.Checked ? "1" : "0") + "&from=" + Server.UrlEncode(from.ToString()) + "&to=" + Server.UrlEncode(to.ToString()) + "&lotNo=" + Server.UrlEncode(txtLotNo.Text.Trim());
        string script = "window.open('/AllSystem/PrintLotList.aspx?" + param + "','_blank')";
        X.AddScript(script);
    }
}
