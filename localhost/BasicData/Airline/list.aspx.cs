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
            ControlBinder.CmbBinder(storeCountry, "CountryList", "");
           
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
            //this.BindData();
            div_bottom.Html = "<p>Status: New Airline record .</p>";
            Code.Focus(true);
        }
        ControlBinder.ChkGroupBind(this.tblChkGroup); //绑定CheckBoxGroup ( 2014-10-12 )
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData();
        }
    }

    void DisabledControl()
    {
        Code.Disabled = true;
        Name.Disabled = true;
        txtCallSign.Disabled = true;
        Next.Disabled = true;
        Save.Disabled = true;
        Cancel.Disabled = true;
        Country.Disabled = true;
    }

    void UseControl()
    {
        Code.Disabled = false;
        Name.Disabled = false;
        txtCallSign.Disabled = false;
        Next.Disabled = false;
        Save.Disabled = false;
        Cancel.Disabled = false;
        Country.Disabled = false;
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
        var store = this.GridPanel1.GetStore();
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Airline_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
         .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
         .Append("dept", userDept)

        }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            //if (!string.IsNullOrEmpty(Request["Code"]))
            //{
              
            //}

            if (Code.Text != "")
            {
                div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + Code.Text + "</span>.</p>";
                Code.Disabled = true;
            }
            store.DataSource = dt;
            store.DataBind();
        }
        else
        {
            div_bottom.Html = "<p class=''>Status: New Airline record .</p>";
        }


        //RowSelectionModel rs = GridPanel1.GetSelectionModel() as RowSelectionModel;       
        //rs.SelectRow(0,true);
        //rs.SelectedRows.Add(new SelectedRow(0));

    }

    //protected void Binding(object sender, DirectEventArgs e)
    //{
    //    BindData();
    //}

    
    protected void Row_Select(object sender, DirectEventArgs e)
    {
        X.AddScript("removeLine('Code');"); 
        var  list= JSON.Deserialize<CountryList>(e.ExtraParams["rowdata"]);      
        hidRowID.Text = list.RowID;
        Code.Text = list.Code;
        Name.Text = list.Name;
        Country.Text= list.Country;
        txtCallSign.Text = list.CallSign;
        chkActive.Checked = list.Active=="1"?true:false;
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
        Code.Focus(true);
        Code.Disabled = true;
        div_bottom.Html = "<p>Status : Edit the record  of <span>" + Code.Text + "</span> . </p>";

    }

    int i = 0;
    protected void btnNext_click(object sender, DirectEventArgs e)
    {
        i = 1;
        btnSave_click(sender, e);  
    }

    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        Row_Select(sender, e);
    }
  
    protected void btnSave_click(object sender, DirectEventArgs e)
    {
        string strStat = "";

        for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
        {
            if (!tblChkGroup.Items[i].Checked)
                strStat += tblChkGroup.Items[i].Tag.Trim() + ",";
        }
        strStat = strStat.Length > 0 ? strStat.Substring(0, strStat.Length - 1) : strStat;

        if (Code.Text.Trim() == "")
        {
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , code can't be empty! </p>";
            Code.Focus();
            return;
        }
        else if (BaseCheckCode.Check("AIRLINE", Code.Text.ToUpper().Trim(), "", hidRowID.Text) == "N")
        {
            Code.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the code already exists! </p>";
            return;
        }

        DataFactory dal = new DataFactory();

        bool bFlag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Airline_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS",Request["sys"])
                .Append("dept",FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("Code",Code.Text.ToUpper().Trim())
                .Append("Name",Name.Text.ToUpper().Trim())
                .Append("Country",Country.Value)
                .Append("CallSign",txtCallSign.Text.ToUpper().Trim())
                .Append("Active",chkActive.Checked?"1":"0")
                .Append("ROWID",hidRowID.Text)
                .Append("statstr",strStat)
            
        }).Update();

        if (bFlag)
        {
            if (!string.IsNullOrEmpty(Request["control"]))
            {
                X.AddScript("window.parent.ChildCallBack(Request(\"control\"), $(\"#Code\").val());");
                return;
            }

            if (i == 1)
            {
                hidRowID.Text = "0";
                Code.Text = "";
                Name.Text = "";
                Country.Text="";
                txtCallSign.Text = "";
                Code.Disabled = false;
                CheckGroupChecked();
            }
            else
            {
                Code.Disabled = true;
                hidRowID.Text = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Airline_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
                            .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                            .Append("dept",FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
                            .Append("Code",Code.Text.ToUpper().Trim())
                            .Append("isGetId", 1)
                    }).GetTable().Rows[0][0].ToString();
            }

            div_bottom.Html = "<p class='success'>Status: Saved successful . </p>";
        }
        else
            div_bottom.Html = "<p class='error'>Status: Saved failed , please check the data ! </p>";

        this.BindData();
        Code.Focus(true);
    }
}

public class CountryList
{
    public string RowID
    { get; set; }
    public string Code
    { get; set; }
    public string Name
    { get; set; }
    public string Country
    { get; set; }
    public string CallSign
    { get; set; }
    public string Active
    { get; set; }
    public string StatList
    { get; set; }
}
