using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wuqi.Webdiyer;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.DBLL;
using Ext.Net;

public partial class Framework_Menu_list : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            GridBind();
        }
    }

    public readonly DataFactory dal = new DataFactory();
    public void GridBind()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GridBind")
        }).GetList();
        this.GridPanel.GetStore().DataSource = ds;
        this.GridPanel.GetStore().DataBind();
    }

    [DirectMethod(Namespace = "CompanyX")]
    public void btnSave_Click()
    {
        if (string.IsNullOrEmpty(txtRoot.Text)) { txtRoot.Text = ""; return; }
        if (string.IsNullOrEmpty(txtParant.Text)) { txtParant.Text = ""; return; }
        if (string.IsNullOrEmpty(txtMenu.Text)) { txtMenu.Text = ""; return; }
        if (string.IsNullOrEmpty(txtNameCHS.Text)) { txtNameCHS.Text = ""; return; }
        if (string.IsNullOrEmpty(txtNameENG.Text)) { txtNameENG.Text = ""; return; }
        if (string.IsNullOrEmpty(txtHyperLink.Text)) { txtHyperLink.Text = ""; return; }
        if (string.IsNullOrEmpty(txtOrder.Text)) { txtOrder.Text = ""; return; }
        if (string.IsNullOrEmpty(txtLevel.Text)) { txtLevel.Text = ""; return; }

        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() { 
                dal.CreateIFields()
            .Append("Option","UpdateMenu")
            .Append("RootID",txtRoot.Text.ToUpper())
            .Append("ParentID",txtParant.Text.ToUpper())
            .Append("MenuID",txtMenu.Text.ToUpper())
            .Append("NameCHS",txtNameCHS.Text)
            .Append("NameENG",txtNameENG.Text)
            .Append("Hyperlink",txtHyperLink.Text)
            .Append("OrderBy",txtOrder.Text)
            .Append("LevelIndex",txtLevel.Text)
            .Append("Remark",txtRemark.Text.ToUpper())
            .Append("Creator",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("Modifier",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("RowID",txtRowID.Text)
            }).Update();
        if (b)
        {
            DataTable getMax = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() { 
                dal.CreateIFields()
                .Append("Option","GetMax")
            }).GetTable();
            if (getMax != null && getMax.Rows.Count > 0 && txtRowID.Text == "")
            {
                txtRowID.Text = getMax.Rows[0][0].ToString().Trim();
            }
            GridBind();
        }
        else
        {
            X.Msg.Alert("status", " Save failed ").Show();
        }

    }
    [DirectMethod(Namespace = "CompanyX")]
    public void btnAddSave_Click()
    {
        btnSave_Click();
        txtRowID.Text = null;
        txtRoot.Text = null;
        txtParant.Text = null;
        txtMenu.Text = null;
        txtRemark.Text = null;
        txtNameCHS.Text = null;
        txtNameENG.Text = null;
        txtOrder.Clear();
        txtLevel.Clear();
        txtHyperLink.Text = null;
    }

    [DirectMethod]
    public void btnCancel_click()
    {
        if (string.IsNullOrEmpty(txtRowID.Text))
        {
            X.Msg.Alert("status", " Please choose to delete lines").Show();
            return;
        }
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() { dal.CreateIFields()
             .Append("Option", "DeleteMenu")
             .Append("RowID",txtRowID.Text)
             .Append("MenuID",txtMenu.Text)
             .Append("Modifier",FSecurityHelper.CurrentUserDataGET()[0])
        }).Update();
        if (b)
        {
            GridBind();
            RowSelectionModel row = this.GridPanel.GetSelectionModel() as RowSelectionModel;
            row.SelectFirstRow();
        }
        else
        {
            X.Msg.Alert("status", " Delete failed ").Show();
        }
    }

    protected void row_Click(object sender, DirectEventArgs e)
    {
        txtRowID.Text = e.ExtraParams["RowID"];
        txtRoot.Text = e.ExtraParams["RootID"];
        txtParant.Text = e.ExtraParams["ParentID"];
        txtMenu.Text = e.ExtraParams["MenuID"];
        txtNameCHS.Text = e.ExtraParams["NameCHS"];
        txtNameENG.Text = e.ExtraParams["NameENG"];
        txtHyperLink.Text = e.ExtraParams["Hyperlink"];
        txtOrder.Text = e.ExtraParams["OrderBy"];
        txtLevel.Text = e.ExtraParams["LevelIndex"];
        txtRemark.Text = e.ExtraParams["Remark"];
    }
}
