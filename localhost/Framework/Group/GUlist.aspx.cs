﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.BASECLASS;

public partial class Framework_Group_GUlist : PageBase
{
    protected DataTable dt1, dt2;

    protected override void Page_Load(object sender, EventArgs e)
    {
        //this.dt1 = this.FactoryFramework.IMenuFrame.GroupUserCompany();
    }

}
