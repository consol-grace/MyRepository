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


public partial class OceanExport_OEContainerList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            txtLotNo.Focus();
            txtETD.RawText = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
            txtETD.Text = DateTime.Now.AddDays(-30).ToString("yyyy/MM/dd");
            DataBinder();
        }
    }
    #region  DataBinder()   Author：Hcy  (2011-09-23)
    void DataBinder()
    {       
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Ocean_OIJobList_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "OIJobList")
            .Append("LotNo", txtLotNo.Text.Trim())
            .Append("MBL", txtMBL.Text.Trim())
            .Append("POL", txtPOL.Text.Trim())
            .Append("POD", txtPOD.Text.Trim())
            .Append("Vessel", txtVessel.Text.Trim())
            .Append("ETD", ControlBinder.getDate(txtETD.RawText.StartsWith("0001")?DBNull.Value:(object)txtETD.RawText))
            .Append("ETA", ControlBinder.getDate(txtETA.RawText.StartsWith("0001")?DBNull.Value:(object)txtETA.RawText)) 
            .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("SYS","OI" )
        }).GetList();
        storeList.DataSource = ds;
        storeList.DataBind();
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
        var win = new Window
        {
            ID = "Window1",
            Title = " ",
            Width = Unit.Pixel(975),
            Height = Unit.Pixel(467),
            Modal = false,
            BodyStyle = "background-color: #fff;",
            Padding = 5,
            PageY = 10,
            PageX = 10,
            Resizable = true,
            Draggable = true
        };

        win.AutoLoad.Url = "DetailList.aspx?ID=" + id;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Render();
        win.Show();
    }
}
