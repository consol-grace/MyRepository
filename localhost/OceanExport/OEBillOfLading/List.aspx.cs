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
using System.Collections;

public partial class OceanExport_OEBillOfLading_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    public static string sys = "OE";

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {

                DataSet dsLocation = GetList("LocationList");
                StoreLocation.DataSource = dsLocation;
                StoreLocation.DataBind();
                ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice","O");
                DataBindList();
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            ControlBinder.DateFormat(txtDate);
            
        }
    }

    public void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataSet dsLocation = GetList("LocationList");
        StoreLocation.DataSource = dsLocation;
        StoreLocation.DataBind();
    }
    public void StoreCurrInvoice_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice","O");
    }


    [DirectMethod]
    public void SetLocationItem(string code,string type)
    {
        if (code.TrimEnd() != "")
        {
           DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
              Append("Option", "LocationByCode").
              Append("STAT",code).
              Append("SYS","O")}).GetList();
           if (ds != null && ds.Tables[0].Rows.Count > 0)
           {
               if (type == "CmbReceipt")
               {
                   txtReceipt.Text = ds.Tables[0].Rows[0][0].ToString();
                   CmbLoading.Focus();
               }
               else if (type == "CmbLoading")
               {
                   txtLoading.Text = ds.Tables[0].Rows[0][0].ToString();
                   CmbDischarge.Focus();
               }
               else if (type == "CmbDischarge")
               {
                   txtDischarge.Text = ds.Tables[0].Rows[0][0].ToString();
                   CmbDelivery.Focus();
               }
               else if (type == "CmbDelivery")
               {
                   txtDelivery.Text = ds.Tables[0].Rows[0][0].ToString();
               }
           }
        }
    }

    DataSet GetList(string Type)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", Type).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS","O")}).GetList();
        }
        catch
        {
            ds = null;
        }
        return ds;
    }

    #region   DataBindList()    Author ：Hcy   (2012-04-03)
    private void DataBindList()
    {
        string flagAtt="0";
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetBill")
            .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("bld_OldMakeMLine", hidMakeOldMLine.Text)
            .Append("bld_OldMakePLine", hidMakeOldPLine.Text)
            .Append("bld_OldMakeDLine", hidMakeOldDLine.Text)
            );
        DataSet ds = GetDs("FW_OceanExport_BillOfLading_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            lablotno.Text = ds.Tables[0].Rows[0]["o_LotNo"].ToString();
            labBLNO.Text = ds.Tables[0].Rows[0]["o_HBL"].ToString();
            labBLNO1.Text = ds.Tables[0].Rows[0]["o_HBL"].ToString();
            chkDigits.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["o_Show3Digit"]);
            chkShowAll.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["o_ShowAllDetail"]);
            chkDigits1.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["o_Show3Digit"]);
            chkShowAll1.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["o_ShowAllDetail"]);
            if (chkDigits.Checked) { hidDigits.Text = "1"; } else { hidDigits.Text = "0"; }
            if (chkShowAll.Checked) { hidShowDetail.Text = "1"; } else { hidShowDetail.Text = "0"; }

            chkAutorefresh.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["o_AutoRefresh"]);
            if (chkAutorefresh.Checked) { hidRefresh.Text = "1"; } else { hidRefresh.Text = "0"; }
            chkRefreshHeader.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["o_InfoRefresh"]);
            if (chkRefreshHeader.Checked) { hidRefresh1.Text = "1"; } else { hidRefresh1.Text = "0"; }

            CmbShipperCode.setValue(ds.Tables[0].Rows[0]["bli_ShipperCode"].ToString());
            txtShipper1.Text = ds.Tables[0].Rows[0]["bli_Shipper1"].ToString();
            txtShipper2.Text = ds.Tables[0].Rows[0]["bli_Shipper2"].ToString();
            txtShipper3.Text = ds.Tables[0].Rows[0]["bli_Shipper3"].ToString();
            txtShipper4.Text = ds.Tables[0].Rows[0]["bli_Shipper4"].ToString();
            CmbShipperCode1.Text = ds.Tables[0].Rows[0]["bli_ShipperCode"].ToString();

            CmbConsigneeCode.setValue(ds.Tables[0].Rows[0]["bli_ConsigneeCode"].ToString());
            txtConsignee1.Text = ds.Tables[0].Rows[0]["bli_Consignee1"].ToString();
            txtConsignee2.Text = ds.Tables[0].Rows[0]["bli_Consignee2"].ToString();
            txtConsignee3.Text = ds.Tables[0].Rows[0]["bli_Consignee3"].ToString();
            txtConsignee4.Text = ds.Tables[0].Rows[0]["bli_Consignee4"].ToString();
            txtConsignee5.Text = ds.Tables[0].Rows[0]["bli_Consignee5"].ToString();
            CmbConsigneeCode1.Text = ds.Tables[0].Rows[0]["bli_ConsigneeCode"].ToString();

            CmbParty1.setValue(ds.Tables[0].Rows[0]["bli_PartyACode"].ToString());
            txtPartyA1.Text = ds.Tables[0].Rows[0]["bli_PartyA1"].ToString();
            txtPartyA2.Text = ds.Tables[0].Rows[0]["bli_PartyA2"].ToString();
            txtPartyA3.Text = ds.Tables[0].Rows[0]["bli_PartyA3"].ToString();
            txtPartyA4.Text = ds.Tables[0].Rows[0]["bli_PartyA4"].ToString();
            txtPartyA5.Text = ds.Tables[0].Rows[0]["bli_PartyA5"].ToString();
            CmbParty11.Text = ds.Tables[0].Rows[0]["bli_PartyACode"].ToString();

            CmbContact.setValue(ds.Tables[0].Rows[0]["bli_PartyBCode"].ToString());
            txtContact1.Text = ds.Tables[0].Rows[0]["bli_PartyB1"].ToString();
            txtContact2.Text = ds.Tables[0].Rows[0]["bli_PartyB2"].ToString();
            txtContact3.Text = ds.Tables[0].Rows[0]["bli_PartyB3"].ToString();
            txtContact4.Text = ds.Tables[0].Rows[0]["bli_PartyB4"].ToString();
            txtContact5.Text = ds.Tables[0].Rows[0]["bli_PartyB5"].ToString();
            CmbContact1.Text = ds.Tables[0].Rows[0]["bli_PartyBCode"].ToString();

            hidChecked.Text=ds.Tables[0].Rows[0]["bli_Xdischarge"].ToString().TrimEnd();
            switch (hidChecked.Text)
            {
                //case "1": chkSurrend.Checked = true; break;
                //case "2": chkOriginal.Checked = true; break;
                //case "3": chkOF.Checked = true; break;
                case "1": chkSurrend.Checked = false; break;
                case "2": chkOriginal.Checked = false; break;
                case "3": chkOF.Checked = false; break;
            }

            txtInstr1.Text = ds.Tables[0].Rows[0]["bli_ExpInst1"].ToString();
            txtInstr2.Text = ds.Tables[0].Rows[0]["bli_ExpInst2"].ToString();
            txtInstr3.Text = ds.Tables[0].Rows[0]["bli_ExpInst3"].ToString();

            txtReceipt.Text = ds.Tables[0].Rows[0]["bli_Receipt"].ToString();
            txtCarriage.Text = ds.Tables[0].Rows[0]["bli_Carriage"].ToString();
            txtPreVoyage.Text = ds.Tables[0].Rows[0]["bli_PreVoyage"].ToString();
            txtVessel.Text = ds.Tables[0].Rows[0]["bli_Vessel"].ToString();
            txtVoyage.Text = ds.Tables[0].Rows[0]["bli_Voyage"].ToString();
            txtLoading.Text = ds.Tables[0].Rows[0]["bli_POL"].ToString();
            txtDischarge.Text = ds.Tables[0].Rows[0]["bli_POD"].ToString();
            txtDelivery.Text = ds.Tables[0].Rows[0]["bli_Final"].ToString();
            txtRouting.Text = ds.Tables[0].Rows[0]["bli_InlandRouting"].ToString();
            txtRefNo.Text = ds.Tables[0].Rows[0]["bli_ShipperRef"].ToString();
            txtOrignBL.Text = ds.Tables[0].Rows[0]["bli_BLCount"].ToString();
            txtOrignBL1.Text = ds.Tables[0].Rows[0]["bli_BLCount1"].ToString();

            txtBy.Text = ds.Tables[0].Rows[0]["bli_ByUser"].ToString();
            txtDate.Text = ds.Tables[0].Rows[0]["bli_ByDate"].ToString();
            txtService1.Text = ds.Tables[0].Rows[0]["bli_Signature1"].ToString();
            txtService2.Text = ds.Tables[0].Rows[0]["bli_Signature2"].ToString();
            txtService3.Text = ds.Tables[0].Rows[0]["bli_Signature3"].ToString();
            txtService4.Text = ds.Tables[0].Rows[0]["bli_Signature4"].ToString();

            CmbReceipt.setValue(ds.Tables[0].Rows[0]["ReceiptCode"].ToString());
            CmbLoading.setValue(ds.Tables[0].Rows[0]["LoadingCode"].ToString());
            CmbDischarge.setValue(ds.Tables[0].Rows[0]["PortCode"].ToString());
            CmbDelivery.setValue(ds.Tables[0].Rows[0]["FinalDestCode"].ToString());
       
        }
        if (ds != null && ds.Tables[1].Rows.Count > 0)
        {
            txtMarks1.Text = ds.Tables[1].Rows[0]["bld_Mark01"].ToString();
            txtMarks2.Text = ds.Tables[1].Rows[0]["bld_Mark02"].ToString();
            txtMarks3.Text = ds.Tables[1].Rows[0]["bld_Mark03"].ToString();
            txtMarks4.Text = ds.Tables[1].Rows[0]["bld_Mark04"].ToString();
            txtMarks5.Text = ds.Tables[1].Rows[0]["bld_Mark05"].ToString();
            txtMarks6.Text = ds.Tables[1].Rows[0]["bld_Mark06"].ToString();
            txtMarks7.Text = ds.Tables[1].Rows[0]["bld_Mark07"].ToString();
            txtMarks8.Text = ds.Tables[1].Rows[0]["bld_Mark08"].ToString();
            txtMarks9.Text = ds.Tables[1].Rows[0]["bld_Mark09"].ToString();
            txtMarks10.Text = ds.Tables[1].Rows[0]["bld_Mark10"].ToString();
            txtMarks11.Text = ds.Tables[1].Rows[0]["bld_Mark11"].ToString();
            txtMarks12.Text = ds.Tables[1].Rows[0]["bld_Mark12"].ToString();
            txtMarks13.Text = ds.Tables[1].Rows[0]["bld_Mark13"].ToString();
            txtMarks14.Text = ds.Tables[1].Rows[0]["bld_Mark14"].ToString();
            txtMarks15.Text = ds.Tables[1].Rows[0]["bld_Mark15"].ToString();
            txtMarks16.Text = ds.Tables[1].Rows[0]["bld_Mark16"].ToString();
            txtMarks17.Text = ds.Tables[1].Rows[0]["bld_Mark17"].ToString();
            txtMarks18.Text = ds.Tables[1].Rows[0]["bld_Mark18"].ToString();
            txtMarks19.Text = ds.Tables[1].Rows[0]["bld_Mark19"].ToString();
            txtMarks20.Text = ds.Tables[1].Rows[0]["bld_Mark20"].ToString();
            txtMarks21.Text = ds.Tables[1].Rows[0]["bld_Mark21"].ToString();

            txtPKGS1.Text = ds.Tables[1].Rows[0]["bld_PKGS01"].ToString();
            txtPKGS2.Text = ds.Tables[1].Rows[0]["bld_PKGS02"].ToString();
            txtPKGS3.Text = ds.Tables[1].Rows[0]["bld_PKGS03"].ToString();
            txtPKGS4.Text = ds.Tables[1].Rows[0]["bld_PKGS04"].ToString();
            txtPKGS5.Text = ds.Tables[1].Rows[0]["bld_PKGS05"].ToString();
            txtPKGS6.Text = ds.Tables[1].Rows[0]["bld_PKGS06"].ToString();
            txtPKGS7.Text = ds.Tables[1].Rows[0]["bld_PKGS07"].ToString();
            txtPKGS8.Text = ds.Tables[1].Rows[0]["bld_PKGS08"].ToString();
            txtPKGS9.Text = ds.Tables[1].Rows[0]["bld_PKGS09"].ToString();
            txtPKGS10.Text = ds.Tables[1].Rows[0]["bld_PKGS10"].ToString();
            txtPKGS11.Text = ds.Tables[1].Rows[0]["bld_PKGS11"].ToString();
            txtPKGS12.Text = ds.Tables[1].Rows[0]["bld_PKGS12"].ToString();
            txtPKGS13.Text = ds.Tables[1].Rows[0]["bld_PKGS13"].ToString();
            txtPKGS14.Text = ds.Tables[1].Rows[0]["bld_PKGS14"].ToString();
            txtPKGS15.Text = ds.Tables[1].Rows[0]["bld_PKGS15"].ToString();
            txtPKGS16.Text = ds.Tables[1].Rows[0]["bld_PKGS16"].ToString();
            txtPKGS17.Text = ds.Tables[1].Rows[0]["bld_PKGS17"].ToString();
            txtPKGS18.Text = ds.Tables[1].Rows[0]["bld_PKGS18"].ToString();
            txtPKGS19.Text = ds.Tables[1].Rows[0]["bld_PKGS19"].ToString();
            txtPKGS20.Text = ds.Tables[1].Rows[0]["bld_PKGS20"].ToString();
            txtPKGS21.Text = ds.Tables[1].Rows[0]["bld_PKGS21"].ToString();

            txtDes1.Text = ds.Tables[1].Rows[0]["bld_Desc01"].ToString();
            txtDes2.Text = ds.Tables[1].Rows[0]["bld_Desc02"].ToString();
            txtDes3.Text = ds.Tables[1].Rows[0]["bld_Desc03"].ToString();
            txtDes4.Text = ds.Tables[1].Rows[0]["bld_Desc04"].ToString();
            txtDes5.Text = ds.Tables[1].Rows[0]["bld_Desc05"].ToString();
            txtDes6.Text = ds.Tables[1].Rows[0]["bld_Desc06"].ToString();
            txtDes7.Text = ds.Tables[1].Rows[0]["bld_Desc07"].ToString();
            txtDes8.Text = ds.Tables[1].Rows[0]["bld_Desc08"].ToString();
            txtDes9.Text = ds.Tables[1].Rows[0]["bld_Desc09"].ToString();
            txtDes10.Text = ds.Tables[1].Rows[0]["bld_Desc10"].ToString();
            txtDes11.Text = ds.Tables[1].Rows[0]["bld_Desc11"].ToString();
            txtDes12.Text = ds.Tables[1].Rows[0]["bld_Desc12"].ToString();
            txtDes13.Text = ds.Tables[1].Rows[0]["bld_Desc13"].ToString();
            txtDes14.Text = ds.Tables[1].Rows[0]["bld_Desc14"].ToString();
            txtDes15.Text = ds.Tables[1].Rows[0]["bld_Desc15"].ToString();
            txtDes16.Text = ds.Tables[1].Rows[0]["bld_Desc16"].ToString();
            txtDes17.Text = ds.Tables[1].Rows[0]["bld_Desc17"].ToString();
            txtDes18.Text = ds.Tables[1].Rows[0]["bld_Desc18"].ToString();
            txtDes19.Text = ds.Tables[1].Rows[0]["bld_Desc19"].ToString();
            txtDes20.Text = ds.Tables[1].Rows[0]["bld_Desc20"].ToString();
            txtDes21.Text = ds.Tables[1].Rows[0]["bld_Desc21"].ToString();

            txtGW.Text = ds.Tables[1].Rows[0]["bld_GWT"].ToString();
            txtMea.Text =  ds.Tables[1].Rows[0]["bld_VWT"].ToString();

            txtFRDes1.Text = ds.Tables[1].Rows[0]["bld_Freight1"].ToString();
            txtFRDes2.Text = ds.Tables[1].Rows[0]["bld_Freight2"].ToString();
            txtFRDes3.Text = ds.Tables[1].Rows[0]["bld_Freight3"].ToString();
            txtFRDes4.Text = ds.Tables[1].Rows[0]["bld_Freight4"].ToString();
            txtFRDes5.Text = ds.Tables[1].Rows[0]["bld_Freight5"].ToString();
            txtFRDes6.Text = ds.Tables[1].Rows[0]["bld_Freight6"].ToString();
            txtFRDes7.Text = ds.Tables[1].Rows[0]["bld_Freight7"].ToString();
            txtFRDes8.Text = ds.Tables[1].Rows[0]["bld_Freight8"].ToString();
            txtFRDes9.Text = ds.Tables[1].Rows[0]["bld_Freight9"].ToString();
            txtFRDes10.Text = ds.Tables[1].Rows[0]["bld_Freight10"].ToString();

            txtPre1.Text = ds.Tables[1].Rows[0]["bld_FPP1"].ToString();
            txtPre2.Text = ds.Tables[1].Rows[0]["bld_FPP2"].ToString();
            txtPre3.Text = ds.Tables[1].Rows[0]["bld_FPP3"].ToString();
            txtPre4.Text = ds.Tables[1].Rows[0]["bld_FPP4"].ToString();
            txtPre5.Text = ds.Tables[1].Rows[0]["bld_FPP5"].ToString();
            txtPre6.Text = ds.Tables[1].Rows[0]["bld_FPP6"].ToString();
            txtPre7.Text = ds.Tables[1].Rows[0]["bld_FPP7"].ToString();
            txtPre8.Text = ds.Tables[1].Rows[0]["bld_FPP8"].ToString();
            txtPre9.Text = ds.Tables[1].Rows[0]["bld_FPP9"].ToString();
            txtPre10.Text = ds.Tables[1].Rows[0]["bld_FPP10"].ToString();

            txtCol1.Text = ds.Tables[1].Rows[0]["bld_FCC1"].ToString();
            txtCol2.Text = ds.Tables[1].Rows[0]["bld_FCC2"].ToString();
            txtCol3.Text = ds.Tables[1].Rows[0]["bld_FCC3"].ToString();
            txtCol4.Text = ds.Tables[1].Rows[0]["bld_FCC4"].ToString();
            txtCol5.Text = ds.Tables[1].Rows[0]["bld_FCC5"].ToString();
            txtCol6.Text = ds.Tables[1].Rows[0]["bld_FCC6"].ToString();
            txtCol7.Text = ds.Tables[1].Rows[0]["bld_FCC7"].ToString();
            txtCol8.Text = ds.Tables[1].Rows[0]["bld_FCC8"].ToString();
            txtCol9.Text = ds.Tables[1].Rows[0]["bld_FCC9"].ToString();
            txtCol10.Text = ds.Tables[1].Rows[0]["bld_FCC10"].ToString();

            txtCharge1.Text = ds.Tables[1].Rows[0]["bld_FPPTotal"].ToString();
            txtCharge2.Text = ds.Tables[1].Rows[0]["bld_FCCTotal"].ToString();
            txtCharge1Currency.Text = ds.Tables[1].Rows[0]["bld_FPPCurrency"].ToString(); ;
            txtCharge2Currency.Text = ds.Tables[1].Rows[0]["bld_FCCCurrency"].ToString(); ;

            hidMLine.Text=ds.Tables[1].Rows[0]["bld_MLine"].ToString();
            hidPLine.Text=ds.Tables[1].Rows[0]["bld_PLine"].ToString();
            hidDLine.Text=ds.Tables[1].Rows[0]["bld_DLine"].ToString();

            hidMakeMLine.Text = ds.Tables[1].Rows[0]["bld_MakeMLine"].ToString();
            hidMakePLine.Text = ds.Tables[1].Rows[0]["bld_MakePLine"].ToString();
            hidMakeDLine.Text = ds.Tables[1].Rows[0]["bld_MakeDLine"].ToString();

            hidMakeOldMLine.Text = ds.Tables[1].Rows[0]["bld_MakeMLine"].ToString();
            hidMakeOldPLine.Text = ds.Tables[1].Rows[0]["bld_MakePLine"].ToString();
            hidMakeOldDLine.Text = ds.Tables[1].Rows[0]["bld_MakeDLine"].ToString();
            flagAtt=ds.Tables[1].Rows[0]["bld_FlagAttachment"].ToString();

            X.AddScript("SetLineData();");
        }
       
        //if (txtDes3.Text.TrimEnd() == "** ALL DETAILS AS PER ATTACHED LIST **" || txtDes5.Text.TrimEnd() == "** ALL DETAILS AS PER ATTACHED LIST **" || (txtDes3.Text.TrimEnd().StartsWith("1 X") && txtDes5.Text.TrimEnd().StartsWith("1 X")))
        //{
        //    //X.AddScript("$('#btnAttachList').show();");
        //    hidAttach.Text = "1";
        //}
        if (flagAtt=="1")
        {
            //X.AddScript("$('#btnAttachList').show();");
            hidAttach.Text = "1";
        }
        else
        {
            //X.AddScript("$('#btnAttachList').hide();");
            hidAttach.Text = "0";
        }
        ControlBinder.pageTitleMsg(false, labBLNO.Text, "<p>Status : Edit  No. of <span>" + labBLNO.Text + "</span></p>", div_bottom);
    }
    #endregion

    #region GetDs(string CmdText, List<IFields> fields)   Author ：hcy   (2012-04-03)
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

    public int i = 0;
    #region    btnPrint_Click()     Author：Hcy   (2012-04-03)
    protected void btnPrint_Click(object sender, DirectEventArgs e)
    {
        i = 1;
        if (LockDate.IsLock(hidSeed.Text, ""))
        {
            if (hidChecked.Text != "")
            {
                X.AddScript("window.open('../OEReportFile/ReportPdf.aspx?type=HDraft&ID=" + hidSeed.Text + "&HAttach=" + hidAttach.Text + "&HType=" + hidChecked.Text + "','_blank');");
            }
            else
            {
                X.AddScript("window.open('../OEReportFile/ReportFile.aspx?type=Bill&ID=" + hidSeed.Text + "&HAttach=" + hidAttach.Text + "&HType=" + hidChecked.Text + "','_blank');");
            }
        }
        else
            btnSave_Click(sender, e);
         
    }
    #endregion

    

     #region    btnSave_Click()     Author：Hcy   (2011-12-03)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        #region 11
        if (chkSurrend.Checked == false && chkOriginal.Checked == false && chkOF.Checked == false)
        {
            hidChecked.Text = "";
        }
        List<IFields> UpdateBill = new List<IFields>();
        UpdateBill.Add(dal.CreateIFields().Append("Option", "Update")
          .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)

         .Append("bli_Xshipper", "0")
         .Append("bli_ShipperCode", CmbShipperCode.Value)
        .Append("bli_Shipper1", txtShipper1.Text.TrimEnd().ToUpper())
        .Append("bli_Shipper2", txtShipper2.Text.TrimEnd().ToUpper())
        .Append("bli_Shipper3", txtShipper3.Text.TrimEnd().ToUpper())
        .Append("bli_Shipper4", txtShipper4.Text.TrimEnd().ToUpper())
        .Append("bli_Shipper5", "")

        .Append("bli_XConsignee", "0")
        .Append("bli_ConsigneeCode", CmbConsigneeCode.Value)
        .Append("bli_Consignee1", txtConsignee1.Text.TrimEnd().ToUpper())
        .Append("bli_Consignee2", txtConsignee2.Text.TrimEnd().ToUpper())
        .Append("bli_Consignee3", txtConsignee3.Text.TrimEnd().ToUpper())
        .Append("bli_Consignee4", txtConsignee4.Text.TrimEnd().ToUpper())
        .Append("bli_Consignee5", txtConsignee5.Text.TrimEnd().ToUpper())
        .Append("bli_Consignee6", "")

        .Append("bli_XPartyA", "0")
        .Append("bli_PartyACode", CmbParty1.Value)
        .Append("bli_PartyA1", txtPartyA1.Text.TrimEnd().ToUpper())
        .Append("bli_PartyA2", txtPartyA2.Text.TrimEnd().ToUpper())
        .Append("bli_PartyA3", txtPartyA3.Text.TrimEnd().ToUpper())
        .Append("bli_PartyA4", txtPartyA4.Text.TrimEnd().ToUpper())
        .Append("bli_PartyA5", txtPartyA5.Text.TrimEnd().ToUpper())
        .Append("bli_PartyA6", "")

        .Append("bli_PartyBCode", CmbContact.Value)
        .Append("bli_PartyB1", txtContact1.Text.TrimEnd().ToUpper())
        .Append("bli_PartyB2", txtContact2.Text.TrimEnd().ToUpper())
        .Append("bli_PartyB3", txtContact3.Text.TrimEnd().ToUpper())
        .Append("bli_PartyB4", txtContact4.Text.TrimEnd().ToUpper())
        .Append("bli_PartyB5", txtContact5.Text.TrimEnd().ToUpper())
        .Append("bli_PartyB6", "")

        .Append("bli_Xdischarge",hidChecked.Text)

        .Append("bli_XExpInst", "0")
        .Append("bli_ExpInst1", txtInstr1.Text.TrimEnd().ToUpper())
        .Append("bli_ExpInst2", txtInstr2.Text.TrimEnd().ToUpper())
        .Append("bli_ExpInst3", txtInstr3.Text.TrimEnd().ToUpper())
        .Append("bli_ExpInst4", "")

        .Append("bli_Receipt", txtReceipt.Text.TrimEnd().ToUpper())
        .Append("bli_Carriage", txtCarriage.Text.TrimEnd().ToUpper())
        .Append("bli_PreVoyage",txtPreVoyage.Text.TrimEnd().ToUpper())
        .Append("bli_Vessel", txtVessel.Text.TrimEnd().ToUpper())
        .Append("bli_Voyage", txtVoyage.Text.TrimEnd().ToUpper())
        .Append("bli_POL", txtLoading.Text.TrimEnd().ToUpper())
        .Append("bli_POD", txtDischarge.Text.TrimEnd().ToUpper())
        .Append("bli_Final", txtDelivery.Text.TrimEnd().ToUpper())
        .Append("bli_InlandRouting",txtRouting.Text.TrimEnd().ToUpper())
        .Append("bli_ShipperRef",txtRefNo.Text.TrimEnd().ToUpper())
        .Append("bli_BLCount",txtOrignBL.Text.TrimEnd())

        //update hbl dest
        .Append("ReceiveCode", string.IsNullOrEmpty(CmbReceipt.Value)?"":CmbReceipt.Value)
        .Append("LoadingCode", string.IsNullOrEmpty(CmbLoading.Value) ? "":CmbLoading.Value)
        .Append("PortCode", String.IsNullOrEmpty(CmbDischarge.Value) ? "" : CmbDischarge.Value)
        .Append("FinalDestCode", string.IsNullOrEmpty(CmbDelivery.Value) ? "" : CmbDelivery.Value)

        .Append("bli_ByUser", txtBy.Text.TrimEnd().ToUpper())
        .Append("bli_ByDate", ControlBinder.getDate(txtDate.RawText.TrimEnd().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtDate.RawText))
        .Append("bli_Signature1",txtService1.Text.TrimEnd().ToUpper())
        .Append("bli_Signature2", txtService2.Text.TrimEnd().ToUpper())
        .Append("bli_Signature3", txtService3.Text.TrimEnd().ToUpper())
        .Append("bli_Signature4", txtService4.Text.TrimEnd().ToUpper())

        .Append("o_Show3Digit", hidDigits.Text)
        .Append("o_ShowAllDetail", hidShowDetail.Text)
        .Append("o_AutoRefresh", hidRefresh.Text)
        .Append("o_InfoRefresh", hidRefresh1.Text)
         .Append("bli_User", FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper())
         .Append("bli_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString().ToUpper())
         .Append("bli_SYS", "OE")
          
          );
      bool resultBill = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_BillOfLading_SP", UpdateBill).Update();
        #endregion
      List<IFields> UpdateBillDetail = new List<IFields>();
      UpdateBillDetail.Add(dal.CreateIFields().Append("Option", "Update")
          .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)

          .Append("bld_Mark01", txtMarks1.Text.TrimEnd().ToUpper())
          .Append("bld_Mark02", txtMarks2.Text.TrimEnd().ToUpper())
          .Append("bld_Mark03", txtMarks3.Text.TrimEnd().ToUpper())
          .Append("bld_Mark04", txtMarks4.Text.TrimEnd().ToUpper())
          .Append("bld_Mark05", txtMarks5.Text.TrimEnd().ToUpper())
          .Append("bld_Mark06", txtMarks6.Text.TrimEnd().ToUpper())
          .Append("bld_Mark07", txtMarks7.Text.TrimEnd().ToUpper())
          .Append("bld_Mark08", txtMarks8.Text.TrimEnd().ToUpper())
          .Append("bld_Mark09", txtMarks9.Text.TrimEnd().ToUpper())
          .Append("bld_Mark10", txtMarks10.Text.TrimEnd().ToUpper())
          .Append("bld_Mark11", txtMarks11.Text.TrimEnd().ToUpper())
          .Append("bld_Mark12", txtMarks12.Text.TrimEnd().ToUpper())
          .Append("bld_Mark13", txtMarks13.Text.TrimEnd().ToUpper())
          .Append("bld_Mark14", txtMarks14.Text.TrimEnd().ToUpper())
          .Append("bld_Mark15", txtMarks15.Text.TrimEnd().ToUpper())
          .Append("bld_Mark16", txtMarks16.Text.TrimEnd().ToUpper())
          .Append("bld_Mark17", txtMarks17.Text.TrimEnd().ToUpper())
          .Append("bld_Mark18", txtMarks18.Text.TrimEnd().ToUpper())
          .Append("bld_Mark19", txtMarks19.Text.TrimEnd().ToUpper())
          .Append("bld_Mark20", txtMarks20.Text.TrimEnd().ToUpper())
          .Append("bld_Mark21", txtMarks21.Text.TrimEnd().ToUpper())

          .Append("bld_PKGS01", txtPKGS1.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS02", txtPKGS2.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS03", txtPKGS3.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS04", txtPKGS4.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS05", txtPKGS5.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS06", txtPKGS6.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS07", txtPKGS7.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS08", txtPKGS8.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS09", txtPKGS9.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS10", txtPKGS10.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS11", txtPKGS11.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS12", txtPKGS12.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS13", txtPKGS13.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS14", txtPKGS14.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS15", txtPKGS15.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS16", txtPKGS16.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS17", txtPKGS17.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS18", txtPKGS18.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS19", txtPKGS19.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS20", txtPKGS20.Text.TrimEnd().ToUpper())
          .Append("bld_PKGS21", txtPKGS21.Text.TrimEnd().ToUpper())

          .Append("bld_Desc01", txtDes1.Text.TrimEnd().ToUpper())
          .Append("bld_Desc02", txtDes2.Text.TrimEnd().ToUpper())
          .Append("bld_Desc03", txtDes3.Text.TrimEnd().ToUpper())
          .Append("bld_Desc04", txtDes4.Text.TrimEnd().ToUpper())
          .Append("bld_Desc05", txtDes5.Text.TrimEnd().ToUpper())
          .Append("bld_Desc06", txtDes6.Text.TrimEnd().ToUpper())
          .Append("bld_Desc07", txtDes7.Text.TrimEnd().ToUpper())
          .Append("bld_Desc08", txtDes8.Text.TrimEnd().ToUpper())
          .Append("bld_Desc09", txtDes9.Text.TrimEnd().ToUpper())
          .Append("bld_Desc10", txtDes10.Text.TrimEnd().ToUpper())
          .Append("bld_Desc11", txtDes11.Text.TrimEnd().ToUpper())
          .Append("bld_Desc12", txtDes12.Text.TrimEnd().ToUpper())
          .Append("bld_Desc13", txtDes13.Text.TrimEnd().ToUpper())
          .Append("bld_Desc14", txtDes14.Text.TrimEnd().ToUpper())
          .Append("bld_Desc15", txtDes15.Text.TrimEnd().ToUpper())
          .Append("bld_Desc16", txtDes16.Text.TrimEnd().ToUpper())
          .Append("bld_Desc17", txtDes17.Text.TrimEnd().ToUpper())
          .Append("bld_Desc18", txtDes18.Text.TrimEnd().ToUpper())
          .Append("bld_Desc19", txtDes19.Text.TrimEnd().ToUpper())
          .Append("bld_Desc20", txtDes20.Text.TrimEnd().ToUpper())
          .Append("bld_Desc21", txtDes21.Text.TrimEnd().ToUpper())

          .Append("bld_GWT", txtGW.Text.TrimEnd() == "" ? null : txtGW.Text.TrimEnd().ToUpper())
          .Append("bld_VWT", txtMea.Text.TrimEnd() == "" ? null : txtMea.Text.TrimEnd().ToUpper())

          .Append("bld_Freight1", txtFRDes1.Text.TrimEnd().ToUpper())
          .Append("bld_Freight2", txtFRDes2.Text.TrimEnd().ToUpper())
          .Append("bld_Freight3", txtFRDes3.Text.TrimEnd().ToUpper())
          .Append("bld_Freight4", txtFRDes4.Text.TrimEnd().ToUpper())
          .Append("bld_Freight5", txtFRDes5.Text.TrimEnd().ToUpper())
          .Append("bld_Freight6", txtFRDes6.Text.TrimEnd().ToUpper())
          .Append("bld_Freight7", txtFRDes7.Text.TrimEnd().ToUpper())
          .Append("bld_Freight8", txtFRDes8.Text.TrimEnd().ToUpper())
          .Append("bld_Freight9", txtFRDes9.Text.TrimEnd().ToUpper())
          .Append("bld_Freight10", txtFRDes10.Text.TrimEnd().ToUpper())

          .Append("bld_FPP1", txtPre1.Text.TrimEnd()==""?null:txtPre1.Text.TrimEnd().ToUpper())
          .Append("bld_FPP2", txtPre2.Text.TrimEnd() == "" ? null : txtPre2.Text.TrimEnd().ToUpper())
          .Append("bld_FPP3", txtPre3.Text.TrimEnd() == "" ? null : txtPre3.Text.TrimEnd().ToUpper())
          .Append("bld_FPP4", txtPre4.Text.TrimEnd() == "" ? null : txtPre4.Text.TrimEnd().ToUpper())
          .Append("bld_FPP5", txtPre5.Text.TrimEnd() == "" ? null : txtPre5.Text.TrimEnd().ToUpper())
          .Append("bld_FPP6", txtPre6.Text.TrimEnd() == "" ? null : txtPre6.Text.TrimEnd().ToUpper())
          .Append("bld_FPP7", txtPre7.Text.TrimEnd() == "" ? null : txtPre7.Text.TrimEnd().ToUpper())
          .Append("bld_FPP8", txtPre8.Text.TrimEnd() == "" ? null : txtPre8.Text.TrimEnd().ToUpper())
          .Append("bld_FPP9", txtPre9.Text.TrimEnd() == "" ? null : txtPre9.Text.TrimEnd().ToUpper())
          .Append("bld_FPP10", txtPre10.Text.TrimEnd() == "" ? null : txtPre10.Text.TrimEnd().ToUpper())
          .Append("bld_FPPTotal", txtCharge1.Text.TrimEnd() == "" ? null : txtCharge1.Text.TrimEnd().ToUpper())

          .Append("bld_FCC1", txtCol1.Text.TrimEnd()==""?null:txtCol1.Text.TrimEnd().ToUpper())
          .Append("bld_FCC2", txtCol2.Text.TrimEnd() == "" ? null : txtCol2.Text.TrimEnd().ToUpper())
          .Append("bld_FCC3", txtCol3.Text.TrimEnd() == "" ? null : txtCol3.Text.TrimEnd().ToUpper())
          .Append("bld_FCC4", txtCol4.Text.TrimEnd() == "" ? null : txtCol4.Text.TrimEnd().ToUpper())
          .Append("bld_FCC5", txtCol5.Text.TrimEnd() == "" ? null : txtCol5.Text.TrimEnd().ToUpper())
          .Append("bld_FCC6", txtCol6.Text.TrimEnd() == "" ? null : txtCol6.Text.TrimEnd().ToUpper())
          .Append("bld_FCC7", txtCol7.Text.TrimEnd() == "" ? null : txtCol7.Text.TrimEnd().ToUpper())
          .Append("bld_FCC8", txtCol8.Text.TrimEnd() == "" ? null : txtCol8.Text.TrimEnd().ToUpper())
          .Append("bld_FCC9", txtCol9.Text.TrimEnd() == "" ? null : txtCol9.Text.TrimEnd().ToUpper())
          .Append("bld_FCC10", txtCol10.Text.TrimEnd() == "" ? null : txtCol10.Text.TrimEnd().ToUpper())
          .Append("bld_FCCTotal", txtCharge2.Text.TrimEnd() == "" ? null : txtCharge2.Text.TrimEnd().ToUpper())

          .Append("bld_FPPCurrency", txtCharge1Currency.Text)
          .Append("bld_FCCCurrency", txtCharge2Currency.Text)

          .Append("bld_MLine",hidMLine.Text)
          .Append("bld_PLine", hidPLine.Text)
          .Append("bld_DLine", hidDLine.Text)
          .Append("bld_MakeMLine", hidMakeMLine.Text)
          .Append("bld_MakePLine", hidMakePLine.Text)
          .Append("bld_MakeDLine", hidMakeDLine.Text)

          .Append("bld_User", FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper())
         .Append("bld_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString().ToUpper())
         .Append("bld_SYS", "OE")
          );

      bool resultBillDetail = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_BillOfLadingDetail_SP", UpdateBillDetail).Update();

      if (resultBillDetail == true)
      {
          DataBindList();
          if (i == 1)
          {
             i = 0;
             if (hidChecked.Text != "")
             {
                 X.AddScript("window.open('../OEReportFile/ReportPdf.aspx?type=HDraft&ID=" + hidSeed.Text + "&HAttach=" + hidAttach.Text + "&HType=" + hidChecked.Text + "','_blank');");
             }
             else
             {
                 X.AddScript("window.open('../OEReportFile/ReportFile.aspx?type=Bill&ID=" + hidSeed.Text + "&HAttach=" + hidAttach.Text + "&HType=" + hidChecked.Text + "','_blank');");
             } 
          }
          //else if (i == 2)
          //{
          //    i = 0;
          //    X.AddScript("window.open('../OEReportFile/ReportFile.aspx?type=HDraft&ID=" + hidSeed.Text + "&HType="+hidChecked.Text+"','_blank');");  
          //}
          //else if (i == 3)
          //{
          //    i = 0;
          //    X.AddScript("window.open('../OEReportFile/ReportFile.aspx?type=ACI&ID=" + hidSeed.Text + "','_blank');");
                
          //}
          //else if (i == 4)
          //{
          //    i = 0;
          //    X.AddScript("window.open('../OEReportFile/ReportFile.aspx?type=AttachList&ID=" + hidSeed.Text + "','_blank');");
          //}
          
          ControlBinder.pageTitleMsg(false, "Edit " + labBLNO.Text, "<p class=\"success\">Status : Save successfully ! </p>", div_bottom);
      }
      else
      {
          ControlBinder.pageTitleMsg(false, "Edit:" + labBLNO.Text, "<p class=\"error\">Status : Save failed, please check the data !</p>", div_bottom);
      }
    }
     #endregion

    #region    btnAttach_Click()     Author：Hcy   (2011-12-03)
    protected void btnAttach_Click(object sender, DirectEventArgs e)
    {
            X.AddScript("CompanyX.ShowManifestDetail();");
    }
    #endregion

    [DirectMethod]
    public void ShowManifestDetail()
    {
        var win = new Window
        {
            ID = "winShow",
            Constrain = true,
            Modal = false,
            BodyStyle = "background-color: #fff;",
            Padding = 0,
            Resizable = false,
            Draggable = true,
            Closable = true,
            Width = Unit.Pixel(630),
            Height = Unit.Pixel(510)

        };
        win.AutoLoad.Url = "ManifestDetail.aspx?seed=" + hidSeed.Text;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Render();
        win.Show();
    }

    [DirectMethod]
    public void SetInfo(string typename, string code)
    {
        if (typename == "CmbShipperCode" && code != "" && code == CmbShipperCode1.Text.TrimEnd())
        {
            return;
        }
        else if (typename == "CmbConsigneeCode" && code != "" && code == CmbConsigneeCode1.Text.TrimEnd())
        {
            return;
        }
        else if (typename == "CmbParty1" && code != "" && code == CmbParty11.Text.TrimEnd())
        {
            return;
        }
        else if (typename == "CmbContact" && code != "" && code == CmbContact1.Text.TrimEnd())
        {
            return;
        }

        DataSet dsCom = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_BillOfLading_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "GetCompanyInfoByCode").
        Append("CODE", code).
        Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        if (dsCom != null && dsCom.Tables[0].Rows.Count > 0)
        {
            if (typename == "CmbShipperCode")
            {
                txtShipper1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtShipper2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtShipper3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                txtShipper4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                //txtShipper5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                CmbShipperCode1.Text = code;
            }
            else if (typename == "CmbConsigneeCode")
            {
                txtConsignee1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtConsignee2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtConsignee3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                txtConsignee4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                txtConsignee5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                CmbConsigneeCode1.Text = code;
            }
            else if (typename == "CmbParty1")
            {
                txtPartyA1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtPartyA2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtPartyA3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                txtPartyA4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                txtPartyA5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                CmbParty11.Text = code;
            }
            else if (typename == "CmbContact")
            {
                txtContact1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtContact2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtContact3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                txtContact4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                txtContact5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                CmbContact1.Text = code;
            }
        }
        else
        {
            if (typename == "CmbShipperCode")
            {
                txtShipper1.Text = "";
                txtShipper2.Text = "";
                txtShipper3.Text = "";
                txtShipper4.Text = "";
                //txtShipper5.Text = "";
            }
            else if (typename == "CmbConsigneeCode")
            {
                txtConsignee1.Text = "";
                txtConsignee2.Text = "";
                txtConsignee3.Text = "";
                txtConsignee4.Text = "";
                txtConsignee5.Text = "";
            }
            else if (typename == "CmbParty1")
            {
                txtPartyA1.Text = "";
                txtPartyA2.Text = "";
                txtPartyA3.Text = "";
                txtPartyA4.Text = "";
                txtPartyA5.Text = "";
            }
            else if (typename == "CmbContact")
            {
                txtContact1.Text = "";
                txtContact2.Text = "";
                txtContact3.Text = "";
                txtContact4.Text = "";
                txtContact5.Text = "";
            }
        }
    }


    [DirectMethod]

    public void SetBLCount()
    {
         DataSet dsCom = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_BillOfLading_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "GetEng").
        Append("seed", txtOrignBL.Text)}).GetList();
         if (dsCom != null && dsCom.Tables[0].Rows.Count > 0)
         {
             txtOrignBL1.Text = dsCom.Tables[0].Rows[0][0].ToString();
         }
    }

    [DirectMethod]

    public void MakeHeader()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_BillOfLadingDetail_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "MakeHeader").
        Append("o_InfoRefresh",hidRefresh1.Text).
        Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)}).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            CmbReceipt.setValue(ds.Tables[0].Rows[0]["ReceiptCode"].ToString());
            CmbLoading.setValue(ds.Tables[0].Rows[0]["LoadingCode"].ToString());
            CmbDischarge.setValue(ds.Tables[0].Rows[0]["PortCode"].ToString());
            CmbDelivery.setValue(ds.Tables[0].Rows[0]["FinalDestCode"].ToString());

            txtReceipt.Text = ds.Tables[0].Rows[0]["bli_Receipt"].ToString();
            txtVessel.Text = ds.Tables[0].Rows[0]["bli_Vessel"].ToString();
            txtVoyage.Text = ds.Tables[0].Rows[0]["bli_Voyage"].ToString();
            txtLoading.Text = ds.Tables[0].Rows[0]["bli_POL"].ToString();
            txtDischarge.Text = ds.Tables[0].Rows[0]["bli_POD"].ToString();
            txtDelivery.Text = ds.Tables[0].Rows[0]["bli_Final"].ToString();
        }
    }

    [DirectMethod]
    public void MakeDetail()
    {
        string flagAtt = "0";
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_BillOfLadingDetail_SP", new List<IFields>() { dal.CreateIFields()
        .Append("Option", "MakeDetail")
        .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)
        .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
        .Append("o_Show3Digit", hidDigits.Text)
        .Append("o_ShowAllDetail", hidShowDetail.Text)
        .Append("bld_OldMakeMLine", hidMakeOldMLine.Text)
         .Append("bld_OldMakePLine", hidMakeOldPLine.Text)
         .Append("bld_OldMakeDLine", hidMakeOldDLine.Text)
         .Append("o_AutoRefresh",hidRefresh.Text)
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            txtMarks1.Text = ds.Tables[0].Rows[0]["bld_Mark01"].ToString();
            txtMarks2.Text = ds.Tables[0].Rows[0]["bld_Mark02"].ToString();
            txtMarks3.Text = ds.Tables[0].Rows[0]["bld_Mark03"].ToString();
            txtMarks4.Text = ds.Tables[0].Rows[0]["bld_Mark04"].ToString();
            txtMarks5.Text = ds.Tables[0].Rows[0]["bld_Mark05"].ToString();
            txtMarks6.Text = ds.Tables[0].Rows[0]["bld_Mark06"].ToString();
            txtMarks7.Text = ds.Tables[0].Rows[0]["bld_Mark07"].ToString();
            txtMarks8.Text = ds.Tables[0].Rows[0]["bld_Mark08"].ToString();
            txtMarks9.Text = ds.Tables[0].Rows[0]["bld_Mark09"].ToString();
            txtMarks10.Text = ds.Tables[0].Rows[0]["bld_Mark10"].ToString();
            txtMarks11.Text = ds.Tables[0].Rows[0]["bld_Mark11"].ToString();
            txtMarks12.Text = ds.Tables[0].Rows[0]["bld_Mark12"].ToString();
            txtMarks13.Text = ds.Tables[0].Rows[0]["bld_Mark13"].ToString();
            txtMarks14.Text = ds.Tables[0].Rows[0]["bld_Mark14"].ToString();
            txtMarks15.Text = ds.Tables[0].Rows[0]["bld_Mark15"].ToString();
            txtMarks16.Text = ds.Tables[0].Rows[0]["bld_Mark16"].ToString();
            txtMarks17.Text = ds.Tables[0].Rows[0]["bld_Mark17"].ToString();
            txtMarks18.Text = ds.Tables[0].Rows[0]["bld_Mark18"].ToString();
            txtMarks19.Text = ds.Tables[0].Rows[0]["bld_Mark19"].ToString();
            txtMarks20.Text = ds.Tables[0].Rows[0]["bld_Mark20"].ToString();
            txtMarks21.Text = ds.Tables[0].Rows[0]["bld_Mark21"].ToString();

            txtPKGS1.Text = ds.Tables[0].Rows[0]["bld_PKGS01"].ToString();
            txtPKGS2.Text = ds.Tables[0].Rows[0]["bld_PKGS02"].ToString();
            txtPKGS3.Text = ds.Tables[0].Rows[0]["bld_PKGS03"].ToString();
            txtPKGS4.Text = ds.Tables[0].Rows[0]["bld_PKGS04"].ToString();
            txtPKGS5.Text = ds.Tables[0].Rows[0]["bld_PKGS05"].ToString();
            txtPKGS6.Text = ds.Tables[0].Rows[0]["bld_PKGS06"].ToString();
            txtPKGS7.Text = ds.Tables[0].Rows[0]["bld_PKGS07"].ToString();
            txtPKGS8.Text = ds.Tables[0].Rows[0]["bld_PKGS08"].ToString();
            txtPKGS9.Text = ds.Tables[0].Rows[0]["bld_PKGS09"].ToString();
            txtPKGS10.Text = ds.Tables[0].Rows[0]["bld_PKGS10"].ToString();
            txtPKGS11.Text = ds.Tables[0].Rows[0]["bld_PKGS11"].ToString();
            txtPKGS12.Text = ds.Tables[0].Rows[0]["bld_PKGS12"].ToString();
            txtPKGS13.Text = ds.Tables[0].Rows[0]["bld_PKGS13"].ToString();
            txtPKGS14.Text = ds.Tables[0].Rows[0]["bld_PKGS14"].ToString();
            txtPKGS15.Text = ds.Tables[0].Rows[0]["bld_PKGS15"].ToString();
            txtPKGS16.Text = ds.Tables[0].Rows[0]["bld_PKGS16"].ToString();
            txtPKGS17.Text = ds.Tables[0].Rows[0]["bld_PKGS17"].ToString();
            txtPKGS18.Text = ds.Tables[0].Rows[0]["bld_PKGS18"].ToString();
            txtPKGS19.Text = ds.Tables[0].Rows[0]["bld_PKGS19"].ToString();
            txtPKGS20.Text = ds.Tables[0].Rows[0]["bld_PKGS20"].ToString();
            txtPKGS21.Text = ds.Tables[0].Rows[0]["bld_PKGS21"].ToString();

            txtDes1.Text = ds.Tables[0].Rows[0]["bld_Desc01"].ToString();
            txtDes2.Text = ds.Tables[0].Rows[0]["bld_Desc02"].ToString();
            txtDes3.Text = ds.Tables[0].Rows[0]["bld_Desc03"].ToString();
            txtDes4.Text = ds.Tables[0].Rows[0]["bld_Desc04"].ToString();
            txtDes5.Text = ds.Tables[0].Rows[0]["bld_Desc05"].ToString();
            txtDes6.Text = ds.Tables[0].Rows[0]["bld_Desc06"].ToString();
            txtDes7.Text = ds.Tables[0].Rows[0]["bld_Desc07"].ToString();
            txtDes8.Text = ds.Tables[0].Rows[0]["bld_Desc08"].ToString();
            txtDes9.Text = ds.Tables[0].Rows[0]["bld_Desc09"].ToString();
            txtDes10.Text = ds.Tables[0].Rows[0]["bld_Desc10"].ToString();
            txtDes11.Text = ds.Tables[0].Rows[0]["bld_Desc11"].ToString();
            txtDes12.Text = ds.Tables[0].Rows[0]["bld_Desc12"].ToString();
            txtDes13.Text = ds.Tables[0].Rows[0]["bld_Desc13"].ToString();
            txtDes14.Text = ds.Tables[0].Rows[0]["bld_Desc14"].ToString();
            txtDes15.Text = ds.Tables[0].Rows[0]["bld_Desc15"].ToString();
            txtDes16.Text = ds.Tables[0].Rows[0]["bld_Desc16"].ToString();
            txtDes17.Text = ds.Tables[0].Rows[0]["bld_Desc17"].ToString();
            txtDes18.Text = ds.Tables[0].Rows[0]["bld_Desc18"].ToString();
            txtDes19.Text = ds.Tables[0].Rows[0]["bld_Desc19"].ToString();
            txtDes20.Text = ds.Tables[0].Rows[0]["bld_Desc20"].ToString();
            txtDes21.Text = ds.Tables[0].Rows[0]["bld_Desc21"].ToString();

            txtGW.Text = ds.Tables[0].Rows[0]["bld_GWT"].ToString();
            txtMea.Text = ds.Tables[0].Rows[0]["bld_VWT"].ToString();

            txtFRDes1.Text = ds.Tables[0].Rows[0]["bld_Freight1"].ToString();
            txtFRDes2.Text = ds.Tables[0].Rows[0]["bld_Freight2"].ToString();
            txtFRDes3.Text = ds.Tables[0].Rows[0]["bld_Freight3"].ToString();
            txtFRDes4.Text = ds.Tables[0].Rows[0]["bld_Freight4"].ToString();
            txtFRDes5.Text = ds.Tables[0].Rows[0]["bld_Freight5"].ToString();
            txtFRDes6.Text = ds.Tables[0].Rows[0]["bld_Freight6"].ToString();
            txtFRDes7.Text = ds.Tables[0].Rows[0]["bld_Freight7"].ToString();
            txtFRDes8.Text = ds.Tables[0].Rows[0]["bld_Freight8"].ToString();
            txtFRDes9.Text = ds.Tables[0].Rows[0]["bld_Freight9"].ToString();
            txtFRDes10.Text = ds.Tables[0].Rows[0]["bld_Freight10"].ToString();

            txtPre1.Text = ds.Tables[0].Rows[0]["bld_FPP1"].ToString();
            txtPre2.Text = ds.Tables[0].Rows[0]["bld_FPP2"].ToString();
            txtPre3.Text = ds.Tables[0].Rows[0]["bld_FPP3"].ToString();
            txtPre4.Text = ds.Tables[0].Rows[0]["bld_FPP4"].ToString();
            txtPre5.Text = ds.Tables[0].Rows[0]["bld_FPP5"].ToString();
            txtPre6.Text = ds.Tables[0].Rows[0]["bld_FPP6"].ToString();
            txtPre7.Text = ds.Tables[0].Rows[0]["bld_FPP7"].ToString();
            txtPre8.Text = ds.Tables[0].Rows[0]["bld_FPP8"].ToString();
            txtPre9.Text = ds.Tables[0].Rows[0]["bld_FPP9"].ToString();
            txtPre10.Text = ds.Tables[0].Rows[0]["bld_FPP10"].ToString();

            txtCol1.Text = ds.Tables[0].Rows[0]["bld_FCC1"].ToString();
            txtCol2.Text = ds.Tables[0].Rows[0]["bld_FCC2"].ToString();
            txtCol3.Text = ds.Tables[0].Rows[0]["bld_FCC3"].ToString();
            txtCol4.Text = ds.Tables[0].Rows[0]["bld_FCC4"].ToString();
            txtCol5.Text = ds.Tables[0].Rows[0]["bld_FCC5"].ToString();
            txtCol6.Text = ds.Tables[0].Rows[0]["bld_FCC6"].ToString();
            txtCol7.Text = ds.Tables[0].Rows[0]["bld_FCC7"].ToString();
            txtCol8.Text = ds.Tables[0].Rows[0]["bld_FCC8"].ToString();
            txtCol9.Text = ds.Tables[0].Rows[0]["bld_FCC9"].ToString();
            txtCol10.Text = ds.Tables[0].Rows[0]["bld_FCC10"].ToString();

            txtCharge1.Text = ds.Tables[0].Rows[0]["bld_FPPTotal"].ToString();
            txtCharge2.Text = ds.Tables[0].Rows[0]["bld_FCCTotal"].ToString();

            hidMLine.Text = ds.Tables[0].Rows[0]["bld_MLine"].ToString();
            hidPLine.Text = ds.Tables[0].Rows[0]["bld_PLine"].ToString();
            hidDLine.Text = ds.Tables[0].Rows[0]["bld_DLine"].ToString();

            hidMakeMLine.Text = ds.Tables[0].Rows[0]["bld_MakeMLine"].ToString();
            hidMakePLine.Text = ds.Tables[0].Rows[0]["bld_MakePLine"].ToString();
            hidMakeDLine.Text = ds.Tables[0].Rows[0]["bld_MakeDLine"].ToString();
            flagAtt = ds.Tables[0].Rows[0]["bld_FlagAttachment"].ToString();

            X.AddScript("SetLineData();");

            //if (txtDes3.Text.TrimEnd() == "** ALL DETAILS AS PER ATTACHED LIST **" || txtDes5.Text.TrimEnd() == "** ALL DETAILS AS PER ATTACHED LIST **" || (txtDes3.Text.TrimEnd().StartsWith("1 X") && txtDes5.Text.TrimEnd().StartsWith("1 X")))
            //{
            //    //X.AddScript("$('#hidAttach').show();");
            //    hidAttach.Text = "1";
            //}
            if (flagAtt == "1")
            {
                hidAttach.Text = "1";
            }
            else
            {
                //X.AddScript("$('#btnAttachList').hide();");
                hidAttach.Text = "0";
            }
        }
        //if (ds != null && ds.Tables.Count > 1)
        //{
        //    txtReceipt.Text = ds.Tables[1].Rows[0]["bli_Receipt"].ToString();
        //    txtVessel.Text = ds.Tables[1].Rows[0]["bli_Vessel"].ToString();
        //    txtVoyage.Text = ds.Tables[1].Rows[0]["bli_Voyage"].ToString();
        //    txtLoading.Text = ds.Tables[1].Rows[0]["bli_POL"].ToString();
        //    txtDischarge.Text = ds.Tables[1].Rows[0]["bli_POD"].ToString();
        //    txtDelivery.Text = ds.Tables[1].Rows[0]["bli_Final"].ToString();
        //}
    }

    [DirectMethod]
    public void SetCheckValue(string str)
    {
        if (str == "1")
        {
            if (chkSurrend.Checked)
            {
                chkOriginal.Checked = false;
                chkOF.Checked = false;
                hidChecked.Text = "1";
            }
        }
        else if (str == "2")
        {
            if (chkOriginal.Checked)
            {
                chkSurrend.Checked = false;
                chkOF.Checked = false;
                hidChecked.Text = "2";
            }
            
        }
        else if (str == "3")
        {
            if (chkOF.Checked)
            {
                chkOriginal.Checked = false;
                chkSurrend.Checked = false;
                hidChecked.Text = "3";
            }
            
        }

    }
}
