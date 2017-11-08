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

public partial class OceanExport_OEShipment_MakeHBL : System.Web.UI.Page
{
    //protected string vesselID = "0", voyageID = "0", vessel = "", voyage = "";
    //protected static string type = "",ETD="";
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            string vesselID = Request["VesselID"] == null ? "0" : Request["VesselID"];
            string voyageID = Request["VoyageID"] == null ? "0" : Request["VoyageID"];
            string vessel = Server.UrlDecode(Request["Vessel"]==null?"":Request["Vessel"]);
            string voyage = Server.UrlDecode(Request["Voyage"] == null ? "" : Request["Voyage"]);
            string type = Request["Type"];
            string ETD=Request["ETD"];
            string isTran = Request["IsTran"].ToString();
            labVessel.Text = vessel;
            labVoyage.Text = voyage;
            rdAutoGene.Checked = true;
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "GetOldLotNo").Append("o_STAT",FSecurityHelper.CurrentUserDataGET()[12]).
                Append("vs_ROWID",vesselID).Append("voy_ROWID",voyageID) }).GetList();
            if (ds != null&&ds.Tables[0].Rows.Count>0)
            {
                StoreAssign.DataSource = ds;
                StoreAssign.DataBind();
                CmbAssign.SelectedItem.Value = ds.Tables[0].Rows[0][1].ToString();
                rdAssign.Checked = true;
            }
            else
            {
                rdNewLot.Checked = true;
            }

            if (type == "0"||type=="1"||type=="4" || isTran == "TRUE")
            {
                divLotNo.Visible = false;
            }
            else if (type == "3")
            {
                divHBL.Visible = false;
            }

        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        X.AddScript("window.parent.winAutoHBL.close();");
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        string hbl = "", lotno = "";
        string type = Request["Type"];
        string ETD = Request["ETD"];
        bool flag = true;
        if (type == "0" || type == "2"||type=="4")
        {
            if (rdAutoGene.Checked)
            {
                string pod = Server.UrlDecode(Request["POD"]);
                if (pod == "")
                {
                    flag = false;
                    X.Msg.Alert("Status", "Discharge port can't be empty!").Show();
                    return;
                }
                else
                {
                    DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", new List<IFields>() { 
                 dal.CreateIFields().Append("Option", "MakeNo").Append("Type", "HBL").Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                .Append("o_STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("code",FSecurityHelper.CurrentUserDataGET()[4].ToString())
                .Append("o_LocPOD",pod)  
                .Append("o_ETD",ControlBinder.getDate(ETD.StartsWith("0001") ? DBNull.Value : (object)ETD))}).GetList();
                    if (ds != null)
                    {
                        hbl = ds.Tables[0].Rows[0][0].ToString();
                    }
                }
            }
            else
            {
                hbl = txtManual.Text.Trim().ToUpper();
                if (hbl == "")
                {
                    flag = false;
                    X.Msg.Alert("Status", "HBL can't be empty!").Show();
                    return;
                }
            }
        }
        if ((type == "2" || type == "3")&&Request["IsTran"].ToString() != "TRUE")
        {
            if (rdNewLot.Checked)
            {
                DataSet dsLot = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "MakeNo").Append("Type", "LotNo").Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                .Append("o_STAT", FSecurityHelper.CurrentUserDataGET()[12]).Append("code", FSecurityHelper.CurrentUserDataGET()[4]) 
                .Append("o_ETD",ControlBinder.getDate(ETD.StartsWith("0001") ? DBNull.Value : (object)ETD))}).GetList();
                if (dsLot != null)
                {
                    lotno = dsLot.Tables[0].Rows[0][0].ToString();
                }
            }
            else if (rdAssign.Checked)
            {
                lotno = CmbAssign.SelectedItem.Text;
                if (lotno == "" )
                {
                    flag = false;
                    X.Msg.Alert("Status", "LotNo can't be empty!").Show();
                    return;
                }
            }
            else
            {
                lotno = txtManual1.Text.Trim().ToUpper();
                if (lotno == "" )
                {
                    flag = false;
                    X.Msg.Alert("Status", "LotNo can't be empty!").Show();
                    return;
                }
            }
        }
        if (flag == true)
        {
            //if (Request["IsTran"].ToString() == "TRUE")
            //{ lotno = "1"; }
            
            X.AddScript("window.parent.SetHBL('" + lotno + "','" + hbl + "','"+type+"');window.parent.winAutoHBL.close();");
        }
        
    }
}
