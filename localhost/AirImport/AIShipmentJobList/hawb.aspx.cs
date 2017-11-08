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


public partial class AirImport_AIShipmentJobList_hawb : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "0" : Request["seed"];
            hidMAWB.Text = Request["MAWB"] == null ? "0" : Request["MAWB"];
            ControlBinder.DateFormat(txtFreeStorageStart);
            ControlBinder.DateFormat(txtFreeStorageEnd);
            ControlBinder.DateFormat(txtPickUp);
            ControlBinder.DateFormat(FI_Date);
            ControlBinder.DateFormat(r_ETD);
            ControlBinder.DateFormat(r_ETA);
            FI_Currency.Text = ControlBinder.getCurrency("f", SYS); 
            cur = ControlBinder.getCurrency("f", SYS);
        }
    }

    public string cur = string.Empty;

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ComboBoxBinding();
            DataBindList();
            LockControl();
            //X.AddScript("showCompanyRemark('CmbShipperCode,CmbConsignee,CmbNotify1,CmbNotify2,CmbCoLoader,CmbBroker', 'Shipper,Consignee,Notify #1,Notify #2,Co-Loader,Broker');");
        }
    }

    #region LockControl()
    protected void LockControl()
    {
        if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT")
        {
            btnSave.Disabled = true;
            btnCancel.Disabled = true;
            btnNext.Disabled = true;
            btnVoid.Disabled = true;
        }
        else
        {
            if (hidSeed.Text.Length > 1)
            {
                X.AddScript("TransferVoid();");
            }
        }
    }
    #endregion

    DataFactory dal = new DataFactory();
    readonly string SYS = "AI";
    #region GetDs(string CmdText, List<IFields> fields)   Author ：hcy   (2011-09-08)
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

    #region   ComboBoxBinding()    Author ：Hcy   (2011-09-08)
    private void ComboBoxBinding()
    {
        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", "A");
        DataSet dsLocation = GetComboxDs("LocationList");
        DataSet dsSalesman = GetComboxDs("SalesList");
        DataSet dsCompany = new DataSet();//GetComboxDs("CompanyList");
        DataSet dsCurrency = GetComboxDs("CurrencysList");
        DataSet dsUnit = GetComboxDs("UnitBinding");
        //DataSet dsItem = GetComboxDs("ItemBinding");
        DataSet dsKind = GetComboxDs("QtyKindBinding");
        DataSet dsDept = GetComboxDs("DeptBinding");
        DataSet dsForeignKind = GetComboxDs("ForeignKind");
        DataSet dsShipKind = GetComboxDs("ShipKind");
        DataSet dsCompanyKind = GetComboxDs("CompanyKind");

        //StoreCurrLocal.DataSource = GetComboxDs("CurrencysListLocal");
        //StoreCurrLocal.DataBind();

        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();

        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();

        //StoreCompany.DataSource = dsCompany;
        //StoreCompany.DataBind();

        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();
        //l_unit.Template.Html = Template.Html;

        //StoreCurrency.DataSource = dsCurrency;
        //StoreCurrency.DataBind();

        //StoreItem.DataSource = dsItem;
        //StoreItem.DataBind();
        //l_item.Template.Html = Template.Html;
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();


        StoreKind.DataSource = dsKind;
        StoreKind.DataBind();

        StoreDept.DataSource = dsDept;
        StoreDept.DataBind();

        StoreForeignKind.DataSource = dsForeignKind;
        StoreForeignKind.DataBind();

        StoreShipKind.DataSource = dsShipKind;
        StoreShipKind.DataBind();

        StoreCompanyKind.DataSource = dsCompanyKind;
        StoreCompanyKind.DataBind();

        StoreCurrInvoice.DataSource = GetComboxDs("CurrencysInvoice");
        StoreCurrInvoice.DataBind();
    }
    #endregion

    public XTemplate Template
    {
        get
        {
            XTemplate xt = new XTemplate();
            xt.Html = "<tpl for=\".\">" +
                      "<tpl if=\"[xindex] == 1\">" +
                          "<table class=\"cbStates-list\">" +
                              "<tr>" +
                                   "<th>Code</th>" +
                                  "<th>Name</th>" +
                              "</tr>" +
                      "</tpl>" +
                          "<tr class=\"list-item\">" +
                          "<td style=\"padding:3px 0px; width:30%\">{value}</td>" +
                          "<td style=\"padding:3px 0px; width:70%\">{text}</td>" +
                      "</tr>" +
                      "<tpl if=\"[xcount-xindex]==0\">" +
                              "</table>" +
                     "</tpl></tpl>";
            return xt;
        }
    }


    #region ///刷新数据源
    /// <summary>
    /// 刷新数据源
    /// </summary>
    public void StoreLocation_OnrefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsLocation = GetComboxDs("LocationList");
        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();
    }
    public void StoreSalesman_OnrefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsSalesman = GetComboxDs("SalesList");
        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();
    }
    public void StoreUnit_OnrefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsUnit = GetComboxDs("UnitBinding");
        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();
    }
    public void StoreItem_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

    }
    public void StoreShipKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsShipKind = GetComboxDs("ShipKind");
        StoreShipKind.DataSource = dsShipKind;
        StoreShipKind.DataBind();

    }
    
    public void StoreKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreKind.DataSource = GetComboxDs("QtyKindBinding"); 
        StoreKind.DataBind();
    }
    public void StoreDept_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreDept.DataSource = GetComboxDs("DeptBinding");
        StoreDept.DataBind();
    }
    public void StoreForeignKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreForeignKind.DataSource = GetComboxDs("ForeignKind");
        StoreForeignKind.DataBind();
    }
    public void StoreCompanyKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreCompanyKind.DataSource = GetComboxDs("CompanyKind");
        StoreCompanyKind.DataBind();
    }
    public void StoreCurrInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreCurrInvoice.DataSource = GetComboxDs("CurrencysInvoice");
        StoreCurrInvoice.DataBind();
    }
    #endregion

    #region   GetComboxDs()    Author ：Hcy   (2011-09-08)
    private DataSet GetComboxDs(string Type)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", Type).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS","A")}).GetList();
        }
        catch
        {
            ds = null;
        }
        return ds;
    }
    #endregion

    #region   DataBinding()    Author ：Hcy   (2011-09-08)
    private void DataBindList()
    {
        txtHawb.Focus(true);
        UserSheet1.seed = hidSeed.Text;
       
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "List")
            .Append("seed", hidSeed.Text)
            .Append("air_ToMAWB", hidMAWB.Text)
            .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS", SYS)
            );
        DataSet ds = GetDs("FW_AirImport_HAWB_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["RowID"].ToString() != "")
        {
            

            txtHawb.Text = ds.Tables[0].Rows[0]["HAWB"].ToString();
            txtReference.Text = ds.Tables[0].Rows[0]["Reference"].ToString();
            txtClearance.Text = ds.Tables[0].Rows[0]["Clearance"].ToString();
            chkInsurance.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Insurance"].ToString() == "" ? 0 : ds.Tables[0].Rows[0]["Insurance"]);
            labMAWB.Text = ds.Tables[0].Rows[0]["MAWB"].ToString();
            labLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();
            CmbReceipt.setValue(ds.Tables[0].Rows[0]["Receipt"].ToString());
            CmbFinalDest.setValue(ds.Tables[0].Rows[0]["FinalDest"].ToString());
            CmbSalesman.setValue(ds.Tables[0].Rows[0]["Salesman"].ToString());
            chkDG.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DG"].ToString() == "" ? 0 : ds.Tables[0].Rows[0]["DG"]);
            chkSurrender.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Surrender"].ToString() == "" ? 0 : ds.Tables[0].Rows[0]["Surrender"]);

            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Shipper"].ToString());
            CmbShipperCode.Text = ds.Tables[0].Rows[0]["ShipperName"].ToString();
            CmbConsignee.setValue(ds.Tables[0].Rows[0]["Consignee"].ToString());
            CmbConsignee.Text = ds.Tables[0].Rows[0]["ConsigneeName"].ToString();

            CmbNotify1.setValue(ds.Tables[0].Rows[0]["Notify1"].ToString());
            CmbNotify1.Text = ds.Tables[0].Rows[0]["Notify1Name"].ToString();
            CmbNotify2.setValue(ds.Tables[0].Rows[0]["Notify2"].ToString());
            CmbNotify2.Text = ds.Tables[0].Rows[0]["Notify2Name"].ToString();

            CmbCoLoader.setValue(ds.Tables[0].Rows[0]["Coloader"].ToString());
            CmbCoLoader.Text = ds.Tables[0].Rows[0]["ColoaderName"].ToString();
            CmbBroker.setValue(ds.Tables[0].Rows[0]["Broker"].ToString());
            CmbBroker.Text = ds.Tables[0].Rows[0]["BrokerName"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
                txtGWT.Text = ds.Tables[0].Rows[0]["GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["VWT"].ToString()))
                txtVWT.Text = ds.Tables[0].Rows[0]["VWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CWT"].ToString()))
                txtCWT.Text = ds.Tables[0].Rows[0]["CWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Piece"].ToString()))
                txtPiece.Text = ds.Tables[0].Rows[0]["Piece"].ToString();
            CmbUnit.setValue(ds.Tables[0].Rows[0]["Unit"].ToString());
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Pallet"].ToString()))
                txtPallet.Text = ds.Tables[0].Rows[0]["Pallet"].ToString();

            CmbWarehouse.setValue(ds.Tables[0].Rows[0]["Warehouse"].ToString());
            CmbWarehouse.Text = ds.Tables[0].Rows[0]["WarehouseName"].ToString();
            txtFreeStorageStart.Text = ds.Tables[0].Rows[0]["FreeStorageStart"].ToString();
            txtFreeStorageEnd.Text = ds.Tables[0].Rows[0]["FreeStorageEnd"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["FreeStorage"].ToString()))
                NumFreeStorage.Text = ds.Tables[0].Rows[0]["FreeStorage"].ToString();
            txtPickUp.Text = ds.Tables[0].Rows[0]["PickUp"].ToString();

            txtRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();

            if (Convert.ToBoolean(ds.Tables[0].Rows[0]["active"]))
            {
                img_void.Style.Add("display", "none");
            }
            else
            {
                img_void.Style.Add("display", "inline");
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnNext.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
            }

            GridPanelInvoice.GetStore().DataSource = ds.Tables[1];
            GridPanelInvoice.GetStore().DataBind();

            

            GridPanelForeign.GetStore().DataSource = ds.Tables[3];
            GridPanelForeign.GetStore().DataBind();

            GridPanelRoute.GetStore().DataSource = ds.Tables[4];
            GridPanelRoute.GetStore().DataBind();

            GridPanelContact.GetStore().DataSource = ds.Tables[5];
            GridPanelContact.GetStore().DataBind();

            ControlBinder.pageTitleMsg(false, "AI-H:" + labLotNo.Text, "<p>Status :  Edit  HAWB of  <span>" + labLotNo.Text + "</span></p>", div_bottom);
        }
        else
        {
            labMAWB.Text = ds.Tables[0].Rows[0]["MAWB"].ToString();
            labLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();
            CmbReceipt.setValue(ds.Tables[0].Rows[0]["Receipt"].ToString());
            CmbFinalDest.setValue(ds.Tables[0].Rows[0]["FinalDest"].ToString());
            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Shipper"].ToString());
            CmbConsignee.setValue(ds.Tables[0].Rows[0]["Consignee"].ToString());
            CmbCoLoader.setValue(ds.Tables[0].Rows[0]["Coloader"].ToString());
            CmbBroker.setValue(ds.Tables[0].Rows[0]["Broker"].ToString());
            CmbSalesman.setValue(ds.Tables[0].Rows[0]["Salesman"].ToString());
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
                txtGWT.Text = ds.Tables[0].Rows[0]["GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["VWT"].ToString()))
                txtVWT.Text = ds.Tables[0].Rows[0]["VWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CWT"].ToString()))
                txtCWT.Text = ds.Tables[0].Rows[0]["CWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Piece"].ToString()))
                txtPiece.Text = ds.Tables[0].Rows[0]["Piece"].ToString();
            CmbUnit.setValue(ds.Tables[0].Rows[0]["Unit"].ToString());
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Pallet"].ToString()))
                txtPallet.Text = ds.Tables[0].Rows[0]["Pallet"].ToString();
            ControlBinder.pageTitleMsg(false, "AI-H New", "<p>Status :  New Blank  Hawb </p>", div_bottom);
        }
        

    }
    #endregion

    #region   ClearControls()    Author ：Hcy   (2011-09-09)
    private void ClearControls()
    {
        txtHawb.Text = "";
        txtReference.Text = "";
        txtClearance.Text = "";
        chkInsurance.Checked = false;

        CmbReceipt.setValue("");
        CmbFinalDest.setValue("");
        CmbSalesman.setValue("");
        chkDG.Checked = false;
        chkSurrender.Checked = false;

        CmbShipperCode.Value = "";
        //CmbShipperName.SelectedItem.Value = "";
        CmbConsignee.Value = "";
        //CmbConsigneeName.SelectedItem.Value = "";

        CmbNotify1.Value = "";
        //CmbNotify1Name.SelectedItem.Value = "";
        CmbNotify2.Value = "";
        //CmbNotify2Name.SelectedItem.Value = "";

        CmbCoLoader.Value = "";
        //CmbCoLoaderName.SelectedItem.Value = "";
        CmbBroker.Value = "";
        //CmbBrokerName.SelectedItem.Value = "";

        txtGWT.Text = "";
        txtVWT.Text = "";
        txtCWT.Text = "";
        txtPiece.Text = "";
        CmbUnit.setValue("");
        txtPallet.Text = "";

        CmbWarehouse.setValue("");
        //CmbWarehouseName.SelectedItem.Value = "";
        txtFreeStorageStart.Text = "";
        txtFreeStorageEnd.Text = "";
        //CmbFreeStorage.SelectedItem.Value = "";
        txtPickUp.Text = "";

        //CmbCompany.setValue("");
        //CmbCompanyName.Text = "";
        //CmbCurrency.Text = "";

        txtRemark.Text = "";
    }
    #endregion

    #region    btnCancel_Click()     Author：Hcy   (2011-09-09)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        DataBindList();
        X.AddScript("BindingCost();");
    }
    #endregion

    #region    btnVoid_Click()     Author：Hcy   (2011-09-09)
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

        if (!VoidCheckAC.CheckisAC("AI", hidSeed.Text))
        {
            X.MessageBox.Alert("Status", VoidCheckAC.Message).Show();
            return;
        }

        if (seedid.Length > 1)
        {
            string voidflag = hidVoid.Text == "0" ? "Y1" : "N1";
            DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "A").Append("Type", "HAWB").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text==""?null:hidSeed.Text)}).GetList();
            if (l != null && l.Tables[0].Rows[0][0].ToString() == "Y")
            {
                X.AddScript("$('#img_void').css('display','inline');");
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnNext.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
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
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "S")
            {
                X.Msg.Alert("Information", "HAWB can't be active,because MAWB is void.").Show();
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "AI-H:" + labLotNo.Text, "<p class=\"error\">Status :  Save failed, please check the data . </p>", div_bottom);
            }

            DataBindList();
            ControlBinder.pageTitleMsg(true, "AI-H:" + labLotNo.Text, "<p>Status :  Edit  HAWB of  <span>" + labLotNo.Text + "</span></p>", div_bottom);
        }
    }

    #region    btnSave_Click()     Author：Hcy   (2011-09-09)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        if (string.IsNullOrEmpty(txtHawb.Text))
        {
            div_bottom.Html = "<p class='error'> Save failed, HAWB can't be empty  ! ! !</p>";
            txtHawb.Focus(true);
            return;
        }

        List<IFields> UpdateHAWB = new List<IFields>();
        UpdateHAWB.Add(dal.CreateIFields().Append("Option", "UpdateHAWB")
            .Append("air_Seed", hidSeed.Text)
            .Append("air_ToMAWB", hidMAWB.Text)
            .Append("air_LotNo", "")

            .Append("air_HAWB", txtHawb.Text.Trim().ToUpper())
            .Append("air_CompanyReferance", txtReference.Text.Trim().ToUpper())
            .Append("imp_Clearance", txtClearance.Text.Trim().ToUpper())
            .Append("air_Insurance", chkInsurance.Checked)

            .Append("air_LocReceived", CmbReceipt.Value)
            .Append("air_LocFinal", CmbFinalDest.Value)
            .Append("air_Sales", CmbSalesman.Value)
            .Append("air_DG", chkDG.Checked)
            .Append("imp_Surrender", chkSurrender.Checked)

            .Append("air_Shipper", CmbShipperCode.Value)
            //.Append("air_Shipper", CmbShipperName.SelectedItem.Value)
            .Append("air_Consignee", CmbConsignee.Value)
            //.Append("air_Consignee", CmbConsigneeName.SelectedItem.Value)

            .Append("air_PartyA", CmbNotify1.Value)
            //.Append("air_PartyA", CmbNotify1Name.SelectedItem.Value)
            .Append("air_PartyB", CmbNotify2.Value)
            //.Append("air_PartyB", CmbNotify2Name.SelectedItem.Value)

            .Append("air_CoLoader", CmbCoLoader.Value)
            //.Append("air_CoLoader", CmbCoLoaderName.SelectedItem.Value)
            .Append("air_Broker", CmbBroker.Value)
            //.Append("air_Broker", CmbBrokerName.SelectedItem.Value)

            .Append("air_GWT", string.IsNullOrEmpty(txtGWT.Text) ? DBNull.Value : (object)txtGWT.Text)
            .Append("air_VWT", string.IsNullOrEmpty(txtVWT.Text) ? DBNull.Value : (object)txtVWT.Text)
            .Append("air_CWT", string.IsNullOrEmpty(txtCWT.Text) ? DBNull.Value : (object)txtCWT.Text)
            .Append("air_Piece", string.IsNullOrEmpty(txtPiece.Text) ? DBNull.Value : (object)txtPiece.Text)
            .Append("air_Unit", CmbUnit.Value)
            .Append("air_Pallet", string.IsNullOrEmpty(txtPallet.Text) ? DBNull.Value : (object)txtPallet.Text)

            .Append("imp_Warehouse", CmbWarehouse.Value)
            //.Append("imp_Warehouse", CmbWarehouseName.SelectedItem.Value)
            .Append("imp_StorageFrom", ControlBinder.getDate(txtFreeStorageStart.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtFreeStorageStart.RawText))
            .Append("imp_StorageTo", ControlBinder.getDate(txtFreeStorageEnd.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtFreeStorageEnd.RawText))
            .Append("imp_FreeDays", NumFreeStorage.Text.Trim().ToUpper().StartsWith("-1") ? DBNull.Value : (object)NumFreeStorage.Text)
            .Append("imp_PickupDate", ControlBinder.getDate(txtPickUp.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtPickUp.RawText))

            .Append("air_Remark", txtRemark.Text.Trim())
            .Append("code", FSecurityHelper.CurrentUserDataGET()[4].ToString() + SYS)
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("air_SYS", SYS)//FSecurityHelper.CurrentUserDataGET()[11].ToString()[0])
            .Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            );
        try
        {
            DataSet ds = GetDs("FW_AirImport_Joblist_SP", UpdateHAWB);
            hidSeed.Text = ds.Tables[0].Rows[0][0].ToString();
            string newFlag = ds.Tables[0].Rows[0][1].ToString();


            #region LocalCosting
            //X.AddScript("saveCost('" + hidSeed.Text + "');");

            ucCost.costseed = hidSeed.Text;
            ucCost.btnCostEvent(sender, e);
            #endregion

            #region ForeignInvoice
            var ForeignInvoice = JSON.Deserialize<List<ForeignInvoice>>(e.ExtraParams["p_safety_2"]);
            List<IFields> ForeignInvoicelist = new List<IFields>();
            string ForeignInvoiceID = "";
            for (int i = 0; i < ForeignInvoice.Count; ++i)
            {
                ForeignInvoicelist.Add(dal.CreateIFields().Append("Option", "Update").
                Append("inv_Payment", ForeignInvoice[i].Kind.Trim().ToUpper()).
                Append("inv_InvoiceDate", ControlBinder.getDate(ForeignInvoice[i].Date.ToString().StartsWith("0001") ? DBNull.Value : (object)ForeignInvoice[i].Date)).
                Append("inv_InvoiceNo", ForeignInvoice[i].DN_CNNO.Trim().ToUpper()).
                Append("inv_CompanyCode", ForeignInvoice[i].CompanyCode.Trim().ToUpper()).
                Append("inv_CompanyName", ForeignInvoice[i].CompanyName.ToUpper()).
                Append("inv_Currency", ForeignInvoice[i].Currency.Trim().ToUpper()).
                Append("inv_Total", string.IsNullOrEmpty(ForeignInvoice[i].Amount) ? DBNull.Value : (object)ForeignInvoice[i].Amount).
                Append("inv_RowID", ForeignInvoice[i].RowID)
                .Append("inv_ToHouse", hidSeed.Text)
                .Append("inv_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("inv_Sys", SYS)
                .Append("inv_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                );
                ForeignInvoiceID += "," + ForeignInvoice[i].RowID;
            }
            //delete
            if (ForeignInvoiceID.Length > 1)
            {
                ForeignInvoiceID = ForeignInvoiceID.Substring(1, ForeignInvoiceID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("inv_Seed", hidSeed.Text).Append("str", ForeignInvoiceID) }).Update();
            bool resultForeignInvoice = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", ForeignInvoicelist).Update();
            #endregion

            #region LocalDeliveryRoute
            var LocalDeliveryRoute = JSON.Deserialize<List<LocalDeliveryRoute>>(e.ExtraParams["p_safety_3"]);
            List<IFields> LocalDeliveryRoutelist = new List<IFields>();
            string LocalDeliveryRouteID = "";
            for (int i = 0; i < LocalDeliveryRoute.Count; ++i)
            {
                LocalDeliveryRoutelist.Add(dal.CreateIFields().Append("Option", "Update").
                Append("sr_ShipKind", LocalDeliveryRoute[i].Kind.Trim().ToUpper()).
                Append("sr_Carrier", LocalDeliveryRoute[i].CompanyCode.Trim().ToUpper()).
                    //Append("sr_Carrier", LocalDeliveryRoute[i].CompanyName).
                Append("sr_To", LocalDeliveryRoute[i].Dest.Trim().ToUpper()).
                Append("sr_Voyage", LocalDeliveryRoute[i].Voyage.Trim().ToUpper()).
                Append("sr_ETD", ControlBinder.getDate(LocalDeliveryRoute[i].ETD.ToString().StartsWith("0001") ? DBNull.Value : (object)LocalDeliveryRoute[i].ETD)).
                Append("sr_ETA", ControlBinder.getDate(LocalDeliveryRoute[i].ETA.ToString().StartsWith("0001") ? DBNull.Value : (object)LocalDeliveryRoute[i].ETA)).
                Append("sr_RowID", LocalDeliveryRoute[i].RowID)
                .Append("sr_ToHouse", hidSeed.Text)
                .Append("sr_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("sr_Sys", SYS)
                .Append("sr_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                );
                LocalDeliveryRouteID += "," + LocalDeliveryRoute[i].RowID;
            }
            //delete
            if (LocalDeliveryRouteID.Length > 1)
            {
                LocalDeliveryRouteID = LocalDeliveryRouteID.Substring(1, LocalDeliveryRouteID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_ShipmentRoute_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("sr_Seed", hidSeed.Text).Append("str", LocalDeliveryRouteID) }).Update();
            bool resultLocalDeliveryRoute = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_ShipmentRoute_SP", LocalDeliveryRoutelist).Update();
            #endregion

            #region ContactInformation
            var ContactInformation = JSON.Deserialize<List<ContactInformation>>(e.ExtraParams["p_safety_4"]);
            List<IFields> ContactInformationlist = new List<IFields>();
            string ContactinformationID = "";
            for (int i = 0; i < ContactInformation.Count; ++i)
            {
                ContactInformationlist.Add(dal.CreateIFields().Append("Option", "Update").
                Append("sc_Type", ContactInformation[i].Kind.Trim().ToUpper()).
                Append("sc_Company", ContactInformation[i].CompanyCode.Trim().ToUpper()).
                    //Append("sc_Company", ContactInformation[i].CompanyName).
                Append("sc_Dept", ContactInformation[i].Dept.Trim().ToUpper()).
                Append("sc_RowID", ContactInformation[i].RowID)
                .Append("sc_ToHouse", hidSeed.Text)
                .Append("sc_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("sc_Sys", SYS)
                .Append("sc_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                );
                ContactinformationID += "," + ContactInformation[i].RowID;
            }
            //delete
            if (ContactinformationID.Length > 1)
            {
                ContactinformationID = ContactinformationID.Substring(1, ContactinformationID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_ShipmentContact_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("sc_Seed", hidSeed.Text).Append("str", ContactinformationID) }).Update();
            bool resultContactInformation = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_ShipmentContact_SP", ContactInformationlist).Update();
            #endregion

            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "AI", "HAWB");
            if (newFlag == "N")
            {
                ControlBinder.pageTitleMsg(true, "AI-H:" + labLotNo.Text, "<p class=\"success\">Status :   Saved successfully  ! ! ! </p>", div_bottom);
            }
            else
            {
                X.Redirect("hawb.aspx?seed=" + ds.Tables[0].Rows[0][0] + "&MAWB=" + hidMAWB.Value);
            }
            
            ControlBinder.pageTitleMsg(true, "AI-H:" + labLotNo.Text, "<p class=\"success\">Status :   Saved successfully  ! ! ! </p>", div_bottom);
        }
        catch
        {
            ControlBinder.pageTitleMsg(false, "AI-H:" + labLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data .</p>", div_bottom);
        }


    }
    #endregion

    #region    btnNext_Click()     Author：Hcy   (2011-09-09)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        btnSave_Click(sender, e);
        //hidSeed.Text = "0";
        //ClearControls();
        Response.Redirect("hawb.aspx?MAWB=" + hidMAWB.Value);
    }
    #endregion

    ///// <summary>
    ///// 添加Invoice
    ///// </summary>
    #region    btnAddNewInvoice_Click(object,DirectEventArgs)    Author：Micro   (2011-09-14)
    //protected void btnAddNewInvoice_Click(object sender, DirectEventArgs e)
    //{
    //    if (string.IsNullOrEmpty(Request["seed"]))
    //    {
    //        X.Msg.Alert("Status", "Please save the data !").Show();
    //        return;
    //    }
    //    //if (string.IsNullOrEmpty(CmbCompany.Text) || string.IsNullOrEmpty(CmbCurrency.Text))
    //    //{
    //    //    X.Msg.Alert("Stauts", " Input can't for empty ! ! ! ", new JFunction { Handler = "Ext.get('CmbCompanyRightCode').focus()" }).Show();
    //    //    return;
    //    //}
    //    //string url = "invoice.aspx?sys=AI&H=" + Request["seed"] + "&Company=" + CmbCompany.Value + "&Currency=" + CmbCurrency.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
    //    //X.Js.AddScript("window.open('" + url + "','_blank')");
    //}

    /// <summary>
    /// 选择是否本地货币
    /// </summary>    
    //protected void CmbCurrencyRight_Select(object sender, DirectEventArgs e)
    //{
    //    DataTable ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
    //            Append("Option", "Currency").
    //            Append("inv_Stat", FSecurityHelper.CurrentUserDataGET()[12]).
    //            Append("cur_code",CmbCurrency.Text).
    //            Append("inv_Sys",FSecurityHelper.CurrentUserDataGET()[11][0]) }).GetTable();
    //    if (ds != null && ds.Rows.Count > 0)
    //    {
    //        radForeign.Checked = Convert.ToBoolean(ds.Rows[0][0]);
    //        radLocal.Checked = Convert.ToBoolean(ds.Rows[0][1]);
    //        txtcur_Rate.Text = ds.Rows[0][2].ToString();
    //    }
    //}


    #endregion

    public void txtFreeStoregeStart_Blur(object sender, DirectEventArgs e)
    {
        string freeStoreage = ControlBinder.getDate(txtFreeStorageStart.RawText).ToString();
        string end = ControlBinder.getDate(txtFreeStorageEnd.RawText).ToString();
        //X.Msg.Alert("Title", freeStoreage).Show();
        if (string.IsNullOrEmpty(end))
        {
            if (!string.IsNullOrEmpty(freeStoreage))
            {
                DateTime dt = Convert.ToDateTime(freeStoreage);
                dt = dt.AddDays(2);
                txtFreeStorageEnd.Text = dt.ToString("yyyy-MM-d");
            }
        }
    }


    #region ForeignInvoice
    class ForeignInvoice
    {
        public int RowID
        { get; set; }
        public string Kind
        { get; set; }
        public string Date
        { get; set; }
        public string DN_CNNO
        { get; set; }
        public string CompanyCode
        { get; set; }
        public string CompanyName
        { get; set; }
        public string Currency
        { get; set; }
        public string Amount
        { get; set; }
    }
    #endregion

    #region LocalDeliveryRoute
    class LocalDeliveryRoute
    {
        public int RowID
        { get; set; }
        public string Kind
        { get; set; }
        public string CompanyCode
        { get; set; }
        public string CompanyName
        { get; set; }
        public string Dest
        { get; set; }
        public string Voyage
        { get; set; }
        public string ETD
        { get; set; }
        public string ETA
        { get; set; }
    }
    #endregion

    #region ContactInformation
    class ContactInformation
    {
        public int RowID
        { get; set; }
        public string Kind
        { get; set; }
        public string CompanyCode
        { get; set; }
        public string CompanyName
        { get; set; }
        public string Dept
        { get; set; }
    }
    #endregion
}
