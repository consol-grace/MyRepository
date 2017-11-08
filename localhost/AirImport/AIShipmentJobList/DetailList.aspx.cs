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

public partial class AirImport_AIShipmentJobList_DetailList : System.Web.UI.Page
{
    //public string lot = "", mawb = "", content = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!string.IsNullOrEmpty(Request["ID"]))
            {
                string id = Request["ID"];
                if (Request["type"] == "invoice")
                    id = getSeed(id, "getInvoiceSeed");
                else if(Request["type"]=="addInvoice")
                    id = getSeed(id, "getSeed");
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
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipment_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option",type).Append("No",id)}).GetTable();
        if (dt != null && dt.Rows.Count > 0)
            s = dt.Rows[0][0].ToString();
        return s;
    }


    public void binder()
    {
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", "A");
    }

    #region  DataBinder()   Author：Hcy  (2011-10-21)
    void DataBinder(string id)
    {

        if (id.Length > 0)
        {
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipment_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetList").Append("id",id)
            .Append("ChinaMode",FSecurityHelper.CurrentUserDataGET()[25])
            .Append("sys","AI")
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
            
            DataTable dt1 = new DataTable();
            if (hidShowInv.Text == "0")
            {
                if (hidShowVoid.Text == "1")
                {
                    ds.Tables[0].DefaultView.RowFilter = "ai_type<>'LINV' and ai_type<>'FINV'";
                }
                else
                {
                    ds.Tables[0].DefaultView.RowFilter = "ai_type<>'LINV' and ai_type<>'FINV' and (ai_void=0 or air_TransferFrom>0 or air_TransferTo>0)";
                }

            }
            else
            {
                if (hidShowVoid.Text == "0")
                {
                    ds.Tables[0].DefaultView.RowFilter = "ai_void=0 or air_TransferFrom>0 or air_TransferTo>0";
                }
            }
            dt1 = ds.Tables[0].DefaultView.ToTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtDirect.Visible = ds.Tables[0].Rows[0]["Direct"].ToString() == "1" ? true : false;
                txtLotNo.InnerHtml = " <font color='red'>" + ds.Tables[0].Rows[0]["ai_lotno"].ToString() + "</font>";
                txtMawb.InnerHtml = " <font color='red'>" + ds.Tables[0].Rows[0]["ai_mawb"].ToString() + "</font>";
                
            }

            string[] header = { "Status", "Date", "Type", "No.#", "POL/POD", "WT/Piece", "Amount", "Remark", "Action", "<div class='div_all_print' style=\"padding-right:15px;\">Print</div>" };
            string[] field = { "void", "ai_date", "ai_Type", "ai_KeyValue", "ai_POL", "WT", "ai_Currency|ai_Total", "Remark", "Detail", "Print" };
            string msg = "No data";

            txtcontent.InnerHtml = ControlBinder.gridHtml(dt1, header, field, msg);
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
}
