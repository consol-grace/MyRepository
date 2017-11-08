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
    protected void Page_Load(object sender, EventArgs e)
    {
        sys = Request["sys"];
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                Code.Text = Request["code"];
                ControlBinder.CmbBinder(StoreCompany, "CompanyList", sys);
                
                div_bottom.Html = "<p>Status: New Salesman record .</p>";
            }
        }

        ControlBinder.ChkGroupBind(this.tblChkGroup); //绑定CheckBoxGroup ( 2014-10-12 )
    }

    DataFactory dal = new DataFactory();
    public string userDept; //当前用户所在部门
    public string stationSys; //当前用户所在系统（总站Y或者分站N）

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
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

                this.BindData();

                //if (ControlBinder.GetPermissionID("sales") == "P000")
                //{
                    //Next.Disabled = true;
                    //Save.Disabled = true;
                    //Cancel.Disabled = true;
                //}
            }
        }
    }

    /// <summary>
    /// 修改时间2014-09-20 Grace
    /// </summary>
    private string sys; 
    private void BindData()
    {
        Code.Focus(true);
        var store = this.GridPanel1.GetStore();
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Sales_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
             .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
             .Append("dept", userDept)
             .Append("SYS", sys) 

        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(Request["code"]))
            {
                var list = (from p in dt.AsEnumerable() where p.Field<string>("Code").Equals(Code.Text) select p).AsDataView();
                if (list.Count > 0)
                {
                    Code.Text = list[0]["Code"].ToString();
                    Name.Text = list[0]["Name"].ToString();
                    chkUSGroup.Checked = list[0]["USGroup"].ToString() == "1" ? true : false;
                    chkActive.Checked = list[0]["Active"].ToString() == "1" ? true : false;
                    //chkActive.Checked = list[0]["Active"].ToString().Substring(list[0]["Active"].ToString().Length - 5, 1) == "Y" ? true : false;
                    hidRowID.Text = list[0]["RowID"].ToString();
                    Company.setValue(list[0]["Company"].ToString());
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

            if (Code.Text != "")
            {
                Code.Disabled = true;
                div_bottom.Html = "<p>Status : Edit the record  of <span>" + Code.Text + "</span> .</p>";
            }
            
            store.DataSource = dt;
            store.DataBind();                 
        }
        else
        {
            div_bottom.Html = "<p>Status: New Salesman record .</p>";
        }

    }

    /// <summary>
    /// 修改时间2014-09-20 Grace
    /// </summary>
    //protected void Binding(object sender, DirectEventArgs e)  //一旦有该方法则会导致用户点Next时首先进入BindData方法里
    //{
    //    BindData();
    //}

    int i = 0;
    public void btnNext_Click(object sender, DirectEventArgs e)
    {
        i = 1;
        btnSave_Click(sender,e);
    }

    void InitCotrol()
    { 
        Code.Text ="";
        Name.Text ="";
        Company.setValue("");
        chkUSGroup.Checked =  true ;
        chkActive.Checked = true ;
        hidRowID.Text ="0";
        Code.Focus(true);
    }

    void DisabledControl()
    {
        Code.Disabled = true;
        Name.Disabled = true;
        Next.Disabled = true;
        Save.Disabled = true;
        Cancel.Disabled = true;
    }

    void UseControl()
    {
        Code.Disabled = false;
        Name.Disabled = false;
        Next.Disabled = false;
        Save.Disabled = false;
        Cancel.Disabled = false;
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

    public void btnCancel_Click(object sender, DirectEventArgs e)
    {
        Row_Select(sender, e);
    }

    /// <summary>
    /// 修改时间2014-09-20 Grace
    /// </summary>
    public void btnSave_Click(object sender, DirectEventArgs e)
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
            Code.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , code can't be empty ! </p>";
            return;
        }

        if (BaseCheckCode.Check("SALESMAN", Code.Text.ToUpper().Trim(), sys, hidRowID.Text) == "N")
        {
            Code.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the code already exists ! </p>";
            return;
        }

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Sales_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS",DBNull.Value)
                .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("Code",Code.Text.ToUpper().Trim())
                .Append("Name",Name.Text.ToUpper().Trim())
                .Append("Company",Company.Value)
                .Append("USGroup",chkUSGroup.Checked?"1":"0")
                .Append("Active",chkActive.Checked?"1":"0")
                .Append("ROWID",hidRowID.Text)    
                .Append("statstr",strStat)
        }).GetTable();
        if (dt!=null&&dt.Rows.Count>0)
        {
            hidRowID.Text = dt.Rows[0][0].ToString();
            if (!string.IsNullOrEmpty(Request["control"]))
            {
                X.AddScript("window.parent.ChildCallBack(Request(\"control\"), $(\"#Code\").val());");
                return;
            }
            if (i == 1)
            {
                InitCotrol();
                Code.Disabled = false;
                CheckGroupChecked();
            }
            else
            {
                Code.Disabled = true;
                hidRowID.Text = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Sales_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
                 .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                 .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                 .Append("SYS", sys) 
                 .Append("Code",Code.Text.Trim())
                 .Append("isGetId", 1)
                }).GetTable().Rows[0][0].ToString();
            }
            //X.Msg.Alert("Status", " saved successful ! ").Show();
            div_bottom.Html = "<p class='success'>Status: Saved successful . </p>";
        }
        else
            div_bottom.Html = "<p class='error'>Status: Saved failed , please check the data ! </p>";

            //X.Msg.Alert("Status", " Error, saved failed ! ").Show();
       
        Code.Focus(true);
        this.BindData();

    }

    public void Row_Select(object sender, DirectEventArgs e)
    {
        X.AddScript("removeLine('Code');");

        var list = JSON.Deserialize<SalesmanList>(e.ExtraParams["rowdata"]);
        Code.Text = list.Code;
        Name.Text = list.Name;
        Company.setValue(list.Company);
        chkUSGroup.Checked = list.USGroup == "1" ? true : false;
        //chkActive.Checked = list.Active.Substring(list.Active.Length-5,1) == "Y" ? true : false;
        chkActive.Checked = list.Active.ToString() == "1" ? true : false;
        hidRowID.Text = list.RowID;
        //Code.Focus(true);
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
        Code.Disabled = true;
        div_bottom.Html = "<p>Status : Edit the record  of <span>" + Code.Text + "</span> .</p>";

    }

    [DirectMethod]
    public void SalesActive(string id, int type)
    {
        string message = (type == 1 ? "Void failed" : "Active failed");
        bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Sales_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "UpdateActive")
            .Append("RowID",id)
        }).Update();
        if (!flag)
        {
            X.Msg.Show(new MessageBoxConfig { Title = "Error", Message = message, Icon = MessageBox.Icon.ERROR, Buttons = MessageBox.Button.OK });
        }
        else
        {
            BindData();
        }
    }
}

public class SalesmanList
{
    public string RowID
    {get;set;}
    public string Code
    {get;set;}
    public string Name
    {get;set;}
    public string Company
    {get;set;}
    public string USGroup
    {get;set;}
    public string Active
    {get;set;}
    public string StatList
    { get; set; }
}
