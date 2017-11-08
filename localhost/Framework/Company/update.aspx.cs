using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.BASECLASS;

public partial class Framework_Company_update : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack)
        //{
        //    this.Option = Request.QueryString["Option"];
        //    if (this.Option == "modify" || this.Option == "view") this.InitData();
        //}
    }

    #region InitData()   初始化资料   作者: Richard ( 2011-03-29 )
    /// <summary>
    /// 初始化资料
    /// </summary>
    private void InitData()
    {
        //this.InitVariable();
        //FwCompanyEntity entity = new FwCompanyEntity();
        //entity.CompanyID = Request.QueryString["CompanyID"];
        //DataTable dt = this.FactoryFramework.IFwCompany.GetTable(entity);

        //if (dt != null && dt.Rows.Count > 0)
        //{
        //    this.CompanyID.Value = dt.Rows[0]["CompanyID"].ToString();
        //    this.NameCHS.Value = dt.Rows[0]["NameCHS"].ToString();
        //    this.NameENG.Value = dt.Rows[0]["NameENG"].ToString();
        //    this.District.Value = dt.Rows[0]["District"].ToString();

        //    if (this.Option == "modify")
        //    {
        //        this.CompanyID.Attributes.Add("readonly", "readonly");
        //        this.CompanyID.Attributes.Add("style", "background-color:#efefef;");
        //    }
        //    if (this.Option == "view")
        //    {
        //        this.CompanyID.Disabled = false;
        //        this.NameCHS.Disabled = false;
        //        this.NameENG.Disabled = false;
        //        this.District.Disabled = false;
        //    }
        //}
    }
    #endregion
}
