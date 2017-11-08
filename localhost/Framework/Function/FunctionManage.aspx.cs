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

public partial class Framework_Function_FunctionManage : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest) //必须加这个，否则GRID不会刷新
        {
            DataBinder();
        }

        BindCheckGroupStat();//绑定StatCheckGroup 不能放在ISAJAXREQUEST里面，否则RowClick的时候不能赋值
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinder();
    }

    #region   DataBinder()
    public void DataBinder()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_FunctionManage_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "List")
        }).GetTable();
        storeList.DataSource = dt;
        storeList.DataBind();
    }
    #endregion

    [DirectMethod]
    public void SetCheckDataByRowClick(string sys, string stat, string dept)
    {
        BindCheck(sys, chbAllSys, tblChkSys);
        BindCheck(stat, chbAllStat, tblChkStat);
        BindCheck(dept, chbAllDept, tblChkDept);
    }
    /// <summary>
    /// 绑定checkbox,点击Grid之后打勾
    /// </summary>
    /// <param name="data"></param>
    /// <param name="chb"></param>
    public void BindCheck(string data, Checkbox chb, CheckboxGroup chbGroup)
    {
        string[] List = string.IsNullOrEmpty(data) ? new string[] { } : data.Split(',');
        CheckGroupClear(chb, chbGroup);
        foreach (string str in List)
        {
            for (int i = 0; i < chbGroup.Items.Count(); ++i)
            {
                if (chbGroup.Items[i].Tag.ToString().Trim().ToUpper() == str.Trim().ToUpper())
                {
                    chbGroup.Items[i].Checked = true;
                    break;
                }
            }
        }
    }

    /// <summary>
    /// 获得打勾的Checkbox 
    /// </summary>
    /// <param name="chbGroup"></param>
    /// <returns></returns>
    public string GetCheckData(CheckboxGroup chbGroup)
    {

        string str = "";

        for (int i = 0; i < chbGroup.Items.Count(); ++i)
        {
            if (chbGroup.Items[i].Checked)
                str += chbGroup.Items[i].Tag.Trim() + ",";
        }

        str = str.Length > 0 ? str.Substring(0, str.Length - 1) : str;

        return str;
    }

    ///<summary>
    ///清空Checkbox 
    ///</summary>
    public void CheckGroupClear(Checkbox chb, CheckboxGroup chbGroup)
    {
        chb.Checked = false;

        for (int ii = 0; ii < chbGroup.Items.Count(); ++ii)
            chbGroup.Items[ii].Checked = false;
    }

    #region   row_Click(object,DirectEventArgs)
    protected void row_Click(object sender, DirectEventArgs e)
    {
        txtName.Text = e.ExtraParams["Name"];
        txtDes.Text = e.ExtraParams["Description"];
        hidID.Text = e.ExtraParams["ID"];
        SetCheckDataByRowClick(e.ExtraParams["Sys"], e.ExtraParams["Stat"], e.ExtraParams["Dept"]);
        X.AddScript("$('#txtName').removeClass('x-form-invalid').removeClass('bottom_line').attr('validata', 'true').removeAttr('title');");
        txtName.Disabled = true;
    }
    #endregion

    /// <summary>
    /// 绑定stat checkGroup 
    /// </summary>
    public void BindCheckGroupStat()
    {
        DataTable dsCheckBoxGroup = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_FunctionManage_SP", new List<IFields>() {
               dal.CreateIFields().Append("Option", "BindStat")
          }).GetTable();
        if (dsCheckBoxGroup != null && dsCheckBoxGroup.Rows.Count > 0)
        {
            foreach (DataRow dr in dsCheckBoxGroup.Rows)
            {

                tblChkStat.Items.Add(new Checkbox()
                {
                    Value = dr[1].ToString(),
                    Tag = dr[1].ToString().Trim(),
                    BoxLabel = dr[0].ToString(),
                    LabelAlign = LabelAlign.Right,
                    LabelWidth = 65,
                    Checked = false
                });
            }
        }
        else
        {
            tblChkStat.Items.Add(new Checkbox());
            tblChkStat.Hide();
            tblChkStat.Dispose();
            tblChkStat.Destroy();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    public void ClearData()
    {
        txtName.Text = "";
        txtDes.Text = "";
        hidID.Text = "-1";
        txtName.Disabled = false;
        txtName.Focus();
        CheckGroupClear(chbAllSys, tblChkSys);
        CheckGroupClear(chbAllStat, tblChkStat);
        CheckGroupClear(chbAllDept, tblChkDept);
    }

    public void btnSave_Click(object sender, DirectEventArgs e)
    {
        if (txtName.Text.Trim() == "")
        {
            txtName.Text = "";
            txtName.Focus();
            return;
        }

        if (IsExistName() && hidID.Text == "-1") //新增的时候
        {
            return;
        }

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_FunctionManage_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "Update")
            .Append("Name", txtName.Text.ToUpper())
            .Append("Sys",  GetCheckData(tblChkSys))
            .Append("Stat", GetCheckData(tblChkStat))
            .Append("Dept", GetCheckData(tblChkDept))
            .Append("Description", txtDes.Text.Trim() == "" ? "" : txtDes.Text.ToUpper())
            .Append("ID", hidID.Text)
        }).GetTable();

        if (dt != null && dt.Rows.Count > 0)
        {
            DataBinder();
            txtName.Disabled = true;
            hidID.Text = dt.Rows[0][0].ToString();
        }
        else
        {
            X.Msg.Alert("status", " Save failed ").Show();
        }

    }

    public void btnReset_Click(object sender, DirectEventArgs e)
    {
        ClearData();
    }

    public bool IsExistName()
    {
        bool a = false;
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_FunctionManage_SP", new List<IFields>() { dal.CreateIFields( ).
                Append("Option","isExistName").
                Append("Name",txtName.Text.Trim().ToUpper())}).GetTable();

        if (dt != null && dt.Rows.Count > 0)
        {
            a = true;
        }

        return a;
    }

    public void btnDelete_Click(object sender, DirectEventArgs e)
    {
        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_FunctionManage_SP", new List<IFields>() {
            dal.CreateIFields().Append("Option", "Delete").Append("ID", hidID.Text)
        }).Update();

        if (b)
        {
            DataBinder();
            ClearData();
        }
        else
        {
            X.Msg.Alert("status", " Delete failed ").Show();
        }
    }

}