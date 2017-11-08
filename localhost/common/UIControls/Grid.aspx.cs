using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
//using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;


public partial class common_UIControls_Grid : System.Web.UI.Page
{

    //Grid grid = new Grid();
    string[] FieldName = new string[] { "RowID", "CompanyCode", "CompanyName", "Item", "Description", "Total", "CalcKind", "Qty", "Unit", "Currency", "EX", "Rate", "Amount" };
    string[] Caption = new string[] { "RowID", "Code", "Company", "Item", "Description", "Total", "Calc Kind", "Qty","Unit","Currency","EX.","Rate","Amount" };
    string[] DataType = new string[] { "string", "company", "comName", "item", "string", "label", "calckind", "string", "unit", "currency", "string", "string", "string" };
    string[] CWidth = new string[] { "80px", "100px", "180px", "60px", "180px", "80px", "80px", "80px", "80px", "80px", "80px", "80px", "80px", "80px" };
    string[] HideField = new string[] { "RowID" };

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Creatgrid(CreateDataSet().Tables[0]);
            store1.DataSource = CreateDataSet().Tables[0];
            store1.DataBind();
        }


    }

    public void Creatgrid(DataTable dt)
    {
        UserGridPanel1.Caption = Caption;
        UserGridPanel1.FieldName = FieldName;
        UserGridPanel1.DataType = DataType;
        UserGridPanel1.HideField = HideField;
        UserGridPanel1.Title = "Local Costing";
        UserGridPanel1.Cls = "grid";
        UserGridPanel1.CWidth = CWidth;
        UserGridPanel1.dt = dt;
        gridPanle.InnerHtml = UserGridPanel1.CreateGrid();
        UserGridPanel1.Disenable = true;
    }

    public DataSet CreateDataSet()
    {
        return GetList("FW_AirImport_ShipmentItem_SP", "List", "si_Seed", "2088102");
        //GetList("FW_AirImport_ShipmentItem_SP", "List", "si_Seed", hidSeed.Text);
    }

    DataFactory dal = new DataFactory();

    DataSet GetList(string CmdText, string Type, string Param, string Stat)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, CmdText, new List<IFields>() { dal.CreateIFields().Append("Option", Type).Append(Param, Stat) }).GetList();
        }
        catch
        {
            ds = null;
        }
        return ds;
    }

    protected void btnClick_Click(object sender, EventArgs e)
    {
        UserGridPanel1.FieldName = FieldName;
        var ShipmentItem = Ext.Net.JSON.Deserialize<List<ShipmentItem>>(UserGridPanel1.getJSON).Where(p => !string.IsNullOrEmpty(p.CompanyCode)).ToList();
        List<IFields> listCosting = new List<IFields>();
        for (int i = 0; i < ShipmentItem.Count; ++i)
        {
            listCosting.Add(dal.CreateIFields().Append("Option", "Update_M").
            Append("si_BillTo", ShipmentItem[i].CompanyCode).
            Append("si_Item", ShipmentItem[i].Item).
            Append("si_Description", ShipmentItem[i].Description.ToUpper()).
            Append("si_QtyKind", ShipmentItem[i].CalcKind).
            Append("si_Quantity", string.IsNullOrEmpty(ShipmentItem[i].Qty) ? (object)DBNull.Value : ShipmentItem[i].Qty).
            Append("si_Unit", ShipmentItem[i].Unit).
            Append("si_Currency", ShipmentItem[i].Currency).
            Append("si_Rate", string.IsNullOrEmpty(ShipmentItem[i].Rate) ? (object)DBNull.Value : ShipmentItem[i].Rate).
            Append("si_Amount", string.IsNullOrEmpty(ShipmentItem[i].Amount) ? (object)DBNull.Value : ShipmentItem[i].Amount).
            Append("si_ExRate", string.IsNullOrEmpty(ShipmentItem[i].EX) ? (object)DBNull.Value : ShipmentItem[i].EX).
            Append("si_Type", i).
            Append("si_Total", string.IsNullOrEmpty(ShipmentItem[i].Total) ? (object)DBNull.Value : ShipmentItem[i].Total).
            Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString()).
            Append("si_Sys","AI" ).
            Append("si_ToMaster", 2088102).
            Append("User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).
            Append("si_ROWID", ShipmentItem[i].RowID)
            );
        }
       
        bool l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_ShipmentItem_SP", listCosting).Update();
        
        Creatgrid(CreateDataSet().Tables[0]);
    }

}

class ShipmentItem
{
    public string RowID
    { get; set; }

    public string CompanyCode
    { get; set; }
    public string CompanyName
    { get; set; }

    public string Item
    { get; set; }
    public string Description
    { get; set; }
    public string Total
    { get; set; }
    public string CalcKind
    { get; set; }
    public string Qty
    { get; set; }
    public string Unit
    { get; set; }
    public string Currency
    { get; set; }
    public string EX
    { get; set; }
    public string Rate
    { get; set; }
    public string Amount
    { get; set; }

}
