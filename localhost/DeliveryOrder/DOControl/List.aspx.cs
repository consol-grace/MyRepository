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

public partial class DeliveryOrder_DOControl_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            //ACShipper.Disabled = false;
            hidSeed.Text = string.IsNullOrEmpty(Request["Seed"]) ? "0" : Request["Seed"];
            ControlBinder.DateFormat(txtDate);
            txtDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
            txtDate.RawText = DateTime.Now.ToString("yyyy/MM/dd");
         
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
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Control_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List")
                   .Append("Seed", hidSeed.Text=="0"?(object)DBNull.Value:(object)hidSeed.Text)

        }).GetList();

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {

            DataBinder(ds.Tables[0]);

            storeList.DataSource = ds.Tables[1];
            storeList.DataBind();

            ControlBinder.pageTitleMsg(true, "DO:" + labDO.Text, "<p>Status : Edit DO of <span>" + labDO.Text + "</span></p>", div_bottom);
        }
        else
        {
            ControlBinder.pageTitleMsg(false, "DO:New", "<p>Status : New Blank DO </p>", div_bottom);
        }


    }

    void DataBinder(DataTable dtDO)
    {
        if (dtDO == null || dtDO.Rows.Count == 0)
        {
            return;
        }

        labDO.Text = dtDO.Rows[0]["DO"].ToString();
        txtDate.Text = Convert.ToDateTime(dtDO.Rows[0]["OrderDate"]).ToString("yyyy/MM/dd");
        ACCompany.Text = dtDO.Rows[0]["CompanyName"].ToString();
        ACCompany.setValue(dtDO.Rows[0]["Company"].ToString());
        cmbType.SetValue(dtDO.Rows[0]["TruckType"].ToString());
        txtAddress.Text = dtDO.Rows[0]["ADDR"].ToString();
        txtPallets.Text = string.IsNullOrEmpty(dtDO.Rows[0]["Pallets"].ToString())? "" : dtDO.Rows[0]["Pallets"].ToString();



        if (string.IsNullOrEmpty(dtDO.Rows[0]["Pallets"].ToString()))
        {
            txtPallets.Clear();
        }
        else 
        {
            txtPallets.Text = dtDO.Rows[0]["Pallets"].ToString();
        }

        if (string.IsNullOrEmpty(dtDO.Rows[0]["Cost"].ToString()))
        {
            txtCost.Clear();
        }
        else
        {
            txtCost.Text = dtDO.Rows[0]["Cost"].ToString();
        }

        txtRemark.Text = dtDO.Rows[0]["DORemark"].ToString();
        ACShipper.Text = dtDO.Rows[0]["ShipperName"].ToString();
        ACShipper.setValue(dtDO.Rows[0]["DOShipper"].ToString());

        if (dtDO.Rows[0]["IsVoid"].ToString().ToUpper() == "FALSE")
        {
            X.AddScript("$('#img_void').css('display','none');");
            btnSave.Disabled = false;
            btnCancel.Disabled = false;
            btnNext.Disabled = false;
            btnVoid.Text = "Void";
            hidVoid.Text = "0";
        }
        else
        {
            X.AddScript("$('#img_void').css('display','inline');");
            btnSave.Disabled = true;
            btnCancel.Disabled = true;
            btnNext.Disabled = true;
            btnVoid.Text = "Active";
            hidVoid.Text = "1";
        }


    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }

    /// <summary>
    /// Button 事件    VOID
    /// </summary>   
    protected void btnVoid_Click(object sender, DirectEventArgs e)
    {

        if (hidVoid.Text == "0")
        {
            X.Msg.Confirm("Information", "Are you sure you want to be void?", "if (buttonId == 'yes') { CompanyX.btnVoid_Click(); }").Show();
        }
        else
        {
            X.Msg.Confirm("Information", "Are you sure you want to be active?", "if (buttonId == 'yes') { CompanyX.btnVoid_Click(); }").Show();
        }
    }

    [DirectMethod]
    public void btnVoid_Click()
    {
        string seedid = hidSeed.Text;
        hidDelByRowId.Text = "";
        //if (!VoidCheckAC.CheckisAC("DO", hidSeed.Text))
        //{
        //    X.MessageBox.Alert("Status", VoidCheckAC.Message).Show();
        //    return;
        //}

        if (seedid.Length > 1)
        {
            string voidflag = hidVoid.Text == "0" ? "Y" : "N";
            DataSet l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallVoid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "D").Append("VoidFlag",voidflag)
            .Append("seed",hidSeed.Text=="" ? null:hidSeed.Text)}).GetList();
            if (l == null)
            {
                ControlBinder.pageTitleMsg(false, "DO:" + labDO.Text, "<p class=\"error\"> Status : Void failed , please check the data .   </p>", div_bottom);
            }
            DataBinder();
            ControlBinder.pageTitleMsg(true, "DO:" + labDO.Text, "<p>Status : Edit DO of <span>" + labDO.Text + "</span></p>", div_bottom);

        }
    }

    /// <summary>
    /// 还原
    /// </summary>    
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        hidDelByRowId.Text = ""; //点击DELETE之后，SAVE之前点了CANCEL，如果不清空DEL的值，就会将刚刚DELETE的那行给删除
        DataBinder();
    }

    #region
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        btnSave_Click(sender, e);

        X.Redirect("List.aspx");
    }
    #endregion

    #region    btnSave_Click()
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        DataTable grid = JSON.Deserialize<DataTable>(e.ExtraParams["grid"]);

        if (gridList.Store.Count > 0)
        {
            for (int i = 0; i < grid.Rows.Count; ++i)
            {
                if (grid.Rows[i]["DODCTNS"].ToString() != "" || grid.Rows[i]["DODGW"].ToString() != "" || grid.Rows[i]["DODCBM"].ToString() != "")
                {
                    DataTable dtGrid = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Control_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                       .Append("IsGetSeedKey", 1)
                       .Append("Seed", hidSeed.Text=="0"? "0" :hidSeed.Text.Trim())
                       .Append("DOSys","DO")
                       .Append("DODSys", grid.Rows[i]["DodSys"].ToString())
                       .Append("ToMaster", DBNull.Value)
                       .Append("ToHouse", DBNull.Value)
                       .Append("BookingNo", grid.Rows[i]["BookingNo"].ToString().ToUpper())
                       .Append("SPL", grid.Rows[i]["SPL"].ToString().ToUpper()== "TRUE" ? 1 : 0)
                       .Append("PO", grid.Rows[i]["PO"].ToString().ToUpper())
                       .Append("DODShipper", grid.Rows[i]["DODShipper"].ToString().ToUpper())
                       .Append("Consignee", grid.Rows[i]["DODConsignee"].ToString().ToUpper())
                       .Append("DODCTNS",  string.IsNullOrEmpty(grid.Rows[i]["DODCTNS"].ToString()) ? DBNull.Value : (object)grid.Rows[i]["DODCTNS"])
                       .Append("DODGW", string.IsNullOrEmpty(grid.Rows[i]["DODGW"].ToString()) ? DBNull.Value : (object)grid.Rows[i]["DODGW"])
                       .Append("DODCBM", string.IsNullOrEmpty(grid.Rows[i]["DODCBM"].ToString()) ? DBNull.Value : (object)grid.Rows[i]["DODCBM"])
                       .Append("IsOutstand", 1)
                       .Append("IsShipment", grid.Rows[i]["BookingNo"].ToString() == "" ? 0 : 1)
                       .Append("IsAC", 0)
                       .Append("CrUser",FSecurityHelper.CurrentUserDataGET()[0])
                       .Append("LastUser",FSecurityHelper.CurrentUserDataGET()[0])
                       .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
                       .Append("DODRemark","")
                       .Append("RowID",Convert.ToInt32(grid.Rows[i]["ROWID"]))
                   }).GetTable();

                    if (dtGrid == null)
                    {
                        div_bottom.Html = "<p class='error'>Status: Saved failed , please check the grid data ! </p>";

                        return;
                    }

                }
                else
                {
                    div_bottom.Html = "<p class='error'> Save failed , CTNS or GW or VOL/CBM is empty!</p>";

                    return;
                }
            }
        }

        if (hidDelByRowId.Text != "")
        {
            string a = hidDelByRowId.Text.Substring(0, hidDelByRowId.Text.Length - 1);
            DataTable dtDel = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Control_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Delete")
                   .Append("DeleteByRowID",a)
                   //.Append("DOSys","DO")
                   //.Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
            }).GetTable();

            if (dtDel != null && Convert.ToInt32(dtDel.Rows[0]["c"]) > 0)
            {
                div_bottom.Html = "<p class='success'>Status : Saved successful . </p>";
            }
            else
            {
                div_bottom.Html = "<p class='error'> Delete failed , please check the data !</p>";

                return;
            }

        }

        DataTable dtDO = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Control_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                   .Append("Seed", hidSeed.Text=="0"?(object)DBNull.Value:(object)hidSeed.Text)
                   .Append("DOSys","DO")
                   .Append("OrderDate", ControlBinder.getDate(string.IsNullOrEmpty(txtDate.RawText.Trim()) ? "1900/01/01" : (object)txtDate.RawText.Trim()))
                   .Append("Company", string.IsNullOrEmpty(ACCompany.Value)? "": ACCompany.Value.Trim())
                   .Append("TruckType", string.IsNullOrEmpty(cmbType.Text)? "": cmbType.Text.Trim())
                   .Append("DOShipper",string.IsNullOrEmpty(ACShipper.Value)? "": ACShipper.Value.Trim())
                   .Append("Address", txtAddress.Text.Trim().ToUpper())
                   .Append("Pallets", string.IsNullOrEmpty(txtPallets.Text.Trim()) ? DBNull.Value : (object)txtPallets.Text.Trim())
                   .Append("Cost", string.IsNullOrEmpty(txtCost.Text.Trim()) ? DBNull.Value : (object)txtCost.Text.Trim())
                   .Append("DORemark", txtRemark.Text.Trim().ToUpper())
                   .Append("CrUser",FSecurityHelper.CurrentUserDataGET()[0])
                   .Append("LastUser",FSecurityHelper.CurrentUserDataGET()[0])
                   .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
        }).GetTable();

        if (dtDO != null)
        {
            //hidSeed.Text = dtDO.Rows[0][0].ToString();
            hidDelByRowId.Text = "";
            DataBinder();
            ControlBinder.pageTitleMsg(true, "DO:" + labDO.Text, "<p class='success'>Status : Saved successful . </p>", div_bottom);

            if (dtDO != null && dtDO.Rows.Count > 0 && hidSeed.Text == "0")
            {
                X.Redirect("List.aspx?Seed=" + dtDO.Rows[0][0].ToString());
            }
        }
        else
            div_bottom.Html = "<p class='error'>Status: Saved failed , please check the data ! </p>";

    }

    #endregion

}