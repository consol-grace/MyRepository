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

public partial class OceanImport_OceanLot_List : System.Web.UI.Page
{
    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            txtMBL.Focus(true);
            ControlsBinder();
            DataBinder();
            LockControl();
            //X.AddScript("showCompanyRemark('cmbCarrierCode,cmbShipperCode,cmbConsigneeCode,cmbDischargeCode,txtM_to,cmbBrokerCode', 'Carrier,Shipper,Consignee,Co-Loader,Manifest To,Broker');");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtETD);
            ControlBinder.DateFormat(txtETADischarge);
            ControlBinder.DateFormat(txtETAFinal);
            ControlBinder.DateFormat(txtATD);
            ControlBinder.DateFormat(txtATA);
            ControlBinder.DateFormat(txtFreeStorageStart);
            ControlBinder.DateFormat(txtFreeStorageEnd);
            ControlBinder.DateFormat(txtPickup);
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
            X.AddScript("$('#showHBL').hide();");
            btnUpdateLotNo.Hide();
        }
        else
        {
            if (hidSeed.Text.Length > 1)
            {
                X.AddScript("TransferVoid();");
            }
        }
    }
  

    DataFactory dal = new DataFactory();
    readonly string SYS = "OI";


    #region ///刷新数据源
    public void StoreItem_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","O") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

    }

    public void StoreMode_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreServiceMode, "ServerMode", SYS[0].ToString());
    }

    public void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", SYS[0].ToString());
    }

    public void StoreUnit_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", SYS[0].ToString());
    }

    public void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", SYS[0].ToString());
    }

    public void StoreVessel_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreVessel, "VesselList");      

    }

    public void StoreVoyage_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreVoyage.RemoveAll();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("SYS",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text ) }).GetTable();
        StoreVoyage.DataSource = dt;
        StoreVoyage.DataBind();
    }

    public void StoreKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreKind, "QtyKindBinding", SYS[0].ToString());
    }
    public void StoreCurrInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", SYS[0].ToString());
    }
    

    #endregion

    public XTemplate TempVoyage
    {
        get
        {
            XTemplate xt = new XTemplate();
            xt.Html = "<tpl for=\".\">" +
                      "<tpl if=\"[xindex] == 1\">" +
                          "<table class=\"cbStates-list\">" +
                              "<tr>" +
                                   "<th>Voyage</th>" +
                                  "<th>POL/POD</th>" +
                              "</tr>" +
                      "</tpl>" +
                          "<tr class=\"list-item\">" +
                          "<td style=\"padding:3px 0px; width:50%\">{text}</td>" +
                          "<td style=\"padding:3px 0px; width:50%\">{POL}/{POD}</td>" +
                      "</tr>" +
                      "<tpl if=\"[xcount-xindex]==0\">" +
                              "</table>" +
                     "</tpl></tpl>";
            return xt;
        }
    }
    /// <summary>
    /// 控件绑定
    /// </summary>
    #region   ///ComboBox 控件绑定     Author：Micro   (2011-09-27)
    void ControlsBinder()
    {
        hidSeed.Text = string.IsNullOrEmpty(Request["seed"]) ? "0" : Request["seed"];
        txtMBL.Focus(true);
        //ControlBinder.CmbBinder(StoreCmb, "CompanyList",SYS[0].ToString());
        //ControlBinder.CmbBinder(StoreItem, "ItemBinding", SYS[0].ToString());
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","O") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

        //ControlBinder.CmbBinder(StoreCurrency, "CurrencysList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", SYS[0].ToString());
        
        ControlBinder.CmbBinder(StoreKind, "QtyKindBinding", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreVessel, "VesselList");
        ControlBinder.CmbBinder(StorePPCC, "PPCCList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreLocation, "LocationList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreServiceMode, "ServerMode", SYS[0].ToString());
        //ControlBinder.CmbBinder(StoreCurrLocal, "CurrencysListLocal", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", SYS[0].ToString());
        cmbVesselText.Template.Html = TempVoyage.Html;
    }


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

    protected void cmbVessel_Select(object sender, DirectEventArgs e)
    {
        cmbVesselText.Text = "";
        StoreVoyage.RemoveAll();
        ComList();             
    }

    #endregion

    /// <summary>
    /// 数据绑定
    /// </summary>
    #region   ///Grid 数据绑定     Author：Micro   (2011-09-27)
    void DataBinder()
    {
        
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_MBLList_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "Single")
                .Append("o_Seed",hidSeed.Text=="0"?(object)DBNull.Value:(object)hidSeed.Text) }).GetList();

        if (ds != null)
        {


            DataBinder(ds.Tables[0]);

            storeHBL.DataSource = ds.Tables[1];
            storeHBL.DataBind();
            if (ds.Tables[1].Rows.Count > 0)
            {
                double GWT = 0.000, Pieces = 0, CBM = 0.000, wm = 0.000;
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    GWT += Convert.ToDouble(ds.Tables[1].Rows[i]["CWT"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["CWT"].ToString());
                    Pieces += Convert.ToDouble(ds.Tables[1].Rows[i]["PKGS"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["PKGS"].ToString());
                    CBM += Convert.ToDouble(ds.Tables[1].Rows[i]["CBM"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["CBM"].ToString());
                    wm += Convert.ToDouble(ds.Tables[1].Rows[i]["WM"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["WM"].ToString());
                }
                if (Pieces.ToString() != "0") { txtAPiece.Text = Pieces.ToString(); }
                if (GWT.ToString() != "0") { txtAGWT.Text = GWT.ToString(); }
                if (CBM.ToString() != "0") { txtACBM.Text = CBM.ToString(); }
                if (wm.ToString() != "0") { txtAWM.Text = wm.ToString(); }
            }

            StoreInvoice.DataSource = ds.Tables[2];
            StoreInvoice.DataBind();

            
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "OI-M New", "<p>Status : New Blank  MBL </p>", div_bottom);
        }
        

    }

    void ComList()
    {
        StoreVoyage.RemoveAll();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("SYS",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text ) }).GetTable();
        StoreVoyage.DataSource = dt;
        StoreVoyage.DataBind();
        if (dt != null && dt.Rows.Count > 0)
        {
            //cmbVesselText.Text = dt.Rows[0][0].ToString();
            //cmbVesselText.Text = dt.Rows[0][1].ToString();
            cmbVesselText.SelectedItem.Value = dt.Rows[0][1].ToString();

            txtETD.Text = dt.Rows[0][2].ToString();
            txtETADischarge.Text = dt.Rows[0][3].ToString();
            cmbLoading.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
            cmbPort.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            cmbFinalDest.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            txtATD.Text = dt.Rows[0][2].ToString();
        }
        else
        {
            txtETD.Text ="";
            txtETADischarge.Text ="";
            cmbLoading.setValue("");
            cmbPort.setValue("");
            cmbFinalDest.setValue("");
            txtATD.Text = "";
                
        }
    }


    [DirectMethod]
    public void ShowVoyage()
    {
        X.AddScript("ShowVoyage('" + cmbVesselCode.SelectedItem.Value + "','" + cmbVesselText.SelectedItem.Value + "');");
    }

    [DirectMethod]
    public void BindVoyag(string id)
    {
        if (id != "")
        {
            StoreVoyage.RemoveAll();

            DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
            StoreVoyage.DataSource = dt1;
            StoreVoyage.DataBind();

            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageByID").
                Append("STAT",id) }).GetTable();

            cmbVesselText.SelectedItem.Value = id;
            txtETD.Text = dt.Rows[0][2].ToString();
            txtETADischarge.Text = dt.Rows[0][3].ToString();
            cmbLoading.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
            cmbPort.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            cmbFinalDest.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            txtATD.Text = dt.Rows[0][2].ToString();          
        }
    }



    void DataBinder(DataTable dt)
    {
        CmbUnit.setValue("PKG");
        if (dt == null || dt.Rows.Count == 0)
        {    
            ControlBinder.pageTitleMsg(false,"OI-M New", "<p>Status : New Blank  MBL </p>", div_bottom);
             return;
        }
        labImpLotNo.Text =dt.Rows[0]["LotNo"].ToString();
        hidLotNo.Text = dt.Rows[0]["LotNo"].ToString();
        txtMBL.Text = dt.Rows[0]["MBL"].ToString();
        cmbMode.setValue(dt.Rows[0]["ServiceMode"].ToString());
        cmbPPD.Text = dt.Rows[0]["PPD"].ToString();
        cmbSales.setValue(dt.Rows[0]["Salesman"].ToString());
        txtColoader.Text = dt.Rows[0]["ColoaderMBL"].ToString();
        txtReference.Text = dt.Rows[0]["Reference"].ToString();
        txtClearance.Text = dt.Rows[0]["Clearance"].ToString();
        cmbCarrierCode.setValue(dt.Rows[0]["Carrier"].ToString());
        cmbCarrierCode.Text = dt.Rows[0]["CarrierName"].ToString();
        cmbShipperCode.setValue(dt.Rows[0]["Shipper"].ToString());
        cmbShipperCode.Text = dt.Rows[0]["ShipperName"].ToString();
        cmbConsigneeCode.setValue(dt.Rows[0]["Consignee"].ToString());
        cmbConsigneeCode.Text = dt.Rows[0]["ConsigneeName"].ToString();
        cmbDischargeCode.setValue(dt.Rows[0]["Discharge"].ToString());
        cmbDischargeCode.Text = dt.Rows[0]["DischargeName"].ToString();
        cmbBrokerCode.setValue(dt.Rows[0]["Boroker"].ToString());
        cmbBrokerCode.Text = dt.Rows[0]["BorokerName"].ToString();
        cmbVesselCode.SelectedItem.Value = dt.Rows[0]["Vessel"].ToString();
        ComList();
        cmbVesselText.SelectedItem.Value = dt.Rows[0]["Voyage"].ToString();
        X.AddScript("getVessel('" + dt.Rows[0]["Vessel"].ToString() + "','" + dt.Rows[0]["Voyage"].ToString() + "');");
        cmbLoading.setValue(dt.Rows[0]["Loading"].ToString());
        cmbPort.setValue(dt.Rows[0]["Port"].ToString());
        cmbFinalDest.setValue(dt.Rows[0]["FinalDest"].ToString());
        txtETD.Text = dt.Rows[0]["ETD"].ToString();
        txtETADischarge.Text = dt.Rows[0]["ETAdischarge"].ToString();
        txtETAFinal.Text = dt.Rows[0]["ETAFinal"].ToString();
        txtOELot.Text = dt.Rows[0]["OELotNo"].ToString();
        txtATD.Text = dt.Rows[0]["ATD"].ToString();
        txtATA.Text = dt.Rows[0]["ATA"].ToString();
        //if (!string.IsNullOrEmpty(dt.Rows[0]["GWT"].ToString()))
        //    txtGWT.Text = dt.Rows[0]["GWT"].ToString();
        //if (!string.IsNullOrEmpty(dt.Rows[0]["CWT"].ToString()))
        //    txtCWT.Text = dt.Rows[0]["CWT"].ToString();
        //if (!string.IsNullOrEmpty(dt.Rows[0]["CBM"].ToString()))
        //    txtCBM.Text = dt.Rows[0]["CBM"].ToString();
        //if (!string.IsNullOrEmpty(dt.Rows[0]["Piece"].ToString()))
        //    txtPiece.Text = dt.Rows[0]["Piece"].ToString();

        if (!string.IsNullOrEmpty(dt.Rows[0]["GWT"].ToString()))
            txtGWT.Text = dt.Rows[0]["GWT"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["AWT"].ToString()))
            txtAGWT.Text = dt.Rows[0]["AWT"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["CBM"].ToString()))
            txtCBM.Text = dt.Rows[0]["CBM"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["ACBM"].ToString()))
            txtACBM.Text = dt.Rows[0]["ACBM"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["PKGS"].ToString()))
            txtPiece.Text = dt.Rows[0]["PKGS"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["APKGS"].ToString()))
            txtAPiece.Text = dt.Rows[0]["APKGS"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["WM"].ToString()))
            txtCWT.Text = dt.Rows[0]["WM"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["AWM"].ToString()))
            txtAWM.Text = dt.Rows[0]["AWM"].ToString();

        if (!string.IsNullOrEmpty(dt.Rows[0]["Container"].ToString()))
        txtContainer.Text = dt.Rows[0]["Container"].ToString();

        CmbUnit.setValue(dt.Rows[0]["Unit"].ToString());
        cmbWarehouse.setValue(dt.Rows[0]["WareHouse"].ToString());
        cmbWarehouse.Text = dt.Rows[0]["WareHouseName"].ToString();
        txtFreeStorageStart.Text = dt.Rows[0]["FreeStorageStart"].ToString();
        txtFreeStorageEnd.Text = dt.Rows[0]["FreeStorageEnd"].ToString();
        txtPickup.Text = dt.Rows[0]["PickUp"].ToString();
        chbDirect.Checked = Convert.ToBoolean(dt.Rows[0]["Direct"]);
        hidSeed.Text = dt.Rows[0]["seed"].ToString();
        
        txtM_to.Value = dt.Rows[0]["M_to"].ToString();
        txtM_to.Text = dt.Rows[0]["M_toName"].ToString();

        txtMAWBRemark.Text = dt.Rows[0]["o_Remark"].ToString();
        txtAccRemark.Text = dt.Rows[0]["o_AccountRemark"].ToString();

        if (ControlBinder.IsDisplayLotNo(txtETADischarge.Text, hidLotNo.Text))
            btnUpdateLotNo.Show();
        else
            btnUpdateLotNo.Hide();

        if (Convert.ToBoolean(dt.Rows[0]["active"]))
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
            X.AddScript("$('#showHBL').hide();");
            btnUpdateLotNo.Hide();
        }

        

        ControlBinder.pageTitleMsg(false, "OI-M:" + labImpLotNo.Text, "<p>Status : Edit  MBL  of   <span>" + dt.Rows[0]["LotNo"] + "</span>  </p>", div_bottom);
    }

    #endregion



    #region   /// Button 事件处理    Author：Micro   (2011-09-27)
    /// <summary>
    /// 保存全部
    /// </summary>
    #region   ///Button 事件   保存全部          Author：Micro   (2011-09-27)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        #region ///Update  OCEAN
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_MBLList_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "UpdateMBL")
            .Append("o_Seed",hidSeed.Text.ToUpper())
            .Append("o_MBL",txtMBL.Text.ToUpper())
            .Append("o_Type","MBL")
            .Append("o_ServiceMode",cmbMode.Value.ToUpper())
            .Append("o_PaymentMode",cmbPPD.Text.ToUpper())
            .Append("o_Sales",cmbSales.Value)
            .Append("o_ColoaderMBL",txtColoader.Text.ToUpper())
            .Append("o_LocFinal",cmbFinalDest.Text)
            .Append("o_Carrier",cmbCarrierCode.Value)
            .Append("o_VesselID",cmbVesselCode.SelectedItem.Value)
            .Append("o_VoyageID",cmbVesselText.SelectedItem.Value)
            .Append("o_ETD",ControlBinder.getDate(txtETD.RawText.StartsWith("0001")?DBNull.Value:(object)txtETD.RawText))
            .Append("OELotNo",txtOELot.Text.ToUpper())
            .Append("o_Shipper",cmbShipperCode.Value)
            .Append("o_Consignee",cmbConsigneeCode.Value)
            .Append("o_Discharge",cmbDischargeCode.Value)
            .Append("o_Broker",cmbBrokerCode.Value)
            //.Append("o_WT",string.IsNullOrEmpty(txtGWT.Text)?DBNull.Value:(object)txtGWT.Text)
            //.Append("o_CWT",string.IsNullOrEmpty(txtCWT.Text)?DBNull.Value:(object)txtCWT.Text)
            //.Append("o_CBM",string.IsNullOrEmpty(txtCBM.Text)?DBNull.Value:(object)txtCBM.Text)
            //.Append("o_PKGS",string.IsNullOrEmpty(txtPiece.Text)?DBNull.Value:(object)txtPiece.Text)
            .Append("o_CWT",string.IsNullOrEmpty(txtGWT.Text)?DBNull.Value:(object)txtGWT.Text)
            .Append("o_AWT",string.IsNullOrEmpty(txtAGWT.Text)?DBNull.Value:(object)txtAGWT.Text)
            .Append("o_CCBM",string.IsNullOrEmpty(txtCBM.Text)?DBNull.Value:(object)txtCBM.Text)
            .Append("o_ACBM",string.IsNullOrEmpty(txtACBM.Text)?DBNull.Value:(object)txtACBM.Text)
            .Append("o_CPKGS",string.IsNullOrEmpty(txtPiece.Text)?DBNull.Value:(object)txtPiece.Text)
            .Append("o_APKGS",string.IsNullOrEmpty(txtAPiece.Text)?DBNull.Value:(object)txtAPiece.Text)
            .Append("o_CWM",string.IsNullOrEmpty(txtCWT.Text)?DBNull.Value:(object)txtCWT.Text)
            .Append("o_AWM",string.IsNullOrEmpty(txtAWM.Text)?DBNull.Value:(object)txtAWM.Text)

            .Append("o_M_to",txtM_to.Value.Trim().ToUpper())
            .Append("o_Remark",txtMAWBRemark.Text.Trim().ToUpper())
            .Append("o_AccountRemark",txtAccRemark.Text.ToUpper())

            .Append("o_Unit",CmbUnit.Value)
            .Append("o_IsDirect",chbDirect.Checked?1:0)
            .Append("o_LocPOL", cmbLoading.Value)
            .Append("o_LocPOD",cmbPort.Value )
            .Append("o_ETA",ControlBinder.getDate(txtETADischarge.RawText.StartsWith("0001")?DBNull.Value:(object)txtETADischarge.RawText))
            .Append("o_ETAFinal",ControlBinder.getDate(txtETAFinal.RawText.StartsWith("0001")?DBNull.Value:(object)txtETAFinal.RawText))
            .Append("o_ATD",ControlBinder.getDate(txtATD.RawText.StartsWith("0001")?DBNull.Value:(object)txtATD.RawText))
            .Append("o_ATA",ControlBinder.getDate(txtATA.RawText.StartsWith("0001")?DBNull.Value:(object)txtATA.RawText))
            .Append("o_CarrierATTN",txtContainer.Text.ToUpper())
            .Append("o_STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("o_SYS",SYS)
            .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("code",FSecurityHelper.CurrentUserDataGET()[4]+"OI")
            .Append("imp_Clearance",txtClearance.Text.ToUpper())
            .Append("imp_Surrender",DBNull.Value)
            .Append("imp_Warehouse",cmbWarehouse.Value)
            .Append("imp_StorageFrom",ControlBinder.getDate(txtFreeStorageStart.RawText.StartsWith("0001")?DBNull.Value:(object)txtFreeStorageStart.RawText))
            .Append("imp_StorageTo",ControlBinder.getDate(txtFreeStorageEnd.RawText.StartsWith("0001")?DBNull.Value:(object)txtFreeStorageEnd.RawText))
            .Append("imp_PickupDate", ControlBinder.getDate(txtPickup.RawText.StartsWith("0001")?DBNull.Value:(object)txtPickup.RawText))            
        }).GetTable();

        if (dt == null || dt.Rows.Count == 0)
        {
            //X.Msg.Show(new MessageBoxConfig { Title = "Status", Message = "  Saved failed ! ! !  ", Width = new Unit(200), Buttons = MessageBox.Button.OK, AnimEl = "btnSave" });
            ControlBinder.pageTitleMsg(false, "OI-M New", "<p class=\"error\">Status :  Save failed, please check the data .  </p>", div_bottom);
            return;
        }
        hidSeed.Text = dt.Rows[0]["o_Seed"].ToString();

        #endregion

        #region ///Update  HBLList ，Local Invoice
        //var HBLList = JSON.Deserialize<List<HBL>>(e.ExtraParams["gridHBL"]);
        //string RowID = "0,";
        //for (int i = 0; i < HBLList.Count; ++i)
        //{
        //    RowID += HBLList[i].RowID + ",";
        //}
        //RowID = RowID.Substring(0, RowID.Length - 1);
        //bool hbl = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_MBLList_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete_HBL")
        //    .Append("o_Seed",hidSeed.Text)
        //    .Append("ROWID",RowID)}).Update();

        //RowID = "0,";
        //var InvoiceList = JSON.Deserialize<List<Invoice>>(e.ExtraParams["gridInvoice"]);
        //for (int i = 0; i < InvoiceList.Count; ++i)
        //{
        //    RowID += InvoiceList[i].RowID + ",";
        //}
        //RowID = RowID.Substring(0, RowID.Length - 1);
        //bool invoice = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_MBLList_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete_Invoice")
        //    .Append("o_Seed",hidSeed.Text)
        //    .Append("ROWID",RowID)}).Update();

        #endregion

        //X.AddScript("saveCost('" + hidSeed.Text + "');");

        ucCost.costseed = hidSeed.Text;
        ucCost.btnCostEvent(sender, e);

        bool l = true;
       
        if (l)
        {

            if (ControlBinder.IsDisplayLotNo(ControlBinder.getDate(string.IsNullOrEmpty(txtETADischarge.RawText.Trim()) ? DBNull.Value : (object)txtETADischarge.RawText).ToString(), hidLotNo.Text))
                btnUpdateLotNo.Show();
            else
                btnUpdateLotNo.Hide();

            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "OI", "MBL");
            if (i == 1)
            {
                hidSeed.Text = "0";
                //X.Msg.Show(new MessageBoxConfig { Title = "Status", Message = "  Saved successfully ! ! !  ", Width = new Unit(200), Buttons = MessageBox.Button.OK, AnimEl = "btnSave", Fn = new JFunction { Handler = "location.href='list.aspx'" } });
                ControlBinder.pageTitleMsg(true, "OI-M:" + labImpLotNo.Text, "<p class=\"success\">Status :  Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
                X.Redirect("list.aspx");
            }
            else
            {
                if (hidSeed.Text != Request["seed"])
                {  //X.Msg.Show(new MessageBoxConfig { Title = "Status", Message = "  Saved successfully ! ! !  ", Width = new Unit(200), Buttons = MessageBox.Button.OK, AnimEl = "btnSave", Fn = new JFunction { Handler = "location.href='list.aspx?seed=" + hidSeed.Text + "'" } });
                    ControlBinder.pageTitleMsg(true, "OI-M:" + labImpLotNo.Text, "<p class=\"success\">Status :  Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
                    X.Redirect("list.aspx?seed=" + hidSeed.Text);
                }
                else
                {// X.Msg.Show(new MessageBoxConfig { Title = "Status", Message = "  Saved successfully ! ! !  ", Width = new Unit(200), Buttons = MessageBox.Button.OK, AnimEl = "btnSave" });
                    ControlBinder.pageTitleMsg(true, "OI-M:" + labImpLotNo.Text, "<p class=\"success\">Status :  Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
                }

            }
        }
        else
            //X.Msg.Show(new MessageBoxConfig { Title = "Status", Message = "  Saved failed ! ! !   ", Width = new Unit(200), Buttons = MessageBox.Button.OK, AnimEl = "btnSave" });
            ControlBinder.pageTitleMsg(true, "OI-M:" + labImpLotNo.Text, "<p class=\"error\">Status :  Save failed, please check the data .  </p>", div_bottom);



      
    }
    #endregion


    /// <summary>
    /// 保存新增
    /// </summary>
    int i = 0;
    #region ///Button 事件  保存新增      Author：Micro   (2011-09-27)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        i = 1;
        btnSave_Click(sender, e);        
    }
    #endregion


    /// <summary>
    /// 删除或者报废
    /// </summary>
    #region    ///Button 事件  删除    Author：Micro   (2011-09-27)
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

        if (!VoidCheckAC.CheckisAC("OI", hidSeed.Text))
        {
            X.MessageBox.Alert("Status", VoidCheckAC.Message).Show();
            return;
        }

        if (hidSeed.Text.Length > 1)
        {
            string voidflag = hidVoid.Text == "0" ? "Y" : "N";
            DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "O").Append("Type", "MBL").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text==""?null:hidSeed.Text)}).GetList();
            if (l != null && l.Tables[0].Rows[0][0].ToString() == "Y")
            {
                X.AddScript("$('#img_void').css('display','inline');");
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnNext.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                X.AddScript("$('#showHBL').hide();");
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
                X.AddScript("$('#showHBL').show();");
            }
            else
            {
                ControlBinder.pageTitleMsg(true, "OI-M:" + labImpLotNo.Text, "<p class=\"error\">Status :  Save failed, please check the data .  </p>", div_bottom);
            }
            DataBinder();
            ControlBinder.pageTitleMsg(true, "OI-M:" + labImpLotNo.Text, "<p>Status : Edit  MBL  of   <span>" + labImpLotNo.Text + "</span>  </p>", div_bottom);
        }
    }

    /// <summary>
    /// 还原
    /// </summary>    
    #region ///Button 事件还原     Author：Micro  (2011-09-27)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
        X.AddScript("BindingCost();");
    }
    #endregion


    #endregion

    
    /// <summary>
    /// 添加Invoice
    /// </summary>
    #region    btnAddNewInvoice_Click(object,DirectEventArgs)    Author：Micro   (2011-09-28)
    //protected void btnAddNewInvoice_Click(object sender, DirectEventArgs e)
    //{
    //    if (string.IsNullOrEmpty(CmbCompanyRightCode.Text) || string.IsNullOrEmpty(CmbCurrencyRight.Text))
    //    {
    //        X.Msg.Alert("Stauts", " Input can't for empty ! ! ! ", new JFunction { Handler = "Ext.get('CmbCompanyRightCode').focus()" }).Show();
    //        return;
    //    }
    //    //sys=AI&M=1932777&Company=3VIETECTW01&Currency=USD&rate=7.750&FL=F
    //    string url = "../../AirImport/AIShipmentJobList/invoice.aspx?sys=OI&M=" + Request["seed"] + "&Company=" + CmbCompanyRightCode.Value + "&Currency=" + CmbCurrencyRight.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
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
    //            Append("cur_code",CmbCurrencyRight.Text).
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
        //X.Msg.Alert("Title", freeStoreage).Show();
        if (!string.IsNullOrEmpty(freeStoreage))
        {
            DateTime dt = Convert.ToDateTime(freeStoreage);
            dt = dt.AddDays(2);
            txtFreeStorageEnd.Text = dt.ToString("yyyy-MM-d");
        }
    }


    [DirectMethod]
    public void btnUpdateLotNo_Click()
    {
        object eta = ControlBinder.getDate(string.IsNullOrEmpty(txtETADischarge.RawText.Trim()) ? DBNull.Value : (object)txtETADischarge.RawText);

        string lotNo = ControlBinder.GetNewLotNo("OI", hidSeed.Text, eta);
        if (lotNo == "-1")
        {
            X.MessageBox.Alert("Status", "The cost of this LOT is transfered to AC, LOT NUMBER updating is aborted!").Show();
            ControlBinder.pageTitleMsg(true, "OI-M:" + labImpLotNo.Text, "<p class=\"success\">Status : Saved failed ! ! ! </p>", div_bottom);

        }
        else
        {
            labImpLotNo.Text = lotNo;
            hidLotNo.Text = lotNo;
            ControlBinder.pageTitleMsg(true, "OI-M:" + labImpLotNo.Text, "<p class=\"success\">Status :  Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
            btnUpdateLotNo.Hide();
        }
    }


}

/// <summary>
/// HBL 实体类
/// </summary>
#region HBL 实体类
class HBL
{
    public string RowID
    { get; set; }
    public string Consignee
    { get; set; }
    public string Final
    { get; set; }
    public string Service
    { get; set; }
    public string CWT
    { get; set; }
    public string CBM
    { get; set; }
    public string Pleces
    { get; set; }
    public string PPD
    { get; set; }
}
#endregion


/// <summary>
/// Invoice 实体类
/// </summary>
#region Invoice 实体类
class Invoice
{
    public string RowID
    { get; set; }   
}
#endregion





