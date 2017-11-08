using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;

/// <summary>
///LockDate 的摘要说明
/// </summary>
public class LockDate
{
   

	public LockDate()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}


    public static bool IsLock(string seed,string id)
    {
        if (seed != "" || id != "")
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CompareLockDate_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields()
            .Append("Seed",seed)
            .Append("ID",id)}).GetList();

            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0][0].ToString() == "Y")
                return true;
            else
                return false;
        }
        return false;
    }

    public static bool IsSave(string sys, string date)
    {
        if (sys != "" || date != "")
        {
            DataFactory dal = new DataFactory();
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CompareLockDate_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields()
            .Append("Sys",sys)
            .Append("date", ControlBinder.getDate(date == "" ? DBNull.Value : (object)date))}).GetList();

            if (ds.Tables[1].Rows.Count > 0 && ds.Tables[1].Rows[0][0].ToString() == "Y")
                return true;
            else
                return false;
        }
        return false;
    }
}