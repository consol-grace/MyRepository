using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using DIYGENS.COM.FRAMEWORK;
using System.Data;
using DIYGENS.COM.DBLL;

/// <summary>
///BaseCheckCode 的摘要说明
/// </summary>
public class BaseCheckCode
{
    public BaseCheckCode()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    private readonly static DataFactory dal = new DataFactory();

    public static string Check(string type, string code, string sys, string rowid)
    {
        string flag = "N";

        try
        {
            if (string.IsNullOrEmpty(code))
                flag = "N";
            else
            {
                flag = CheckIsExist(type, code, sys, rowid);
            }
        }
        catch
        {
            flag = "N";
        }
        return flag;
    }

    public static string CheckIsExist(string type, string code, string sys, string rowid)
    {
        string flag = "N";
        string cmdText = string.Empty;
        string userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();

        switch (type.ToUpper())
        {
            case "ITEM":
                cmdText = string.Format(@"
                    if exists(select * from fw_company where isnull(fco_isServer, 0) = 1 and IsDelete = 'N') and '{0}' in ('IT','ADMIN')
                    begin
                        select  MIN(itm_ROWID) from cs_item  where itm_code='{1}' and itm_SYS='{2}'
                    end 
                    else
                    begin
                        select  itm_ROWID from cs_item  where itm_code='{1}' and itm_SYS='{2}' and itm_stat='{3}'
                    end
                    ", userDept, code, sys, FSecurityHelper.CurrentUserDataGET()[12]);
                break;
            case "SALESMAN": //SELECT * FROM cs_Sales where sal_STAT='' and sal_Code 
                cmdText = "select MAX(sal_RowID) from cs_Sales  where sal_Code='" + code + "'";
                break;
            case "COMPANY": //select co_rowid from cs_Company where co_CODE='' and co_STAT='' and co_CompanyKind='base'
                cmdText = "select MAX(co_seedkey) from cs_Company  where co_CODE='" + code + "'  and  co_CompanyKind='base'";
                break;
            case "LOCATION":
                cmdText = "select MAX(loc_ROWID) from cs_Location where loc_Code='" + code + "' and loc_new=1";
                break;
            case "LOCDESC":
                cmdText = "select MAX(loc_ROWID) from cs_Location where loc_Name='" + code + "' and loc_new=1";
                break;
            case "CURRENCY":
                cmdText = "select cur_RowID from cs_currency where cur_code='" + code + "' and cur_sys='" + sys + "'";
                break;
            case "CONTAINER SIZE":
                cmdText = "select MAX(ctnr_ROWID) from cs_Container  where ctnr_Code LIKE '" + code.Replace("'","_") + "'";
                break;
            case "AIRLINE":
                cmdText = "select MAX(al_ROWID) from cs_Airline  where al_Code='" + code + "'";
                break;
            case "DOMESTICSTATUS":
                cmdText = "select MAX(dk_ROWID) from cs_DomesticKind  where dk_Code='" + code + "'";
                break;
            case "SERVICEMODE":
                cmdText = "select MAX(sm_ROWID) from cs_ServiceMode  where sm_CODE='" + code + "'";
                break;
            case "UNIT":
                cmdText = "select MAX(unt_ROWID) from cs_Unit  where unt_Type='PKG' and unt_Code='" + code + "'";
                break;
        }

        SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings);

        con.Open();
        SqlCommand cmd = new SqlCommand(cmdText, con);
        object result = cmd.ExecuteScalar();
        con.Close();
        if (result == null || result == DBNull.Value)//if (result == null) // result == DBNull.Value解决有时候result返回的是""
            flag = "Y";
        else if (result.ToString() == rowid)//if (result != null && result.ToString() == rowid) //这样可以少了一步判断
            flag = "Y";
        
        return flag;
    }

    /// <summary>
    /// 针对于ITEM特殊页面，重写的验证方法   grace
    /// </summary>
    /// <param name="type">类型</param>
    /// <param name="code">des文本框的值</param>
    /// <param name="sys">当前系统</param>
    /// <param name="rowid">记录ID</param>
    /// <param name="descode">CODE文本框的值</param>
    /// <returns></returns>
    public static string CheckIsExist(string type, string code, string sys, string rowid, string descode)
    {
        string flag = "N";
        string cmdText = string.Empty;
        string userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();

        switch (type.ToUpper())
        {
            case "ITEMDESC":
                cmdText = string.Format(@"
                    if exists(select * from fw_company where isnull(fco_isServer, 0) = 1 and IsDelete = 'N') and '{0}' in ('IT','ADMIN')
                    begin
                        select MIN(itm_RowID) from cs_item  where itm_Description='{1}' and itm_SYS='{2}' and itm_Code!='{3}'
                    end 
                    else
                    begin
                        select itm_RowID from cs_item  where itm_Description='{1}' and itm_SYS='{2}' and itm_stat='{4}'
                    end
                    ", userDept, code, sys, descode, FSecurityHelper.CurrentUserDataGET()[12]);
                break;
        }

        SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings);

        con.Open();
        SqlCommand cmd = new SqlCommand(cmdText, con);
        object result = cmd.ExecuteScalar();
        con.Close();
        if (result == null || result == DBNull.Value)//if (result == null) // result == DBNull.Value解决有时候result返回的是""
            flag = "Y";
        else if (result.ToString() == rowid)//if (result != null && result.ToString() == rowid) //这样可以少了一步判断
            flag = "Y";

        return flag;
    }
    //检查是否包含特殊字符
    public static string CheckChar(string value)
    {
        string flag = "N";

        string[] strChar = { "/", "'", "\"", "\\", "<", ">", "*", "&", "!", "=", "%", "-" };
        foreach (string str in strChar)
        {
            flag = value.Contains(str) ? "Y" : "N";
            if (flag == "Y")
                break;
        }
        return flag;
    }


    public static string CheckType(string type, string code, ref int typeLen)
    {
        string flag = "N";
        type = type.ToUpper();

        int len = code.Trim().Length;
        if (type == "AIRLINE" && len != 2)
        { flag = "N"; typeLen = 2; }
        else if (type == "VESSEL" && len != 3)
        { flag = "N"; typeLen = 3; }
        else if (type == "BRANCH" && len != 7)
        { flag = "N"; typeLen = 7; }
        else if (type == "AG_CL" && len != 7)
        { flag = "N"; typeLen = 7; }
        else if (type == "OTHERS" && len != 4)
        { flag = "N"; typeLen = 4; }
        else if (type == "TK_WH" && len != 5)
        { flag = "N"; typeLen = 5; }
        else if (type == "CUST" && len != 8)
        { flag = "N"; typeLen = 8; }
        else { flag = "Y"; }
        return flag.ToUpper();
    }

    /// <summary>
    /// 检查Location Code 是否存在，不存在返回空值
    /// </summary>
    /// <param name="code"></param>
    /// <returns></returns>
    public static string locationCheckCode(string code)
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "[FW_BasicData_Location_SP]", new List<IFields>() { dal.CreateIFields().
                Append("Option", "ValidLocation").
                Append("Code",code).
                Append("ID","0")}).GetTable();
        if (dt.Rows[0][0].ToString() == "N")
            code = "";
        return code;
    }
}
