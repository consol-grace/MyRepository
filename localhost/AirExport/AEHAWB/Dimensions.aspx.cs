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

public partial class AirExport_AEHAWB_Dimensions : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    public static string sys = "AE";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            txtRate.Text = FSecurityHelper.CurrentUserDataGET()[23];
            //txtRate.Number = Convert.ToDouble(FSecurityHelper.CurrentUserDataGET()[23]);
            hidSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            DataBindList();
            txtRate.Focus(true);
        }
    }
      
    #region GetDs(string CmdText, List<IFields> fields)   Author ：hcy   (2011-12-05)
    DataSet GetDs(string CmdText, List<IFields> fields)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = dal.FactoryDAL(PageHelper.ConnectionStrings, CmdText, fields).GetList();
        }
        catch
        {
            ds = null;
        }
        return ds;
    }
    #endregion
     
    #region   DataBindList()    Author ：Hcy   (2011-12-05)
    private void DataBindList()
    {
        List<IFields> Getlist = new List<IFields>();
        Getlist.Add(dal.CreateIFields().Append("Option", "GetList")
            .Append("wd_Seed", hidSeed.Text == "" ? null : hidSeed.Text)
            );
        DataSet ds = GetDs("FW_AirExport_AWBDimension_SP", Getlist);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            hidRowID.Text = ds.Tables[0].Rows[0]["RowID"].ToString();
            txtRate.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_DIMRate"].ToString()) ? FSecurityHelper.CurrentUserDataGET()[23] : ds.Tables[0].Rows[0]["wbi_DIMRate"].ToString();
            txtLine.Text = string.IsNullOrEmpty(ds.Tables[0].Rows[0]["wbi_DIMLineStart"].ToString()) ? "7" : ds.Tables[0].Rows[0]["wbi_DIMLineStart"].ToString();
            txtCM3.Text = ds.Tables[0].Rows[0]["wbi_DIMCM3"].ToString();
            lblCount.Text = ds.Tables[0].Rows[0]["wbi_DIMStart"].ToString();
            lblPieces.Text = ds.Tables[0].Rows[0]["wbi_DIMLineCount"].ToString();
            lblCM3.Text = ds.Tables[0].Rows[0]["wbi_DIMCount"].ToString();
            txtDigit.Text = ds.Tables[0].Rows[0]["wbi_DIMDigit"].ToString();
            
            gpDim.GetStore().DataSource = ds.Tables[1];
            gpDim.GetStore().DataBind();
        }
    }
    #endregion


    public void Save(object sender ,  DirectEventArgs e)
    {
        bool b= dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AWBDimension_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "UpdateHeader")
            .Append("wd_Seed", hidSeed.Text)
            .Append("wbi_DIMStart", string.IsNullOrEmpty(lblCount.Text)?null:lblCount.Text)
            .Append("wbi_DIMCount", string.IsNullOrEmpty(lblCM3.Text)?null:lblCM3.Text)
            .Append("wbi_DIMLineCount",string.IsNullOrEmpty(lblPieces.Text)?null:lblPieces.Text)
            .Append("wbi_DIMLineStart", string.IsNullOrEmpty(txtLine.Text)?null:txtLine.Text)
            .Append("wbi_DIMRate", string.IsNullOrEmpty(txtRate.Text.Trim())?null:txtRate.Text.Trim())
            .Append("wbi_DIMCM3", string.IsNullOrEmpty(txtCM3.Text.Trim())?null:txtCM3.Text.Trim())
            .Append("wbi_DIMDigit",string.IsNullOrEmpty(txtDigit.Text.Trim())?null:txtDigit.Text.Trim())
        }).Update();

        var Dimensions = JSON.Deserialize<List<Dimensions>>(e.ExtraParams["p_safety_3"]);
        List<IFields> Dimlist = new List<IFields>();
        string DimID = ""; 
        
        for (int i = 0; i < Dimensions.Count; ++i)
        {
            if (string.IsNullOrEmpty(Dimensions[i].cM3) || Dimensions[i].cM3 == "0")
                continue;
            Dimlist.Add(dal.CreateIFields().Append("Option", "Update").
            Append("wd_Width", string.IsNullOrEmpty(Dimensions[i].W) ? DBNull.Value : (object)Dimensions[i].W).
            Append("wd_Length", string.IsNullOrEmpty(Dimensions[i].L) ? DBNull.Value : (object)Dimensions[i].L).
            Append("wd_Height", string.IsNullOrEmpty(Dimensions[i].H) ? DBNull.Value : (object)Dimensions[i].H).
            Append("wd_Piece", string.IsNullOrEmpty(Dimensions[i].Pieces) ? DBNull.Value : (object)Dimensions[i].Pieces)
            .Append("wd_Line", txtLine.Text)
            .Append("wd_ROWID", Dimensions[i].RowID)
            .Append("wd_Seed", hidSeed.Text)
            .Append("wd_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("wd_Sys", sys)
            .Append("wd_User", FSecurityHelper.CurrentUserDataGET()[0].ToString())
            );
            DimID += "," + Dimensions[i].RowID;
        }
        //delete
        if (DimID.Length > 1)
        {
            DimID = DimID.Substring(1, DimID.Length - 1);
        }
        dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AWBDimension_SP", new List<IFields> { dal.CreateIFields().Append("Option", "Delete").Append("wd_Seed", hidSeed.Text).Append("str", DimID) }).Update();
        bool resultWTForeign = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_AWBDimension_SP", Dimlist).Update();
        
        X.AddScript("window.parent.winShow.close();");      
         

    }

    #region Dimensions
    class Dimensions
    {
        public int RowID
        { get; set; }
        public string L
        { get; set; }
        public string W
        { get; set; }
        public string H
        { get; set; }
        public string Pieces
        { get; set; }
        public string cM3
        { get; set; }
    }
    #endregion
}
