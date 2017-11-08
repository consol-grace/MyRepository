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

public partial class OceanExport_OEContainerList_Container : System.Web.UI.Page
{
    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                CmbUnit.setValue("PKG");
                txtMarks2.Width = Unit.Parse(Setwidth());
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


    private string Setwidth()
    {
        string width = "332px";
        HttpBrowserCapabilities b =Request.Browser;

        string browser = b.Browser;
        string version = b.Version;
        if (browser.ToUpper() == "IE" && version.StartsWith("9.0"))
        {
            width = "340px";
            divWidth.Style.Add("width", "590px");
        }
        return width;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            txtContainer.Focus(true);
            hidID.Text = Request["ID"] == null ? "-1" : Request["ID"];
            hidHBL.Text = Request["HBL"] == null ? "-1" : Request["HBL"];

            DataFactory dal = new DataFactory();
            string f = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ContainerSize_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "CheckISOCode").Append("ctnr_STAT", FSecurityHelper.CurrentUserDataGET()[12]) }).GetTable().Rows[0][0].ToString();
            if (f == "Y")
            {               
                X.Msg.Alert("Status", "Any record of Container' EDI is blank, please fill in the EDI data completely before entry Shipment.", "CompanyX.UserControlTop1.ShowLink('Container Size','443,480,/BasicData/ContainerSize/ContainerSize.aspx?sys=O')").Show();
            }
        }
    }

    readonly string SYS = "OE";

    #region ///刷新数据源
    public void StoreUnit_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreUnit, "UnitBindingContainer", SYS[0].ToString());
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
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "List").Append("oc_ROWID",hidID.Text)
            .Append("oc_ToHBL",Request["HBL"])
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            string temphawb = ds.Tables[0].Rows[0]["HBL"].ToString().ToUpper() == "" ? "" : "HBL# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["HBL"].ToString().ToUpper() + "</span>";
            string tempmawb = ds.Tables[0].Rows[0]["MBL"].ToString().ToUpper() == "" ? "" : "MBL# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["MBL"].ToString().ToUpper() + "</span>";
            string tempLotNo = ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() == "" ? "" : "Lot# " + "<span style='color:#ff0000;'>" + ds.Tables[0].Rows[0]["LotNo"].ToString().ToUpper() + "</span>";
            labHeader.Html = (temphawb == "" ? "" : "<span style='padding-left:10px'>" + temphawb + "</span>") + (tempmawb == "" ? "" : "<span style='padding-left:10px'>" + tempmawb + "</span>") + (tempLotNo == "" ? "" : "<span style='padding-left:10px'>" + tempLotNo + "</span>");

            chkIsMain.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["oc_isMain"]);
            txtContainer.Text = ds.Tables[0].Rows[0]["oc_CtnrNo"].ToString();
            txtSeal.Text = ds.Tables[0].Rows[0]["oc_SealNo"].ToString();
            CmbSize.setValue(ds.Tables[0].Rows[0]["oc_CtnrSize"].ToString());
            CmbSerMode.setValue(ds.Tables[0].Rows[0]["oc_Servicemode"].ToString());
            txtSO.Text = ds.Tables[0].Rows[0]["oc_SONo"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["oc_GWT"].ToString()))
            txtGWT.Text = ds.Tables[0].Rows[0]["oc_GWT"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["oc_CBM"].ToString()))
            txtCBM.Text = ds.Tables[0].Rows[0]["oc_CBM"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["oc_Piece"].ToString()))
            txtPiece.Text = ds.Tables[0].Rows[0]["oc_Piece"].ToString();
            CmbUnit.setValue(ds.Tables[0].Rows[0]["oc_Unit"].ToString());
            txtMarks1.Text = ds.Tables[0].Rows[0]["oc_OrderMarks"].ToString();
            txtMarks2.Text = ds.Tables[0].Rows[0]["oc_OrderDescription"].ToString();
            txtmarks3.Text = ds.Tables[0].Rows[0]["oc_OrderNoOfPackage"].ToString();
            lblPiece.Text = txtPiece.Text;
            //lblUnit.Text = ds.Tables[0].Rows[0]["oc_Unit"].ToString();
            X.AddScript("var r = StoreUnit.getById($('#CmbUnit').val());if(!Ext.isEmpty(r)){#{lblUnit}.setValue(r.data.short);}");
            txtRemark.Text = ds.Tables[0].Rows[0]["oc_Remark"].ToString();
            if (string.IsNullOrEmpty(Request["ID"]))
                ControlBinder.pageTitleMsg(false, "OE-C  New", "<p>Status: New Blank Container .</p>", div_bottom);
            else
                ControlBinder.pageTitleMsg(false, "OE-C:" + txtContainer.Text, "<p>Status: Edit Container of  <span>" + txtContainer.Text.ToUpper() + "</span>.</p>", div_bottom);
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "OE-C  New", "<p>Status: New Blank Container .</p>", div_bottom);
        }

    }
    #endregion

    #region   ComboBoxBinding()    Author ：Hcy   (2011-09-27)
    private void ComboBoxBinding()
    {
        ControlBinder.CmbBinder(StoreServiceMode, "ServerMode", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreUnit, "UnitBindingContainer", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreDes, "Description", SYS[0].ToString());
        ControlBinder.CmbBinder(StoreCN, "ContainerSize", SYS[0].ToString());
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetContainerInfo").Append("oc_ToHBL",Request["HBL"])
        }).GetList();
        StoreCNNO.DataSource = ds;
        StoreCNNO.DataBind();
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
        DataFactory dal = new DataFactory();

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
            .Append("oc_CtnrNo",txtContainer.Text.ToUpper().Trim())
            .Append("oc_CtnrSize",CmbSize.Value)
            .Append("oc_SealNo",txtSeal.Text.Trim().ToUpper())
            .Append("oc_Servicemode",CmbSerMode.Value)
            .Append("oc_SONo",txtSO.Text.Trim().ToUpper())
            .Append("oc_GWT",string.IsNullOrEmpty(txtGWT.Text)?DBNull.Value:(object)txtGWT.Text)
            .Append("oc_CBM",string.IsNullOrEmpty(txtCBM.Text)?DBNull.Value:(object)txtCBM.Text)
            .Append("oc_Piece",string.IsNullOrEmpty(txtPiece.Text)?DBNull.Value:(object)txtPiece.Text)
            .Append("oc_Unit",CmbUnit.Value)
            .Append("oc_OrderMarks",ControlBinder.GetMakeStr(txtMarks1.Text.TrimEnd().ToUpper(), 19))
            .Append("oc_OrderNoOfPackage",ControlBinder.GetMakeStr(txtmarks3.Text.TrimEnd().ToUpper(), 10))
            .Append("oc_OrderDescription",ControlBinder.GetMakeStr(txtMarks2.Text.TrimEnd().ToUpper(),46))
            //.Append("oc_OrderDescription",txtMarks2.Text.TrimEnd().ToUpper().Replace("\r\n","\n"))
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
            
            ControlBinder.pageTitleMsg(true, "OE-C:" + txtContainer.Text, "<p class=\"success\">Status : Record Saved with  <span>" + txtContainer.Text.ToUpper() + " </span> </p>", div_bottom);
            
            if (b)
            {
                b = false;
                X.Redirect("Container.aspx?HBL=" + Request["HBL"]);
            }

            if (flag.Trim() == "Insert")
            {
                X.Redirect("Container.aspx?ID=" + rowID + "&HBL=" + Request["HBL"]);
            }
            else
            {
                DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields>() { dal.CreateIFields()
             .Append("Option", "GetContainerInfo").Append("oc_ToHBL",Request["HBL"])
             }).GetList();
                StoreCNNO.DataSource = ds;
                StoreCNNO.DataBind();
            }

            lblPiece.Text = txtPiece.Text;
            //lblUnit.Text = CmbUnit.Value;
            X.AddScript("var r = StoreUnit.getById($('#CmbUnit').val());#{lblUnit}.setValue(r.data.short);");
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "OE-C:" + txtContainer.Text.ToUpper(), "<p class=\"error\">Status : Save failed, please check the data . </p>", div_bottom);
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
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (hidID.Text != "-1")
        {
            DataFactory dal = new DataFactory();
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete")
                 .Append("oc_ROWID",hidID.Text).Append("oc_User",FSecurityHelper.CurrentUserDataGET()[0])
          }).Update();
            if (b)
            {
                ControlBinder.pageTitleMsg(true, "OE-C:" + txtContainer.Text.ToUpper(), "<p class=\"success\">Status : Delete successfully . </p>", div_bottom);
                //X.Redirect("Container.aspx?HBL=" + Request["HBL"]);
                X.AddScript("window.opener=null;window.open('','_self');window.close();");
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "OE-C:" + txtContainer.Text.ToUpper(), "<p class=\"error\">Status : Delete failed, please check the data . </p>", div_bottom);
            }
        }

    }
    #endregion

    [DirectMethod]
    public void btnDelete_Click()
    {
        if (hidID.Text != "-1")
        {
            DataFactory dal = new DataFactory();
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_Container_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete")
                 .Append("oc_ROWID",hidID.Text).Append("oc_User",FSecurityHelper.CurrentUserDataGET()[0])
          }).Update();
            if (b)
            {
                ControlBinder.pageTitleMsg(true, "OE-C:" + txtContainer.Text.ToUpper(), "<p class=\"success\">Status : Delete successfully . </p>", div_bottom);
                X.AddScript("window.opener=null;window.open('','_self');window.close();");
            }
            else
            {
                ControlBinder.pageTitleMsg(false, "OE-C:" + txtContainer.Text.ToUpper(), "<p class=\"error\">Status : Delete failed, please check the data . </p>", div_bottom);
            }
        }
    }

    protected void CmbDescripSelect_Click(object sender, EventArgs e)
    {
        txtMarks2.Text = CmbDescrip.SelectedItem.Text + "\r\n" + txtMarks2.Text;
        txtMarks2.Focus();
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
