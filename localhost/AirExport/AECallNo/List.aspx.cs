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

public partial class AirExport_AECallNo_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TextHelper tp = new TextHelper();
            string sys = Request["sys"] == null ? "" : Request["sys"];
            string textPre = tp.getPre(sys);
            txtLot.Text = textPre;
            txtBKNo.Text = textPre;
            txtInvoice.Text = textPre;
            tp.SetFocusAtLast("txtLot");

            if (!string.IsNullOrEmpty(Request["ID"]))
            {
                Window1.Hide();
                string id = Request["ID"];
                DataBinder(id);
            }
        }
    }
    #region  DataBinder()   Author：Hcy  (2012-01-06)
    void DataBinder(string id)
    {
        if (id.Length > 0)
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForAE_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetList").Append("id",id).Append("sys",FSecurityHelper.CurrentUserDataGET()[11])
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])}).GetList();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                //lblShow.Text = "Lot No# " + ds.Tables[0].Rows[0]["ae_lotno"].ToString() + "   MAWB# " + ds.Tables[0].Rows[0]["ae_mawb"].ToString();
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
        else if (rdBKNo.Checked)
        {
            if (txtBKNo.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "BK No. can't be empty ").Show();
                return;
            }
        }

        DataSet ds = GetDs();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            string id = ds.Tables[0].Rows[0][0].ToString();
            string par = ds.Tables[0].Rows[0][2].ToString();
            string type = ds.Tables[0].Rows[0][3].ToString();
            if (rdLot.Checked)
            {
                if (type == "0")
                {
                    X.AddScript("window.open('../AEConsolAndDirect/List.aspx?type=c&seed=" + id + "');");
                }
                else if (type == "1")
                {
                    X.AddScript("window.open('../AEColoaderDirect/List.aspx?seed=" + id + "');");
                }
                else if (type == "2")
                {
                    X.AddScript("window.open('../AEConsolAndDirect/List.aspx?type=d&seed=" + id + "');");
                }
                else if (type == "6")
                {
                    X.AddScript("window.open('../AEDirectMAWB/List.aspx?seed=" + id + "');");
                }

            }
            else if (rdMawb.Checked)
            {
                if (type == "0")
                {
                    X.AddScript("window.open('../AEHAWB/List.aspx?type=m&MAWB="+id+"&seed=" + id + "');"); 
                }
                else if (type == "1")
                {
                    X.AddScript("window.open('../AEHAWB/List.aspx?type=m&MAWB=" + id + "&seed=" + id + "');"); 
                }
                else if (type == "2")
                {
                    X.AddScript("window.open('../AEHAWB/List.aspx?type=m&MAWB=" + id + "&seed=" + id + "');"); 
                }
                else if (type == "6")
                {
                    X.AddScript("window.open('../AEHAWB/List.aspx?type=m&MAWB=" + id + "&seed=" + id + "');"); 
                }
            }
            else if (rdHawb.Checked)
            {
                if (type == "3")
                {
                    X.AddScript("window.open('../AEHAWB/List.aspx?type=h&MAWB=" + id + "&seed=" + par + "');"); 
                }
                else if (type == "4")
                {
                    X.AddScript("window.open('../AEHAWB/List.aspx?type=h&MAWB=" + id + "&seed=" + par + "');"); 
                }
                else if (type == "5")
                {
                    X.AddScript("window.open('../AEHAWB/List.aspx?type=h&MAWB=" + id + "&seed=" + par + "');"); 
                }
            }
            else if(rdBKNo.Checked)
            {
                if (type == "3")
                {
                    X.AddScript("window.open('../AEShipAndColIn/List.aspx?type=s&MAWB=" + id + "&seed=" + par + "');");
                }
                else if (type == "4")
                {
                    X.AddScript("window.open('../AEShipAndColIn/List.aspx?type=i&MAWB=" + id + "&seed=" + par + "');");
                }
                else if (type == "5")
                {
                    X.AddScript("window.open('../AESubShipment/List.aspx?MAWB=" + id + "&seed=" + par + "');");
                }
            }
            else if (rdInvoice.Checked)
            {
                X.AddScript("window.open('../../AirImport/AIShipmentJobList/invoice.aspx?sys=AE&FL="+type+"&seed=" + par + "');");
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
        else if (rdBKNo.Checked)
        {
            No = txtBKNo.Text.Trim();
            type = "BKNO";
        }

        DataFactory dal = new DataFactory();
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForAE_SP", new List<IFields>() { dal.CreateIFields()
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
        else if (rdBKNo.Checked)
        {
            if (txtBKNo.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "BK No. can't be empty ").Show();
                return;
            }
        }
        DataSet ds = GetDs();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
           
            string id = ds.Tables[0].Rows[0][0].ToString();
            if (id == "" || id == "0" || id == "-1")
            {
                X.Msg.Alert("Information", "Search no data!").Show();
            }
            else
            {
                string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/../AEViewConsol/DetailList.aspx?ID=" + id;
                //Window2.Reload();
                //Window2.Render();
                //Window2.Show();
                X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");
            }

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
        else if (type == "rdBKNo")
        {
            rdLot.Checked = false;
            rdMawb.Checked = false;
            rdHawb.Checked = false;
            rdInvoice.Checked = false;
            rdBKNo.Checked = true;

        }
    }
}
