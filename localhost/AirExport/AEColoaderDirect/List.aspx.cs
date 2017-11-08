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

public partial class AirExport_AEColoaderDirect_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    public static string sys = "AE";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            ControlBinder.DateFormat(l_etd);
            ControlBinder.DateFormat(l_eta);
            ControlBinder.DateFormat(l_atd);
            ControlBinder.DateFormat(l_ata);
            CmbNP.SelectedItem.Value = "N";
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ComboBoxBinding();
            DataBindList();
            LockControl();
        }
    }

    protected void LockControl()
    {
        if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT")
        {
            btnSave.Disabled = true;
            btnCancel.Disabled = true;
            btnNext.Disabled = true;
            btnVoid.Disabled = true;
            btnUpdateLotNo.Hide();
        }
    }


    #region //Store数据刷新
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
    protected void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsSalesman = GetComboxDs("SalesList");
        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();
    }
    #endregion



    #region GetDs(string CmdText, List<IFields> fields)   Author ：hcy   (2011-11-30)
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

    #region   GetComboxDs()    Author ：Hcy   (2011-11-30)
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

    #region   ComboBoxBinding()    Author ：Hcy   (2011-11-30)
    private void ComboBoxBinding()
    {
        DataSet dsLocation = GetComboxDs("LocationList");
        DataSet dsUnit = GetComboxDs("UnitBinding");
        DataSet dsItem = GetComboxDs("ItemBinding");
        DataSet dsKind = GetComboxDs("QtyKindBinding");
        DataSet dsCurrencysList = GetComboxDs("CurrencysInvoice");
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();
        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

        StoreCurrInvoice.DataSource = dsCurrencysList;
        StoreCurrInvoice.DataBind();

        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();

        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();

        StoreItem.DataSource = dsItem;
        StoreItem.DataBind();

        StoreKind.DataSource = dsKind;
        StoreKind.DataBind();

        DataSet dsSalesman = GetComboxDs("SalesList");
        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();

        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", "A");
    }
    #endregion

    #region   DataBindList()    Author ：Hcy   (2011-11-30)
    private void DataBindList()
    {
        txtMAWB.Focus(true);

        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetAEColoaderDirect")
            .Append("air_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("air_SYS", sys)
            );
        DataSet ds = GetDs("FW_AirExport_CoLoaderDirect_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0 && hidSeed.Text != "0" && hidSeed.Text != "")
        {


            labLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();
            hidLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();

            txtMAWB.Text = ds.Tables[0].Rows[0]["MAWB"].ToString();
            //CmbDeparture.setValue(ds.Tables[0].Rows[0]["Departure"].ToString());
            //CmbFinalDest.setValue(ds.Tables[0].Rows[0]["Destination"].ToString());

            CmbSalesman.setValue(ds.Tables[0].Rows[0]["Salesman"].ToString());

            CmbColoader.setValue(ds.Tables[0].Rows[0]["CoLoader"].ToString());
            CmbColoader.Text = ds.Tables[0].Rows[0]["CoLoaderName"].ToString();
            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Shipper"].ToString());
            CmbShipperCode.Text = ds.Tables[0].Rows[0]["ShipperName"].ToString();
            CmbConsignee.setValue(ds.Tables[0].Rows[0]["Consignee"].ToString());
            CmbConsignee.Text = ds.Tables[0].Rows[0]["ConsigneeName"].ToString();
            CmbNP.SelectedItem.Value = ds.Tables[0].Rows[0]["NP"].ToString();

            CmbCarrierRight.setValue(ds.Tables[0].Rows[0]["Carrier"].ToString());
            txtFlightRight.Text = ds.Tables[0].Rows[0]["FlightNo"].ToString();
            CmbFromRight.setValue(ds.Tables[0].Rows[0]["From"].ToString());
            CmbToRight.setValue(ds.Tables[0].Rows[0]["To"].ToString());
            txtETD.Text = ds.Tables[0].Rows[0]["ETD"].ToString();
            txtETA.Text = ds.Tables[0].Rows[0]["ETA"].ToString();
            txtATD.Text = ds.Tables[0].Rows[0]["ATD"].ToString();
            txtATA.Text = ds.Tables[0].Rows[0]["ATA"].ToString();
            txtMAWBRemark.Text = ds.Tables[0].Rows[0]["air_Remark"].ToString();

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

            bool ismakeMawb = ds.Tables[0].Rows[0]["air_MakeMAWB"].ToString() == "" ? false : Convert.ToBoolean(ds.Tables[0].Rows[0]["air_MakeMAWB"]);
            if (ismakeMawb == true)
            {
                txtGWT.Disabled = true;
                txtVWT.Disabled = true;
                txtCWT.Disabled = true;
                txtPiece.Disabled = true;
                isMawbFlag.Style.Add("display", "none");
            }
            else
            {
                txtGWT.Disabled = false;
                txtVWT.Disabled = false;
                txtCWT.Disabled = false;
                txtPiece.Disabled = false;
                isMawbFlag.Style.Add("display", "block");
            }
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


            if (ControlBinder.IsDisplayLotNo(txtETD.Text.Trim(), hidLotNo.Text))
            {
                btnUpdateLotNo.Show();
            }
            else
            {
                btnUpdateLotNo.Hide();
            }

            if (ds.Tables[0].Rows[0]["Active"].ToString() == "Y")
            {
                img_void.Style.Value = "display:none";
            }
            else
            {
                img_void.Style.Value = "display:inline";
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnNext.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                btnUpdateLotNo.Hide();
            }

            ControlBinder.pageTitleMsg(false, "AE-M:" + hidLotNo.Text, "<p>Status :  Edit MAWB of  <span>" + hidLotNo.Text + "</span></p>", div_bottom);
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "AE-M New", "<p>Status :  New Blank MAWB </p>", div_bottom);
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

        if (seedid.Length > 1)
        {

            string voidflag = hidVoid.Text == "0" ? "Y1" : "N1";
            DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "A").Append("Type", "MAWB").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text==""?null:hidSeed.Text)}).GetList();
            if (l != null && l.Tables[0].Rows[0][0].ToString() == "Y")
            {
                X.AddScript("$('#img_void').css('display','inline');");
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnNext.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                btnUpdateLotNo.Hide();
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "N")
            {
                X.AddScript("$('#img_void').css('display','none');");
                btnSave.Disabled = false;
                btnCancel.Disabled = false;
                btnNext.Disabled = false;
                btnVoid.Text = "Void";
                hidVoid.Text = "0";
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "AE-M:" + hidLotNo.Text, "<p class=\"error\">Status :  Void failed, please check the data . </p>", div_bottom);
            }
            DataBindList();
            ControlBinder.pageTitleMsg(false, "AE-M:" + hidLotNo.Text, "<p>Status :  Edit MAWB of  <span>" + hidLotNo.Text + "</span></p>", div_bottom);
        }
    }


    #region    btnNext_Click()     Author：Hcy   (2011-11-23)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        btnSave_Click(sender, e);
        X.Redirect("List.aspx");
    }
    #endregion

    #region    btnSave_Click()     Author：Hcy   (2011-11-28)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        //if (string.IsNullOrEmpty(CmbShipperCode.Value.Trim()))
        //{

        //    div_bottom.Html = "<p class='error'> Save failed, Shipper can't be empty!</p>";
        //    CmbShipperCode.Focus();
        //    return;
        //}
        //if (string.IsNullOrEmpty(CmbConsignee.Value.Trim()))
        //{
        //    div_bottom.Html = "<p class='error'> Save failed, Consignee can't be empty!</p>";
        //    CmbConsignee.Focus();
        //    return;
        //}
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
            //.Append("air_LocReceived", CmbDeparture.Value)
            //.Append("air_LocFinal", CmbFinalDest.Value)

            .Append("air_CoLoader", CmbColoader.Value)
            //.Append("air_CoLoader", CmbColoaderName.SelectedItem.Value)
            .Append("air_Shipper", CmbShipperCode.Value)
            //.Append("air_Shipper", CmbShipperName.SelectedItem.Value)
            .Append("air_Consignee", CmbConsignee.Value)
            //.Append("air_Consignee", CmbConsigneeName.SelectedItem.Value)
            .Append("air_NP", CmbNP.SelectedItem.Value)
            
            .Append("air_Sales", CmbSalesman.Value)

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
            .Append("air_Remark", string.IsNullOrEmpty(txtMAWBRemark.Text) ? "" : txtMAWBRemark.Text.ToUpper())

            .Append("code", FSecurityHelper.CurrentUserDataGET()[4].ToString() + sys)
            .Append("code1", FSecurityHelper.CurrentUserDataGET()[4].ToString() + sys + "SN")
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("air_SYS", sys)
            .Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            );
        try
        {
            DataSet ds = GetDs("FW_AirExport_CoLoaderDirect_SP", UpdateHAWB);
            hidSeed.Text = ds.Tables[0].Rows[0][0].ToString();
            string newFlag = ds.Tables[0].Rows[0][1].ToString();

            //X.AddScript("saveCost('" + hidSeed.Text + "');");

            ucCost.costseed = hidSeed.Text;
            ucCost.btnCostEvent(sender, e);

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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentRouteForDirect_SP", new List<IFields> { dal.CreateIFields().Append("Option", "Delete").Append("sr_ToMaster", hidSeed.Text).Append("str", RouteID) }).Update();
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentRouteForDirect_SP", Routelist).Update();
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
            //bool inv = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_CoLoaderDirect_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteInvoice")
            //.Append("air_ToMAWB",hidSeed.Text)
            //.Append("str",InvoiceID)}).Update();
            #endregion




            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "AE", "MAWB");
            if (newFlag == "N")
            {
                DataBindList();
                X.AddScript("if(window.opener!=null){if(typeof(window.opener.RefreshList)!='undefined'){window.opener.RefreshList();}}");
                ControlBinder.pageTitleMsg(true, "AE-M:" + hidLotNo.Text, "<p class=\"success\">Status : Save successfully ! </p>", div_bottom);
            }
            else
            {
                ControlBinder.pageTitleMsg(true, "AE-M:" + hidLotNo.Text, "<p class=\"success\">Status : Save successfully ! </p>", div_bottom);
                X.Redirect("List.aspx?seed=" + hidSeed.Text);
            }
        }
        catch
        {
            ControlBinder.pageTitleMsg(false, "AE-M:" + hidLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data !</p>", div_bottom);
        }


    }
    #endregion


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

}

