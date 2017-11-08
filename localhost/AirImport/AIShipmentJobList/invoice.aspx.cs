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

public partial class AirImport_AIShipmentJobList_invoice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!X.IsAjaxRequest)
        {
            if (Request["sys"].ToString() == "DM" || Request["sys"].ToString() == "BK" || Request["sys"].ToString() == "TK")
            {
                hidOtherSys.Text = "O";
            }
            else
            {
                hidOtherSys.Text = Request["sys"][0].ToString();
            }
            if (Request["sys"].ToString() == "OI")
            {
                txtInvoiceDate.Disabled = false;
            }
            UserControlTop1.sys = hidOtherSys.Text;
            hidStat.Text = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
            //txtCompany.Focus(true);
            txtContact.Focus(true);
        }
    }



    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            inv_Ex.Text = "1";
            GridCoum(Request["sys"]);
            InitControls();
            CmbBinder();
            inv_Currency.setValue(labCurrency1.Text);
            LockControl();

            //判断是否是财务,以及invoce为VOID,parentInvoice 没VOID的时候才显示ACTIVE按钮
            if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT" && hidIsVoid.Text == "Y" && hidParentActive.Text == "N")
            {
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                btnVoid.Disabled = false;
            }
        }
    }

    protected void LockControl()
    {
        hidAccount.Text = DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString();
        if (hidAccount.Text == "ACCOUNT")
        {
            btnOk.Disabled = true;
        }
        //if("AT,OT,TK,BK,DM".Contains(Request["sys"]))
        //{
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallTransfer_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "GetInvoiceLotNo").Append("sys",Request["sys"]).Append("seed",inv_Seed.Text)
            }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            if (dt.Rows[0][0].ToString() != labLotNo.Text)
            {
                labCurrentLotno.Html = "<span style='color:green;'>(" + dt.Rows[0][0].ToString() + ")</span>";
            }
        }
        //}
    }

    /// <summary>
    /// 全局变量
    /// </summary>
    #region   ///DataFactory 全局变量      Author：Micro      （2011-09-14）
    public readonly DataFactory dal = new DataFactory();
    public int b = 0;    //初始为可编辑；
    #endregion

    void InitControls()
    {
        inv_SYS.Text = Request["sys"];
        //ToHouse = string.IsNullOrEmpty(Request["H"])?DBNull.Value:(object)Request["H"];
        //ToMaster =  string.IsNullOrEmpty(Request["M"])?DBNull.Value:(object)Request["M"];
        inv_Seed.Text = string.IsNullOrEmpty(Request["seed"]) ? "0" : Request["seed"];
        inv_CopySeed.Text = string.IsNullOrEmpty(Request["copyseed"]) ? "0" : Request["copyseed"];
        if (string.IsNullOrEmpty(inv_SYS.Text)) { X.AddScript("alert('Invalid information ! ! !');window.close();"); return; }
        switch (inv_SYS.Text.ToUpper())
        {
            case "OI":
                Mawblab.Text = "MBL";
                Hawblab.Text = "HBL";
                labVorY.Text = "Vessel/ Voyage";
                labcVWT.Text = "CBM";
                labcPallet.Text = "Container";
                labCWT.Text = "WM";
                break;
            case "AI":
                Hawblab.Text = "HAWB";
                Mawblab.Text = "MAWB";
                labVorY.Text = "Flight No.";
                labcVWT.Text = "VWT";
                labcPallet.Text = "Pallet";
                labCWT.Text = "CWT";
                break;
            case "AE":
                Hawblab.Text = "HAWB";
                Mawblab.Text = "MAWB";
                labVorY.Text = "Flight No.";
                labcVWT.Text = "VWT";
                labcPallet.Text = "Pallet";
                labCWT.Text = "CWT";
                //if (Request["seed"] != null)
                //{
                //    Invoicedetail.Visible = true;
                //}
                break;
            case "OE":
                Mawblab.Text = "MBL";
                Hawblab.Text = "HBL";
                labVorY.Text = "Vessel/ Voyage";
                labcVWT.Text = "CBM";
                labcPallet.Text = "Container";
                labCWT.Text = "WM";
                labETDShow.Text = "Onboard";
                break;
            case "AT":
                Hawblab.Text = "HAWB";
                Mawblab.Text = "MAWB";
                labVorY.Text = "Flight No.";
                labcVWT.Text = "VWT";
                labcPallet.Text = "Pallet";
                labCWT.Text = "CWT";
                break;
            case "OT":
                Mawblab.Text = "MBL";
                Hawblab.Text = "HBL";
                labVorY.Text = "Vessel/ Voyage";
                labcVWT.Text = "CBM";
                labcPallet.Text = "Container";
                labCWT.Text = "WM";
                break;
            case "DM":
                Mawblab.Text = "Master";
                Hawblab.Text = "House";
                labVorY.Text = "Vessel/ Voyage";
                labcVWT.Text = "CBM";
                labcPallet.Text = "Container";
                labCWT.Text = "WM";
                break;
            case "TK":
                Mawblab.Text = "Master";
                Hawblab.Text = "House";
                labVorY.Text = "Vessel/ Voyage";
                labcVWT.Text = "CBM";
                labcPallet.Text = "Container";
                labCWT.Text = "WM";
                labBookShow.Text = "S/O";
                labShipperShow.Text = "Pick Up";
                labConsigneeShow.Text = "Delivery";
                labETAShow.Text = "";
                labETDShow.Text = "Pick Up";
                break;
            case "BK":
                Mawblab.Text = "Master";
                Hawblab.Text = "House";
                labVorY.Text = "Vessel/ Voyage";
                labcVWT.Text = "CBM";
                labcPallet.Text = "Container";
                labCWT.Text = "WM";
                break;

        }

        if (inv_Seed.Text != "0" || inv_CopySeed.Text != "0")
        {
            RefreshData();
        }
        else
        {
            hidChinaMode.Text = Request["chinaMode"];
            InitData();
        }


    }


    /// <summary>
    /// 控件绑定
    /// </summary>
    #region  ///控件数据绑定    Author：Micro     (2011-09-16)
    void CmbBinder()
    {

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "Item").
                Append("islocal", Request["FL"]).
                Append("inv_chinaMode",hidChinaMode.Text).
                Append("inv_SYS",string.IsNullOrEmpty(Request["sys"])?"":hidOtherSys.Text).
                Append("inv_Stat", FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        StoreItem.DataSource = ds;
        StoreItem.DataBind();

        ControlBinder.CmbBinder(StorecalcQty, "QtyKindBinding", hidOtherSys.Text);
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", hidOtherSys.Text);
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", hidOtherSys.Text);

    }


    #endregion


    void GridCoum(string sys)
    {
        ColumnModel cm = gridList.ColumnModel as ColumnModel;

        if (sys.ToUpper().Trim() == "AI")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[4].Hidden = true;
            cm.Columns[5].Hidden = true;
            cm.Columns[6].Hidden = true;
            cm.Columns[7].Hidden = true;
            cm.Columns[11].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divcalby.Style.Value = "display:none";
            divCurrency.Style.Value = "display:none";
            Tr1.Style.Value = "display:none";
            Tr2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";
        }
        else if (sys.ToUpper().Trim() == "OI")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[8].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divMin.Style.Value = "display:none";
            divMin1.Style.Value = "display:none";
            Td1.Style.Value = "display:none";
            Td2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";

        }
        else if (sys.ToUpper().Trim() == "AE")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[4].Hidden = true;
            cm.Columns[5].Hidden = true;
            cm.Columns[6].Hidden = true;
            cm.Columns[7].Hidden = true;
            cm.Columns[11].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divcalby.Style.Value = "display:none";
            divCurrency.Style.Value = "display:none";
            Tr1.Style.Value = "display:none";
            Tr2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";
        }
        else if (sys.ToUpper().Trim() == "OE")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[8].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divMin.Style.Value = "display:none";
            divMin1.Style.Value = "display:none";
            Td1.Style.Value = "display:none";
            Td2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";

        }
        else if (sys.ToUpper().Trim() == "AT")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[4].Hidden = true;
            cm.Columns[5].Hidden = true;
            cm.Columns[6].Hidden = true;
            cm.Columns[7].Hidden = true;
            cm.Columns[11].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divcalby.Style.Value = "display:none";
            divCurrency.Style.Value = "display:none";
            Tr1.Style.Value = "display:none";
            Tr2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";
        }
        else if (sys.ToUpper().Trim() == "OT")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[8].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divMin.Style.Value = "display:none";
            divMin1.Style.Value = "display:none";
            Td1.Style.Value = "display:none";
            Td2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";

        }
        else if (sys.ToUpper().Trim() == "DM")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[8].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divMin.Style.Value = "display:none";
            divMin1.Style.Value = "display:none";
            Td1.Style.Value = "display:none";
            Td2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";

        }
        else if (sys.ToUpper().Trim() == "TK")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[8].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divMin.Style.Value = "display:none";
            divMin1.Style.Value = "display:none";
            Td1.Style.Value = "display:none";
            Td2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";

        }
        else if (sys.ToUpper().Trim() == "BK")
        {
            cm.Columns[3].Hidden = true;
            cm.Columns[8].Hidden = true;
            cm.Columns[12].Hidden = true;
            cm.Columns[13].Hidden = true;
            cm.Columns[14].Hidden = true;
            divMin.Style.Value = "display:none";
            divMin1.Style.Value = "display:none";
            Td1.Style.Value = "display:none";
            Td2.Style.Value = "display:none";
            td_lsit.Style.Value = "display:none";

        }
        if (hidStat.Text == "USG/SIN")
        {
            cm.Columns[12].Hidden = false;
            cm.Columns[13].Hidden = false;
            cm.Columns[14].Hidden = false;
        }
    }


    void InvoiceData()
    {
        //storeInvoice.RemoveAll();
        //gridList.ColumnModel.Columns[2].Hidden = true; 

        if (inv_CopySeed.Text != "0")
        {
            DataTable dsgrid = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "copyinvoicedetail").Append("inv_Seed",inv_CopySeed.Text) }).GetTable();
            storeInvoice.DataSource = dsgrid;
            storeInvoice.DataBind();
            X.AddScript("make=1;");
            X.AddScript("var auto='Auto';");
        }
        else
        {
            DataTable dsgrid = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_InvoiceDetail_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "list").Append("id_Seed",Request["seed"]) }).GetTable();
            storeInvoice.DataSource = dsgrid;
            storeInvoice.DataBind();

            if (inv_Seed.Text.Length > 0 && inv_SYS.Text.ToUpper() == "AE")
            {
                DataSet dsInv = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AutoInvoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "GetDetail").Append("seed",Request["seed"]) }).GetList();
                if (dsInv.Tables[0].Rows[0][0].ToString() == "N")
                {
                    storeInvoice.DataSource = dsInv.Tables[1];
                    storeInvoice.DataBind();
                    X.AddScript("make=1;");
                    X.AddScript("var auto='Auto';");
                }
            }
        }

        //RowSelectionModel sm = gridList.GetSelectionModel() as RowSelectionModel;
        //sm.SelectRow(0);

    }


    #region /// 刷新Combobox绑定数据
    public void StoreItem_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "Item").
                Append("islocal", Request["FL"]).
                Append("inv_chinaMode",hidChinaMode.Text).
                Append("inv_SYS",string.IsNullOrEmpty(Request["sys"])?"":hidOtherSys.Text).
                Append("inv_Stat", FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        StoreItem.DataSource = ds;
        StoreItem.DataBind();
    }

    public void StoreUnit_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", hidOtherSys.Text);

    }

    public void StoreCurrInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", hidOtherSys.Text);
    }

    #endregion


    [DirectMethod]
    public void SetInfo(string typename, string code)
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "getInvoice").
                Append("Code", code).
                Append("inv_SYS","").
                Append("inv_chinaMode",hidChinaMode.Text).
                Append("inv_Seed",string.IsNullOrEmpty(Request["M"])?Request["H"]:Request["M"]).
                Append("inv_Stat", FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            labCpyRowID.Text = ds.Tables[0].Rows[0]["RowID"].ToString();
            txtAddress1.Text = ds.Tables[0].Rows[0]["Address1"].ToString();
            txtAddress2.Text = ds.Tables[0].Rows[0]["Address2"].ToString();
            txtAddress3.Text = ds.Tables[0].Rows[0]["Address3"].ToString();
            txtAddress4.Text = ds.Tables[0].Rows[0]["Address4"].ToString();
            txtContact.Text = ds.Tables[0].Rows[0]["Contact"].ToString();
            txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
            txtFax.Text = ds.Tables[0].Rows[0]["Fax"].ToString();
            txtCompany.Text = ds.Tables[0].Rows[0]["Company"].ToString();

        }

    }

    /// <summary>
    /// 刷新数据
    /// </summary>
    #region    ///刷新数据    Author：Micro
    void RefreshData()
    {
        DataSet ds = null;
        if (inv_CopySeed.Text != "0")
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "copyinvoiceheader").             
                Append("inv_Seed", inv_CopySeed.Text)}).GetList();
        }
        else
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_InvoiceDetail_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "Single").             
                Append("id_Seed", inv_Seed.Text)}).GetList();
        }
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            hidIsVoid.Text = ds.Tables[0].Rows[0]["IsVoid"].ToString().Trim();
            hidParentActive.Text = ds.Tables[0].Rows[0]["ParentActive"].ToString().Trim();

            //labCpyRowID.Text = ds.Tables[0].Rows[0]["RowID"].ToString();

            txtoffical.Value = ds.Tables[0].Rows[0]["offical"].ToString();
            txtAddress1.Text = ds.Tables[0].Rows[0]["Address1"].ToString();
            txtAddress2.Text = ds.Tables[0].Rows[0]["Address2"].ToString();
            txtAddress3.Text = ds.Tables[0].Rows[0]["Address3"].ToString();
            txtAddress4.Text = ds.Tables[0].Rows[0]["Address4"].ToString();
            txtContact.Text = ds.Tables[0].Rows[0]["Contact"].ToString();
            txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
            txtFax.Text = ds.Tables[0].Rows[0]["Fax"].ToString();
            txtCompany.Text = ds.Tables[0].Rows[0]["Company"].ToString();

            labCompany.Text = ds.Tables[0].Rows[0]["Code"].ToString();
            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Code"].ToString());

            labDNNO.Text = ds.Tables[0].Rows[0]["InvoiceNo"].ToString();
            labLotNo.Text = ds.Tables[0].Rows[0]["LotNo"].ToString();
            labHawb.Text = ds.Tables[0].Rows[0]["H"].ToString();
            labMawb.Text = ds.Tables[0].Rows[0]["M"].ToString();
            labBook.Text = ds.Tables[0].Rows[0]["Book"].ToString();
            labSales.Text = ds.Tables[0].Rows[0]["Sales"].ToString();

            labCurrency.Value = ds.Tables[0].Rows[0]["Currency"].ToString();
            labCurrency1.Text = ds.Tables[0].Rows[0]["Currency"].ToString();
            labEx.Text = ds.Tables[0].Rows[0]["Currency"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Ex"].ToString()))
                txtUSD.Text = ds.Tables[0].Rows[0]["Ex"].ToString();
            txtTax.Text = ds.Tables[0].Rows[0]["Tax"].ToString();
            //hhh
            inv_Tax.Text = ds.Tables[0].Rows[0]["Tax"].ToString();

            labLocal.Text = ds.Tables[0].Rows[0]["FL"].ToString();
            txtInvoiceDate.Text = ds.Tables[0].Rows[0]["InvoiceDate"].ToString();
            labCredit.Text = ds.Tables[0].Rows[0]["Factor"].ToString();
            labCredit1.Text = ds.Tables[0].Rows[0]["Factor"].ToString();
            X.AddScript("var auto='" + ds.Tables[0].Rows[0]["Factor"].ToString() + "';");
            hidChinaMode.Text = Convert.ToBoolean(ds.Tables[0].Rows[0]["chinaMode"]) ? "1" : "0";

            labShipperCode.Text = ds.Tables[0].Rows[0]["Shipper"].ToString();
            labShipperText.Text = ds.Tables[0].Rows[0]["ShipperName"].ToString();
            labConsigneeCode.Text = ds.Tables[0].Rows[0]["Consignee"].ToString();
            labConsigneeText.Text = ds.Tables[0].Rows[0]["ConsigneeName"].ToString();

            chkShipperShow.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["inv_ShowShipper"]);
            chkConsigneeShow.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["inv_ShowConsignee"]);
            txtCarrierCode.Text = ds.Tables[0].Rows[0]["Carrier"].ToString();
            txtCarrierText.Text = ds.Tables[0].Rows[0]["CarrierName"].ToString();
            if (Request["sys"] == "AT" || Request["sys"] == "OT" || Request["sys"] == "DM" || Request["sys"] == "BK" || Request["sys"] == "TK")
            {
                labDepart.Text = ds.Tables[0].Rows[0]["DepartL"].ToString();
                labDest.Text = ds.Tables[0].Rows[0]["DestL"].ToString();
            }
            else
            {
                labDepart.Text = ds.Tables[0].Rows[0]["Depart"].ToString();
                labDest.Text = ds.Tables[0].Rows[0]["Dest"].ToString();
            }

            if (Request["sys"] == "OI" || Request["sys"] == "OE" || Request["sys"] == "OT" || Request["sys"] == "DM" || Request["sys"] == "BK" || Request["sys"] == "TK")
            {
                labVessel.Text = ds.Tables[0].Rows[0]["Vessel"].ToString();
                labvoyage.Text = ds.Tables[0].Rows[0]["Voyage"].ToString();
            }
            if (Request["sys"] == "AI" || Request["sys"] == "AE" || Request["sys"] == "AT")
            {
                labvoyage.Text = ds.Tables[0].Rows[0]["FlightNo"].ToString();
            }
            // labDepart.Text = ds.Tables[0].Rows[0]["Depart"].ToString();
            // labDest.Text = ds.Tables[0].Rows[0]["Dest"].ToString();

            labETD.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["ETD"].ToString()) ? "" : ds.Tables[0].Rows[0]["ETD"].ToString();
            labETA.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["ETA"].ToString()) ? "" : ds.Tables[0].Rows[0]["ETA"].ToString();

            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["VWT"].ToString()))
                labVWT.Text = ds.Tables[0].Rows[0]["VWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["GWT"].ToString()))
                txtGWT.Text = ds.Tables[0].Rows[0]["GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["CWT"].ToString()))
                txtCWT.Text = ds.Tables[0].Rows[0]["CWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["pkgs"].ToString()))
                labPiece.Text = ds.Tables[0].Rows[0]["pkgs"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["pallets"].ToString()))
                labPallet.Text = ds.Tables[0].Rows[0]["pallets"].ToString();
            //labUnit.Text = ds.Tables[0].Rows[0]["Unit"].ToString();
            labUnit.setValue(ds.Tables[0].Rows[0]["Unit"].ToString());
            labelUnit.Text = ds.Tables[0].Rows[0]["Unit"].ToString();

            txtRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();

            if (inv_CopySeed.Text != "0")
            {
                hidtohouse.Text = ds.Tables[0].Rows[0]["inv_ToHouse"].ToString();
                hidtomaster.Text = ds.Tables[0].Rows[0]["inv_ToMaster"].ToString();
            }

            InvoiceData();

            if (inv_SYS.Text == "AE")
            {
                if (ds.Tables[0].Rows[0]["inv_Retrieve"].ToString() == "1" && inv_CopySeed.Text == "0")
                {
                    Invoicedetail.Visible = true;
                }
            }

            if (ds.Tables[0].Rows[0]["inv_print"].ToString() == "Y")
            {
                b = 1;
                PrintFlag(true);
                Invoicedetail.Visible = false;
            }
            if (ds.Tables[0].Rows[0]["inv_IsVoid"].ToString() == "Y") //当ISVOID=1 或者 PA= 0 的时候进入VOID状态
            {
                b = 1;
                VoidFlag(true);
                Invoicedetail.Visible = false;
                img_void.Style.Value = "display:inline";
            }

            hidIsAc.Text = ds.Tables[0].Rows[0]["inv_IsAc"].ToString();
            if (ds.Tables[0].Rows[0]["inv_IsAc"].ToString() == "Y")
            {
                b = 1;
                VoidFlag(true);
                Invoicedetail.Visible = false;
                btnPrint.Disabled = false;
                imgTransfer.Visible = true;
            }

            if (inv_CopySeed.Text != "0")
            {
                ControlBinder.pageTitleMsg(false, "INV  New ", "<p>Status : New Blank Invoice </p>", div_bottom);
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "INV:" + (string.IsNullOrEmpty(labDNNO.Text) ? labLotNo.Text : labDNNO.Text), "<p>Status :  Edit  Invoice .  </p>", div_bottom);
            }
        }


    }
    #endregion

    #region VoidFlag
    private void VoidFlag(bool flag)
    {

        //btn_offical.Disabled = flag;
        //txtoffical.Disabled = flag;

        X.AddScript("$('#labCurrency1_Container').next().hide();");// = "display:none";
        labCurrency1.Show();

        btnPrint.Disabled = flag;
        btnCancel.Disabled = flag;
        btnOk.Disabled = flag;
        btnVoid.Disabled = flag;

        txtAddress1.Disabled = flag;
        txtAddress2.Disabled = flag;
        txtAddress3.Disabled = flag;
        txtAddress4.Disabled = flag;
        if (flag)
        {
            td_lsit.Style.Value = "display:block";
            td_edit.Style.Value = "display:none";
            labCompany.Show();
            //showShipperCode
            X.AddScript("$('#showShipperCode').hide();");
            labelUnit.Show();
            X.AddScript("$('#showUnit').hide();");

        }

        //txtCompany.Disabled = flag;

        txtContact.Disabled = flag;
        txtPhone.Disabled = flag;
        txtFax.Disabled = flag;
        txtRemark.Disabled = flag;

        txtCWT.Disabled = flag;
        txtGWT.Disabled = flag;
        labVWT.Disabled = flag;
        labPiece.Disabled = flag;
        labPallet.Disabled = flag;




        txtInvoiceDate.Disabled = flag;
        txtUSD.Disabled = flag;
        txtTax.Disabled = flag;
        PrintFlag(flag);
        for (int i = 0; i < gridList.ColumnModel.Columns.Count; i++)
        {
            gridList.ColumnModel.SetEditable(i, flag == true ? false : true);
        }

        chkShipperShow.Disabled = flag;
        chkConsigneeShow.Disabled = flag;
    }

    #endregion

    void PrintFlag(bool flag)
    {

        X.AddScript("$('#labCurrency1_Container').next().hide();");// = "display:none";
        labCurrency1.Show();


        txtCWT.Disabled = flag;
        txtGWT.Disabled = flag;
        labVWT.Disabled = flag;
        labPiece.Disabled = flag;
        labPallet.Disabled = flag;


        txtInvoiceDate.Disabled = flag;
        txtUSD.Disabled = flag;
        txtTax.Disabled = flag;
        //inv_CmbItem.Disabled = flag;
        //inv_Cmbcalby.Disabled = flag;
        //inv_CmbUnit.Disabled = flag;
        //inv_txtQty.Disabled = flag;
        //inv_Currency.Disabled = flag;
        //inv_Ex.Disabled = flag;
        //inv_Min.Disabled = flag;
        //inv_Rate.Disabled = flag;
        //inv_Amount.Disabled = flag;
        btnAddInvoice.Disabled = flag;
        X.AddScript("$('#btnAddInvoice').attr('disabled','disabled');");
        Button2.Disabled = flag;
        Button3.Disabled = flag;
        if (flag)
        {
            td_lsit.Style.Value = "display:block";
            td_edit.Style.Value = "display:none";
            labCompany.Show();
            //showShipperCode
            X.AddScript("$('#showShipperCode').hide();");
            labelUnit.Show();
            X.AddScript("$('#showUnit').hide();");
        }

        //txtCompany.Disabled = flag;
        txtContact.Disabled = flag;
        txtPhone.Disabled = flag;
        txtFax.Disabled = flag;
        txtRemark.Disabled = flag;

        txtAddress1.Disabled = flag;
        txtAddress2.Disabled = flag;
        txtAddress3.Disabled = flag;
        txtAddress4.Disabled = flag;
    }

    /// <summary>
    /// InitData() 初始化数据
    /// </summary>
    #region   ///InitData()     Author：Micro  (2011-09-14)
    void InitData()
    {
        InvoiceData();

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "getInvoice").
                Append("Code", Request["Company"]).
                Append("inv_SYS",inv_SYS.Text).
                Append("inv_ChinaMode",hidChinaMode.Text).
                Append("inv_Seed",string.IsNullOrEmpty(Request["M"])?Request["H"]:Request["M"]).
                Append("inv_Stat", FSecurityHelper.CurrentUserDataGET()[12])}).GetList();

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            labCpyRowID.Text = ds.Tables[0].Rows[0]["RowID"].ToString();
            txtAddress1.Text = ds.Tables[0].Rows[0]["Address1"].ToString();
            txtAddress2.Text = ds.Tables[0].Rows[0]["Address2"].ToString();
            txtAddress3.Text = ds.Tables[0].Rows[0]["Address3"].ToString();
            txtAddress4.Text = ds.Tables[0].Rows[0]["Address4"].ToString();
            txtContact.Text = ds.Tables[0].Rows[0]["Contact"].ToString();
            txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
            txtFax.Text = ds.Tables[0].Rows[0]["Fax"].ToString();
            txtCompany.Text = ds.Tables[0].Rows[0]["Company"].ToString();
            labCompany.Text = ds.Tables[0].Rows[0]["Code"].ToString();
            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["Code"].ToString());

        }
        if (ds != null && ds.Tables[1].Rows.Count > 0)
        {
            // labDNNO.Text = ds.Tables[1].Rows[0]["inv_InvoiceNo"].ToString();
            labLotNo.Text = ds.Tables[1].Rows[0]["LotNo"].ToString();
            labHawb.Text = ds.Tables[1].Rows[0]["H"].ToString();
            labMawb.Text = ds.Tables[1].Rows[0]["M"].ToString();
            labBook.Text = ds.Tables[1].Rows[0]["Book"].ToString();
            labSales.Text = ds.Tables[1].Rows[0]["Sales"].ToString();

            labCurrency.setValue(Request["Currency"]);
            labCurrency1.Text = Request["Currency"];

            try
            {
                txtUSD.Text = Convert.ToDouble(Request["rate"]).ToString();
            }
            catch
            {
                txtUSD.Text = "1";
            }

            //hhh
            txtTax.Text = ds.Tables[1].Rows[0]["Tax"].ToString();
            inv_Tax.Text = ds.Tables[1].Rows[0]["Tax"].ToString();

            labLocal.Text = Request["FL"] == "F" ? "Foreign" : "Local";

            //txtInvoiceDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            if (Request["sys"].ToString() == "AI" || Request["sys"].ToString() == "OI")
            {
                if (!string.IsNullOrEmpty(ds.Tables[1].Rows[0]["ETA"].ToString()))
                {
                    //txtInvoiceDate.Text = Convert.ToDateTime(ds.Tables[1].Rows[0]["ETA"].ToString()).ToString("yyyy-MM-dd");
                    txtInvoiceDate.Text = DateTime.ParseExact(ds.Tables[1].Rows[0]["ETA"].ToString(), "dd/MM/yyyy", new System.Globalization.CultureInfo("zh-CN", true), System.Globalization.DateTimeStyles.AllowInnerWhite).ToString("yyyy-MM-dd");
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(ds.Tables[1].Rows[0]["ETD"].ToString()))
                {
                    //txtInvoiceDate.Text = Convert.ToDateTime(ds.Tables[1].Rows[0]["ETD"].ToString()).ToString("yyyy-MM-dd");
                    txtInvoiceDate.Text = DateTime.ParseExact(ds.Tables[1].Rows[0]["ETD"].ToString(), "dd/MM/yyyy", new System.Globalization.CultureInfo("zh-CN", true), System.Globalization.DateTimeStyles.AllowInnerWhite).ToString("yyyy-MM-dd");
                }
            }

            labEx.Text = Request["Currency"];

            labShipperCode.Text = ds.Tables[1].Rows[0]["Shipper"].ToString();
            labShipperText.Text = ds.Tables[1].Rows[0]["ShipperName"].ToString();
            labConsigneeCode.Text = ds.Tables[1].Rows[0]["Consignee"].ToString();
            labConsigneeText.Text = ds.Tables[1].Rows[0]["ConsigneeName"].ToString();
            txtCarrierCode.Text = ds.Tables[1].Rows[0]["Carrier"].ToString();
            txtCarrierText.Text = ds.Tables[1].Rows[0]["CarrierName"].ToString();

            txtoffical.Value = "";

            X.AddScript("var auto='Auto';");

            hidChinaMode.Text = Request["chinaMode"];

            labVessel.Text = ds.Tables[1].Rows[0]["Vessel"].ToString();
            labvoyage.Text = ds.Tables[1].Rows[0]["Voyage"].ToString();

            if (Request["sys"] == "AT" || Request["sys"] == "OT" || Request["sys"] == "DM" || Request["sys"] == "BK" || Request["sys"] == "TK")
            {
                labDepart.Text = ds.Tables[1].Rows[0]["DepartL"].ToString();
                labDest.Text = ds.Tables[1].Rows[0]["DestL"].ToString();
            }
            else
            {
                labDepart.Text = ds.Tables[1].Rows[0]["Depart"].ToString();
                labDest.Text = ds.Tables[1].Rows[0]["Dest"].ToString();
            }
            labETD.Text = string.IsNullOrEmpty(ds.Tables[1].Rows[0]["ETD"].ToString()) ? "" : ds.Tables[1].Rows[0]["ETD"].ToString();
            labETA.Text = string.IsNullOrEmpty(ds.Tables[1].Rows[0]["ETA"].ToString()) ? "" : ds.Tables[1].Rows[0]["ETA"].ToString();

            if (!string.IsNullOrEmpty(ds.Tables[1].Rows[0]["VWT"].ToString()))
                labVWT.Text = ds.Tables[1].Rows[0]["VWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[1].Rows[0]["GWT"].ToString()))
                txtGWT.Text = ds.Tables[1].Rows[0]["GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[1].Rows[0]["CWT"].ToString()))
                txtCWT.Text = ds.Tables[1].Rows[0]["CWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[1].Rows[0]["Piece"].ToString()))
                labPiece.Text = ds.Tables[1].Rows[0]["Piece"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[1].Rows[0]["Pallet"].ToString()))
                labPallet.Text = ds.Tables[1].Rows[0]["Pallet"].ToString();
            //labUnit.Text = ds.Tables[1].Rows[0]["Unit"].ToString();
            labUnit.setValue(ds.Tables[1].Rows[0]["Unit"].ToString());
            labelUnit.Text = ds.Tables[1].Rows[0]["Unit"].ToString();

            txtRemark.Text = ds.Tables[1].Rows[0]["Remark"].ToString();
        }
        ControlBinder.pageTitleMsg(false, "INV  New ", "<p>Status : New Blank Invoice </p>", div_bottom);
    }
    #endregion


    /// <summary>
    /// Grid 行选择事件，获取选择当前行号
    /// </summary>    
    #region   ///GridList_RowSelect(object,DirectEventArgs)   Grid 行选择事件，获取选择当前行号    Author：Micro    (2011-09-16)
    protected void GridList_RowSelect(object sender, DirectEventArgs e)
    {
        var list = JSON.Deserialize<List<InvoiceDetail>>(e.ExtraParams["gridData"]);

        RowSelectionModel sm = this.gridList.SelectionModel.Primary as RowSelectionModel;
        foreach (SelectedRow row in sm.SelectedRows)
        {
            labRowIndex.Text = row.RowIndex.ToString();
            //gridList.StartEditing(row.RowIndex, 0);
            inv_RowID.Text = list[row.RowIndex].RowID;
        }
        //var parm = JSON.Deserialize<InvoiceDetail>(e.ExtraParams["gridRowsData"]);
        double sumNetTotal = 0, sumTaxTotal = 0, sumTotal = 0;
        for (int i = 0; i < list.Count; ++i)
        {
            sumNetTotal += string.IsNullOrEmpty(list[i].NetTotal) ? 0 : Convert.ToDouble(list[i].NetTotal);
            sumTaxTotal += string.IsNullOrEmpty(list[i].TaxTotal) ? 0 : Convert.ToDouble(list[i].TaxTotal);
            sumTotal += string.IsNullOrEmpty(list[i].Total) ? 0 : Convert.ToDouble(list[i].Total);
        }
        labCredit.Text = "Invoice";
        labCredit1.Text = "Invoice";
        if (sumNetTotal < 0)
        {
            labCredit.Text = "Credit Note";
            labCredit1.Text = "Credit Note";
        }

        txtTotal1.Text = "Net Total：" + Math.Round(Math.Abs(sumNetTotal), 2);
        txtTotal2.Text = " Tax Total：" + Math.Round(Math.Abs(sumTaxTotal), 2);
        txtTotal3.Text = "Total：" + Math.Round(Math.Abs(sumTotal), 2);
        inv_Total.Text = sumTotal.ToString();

        // labgridCalBy.Text = string.IsNullOrEmpty(parm.CalBy) ? "CWT" : parm.CalBy;
    }
    #endregion


    /// <summary>
    /// ComboxBox Item  选择事件
    /// </summary>    
    #region    ///gridList_AfterEdi(object,DirectEventArgs)     ComboxBox Item  选择事件      Author：Micro   (2011-09-16)
    protected void gridList_AfterEdit(object sender, DirectEventArgs e)
    {
        int SelectRowIndex = Convert.ToInt32(labRowIndex.Text);
        var parm = JSON.Deserialize<Item>(e.ExtraParams["ItemList"]);

        int index = string.IsNullOrEmpty(labRowIndex.Text) ? 0 : Convert.ToInt32(labRowIndex.Text);
        this.storeInvoice.UpdateRecordField(index, "Description", parm.itm_Description);
        this.storeInvoice.UpdateRecordField(index, "Min", parm.Min);
        this.storeInvoice.UpdateRecordField(index, "CalBy", parm.CalcQty);
        this.storeInvoice.UpdateRecordField(index, "Rate", parm.Rate);
        this.storeInvoice.UpdateRecordField(index, "Amount", parm.Amount);
        labItemRound.Text = string.IsNullOrEmpty(parm.Round) ? "0" : parm.Round;
        labMarkDown.Text = string.IsNullOrEmpty(parm.MarkDown) ? "0" : parm.MarkDown;
        labMarkUp.Text = string.IsNullOrEmpty(parm.MarkUp) ? "0" : parm.MarkUp;
        labgridCalBy.Text = string.IsNullOrEmpty(parm.CalcQty) ? "0" : parm.CalcQty;

        double NetTotal = SumNetTotal(parm.CalcQty, Convert.ToDouble(string.IsNullOrEmpty(parm.Rate) ? "0" : parm.Rate), Convert.ToDouble(100), Convert.ToInt32(parm.Round), Convert.ToBoolean(labMarkUp.Text), Convert.ToBoolean(labMarkDown.Text), Convert.ToDouble(string.IsNullOrEmpty(parm.Min) ? "0" : parm.Min));
        if (!string.IsNullOrEmpty(parm.Amount) && parm.Amount != "0")
            NetTotal = Convert.ToDouble(parm.Amount);
        double TaxTotal = NetTotal * Convert.ToDouble(txtTax.Text) / 100;
        double Total = TaxTotal + NetTotal;
        this.storeInvoice.UpdateRecordField(SelectRowIndex, "NetTotal", NetTotal);
        this.storeInvoice.UpdateRecordField(SelectRowIndex, "TaxTotal", TaxTotal);
        this.storeInvoice.UpdateRecordField(SelectRowIndex, "Total", Total);

    }
    #endregion


    #region   ///Grid 数据计算处理     Author ：Micro   (2011-09-17)
    protected void Amount_Blur(object sender, DirectEventArgs e)
    {
        int SelectRowIndex = Convert.ToInt32(labRowIndex.Text);

        if (!string.IsNullOrEmpty(labgridAmout.Text.Trim()))
        {
            //this.storeInvoice.UpdateRecordField(SelectRowIndex, "Min", "");
            //this.storeInvoice.UpdateRecordField(SelectRowIndex, "Rate", "");
            //    labgridMin.Text = "0";
            //    labgridRate.Text = "0";
            //    //Percent_Blur(sender, e);
        }
        //else
        //    labgridAmout.Text = "0";
    }

    protected void Min_Blur(object sender, DirectEventArgs e)
    {
        int SelectRowIndex = Convert.ToInt32(labRowIndex.Text);

        if (!string.IsNullOrEmpty(labgridMin.Text.Trim()))
        {
            // this.storeInvoice.UpdateRecordField(SelectRowIndex, "Amount", "");
            labgridAmout.Text = "0";
            //Percent_Blur(sender, e);
        }
        else
            labgridMin.Text = "0";
    }

    protected void Rate_Blur(object sender, DirectEventArgs e)
    {
        int SelectRowIndex = Convert.ToInt32(labRowIndex.Text);

        if (!string.IsNullOrEmpty(labgridRate.Text.Trim()))
        {
            // this.storeInvoice.UpdateRecordField(SelectRowIndex, "Amount", "");
            labgridAmout.Text = "0";
            //Percent_Blur(sender, e);
        }
        else
        {
            labgridRate.Text = "0";
        }
    }

    protected void Percent_Blur(object sender, DirectEventArgs e)
    {
        int SelectRowIndex = Convert.ToInt32(labRowIndex.Text);
        //double NetTotal = SumNetTotal(labgridCalBy.Text, Convert.ToDouble(labgridRate.Text), Convert.ToDouble(labgridPercent.Text), Convert.ToInt32(labItemRound.Text), Convert.ToBoolean(labMarkUp.Text), Convert.ToBoolean(labMarkDown.Text),Convert.ToDouble(labgridMin.Text));
        //if (!string.IsNullOrEmpty(labgridAmout.Text)&&labgridAmout.Text!="0")
        //    NetTotal = Convert.ToDouble(labgridAmout.Text);
        //double TaxTotal = NetTotal * Convert.ToDouble(labgridTax.Text) / 100;
        //double Total = TaxTotal + NetTotal;
        //this.storeInvoice.UpdateRecordField(SelectRowIndex, "NetTotal", NetTotal);
        //this.storeInvoice.UpdateRecordField(SelectRowIndex, "TaxTotal", TaxTotal);
        //this.storeInvoice.UpdateRecordField(SelectRowIndex, "Total", Total);
        // GridList_RowSelect(sender, e);
    }

    protected void Tax_Blur(object sender, DirectEventArgs e)
    {
        int SelectRowIndex = Convert.ToInt32(labRowIndex.Text);
        //Percent_Blur(sender, e);
    }

    protected void calBy_select(object sender, DirectEventArgs e)
    {
        int SelectRowIndex = Convert.ToInt32(labRowIndex.Text);
        //Percent_Blur(sender, e);
    }
    #endregion

    /// <summary>
    /// Grid  编辑处理
    /// </summary>
    #region    ///Grid   编辑处理      Author ：Micro    （2011-09-16）
    protected void Grid_AfterEdit(object sender, DirectEventArgs e)
    {
        int SelectRowIndex = Convert.ToInt32(labRowIndex.Text);
        var parm = JSON.Deserialize<InvoiceDetail>(e.ExtraParams["rowdata"]);

        if ((!string.IsNullOrEmpty(parm.Min) || !string.IsNullOrEmpty(parm.Rate)) && inv_Show.Text == "0")
        {
            this.storeInvoice.UpdateRecordField(SelectRowIndex, "Amount", DBNull.Value);
            parm.Amount = "";
            inv_Show.Text = "1";
        }

        if (!string.IsNullOrEmpty(parm.Amount))
        {
            this.storeInvoice.UpdateRecordField(SelectRowIndex, "Min", DBNull.Value);
            this.storeInvoice.UpdateRecordField(SelectRowIndex, "Rate", DBNull.Value);
            parm.Min = "";
            parm.Rate = "";
            inv_Show.Text = "0";
        }


        double NetTotal = SumNetTotal(parm.CalBy, Convert.ToDouble(string.IsNullOrEmpty(parm.Rate) ? "0" : parm.Rate), Convert.ToDouble(parm.Percent), Convert.ToInt32(labItemRound.Text), Convert.ToBoolean(labMarkUp.Text), Convert.ToBoolean(labMarkDown.Text), Convert.ToDouble(string.IsNullOrEmpty(parm.Min) ? "0" : parm.Min));
        if (!string.IsNullOrEmpty(parm.Amount) && parm.Amount != "0")
            NetTotal = Convert.ToDouble(parm.Amount);
        double TaxTotal = NetTotal * Convert.ToDouble(parm.Tax) / 100;
        decimal Total = Convert.ToDecimal(TaxTotal + NetTotal);
        this.storeInvoice.UpdateRecordField(SelectRowIndex, "NetTotal", NetTotal);
        this.storeInvoice.UpdateRecordField(SelectRowIndex, "TaxTotal", TaxTotal);
        this.storeInvoice.UpdateRecordField(SelectRowIndex, "Total", Total);

        //storeInvoice.Update();

        var list = JSON.Deserialize<List<InvoiceDetail>>(e.ExtraParams["gridRowsData"]);
        double sumNetTotal = 0, sumTaxTotal = 0, sumTotal = 0;
        for (int i = 0; i < list.Count; ++i)
        {
            sumNetTotal += string.IsNullOrEmpty(list[i].NetTotal) ? 0 : Convert.ToDouble(list[i].NetTotal);
            sumTaxTotal += string.IsNullOrEmpty(list[i].TaxTotal) ? 0 : Convert.ToDouble(list[i].TaxTotal);
            sumTotal += string.IsNullOrEmpty(list[i].Total) ? 0 : Convert.ToDouble(list[i].Total);
        }
        labCredit.Text = "Invoice";
        labCredit1.Text = "Invoice";
        if (sumNetTotal < 0)
        {
            labCredit.Text = "Credit Note";
            labCredit1.Text = "Credit Note";
        }

        txtTotal1.Text = "Net Total：" + Math.Abs(sumNetTotal);
        txtTotal2.Text = " Tax Total：" + Math.Abs(sumTaxTotal);
        txtTotal3.Text = "Total：" + Math.Abs(sumTotal);
        inv_Total.Text = sumTotal.ToString();

        //RowSelectionModel sm = this.gridList.SelectionModel.Primary as RowSelectionModel;
        //sm.SelectRow(Convert.ToInt32(labRowIndex.Text));


    }
    #endregion


    #region    ///求和计算      Author ：Micro   （2011-09-17）
    /// <summary>
    /// 计算 NetTotal 
    /// </summary>
    /// <param name="calcQty">计量单位</param>
    /// <param name="Rate">价格</param>
    /// <param name="Percent">百分比</param>
    /// <param name="Round">保留小数位</param>
    ///<param name="isMarkup">四舍五入法  Up 入  Down  舍  否则 四舍五入</param>
    /// <param name="isMarkDown">四舍五入法  Up 入  Down  舍  否则 四舍五入</param>
    /// <returns></returns>
    double SumNetTotal(object calcQty, object rate, object percent, int Round, bool isMarkup, bool isMarkDown, object min)
    {
        int qty = 0;
        double Rate = string.IsNullOrEmpty(Convert.ToString(rate)) ? 0 : Convert.ToDouble(rate);
        double Percent = string.IsNullOrEmpty(Convert.ToString(percent)) ? 0 : Convert.ToDouble(percent);
        double Min = string.IsNullOrEmpty(Convert.ToString(min)) ? 0 : Convert.ToDouble(min);

        switch (calcQty.ToString().ToUpper().Trim())
        {
            case "CWT":
                qty = 30;
                break;
            case "GWT":
                qty = 10;
                break;
            case "VWT":
                qty = 20;
                break;
            case "Piece":
                qty = 40;
                break;
        }
        bool b = true;
        double NetTotal = qty * (Rate) * Percent / 100;
        if (NetTotal < 0)
            b = false;
        double Num = Math.Pow(0.1, Round);
        double SumNetTotal = (double)Math.Round(new decimal(Math.Abs(NetTotal)), Round);

        if (isMarkup)
        {
            if (SumNetTotal < NetTotal)
                SumNetTotal = SumNetTotal + Num;
        }
        if (isMarkDown)
        {
            if (SumNetTotal > NetTotal)
                SumNetTotal = SumNetTotal - Num;
        }
        if (SumNetTotal < Math.Abs(Min))
            SumNetTotal = Min;
        if (!b)
            SumNetTotal = SumNetTotal * (-1);
        return SumNetTotal;

    }

    /// <summary>
    /// 计算 TaxTotal
    /// </summary>
    /// <param name="NetTotal"></param>
    /// <param name="tax"></param>
    /// <returns></returns>
    double SumTaxTotal(double NetTotal, float tax)
    {
        return NetTotal * tax;
    }

    /// <summary>
    /// 计算 Total
    /// </summary>
    /// <param name="NetTotal"></param>
    /// <param name="TaxTotal"></param>
    /// <returns></returns>
    double SumTotal(double NetTotal, double TaxTotal)
    {
        return NetTotal + TaxTotal;
    }
    #endregion


    #region   ///Button 点击事件  Author：Micro  (2011-09-14)

    /// <summary>
    /// 保存
    /// </summary>    
    #region btnOk_Click   Author ：Micro   (2011-09-04)
    protected void btnOk_Click(object sender, DirectEventArgs e)
    {
        //
        //RowSelectionModel sm = this.gridList.SelectionModel.Primary as RowSelectionModel;
        //sm.SelectPrevious(true);

        
        ControlBinder cbe = new ControlBinder();
        cbe.Log("2:    lot: " + labLotNo.Text + "  SYS: " + inv_SYS.Text + " | " + DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + "\r\n-----------------------");
        #region    //更新Invoice
        DataTable tb = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                 Append("Option", "UpdateInvoice")
                 .Append("offical",string.IsNullOrEmpty(txtoffical.Text)?"":txtoffical.Text.ToUpper())
                 .Append("inv_chinaMode",hidChinaMode.Text)
                 .Append("inv_ToMaster", string.IsNullOrEmpty(Request["M"])?(inv_CopySeed.Text != "0"?(object)hidtomaster.Text:DBNull.Value):(object)Request["M"])                 
                 .Append("inv_Seed", string.IsNullOrEmpty(Request["seed"])?"0":Request["seed"])
                 //.Append("inv_CompanyCode",inv_CopySeed.Text != "0"?CmbShipperCode.Value.Trim().ToUpper():labCompany.Text.Trim().ToUpper())
                 .Append("inv_CompanyCode",CmbShipperCode.Value.Trim().ToUpper())
                 .Append("inv_CompanyName",txtCompany.Text.Trim().ToUpper())
                 .Append("inv_Address1",txtAddress1.Text.Trim().ToUpper())
                 .Append("inv_Address2",txtAddress2.Text.Trim().ToUpper())
                 .Append("inv_Address3",txtAddress3.Text.Trim().ToUpper())
                 .Append("inv_Address4",txtAddress4.Text.Trim().ToUpper())          
                 .Append("inv_Contact",txtContact.Text.Trim().ToUpper())
                 .Append("inv_Phone", txtPhone.Text.Trim().ToUpper())
                 .Append("inv_Fax",txtFax.Text.Trim().ToUpper())
                 .Append("inv_Ex",string.IsNullOrEmpty(txtUSD.Text)?DBNull.Value:(object)txtUSD.Text)
                 .Append("inv_LotNo",labLotNo.Text.Trim().ToUpper())
                 .Append("inv_ShpNo",labBook.Text.Trim().ToUpper())
                 .Append("inv_MasterNo",labMawb.Text.Trim().ToUpper())            
                 .Append("inv_HouseNo",labHawb.Text.Trim().ToUpper())            
                 .Append("inv_Sales",labSales.Text.Trim().ToUpper())            
                 .Append("inv_InvoiceDate",ControlBinder.getDate(string.IsNullOrEmpty(txtInvoiceDate.RawText)?DBNull.Value:(object)txtInvoiceDate.RawText))            
                 .Append("inv_Currency",labCurrency.Value.Trim().ToUpper())            
                 .Append("inv_ForeignLocal",labLocal.Text[0])
                 .Append("inv_Tax",txtTax.Text.Trim())            
                 .Append("inv_Shipper",labShipperCode.Text.Trim().ToUpper())            
                 .Append("inv_ShipperLine",labShipperText.Text.Trim().ToUpper())            
                 .Append("inv_Consignee",labConsigneeCode.Text.Trim().ToUpper())            
                 .Append("inv_ConsigneeLine",labConsigneeText.Text.Trim().ToUpper())            
                 .Append("inv_Carrier",txtCarrierCode.Text.Trim().ToUpper())            
                 //.Append("inv_Vessel",inv_SYS.Text=="OI" ? labVessel.Text.Trim().ToUpper():null)            
                 //.Append("inv_Voyage",inv_SYS.Text=="OI" ? labvoyage.Text.Trim().ToUpper():null)
                 //.Append("inv_FlightNo",inv_SYS.Text=="AI" ? labvoyage.Text.Trim().ToUpper():null)
                 .Append("inv_Vessel",hidOtherSys.Text.StartsWith("O") ? labVessel.Text.Trim().ToUpper():null)            
                 .Append("inv_Voyage",hidOtherSys.Text.StartsWith("O")  ? labvoyage.Text.Trim().ToUpper():null)
                 .Append("inv_FlightNo",hidOtherSys.Text.StartsWith("A")  ? labvoyage.Text.Trim().ToUpper():null)
                 .Append("inv_ETD",ControlBinder.getDate(labETD.Text.Trim()))            
                 .Append("inv_ETA",ControlBinder.getDate(labETA.Text.Trim()))            
                 .Append("inv_GWT", string.IsNullOrEmpty(txtGWT.Text.Trim())?DBNull.Value:(object)txtGWT.Text)        
                 .Append("inv_VWT",string.IsNullOrEmpty(labVWT.Text.Trim())?DBNull.Value:(object)labVWT.Text)           
                 .Append("inv_CWT",string.IsNullOrEmpty(txtCWT.Text.Trim())?DBNull.Value:(object)txtCWT.Text)               
                 .Append("inv_Pkgs",string.IsNullOrEmpty(labPiece.Text.Trim())?DBNull.Value:(object)labPiece.Text)      
                 .Append("inv_Pallets",string.IsNullOrEmpty(labPallet.Text.Trim())?DBNull.Value:(object)labPallet.Text)      
                 //.Append("inv_UnitDesc",labUnit.Text.Trim())     
                 .Append("inv_UnitDesc",labUnit.Value)
                 .Append("inv_Remark",txtRemark.Text.Trim().ToUpper())   
                 .Append("inv_ToHouse", string.IsNullOrEmpty(Request["H"])?(inv_CopySeed.Text != "0"?(object)hidtohouse.Text:DBNull.Value):(object)Request["H"])
                 .Append("inv_IsCost",0)
                 .Append("load",(Request["sys"]=="AT"||Request["sys"]=="OT"|| Request["sys"] == "DM" || Request["sys"] == "BK" || Request["sys"] == "TK")?"":labDepart.Text.ToUpper())
                 .Append("final",(Request["sys"]=="AT"||Request["sys"]=="OT"|| Request["sys"] == "DM" || Request["sys"] == "BK" || Request["sys"] == "TK")?"":labDest.Text.ToUpper())
                 .Append("inv_ReceivedL",(Request["sys"]=="AT"||Request["sys"]=="OT"|| Request["sys"] == "DM" || Request["sys"] == "BK" || Request["sys"] == "TK")?labDepart.Text.ToUpper():null)
                 .Append("inv_FinalL",(Request["sys"]=="AT"||Request["sys"]=="OT"|| Request["sys"] == "DM" || Request["sys"] == "BK" || Request["sys"] == "TK")?labDest.Text.ToUpper():null)
                 .Append("inv_Stat",FSecurityHelper.CurrentUserDataGET()[12])              
                 .Append("inv_SYS",inv_SYS.Text)
                 .Append("inv_User",FSecurityHelper.CurrentUserDataGET()[0].ToString())  
                 .Append("inv_ShowShipper",chkShipperShow.Checked?"1":"0")
                 .Append("inv_ShowConsignee",chkConsigneeShow.Checked?"1":"0")
        }).GetTable();
        #endregion

        if (tb != null)
            inv_Seed.Text = tb.Rows[0][0].ToString();   // 获取 SeedID
        else
        {
            //X.Msg.Alert("Tip", " Saved failed ! ! ! " + inv_Seed.Text).Show();
            ControlBinder.pageTitleMsg(false, "INV:" + (string.IsNullOrEmpty(labDNNO.Text) ? labLotNo.Text : labDNNO.Text), "<p class=\"error\">Status : Saved failed ! ! !  </p>", div_bottom);
            return;
        }

        #region   //更新InvoiceDetails
        List<IFields> fields = new List<IFields>();
        var list = JSON.Deserialize<List<InvoiceDetail>>(e.ExtraParams["gridList"]);

        #region  /// 先Delete 在Update
        string ROWID = "0,";
        for (int i = 0; i < list.Count; ++i)
        {
            ROWID += list[i].RowID + ",";
        }

        ROWID = ROWID.Substring(0, ROWID.Length - 1);
        //hhh
        string taxTotal = "0";
        string netTotal = "0";
        string actTotal = "0";
        string total = "0";
        netTotal = hidNetTotal.Text;
        taxTotal = hidTaxTotal.Text;
        actTotal = inv_Total.Text;
        total = hidNetTotal.Text;


        bool d = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_InvoiceDetail_SP", new List<IFields>() { dal.CreateIFields().
                   Append("Option", "Delete")
                   .Append("ROWID",ROWID)
                   .Append("inv_ActTotal", labCredit1.Text.Trim() == "Invoice" ? Convert.ToDouble(actTotal) : Convert.ToDouble(actTotal))
                   .Append("inv_Total ", Math.Abs(Convert.ToDouble(actTotal)))
                   .Append("inv_TaxTotal ", Math.Abs(Convert.ToDouble(taxTotal)))
                   .Append("inv_NetTotal ", Math.Abs(Convert.ToDouble(netTotal)))
                   .Append("inv_Factor ", labCredit1.Text.Trim() == "Invoice" ? "1" : "-1")
                   .Append("inv_Payment", labCredit1.Text.Trim() == "Invoice" ? "1" : "2")
                   .Append("inv_IsDN", labCredit1.Text.Trim() == "Invoice" ? "1" : "0")
                   .Append("inv_IsCN", labCredit1.Text.Trim() == "Invoice" ? "0" : "1")
                   .Append("id_Seed",inv_Seed.Text) }).Update();
        #endregion

        for (int i = 0; i < list.Count; ++i)
        {
            //list[i].NetTotal = SumNetTotal(list[i].CalBy, list[i].Rate, list[i].Percent, Convert.ToInt32(labItemRound.Text), Convert.ToBoolean(labMarkUp.Text), Convert.ToBoolean(labMarkDown.Text), list[i].Min).ToString();
            //if (!string.IsNullOrEmpty(list[i].Amount) && list[i].Amount != "0")
            //    list[i].NetTotal = list[i].Amount;
            //list[i].TaxTotal = (Convert.ToDouble(list[i].NetTotal) * Convert.ToDouble(list[i].Tax) / 100).ToString();
            //list[i].Total = (Convert.ToDouble(list[i].NetTotal) + Convert.ToDouble(list[i].TaxTotal)).ToString();

            fields.Add(dal.CreateIFields().
                       Append("Option", "Update")
                      .Append("id_Seed", inv_Seed.Text.Trim())
                      .Append("id_Parent", "0")
                      .Append("id_ROWID", string.IsNullOrEmpty(list[i].RowID) ? "0" : list[i].RowID)
                      .Append("id_Item", list[i].ItemCode)
                      .Append("id_Description", list[i].Description.ToUpper())
                      .Append("id_QtyKind", list[i].CalBy)
                      .Append("id_Unit", list[i].Unit)
                      .Append("id_Qty", list[i].Qty)
                      .Append("id_Currency", list[i].Currency)
                      .Append("id_ExRate", list[i].Ex)
                      .Append("id_Min", string.IsNullOrEmpty(list[i].Min) ? DBNull.Value : (object)list[i].Min)
                      .Append("id_Rate", string.IsNullOrEmpty(list[i].Rate) ? DBNull.Value : (object)list[i].Rate)
                      .Append("id_Amount", string.IsNullOrEmpty(list[i].Amount) ? DBNull.Value : (object)list[i].Amount)
                      .Append("id_Percent", list[i].Percent)
                      .Append("id_NetTotal", list[i].NetTotal)
                      .Append("id_TaxQty", list[i].Tax)
                      .Append("id_TaxTotal", list[i].TaxTotal)
                      .Append("id_ActTotal", list[i].Total)
                      .Append("id_Stat", FSecurityHelper.CurrentUserDataGET()[12])
                      .Append("id_SYS", inv_SYS.Text)
                      .Append("id_ShipmentID", list[i].ShipmentID)
                      //更新Invoice  
                      .Append("inv_ActTotal", labCredit1.Text.Trim() == "Invoice" ? Convert.ToDouble(actTotal) : Convert.ToDouble(actTotal))
                      .Append("inv_Total ", Math.Abs(Convert.ToDouble(actTotal)))
                      .Append("inv_TaxTotal ", Math.Abs(Convert.ToDouble(taxTotal)))
                      .Append("inv_NetTotal ", Math.Abs(Convert.ToDouble(netTotal)))
                      .Append("inv_Factor ", labCredit1.Text.Trim() == "Invoice" ? "1" : "-1")
                      .Append("inv_Payment", labCredit1.Text.Trim() == "Invoice" ? "1" : "2")
                      .Append("inv_IsDN", labCredit1.Text.Trim() == "Invoice" ? "1" : "0")
                      .Append("inv_IsCN", labCredit1.Text.Trim() == "Invoice" ? "0" : "1")
                      .Append("id_User", FSecurityHelper.CurrentUserDataGET()[0].ToString()));
        }
        bool c = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_InvoiceDetail_SP", fields).Update();

        if ((tb != null))
        {
            //X.Msg.Alert("Tip", " Saved successfully ! ! ! " + inv_Seed.Text).Show();
            ControlBinder.pageTitleMsg(true, "INV:" + (string.IsNullOrEmpty(labDNNO.Text) ? labLotNo.Text : labDNNO.Text), "<p class=\"success\">Status :  Saved successfully ! ! !  </p>", div_bottom);
            if (Request["seed"] != inv_Seed.Text)
                X.Redirect("Invoice.aspx?sys=" + inv_SYS.Text + "&FL=" + labLocal.Text[0] + "&seed=" + inv_Seed.Text);

        }
        else
            ControlBinder.pageTitleMsg(false, "INV:" + (string.IsNullOrEmpty(labDNNO.Text) ? labLotNo.Text : labDNNO.Text), "<p class=\"error\">Status :  Save failed, please check the data .  </p>", div_bottom);

        //X.Msg.Alert("Tip", " Saved failed ! ! ! " + inv_Seed.Text).Show();
        #endregion
    }
    #endregion


    #region  ///删除 Details      Author：Micro   （2011-09-19）
    //删除
    [DirectMethod(Namespace = "CompanyX")]
    public void Delete(string id)
    {
        //dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_InvoiceDetail_SP", new List<IFields>() { dal.CreateIFields().
        //      Append("Option", "Delete").Append("id_ROWID",id) }).Update();

        //txtTotal1.Text = "NetTotal：0";
        // txtTotal2.Text = " TaxTotal：0";
        txtTotal3.Text = "Total：0";
        inv_Total.Text = "0";

        RowSelectionModel sm = this.gridList.SelectionModel.Primary as RowSelectionModel;
        sm.SelectRow(0);
    }

    [DirectMethod(Namespace = "CompanyX")]
    public void DeleteAll(string id)
    {
        //if (dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_InvoiceDetail_SP", new List<IFields>() { dal.CreateIFields().
        //                Append("Option", "DeleteAll").Append("id_Seed",id) }).Update())
        //    storeInvoice.RemoveAll();                
        //X.Msg.Alert("TITLE", id).Show();
        //txtTotal1.Text = "NetTotal：0" ;
        //txtTotal2.Text = " TaxTotal：0";
        txtTotal3.Text = "Total：0";
        inv_Total.Text = "0";

    }
    #endregion


    /// <summary>
    /// 还原
    /// </summary>    
    #region btnCancel_Click    Author： Micro  (2011-09-14)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        if (inv_Seed.Text != "0" || inv_CopySeed.Text != "0")
        {
            RefreshData();
        }
        else
        {
            InitData();
        }
    }
    #endregion


    /// <summary>
    /// 删除
    /// </summary>    
    #region btnVoid_Click   Author： Micro  (2011-09-14)
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
        string voidflag = hidVoid.Text == "0" ? "Y1" : "N1";

        DataTable table = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                            Append("Option", "Delete").Append("inv_seed",inv_Seed.Text).Append("inv_User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).
                            Append("VoidFlag",voidflag)
        }).GetTable();
        if (table != null && table.Rows.Count > 0 && table.Rows[0][0].ToString() == "Y")
        {
            ControlBinder.pageTitleMsg(true, "INV:" + (string.IsNullOrEmpty(labDNNO.Text) ? labLotNo.Text : labDNNO.Text), "<p class=\"success\">Status :  Saved successfully ! ! !  </p>", div_bottom);
            VoidFlag(true);

            //判断是否是财务,以及invoce为VOID,parentAcive 没VOID的时候才显示ACTIVE按钮
            if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT" && table.Rows[0]["ParentActive"].ToString() == "N")
            {
                btnVoid.Text = "Active";
                hidVoid.Text = "1";
                btnVoid.Disabled = false;
            }

            X.AddScript("$('#Invoicedetail').css('display','none');$('#img_void').css('display','inline'); $('#td_edit').hide();$('#td_lsit').show();");

        }
        else if (table != null && table.Rows.Count > 0 && table.Rows[0][0].ToString() == "A")
        {
            X.Redirect("Invoice.aspx?sys=" + inv_SYS.Text + "&FL=" + labLocal.Text[0] + "&seed=" + inv_Seed.Text);
        }
        else if (table != null && table.Rows.Count > 0 && table.Rows[0][0].ToString() == "T")
        {
            X.Msg.Alert("Status", "Error，The information has been transmitted .", "location.reload();").Show();
        }
        else
        {
            ControlBinder.pageTitleMsg(true, "INV:" + (string.IsNullOrEmpty(labDNNO.Text) ? labLotNo.Text : labDNNO.Text), "<p class=\"error\">Status :  Saved failed ! ! ! </p>", div_bottom);
            //X.Msg.Alert("Tip", " Saved failed ! ! ! ").Show();  
        }
    }

    /// <summary>
    /// 打印
    /// </summary>    
    #region btnPrint_Click   Author：Micro  (2011-09-14)
    protected void btnPrint_Click(object sender, DirectEventArgs e)
    {
        if (hidIsAc.Text != "Y" && hidAccount.Text != "ACCOUNT" && !LockDate.IsLock(inv_Seed.Text, ""))
        {
            btnOk_Click(sender, e);
        }
        try
        {
            if (Request["sys"] == "AI")
            {
                X.AddScript("window.open('ReportFile.aspx?type=Invoice&ID=" + inv_Seed.Text + "','_blank');");
            }
            else if (Request["sys"] == "OI")
            {
                X.AddScript("window.open('../../OceanImport/OceanShipmentJobList/ReportFile.aspx?type=Invoice&ID=" + inv_Seed.Text + "','_blank');");
            }
            else if (Request["sys"] == "AE")
            {
                X.AddScript("window.open('../../AirExport/AEReportFile/ReportFile.aspx?type=Invoice&ID=" + inv_Seed.Text + "','_blank');");
            }
            else if (Request["sys"] == "OE")
            {
                X.AddScript("window.open('../../OceanExport/OEReportFile/ReportFile.aspx?type=Invoice&ID=" + inv_Seed.Text + "','_blank');");
            }
            else if (Request["sys"] == "AT")
            {
                X.AddScript("window.open('../../Triangle/Report/ReportFile.aspx?type=Invoice&sys=" + Request["sys"] + "&ID=" + inv_Seed.Text + "','_blank');");
            }
            else if (Request["sys"] == "OT")
            {
                X.AddScript("window.open('../../Triangle/Report/ReportFile.aspx?type=Invoice&sys=" + Request["sys"] + "&ID=" + inv_Seed.Text + "','_blank');");
            }
            else if (Request["sys"] == "DM")
            {
                X.AddScript("window.open('../../OtherBusiness/Report/ReportFile.aspx?type=Invoice&sys=" + Request["sys"] + "&ID=" + inv_Seed.Text + "','_blank');");
            }
            else if (Request["sys"] == "BK")
            {
                X.AddScript("window.open('../../OtherBusiness/Report/ReportFile.aspx?type=Invoice&sys=" + Request["sys"] + "&ID=" + inv_Seed.Text + "','_blank');");
            }
            else if (Request["sys"] == "TK")
            {
                X.AddScript("window.open('../../OtherBusiness/Report/ReportFile.aspx?type=Invoice&sys=" + Request["sys"] + "&ID=" + inv_Seed.Text + "','_blank');");
            }
        }
        catch
        {

        }
    }
    #endregion

    [DirectMethod]
    public void MakeInvoiceDetail()
    {
        if (inv_Seed.Text.Length > 0)
        {
            bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AutoInvoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "MakeDetail"). 
                Append("seed", inv_Seed.Text).
                Append("CWT", string.IsNullOrEmpty(txtCWT.Text)?DBNull.Value:(object)txtCWT.Text).
                Append("user",FSecurityHelper.CurrentUserDataGET()[0])}).Update();

            RefreshData();
        }
    }

    #endregion

    [DirectMethod]
    public void UpdateStatus()
    {
        bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Invoice_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "UpdateStatus").
                Append("inv_Seed",inv_Seed.Text).
                Append("inv_ShowShipper",chkShipperShow.Checked?1:0).
                Append("inv_ShowConsignee",chkConsigneeShow.Checked?1:0)
        }).Update();
    }

    protected void btnVoid_DirectClick(object sender, DirectEventArgs e)
    {

    }


}


