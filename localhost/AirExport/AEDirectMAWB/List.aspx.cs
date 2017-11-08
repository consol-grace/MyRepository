using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class AirExport_AEMakeConsol_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    public static string sys = "AE";
    public static string typename = "";
    public static string showname = "AE-Direct MAWB";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            hidIDList.Text = Server.UrlDecode(Request["IDList"] == null ? "" : Request["IDList"]);
            typename = Request["type"] == null ? "" : Request["type"].ToLower();
            showname = "AE-Direct MAWB";
            ControlBinder.DateFormat(l_etd);
            ControlBinder.DateFormat(l_eta);
            ControlBinder.DateFormat(l_atd);
            ControlBinder.DateFormat(l_ata);
            txtMAWB.Focus(true);
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                ComboBoxBinding();
                DataBindList();
                LockControl();
            }
        }
    }

    #region LockControl()
    protected void LockControl()
    {
        if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT")
        {
            btnSave.Disabled = true;
            btnCancel.Disabled = true;
            btnRevert.Disabled = true;
            btnVoid.Disabled = true;
            X.AddScript("$('#showGenerate').hide();");
            btnUpdateLotNo.Hide();
        }
    }
    #endregion

    #region //Store数据刷新

    protected void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsSalesman = GetComboxDs("SalesList");
        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();
    }

    protected void StoreGetItem_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();
        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();
    }
    protected void StoreCurrInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsCurrencysList = GetComboxDs("CurrencysInvoice");
        StoreCurrInvoice.DataSource = dsCurrencysList;
        StoreCurrInvoice.DataBind();
    }

    protected void StoreCurrInvoiceForeign_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsCurrencysList = GetComboxDs("CurrencysInvoiceForeign");
        StoreCurrInvoiceForeign.DataSource = dsCurrencysList;
        StoreCurrInvoiceForeign.DataBind();
    }

    protected void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsLocation = GetComboxDs("LocationList");
        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();
    }

    protected void StoreUnit_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsUnit = GetComboxDs("UnitBinding");
        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();
    }

    protected void StoreCurrForeign_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsCur = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_CoLoaderIn_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetCurrency").Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12]) }).GetList();

        StoreCurrForeign.DataSource = dsCur.Tables[0];
        StoreCurrForeign.DataBind();

        StoreCurrLocal.DataSource = dsCur.Tables[1];
        StoreCurrLocal.DataBind();
    }

    protected void StoreCurrLocal_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsCur = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_CoLoaderIn_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetCurrency").Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12]) }).GetList();

        StoreCurrForeign.DataSource = dsCur.Tables[0];
        StoreCurrForeign.DataBind();

        StoreCurrLocal.DataSource = dsCur.Tables[1];
        StoreCurrLocal.DataBind();
    }

    #endregion


    #region GetDs(string CmdText, List<IFields> fields)   Author ：hcy   (2011-11-28)
    DataSet GetDs(string CmdText, List<IFields> fields)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, CmdText, fields).GetList();
        }
        catch
        {
            ds = null;
        }
        return ds;
    }
    #endregion

    #region   GetComboxDs()    Author ：Hcy   (2011-11-28)

    private DataSet GetComboxDs(string Type)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", Type).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS",sys[0])}).GetList();
        }
        catch
        {
            ds = null;
        }
        return ds;
    }
    #endregion

    #region   ComboBoxBinding()    Author ：Hcy   (2011-11-28)
    private void ComboBoxBinding()
    {
        DataSet dsSalesman = GetComboxDs("SalesList");
        DataSet dsLocation = GetComboxDs("LocationList");
        DataSet dsUnit = GetComboxDs("UnitBinding");
        DataSet dsItem = GetComboxDs("ItemBinding");
        DataSet dsKind = GetComboxDs("QtyKindBinding");
        DataSet dsCurrencysList = GetComboxDs("CurrencysInvoice");
        DataSet dsCurrencysListForeign = GetComboxDs("CurrencysInvoiceForeign");
        DataSet dsShowIn = GetComboxDs("GetShowIn");
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();
        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();



        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();

        StoreCurrInvoice.DataSource = dsCurrencysList;
        StoreCurrInvoice.DataBind();

        StoreCurrInvoiceForeign.DataSource = dsCurrencysListForeign;
        StoreCurrInvoiceForeign.DataBind();

        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();

        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();

        StoreKind.DataSource = dsKind;
        StoreKind.DataBind();

        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", "A");

        DataSet dsCur = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_CoLoaderIn_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetCurrency").Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12]) }).GetList();

        StoreCurrForeign.DataSource = dsCur.Tables[0];
        StoreCurrForeign.DataBind();

        StoreCurrLocal.DataSource = dsCur.Tables[1];
        StoreCurrLocal.DataBind();

        StoreShowIn.DataSource = dsShowIn;
        StoreShowIn.DataBind();
    }
    #endregion

    #region   DataBindList()    Author ：Hcy   (2011-11-28)
    private void DataBindList()
    {

        
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetAEDirectMAWB")
            .Append("air_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("str", hidIDList.Text)
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("air_SYS", sys)
            );
        DataSet ds = GetDs("FW_AirExport_DirectMAWB_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0 && hidSeed.Text != null && hidSeed.Text != "")
        {
            

            labLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();
            if (labLotNo.Text != "")
            {
                labLot.Text = "Lot# ";
            }
            hidLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();

            txtMAWB.Text = ds.Tables[0].Rows[0]["MAWB"].ToString();

            CmbSalesman.setValue(ds.Tables[0].Rows[0]["air_Sales"].ToString());

            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Shipper"].ToString());
            CmbShipperCode.Text = ds.Tables[0].Rows[0]["ShipperName"].ToString();
            CmbConsignee.setValue(ds.Tables[0].Rows[0]["Consignee"].ToString());
            CmbConsignee.Text = ds.Tables[0].Rows[0]["ConsigneeName"].ToString();

            CmbCarrierRight.setValue(ds.Tables[0].Rows[0]["Carrier"].ToString());
            txtFlightRight.Text = ds.Tables[0].Rows[0]["FlightNo"].ToString();
            CmbFromRight.setValue(ds.Tables[0].Rows[0]["From"].ToString());
            CmbToRight.setValue(ds.Tables[0].Rows[0]["To"].ToString());
            txtETD.Text = ds.Tables[0].Rows[0]["ETD"].ToString();
            txtETA.Text = ds.Tables[0].Rows[0]["ETA"].ToString();
            txtATD.Text = ds.Tables[0].Rows[0]["ATD"].ToString();
            txtATA.Text = ds.Tables[0].Rows[0]["ATA"].ToString();

            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
                txtGWT.Text = ds.Tables[0].Rows[0]["GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["VWT"].ToString()))
                txtVWT.Text = ds.Tables[0].Rows[0]["VWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CWT"].ToString()))
                txtCWT.Text = ds.Tables[0].Rows[0]["CWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Piece"].ToString()))
                txtPiece.Text = ds.Tables[0].Rows[0]["Piece"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Pallet"].ToString()))
                txtPallet.Text = ds.Tables[0].Rows[0]["Pallet"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Rate"].ToString()))
                txtRate.Text = ds.Tables[0].Rows[0]["Rate"].ToString();

            txtRemark.Text = ds.Tables[0].Rows[0]["air_Remark"].ToString();
            txtAccount.Text = ds.Tables[0].Rows[0]["air_AccountRemark"].ToString();
            txtOperation.Text = ds.Tables[0].Rows[0]["air_OperationRemark"].ToString();

            bool ismakeMawb = ds.Tables[0].Rows[0]["air_MakeMAWB"].ToString() == "" ? false : Convert.ToBoolean(ds.Tables[0].Rows[0]["air_MakeMAWB"]);

            string flag = "N";
            if (ismakeMawb) flag = "Y";
            X.AddScript("isMawbFlag='" + flag + "';");

           
            if (ds.Tables[1].Rows.Count > 0)
            {
                GridFlightList.GetStore().DataSource = ds.Tables[1];
                GridFlightList.GetStore().DataBind();
            }

            if (ds.Tables[2].Rows.Count > 0)
            {
                gpInvoice.GetStore().DataSource = ds.Tables[2];
                gpInvoice.GetStore().DataBind();
            }

           

            if (ds.Tables[4].Rows.Count > 0)
            {
                lblCurForeign.Text = ds.Tables[4].Rows[0]["Currency"].ToString();
                CmbForeign.SelectedItem.Value = ds.Tables[4].Rows[0]["Currency"].ToString();
                gpForeign.GetStore().DataSource = ds.Tables[4];
                gpForeign.GetStore().DataBind();
            }

            if (ds.Tables[5].Rows.Count > 0)
            {
                hidForeignID.Text = ds.Tables[5].Rows[0]["RowID"].ToString();
                CmbCompany.setValue(ds.Tables[5].Rows[0]["CompanyCode"].ToString());
                CmbCompany.Text = ds.Tables[5].Rows[0]["CompanyName"].ToString();
                txtFor.Text = ds.Tables[5].Rows[0]["Min"].ToString();
            }
            if (ds.Tables[6].Rows.Count > 0)
            {
                lblCurLocal.Text = ds.Tables[6].Rows[0]["Currency"].ToString();
                CmbLocal.SelectedItem.Value = ds.Tables[6].Rows[0]["Currency"].ToString();
                gpLocal.GetStore().DataSource = ds.Tables[6];
                gpLocal.GetStore().DataBind();
            }
            if (ds.Tables[7].Rows.Count > 0)
            {
                hidLocalID.Text = ds.Tables[7].Rows[0]["RowID"].ToString();
                CmbCompany1.setValue(ds.Tables[7].Rows[0]["CompanyCode"].ToString());
                CmbCompany1.Text = ds.Tables[7].Rows[0]["CompanyName"].ToString();
                txtLoc.Text = ds.Tables[7].Rows[0]["Min"].ToString();
            }
            if (ds.Tables[8].Rows.Count > 0)
            {
                gpWTForeign.GetStore().DataSource = ds.Tables[8];
                gpWTForeign.GetStore().DataBind();
            }
            if (ds.Tables[9].Rows.Count > 0)
            {
                gpWTLocal.GetStore().DataSource = ds.Tables[9];
                gpWTLocal.GetStore().DataBind();
            }

            if (ds.Tables.Count > 10)
            {
                l_from.setValue( ds.Tables[10].Rows[0]["From"].ToString());
                l_to.setValue( ds.Tables[10].Rows[0]["To"].ToString());
                l_etd.Text = ds.Tables[10].Rows[0]["ETD"].ToString();
                l_eta.Text = ds.Tables[10].Rows[0]["ETA"].ToString();
            }

            if (hidLotNo.Text != "")
            {
                if (ControlBinder.IsDisplayLotNo(txtETD.Text.Trim(), hidLotNo.Text)) 
                {
                    btnUpdateLotNo.Show();
                }
                else
                {
                    btnUpdateLotNo.Hide();
                }
            }

            if (ds.Tables[0].Rows[0]["Active"].ToString() == "Y")
            {
                img_void.Style.Value = "display:none";
                if (labLotNo.Text != "")
                {
                    X.AddScript("$('#showGenerate').show();");
                }
            }
            else
            {
                img_void.Style.Value = "display:inline";
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnRevert.Disabled = true;
                X.AddScript("$('#showGenerate').hide();");
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                btnUpdateLotNo.Hide();
            }
            ControlBinder.pageTitleMsg(false, showname + ":" + hidLotNo.Text, "<p>Status :  Edit  No. of  <span>" + hidLotNo.Text + "</span></p>", div_bottom);
        }
        else
        {
           
            ControlBinder.pageTitleMsg(false, showname, "<p>Status :  New Blank  No. </p>", div_bottom);
        }
        

    }
    #endregion

    [DirectMethod]
    public void btnUpdateLotNo_Click()
    {
        object etd = ControlBinder.getDate(string.IsNullOrEmpty(txtETD.RawText.Trim()) ? DBNull.Value : (object)txtETD.RawText.Trim());

        string lotNo = ControlBinder.GetNewLotNo("AE", hidSeed.Text, etd);

        if (lotNo == "-1")
        {
            X.MessageBox.Alert("Status", "The cost of this LOT is transfered to AC, LOT NUMBER updating is aborted!").Show();
            ControlBinder.pageTitleMsg(true, "AE-M:" + hidLotNo.Text, "<p class=\"success\">Status : Saved failed ! ! ! </p>", div_bottom);

        }
        else if (lotNo != "0")
        {
            labLotNo.Text = lotNo;
            hidLotNo.Text = lotNo;

            ControlBinder.pageTitleMsg(true, "AE-M:" + hidLotNo.Text, "<p class=\"success\">Status : Saved successfully ! ! ! </p>", div_bottom);
            btnUpdateLotNo.Hide();
        }
    }


    #region    btnCancel_Click()     Author：Hcy   (2011-11-28)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        DataBindList();
        X.AddScript("BindingCost();");
    }
    #endregion

    #region    btnVoid_Click()     Author：Hcy   (2011-11-28)
    protected void btnVoid_Click(object sender, DirectEventArgs e)
    {
        if (hidVoid.Text == "0")
        {
            X.Msg.Confirm("Information", "Are you sure you want to be void?", "if (buttonId == 'yes') { CompanyX.btnVoid_Click(); }").Show();
        }
        else
        {
            X.Msg.Confirm("Information", "Are you sure you want to be active?", "if (buttonId == 'yes') { CompanyX.btnVoid_Click(); }").Show();
        }
    }
    #endregion

    [DirectMethod]
    public void btnVoid_Click()
    {
        string seedid = hidSeed.Text;

        if (!VoidCheckAC.CheckisAC("AE", hidSeed.Text))
        {
            X.MessageBox.Alert("Status", VoidCheckAC.Message).Show();
            return;
        }


        if (seedid.Length>1)
        {
            string voidflag = hidVoid.Text == "0" ? "Y1" : "N1";
            DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "A").Append("Type", "MAWB").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text==""?null:hidSeed.Text)}).GetList();
            if (l != null && l.Tables[0].Rows[0][0].ToString() == "Y")
            {
                X.AddScript("$('#img_void').css('display','inline');");
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnRevert.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                X.AddScript("$('#showGenerate').hide();");
                btnUpdateLotNo.Hide();
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "N")
            {
                X.AddScript("$('#img_void').css('display','none');");
                btnSave.Disabled = false;
                btnCancel.Disabled = false;
                btnRevert.Disabled = false;
                X.AddScript("$('#showGenerate').show();");
                btnVoid.Text = "Void";
                hidVoid.Text = "0";
            }
            else
            {
                ControlBinder.pageTitleMsg(false, showname + hidLotNo.Text, "<p class=\"error\">Status :  Void failed, please check the data . </p>", div_bottom);
            }
            DataBindList();
            ControlBinder.pageTitleMsg(true, showname + ":" + hidLotNo.Text, "<p>Status :  Edit  No. of  <span>" + hidLotNo.Text + "</span></p>", div_bottom);
        }
    }

    #region    btnRevert_Click()     Author：Hcy   
    protected void btnRevert_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Confirm("Information", "Are you sure you want to revert direct MAWB?", "if (buttonId == 'yes') { CompanyX.btnRevert_Click(); }").Show();
    }
    #endregion

    [DirectMethod]
    public void btnRevert_Click()
    {
        string lotno = hidLotNo.Text;
        if (lotno != "")
        {
           DataSet  result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_DirectMAWB_SP", new List<IFields>() 
        { dal.CreateIFields().Append("Option", "Revert").Append("air_Seed", hidSeed.Text)
        .Append("User",FSecurityHelper.CurrentUserDataGET()[0].ToString()) }).GetList();
            if (result!=null&&result.Tables[0].Rows.Count>0)
            {

                string type = "";
                if (result.Tables[0].Rows[0][0].ToString() == "s")
                {
                    Response.Redirect("../AEShipAndColIn/List.aspx?type=s&seed="+result.Tables[0].Rows[0][1]);
                }
                else
                {
                    Response.Redirect("../AEShipAndColIn/List.aspx?type=c&seed=" + result.Tables[0].Rows[0][1]);
                }
            }
            else
            {
                ControlBinder.pageTitleMsg(false, showname + hidLotNo.Text, "<p class=\"error\">Status :  Deleted failed, please check the data . </p>", div_bottom);
            }

        }
    }

    #region    btnNext_Click()     Author：Hcy   (2011-11-23)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        btnSave_Click(sender, e);
        Response.Redirect("List.aspx?type=" + typename);
    }
    #endregion

    #region    btnSave_Click()     Author：Hcy   (2011-11-28)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        if (string.IsNullOrEmpty(CmbShipperCode.Value.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, Shipper can't be empty!</p>";
            CmbShipperCode.Focus();
            return;
        }
        if (string.IsNullOrEmpty(CmbConsignee.Value.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, Consignee can't be empty!</p>";
            CmbConsignee.Focus();
            return;
        }
        if (GridFlightList.Store.Count == 0)
        {
            div_bottom.Html = "<p class='error'> Save failed, Flight Routing is no data!</p>";
            l_flightno.Focus();
            return;
        }

        List<IFields> UpdateHAWB = new List<IFields>();
        UpdateHAWB.Add(dal.CreateIFields().Append("Option", "Update")
            .Append("air_Seed", hidSeed.Text == "" ? null : hidSeed.Text)

            .Append("air_MAWB", txtMAWB.Text.Trim().Replace(" ", "").ToUpper())
            .Append("air_LotNo",hidLotNo.Text)
            //.Append("air_LocReceived",CmbDeparture.Value)
            //.Append("air_LocFinal", CmbFinalDest.Value)

            .Append("air_Sales", CmbSalesman.Value)
            .Append("air_Shipper", CmbShipperCode.Value)
            .Append("air_Consignee", CmbConsignee.Value)

            .Append("air_Carrier", CmbCarrierRight.Value)
            .Append("air_Flight", txtFlightRight.Text.ToUpper())
            .Append("air_LocLoad", CmbFromRight.Value)
            .Append("air_LocDischarge", CmbToRight.Value)
            .Append("air_ETD", ControlBinder.getDate(txtETD.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtETD.RawText.Trim()))
            .Append("air_ETA", ControlBinder.getDate(txtETA.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtETA.RawText.Trim()))
            .Append("air_ATD", ControlBinder.getDate(txtATD.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtATD.RawText.Trim()))
            .Append("air_ATA", ControlBinder.getDate(txtATA.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtATA.RawText.Trim()))

            .Append("air_GWT", string.IsNullOrEmpty(txtGWT.Text) ? DBNull.Value : (object)txtGWT.Text)
            .Append("air_VWT", string.IsNullOrEmpty(txtVWT.Text) ? DBNull.Value : (object)txtVWT.Text)
            .Append("air_CWT", string.IsNullOrEmpty(txtCWT.Text) ? DBNull.Value : (object)txtCWT.Text)
            .Append("air_Piece", string.IsNullOrEmpty(txtPiece.Text) ? DBNull.Value : (object)txtPiece.Text)
            .Append("air_Pallet", string.IsNullOrEmpty(txtPallet.Text) ? DBNull.Value : (object)txtPallet.Text)
            .Append("air_Rate", string.IsNullOrEmpty(txtRate.Text) ? DBNull.Value : (object)txtRate.Text)
            .Append("air_Remark",txtRemark.Text.Trim())
            .Append("air_OperationRemark", txtOperation.Text.Trim())
            .Append("air_AccountRemark", txtAccount.Text.Trim())

            .Append("code", FSecurityHelper.CurrentUserDataGET()[4].ToString() + sys)
            .Append("code1", FSecurityHelper.CurrentUserDataGET()[4].ToString() + sys + "SN")
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("air_SYS", sys)
            .Append("type", typename)
            .Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            );
        try
        {
            DataSet ds = GetDs("FW_AirExport_DirectMAWB_SP", UpdateHAWB);
            hidSeed.Text = ds.Tables[0].Rows[0][0].ToString();
            string newFlag = ds.Tables[0].Rows[0][1].ToString();
            hidLotNo.Text = ds.Tables[0].Rows[0][2].ToString();

            #region FlightRouting
            var ShipmentRoute = JSON.Deserialize<List<ShipmentRoute>>(e.ExtraParams["p_safety_l"]);
            List<IFields> Routelist = new List<IFields>();
            string RouteID = "";
            for (int i = 0; i < ShipmentRoute.Count; ++i)
            {
                Routelist.Add(dal.CreateIFields().Append("Option", "Update").
                Append("sr_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString()).
                Append("sr_ToMaster", hidSeed.Text).
                Append("sr_ShipKind", "FREIGHT").
                Append("sr_Carrier", ShipmentRoute[i].Carrier).
                Append("sr_OrderID", i).
                Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).
                Append("sr_Flight", ShipmentRoute[i].FlightNo.ToUpper()).
                Append("sr_From", ShipmentRoute[i].From).
                Append("sr_To", ShipmentRoute[i].To).
                Append("sr_ETD", ControlBinder.getDate(ShipmentRoute[i].ETD.ToString().StartsWith("0001") ? DBNull.Value : (object)ShipmentRoute[i].ETD)).
                Append("sr_ETA", ControlBinder.getDate(ShipmentRoute[i].ETA.ToString().StartsWith("0001") ? DBNull.Value : (object)ShipmentRoute[i].ETA)).
                Append("sr_ATD", ControlBinder.getDate(ShipmentRoute[i].ATD.ToString().StartsWith("0001") ? DBNull.Value : (object)ShipmentRoute[i].ATD)).
                Append("sr_ATA", ControlBinder.getDate(ShipmentRoute[i].ATA.ToString().StartsWith("0001") ? DBNull.Value : (object)ShipmentRoute[i].ATA)).
                Append("sr_ROWID", ShipmentRoute[i].RowID));
                RouteID += "," + ShipmentRoute[i].RowID;
            }
            if (RouteID.Length > 1)
            {
                RouteID = RouteID.Substring(1, RouteID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentRoute_SP", new List<IFields> { dal.CreateIFields().Append("Option", "Delete").Append("sr_ToMaster", hidSeed.Text).Append("str", RouteID) }).Update();
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentRoute_SP", Routelist).Update();
            #endregion

            #region LocalInvoice
            //var InvocieList = JSON.Deserialize<List<Invocie>>(e.ExtraParams["p_safety_2"]);
            //string InvoiceID = "";
            //for (int i = 0; i < InvocieList.Count; ++i)
            //{
            //    InvoiceID += "," + InvocieList[i].RowID;
            //}
            //if (InvoiceID.Length > 1)
            //{
            //    InvoiceID = InvoiceID.Substring(1, InvoiceID.Length - 1);
            //}
            //bool inv = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_DirectMAWB_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteInvoice")
            //.Append("air_ToMAWB",hidSeed.Text)
            //.Append("str",InvoiceID)}).Update();
            #endregion

            //X.AddScript("saveCost('" + hidSeed.Text + "');");

            ucCost.costseed = hidSeed.Text;
            ucCost.btnCostEvent(sender, e);

            #region Foreign
            var Foreign = JSON.Deserialize<List<Foreign>>(e.ExtraParams["p_safety_4"]);
            List<IFields> Foreignlist = new List<IFields>();
            string ForeignID = "";
            for (int i = 0; i < Foreign.Count; ++i)
            {
                if (Foreign[i].CompanyCode.Trim() != "" && Foreign[i].Item.Trim() != "" && Foreign[i].CalcKind.Trim() != "")
                {
                    Foreignlist.Add(dal.CreateIFields().Append("Option", "UpdateForeign").
                    Append("si_BillTo", Foreign[i].CompanyCode.Trim().ToUpper()).
                    Append("si_Total", string.IsNullOrEmpty(Foreign[i].Total) ? DBNull.Value : (object)Foreign[i].Total).
                    Append("si_Item", Foreign[i].Item.Trim().ToUpper()).
                    Append("si_Description", Foreign[i].Description).
                    Append("si_QtyKind", Foreign[i].CalcKind.Trim().ToUpper()).
                    //Append("si_Currency", CmbForeign.SelectedItem.Value == null ? "USD" : CmbForeign.SelectedItem.Value).
                    Append("si_Currency", string.IsNullOrEmpty(Foreign[i].Currency) ? "USD" : (object)Foreign[i].Currency).
                    Append("si_Quantity", string.IsNullOrEmpty(txtCWT.Text) ? null : (object)txtCWT.Text).
                    Append("si_Unit", Foreign[i].Unit).
                    Append("si_ExRate", string.IsNullOrEmpty(Foreign[i].EX) ? DBNull.Value : (object)Foreign[i].EX).
                    Append("si_Rate", string.IsNullOrEmpty(Foreign[i].Rate) ? DBNull.Value : (object)Foreign[i].Rate).
                    Append("si_Amount", string.IsNullOrEmpty(Foreign[i].Amount) ? DBNull.Value : (object)Foreign[i].Amount).
                    Append("si_Min", string.IsNullOrEmpty(Foreign[i].Min) ? DBNull.Value : (object)Foreign[i].Min).
                    Append("si_ShowIn", Foreign[i].Show.Trim().ToUpper())
                    .Append("si_ROWID", Foreign[i].RowID)
                    .Append("si_ToMaster", hidSeed.Text)
                    .Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                    .Append("si_Sys", sys)
                    .Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                    );
                    ForeignID += "," + Foreign[i].RowID;
                }
            }
            //delete
            if (ForeignID.Length > 1)
            {
                ForeignID = ForeignID.Substring(1, ForeignID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualForeign").Append("si_Seed", hidSeed.Text).Append("str", ForeignID) }).Update();
            bool resultForeign = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", Foreignlist).Update();
            #endregion

            #region Foreign Freight
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateForFreight").Append("si_ROWID", string.IsNullOrEmpty(hidForeignID.Text) ? null : (object)hidForeignID.Text)
             .Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).Append("si_Sys", sys).Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString()).Append("si_ToMaster", hidSeed.Text)
             .Append("si_BillTo", CmbCompany.Value).Append("si_Min",string.IsNullOrEmpty(txtFor.Text) ? "0" : (object)txtFor.Text).Append("si_Currency", CmbForeign.SelectedItem.Value == null ? "USD" : CmbForeign.SelectedItem.Value).Append("si_Quantity", string.IsNullOrEmpty(txtCWT.Text) ? null : (object)txtCWT.Text).Append("si_Unit", "") }).Update();
            #endregion

            #region Local
            var Local = JSON.Deserialize<List<Local>>(e.ExtraParams["p_safety_5"]);
            List<IFields> Locallist = new List<IFields>();
            string LocalID = "";
            for (int i = 0; i < Local.Count; ++i)
            {
                if (Local[i].CompanyCode.Trim() != "" && Local[i].Item.Trim() != "" && Local[i].CalcKind.Trim() != "")
                {
                    Locallist.Add(dal.CreateIFields().Append("Option", "UpdateLocal").
                    Append("si_BillTo", Local[i].CompanyCode.Trim().ToUpper()).
                    Append("si_Total", string.IsNullOrEmpty(Local[i].Total) ? DBNull.Value : (object)Local[i].Total).
                    Append("si_Item", Local[i].Item.Trim().ToUpper()).
                    Append("si_Description", Local[i].Description).
                    Append("si_QtyKind", Local[i].CalcKind.Trim().ToUpper()).
                    Append("si_Currency", CmbLocal.SelectedItem.Value == null ? "HKD" : CmbLocal.SelectedItem.Value).
                    Append("si_Quantity", string.IsNullOrEmpty(txtCWT.Text) ? null : (object)txtCWT.Text).
                    Append("si_Unit", Local[i].Unit).
                    Append("si_ExRate", string.IsNullOrEmpty(Local[i].EX) ? DBNull.Value : (object)Local[i].EX).
                    Append("si_Rate", string.IsNullOrEmpty(Local[i].Rate) ? DBNull.Value : (object)Local[i].Rate).
                    Append("si_Amount", string.IsNullOrEmpty(Local[i].Amount) ? DBNull.Value : (object)Local[i].Amount).
                    Append("si_Min", string.IsNullOrEmpty(Local[i].Min) ? DBNull.Value : (object)Local[i].Min).
                    Append("si_ShowIn", Local[i].Show.Trim().ToUpper())
                    .Append("si_ROWID", Local[i].RowID)
                    .Append("si_ToMaster", hidSeed.Text)
                    .Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                    .Append("si_Sys", sys)
                    .Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                    );
                    LocalID += "," + Local[i].RowID;
                }
            }
            //delete
            if (LocalID.Length > 1)
            {
                LocalID = LocalID.Substring(1, LocalID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualLocal").Append("si_Seed", hidSeed.Text).Append("str", LocalID) }).Update();
            bool resultLocal = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", Locallist).Update();
            #endregion

            #region Local Freight
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateLocFreight").Append("si_ROWID", string.IsNullOrEmpty(hidLocalID.Text) ? null : (object)hidLocalID.Text)
             .Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).Append("si_Sys", sys).Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString()).Append("si_ToMaster", hidSeed.Text)
             .Append("si_BillTo", CmbCompany1.Value).Append("si_Min", string.IsNullOrEmpty(txtLoc.Text) ? "0" : (object)txtLoc.Text).Append("si_Currency", CmbLocal.SelectedItem.Value == null ? "HKD" : CmbLocal.SelectedItem.Value).Append("si_Quantity", string.IsNullOrEmpty(txtCWT.Text) ? null : (object)txtCWT.Text).Append("si_Unit", "") }).Update();
            #endregion

            #region WTForeign
            var WTForeign = JSON.Deserialize<List<WTForeign>>(e.ExtraParams["p_safety_6"]);
            List<IFields> WTForeignlist = new List<IFields>();
            string WTForeignID = "";
            for (int i = 0; i < WTForeign.Count; ++i)
            {
                if (WTForeign[i].Rate != null)
                {
                    WTForeignlist.Add(dal.CreateIFields().Append("Option", "UpdateSellRateForeign").
                    Append("aer_Weight", string.IsNullOrEmpty(WTForeign[i].WT) ? "0.000" : (object)WTForeign[i].WT).
                    Append("aer_Rate", string.IsNullOrEmpty(WTForeign[i].Rate) ? DBNull.Value : (object)WTForeign[i].Rate)
                    .Append("aer_ROWID", WTForeign[i].RowID)
                    .Append("aer_Seed", hidSeed.Text)
                    .Append("aer_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                    .Append("aer_Sys", sys)
                    .Append("aer_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                    );
                    WTForeignID += "," + WTForeign[i].RowID;
                }
            }
            //delete
            if (WTForeignID.Length > 1)
            {
                WTForeignID = WTForeignID.Substring(1, WTForeignID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualSellRateForeign").Append("aer_Seed", hidSeed.Text).Append("str", WTForeignID) }).Update();
            bool resultWTForeign = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", WTForeignlist).Update();
            #endregion

            #region WTLocal
            var WTLocal = JSON.Deserialize<List<WTLocal>>(e.ExtraParams["p_safety_7"]);
            List<IFields> WTLocallist = new List<IFields>();
            string WTLocalID = "";
            for (int i = 0; i < WTLocal.Count; ++i)
            {
                if (WTLocal[i].Rate != null)
                {
                    WTLocallist.Add(dal.CreateIFields().Append("Option", "UpdateSellRateLocal").
                    Append("aer_Weight", string.IsNullOrEmpty(WTLocal[i].WT) ? "0.000" : (object)WTLocal[i].WT).
                    Append("aer_Rate", string.IsNullOrEmpty(WTLocal[i].Rate) ? DBNull.Value : (object)WTLocal[i].Rate)
                    .Append("aer_ROWID", WTLocal[i].RowID)
                    .Append("aer_Seed", hidSeed.Text)
                    .Append("aer_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                    .Append("aer_Sys", sys)
                    .Append("aer_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                    );
                    WTLocalID += "," + WTLocal[i].RowID;
                }
            }
            //delete
            if (WTLocalID.Length > 1)
            {
                WTLocalID = WTLocalID.Substring(1, WTLocalID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualSellRateLocal").Append("aer_Seed", hidSeed.Text).Append("str", WTLocalID) }).Update();
            bool resultWTLocal = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForDirectMAWB_SP", WTLocallist).Update();
            #endregion

            #region updateFreightTotal
            string type1 = "N", type2 = "N";
            if (CmbCompany.Value != "") { type1 = "Y"; }
            if (CmbCompany1.Value != "") { type2 = "Y"; }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_CoLoaderInFreight_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateTotal").Append("air_Seed", hidSeed.Text).Append("CWT", string.IsNullOrEmpty(txtCWT.Text) ? "0" : txtCWT.Text)
            .Append("Type1",type1).Append("Type2",type2).Append("F_Min", string.IsNullOrEmpty(txtFor.Text) ? "0" : txtFor.Text).Append("L_Min", string.IsNullOrEmpty(txtLoc.Text) ? "0" : txtLoc.Text).Append("M","Y") }).Update();
            #endregion

            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "AE", "MAWB");

            if (newFlag == "N")
            {
                //---
                DataBindList();
                X.AddScript("if(window.opener!=null){if(typeof(window.opener.RefreshList)!='undefined'){window.opener.RefreshList();}}");
                ControlBinder.pageTitleMsg(false, showname + ":" + hidLotNo.Text, "<p class=\"success\">Status : Save successfully ! </p>", div_bottom);
            }
            
        }
        catch
        {
            ControlBinder.pageTitleMsg(false, showname + ":" + hidLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data !</p>", div_bottom);
        }

        
    }
    #endregion

    [DirectMethod]
    public void MakeInvoice()
    {
        if (hidSeed.Text.Length > 0)
        {
            bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AutoInvoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "MakeInvoice").
                Append("seed", hidSeed.Text).
                Append("user",FSecurityHelper.CurrentUserDataGET()[0])}).Update();

            DataBindList();
        }
    }

    #region FlightRouting
    class ShipmentRoute
    {
        public int RowID
        { get; set; }

        public string FlightNo
        { get; set; }

        public string From
        { get; set; }

        public string To
        { get; set; }

        public string ETD
        { get; set; }

        public string ETA
        { get; set; }


        public string ATD
        { get; set; }


        public string ATA
        { get; set; }

        public string Carrier
        { get; set; }

    }
    #endregion

    #region Invoice
    class Invocie
    {
        public string RowID { get; set; }
    }
    #endregion

    

    #region GetCWT
    private string GetCWT()
    {
        string temp = "0";
        string gwt = txtGWT.Text.Trim();
        string vwt = txtVWT.Text.Trim();
        if (txtGWT.Text.Trim() == "")
        {
            gwt = "0";
        }
        if (txtVWT.Text.Trim() == "")
        {
            vwt = "0";
        }
        if (Convert.ToDouble(gwt) >= Convert.ToDouble(vwt))
        {
            temp = gwt;
        }
        else
        {
            temp = vwt;
        }
        return temp;
    }
    #endregion

    #region WTForeign
    class WTForeign
    {
        public int RowID
        { get; set; }
        public string Rate
        { get; set; }
        public string WT
        { get; set; }
    }
    #endregion

    #region WTLocal
    class WTLocal
    {
        public int RowID
        { get; set; }
        public string Rate
        { get; set; }
        public string WT
        { get; set; }
    }
    #endregion

    #region Foreign
    class Foreign
    {
        public int RowID
        { get; set; }
        public string CompanyCode
        { get; set; }
        public string Item
        { get; set; }
        public string CalcKind
        { get; set; }
        public string Rate
        { get; set; }
        public string Amount
        { get; set; }
        public string Min
        { get; set; }
        public string Show
        { get; set; }
        public string Currency
        { get; set; }
        public string Description
        { get; set; }
        public string Total
        { get; set; }
        public string EX
        { get; set; }
        public string Qty
        { get; set; }
        public string Unit
        { get; set; }
    }
    #endregion

    #region Local
    class Local
    {
        public int RowID
        { get; set; }
        public string CompanyCode
        { get; set; }
        public string Item
        { get; set; }
        public string CalcKind
        { get; set; }
        public string Rate
        { get; set; }
        public string Amount
        { get; set; }
        public string Min
        { get; set; }
        public string Show
        { get; set; }
        public string Currency
        { get; set; }
        public string Description
        { get; set; }
        public string Total
        { get; set; }
        public string EX
        { get; set; }
        public string Qty
        { get; set; }
        public string Unit
        { get; set; }
    }
    #endregion
   
}
