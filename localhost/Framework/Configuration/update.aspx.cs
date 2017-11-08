using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.BASECLASS;

public partial class Framework_Configuration_update : PageBase
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
        //FwConfigurationEntity entity = new FwConfigurationEntity();
        //entity.KeyName = Request.QueryString["keyname"];
        //DataTable dt = this.FactoryFramework.IFwConfiguration.GetTable(entity);

        //if (dt != null && dt.Rows.Count > 0)
        //{
        //    this.KeyName.Value = dt.Rows[0]["KeyName"].ToString();
        //    this.KeyValue.Value = dt.Rows[0]["KeyValue"].ToString();
        //    this.Remark.Value = dt.Rows[0]["Remark"].ToString();

        //    this.KeyName.Attributes.Add("readonly", "readonly");
        //    this.KeyName.Attributes.Add("style", "background-color:#efefef");

        //    if (this.Option == "view")
        //    {
        //        this.KeyValue.Attributes.Add("readonly", "readonly");
        //        this.KeyValue.Attributes.Add("style", "background-color:#efefef");

        //        this.Remark.Attributes.Add("readonly", "readonly");
        //        this.Remark.Attributes.Add("style", "background-color:#efefef");
        //    }
        //}
    }
    #endregion
}
