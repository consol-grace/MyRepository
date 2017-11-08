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

public partial class AirExport_AEHAWB_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    public static string sys = "AE";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            //ControlBinder.DateFormat(txtSignDate);
            //ControlBinder.DateFormat(txtFlightDate2);
            InitControl(true, true);

            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            hidType.Text = string.IsNullOrEmpty(Request["type"]) ? "m" : Request["type"].ToLower();
            if (hidType.Text == "h")
            {
                btnModify.Hide();
                btnDescription.Hidden = true;
                X.AddScript("$('#img_Mark').css('display','block');");
                //img_Dimension.Style.Value = "display:block";
                td_hawb1.Style.Value = "display:block";
                td_hawb2.Style.Value = "display:block";
                td_mawb1.Style.Value = "display:none";
                td_mawb2.Style.Value = "display:none";
                td_mawb3.Style.Value = "display:none";
                td_mawb4.Style.Value = "display:none";
                for (int i = 1; i <= 6; ++i)
                {
                    //TextField txt = X.GetCmp("txtLine" + i) as TextField;
                    //txt.StyleSpec = "background-color:#FFbbbb;";
                    X.AddScript("$('#txtLine" + i + "').parent().parent().css('background','#fbb');");
                }

            }
            else
            {
                btnModify.Show();
                btnDescription.Hidden = false;
                X.AddScript("$('#img_Mark').css('display','none');");
                btnOption.Hidden = true;
                btnMan.Hidden = true;
                btnSave.Hidden = true;
                //td_mawb1.Style.Value = "display:block";
                //td_mawb2.Style.Value = "display:block";
                //td_mawb3.Style.Value = "display:block";
                //td_mawb4.Style.Value = "display:block";
                //td_hawb1.Style.Value = "display:none";
                //td_hawb2.Style.Value = "display:none";
                td_hawb1.Style.Value = "display:block";
                td_hawb2.Style.Value = "display:block";
                td_mawb1.Style.Value = "display:none";
                td_mawb2.Style.Value = "display:none";
                td_mawb3.Style.Value = "display:none";
                td_mawb4.Style.Value = "display:none";
                img_Dimension.Style.Value = "display:block";

                for (int i = 6; i <= 14; ++i)
                {
                    //TextField txt = X.GetCmp("txtLineAll" + i) as TextField;
                    //txt.StyleSpec = "background-color:#FFbbbb;";
                    X.AddScript("$('#txtLineAll" + i + "').parent().parent().css('background','#fbb');");

                }
            }

            //ComboBoxBinding();
            DataBindList();
        }
    }

    #region /// 初始化控件
    void InitControl(bool i, bool o)
    {
        string AWBArrange = FSecurityHelper.CurrentUserDataGET()[24];
        txtRate2.Text = AWBArrange;
        txtRate2.StyleSpec = "text-align:center";
        txtPPWeight1.Text = AWBArrange;
        txtPPWeight1.StyleSpec = "text-align:center";
        txtCCWeight1.Text = AWBArrange;
        txtCCWeight1.StyleSpec = "text-align:center";
        txtPPOCAgent1.Text = AWBArrange;
        txtPPOCAgent1.StyleSpec = "text-align:center";
        txtCCOCAgent1.Text = AWBArrange;
        txtCCOCAgent1.StyleSpec = "text-align:center";
        txtPPTotal1.Text = AWBArrange;
        txtPPTotal1.StyleSpec = "text-align:center";
        txtCCTotal1.Text = AWBArrange;
        txtCCTotal1.StyleSpec = "text-align:center";

        if (i == false && o == false)
        {

            txtRate2.Hide();
            txtRate1.Show();
            txtPPOCAgent.Show();
            txtCCOCAgent.Show();
            txtPPOCAgent1.Hide();
            txtCCOCAgent1.Hide();

            txtPPTotal1.Hide();
            txtCCTotal1.Hide();
            txtPPTotal.Show();
            txtCCTotal.Show();
            txtTotal1.Show();
            textShow(false);
        }

        else if (i == true && o == false)
        {
            txtRate2.Show();
            txtRate1.Hide();
            txtTotal1.Hide();

            txtPPOCAgent.Show();
            txtCCOCAgent.Show();

            if (txtWTPPD.Text.ToUpper() == "P")
            {
                txtPPWeight.Hide();
                txtPPWeight1.Show();
            }
            if (txtWTColl.Text.ToUpper() == "C")
            {
                txtCCWeight.Hide();
                txtCCWeight1.Show();
            }
            textShow(false);
        }
        else if (i == false && o == true)
        {
            txtRate2.Hide();
            txtRate1.Show();
            txtTotal1.Show();
            txtTotal11.Hide();
            txtPPWeight.Disabled = true;
            txtCCWeight.Disabled = true;
            txtPPOCAgent.Show();
            txtCCOCAgent.Show();

            if (txtOtherPPD.Text.ToUpper() == "P")
            {
                txtPPOCAgent.Hide();
                txtPPOCAgent1.Show();
            }
            if (txtOtherColl.Text.ToUpper() == "C")
            {
                txtCCOCAgent.Hide();
                txtCCOCAgent1.Show();
            }

            textShow(false);
        }

        else if (i == true && o == true)
        {
            txtRate2.Show();
            txtRate1.Hide();
            txtTotal1.Hide();
            txtCCOCAgent.Hide();
            txtCCOCAgent1.Hide();
            txtPPOCAgent.Hide();
            txtPPOCAgent1.Hide();

            txtPPWeight.Disabled = true;
            txtCCWeight.Disabled = true;


            if (txtWTPPD.Text.ToUpper() == "P" && txtOtherColl.Text.ToUpper() == "C")
            {

                //txtCCTotal1.hide();
                txtPPTotal1.Show();
                txtCCTotal1.Show();

            }
            else if (txtWTColl.Text.ToUpper() == "C" && txtOtherPPD.Text.ToUpper() == "P")
            {
                //txtPPTotal1.hide();
                txtPPTotal1.Show();
                txtCCTotal1.Show();
            }
            else if (txtWTColl.Text.ToUpper() == "C" && txtOtherColl.Text.ToUpper() == "C")
            {
                txtPPTotal1.Hide();
                txtCCTotal1.Show();
            }
            else if (txtWTPPD.Text.ToUpper() == "P" && txtOtherPPD.Text.ToUpper() == "P")
            {
                txtCCTotal1.Hide();
                txtPPTotal1.Show();
            }
            else
            {
                txtPPTotal1.Hide();
                txtCCTotal1.Hide();
            }

            textShow(true);
        }

        //chkItemlist(i);
        //chkOtherList(o);

    }

    //void chkItemlist(bool b)
    //{
    //    txtRate2.Show();
    //    txtRate2.Hidden = !b;
    //    txtRate1.Hidden =b;
    //    txtTotal1.Hidden = b;
    //    txtTotal11.Show();
    //    txtTotal11.Hidden = !b;

    //}

    void textShow(bool b)
    {
        txtPPWeight.Hidden = b;
        txtCCWeight.Hidden = b;
        txtPPValuation.Hidden = b;
        txtCCValuation.Hidden = b;
        txtPPTax.Hidden = b;
        txtCCTax.Hidden = b;
        txtPPOCAgent.Hidden = b;
        txtCCOCAgent.Hidden = b;
        txtPPOCCarrier.Hidden = b;
        txtCCOCCarrier.Hidden = b;
        txtPPTotal.Hidden = b;
        txtCCTotal.Hidden = b;
    }
    #endregion

    #region GetDs(string CmdText, List<IFields> fields)   Author ：hcy   (2011-12-03)
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

    #region   GetComboxDs()    Author ：Hcy   (2011-12-03)
    private DataSet GetComboxDs(string Type)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", Type).
                Append("STAT", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("SYS",sys)}).GetList();
        }
        catch
        {
            ds = null;
        }
        return ds;
    }
    #endregion

    #region   ComboBoxBinding()    Author ：Hcy   (2011-12-03)
    private void ComboBoxBinding()
    {

        DataSet dsCom = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWB_SP", new List<IFields>() { dal.CreateIFields().
        Append("Option", "GetCompanyInfo").
        Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        if (dsCom != null && dsCom.Tables[0].Rows.Count > 0)
        {
            StoreCompanyInfo.DataSource = dsCom;
            StoreCompanyInfo.DataBind();
        }
    }
    #endregion


    public bool isb = true;

    #region   DataBindList()    Author ：Hcy   (2011-12-03)
    private void DataBindList()
    {
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetHAWB")
            .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)
            .Append("Type", hidType.Text)
            .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
            .Append("wbi_SignUser", FSecurityHelper.CurrentUserDataGET()[2])
            );
        DataSet ds = GetDs("FW_AirExport_HAWB_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            //labHeader
            string tempmawb = ds.Tables[0].Rows[0]["air_MAWB"].ToString().ToUpper();
            string temphawb = ds.Tables[0].Rows[0]["air_HAWB"].ToString().ToUpper();

            labHawbNo.Html = temphawb;
            labMawbNo.Html = tempmawb;

            string templotno = "Lot No.#: " + ds.Tables[0].Rows[0]["air_LotNo"].ToString().ToUpper();
            if (hidType.Text == "h")
            {
                labhawbormawb.Text = "HAWB";
                //labHeader.Html = (tempmawb == "MAWB#: " ? "" : tempmawb) + (temphawb == "HAWB#: " ? "" : "<span style='padding-left:10px'>" + temphawb + "</span>");
                lablotno.Text = (templotno == "Lot No.#: " ? "" : templotno);
                if (ds.Tables[0].Rows[0]["wbi_Charges"].ToString().ToUpper().StartsWith("P"))
                {
                    labppcc.Text = "FREIGHT PREPAID";
                }
                else
                {
                    labppcc.Text = "FREIGHT COLLECT";
                }
            }
            else
            {
                labhawbormawb.Text = "MAWB";
                //labHeader.Html = (tempmawb == "MAWB#: " ? "" : tempmawb);
                lablotno.Text = (templotno == "Lot No.#: " ? "" : templotno);
                labppcc.Text = "";
                labHAwbFlag.Visible = false;
                labHawbNo.Visible = false;
            }
            //wbi_ShipperCode
            txtShipper1.Text = ds.Tables[0].Rows[0]["wbi_Shipper1"].ToString();
            txtShipper2.Text = ds.Tables[0].Rows[0]["wbi_Shipper2"].ToString();
            txtShipper3.Text = ds.Tables[0].Rows[0]["wbi_Shipper3"].ToString();
            txtShipper4.Text = ds.Tables[0].Rows[0]["wbi_Shipper4"].ToString();
            txtShipper5.Text = ds.Tables[0].Rows[0]["wbi_Shipper5"].ToString();

            //wbi_ConsigneeCode
            txtConsignee1.Text = ds.Tables[0].Rows[0]["wbi_Consignee1"].ToString();
            txtConsignee2.Text = ds.Tables[0].Rows[0]["wbi_Consignee2"].ToString();
            txtConsignee3.Text = ds.Tables[0].Rows[0]["wbi_Consignee3"].ToString();
            txtConsignee4.Text = ds.Tables[0].Rows[0]["wbi_Consignee4"].ToString();
            txtConsignee5.Text = ds.Tables[0].Rows[0]["wbi_Consignee5"].ToString();

            //wbi_PartyACode hcy
            txtPartyA1.Text = ds.Tables[0].Rows[0]["wbi_PartyA2"].ToString();
            txtPartyA2.Text = ds.Tables[0].Rows[0]["wbi_PartyA3"].ToString();
            txtPartyA3.Text = ds.Tables[0].Rows[0]["wbi_PartyA4"].ToString();
            TextField1.Text = ds.Tables[0].Rows[0]["wbi_PartyA5"].ToString();
            TextField2.Text = ds.Tables[0].Rows[0]["wbi_PartyA6"].ToString();

            //wbi_PartyBCode  hcy 
            txtPartyB1.Text = ds.Tables[0].Rows[0]["wbi_PartyB1"].ToString();
            txtPartyB2.Text = ds.Tables[0].Rows[0]["wbi_PartyB2"].ToString();
            txtPartyB3.Text = ds.Tables[0].Rows[0]["wbi_PartyB3"].ToString();
            txtPartyB4.Text = ds.Tables[0].Rows[0]["wbi_PartyB4"].ToString();
            txtPartyB5.Text = ds.Tables[0].Rows[0]["wbi_PartyB5"].ToString();
            txtPartyB6.Text = ds.Tables[0].Rows[0]["wbi_AccountInfo1"].ToString();
            txtPartyB7.Text = ds.Tables[0].Rows[0]["wbi_AccountInfo2"].ToString();

            txtAgent.Text = ds.Tables[0].Rows[0]["wbi_IATA"].ToString();
            txtAccount.Text = ds.Tables[0].Rows[0]["wbi_AccountNO"].ToString();
            txtDeparture.Text = ds.Tables[0].Rows[0]["wbi_Departure"].ToString();

            txtTo.Text = ds.Tables[0].Rows[0]["wbi_Flight1To"].ToString();
            txtFde.Text = ds.Tables[0].Rows[0]["wbi_Flight1Desc"].ToString();
            txtTo2.Text = ds.Tables[0].Rows[0]["wbi_Flight2To"].ToString();
            txtBy2.Text = ds.Tables[0].Rows[0]["wbi_Flight2By"].ToString();
            txtTo3.Text = ds.Tables[0].Rows[0]["wbi_Flight3To"].ToString();
            txtBy3.Text = ds.Tables[0].Rows[0]["wbi_Flight3By"].ToString();
            txtCurrency.Text = ds.Tables[0].Rows[0]["wbi_Currency"].ToString();
            txtGhSS.Text = ds.Tables[0].Rows[0]["wbi_Charges"].ToString();
            txtWTPPD.Text = ds.Tables[0].Rows[0]["wbi_PPWT"].ToString();
            txtWTColl.Text = ds.Tables[0].Rows[0]["wbi_CCWT"].ToString();
            txtOtherPPD.Text = ds.Tables[0].Rows[0]["wbi_PPOther"].ToString();
            txtOtherColl.Text = ds.Tables[0].Rows[0]["wbi_CCOther"].ToString();
            txtCarriage.Text = ds.Tables[0].Rows[0]["wbi_Carriage"].ToString();
            txtCustomer.Text = ds.Tables[0].Rows[0]["wbi_Custom"].ToString();

            txtDest.Text = ds.Tables[0].Rows[0]["wbi_Airport"].ToString();
            txtFlightDate1.Text = ds.Tables[0].Rows[0]["wbi_Flight2Desc"].ToString();  //wbi_Flight2Desc
            txtFlightDate2.Text = ds.Tables[0].Rows[0]["wbi_Flight3Desc"].ToString();  //wbi_Flight3Desc
            txtInsur.Text = ds.Tables[0].Rows[0]["wbi_Insurance"].ToString();

            try
            {
                DateTime dt2 = DateTime.Now.AddDays(-1);
                DateTime dt1;
                if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_Flight3Desc"].ToString()))
                    dt1 = Convert.ToDateTime(ds.Tables[0].Rows[0]["wbi_Flight3Desc"].ToString());
                else
                    dt1 = DateTime.Now;

                //
                if (dt2 > dt1)
                {
                    btnSave.Hide();
                    btnModify.Show();
                    hidisb.Text = "false";
                }
                else
                {
                    btnSave.Show();
                    btnModify.Hide();
                    hidisb.Text = "true";
                }

            }
            catch
            {

            }

            txtHandle1.Text = ds.Tables[0].Rows[0]["wbi_Handle1"].ToString();
            txtHandle2.Text = ds.Tables[0].Rows[0]["wbi_Handle2"].ToString();
            txtHandle3.Text = ds.Tables[0].Rows[0]["wbi_Handle3"].ToString();

            txtPPWeight.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_PPWeight"].ToString())?"":Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_PPWeight"]).ToString("0.00");
            txtPPValuation.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_PPValuation"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_PPValuation"]).ToString("0.00");
            txtPPTax.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_PPTax"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_PPTax"]).ToString("0.00");
            txtPPOCAgent.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_PPOCAgent"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_PPOCAgent"]).ToString("0.00");
            txtPPOCCarrier.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_PPOCCarrier"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_PPOCCarrier"]).ToString("0.00");
            txtPPTotal.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_PPTotal"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_PPTotal"]).ToString("0.00");
            txtCCWeight.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_CCWeight"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_CCWeight"]).ToString("0.00");
            txtCCValuation.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_CCValuation"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_CCValuation"]).ToString("0.00");
            txtCCTax.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_CCTax"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_CCTax"]).ToString("0.00");
            txtCCOCAgent.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_CCOCAgent"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_CCOCAgent"]).ToString("0.00");
            txtCCOCCarrier.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_CCOCCarrier"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_CCOCCarrier"]).ToString("0.00");
            txtCCTotal.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_CCTotal"].ToString()) ? "" : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_CCTotal"]).ToString("0.00");

            txtCert.Text = ds.Tables[0].Rows[0]["wbi_Signature1"].ToString();
            txtSignature1.Text = ds.Tables[0].Rows[0]["wbi_Signature2"].ToString();
            txtSignDate.Text = ds.Tables[0].Rows[0]["SignDate"].ToString();
            txtSignStation.Text = ds.Tables[0].Rows[0]["wbi_SignStation"].ToString();
            txtSignUser.Text = ds.Tables[0].Rows[0]["wbi_SignUser"].ToString();

            txtCarrier1.Text = ds.Tables[0].Rows[0]["wbi_Carrier1"].ToString();
            txtCarrier2.Text = ds.Tables[0].Rows[0]["wbi_Carrier2"].ToString();

            txtVWT.Text = ds.Tables[0].Rows[0]["wbi_VWT"].ToString();

            chkItem1.Text = Convert.ToBoolean(ds.Tables[0].Rows[0]["showItem"].ToString()) ? "1" : "0";
            chkOther1.Text = Convert.ToBoolean(ds.Tables[0].Rows[0]["showOther"].ToString()) ? "1" : "0";
            chkShowInManifest1.Text = Convert.ToBoolean(ds.Tables[0].Rows[0]["XManifest"].ToString()) ? "1" : "0";

            chkItem.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["showItem"].ToString());
            chkOther.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["showOther"].ToString());
            chkShowInManifest.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["XManifest"].ToString());
            txtDescriptionhide.Text = ds.Tables[0].Rows[0]["wbi_MAWBManifest"].ToString();
            string desc = "N";
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_MAWBManifest"].ToString()))
                desc = "Y";

            string Shipper = ds.Tables[0].Rows[0]["flag2"].ToString();
            string Consignee = ds.Tables[0].Rows[0]["flag1"].ToString();
            string Dimensions = ds.Tables[0].Rows[0]["flag3"].ToString();


            X.AddScript("ShipperColor('" + Shipper + "');ConsigneeColor('" + Consignee + "');DimensionsColor('" + Dimensions + "');DescriptionColor('" + desc + "');");

            InitControl(chkItem.Checked, chkOther.Checked);

            hidShowShipperFlag.Text = ds.Tables[0].Rows[0]["ShowShipperFlag"].ToString();
        }

        if (ds != null && ds.Tables[1].Rows.Count > 0)
        {
            txtRCP1.Text = ds.Tables[1].Rows[0]["wbd_Item01RCP"].ToString();
            txtGWT1.Text = ds.Tables[1].Rows[0]["wbd_Item01GWT"].ToString();
            txtUnit1.Text = ds.Tables[1].Rows[0]["wbd_Item01Unit"].ToString();
            txtRateClass1.Text = ds.Tables[1].Rows[0]["wbd_Item01RateClass"].ToString();
            txtItem1.Text = ds.Tables[1].Rows[0]["wbd_Item01Item"].ToString();
            txtCWT1.Text = ds.Tables[1].Rows[0]["wbd_Item01CWT"].ToString();
            txtRate1.Text = ds.Tables[1].Rows[0]["wbd_Item01Rate"].ToString();
            txtTotal1.Text =string.IsNullOrEmpty(ds.Tables[1].Rows[0]["wbd_Item01Amount"].ToString())?"":Convert.ToDouble(ds.Tables[1].Rows[0]["wbd_Item01Amount"]).ToString("0.00");

            txtLineAll1.Text = ds.Tables[1].Rows[0]["wbd_Item02Line1"].ToString();
            txtLineAll2.Text = ds.Tables[1].Rows[0]["wbd_Item03Line1"].ToString();
            txtLineAll3.Text = ds.Tables[1].Rows[0]["wbd_Item04Line1"].ToString();
            txtLineAll4.Text = ds.Tables[1].Rows[0]["wbd_Item05Line1"].ToString();
            txtLineAll5.Text = ds.Tables[1].Rows[0]["wbd_Item06Line1"].ToString();
            txtLineAll6.Text = ds.Tables[1].Rows[0]["wbd_Item07Line1"].ToString();
            txtLineAll7.Text = ds.Tables[1].Rows[0]["wbd_Item08Line1"].ToString();
            txtLineAll8.Text = ds.Tables[1].Rows[0]["wbd_Item09Line1"].ToString();
            txtLineAll9.Text = ds.Tables[1].Rows[0]["wbd_Item10Line1"].ToString();
            txtLineAll10.Text = ds.Tables[1].Rows[0]["wbd_Item11Line1"].ToString();
            txtLineAll11.Text = ds.Tables[1].Rows[0]["wbd_Item12Line1"].ToString();
            txtLineAll12.Text = ds.Tables[1].Rows[0]["wbd_Item13Line1"].ToString();
            txtLineAll13.Text = ds.Tables[1].Rows[0]["wbd_Item14Line1"].ToString();


            txtLine1.Text = ds.Tables[1].Rows[0]["wbd_Item01Line3"].ToString();
            txtLine2.Text = ds.Tables[1].Rows[0]["wbd_Item02Line3"].ToString();
            txtLine3.Text = ds.Tables[1].Rows[0]["wbd_Item03Line3"].ToString();
            txtLine4.Text = ds.Tables[1].Rows[0]["wbd_Item04Line3"].ToString();
            txtLine5.Text = ds.Tables[1].Rows[0]["wbd_Item05Line3"].ToString();
            txtLine6.Text = ds.Tables[1].Rows[0]["wbd_Item06Line3"].ToString();
            txtLine7.Text = ds.Tables[1].Rows[0]["wbd_Item07Line3"].ToString();
            txtLine8.Text = ds.Tables[1].Rows[0]["wbd_Item08Line3"].ToString();
            txtLine9.Text = ds.Tables[1].Rows[0]["wbd_Item09Line3"].ToString();
            txtLine10.Text = ds.Tables[1].Rows[0]["wbd_Item10Line3"].ToString();
            txtLine11.Text = ds.Tables[1].Rows[0]["wbd_Item11Line3"].ToString();
            txtLine12.Text = ds.Tables[1].Rows[0]["wbd_Item12Line3"].ToString();
            txtLine13.Text = ds.Tables[1].Rows[0]["wbd_Item13Line3"].ToString();
            txtLine14.Text = ds.Tables[1].Rows[0]["wbd_Item14Line3"].ToString();

            txtOtherCharges1.Text = ds.Tables[1].Rows[0]["wbd_Otherline1"].ToString();
            txtOtherCharges2.Text = ds.Tables[1].Rows[0]["wbd_Otherline2"].ToString();
            txtOtherCharges3.Text = ds.Tables[1].Rows[0]["wbd_Otherline3"].ToString();
            txtOtherCharges4.Text = ds.Tables[1].Rows[0]["wbd_Otherline4"].ToString();
            txtOtherCharges5.Text = ds.Tables[1].Rows[0]["wbd_Otherline5"].ToString();
        }
        ControlBinder.pageTitleMsg(false, labhawbormawb.Text, "<p>Status : Edit  No. of <span>" + (hidType.Text == "h" ? ds.Tables[0].Rows[0]["air_HAWB"].ToString() : ds.Tables[0].Rows[0]["air_MAWB"].ToString()) + "</span></p>", div_bottom);
    }
    #endregion

    #region    btnSave_Click()     Author：Hcy   (2011-12-03)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
         
        int wbi_XParty5 = 1, wbi_XParty6 = 1;
        if (hidType.Text == "h") { wbi_XParty5 = 1; wbi_XParty6 = 1; }

        if (string.IsNullOrEmpty(txtGhSS.Text.TrimEnd()))
        {
            txtGhSS.Focus(true);
            X.Msg.Alert("Information", "PP/CC Code can't be empty").Show();
            return;
        }
        try
        {
            string FData2 = txtFlightDate2.Text.TrimEnd().ToUpper();
            string SignDate = txtSignDate.Text.TrimEnd();
            try
            {
                string[] list = FData2.Split(' ');
                int num = 0;
                if (int.TryParse(list[0], out num) && int.TryParse(list[1], out num) && int.TryParse(list[2], out num))
                {
                    if (list[0].Length == 1)
                    {
                        list[0] = "0" + list[0];
                    }

                    if (list[1].Length == 1)
                    {
                        list[1] = "0" + list[1];
                    }

                    FData2 = list[0] + " " + list[1] + " " + list[2];
                }

                if (FData2 != "")
                {
                    FData2 = DateTime.ParseExact(FData2, "yyyyMMdd", new System.Globalization.CultureInfo("en", true), System.Globalization.DateTimeStyles.AllowInnerWhite).ToString("yyyy-MM-dd");
                }
            }
            catch
            {
                try
                {
                    FData2 = Convert.ToDateTime(FData2).ToString("yyyy-MM-dd");
                }
                catch
                {
                    ControlBinder.pageTitleMsg(false, "Edit:" + hidSeed.Text, "<p class=\"error\">Status : Save failed, please check the date !</p>", div_bottom);
                    return;
                }
            }

            try
            {
                string[] list = SignDate.Split(' ');
                int num = 0;
                if (int.TryParse(list[0], out num) && int.TryParse(list[1], out num) && int.TryParse(list[2], out num))
                {
                    if (list[0].Length == 1)
                    {
                        list[0] = "0" + list[0];
                    }

                    if (list[1].Length == 1)
                    {
                        list[1] = "0" + list[1];
                    }

                    SignDate = list[0] + " " + list[1] + " " + list[2];
                }

                if (SignDate != "")
                {
                    SignDate = DateTime.ParseExact(SignDate, "yyyyMMdd", new System.Globalization.CultureInfo("en", true), System.Globalization.DateTimeStyles.AllowInnerWhite).ToString("yyyy-MM-dd HH:mm:ss");
                }
            }
            catch 
            {
                try
                {
                    SignDate = Convert.ToDateTime(SignDate).ToString("yyyy-MM-dd");
                    
                }
                catch
                {
                    ControlBinder.pageTitleMsg(false, "Edit:" + hidSeed.Text, "<p class=\"error\">Status : Save failed, please check the date !</p>", div_bottom);

                    return;
                }
                
            }

            List<IFields> UpdateHAWB = new List<IFields>();
            UpdateHAWB.Add(dal.CreateIFields().Append("Option", "Update")
                .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)
                .Append("wbi_Seed", hidSeed.Text)

                .Append("wbi_XParty5", wbi_XParty5)
                .Append("wbi_XParty6", wbi_XParty6)
                .Append("wbi_ShowOther", chkOther1.Text)
                .Append("wbi_ShowItem", chkItem1.Text)
                .Append("wbi_descript", txtDescriptionhide.Text.ToUpper())

                .Append("wbi_ShipperCode", CmbShipperCode.Value.ToUpper())
                .Append("wbi_Shipper1", txtShipper1.Text.TrimEnd().ToUpper())
                .Append("wbi_Shipper2", txtShipper2.Text.TrimEnd().ToUpper())
                .Append("wbi_Shipper3", txtShipper3.Text.TrimEnd().ToUpper())
                .Append("wbi_Shipper4", txtShipper4.Text.TrimEnd().ToUpper())
                .Append("wbi_Shipper5", txtShipper5.Text.TrimEnd().ToUpper())

                .Append("wbi_ConsigneeCode", CmbConsigneeCode.Value.ToUpper())
                .Append("wbi_Consignee1", txtConsignee1.Text.TrimEnd().ToUpper())
                .Append("wbi_Consignee2", txtConsignee2.Text.TrimEnd().ToUpper())
                .Append("wbi_Consignee3", txtConsignee3.Text.TrimEnd().ToUpper())
                .Append("wbi_Consignee4", txtConsignee4.Text.TrimEnd().ToUpper())
                .Append("wbi_Consignee5", txtConsignee5.Text.TrimEnd().ToUpper())

                .Append("wbi_PartyACode", CmbParty1.Value.ToUpper())
                .Append("wbi_PartyA2", txtPartyA1.Text.TrimEnd().ToUpper())
                .Append("wbi_PartyA3", txtPartyA2.Text.TrimEnd().ToUpper())
                .Append("wbi_PartyA4", txtPartyA3.Text.TrimEnd().ToUpper())
                .Append("wbi_PartyA5", TextField1.Text.ToUpper())
                .Append("wbi_PartyA6", TextField2.Text.ToUpper())

                .Append("wbi_PartyBCode", CmbParty2.Value.ToUpper())
                .Append("wbi_PartyB1", txtPartyB1.Text.TrimEnd().ToUpper())
                .Append("wbi_PartyB2", txtPartyB2.Text.TrimEnd().ToUpper())
                .Append("wbi_PartyB3", txtPartyB3.Text.TrimEnd().ToUpper())
                .Append("wbi_PartyB4", txtPartyB4.Text.TrimEnd().ToUpper())
                .Append("wbi_PartyB5", txtPartyB5.Text.TrimEnd().ToUpper())
                .Append("wbi_AccountInfo1", txtPartyB6.Text.TrimEnd().ToUpper())
                .Append("wbi_AccountInfo2", txtPartyB7.Text.TrimEnd().ToUpper())
                 .Append("wbi_IATA", txtAgent.Text.TrimEnd().ToUpper())
                .Append("wbi_AccountNO", txtAccount.Text.TrimEnd().ToUpper())
                .Append("wbi_Departure", txtDeparture.Text.TrimEnd().ToUpper())

                .Append("wbi_Flight1To", txtTo.Text.TrimEnd().ToUpper())
                .Append("wbi_Flight1Desc", txtFde.Text.TrimEnd().ToUpper())
                .Append("wbi_Flight2To", txtTo2.Text.TrimEnd().ToUpper())
                .Append("wbi_Flight2By", txtBy2.Text.TrimEnd().ToUpper())
                .Append("wbi_Flight3To", txtTo3.Text.TrimEnd().ToUpper())
                .Append("wbi_Flight3By", txtBy3.Text.TrimEnd().ToUpper())
                .Append("wbi_Flight2Desc", txtFlightDate1.Text.TrimEnd().ToUpper()) //
                //.Append("wbi_Flight3Desc", string.IsNullOrEmpty(txtFlightDate2.RawText) ? null : ControlBinder.getDate(txtFlightDate2.RawText.TrimEnd())) //
                //.Append("wbi_Flight3Desc", txtFlightDate2.Text.TrimEnd().ToUpper()) //
                .Append("wbi_Flight3Desc", FData2)
                .Append("wbi_Currency", txtCurrency.Text.TrimEnd().ToUpper())
                .Append("wbi_Charges", txtGhSS.Text.TrimEnd().ToUpper())
                .Append("wbi_PPWT", txtWTPPD.Text.TrimEnd().ToUpper())
                .Append("wbi_CCWT", txtWTColl.Text.TrimEnd().ToUpper())
                .Append("wbi_PPOther", txtOtherPPD.Text.TrimEnd().ToUpper())
                .Append("wbi_CCOther", txtOtherColl.Text.TrimEnd().ToUpper())
                .Append("wbi_Carriage", txtCarriage.Text.TrimEnd().ToUpper())
                .Append("wbi_Custom", txtCustomer.Text.TrimEnd().ToUpper())

                .Append("wbi_Carrier1", txtCarrier1.Text.ToUpper().ToUpper())
                .Append("wbi_Carrier2", txtCarrier2.Text.ToUpper().ToUpper())

                .Append("wbi_Airport", txtDest.Text.TrimEnd().ToUpper())
                .Append("wbi_Insurance", txtInsur.Text.TrimEnd().ToUpper())

                .Append("wbi_Handle1", txtHandle1.Text.TrimEnd().ToUpper())
                .Append("wbi_Handle2", txtHandle2.Text.TrimEnd().ToUpper())
                .Append("wbi_Handle3", txtHandle3.Text.TrimEnd().ToUpper())

                .Append("wbi_PPWeight", string.IsNullOrEmpty(txtPPWeight.Text.TrimEnd()) ? DBNull.Value : (object)txtPPWeight.Text.TrimEnd().ToUpper())
                .Append("wbi_PPValuation", string.IsNullOrEmpty(txtPPValuation.Text.TrimEnd()) ? DBNull.Value : (object)txtPPValuation.Text.TrimEnd().ToUpper())
                .Append("wbi_PPTax", string.IsNullOrEmpty(txtPPTax.Text.TrimEnd()) ? DBNull.Value : (object)txtPPTax.Text.TrimEnd().ToUpper())
                .Append("wbi_PPOCAgent", string.IsNullOrEmpty(txtPPOCAgent.Text.TrimEnd()) ? DBNull.Value : (object)txtPPOCAgent.Text.TrimEnd().ToUpper())
                .Append("wbi_PPOCCarrier", string.IsNullOrEmpty(txtPPOCCarrier.Text.TrimEnd()) ? DBNull.Value : (object)txtPPOCCarrier.Text.TrimEnd().ToUpper())
                .Append("wbi_PPTotal", string.IsNullOrEmpty(txtPPTotal.Text.TrimEnd()) ? DBNull.Value : (object)txtPPTotal.Text.TrimEnd().ToUpper())
                .Append("wbi_CCWeight", string.IsNullOrEmpty(txtCCWeight.Text.TrimEnd()) ? DBNull.Value : (object)txtCCWeight.Text.TrimEnd().ToUpper())
                .Append("wbi_CCValuation", string.IsNullOrEmpty(txtCCValuation.Text.TrimEnd()) ? DBNull.Value : (object)txtCCValuation.Text.TrimEnd().ToUpper())
                .Append("wbi_CCTax", string.IsNullOrEmpty(txtCCTax.Text.TrimEnd()) ? DBNull.Value : (object)txtCCTax.Text.TrimEnd().ToUpper())
                .Append("wbi_CCOCAgent", string.IsNullOrEmpty(txtCCOCAgent.Text.TrimEnd()) ? DBNull.Value : (object)txtCCOCAgent.Text.TrimEnd().ToUpper())
                .Append("wbi_CCOCCarrier", string.IsNullOrEmpty(txtCCOCCarrier.Text.TrimEnd()) ? DBNull.Value : (object)txtCCOCCarrier.Text.TrimEnd().ToUpper())
                .Append("wbi_CCTotal", string.IsNullOrEmpty(txtCCTotal.Text.TrimEnd()) ? DBNull.Value : (object)txtCCTotal.Text.TrimEnd().ToUpper())

                .Append("wbi_Signature1", txtCert.Text.TrimEnd().ToUpper())
                .Append("wbi_Signature2", txtSignature1.Text.TrimEnd().ToUpper())
                //.Append("wbi_SignDate", txtSignDate.Text.TrimEnd())
                .Append("wbi_SignDate", SignDate)
                .Append("wbi_SignStation", txtSignStation.Text.TrimEnd().ToUpper())
                .Append("wbi_SignUser", txtSignUser.Text.TrimEnd().ToUpper())

                .Append("wbi_User", FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper())
                .Append("wbi_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString().ToUpper())
                .Append("wbi_Sys", sys)
                );
            bool resultHawb = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWB_SP", UpdateHAWB).Update();
            List<IFields> UpdateHAWBDetail = new List<IFields>();
            UpdateHAWBDetail.Add(dal.CreateIFields().Append("Option", "Update")
                .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)
                .Append("wbd_Seed", hidSeed.Text)

                .Append("VWT", string.IsNullOrEmpty(txtVWT.Text) ? null : txtVWT.Text)
                .Append("wbd_Item01RCP", string.IsNullOrEmpty(txtRCP1.Text.TrimEnd()) ? DBNull.Value : (object)txtRCP1.Text.TrimEnd())
                .Append("wbd_Item01GWT", string.IsNullOrEmpty(txtGWT1.Text.TrimEnd()) ? DBNull.Value : (object)txtGWT1.Text.TrimEnd())
                .Append("wbd_Item01Unit", txtUnit1.Text.TrimEnd().ToUpper())
                .Append("wbd_Item01RateClass", txtRateClass1.Text.TrimEnd().ToUpper())
                .Append("wbd_Item01Item", txtItem1.Text.TrimEnd().ToUpper())
                .Append("wbd_Item01CWT", string.IsNullOrEmpty(txtCWT1.Text.TrimEnd()) ? DBNull.Value : (object)txtCWT1.Text.TrimEnd().Replace("K", ""))
                .Append("wbd_Item01Rate", string.IsNullOrEmpty(txtRate1.Text.TrimEnd()) ? DBNull.Value : (object)txtRate1.Text.TrimEnd())
                .Append("wbd_Item01Amount", string.IsNullOrEmpty(txtTotal1.Text.TrimEnd()) ? DBNull.Value : (object)txtTotal1.Text.TrimEnd())

                .Append("wbd_Item02Line1", txtLineAll1.Text.ToUpper())
                .Append("wbd_Item03Line1", txtLineAll2.Text.ToUpper())
                .Append("wbd_Item04Line1", txtLineAll3.Text.ToUpper())
                .Append("wbd_Item05Line1", txtLineAll4.Text.ToUpper())
                .Append("wbd_Item06Line1", txtLineAll5.Text.ToUpper())
                .Append("wbd_Item07Line1", txtLineAll6.Text.ToUpper())
                .Append("wbd_Item08Line1", txtLineAll7.Text.ToUpper())
                .Append("wbd_Item09Line1", txtLineAll8.Text.ToUpper())
                .Append("wbd_Item10Line1", txtLineAll9.Text.ToUpper())
                .Append("wbd_Item11Line1", txtLineAll10.Text.ToUpper())
                .Append("wbd_Item12Line1", txtLineAll11.Text.ToUpper())
                .Append("wbd_Item13Line1", txtLineAll12.Text.ToUpper())
                .Append("wbd_Item14Line1", txtLineAll13.Text.ToUpper())

                .Append("wbd_Item01Line3", txtLine1.Text.ToUpper())
                .Append("wbd_Item02Line3", txtLine2.Text.ToUpper())
                .Append("wbd_Item03Line3", txtLine3.Text.ToUpper())
                .Append("wbd_Item04Line3", txtLine4.Text.ToUpper())
                .Append("wbd_Item05Line3", txtLine5.Text.ToUpper())
                .Append("wbd_Item06Line3", txtLine6.Text.ToUpper())
                .Append("wbd_Item07Line3", txtLine7.Text.ToUpper())
                .Append("wbd_Item08Line3", txtLine8.Text.ToUpper())
                .Append("wbd_Item09Line3", txtLine9.Text.ToUpper())
                .Append("wbd_Item10Line3", txtLine10.Text.ToUpper())
                .Append("wbd_Item11Line3", txtLine11.Text.ToUpper())
                .Append("wbd_Item12Line3", txtLine12.Text.ToUpper())
                .Append("wbd_Item13Line3", txtLine13.Text.ToUpper())
                .Append("wbd_Item14Line3", txtLine14.Text.ToUpper())

                .Append("wbd_Otherline1", txtOtherCharges1.Text.TrimEnd().ToUpper())
                .Append("wbd_Otherline2", txtOtherCharges2.Text.TrimEnd().ToUpper())
                .Append("wbd_Otherline3", txtOtherCharges3.Text.TrimEnd().ToUpper())
                .Append("wbd_Otherline4", txtOtherCharges4.Text.TrimEnd().ToUpper())
                .Append("wbd_Otherline5", txtOtherCharges5.Text.TrimEnd().ToUpper())

                .Append("wbd_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("wbd_Sys", sys)
                );
            bool resultHawbDetail = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWBDetail_SP", UpdateHAWBDetail).Update();
            if (resultHawbDetail == true)
            {
                if (txti.Text == "1")
                {
                    if (hidType.Text == "h")
                    {
                        X.AddScript("window.open('../AEReportFile/ReportFile.aspx?type=HAWB&ID=" + hidSeed.Text + "','_blank');");
                    }
                    else
                        X.AddScript("window.open('../AEReportFile/ReportFile.aspx?type=MAWB&ID=" + hidSeed.Text + "','_blank');");

                    txti.Text = "0";
                }

                ControlBinder.pageTitleMsg(false, "Edit " + hidSeed.Text, "<p class=\"success\">Status : Save successfully ! </p>", div_bottom);
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "Edit:" + hidSeed.Text, "<p class=\"error\">Status : Save failed, please check the data !</p>", div_bottom);
            }
        }
        catch
        {
            ControlBinder.pageTitleMsg(false, "Edit:" + hidSeed.Text, "<p class=\"error\">Status : Save failed, please check the data !</p>", div_bottom);
        }
    }
    #endregion

    #region    btnModify_Click()     Author：Hcy   (2011-12-03)
    protected void btnModify_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Prompt("Password", "Please enter your password:").Show();
    }
    #endregion


   
    #region    btnPrint_Click()     Author：Hcy   (2011-12-03)
    protected void btnPrint_Click(object sender, DirectEventArgs e)
    {
        txti.Text = "1";

        if (hidisb.Text=="true")
        {
            if (LockDate.IsLock(hidSeed.Text, ""))
                noSaveprint();
            else
                btnSave_Click(sender, e);
        }
        else
        {
            if (LockDate.IsLock(hidSeed.Text, ""))
                noSaveprint();
            else
                X.AddScript("Ext.Msg.confirm('Status',' This record is not saved ! Do you want to save before print ? ',function(btn){if(btn=='yes'){#{windowconfirm}.show();} else{CompanyX.noSaveprint();} })");
        }
    }




    [DirectMethod]
    public void noSaveprint()
    {
        //X.Msg.Confirm("Status", "", new JFunction() { Handler = "ShowInput(o);" }).Show();
        if (hidType.Text == "h")
            X.AddScript("window.open('../AEReportFile/ReportFile.aspx?type=HAWB&ID=" + hidSeed.Text + "','_blank');");
        else
            X.AddScript("window.open('../AEReportFile/ReportFile.aspx?type=MAWB&ID=" + hidSeed.Text + "','_blank');");
    }

    



    #endregion

    #region    btnMan_Click()     Author：Hcy   (2011-12-03)
    protected void btnMan_Click(object sender, DirectEventArgs e)
    {
        if (hidType.Text == "h")
        {
            X.AddScript("CompanyX.ShowManifestDetail();");
        }
    }
    #endregion


    protected void chkShowInManifest_Check(object sender, DirectEventArgs e)
    {
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "[FW_AirExport_HAWB_SP]", new List<IFields>() { dal.CreateIFields().
                Append("Option", "UpdateManifest").
                Append("wbi_XManifest",chkShowInManifest1.Text).
                Append("Wbi_Seed",hidSeed.Text)}).Update();
    }


    [DirectMethod]
    public void ShowDimension()
    {
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetList")
            .Append("wd_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            );
        DataSet ds = GetDs("FW_AirExport_AWBDimension_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            int line = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_DIMLineStart"].ToString()) ? 0 : Convert.ToInt32(ds.Tables[0].Rows[0]["wbi_DIMLineStart"]);


            startLine.Text = line.ToString();
            startcount.Text = ds.Tables[0].Rows[0]["wbi_DIMStart"].ToString();

        }

        var win = new Window
        {

            ID = "winShow",
            Constrain = true,
            Modal = false,
            BodyStyle = "background-color: #fff;",
            Padding = 0,
            Resizable = false,
            Draggable = true,
            Width = Unit.Pixel(400),
            Height = Unit.Pixel(310)

        };
        win.Closable = false;
        win.AutoLoad.Url = "Dimensions.aspx?seed=" + hidSeed.Text;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Listeners.Hide.Handler = "CompanyX.SetLineValue();";
        win.Render();
        win.Show();
    }

    [DirectMethod]
    public void ShowOtherChargs()
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
            Width = Unit.Pixel(320),
            Height = Unit.Pixel(300)

        };
        win.Closable = false;
        win.AutoLoad.Url = "OtherCharges.aspx?seed=" + hidSeed.Text + "&currency=" + txtCurrency.Text;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Listeners.Hide.Handler = "CompanyX.SetOtherChargesValue();";
        win.Render();
        win.Show();
    }

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
            Closable = false,
            Width = Unit.Pixel(960),
            Height = Unit.Pixel(510)

        };
        win.AutoLoad.Url = "ManifestDetail.aspx?seed=" + hidSeed.Text;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Render();
        win.Show();
    }
    [DirectMethod]
    public void CheckPass(string text)
    {
        if (text == "123")
        {
            btnSave.Show();
        }
    }

    [DirectMethod]
    public void ShowDescription()
    {


        var win = new Window
        {
            ID = "Window1",
            Title = "Description for Manifest",
            Resizable = false,
            Draggable = true,
            //AnimateTarget = "btnDescription",  //--- 此效果会有点卡
            Width = 416, // 417,
            Height = 208, // 561,
            Modal = false,
            Padding = 0,
            CloseAction = CloseAction.Close
        };

        win.AutoLoad.Url = "Description.aspx";
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Listeners.Close.Handler = "if(Window1_IFrame.getText()!=''){DescriptionColor('Y');}else{DescriptionColor('N');} #{txtDescriptionhide}.setValue(Window1_IFrame.getText());";
        win.Render();
        win.Show();
    }

    [DirectMethod]
    public void ShowMark(string isIE8)
    {
        string seed = hidSeed.Text == "" ? null : hidSeed.Text;
        string url = "/AirExport/AEHAWB/Mark.aspx?seed=" + seed + "&Type=" + hidType.Text;

        int width = 718;//isIE8=="true" ? 970 : 945;
        //X.AddScript("alert("+browser.ToUpper() + "," + version + "," + width+");");
        var win = new Window
        {
            ID = "WindowMark",
            Title = "Marks",
            Resizable = false,
            Draggable = true,
            //AnimateTarget = "btnDescription",  //--- 此效果会有点卡
            Width = width, // 417,
            Height = 280, // 561,
            Modal = false,
            Padding = 0,
            Closable = false
        };

        win.AutoLoad.Url = url;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Listeners.Close.Handler = "window.parent.window.document.body.style.overflow = 'auto';";
        win.Render();
        win.Show();


        //X.AddScript("ExtWindow.CreateWin({id:'WindowMark',title:'Marks',X:0,Y:160,width:980,height:330,shadow:false,url:'" + url + "'});");
    }

    [DirectMethod]
    public void SetInfo(string typename, string code)
    {
        DataSet dsCom = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWB_SP", new List<IFields>() { dal.CreateIFields().
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
                txtShipper5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                //ShowShipperSign
                if (hidShowShipperFlag.Text == "1")
                {
                    txtCert.Text = txtShipper1.Text;
                }
            }
            else if (typename == "CmbConsigneeCode")
            {
                txtConsignee1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtConsignee2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtConsignee3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                txtConsignee4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                txtConsignee5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
            }
            else if (typename == "CmbParty1")
            {
                txtPartyA1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtPartyA2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtPartyA3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                TextField1.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                TextField2.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
            }
            else if (typename == "CmbParty2")
            {
                txtPartyB1.Text = dsCom.Tables[0].Rows[0]["co_Name"].ToString();
                txtPartyB2.Text = dsCom.Tables[0].Rows[0]["co_Address1"].ToString();
                txtPartyB3.Text = dsCom.Tables[0].Rows[0]["co_Address2"].ToString();
                txtPartyB4.Text = dsCom.Tables[0].Rows[0]["co_Address3"].ToString();
                txtPartyB5.Text = dsCom.Tables[0].Rows[0]["co_Address4"].ToString();
                txtPartyB6.Text = dsCom.Tables[0].Rows[0]["co_Contact"].ToString();
                txtPartyB7.Text = dsCom.Tables[0].Rows[0]["co_Phone"].ToString();
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
                txtShipper5.Text = "";
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
                TextField2.Text = "";
                TextField1.Text = "";
            }
            else if (typename == "CmbParty2")
            {
                txtPartyB1.Text = "";
                txtPartyB2.Text = "";
                txtPartyB3.Text = "";
                txtPartyB4.Text = "";
                txtPartyB5.Text = "";
                txtPartyB6.Text = "";
                txtPartyB7.Text = "";
            }
        }
    }

    /// 全局变量
    public string DIM = string.IsNullOrEmpty(FSecurityHelper.CurrentUserDataGET()[19]) ? "M" : FSecurityHelper.CurrentUserDataGET()[19].ToUpper();      // 获取 计算单位
    public string FLOAT = FSecurityHelper.CurrentUserDataGET()[20];    // 获取保留小数位

    //给TOTAL OTHER CHARGES赋值 GRACE
    public void SetTotalOther(bool i, bool o)
    {
        if (i == false && o == false)
        {
            if (txtOtherPPD.Text.ToUpper() == "P")
            {
                txtPPOCAgent.Text = hidAgentCount.Text;
                txtPPOCCarrier.Text = hidCarrierCount.Text;
                txtCCOCAgent.Text = "";
                txtCCOCCarrier.Text = "";

            }
            else if (txtOtherColl.Text.ToUpper() == "C")
            {
                txtCCOCAgent.Text = hidAgentCount.Text;
                txtCCOCCarrier.Text = hidCarrierCount.Text;
                txtPPOCAgent.Text = "";
                txtPPOCCarrier.Text = "";
            }
        }
        else if (i == true && o == false)
        {
            if (txtOtherPPD.Text.ToUpper() == "P")
            {
                txtPPOCAgent.Text = hidAgentCount.Text;
                txtPPOCCarrier.Text = hidCarrierCount.Text;
                txtCCOCAgent.Text = "";
                txtCCOCCarrier.Text = "";

            }
            else if (txtOtherColl.Text.ToUpper() == "C")
            {

                txtCCOCAgent.Text = hidAgentCount.Text;
                txtCCOCCarrier.Text = hidCarrierCount.Text;
                txtPPOCAgent.Text = "";
                txtPPOCCarrier.Text = "";
            }
        }
        else if (i == false && o == true)
        {
            if (txtOtherPPD.Text.ToUpper() == "P")
            {
                txtCCOCAgent.Text = "";
                txtPPOCCarrier.Text = hidCarrierCount.Text;
                txtCCOCCarrier.Text = "";

            }
            else if (txtOtherColl.Text.ToUpper() == "C")
            {
                //txtCCWeight.setValue(txtTotal1.getValue());

                txtPPOCAgent.Text = "";
                txtPPOCCarrier.Text = "";
                txtCCOCCarrier.Text = hidCarrierCount.Text;
            }

        }
    }

    //给OTHER CHARGES赋值 GRACE
    [DirectMethod]
    public void SetOtherChargesValue()
    {

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AWBOther_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "BindList")
                   .Append("ao_seed", hidSeed.Text=="0"?(object)DBNull.Value:(object)hidSeed.Text) 
        }).GetList();


        //int len = 0;//列宽：dt中<=56 / 2的最大的长度
        //for (int i = 0; i < dt.Rows.Count; i++)
        //{
        //    string str = dt.Rows[i]["Item"].ToString() + ":" + string.Format("{0:F2}", dt.Rows[i]["Amount"]) + "  ";//2个字符间隔
        //    if (str.Length <= 48 / 2 && str.Length > len)
        //    {
        //        len = str.Length;
        //    }
        //}

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            hidAgentCount.Text = ds.Tables[0].Rows[0]["AgentCount"].ToString();
            hidCarrierCount.Text = ds.Tables[0].Rows[0]["CarrierCount"].ToString();
            SetTotalOther(chkItem.Checked, chkOther.Checked);

            int len = 0;//列宽：dt中<=56 / 2的最大的长度
            if (ds.Tables[1].Rows.Count > 0)
            {
                len = Convert.ToInt32(ds.Tables[1].Rows[0]["MaxL"]);
            }
            string[] v = new string[5];//行数：可显示的文本框个数
            int n = 0;
            string list = "";
            string chargeTo = "";//分类
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (i == 0)
                {
                    chargeTo = ds.Tables[0].Rows[i]["ChargeTo"].ToString();

                }
                string str = ds.Tables[0].Rows[i]["Item"].ToString() + ":" + string.Format("{0:F2}", ds.Tables[0].Rows[i]["Amount"]) + "  ";//2个字符间隔
                if (str.Length > 56 / 2)
                {//单独占一行
                    if (list != "")
                    {
                        v[n++] = list;//.TrimEnd(' ');//赋值
                        list = "";//清空
                    }

                    v[n++] = str;//赋值
                }
                else if (str.Length < 56 / 2)
                {
                    if ((list + str).Length > 56 || chargeTo != ds.Tables[0].Rows[i]["ChargeTo"].ToString()) //(list + str).TrimEnd(' ').Length > 56
                    {
                        if (list != "")
                        {
                            v[n++] = list;//.TrimEnd(' ');//赋值
                            list = "";//清空
                        }
                        chargeTo = ds.Tables[0].Rows[i]["ChargeTo"].ToString();
                    }

                    list = list + str.PadRight(len, ' ');
                }

                if (n == v.Length)
                {
                    break;
                }
            }
            if (n < v.Length)
            {
                v[n++] = list;//.TrimEnd(' ');//赋值
                list = "";//清空
            }

            for (int j = 0; j < v.Length; j++)
            {
                TextField txt = X.GetCmp("txtOtherCharges" + (1 + j)) as TextField;
                txt.Clear();
                txt.Text = v[j];
            }

        }

        X.AddScript("TotalPP();TotalCC();");

    }

    [DirectMethod]
    public void SetLineValue()
    {

        ArrayList list = new ArrayList();
        double sum = 0.0;
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetList")
            .Append("wd_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            );
        DataSet ds = GetDs("FW_AirExport_AWBDimension_SP", Getlist);

        int line = 0;
        double rate = 0.0;
        double cm3 = 0.0;
        int dimDigit = 1;
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            line = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_DIMLineStart"].ToString()) ? 0 : Convert.ToInt32(ds.Tables[0].Rows[0]["wbi_DIMLineStart"]);
            rate = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_DIMRate"].ToString()) ? 0.0 : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_DIMRate"]);
            cm3 = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_DIMCM3"].ToString()) ? 0.0 : Convert.ToDouble(ds.Tables[0].Rows[0]["wbi_DIMCM3"]);
            dimDigit = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_DIMDigit"].ToString()) ? 0 : Convert.ToInt32(ds.Tables[0].Rows[0]["wbi_DIMDigit"]);
        }

        if (rate <= 0)
            return;

        if (!string.IsNullOrEmpty(cm3.ToString()) && cm3 != 0.0)
        {
            sum = cm3;
            list.Add(sumTotal(sum, rate).ToString());
        }
        else if (ds != null && ds.Tables[1].Rows.Count > 0 && rate > 0)
        {
            if (!string.IsNullOrEmpty(ds.Tables[1].Rows[0]["Seed"].ToString()))
            {
                for (int i = 0; i < ds.Tables[1].Rows.Count; ++i)
                {
                    //list.Add(ds.Tables[1].Rows[i]["L"] + "*" + ds.Tables[1].Rows[i]["w"] + "*" + ds.Tables[1].Rows[i]["h"] + "CM/" + ds.Tables[1].Rows[i]["Pieces"]);
                    list.Add(GetDimDigit(dimDigit, ds.Tables[1].Rows[i]["L"].ToString(), ds.Tables[1].Rows[i]["w"].ToString(), ds.Tables[1].Rows[i]["h"].ToString(), ds.Tables[1].Rows[i]["Pieces"].ToString()));
                    sum += Convert.ToDouble(ds.Tables[1].Rows[i]["CM3"]);
                }

                list.Add(sumTotal(sum, rate).ToString());
            }
        }

        else
        {
            if (string.IsNullOrEmpty(txtGWT1.Text))
                txtCWT1.Clear();
            else
                txtCWT1.Text = txtGWT1.Text;
        }

        //read data
        //SelectLineValue(line, info);
        //double c = string.IsNullOrEmpty(txtCWT1.Text) ? 0 : Convert.ToDouble(txtCWT1.Text);
        //double r = string.IsNullOrEmpty(txtRate1.Text) ? 0 : Convert.ToDouble(txtRate1.Text);
        //txtTotal1.Text = Math.Round(c * r, 2).ToString("0.00");

        SetRate();

        if (!string.IsNullOrEmpty(txtWTPPD.Text))
        {
            txtPPWeight.Text = txtTotal1.Text;
            txtCCWeight.Clear();
            X.AddScript("TotalCC();TotalPP();");
        }
        else if (!string.IsNullOrEmpty(txtWTColl.Text))
        {
            txtCCWeight.Text = txtTotal1.Text;
            txtPPWeight.Clear();
            X.AddScript("TotalCC();TotalPP();");
        }
        else
        {
            txtCCWeight.Clear();
            txtCCWeight.Clear();
        }

        SelectLineValue(line, list);



    }

    //处理小数位
    private string GetDimDigit(int digit,string l,string w,string h,string p)
    {
        string str = "";
        
        double l1 = Convert.ToDouble(l);
        double w1 = Convert.ToDouble(w);
        double h1 = Convert.ToDouble(h);
        if (digit == 1)
        {
            str = l1.ToString("0.0") + "*" + w1.ToString("0.0") + "*" + h1.ToString("0.0") + "CM/" + p;
            if (str.Length > 24)
            {
                str = (l1.ToString("0.0").EndsWith(".0") ? l1.ToString("0.0").Replace(".0", "") : l1.ToString("0.0")) + "*"
                      + (w1.ToString("0.0").EndsWith(".0") ? w1.ToString("0.0").Replace(".0", "") : w1.ToString("0.0")) + "*"
                      + (h1.ToString("0.0").EndsWith(".0") ? h1.ToString("0.0").Replace(".0", "") : h1.ToString("0.0")) + "CM/" + p;
            }
        }
        else
        {
            str = l1.ToString("0.00") + "*" + w1.ToString("0.00") + "*" + h1.ToString("0.00") + "CM/" + p;
            if (str.Length > 24)
            {
                str = (l1.ToString("0.00").EndsWith("0") ? l1.ToString("0.00").Remove(l1.ToString("0.00").Length-1) : l1.ToString("0.00")) + "*"
                      + (w1.ToString("0.00").EndsWith("0") ? w1.ToString("0.00").Remove(w1.ToString("0.00").Length - 1) : w1.ToString("0.00")) + "*"
                      + (h1.ToString("0.00").EndsWith("0") ? h1.ToString("0.00").Remove(h1.ToString("0.00").Length - 1) : h1.ToString("0.00")) + "CM/" + p;
            }
        }
        
        return str;
    }

    ///  清除TextBox的值
    public void ClearText()
    {

        int startCount = string.IsNullOrEmpty(startcount.Text) ? 0 : Convert.ToInt32(startcount.Text);
        int startline = string.IsNullOrEmpty(startLine.Text) ? 0 : Convert.ToInt32(startLine.Text);

        if (startline != 0)
        {
            for (int i = 0; i < startCount + 1; ++i)
            {
                if (startline + i > 14)
                    return;
                TextField txt = X.GetCmp("txtLine" + (startline + i)) as TextField;
                
                txt.Clear();
            }
        }
    }


    private void SelectLineValue(int line, ArrayList str)
    {
        ClearText();
        if (str == null) return;
        int count = str.Count;
        if (14 - line + 1 >= count)
        {
            for (int i = 0; i < count; ++i)
            {
                TextField txt = X.GetCmp("txtLine" + (line + i)) as TextField;

                if (DIM == "CM" && string.IsNullOrEmpty(FLOAT) && i == count - 1)
                    break;

                if (i == 0)
                {
                    txt.Text = "DIM:" + str[i].ToString();
                }
                else
                    txt.Text = "    " + str[i].ToString();
            }
        }
        else
        {
            TextField txt = Page.FindControl("txtLine" + line) as TextField;
            txt.Text = "DIM:" + str[count - 1].ToString();
        }
    }



    /// <summary>
    /// 处理计算
    /// </summary>
    /// <param name="total">cm3或total</param>
    /// <param name="rate">rate</param>
    /// <returns></returns>
    public string sumTotal(double total, double rate)
    {
        double Total = 0.0;
        string dim = DIM;  // 计算的单位 M , CM
        int d = string.IsNullOrEmpty(FLOAT) ? 0 : Convert.ToInt32(FLOAT);        // 保留的小数位

        if (dim == "M")
        {
            Total = Math.Round(total / 1000000 + 0.000001, d);
        }
        else
        {
            Total = Math.Round(total + 0.000001, d);
        }

        double cwt = Math.Ceiling(Math.Ceiling(Math.Round(total / rate, 2) * 10) / 10 * 2) / 2;

        cwt = cwt + 0.0001;

        string ss = cwt.ToString().Substring(0, cwt.ToString().LastIndexOf(".") + 2);
        txtVWT.Text = ss;

        double gwt = Convert.ToDouble(string.IsNullOrEmpty(txtGWT1.Text) ? "0" : txtGWT1.Text);

        cwt = cwt > gwt ? cwt : gwt;

        txtCWT1.Text = cwt.ToString("0.000");

        //txtTotal1.Text = (cwt * Convert.ToDouble(string.IsNullOrEmpty(txtRate1.Text) ? "0" : txtRate1.Text)).ToString("0.00");
        txtTotal1.Text = string.IsNullOrEmpty(txtRate1.Text)?"":(cwt * Convert.ToDouble(txtRate1.Text)).ToString("0.00");

        return Total.ToString() + dim + "3";

    }

    [DirectMethod]
    public void SetRate()
    {
        if (chkItem1.Text == "0")
        {
            string type1 = "N", type2 = "N";
            string vwt = "0.000";
            if (txtWTPPD.Text.TrimEnd() == "" && txtWTColl.Text.TrimEnd().ToUpper() == "C")
            {
                type1 = "Y";
            }
            if (txtWTPPD.Text.TrimEnd().ToUpper() == "P" && txtWTColl.Text.TrimEnd() == "")
            {
                type2 = "Y";
            }
            if (type1 == "N" && type2 == "N")
            {
                return;
            }
            else
            {
                if (!string.IsNullOrEmpty(txtGWT1.Text.TrimEnd()) && !string.IsNullOrEmpty(txtCWT1.Text.TrimEnd()))
                {
                    if (Convert.ToDouble(txtGWT1.Text.TrimEnd()) > Convert.ToDouble(txtCWT1.Text.TrimEnd()))
                    {
                        vwt = txtGWT1.Text.TrimEnd();
                    }
                    else
                    {
                        vwt = txtCWT1.Text.TrimEnd();
                    }
                }
                else if (!string.IsNullOrEmpty(txtGWT1.Text.TrimEnd()))
                {
                    vwt = txtGWT1.Text.TrimEnd();
                }
                else if (!string.IsNullOrEmpty(txtCWT1.Text.TrimEnd()))
                {
                    vwt = txtCWT1.Text.TrimEnd();
                }
                
                DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWBRate_SP", new List<IFields> { dal.CreateIFields().Append("Option", "GetRate").Append("air_Seed", hidSeed.Text).Append("CWT", string.IsNullOrEmpty(txtCWT1.Text) ? "0" : txtCWT1.Text)
                .Append("Type1",type1).Append("Type2",type2) }).GetList();
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0][1].ToString() == "Y")
                    {
                        txtRate1.Text = ds.Tables[0].Rows[0][0].ToString();
                        //txtTotal1.Text = Math.Round(Convert.ToDouble(txtCWT1.Text) * Convert.ToDouble(txtRate1.Text), 2).ToString("0.00");
                        txtTotal1.Text = (Convert.ToDouble(txtCWT1.Text) * Convert.ToDouble(txtRate1.Text)).ToString("0.00");
                    }
                } 
            }
        }

    }

}
