using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using Ext.Net;
using DIYGENS.COM.DBLL;

public partial class OceanExport_OEWareHouse_WareHouse : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlBinder.DateFormat(txtNoticeDate);
            ControlBinder.DateFormat(txtWhseClosing);
            ControlBinder.DateFormat(txtHandleClosing);
            ControlBinder.DateFormat(txtETD);
            rowid.Value = Request["rowid"];
            seed.Value = Request["seed"];
            txtCustomer.Focus();

        }

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            ControlsBinder();
            Binder();
        }
    }

    DataFactory dal = new DataFactory();
    readonly string SYS = "OE";


    #region ///刷新数据源

    public void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", SYS[0].ToString());
    }

    public void StoreVessel_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreVessel, "VesselList");
    }

    public void StoreVoyage_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        StoreVoyage.RemoveAll();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
        StoreVoyage.DataSource = dt;
        StoreVoyage.DataBind();
    }

    #endregion

    public XTemplate TempVoyage
    {
        get
        {
            XTemplate xt = new XTemplate();
            xt.Html = "<tpl for=\".\">" +
                      "<tpl if=\"[xindex] == 1\">" +
                          "<table class=\"cbStates-list\">" +
                              "<tr>" +
                                   "<th>Voyage</th>" +
                                  "<th>POL/POD</th>" +
                              "</tr>" +
                      "</tpl>" +
                          "<tr class=\"list-item\">" +
                          "<td style=\"padding:3px 0px; width:50%\">{text}</td>" +
                          "<td style=\"padding:3px 0px; width:50%\">{POL}/{POD}</td>" +
                      "</tr>" +
                      "<tpl if=\"[xcount-xindex]==0\">" +
                              "</table>" +
                     "</tpl></tpl>";
            return xt;
        }
    }
    /// <summary>
    /// 控件绑定
    /// </summary>
    #region   ///ComboBox 控件绑定     Author：Micro   (2011-09-27)
    void ControlsBinder()
    {

        ControlBinder.CmbBinder(StoreVessel, "VesselList");
        ControlBinder.CmbBinder(StoreLocation, "LocationList", SYS[0].ToString());

        cmbVesselText.Template.Html = TempVoyage.Html;
    }

    public XTemplate Template
    {
        get
        {
            XTemplate xt = new XTemplate();
            xt.Html = "<tpl for=\".\">" +
                      "<tpl if=\"[xindex] == 1\">" +
                          "<table class=\"cbStates-list\">" +
                              "<tr>" +
                                   "<th>Code</th>" +
                                  "<th>Name</th>" +
                              "</tr>" +
                      "</tpl>" +
                          "<tr class=\"list-item\">" +
                          "<td style=\"padding:3px 0px; width:30%\">{value}</td>" +
                          "<td style=\"padding:3px 0px; width:70%\">{text}</td>" +
                      "</tr>" +
                      "<tpl if=\"[xcount-xindex]==0\">" +
                              "</table>" +
                     "</tpl></tpl>";
            return xt;
        }
    }



    protected void cmbVessel_Select(object sender, DirectEventArgs e)
    {
        cmbVesselText.Text = "";
        ComList();
    }

    protected void cmbVesselText_Select(object sender, DirectEventArgs e)
    {
        if (cmbVesselText.SelectedItem.Value != "")
        {
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageByID").
                Append("STAT",cmbVesselText.SelectedItem.Value) }).GetTable();

            txtETD.Text = dt.Rows[0][2].ToString();
            txtPOD.setValue(dt.Rows[0][5].ToString());
            //cmbLoading.setValue(dt.Rows[0][4].ToString());
            //cmbPort.setValue(dt.Rows[0][5].ToString());
            //txtPOD.setValue(dt.Rows[0][5].ToString());
            //txtCFSClosing.Text = dt.Rows[0][6].ToString();
            //txtCYClosing.Text = dt.Rows[0][7].ToString();
            //txtOnBoard.Text = dt.Rows[0][8].ToString();
        }
    }

    void ComList()
    {
        StoreVoyage.RemoveAll();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
        StoreVoyage.DataSource = dt;
        StoreVoyage.DataBind();
        if (dt != null && dt.Rows.Count > 0)
        {
            cmbVesselText.SelectedItem.Value = dt.Rows[0][1].ToString();

            //txtCFSClosing.Text = dt.Rows[0][7].ToString();
            //txtCYClosing.Text = dt.Rows[0][8].ToString();
            //txtOnBoard.Text = dt.Rows[0][9].ToString();
            txtETD.Text = dt.Rows[0][2].ToString();
            txtPOD.setValue(dt.Rows[0][5].ToString());
            //cmbLoading.setValue(dt.Rows[0][4].ToString());
            //cmbPort.setValue(dt.Rows[0][5].ToString());
            //cmbFinalDest.setValue(dt.Rows[0][5].ToString());
        }
        else
        {
            //txtCFSClosing.Text = "";
            //txtCYClosing.Text = "";
            //txtOnBoard.Text = "";
            txtETD.Text = "";
            //txtETADischarge.Text = "";
            //cmbLoading.setValue("");
            //cmbPort.setValue("");
            txtPOD.setValue("");
        }
    }

    [DirectMethod]
    public void ShowVoyage()
    {
        X.AddScript("ShowVoyage('" + cmbVesselCode.SelectedItem.Value + "','" + cmbVesselText.SelectedItem.Value + "');");
    }

    [DirectMethod]
    public void BindVoyag(string id)
    {
        if (id != "")
        {
            StoreVoyage.RemoveAll();

            DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
            StoreVoyage.DataSource = dt1;
            StoreVoyage.DataBind();

            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageByID").
                Append("STAT",id) }).GetTable();

            cmbVesselText.SelectedItem.Value = id;
            //txtETD.Text = dt.Rows[0][2].ToString();
            //txtETADischarge.Text = dt.Rows[0][3].ToString();
            //cmbLoading.setValue(dt.Rows[0][4].ToString());
            //cmbPort.setValue(dt.Rows[0][5].ToString());
            //cmbFinalDest.setValue(dt.Rows[0][5].ToString());
            //txtCFSClosing.Text = dt.Rows[0][6].ToString();
            //txtCYClosing.Text = dt.Rows[0][7].ToString();
            //txtOnBoard.Text = dt.Rows[0][8].ToString();
        }
    }

    #endregion


    [DirectMethod]
    public void SetInfo(string typename, string code)
    {


        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_WarehouseEntry_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "getCompany").
                Append("co_code", code)  }).GetList();

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            if (typename == "txtwarehouse")
            {
                //labCpyRowID.Text = ds.Tables[0].Rows[0]["RowID"].ToString();
                txtwhseAdd.Text = ds.Tables[0].Rows[0]["Address1"].ToString();
                txtwhseAdd.Text += ds.Tables[0].Rows[0]["Address2"].ToString();
                txtwhseAdd.Text += ds.Tables[0].Rows[0]["Address3"].ToString();
                txtwhseAdd.Text += ds.Tables[0].Rows[0]["Address4"].ToString();
                txtWsheContact.Text = ds.Tables[0].Rows[0]["Contact"].ToString();
                txtWshePhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
                txtWsheFxt.Text = ds.Tables[0].Rows[0]["Fax"].ToString();
                txtWsheName.Text = ds.Tables[0].Rows[0]["Company"].ToString();
            }
            else if (typename == "txtHandle" || typename == "txtCompany")
            {
                //labCpyRowID.Text = ds.Tables[0].Rows[0]["RowID"].ToString();
                txtHandleAdd.Text = ds.Tables[0].Rows[0]["Address1"].ToString();
                txtHandleAdd.Text += ds.Tables[0].Rows[0]["Address2"].ToString();
                txtHandleAdd.Text += ds.Tables[0].Rows[0]["Address3"].ToString();
                txtHandleAdd.Text += ds.Tables[0].Rows[0]["Address4"].ToString();
                txtHandlContact.Text = ds.Tables[0].Rows[0]["Contact"].ToString();
                txtHandlPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
                txtHandlFxt.Text = ds.Tables[0].Rows[0]["Fax"].ToString();
                txtHandleName.Text = ds.Tables[0].Rows[0]["Company"].ToString();
                txtCompanyName.Text = ds.Tables[0].Rows[0]["Company"].ToString();
                txtCompany.setValue(code);
                txtHandle.setValue(code);

            }
            else if (typename == "txtCustomer")
            {
                txtCustomerLine.Text = ds.Tables[0].Rows[0]["Company"].ToString();

            }

        }

    }


    /// <summary>
    /// 初始数据
    /// </summary>
    public void Binder()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_WarehouseEntry_SP", new List<IFields>() { dal.CreateIFields()
                          .Append("Option", "select")
                          .Append("we_seed", seed.Value)
                          .Append("co_code",FSecurityHelper.CurrentUserDataGET()[12])
                          .Append("we_User",FSecurityHelper.CurrentUserDataGET()[0])
                          .Append("we_ROWID", rowid.Value)}).GetList();
        DataTable dt = ds.Tables[0];
        if (dt != null && ds.Tables.Count ==2 && ds.Tables[1].Rows[0][0].ToString() == "Y")
        {
            labImpLotNo.Text = dt.Rows[0]["lotno"].ToString();
            labMBL.Text = dt.Rows[0]["mbl"].ToString();
            txtCompany.setValue(dt.Rows[0]["we_Company"].ToString());
            txtCompanyName.Text = dt.Rows[0]["we_HandleName"].ToString();
            txtCustomer.setValue(dt.Rows[0]["we_Customer"].ToString());
            txtCustomerLine.Text = dt.Rows[0]["we_CustomerLine"].ToString();
            txtNoticeDate.Text = dt.Rows[0]["we_NoticeDate"].ToString();
            txtOperation.Text = dt.Rows[0]["we_OperationUser"].ToString();
            txtOpExt.Text = dt.Rows[0]["we_OperationExt"].ToString();
            txtDcument.Text = dt.Rows[0]["we_DocumnetUser"].ToString();
            txtDocExt.Text = dt.Rows[0]["we_DocumnetExt"].ToString();
            txtPhone.Text = dt.Rows[0]["we_ContactTel"].ToString();
            txtFax.Text = dt.Rows[0]["we_ContactFax"].ToString();
            txtPOD.setValue(dt.Rows[0]["we_POD"].ToString());

            cmbVesselCode.Text = dt.Rows[0]["we_Vessel"].ToString();
            StoreVoyage.RemoveAll();

            DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
            StoreVoyage.DataSource = dt1;
            StoreVoyage.DataBind();
            cmbVesselText.Template.Html = TempVoyage.Html;
            if (dt1 != null && dt1.Rows.Count > 0)
            {
                cmbVesselText.Value = dt.Rows[0]["we_Voyage"].ToString();
            }
            //cmbVesselText.Text = dt.Rows[0]["we_Voyage"].ToString();
            txtDeclareNo.Text = dt.Rows[0]["we_DeclareNo"].ToString();
            txtNoticeNo.Text = dt.Rows[0]["we_NoticeNo"].ToString();
            txtETD.Text = dt.Rows[0]["we_ETD"].ToString();

            txtWsheTime.Text = dt.Rows[0]["we_warehouseclosingtime"].ToString();
            txtHandleTime.Text = dt.Rows[0]["we_docmentclosingtime"].ToString();

            txtWhseClosing.Text = dt.Rows[0]["we_WarehouseClosing"].ToString();
            txtwarehouse.setValue(dt.Rows[0]["we_WarehouseCode"].ToString());
            txtWsheName.Text = dt.Rows[0]["we_WarehouseName"].ToString();
            txtwhseAdd.Text = dt.Rows[0]["we_WarehouseAddress"].ToString();
            txtWsheContact.Text = dt.Rows[0]["we_WarehousePerson"].ToString();
            txtWshePhone.Text = dt.Rows[0]["we_WarehouseTel"].ToString();
            txtWsheExt.Text = dt.Rows[0]["we_WarehouseExt"].ToString();
            txtWsheFxt.Text = dt.Rows[0]["we_WarehouseFax"].ToString();
            txtHandleClosing.Text = dt.Rows[0]["we_DocmentClosing"].ToString();
            txtHandle.setValue(dt.Rows[0]["we_HandleCode"].ToString());
            txtHandleName.Text = dt.Rows[0]["we_HandleName"].ToString();
            txtHandleAdd.Text = dt.Rows[0]["we_HandleAddress"].ToString();
            txtHandlContact.Text = dt.Rows[0]["we_HandlePerson"].ToString();
            txtHandlPhone.Text = dt.Rows[0]["we_HandleTel"].ToString();
            txtHandlExt.Text = dt.Rows[0]["we_HandleExt"].ToString();
            txtHandlFxt.Text = dt.Rows[0]["we_HandleFax"].ToString();

            ControlBinder.pageTitleMsg(false, this, "<p class=\"success\">Status : Edit warehouse information.</p>", div_bottom);

        }
        else if (ds != null && ds.Tables.Count==5 && ds.Tables[1].Rows.Count>0 && ds.Tables[4].Rows[0][0].ToString() == "N")
        {
            labImpLotNo.Text = ds.Tables[1].Rows[0]["lotno"].ToString();
            labMBL.Text =  ds.Tables[1].Rows[0]["mbl"].ToString();

            txtCompany.setValue(ds.Tables[3].Rows[0]["we_Company"].ToString());
            txtCompanyName.Text = ds.Tables[3].Rows[0]["we_CompanyName"].ToString();
            txtCustomer.Text = "";
            txtCustomerLine.Text = "";
            txtNoticeDate.Text = ds.Tables[1].Rows[0]["we_NoticeDate"].ToString();
            txtOperation.Text = ds.Tables[2].Rows[0]["we_OperationUser"].ToString();
            txtOpExt.Text = ds.Tables[2].Rows[0]["we_OperationExt"].ToString();
            txtDcument.Text = "";
            txtDocExt.Text = "";
            txtPhone.Text = "";
            txtFax.Text = "";
            txtPOD.setValue(ds.Tables[1].Rows[0]["we_POD"].ToString());

            cmbVesselCode.Text = ds.Tables[1].Rows[0]["we_Vessel"].ToString();
            StoreVoyage.RemoveAll();

            DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() { 
                dal.CreateIFields().Append("Option", "VoyageList").
                Append("sys", FSecurityHelper.CurrentUserDataGET()[12]).
                Append("STAT",cmbVesselCode.Text) }).GetTable();
            StoreVoyage.DataSource = dt1;
            StoreVoyage.DataBind();
            cmbVesselText.Template.Html = TempVoyage.Html;
            if (dt1 != null && dt1.Rows.Count > 0)
            {
                cmbVesselText.Value = ds.Tables[1].Rows[0]["we_Voyage"].ToString();
            }
            //cmbVesselText.Text = dt.Rows[0]["we_Voyage"].ToString();
            txtDeclareNo.Text = "";
            txtNoticeNo.Text = ds.Tables[1].Rows[0]["we_NoticeNo"].ToString();
            txtETD.Text = ds.Tables[1].Rows[0]["we_ETD"].ToString();

            ////txtWsheTime.Text = "";
            //txtHandleTime.Text = "";

            txtWhseClosing.Text = "";
            txtwarehouse.setValue(ds.Tables[0].Rows[0]["we_WarehouseCode"].ToString());
            txtWsheName.Text = ds.Tables[0].Rows[0]["we_WarehouseName"].ToString();
            txtwhseAdd.Text = ds.Tables[0].Rows[0]["we_WarehouseAddress"].ToString();
            txtWsheContact.Text = ds.Tables[0].Rows[0]["we_WarehousePerson"].ToString();
            txtWshePhone.Text = ds.Tables[0].Rows[0]["we_WarehouseTel"].ToString();
            txtWsheExt.Text = ds.Tables[0].Rows[0]["we_WarehouseExt"].ToString();
            txtWsheFxt.Text = ds.Tables[0].Rows[0]["we_WarehouseFax"].ToString();
            txtHandleClosing.Text = "";
            txtHandle.setValue(ds.Tables[3].Rows[0]["we_Company"].ToString());
            txtHandleName.Text = ds.Tables[3].Rows[0]["we_CompanyName"].ToString();
            txtHandleAdd.Text = ds.Tables[3].Rows[0]["we_HandleAddress"].ToString();
            txtHandlContact.Text = ds.Tables[3].Rows[0]["we_HandlePerson"].ToString();
            txtHandlPhone.Text = ds.Tables[3].Rows[0]["we_HandleTel"].ToString();
            txtHandlExt.Text = "";
            txtHandlFxt.Text = ds.Tables[3].Rows[0]["we_HandleFax"].ToString();
            ControlBinder.pageTitleMsg(false, "New WareHouse", "<p>Status : New blank wareHouse information. </p>", div_bottom);
        }
        else
        {
            Response.Write("Error: invalid parameter, please check the data.");
            Response.End();
            Response.Flush();
            Response.Clear();
        }

    }

    public void btnSave_Click(object send, DirectEventArgs e)
    {
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_WarehouseEntry_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "Update")
                .Append("we_ROWID",rowid.Value)
                .Append("we_Seed",seed.Value)
                .Append("we_Company", txtCompany.Value.ToUpper())
                .Append("we_Customer", txtCustomer.Value.ToUpper())
                .Append("we_CustomerLine",txtCustomerLine.Text.ToUpper())
                .Append("we_NoticeDate", ControlBinder.getDate(txtNoticeDate.RawText.StartsWith("0001")?DBNull.Value:(object)txtNoticeDate.RawText))
                .Append("we_OperationUser",txtOperation.Text.ToUpper())
                .Append("we_OperationExt", txtOpExt.Text.ToUpper())
                .Append("we_DocumnetUser", txtDcument.Text.ToUpper())
                .Append("we_DocumnetExt", txtDocExt.Text.ToUpper())
                .Append("we_ContactTel", txtPhone.Text.ToUpper())
                .Append("we_ContactFax", txtFax.Text.ToUpper())
                .Append("we_POD", txtPOD.Text)
                .Append("we_PODLine", txtPOD.Value)
                .Append("we_Vessel", cmbVesselCode.Text.ToUpper())
                .Append("we_Voyage", cmbVesselText.Text.ToUpper())
                .Append("we_DeclareNo", txtDeclareNo.Text.ToUpper())
                .Append("we_NoticeNo", txtNoticeNo.Text.ToUpper())
                .Append("we_ETD",ControlBinder.getDate(txtETD.RawText.StartsWith("0001")?DBNull.Value:(object)txtETD.RawText))
                .Append("we_WarehouseClosing", ControlBinder.getDate(txtWhseClosing.RawText.StartsWith("0001")?DBNull.Value:(object)txtWhseClosing.RawText))
                .Append("we_WarehouseCode",txtwarehouse.Value.ToUpper())
                .Append("we_WarehouseName",txtWsheName.Text.ToUpper())
                .Append("we_WarehouseAddress",txtwhseAdd.Text.ToUpper())
                .Append("we_WarehousePerson",txtWsheContact.Text.ToUpper())
                .Append("we_WarehouseTel",txtWshePhone.Text.ToUpper())
                .Append("we_WarehouseExt", txtWsheExt.Text.ToUpper())
                .Append("we_WarehouseFax", txtWsheFxt.Text.ToUpper())
                .Append("we_DocmentClosing",  ControlBinder.getDate( txtHandleClosing.RawText.StartsWith("0001")?DBNull.Value:(object)txtHandleClosing.RawText))
                .Append("we_HandleCode", txtHandle.Value.ToUpper())
                .Append("we_HandleName", txtHandleName.Text.ToUpper())
                .Append("we_HandleAddress",txtHandleAdd.Text.ToUpper())
                .Append("we_HandlePerson", txtHandlContact.Text.ToUpper())
                .Append("we_HandleTel",txtHandlPhone.Text.ToUpper())
                .Append("we_HandleExt",txtHandlExt.Text.ToUpper())
                .Append("we_HandleFax",txtHandlFxt.Text.ToUpper())  
              
                .Append("we_warehouseclosingtime",txtWsheTime.SelectedItem.Text)
                .Append("we_docmentclosingtime",txtHandleTime.SelectedItem.Text)  

                .Append("we_User",FSecurityHelper.CurrentUserDataGET()[0])}).Update();

        //if (dt.Rows[0]["flag"].ToString() == "Y")
        //{
        //    ControlBinder.pageTitleMsg(false, this, "<p class=\"success\">Status :  Saved successfully.</p>", div_bottom);
        //    Response.Redirect("WareHouse.aspx?seed=" + seed.Value + "&rowid=" + dt.Rows[0]["rowid"].ToString());
        //}
        //else if (dt.Rows[0]["flag"].ToString() == "N")
        //    ControlBinder.pageTitleMsg(false, this, "<p class=\"success\">Status :  Saved successfully.</p>", div_bottom);
        //else
        //    ControlBinder.pageTitleMsg(false, this, "<p class=\"error\">Status : Saved failed， please check the data.  </p>", div_bottom);
        redirect = b;

        if (b)
        {
            ControlBinder.pageTitleMsg(false, this, "<p class=\"success\">Status :  Saved successfully.</p>", div_bottom);
        }
        else
            ControlBinder.pageTitleMsg(false, this, "<p class=\"error\">Status : Saved failed， please check the data.  </p>", div_bottom);
    }

    public void btnCancel_Click(object send, DirectEventArgs e)
    {
        Binder();
    }

    bool redirect = false;
    public void btnPrint_Click(object send, DirectEventArgs e)
    {
        redirect = false;

        btnSave_Click(send, e);
        if (redirect)
        {
            X.AddScript("window.open('/OceanExport/OEReportFile/ReportFile.aspx?type=InWarehouse&ID=" + seed.Value + "','_blank')");
        }
    }
}
