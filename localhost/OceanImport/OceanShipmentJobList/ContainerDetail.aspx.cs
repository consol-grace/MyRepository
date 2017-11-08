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

public partial class OceanImport_OceanShipmentJobList_ContainerDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            txtDescrip.Focus(true);
            DataBinder();
        }
    }
    #region  DataBinder()   Author：Hcy  (2011-09-30)
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Container_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "DesList").Append("st_Stat",FSecurityHelper.CurrentUserDataGET()[12])
            
            
            .Append("st_Sys",FSecurityHelper.CurrentUserDataGET()[11][0])
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            GridPanelDescription.GetStore().DataSource = ds.Tables[0];
            GridPanelDescription.GetStore().DataBind();
        }

    }
    #endregion

    #region  btnNext_Click(object, EventArgs) Author：Hcy  (2011-09-30)
    protected void btnNext_Click(object sender, EventArgs e)
    {
        btnSave_Click(sender, e);
        hidID.Text = "";
        hidShort.Text = "";
        txtDescrip.Text = "";
        txtDescrip.Focus();
    }
    #endregion

    #region  btnSave_Click(object, EventArgs) Author：Hcy  (2011-09-30)
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string tt=DateTime.Now.ToString("yyyyMMdd");
        tt+=DateTime.Now.ToString("HHmmssmmm");
        DataFactory dal = new DataFactory();
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Container_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DesUpdate")
        .Append("st_ROWID",hidID.Text).Append("st_Text",txtDescrip.Text.Trim().ToUpper()).Append("st_Stat",FSecurityHelper.CurrentUserDataGET()[12]).Append("st_Sys",FSecurityHelper.CurrentUserDataGET()[11])
        .Append("st_Short",hidShort.Text==""?tt:hidShort.Text).Append("st_User",FSecurityHelper.CurrentUserDataGET()[0])
        }).Update();
        if (b)
        {
            // X.Msg.Alert("status", " Saved successfully").Show();
        }
        else
        {
            X.Msg.Alert("status", " Save failed ").Show();
        }
        DataBinder();
        txtDescrip.Text = "";
        txtDescrip.Focus();
    }
    #endregion

    #region  btnCancel_Click(object, EventArgs) Author：Hcy  (2011-09-30)
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        DataBinder();
        txtDescrip.Focus();
    }
    #endregion

    #region  btnDelete_Click(object, EventArgs) Author：Hcy  (2011-09-30)
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        X.Msg.Confirm("Message", "Confirm?", "if (buttonId == 'yes') { CompanyX.Delete(); } else {  }").Show();
    }
    #endregion

    [DirectMethod]
    public void Delete()
    {
        DataFactory dal = new DataFactory();
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Container_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DesDelete")
                 .Append("st_ROWID",hidID.Text).Append("st_User",FSecurityHelper.CurrentUserDataGET()[0])
        }).Update();
        if (b)
        {
            //X.Msg.Alert("status", " Delete successfully").Show();
        }
        else
        {
            X.Msg.Alert("status", " Delete failed ").Show();
        }
        DataBinder();
        txtDescrip.Text = "";
        txtDescrip.Focus();
    }

    #region   row_Click(object,DirectEventArgs)  Author：Hcy （2011-09-30）
    protected void row_Click(object sender, DirectEventArgs e)
    {
        hidID.Text = e.ExtraParams["st_ROWID"];
        hidShort.Text = e.ExtraParams["st_Short"];
        txtDescrip.Text = e.ExtraParams["st_Text"];
        txtDescrip.Focus();
    }
     #endregion
}

