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

public partial class OceanImport_OceanShipmentJobList_Container : System.Web.UI.Page
{

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                CmbUnit.setValue("PKG");

                ComboBoxBinding();
                DataBinder();
                LockControl();
            }
        }
    }

    protected void LockControl()
    {
        if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToString() == "ACCOUNT")
        {
            btnSave.Disabled = true;
            btnCancel.Disabled = true;
            btnNext.Disabled = true;
            btnDelete.Disabled = true;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            txtContainer.Focus(true);
            hidID.Text = Request["ID"] == null ? "-1" : Request["ID"];
            hidHBL.Text = Request["HBL"] == null ? "-1" : Request["HBL"];
        }
    }

    readonly string SYS = "OI";

    #region ///刷新数据源
    public void StoreUnit_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", SYS[0].ToString());
    }
    public void StoreServiceMode_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreServiceMode, "ServerMode", SYS[0].ToString());
    }
    public void StoreCN_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreCN, "ContainerSize", SYS[0].ToString());
    }

    #endregion

    #region  DataBinder()   Author：Hcy  (2011-09-30)
    void DataBinder()
    {
        txtContainer.Focus(true);

        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Container_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "List").Append("oc_ROWID",hidID.Text)
            .Append("oc_ToHBL",Request["HBL"])
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            txtContainer.Text = ds.Tables[0].Rows[0]["oc_CtnrNo"].ToString();
            txtSeal.Text = ds.Tables[0].Rows[0]["oc_SealNo"].ToString();
            CmbSize.setValue(ds.Tables[0].Rows[0]["oc_CtnrSize"].ToString());
            CmbSerMode.setValue(ds.Tables[0].Rows[0]["oc_Servicemode"].ToString());
            txtSO.Text = ds.Tables[0].Rows[0]["oc_SONo"].ToString();
            txtGWT.Text = ds.Tables[0].Rows[0]["oc_GWT"].ToString();
            txtCBM.Text = ds.Tables[0].Rows[0]["oc_CBM"].ToString();
            txtPiece.Text = ds.Tables[0].Rows[0]["oc_Piece"].ToString();
            CmbUnit.setValue(ds.Tables[0].Rows[0]["oc_Unit"].ToString());
            txtMarks1.Text = ds.Tables[0].Rows[0]["oc_OrderMarks"].ToString();
            txtMarks2.Text = ds.Tables[0].Rows[0]["oc_OrderDescription"].ToString();
            txtmarks3.Text = ds.Tables[0].Rows[0]["oc_OrderNoOfPackage"].ToString();
            lblPiece.Text = ds.Tables[0].Rows[0]["oc_Piece"].ToString();
            lblUnit.Text = ds.Tables[0].Rows[0]["oc_Unit"].ToString();
            txtRemark.Text = ds.Tables[0].Rows[0]["oc_Remark"].ToString();
            if (string.IsNullOrEmpty(Request["ID"]))
                ControlBinder.pageTitleMsg(false, "OI-C  New", "<p>Status: New Blank Container .</p>", div_bottom);
            else
                ControlBinder.pageTitleMsg(false, "OI-C:" + txtContainer.Text, "<p>Status: Edit Container of  <span>" + txtContainer.Text + "</span>.</p>", div_bottom);
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "OI-C  New", "<p>Status: New Blank Container .</p>", div_bottom);
        }

    }
    #endregion

    #region   ComboBoxBinding()    Author ：Hcy   (2011-09-27)
    private void ComboBoxBinding()
    {
        ControlBinder.CmbBinder(StoreServiceMode, "ServerMode", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreDes, "Description", "OI");
        ControlBinder.CmbBinder(StoreCN, "ContainerSize", SYS[0].ToString());
    }
    #endregion

    #region  btnNext_Click(object, EventArgs) Author：Hcy  (2011-09-30)
    bool b = false;
    protected void btnNext_Click(object sender, EventArgs e)
    {
        b = true;
        btnSave_Click(sender, e);
        //hidID.Text = "";
        //txtContainer.Text = "";
        //txtContainer.Focus();
    }
    #endregion

    #region  btnSave_Click(object, EventArgs) Author：Hcy  (2011-09-30)
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (string.IsNullOrEmpty(txtContainer.Text))
        //{
        //    div_bottom.Html = "<p class=\"error\">Status : Save failed, Container  can't for empty .</p>";
        //    txtContainer.Focus();
        //    return;
        //}

        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Container_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
            .Append("oc_CtnrNo",txtContainer.Text.ToUpper().Trim())
            .Append("oc_CtnrSize",CmbSize.Value)
            .Append("oc_SealNo",txtSeal.Text.Trim().ToUpper())
            .Append("oc_Servicemode",CmbSerMode.Value)
            .Append("oc_SONo",txtSO.Text.Trim().ToUpper())
            .Append("oc_GWT",string.IsNullOrEmpty(txtGWT.Text)?DBNull.Value:(object)txtGWT.Text)
            .Append("oc_CBM",string.IsNullOrEmpty(txtCBM.Text)?DBNull.Value:(object)txtCBM.Text)
            .Append("oc_Piece",string.IsNullOrEmpty(txtPiece.Text)?DBNull.Value:(object)txtPiece.Text)
            .Append("oc_Unit",CmbUnit.Value)
            .Append("oc_OrderMarks",txtMarks1.Text.ToUpper().Replace("\r\n","\n"))
            .Append("oc_OrderNoOfPackage",txtmarks3.Text.ToUpper().Replace("\r\n","\n"))
            .Append("oc_OrderDescription",txtMarks2.Text.ToUpper().Replace("\r\n","\n"))
            .Append("oc_Remark",txtRemark.Text.ToUpper().Replace("\r\n","\n"))
            .Append("oc_STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("oc_SYS",SYS)
            .Append("oc_User",FSecurityHelper.CurrentUserDataGET()[0])
            .Append("oc_ToHBL",hidHBL.Text)
            .Append("oc_ROWID",hidID.Text)
        }).GetTable();
        if (dt != null)
        {
            string rowID = dt.Rows[0][0].ToString();
            string flag = dt.Rows[0][1].ToString();

            ControlBinder.pageTitleMsg(true, "OI-C:" + txtContainer.Text, "<p class=\"success\">Status : Record Saved with  <span>" + txtContainer.Text + " </span> </p>", div_bottom);

            if (b)
            {
                b = false;
                X.Redirect("Container.aspx?HBL=" + Request["HBL"]);
                return;
            }

            if (flag.Trim() == "Insert")
                //X.Msg.Alert("status", " Saved successfully").Show();
                X.Redirect("Container.aspx?ID=" + rowID + "&HBL=" + Request["HBL"]);

            lblPiece.Text = txtPiece.Text;
            lblUnit.Text = CmbUnit.Value;
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "OI-C:" + txtContainer.Text, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
        }
    }
    #endregion

    #region  btnCancel_Click(object, EventArgs) Author：Hcy  (2011-09-30)
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        DataBinder();
        txtContainer.Focus();
    }
    #endregion

    #region  btnDelete_Click(object, EventArgs) Author：Hcy  (2011-09-30)
    [DirectMethod(Namespace="CompanyX")]
    public void btnDelete_Click()
    {
        DataFactory dal = new DataFactory();
        DataTable dt  = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanImport_Container_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete")
                 .Append("oc_ROWID",hidID.Text).Append("oc_User",FSecurityHelper.CurrentUserDataGET()[0])
        }).GetTable();
        if (dt!=null&&dt.Rows.Count>0)
        { //X.Msg.Alert("status", " Delete successfully").Show();
            ControlBinder.pageTitleMsg(true, "OI-C:" + txtContainer.Text, "<p class=\"success\">Status : Delete successfully . </p>", div_bottom);
            X.Redirect("OceanShipmentHouse.aspx?MBL=" + dt.Rows[0]["HBL"] + "&seed=" + dt.Rows[0]["MBL"]);
        }
        else
            ControlBinder.pageTitleMsg(false, "OI-C:" + txtContainer.Text, "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);

    }
    #endregion


    protected void CmbDescripSelect_Click(object sender, EventArgs e)
    {
        txtMarks2.Text = CmbDescrip.SelectedItem.Text + "\n\r" + txtMarks2.Text;
    }

    protected void imgDes_Click(object sender, EventArgs e)
    {
        var win = new Window
        {
            ID = "Window1",
            Title = "Description",
            Width = Unit.Pixel(445),
            Height = Unit.Pixel(550),
            Modal = true,
            BodyStyle = "background-color: #fff;",
            Padding = 5
        };

        win.AutoLoad.Url = "ContainerDetail.aspx";
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Listeners.Hide.Handler = "CompanyX.SetDes()";
        win.Render(this.Form);
        win.Show();
    }

    [DirectMethod]
    public void SetDes()
    {
        ControlBinder.CmbBinder(StoreDes, "Description", true);
    }
}
