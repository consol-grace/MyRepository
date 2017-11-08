using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using System.Text.RegularExpressions;
using System.Text;
using System.IO;


/// <summary>
///VoidCheckAC 的摘要说明
/// </summary>
public class VoidCheckAC
{
    public VoidCheckAC()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    private static readonly DataFactory dal = new DataFactory();

    public static string Message = "Sorry, operation failed.The data has been fetched, delete operation can not be performed, please check the data!";

    public static bool CheckisAC(string sys, string seed)
    {
        bool flag = true;
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllSystem_VoidCheckIsAC_SP", new List<IFields>() { dal.CreateIFields().
                Append("Option", "check").
                Append("seed", seed).
                Append("sys",sys)}).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            try
            {
                if (Convert.ToInt32(dt.Rows[0][0]) + Convert.ToInt32(dt.Rows[1][0]) > 0)
                    flag = false;
            }
            catch (Exception exp)
            {
                flag = true;
            }
        }

        return flag;
    }

}
