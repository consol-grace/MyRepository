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

public partial class OceanExport_OEContainerList_CntrAndSeal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            txtContainer.Focus(true);
            ComboBoxBinding();
            DataBinder();
        }
    }

    public void StoreCN_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCN, "ContainerSize");
    }

    #region  DataBinder()   Author：Hcy  (2011-10-17)
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetContainerListByMBL")
            .Append("oc_Seed", Request.QueryString["seed"])
            .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].ToString()[0])
        }).GetList();

        storeList.DataSource = ds.Tables[1];
        storeList.DataBind();

        lblLotNo.Text = ds.Tables[0].Rows[0]["o_LotNo"].ToString();
        lblMBL.Text = ds.Tables[0].Rows[0]["o_MBL"].ToString();
        lblETD.Text = ds.Tables[0].Rows[0]["O_ETD"].ToString();
    }
    #endregion

    #region   ComboBoxBinding()    Author ：Hcy   (2011-09-27)
    private void ComboBoxBinding()
    {
        ControlBinder.CmbBinder(StoreCN, "ContainerSize");
    }
    #endregion

    #region   btnAssign_Click(object,DirectEventArgs)   Author： Hcy  (2011-10-18)
    protected void btnAssign_Click(object sender, DirectEventArgs e)
    {
        string idList = "";
        RowSelectionModel sm = gridList.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            idList += row.RecordID + ",";
        }
        if (idList.Length > 1)
        {
            DataFactory dal = new DataFactory();
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "UpdateContainerListByMBL")
            .Append("oc_CtnrNo", txtContainer.Text.Trim().ToUpper())
            .Append("oc_SealNo", txtSeal.Text.Trim().ToUpper())
            .Append("oc_CtnrSize", CmbSize.Value)
            .Append("oc_SONo", txtSO.Text.Trim().ToUpper())
            .Append("IDList", idList)
              }).Update();
            sm.SelectedRows.Clear();
            sm.UpdateSelection();
            DataBinder();
            txtContainer.Focus(true);
        }
    }
    #endregion


    #region   btnClear_Click(object,DirectEventArgs)   Author： Hcy  (2011-10-18)
    protected void btnClear_Click(object sender, DirectEventArgs e)
    {
        txtContainer.Text = "";
        txtSeal.Text = "";
        CmbSize.setValue("");
        txtSO.Text = "";
        txtContainer.Focus(true);

    }
    #endregion

    #region   row_Click(object,DirectEventArgs)  Author：Hcy （2012-09-23）
    protected void row_Click(object sender, DirectEventArgs e)
    {

        txtContainer.Text = e.ExtraParams["container"];
        txtSeal.Text = e.ExtraParams["seal"];
        CmbSize.setValue(e.ExtraParams["size"]);
        txtSO.Text = e.ExtraParams["so"];
        txtContainer.Focus(true);
    }
    #endregion
}
