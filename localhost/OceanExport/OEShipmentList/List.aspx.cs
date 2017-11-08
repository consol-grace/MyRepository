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

public partial class OceanExport_OEShipmentList_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (Request["JobType"] != null)
            {
                chkVoid.Hidden = true;
            }
            DataBinder();
        }
    }

    #region   DataBinder()    Author ：Hcy   (2011-12-11)
    void DataBinder()
    {
        txtHawb.Focus(true);
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "BookingList")
        .Append("o_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("o_HBL",txtHawb.Text.Trim()).Append("o_Shipper",txtShipper.Text.Trim()).Append("active",chkVoid.Checked?0:1)
        }).GetList();
        storeHBL.DataSource = ds;
        storeHBL.DataBind();
    }
    #endregion

    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        DataBinder();
    }

    protected void storeHBL_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }
    protected void btnAssign_Click(object sender, DirectEventArgs e)
    {
        string id = e.ExtraParams["RowID"];
        if (id == "[]" && Request["JobIDList"] == null)
        {
            X.Msg.Alert("Information", "Please select rows!").Show();
        }
        else
        {
            string str = "";
            var JobList = JSON.Deserialize<List<Assign>>(e.ExtraParams["RowID"]);

            for (int i = 0; i < JobList.Count; ++i)
            {
                str += "," + JobList[i].o_Seed;
            }
            if (str.Length > 1)
            {
                str = str.Substring(1, str.Length - 1);
            }
            string RequestID = Server.UrlDecode(Request["JobIDList"] == null ? "" : Request["JobIDList"]);
            string seed = Request["Jobseed"] == null ? "" : Request["Jobseed"];
            if (RequestID.Length > 1)
            {
                str = RequestID + "," + str;  
            }
            if (Request["JobType"] == null)
            {
                CheckboxSelectionModel sm = this.gridList.SelectionModel.Primary as CheckboxSelectionModel;
                sm.ClearSelections();
                X.AddScript("window.open('../OEAssignJob/List.aspx?IDList=" + Server.UrlEncode(str) + "','_blank');");
            }
            else
            {
                X.AddScript("window.dialogArguments.refreshdata(\"" + seed + "\",\"" + str + "\");window.close();");
            }

        }
    }
    #region Assign
    class Assign
    {
        public int o_Seed
        {
            get;
            set;

        }
    }
    #endregion
}
