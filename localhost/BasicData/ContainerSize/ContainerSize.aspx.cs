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

public partial class BasicData_ContainerSize_ContainerSize : System.Web.UI.Page
{
    public static string sys = "";
    private String tempString { get; set; }
    public string station; //当前用户所在部门
    public string userDept; //当前用户所在部门
    public string stationSys; //当前用户所在系统（总站Y或者分站N）

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                //string userStat = FSecurityHelper.CurrentUserDataGET()[12];
                //string userApart = FSecurityHelper.CurrentUserDataGET()[28];
                sys = Request["sys"] == null ? "A" : Request["sys"];
                //userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
                //stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
                txtCode.Text = Request["code"];
                //if (userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N")
                //{
                //    DisabledControl();
                //}
                //else
                //{
                //    UseControl();
                //}
                BindCombox();

                div_bottom.Html = "<p>Status: New Container Size record .</p>";
            }
        }

        ControlBinder.ChkGroupBind(this.tblChkGroup); //绑定CheckBoxGroup ( 2014-10-12 )
    }

    protected void Page_PreRender(object sender, EventArgs e)  //修改Grace，先进入load事件绑定好CheckBoxGroup ( 2014-10-15 )
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                string userStat = FSecurityHelper.CurrentUserDataGET()[12];
                string userApart = FSecurityHelper.CurrentUserDataGET()[28];
                station = userStat.ToUpper();
                userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
                stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();

                if ((userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N") && userStat.ToUpper() !="CON/HKG")
                {
                    DisabledControl();
                }
                else
                {
                    UseControl();
                }

                DataBinder();
            }
        }
    }


    void DisabledControl()
    {
        txtCode.Disabled = true;
        txtDes.Disabled = true;
        txtLong.Disabled = true;
        btnAddSave.Disabled = true;
        btnCancel.Disabled = true;
        btnSave.Disabled = true;
        ChbActive.Disabled = true;
        CmbCalc.Disabled = true;
        CmbGroup.Disabled = true;
        txtisocode.Disabled = true;
    }

    void UseControl()
    {
        txtisocode.Disabled = false;
        txtCode.Disabled = false;
        txtDes.Disabled = false;
        txtLong.Disabled = false;
        btnAddSave.Disabled = false;
        btnCancel.Disabled = false;
        btnSave.Disabled = false;
        ChbActive.Disabled = false ;
        CmbCalc.Disabled = false;
        CmbGroup.Disabled = false;

    }

    private void BindCombox()
    {
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "BLCal")
            .Append("SYS",sys)
        
        }).GetTable();      
        if (dt != null && dt.Rows.Count > 0)
        {
            Store1.DataSource = dt;
            Store1.DataBind();
        }

        DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "GetCtnrGroup")
            .Append("SYS",sys)
        
        }).GetTable();
        if (dt1 != null && dt1.Rows.Count > 0)
        {
            Store2.DataSource = dt1;
            Store2.DataBind();
        }
    }

    #region  DataBinder()   Author：Hcy  (2011-09-23) 修改时间2014-09-19 Grace
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ContainerSize_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "List")
            .Append("ctnr_STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("dept", userDept)
        }).GetList();

        if (ds != null && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(Request["code"]))
            {
                var list = (from p in ds.Tables[0].AsEnumerable() where p.Field<string>("ctnr_Code").Equals(txtCode.Text) select p).AsDataView();
                if (list.Count > 0)
                {
                    txtCode.Text = list[0]["ctnr_Code"].ToString();
                    CmbCalc.Text = list[0]["ctnr_ContainerType"].ToString();
                    CmbGroup.Text = list[0]["ctnr_Group"].ToString();
                    txtLong.Text = list[0]["ctnr_Length"].ToString();
                    txtDes.Text = list[0]["ctnr_Description"].ToString();
                    txtRowID.Text = list[0]["ctnr_ROWID"].ToString();
                    ChbActive.Checked = Convert.ToBoolean(list[0]["ctnr_Active"].ToString());
                    string[] statlist = string.IsNullOrEmpty(list[0]["StatList"].ToString()) ? new string[] { } : list[0]["StatList"].ToString().Split(',');
                    CheckGroupClear();

                    foreach (string str in statlist)
                    {
                        for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
                        {
                            if (tblChkGroup.Items[i].Tag.ToString().Trim().ToUpper() == str.Trim().ToUpper())
                            {
                                tblChkGroup.Items[i].Checked = true;
                                break;
                            }
                        }
                    }
                } 
            }

            if (txtCode.Text != "")
            {
                div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + txtCode.Text + "</span> .</p>";
                txtCode.Disabled = true;
            }

            GridPanel1.GetStore().DataSource = ds;
            GridPanel1.GetStore().DataBind();
        }
        else
        {
            div_bottom.Html = "<p class=''>Status: New Container Size record .</p>";
        }
    }
    #endregion

    #region   Row_Select(object,DirectEventArgs)  Author：Hcy （2011-09-23）修改时间2014-09-19 Grace
    protected void Row_Select(object sender, DirectEventArgs e)
    {
        X.AddScript("removeLine('txtCode');"); 
        txtRowID.Text = e.ExtraParams["ctnr_ROWID"];
        txtCode.Text = e.ExtraParams["ctnr_Code"];
        txtisocode.Text = e.ExtraParams["ctnr_EDI"];
        txtDes.Text = e.ExtraParams["ctnr_Description"];
        CmbCalc.SelectedItem.Value = e.ExtraParams["ctnr_ContainerType"];
        CmbGroup.SelectedItem.Value = e.ExtraParams["ctnr_Group"];
        if (!string.IsNullOrEmpty(e.ExtraParams["ctnr_Length"]))
        {
            txtLong.Text = e.ExtraParams["ctnr_Length"];
        }
        else
        {
            txtLong.Clear();
        }
        ChbActive.Checked = Convert.ToBoolean(e.ExtraParams["ctnr_Active"]);
        //txtCode.Focus();
        string[] statlist = string.IsNullOrEmpty(e.ExtraParams["StatList"]) ? new string[] { } : e.ExtraParams["StatList"].Split(',');
        CheckGroupClear();

        foreach (string str in statlist)
        {
            for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
            {
                if (tblChkGroup.Items[i].Tag.ToString().Trim().ToUpper() == str.Trim().ToUpper())
                {
                    tblChkGroup.Items[i].Checked = true;
                    break;
                }
            }
        }
        txtCode.Disabled = true;
        div_bottom.Html = "<p>Status : Edit the record  of <span>" + txtCode.Text + "</span> .</p>";
        txtDes.Focus();
    }
    #endregion

    int i = 0;

    #region  btnAddSave_Click(object, EventArgs) Author：Hcy  (2011-10-23) 修改时间2014-09-19 Grace
    protected void btnAddSave_Click(object sender, EventArgs e)
    {
        i = 1;
        btnSave_Click(sender, e);
    }
    #endregion

    /// <summary>
    /// 初始化控件  2014-09-19 Grace
    /// </summary>
    void InitCotrol()
    {
        txtRowID.Text = "";
        txtCode.Text = "";
        txtisocode.Text = "";
        txtDes.Text = "";
        txtLong.Clear();
        CmbCalc.SelectedItem.Value = "";
        CmbGroup.SelectedItem.Value = "";
        ChbActive.Checked = true;
        txtCode.Focus();
    }

    /// <summary>
    /// 清空Checkbox
    /// </summary>
    private void CheckGroupClear()
    {
        for (int ii = 0; ii < tblChkGroup.Items.Count(); ++ii)
            tblChkGroup.Items[ii].Checked = false;
    }

    /// <summary>
    /// Checkbox全选
    /// </summary>
    private void CheckGroupChecked()
    {
        for (int ii = 0; ii < tblChkGroup.Items.Count(); ++ii)
            tblChkGroup.Items[ii].Checked = true;
    }

    #region  btnSave_Click(object, EventArgs) Author：Hcy  (2011-10-23) 修改时间2014-09-19 Grace
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strStat = "";

        for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
        {
            if (!tblChkGroup.Items[i].Checked)
                strStat += tblChkGroup.Items[i].Tag.Trim() + ",";
        }

        strStat = strStat.Length > 0 ? strStat.Substring(0, strStat.Length - 1) : strStat;

        if (txtCode.Text.Trim() == "")
        {
            //X.Msg.Alert("Information", "Code can't be empty!").Show();
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , code can't be empty ! </p>";
            txtCode.Focus();
        }

        if (txtisocode.Text.Trim() == "")
        {
            //X.Msg.Alert("Information", "Code can't be empty!").Show();
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , EDI Code can't be empty ! </p>";
            txtisocode.Focus();
        }
        else if (CmbGroup.SelectedItem.Value == null)
        {
            //X.Msg.Alert("Information", "Group can't be empty!").Show();
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , group can't be empty ! </p>";
            CmbGroup.Focus();
        }
        else if (BaseCheckCode.Check("CONTAINER SIZE", txtCode.Text.ToUpper().Trim(), sys, txtRowID.Text) == "N")
        {
            txtCode.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , the code already exists ! </p>";
            //X.Msg.Alert("Information", "The code already exists!").Show();
            return;
        }
        else
        {
            string a = FSecurityHelper.CurrentUserDataGET()[12].ToString();
            DataFactory dal = new DataFactory();
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ContainerSize_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                 .Append("ctnr_Code",txtCode.Text.Trim().ToUpper())
                 .Append("ctnr_EDI",txtisocode.Text.Trim().ToUpper())
                 .Append("ctnr_Description",txtDes.Text.Trim().ToUpper())
                 .Append("ctnr_ContainerType",CmbCalc.SelectedItem.Value)
                 .Append("ctnr_Group",CmbGroup.SelectedItem.Value)
                 .Append("ctnr_Length",string.IsNullOrEmpty(txtLong.Text.Trim().ToUpper()) ? DBNull.Value : (object)txtLong.Text.Trim().ToUpper())
                 .Append("ctnr_Active",ChbActive.Checked?"1":"0")
                 .Append("ctnr_STAT",FSecurityHelper.CurrentUserDataGET()[12])
                 .Append("ctnr_User",FSecurityHelper.CurrentUserDataGET()[0])
                 .Append("ctnr_ROWID",txtRowID.Text)
                 .Append("statstr",strStat)
                 .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
        }).Update();
            if (b)
            {
                //X.Msg.Alert("status", " Saved successfully").Show();
                if (!string.IsNullOrEmpty(Request["control"]))
                {
                    X.AddScript("window.parent.ChildCallBack(Request(\"control\"), $(\"#txtCode\").val());");
                    return;
                }

                if (i == 1)
                {
                    InitCotrol();
                    txtCode.Disabled = false;
                    CheckGroupChecked();
                }
                else
                {
                    txtCode.Disabled = true;
                    txtRowID.Text = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ContainerSize_SP", new List<IFields>() { dal.CreateIFields()
                                        .Append("Option", "List")
                                        .Append("ctnr_STAT",FSecurityHelper.CurrentUserDataGET()[12])
                                        .Append("dept",  FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                                        .Append("ctnr_Code", txtCode.Text)
                                        .Append("isGetId", 1)
                                    }).GetTable().Rows[0][0].ToString();
                }
                //X.Msg.Alert("Status", " saved successful ! ").Show();
                div_bottom.Html = "<p class='success'>Status: Saved successful . </p>";
            }
            else
            {
                div_bottom.Html = "<p class='error'>Status: Saved failed , please check the data ! </p>";
                //X.Msg.Alert("status", " Save failed ").Show();
            }
            DataBinder();
            txtCode.Focus();
        }
    }
    #endregion

    //#region  btnCancel_Click(object, EventArgs) Author：Hcy  (2011-10-23)
    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    txtRowID.Text = "";
    //    txtCode.Text = "";
    //    txtDes.Text = "";
    //    txtLong.Clear();
    //    CmbCalc.SelectedItem.Value = "";
    //    CmbGroup.SelectedItem.Value = "";
    //    ChbActive.Checked = true;
    //    txtCode.Focus();
    //}
    //#endregion

    /// <summary>
    /// 重置按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    #region  btnCancel_Click(object, DirectEventArgs) Author：Grace  (2014-9-19)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
       Row_Select(sender, e);
    }
    #endregion

}
