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

public partial class AirExport_AEHAWB_OtherCharges : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    public static string sys = "AE";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            hidCurrency.Text = Request["currency"] == null ? "" : Request["currency"];
            DataBinder();
        }
    }

    void DataBinder()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AWBOther_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List")
                   .Append("ao_seed", hidSeed.Text=="0"?(object)DBNull.Value:(object)hidSeed.Text) 
        }).GetTable();

        if (dt != null && dt.Rows.Count>0)
        {
            lblAnget.Text = dt.Rows[0]["AgentCount"].ToString();
            lblCarrier.Text = dt.Rows[0]["CarrierCount"].ToString();
            storeDim.DataSource = dt;
            storeDim.DataBind();
        }
    }

    public void Save(object sender, DirectEventArgs e)
    {
        var grid = JSON.Deserialize<List<OtherCharges>>(e.ExtraParams["grid"]);
        List<IFields> list = new List<IFields>();
        string ID = ""; 

        if (gpDim.Store.Count > 0)
        {
            for (int i = 0; i < grid.Count; ++i)
            {
                if (grid[i].Item != "" && grid[i].Amount != "" && grid[i].ChargeTo != "")
                {
                    list.Add(dal.CreateIFields()
                .Append("Option", "Update")
                .Append("ao_Seed", hidSeed.Text)
                .Append("ao_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("ao_Sys", sys)
                .Append("ao_Item", grid[i].Item.ToString().ToUpper())
                .Append("ao_Description", "")
                .Append("ao_Amount", string.IsNullOrEmpty(grid[i].Amount) ? DBNull.Value : (object)grid[i].Amount)
                .Append("ao_IsAgent",grid[i].ChargeTo.ToUpper()== "AGENT" ? 1 : 0)
                .Append("ao_IsCarrier",grid[i].ChargeTo.ToUpper()== "CARRIER" ? 1 : 0)
                .Append("ao_ChargeTo",grid[i].ChargeTo)
                .Append("ao_Currency",hidCurrency.Text)
                .Append("ao_CrUser", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                .Append("ao_ROWID", grid[i].RowID.ToString())
            );

                    ID += "," + grid[i].RowID.ToString();
                }
            }
        }

        //delete
        if (ID.Length > 1)
        {
            ID = ID.Substring(1, ID.Length - 1);
        }

       dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AWBOther_SP", new List<IFields> { dal.CreateIFields().Append("Option", "Delete").Append("ao_Seed", hidSeed.Text).Append("str", ID) }).Update();
       bool save = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AWBOther_SP", list).Update();
       //if (save)
        X.AddScript("window.parent.winShow.close();");
    }

    #region OtherCharges
    class OtherCharges
    {
        public int RowID
        { get; set; }
        public string Item
        { get; set; }
        public string Amount
        { get; set; }
        public string ChargeTo
        { get; set; }
    }
    #endregion
}
