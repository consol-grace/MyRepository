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

public partial class OceanExport_Vessel : System.Web.UI.Page
{
    public string userDept; //当前用户所在部门
    public string stationSys; //当前用户所在系统（总站Y或者分站N）

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {   
            txtVessel.Focus(true);
            ControlBinder.CmbBinder(StoreCompany, "CompanyList", "o");
           
            userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
            stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();

            if (userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N")
            {
                DisabledControl();
            }
            else
            {
                UseControl();
            }
          
            //DataBinder();
        }

        ControlBinder.ChkGroupBind(this.tblChkGroup); //绑定CheckBoxGroup ( 2014-10-12 )

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.DataBinder();
        }
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }

    protected void StoreCompany_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCompany, "CompanyList", "o");
    }

    void DisabledControl()
    {
        txtVessel.Disabled = true;
        btnAddSave.Disabled = true;
        btnCancel.Disabled = true;
        btnSave.Disabled = true;
        btnNewVoyage.Disabled = true;
        CmbCarrier.Disabled = true;
    }

    void UseControl()
    {
        txtVessel.Disabled = false;
        btnAddSave.Disabled = false;
        btnCancel.Disabled = false;
        btnSave.Disabled = false;
        btnNewVoyage.Disabled = false;
        CmbCarrier.Disabled = false;
    }

    /// <summary>
    /// 清空Checkbox
    /// </summary>
    private void CheckGroupClear()
    {
        for (int ii = 0; ii < tblChkGroup.Items.Count(); ++ii)
            tblChkGroup.Items[ii].Checked = false;
    }

    /// <summary>
    /// Checkbox全选
    /// </summary>
    private void CheckGroupChecked()
    {
        for (int ii = 0; ii < tblChkGroup.Items.Count(); ++ii)
            tblChkGroup.Items[ii].Checked = true;
    }

    #region  DataBinder()   Author：Hcy  (2011-09-23)
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Vessel_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "List")
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("dept", userDept)
        }).GetList();

        gridList.GetStore().DataSource = ds;
        gridList.GetStore().DataBind();
    }
    #endregion

    #region   row_Click(object,DirectEventArgs)  Author：Hcy （2011-09-23）
    protected void row_Click(object sender, DirectEventArgs e)
    {

        string vs_RowID = e.ExtraParams["vs_RowID"];
        string RowID = e.ExtraParams["RowID"].ToString() == "" ? "0" : e.ExtraParams["RowID"];
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Vessel_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "GetList").Append("voy_ROWID", RowID)
        .Append("vs_RowID", vs_RowID)}).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            hidVesselID.Text = ds.Tables[0].Rows[0]["vs_ROWID"].ToString();
            txtVessel.Text = ds.Tables[0].Rows[0]["vs_Vessel"].ToString();
            CmbCarrier.setValue(ds.Tables[0].Rows[0]["voy_Carrier"].ToString());
            //CmbCarrierName.SelectedItem.Value = ds.Tables[0].Rows[0]["voy_Carrier"].ToString();
            chkActive.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["vs_Active"]);
            lblVoyage.Text = ds.Tables[0].Rows[0]["voy_Voyage"].ToString();
            lblPOL.Text = ds.Tables[0].Rows[0]["voy_POL"].ToString();
            lblPOD.Text = ds.Tables[0].Rows[0]["voy_POD"].ToString();
            lblOnboard.Text = ds.Tables[0].Rows[0]["voy_Onboard"].ToString() == "" ? "" : Convert.ToDateTime(ds.Tables[0].Rows[0]["voy_Onboard"].ToString()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            lblETD.Text = ds.Tables[0].Rows[0]["voy_ETD"].ToString() == "" ? "" : Convert.ToDateTime(ds.Tables[0].Rows[0]["voy_ETD"].ToString()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            lblETA.Text = ds.Tables[0].Rows[0]["voy_ETA"].ToString() == "" ? "" : Convert.ToDateTime(ds.Tables[0].Rows[0]["voy_ETA"].ToString()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            lblCFS.Text = ds.Tables[0].Rows[0]["voy_CFS"].ToString() == "" ? "" : Convert.ToDateTime(ds.Tables[0].Rows[0]["voy_CFS"].ToString()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            lblCY.Text = ds.Tables[0].Rows[0]["voy_CY"].ToString() == "" ? "" : Convert.ToDateTime(ds.Tables[0].Rows[0]["voy_CY"].ToString()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/");
            string[] statlist = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["StatList"].ToString()) ? new string[] { } : ds.Tables[0].Rows[0]["StatList"].ToString().Split(',');
            CheckGroupClear();

            foreach (string str in statlist)
            {
                for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
                {
                    if (tblChkGroup.Items[i].Tag.ToString().Trim().ToUpper() == str.Trim().ToUpper())
                    {
                        tblChkGroup.Items[i].Checked = true;
                        break;
                    }
                }
            }
        }
        txtVessel.Focus();
    }
    #endregion

    #region  btnAddSave_Click(object, EventArgs) Author：Hcy  (2011-09-23)
    protected void btnAddSave_Click(object sender, EventArgs e)
    {
        i = 1;
        btnSave_Click(sender, e);       


    }
    #endregion

    #region  btnSave_Click(object, EventArgs) Author：Hcy  (2011-09-23)
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strStat = "";

        for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
        {
            if (!tblChkGroup.Items[i].Checked)
                strStat += tblChkGroup.Items[i].Tag.Trim() + ",";
        }

        strStat = strStat.Length > 0 ? strStat.Substring(0, strStat.Length - 1) : strStat;

        if (string.IsNullOrEmpty(txtVessel.Text))
        {
            txtVessel.Focus();
            return;
        }

        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Vessel_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                 .Append("vs_Vessel",txtVessel.Text.Trim().ToUpper())
                 .Append("vs_Active",chkActive.Checked?"1":"0")
                 .Append("vs_Carrier", CmbCarrier.Value)
                 .Append("vs_ROWID",hidVesselID.Text)
                 .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])
                 .Append("statstr",strStat)
                 .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
        }).GetTable();

        if (dt.Rows.Count > 0)
        {
            hidVesselID.Text = dt.Rows[0][0].ToString();
            if (i == 1)
            {
                DataBinder();
                hidVesselID.Text = "";
                txtVessel.Text = "";
                CmbCarrier.setValue("");
                txtVessel.Focus();
                CheckGroupChecked();

                lblVoyage.Text = ""; //用于清空VOYAGE GRACE
                lblPOD.Text = "";
                lblPOL.Text = "";
                lblOnboard.Text = "";
                lblETA.Text = "";
                lblETD.Text = "";
                lblCFS.Text = "";
                lblCY.Text = "";
                return;
            }
            else if (i == 2)
            {

                X.AddScript("windowshow();");
                X.Redirect("../voyage/list.aspx?vessel=" + hidVesselID.Text + "&vstext=" + txtVessel.Text + "&carrier=" + CmbCarrier.Value + "&cartext=" + CmbCarrier.Text);
                return;
            }
            else
                X.Msg.Alert("status", " Saved successfully").Show();
        }
        else
            X.Msg.Alert("status", " Save failed ").Show();
        DataBinder();
        txtVessel.Focus();
    }
    #endregion

    #region  btnCancel_Click(object, EventArgs) Author：Hcy  (2011-09-23)
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //hidVesselID.Text = ""; //用于解决CANCEL之后为修改 GRACE
        txtVessel.Text = "";
        DataBinder();
        txtVessel.Focus();
        CheckGroupChecked();
    }
    #endregion

    #region  btnNewVoyage_Click(object, EventArgs) Author：Hcy  (2011-09-23)
    int i = 0;
    protected void btnNewVoyage_Click(object sender, EventArgs e)
    {
        i = 2;
        btnSave_Click(sender, e);
    }
    #endregion

}
