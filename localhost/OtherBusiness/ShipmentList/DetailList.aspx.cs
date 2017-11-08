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

public partial class OceanExport_OEJobList_DetailList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!string.IsNullOrEmpty(Request["ID"]))
            {
                string id = Request["ID"];
                if (Request["type"] == "invoice")
                    id = getSeed(id, "invoice");
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

    DataFactory dal = new DataFactory();

    public string getSeed(string id, string type)
    {
        string s = "";
        if (type.ToUpper() == "INVOICE")
            type = "getInvoiceSeed";

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOT_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option",type).Append("No",id)}).GetTable();
        if (dt != null && dt.Rows.Count > 0)
            s = dt.Rows[0][0].ToString();
        return s;
    }

    public void binder()
    {
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", "O");
    }

    public void btnCancel_Click(object sender, DirectEventArgs e)
    {
        X.AddScript("window.location.reload();");
    }

    #region  DataBinder()   Author：Hcy  (2011-10-21)
    void DataBinder(string id)
    {
        if (id.Length > 0)
        {
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOT_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetDetailList").Append("id",id).Append("ChinaMode",FSecurityHelper.CurrentUserDataGET()[25])
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])}).GetList();

            DataTable dt1 = new DataTable();
            if (hidShowInv.Text == "0")
            {
                if (hidShowVoid.Text == "1")
                {
                    ds.Tables[0].DefaultView.RowFilter = "type<>'LINV'";
                }
                else
                {
                    ds.Tables[0].DefaultView.RowFilter = "type<>'LINV' and (tr_void=0 or tri_TransferFrom>0 or tri_TransferTo>0)";
                }

            }
            else
            {
                if (hidShowVoid.Text == "0")
                {
                    ds.Tables[0].DefaultView.RowFilter = "ot_void=0 or tri_TransferFrom>0 or tri_TransferTo>0";
                }
            }
            dt1 = ds.Tables[0].DefaultView.ToTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtLotNo.InnerHtml = "<font color='red'>  " + ds.Tables[0].Rows[0]["lotno"].ToString() + "</font>";
                txtMawb.InnerHtml = "<font color='red'>  " + ds.Tables[0].Rows[0]["mbl"].ToString() + "</font>";
            }
            string[] header = { "Status", "Date", "Type", "No.#", "POL/POD", "WT/Piece", "Amount", "Remark", "Action", "Print" };
            string[] field = { "void", "date", "type", "KeyValue", "POL", "WT", "currency|Total", "remark", "Detail", "Print" };
            string msg = "No data";

            txtcontent.InnerHtml = ControlBinder.gridHtml(dt1, header, field, msg);

        }

    }
    #endregion

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
}
