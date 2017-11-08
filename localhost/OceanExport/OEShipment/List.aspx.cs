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

public partial class OceanExport_OEShipment_List : System.Web.UI.Page
{
    private static string DODRowID = "";
    public string TranLotNo = "";
    public string TranHBL = "";
    public string TranSeed = "";
    public string TranToMBL = "";

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                string sed = Request["Seed"] == null ? "" : Request["Seed"].ToString();
                if(sed != "")
                { 
                    DataTable dtSeed = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysTranshipment_SP", new List<IFields>() { dal.CreateIFields()
                    .Append("Option", "IsExistSeed")
                    .Append("HBLSeed", Request["Seed"]=="0"?(object)DBNull.Value:(object)Request["seed"] )}).GetTable();
                
                    if (dtSeed != null && dtSeed.Rows[0][0].ToString() == "0")
                    {
                        X.Redirect("/OceanExport/OEShipment/List.aspx");
                        return;
                    }
                }

                if (Request["JobLotNo"] != null)
                {
                    hidLotNo.Text = Request["JobLotNo"];
                }

                if (IsTran())
                {
                    hidTran.Text = "TRUE";
                    txtRemark.Height = 55;
                    X.AddScript("$('#trIsTran').css('height','25px');");
                }
                else
                {
                    hidTran.Text = "FALSE";
                    txtRemark.Height = 80;
                    X.AddScript("$('#trIsTran').css('height','0px');");
                }

                ComboBoxBinding();
                DODRowID = string.IsNullOrEmpty(Request["DODRowID"]) ? "" : Request["DODRowID"].Substring(0, Request["DODRowID"].Length - 1);
                DataBindPO();
                DataBindList();
                LockControl();
                //X.AddScript("showCompanyRemark('CmbShipperCode,CmbConsignee,CmbNotify1,CmbNotify2,CmbAgent,CmbBroker,CmbShipTo', 'Shipper,Consignee,Notify #1,Notify #2,Agent,Broker,Ship To');");
                if (Request["JobLotNo"] == null && cmbVesselCode.Disabled != true)
                {
                    cmbVesselCode.Focus(true);
                }
                else
                {
                    X.AddScript("$('#CmbShipperCode').focus().select();");
                }
            }
        }
    }

    public bool IsTran()
    {
        bool t = false;
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysTranshipment_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "GetTranLotNo")
                .Append("HBLSeed", Request["Seed"]=="0"?(object)DBNull.Value:(object)Request["seed"] )}).GetList();
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                TranLotNo = ds.Tables[0].Rows[0][0].ToString();
                TranHBL = ds.Tables[0].Rows[0][1].ToString();
                TranSeed = ds.Tables[0].Rows[0][2].ToString();
                TranToMBL = ds.Tables[0].Rows[0][3].ToString();
                if (ds.Tables[0].Rows[0][4].ToString() == "0" && ds.Tables[0].Rows[0][5].ToString() == "0") //判断是否已经有COST AC或者有INVOICE已经被打印
                {
                    hidisACorPrint.Text = "false";
                }
                t = true;
            }
        }

        return t;
    }
       /// <summary>
    /// 点击ADD按钮，汇总打勾的记录 GRACE
    /// </summary>
    /// <param name="rowID"></param>
    [DirectMethod]
    public void AddPOData(string rowID)
    {
        DODRowID = rowID;
    }


    /// <summary>
    /// 绑定从POOL页面带过来的数据 GRACE
    /// </summary>
    public void DataBindPO()
    {
        //DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields>() {dal.CreateIFields()
        //            .Append("Option", "Bind")
        //            .Append("DODRowID",DODRowID)
        //            }).GetTable();

        //if (dt != null)
        //{
        //    CmbShipperCode.setValue(dt.Rows[0]["dod_Shipper"].ToString());
        //    CmbShipperCode.Text = dt.Rows[0]["DODShipperName"].ToString();
        //    CmbConsignee.setValue(dt.Rows[0]["dod_Consignee"].ToString());
        //    CmbConsignee.Text = dt.Rows[0]["DODConsigneeName"].ToString();
        //}
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
            if (hidSeed.Text.Length > 1)
            {
                X.AddScript("TransferVoid();");
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            hidMAWB.Text = Request["MBL"] == null ? "" : Request["MBL"];
            ControlBinder.DateFormat(txtCFSClosing);
            ControlBinder.DateFormat(txtCYClosing);
            ControlBinder.DateFormat(txtOnBoard);
            ControlBinder.DateFormat(txtETD);
            ControlBinder.DateFormat(txtOnBoard1);
            ControlBinder.DateFormat(txtETD1);
            ControlBinder.DateFormat(txtETADischarge);
            ControlBinder.DateFormat(txtETAFinal);
            ControlBinder.DateFormat(txtATD);
            ControlBinder.DateFormat(txtBookingDate);
            ControlBinder.DateFormat(txtEstReceipt);
            ControlBinder.DateFormat(txtActReceipt);

        }
    }

    DataFactory dal = new DataFactory();
    readonly string SYS = "OE";

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
    public void StoreVessel_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreVessel, "VesselList");
    }

    public void StoreVoyage_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreVoyage.RemoveAll();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.SelectedItem.Value) }).GetTable();
        StoreVoyage.DataSource = dt;
        StoreVoyage.DataBind();
    }
    #endregion


    void ComList()
    {
        StoreVoyage.RemoveAll();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.SelectedItem.Value) }).GetTable();
        StoreVoyage.DataSource = dt;
        StoreVoyage.DataBind();
        if (dt != null && dt.Rows.Count > 0)
        {
            cmbVesselText.SelectedItem.Value = dt.Rows[0][1].ToString();

            if (cmbPayAt.Value == cmbPort.Value || string.IsNullOrEmpty(cmbPayAt.Value))
            {
                cmbPayAt.setValue(dt.Rows[0][5].ToString());
                X.AddScript("SelectItem('cmbPayAt','txtPayAtL');");
            }

            txtCFSClosing.Text = dt.Rows[0][7].ToString();
            txtCYClosing.Text = dt.Rows[0][8].ToString();
            txtOnBoard.Text = dt.Rows[0][9].ToString();
            txtETD.Text = dt.Rows[0][2].ToString();
            txtETADischarge.Text = dt.Rows[0][3].ToString();
            txtOnBoard1.Text = dt.Rows[0][9].ToString();
            txtETD1.Text = dt.Rows[0][2].ToString();
            CmbReceive.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
            cmbLoading.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
            cmbPort.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            cmbFinalDest.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            txtCarrier.Text = dt.Rows[0][10].ToString();

            hidPort.Text = dt.Rows[0][5].ToString();
        }
        else
        {
            txtCFSClosing.Text = "";
            txtCYClosing.Text = "";
            txtOnBoard.Text = "";
            txtETD.Text = "";
            txtOnBoard1.Text = "";
            txtETD1.Text = "";
            txtETADischarge.Text = "";
            CmbReceive.setValue("");
            cmbLoading.setValue("");
            cmbPort.setValue("");
            cmbFinalDest.setValue("");
            hidPort.Text = "";
        }
    }

    protected void cmbVessel_Select(object sender, DirectEventArgs e)
    {
        cmbVesselText.Text = "";
        ComList();
    }

    protected void cmbVesselText_Select(object sender, DirectEventArgs e)
    {
        if (cmbVesselText.SelectedItem.Value != "")
        {
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageByID").
                Append("STAT",cmbVesselText.SelectedItem.Value) }).GetTable();

            if (cmbPayAt.Value == cmbPort.Value || string.IsNullOrEmpty(cmbPayAt.Value))
            {
                cmbPayAt.setValue(dt.Rows[0][5].ToString());
                X.AddScript("SelectItem('cmbPayAt','txtPayAtL');");
            }

            txtETD.Text = dt.Rows[0][2].ToString();
            txtETD1.Text = dt.Rows[0][2].ToString();
            txtETADischarge.Text = dt.Rows[0][3].ToString();
            CmbReceive.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
            cmbLoading.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
            cmbPort.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            cmbFinalDest.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            txtCFSClosing.Text = dt.Rows[0][6].ToString();
            txtCYClosing.Text = dt.Rows[0][7].ToString();
            txtOnBoard.Text = dt.Rows[0][8].ToString();
            txtOnBoard1.Text = dt.Rows[0][8].ToString();
            txtCarrier.Text = dt.Rows[0][9].ToString();

            hidPort.Text = dt.Rows[0][5].ToString();
        }
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
            txtETD1.Text = dt.Rows[0][2].ToString();
            txtETADischarge.Text = dt.Rows[0][3].ToString();
            CmbReceive.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
            cmbLoading.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][4].ToString()));
            cmbPort.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            cmbFinalDest.setValue(BaseCheckCode.locationCheckCode(dt.Rows[0][5].ToString()));
            txtCFSClosing.Text = dt.Rows[0][6].ToString();
            txtCYClosing.Text = dt.Rows[0][7].ToString();
            txtOnBoard.Text = dt.Rows[0][8].ToString();
            txtOnBoard1.Text = dt.Rows[0][8].ToString();
            txtCarrier.Text = dt.Rows[0][9].ToString();

            hidPort.Text = dt.Rows[0][5].ToString();
        }
    }

    [DirectMethod]
    public void ShowVoyage()
    {
        X.AddScript("ShowVoyage('" + cmbVesselCode.SelectedItem.Value + "','" + cmbVesselText.SelectedItem.Value + "');");
    }



    #region   ComboBoxBinding()    Author ：Hcy   (2011-09-27)
    private void ComboBoxBinding()
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", SYS[0].ToString());
        o_unit.Template.Html = Template.Html;
        
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","O") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

        ControlBinder.CmbBinder(StoreVessel, "VesselList");

        ControlBinder.CmbBinder(StoreKind, "QtyKindBinding", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreDept, "DeptBinding", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreForeignKind, "ForeignKind", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreShipKind, "ShipKind", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreCompanyKind, "CompanyKind", SYS[0].ToString());
        ControlBinder.CmbBinder(StorePPCC, "PPCCList", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreServiceMode, "ServerMode", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", SYS[0].ToString());
        cmbVesselText.Template.Html = TempVoyage.Html;

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

    #region   DataBinding()    Author ：Hcy   (2011-09-27)
    private void DataBindList()
    {
        hidMAWB.Text = Request["MBL"] == null ? Request["Jobseed"] : Request["MBL"];
        
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "List")
            .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS", SYS)
            .Append("o_ToMBL", hidMAWB.Text)
            .Append("o_LocPOL", FSecurityHelper.CurrentUserDataGET()[4])
            );
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", Getlist).GetList();
        if (ds != null && hidSeed.Text.Length > 1)
        {
            

            string temphawb = ds.Tables[0].Rows[0]["HBL"].ToString().ToUpper() == "" ? "" : "HBL# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["HBL"].ToString().ToUpper() + "</span>";
            string tempmawb = ds.Tables[0].Rows[0]["MBL"].ToString().ToUpper() == "" ? "" : "MBL# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["MBL"].ToString().ToUpper() + "</span>";
            string tempLotNo = ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() == "" ? "" : "Lot# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() + "</span>";
            labHeader.Html = "Book# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["BookNo"].ToString().ToUpper() + "</span>" + (temphawb == "" ? "" : "<span style='padding-left:10px'>" + temphawb + "</span>") + (tempmawb == "" ? "" : "<span style='padding-left:10px'>" + tempmawb + "</span>") + (tempLotNo == "" ? "" : "<span style='padding-left:10px'>" + tempLotNo + "</span>");
            labImpLotNo.Text = ds.Tables[0].Rows[0]["BookNo"].ToString();
            hidLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();//LotNo

            hidHawb.Text = ds.Tables[0].Rows[0]["HBL"].ToString();

            txtHawb.Text = ds.Tables[0].Rows[0]["HBL"].ToString();
            CmbService.setValue(ds.Tables[0].Rows[0]["ServiceMode"]);
            CmbPPD.SelectedItem.Value = ds.Tables[0].Rows[0]["PPD"].ToString();
            CmbSalesman.setValue(ds.Tables[0].Rows[0]["Salesman"]);
            txtBookingDate.Text = ds.Tables[0].Rows[0]["BookDate"].ToString();
            txtActReceipt.Text = ds.Tables[0].Rows[0]["ActReceipt"].ToString();
            txtEstReceipt.Text = ds.Tables[0].Rows[0]["EstReceipt"].ToString();
            txtCarrier.Text = ds.Tables[0].Rows[0]["Carrier"].ToString();
            chkDG.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DG"]);
            chkLocation.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["SameLocation"]);
            chkDate.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["SameDate"]);

            chkSBSReceive.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["o_SBSReceipt"]);
            
            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Shipper"].ToString());
            CmbShipperCode.Text = ds.Tables[0].Rows[0]["ShipperName"].ToString();
            CmbConsignee.setValue(ds.Tables[0].Rows[0]["Consignee"].ToString());
            CmbConsignee.Text = ds.Tables[0].Rows[0]["ConsigneeName"].ToString();

            CmbNotify1.setValue(ds.Tables[0].Rows[0]["Notify1"].ToString());
            CmbNotify1.Text = ds.Tables[0].Rows[0]["Notify1Name"].ToString();
            CmbNotify2.setValue(ds.Tables[0].Rows[0]["Notify2"].ToString());
            CmbNotify2.Text = ds.Tables[0].Rows[0]["Notify2Name"].ToString();

            CmbAgent.setValue(ds.Tables[0].Rows[0]["Agent"].ToString());
            CmbAgent.Text = ds.Tables[0].Rows[0]["AgentName"].ToString();
            CmbBroker.setValue(ds.Tables[0].Rows[0]["Broker"].ToString());
            CmbBroker.Text = ds.Tables[0].Rows[0]["BrokerName"].ToString();
            CmbShipTo.setValue(ds.Tables[0].Rows[0]["ShipTo"].ToString());
            CmbShipTo.Text = ds.Tables[0].Rows[0]["ShipToName"].ToString();

            cmbVesselCode.SelectedItem.Value = ds.Tables[0].Rows[0]["Vessel"].ToString();
            StoreVoyage.RemoveAll();
            
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
            StoreVoyage.DataSource = dt;
            StoreVoyage.DataBind();
            if (dt != null && dt.Rows.Count > 0)
            {
                cmbVesselText.SelectedItem.Value = ds.Tables[0].Rows[0]["Voyage"].ToString();
            }

            CmbReceive.setValue(ds.Tables[0].Rows[0]["Receipt"].ToString());
            cmbLoading.setValue(ds.Tables[0].Rows[0]["Loading"].ToString());
            cmbPort.setValue(ds.Tables[0].Rows[0]["Port"].ToString());
            hidPort.Text = ds.Tables[0].Rows[0]["Port"].ToString();
            cmbFinalDest.setValue(ds.Tables[0].Rows[0]["FinalDest"].ToString());

            txtCFSClosing.Text = ds.Tables[0].Rows[0]["CFS"].ToString();
            txtCYClosing.Text = ds.Tables[0].Rows[0]["CY"].ToString();
            txtOnBoard.Text = ds.Tables[0].Rows[0]["OnBoard"].ToString();
            txtETD.Text = ds.Tables[0].Rows[0]["ETD"].ToString();
            txtOnBoard1.Text = ds.Tables[0].Rows[0]["OnBoard"].ToString();
            txtETD1.Text = ds.Tables[0].Rows[0]["ETD"].ToString();
            txtETADischarge.Text = ds.Tables[0].Rows[0]["ETAdischarge"].ToString();
            txtETAFinal.Text = ds.Tables[0].Rows[0]["ETAFinal"].ToString();
            txtATD.Text = ds.Tables[0].Rows[0]["ATD"].ToString();

            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
                txtCGWT.Text = ds.Tables[0].Rows[0]["GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["AWT"].ToString()))
                txtAGWT.Text = ds.Tables[0].Rows[0]["AWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CBM"].ToString()))
                txtCCBM.Text = ds.Tables[0].Rows[0]["CBM"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["ACBM"].ToString()))
                txtACBM.Text = ds.Tables[0].Rows[0]["ACBM"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["PKGS"].ToString()))
                txtCPiece.Text = ds.Tables[0].Rows[0]["PKGS"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["APKGS"].ToString()))
                txtAPiece.Text = ds.Tables[0].Rows[0]["APKGS"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["WM"].ToString()))
                txtCWM.Text = ds.Tables[0].Rows[0]["WM"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["AWM"].ToString()))
                txtAWM.Text = ds.Tables[0].Rows[0]["AWM"].ToString();
            CmbUnit.setValue(ds.Tables[0].Rows[0]["Unit"].ToString());
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Container"].ToString()))
                txtContainer.Text = ds.Tables[0].Rows[0]["Container"].ToString();


            cmbIssue.setValue(ds.Tables[0].Rows[0]["o_Issue"].ToString());
            cmbPayAt.setValue(ds.Tables[0].Rows[0]["o_PayAt"].ToString());
            txtIssueL.Text = ds.Tables[0].Rows[0]["o_IssueLine"].ToString();
            txtPayAtL.Text = ds.Tables[0].Rows[0]["o_PayAtLine"].ToString();
            cmbCurrency.SelectedItem.Value = ds.Tables[0].Rows[0]["o_BLCurrency"].ToString();
            txtRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();

            txtSubMBL.Text = ds.Tables[0].Rows[0]["subMBL"].ToString();
                

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
                X.AddScript("$('#showContainer').hide();");
            }

            
            //Vessel and Voyage
            if (cmbVesselCode.SelectedItem.Value != "" && cmbVesselCode.SelectedItem.Value != "0")
            {
                cmbVesselCode.Disabled = true;
            }
            if (cmbVesselText.SelectedItem.Value != "" && cmbVesselText.SelectedItem.Value != "0")
            {
                cmbVesselText.Disabled = true;
            }
            
            //产生Hawb Status Lock
            if(ds.Tables[0].Rows[0]["HawbFlag"].ToString()=="1")
            {
                labReceive.Text = ds.Tables[0].Rows[0]["Receipt"].ToString();
                labLoading.Text = ds.Tables[0].Rows[0]["Loading"].ToString();
                labPort.Text = ds.Tables[0].Rows[0]["Port"].ToString();
                labFinalDest.Text = ds.Tables[0].Rows[0]["FinalDest"].ToString();
                X.AddScript("$('#showCmbReceive,#showcmbLoading,#showcmbPort,#showcmbFinalDest').hide();");
                labReceive.Show();
                labLoading.Show();
                labPort.Show();
                labFinalDest.Show();
            }

            GridPanelInvoice.GetStore().DataSource = ds.Tables[1];
            GridPanelInvoice.GetStore().DataBind();

            if (ds.Tables[2].Rows.Count > 0)
            {
                GridPanelContainer.GetStore().DataSource = ds.Tables[2];
                GridPanelContainer.GetStore().DataBind();

                double GWT = 0.000, Pieces = 0, CBM = 0.000, wm = 0.000;
                for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                {
                    GWT += Convert.ToDouble(ds.Tables[2].Rows[i]["GWT"].ToString() == "" ? "0.000" : ds.Tables[2].Rows[i]["GWT"].ToString());
                    Pieces += Convert.ToDouble(ds.Tables[2].Rows[i]["PKG"].ToString() == "" ? "0" : ds.Tables[2].Rows[i]["PKG"].ToString());
                    CBM += Convert.ToDouble(ds.Tables[2].Rows[i]["CBM"].ToString() == "" ? "0.000" : ds.Tables[2].Rows[i]["CBM"].ToString());
                    wm += Convert.ToDouble(ds.Tables[2].Rows[i]["WM"].ToString() == "" ? "0.000" : ds.Tables[2].Rows[i]["WM"].ToString());
                }
                if (Pieces.ToString() != "0") { txtAPiece.Text = Pieces.ToString(); }
                if (GWT.ToString() != "0") { txtAGWT.Text = GWT.ToString(); }
                if (CBM.ToString() != "0") { txtACBM.Text = CBM.ToString(); }
                if (wm.ToString() != "0") { txtAWM.Text = wm.ToString(); }
            }

            GridPanelOther.GetStore().DataSource = ds.Tables[3];
            GridPanelOther.GetStore().DataBind();

            

            GridPanelContact.GetStore().DataSource = ds.Tables[5];
            GridPanelContact.GetStore().DataBind();

        }
        else
        {
            imgHBL.Disabled = false;
            if (ds.Tables[0].Rows.Count > 0)
            {
                string tempmawb = ds.Tables[0].Rows[0]["MBL"].ToString().ToUpper() == "" ? "" : "MBL# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["MBL"].ToString().ToUpper() + "</span>";
                string tempLotNo = ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() == "" ? "" : "Lot# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() + "</span>";
                labHeader.Html = (tempmawb == "" ? "" : "<span style='padding-left:10px'>" + tempmawb + "</span>") + (tempLotNo == "" ? "" : "<span style='padding-left:10px'>" + tempLotNo + "</span>");
                hidLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();

                CmbUnit.Value = ds.Tables[0].Rows[0]["Unit"].ToString();
                CmbPPD.SelectedItem.Value = ds.Tables[0].Rows[0]["PPD"].ToString();
                //cmbLoading.Value = ds.Tables[0].Rows[0]["Loading"].ToString();
                txtBookingDate.Text = ds.Tables[0].Rows[0]["BookDate"].ToString();
                //txtOnBoard.Text = ds.Tables[0].Rows[0]["OnBoard"].ToString();
                //txtOnBoard1.Text = ds.Tables[0].Rows[0]["OnBoard"].ToString();

                chkLocation.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["SameLocation"]);
                chkDate.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["SameDate"]);
                cmbVesselCode.SelectedItem.Value = ds.Tables[0].Rows[0]["Vessel"].ToString();
                StoreVoyage.RemoveAll();

                DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
                StoreVoyage.DataSource = dt;
                StoreVoyage.DataBind();
                if (dt != null && dt.Rows.Count > 0)
                {
                    cmbVesselText.SelectedItem.Value = ds.Tables[0].Rows[0]["Voyage"].ToString();
                }
                txtCarrier.Text = ds.Tables[0].Rows[0]["Carrier"].ToString();
                CmbReceive.setValue(ds.Tables[0].Rows[0]["Receipt"].ToString());
                cmbLoading.setValue(ds.Tables[0].Rows[0]["Loading"].ToString());
                cmbPort.setValue(ds.Tables[0].Rows[0]["Port"].ToString());
                cmbFinalDest.setValue(ds.Tables[0].Rows[0]["FinalDest"].ToString());

                txtCFSClosing.Text = ds.Tables[0].Rows[0]["CFS"].ToString();
                txtCYClosing.Text = ds.Tables[0].Rows[0]["CY"].ToString();
                txtOnBoard.Text = ds.Tables[0].Rows[0]["OnBoard"].ToString();
                txtETD.Text = ds.Tables[0].Rows[0]["ETD"].ToString();
                txtOnBoard1.Text = ds.Tables[0].Rows[0]["OnBoard"].ToString();
                txtETD1.Text = ds.Tables[0].Rows[0]["ETD"].ToString();
                txtETADischarge.Text = ds.Tables[0].Rows[0]["ETAdischarge"].ToString();
                txtETAFinal.Text = ds.Tables[0].Rows[0]["ETAFinal"].ToString();
                txtATD.Text = ds.Tables[0].Rows[0]["ATD"].ToString();

                cmbIssue.Value = ds.Tables[0].Rows[0]["o_Issue"].ToString();
                txtIssueL.Text = ds.Tables[0].Rows[0]["o_IssueLine"].ToString();
                cmbCurrency.SelectedItem.Value = ds.Tables[0].Rows[0]["o_BLCurrency"].ToString();
                hidPort.Text = ds.Tables[0].Rows[0]["Port"].ToString();

                cmbPayAt.Value = ds.Tables[0].Rows[0]["o_PayAt"].ToString();
                txtPayAtL.Text = ds.Tables[0].Rows[0]["o_PayAtLine"].ToString();

                txtSubMBL.Text = ds.Tables[0].Rows[0]["subMBL"].ToString();

            }
        }
        

        if (!string.IsNullOrEmpty(Request["seed"]))
            ControlBinder.pageTitleMsg(false, "OE-H:" + labImpLotNo.Text, "<p>Status : Edit HBL of  <span>" + labImpLotNo.Text + "</span>. </p>", div_bottom);
        else
            ControlBinder.pageTitleMsg(false, "OE-H New", "<p>Status : New Blank HBL . </p>", div_bottom);
        
        //cmbVesselCode.Focus();
        //X.AddScript("getSelectPos('cmbVesselCode');");
       

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

        if (!VoidCheckAC.CheckisAC("OE", hidSeed.Text))
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
                ControlBinder.pageTitleMsg(false, "OE-H:" + labImpLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
            }

            DataBindList();
            ControlBinder.pageTitleMsg(true, "OE-H:" + labImpLotNo.Text, "<p>Status : Edit HBL of  <span>" + labImpLotNo.Text + "</span>. </p>", div_bottom);
        }
    }

    #region    btnSave_Click()     Author：Hcy   (2011-09-09)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        //HBL Check
        string checkhawb=txtHawb.Text.Trim().ToUpper();


        #region ///Check HBL NO   Michael Chien  2014-04-08
        string isCheckFlag =OEHandler.ValidHBL(hidHawb.Text,checkhawb,hidSeed.Text);
        if (isCheckFlag == "S")
        {
            ControlBinder.pageTitleMsg(false, "OE-H:" + labImpLotNo.Text, "<p class=\"error\">Status:Can change the discharge port code on the auto-generated HBL only.</p>", div_bottom);
            txtHawb.Focus();
            txtHawb.SelectText(txtHawb.Text.Length);
            return;
        }
        else if (isCheckFlag == "Y")
        {
            ControlBinder.pageTitleMsg(false, "OE-H:" + labImpLotNo.Text, "<p class=\"error\">Status: The input value already exists .</p>", div_bottom);
            txtHawb.Focus();
            txtHawb.SelectText(txtHawb.Text.Length);
            return;
        }
        #endregion

        //if (chkLocation.Checked && hidMAWB.Text != "" && checkhawb.Length == 12 )
        //{
        //    DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", new List<IFields>() { 
        //        dal.CreateIFields().Append("Option", "MakeNewHBL").Append("o_ToMBL", hidMAWB.Text).Append("User", FSecurityHelper.CurrentUserDataGET()[0])
        //        .Append("o_STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("o_HBL",checkhawb).Append("o_LocPOD","")   
        //        .Append("o_ETD",ControlBinder.getDate(txtETD.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETD.RawText))}).GetList();
        //    if (ds != null)
        //    {
        //        if (ds.Tables[0].Rows[0][1].ToString() == "Y")
        //        {
        //            checkhawb = ds.Tables[0].Rows[0][0].ToString();
        //            X.Msg.Alert("Information", "HBL No has been change from " + txtHawb.Text.Trim().ToUpper() + " to " + checkhawb).Show();
        //        }
        //    }
        //}
        //else if (checkhawb.Length == 12 && !string.IsNullOrEmpty(cmbPort.Value) && checkhawb.Substring(2, 3) != cmbPort.Value)
        //{
        //    DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", new List<IFields>() { 
        //        dal.CreateIFields().Append("Option", "MakeNewHBL").Append("o_ToMBL", hidMAWB.Text).Append("User", FSecurityHelper.CurrentUserDataGET()[0])
        //        .Append("o_STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("o_HBL",checkhawb).Append("o_LocPOD",cmbPort.Value)  
        //        .Append("o_ETD",ControlBinder.getDate(txtETD.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETD.RawText))}).GetList();
        //    if (ds != null)
        //    {
        //        if (ds.Tables[0].Rows[0][1].ToString() == "Y")
        //        {
        //            checkhawb = ds.Tables[0].Rows[0][0].ToString();
        //            X.Msg.Alert("Information", "HBL No has been change from " + txtHawb.Text.Trim().ToUpper() + " to " + checkhawb).Show();
        //        }
        //    }
        //}

        
        List<IFields> UpdateHBL = new List<IFields>();
        UpdateHBL.Add(dal.CreateIFields().Append("Option", "UpdateHBL")
            .Append("Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("o_ToMBL", hidMAWB.Text == "" ? null : hidMAWB.Text)

            .Append("o_Carrier", txtCarrier.Text)
            .Append("o_VesselID", cmbVesselCode.SelectedItem.Value)
            .Append("o_VoyageID", cmbVesselText.SelectedItem.Value)


            //.Append("o_HBL", txtHawb.Text.Trim().ToUpper())
            .Append("o_HBL", checkhawb)
            .Append("o_LotNo", hidLotNo.Text)
            .Append("o_ServiceMode", string.IsNullOrEmpty(CmbService.Value) ? null : CmbService.Value.Trim().ToUpper())
            .Append("o_PaymentMode", CmbPPD.SelectedItem.Value)
            .Append("o_Sales", CmbSalesman.Value)

            .Append("o_Shipper", CmbShipperCode.Value)
            .Append("o_Consignee", CmbConsignee.Value)
            .Append("o_PartyA", CmbNotify1.Value)
            .Append("o_PartyB", CmbNotify2.Value)
            .Append("o_Agent", CmbAgent.Value)
            .Append("o_Broker", CmbBroker.Value)
            .Append("o_ShipTo",CmbShipTo.Value)

            .Append("o_LocReceipt", CmbReceive.Value)
            .Append("o_LocPOL", cmbLoading.Value)
            .Append("o_LocPOD", cmbPort.Value)
            .Append("o_LocFinal", cmbFinalDest.Text)

            .Append("o_ScheduleDate", ControlBinder.getDate(txtOnBoard.RawText.StartsWith("0001") ? DBNull.Value : (object)txtOnBoard.RawText))
            .Append("o_ETD", ControlBinder.getDate(txtETD.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETD.RawText))
            .Append("o_CFS", ControlBinder.getDate(txtCFSClosing.RawText.StartsWith("0001") ? DBNull.Value : (object)txtCFSClosing.RawText))
            .Append("o_CY", ControlBinder.getDate(txtCYClosing.RawText.StartsWith("0001") ? DBNull.Value : (object)txtCYClosing.RawText))
            .Append("o_ScheduleDate", ControlBinder.getDate(txtOnBoard1.RawText.StartsWith("0001") ? DBNull.Value : (object)txtOnBoard1.RawText))
            .Append("o_ETD", ControlBinder.getDate(txtETD1.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETD1.RawText))
            .Append("o_ETA", ControlBinder.getDate(txtETADischarge.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETADischarge.RawText))
            .Append("o_ETAFinal", ControlBinder.getDate(txtETAFinal.RawText.StartsWith("0001") ? DBNull.Value : (object)txtETAFinal.RawText))
            .Append("o_ATD", ControlBinder.getDate(txtATD.RawText.StartsWith("0001") ? DBNull.Value : (object)txtATD.RawText))


           .Append("o_CWT", string.IsNullOrEmpty(txtCGWT.Text) ? DBNull.Value : (object)txtCGWT.Text)
            .Append("o_AWT", string.IsNullOrEmpty(txtAGWT.Text) ? DBNull.Value : (object)txtAGWT.Text)
            .Append("o_CCBM", string.IsNullOrEmpty(txtCCBM.Text) ? DBNull.Value : (object)txtCCBM.Text)
            .Append("o_ACBM", string.IsNullOrEmpty(txtACBM.Text) ? DBNull.Value : (object)txtACBM.Text)
            .Append("o_CPKGS", string.IsNullOrEmpty(txtCPiece.Text) ? DBNull.Value : (object)txtCPiece.Text)
            .Append("o_APKGS", string.IsNullOrEmpty(txtAPiece.Text) ? DBNull.Value : (object)txtAPiece.Text)
            .Append("o_CWM", string.IsNullOrEmpty(txtCWM.Text) ? DBNull.Value : (object)txtCWM.Text)
            .Append("o_AWM", string.IsNullOrEmpty(txtAWM.Text) ? DBNull.Value : (object)txtAWM.Text)
            .Append("o_Unit", CmbUnit.Value)

            .Append("o_EReceiptDate", ControlBinder.getDate(txtEstReceipt.RawText.StartsWith("0001") ? DBNull.Value : (object)txtEstReceipt.RawText))
            .Append("o_AReceiptDate", ControlBinder.getDate(txtActReceipt.RawText.StartsWith("0001") ? DBNull.Value : (object)txtActReceipt.RawText))
            .Append("o_SameLocation", chkLocation.Checked)
            .Append("o_SameDate", chkDate.Checked)
            .Append("o_DG", chkDG.Checked)
            .Append("o_Issue", cmbIssue.Value)
            .Append("o_PayAt", cmbPayAt.Value)
            .Append("o_IssueLine", txtIssueL.Text.Trim().ToUpper())
            .Append("o_PayAtLine", txtPayAtL.Text.Trim().ToUpper())
            .Append("o_BLCurrency", cmbCurrency.SelectedItem.Value)
            .Append("o_Remark", txtRemark.Text.Trim())

            .Append("o_SBSReceipt", chkSBSReceive.Checked)

            .Append("subMBL",txtSubMBL.Text.Trim().ToUpper())

            .Append("o_STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("o_SYS", SYS)
            .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
            .Append("code", FSecurityHelper.CurrentUserDataGET()[4] + "OEBK")
            );
        try
        {
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
            //dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("oc_Seed", hidSeed.Text).Append("IDList", conRowID) }).Update();
            #endregion

            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", UpdateHBL).GetList();
            hidSeed.Text = ds.Tables[0].Rows[0][0].ToString();
            string newFlag = ds.Tables[0].Rows[0][1].ToString();
            string status = ds.Tables[0].Rows[0]["Status"].ToString();

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
            //dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Invoice_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualLocal").Append("inv_Seed", hidSeed.Text == "" ? null : hidSeed.Text).Append("str", invRowID) }).Update();

            #endregion

            #region Other
            var Other = JSON.Deserialize<List<Other>>(e.ExtraParams["p_safety_l"]);
            List<IFields> Otherlist = new List<IFields>();
            string OtherID = "";
            for (int i = 0; i < Other.Count; ++i)
            {
                Otherlist.Add(dal.CreateIFields().Append("Option", "UpdateOther").
                Append("si_PPCC", Other[i].PPD).
                Append("si_BillTo", Other[i].CompanyCode).
                Append("si_Total", string.IsNullOrEmpty(Other[i].Total) ? DBNull.Value : (object)Other[i].Total).
                Append("si_Item", Other[i].Item).
                Append("si_Description", Other[i].Description).
                Append("si_QtyKind", Other[i].CalcKind).
                Append("si_Quantity", string.IsNullOrEmpty(Other[i].Qty) ? DBNull.Value : (object)Other[i].Qty).
                Append("si_Unit", Other[i].Unit).
                Append("si_Currency", Other[i].Currency.ToUpper()).
                Append("si_ExRate", string.IsNullOrEmpty(Other[i].EX) ? DBNull.Value : (object)Other[i].EX).
                Append("si_Rate", string.IsNullOrEmpty(Other[i].Rate) ? DBNull.Value : (object)Other[i].Rate).
                Append("si_Amount", string.IsNullOrEmpty(Other[i].Amount) ? DBNull.Value : (object)Other[i].Amount).
                Append("si_Percent", string.IsNullOrEmpty(Other[i].Percent) ? DBNull.Value : (object)Other[i].Percent).
                Append("si_ShowIn", Other[i].Show).
                Append("si_ROWID", Other[i].RowID)
                .Append("si_ToHouse", hidSeed.Text == "" ? null : hidSeed.Text)
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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_ShipmentItem_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("si_Seed", hidSeed.Text == "" ? null : hidSeed.Text).Append("si_Type", "OTHER").Append("str", OtherID) }).Update();

            bool resultOther = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_ShipmentItem_SP", Otherlist).Update();
            #endregion

            #region Costing
            //X.AddScript("saveCost('" + hidSeed.Text + "');");

            ucCost.costseed = hidSeed.Text;
            ucCost.btnCostEvent(sender, e);
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
                Append("sc_Dept", ContactInformation[i].Dept.ToUpper()).
                Append("sc_RowID", ContactInformation[i].RowID)
                .Append("sc_ToHouse", hidSeed.Text == "" ? null : hidSeed.Text)
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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_ShipmentContact_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActual").Append("sc_Seed", hidSeed.Text == "" ? null : hidSeed.Text).Append("str", ContactinformationID) }).Update();
            bool resultContactInformation = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_ShipmentContact_SP", ContactInformationlist).Update();
            #endregion

            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "OE", "HBL");
            if (newFlag == "Y")
            {
                if (!b)
                {
                    if (status != "N" && hidTran.Text=="FALSE")
                    {
                        X.AddScript("window.open('../OEAssignJob/List.aspx?seed=" + ds.Tables[0].Rows[0][2] + "','_blank');");
                    }
                    string jobtype = "", jobseed = "", jobidlist = "", idlist = "";
                    jobtype = Request["JobType"];
                    idlist = ds.Tables[0].Rows[0][0].ToString();
                    if (jobtype == "job")
                    {
                        jobseed = Request["Jobseed"];
                        jobidlist = Server.UrlDecode(Request["JobIDList"]);
                        idlist += "," + jobidlist;
                        X.AddScript("window.dialogArguments.refreshdata(\"" + jobseed + "\",\"" + idlist + "\");window.close();");
                    }
                    else if (jobtype == "p")
                    {
                        //修改PO页面记录的BookingNo  GRACE
                        #region updatePOBookingNo
                        dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateBookingNO")
                            .Append("DODBookingNo",ds.Tables[0].Rows[0][4]).Append("DODRowID",DODRowID).Append("Master", DBNull.Value).Append("House",ds.Tables[0].Rows[0][0])}).Update();
                        #endregion
                        //X.AddScript("window.dialogArguments.location.href='../../DeliveryOrder/DOPool/List.aspx?';window.close();");
                        X.AddScript("window.opener.$('#btnSearch').click();");
                        X.Redirect("List.aspx?seed=" + ds.Tables[0].Rows[0][0] + "&MBL=" + ds.Tables[0].Rows[0][2].ToString());
                    }
                    else
                    {
                        X.Redirect("List.aspx?seed=" + ds.Tables[0].Rows[0][0] + "&MBL=" + ds.Tables[0].Rows[0][2].ToString());
                    }
                }
                else
                {
                    X.Redirect("List.aspx?MBL=" + Request["MBL"]);
                }
            }
            else
            {
                if (b)
                {
                    X.Redirect("List.aspx?MBL=" + Request["MBL"]);
                }
                else
                {
                    if (status == "S" && hidTran.Text=="FALSE")
                    {
                        X.AddScript("window.open('../OEAssignJob/List.aspx?seed=" + ds.Tables[0].Rows[0][2] + "','_blank');");
                    }

                    //修改PO页面记录的BookingNo  GRACE
                    #region updatePOBookingNo
                    dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateBookingNO")
                            .Append("DODBookingNo",hidLotNo.Text).Append("DODRowID",DODRowID).Append("Master", DBNull.Value).Append("House",hidSeed.Text)}).Update();
                    #endregion

                    DataBindList();

                    
                //    DataTable  dtMblSeed= dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysTranshipment_SP", new List<IFields>() { dal.CreateIFields()
                //.Append("Option", "GetMblSeed")
                //.Append("HBLSeed", Request["Seed"]=="0"?(object)DBNull.Value:(object)Request["seed"] )}).GetTable();
                //    if (dtMblSeed != null && dtMblSeed.Rows.Count>0)
                //    {
                //        X.Redirect("List.aspx?MBL=" + dtMblSeed.Rows[0][0] + "&seed=" + Request["seed"]);
                //    }
                }
            }

            ControlBinder.pageTitleMsg(true, "OE-H:" + labImpLotNo.Text, "<p class=\"success\">Status : Record Saved with  <span>" + labImpLotNo.Text + " </span> </p>", div_bottom);
            X.AddScript("if(top.opener!= null&&top.opener!= undefined && top.opener.parent.length > 0){if(top.opener.parent.$('#ifmContent').attr('src') == '/OceanExport/OEShipmentList/List.aspx'){top.opener.parent.document.getElementById('ifmContent').contentWindow.location.reload();}if(top.opener.parent.WinView == null ||top.opener.parent.WinView == undefined){if(window.parent.Window10 !=null ||window.parent.Window10 !=undefined){window.parent.Window10.reload();}}else{top.opener.parent.WinView.reload();if(top.opener.parent.winHblList != null && top.opener.parent.winHblList != undefined){top.opener.parent.winHblList.reload();}}}");
        }
        catch
        {
            ControlBinder.pageTitleMsg(false, "OE-H:" + labImpLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
        }

    }
    #endregion

    #region    btnNext_Click()     Author：Hcy   (2011-09-27)
    bool b = false;
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        b = true;
        btnSave_Click(sender, e);
    }
    #endregion

    #region    btnRelease_Click()
    protected void btnRelease_Click(object sender, DirectEventArgs e)
    {
        if (hidisACorPrint.Text == "true")
        {
            X.Msg.Alert("Information", "Sorry,this shipment can't be releaseed!").Show();
        }
        else
        {
            X.Msg.Confirm("Information", "Do you want to release and cancel this transhipment?", "if (buttonId == 'yes') { CompanyX.btnRelease_Click(); }").Show();
        }
    }
    #endregion

    [DirectMethod]
    public void btnRelease_Click()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysTranshipment_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "Release")
                .Append("HBLSeed", Request["seed"]=="0"?(object)DBNull.Value:(object)Request["seed"] )}).GetTable();


        if (dt == null || dt.Rows.Count < 1)
        {
            //X.Msg.Alert("Information", "Success !").Show();
            //X.AddScript("if(top.opener.parent.winHblList != null && top.opener.parent.winHblList != undefined){top.opener.parent.winHblList.reload();} if(top.opener.parent.$('#ifmContent').attr('src') == '/OceanExport/OEShipmentList/List.aspx'){top.opener.parent.document.getElementById('ifmContent').contentWindow.location.reload();}if(top.opener.parent.WinView == null ||top.opener.parent.WinView == undefined){if(window.parent.Window10 !=null ||window.parent.Window10 !=undefined){window.parent.Window10.reload();}}else{top.opener.parent.WinView.reload();}alert(window);window.opener=null;window.open('','_self');window.close();");
            X.AddScript("if(top.opener!= null&&top.opener!= undefined && top.opener.parent.$('#ifmContent').length > 0){if(top.opener.parent.$('#ifmContent').attr('src') == '/OceanExport/OEShipmentList/List.aspx'){top.opener.parent.document.getElementById('ifmContent').contentWindow.location.reload();}if(top.opener.parent.WinView == null ||top.opener.parent.WinView == undefined){if(window.parent.Window10 !=null ||window.parent.Window10 !=undefined){window.parent.Window10.reload();}}else{top.opener.parent.WinView.reload();if(top.opener.parent.winHblList != null && top.opener.parent.winHblList != undefined){top.opener.parent.winHblList.reload();}}}window.opener=null;window.open('','_self');window.close();");
        }
        else
        {
            X.Msg.Alert("Information", "Sorry failed!").Show();
        }

    }
    /// <summary>
    /// Grace add DO 按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnOpen_Click(object sender, DirectEventArgs e)
    {
        X.AddScript("window.showModalDialog('../../DeliveryOrder/DOPool/List.aspx?isok=1',window,'dialogWidth=980px,dialogHeight=750px,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,directories=no,resizable=no');");

    }
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
    //    string url = "../../AirImport/AIShipmentJobList/invoice.aspx?sys=OE&H=" + Request["seed"] + "&Company=" + CmbCompany.Value + "&Currency=" + CmbCurrency.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
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
    //            Append("inv_Sys","O") }).GetTable();
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



    protected void CompanyNameSelect_AfterEdit(object sender, DirectEventArgs e)
    {
        RowSelectionModel sm = this.GridPanelOther.SelectionModel.Primary as RowSelectionModel;
        int index = sm.SelectedRow.RowIndex;
        var data = JSON.Deserialize<Other>(e.ExtraParams["CompanyNameSelect"]);
        this.StoreOther.UpdateRecordField(index, "", data.CompanyCode);
    }

    protected void imgHBL_Click(object sender, DirectEventArgs e)
    {
        if (txtHawb.Text.Trim() == "")
        {
            X.AddScript("CompanyX.ShowHbl('0');");
        }
        else
        {
            X.AddScript("CompanyX.ShowHbl('1');");
        }
    }

    [DirectMethod]
    public void ShowHbl(string type)
    {
        var win = new Window
        {
            ID = "winAutoHBL",
            Title = "",
            Icon = Icon.Application,
            Constrain = true,
            Modal = true,
            BodyStyle = "background-color: #fff;",
            Padding = 5,
            Resizable = false,
            Draggable = true,
            Width = Unit.Pixel(245),
            Height = Unit.Pixel(285)

        };

        win.AutoLoad.Url = "MakeHBL.aspx?Type=" + type + "&VesselID=" + cmbVesselCode.Value + "&VoyageID=" + cmbVesselText.Value + "&Vessel=" + Server.UrlEncode(cmbVesselCode.SelectedItem.Text) + "&Voyage=" + Server.UrlEncode(cmbVesselText.SelectedItem.Text) + "&ETD=" + Server.UrlEncode(txtETD.RawText.Trim()) + "&POD=" + Server.UrlEncode(cmbPort.Value) + "&IsTran=" + hidTran.Text;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Render();
        win.Show();
    }

    [DirectMethod]
    public void SetHBL(string lotno, string hbl, string type)
    {
        if (hidLotNo.Text == "")
        {
            hidLotNo.Text = lotno;
        }
        if (txtHawb.Text.Trim() == "")
        {
            txtHawb.Text = hbl;
            hidHawb.Text = hbl;
        }
        imgHBL.Disabled = true;
        if (type == "2" || type == "3" || type == "4")
        {
            X.AddScript("Ext.getCmp('btnSave').fireEvent('click', this);");
        }
    }
}
