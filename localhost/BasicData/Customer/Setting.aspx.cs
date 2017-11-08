using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class BasicData_Customer_Setting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBinder();
        }
    }

    DataFactory dal = new DataFactory();

    public void DataBinder()
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() { dal.CreateIFields()
                  .Append("Option", "StatList")}).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            int currindex = 0;
            foreach (DataRow dr in dt.Rows)
            {
                chkModifiedStat.Items.Add(new System.Web.UI.WebControls.ListItem(dr["Stat"].ToString()));
                chkModifyStat.Items.Add(new System.Web.UI.WebControls.ListItem(dr["Stat"].ToString()));
                if (Convert.ToBoolean(dr["isModified"]))
                {
                    chkModifiedStat.Items[currindex].Selected = true;
                    chkModifiedStat.Items[currindex].Attributes.CssStyle.Add("color", "red");
                }

                if (Convert.ToBoolean(dr["isModify"]))
                {
                    chkModifyStat.Items[currindex].Selected = true;
                    chkModifyStat.Items[currindex].Attributes.CssStyle.Add("color", "red");

                }
                ++currindex;
            }
        }
    }


    [DirectMethod(Namespace = "CompanyX")]
    public void UpdateStat(string stat, string flag, string type)
    {

        bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() { dal.CreateIFields()
                  .Append("Option", "updateStatStatus")
                  .Append("stat", stat)
                  .Append("Active", Convert.ToBoolean(flag)?1:0)
                  .Append("user", "")
                  .Append("sys", type)}).Update();

        X.Msg.Alert("TITLE", stat + "," + flag + "," + type + "," + b.ToString()).Show();
    }

}
