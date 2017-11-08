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

public partial class AirExport_AEManageMentList_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtDateFrom);
            txtDateFrom.Text = DateTime.Now.AddDays(-30).ToString("yyyy/MM/dd");
            txtDateFrom.RawText = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");

            DataBinder();
            CheckStatus();
        }
    }

    #region   CheckStatus()    Author ：Hcy   (2011-12-11)
    void CheckStatus()
    {
        if (Request["subIDList"] != null)
        {
            btnMakeConsol.Visible = false;
            btnDirect.Visible = false;
            btnDirectMAWB.Visible = false;
        }
        if (Request["transfer"] != null)
        {
            chkVoid.Hidden = true;
            if (Request["transfer"] == "c")
            {
                btnDirect.Visible = false;
                btnSub.Visible = false;
                btnDirectMAWB.Visible = false;

            }
            if (Request["transfer"] == "d")
            {
                btnMakeConsol.Visible = false;
                btnSub.Visible = false;
                btnDirectMAWB.Visible = false;
            }
        }
    }

    #endregion

    #region   DataBinder()    Author ：Hcy   (2011-12-11)
    void DataBinder()
    {
        txtHawb.Focus(true);  
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ConsolManagement_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List")
                 .Append("air_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("air_HAWB",txtHawb.Text.Trim()).Append("air_Shipper",txtShipper.Text.Trim()).Append("air_BookNo",txtRef.Text.Trim())
                 .Append("air_ETD",ControlBinder.getDate( txtDateFrom.RawText.Trim().ToUpper().StartsWith("0001") ? DBNull.Value : (object)txtDateFrom.RawText.Trim())).Append("air_Active",chkVoid.Checked?0:1)
        }).GetList();
        storeList.DataSource = ds;
        storeList.DataBind();
    }
    #endregion

    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        DataBinder(); 
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
         DataBinder();
    }
    protected void btnSub_Click(object sender, DirectEventArgs e)
    {
        string id = e.ExtraParams["RowID"];
        if (id == "[]" && Request["subseed"]==null)
        {
            X.Msg.Alert("Information", "Please select rows!").Show(); 
        }
        else
        {
            string str = "";
            var SubShipment = JSON.Deserialize<List<SubShipment>>(e.ExtraParams["RowID"]);
            for (int i = 0; i < SubShipment.Count; ++i)
            {
                str += "," + SubShipment[i].RowID;
            }
            if (str.Length > 1)
            {
                str = str.Substring(1, str.Length - 1); 
            }

            string MAWB = "", RequestID = "", seed = "",type="";
            MAWB = Request["MAWB"];
            RequestID = Server.UrlDecode(Request["subIDList"] == null ? "" : Request["subIDList"]);
            seed = Request["subseed"] == null ? "" : Request["subseed"];
            type=Request["transfer"];

            if (RequestID.Length > 1)
            {
                str = RequestID + "," + str; 
            }

            DataSet result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_SubShipment_SP", new List<IFields> { dal.CreateIFields().Append("Option", "CheckSubShipment")
             .Append("str", str) }).GetList();
            if (result != null && result.Tables[0].Rows.Count > 0)
            {
                if (result.Tables[0].Rows[0]["Flag"].ToString() == "Y")  
                {
                    X.Msg.Alert("Information", "Cannot select any record with different Sub Shipment Master Record").Show();
                }
                else
                {
                    if (type == "sub")
                    {
                        //X.Redirect("../AESubShipment/List.aspx?seed=" + seed + "&MAWB=" + MAWB + "&IDList=" + Server.UrlEncode(str)); 
                        //X.AddScript("window.dialogArguments.location.href='../AESubShipment/List.aspx?seed=" + seed + "&MAWB=" + MAWB + "&IDList=" + Server.UrlEncode(str) + "';window.close();");
                        X.AddScript("window.dialogArguments.refreshdata(\"" + seed + "\",\"" + str + "\");window.close();");
                    }
                    else
                    {
                        CheckboxSelectionModel sm = this.gridList.SelectionModel.Primary as CheckboxSelectionModel;
                        sm.ClearSelections();      
                        X.AddScript("window.open('../AESubShipment/List.aspx?MAWB=" + MAWB + "&seed=" + result.Tables[0].Rows[0]["air_Seed"] + "&IDList=" + Server.UrlEncode(str) + "','_blank');");
                    }
                }
            }
        }
    }

    protected void btnMakeConsol_Click(object sender, DirectEventArgs e)
    {
        string id = e.ExtraParams["RowID"];
        if (id == "[]" && Request["transSeed"] == null)
        {
            X.Msg.Alert("Information", "Please select rows!").Show();
        }
        else
        {
            string str = "";
            var MakeConsol = JSON.Deserialize<List<MakeConsol>>(e.ExtraParams["RowID"]);
            for (int i = 0; i < MakeConsol.Count; ++i)
            {
                str += "," + MakeConsol[i].RowID;
            }
            if (str.Length > 1)
            {
                str = str.Substring(1, str.Length - 1);
                DataSet result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ConsolManagement_SP", new List<IFields> { dal.CreateIFields().Append("Option", "CheckMakeConsol")
                .Append("str", str) }).GetList();
                str = "";
                for (int i = 0; i < result.Tables[0].Rows.Count; i++)
                {
                    str += "," + result.Tables[0].Rows[i][0].ToString();
                }
                str = str.Substring(1, str.Length - 1); 
            }

            string RequestID = "", seed = "", type = "";
            RequestID = Server.UrlDecode(Request["transIDList"] == null ? "" : Request["transIDList"]);
            seed = Request["transSeed"] == null ? "" : Request["transSeed"];
            type = Request["transfer"];
            if (type == "c")
            {
                str = RequestID + "," + str;
                //X.Redirect("../AEMakeConsol/List.aspx?seed=" + seed + "&IDList=" + Server.UrlEncode(str));
                //X.AddScript("window.dialogArguments.location.href='../AEMakeConsol/List.aspx?seed=" + seed + "&IDList=" + Server.UrlEncode(str) + "';window.close();");
                X.AddScript("window.dialogArguments.refreshdata(\"" + seed + "\",\"" + str + "\");window.close();");
            }
            else
            {
                CheckboxSelectionModel sm = this.gridList.SelectionModel.Primary as CheckboxSelectionModel;
                sm.ClearSelections();
                X.AddScript("window.open('../AEConsolAndDirect/List.aspx?type=c&IDList=" + Server.UrlEncode(str) + "','_blank');");
            }

        }
    }

   

    protected void btnDirect_Click(object sender, DirectEventArgs e)
    {
        string id = e.ExtraParams["RowID"];
        if (id == "[]" && Request["transSeed"] == null)
        {
            X.Msg.Alert("Information", "Please select rows!").Show();
        }
        else
        {
            string str = "";
            var Direct = JSON.Deserialize<List<MakeConsol>>(e.ExtraParams["RowID"]);
            for (int i = 0; i < Direct.Count; ++i)
            {
                str += "," + Direct[i].RowID;
            }
            if (str.Length > 1)
            {
                str = str.Substring(1, str.Length - 1);
                DataSet result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ConsolManagement_SP", new List<IFields> { dal.CreateIFields().Append("Option", "CheckMakeDirect")
                .Append("str", str) }).GetList();
                str = "";
                for (int i = 0; i < result.Tables[0].Rows.Count; i++)
                {
                    str += "," + result.Tables[0].Rows[i][0].ToString();
                }
                str = str.Substring(1, str.Length - 1);  
            }

            string RequestID = "", seed = "", type = "";
            RequestID = Server.UrlDecode(Request["transIDList"] == null ? "" : Request["transIDList"]);
            seed = Request["transSeed"] == null ? "" : Request["transSeed"];
            type = Request["transfer"];

            if (type == "d")
            {
                str = RequestID + "," + str;
                //X.Redirect("../AEMakeDirect/List.aspx?seed=" + seed + "&IDList=" + Server.UrlEncode(str));
                //X.AddScript("window.dialogArguments.location.href='../AEMakeDirect/List.aspx?seed=" + seed + "&IDList=" + Server.UrlEncode(str) + "';window.close();");
                X.AddScript("window.dialogArguments.refreshdata(\"" + seed + "\",\"" + str + "\");window.close();");
            }
            else
            {
                CheckboxSelectionModel sm = this.gridList.SelectionModel.Primary as CheckboxSelectionModel;
                sm.ClearSelections();
                X.AddScript("window.open('../AEConsolAndDirect/List.aspx?type=d&IDList=" + Server.UrlEncode(str) + "','_blank');");
            }

        }
    }

    protected void btnDirectMAWB_Click(object sender, DirectEventArgs e)
    {
        string id = e.ExtraParams["RowID"];
        if (id == "[]")
        {
            X.Msg.Alert("Information", "Please select rows!").Show();
        }
        else
        {
            string str = "";
            var DirectMAWB = JSON.Deserialize<List<SubShipment>>(e.ExtraParams["RowID"]);
            for (int i = 0; i < DirectMAWB.Count; ++i)
            {
                str += "," + DirectMAWB[i].RowID;
            }
            if (str.Length > 1)
            {
                str = str.Substring(1, str.Length - 1);
            }
            DataSet result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_DirectMAWB_SP", new List<IFields> { dal.CreateIFields().Append("Option", "CheckDirectMAWB")
             .Append("code", FSecurityHelper.CurrentUserDataGET()[4].ToString() + "AE").Append("air_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
             .Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).Append("str", str) }).GetList();
            if(result.Tables[0].Rows[0][0].ToString()=="Y")
            {
                X.Msg.Alert("Information", "Sub Shipment can't make direct MAWB!").Show();
            }
            else if (result.Tables[0].Rows[0][0].ToString() == "D")
            {
                X.Msg.Alert("Information", "Please select just one row!").Show();
            }
            else
            {
                X.AddScript("window.open('../AEDirectMAWB/List.aspx?seed=" + result.Tables[0].Rows[0]["air_Seed"] + "','_blank');");
                DataBinder();
            }

        }
    }


    [DirectMethod]
    public void UpdateHawb(int id, string hawb)
    {
        if (hawb.Trim().Length > 0)
        {
            string flag = "N";
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_Valid_SP", new List<IFields>() { dal.CreateIFields().Append("type", "HAWB")
                 .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("name",hawb.Trim()).Append("id",id)}).GetList();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                flag = ds.Tables[0].Rows[0][0].ToString();
            }

            if (flag == "Y")
            {
                X.Msg.Alert("Error","HAWB NO. already exists .").Show();
                DataBinder(); 
            }
            else
            {
                bool result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ConsolManagement_SP", new List<IFields> { dal.CreateIFields().Append("Option", "UpdateHawbByID")
                .Append("air_HAWB", hawb.Trim().ToUpper()).Append("air_ROWID",id.ToString()) }).Update();
                DataBinder(); 
            }
        }
    }

    #region SubShipment
    class SubShipment
    {  
      
        public int RowID
        { get; set; } 
    }
    #endregion

    #region MakeConsol
    class MakeConsol
    {
        public int RowID
        { get; set;

        }
    }
    #endregion
}
