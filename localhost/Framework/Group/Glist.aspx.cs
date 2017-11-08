using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.JQUERY;
using DIYGENS.COM.BASECLASS;

public partial class Framework_Group_Glist : PageBase
{
    protected DataTable dt;

    protected override void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack) this.InitData();
    }

    #region InitData()   初始化资料   作者: Richard ( 2011-03-29 )
    /// <summary>
    /// 初始化资料
    /// </summary>
    private void InitData()
    {
        //dt = this.FactoryFramework.IFwGroup.TreeRoot();
    }
    #endregion
}
