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

public partial class BasicData_Country_list : System.Web.UI.Page
{
    public string userDept; //当前用户所在部门
    public string stationSys; //当前用户所在系统（总站Y或者分站N）

    protected void Page_Load(object sender, EventArgs e)
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
            CotrolsInitial();
            div_bottom.Html = "<p>Status: New Domestic Status record .</p>";
        }
        ControlBinder.ChkGroupBind(this.tblChkGroup); //绑定CheckBoxGroup ( 2014-10-12 )
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.DataBinder();
        }
    }


    DataFactory dal = new DataFactory();

    /// <summary>
    /// 控件初始化
    /// </summary>
    #region  CotrolsInitial（）  Author: Micro ( 2011-08-27 )
    void CotrolsInitial()
    {
        txtCode.Text = "";
        txtCode.Focus(true);
        txtDes.Text = "";
        txtShort.Text = "";
        txtRowID.Text = "0";
        ChbActive.Checked = true;
    }
    #endregion

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

    /// <summary>
    /// 禁用控件
    /// </summary>
    void DisabledControl()
    {
        txtCode.Disabled = true;
        txtShort.Disabled = true;
        txtDes.Disabled = true;
        btnAddSave.Disabled = true;
        btnCancel.Disabled = true;
        btnSave.Disabled = true;
    }

    /// <summary>
    /// 启用控件
    /// </summary>
    void UseControl()
    {
        txtCode.Disabled = false;
        txtShort.Disabled = false;
        txtDes.Disabled = false;
        btnAddSave.Disabled = false;
        btnCancel.Disabled = false;
        btnSave.Disabled = false;
    }

    /// <summary>
    /// Grid 数据绑定   
    /// </summary>
    #region   DataBinder()   Author: Micro ( 2011-08-26 )
    void DataBinder()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_DomesticKid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List")
        .Append("dept", userDept)
        .Append("dk_STAT",FSecurityHelper.CurrentUserDataGET()[12]) }).GetList(); //修改grace 2014-09-23 用于决定是否分站
        
        if (ds != null && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
        {
            //if (!string.IsNullOrEmpty(Request["txtCode"]))
            //{
               
            //}

            if (txtCode.Text != "")
            {
                div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + txtCode.Text + "</span>.</p>";
                txtCode.Disabled = true;
            }

            StoreDomestic.DataSource = ds;
            StoreDomestic.DataBind();
        }
        else
        {
            div_bottom.Html = "<p class=''>Status: New Container Size record .</p>";
        }

    }
    #endregion

    /// <summary>
    /// Grid 行选择事件处理
    /// </summary>
    #region   row_Click(object,DirectEventArgs)  Author：Micro （2011-08-27）
    protected void row_Click(object sender, DirectEventArgs e)
    {
        X.AddScript("removeLine('txtCode');");    
        var list=JSON.Deserialize<DomesticList>(e.ExtraParams["rowdata"]);
      
        txtCode.Value =list.dk_Code;
        txtDes.Text = list.dk_Description;
        txtShort.Value = list.dk_Short;
        ChbActive.Checked = list.dk_Active;
        txtRowID.Text = list.dk_ROWID;
        string[] statlist = string.IsNullOrEmpty(list.StatList) ? new string[] { } : list.StatList.Split(',');
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
        txtCode.Focus(true, 5);
        txtCode.Disabled = true;
        div_bottom.Html = "<p>Status : Edit the record  of <span>" + txtCode.Text + "</span> . </p>";
    }
    #endregion


    int i = 0;
    /// <summary>
    /// btnAddSave 保存添加事件
    /// </summary>
    #region  btnAddSave_Click(object, EventArgs) Author：Micro (2011-08-27)
    protected void btnAddSave_Click(object sender, EventArgs e)
    {
        i = 1;
        btnSave_Click(sender, e);
    }
    #endregion


    /// <summary>
    /// btnSave 保存事件
    /// </summary>
    #region  btnSave_Click(object, EventArgs) Author：Micro (2011-08-27)
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strStat = "";

        for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
        {
            if (!tblChkGroup.Items[i].Checked)
                strStat += tblChkGroup.Items[i].Tag.Trim() + ",";
        }
        strStat = strStat.Length > 0 ? strStat.Substring(0, strStat.Length - 1) : strStat;

        if (string.IsNullOrEmpty(txtCode.Text.Trim()))
        {
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , code can't be empty! </p>";
            txtCode.Focus();
            return;
        }

        if (string.IsNullOrEmpty(txtShort.Text.Trim()))
        {
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , short can't be empty! </p>";
            txtShort.Focus();
            return;
        }

        if (string.IsNullOrEmpty(txtDes.Text.Trim()))
        {
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , Description can't be empty! </p>";
            txtDes.Focus();
            return;
        }

        if (BaseCheckCode.Check("DOMESTICSTATUS", txtCode.Text.ToUpper().Trim(), "", txtRowID.Text) == "N")
        {
            txtCode.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the code already exists! </p>";
            //X.Msg.Alert("Information", "The code already exists!").Show();
            return;
        }

        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_DomesticKid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "AddModify")
                 .Append("dk_Code",txtCode.Text.Trim())
                 .Append("dk_Description",txtDes.Text.Trim())
                 .Append("dk_Short",txtShort.Text.Trim())
                 .Append("dk_Active",ChbActive.Checked==true?1:0)
                 .Append("dk_ROWID",txtRowID.Text.Trim())
                 .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                .Append("statstr",strStat)}).Update();
        if (b)
        {
            if (!string.IsNullOrEmpty(Request["control"]))
            {
                X.AddScript("window.parent.ChildCallBack(Request(\"control\"), $(\"#txtCode\").val());");
                return;
            }
            if (i == 1)
            {
                CotrolsInitial();
                txtCode.Disabled = false;
                CheckGroupChecked();
            }
            else
            {
                txtCode.Disabled = true;
                txtRowID.Text = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_DomesticKid_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List")
                                    .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                                    .Append("dk_Code", txtCode.Text.Trim())
                                    .Append("isGetId", 1)
                                }).GetTable().Rows[0][0].ToString();
            }

            //X.Msg.Alert("Status", " Saved successfully !!!", new JFunction { Fn = "TextFocus" }).Show();
            div_bottom.Html = "<p class='success'>Status: Saved successful . </p>";
        }
        else
            //X.Msg.Alert("Status", " Save failed !!! ", new JFunction { Fn = "TextFocus" }).Show();
            div_bottom.Html = "<p class='error'>Status: Saved failed , please check the data ! </p>";
            txtCode.Focus(true);
            DataBinder();
    }
    #endregion

    /// <summary>
    /// btnCancel 清空事件(还原事件 ，清空在前台执行)
    /// </summary>    
    #region  btnCancel_Click(object, EventArgs) Author：Micro (2011-08-27)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        row_Click(sender, e);
    }
    #endregion
    
}

public class DomesticList
{
    public string dk_ROWID
{get;set;}
    public string dk_Code
{get;set;}
    public string dk_Short
{get;set;}
    public string dk_Description
{get;set;}
    public bool dk_Active
{get;set;}
    public string StatList
    { get; set; }
}