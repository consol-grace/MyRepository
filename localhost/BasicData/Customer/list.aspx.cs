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
    public string currStation = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            //this.BindData();
            Code.Focus(true);
            string dep = FSecurityHelper.CurrentUserDataGET()[28];
            if (!((dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN") && currStation == "Y"))
            {
                btnPrint.Visible = false;
                div_ShowActive.Attributes.CssStyle.Value = "display:none";
                tblChkGroup.Hide();
            }
            else
            {
                Code.Width = new Unit(80);
                Address.Width = new Unit(100);
            }
           
        }
        ControlBinder.ChkGroupBind(this.tblChkGroup);
        CheckGroupClear();
    }


    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        //if (!string.IsNullOrEmpty(Code.Text.Trim()) || !string.IsNullOrEmpty(Name.Text.Trim()))
        BindData();
        CheckGroupClear();
        X.AddScript("$('#txtRemark').val('');$('#hidRowID').val('0')");
    }


    private void CheckGroupClear()
    {
        for (int ii = 0; ii < tblChkGroup.Items.Count(); ++ii)
            tblChkGroup.Items[ii].Checked = false;
    }

    private void BindData()
    {

        var store = this.GridPanel1.GetStore();
        DataFactory dal = new DataFactory();
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
            .Append("Code",Code.Text.Trim())
            .Append("Address1",Address.Text.Trim())
            .Append("co_isvalid",chkActive.Checked?1:0)
            .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("dept", FSecurityHelper.CurrentUserDataGET()[28])
            .Append("SYS",FSecurityHelper.CurrentUserDataGET()[11].Substring(0,1)) 

        }).GetTable();
        store.RemoveAll();
        if (dt != null && dt.Rows.Count > 0)
        {
            store.DataSource = dt;
            store.DataBind();
        }
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        BindData();
    }


    [DirectMethod]
    public void ShowDetail(string id)
    {
        ///BasicData/Customer/detail.aspx?rowid=16087
        string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/detail.aspx?rowid=" + id;
        X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");
    }

    [DirectMethod(ShowMask = true, Msg = "  Searching ... ")]
    public void ShowInActive()
    {
        BindData();
    }

    [DirectMethod]
    public void RowSelectStation(string stationList)
    {
        string[] list = string.IsNullOrEmpty(stationList) ? new string[] { } : stationList.ToString().Split(',');
        CheckGroupClear();

        foreach (string str in list)
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

    [DirectMethod]
    public void UpdateStationCompany(string rowid, string station, string flag)
    {
       
    }
}
