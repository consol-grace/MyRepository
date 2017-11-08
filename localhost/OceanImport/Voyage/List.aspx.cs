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

public partial class OceanImport_Voyage_List : System.Web.UI.Page
{

    bool refresh = true;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            cmbVessel.Focus();

            //cmbVessel.Focus();
            labCarrierCode.Text = Request["carrier"];
            // labCarrierText.Text = Request["cartext"];

            ControlBinder.DateFormat(txtETA);
            ControlBinder.DateFormat(txtETD);
            ControlBinder.DateFormat(txtOnboard);
            ControlBinder.DateFormat(txtCY);
            ControlBinder.DateFormat(txtCFS);
            if (Request["vesselID"] == null)
            {
                cmbVessel.SelectedItem.Text = string.IsNullOrEmpty(Request["vstext"]) ? "" : Request["vstext"].ToUpper().ToString();
                cmbVessel.Value = string.IsNullOrEmpty(Request["vessel"]) ? "" : Request["vessel"].ToString();
            }
            else
            {
                cmbVessel.SelectedItem.Value = Request["vesselID"];
                txtVoyageID.Text = Request["voyageID"];
            }
            //cmbVessel.Text = Request["vstext"];
            //cmbVessel.Text="MICHAEL";
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            CmbBinder();
        }
    }

    DataFactory dal = new DataFactory();

    #region    ///初始化数据        Author：Micro    （2011-09-23）
    /// <summary>
    /// 初始化控件绑定
    /// </summary>
    void ControlInit()
    {
        int voyageID = -1;
        try
        {
            voyageID = Convert.ToInt32(txtVoyageID.Text);
        }
        catch
        {
            txtVoyageID.Text = voyageID.ToString();
        }

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Voyage_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "Single").
                Append("voy_ROWID",voyageID.ToString())}).GetList();

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            txtVoyageID.Text = ds.Tables[0].Rows[0]["voy_ROWID"].ToString();
            txtVoyage.Text = ds.Tables[0].Rows[0]["voy_Voyage"].ToString();
            cmbPOL.setValue(ds.Tables[0].Rows[0]["voy_POL"].ToString());
            cmbPOD.setValue(ds.Tables[0].Rows[0]["voy_POD"].ToString());
            txtETD.Text = ds.Tables[0].Rows[0]["voy_ETD"].ToString();
            txtETA.Text = ds.Tables[0].Rows[0]["voy_ETA"].ToString();
            txtOnboard.Text = ds.Tables[0].Rows[0]["voy_Onboard"].ToString();
            txtCFS.Text = ds.Tables[0].Rows[0]["voy_CFS"].ToString();
            txtCY.Text = ds.Tables[0].Rows[0]["voy_CY"].ToString();
            chcActive.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["voy_Active"]);
            storeVoyageRoute.DataSource = ds.Tables[1];
            storeVoyageRoute.DataBind();
            ControlBinder.pageTitleMsg(false, "Edit Voyage", "<p>Status : Edit Voyage . </p>", div_bottom);
        }
        else
            ControlBinder.pageTitleMsg(false, "New Voyage", "<p>Status : New  Blank  Voyage . </p>", div_bottom);


    }
    /// <summary>
    /// 查询数据绑定
    /// </summary>
    void DataBinder()
    {
        int voy_vessel = -1;
        try
        {
            voy_vessel = Convert.ToInt32(cmbVessel.SelectedItem.Value);
        }
        catch
        {
            cmbVessel.Value = "";
            cmbVessel.Text = "";
        }

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Voyage_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "list").
                Append("voy_Stat",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("voy_Vessel",voy_vessel)}).GetList();
        if (ds == null || ds.Tables[0].Rows.Count == 0)
        {
            txtVoyageID.Text = "0";
            //labCarrierCode.Text = "";
            txtVoyage.Text = "";
            txtCFS.RawText = "";
            txtCY.RawText = "";
            txtETA.RawText = "";
            txtETD.RawText = "";
            txtOnboard.RawText = "";
            cmbPOD.setValue("");
            cmbPOL.setValue("");
            gridVoyageRoute.GetStore().RemoveAll();
        }
        if (ds != null && ds.Tables[1].Rows.Count > 0)
            labCarrierCode.Text = ds.Tables[1].Rows[0]["Carrier"].ToString();

        storeVoyage.DataSource = ds;
        storeVoyage.DataBind();
        if ((string.IsNullOrEmpty(Request["vessel"]) && Request["vesselID"] == null) && refresh)
        {
            RowSelectionModel sm = gridVoyage.GetSelectionModel() as RowSelectionModel;
            sm.SelectRow(0);
            sm.SelectedRows.Add(new SelectedRow(0));            
        }
        else if (Request["vesselID"] != null && cmbVessel.SelectedItem.Value != Request["vesselID"].ToString() && refresh)
        {
            RowSelectionModel sm = gridVoyage.GetSelectionModel() as RowSelectionModel;
            sm.SelectRow(0);
            sm.SelectedRows.Add(new SelectedRow(0));
        }
    }
    protected void cmbVessel_Select(object sender, DirectEventArgs e)
    {
        refresh = true;
        DataBinder();

    }
    /// <summary>
    /// ComboBox数据绑定
    /// </summary>
    void CmbBinder()
    {
        ControlBinder.CmbBinder(storeVessel, "VesselList");
        ControlBinder.CmbBinder(storeLocation, "LocationList", "O");
        DataBinder();
        ControlInit();
    }
    #endregion

    #region   ///grid 选择事件处理     Author：Micro   （2011-09-23）
    protected void gridVoyage_RowSelect(object sender, DirectEventArgs e)
    {
        txtVoyageID.Text = e.ExtraParams["RowID"];
        ControlInit();
    }
    #endregion

    #region  ///Button 按钮事件处理     Author：Micro   （2011-09-23）
    /// <summary> 
    /// 保存
    /// </summary>    
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        refresh = false;
        try
        {
            if (string.IsNullOrEmpty(cmbVessel.Text))
            {
                cmbVessel.Focus();
                return;
            }
            if (string.IsNullOrEmpty(txtVoyage.Text.Trim()))
            {
                txtVoyage.Focus();
                return;
            }
            if (string.IsNullOrEmpty(ControlBinder.getDate(txtETD.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETD.RawText).ToString()))
            {
                txtETD.Focus();
                return;
            }
            if (string.IsNullOrEmpty(ControlBinder.getDate(txtETA.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETA.RawText).ToString()))
            {
                txtETA.Focus();
                return;
            }
            DataTable tb = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Voyage_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "Update").
                Append("voy_ROWID",txtVoyageID.Text).
                Append("voy_Parent",cmbVessel.Value).
                Append("voy_Voyage",txtVoyage.Text.ToUpper()).
                Append("voy_POL", cmbPOL.Value).
                Append("voy_POD",cmbPOD.Value).
                Append("voy_ETD", ControlBinder.getDate(txtETD.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETD.RawText)).                
                Append("voy_ETA",ControlBinder.getDate(txtETA.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETA.RawText)).
                Append("voy_Onboard",ControlBinder.getDate(txtOnboard.RawText.StartsWith("0001") ? DBNull.Value : (object)txtOnboard.RawText)).
                Append("voy_CFS",ControlBinder.getDate(txtCFS.RawText.StartsWith("0001") ? DBNull.Value : (object)txtCFS.RawText)).
                Append("voy_CY",ControlBinder.getDate(txtCY.RawText.StartsWith("0001") ? DBNull.Value : (object)txtCY.RawText)).
                Append("voy_Active",chcActive.Checked?1:0).
                Append("voy_Stat",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("voy_Sys","OI").
                Append("voy_Vessel",cmbVessel.SelectedItem.Text).
                Append("voy_User",FSecurityHelper.CurrentUserDataGET()[0])}).GetTable();//UpdateList
            if (tb == null && tb.Rows.Count == 0)
            {
                //X.Msg.Alert("prompt", " Save Failed ! ! !").Show();
                ControlBinder.pageTitleMsg(this, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
                return;
            }
            txtVoyageID.Text = tb.Rows[0][0].ToString();

            var list = JSON.Deserialize<List<VoyageRoute>>(e.ExtraParams["gridData"]);
            if (list.Count == 0)
            {
                if (!string.IsNullOrEmpty(Request["control"]))
                {
                    X.AddScript("this.parent.getshowVessel('" + cmbVessel.Text + "','" + txtVoyage.Text + "','" + cmbPOL.Text + "','" + cmbPOD.Text + "','" + txtETD.RawText + "','" + txtETA.RawText + "');");
                }
                else if (!string.IsNullOrEmpty(Request["controlID"]))
                {
                    X.AddScript("this.parent.getshowVessel('" + cmbVessel.Text + "','" + txtVoyageID.Text + "','" + Request["controlID"] + "');");
                }
                ControlBinder.pageTitleMsg(this, "<p class=\"success\">Status : Save successfully . </p>", div_bottom);
                DataBinder();
                return;
            }
            List<IFields> fields = new List<IFields>();
            for (int i = 0; i < list.Count; ++i)
            {
                fields.Add(dal.CreateIFields().
                  Append("Option", "UpdateList").
                  Append("vr_Tovoyage", tb.Rows[0][0]).
                  Append("vr_OrderID", i).
                  Append("vr_POL", list[i].POL).
                  Append("vr_POD", list[i].POD).
                  Append("vr_ETD", ControlBinder.getDate(list[i].ETD)).
                  Append("vr_ETA", ControlBinder.getDate(list[i].ETA)).
                  Append("voy_User", FSecurityHelper.CurrentUserDataGET()[0]));
            }

            bool a = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Voyage_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "DeleteAll").
                Append("vr_Tovoyage",txtVoyageID.Text)}).Update();

            bool c = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Voyage_SP", fields).Update();
            if (!c)
            {
                ControlBinder.pageTitleMsg(this, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
            }
            else
            {
                if (!string.IsNullOrEmpty(Request["control"]))
                {
                    X.AddScript("this.parent.getshowVessel('" + cmbVessel.Text + "','" + txtVoyage.Text + "','" + cmbPOL.Text + "','" + cmbPOD.Text + "','" + txtETD.RawText + "','" + txtETA.RawText + "');");
                }
                else if (!string.IsNullOrEmpty(Request["controlID"]))
                {
                    X.AddScript("this.parent.getshowVessel('" + cmbVessel.Text + "','" + txtVoyageID.Text + "','" + Request["controlID"] + "');");
                }
                ControlBinder.pageTitleMsg(this, "<p class=\"success\">Status : Save successfully . </p>", div_bottom);
            }
            DataBinder();
        }
        catch
        {
            ControlBinder.pageTitleMsg(this, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
        }
    }

    /// <summary>
    /// 还原
    /// </summary>    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ControlInit();
    }

    /// <summary>
    /// 复制
    /// </summary>    
    protected void btnCopy_Click(object sender, EventArgs e)
    {
        ControlInit();
        txtVoyageID.Text = "";
        txtVoyage.Text = "";
        txtETD.Text = "";
        txtETA.Text = "";
        txtOnboard.Text = "";
        txtCFS.Text = "";
        txtCY.Text = "";
        txtVoyage.Focus(true);
        ControlBinder.pageTitleMsg(false, "New Voyage", "<p>Status : New  Blank  Voyage . </p>", div_bottom);
    }

    /// <summary>
    /// 新增
    /// </summary>    
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        txtVoyageID.Text = "";
        ControlInit();
        txtVoyage.Focus();
        ControlBinder.pageTitleMsg(false, "New Voyage", "<p>Status : New  Blank  Voyage . </p>", div_bottom);
    }
    #endregion
}

/// <summary>
/// VoyageRoute 实体类
/// </summary>
#region   VoyageRoute 实体类    Author：Micro   （2011-09-23）
class VoyageRoute
{
    public string RowID
    { get; set; }
    public string POL
    { get; set; }
    public string POD
    { get; set; }
    public DateTime ETD
    { get; set; }
    public DateTime ETA
    { get; set; }
    public string Tovoyage
    { get; set; }
}
#endregion

