using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;

public partial class common_UIControls_Transfer : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                hidsys.Text = this.sys;
                hidtype.Text = this.type;
                hidseed.Text = Request["seed"] == null ? "" : Request["seed"];
                if (hidtype.Text == "HC") { hidseed.Text = Request["HBL"] == null ? "" : Request["HBL"]; }
                if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT")
                {
                    BindData(); 
                }
                Valid();
            }
        }
    }

    protected void Valid()
    {
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallTransfer_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "Valid").Append("sys",hidsys.Text).Append("seed",hidseed.Text)
        }).GetTable();
        if (dt != null)
        {
            if (dt.Rows[0][1].ToString() == "0")
            {
                divtransferImg.Visible = false;
                if (!string.IsNullOrEmpty(dt.Rows[0][0].ToString()))
                {
                    ShowLotno(dt.Rows[0][2].ToString(), dt.Rows[0][0].ToString(), dt.Rows[0][3].ToString(), dt.Rows[0][4].ToString(), dt.Rows[0][5].ToString());
                }
            }
            else if (!string.IsNullOrEmpty(dt.Rows[0][0].ToString()))
            {
                X.AddScript("SetTransferText();");
                btnTransfer.Text = "Revert";
                ShowLotno(dt.Rows[0][2].ToString(), dt.Rows[0][0].ToString(), dt.Rows[0][3].ToString(), dt.Rows[0][4].ToString(), dt.Rows[0][5].ToString());
            }
        }
        if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() != "ACCOUNT"||hidtype.Text == "HC") { divtransferImg.Visible = false; }
    }
    protected void BindData()
    {
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallTransfer_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "GetSys").Append("sys",hidsys.Text)
        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            StoreSys.DataSource = dt;
            StoreSys.DataBind();
        }
    }

    protected void btnTransfer_Click(object sender, DirectEventArgs e)
    {
        if (btnTransfer.Text == "Change" && string.IsNullOrEmpty(cmbTransfer.SelectedItem.Value))
        {
            //X.Msg.Alert("Warning", "Sys can't be empty").Show();
            X.Msg.Show(new MessageBoxConfig { Title="Warning",Message="System can't be empty",Icon=MessageBox.Icon.WARNING,Buttons=MessageBox.Button.OK});
        }
        else
        {
            string msg = btnTransfer.Text == "Change" ? "Are you sure to change system?" : "Are you sure to revert?";
            X.Msg.Confirm("Information", msg, "if (buttonId == 'yes') { hideTransferPanel();CompanyX.TransferSys.btnTransfer_Click(); }else{hideTransferPanel();}").Show();
        }
    }

    [DirectMethod]
    public void btnTransfer_Click()
    {
        DataSet ds=null;
        if (btnTransfer.Text == "Revert")
        {
            ds=RevertData();
            if (ds!=null&&ds.Tables.Count==2)
            {
                SetPage(ds.Tables[1].Rows[0][0].ToString(), ds.Tables[1].Rows[0][1].ToString(), ds.Tables[1].Rows[0][2].ToString(), ds.Tables[1].Rows[0][3].ToString());
            }
            else
            {
                //X.Msg.Alert("Error", "Revert failed").Show();
                X.Msg.Show(new MessageBoxConfig { Title = "Error", Message = "Revert failed", Icon = MessageBox.Icon.ERROR, Buttons = MessageBox.Button.OK });
            }
        }
        else
        {
            if (cmbTransfer.SelectedItem.Value != "")
            {
                ds=TransferData();
                if (ds!=null&&ds.Tables.Count==2)
                {
                    SetPage(ds.Tables[1].Rows[0][0].ToString(), ds.Tables[1].Rows[0][1].ToString(), ds.Tables[1].Rows[0][2].ToString(), ds.Tables[1].Rows[0][3].ToString());
                }
                else
                {
                    //X.Msg.Alert("Error", "Transfer failed").Show(); 
                    X.Msg.Show(new MessageBoxConfig { Title = "Error", Message = "Change System failed", Icon = MessageBox.Icon.ERROR, Buttons = MessageBox.Button.OK });
                }
            }
        }
    }

    protected void SetPage(string sys,string seed,string type,string masterseed)
    {
        switch (sys)
        {
            case "AI":
                if (type == "H")
                {
                   X.Redirect("~/AirImport/AIShipmentJobList/hawb.aspx?MAWB="+masterseed+"&seed=" + seed);
                }
                else
                {
                  X.Redirect("~/AirImport/AIShipmentJobList/mawb.aspx?seed="+seed);
                }
                break;
            case "AE":
                if (type == "H1")
                {
                    X.Redirect("~/AirExport/AEShipAndColIn/List.aspx?MAWB="+masterseed+"&type=s&seed=" + seed);
                }
                else if (type == "H2")
                {
                    X.Redirect("~/AirExport/AEShipAndColIn/List.aspx?MAWB=" + masterseed + "&type=i&seed=" + seed);
                }
                else if (type == "H3")
                {
                    X.Redirect("~/AirExport/AESubShipment/List.aspx?MAWB=" + masterseed + "&seed=" + seed);
                }
                else if (type == "M1"||type=="M")
                {
                    X.Redirect("~/AirExport/AEConsolAndDirect/List.aspx?type=c&seed=" + seed);
                }
                else if(type=="M2")
                {
                    X.Redirect("~/AirExport/AEConsolAndDirect/List.aspx?type=d&seed=" + seed);
                }
                else if (type == "M3")
                {
                    X.Redirect("~/AirExport/AEDirectMAWB/List.aspx?seed=" + seed);
                }
                else if (type == "M4")
                {
                    X.Redirect("~/AirExport/AEColoaderDirect/List.aspx?seed=" + seed);
                }
                break;
            case "OI":
                if (type == "H")
                {
                    X.Redirect("~/OceanImport/OceanShipmentJobList/OceanShipmentHouse.aspx?MBL="+masterseed+"&seed=" + seed);
                }
                else
                {
                    X.Redirect("~/OceanImport/OceanLot/List.aspx?seed=" + seed);
                }
                break;
            case "OE":
                if (type == "H")
                {
                    X.Redirect("~/OceanExport/OEShipment/List.aspx?MBL="+masterseed+"&Seed=" + seed);
                }
                else
                {
                    X.Redirect("~/OceanExport/OEAssignJob/List.aspx?Seed=" + seed);
                }
                break;
            case "AT":
                X.Redirect("~/Triangle/AirShipment/List.aspx?Seed=" + seed);
                break;
            case "OT":
                X.Redirect("~/Triangle/OceanShipment/List.aspx?Seed=" + seed);
                break;
            case "DM":
                X.Redirect("~/OtherBusiness/Domestic/List.aspx?Seed=" + seed);
                break;
            case "BK":
                X.Redirect("~/OtherBusiness/Brokerage/List.aspx?Seed=" + seed);
                break;
            case "TK":
                X.Redirect("~/OtherBusiness/Trucking/List.aspx?Seed=" + seed);
                break;
        }
    }
    
    protected void ShowLotno(string sys, string seed, string type, string masterseed,string lotno)
    {
        //string att = btnTransfer.Text == "Revert" ? "From " : "To ";
        string att = "";
        string left = " <span style='color:green;'>( </span>";
        string right = "<span style='color:green;'> )</span>";
        if (string.IsNullOrEmpty(lotno))
        {
            lotno = "###lotno###";
        }
        switch (sys)
        {
            case "AI":
                if (type == "H")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirImport/AIShipmentJobList/hawb.aspx?MAWB=" + masterseed + "&seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirImport/AIShipmentJobList/mawb.aspx?seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                break;
            case "AE":
                if (type == "H1")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirExport/AEShipAndColIn/List.aspx?MAWB=" + masterseed + "&type=s&seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else if (type == "H2")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirExport/AEShipAndColIn/List.aspx?MAWB=" + masterseed + "&type=i&seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else if (type == "H3")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirExport/AESubShipment/List.aspx?MAWB=" + masterseed + "&seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else if (type == "M1")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirExport/AEConsolAndDirect/List.aspx?type=c&seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else if (type == "M2")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirExport/AEConsolAndDirect/List.aspx?type=d&seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else if (type == "M3")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirExport/AEDirectMAWB/List.aspx?seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else if (type == "M4")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/AirExport/AEColoaderDirect/List.aspx?seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                break;
            case "OI":
                if (type == "H")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/OceanImport/OceanShipmentJobList/OceanShipmentHouse.aspx?MBL=" + masterseed + "&seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/OceanImport/OceanLot/List.aspx?seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                break;
            case "OE":
                if (type == "H")
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/OceanExport/OEShipment/List.aspx?MBL=" + masterseed + "&Seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                else
                {
                    transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/OceanExport/OEAssignJob/List.aspx?Seed=" + seed + "'>" + lotno + "</a>" + right;
                }
                break;
            case "AT":
                transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/Triangle/AirShipment/List.aspx?Seed=" + seed + "'>" + lotno + "</a>" + right;
                break;
            case "OT":
                transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/Triangle/OceanShipment/List.aspx?Seed=" + seed + "'>" + lotno + "</a>" + right;
                break;
            case "DM":
                transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/OtherBusiness/Domestic/List.aspx?Seed=" + seed + "'>" + lotno + "</a>" + right;
                break;
            case "BK":
                transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/OtherBusiness/Brokerage/List.aspx?Seed=" + seed + "'>" + lotno + "</a>" + right;
                break;
            case "TK":
                transferLotno.Html = left + att + "<a target='_blank' style='color:green;' href='/OtherBusiness/Trucking/List.aspx?Seed=" + seed + "'>" + lotno + "</a>" + right;
                break;
        }
    }

    protected DataSet TransferData()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallTransfer_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","Transfer")
            .Append("seed",hidseed.Text)
            .Append("sys",hidsys.Text)
            .Append("tosys",cmbTransfer.SelectedItem.Value)
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("code",FSecurityHelper.CurrentUserDataGET()[4]+cmbTransfer.SelectedItem.Value)
            .Append("user",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("type",hidtype.Text)
        }).GetList();
        return ds;
    }

    protected DataSet RevertData()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallTransfer_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("Option","Revert")
            .Append("seed",hidseed.Text)
            .Append("sys",hidsys.Text)
            .Append("type",hidtype.Text)
        }).GetList();
        return ds;
    }

    #region 系统
    private string _sys = "";
    public string sys
    {
        get { return _sys; }
        set { _sys = value; }
    }
    #endregion

    #region 类别
    private string _type = "";
    public string type
    {
        get { return _type; }
        set { _type = value; }
    }
    #endregion
}
