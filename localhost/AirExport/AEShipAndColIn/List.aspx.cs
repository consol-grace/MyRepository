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

public partial class AirExport_AEColoaderIn_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    private static string sys = "AE";
    private static string typename = "s";
    private static string showname = "AE-Shipping Note";
    private static string DODRowID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)

        {
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            hidMAWB.Text = Request["MAWB"] == null ? "" : Request["MAWB"];
            typename = Request["type"] == null ? "s" : Request["type"].ToLower();
            showname = typename == "s" ? "AE-Shipping Note" : "AE-Coloader In";
            DODRowID = string.IsNullOrEmpty(Request["DODRowID"]) ? "" : Request["DODRowID"].Substring(0, Request["DODRowID"].Length - 1);
            ControlBinder.DateFormat(txtEst);
            ControlBinder.DateFormat(txtAct);
            txtCS.Text = FSecurityHelper.CurrentUserDataGET()[0];
            CmbNP.SelectedItem.Value = "N";
            txtEst.Text = DateTime.Now.AddDays(0).ToString("yyyy/MM/dd");
            txtEst.RawText = DateTime.Now.AddDays(0).ToString("dd/MM/yyyy");
            f_company.Focus();
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                ComboBoxBinding();
                CmbUnit.setValue("CTN");
                CmbDeparture.setValue(FSecurityHelper.CurrentUserDataGET()[4]);

                DataBindPO();
                DataBindList();
                txtHawb.Focus();
                if (typename == "s")
                {
                    chkSpecial.Show();
                    CmbCoLoader.Visible = false;
                    txtNature.Visible = false;
                }
                else
                {
                    chkSpecial.Hide();
                    X.AddScript("CheckSpecial(true);");
                    CmbCoLoader.Visible = true;
                    txtNature.Visible = true;
                    btnPrint.Hidden = true;
                }
                LockControl();
                //X.AddScript("showCompanyRemark('CmbShipperCode,CmbConsignee,CmbNotify1,CmbNotify2', 'Shipper,Consignee,Notify #1,Notify #2');");
            }
        }
    }

    /// <summary>
    /// 绑定从POOL页面带过来的数据 GRACE
    /// </summary>
    
  
    public void DataBindPO()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields>() {dal.CreateIFields()
                    .Append("Option", "Bind")
                    .Append("DODRowID",DODRowID)
                    }).GetTable();

        if (dt != null)
        {
            CmbShipperCode.setValue(dt.Rows[0]["dod_Shipper"].ToString());
            CmbShipperCode.Text = dt.Rows[0]["DODShipperName"].ToString();
            CmbConsignee.setValue(dt.Rows[0]["dod_Consignee"].ToString());
            CmbConsignee.Text = dt.Rows[0]["DODConsigneeName"].ToString();
            txtCbf.Text = dt.Rows[0]["dod_CBM"].ToString();
            txtPallet.Text = dt.Rows[0]["do_Pallets"].ToString();
            txtGWT.Text = dt.Rows[0]["do_GW"].ToString();
             
        }
    }

    /// <summary>
    /// 点击ADD按钮，汇总打勾的记录 GRACE
    /// </summary>
    /// <param name="rowID"></param>
    [DirectMethod]
    public void AddPOData(string rowID)
    {
        DODRowID = rowID;
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields>() {dal.CreateIFields()
                    .Append("Option", "Bind")
                    .Append("DODRowID",rowID)
                    }).GetTable();

        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetAECoLoaderIn")
            .Append("air_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("air_SYS", sys));

        DataSet ds = GetDs("FW_AirExport_CoLoaderIn_SP", Getlist);

        if (dt != null && ds!=null)
        {
            if (string.IsNullOrEmpty(dt.Rows[0]["dod_CBM"].ToString()))
            {
                if (string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CBF"].ToString()))
                {
                    txtCbf.Text = "";
                }
                else
                {
                    txtCbf.Text = decimal.Parse(ds.Tables[0].Rows[0]["CBF"].ToString()).ToString();
                }
            }
            else
            {
                if (string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CBF"].ToString()))
                {
                    txtCbf.Text = decimal.Parse(dt.Rows[0]["dod_CBM"].ToString()).ToString(); 
                }
                else
                {
                    txtCbf.Text = (decimal.Parse(dt.Rows[0]["dod_CBM"].ToString()) + decimal.Parse(ds.Tables[0].Rows[0]["CBF"].ToString())).ToString();
                }
            }

            if (string.IsNullOrEmpty(dt.Rows[0]["do_Pallets"].ToString()))
            {
                if (string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Pallet"].ToString()))
                {
                    txtPallet.Text = "";
                }
                else
                {
                    txtPallet.Text = ds.Tables[0].Rows[0]["Pallet"].ToString();
                }
            }
            else
            {
                if (string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Pallet"].ToString()))
                {
                    txtPallet.Text = dt.Rows[0]["do_Pallets"].ToString();
                }
                else
                {
                    txtPallet.Text = (Convert.ToInt32(dt.Rows[0]["do_Pallets"]) + Convert.ToInt32(ds.Tables[0].Rows[0]["Pallet"])).ToString();
                }
            }

            if (string.IsNullOrEmpty(dt.Rows[0]["do_GW"].ToString()))
            {
                if (string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
                {
                    txtGWT.Text = "";
                }
                else
                {
                    txtGWT.Text = decimal.Parse(ds.Tables[0].Rows[0]["GWT"].ToString()).ToString();
                }
            }
            else
            {
                if (string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
                {
                    txtGWT.Text = decimal.Parse(dt.Rows[0]["do_GW"].ToString()).ToString();
                }
                else
                {
                    txtGWT.Text = (decimal.Parse(dt.Rows[0]["do_GW"].ToString()) + decimal.Parse(ds.Tables[0].Rows[0]["GWT"].ToString())).ToString();
                }
            }
           
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
            btnPrint.Disabled = true;
            X.AddScript("$('#showGenerate').hide();");
        }
        else
        {
            if (hidSeed.Text.Length > 1)
            {
                X.AddScript("TransferVoid();");
            }
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
        StoreCurrInvoice.DataSource = GetComboxDs("CurrencysInvoice");
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
    protected void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsSalesman = GetComboxDs("SalesList");
        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();
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




    #region GetDs(string CmdText, List<IFields> fields)   Author ：hcy   (2011-11-11)
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

    #region   GetComboxDs()    Author ：Hcy   (2011-11-11)
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

    #region   ComboBoxBinding()    Author ：Hcy   (2011-11-11)
    private void ComboBoxBinding()
    {
        DataSet dsLocation = GetComboxDs("LocationList");
        DataSet dsSalesman = GetComboxDs("SalesList");
        DataSet dsCurrency = GetComboxDs("CurrencysList");
        DataSet dsCurrencysListForeign = GetComboxDs("CurrencysInvoiceForeign");
        DataSet dsUnit = GetComboxDs("UnitBinding");
        DataSet dsItem = GetComboxDs("ItemBinding");
        DataSet dsKind = GetComboxDs("QtyKindBinding");
        DataSet dsShowIn = GetComboxDs("GetShowIn");
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();
        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

        DataSet dsCur = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_CoLoaderIn_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetCurrency").Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12]) }).GetList();

        StoreCurrForeign.DataSource = dsCur.Tables[0];
        StoreCurrForeign.DataBind();

        StoreCurrLocal.DataSource = dsCur.Tables[1];
        StoreCurrLocal.DataBind();

        if (dsCur != null && dsCur.Tables[2].Rows.Count > 0)
        {
            CmbForeign.SelectedItem.Value = dsCur.Tables[2].Rows[0][0].ToString();
            lblCurForeign.Text = dsCur.Tables[2].Rows[0][0].ToString();
        }
        if (dsCur != null && dsCur.Tables[3].Rows.Count > 0)
        {
            CmbLocal.SelectedItem.Value = dsCur.Tables[3].Rows[0][0].ToString();
            lblCurLocal.Text = dsCur.Tables[3].Rows[0][0].ToString();
        }

        StoreCurrInvoiceForeign.DataSource = dsCurrencysListForeign;
        StoreCurrInvoiceForeign.DataBind();

        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();

        StoreSalesman.DataSource = dsSalesman;
        StoreSalesman.DataBind();

        StoreUnit.DataSource = dsUnit;
        StoreUnit.DataBind();

        StoreCurrInvoice.DataSource = GetComboxDs("CurrencysInvoice");
        StoreCurrInvoice.DataBind();



        StoreKind.DataSource = dsKind;
        StoreKind.DataBind();

        StoreShowIn.DataSource = dsShowIn;
        StoreShowIn.DataBind();

        ControlBinder.CmbBinder(StoreAgentLocal, "PPCC", "A");
    }
    #endregion


    #region   DataBinding()    Author ：Hcy   (2011-11-14)
    private void DataBindList()
    {
        
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetAECoLoaderIn")
            .Append("air_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("air_SYS", sys)
            );
        DataSet ds = GetDs("FW_AirExport_CoLoaderIn_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {

            //string tempmawb = "MAWB#:" + ds.Tables[0].Rows[0]["MAWB"].ToString().ToUpper();
            //string tempLotNo = "Lot#:" + ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper();
            //labHeader.Html = "SN#:" + ds.Tables[0].Rows[0]["BookNo"].ToString().ToUpper() + (tempmawb == "MAWB#:" ? "" : "<span style='padding-left:10px'>" + tempmawb + "</span>") + (tempLotNo == "Lot#:" ? "" : "<span style='padding-left:10px'>" + tempLotNo + "</span>");
            //hidLotNo.Text = ds.Tables[0].Rows[0]["BookNo"].ToString();

            string tempmawb = ds.Tables[0].Rows[0]["MAWB"].ToString().ToUpper() == "" ? "" : "MAWB# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["MAWB"].ToString().ToUpper() + "</span>";
            string tempLotNo = ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() == "" ? "" : "Lot# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() + "</span>";
            labHeader.Html = "Book# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["BookNo"].ToString().ToUpper() + "</span>" + (tempmawb == "" ? "" : "<span style='padding-left:10px'>" + tempmawb + "</span>") + (tempLotNo == "" ? "" : "<span style='padding-left:10px'>" + tempLotNo + "</span>");
            hidLotNo.Text = ds.Tables[0].Rows[0]["BookNo"].ToString();

            txtHawb.Text = ds.Tables[0].Rows[0]["HAWB"].ToString();
            txtReference.Text = ds.Tables[0].Rows[0]["Reference"].ToString();


            CmbDeparture.setValue(ds.Tables[0].Rows[0]["Departure"].ToString());
            CmbFinalDest.setValue(ds.Tables[0].Rows[0]["Destination"].ToString());
            CmbSalesman.setValue(ds.Tables[0].Rows[0]["Salesman"].ToString());
            txtEst.Text = ds.Tables[0].Rows[0]["EstReceipt"].ToString();
            txtAct.Text = ds.Tables[0].Rows[0]["ActReceipt"].ToString();
            txtCS.Text = ds.Tables[0].Rows[0]["air_User"].ToString();
            CmbNP.SelectedItem.Value = ds.Tables[0].Rows[0]["NP"].ToString();

            CmbCoLoader.setValue(ds.Tables[0].Rows[0]["CoLoader"].ToString());
            CmbCoLoader.Text = ds.Tables[0].Rows[0]["CoLoaderName"].ToString();
            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Shipper"].ToString());
            CmbShipperCode.Text = ds.Tables[0].Rows[0]["ShipperName"].ToString();
            CmbConsignee.setValue(ds.Tables[0].Rows[0]["Consignee"].ToString());
            CmbConsignee.Text = ds.Tables[0].Rows[0]["ConsigneeName"].ToString();

            CmbNotify1.setValue(ds.Tables[0].Rows[0]["Notify1"].ToString());
            CmbNotify1.Text = ds.Tables[0].Rows[0]["Notify1Name"].ToString();
            CmbNotify2.setValue(ds.Tables[0].Rows[0]["Notify2"].ToString());
            CmbNotify2.Text = ds.Tables[0].Rows[0]["Notify2Name"].ToString();
            txtNature.Text = ds.Tables[0].Rows[0]["Nature"].ToString();
            chkSpecial.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["SpecicalDeal"].ToString() == "N" ? 0 : 1);

            if (typename == "s")
                X.AddScript("CheckSpecial(" + chkSpecial.Checked.ToString().ToLower() + ");");
            else
                X.AddScript("CheckSpecial(true);");


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

            txtCbf.Text = ds.Tables[0].Rows[0]["CBF"].ToString();

            txtAccountRemark.Text = ds.Tables[0].Rows[0]["AccountRemark"].ToString();
            txtOperationRemark.Text = ds.Tables[0].Rows[0]["OperationRemark"].ToString();

            bool ismakehawb = ds.Tables[0].Rows[0]["air_MakeHAWB"].ToString() == "" ? false : Convert.ToBoolean(ds.Tables[0].Rows[0]["air_MakeHAWB"]);
            if (ismakehawb == true)
            {
                txtGWT.Disabled = true;
                txtVWT.Disabled = true;
                txtCWT.Disabled = true;
                txtPiece.Disabled = true;
            }
            else
            {
                txtGWT.Disabled = false;
                txtVWT.Disabled = false;
                txtCWT.Disabled = false;
                txtPiece.Disabled = false;
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
                btnPrint.Disabled = true;
                X.AddScript("$('#showGenerate').hide();");
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
            }

            if (ds.Tables[1].Rows.Count > 0)
            {
                lblCurForeign.Text = ds.Tables[1].Rows[0]["Currency"].ToString();
                CmbForeign.SelectedItem.Value = ds.Tables[1].Rows[0]["Currency"].ToString();
                gpForeign.GetStore().DataSource = ds.Tables[1];
                gpForeign.GetStore().DataBind();
            }
            if (ds.Tables[2].Rows.Count > 0)
            {
                hidForeignID.Text = ds.Tables[2].Rows[0]["RowID"].ToString();
                CmbCompany.setValue(ds.Tables[2].Rows[0]["CompanyCode"].ToString());
                CmbCompany.Text = ds.Tables[2].Rows[0]["CompanyName"].ToString();
                txtFor.Text = ds.Tables[2].Rows[0]["Min"].ToString();
            }
            if (ds.Tables[3].Rows.Count > 0)
            {
                lblCurLocal.Text = ds.Tables[3].Rows[0]["Currency"].ToString();
                CmbLocal.SelectedItem.Value = ds.Tables[3].Rows[0]["Currency"].ToString();
                gpLocal.GetStore().DataSource = ds.Tables[3];
                gpLocal.GetStore().DataBind();
            }
            if (ds.Tables[4].Rows.Count > 0)
            {
                hidLocalID.Text = ds.Tables[4].Rows[0]["RowID"].ToString();
                CmbCompany1.setValue(ds.Tables[4].Rows[0]["CompanyCode"].ToString());
                CmbCompany1.Text = ds.Tables[4].Rows[0]["CompanyName"].ToString();
                txtLoc.Text = ds.Tables[4].Rows[0]["Min"].ToString();
            }

            //gridCost.GetStore().DataSource = ds.Tables[5];
            //gridCost.GetStore().DataBind();

            gpAPCommssion.GetStore().DataSource = ds.Tables[6];
            gpAPCommssion.GetStore().DataBind();

            gpWTForeign.GetStore().DataSource = ds.Tables[7];
            gpWTForeign.GetStore().DataBind();

            gpWTLocal.GetStore().DataSource = ds.Tables[8];
            gpWTLocal.GetStore().DataBind();

            gpInvoice.GetStore().DataSource = ds.Tables[9];
            gpInvoice.GetStore().DataBind();

            ControlBinder.pageTitleMsg(false, showname + ":" + hidLotNo.Text, "<p>Status :  Edit  No. of  <span>" + hidLotNo.Text + "</span></p>", div_bottom);
        }
        else
        {
            ControlBinder.pageTitleMsg(false, showname, "<p>Status :  New Blank  HAWB </p>", div_bottom);
        }

    }
    #endregion


    #region    btnCancel_Click()     Author：Hcy   (2011-11-14)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        DataBindList();
        X.AddScript("BindingCost();");
    }
    #endregion

    #region    btnVoid_Click()     Author：Hcy   (2011-11-14)
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
            DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "A").Append("Type", "HAWB").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text==""?null:hidSeed.Text)}).GetList();
            if (l != null && l.Tables[0].Rows[0][0].ToString() == "Y")
            {
                X.AddScript("$('#img_void').css('display','inline');");
                btnSave.Disabled = true;
                btnCancel.Disabled = true;
                btnNext.Disabled = true;
                btnPrint.Disabled = true;
                X.AddScript("$('#showGenerate').hide();");
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "N")
            {
                X.AddScript("$('#img_void').css('display','none');");
                btnSave.Disabled = false;
                btnCancel.Disabled = false;
                btnNext.Disabled = false;
                btnPrint.Disabled = false;
                X.AddScript("$('#showGenerate').show();");
                btnVoid.Text = "Void";
                hidVoid.Text = "0";
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "S")
            {
                X.Msg.Alert("Information", "HAWB can't be active,because MAWB is void.").Show();
            }
            else if (l != null && l.Tables[0].Rows[0][0].ToString() == "H")
            {
                X.Msg.Alert("Information", "HAWB can't be active,because Sub HAWB is void.").Show();
            }
            else
            {
                ControlBinder.pageTitleMsg(false, showname + ":" + hidLotNo.Text, "<p class=\"error\">Status :  Void failed, please check the data . </p>", div_bottom);
            }
            DataBindList();
            ControlBinder.pageTitleMsg(true, showname + ":" + hidLotNo.Text, "<p>Status :  Edit  No. of  <span>" + hidLotNo.Text + "</span></p>", div_bottom);
        }
    }

    #region    btnSave_Click()     Author：Hcy   (2011-11-14)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        if (string.IsNullOrEmpty(CmbDeparture.Value.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, Receipt can't be empty!</p>";
            CmbDeparture.Focus();
            return;
        }
        if (string.IsNullOrEmpty(CmbFinalDest.Value.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, Dest. can't be empty!</p>";
            CmbFinalDest.Focus();
            return;
        }
        if (string.IsNullOrEmpty(txtEst.RawText.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, Est Receipt can't be empty!</p>";
            txtEst.Text = "";
            txtEst.Focus(true);
            return;
        }
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
        if (string.IsNullOrEmpty(CmbSalesman.Value.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, Salesman can't be empty!</p>";
            CmbSalesman.Focus();
            return;
        }
        if (string.IsNullOrEmpty(txtPiece.Text.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, Piece(s) can't be empty!</p>";
            txtPiece.Text = "";
            txtPiece.Focus(true);
            return;
        }

        List<IFields> UpdateHAWB = new List<IFields>();
        UpdateHAWB.Add(dal.CreateIFields().Append("Option", "Update")
            
            .Append("air_flag",Request["flag"])
            .Append("air_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("air_ToMAWB", hidMAWB.Text == "" ? null : hidMAWB.Text)

            .Append("air_HAWB", txtHawb.Text.Trim().ToUpper())
            .Append("air_CompanyReferance", txtReference.Text.Trim().ToUpper())
            .Append("air_Remark", txtNature.Text.Trim())
            .Append("air_CoLoader", CmbCoLoader.Value)
            //.Append("air_CoLoader",CmbCoLoaderName.SelectedItem.Value)
            .Append("air_LocReceived", CmbDeparture.Value)
            .Append("air_LocFinal", CmbFinalDest.Value)
            .Append("air_EReceipt", ControlBinder.getDate(txtEst.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtEst.RawText.Trim()))
            .Append("air_AReceipt", ControlBinder.getDate(txtAct.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtAct.RawText.Trim()))

            .Append("air_Sales", CmbSalesman.Value)
            //.Append("air_CSMode",txtCS.Text)
            .Append("air_NP", CmbNP.SelectedItem.Value)
            .Append("air_SpecicalDeal", chkSpecial.Checked ? "Y" : "N")

            .Append("air_Shipper", CmbShipperCode.Value)
            //.Append("air_Shipper", CmbShipperName.SelectedItem.Value)
            .Append("air_Consignee", CmbConsignee.Value)
            //.Append("air_Consignee", CmbConsigneeName.SelectedItem.Value)

            .Append("air_PartyA", CmbNotify1.Value)
            //.Append("air_PartyA", CmbNotify1Name.SelectedItem.Value)
            .Append("air_PartyB", CmbNotify2.Value)
            //.Append("air_PartyB", CmbNotify2Name.SelectedItem.Value)

            .Append("air_GWT", string.IsNullOrEmpty(txtGWT.Text) ? DBNull.Value : (object)txtGWT.Text)
            .Append("air_VWT", string.IsNullOrEmpty(txtVWT.Text) ? DBNull.Value : (object)txtVWT.Text)
            .Append("air_CWT", string.IsNullOrEmpty(txtCWT.Text) ? DBNull.Value : (object)txtCWT.Text)
            .Append("air_Piece", string.IsNullOrEmpty(txtPiece.Text) ? DBNull.Value : (object)txtPiece.Text)
            .Append("air_Unit", CmbUnit.Value)
            .Append("air_Pallet", string.IsNullOrEmpty(txtPallet.Text) ? DBNull.Value : (object)txtPallet.Text)
            .Append("air_CBM", txtCbf.Text.Trim().ToUpper())

            .Append("air_AccountRemark", txtAccountRemark.Text.Trim())
            .Append("air_OperationRemark", txtOperationRemark.Text.Trim())

            .Append("code", FSecurityHelper.CurrentUserDataGET()[4].ToString() + sys)
            .Append("code1", FSecurityHelper.CurrentUserDataGET()[4].ToString() + sys + (typename == "s" ? "SN" : "CL"))
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("air_SYS", sys)
            .Append("type", typename)
            .Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            );
        try
        {
            DataSet ds = GetDs("FW_AirExport_CoLoaderIn_SP", UpdateHAWB);
            hidSeed.Text = ds.Tables[0].Rows[0][0].ToString();
            string newFlag = ds.Tables[0].Rows[0][1].ToString();

            #region Foreign
            var Foreign = JSON.Deserialize<List<Foreign>>(e.ExtraParams["p_safety_l"]);
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
                    Append("si_Unit", CmbUnit.Value).
                    Append("si_ExRate", string.IsNullOrEmpty(Foreign[i].EX) ? DBNull.Value : (object)Foreign[i].EX).
                    Append("si_Rate", string.IsNullOrEmpty(Foreign[i].Rate) ? DBNull.Value : (object)Foreign[i].Rate).
                    Append("si_Amount", string.IsNullOrEmpty(Foreign[i].Amount) ? DBNull.Value : (object)Foreign[i].Amount).
                    Append("si_Min", string.IsNullOrEmpty(Foreign[i].Min) ? DBNull.Value : (object)Foreign[i].Min).
                    Append("si_ShowIn", Foreign[i].Show.Trim().ToUpper())
                    .Append("si_ROWID", Foreign[i].RowID)
                    .Append("si_ToHouse", hidSeed.Text)
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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualForeign").Append("si_Seed", hidSeed.Text).Append("str", ForeignID) }).Update();
            bool resultForeign = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", Foreignlist).Update();
            #endregion

            #region Foreign Freight
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateForFreight").Append("si_ROWID", string.IsNullOrEmpty(hidForeignID.Text) ? null : (object)hidForeignID.Text)
             .Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).Append("si_Sys", sys).Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString()).Append("si_ToHouse", hidSeed.Text)
             .Append("si_BillTo", CmbCompany.Value).Append("si_Min",string.IsNullOrEmpty(txtFor.Text) ? "0" : (object)txtFor.Text).Append("si_Currency", CmbForeign.SelectedItem.Value == null ? "USD" : CmbForeign.SelectedItem.Value).Append("si_Quantity", string.IsNullOrEmpty(txtCWT.Text) ? null : (object)txtCWT.Text).Append("si_Unit", CmbUnit.Value) }).Update();
            #endregion

            #region Local
            var Local = JSON.Deserialize<List<Local>>(e.ExtraParams["p_safety_2"]);
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
                    Append("si_Unit", CmbUnit.Value).
                    Append("si_ExRate", string.IsNullOrEmpty(Local[i].EX) ? DBNull.Value : (object)Local[i].EX).
                    Append("si_Rate", string.IsNullOrEmpty(Local[i].Rate) ? DBNull.Value : (object)Local[i].Rate).
                    Append("si_Amount", string.IsNullOrEmpty(Local[i].Amount) ? DBNull.Value : (object)Local[i].Amount).
                    Append("si_Min", string.IsNullOrEmpty(Local[i].Min) ? DBNull.Value : (object)Local[i].Min).
                    Append("si_ShowIn", Local[i].Show.Trim().ToUpper())
                    .Append("si_ROWID", Local[i].RowID)
                    .Append("si_ToHouse", hidSeed.Text)
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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualLocal").Append("si_Seed", hidSeed.Text).Append("str", LocalID) }).Update();
            bool resultLocal = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", Locallist).Update();
            #endregion

            #region Local Freight
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateLocFreight").Append("si_ROWID", string.IsNullOrEmpty(hidLocalID.Text) ? null : (object)hidLocalID.Text)
             .Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).Append("si_Sys", sys).Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString()).Append("si_ToHouse", hidSeed.Text)
             .Append("si_BillTo", CmbCompany1.Value).Append("si_Min", string.IsNullOrEmpty(txtLoc.Text) ? "0" : (object)txtLoc.Text).Append("si_Currency", CmbLocal.SelectedItem.Value == null ? "HKD" : CmbLocal.SelectedItem.Value).Append("si_Quantity", string.IsNullOrEmpty(txtCWT.Text) ? null : (object)txtCWT.Text).Append("si_Unit", CmbUnit.Value) }).Update();
            #endregion

            #region APCost
            //X.AddScript("saveCost('" + hidSeed.Text + "');");

            ucCost.costseed = hidSeed.Text;
            ucCost.btnCostEvent(sender, e);
            #endregion

            #region APCommssion
            var APCommssion = JSON.Deserialize<List<APCommssion>>(e.ExtraParams["p_safety_4"]);
            List<IFields> APCommssionlist = new List<IFields>();
            string APCommssionID = "";
            for (int i = 0; i < APCommssion.Count; ++i)
            {
                if (APCommssion[i].CompanyCode.Trim() != "" && APCommssion[i].Currency.Trim() != "")
                {
                    APCommssionlist.Add(dal.CreateIFields().Append("Option", "UpdateAPCommssion").
                    Append("si_BillTo", APCommssion[i].CompanyCode.Trim().ToUpper()).
                    Append("si_QtyKind", APCommssion[i].CalcKind.Trim().ToUpper()).
                    Append("si_Rate", string.IsNullOrEmpty(APCommssion[i].Rate) ? DBNull.Value : (object)APCommssion[i].Rate).
                    Append("si_Amount", string.IsNullOrEmpty(APCommssion[i].Amount) ? DBNull.Value : (object)APCommssion[i].Amount).
                    Append("si_Currency", APCommssion[i].Currency.Trim().ToUpper()).
                    Append("si_Remark", APCommssion[i].Remark.Trim().ToUpper()).
                    Append("si_EXRate", string.IsNullOrEmpty(APCommssion[i].EX) ? DBNull.Value : (object)APCommssion[i].EX)
                    .Append("si_ROWID", APCommssion[i].RowID)
                    .Append("si_ToHouse", hidSeed.Text)
                    .Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                    .Append("si_Sys", sys)
                    .Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                    );
                    APCommssionID += "," + APCommssion[i].RowID;
                }
            }
            //delete
            if (APCommssionID.Length > 1)
            {
                APCommssionID = APCommssionID.Substring(1, APCommssionID.Length - 1);
            }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualAPCommssion").Append("si_Seed", hidSeed.Text).Append("str", APCommssionID) }).Update();
            bool resultAPCommssion = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", APCommssionlist).Update();
            #endregion

            #region WTForeign
            var WTForeign = JSON.Deserialize<List<WTForeign>>(e.ExtraParams["p_safety_5"]);
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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualSellRateForeign").Append("aer_Seed", hidSeed.Text).Append("str", WTForeignID) }).Update();
            bool resultWTForeign = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", WTForeignlist).Update();
            #endregion

            #region WTLocal
            var WTLocal = JSON.Deserialize<List<WTLocal>>(e.ExtraParams["p_safety_6"]);
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
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteActualSellRateLocal").Append("aer_Seed", hidSeed.Text).Append("str", WTLocalID) }).Update();
            bool resultWTLocal = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ShipmentItemForColoaderIn_SP", WTLocallist).Update();
            #endregion

            #region LocalInvoice
            //var InvocieList = JSON.Deserialize<List<Invocie>>(e.ExtraParams["p_safety_invoice"]);
            //string InvoiceID = "";
            //for (int i = 0; i < InvocieList.Count; ++i)
            //{
            //    InvoiceID += "," + InvocieList[i].RowID;
            //}
            //if (InvoiceID.Length > 1)
            //{
            //    InvoiceID = InvoiceID.Substring(1, InvoiceID.Length - 1);
            //}
            //bool inv = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_CoLoaderIn_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteInvoice")
            //.Append("air_ToHAWB",hidSeed.Text)
            //.Append("str",InvoiceID)}).Update();
            #endregion

            #region updateFreightTotal
            string type1 = "N", type2 = "N";
            if (CmbCompany.Value != "") { type1 = "Y"; }
            if (CmbCompany1.Value != "") { type2 = "Y"; }
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_CoLoaderInFreight_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateTotal").Append("air_Seed", hidSeed.Text).Append("CWT", string.IsNullOrEmpty(txtCWT.Text) ? "0" : txtCWT.Text)
            .Append("Type1",type1).Append("Type2",type2).Append("F_Min", string.IsNullOrEmpty(txtFor.Text) ? "0" : txtFor.Text).Append("L_Min", string.IsNullOrEmpty(txtLoc.Text) ? "0" : txtLoc.Text) }).Update();
            #endregion

            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "AE", "HAWB");

            MakeInvoice();

            if (newFlag == "N")
            {


                //修改PO页面记录的BookingNo  GRACE
                #region updatePOBookingNo
                dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateBookingNO")
                    .Append("DODBookingNo", hidLotNo.Text).Append("DODRowID",DODRowID).Append("Master", DBNull.Value).Append("House",ds.Tables[0].Rows[0][0])}).Update();
                #endregion

                DataBindList();

                X.AddScript("if(window.opener!=null&&window.opener!=undefined){if(typeof(window.opener.RefreshList)!='undefined'&&typeof(window.opener.RefreshList)!='unknown'){window.opener.RefreshList();}}");
                ControlBinder.pageTitleMsg(true, showname + ":" + hidLotNo.Text, "<p class=\"success\">Status : Save successfully ! </p>", div_bottom);
            }
            else
            {
                string type = "", transseed = "", transidlist = "", idlist = "";
                type = Request["transfer"];
                idlist = ds.Tables[0].Rows[0][3].ToString();
                if (type == "c" || type == "d")
                {
                    transseed = Request["transSeed"];
                    transidlist = Server.UrlDecode(Request["transIDList"]);
                    idlist += "," + transidlist;
                    X.AddScript("window.dialogArguments.refreshdata(\"" + transseed + "\",\"" + idlist + "\");window.close();");
                }
                else if (type == "sub")
                {
                    transseed = Request["subSeed"];
                    transidlist = Server.UrlDecode(Request["subIDList"]);
                    idlist += "," + transidlist;
                    X.AddScript("window.dialogArguments.refreshdata(\"" + transseed + "\",\"" + idlist + "\");window.close();");
                }
                else if (type == "p")
                {
                    //修改PO页面记录的BookingNo  GRACE
                    #region updatePOBookingNo
                    dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateBookingNO")
                    .Append("DODBookingNo",ds.Tables[0].Rows[0][2]).Append("DODRowID",DODRowID).Append("Master", DBNull.Value).Append("House",ds.Tables[0].Rows[0][0])}).Update();
                    #endregion
                    // X.AddScript("window.dialogArguments.location.href='../../DeliveryOrder/DOPool/List.aspx?';window.close();");
                    //X.AddScript("window.opener.location.reload()");
                    X.AddScript("window.opener.$('#btnSearch').click();");
                    X.Redirect("List.aspx?type=" + typename + "&seed=" + ds.Tables[0].Rows[0][0] + "&MAWB=" + hidMAWB.Value);
                }
                else
                {
                    X.Redirect("List.aspx?type=" + typename + "&seed=" + ds.Tables[0].Rows[0][0] + "&MAWB=" + hidMAWB.Value);
                }
            }
        }
        catch
        {
            ControlBinder.pageTitleMsg(false, showname + ":" + hidLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data !</p>", div_bottom);
        }


    }
    #endregion

    #region    btnNext_Click()     Author：Hcy   (2011-11-14)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        btnSave_Click(sender, e);
        Response.Redirect("list.aspx?type=" + typename + "&MAWB=" + hidMAWB.Value);
    }
    #endregion

    /// <summary>
    /// GRACE 用于打开POOL页面
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnOpen_Click(object sender, DirectEventArgs e)
    {
        //X.AddScript("window.showModalDialog('../../DeliveryOrder/DOPool/List.aspx?isok=1');");
        // X.AddScript("alert(1);var win=this.parent.WinView; win.load('../../DeliveryOrder/DOPool/List.aspx?isok=1');win.show();");
        X.AddScript("window.showModalDialog('../../DeliveryOrder/DOPool/List.aspx?isok=1',window,'dialogWidth=980px,dialogHeight=750px,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,directories=no,resizable=no');");

    }

    #region    btnPrint_Click()     Author：Hcy   (2011-11-14)
    protected void btnPrint_Click(object sender, DirectEventArgs e)
    {
        string seedid = hidSeed.Text;
        if (seedid.Length > 1)
        {
            X.AddScript("window.open('../../AirExport/AEReportFile/ReportFile.aspx?type=ShippingNote&ID=" + seedid + "','_blank');");
        }
        
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

    

    #region APCommssion
    class APCommssion
    {
        public int RowID
        { get; set; }
        public string CompanyCode
        { get; set; }
        public string CalcKind
        { get; set; }
        public string Rate
        { get; set; }
        public string Amount
        { get; set; }
        public string Currency
        { get; set; }
        public string Remark
        { get; set; }
        public string EX
        { get; set; }
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

    #region Invoice
    class Invocie
    {
        public string RowID { get; set; }
    }
    #endregion

    [DirectMethod]
    public void BindSelectCurency(int type, string value)
    {
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "BindSelectList")
            .Append("air_Seed", hidSeed.Text)
            .Append("air_Type", type)
            .Append("si_Currency", value)
            );
        DataSet ds = GetDs("FW_AirExport_CoLoaderIn_SP", Getlist);
        if (type == 0)
        {
            gpForeign.GetStore().DataSource = ds;
            gpForeign.GetStore().DataBind();
        }
        else
        {
            gpLocal.GetStore().DataSource = ds;
            gpLocal.GetStore().DataBind();
        }
    }

    private string[] GetQtyAndUnit(string type)
    {
        string[] temp = new string[2];
        temp[1] = CmbUnit.Value;
        if (type == "GWT")
        {
            temp[0] = txtGWT.Text;
        }
        else if (type == "CWT")
        {
            temp[0] = txtCWT.Text;
        }
        else if (type == "VWT")
        {
            temp[0] = txtVWT.Text;
        }
        else if (type == "PCS")
        {
            temp[0] = txtPiece.Text;
        }
        else
        {
            temp[0] = "0";
        }
        return temp;
    }

    [DirectMethod]
    public void MakeInvoice()
    {
        if (hidSeed.Text.Length > 0)
        {
            bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AutoInvoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "MakeInvoice").
                Append("seed", hidSeed.Text).
                Append("user",FSecurityHelper.CurrentUserDataGET()[0])}).Update();

            //DataBindList();
        }
    }

}

