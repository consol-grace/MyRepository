using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;

/// <summary>
///OEHandler 的摘要说明
/// </summary>
public class OEHandler
{
	public OEHandler()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    public static string ValidHBL(string oldname, string name, string id)
    {
        string flag = "N";

        try
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_HBL_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "ValidHBLNo")
                 .Append("o_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("OldHBL",oldname).Append("o_HBL",name).Append("Seed",id)}).GetList();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                flag = ds.Tables[0].Rows[0][0].ToString();
            }
        }
        catch
        {
            flag = "Y";
        }


        return flag;
    }
}
