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

public partial class AirImport_AIShipmentJobList_CallShipment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            TextHelper tp = new TextHelper();
            string sys = Request["sys"] == null ? "" : Request["sys"];
            txtLot.Text = tp.getPre(sys);
            txtInvoice.Text = tp.getPre(sys);

            txtLot.Focus();
            tp.SetFocusAtLast("txtLot");
            if (!string.IsNullOrEmpty(Request["ID"]))
            {
                Window1.Hide();
                string id = Request["ID"];
                //DataBinder(id);
            }
        }
    }

    #region  DataBinder()   Author：Hcy  (2011-10-21)
    void DataBinder(string id)
    {
        if (id.Length>0)
        {
            //Window2.Show();
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipment_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetList").Append("id",id).Append("sys",FSecurityHelper.CurrentUserDataGET()[11])
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])}).GetList();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                //lblShow.Text = "Lot No# " + ds.Tables[0].Rows[0]["ai_lotno"].ToString() + "   MAWB# " + ds.Tables[0].Rows[0]["ai_mawb"].ToString(); 
                //GridPanelList.GetStore().DataSource = ds.Tables[0];
                //GridPanelList.GetStore().DataBind();
            }
        }
        else
        {
            //Window2.Hide();
        }

    }
    #endregion

    protected void btnDetail_Click(object sender, EventArgs e)
    {
        if (rdLot.Checked)
        {
            if (txtLot.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "Lot No. can't be empty ").Show();
                return;
            }
        }
        else if (rdMawb.Checked)
        {
            if (txtMawb.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "MAWB can't be empty ").Show();
                return;
            }
        }
        else if (rdHawb.Checked)
        {
            if (txtHawb.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "HAWB can't be empty ").Show();
                return;
            }
        }
        else if (rdInvoice.Checked)
        {
            if (txtInvoice.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "Invoice can't be empty ").Show();
                return;
            }
        }
        DataSet ds = GetDs();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            string id = ds.Tables[0].Rows[0][0].ToString();
            string par = ds.Tables[0].Rows[0][2].ToString();
            string type = ds.Tables[0].Rows[0][1].ToString();
            if (type == "Hawb")
            {
                //Response.Redirect("hawb.aspx?MAWB=" + id + "&seed=" + par);
                X.AddScript("window.open('hawb.aspx?MAWB=" + id + "&seed=" + par + "');");
            }
            else if (type == "LotNo" || type == "Mawb")
            {
                //Response.Redirect("mawb.aspx?seed=" + id);
                X.AddScript("window.open('mawb.aspx?seed=" + id +"');");
            }
            else 
            {
                X.AddScript("window.open('../../AirImport/AIShipmentJobList/invoice.aspx?sys=AI&FL=" + type + "&seed=" + par + "');");
            }

        }
        else
        {
            X.Msg.Alert("Information", "Search no data!").Show();
        }

    }

    private DataSet GetDs()
    {
        DataSet ds = null;
        string No = "", type = "";
        if (rdLot.Checked)
        {
            No = txtLot.Text.Trim();
            type = "LOTNO";
        }
        else if (rdMawb.Checked)
        {
            No = txtMawb.Text.Trim();
            type = "MAWB";
        }
        else if (rdHawb.Checked)
        {
            No = txtHawb.Text.Trim();
            type = "HAWB";
        }
        else if (rdInvoice.Checked)
        {
            No = txtInvoice.Text.Trim();
            type = "INVOICE";
        }
        DataFactory dal = new DataFactory();
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipment_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetID").Append("Type",type).Append("No",No)
            .Append("sys",FSecurityHelper.CurrentUserDataGET()[11])
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        return ds;

    }

    protected void btnLotlist_Click(object sender, EventArgs e)
    {

        if (rdLot.Checked)
        {
            if (txtLot.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "Lot No. can't be empty ").Show();
                return;
            }
        }
        else if (rdMawb.Checked)
        {
            if (txtMawb.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "MAWB can't be empty ").Show();
                return;
            }
        }
        else if (rdHawb.Checked)
        {
            if (txtHawb.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "HAWB can't be empty ").Show();
                return;
            }
        }
        else if (rdInvoice.Checked)
        {
            if (txtInvoice.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "Invoice can't be empty ").Show();
                return;
            }
        }
        DataSet ds = GetDs();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            string id = ds.Tables[0].Rows[0][0].ToString();
            string url =Request.Url.AbsoluteUri.Substring(0,Request.Url.AbsoluteUri.LastIndexOf("/"))+"/DetailList.aspx?ID=" + id;
            //Window2.Reload();
            //Window2.Render();
            //Window2.Show();
            X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");
        }
        else
        {
            X.Msg.Alert("Information", "Search no data!").Show();
        }
    }

    [DirectMethod]
    public void Check(string type)
    {
        if (type == "rdLot")
        {
            rdLot.Checked = true;
            rdMawb.Checked = false;
            rdHawb.Checked = false;
            rdInvoice.Checked = false;
            
        }
        else if (type == "rdMawb")
        {
            rdLot.Checked = false;
            rdMawb.Checked = true;
            rdHawb.Checked = false;
            rdInvoice.Checked = false;
        }
        else if (type == "rdHawb")
        {
            rdLot.Checked = false;
            rdMawb.Checked = false;
            rdHawb.Checked = true;
            rdInvoice.Checked = false;
        }
        else if (type == "rdInvoice")
        {
            rdLot.Checked = false;
            rdMawb.Checked = false;
            rdHawb.Checked = false;
            rdInvoice.Checked = true;
        }
    }
}
