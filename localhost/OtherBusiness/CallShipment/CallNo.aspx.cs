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

public partial class Triangle_CallNo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
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
        if (id.Length > 0)
        {
            //Window2.Show();
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOT_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetDetailList").Append("id",id)
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])}).GetList();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                //lblShow.Text = "Lot No# " + ds.Tables[0].Rows[0]["lotno"].ToString();
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
        else if (rdMbl.Checked)
        {
            if (txtMbl.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "MBL can't be empty ").Show();
                return;
            }
        }
        else if (rdHbl.Checked)
        {
            if (txtHbl.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "HBL can't be empty ").Show();
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
            if (ds.Tables[0].Rows[0][1].ToString() == "Invoice")
            {
                string[] str = ds.Tables[0].Rows[0][2].ToString().Split(',');
                X.AddScript("window.open('../../AirImport/AIShipmentJobList/invoice.aspx?sys=" + str[0] + "&FL=" + str[1] + "&seed="+str[2]+"');");
            }
            else
            {
                if (ds.Tables[0].Rows[0][2].ToString() == "Domestic")
                {
                    X.AddScript("window.open('../Domestic/List.aspx?seed=" + ds.Tables[0].Rows[0][0].ToString() + "');");
                }
                else if (ds.Tables[0].Rows[0][2].ToString() == "Trucking")
                {
                    X.AddScript("window.open('../Trucking/List.aspx?seed=" + ds.Tables[0].Rows[0][0].ToString() + "');");
                }
                else
                {
                    X.AddScript("window.open('../Brokerage/List.aspx?seed=" + ds.Tables[0].Rows[0][0].ToString() + "');");
                }
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
        else if (rdMbl.Checked)
        {
            No = txtMbl.Text.Trim();
            type = "MBL";
        }
        else if (rdHbl.Checked)
        {
            No = txtHbl.Text.Trim();
            type = "HBL";
        }
        else if (rdInvoice.Checked)
        {
            No = txtInvoice.Text.Trim();
            type = "INVOICE";
        }
        DataFactory dal = new DataFactory();
        ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOT_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetID").Append("Type",type).Append("No",No)
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])}).GetList();
        return ds;

    }

    protected void btnLotlist_Click(object sender, EventArgs e)
    {
        if (rdLot.Checked)
        {
            if (txtLot.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "LotNo can't be empty ").Show();
                return;
            }
        }
        else if (rdMbl.Checked)
        {
            if (txtMbl.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "Mbl can't be empty ").Show();
                return;
            }
        }
        else if (rdHbl.Checked)
        {
            if (txtHbl.Text.Trim() == "")
            {
                X.Msg.Alert("Information", "Hbl can't be empty ").Show();
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
            string sys = "";
            if (ds.Tables[0].Rows[0][1].ToString() == "Invoice")
            {
                string[] str = ds.Tables[0].Rows[0][2].ToString().Split(',');
                sys = str[0];

            }
            else if (ds.Tables[0].Rows[0][2].ToString() == "Domestic")
            {
                sys = "DM";
            }
            else if (ds.Tables[0].Rows[0][2].ToString() == "Brokerage")
            {
                sys = "BK";
            }
            else
            {
                sys = "TK";
            }
            string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/../ShipmentList/DetailList.aspx?ID=" + id+"&sys="+sys;

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
            rdMbl.Checked = false;
            rdHbl.Checked = false;
            rdInvoice.Checked = false;

        }
        else if (type == "rdMbl")
        {
            rdLot.Checked = false;
            rdMbl.Checked = true;
            rdHbl.Checked = false;
            rdInvoice.Checked = false;
        }
        else if (type == "rdHbl")
        {
            rdLot.Checked = false;
            rdMbl.Checked = false;
            rdHbl.Checked = true;
            rdInvoice.Checked = false;
        }
        else if (type == "rdInvoice")
        {
            rdLot.Checked = false;
            rdMbl.Checked = false;
            rdHbl.Checked = false;
            rdInvoice.Checked = true;
        }
    }
}

