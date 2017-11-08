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

public partial class Triangle_AirShipment_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtMAWB.Focus(true);
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = string.IsNullOrEmpty(Request["seed"]) ? "" : Request["seed"];
            ControlBinder.DateFormat(txtJob);
            ControlBinder.DateFormat(txtDepartDate);
            ControlBinder.DateFormat(txtArrivalDate);
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {

        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                ComboBoxBinder();
                DataBinder();
                LockControl();
                //X.AddScript("showCompanyRemark('CmbShipperCode,CmbConsigneeCode,CmbNotify1Code,CmbNotify2Code,CmbCarrierCode,CmbCoLoader', 'Shipper,Consignee,Notify #1,Notify #2,Carrier,Co-Loader');");
            }
        }
    }

    protected void LockControl()
    {
        if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT")
        {
            btnNext.Disabled = true;
            btnSave.Disabled = true;
            btnVoid.Disabled = true;
            btnCancel.Disabled = true;
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

    /// <summary>
    /// DataFactory  全局变量
    /// </summary>
    DataFactory dal = new DataFactory();

    [DirectMethod]
    public void btnUpdateLotNo_Click()
    {
        object etd = ControlBinder.getDate(string.IsNullOrEmpty(txtJob.RawText.Trim()) ? DBNull.Value : (object)txtJob.RawText.Trim());

        string lotNo = ControlBinder.GetNewLotNo("AT", hidSeed.Text, etd);
        if (lotNo == "-1")
        {
            X.MessageBox.Alert("Status", "The cost of this LOT is transfered to AC, LOT NUMBER updating is aborted!").Show();
            ControlBinder.pageTitleMsg(true, "Air Shipment:" + hidLotNo.Text, "<p class=\"success\">Status : Saved failed ! ! ! </p>", div_bottom);
        }
        else if (lotNo != "0")
        {
            labLotNo.Text = lotNo;
            hidLotNo.Text = lotNo;

            ControlBinder.pageTitleMsg(true, "Air Shipment:" + hidLotNo.Text, "<p class=\"success\">Status : Saved successfully ! ! ! </p>", div_bottom);
            btnUpdateLotNo.Hide();
        }
    }

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
    }

    public void StoreKind_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsKind = GetList("QtyKindBinding");
        StoreKind.DataSource = dsKind;
        StoreKind.DataBind();
    }

    protected void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsSalesman = GetList("SalesList");
        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();
    }

    #endregion


    /// <summary>
    /// 绑定ComboBox
    /// </summary>
    #region   ComboBoxBinder()    Author ：Micro   (2011-09-06)
    void ComboBoxBinder()
    {
        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", "A");

        DataSet dsLocation = GetList("LocationList");
        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();

        DataSet dsUnit = GetList("UnitBinding");
        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();


        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();

        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

        DataSet dsKind = GetList("QtyKindBinding");
        StoreKind.DataSource = dsKind;
        StoreKind.DataBind();

        StoreCurrInvoice.DataSource = GetList("CurrencysInvoice");
        StoreCurrInvoice.DataBind();

        StoreSalesman.DataSource = GetList("SalesList");
        StoreSalesman.DataBind();
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

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Triangle_Air_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "GetList").Append("tri_Seed", hidSeed.Text) }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            labLotNo.Text = ds.Tables[0].Rows[0]["tri_LotNo"].ToString();
            hidLotNo.Text = ds.Tables[0].Rows[0]["tri_LotNo"].ToString();
            txtMAWB.Text = ds.Tables[0].Rows[0]["tri_MBL"].ToString();
            txtHAWB.Text = ds.Tables[0].Rows[0]["tri_HBL"].ToString();
            txtFlightNo.Text = ds.Tables[0].Rows[0]["tri_Flight"].ToString();
            CmbDeparture.setValue(ds.Tables[0].Rows[0]["tri_LocReceived"].ToString());
            CmbDest.setValue(ds.Tables[0].Rows[0]["tri_LocFinal"].ToString());
            txtDepL.Text = ds.Tables[0].Rows[0]["tri_LocReceivedL"].ToString();
            txtDesL.Text = ds.Tables[0].Rows[0]["tri_LocFinalL"].ToString();
            txtDepartDate.Text = ds.Tables[0].Rows[0]["tri_ETD"].ToString();
            txtArrivalDate.Text = ds.Tables[0].Rows[0]["tri_ETA"].ToString();
            txtJob.Text = ds.Tables[0].Rows[0]["tri_EReceipt"].ToString();
            CmbSalesman.setValue(ds.Tables[0].Rows[0]["tri_Sales"].ToString());
            txtMAWBRemark.Text = ds.Tables[0].Rows[0]["tri_Remark"].ToString();

            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["tri_GWT"].ToString()))
                txtGWT.Text = ds.Tables[0].Rows[0]["tri_GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["tri_VWT"].ToString()))
                txtVWT.Text = ds.Tables[0].Rows[0]["tri_VWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["tri_CWT"].ToString()))
                txtCWT.Text = ds.Tables[0].Rows[0]["tri_CWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["tri_Piece"].ToString()))
                txtPiece.Text = ds.Tables[0].Rows[0]["tri_Piece"].ToString();
            CmbUnit.setValue(ds.Tables[0].Rows[0]["tri_Unit"].ToString());

            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["tri_Shipper"].ToString());
            CmbShipperCode1.Text = ds.Tables[0].Rows[0]["tri_Shipper"].ToString();
            CmbShipperCode_name.Text = ds.Tables[0].Rows[0]["tri_ShipperLine"].ToString();

            CmbConsigneeCode.setValue(ds.Tables[0].Rows[0]["tri_Consignee"].ToString());
            CmbConsigneeCode1.Text = ds.Tables[0].Rows[0]["tri_Consignee"].ToString();
            CmbConsigneeCode_name.Text = ds.Tables[0].Rows[0]["tri_ConsigneeLine"].ToString();

            CmbNotify1Code.setValue(ds.Tables[0].Rows[0]["tri_PartyA"].ToString());
            CmbNotify1Code1.Text = ds.Tables[0].Rows[0]["tri_PartyA"].ToString();
            CmbNotify1Code_name.Text = ds.Tables[0].Rows[0]["tri_PartyALine"].ToString();

            CmbNotify2Code.setValue(ds.Tables[0].Rows[0]["tri_PartyB"].ToString());
            CmbNotify2Code1.Text = ds.Tables[0].Rows[0]["tri_PartyB"].ToString();
            CmbNotify2Code_name.Text = ds.Tables[0].Rows[0]["tri_PartyBLine"].ToString();

            CmbCarrierCode.setValue(ds.Tables[0].Rows[0]["tri_Carrier"].ToString());
            CmbCarrierCode1.Text = ds.Tables[0].Rows[0]["tri_Carrier"].ToString();
            CmbCarrierCode_name.Text = ds.Tables[0].Rows[0]["tri_CarrierLine"].ToString();

            CmbCoLoader.setValue(ds.Tables[0].Rows[0]["tri_CoLoader"].ToString());
            CmbCoLoader1.Text = ds.Tables[0].Rows[0]["tri_CoLoader"].ToString();
            CmbCoLoader_name.Text = ds.Tables[0].Rows[0]["tri_CoLoaderLine"].ToString();

            if (ControlBinder.IsDisplayLotNo(txtJob.Text.Trim(), hidLotNo.Text))
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

            gridInvoice.GetStore().DataSource = ds.Tables[1];
            gridInvoice.GetStore().DataBind();



            ControlBinder.pageTitleMsg(false, "Air Shipment:" + ds.Tables[0].Rows[0]["tri_LotNo"].ToString(), "<p>Status :  Edit  Air Shipment  of <span>" + ds.Tables[0].Rows[0]["tri_LotNo"].ToString() + "</span></p>", div_bottom);
        }
        else
        {
            txtJob.RawText = DateTime.Now.ToString("dd/MM/yyyy");
            txtJob.Text = DateTime.Now.ToString("yyyy/MM/dd");
            txtDepartDate.RawText = DateTime.Now.ToString("dd/MM/yyyy");
            txtDepartDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
            txtArrivalDate.RawText = DateTime.Now.ToString("dd/MM/yyyy");
            txtArrivalDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
            //CmbUnit.setValue("CTN");
            ControlBinder.pageTitleMsg(false, "Air Shipment:New", "<p>Status :  New  Blank  Air Shipment </p>", div_bottom);
        }

    }
    #endregion



    /// <summary>
    /// Button 事件   保存新增
    /// </summary>    
    #region   btnNext_Click()  保存新增    Author：Micro   (2011-09-05)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        btnSave_Click(sender, e);
        X.Redirect("List.aspx");
    }
    #endregion


    /// <summary>
    /// Button 事件   重置(还原数据)
    /// </summary>   
    #region    btnCancel_Click()   重置   Author：Micro   (2011-09-05)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
        X.AddScript("BindingCost();");
        txtMAWB.Focus(true);
    }
    #endregion


    /// <summary>
    /// Button 事件   修改保存
    /// </summary>   
    #region    btnSave_Click()  修改保存   Author：Micro   (2011-09-05)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {

        object job = ControlBinder.getDate(string.IsNullOrEmpty(txtJob.RawText.Trim()) ? DBNull.Value : (object)txtJob.RawText.Trim());
        object ETD = ControlBinder.getDate(string.IsNullOrEmpty(txtDepartDate.RawText.Trim()) ? DBNull.Value : (object)txtDepartDate.RawText.Trim());
        object ETA = ControlBinder.getDate(string.IsNullOrEmpty(txtArrivalDate.RawText.Trim()) ? DBNull.Value : (object)txtArrivalDate.RawText.Trim());

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Triangle_Air_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
            .Append("tri_Seed",hidSeed.Text==""?null:hidSeed.Text)
            .Append("tri_MBL",txtMAWB.Text.Trim().ToUpper())
            .Append("tri_HBL",txtHAWB.Text.Trim().ToUpper())
            .Append("tri_Flight",txtFlightNo.Text.Trim().ToUpper())
            .Append("tri_EReceipt",job)
            .Append("tri_ETD",ETD)
            .Append("tri_ETA",ETA)
            .Append("tri_LocReceived",string.IsNullOrEmpty(CmbDeparture.Value)?DBNull.Value:(object)CmbDeparture.Value.Trim().ToUpper())
            .Append("tri_LocFinal",string.IsNullOrEmpty(CmbDest.Value)?DBNull.Value:(object)CmbDest.Value.Trim().ToUpper())
            .Append("tri_LocReceivedL",txtDepL.Text.Trim().ToUpper())
            .Append("tri_LocFinalL",txtDesL.Text.Trim().ToUpper())
            .Append("tri_Sales",string.IsNullOrEmpty(CmbSalesman.Value)?DBNull.Value:(object)CmbSalesman.Value.Trim().ToUpper())

            .Append("tri_Shipper",CmbShipperCode.Value.Trim().ToUpper())
            .Append("tri_ShipperLine",CmbShipperCode_name.Text.Trim().ToUpper())
            .Append("tri_Consignee",CmbConsigneeCode.Value.Trim().ToUpper())
            .Append("tri_ConsigneeLine",CmbConsigneeCode_name.Text.Trim().ToUpper())
            .Append("tri_PartyA",CmbNotify1Code.Value.Trim().ToUpper())
            .Append("tri_PartyALine",CmbNotify1Code_name.Text.Trim().ToUpper())
            .Append("tri_PartyB",CmbNotify2Code.Value.Trim().ToUpper())
            .Append("tri_PartyBLine",CmbNotify2Code_name.Text.Trim().ToUpper())
            .Append("tri_Carrier",CmbCarrierCode.Value.Trim().ToUpper())
            .Append("tri_CarrierLine",CmbCarrierCode_name.Text.Trim().ToUpper())
            .Append("tri_CoLoader",CmbCoLoader.Value.Trim().ToUpper())
            .Append("tri_CoLoaderLine",CmbCoLoader_name.Text.Trim().ToUpper())

            .Append("tri_GWT",string.IsNullOrEmpty(txtGWT.Text.Trim())?DBNull.Value:(object)txtGWT.Text)
            .Append("tri_VWT",string.IsNullOrEmpty(txtVWT.Text.Trim())?DBNull.Value:(object)txtVWT.Text)
            .Append("tri_CWT",string.IsNullOrEmpty(txtCWT.Text.Trim())?DBNull.Value:(object)txtCWT.Text)
            .Append("tri_Piece",string.IsNullOrEmpty(txtPiece.Text.Trim())?DBNull.Value:(object)txtPiece.Text)
            .Append("tri_Unit",CmbUnit.Value)

            .Append("tri_LastUser",FSecurityHelper.CurrentUserDataGET()[0].ToString())
            .Append("tri_STAT",FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("tri_SYS","AT")
            .Append("tri_User",FSecurityHelper.CurrentUserDataGET()[0].ToString())
            .Append("code",FSecurityHelper.CurrentUserDataGET()[4].ToString()+"AT")
            .Append("tri_Remark", string.IsNullOrEmpty(txtMAWBRemark.Text) ? "" : txtMAWBRemark.Text.ToUpper())
            
        }).GetTable();

        if (dt != null && dt.Rows.Count > 0 && !string.IsNullOrEmpty(dt.Rows[0][0].ToString()))
        {
            hidSeed.Text = dt.Rows[0][0].ToString();
        }

        //X.AddScript("saveCost('" + hidSeed.Text + "');");

        ucCost.costseed = hidSeed.Text;
        ucCost.btnCostEvent(sender, e);

        #region Invoice
        //string rowID = "0,";
        //var InvoiceList = JSON.Deserialize<List<Invocie>>(e.ExtraParams["p_safety_4"]);
        //rowID = "0,";
        //for (int i = 0; i < InvoiceList.Count; ++i)
        //{
        //    rowID += InvoiceList[i].RowID + ",";
        //}
        //rowID = rowID.Substring(0, rowID.Length - 1);
        //bool inv = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Triangle_Air_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteActive")
        //    .Append("tri_Seed",hidSeed.Text)
        //    .Append("str",rowID)}).Update();
        #endregion




        if (dt != null)
        {

            ControlBinder.pageTitleMsg(true, "Air Shipment:" + labLotNo.Text, "<p class=\"success\">Status : Record Saved with Lot No.  <span>" + labLotNo.Text + "</span>  </p>", div_bottom);
            if (dt != null && dt.Rows.Count > 0 && !string.IsNullOrEmpty(dt.Rows[0][0].ToString()))
            {
                X.Redirect("List.aspx?seed=" + dt.Rows[0][0]);
            }
            else
            {
                DataBinder();
            }

        }
        else
        {
            ControlBinder.pageTitleMsg(false, "Air Shipment:" + labLotNo.Text, "<p class=\"error\">Status :  Saved  failed ! ! !  </p>", div_bottom);
        }

        txtMAWB.Focus(true);
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

        if (!VoidCheckAC.CheckisAC("AT", hidSeed.Text))
        {
            X.MessageBox.Alert("Status", VoidCheckAC.Message).Show();
            return;
        }

        if (seedid != "")
        {
            string voidflag = hidVoid.Text == "0" ? "Y" : "N";
            DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "T").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text==""?null:hidSeed.Text)}).GetList();
            if (l != null && l.Tables[0].Rows[0][0].ToString() == "Y")
            {
                X.AddScript("$('#img_void').css('display','inline');");
                btnNext.Disabled = true;
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                //btnUpdateLotNo.Hide();
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "N")
            {
                X.AddScript("$('#img_void').css('display','none');");
                btnNext.Disabled = false;
                btnSave.Disabled = false;
                btnCancel.Disabled = false;
                btnVoid.Text = "Void";
                hidVoid.Text = "0";
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "Air Shipment:" + labLotNo.Text, "<p class=\"error\"> Status : Saving  failed  ! ! !   </p>", div_bottom);
            }
            DataBinder();
            ControlBinder.pageTitleMsg(true, "Air Shipment:" + labLotNo.Text, "<p>Status :  Edit  Air Shipment  of <span>" + labLotNo.Text + "</span></p>", div_bottom);
        }
    }


}


#region   /// 实体类



class Invocie
{
    public string RowID { get; set; }
}
#endregion