#region    ///实体类    Author ：Micro   （2011-09-14）
public class Item
{
    public string itm_ROWID
    { get; set; }
    public string itm_Code
    { get; set; }
    public string itm_Description
    { get; set; }
    public string CalcQty
    { get; set; }
    public string Min
    { get; set; }
    public string Rate
    { get; set; }
    public string Amount
    { get; set; }
    public string Round
    { get; set; }
    public string MarkUp
    { get; set; }
    public string MarkDown
    { get; set; }
}

public class InvoiceDetail
{
    //{"RowID":"","ItemCode":"AMD","Description":"AMENDMENT FEE (AMS)","CalBy":"CWT","Min":10,"Rate":"","Amount":null,"Percent":"100","NetTotal":"","Tax":"10%","TaxTotal":"","Total":"","id":-1}
    public string RowID
    { get; set; }
    public string ItemCode
    { get; set; }
    public string Description
    { get; set; }
    public string CalBy
    { get; set; }
    public string Min
    { get; set; }
    public string Rate
    { get; set; }
    public string Amount
    { get; set; }
    public string Percent
    { get; set; }
    public string NetTotal
    { get; set; }
    public string Tax
    { get; set; }
    public string TaxTotal
    { get; set; }
    public string Total
    { get; set; }
    public string Unit
    { get; set; }
    public string Qty
    { get; set; }
    public string Currency
    { get; set; }
    public string Ex
    { get; set; }
    public int ShipmentID
    { get; set; }

}
#endregion