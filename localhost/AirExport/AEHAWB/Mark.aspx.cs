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

public partial class AirExport_AEHAWB_Mark : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"];
            hidType.Text = Request["type"];

            //BindData();
        }
    }

    //public void BindData()
    //{
    //    List<IFields> list = new List<IFields>();
    //    list.Add(dal.CreateIFields().Append("Option", "GetHAWB")
    //      .Append("seed", hidSeed.Text == "" ? null : hidSeed.Text)
    //      .Append("Type", hidType.Text)
    //      .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
    //      .Append("wbi_SignUser", FSecurityHelper.CurrentUserDataGET()[2])
    //      );

    //    DataSet dsAllInfo = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWB_SP", list).GetList();
    //    if (dsAllInfo != null && dsAllInfo.Tables[0].Rows.Count > 0)
    //    {
    //        //txtRCP1.Text = dsAllInfo.Tables[1].Rows[0]["wbd_Item01RCP"].ToString();
    //        //txtGWT1.Text = dsAllInfo.Tables[1].Rows[0]["wbd_Item01GWT"].ToString();
    //        //txtUnit1.Text = dsAllInfo.Tables[1].Rows[0]["wbd_Item01Unit"].ToString();
    //        //txtRateClass1.Text = dsAllInfo.Tables[1].Rows[0]["wbd_Item01RateClass"].ToString();
    //        //txtItem1.Text = dsAllInfo.Tables[1].Rows[0]["wbd_Item01Item"].ToString();
    //        //txtCWT1.Text = dsAllInfo.Tables[1].Rows[0]["wbd_Item01CWT"].ToString();
    //        //txtVWT.Text = dsAllInfo.Tables[0].Rows[0]["wbi_VWT"].ToString();
    //        //txtRate1.Text = dsAllInfo.Tables[1].Rows[0]["wbd_Item01Rate"].ToString();
    //        //txtTotal1.Text = string.IsNullOrEmpty(dsAllInfo.Tables[1].Rows[0]["wbd_Item01Amount"].ToString()) ? "" : Convert.ToDouble(dsAllInfo.Tables[1].Rows[0]["wbd_Item01Amount"]).ToString("0.00");

    //        //hidItem.Text = Convert.ToBoolean(dsAllInfo.Tables[0].Rows[0]["showItem"].ToString()) ? "1" : "0";
    //        //hidWTPPD.Text = dsAllInfo.Tables[0].Rows[0]["wbi_PPWT"].ToString();
    //        //hidWTColl.Text = dsAllInfo.Tables[0].Rows[0]["wbi_CCWT"].ToString();
    //    }
    //}

    [DirectMethod]
    public void SetStrLineAll()
    {
       txtLineAll.Text= ControlBinder.GetMakeStr(txtLineAll.Text.TrimEnd().ToUpper(), 61);
    }

    [DirectMethod]
    public void SetStrLine()
    {
        txtLine.Text = ControlBinder.GetMakeStr(txtLine.Text.TrimEnd().ToUpper(), 28);
    }

    [DirectMethod]
    public void SetRateMark(string chkItem, string txtWTPPD, string txtWTColl)
    {

        if (chkItem == "0")
        {
            string type1 = "N", type2 = "N";
            string vwt = "0.000";
            if (txtWTPPD.TrimEnd() == "" && txtWTColl.TrimEnd().ToUpper() == "C")
            {
                type1 = "Y";
            }
            if (txtWTPPD.TrimEnd().ToUpper() == "P" && txtWTColl.TrimEnd() == "")
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

                DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_HAWBRate_SP", new List<IFields> { dal.CreateIFields().Append("Option", "GetRate")
                .Append("air_Seed", hidSeed.Text)
                .Append("CWT", string.IsNullOrEmpty(txtCWT1.Text) ? "0" : txtCWT1.Text)
                .Append("Type1",type1).Append("Type2",type2) }).GetList();
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0][1].ToString() == "Y")
                    {
                        txtRate1.Text = ds.Tables[0].Rows[0][0].ToString();
                        txtTotal1.Text = Math.Round(Convert.ToDouble(txtCWT1.Text) * Convert.ToDouble(txtRate1.Text), 2).ToString("0.00");
                        txtTotal1.Text = (Convert.ToDouble(txtCWT1.Text) * Convert.ToDouble(txtRate1.Text)).ToString("0.00");
                    }
                }
            }
        }

    }
}