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

public partial class common_Cost_CostingDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtDate);
            
        }
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                DataBinder();
                
            }
        }
    }
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetDetailList")
            .Append("cxh_ROWID",Request["CostingID"])
            .Append("cxd_Seed", Request["CostingDetailSeed"])
        }).GetList();

        

        if (ds != null && ds.Tables.Count > 0)
        {
            if (Request["CostingID"] != "0" && Request["CostingID"] != null)
            {
                hidID.Text = ds.Tables[0].Rows[0]["cxh_ROWID"].ToString();
                hidHeadSeed.Text = ds.Tables[0].Rows[0]["cxh_Seed"].ToString();
                cmbShipperCode.setValue(ds.Tables[0].Rows[0]["cxh_Company"].ToString());
                cmbShipperCode.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                txtDate.Text = ds.Tables[0].Rows[0]["cxh_Date"].ToString();
                txtInv.Text = ds.Tables[0].Rows[0]["cxh_InvoiceNo"].ToString();
                txtAmount.Text = ds.Tables[0].Rows[0]["cxh_Amount"].ToString();

            }
        }

        storeList.DataSource = ds.Tables[1];
        storeList.DataBind();
        

        if (hidID.Text != "0")
        {
            ControlBinder.pageTitleMsg(false, "Combine Cost:Edit", "<p>Status :  Edit  Combine Cost </p>", div_bottom);
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "Combine Cost:New", "<p>Status :  New  Combine Cost </p>", div_bottom);
        }
        X.AddScript("getSelectPos('cmbShipperCode');");
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }

    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "Update")
            .Append("cxh_ROWID",hidID.Text)
            .Append("cxh_Company",cmbShipperCode.Value)
            .Append("cxh_Date",ControlBinder.getDate(txtDate.RawText.StartsWith("0001")?DBNull.Value:(object)txtDate.RawText))
            .Append("cxh_Amount",string.IsNullOrEmpty(txtAmount.Text)?DBNull.Value:(object)txtAmount.Text)
            .Append("cxh_InvoiceNo",txtInv.Text.Trim().ToUpper())
            .Append("cxh_User",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])
        }).GetList();

        hidHeadSeed.Text = ds.Tables[0].Rows[0][0].ToString();

        var CostList = JSON.Deserialize<List<Cost>>(e.ExtraParams["gridList"]);
        string RowID = "";
        List<IFields> listCosting = new List<IFields>();
        for (int i = 0; i < CostList.Count; ++i)
        {
            listCosting.Add(dal.CreateIFields().Append("Option", "UpdateDetail").
                    Append("cxd_Seed", hidHeadSeed.Text).
                    Append("cxd_LotSeed", CostList[i].cxd_LotSeed).
                    Append("cxd_Sys", CostList[i].cxd_Sys).
                    Append("cxd_LotNo", CostList[i].cxd_LotNo.Trim().ToUpper()).
                    Append("cxd_Master", CostList[i].cxd_Master.Trim().ToUpper()).
                    Append("cxd_House", CostList[i].cxd_House.Trim().ToUpper())
                    .Append("cxd_ROWID", CostList[i].cxd_ROWID)
                    .Append("cxd_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
                    .Append("stat", FSecurityHelper.CurrentUserDataGET()[12])
                    );
            RowID += "," + CostList[i].cxd_ROWID;
        }
        if (RowID.Length > 1)
        {
            RowID = RowID.Substring(1, RowID.Length - 1);
        }
        dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new List<IFields> { dal.CreateIFields().Append("Option", "DeleteDetail").Append("cxd_Seed", hidHeadSeed.Text).Append("str", RowID) }).Update();
        bool resultCost = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", listCosting).Update();

        if (hidID.Text == "0")
        {
            //this.parent.winCombineCostDetail.close();
            X.AddScript("this.parent.window.loadCost();this.parent.winCombineCostDetail.close();");
        }
        else
        {
            DataBinder();
        }
    }

    [DirectMethod]
    public void GetData(int rowindex, int id, string value)
    {
        if (value.Trim().Length > 0)
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_ComplexCost_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetData")
            .Append("type",id.ToString())
            .Append("str", value.Trim().Replace(" ",""))
            .Append("stat",FSecurityHelper.CurrentUserDataGET()[12])
            }).GetList();
            //StoreGetData.DataSource = ds;
            //StoreGetData.DataBind();
            if (ds != null &&ds.Tables[0].Rows.Count>0 )
            {
                this.storeList.UpdateRecordField(rowindex, "cxd_LotNo", ds.Tables[0].Rows[0]["LotNo"].ToString());
                this.storeList.UpdateRecordField(rowindex, "cxd_Master", ds.Tables[0].Rows[0]["Master"].ToString());
                this.storeList.UpdateRecordField(rowindex, "cxd_House", ds.Tables[0].Rows[0]["House"].ToString());
                this.storeList.UpdateRecordField(rowindex, "cxd_LotSeed", ds.Tables[0].Rows[0]["Seed"].ToString());
                this.storeList.UpdateRecordField(rowindex, "cxd_Sys", ds.Tables[0].Rows[0]["SYS"].ToString());
                this.storeList.UpdateRecordField(rowindex, "GWT", ds.Tables[0].Rows[0]["GWT"].ToString());
                this.storeList.UpdateRecordField(rowindex, "VWT", ds.Tables[0].Rows[0]["VWT"].ToString());
                this.storeList.UpdateRecordField(rowindex, "Piece", ds.Tables[0].Rows[0]["Piece"].ToString());
            }
        }
    }

    #region Cost 实体类
    class Cost
    {
        public string cxd_ROWID
        { get; set; }
        public string cxd_LotNo
        { get; set; }
        public string cxd_Master
        { get; set; }
        public string cxd_House
        { get; set; }
        public string cxd_LotSeed
        {
            get;
            set;
        }
        public string cxd_Sys
        {
            get;
            set;
        }
    }
    #endregion
}
