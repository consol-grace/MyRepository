using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.DBLL;

public partial class AirExport_AEViewConsol_transfer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = "", seed = "", type = "0";

        id = Request["ID"];
        seed = Request["Seed"];
        DataFactory dal = new DataFactory();
        DataSet result = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ViewConsol_SP", new List<IFields> { dal.CreateIFields().Append("Option", "GetViewDetail")
            .Append("air_ROWID", id) }).GetList();

        if (result != null && result.Tables[0].Rows.Count > 0)
        {
            type = result.Tables[0].Rows[0][0].ToString();
            if (type == "0")
            {
                X.Redirect("../AEConsolAndDirect/List.aspx?type=c&seed=" + seed);
            }
            else if (type == "1")
            {
                X.Redirect("../AEColoaderDirect/List.aspx?seed=" + seed);
            }
            else if (type == "2")
            {
                X.Redirect("../AEConsolAndDirect/List.aspx?type=d&seed=" + seed);

            }
        }
    }
}
