﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wuqi.Webdiyer;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.BASECLASS;

public partial class Framework_Permission_list : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack)
        //    this.ShowList();
    }

    protected void ShowList()
    {
        //FwPermissionEntity entity = new FwPermissionEntity();
        //DataTable dt = this.FactoryFramework.IFwPermission.GetTable(entity);
        //PaginationHelper.Instance.Pagination(dt, this.Repeater1, this.AspNetPager1, 18);
    }

    protected void AspNetPager1_OnPageChanging(object src, PageChangingEventArgs e)
    {
        this.AspNetPager1.CurrentPageIndex = e.NewPageIndex;
        ShowList();
    }
}
