using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using CrystalDecisions.CrystalReports.Engine;

/// <summary>
///CompanyView 的摘要说明
/// </summary>
public class CompanyView
{
    public CompanyView()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //

    }

    public static ReportDocument Preview(string print, int fcount,string reportType, string comtype, string sort, string printname, System.Web.UI.Page page)
    {
        DataFactory dal = new DataFactory();
        string top = "0", left = "0", right = "0", bottom = "0";
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Print_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "PrintMargin")
                 .Append("prt_STAT",FSecurityHelper.CurrentUserDataGET()[12]).Append("prt_ReportCode",reportType).Append("prt_sys","OE").Append("prt_PrinterName",printname)
        }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            top = ds.Tables[0].Rows[0][0].ToString();
            bottom = ds.Tables[0].Rows[0][1].ToString();
            left = ds.Tables[0].Rows[0][2].ToString();
            right = ds.Tables[0].Rows[0][3].ToString();
        }

        CrystalDecisions.CrystalReports.Engine.ReportDocument doc = ReportHelper.SetReportDoc(Convert.ToDouble(top), Convert.ToDouble(bottom), Convert.ToDouble(left), Convert.ToDouble(right), fcount, GetNums(print, printname, comtype.ToUpper(), sort, page));
        //CrystalReportViewer1.ReportSource = doc;
        //CrystalReportViewer1.DataBind();
        return doc;
    }

    public static string[] GetNums(string flag, string printName, string type, string sort, System.Web.UI.Page page)
    {
        string[] nums = new string[5];
        nums[0] = page.Server.MapPath("~/BasicData/Customer/company_report/Company_Report.rpt");
        nums[1] = flag;
        nums[2] = printName;
        nums[3] = type;
        nums[4] = sort;

        return nums;
    }
}
