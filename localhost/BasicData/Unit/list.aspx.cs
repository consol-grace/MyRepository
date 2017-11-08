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
    public string userStat;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                //userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
                //stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();

                Code.Text = Request["code"];
                //if (userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N")
                //{
                //    DisabledControl();
                //}
                //else
                //{
                //    UseControl();
                //}
                //this.BindData();
                div_bottom.Html = "<p>Status: New Unit record .</p>";
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
                userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
                stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
                userStat = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();

                if ((userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N") && userStat!= "CON/HKG")
                {
                    DisabledControl();
                }
                else
                {
                    UseControl();
                }
                this.BindData();

            }
        }
    }

    void DisabledControl()
    {
        Code.Disabled = true;
        txtEDI.Disabled = true;
        Short.Disabled = true;
        Description.Disabled = true;
        Next.Disabled = true;
        Save.Disabled = true;
        Cancel.Disabled = true;
    }

    void UseControl()
    {
        Code.Disabled = false;
        txtEDI.Disabled = false;
        Short.Disabled = false;
        Description.Disabled = false;
        Next.Disabled = false;
        Save.Disabled = false;
        Cancel.Disabled = false;
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

    private void BindData()
    {
        Code.Focus(true);
        var store = this.GridPanel1.GetStore();
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Unit_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
             .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
             .Append("dept", userDept)
        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(Request["code"]))
            {
                var list = (from p in dt.AsEnumerable() where p.Field<string>("Code").Equals(Code.Text) select p).AsDataView();
                if (list.Count > 0)
                {
                    Code.Disabled = true;
                    Code.Text = list[0]["Code"].ToString();
                    Short.Text = list[0]["Short"].ToString();
                    txtEDI.Text = list[0]["EDI"].ToString();
                    chkActive.Checked = list[0]["Active"].ToString() == "1" ? true : false;
                    Description.Text = list[0]["Description"].ToString();
                    hidRowID.Text = list[0]["RowID"].ToString();
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
                    Short.Focus(true);
                }

            }

            if (Code.Text != "")
            {
                div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + Code.Text + "</span> . </p>";
                Code.Disabled = true;
            }
            store.DataSource = dt;
            store.DataBind();
        }
        else
        {
            div_bottom.Html = "<p class=''>Status: New Unit record .</p>";
        }

    }

    //protected void Binding(object sender, DirectEventArgs e)
    //{
    //    BindData();
    //}

    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        string strStat = "";

        for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
        {
            if (!tblChkGroup.Items[i].Checked)
                strStat += tblChkGroup.Items[i].Tag.Trim() + ",";
        }

        strStat = strStat.Length > 0 ? strStat.Substring(0, strStat.Length - 1) : strStat;

        if (string.IsNullOrEmpty(Code.Text))
        {
            Code.Text = "";
            Code.Focus();
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , code can't be empty ! </p>";
            //X.Msg.Alert("Status", "Code can't be null", "Code.focus();").Show();
            return;
        }

        if (string.IsNullOrEmpty(Short.Text))
        {
            //X.Msg.Alert("Status", "Short can't be null", "Code.focus();").Show();
            Short.Text = "";
            Short.Focus();
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , short can't be empty ! </p>";
            return;
        }

        if (string.IsNullOrEmpty(txtEDI.Text))
        {
            //X.Msg.Alert("Status", "Short can't be null", "Code.focus();").Show();
            txtEDI.Text = "";
            txtEDI.Focus();
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , EDI can't be empty ! </p>";
            return;
        }

        if (BaseCheckCode.Check("UNIT", Code.Text.ToUpper().Trim(), "", hidRowID.Text) == "N")
        {
            Code.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the code already exists! </p>";
            //X.Msg.Alert("Information", "The code already exists!").Show();
            return;
        }

        bool bFlag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Unit_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS",DBNull.Value)
                .Append("dept",FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("Code",Code.Text.ToUpper().Trim())
                .Append("EDI",txtEDI.Text.ToUpper().Trim())
                .Append("Short",Short.Text.ToUpper().Trim())
                .Append("Description",Description.Text.ToUpper().Trim())
                .Append("Active",chkActive.Checked?"1":"0")
                .Append("ROWID",hidRowID.Text.Trim())   
                .Append("statstr",strStat)
        }).Update();
        if (bFlag)
        {
            if (!string.IsNullOrEmpty(Request["control"]))
            {
                X.AddScript("window.parent.ChildCallBack(Request(\"control\"), Code.getValue().toUpperCase(),'');");
                return;
            }

            if (i == 1)
            {
                Code.Text = "";
                txtEDI.Text = "";
                Short.Text = "";
                Description.Text = "";
                hidRowID.Text = "0";
                chkActive.Checked = true;
                CheckGroupChecked();
                Code.Disabled = false;
                Code.Focus(true);
            }
            else
            {
                Code.Disabled = true;
                Short.Focus(true);
                hidRowID.Text = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Unit_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
                                     .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                                     .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                                     .Append("Code", Code.Text.Trim())
                                     .Append("isGetId", 1)
                                }).GetTable().Rows[0][0].ToString();
            }
            //X.Msg.Alert("Status", "saved successful", "Code.focus();").Show();
            div_bottom.Html = "<p class='success'>Status: Saved successful . </p>";
        }
        else
        {
            div_bottom.Html = "<p class='error'>Status: Saved failed , please check the data ! </p>";
        }
        this.BindData();
        Code.Focus(true);
    }

    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        Row_Select(sender, e);
    }

    DataFactory dal = new DataFactory();

    int i = 0;
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        i = 1;

        btnSave_Click(sender, e);
    }

    protected void Row_Select(object sender, DirectEventArgs e)
    {
        X.AddScript("removeLine('Code');");
        var list = JSON.Deserialize<UnitList>(e.ExtraParams["rowdata"]);
        Code.Disabled = true;
        Code.Text = list.Code;
        Short.Text = list.Short;
        txtEDI.Text = list.EDI;
        hidRowID.Text = list.RowID;
        Description.Text = list.Description;
        chkActive.Checked = list.Active == "1" ? true : false;
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
        Short.Focus(true);
        div_bottom.Html = "<p>Status : Edit the record  of <span>" + Code.Text + "</span> . </p>";
    }

}

public class UnitList
{
    public string RowID
    { get; set; }
    public string Code
    { get; set; }
    public string EDI
    { get; set; }
    public string Short
    { get; set; }
    public string Description
    { get; set; }
    public string Active
    { get; set; }
    public string StatList
    { get; set; }
}
