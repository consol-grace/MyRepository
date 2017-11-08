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

public partial class OceanImport_OceanShipmentJobList_OceanShipmentHouse : System.Web.UI.Page
{

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                cur = ControlBinder.getCurrency("f", SYS);
                ComboBoxBinding();
                DataBindList();
                FI_Currency.Text = cur;
                LockControl();
                //X.AddScript("showCompanyRemark('CmbShipperCode,CmbConsignee,CmbNotify1,CmbNotify2,CmbBroker', 'Shipper,Consignee,Notify #1,Notify #2,Broker');");
            }
        }
    }

    public string cur = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "-1" : Request["seed"];
            hidMAWB.Text = Request["MBL"] == null ? "-1" : Request["MBL"];
            ControlBinder.DateFormat(txtFreeStorageStart);
            ControlBinder.DateFormat(txtFreeStorageEnd);
            ControlBinder.DateFormat(txtPickUp);
            ControlBinder.DateFormat(FI_Date);
            ControlBinder.DateFormat(r_ETD);
            ControlBinder.DateFormat(r_ETA);

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
            X.AddScript("$('#showContainer').hide();");
        }
        else
        {
            if (hidSeed.Text.Length > 2)
            {
                X.AddScript("TransferVoid();");
            }
        }
    }
  

    DataFactory dal = new DataFactory();
    readonly string SYS = "OI";

    public void storeInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBindList();
    }

    #region /// 刷新数据源
    public void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", SYS[0].ToString());
    }
    public void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", SYS[0].ToString());
    }
    public void StoreUnit_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", SYS[0].ToString());
    }
    public void StoreServiceMode_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreServiceMode, "ServerMode", SYS[0].ToString());
    }
    public void StoreItem_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","O") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();
    }
    public void StoreKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreKind, "QtyKindBinding", SYS[0].ToString());
    }
    public void StoreForeignKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreForeignKind, "ForeignKind", SYS[0].ToString());
    }
    public void StoreShipKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreShipKind, "ShipKind", SYS[0].ToString());
    }
    public void StoreCompanyKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCompanyKind, "CompanyKind", SYS[0].ToString());
    }
    public void StoreCurrInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", SYS[0].ToString());
    }
    public void StoreDept_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreDept, "DeptBinding", SYS[0].ToString());
    }
    #endregion




    #region   ComboBoxBinding()    Author ：Hcy   (2011-09-27)
    private void ComboBoxBinding()
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", SYS[0].ToString());
        //ControlBinder.CmbBinder(StoreCompany, "CompanyList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", SYS[0].ToString());
        
        o_unit.Template.Html = Template.Html;
        //ControlBinder.CmbBinder(StoreCurrency, "CurrencysList", SYS[0].ToString());
        //ControlBinder.CmbBinder(StoreItem, "ItemBinding", SYS[0].ToString());
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","O") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

        //l_item.Template.Html = Template.Html;
        //o_item.Template.Html = Template.Html;
        ControlBinder.CmbBinder(StoreKind, "QtyKindBinding", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreDept, "DeptBinding", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreForeignKind, "ForeignKind", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreShipKind, "ShipKind", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreCompanyKind, "CompanyKind", SYS[0].ToString());
        ControlBinder.CmbBinder(StorePPCC, "PPCCList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreServiceMode, "ServerMode", SYS[0].ToString());
        //ControlBinder.CmbBinder(StoreCurrLocal, "CurrencysListLocal", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", SYS[0].ToString());
    }
    #endregion

    #region Template
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
    #endregion

    #region   DataBinding()    Author ：Hcy   (2011-09-27)
    private void DataBindList()
    {
        CmbUnit.setValue("PKG");
        
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "List")
            .Append("seed", hidSeed.Text)
            .Append("o_ToMBL", Request["MBL"])
            .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS", SYS)
            );
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_HBL_SP", Getlist).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            

            txtHawb.Text = ds.Tables[0].Rows[0]["HBL"].ToString();
            CmbService.setValue(ds.Tables[0].Rows[0]["ServiceMode"]);
            CmbPPD.SelectedItem.Value = ds.Tables[0].Rows[0]["PPD"].ToString();
            CmbSalesman.setValue(ds.Tables[0].Rows[0]["Salesman"]);
            labImpLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();
            txtColoader.Text = ds.Tables[0].Rows[0]["ColoaderHBL"].ToString();
            txtReference.Text = ds.Tables[0].Rows[0]["Reference"].ToString();
            txtClearance.Text = ds.Tables[0].Rows[0]["Clearance"].ToString();
            txtDO.Text = ds.Tables[0].Rows[0]["DO"].ToString();

            labMBL.Text = ds.Tables[0].Rows[0]["MBL"].ToString();

            CmbReceipt.setValue(ds.Tables[0].Rows[0]["Receipt"]);
            CmbFinalDest.setValue(ds.Tables[0].Rows[0]["FinalDest"].ToString());
            chkInsurance.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Insurance"]);
            chkDG.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DG"]);
            chkSurrender.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Surrender"]);

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
            //if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
            //    txtGWT.Text = ds.Tables[0].Rows[0]["GWT"].ToString();
            //if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CWT"].ToString()))
            //    txtCWT.Text = ds.Tables[0].Rows[0]["CWT"].ToString();
            //if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CBM"].ToString()))
            //    txtCBM.Text = ds.Tables[0].Rows[0]["CBM"].ToString();
            //if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Piece"].ToString()))
            //    txtPiece.Text = ds.Tables[0].Rows[0]["Piece"].ToString();

            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
                txtGWT.Text = ds.Tables[0].Rows[0]["GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["AWT"].ToString()))
                txtAGWT.Text = ds.Tables[0].Rows[0]["AWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CBM"].ToString()))
                txtCBM.Text = ds.Tables[0].Rows[0]["CBM"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["ACBM"].ToString()))
                txtACBM.Text = ds.Tables[0].Rows[0]["ACBM"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["PKGS"].ToString()))
                txtPiece.Text = ds.Tables[0].Rows[0]["PKGS"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["APKGS"].ToString()))
                txtAPiece.Text = ds.Tables[0].Rows[0]["APKGS"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["WM"].ToString()))
                txtCWT.Text = ds.Tables[0].Rows[0]["WM"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["AWM"].ToString()))
                txtAWM.Text = ds.Tables[0].Rows[0]["AWM"].ToString();

            CmbUnit.setValue(ds.Tables[0].Rows[0]["Unit"].ToString());
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Container"].ToString()))
                txtContainer.Text = ds.Tables[0].Rows[0]["Container"].ToString();

            CmbWarehouse.setValue(ds.Tables[0].Rows[0]["Warehouse"].ToString());
            CmbWarehouse.Text = ds.Tables[0].Rows[0]["WarehouseName"].ToString();
            txtFreeStorageStart.Text = ds.Tables[0].Rows[0]["FreeStorageStart"].ToString();
            txtFreeStorageEnd.Text = ds.Tables[0].Rows[0]["FreeStorageEnd"].ToString();
            txtPickUp.Text = ds.Tables[0].Rows[0]["PickUp"].ToString();

            txtRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();

            GridPanelInvoice.GetStore().DataSource = ds.Tables[1];
            GridPanelInvoice.GetStore().DataBind();

            GridPanelContainer.GetStore().DataSource = ds.Tables[2];
            GridPanelContainer.GetStore().DataBind();
            if (ds.Tables[2].Rows.Count > 0)
            {
                double GWT = 0.000, Pieces = 0, CBM = 0.000, wm = 0.000;
                for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                {
                    GWT += Convert.ToDouble(ds.Tables[2].Rows[i]["GWT"].ToString() == "" ? "0.000" : ds.Tables[2].Rows[i]["GWT"].ToString());
                    Pieces += Convert.ToDouble(ds.Tables[2].Rows[i]["PKGS"].ToString() == "" ? "0" : ds.Tables[2].Rows[i]["PKGS"].ToString());
                    CBM += Convert.ToDouble(ds.Tables[2].Rows[i]["CBM"].ToString() == "" ? "0.000" : ds.Tables[2].Rows[i]["CBM"].ToString());
                    wm += Convert.ToDouble(ds.Tables[2].Rows[i]["WM"].ToString() == "" ? "0.000" : ds.Tables[2].Rows[i]["WM"].ToString());
                }
                if (Pieces.ToString() != "0") { txtAPiece.Text = Pieces.ToString(); }
                if (GWT.ToString() != "0") { txtAGWT.Text = GWT.ToString(); }
                if (CBM.ToString() != "0") { txtACBM.Text = CBM.ToString(); }
                if (wm.ToString() != "0") { txtAWM.Text = wm.ToString(); }
            }
            
            if (Convert.ToBoolean(ds.Tables[0].Rows[0]["active"]))
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
                X.AddScript("$('#showContainer').hide();");
            }
            
            GridPanelOther.GetStore().DataSource = ds.Tables[3];
            GridPanelOther.GetStore().DataBind();

            

            GridPanelForeign.GetStore().DataSource = ds.Tables[5];
            GridPanelForeign.GetStore().DataBind();

            GridPanelRoute.GetStore().DataSource = ds.Tables[6];
            GridPanelRoute.GetStore().DataBind();

            GridPanelContact.GetStore().DataSource = ds.Tables[7];
            GridPanelContact.GetStore().DataBind();

        }

        if (!string.IsNullOrEmpty(Request["seed"]))
            ControlBinder.pageTitleMsg(false, "OI-H:" + labImpLotNo.Text, "<p>Status : Edit HBL of  <span>" + labImpLotNo.Text + "</span>. </p>", div_bottom);
        else
        {
            ControlBinder.pageTitleMsg(false, "OI-H New", "<p>Status : New Blank HBL . </p>", div_bottom);
        }
        
        txtHawb.Focus(true);


    }
    #endregion

    #region   ClearControls()    Author ：Hcy   (2011-09-27)
    private void ClearControls()
    {
        txtHawb.Text = "";
        CmbService.setValue("");
        CmbPPD.SelectedItem.Value = "";
        CmbSalesman.setValue("");

        txtColoader.Text = "";
        txtReference.Text = "";
        txtClearance.Text = "";
        txtDO.Text = "";

        CmbReceipt.setValue("");
        CmbFinalDest.setValue("");
        chkInsurance.Checked = false;
        chkDG.Checked = false;
        chkSurrender.Checked = false;

        CmbShipperCode.setValue("");
        //CmbShipperName.SelectedItem.Value = "";
        CmbConsignee.setValue("");
        //CmbConsigneeName.SelectedItem.Value = "";

        CmbNotify1.setValue("");
        //mbNotify1Name.SelectedItem.Value = "";
        CmbNotify2.setValue("");
        //CmbNotify2Name.SelectedItem.Value = "";

        CmbCoLoader.setValue("");
        //CmbCoLoaderName.SelectedItem.Value = "";
        CmbBroker.setValue("");
        //CmbBrokerName.SelectedItem.Value = "";

        txtGWT.Text = "";
        txtCWT.Text = "";
        txtCBM.Text = "";
        txtPiece.Text = "";
        CmbUnit.setValue("");
        txtContainer.Text = "";

        CmbWarehouse.setValue("");
        //CmbWarehouseName.SelectedItem.Value = "";
        txtFreeStorageStart.Text = "";
        txtFreeStorageEnd.Text = "";
        txtPickUp.Text = "";

        //CmbCompany.Text = "";
        // CmbCompanyName.Text = "";
        //CmbCurrency.Text = "";

        txtRemark.Text = "";
    }
    #endregion

    #region    btnCancel_Click()     Author：Hcy   (2011-09-27)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        DataBindList();
        X.AddScript("BindingCost();");
    }
    #endregion

    #region    btnVoid_Click()     Author：Hcy   (2011-09-27)
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

        if (!VoidCheckAC.CheckisAC("OI", hidSeed.Text))
        {
            X.MessageBox.Alert("Status", VoidCheckAC.Message).Show();
            return;
        }


        if (seedid.Length > 1)
        {
            string voidflag = hidVoid.Text == "0" ? "Y" : "N";
            DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "O").Append("Type", "HBL").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text==""?null:hidSeed.Text)}).GetList();
            if (l != null && l.Tables[0].Rows[0][0].ToString() == "Y")
            {
                X.AddScript("$('#img_void').css('display','inline');");
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnNext.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                X.AddScript("$('#showContainer').hide();");
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "N")
            {
                X.AddScript("$('#img_void').css('display','none');");
                btnSave.Disabled = false;
                btnCancel.Disabled = false;
                btnNext.Disabled = false;
                btnVoid.Text = "Void";
                hidVoid.Text = "0";
                X.AddScript("$('#showContainer').show();");
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "S")
            {
                X.Msg.Alert("Information", "HBL can't be active,because MBL is void.").Show();
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "OI-H:" + labImpLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
            }
            
            DataBindList();
            ControlBinder.pageTitleMsg(true, "OI-H:" + labImpLotNo.Text, "<p>Status : Edit HBL of  <span>" + labImpLotNo.Text + "</span>. </p>", div_bottom);
        }
    }

    #region    btnSave_Click()     Author：Hcy   (2011-09-09)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        if (hidMAWB.Text == "-1")
        {
            ControlBinder.pageTitleMsg(false, "OI-H New", "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
            return;
        }
        if (string.IsNullOrEmpty(txtHawb.Text.Trim()))
        {
            div_bottom.Html = "<p class=\"error\">Status : Save failed, HBL  can't for empty . </p>";
            txtHawb.Focus(true);
            return;
        }

        List<IFields> UpdateHBL = new List<IFields>();
        UpdateHBL.Add(dal.CreateIFields().Append("Option", "UpdateHBL")
            .Append("Seed", hidSeed.Text)
            .Append("o_ToMBL", hidMAWB.Text)

            .Append("o_HBL", txtHawb.Text.Trim().ToUpper())
            .Append("o_ServiceMode", string.IsNullOrEmpty(CmbService.Value) ? null : CmbService.Value.Trim().ToUpper())
            .Append("o_PaymentMode", CmbPPD.SelectedItem.Value)
            .Append("o_Sales", CmbSalesman.Value)

            .Append("o_MBL", labMBL.Text.Trim().ToUpper())
            .Append("o_ColoaderHBL", txtColoader.Text.ToUpper())
            .Append("o_DONo", txtReference.Text.Trim().ToUpper())
            .Append("imp_Clearance", txtClearance.Text.Trim().ToUpper())
            .Append("o_DONo", txtDO.Text.Trim().ToUpper())

            .Append("o_LocReceipt", CmbReceipt.Value)
            .Append("o_LocFinal", CmbFinalDest.Value)
            .Append("o_Insurance", chkInsurance.Checked)
            .Append("o_DG", chkDG.Checked)
            .Append("imp_Surrender", chkSurrender.Checked)

            .Append("o_Shipper", CmbShipperCode.Value)
            //.Append("o_Shipper", CmbShipperName.SelectedItem.Value)
            .Append("o_Consignee", CmbConsignee.Value)
            //.Append("o_Consignee", CmbConsigneeName.SelectedItem.Value)

            .Append("o_PartyA", CmbNotify1.Value)
            //.Append("o_PartyA", CmbNotify1Name.SelectedItem.Value)
            .Append("o_PartyB", CmbNotify2.Value)
            //.Append("o_PartyB", CmbNotify2Name.SelectedItem.Value)

            .Append("o_CoLoader", CmbCoLoader.Value)
            //.Append("o_CoLoader", CmbCoLoaderName.SelectedItem.Value)
            .Append("o_Broker", CmbBroker.Value)
            //.Append("o_Broker", CmbBrokerName.SelectedItem.Value)

            //.Append("o_WT", string.IsNullOrEmpty(txtGWT.Text) ? DBNull.Value : (object)txtGWT.Text)
            //.Append("o_CWT", string.IsNullOrEmpty(txtCWT.Text) ? DBNull.Value : (object)txtCWT.Text)
            //.Append("o_CBM", string.IsNullOrEmpty(txtCBM.Text) ? DBNull.Value : (object)txtCBM.Text)
            //.Append("o_PKGS", string.IsNullOrEmpty(txtPiece.Text) ? DBNull.Value : (object)txtPiece.Text)

            .Append("o_CWT", string.IsNullOrEmpty(txtGWT.Text) ? DBNull.Value : (object)txtGWT.Text)
            .Append("o_AWT", string.IsNullOrEmpty(txtAGWT.Text) ? DBNull.Value : (object)txtAGWT.Text)
            .Append("o_CCBM", string.IsNullOrEmpty(txtCBM.Text) ? DBNull.Value : (object)txtCBM.Text)
            .Append("o_ACBM", string.IsNullOrEmpty(txtACBM.Text) ? DBNull.Value : (object)txtACBM.Text)
            .Append("o_CPKGS", string.IsNullOrEmpty(txtPiece.Text) ? DBNull.Value : (object)txtPiece.Text)
            .Append("o_APKGS", string.IsNullOrEmpty(txtAPiece.Text) ? DBNull.Value : (object)txtAPiece.Text)
            .Append("o_CWM", string.IsNullOrEmpty(txtCWT.Text) ? DBNull.Value : (object)txtCWT.Text)
            .Append("o_AWM", string.IsNullOrEmpty(txtAWM.Text) ? DBNull.Value : (object)txtAWM.Text)



            .Append("o_Unit", CmbUnit.Value)
            .Append("o_CarrierATTN", string.IsNullOrEmpty(txtContainer.Text) ? DBNull.Value : (object)txtContainer.Text)

            .Append("imp_Warehouse", CmbWarehouse.Value)
            //.Append("imp_Warehouse", CmbWarehouseName.SelectedItem.Value)
            .Append("imp_StorageFrom", ControlBinder.getDate(txtFreeStorageStart.RawText.StartsWith("0001") ? DBNull.Value : (object)txtFreeStorageStart.RawText))
            .Append("imp_StorageTo", ControlBinder.getDate(txtFreeStorageEnd.RawText.StartsWith("0001") ? DBNull.Value : (object)txtFreeStorageEnd.RawText))
            .Append("imp_PickupDate", ControlBinder.getDate(txtPickUp.RawText.StartsWith("0001") ? DBNull.Value : (object)txtPickUp.RawText))

            .Append("o_Remark", txtRemark.Text.Trim())

            .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("SYS", SYS)
            .Append("code", FSecurityHelper.CurrentUserDataGET()[4].ToString() + SYS)
            .Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            );
       
            #region ///Container
            //var Container = JSON.Deserialize<List<gridContainer>>(e.ExtraParams["p_safety_6"]);
            //string conRowID = "";
            //for (int i = 0; i < Container.Count; ++i)
            //{
            //    conRowID += "," + Container[i].RowID;
            //}
            //if (conRowID.Length > 1)
            //{
            //    conRowID = conRowID.Substring(1, conRowID.Length - 1);
            //}
            //dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Container_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("oc_Seed", hidSeed.Text).Append("IDList", conRowID) }).Update();
            #endregion

            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_HBL_SP", UpdateHBL).GetList();
            hidSeed.Text = ds.Tables[0].Rows[0][0].ToString();
            string newFlag = ds.Tables[0].Rows[0][1].ToString();
            
            #region /// Local Invoice
            //var localInvoice = JSON.Deserialize<List<gridContainer>>(e.ExtraParams["p_safety_7"]);
            //string invRowID = "";
            //for (int i = 0; i < localInvoice.Count; ++i)
            //{
            //    invRowID += "," + localInvoice[i].RowID;
            //}
            //if (invRowID.Length > 1)
            //{
            //    invRowID = invRowID.Substring(1, invRowID.Length - 1);
            //}
            //dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Invoice_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualLocal").Append("inv_Seed", hidSeed.Text).Append("str", invRowID) }).Update();

            #endregion
            
            #region Other
            var Other = JSON.Deserialize<List<Other>>(e.ExtraParams["p_safety_l"]);
            List<IFields> Otherlist = new List<IFields>();
            string OtherID = "";
            for (int i = 0; i < Other.Count; ++i)
            {
                Otherlist.Add(dal.CreateIFields().Append("Option", "UpdateOther").
                Append("si_PPCC", Other[i].PPD).
                Append("si_BillTo", Other[i].CompanyCode.ToUpper()).
                    //Append("si_BillTo", Other[i].CompanyName).
                Append("si_Total", string.IsNullOrEmpty(Other[i].Total) ? DBNull.Value : (object)Other[i].Total).
                Append("si_Item", Other[i].Item.Trim().ToUpper()).
                Append("si_Description", Other[i].Description.Trim().ToUpper()).
                Append("si_QtyKind", Other[i].CalcKind.Trim().ToUpper()).
                Append("si_Quantity", string.IsNullOrEmpty(Other[i].Qty) ? DBNull.Value : (object)Other[i].Qty).
                Append("si_Unit", Other[i].Unit.ToUpper()).
                Append("si_Currency", Other[i].Currency.ToUpper()).
                Append("si_ExRate", string.IsNullOrEmpty(Other[i].EX) ? DBNull.Value : (object)Other[i].EX).
                Append("si_Rate", string.IsNullOrEmpty(Other[i].Rate) ? DBNull.Value : (object)Other[i].Rate).
                Append("si_Amount", string.IsNullOrEmpty(Other[i].Amount) ? DBNull.Value : (object)Other[i].Amount).
                Append("si_Percent", string.IsNullOrEmpty(Other[i].Percent) ? DBNull.Value : (object)Other[i].Percent).
                Append("si_ShowIn", Other[i].Show.ToUpper()).
                Append("si_ROWID", Other[i].RowID)
                .Append("si_ToHouse", hidSeed.Text)
                .Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("si_Sys", SYS)
                .Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                );
                OtherID += "," + Other[i].RowID;
            }
            //delete
            if (OtherID.Length > 1)
            {
                OtherID = OtherID.Substring(1, OtherID.Length - 1); 
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_ShipmentItem_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("si_Seed", hidSeed.Text).Append("si_Type", "OTHER").Append("str", OtherID) }).Update();

            bool resultOther = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_ShipmentItem_SP", Otherlist).Update();
            #endregion

            #region Costing
            //X.AddScript("saveCost('" + hidSeed.Text + "');");

            ucCost.costseed = hidSeed.Text;
            ucCost.btnCostEvent(sender, e);
            #endregion

            #region ForeignInvoice
            var ForeignInvoice = JSON.Deserialize<List<ForeignInvoice>>(e.ExtraParams["p_safety_3"]);
            List<IFields> ForeignInvoicelist = new List<IFields>();
            string ForeignInvoiceID = "";
            for (int i = 0; i < ForeignInvoice.Count; ++i)
            {
                ForeignInvoicelist.Add(dal.CreateIFields().Append("Option", "Update").
                Append("inv_Payment", ForeignInvoice[i].Kind).
                Append("inv_InvoiceDate", ControlBinder.getDate(ForeignInvoice[i].Date.ToString().StartsWith("0001") ? DBNull.Value : (object)ForeignInvoice[i].Date)).
                Append("inv_InvoiceNo", ForeignInvoice[i].DN_CNNO.ToUpper()).
                Append("inv_CompanyCode", ForeignInvoice[i].CompanyCode).
                Append("inv_CompanyName", ForeignInvoice[i].CompanyName).
                Append("inv_Currency", ForeignInvoice[i].Currency).
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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Invoice_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("inv_Seed", hidSeed.Text).Append("str", ForeignInvoiceID) }).Update();
            bool resultForeignInvoice = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Invoice_SP", ForeignInvoicelist).Update();
            #endregion

            #region Domestic
            var Domestic = JSON.Deserialize<List<Domestic>>(e.ExtraParams["p_safety_4"]);
            List<IFields> Domesticlist = new List<IFields>();
            string DomesticID = "";
            for (int i = 0; i < Domestic.Count; ++i)
            {
                Domesticlist.Add(dal.CreateIFields().Append("Option", "Update").
                Append("sr_ShipKind", Domestic[i].Kind).
                Append("sr_Carrier", Domestic[i].CompanyCode).
                    //Append("sr_Carrier", Domestic[i].CompanyName).
                Append("sr_To", Domestic[i].Dest).
                Append("sr_Voyage", Domestic[i].Voyage.ToUpper()).
                Append("sr_ETD", ControlBinder.getDate(Domestic[i].ETD.ToString().StartsWith("0001") ? DBNull.Value : (object)Domestic[i].ETD)).
                Append("sr_ETA", ControlBinder.getDate(Domestic[i].ETA.ToString().StartsWith("0001") ? DBNull.Value : (object)Domestic[i].ETA)).
                Append("sr_RowID", Domestic[i].RowID)
                .Append("sr_ToHouse", hidSeed.Text)
                .Append("sr_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("sr_Sys", SYS)
                .Append("sr_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                );
                DomesticID += "," + Domestic[i].RowID;
            }
            //delete
            if (DomesticID.Length > 1)
            {
                DomesticID = DomesticID.Substring(1, DomesticID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_ShipmentRoute_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("sr_Seed", hidSeed.Text).Append("str", DomesticID) }).Update();
            bool resultLocalDeliveryRoute = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_ShipmentRoute_SP", Domesticlist).Update();
            #endregion

            #region Contact
            var ContactInformation = JSON.Deserialize<List<Contact>>(e.ExtraParams["p_safety_5"]);
            List<IFields> ContactInformationlist = new List<IFields>();
            string ContactinformationID = "";
            for (int i = 0; i < ContactInformation.Count; ++i)
            {
                ContactInformationlist.Add(dal.CreateIFields().Append("Option", "Update").
                Append("sc_Type", ContactInformation[i].Kind.ToUpper()).
                Append("sc_Company", ContactInformation[i].CompanyCode.ToUpper()).
                    //Append("sc_Company", ContactInformation[i].CompanyName).
                Append("sc_Dept", ContactInformation[i].Dept.ToUpper()).
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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_ShipmentContact_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("sc_Seed", hidSeed.Text).Append("str", ContactinformationID) }).Update();
            bool resultContactInformation = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_ShipmentContact_SP", ContactInformationlist).Update();
            #endregion

            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "OI", "HBL");
           
                if (newFlag == "Y")
                {
                    if (!b)
                    {
                        X.Redirect("OceanShipmentHouse.aspx?seed=" + ds.Tables[0].Rows[0][0] + "&MBL=" + hidMAWB.Value);
                    }
                    else
                    {
                        X.Redirect("OceanShipmentHouse.aspx?MBL=" + Request["MBL"]);
                    }
                }
                else
                    if (b)
                    {
                        X.Redirect("OceanShipmentHouse.aspx?MBL=" + Request["MBL"]);
                    }

                ControlBinder.pageTitleMsg(true, "OI-H:" + labImpLotNo.Text, "<p class=\"success\">Status : Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
           
            
                //ControlBinder.pageTitleMsg(false, "OI-H:" + labImpLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
            

    }
    #endregion

    #region    btnNext_Click()     Author：Hcy   (2011-09-27)
    bool b = false;
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        b = true;
        btnSave_Click(sender, e);
        //hidSeed.Text = "0";
        //ClearControls();
    }
    #endregion

    /// <summary>
    /// 添加Invoice
    /// </summary>
    #region    btnAddNewInvoice_Click(object,DirectEventArgs)    Author：Micro   (2011-09-28)
    //protected void btnAddNewInvoice_Click(object sender, DirectEventArgs e)
    //{
    //    if (string.IsNullOrEmpty(CmbCompany.Text) || string.IsNullOrEmpty(CmbCurrency.Text))
    //    {
    //        X.Msg.Alert("Stauts", " Input can't for empty ! ! ! ", new JFunction { Handler = "Ext.get('CmbCompany').focus()" }).Show();
    //        return;
    //    }
    //    //sys=AI&M=1932777&Company=3VIETECTW01&Currency=USD&rate=7.750&FL=F
    //    string url = "../../AirImport/AIShipmentJobList/invoice.aspx?sys=OI&H=" + Request["seed"] + "&Company=" + CmbCompany.Value + "&Currency=" + CmbCurrency.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
    //    X.Js.AddScript("window.open('" + url + "','_blank')");
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

    #region Other
    class Other
    {
        public int RowID
        { get; set; }
        public string PPD
        { get; set; }
        public string CompanyCode
        { get; set; }
        public string CompanyName
        { get; set; }
        public string Item
        { get; set; }
        public string Description
        { get; set; }
        public string Total
        { get; set; }
        public string CalcKind
        { get; set; }
        public string Qty
        { get; set; }
        public string Unit
        { get; set; }
        public string Currency
        { get; set; }
        public string EX
        { get; set; }
        public string Rate
        { get; set; }
        public string Amount
        { get; set; }
        public string Percent
        { get; set; }
        public string Show
        { get; set; }
    }
    #endregion

    

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

    #region Domestic
    class Domestic
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

    #region Contact
    class Contact
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

    #region  Container
    public class gridContainer
    {
        public int RowID { get; set; }
    }
    #endregion

    #region LocalInvoice
    public class LocalInvoice
    {
        public int RowID { get; set; }
    }
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

    protected void CompanyNameSelect_AfterEdit(object sender, DirectEventArgs e)
    {
        RowSelectionModel sm = this.GridPanelOther.SelectionModel.Primary as RowSelectionModel;
        int index = sm.SelectedRow.RowIndex;
        var data = JSON.Deserialize<Other>(e.ExtraParams["CompanyNameSelect"]);
        this.StoreOther.UpdateRecordField(index, "", data.CompanyCode);
    }
}
