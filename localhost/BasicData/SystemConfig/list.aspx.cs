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


public partial class BasicData_Country_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
            DataBinder();
       
    }



    /// <summary>
    /// Grid 数据绑定   
    /// </summary>
    #region   DataBinder()   Author: Micro ( 2011-08-26 )
    void DataBinder()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_SystemString_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List") }).GetList();
        StoreDomestic.DataSource = ds;
        StoreDomestic.DataBind();
    }
    #endregion
    
}
