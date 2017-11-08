using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class OceanExport_OEBillOfLading_ManifestDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBinder();
            for (int i = 0; i < repList.Items.Count; i++)
            {
                ((TextBox)repList.Items[i].FindControl("txtD")).Style.Add("width", Setwidth(i));
            }
        }
    }

    private string Setwidth(int i)
    {
        string width = "323px";
        HttpBrowserCapabilities b = Request.Browser;

        string browser = b.Browser;
        string version = b.Version;
        if (browser.ToUpper() == "IE" && version.StartsWith("9.0"))
        {
            width = "332px";
        }
        else
        {
            X.AddScript("$('#Display"+i+"').css('width','573px');");
        }
        return width;
    }

    #region  DataBinder()   Author：Hcy  (2011-09-30)
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_BillOfLading_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetAttachList").Append("seed",Request["seed"])
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            totalPKGS.Text = ds.Tables[0].Rows[0][0].ToString();
        }
        if (ds != null && ds.Tables[1].Rows.Count > 0)
        {
            txtInfor.Text = "";// ds.Tables[1].Rows[0]["oc_Remark"].ToString();
            repList.DataSource = ds.Tables[1];
            repList.DataBind();
        }
    }
     #endregion

    #region    btnSave_Click()     Author：Hcy   (2011-12-03)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        DataFactory dal = new DataFactory();
        List<IFields> attachlist = new List<IFields>();
        for (int i = 0; i < repList.Items.Count; i++)
        {
            attachlist.Add(dal.CreateIFields().Append("Option", "UpdateAttachList").
            Append("oc_OrderMarks", ControlBinder.GetMakeStr(((TextBox)repList.Items[i].FindControl("txtM")).Text.TrimEnd().ToUpper(), 19)).
            Append("oc_OrderNoOfPackage", ControlBinder.GetMakeStr(((TextBox)repList.Items[i].FindControl("txtP")).Text.TrimEnd().ToUpper(), 10)).
            Append("oc_OrderDescription", ControlBinder.GetMakeStr(((TextBox)repList.Items[i].FindControl("txtD")).Text.TrimEnd().ToUpper(), 46)).
            Append("oc_User", FSecurityHelper.CurrentUserDataGET()[0]).
            Append("ROWID", ((HiddenField)repList.Items[i].FindControl("hidID")).Value)            
            );
        }
        dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_BillOfLading_SP", attachlist).Update();
        X.AddScript("window.parent.CompanyX.MakeDetail();window.parent.winShow.close();");
    }
    #endregion

    #region    btnCancel_Click()     Author：Hcy   (2011-12-03)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        X.AddScript("window.parent.CompanyX.MakeDetail();window.parent.winShow.close();");
    }
    #endregion
}
