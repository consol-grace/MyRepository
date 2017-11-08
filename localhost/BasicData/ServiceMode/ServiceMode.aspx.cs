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

public partial class BasicData_ServiceMode_ServiceMode : System.Web.UI.Page
{
    public string userDept; //当前用户所在部门
    public string stationSys; //当前用户所在系统（总站Y或者分站N）

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            //userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
            //stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
            //if (userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N")
            //{
            //    DisabledControl();
            //}
            //else
            //{
            //    UseControl();
            //}
            
            txtCode.Text = Request["code"];
            BindCombox();
            //DataBinder();
            div_bottom.Html = "<p>Status: New Service Mode record .</p>";
        }

        ControlBinder.ChkGroupBind(this.tblChkGroup); //绑定CheckBoxGroup ( 2014-10-12 )
    }

    protected void Page_PreRender(object sender, EventArgs e)  //修改Grace，先进入load事件绑定好CheckBoxGroup ( 2014-10-15 )
    {
        if (!X.IsAjaxRequest)
        {
            userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
            stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
            if (userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N")
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


    void DisabledControl()
    {
        txtCode.Disabled = true;
        txtDes.Disabled = true;
        txtLine.Disabled = true;
        btnAddSave.Disabled = true;
        btnSave.Disabled = true;
        btnCancel.Disabled = true;
    }

    void UseControl()
    {
        txtCode.Disabled = false;
        txtDes.Disabled = false;
        txtLine.Disabled = false;
        btnAddSave.Disabled = false;
        btnSave.Disabled = false;
        btnCancel.Disabled = false;
    }

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

    private void BindCombox()
    {
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "BLCal") .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            Store1.DataSource = dt;
            Store1.DataBind();
        }

        DataTable dt1 = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ComboBoxBinder_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "GetSmGroup")
        
        }).GetTable();
        if (dt1 != null && dt1.Rows.Count > 0)
        {
            Store2.DataSource = dt1;
            Store2.DataBind();
        }
    }

    #region  DataBinder()   Author：Hcy  (2011-09-23)
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ServiceMode_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "List")
            .Append("sm_STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("dept", userDept)
        }).GetList();

        if (ds != null && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(Request["Code"]))
            {
                var list = (from p in ds.Tables[0].AsEnumerable() where p.Field<string>("sm_CODE").Equals(txtCode.Text) select p).AsDataView();
                if (list.Count > 0)
                {
                    txtCode.Text = list[0][1].ToString();
                    CmbCalc.Text = list[0][3].ToString();
                    CmbGroup.Text = list[0][6].ToString();
                    txtLine.Text = list[0][4].ToString();
                    txtDes.Text = list[0][2].ToString();
                    txtRowID.Text = list[0][0].ToString();
                    ChbActive.Checked = Convert.ToBoolean(list[0][5].ToString());
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
                div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + txtCode.Text + "</span>.</p>";
                txtCode.Disabled = true;
            }

            GridPanel1.GetStore().DataSource = ds;
            GridPanel1.GetStore().DataBind();
        }
        else
        {
            div_bottom.Html = "<p class=''>Status: New Service Mode record .</p>";
        }

        
    }
    #endregion

    #region   row_Click(object,DirectEventArgs)  Author：Hcy （2011-09-23）
    protected void row_Click(object sender, DirectEventArgs e)
    {
        X.AddScript("removeLine('txtCode');"); 
        txtRowID.Text= e.ExtraParams["sm_ROWID"];
        txtCode.Text=e.ExtraParams["sm_CODE"];
        txtDes.Text=e.ExtraParams["sm_Description"];
        CmbCalc.SelectedItem.Value=e.ExtraParams["sm_CalcUnit"];
        CmbGroup.SelectedItem.Value = e.ExtraParams["sm_Group"];
        txtLine.Text = e.ExtraParams["sm_BLString"];
        ChbActive.Checked = Convert.ToBoolean(e.ExtraParams["sm_Active"]);

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
        txtCode.Focus();
        txtCode.Disabled = true;
        div_bottom.Html = "<p>Status : Edit the record  of <span>" + txtCode.Text + "</span>.</p>";
    }
    #endregion

    int i = 0;

    #region  btnAddSave_Click(object, EventArgs) Author：Hcy  (2011-10-23)
    protected void btnAddSave_Click(object sender, EventArgs e)
    {
        i = 1;
        btnSave_Click(sender, e);
    }
    #endregion

    #region  btnSave_Click(object, EventArgs) Author：Hcy  (2011-10-23)
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
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , code can't be empty! </p>";
        }
        else if (BaseCheckCode.Check("SERVICEMODE", txtCode.Text.ToUpper().Trim(), "", txtRowID.Text) == "N")
        {
            txtCode.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the code already exists! </p>";
            return;
        }
        else
        {
            DataFactory dal = new DataFactory();
            bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ServiceMode_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                 .Append("sm_CODE",txtCode.Text.Trim().ToUpper())
                 .Append("sm_Description",txtDes.Text.Trim().ToUpper())
                 .Append("sm_CalcUnit",CmbCalc.SelectedItem.Value)
                 .Append("sm_Group",CmbGroup.SelectedItem.Value)
                 .Append("sm_BLString",txtLine.Text.Trim().ToUpper())
                 .Append("sm_Active",ChbActive.Checked?"1":"0")
                 .Append("sm_STAT",FSecurityHelper.CurrentUserDataGET()[12])
                 .Append("sm_User",FSecurityHelper.CurrentUserDataGET()[0])
                 .Append("sm_ROWID",txtRowID.Text)
                 .Append("statstr",strStat)
                 .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
        }).Update();
            if (b)
            {
                //X.Msg.Alert("status", " Saved successfully").Show();
                if (!string.IsNullOrEmpty(Request["control"]))
                {
                    X.AddScript("window.parent.ChildCallBack(Request(\"control\"), txtCode.getValue());");
                    return;
                }

                if (i == 1)
                {
                    txtRowID.Text = "";
                    txtCode.Text = "";
                    txtDes.Text = "";
                    txtLine.Text = "";
                    CmbCalc.SelectedItem.Value = "";
                    CmbGroup.SelectedItem.Value = "";
                    ChbActive.Checked = true;
                    CheckGroupChecked();
                    txtCode.Focus();
                    txtCode.Disabled = false;
                }
                else
                {
                    txtCode.Disabled = true;
                    txtRowID.Text = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ServiceMode_SP", new List<IFields>() { dal.CreateIFields()
                        .Append("Option", "List")
                        .Append("sm_STAT",FSecurityHelper.CurrentUserDataGET()[12])
                        .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                        .Append("sm_CODE", txtCode.Text)
                        .Append("isGetId", 1)
                    }).GetTable().Rows[0][0].ToString();
                }
                div_bottom.Html = "<p class='success'>Status: Saved successful . </p>";
            }
            else
            {
                div_bottom.Html = "<p class='error'>Status: Saved failed , please check the data ! </p>";
            }
            DataBinder();
            txtCode.Focus();
        }
    }
    #endregion

    #region  btnCancel_Click(object, EventArgs) Author：Hcy  (2011-10-23)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        row_Click(sender, e); 
    }
    #endregion


}
