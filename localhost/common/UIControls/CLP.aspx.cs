using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Ext.Net;
using System.Collections.Generic;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;

public partial class common_UIControls_CLP : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtCntrNo.Value = Request["cntrno"];
            txtToMBL.Value = Request["tombl"];
            labCntrNo.InnerText = Request["cntrno"];
        }
    }

}