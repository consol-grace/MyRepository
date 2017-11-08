using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class common_ylQuery_UserNewInvoice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string curSys = Request["curSys"];
        ControlBinder.CmbBinder(StoreCurrInvoice, "CurrencysInvoice", curSys);
    }
}