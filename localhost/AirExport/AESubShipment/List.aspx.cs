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

public partial class AirExport_AESubShipment_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    public static string sys = "AE";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"] ;
            hidMAWB.Text = Request["MAWB"] == null ? "" : Request["MAWB"];
            hidIDList.Text = Server.UrlDecode( Request["IDList"] == null ? "" : Request["IDList"]);
            ControlBinder.DateFormat(txtEst);
            ControlBinder.DateFormat(txtAct);
            txtCS.Text = FSecurityHelper.CurrentUserDataGET()[0];
            CmbNP.SelectedItem.Value = "N";
            txtEst.Text = DateTime.Now.AddDays(0).ToString("yyyy/MM/dd");
            txtEst.RawText = DateTime.Now.AddDays(0).ToString("dd/MM/yyyy");
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
                CmbReceipt.Focus();
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
            btnPull.Disabled = true;
            btnNew.Disabled = true;
            btnVoid.Disabled = true;
        }
    }
    #endregion

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


    #region GetDs(string CmdText, List<IFields> fields)   Author ：hcy   (2011-11-23)
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

    #region   GetComboxDs()    Author ：Hcy   (2011-11-23)
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

    #region   ComboBoxBinding()    Author ：Hcy   (2011-11-23)
    private void ComboBoxBinding()
    {
        DataSet dsLocation = GetComboxDs("LocationList");
        DataSet dsSalesman = GetComboxDs("SalesList");
        DataSet dsUnit = GetComboxDs("UnitBinding");
        DataSet dsKind = GetComboxDs("QtyKindBinding");
        DataSet dsShowIn = GetComboxDs("GetShowIn");
        DataSet dsGetItem = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetItem_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetItem").Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("SYS","A") }).GetList();
        StoreGetItem.DataSource = dsGetItem;
        StoreGetItem.DataBind();

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


    #region   DataBinding()    Author ：Hcy   (2011-11-23)
    private void DataBindList()
    {
        txtHawb.Focus(true);
        
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetSubShipment")
            .Append("air_Seed", hidSeed.Text==""?null:hidSeed.Text)
            .Append("str",hidIDList.Text)
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("air_SYS", sys)
            );
        DataSet ds = GetDs("FW_AirExport_SubShipment_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0 && hidSeed.Text != "0" && hidSeed.Text != "")
        {
            

            string tempmawb = ds.Tables[0].Rows[0]["MAWB"].ToString().ToUpper() == "" ? "" : "MAWB# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["MAWB"].ToString().ToUpper() + "</span>";
            string tempLotNo = ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() == "" ? "" : "Lot# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() + "</span>";
            labHeader.Html = "Book# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["BookNo"].ToString().ToUpper() +"</span>"+ (tempmawb == "" ? "" : "<span style='padding-left:10px'>" + tempmawb + "</span>") + (tempLotNo == "" ? "" : "<span style='padding-left:10px'>" + tempLotNo + "</span>");
            hidLotNo.Text = ds.Tables[0].Rows[0]["BookNo"].ToString();


            txtHawb.Text = ds.Tables[0].Rows[0]["HAWB"].ToString();
            txtReference.Text = ds.Tables[0].Rows[0]["Reference"].ToString();
            chkSpecial.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["SpecicalDeal"].ToString() == "N" ? 0 : 1);
            CmbReceipt.setValue(ds.Tables[0].Rows[0]["Receipt"].ToString());
            CmbFinalDest.setValue(ds.Tables[0].Rows[0]["Destination"].ToString());
            CmbSalesman.setValue(ds.Tables[0].Rows[0]["Salesman"].ToString());
            txtEst.Text = ds.Tables[0].Rows[0]["EstReceipt"].ToString();
            txtAct.Text = ds.Tables[0].Rows[0]["ActReceipt"].ToString();
            txtCS.Text = ds.Tables[0].Rows[0]["air_User"].ToString();
            CmbNP.SelectedItem.Value = ds.Tables[0].Rows[0]["NP"].ToString();

            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Shipper"].ToString());
            CmbShipperCode.Text = ds.Tables[0].Rows[0]["ShipperName"].ToString();
            CmbConsignee.setValue(ds.Tables[0].Rows[0]["Consignee"].ToString());
            CmbConsignee.Text = ds.Tables[0].Rows[0]["ConsigneeName"].ToString();

            CmbNotify1.setValue(ds.Tables[0].Rows[0]["Notify1"].ToString());
            CmbNotify1.Text = ds.Tables[0].Rows[0]["Notify1Name"].ToString();
            CmbNotify2.setValue(ds.Tables[0].Rows[0]["Notify2"].ToString());
            CmbNotify2.Text = ds.Tables[0].Rows[0]["Notify2Name"].ToString();

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
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CBF"].ToString()))
                txtCbf.Text = ds.Tables[0].Rows[0]["CBF"].ToString();
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
                btnPull.Disabled = true;
                btnNew.Disabled = true;
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
            }

            if (ds.Tables[1].Rows.Count > 0)
            {
                gpHAWB.GetStore().DataSource = ds.Tables[1];
                gpHAWB.GetStore().DataBind();
                double GWT = 0, VWT = 0, CWT = 0, Pieces = 0, Pallets = 0;
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    GWT += Convert.ToDouble(ds.Tables[1].Rows[i]["GWT"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["GWT"].ToString());
                    VWT += Convert.ToDouble(ds.Tables[1].Rows[i]["VWT"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["VWT"].ToString());
                    CWT += Convert.ToDouble(ds.Tables[1].Rows[i]["CWT"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["CWT"].ToString());
                    Pieces += Convert.ToDouble(ds.Tables[1].Rows[i]["Piece"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["Piece"].ToString());
                    Pallets += Convert.ToDouble(ds.Tables[1].Rows[i]["Pallet"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["Pallet"].ToString());
                }
                lblGWT.Text = GWT.ToString("0.000");
                lblVWT.Text = VWT.ToString("0.000");
                lblCWT.Text = CWT.ToString("0.000");
                lblPiece.Text = Pieces.ToString();
                lblPallet.Text = Pallets.ToString();
            }
            
            
            
            gpInvoice.GetStore().DataSource = ds.Tables[3];
            gpInvoice.GetStore().DataBind();

            ControlBinder.pageTitleMsg(false, "AE-H:" + hidLotNo.Text, "<p>Status :  Edit  HAWB of  <span>" + hidLotNo.Text + "</span></p>", div_bottom);
        }
        else
        {
            if (ds.Tables[1].Rows.Count > 0)
            {
                gpHAWB.GetStore().DataSource = ds.Tables[1];
                gpHAWB.GetStore().DataBind();
                double GWT = 0, VWT = 0, CWT = 0, Pieces = 0, Pallets = 0;
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    GWT += Convert.ToDouble(ds.Tables[1].Rows[i]["GWT"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["GWT"].ToString());
                    VWT += Convert.ToDouble(ds.Tables[1].Rows[i]["VWT"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["VWT"].ToString());
                    CWT += Convert.ToDouble(ds.Tables[1].Rows[i]["CWT"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["CWT"].ToString());
                    Pieces += Convert.ToDouble(ds.Tables[1].Rows[i]["Piece"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["Piece"].ToString());
                    Pallets += Convert.ToDouble(ds.Tables[1].Rows[i]["Pallet"].ToString() == "" ? "0" : ds.Tables[1].Rows[i]["Pallet"].ToString());
                }
                lblGWT.Text = GWT.ToString("0.000");
                lblVWT.Text = VWT.ToString("0.000");
                lblCWT.Text = CWT.ToString("0.000");
                lblPiece.Text = Pieces.ToString();
                lblPallet.Text = Pallets.ToString();

                txtGWT.Text = lblGWT.Text;
                txtVWT.Text = lblVWT.Text;
                txtCWT.Text = lblCWT.Text;
                txtPiece.Text = lblPiece.Text;
                txtPallet.Text = lblPallet.Text;
            }
            ControlBinder.pageTitleMsg(false, "AE-H New", "<p>Status :  New Blank  HAWB </p>", div_bottom);
        }
        

    }
    #endregion


    #region    btnCancel_Click()     Author：Hcy   (2011-11-23)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        DataBindList();
        X.AddScript("BindingCost();");
    }
    #endregion

    #region    btnVoid_Click()     Author：Hcy   (2011-11-23)
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
              string voidflag = hidVoid.Text == "0" ? "Y" : "N";
              DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "A").Append("Type", "HAWB").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text==""?null:hidSeed.Text)}).GetList();
              if (l != null && l.Tables[0].Rows[0][0].ToString() == "Y")
              {
                  X.AddScript("$('#img_void').css('display','inline');");
                  btnSave.Disabled = true;
                  btnCancel.Disabled = true;
                  btnPull.Disabled = true;
                  btnNew.Disabled = true;
                  btnVoid.Text = "Active";
                  hidVoid.Text = "1";
              }
              else if (l != null && l.Tables[0].Rows[0][0].ToString() == "N")
              {
                  X.AddScript("$('#img_void').css('display','none');");
                  btnSave.Disabled = false;
                  btnCancel.Disabled = false;
                  btnPull.Disabled = false;
                  btnNew.Disabled = false;
                  btnVoid.Text = "Void";
                  hidVoid.Text = "0";
              }
              else if (l != null && l.Tables[0].Rows[0][0].ToString() == "S")
              {
                  X.Msg.Alert("Information", "Sub HAWB can't be active,because MAWB is void.").Show();
              }
              else
              {
                  ControlBinder.pageTitleMsg(false, "AE-H:" + hidLotNo.Text, "<p class=\"error\">Status :  Void failed, please check the data . </p>", div_bottom);
              }
              DataBindList();
              ControlBinder.pageTitleMsg(true, "AE-H:" + hidLotNo.Text, "<p>Status :  Edit  HAWB of  <span>" + hidLotNo.Text + "</span></p>", div_bottom);
        }
    }


    #region    btnSave_Click()     Author：Hcy   (2011-11-23)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        if (string.IsNullOrEmpty(CmbReceipt.Value.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, From can't be empty!</p>";
            CmbReceipt.Focus();
            return;
        }
        if (string.IsNullOrEmpty(CmbFinalDest.Value.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, To can't be empty!</p>";
            CmbFinalDest.Focus();
            return;
        }
        if (string.IsNullOrEmpty(txtEst.RawText.Trim()))
        {
            div_bottom.Html = "<p class='error'> Save failed, Est Receipt can't be empty!</p>";
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
            txtPiece.Focus(true);
            return;
        }

        List<IFields> UpdateHAWB = new List<IFields>();
        UpdateHAWB.Add(dal.CreateIFields().Append("Option", "Update")
            .Append("air_Seed", hidSeed.Text==""?null:hidSeed.Text)
            .Append("air_ToMAWB", hidMAWB.Text==""?null:hidMAWB.Text)

            .Append("air_HAWB", txtHawb.Text.Trim().ToUpper())
            .Append("air_CompanyReferance", txtReference.Text.Trim().ToUpper())
            .Append("air_SpecicalDeal", chkSpecial.Checked ? "Y" : "N")
            .Append("air_LocReceived",CmbReceipt.Value)
            .Append("air_LocFinal", CmbFinalDest.Value)
            .Append("air_EReceipt", ControlBinder.getDate(txtEst.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtEst.RawText.Trim()))
            .Append("air_AReceipt", ControlBinder.getDate(txtAct.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtAct.RawText.Trim()))

            .Append("air_Sales", CmbSalesman.Value)
            //.Append("air_CSMode",txtCS.Text)
            .Append("air_NP", CmbNP.SelectedItem.Value)

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
            .Append("air_CBM", string.IsNullOrEmpty(txtCbf.Text) ? DBNull.Value : (object)txtCbf.Text)

            .Append("code", FSecurityHelper.CurrentUserDataGET()[4].ToString() + sys)
            .Append("code1", FSecurityHelper.CurrentUserDataGET()[4].ToString() + sys + "SN")
            .Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("air_SYS", sys)
            .Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            );
        try
        {
            DataSet ds = GetDs("FW_AirExport_SubShipment_SP", UpdateHAWB);
            hidSeed.Text = ds.Tables[0].Rows[0][0].ToString();
            string newFlag = ds.Tables[0].Rows[0][1].ToString();

            #region HAWBList
            var HAWBList = JSON.Deserialize<List<HAWBList>>(e.ExtraParams["p_safety_2"]);
            List<IFields> HAWBLists = new List<IFields>();
            string RowID = "";
            for (int i = 0; i < HAWBList.Count; ++i)
            {
                HAWBLists.Add(dal.CreateIFields().Append("Option", "UpdateEmptyHAWB").
                    Append("air_ROWID", HAWBList[i].RowID)
                   .Append("air_ToHAWB", hidSeed.Text));
                RowID += "," + HAWBList[i].RowID.ToString();
            }
            bool result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_SubShipment_SP", new List<IFields> { dal.CreateIFields().Append("Option", "AddSubShipmentByIDList")
                .Append("str", RowID).Append("User",FSecurityHelper.CurrentUserDataGET()[0].ToString()).Append("air_ToHAWB",hidSeed.Text) }).Update();
            dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_SubShipment_SP", HAWBLists).Update();
            #endregion

            #region Costing
            //X.AddScript("saveCost('" + hidSeed.Text + "');");

            ucCost.costseed = hidSeed.Text;
            ucCost.btnCostEvent(sender, e);
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
            //bool inv = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_SubShipment_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteInvoice")
            //.Append("air_ToHAWB",hidSeed.Text)
            //.Append("str",InvoiceID)}).Update();
            #endregion

            //update cost(Qty,unit,total)
            //ControlBinder.UpdateCostData(hidSeed.Text, "AE", "HAWB");
            if (newFlag == "N")
            {
                DataBindList();
                X.AddScript("if(window.opener!=null){if(typeof(window.opener.RefreshList)!='undefined'){window.opener.RefreshList();}}");
                ControlBinder.pageTitleMsg(false, "AE-H:" + hidLotNo.Text, "<p class=\"success\">Status : Save successfully ! </p>", div_bottom);
            }
            else
            {
                X.AddScript("if(window.opener!=null){if(typeof(window.opener.RefreshList)!='undefined'){window.opener.RefreshList();}}");
                ControlBinder.pageTitleMsg(false, "AE-H:" + hidLotNo.Text, "<p class=\"success\">Status : Save successfully ! </p>", div_bottom);
                X.Redirect("List.aspx?seed=" + ds.Tables[0].Rows[0][0] + "&MAWB=" + hidMAWB.Value);
            }
            
        }
        catch
        {
            ControlBinder.pageTitleMsg(false, "AE-H:" + hidLotNo.Text, "<p class=\"error\">Status : Save failed, please check the data !</p>", div_bottom);
        }


    }
    #endregion

    #region    btnNext_Click()     Author：Hcy   (2011-11-23)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        btnSave_Click(sender, e);
        X.Redirect("list.aspx?MAWB=" + hidMAWB.Value);
    }
    #endregion


    #region    btnCosolManage_Click()     Author：Hcy   (2011-11-23)
    protected void btnCosolManage_Click(object sender, DirectEventArgs e)
    {
        var HAWBList = JSON.Deserialize<List<HAWBList>>(e.ExtraParams["p_safety_3"]);
        string RowID = "";
        for (int i = 0; i < HAWBList.Count; ++i)
        {
            RowID += "," + HAWBList[i].RowID.ToString();
        }
        if (RowID.Length > 1)
        {
            RowID = RowID.Substring(1, RowID.Length - 1);
        }

        X.AddScript("window.showModalDialog('../AEManageMentList/List.aspx?transfer=sub&subseed=" + hidSeed.Text + "&MAWB=" + hidMAWB.Text + "&subIDList=" + Server.UrlEncode(RowID) + "',window,'dialogWidth=980px,dialogHeight=750px,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,directories=no,resizable=no');");
    }
    #endregion

    #region    btnCoLoaderIn_Click()     Author：Hcy   (2011-11-23)
    protected void btnCoLoaderIn_Click(object sender, DirectEventArgs e)
    {
        //X.AddScript("window.open('../AEManageMentList/List.aspx');");

        var HAWBList = JSON.Deserialize<List<HAWBList>>(e.ExtraParams["p_safety_3"]);
        string RowID = "";
        for (int i = 0; i < HAWBList.Count; ++i)
        {
            RowID += "," + HAWBList[i].RowID.ToString();
        }
        if (RowID.Length > 1)
        {
            RowID = RowID.Substring(1, RowID.Length - 1);
        }
        //X.Redirect("../AEManageMentList/List.aspx?seed=" + hidSeed.Text + "&MAWB=" + hidMAWB.Text + "&IDList=" + Server.UrlEncode(RowID));

        X.AddScript("window.showModalDialog('../AEShipAndColIn/List.aspx?type=i&transfer=sub&subseed=" + hidSeed.Text + "&MAWB=" + hidMAWB.Text + "&subIDList=" + Server.UrlEncode(RowID) + "',window,'dialogWidth=980px,dialogHeight=750px,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,directories=no,resizable=no');");
    }
    #endregion


    #region    btnShippingNote_Click()     Author：Hcy   (2011-11-23)
    protected void btnShippingNote_Click(object sender, DirectEventArgs e)
    {
        //X.AddScript("window.open('../AEManageMentList/List.aspx');");

        var HAWBList = JSON.Deserialize<List<HAWBList>>(e.ExtraParams["p_safety_3"]);
        string RowID = "";
        for (int i = 0; i < HAWBList.Count; ++i)
        {
            RowID += "," + HAWBList[i].RowID.ToString();
        }
        if (RowID.Length > 1)
        {
            RowID = RowID.Substring(1, RowID.Length - 1);
        }
        //X.Redirect("../AEManageMentList/List.aspx?seed=" + hidSeed.Text + "&MAWB=" + hidMAWB.Text + "&IDList=" + Server.UrlEncode(RowID));

        X.AddScript("window.showModalDialog('../AEShipAndColIn/List.aspx?type=s&transfer=sub&subseed=" + hidSeed.Text + "&MAWB=" + hidMAWB.Text + "&subIDList=" + Server.UrlEncode(RowID) + "',window,'dialogWidth=980px,dialogHeight=630px,status=no,resizable=yes');");
    }
    #endregion


    #region HAWBList
    class HAWBList
    {
        public int RowID
        { get; set; }
    }
    #endregion

    #region Invoice
    class Invocie
    {
        public string RowID { get; set; }
    }
    #endregion

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
    public void UpdateHawb(int id,string hawb)
    {
        bool result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_SubShipment_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateHawbByID")
                .Append("air_HAWB", hawb).Append("air_ROWID",id.ToString()) }).Update();
    }
    [DirectMethod]
    public void RefreshData(string seed, string str)
    {
       
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_SubShipment_SP", new List<IFields> { dal.CreateIFields().Append("Option", "RefreshData")
                .Append("air_Seed", seed==""?null:seed).Append("str",str) }).GetList();

        if (ds!=null&&ds.Tables[0].Rows.Count > 0)
        {
            gpHAWB.GetStore().DataSource = ds.Tables[0];
            gpHAWB.GetStore().DataBind();
            double GWT = 0, VWT = 0, CWT = 0, Pieces = 0, Pallets = 0;
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GWT += Convert.ToDouble(ds.Tables[0].Rows[i]["GWT"].ToString() == "" ? "0" : ds.Tables[0].Rows[i]["GWT"].ToString());
                VWT += Convert.ToDouble(ds.Tables[0].Rows[i]["VWT"].ToString() == "" ? "0" : ds.Tables[0].Rows[i]["VWT"].ToString());
                CWT += Convert.ToDouble(ds.Tables[0].Rows[i]["CWT"].ToString() == "" ? "0" : ds.Tables[0].Rows[i]["CWT"].ToString());
                Pieces += Convert.ToDouble(ds.Tables[0].Rows[i]["Piece"].ToString() == "" ? "0" : ds.Tables[0].Rows[i]["Piece"].ToString());
                Pallets += Convert.ToDouble(ds.Tables[0].Rows[i]["Pallet"].ToString() == "" ? "0" : ds.Tables[0].Rows[i]["Pallet"].ToString());
            }
            lblGWT.Text = GWT.ToString("0.000");
            lblVWT.Text = VWT.ToString("0.000");
            lblCWT.Text = CWT.ToString("0.000");
            lblPiece.Text = Pieces.ToString();
            lblPallet.Text = Pallets.ToString();

            txtGWT.Text = lblGWT.Text;
            txtVWT.Text = lblVWT.Text;
            txtCWT.Text = lblCWT.Text;
            txtPiece.Text = lblPiece.Text;
            txtPallet.Text = lblPallet.Text;
        }

    }
}

