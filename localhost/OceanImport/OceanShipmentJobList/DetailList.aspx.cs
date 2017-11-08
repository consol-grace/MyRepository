﻿using System;
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

public partial class OceanImport_OceanShipmentJobList_DetailList : System.Web.UI.Page
{
    public string lot = "", mbl = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!string.IsNullOrEmpty(Request["ID"]))
            {
                string id = Request["ID"];
                if (Request["type"] == "invoice")
                    id = getSeed(id, "getInvoiceSeed");
                else if (Request["type"] == "addInvoice")
                    id = getSeed(id, "getSeed");
                else if (Request["type"] == "Container")
                    id = getContainerMBL(id);
                hidID.Text = id;
                if (Session["showvoid"] != null)
                {
                    if (Session["showvoid"].ToString() == hidID.Text)
                    {
                        hidShowVoid.Text = "1";
                        chkShowVoid.Checked = true;
                    }
                }
                if (Session["showinv"] != null)
                {
                    if (Session["showinv"].ToString() == hidID.Text)
                    {
                        hidShowInv.Text = "0";
                        chkShowInv.Checked = false;
                    }
                }
                DataBinder(id);
            }
            binder();
        }
    }

    public DataFactory dal = new DataFactory();

    public string getSeed(string id,string type)
    {
        string s = "";
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOI_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option",type).Append("No",id)}).GetTable();
        if (dt != null && dt.Rows.Count > 0)
            s = dt.Rows[0][0].ToString();
        return s;
    }

    public string getContainerMBL(string id)
    {
        string s = "";
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOI_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "getContainerMBL").Append("No",id)}).GetTable();
        if (dt != null && dt.Rows.Count > 0)
            s = dt.Rows[0][0].ToString();
        return s;
    }


    public void binder()
    {
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", "O");
    }

    #region  DataBinder()   Author：Hcy  (2011-10-21)
    void DataBinder(string id)
    {
        if (id.Length > 0)
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOI_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetDetailList")
            .Append("id",id)
            .Append("ChinaMode",FSecurityHelper.CurrentUserDataGET()[25])
            .Append("sys","OI")
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("ShowVoid",hidShowVoid.Text)
            }).GetList();

            DataTable dt1 = new DataTable();
            DataTable dt2 = new DataTable();

            if (hidShowInv.Text == "0")
            {
                ds.Tables[0].DefaultView.RowFilter = "oi_Type<>'LINV' and oi_Type<>'CTNR' and oi_Type<>'FINV'";
            }
            else
            {
                ds.Tables[0].DefaultView.RowFilter = "oi_Type<>'CTNR'";
            }

            dt1 = ds.Tables[0].DefaultView.ToTable();

            dt2 = ds.Tables[1].DefaultView.ToTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtLotNo.InnerHtml = " <font color='red'>" + ds.Tables[0].Rows[0]["oi_lotno"].ToString() + "</font>";
                txtMawb.InnerHtml =" <font color='red'>"+ds.Tables[0].Rows[0]["oi_mbl"].ToString()+"</font>";
                
            }

            string[] header = { "Status", "Date", "Type", "No.#", "POL/POD", "WT/Piece", "Amount", "Remark", "Action", "<div class='div_all_print'>Print</div>" };
            string[] field = {"void", "oi_date", "oi_Type", "oi_KeyValue", "oi_POL", "WT", "oi_Currency|oi_Total","remark", "Detail", "Print" };
            string msg = "No data";

            string[] header_ctnr = { "Status", "Status / S.Mode", "Container No", "WT", "CBM", "PCS", "Remark", "Print" };
            string[] field_r_ctnr_ = { "isvoid", "oi_serMode", "oi_KeyValue", "GWT", "CBM", "PIECE", "remark", "Print" };
            string msg_ctnr = "No data";

            txtContent.InnerHtml = ControlBinder.gridHtml(dt1, header, field, msg);
            txtcontainer.InnerHtml = ControlBinder.gridHtml(dt2, header_ctnr, field_r_ctnr_, msg_ctnr);
        }

    }
    #endregion

    public void btnCancel_Click(object sender, DirectEventArgs e)
    {
        X.AddScript("window.location.reload();");
    }

    [DirectMethod]
    public void ShowVoid()
    {
        if (hidShowVoid.Text == "1")
        {
            Session["showvoid"] = hidID.Text;
        }
        else
        {
            Session["showvoid"] = null;
        }
        X.AddScript("window.location.reload();");
    }
    [DirectMethod]
    public void ShowInv()
    {
        if (hidShowInv.Text == "0")
        {
            Session["showinv"] = hidID.Text;
        }
        else
        {
            Session["showinv"] = null;
        }
        X.AddScript("window.location.reload();");
    }

    [DirectMethod]
    public void ShowOIHBLList(int MBLSeed)
    {
        string url = "/OceanImport/OceanShipmentJobList/OIHBLList.aspx?seed=" + MBLSeed;
        X.AddScript("window.parent.top.ExtWindow.CreateWin({id:'winHblList',title:'Transhipment',X:100,Y:160,width:815,height:300,url:'" + url + "'});");
    }
}
