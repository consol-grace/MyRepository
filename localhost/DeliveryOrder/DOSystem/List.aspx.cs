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

public partial class DeliveryOrder_DOSystem_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtDate);
            ControlBinder.DateFormat(txtTo);
            txtDate.Focus(true);
            txtDate.Text = DateTime.Now.AddDays(-7).ToString("yyyy/MM/dd");
            txtDate.RawText = DateTime.Now.AddDays(-7).ToString("yyyy/MM/dd");
            DataBinder();
        }
    }

    void DataBinder()
    {
        
        try
        {
            DataFactory dal = new DataFactory();

            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_System_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List")
                 .Append("do_OrderDate", ControlBinder.getDate(string.IsNullOrEmpty(txtDate.RawText.Trim()) ? "1900/01/01" : (object)txtDate.RawText.Trim()))
                 .Append("do_OrderTo", ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText.Trim()) ? DateTime.MaxValue : (object)txtTo.RawText.Trim()))
                 .Append("do_Company",(string.IsNullOrEmpty(ACCompany.Value))? "": ACCompany.Value.Trim())
                 .Append("do_IsVoid", chbVoid.Checked?"1":"0")
                 .Append("do_Stat",FSecurityHelper.CurrentUserDataGET()[12]) 
                 .Append("DO",txtDO.Text.Trim()) 
        }).GetList();

            storeList.DataSource = ds;
            storeList.DataBind();

        }
        catch
        {

        }

    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }

    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        object from = ControlBinder.getDate(string.IsNullOrEmpty(txtDate.RawText.Trim()) ? "1900/01/01" : (object)txtDate.RawText.Trim());
        object to = ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText.Trim()) ? DateTime.MaxValue : (object)txtTo.RawText.Trim());

        string param = "sys=DO&Company=" + ((string.IsNullOrEmpty(ACCompany.Value))? "": ACCompany.Value.Trim()) + "&do_Active=" + (chbVoid.Checked ? "1" : "0") + "&Date=" + Server.UrlEncode(from.ToString()) + "&TO=" + Server.UrlEncode(to.ToString());
        string script = "window.open('/AllSystem/PrintLotList.aspx?" + param + "','_blank')";
        X.AddScript(script);
    }
}