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


public partial class AirImport_AIShipmentJobList_mawb : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!X.IsAjaxRequest)
        {
            hidRowID.Text = string.IsNullOrEmpty(Request["seed"]) ? "0" : Request["seed"];   
            hidSeed.Text = string.IsNullOrEmpty(Request["seed"]) ? "0" : Request["seed"];

        }

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                ControlBinder.DateFormat(txtATA);
                ControlBinder.DateFormat(txtATD);
                ControlBinder.DateFormat(txtETA);
                ControlBinder.DateFormat(txtETD);
                ControlsInit();
                ComboBoxBinder();
                GridListBinder();
                DataBinder();
                UnVoid();
                LockControl();
                //X.AddScript("showCompanyRemark('CmbShipperCode,CmbConsigneeCode,CmbNotify1Code,CmbNotify2Code', 'Shipper,Consignee,Notify #1,Notify #2');");
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
    #endregion
    /// <summary>
    /// DataFactory  全局变量
    /// </summary>
    DataFactory dal = new DataFactory();


    #region  ///刷新数据源

    /// <summary>
    /// 刷新数据源
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    public void StoreUnit_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsUnit = GetList("UnitBinding");
        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();

    }

    public void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsLocation = GetList("LocationList");
        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();
    }

    public void StoreSales_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsSales = GetList("SalesList");
        StoreSalesman.DataSource = dsSales;
        StoreSalesman.DataBind();
    }

    public void StoreItem_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

    }

    public void StoreCurrInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreCurrInvoice.DataSource = GetList("CurrencysInvoice");
        StoreCurrInvoice.DataBind();

        DataSet dsCurrency = GetList("CurrencysList");
        StoreCurrency.DataSource = dsCurrency;
        StoreCurrency.DataBind();
    }

    public void StoreKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsKind = GetList("QtyKindBinding");
        StoreKind.DataSource = dsKind;
        StoreKind.DataBind();
    }

    #endregion


    /// <summary>
    /// 绑定ComboBox
    /// </summary>
    #region   ComboBoxBinder()    Author ：Micro   (2011-09-06)
    void ComboBoxBinder()
    {

        //StoreCmb.DataSource = GetList("CompanyList");
        //StoreCmb.DataBind();

        //StoreCmbName.DataSource = GetList("CompanyListByName");
        //StoreCmbName.DataBind();

        //StoreCurrLocal.DataSource = GetList("CurrencysListLocal");
        //StoreCurrLocal.DataBind();

        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", "A");

        DataSet dsLocation = GetList("LocationList");
        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();

        DataSet dsUnit = GetList("UnitBinding");
        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();

        DataSet dsCurrency = GetList("CurrencysList");
        StoreCurrency.DataSource = dsCurrency;
        StoreCurrency.DataBind();

        DataSet dsSales = GetList("SalesList");
        StoreSalesman.DataSource = dsSales;
        StoreSalesman.DataBind();

        //DataSet dsItem = GetList("ItemBinding");       
        //StoreItem.DataSource = dsItem;
        //StoreItem.DataBind();
        //l_item.Template.Html = Template.Html;
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

        DataSet dsKind = GetList("QtyKindBinding");
        StoreKind.DataSource = dsKind;
        StoreKind.DataBind();

        StoreCurrInvoice.DataSource = GetList("CurrencysInvoice");
        StoreCurrInvoice.DataBind();

        //CmbFromRight.Template.Html = Template.Html;
        //CmbToRight.Template.Html = Template.Html;
        //CmbUnit.Template.Html = Template.Html;
        //l_unit.Template.Html = Template.Html;
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


    #endregion


    /// <summary>
    /// 控件初始化
    /// </summary>
    #region   ComboBoxBinder()    Author ：Micro   (2011-09-06)
    void ControlsInit()
    {
        txtMawb.Focus(true);

        labLotNo.Text = "";
        labAeLotNo.Text = "";
        txtMawb.Text = "";
        txtReference.Text = "";
        txtClearence.Text = "";
        CmbCarrierCode.Text = "";
        //CmbCarrierText.Value = "";
        CmbShipperCode.Text = "";
        //CmbShipperText.Value = "";
        CmbConsigneeCode.Text = "";
        //CmbConsigneeText.Value = "";
        CmbNotify1Code.Text = "";
        //CmbNotify1Text.Value = "";
        CmbNotify2Code.Text = "";
        //CmbNotify2Text.Value = "";
        CmbDischargeCode.Text = "";
        //CmbDischargeText.Value = "";
        CmbSalesman.Text = "";
        chbDirect.Checked = false;
        txtGWT.Text = "";
        txtVWT.Text = "";
        txtCWT.Text = "";
        txtPiece.Text = "";
        txtPallet.Text = "";
        //CmbUnit.Text = "";
        txtRemark.Text = "";
        txtATA.Text = "";
        txtATD.Text = "";
        txtETA.Text = "";
        txtETD.Text = "";
        txtFlightRight.Text = "";
        CmbCarrierRight.Text = "";
        CmbFromRight.setValue("");
        CmbToRight.setValue("");
        // CmbCompanyRightCode.Text = "";
        // CmbCompanyRightText.Text = "";
        //CmbCurrencyRight.Text = "";
        CmbUnit.setValue("CTN");
        //CmbUnit.Text="CTN";
        //td_sales1.Style.Value = "display:none";
        td_sales2.Style.Value = "display:none";

    }
    #endregion



    /// <summary>
    /// 绑定Grid
    /// </summary>
    #region   GridListBinder()    Author ：Micro   (2011-09-05)
    void GridListBinder()
    {


        StoreHawb.DataSource = GetList("FW_AirImport_Joblist_SP", "HAWBList", "air_Seed", hidSeed.Text);
        StoreHawb.DataBind();

        StoreFlight.DataSource = GetList("FW_AirImport_ShipmentRoute_SP", "List", "sr_Seed", hidSeed.Text);
        StoreFlight.DataBind();

        StoreInvoice.DataSource = GetList("FW_AirImport_Invoice_SP", "List", "inv_Seed", hidSeed.Text);
        StoreInvoice.DataBind();

        

        

    }
    #endregion


    /// <summary>
    /// UnVoid   and   Void
    /// </summary>
    void UnVoid()
    {
        
    }


    /// <summary>
    /// 返回数据集
    /// </summary>
    #region   GetList(string,string)   Author ：Micro   (2011-09-05)
    DataSet GetList(string CmdText, string Type, string Param, string Stat)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, CmdText, new List<IFields>() { dal.CreateIFields().Append("Option", Type).Append(Param, Stat) }).GetList();
        }
        catch
        {
            ds = null;
        }
        return ds;
    }

    DataSet GetList(string Type)
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


    /// <summary>
    /// 初始数据
    /// </summary>  
    #region  初始数据   DataBinder()   Author：Micro  (2011-09-05)
    void DataBinder()
    {
        
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Joblist_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "MAWBByID").Append("air_ROWID", hidRowID.Text) }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            
            //hidRowID.Text = dt.Rows[0]["RowID"].ToString();
            labLotNo.Text = dt.Rows[0]["LotNo"].ToString();
            hidLotNo.Text = dt.Rows[0]["LotNo"].ToString();
            labAeLotNo.Text = dt.Rows[0]["AeLotNo"].ToString();
            txtMawb.Text = dt.Rows[0]["MAWB"].ToString();
            txtReference.Text = dt.Rows[0]["Reference"].ToString();
            txtClearence.Text = dt.Rows[0]["Clearance"].ToString();
            CmbCarrierCode.setValue(dt.Rows[0]["Coloader"].ToString());
            CmbCarrierCode.Text = dt.Rows[0]["ColoaderName"].ToString();
            CmbShipperCode.setValue(dt.Rows[0]["Shipper"].ToString());
            CmbShipperCode.Text = dt.Rows[0]["ShipperName"].ToString();
            CmbConsigneeCode.setValue(dt.Rows[0]["Consignee"].ToString());
            CmbConsigneeCode.Text = dt.Rows[0]["ConsigneeName"].ToString();
            CmbNotify1Code.setValue(dt.Rows[0]["Notify1"].ToString());
            CmbNotify1Code.Text = dt.Rows[0]["Notify1Name"].ToString();
            CmbNotify2Code.setValue(dt.Rows[0]["Notify2"].ToString());
            CmbNotify2Code.Text = dt.Rows[0]["Notify2Name"].ToString();
            CmbDischargeCode.setValue(dt.Rows[0]["Discharge"].ToString());
            CmbDischargeCode.Text = dt.Rows[0]["DischargeName"].ToString();
            chbDirect.Checked = Convert.ToBoolean(dt.Rows[0]["Direct"].ToString());
            CmbSalesman.setValue(dt.Rows[0]["Salesman"].ToString());
            if (Convert.ToBoolean(dt.Rows[0]["Direct"].ToString()))
            {
                //td_sales1.Style.Value = "visibility:visible; width:210px;";
                td_sales2.Style.Value = "visibility:visible;width:70px;padding-left:0px;";
                X.AddScript("HawbShow(true);");
            }
            else
            {
                //td_sales1.Style.Value = "visibility:hidden;width:210px;";
                td_sales2.Style.Value = "visibility:hidden;width:70px;padding-left:0px;";
                X.AddScript("HawbShow(false);");
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["GWT"].ToString()))
                txtGWT.Text = dt.Rows[0]["GWT"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["VWT"].ToString()))
                txtVWT.Text = dt.Rows[0]["VWT"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["CWT"].ToString()))
                txtCWT.Text = dt.Rows[0]["CWT"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["Piece"].ToString()))
                txtPiece.Text = dt.Rows[0]["Piece"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["Pallet"].ToString()))
                txtPallet.Text = dt.Rows[0]["Pallet"].ToString();
            CmbUnit.setValue(dt.Rows[0]["Unit"].ToString());
            //CmbUnit.Text=dt.Rows[0]["Unit"].ToString();
            txtRemark.Text = dt.Rows[0]["Remark"].ToString();
            txtATA.Text = dt.Rows[0]["ATA"].ToString();
            txtATD.Text = dt.Rows[0]["ATD"].ToString();
            txtETA.Text = dt.Rows[0]["ETA"].ToString();
            txtETD.Text = dt.Rows[0]["ETD"].ToString();
            CmbCarrierRight.setValue(dt.Rows[0]["Carrier"].ToString());
            txtFlightRight.Text = dt.Rows[0]["FlightNo"].ToString();
            CmbFromRight.setValue(dt.Rows[0]["From"].ToString());
            CmbToRight.setValue(dt.Rows[0]["To"].ToString());
            //CmbFromRight.Text=dt.Rows[0]["From"].ToString();
            //CmbToRight.Text=dt.Rows[0]["To"].ToString();

            if (ControlBinder.IsDisplayLotNo(txtETA.Text, labLotNo.Text))
                btnUpdateLotNo.Show();
            else
                btnUpdateLotNo.Hide();

            txtVoid.Text = Convert.ToBoolean(dt.Rows[0]["Action"]) ? "1" : "0";
            if (txtVoid.Text == "0")
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
            else
            {
                img_void.Style.Value = "display:none";
            }

            

            ControlBinder.pageTitleMsg(false, "AI-M:" + dt.Rows[0]["LotNo"].ToString(), "<p>Status :  Edit  MAWB  of <span>" + dt.Rows[0]["LotNo"].ToString() + "</span></p>", div_bottom);
        }
        else
        {
            //td_sales1.Style.Value = "visibility:hidden;width:210px;";
            td_sales2.Style.Value = "visibility:hidden;width:70px;padding-left:0px;";
            X.AddScript("HawbShow(false);");
            ControlBinder.pageTitleMsg(false, "AI-M:New", "<p>Status :  New  Blank  MAWB </p>", div_bottom);
        }
        
    }
    #endregion


    #region   GridList   删除事件     Author： Micro   (2011-09-06)
    ///// <summary>
    ///// GridListHawb     删除事件
    ///// </summary>    
    //#region   btnDeleteHawb_Click() 删除事件   Author： Micro   (2011-09-06)
    //protected void btnDeleteHawb_Click(object sender, DirectEventArgs e)
    //{
    //    string RowID = e.ExtraParams["RowID"];
    //    bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Joblist_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteMAWB").Append("air_ROWID", RowID) }).Update();
    //    if (b)
    //        X.Msg.Alert("Status", " Deleted successful !!! ").Show();
    //    else
    //        X.Msg.Alert("Status", " Deleted failed !!! ").Show();

    //    GridListBinder();

    //}
    //#endregion


    ///// <summary>
    ///// GridListInvoice  删除事件
    ///// </summary>
    //#region  btnDeleteInvoice_Click() 删除事件   Author： Micro   (2011-09-06)
    //protected void btnDeleteInvoice_Click(object sender, DirectEventArgs e)
    //{
    //    string RowID = e.ExtraParams["RowID"];
    //    bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteActive").Append("inv_ROWID", RowID) }).Update();
    //    if (b)
    //        X.Msg.Alert("prompt", " Deleted successful !!! ").Show();
    //    else
    //        X.Msg.Alert("prompt", " Deleted failed !!! ").Show();

    //    GridListBinder();
    //}
    //#endregion



    ///// <summary>
    ///// GridListFlight   删除事件
    ///// </summary>
    //#region   btnDeleteFlight_Click() 删除事件   Author： Micro   (2011-09-06)
    //protected void btnDeleteFlight_Click(object sender, DirectEventArgs e)
    //{
    //    string RowID = e.ExtraParams["RowID"];
    //    bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_ShipmentRoute_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete").Append("sr_ROWID", RowID) }).Update();
    //    if (b)
    //        X.Msg.Alert("prompt", " Deleted successful !!! ").Show();
    //    else
    //        X.Msg.Alert("prompt", " Deleted failed !!! ").Show();

    //    GridListBinder();

    //}
    //#endregion

    #endregion


    #region  Button  事件处理    Author： Micro   (2011-09-06)

    /// <summary>
    /// Button 事件   保存新增
    /// </summary>    
    #region   btnNext_Click()  保存新增    Author：Micro   (2011-09-05)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        btnSave_Click(sender, e);
        X.Redirect("mawb.aspx");
    }
    #endregion


    /// <summary>
    /// Button 事件   重置(还原数据)
    /// </summary>   
    #region    btnCancel_Click()   重置   Author：Micro   (2011-09-05)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
        GridListBinder();
        X.AddScript("BindingCost();");
        txtMawb.Focus(true);
    }
    #endregion


    /// <summary>
    /// Button 事件   修改保存
    /// </summary>   
    #region    btnSave_Click()  修改保存   Author：Micro   (2011-09-05)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {

        object ETA = ControlBinder.getDate(string.IsNullOrEmpty(txtETA.RawText.Trim()) ? DBNull.Value : (object)txtETA.RawText);
        object ETD = ControlBinder.getDate(string.IsNullOrEmpty(txtETD.RawText.Trim()) ? DBNull.Value : (object)txtETD.RawText);
        object ATD = ControlBinder.getDate(string.IsNullOrEmpty(txtATD.RawText.Trim()) ? DBNull.Value : (object)txtATD.RawText);
        object ATA = ControlBinder.getDate(string.IsNullOrEmpty(txtATA.RawText.Trim()) ? DBNull.Value : (object)txtATA.RawText);
        if (!string.IsNullOrEmpty(ETA.ToString()) && !string.IsNullOrEmpty(ETD.ToString()) && Convert.ToDateTime(ETD) > Convert.ToDateTime(ETA))
        {
            ControlBinder.pageTitleMsg(false, "AI:M" + labLotNo.Text, "<p class=\"error\">Status :  Saved  failed , Error message: ETD  Not more than   ETA  .</p>", div_bottom);
            txtETD.Focus(true);
            return;
        }

        if (!string.IsNullOrEmpty(ATD.ToString()) && !string.IsNullOrEmpty(ATA.ToString()) && Convert.ToDateTime(ATD) > Convert.ToDateTime(ATA))
        {
            ControlBinder.pageTitleMsg(false, "AI:M" + labLotNo.Text, "<p class=\"error\">Status :  Saved  failed , Error message: ATD  Not more than   ATA  .</p>", div_bottom);
            txtATD.Focus(true);
            return;
        }

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Joblist_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "UpdateMAWB")
            .Append("air_ROWID",hidRowID.Text.Trim()) 
            .Append("air_MAWB",txtMawb.Text.Replace(" ","").Trim().ToUpper())
            .Append("air_aeLotNo",labAeLotNo.Text.ToUpper())
            .Append("air_CompanyReferance",txtReference.Text.Trim().ToUpper())
            .Append("imp_Clearance",txtClearence.Text.Trim().ToUpper())
            .Append("air_CoLoader",CmbCarrierCode.Value)
            .Append("air_Shipper",CmbShipperCode.Value)
            .Append("air_Consignee",CmbConsigneeCode.Value)
            .Append("air_PartyA",CmbNotify1Code.Value)
            .Append("air_PartyB",CmbNotify2Code.Value)
            .Append("air_Broker",CmbDischargeCode.Value)
            .Append("air_IsDirect",chbDirect.Checked?"1":"0")
            .Append("air_Sales",chbDirect.Checked?CmbSalesman.Value.ToUpper():"")
            .Append("air_GWT",string.IsNullOrEmpty(txtGWT.Text.Trim())?DBNull.Value:(object)txtGWT.Text)
            .Append("air_VWT",string.IsNullOrEmpty(txtVWT.Text.Trim())?DBNull.Value:(object)txtVWT.Text)
            .Append("air_CWT",string.IsNullOrEmpty(txtCWT.Text.Trim())?DBNull.Value:(object)txtCWT.Text)
            .Append("air_Piece",string.IsNullOrEmpty(txtPiece.Text.Trim())?DBNull.Value:(object)txtPiece.Text)
            .Append("air_Unit",CmbUnit.Value)
            .Append("air_Pallet",string.IsNullOrEmpty(txtPallet.Text.Trim())?DBNull.Value:(object)txtPallet.Text)
            .Append("air_Carrier",CmbCarrierRight.Value)
            .Append("air_Flight",txtFlightRight.Text.Trim().ToUpper())
            .Append("air_LocLoad",CmbFromRight.Value)  
            .Append("air_LocDischarge",CmbToRight.Value)
            .Append("air_Remark",txtRemark.Text.Trim())
            .Append("air_ETD",ControlBinder.getDate(string.IsNullOrEmpty(txtETD.RawText.Trim())?DBNull.Value:(object)txtETD.RawText))
            .Append("air_ETA",ControlBinder.getDate(string.IsNullOrEmpty(txtETA.RawText.Trim())?DBNull.Value:(object)txtETA.RawText))
            .Append("air_ATD",ControlBinder.getDate(string.IsNullOrEmpty(txtATD.RawText.Trim())?DBNull.Value:(object)txtATD.RawText))
            .Append("air_ATA",ControlBinder.getDate(string.IsNullOrEmpty(txtATA.RawText.Trim())?DBNull.Value:(object)txtATA.RawText))
            .Append("LastUser",FSecurityHelper.CurrentUserDataGET()[0].ToString())
            .Append("air_Seed",hidSeed.Text.Trim())
            .Append("air_STAT",FSecurityHelper.CurrentUserDataGET()[12].ToString())
           // .Append("air_SYS",FSecurityHelper.CurrentUserDataGET()[11].ToString())
            .Append("air_SYS","AI")
            .Append("User",FSecurityHelper.CurrentUserDataGET()[0].ToString())
            .Append("code",FSecurityHelper.CurrentUserDataGET()[4].ToString()+"AI")
        }).GetTable();

        if (dt != null && dt.Rows.Count > 0 && !string.IsNullOrEmpty(dt.Rows[0][1].ToString()))
        {
            hidSeed.Text = dt.Rows[0][1].ToString();
        }

        //X.AddScript("saveCost('" + hidSeed.Text + "');");

        ucCost.costseed = hidSeed.Text;
        ucCost.btnCostEvent(sender, e);

        #region///获取FlightRouting列表数据
        var ShipmentRoute = JSON.Deserialize<List<ShipmentRoute>>(e.ExtraParams["p_safety_l"]);

        #region  /// 先Delete 在Update
        string rowID = "0,";
        for (int i = 0; i < ShipmentRoute.Count; ++i)
        {
            rowID += ShipmentRoute[i].RowID + ",";
        }

        rowID = rowID.Substring(0, rowID.Length - 1);
        bool d = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_ShipmentRoute_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete")
            .Append("sr_ToMaster",hidSeed.Text)
            .Append("ROWID",rowID)}).Update();

        List<IFields> list = new List<IFields>();

        for (int i = 0; i < ShipmentRoute.Count; ++i)
        {
            list.Add(dal.CreateIFields().Append("Option", "UpdateList").
            Append("sr_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString()).
            Append("sr_ToMaster", hidSeed.Text).
            Append("sr_ShipKind", CmbShipperCode.Text).
            Append("sr_Carrier", CmbCarrierCode.Text).
            Append("sr_OrderID", i).
            Append("sr_Vessel", "").
            Append("sr_Voyage", "").
            Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).
            Append("sr_Flight", ShipmentRoute[i].FlightNo.ToUpper()).
            Append("sr_From", ShipmentRoute[i].From).
            Append("sr_To", ShipmentRoute[i].To).
            Append("sr_ETD", ControlBinder.getDate(ShipmentRoute[i].ETD.ToString().StartsWith("0001") ? DBNull.Value : (object)ShipmentRoute[i].ETD)).
            Append("sr_ETA", ControlBinder.getDate(ShipmentRoute[i].ETA.ToString().StartsWith("0001") ? DBNull.Value : (object)ShipmentRoute[i].ETA)).
            Append("sr_ATD", ControlBinder.getDate(ShipmentRoute[i].ATD.ToString().StartsWith("0001") ? DBNull.Value : (object)ShipmentRoute[i].ATD)).
            Append("sr_ATA", ControlBinder.getDate(ShipmentRoute[i].ATA.ToString().StartsWith("0001") ? DBNull.Value : (object)ShipmentRoute[i].ATA)).
            Append("sr_ROWID", ShipmentRoute[i].RowID));
        }
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_ShipmentRoute_SP", list).Update();
        #endregion
        #endregion

        #region ///Update HAWB List
        var hawbList = JSON.Deserialize<List<HawbList>>(e.ExtraParams["p_safety_3"]);
        rowID = "0,";
        for (int i = 0; i < hawbList.Count; ++i)
        {
            rowID += hawbList[i].RowID + ",";
        }
        rowID = rowID.Substring(0, rowID.Length - 1);
        bool h = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Joblist_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteMAWB")
            .Append("air_ToMAWB",hidSeed.Text)
            .Append("str",rowID)}).Update();

        #endregion

        #region ///Update Local Invoice
        //var InvocieList = JSON.Deserialize<List<Invocie>>(e.ExtraParams["p_safety_4"]);
        //rowID = "0,";
        //for (int i = 0; i < InvocieList.Count; ++i)
        //{
        //    rowID += InvocieList[i].RowID + ",";
        //}
        //rowID = rowID.Substring(0, rowID.Length - 1);
        //bool inv = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteActive")
        //    .Append("inv_ToMaster",hidSeed.Text)
        //    .Append("str",rowID)}).Update();
        #endregion




        if (dt != null)
        {
            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "AI", "MAWB");

            if (ControlBinder.IsDisplayLotNo(ControlBinder.getDate(string.IsNullOrEmpty(txtETA.RawText.Trim()) ? DBNull.Value : (object)txtETA.RawText).ToString(), hidLotNo.Text))
            {
                btnUpdateLotNo.Show();
            }
            else
            {
                btnUpdateLotNo.Hide();
            }
            txtMawb.Focus(true);
            ControlBinder.pageTitleMsg(true, "AI-M:" + labLotNo.Text, "<p class=\"success\">Status : Record Saved with Lot No.  <span>" + labLotNo.Text + "</span>  </p>", div_bottom);

            if (dt != null && dt.Rows.Count > 0 && !string.IsNullOrEmpty(dt.Rows[0][1].ToString()))
            {
                X.Redirect("mawb.aspx?seed=" + dt.Rows[0][1]);
            }


        }
        else
        {
            ControlBinder.pageTitleMsg(false, "AI-M:" + labLotNo.Text, "<p class=\"error\">Status :  Saved  failed ! ! !  </p>", div_bottom);
        }
      
        
    }
    #endregion


    /// <summary>
    /// Button 事件    删除
    /// </summary>   
    #region    btnVoid_Click()   删除    Author：Micro   (2011-09-05)
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
            string voidflag = hidVoid.Text == "0" ? "Y" : "N";
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
                ControlBinder.pageTitleMsg(false, "AI-M:" + labLotNo.Text, "<p class=\"error\"> Status : Saving  failed  ! ! !   </p>", div_bottom);
            }
            DataBinder();
            StoreInvoice.DataSource = GetList("FW_AirImport_Invoice_SP", "List", "inv_Seed", hidSeed.Text);
            StoreInvoice.DataBind();
            ControlBinder.pageTitleMsg(true, "AI-M:" + labLotNo.Text, "<p>Status :  Edit  MAWB  of <span>" + labLotNo.Text + "</span></p>", div_bottom);
        }
    }


    #endregion
    //@LotNo nvarchar(30)=null,
    //@code nvarchar(20)=null,
    //@date datetime =null,
    //@user nvarchar(20)=null,
    //@stat nvarchar(20)=null,
    //@seed numeric =null


    [DirectMethod]
    public void btnUpdateLotNo_Click()
    {
        object eta = ControlBinder.getDate(string.IsNullOrEmpty(txtETA.RawText.Trim()) ? DBNull.Value : (object)txtETA.RawText);

        string lotNo = ControlBinder.GetNewLotNo("AI", hidSeed.Text, eta);
        if (lotNo == "-1")
        {
            X.MessageBox.Alert("Status", "The cost of this LOT is transfered to AC, LOT NUMBER updating is aborted!").Show();
            ControlBinder.pageTitleMsg(true, "AI-M:" + labLotNo.Text, "<p class=\"success\">Status : Saved failed ! ! ! </p>", div_bottom);
        }
        else
        {
            labLotNo.Text = lotNo;
            hidLotNo.Text = lotNo;
            ControlBinder.pageTitleMsg(true, "AI-M:" + labLotNo.Text, "<p class=\"success\">Status : Record Saved with Lot No.  <span>" + labLotNo.Text + "</span>  </p>", div_bottom);
            btnUpdateLotNo.Hide();
        }
    }



    ///// <summary>
    ///// 添加Invoice
    ///// </summary>
    #region    btnAddNewInvoice_Click(object,DirectEventArgs)    Author：Micro   (2011-09-14)
    //protected void btnAddNewInvoice_Click(object sender, DirectEventArgs e)
    //{
    //    if (string.IsNullOrEmpty(labLotNo.Text.Trim()))
    //    {
    //        X.Msg.Alert("Status", "Please save the data !").Show();
    //        return;
    //    }
    //    if (string.IsNullOrEmpty(CmbCompanyRightCode.Text) || string.IsNullOrEmpty(CmbCurrencyRight.Text))
    //    {
    //        X.Msg.Alert("Stauts", " Input can't for empty ! ! ! ", new JFunction { Handler = "Ext.get('CmbCompanyRightCode').focus()" }).Show();
    //        return;
    //    }
    //    string url = "invoice.aspx?sys=AI&M=" + Request["seed"] + "&Company=" + CmbCompanyRightCode.Value + "&Currency=" + CmbCurrencyRight.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
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


    //protected void btnAddHawb_Click(object sender, DirectEventArgs e)
    //{
    //    //if (string.IsNullOrEmpty(labAeLotNo.Text))
    //    //{
    //    //     X.Msg.Confirm("提示", " 你确定要保存数据吗 ?").Show();
    //    //     //X.AddScript("Ext.Msg.Confirm('提示','你确定要保存数据吗?')"
    //    //     //X.Msg.Confirm("Status", " Please save the data ? ").Show();
    //    //    return;           
    //    //}

    //    string url = "hawb.aspx?MAWB=" + Request["seed"];
    //    X.Js.AddScript("window.open('" + url + "','_blank')");

    //}
    #endregion


}


#region   /// 实体类
/// <summary>
/// ShipmentRouting实体
/// </summary>
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

    public DateTime ETD
    { get; set; }

    public DateTime ETA
    { get; set; }


    public DateTime ATD
    { get; set; }


    public DateTime ATA
    { get; set; }

}

class HawbList
{
    public string RowID
    { get; set; }
}

class Invocie
{
    public string RowID { get; set; }
}
#endregion