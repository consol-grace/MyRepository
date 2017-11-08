using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.BASECLASS;

public partial class Framework_Permission_update : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack)
        //{
        //    this.Option = Request.QueryString["Option"];
        //    if (this.Option == "modify" || this.Option == "view")
        //    {
        //        this.InitData();
        //    }
        //}
    }

    #region InitData()   初始化资料   作者: Richard ( 2011-03-30 )
    /// <summary>
    /// 初始化资料
    /// </summary>
    protected void InitData()
    {
        //FwPermissionEntity entity = new FwPermissionEntity();
        //entity.PermissionID = Request.QueryString["permissionID"];
        //DataTable dt = this.FactoryFramework.IFwPermission.GetTable(entity);

        //if (dt != null && dt.Rows.Count > 0)
        //{
        //    this.PermissionID.Value = dt.Rows[0]["PermissionID"].ToString();
        //    this.NameCHS.Value = dt.Rows[0]["NameCHS"].ToString();
        //    this.NameENG.Value = dt.Rows[0]["NameENG"].ToString();
        //    this.Remark.Value = dt.Rows[0]["Remark"].ToString();

        //    this.PermissionID.Attributes.Add("readonly", "readonly");
        //    this.PermissionID.Attributes.Add("style", "background-color:#efefef");

        //    if (this.Option == "view")
        //    {
        //        this.NameCHS.Attributes.Add("readonly", "readonly");
        //        this.NameCHS.Attributes.Add("style", "background-color:#efefef");

        //        this.NameENG.Attributes.Add("readonly", "readonly");
        //        this.NameENG.Attributes.Add("style", "background-color:#efefef");

        //        this.Remark.Attributes.Add("readonly", "readonly");
        //        this.Remark.Attributes.Add("style", "background-color:#efefef");
        //    }
        //}
    }
    #endregion
}
