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

public partial class AirExport_AEHAWB_ManifestDetail : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    public static string sys = "AE";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            ComboBoxBinding();
            DataBindList();
            txtHAWB.Focus();
        }
    }


    #region   ComboBoxBinding()    Author ：Hcy   (2011-12-07)
    private void ComboBoxBinding()
    {
        DataSet dsLocation = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "LocationList").
        Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
        Append("SYS",sys[0])
        }).GetList();

        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();

    }
    #endregion

    #region   DataBindList()    Author ：Hcy   (2011-12-07)
    private void DataBindList()
    {
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "List")
            .Append("wbm_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            );
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_Manifest_SP", Getlist).GetList();
        if (ds != null && ds.Tables[0].Rows[0][0].ToString() == "Y")
        {
            if (ds != null && ds.Tables[1].Rows.Count > 0)
            {
                txtHAWB.Text = ds.Tables[1].Rows[0]["wbm_HAWB"].ToString();
                txtPKG.Text = ds.Tables[1].Rows[0]["wbm_RCP"].ToString();
                txtWT.Text = ds.Tables[1].Rows[0]["wbm_WT"].ToString();
                txtPreWT.Text = ds.Tables[1].Rows[0]["wbm_PreAlertWT"].ToString();
                txtInfo.Text = ds.Tables[1].Rows[0]["wbm_WTLine"].ToString();
                CmbDest.SelectedItem.Value = ds.Tables[1].Rows[0]["wbm_Final"].ToString();

                CmbShipperCode.setValue(ds.Tables[1].Rows[0]["wbm_ShipperCode"].ToString());
                lblShipper1.Text = ds.Tables[1].Rows[0]["wbm_Shipper1"].ToString();
                lblShipper2.Text = ds.Tables[1].Rows[0]["wbm_Shipper2"].ToString();
                lblShipper3.Text = ds.Tables[1].Rows[0]["wbm_Shipper3"].ToString();
                lblShipper4.Text = ds.Tables[1].Rows[0]["wbm_Shipper4"].ToString();
                lblShipper5.Text = ds.Tables[1].Rows[0]["wbm_Shipper5"].ToString();
                lblShipper6.Text = ds.Tables[1].Rows[0]["wbm_Shipper6"].ToString();

                CmbConsignee.setValue(ds.Tables[1].Rows[0]["wbm_ConsigneeCode"].ToString());
                lblConsignee1.Text = ds.Tables[1].Rows[0]["wbm_Consignee1"].ToString();
                lblConsignee2.Text = ds.Tables[1].Rows[0]["wbm_Consignee2"].ToString();
                lblConsignee3.Text = ds.Tables[1].Rows[0]["wbm_Consignee3"].ToString();
                lblConsignee4.Text = ds.Tables[1].Rows[0]["wbm_Consignee4"].ToString();
                lblConsignee5.Text = ds.Tables[1].Rows[0]["wbm_Consignee5"].ToString();
                lblConsignee6.Text = ds.Tables[1].Rows[0]["wbm_Consignee6"].ToString();

                lblNature1.Text = ds.Tables[1].Rows[0]["wbm_Nature1"].ToString();
                lblNature2.Text = ds.Tables[1].Rows[0]["wbm_Nature2"].ToString();
                lblNature3.Text = ds.Tables[1].Rows[0]["wbm_Nature3"].ToString();
                lblNature4.Text = ds.Tables[1].Rows[0]["wbm_Nature4"].ToString();
                lblNature5.Text = ds.Tables[1].Rows[0]["wbm_Nature5"].ToString();
                lblNature6.Text = ds.Tables[1].Rows[0]["wbm_Nature6"].ToString();
            }

            if (ds != null && ds.Tables[2].Rows.Count > 0)
            {
                gpHawb.GetStore().DataSource = ds.Tables[2];
                gpHawb.GetStore().DataBind();
                RowSelectionModel sm = gpHawb.GetSelectionModel() as RowSelectionModel;
                sm.SelectRow(0);
                sm.SelectedRows.Add(new SelectedRow(0));

            }
        }
        else
        {
            if (ds.Tables[1].Rows.Count > 0)
            {
                txtHAWB.Text = ds.Tables[1].Rows[0]["wbm_HAWB"].ToString();
                txtPKG.Text = ds.Tables[1].Rows[0]["wbm_RCP"].ToString();
                txtWT.Text = ds.Tables[1].Rows[0]["wbm_WT"].ToString();
                CmbDest.SelectedItem.Value = ds.Tables[1].Rows[0]["wbm_Final"].ToString();
            }
        }
    }
    #endregion



    #region    btnSave_Click()     Author：Hcy   (2011-12-07)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        if (!SaveHawb())
            return;

        var Hawb = JSON.Deserialize<List<HawbClass>>(e.ExtraParams["HawbValue"]);
        List<IFields> HawbList = new List<IFields>();
        string RowID = "";
        for (int i = 0; i < Hawb.Count; ++i)
        {
            HawbList.Add(dal.CreateIFields().Append("Option", "UpdateUnder")
            .Append("wbm_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("wbm_ROWID", Hawb[i].wbm_ROWID)

            .Append("wbm_HAWB", Hawb[i].wbm_HAWB.ToUpper())
            .Append("wbm_RCP", Hawb[i].wbm_RCP.ToUpper())
            .Append("wbm_WT", Hawb[i].wbm_WT.ToUpper())
            .Append("wbm_Final", Hawb[i].wbm_Final.ToUpper())
            .Append("wbm_WTLine", Hawb[i].wbm_WTLine.ToUpper())

            .Append("wbm_ShipperCode", Hawb[i].wbm_ShipperCode.ToUpper())
            .Append("wbm_Shipper1", Hawb[i].wbm_Shipper1.ToUpper())
            .Append("wbm_Shipper2", Hawb[i].wbm_Shipper2.ToUpper())
            .Append("wbm_Shipper3", Hawb[i].wbm_Shipper3.ToUpper())
            .Append("wbm_Shipper4", Hawb[i].wbm_Shipper4.ToUpper())
            .Append("wbm_Shipper5", Hawb[i].wbm_Shipper5.ToUpper())
            .Append("wbm_Shipper6", Hawb[i].wbm_Shipper6.ToUpper())

            .Append("wbm_ConsigneeCode", Hawb[i].wbm_ConsigneeCode.ToUpper())
            .Append("wbm_Consignee1", Hawb[i].wbm_Consignee1.ToUpper())
            .Append("wbm_Consignee2", Hawb[i].wbm_Consignee2.ToUpper())
            .Append("wbm_Consignee3", Hawb[i].wbm_Consignee3.ToUpper())
            .Append("wbm_Consignee4", Hawb[i].wbm_Consignee4.ToUpper())
            .Append("wbm_Consignee5", Hawb[i].wbm_Consignee5.ToUpper())
            .Append("wbm_Consignee6", Hawb[i].wbm_Consignee6.ToUpper())

            .Append("wbm_Nature1", Hawb[i].wbm_Nature1.ToUpper())
            .Append("wbm_Nature2", Hawb[i].wbm_Nature2.ToUpper())
            .Append("wbm_Nature3", Hawb[i].wbm_Nature3.ToUpper())
            .Append("wbm_Nature4", Hawb[i].wbm_Nature4.ToUpper())
            .Append("wbm_Nature5", Hawb[i].wbm_Nature5.ToUpper())
            .Append("wbm_Nature6", Hawb[i].wbm_Nature6.ToUpper())

            .Append("wbm_User", FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper())
            .Append("wbm_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString().ToUpper())
            .Append("wbm_Sys", sys)
            );
            RowID += "," + Hawb[i].wbm_ROWID;
        }
        //delete
        if (RowID.Length > 1)
        {
            RowID = RowID.Substring(1, RowID.Length - 1);
        }
        dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_Manifest_SP", new List<IFields> { dal.CreateIFields().Append("Option", "delete").Append("wbm_Seed", hidSeed.Text).Append("str", RowID) }).Update();
        bool resultHawb = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_Manifest_SP", HawbList).Update();

        X.AddScript("window.parent.ShipperColor('" + shipper + "');window.parent.ConsigneeColor('" + consignee + "');window.parent.DimensionsColor('" + dimensions + "'); window.parent.winShow.close();");
    }
    #endregion

    public string shipper = "Y";
    public string consignee = "Y";
    public string dimensions = "Y";

    private bool SaveHawb()
    {

        List<IFields> UpdateHAWB = new List<IFields>();
        UpdateHAWB.Add(dal.CreateIFields().Append("Option", "Update")
            .Append("wbm_Seed", hidSeed.Text == "" ? null : hidSeed.Text)

            .Append("wbm_HAWB", txtHAWB.Text.Trim())
            .Append("wbm_RCP", string.IsNullOrEmpty(txtPKG.Text.Trim()) ? DBNull.Value : (object)txtPKG.Text.Trim())
            .Append("wbm_WT", string.IsNullOrEmpty(txtWT.Text.Trim()) ? DBNull.Value : (object)txtWT.Text.Trim())
            .Append("wbm_PreAlertWT", string.IsNullOrEmpty(txtPreWT.Text.Trim()) ? DBNull.Value : (object)txtPreWT.Text.Trim())
             .Append("wbm_Final", CmbDest.SelectedItem.Value)
            .Append("wbm_WTLine", txtInfo.Text.Trim().ToUpper())

            .Append("wbm_ShipperCode", CmbShipperCode.Value.ToUpper())
            .Append("wbm_Shipper1", lblShipper1.Text.ToUpper())
            .Append("wbm_Shipper2", lblShipper2.Text.ToUpper())
            .Append("wbm_Shipper3", lblShipper3.Text.ToUpper())
            .Append("wbm_Shipper4", lblShipper4.Text.ToUpper())
            .Append("wbm_Shipper5", lblShipper5.Text.ToUpper())
            .Append("wbm_Shipper6", lblShipper6.Text.ToUpper())

            .Append("wbm_ConsigneeCode", CmbConsignee.Value.ToUpper())
            .Append("wbm_Consignee1", lblConsignee1.Text.ToUpper())
            .Append("wbm_Consignee2", lblConsignee2.Text.ToUpper())
            .Append("wbm_Consignee3", lblConsignee3.Text.ToUpper())
            .Append("wbm_Consignee4", lblConsignee4.Text.ToUpper())
            .Append("wbm_Consignee5", lblConsignee5.Text.ToUpper())
            .Append("wbm_Consignee6", lblConsignee6.Text.ToUpper())

            .Append("wbm_Nature1", lblNature1.Text.ToUpper())
            .Append("wbm_Nature2", lblNature2.Text.ToUpper())
            .Append("wbm_Nature3", lblNature3.Text.ToUpper())
            .Append("wbm_Nature4", lblNature4.Text.ToUpper())
            .Append("wbm_Nature5", lblNature5.Text.ToUpper())
            .Append("wbm_Nature6", lblNature6.Text.ToUpper())

            .Append("wbm_User", FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper())
            .Append("wbm_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString().ToUpper())
            .Append("wbm_Sys", sys)
            );
        try
        {
            if (CmbConsignee.Value == "" && lblConsignee1.Text == "")
                consignee = "N";
            if (CmbShipperCode.Value == "" && lblShipper1.Text == "")
                shipper = "N";
            if (lblNature1.Text == "" && lblNature2.Text == "" && lblNature3.Text == "" && lblNature4.Text == "" && lblNature5.Text == "" && lblNature6.Text == "")
                dimensions = "N";

            bool resultHawb = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_Manifest_SP", UpdateHAWB).Update();

            return true;
        }
        catch (Exception exp)
        {
            X.Msg.Alert("Title", exp.Message).Show();
            return false;
        }
    }



    #region HawbClass
    class HawbClass
    {
        public int wbm_ROWID
        { get; set; }
        public int wbm_Seed
        { get; set; }
        public string wbm_RCP
        { get; set; }
        public string wbm_ShipperCode
        { get; set; }
        public string wbm_Shipper1
        { get; set; }
        public string wbm_Shipper2
        { get; set; }
        public string wbm_Shipper3
        { get; set; }
        public string wbm_Shipper4
        { get; set; }
        public string wbm_Shipper5
        { get; set; }
        public string wbm_Shipper6
        { get; set; }
        public string wbm_ConsigneeCode
        { get; set; }
        public string wbm_Consignee1
        { get; set; }
        public string wbm_Consignee2
        { get; set; }
        public string wbm_Consignee3
        { get; set; }
        public string wbm_Consignee4
        { get; set; }
        public string wbm_Consignee5
        { get; set; }
        public string wbm_Consignee6
        { get; set; }
        public string wbm_Nature1
        { get; set; }
        public string wbm_Nature2
        { get; set; }
        public string wbm_Nature3
        { get; set; }
        public string wbm_Nature4
        { get; set; }
        public string wbm_Nature5
        { get; set; }
        public string wbm_Nature6
        { get; set; }
        public string wbm_HAWB
        { get; set; }
        public string wbm_Final
        { get; set; }
        public string wbm_WT
        { get; set; }
        public string wbm_WTLine
        { get; set; }
    }
    #endregion

    //#region    RowSelect_Click()     Author：Hcy   (2011-12-08)
    //protected void RowSelect_Click(object sender, DirectEventArgs e)
    //{
    //    SaveHawbUnder();
    //    string rowid = e.ExtraParams["RowID"];
    //    DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_Manifest_SP", new List<IFields> { dal.CreateIFields().Append("Option", "GetHawbByID").Append("wbm_ROWID", rowid) }).GetList();
    //    if (ds != null && ds.Tables[0].Rows.Count > 0)
    //    {
    //        hidID.Text = ds.Tables[0].Rows[0]["wbm_ROWID"].ToString();
    //        txtHAWB01.Text = ds.Tables[0].Rows[0]["wbm_HAWB"].ToString();
    //        txtPKG01.Text = ds.Tables[0].Rows[0]["wbm_RCP"].ToString();
    //        txtWT01.Text = ds.Tables[0].Rows[0]["wbm_WT"].ToString();
    //        txtInfo01.Text = ds.Tables[0].Rows[0]["wbm_WTLine"].ToString();
    //        CmbDest01.SelectedItem.Value = ds.Tables[0].Rows[0]["wbm_Final"].ToString();

    //        CmbShipper01.setValue( ds.Tables[0].Rows[0]["wbm_ShipperCode"].ToString());
    //        txtShipper1.Text = ds.Tables[0].Rows[0]["wbm_Shipper1"].ToString();
    //        txtShipper2.Text = ds.Tables[0].Rows[0]["wbm_Shipper2"].ToString();
    //        txtShipper3.Text = ds.Tables[0].Rows[0]["wbm_Shipper3"].ToString();
    //        txtShipper4.Text = ds.Tables[0].Rows[0]["wbm_Shipper4"].ToString();
    //        txtShipper5.Text = ds.Tables[0].Rows[0]["wbm_Shipper5"].ToString();
    //        txtShipper6.Text = ds.Tables[0].Rows[0]["wbm_Shipper6"].ToString();

    //        CmbConsignee01.setValue( ds.Tables[0].Rows[0]["wbm_ConsigneeCode"].ToString());
    //        txtConsignee1.Text = ds.Tables[0].Rows[0]["wbm_Consignee1"].ToString();
    //        txtConsignee2.Text = ds.Tables[0].Rows[0]["wbm_Consignee2"].ToString();
    //        txtConsignee3.Text = ds.Tables[0].Rows[0]["wbm_Consignee3"].ToString();
    //        txtConsignee4.Text = ds.Tables[0].Rows[0]["wbm_Consignee4"].ToString();
    //        txtConsignee5.Text = ds.Tables[0].Rows[0]["wbm_Consignee5"].ToString();
    //        txtConsignee6.Text = ds.Tables[0].Rows[0]["wbm_Consignee6"].ToString();

    //        txtNature1.Text = ds.Tables[0].Rows[0]["wbm_Nature1"].ToString();
    //        txtNature2.Text = ds.Tables[0].Rows[0]["wbm_Nature2"].ToString();
    //        txtNature3.Text = ds.Tables[0].Rows[0]["wbm_Nature3"].ToString();
    //        txtNature4.Text = ds.Tables[0].Rows[0]["wbm_Nature4"].ToString();
    //        txtNature5.Text = ds.Tables[0].Rows[0]["wbm_Nature5"].ToString();
    //        txtNature6.Text = ds.Tables[0].Rows[0]["wbm_Nature6"].ToString();

    //    }
    //}
    //#endregion

    [DirectMethod]
    public void SetInfo(string typename, string code)
    {
        DataSet dsCom = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWB_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "GetCompanyInfoByCode").
        Append("CODE", code).
        Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        if (dsCom != null && dsCom.Tables[0].Rows.Count > 0)
        {
            if (typename == "CmbShipperCode")
            {
                lblShipper1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                lblShipper2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                lblShipper3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                lblShipper4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                lblShipper5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                lblShipper6.Text = dsCom.Tables[0].Rows[0]["co_Contact"].ToString();
            }
            else if (typename == "CmbConsignee")
            {
                lblConsignee1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                lblConsignee2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                lblConsignee3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                lblConsignee4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                lblConsignee5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                lblConsignee6.Text = dsCom.Tables[0].Rows[0]["co_Contact"].ToString();
            }
            else if (typename == "CmbShipper01")
            {
                txtShipper1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtShipper2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtShipper3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                txtShipper4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                txtShipper5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                txtShipper6.Text = dsCom.Tables[0].Rows[0]["co_Contact"].ToString();
            }
            else if (typename == "CmbConsignee01")
            {
                txtConsignee1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtConsignee2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtConsignee3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                txtConsignee4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                txtConsignee5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                txtConsignee6.Text = dsCom.Tables[0].Rows[0]["co_Contact"].ToString();
            }
        }
        else
        {
            if (typename == "CmbShipperCode")
            {
                lblShipper1.Text = "";
                lblShipper2.Text = "";
                lblShipper3.Text = "";
                lblShipper4.Text = "";
                lblShipper5.Text = "";
                lblShipper6.Text = "";
            }
            else if (typename == "CmbConsignee")
            {
                lblConsignee1.Text = "";
                lblConsignee2.Text = "";
                lblConsignee3.Text = "";
                lblConsignee4.Text = "";
                lblConsignee5.Text = "";
                lblConsignee6.Text = "";
            }
            else if (typename == "CmbShipper01")
            {
                txtShipper1.Text = "";
                txtShipper2.Text = "";
                txtShipper3.Text = "";
                txtShipper4.Text = "";
                txtShipper5.Text = "";
                txtShipper6.Text = "";
            }
            else if (typename == "CmbConsignee01")
            {
                txtConsignee1.Text = "";
                txtConsignee2.Text = "";
                txtConsignee3.Text = "";
                txtConsignee4.Text = "";
                txtConsignee5.Text = "";
                txtConsignee6.Text = "";
            }
        }
    }

    [DirectMethod]
    public void GetHAWBInfo(string name)
    {
        DataSet dsCom = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_Manifest_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "GetHawbInfo").
        Append("wbm_Seed", hidSeed.Text)}).GetList();
        if (dsCom != null && dsCom.Tables[0].Rows.Count > 0)
        {
            if (name == "Shipper")
            {
                CmbShipperCode.setValue(dsCom.Tables[0].Rows[0]["wbi_ShipperCode"].ToString());
                lblShipper1.Text = dsCom.Tables[0].Rows[0]["wbi_Shipper1"].ToString();
                lblShipper2.Text = dsCom.Tables[0].Rows[0]["wbi_Shipper2"].ToString();
                lblShipper3.Text = dsCom.Tables[0].Rows[0]["wbi_Shipper3"].ToString();
                lblShipper4.Text = dsCom.Tables[0].Rows[0]["wbi_Shipper4"].ToString();
                lblShipper5.Text = dsCom.Tables[0].Rows[0]["wbi_Shipper5"].ToString();
                lblShipper6.Text = dsCom.Tables[0].Rows[0]["wbi_Shipper6"].ToString();

            }
            else if (name == "Consignee")
            {
                CmbConsignee.setValue(dsCom.Tables[0].Rows[0]["wbi_ConsigneeCode"].ToString());
                lblConsignee1.Text = dsCom.Tables[0].Rows[0]["wbi_Consignee1"].ToString();
                lblConsignee2.Text = dsCom.Tables[0].Rows[0]["wbi_Consignee2"].ToString();
                lblConsignee3.Text = dsCom.Tables[0].Rows[0]["wbi_Consignee3"].ToString();
                lblConsignee4.Text = dsCom.Tables[0].Rows[0]["wbi_Consignee4"].ToString();
                lblConsignee5.Text = dsCom.Tables[0].Rows[0]["wbi_Consignee5"].ToString();
                lblConsignee6.Text = dsCom.Tables[0].Rows[0]["wbi_Consignee6"].ToString();
            }
            else
            {
                int count = dsCom.Tables[1].Rows.Count;
                if (count > 0)
                {
                    lblNature1.Text = dsCom.Tables[1].Rows[0][0].ToString();
                }
                if (count > 1)
                {
                    lblNature2.Text = dsCom.Tables[1].Rows[1][0].ToString();
                }
                if (count > 2)
                {
                    lblNature3.Text = dsCom.Tables[1].Rows[2][0].ToString();
                }
                if (count > 3)
                {
                    lblNature4.Text = dsCom.Tables[1].Rows[3][0].ToString();
                }
                if (count > 4)
                {
                    lblNature5.Text = dsCom.Tables[1].Rows[4][0].ToString();
                }
                if (count > 5)
                {
                    lblNature6.Text = dsCom.Tables[1].Rows[5][0].ToString();
                }

            }

        }
    }
}
