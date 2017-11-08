using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Wuqi.Webdiyer;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.BASECLASS;

public partial class Framework_Company_list : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack)
        //    this.ShowList();
    }

    protected void ShowList()
    {
        //FwCompanyEntity entity = new FwCompanyEntity();
        //DataTable dt = this.FactoryFramework.IFwCompany.GetTable(entity);
        //PaginationHelper.Instance.Pagination(dt, this.Repeater1,this.AspNetPager1, 18);
    }

    protected void AspNetPager1_OnPageChanging(object src, PageChangingEventArgs e)
    {
        AspNetPager1.CurrentPageIndex = e.NewPageIndex;
        ShowList();
    }
}
