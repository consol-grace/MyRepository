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

public partial class OceanImport_OceanShipmentJobList_OIHBLList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            DataBinder();
        }
    }

    DataFactory dal = new DataFactory();

    public void DataBinder()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysTranshipment_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "HBLList")
                .Append("MBLSeed", Request["seed"]=="0"?(object)DBNull.Value:(object)Request["seed"] )}).GetTable();

        if (dt != null)
        {
            storeHBL.DataSource = dt;
            storeHBL.DataBind();
        }
    }

    #region   btnOIToOE_Click(object,DirectEventArgs) 
    protected void btnOIToOE_Click(object sender, DirectEventArgs e)
    {
       
        string RowData = e.ExtraParams["RowData"];

        if (RowData == "[]")
        {
            X.Msg.Alert("Information", "Please select rows!").Show();
        }else if (cmbSys.Text == "")
        {
            X.Msg.Alert("Information", "Please select system!").Show();
        }
        else
        {
            var RowList = JSON.Deserialize<List<HBLRowData>>(e.ExtraParams["RowData"]);
            //string SeedList = "";

            for (int i = 0; i < RowList.Count; ++i)
            {


                DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysTranshipment_SP", new List<IFields>() { dal.CreateIFields()
                    .Append("Option", "IsTransfer")
                    .Append("HBLSeed",RowList[i].Seed)
                }).GetTable();

                if (dt == null)
                {
                    X.Msg.Alert("Information", "Sorry,please try later again!").Show();
                    return;
                }
                else
                {
                    if (dt.Rows[0][0].ToString() != "0")
                    {
                        X.Msg.Alert("Information", "This row is transferred!").Show();
                        return;
                    }
                }

                DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysTranshipment_SP", new List<IFields>() { dal.CreateIFields()
                    .Append("Option", "COPY")
                    .Append("HBLSeed",RowList[i].Seed)
                    .Append("User", FSecurityHelper.CurrentUserDataGET()[2])
                    .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])
                    .Append("code",FSecurityHelper.CurrentUserDataGET()[4] + "OEBK")
                    .Append("toSys",cmbSys.Text)
                }).GetList();

                string newSeed = ds.Tables[0].Rows[0]["cs_toseed"].ToString();
               // X.AddScript("window.open('../../OceanExport/OEShipment/List.aspx?MBL=0&Seed=" + newSeed + "','_blank');");
                X.AddScript("if(window.parent.winHblList != null && window.parent.winHblList != undefined){window.parent.winHblList.reload();} if(window.parent.$('#ifmContent').attr('src') == '/OceanExport/OEShipmentList/List.aspx'){window.parent.document.getElementById('ifmContent').contentWindow.location.reload();}if(window.parent.top.WinView == null ||window.parent.top.WinView == undefined){if(window.parent.Window10 !=null ||window.parent.Window10 !=undefined){window.parent.Window10.reload();}}else{window.parent.top.WinView.reload();}");

                X.AddScript("openwin('../../OceanExport/OEShipment/List.aspx?MBL=0&Seed=" + newSeed + "','openOE');");
            }
            
        }
      
    }
    #endregion


    #region HBLRowData
    class HBLRowData
    {
        public int Seed
        {
            get;
            set;

        }

        public string VesselID
        {
            get;
            set;

        }

        public string VoyageID
        {
            get;
            set;

        }

        public string Vessel
        {
            get;
            set;

        }

        public string Voyage
        {
            get;
            set;

        }

        public string ETD
        {
            get;
            set;

        }

        public string POD
        {
            get;
            set;

        }

    }
    #endregion
}