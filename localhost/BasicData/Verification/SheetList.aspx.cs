using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;



public partial class common_UIControls_SheetList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                ControlBinder.DateFormat(txtBeginDate);
                ControlBinder.DateFormat(txtEndDate);

                txtEndDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
                txtBeginDate.Text = DateTime.Now.AddDays(-30).ToString("yyyy/MM/dd");
                Binder();

            }
        }
    }


    DataFactory dal = new DataFactory();
    void Binder()
    {
        object status = cmbStatus.Value ?? "0";
        object BeginDate = ControlBinder.getDate(txtBeginDate.RawText == "" ? "01/01/1900" : (object)txtBeginDate.RawText.Trim());
        object EndDate = ControlBinder.getDate(txtEndDate.RawText == "" ? DateTime.Now.AddDays(1).ToString("dd/MM/yyyy") : (object)txtEndDate.RawText.Trim());

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_CLP_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "filter")
                .Append("M",txtMHno.Text)
                .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("vv_VerifyNo",txtSheetNo.Text)
                .Append("lotno",txtLotno.Text)
                .Append("status",status)
                .Append("vv_ReceivedDate",BeginDate)
                .Append("vv_ReturnedDate",EndDate)
            }).GetTable();

        storeList.DataSource = dt;
        storeList.DataBind();
    }

    public void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        Binder();
    }


    public void btnFilter_Click(object sender, DirectEventArgs e)
    {
        Binder();
    }
   
}
