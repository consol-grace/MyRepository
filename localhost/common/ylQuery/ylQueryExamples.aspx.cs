using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DIYGENS.COM.BASECLASS;

public partial class Common_ylQuery_ylQueryExamples : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        this.Option = Request.QueryString["Option"];
        if (String.IsNullOrEmpty(this.Option)) this.InitData();

        if (this.Option == "table-dome-list") this.TABLE_DOME_LIST();
    }

    #region InitData()   初始化资料   作者: Richard ( 2011-07-06 )
    /// <summary>
    /// 初始化资料
    /// </summary>
    private void InitData()
    {

    }
    #endregion

    #region TABLE_DOME_LIST()   作者: Richard ( 2011-07-06 )
    /// <summary>
    /// 
    /// </summary>
    private void TABLE_DOME_LIST()
    {
        this.Message = "姓名: {NameCHS}\n邮箱: {Email}\n电话: {Tel}\n密码: {Password}\n选择框: {chkItem}";
        this.ReturnValue = this.Message.Replace("{NameCHS}", Request.Form["NameCHS"])
            .Replace("{Email}", Request.Form["Email"])
            .Replace("{Tel}", Request.Form["Tel"])
            .Replace("{Password}", Request.Form["Password"])
            .Replace("{chkItem}", Request.Form["chkItem"]);

        Response.Write(this.ReturnValue);
        Response.End();
    }
    #endregion
}
