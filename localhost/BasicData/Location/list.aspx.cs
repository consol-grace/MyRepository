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
    public string dep;
    public string stationSys; //当前用户所在系统（总站Y或者分站N）

    protected void Page_Load(object sender, EventArgs e)
    {
        this.sys = Request["sys"];

        if (sys == "D" || sys == "B" || sys == "T")
        {
            sys = "O";
        }
        if (!X.IsAjaxRequest)
        {
            ControlBinder.CmbBinder(StoreCompany, "CompanyList", sys);
            ControlBinder.CmbBinder(storeCountry, "CountryList", sys);
            ControlBinder.CmbBinder(storeCurrency, "CurrencysList", sys);
            Code.Text = Request["code"];
            dep = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
            stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
            div_bottom.Html = "<p>Status: New location record .</p>";
            if (dep == "OP" || dep == "ACCOUNT" || stationSys == "N")
            {
                DisabledControl();
            }
            else
            {
                UseControl();
            }

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

    private string sys;

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

    private void BindData()
    {
        var store = this.GridPanel1.GetStore();
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Location_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
            .Append("SYS",sys)
            .Append("code",Request["code"]) 
            .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("dept", FSecurityHelper.CurrentUserDataGET()[28])

        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            store.DataSource = ds.Tables[0];
            store.DataBind();

            if (!string.IsNullOrEmpty(Request["code"]))
            {
                var list = (from p in ds.Tables[0].AsEnumerable() where p.Field<string>("Code").Equals(Code.Text) select p).AsDataView();
                if (list.Count > 0)
                {
                    Code.Text = list[0]["Code"].ToString();
                    AirAgent.Text = list[0]["AIR"].ToString();
                    OceanAgent.Text = list[0]["OCEAN"].ToString();
                    Name.Text = list[0]["Name"].ToString();
                    Country.Text = list[0]["Country"].ToString();
                    City.Text = list[0]["City"].ToString();
                    Currency.Text = list[0]["Currency"].ToString();
                    hidRowID.Text = list[0]["RowID"].ToString();
                    chkActive.Checked = list[0]["Active"].ToString() == "1" ? true : false;

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
                div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + Code.Text + "</span> .</p>";
                Code.Disabled = true;
            }
            GridPanel1.GetStore().DataSource = ds;
            GridPanel1.GetStore().DataBind();
        }
        else
        {
            div_bottom.Html = "<p class=''>Status: New location record . </p>";
        }

        //修改Grace 2014-09-23 //不需要在这里给文本框赋值，否则赋值的结果永远是第一个
        //if (!string.IsNullOrEmpty(Request["code"]) && Code.Text != "")
        //{
        //    //if (ds != null && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
        //    //{
        //    //    hidRowID.Text = ds.Tables[0].Rows[0]["RowID"].ToString();
        //    //    Code.Text = ds.Tables[0].Rows[0]["Code"].ToString();
        //    //    Code.Disabled = true;
        //    //    Name.Text = ds.Tables[0].Rows[0]["Name"].ToString();
        //    //    Country.Text = ds.Tables[0].Rows[0]["Country"].ToString();
        //    //    City.Text = ds.Tables[0].Rows[0]["City"].ToString();
        //    //    Currency.Text = ds.Tables[0].Rows[0]["Currency"].ToString();
        //    //    AirAgent.setValue(ds.Tables[0].Rows[0]["AIR"].ToString());
        //    //    OceanAgent.setValue(ds.Tables[0].Rows[0]["OCEAN"].ToString());

        //    //    div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + Code.Text + "</span> . </p>";
        //    //}
        //    //else
        //    //    div_bottom.Html = "<p class=''>Status : New location record . </p>";

        //}
        //else
        //    div_bottom.Html = "<p class=''>Status : New location record . </p>";

        this.Code.Focus(true);

    }
    protected void Binding(object sender, DirectEventArgs e)
    {
        BindData();
    }

    protected void btnCancel_click(object sender, DirectEventArgs e)
    {
        Row_Select(sender, e);
    }

    protected void Row_Select(object sender, DirectEventArgs e)
    {
        X.AddScript("removeLine('txtCode');"); 
        var list = JSON.Deserialize<LocationList>(e.ExtraParams["rowdata"]);
        hidRowID.Text = list.RowID;
        Code.Text = list.Code;

        Name.Text = list.Name;
        Country.Text = list.Country;
        City.Text = list.City;
        Currency.Text = list.Currency;
        AirAgent.setValue(list.AIR);
        OceanAgent.setValue(list.OCEAN);
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
        Code.Disabled = true;
        div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + Code.Text + "</span> . </p>";
        Name.Focus(false, Name.Text.Length);
    }

    int i = 0;
    //bool next = false;
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        i = 1;
        //next = false;
        btnSave_Click(sender, e);
        //if (next)
        //{
        //    Code.Text = "";
        //    Name.Text = "";
        //    Country.Text = "";
        //    City.Text = "";
        //    Currency.Text = "";
        //    AirAgent.setValue("");
        //    OceanAgent.setValue("");
        //    hidRowID.Text = "0";
        //    chkActive.Checked = true;

        //    Code.Disabled = false;
        //    Code.Focus(true);
        //    div_bottom.Html = "<p class=''>Status : New location record.</p>";
        //}

    }

    DataFactory dal = new DataFactory();

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
            Code.Focus(true);
            div_bottom.Html = "<p class='error'>Status : The code can't be empty .</p>";
            return;
        }
        if (string.IsNullOrEmpty(Name.Text))
        {
            Name.Focus(true);
            div_bottom.Html = "<p class='error'>Status : The description can't be empty .</p>";
            return;
        }

        if (string.IsNullOrEmpty(Country.Text))
        {
            Country.Focus(true);
            div_bottom.Html = "<p class='error'>Status : The country can't be empty .</p>";
            return;
        }

        if (Code.Text.Trim().Length < 3)
        {
            Code.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : The Code length can not be less than 3 . </p>";
            return;
        }

        if (BaseCheckCode.Check("location", Code.Text.ToUpper().Trim(), sys, hidRowID.Text) == "N")
        {
            Code.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the code already exists! </p>";
            return;
        }

        bool bFlag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Location_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS",sys)
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("Code",Code.Text.ToUpper().Trim())
                .Append("Name",Name.Text.Trim().ToUpper())
                .Append("Country",Country.Value)
                .Append("City",City.Text.ToUpper().Trim())
                .Append("Currency",Currency.Value)
                .Append("AirAgent",AirAgent.Value)
                .Append("OceanAgent", OceanAgent.Value)
                .Append("Active",chkActive.Checked?"1":"0")
                .Append("ROWID",hidRowID.Text)
                .Append("statstr",strStat)
                .Append("dept", FSecurityHelper.CurrentUserDataGET()[28].ToUpper())
            
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
                Code.Text = "";
                Name.Text = "";
                Country.Text = "";
                City.Text = "";
                Currency.Text = "";
                AirAgent.setValue("");
                OceanAgent.setValue("");
                hidRowID.Text = "0";
                chkActive.Checked = true;
                Code.Disabled = false;
                Code.Focus(true);
                CheckGroupChecked();
            }
            else
            {
                Code.Disabled = true;
                hidRowID.Text = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Location_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
                                    .Append("SYS",sys)
                                    .Append("code",Code.Text)
                                    .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                                    .Append("dept", FSecurityHelper.CurrentUserDataGET()[28])
                                    .Append("num",1)
                                    }).GetTable().Rows[0][0].ToString();
            }
            div_bottom.Html = "<p class='success'>Status: Saved successful . </p>";
             //next = true;
            this.BindData();
        }
        else
        {
            // X.Msg.Alert("Status", "saved failed", "Code.focus();").Show();
            div_bottom.Html = "<p class='error'>Status: Saved failed , please check the data ! </p>";
            Code.Focus();
            //next = false;
        }
    }
}

public class LocationList
{
    public string RowID
    { get; set; }
    public string Code
    { get; set; }
    public string Name
    { get; set; }
    public string City
    { get; set; }
    public string Country
    { get; set; }
    public string AIR
    { get; set; }
    public string OCEAN
    { get; set; }
    public string Currency
    { get; set; }
    public string Active
    { get; set; }
    public string StatList
    { get; set; }
}