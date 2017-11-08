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

public partial class OceanExport_OEAssignJob_List : System.Web.UI.Page
{
    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlsBinder();
            DataBinder();
            LockControl();
            //X.AddScript("showCompanyRemark('cmbDischargeCode,cmbShipperCode,cmbConsigneeCode,CmbNotify1,CmbNotify2,cmbCarrierCode,cmbBrokerCode,txtM_to', 'Co-Loader,Shipper,Consignee,Notify #1,Notify #2,Carrier,Broker,Manifest To');");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtCFSClosing);
            ControlBinder.DateFormat(txtCYClosing);
            ControlBinder.DateFormat(txtOnBoard);
            ControlBinder.DateFormat(txtETD);
            ControlBinder.DateFormat(txtETADischarge);
            ControlBinder.DateFormat(txtETAFinal);
            ControlBinder.DateFormat(txtATD);
        }
    }

    DataFactory dal = new DataFactory();
    readonly string SYS = "OE";
    protected void LockControl()
    {
        if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT")
        {
            btnSave.Disabled = true;
            btnCancel.Disabled = true;
            btnPull.Disabled = true;
            btnNewBooking.Disabled = true;
            btnAddBooking.Disabled = true;
            btnVoid.Disabled = true;
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

    #region ///刷新数据源
    public void StoreItem_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","O") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();


    }

    public void StoreCurrInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", SYS[0].ToString());
    }

    public void StoreKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreKind, "QtyKindBinding", SYS[0].ToString());
    }

    public void StoreMode_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreMode, "ServerMode", SYS[0].ToString());
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

    public void StorePreVoyage_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StorePreVoyage.RemoveAll();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbpreVessel.Text) }).GetTable();
        StorePreVoyage.DataSource = dt;
        StorePreVoyage.DataBind();
    }

    public void StoreVoyage_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreVoyage.RemoveAll();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
        StoreVoyage.DataSource = dt;
        StoreVoyage.DataBind();
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
        hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
        hidIDList.Text = Server.UrlDecode(Request["IDList"] == null ? "" : Request["IDList"]);
        //txtMBL.Focus(true);
        CmbGroup.Focus(true);
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","O") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", SYS[0].ToString());

        ControlBinder.CmbBinder(StoreKind, "QtyKindBinding", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreVessel, "VesselList");
        ControlBinder.CmbBinder(StorePPCC, "PPCCList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreLocation, "LocationList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreMode, "ServerMode", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreGroup, "GetSmGroup", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", SYS[0].ToString());

        cmbVesselText.Template.Html = TempVoyage.Html;
        cmbpreVoyage.Template.Html = TempVoyage.Html;
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
        Ext.Net.ComboBox combox = sender as ComboBox;
        if (combox.ID == "cmbpreVessel")
        {
            cmbpreVoyage.Text = "";
        }
        else
        {
            cmbVesselText.Text = "";
        }
        ComList(combox);
    }

    protected void cmbVesselText_Select(object sender, DirectEventArgs e)
    {
        Ext.Net.ComboBox combox = sender as ComboBox;
        if (combox.ID == "cmbpreVoyage")
        {
            if (cmbpreVessel.SelectedItem.Value != "")
            {
                DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageByID").
                Append("STAT",cmbpreVoyage.SelectedItem.Value) }).GetTable();
                txtpreonboard.Text = dt.Rows[0][8].ToString();
            }
        }
        else
        {
            if (cmbVesselText.SelectedItem.Value != "")
            {
                DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageByID").
                Append("STAT",cmbVesselText.SelectedItem.Value) }).GetTable();

                txtETD.Text = dt.Rows[0][2].ToString();
                txtETADischarge.Text = dt.Rows[0][3].ToString();
                cmbLoading.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
                cmbPort.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
                cmbFinalDest.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
                txtCFSClosing.Text = dt.Rows[0][6].ToString();
                txtCYClosing.Text = dt.Rows[0][7].ToString();
                txtOnBoard.Text = dt.Rows[0][8].ToString();
            }
        }
    }

    #endregion

    /// <summary>
    /// 数据绑定
    /// </summary>
    #region   ///Grid 数据绑定     Author：Micro   (2011-09-27)
    void DataBinder()
    {
        //tooltip.Html = ControlBinder.GetCostTotal(hidSeed.Text);
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_MBL_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "Single")
                .Append("o_Seed",hidSeed.Text==""?null:hidSeed.Text)
                .Append("str",hidIDList.Text)
                .Append("o_STAT",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("o_LocPOL",FSecurityHelper.CurrentUserDataGET()[4])
        }).GetList();



        if (ds != null && hidSeed.Text.Length > 1)
        {

            DataBinder(ds.Tables[0]);

            if (ds.Tables[1].Rows.Count > 0)
            {
                storeHBL.DataSource = ds.Tables[1];
                storeHBL.DataBind();
                double GWT = 0.000, Pieces = 0, CBM = 0.000, wm = 0.000;
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    GWT += Convert.ToDouble(ds.Tables[1].Rows[i]["o_WT"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["o_WT"].ToString());
                    Pieces += Convert.ToDouble(ds.Tables[1].Rows[i]["o_PKGS"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["o_PKGS"].ToString());
                    CBM += Convert.ToDouble(ds.Tables[1].Rows[i]["o_CBM"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["o_CBM"].ToString());
                    wm += Convert.ToDouble(ds.Tables[1].Rows[i]["o_WM"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["o_WM"].ToString());
                }
                if (Pieces.ToString() != "0") { txtAPiece.Text = Pieces.ToString(); }
                if (GWT.ToString() != "0") { txtAGWT.Text = GWT.ToString(); }
                if (CBM.ToString() != "0") { txtACBM.Text = CBM.ToString(); }
                if (wm.ToString() != "0") { txtAWM.Text = wm.ToString(); }
                totalPiece.Text = txtAPiece.Text;
                totalGWT.Text = txtAGWT.Text;
                totalCBM.Text = txtACBM.Text;
            }
            StoreInvoice.DataSource = ds.Tables[2];
            StoreInvoice.DataBind();




        }
        else if (ds != null && hidSeed.Text == "")
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                CmbUnit.Value = ds.Tables[0].Rows[0]["Unit"].ToString();
                cmbPPD.SelectedItem.Value = ds.Tables[0].Rows[0]["PPD"].ToString();
                cmbLoading.Value = ds.Tables[0].Rows[0]["Loading"].ToString();
                cmbShipperCode.setValue(ds.Tables[0].Rows[0]["Shipper"].ToString());
                cmbShipperCode.Text = ds.Tables[0].Rows[0]["ShipperName"].ToString();
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                storeHBL.DataSource = ds.Tables[1];
                storeHBL.DataBind();
                double GWT = 0.000, Pieces = 0, CBM = 0.000, wm = 0.000;
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    GWT += Convert.ToDouble(ds.Tables[1].Rows[i]["o_WT"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["o_WT"].ToString());
                    Pieces += Convert.ToDouble(ds.Tables[1].Rows[i]["o_PKGS"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["o_PKGS"].ToString());
                    CBM += Convert.ToDouble(ds.Tables[1].Rows[i]["o_CBM"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["o_CBM"].ToString());
                    wm += Convert.ToDouble(ds.Tables[1].Rows[i]["o_WM"].ToString() == "" ? "0.000" : ds.Tables[1].Rows[i]["o_WM"].ToString());
                }
                if (Pieces.ToString() != "0") { txtAPiece.Text = Pieces.ToString(); }
                if (GWT.ToString() != "0") { txtAGWT.Text = GWT.ToString(); }
                if (CBM.ToString() != "0") { txtACBM.Text = CBM.ToString(); }
                if (wm.ToString() != "0") { txtAWM.Text = wm.ToString(); }
                totalPiece.Text = txtAPiece.Text;
                totalGWT.Text = txtAGWT.Text;
                totalCBM.Text = txtACBM.Text;
            }
            ControlBinder.pageTitleMsg(false, "OE-M New", "<p>Status : New Blank  MBL. </p>", div_bottom);
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "OE-M New", "<p>Status : New Blank  MBL. </p>", div_bottom);
        }

        //txtMBL.Focus(true);
        CmbGroup.Focus(true);
    }

    void ComList(ComboBox combox)
    {

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",combox.Text) }).GetTable();

        if (combox.ID == "cmbpreVessel")
        {
            StorePreVoyage.RemoveAll();

            StorePreVoyage.DataSource = dt;
            StorePreVoyage.DataBind();
            if (dt != null && dt.Rows.Count > 0)
            {
                cmbpreVoyage.SelectedItem.Value = dt.Rows[0][1].ToString();
                txtpreonboard.Text = dt.Rows[0][9].ToString();
            }
            else
            {
                txtpreonboard.Text = "";
            }
        }
        else
        {
            StoreVoyage.RemoveAll();

            StoreVoyage.DataSource = dt;
            StoreVoyage.DataBind();
            if (dt != null && dt.Rows.Count > 0)
            {
                cmbVesselText.SelectedItem.Value = dt.Rows[0][1].ToString();

                txtCFSClosing.Text = dt.Rows[0][7].ToString();
                txtCYClosing.Text = dt.Rows[0][8].ToString();
                txtOnBoard.Text = dt.Rows[0][9].ToString();
                txtETD.Text = dt.Rows[0][2].ToString();
                txtETADischarge.Text = dt.Rows[0][3].ToString();
                cmbLoading.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
                cmbPort.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
                cmbFinalDest.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));

            }
            else
            {
                txtCFSClosing.Text = "";
                txtCYClosing.Text = "";
                txtOnBoard.Text = "";
                txtETD.Text = "";
                txtETADischarge.Text = "";
                cmbLoading.setValue("");
                cmbPort.setValue("");
                cmbFinalDest.setValue("");
            }
        }
    }

    [DirectMethod]
    public void ShowVoyage(string type)
    {
        if (type == "pre")
            X.AddScript("ShowVoyage('" + cmbpreVessel.SelectedItem.Value + "','" + cmbpreVoyage.SelectedItem.Value + "','cmbpreVessel');");
        else
            X.AddScript("ShowVoyage('" + cmbVesselCode.SelectedItem.Value + "','" + cmbVesselText.SelectedItem.Value + "','cmbVesselCode');");
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
            txtCFSClosing.Text = dt.Rows[0][6].ToString();
            txtCYClosing.Text = dt.Rows[0][7].ToString();
            txtOnBoard.Text = dt.Rows[0][8].ToString();
        }
    }
    [DirectMethod]
    public void BindPreVoyag(string id)
    {
        if (id != "")
        {
            StorePreVoyage.RemoveAll();

            DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT", cmbpreVessel.Text) }).GetTable();
            StorePreVoyage.DataSource = dt1;
            StorePreVoyage.DataBind();

            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageByID").
                Append("STAT",id) }).GetTable();

            cmbpreVoyage.SelectedItem.Value = id;

            txtpreonboard.Text = dt.Rows[0][8].ToString();
        }
    }

    void DataBinder(DataTable dt)
    {
        if (dt == null || dt.Rows.Count == 0)
        {
            ControlBinder.pageTitleMsg(false, "OE-M New", "<p>Status : New Blank  MBL . </p>", div_bottom);
            return;
        }
        labImpLotNo.Text = dt.Rows[0]["LotNo"].ToString();
        string tempmawb = dt.Rows[0]["MBL"].ToString().ToUpper() == "" ? "" : "MBL# " + "<span style='color:#ff0000;'>" + dt.Rows[0]["MBL"].ToString().ToUpper() + "</span>";
        string tempLotNo = labImpLotNo.Text == "" ? "" : "Lot# " + "<span style='color:#ff0000;'>" + labImpLotNo.Text + "</span>";
        labHeader.Html = (tempmawb == "" ? "" : "<span>" + tempmawb + "</span>") + (tempLotNo == "" ? "" : "<span style='padding-left:10px'>" + tempLotNo + "</span>");
        txtMBL.Text = dt.Rows[0]["MBL"].ToString();
        cmbMode.setValue(dt.Rows[0]["ServiceMode"].ToString());
        CmbGroup.SelectedItem.Value = dt.Rows[0]["o_ServiceType"].ToString();
        cmbPPD.Text = dt.Rows[0]["PPD"].ToString();
        cmbSales.setValue(dt.Rows[0]["Salesman"].ToString());
        cmbCarrierCode.setValue(dt.Rows[0]["Carrier"].ToString());
        cmbCarrierCode.Text = dt.Rows[0]["CarrierName"].ToString();
        cmbShipperCode.setValue(dt.Rows[0]["Shipper"].ToString());
        cmbShipperCode.Text = dt.Rows[0]["ShipperName"].ToString();
        cmbConsigneeCode.setValue(dt.Rows[0]["Consignee"].ToString());
        cmbConsigneeCode.Text = dt.Rows[0]["ConsigneeName"].ToString();
        cmbDischargeCode.setValue(dt.Rows[0]["Coloader"].ToString());
        cmbDischargeCode.Text = dt.Rows[0]["ColoaderName"].ToString();
        CmbNotify1.setValue(dt.Rows[0]["Notify1"].ToString());
        CmbNotify1.Text = dt.Rows[0]["Notify1Name"].ToString();
        CmbNotify2.setValue(dt.Rows[0]["Notify2"].ToString());
        CmbNotify2.Text = dt.Rows[0]["Notify2Name"].ToString();
        cmbBrokerCode.setValue(dt.Rows[0]["Broker"].ToString());
        cmbBrokerCode.Text = dt.Rows[0]["BrokerName"].ToString();
        cmbVesselCode.SelectedItem.Value = dt.Rows[0]["Vessel"].ToString();
        StoreVoyage.RemoveAll();

        DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
        StoreVoyage.DataSource = dt1;
        StoreVoyage.DataBind();
        if (dt1 != null && dt1.Rows.Count > 0)
        {
            cmbVesselText.SelectedItem.Value = dt.Rows[0]["Voyage"].ToString();
        }
        cmbLoading.setValue(dt.Rows[0]["Loading"].ToString());
        cmbPort.setValue(dt.Rows[0]["Port"].ToString());
        cmbFinalDest.setValue(dt.Rows[0]["FinalDest"].ToString());

        txtCFSClosing.Text = dt.Rows[0]["CFS"].ToString();
        txtCYClosing.Text = dt.Rows[0]["CY"].ToString();
        txtOnBoard.Text = dt.Rows[0]["OnBoard"].ToString();
        txtETD.Text = dt.Rows[0]["ETD"].ToString();
        txtETADischarge.Text = dt.Rows[0]["ETAdischarge"].ToString();
        txtETAFinal.Text = dt.Rows[0]["ETAFinal"].ToString();
        txtATD.Text = dt.Rows[0]["ATD"].ToString();

        #region ///pre-Carriage
        cmbpreVessel.SelectedItem.Value = dt.Rows[0]["PreVessel"].ToString();
        StorePreVoyage.RemoveAll();

        DataTable dt2 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbpreVessel.Text) }).GetTable();
        StorePreVoyage.DataSource = dt2;
        StorePreVoyage.DataBind();
        if (dt2 != null && dt2.Rows.Count > 0)
        {
            cmbpreVoyage.SelectedItem.Value = dt.Rows[0]["PreVoyage"].ToString();
        }
        txtpreonboard.Text = dt.Rows[0]["PreOnBoard"].ToString();

        #endregion

        if (!string.IsNullOrEmpty(dt.Rows[0]["GWT"].ToString()))
            txtCGWT.Text = dt.Rows[0]["GWT"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["AWT"].ToString()))
            txtAGWT.Text = dt.Rows[0]["AWT"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["CBM"].ToString()))
            txtCCBM.Text = dt.Rows[0]["CBM"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["ACBM"].ToString()))
            txtACBM.Text = dt.Rows[0]["ACBM"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["PKGS"].ToString()))
            txtCPiece.Text = dt.Rows[0]["PKGS"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["APKGS"].ToString()))
            txtAPiece.Text = dt.Rows[0]["APKGS"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["WM"].ToString()))
            txtCWM.Text = dt.Rows[0]["WM"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["AWM"].ToString()))
            txtAWM.Text = dt.Rows[0]["AWM"].ToString();
        if (!string.IsNullOrEmpty(dt.Rows[0]["Container"].ToString()))
            txtContainer.Text = dt.Rows[0]["Container"].ToString();

        CmbUnit.setValue(dt.Rows[0]["Unit"].ToString());

        txtM_to.Value = dt.Rows[0]["M_to"].ToString();
        txtM_to.Text = dt.Rows[0]["M_toName"].ToString();

        txtclpRemark.Text = dt.Rows[0]["o_DeclareRemark"].ToString();
        txtAccRemark.Text = dt.Rows[0]["o_AccountRemark"].ToString();
        txtMAWBRemark.Text = dt.Rows[0]["o_Remark"].ToString();

        if (ControlBinder.IsDisplayLotNo(txtETD.Text.Trim(), labImpLotNo.Text))
        {
            btnUpdateLotNo.Show();
        }
        else
        {
            btnUpdateLotNo.Hide();
        }

        if (dt.Rows[0]["Active"].ToString() == "Y")
        {
            img_void.Style.Value = "display:none";
        }
        else
        {
            img_void.Style.Value = "display:inline";
            btnSave.Disabled = true;
            btnCancel.Disabled = true;
            btnPull.Disabled = true;
            btnNewBooking.Disabled = true;
            btnAddBooking.Disabled = true;
            btnVoid.Text = "Active";
            hidVoid.Text = "1";
            btnUpdateLotNo.Hide();
        }

        hidSeed.Text = dt.Rows[0]["seed"].ToString();
        ControlBinder.pageTitleMsg(false, "OE-M:" + labImpLotNo.Text, "<p>Status : Edit  MBL  of   <span>" + dt.Rows[0]["LotNo"] + "</span>  </p>", div_bottom);
    }

    #endregion

    #region   /// Button 事件处理    Author：Micro   (2011-09-27)
    /// <summary>
    /// 保存全部
    /// </summary>
    #region   ///Button 事件   保存全部          Author：Micro   (2011-09-27)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        string code = (FSecurityHelper.CurrentUserDataGET()[12].Length>3) ? FSecurityHelper.CurrentUserDataGET()[12].Substring(4,3)+"OE" : FSecurityHelper.CurrentUserDataGET()[12] + "OE";
        #region ///Update  OCEAN
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_MBL_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "UpdateMBL")
            .Append("o_Seed",hidSeed.Text==""?null:hidSeed.Text)
            .Append("o_LotNo",labImpLotNo.Text)
            .Append("o_MBL",txtMBL.Text.ToUpper())
            .Append("o_ServiceMode",cmbMode.Value)
            .Append("o_ServiceType",CmbGroup.SelectedItem.Value)
            .Append("o_PaymentMode",cmbPPD.Text)
            .Append("o_Sales",cmbSales.Value)
            .Append("o_Carrier",cmbCarrierCode.Value)
            .Append("o_VesselID",cmbVesselCode.SelectedItem.Value)
            .Append("o_VoyageID",cmbVesselText.SelectedItem.Value)
            .Append("o_Shipper",cmbShipperCode.Value)
            .Append("o_Consignee",cmbConsigneeCode.Value)
            .Append("o_PartyA",CmbNotify1.Value)
            .Append("o_PartyB",CmbNotify2.Value)
            .Append("o_Coloader",cmbDischargeCode.Value)
            .Append("o_Broker",cmbBrokerCode.Value)
            .Append("o_M_to",txtM_to.Value.Trim().ToUpper())

            .Append("o_CWT",string.IsNullOrEmpty(txtCGWT.Text)?DBNull.Value:(object)txtCGWT.Text)
            .Append("o_AWT",string.IsNullOrEmpty(txtAGWT.Text)?DBNull.Value:(object)txtAGWT.Text)
            .Append("o_CCBM",string.IsNullOrEmpty(txtCCBM.Text)?DBNull.Value:(object)txtCCBM.Text)
            .Append("o_ACBM",string.IsNullOrEmpty(txtACBM.Text)?DBNull.Value:(object)txtACBM.Text)
            .Append("o_CPKGS",string.IsNullOrEmpty(txtCPiece.Text)?DBNull.Value:(object)txtCPiece.Text)
            .Append("o_APKGS",string.IsNullOrEmpty(txtAPiece.Text)?DBNull.Value:(object)txtAPiece.Text)
            .Append("o_CWM",string.IsNullOrEmpty(txtCWM.Text)?DBNull.Value:(object)txtCWM.Text)
            .Append("o_AWM",string.IsNullOrEmpty(txtAWM.Text)?DBNull.Value:(object)txtAWM.Text)
            .Append("o_Unit",CmbUnit.Value)
            .Append("o_LocFinal",cmbFinalDest.Text)
            .Append("o_LocPOL", cmbLoading.Value)
            .Append("o_LocPOD",cmbPort.Value)
            .Append("o_CFS",ControlBinder.getDate(txtCFSClosing.RawText.StartsWith("0001")?DBNull.Value:(object)txtCFSClosing.RawText))
            .Append("o_CY",ControlBinder.getDate(txtCYClosing.RawText.StartsWith("0001")?DBNull.Value:(object)txtCYClosing.RawText))
            .Append("o_ScheduleDate",ControlBinder.getDate(txtOnBoard.RawText.StartsWith("0001")?DBNull.Value:(object)txtOnBoard.RawText))
            .Append("o_ETD",ControlBinder.getDate(txtETD.RawText.StartsWith("0001")?DBNull.Value:(object)txtETD.RawText))
            .Append("o_ETA",ControlBinder.getDate(txtETADischarge.RawText.StartsWith("0001")?DBNull.Value:(object)txtETADischarge.RawText))
            .Append("o_ETAFinal",ControlBinder.getDate(txtETAFinal.RawText.StartsWith("0001")?DBNull.Value:(object)txtETAFinal.RawText))
            .Append("o_ATD",ControlBinder.getDate(txtATD.RawText.StartsWith("0001")?DBNull.Value:(object)txtATD.RawText))
           
            .Append("o_STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("o_SYS",SYS)
            .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("code",code)//FSecurityHelper.CurrentUserDataGET()[4]

            .Append("o_DeclareRemark",txtclpRemark.Text.ToUpper())
            .Append("o_AccountRemark",txtAccRemark.Text.ToUpper())
            .Append("o_Remark",txtMAWBRemark.Text.ToUpper())

            .Append("o_PreVesselID", cmbpreVessel.SelectedItem.Value)
            .Append("o_PreVoyageID", cmbpreVoyage.SelectedItem.Value)
            .Append("o_PreOnboard",ControlBinder.getDate(txtpreonboard.RawText.StartsWith("0001")?DBNull.Value:(object)txtpreonboard.RawText))


                    
        }).GetTable();

        if (dt == null || dt.Rows.Count == 0)
        {
            ControlBinder.pageTitleMsg(false, "OE-M New", "<p class=\"error\">Status :  Save failed, please check the data .  </p>", div_bottom);
            return;
        }
        hidSeed.Text = dt.Rows[0]["o_Seed"].ToString();
        string lotno = dt.Rows[0]["o_LotNo"].ToString();

        #endregion

        #region Update  HBLList ，Local Invoice
        var HBLList = JSON.Deserialize<List<HBL>>(e.ExtraParams["gridHBL"]);
        string RowID = "0,";
        //List<IFields> listHBL = new List<IFields>();
        for (int i = 0; i < HBLList.Count; ++i)
        {
            //listHBL.Add(dal.CreateIFields().Append("Option", "UpdateHBLActReceipt")
            //   .Append("o_ROWID", HBLList[i].o_ROWID).Append("o_AReceiptDate", HBLList[i].ActReceipt==null ? null : ControlBinder.getDate((object)HBLList[i].ActReceipt))
            //   ); 
            RowID += HBLList[i].o_ROWID + ",";
        }
        RowID = RowID.Substring(0, RowID.Length - 1);

        bool hbl = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_MBL_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete_HBL").Append("o_MBL",txtMBL.Text.Trim().ToUpper())
            .Append("o_Seed",hidSeed.Text==""?null:hidSeed.Text).Append("ROWID",RowID).Append("o_LotNo",lotno)}).Update();



        #endregion

        //update Data
        bool updatealldata = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_MBL_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "UpdateAllData")
            .Append("o_Seed",hidSeed.Text==""?null:hidSeed.Text)}).Update();

        //updatecost
        //X.AddScript("saveCost('" + hidSeed.Text + "');");

        ucCost.costseed = hidSeed.Text;
        ucCost.btnCostEvent(sender, e);

        bool l = true;
        if (l)
        {
            if (i == 1)
            {
                hidSeed.Text = "";
                ControlBinder.pageTitleMsg(true, "OE-M:" + labImpLotNo.Text, "<p class=\"success\">Status :  Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
                X.Redirect("List.aspx");
            }
            else
            {
                if (hidSeed.Text != Request["seed"])
                {
                    ControlBinder.pageTitleMsg(true, "OE-M:" + labImpLotNo.Text, "<p class=\"success\">Status :  Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
                    X.Redirect("List.aspx?seed=" + hidSeed.Text);
                }
                else
                {
                    DataBinder();
                    ControlBinder.pageTitleMsg(true, "OE-M:" + labImpLotNo.Text, "<p class=\"success\">Status :  Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
                }

            }
        }
        else
            ControlBinder.pageTitleMsg(false, "OE-M:" + labImpLotNo.Text, "<p class=\"error\">Status :  Save failed, please check the data .  </p>", div_bottom);




    }
    #endregion


    /// <summary>
    /// 保存新增
    /// </summary>
    int i = 0;
    #region ///Button 事件  保存新增      Author：Micro   (2011-09-27)
    //protected void btnNext_Click(object sender, DirectEventArgs e)
    //{
    //    i = 1;
    //    btnSave_Click(sender, e);
    //}
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
        if (!VoidCheckAC.CheckisAC("OE", hidSeed.Text))
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
                btnPull.Disabled = true;
                btnNewBooking.Disabled = true;
                btnAddBooking.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                btnUpdateLotNo.Hide();
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "N")
            {
                X.AddScript("$('#img_void').css('display','none');");
                btnSave.Disabled = false;
                btnCancel.Disabled = false;
                btnPull.Disabled = false;
                btnNewBooking.Disabled = false;
                btnAddBooking.Disabled = false;
                btnVoid.Text = "Void";
                hidVoid.Text = "0";
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "OE-M:" + labImpLotNo.Text, "<p class=\"error\">Status :  Void failed, please check the data .  </p>", div_bottom);
            }
            DataBinder();
            ControlBinder.pageTitleMsg(true, "OE-M:" + labImpLotNo.Text, "<p>Status : Edit  MBL  of   <span>" + labImpLotNo.Text + "</span>  </p>", div_bottom);
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

    [DirectMethod]
    public void btnUpdateLotNo_Click()
    {
        object etd = ControlBinder.getDate(string.IsNullOrEmpty(txtETD.RawText.Trim()) ? DBNull.Value : (object)txtETD.RawText.Trim());

        string lotNo = ControlBinder.GetNewLotNo("OE", hidSeed.Text, etd);
        if(lotNo == "-1")
        {
            X.MessageBox.Alert("Status", "The cost of this LOT is transfered to AC, LOT NUMBER updating is aborted!").Show();
            ControlBinder.pageTitleMsg(true, "OE-M:" + labImpLotNo.Text, "<p class=\"success\">Status : Saved failed ! ! ! </p>", div_bottom);
            
        }
        else if (lotNo != "0")
        {
            labImpLotNo.Text = lotNo;
            string tempmawb = txtMBL.Text.Trim() == "" ? "" : "MBL# " + "<span style='color:#ff0000;'>" + txtMBL.Text.Trim().ToUpper() + "</span>";
            string tempLotNo = labImpLotNo.Text == "" ? "" : "Lot# " + "<span style='color:#ff0000;'>" + labImpLotNo.Text + "</span>";
            labHeader.Html = (tempmawb == "" ? "" : "<span>" + tempmawb + "</span>") + (tempLotNo == "" ? "" : "<span style='padding-left:10px'>" + tempLotNo + "</span>");


            ControlBinder.pageTitleMsg(true, "OE-M:" + labImpLotNo.Text, "<p class=\"success\">Status : Saved successfully ! ! ! </p>", div_bottom);
            btnUpdateLotNo.Hide();
        }

    }


    #endregion

    #region    btnAddBooking_Click()     Author：Hcy   (2011-11-23)
    protected void btnAddBooking_Click(object sender, DirectEventArgs e)
    {

        var HBLList = JSON.Deserialize<List<HBL>>(e.ExtraParams["p_safety_HBL"]);
        string RowID = "";
        for (int i = 0; i < HBLList.Count; ++i)
        {
            RowID += "," + HBLList[i].o_Seed.ToString();
        }
        if (RowID.Length > 1)
        {
            RowID = RowID.Substring(1, RowID.Length - 1);
        }

        X.AddScript("window.showModalDialog('../OEShipmentList/List.aspx?JobType=job&Jobseed=" + hidSeed.Text + "&JobIDList=" + Server.UrlEncode(RowID) + "',window,'dialogWidth=980px,dialogHeight=630px,status=no,resizable=yes');");
    }
    #endregion


    #region    btnNewBooking_Click()     Author：Hcy   (2011-11-23)
    protected void btnNewBooking_Click(object sender, DirectEventArgs e)
    {

        var HBLList = JSON.Deserialize<List<HBL>>(e.ExtraParams["p_safety_HBL"]);
        string RowID = "";
        for (int i = 0; i < HBLList.Count; ++i)
        {
            RowID += "," + HBLList[i].o_Seed.ToString();
        }
        if (RowID.Length > 1)
        {
            RowID = RowID.Substring(1, RowID.Length - 1);
        }

        X.AddScript("window.showModalDialog('../OEShipment/List.aspx?JobType=job&JobLotNo=" + labImpLotNo.Text + "&Jobseed=" + hidSeed.Text + "&JobIDList=" + Server.UrlEncode(RowID) + "',window,'dialogWidth=1000px,dialogHeight=750px,status=no,resizable=yes');");
    }
    #endregion

    [DirectMethod]
    public void RefreshData(string seed, string str)
    {

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_MBL_SP", new List<IFields> { dal.CreateIFields().Append("Option", "RefreshData")
                .Append("o_Seed", seed==""?null:seed).Append("str",str) }).GetList();

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            storeHBL.DataSource = ds.Tables[0];
            storeHBL.DataBind();
            double GWT = 0.000, Pieces = 0, CBM = 0.000, wm = 0.000;
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GWT += Convert.ToDouble(ds.Tables[0].Rows[i]["o_WT"].ToString() == "" ? "0.000" : ds.Tables[0].Rows[i]["o_WT"].ToString());
                Pieces += Convert.ToDouble(ds.Tables[0].Rows[i]["o_PKGS"].ToString() == "" ? "0" : ds.Tables[0].Rows[i]["o_PKGS"].ToString());
                CBM += Convert.ToDouble(ds.Tables[0].Rows[i]["o_CBM"].ToString() == "" ? "0.000" : ds.Tables[0].Rows[i]["o_CBM"].ToString());
                wm += Convert.ToDouble(ds.Tables[0].Rows[i]["o_WM"].ToString() == "" ? "0.000" : ds.Tables[0].Rows[i]["o_WM"].ToString());
            }
            if (Pieces.ToString() != "0") { txtAPiece.Text = Pieces.ToString(); }
            if (GWT.ToString() != "0") { txtAGWT.Text = GWT.ToString(); }
            if (CBM.ToString() != "0") { txtACBM.Text = CBM.ToString(); }
            if (wm.ToString() != "0") { txtAWM.Text = wm.ToString(); }
            totalPiece.Text = txtAPiece.Text;
            totalGWT.Text = txtAGWT.Text;
            totalCBM.Text = txtACBM.Text;
        }

    }

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
    //    string url = "../../AirImport/AIShipmentJobList/invoice.aspx?sys=OE&M=" + Request["seed"] + "&Company=" + CmbCompanyRightCode.Value + "&Currency=" + CmbCurrencyRight.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
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
    //            Append("inv_Sys","O") }).GetTable();
    //    if (ds != null && ds.Rows.Count > 0)
    //    {
    //        radForeign.Checked = Convert.ToBoolean(ds.Rows[0][0]);
    //        radLocal.Checked = Convert.ToBoolean(ds.Rows[0][1]);
    //        txtcur_Rate.Text = ds.Rows[0][2].ToString();
    //    }
    //}
    #endregion




}

/// <summary>
/// HBL 实体类
/// </summary>
#region HBL 实体类
class HBL
{
    public string o_ROWID
    { get; set; }
    public DateTime o_ScheduleDate
    { get; set; }
    public DateTime ActReceipt
    { get; set; }
    public string o_BookNo
    { get; set; }
    public string o_HBL
    { get; set; }
    public string o_Shipper
    { get; set; }
    public string o_Consignee
    { get; set; }
    public string o_LocFinal
    { get; set; }
    public string o_ServiceMode
    { get; set; }
    public string o_PKGS
    { get; set; }
    public string o_Unit
    { get; set; }
    public string o_WT
    { get; set; }
    public string o_CBM
    { get; set; }
    public string o_PaymentMode
    { get; set; }
    public string o_Seed
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





