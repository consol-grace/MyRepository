<%@ WebHandler Language="C#" Class="DataController" %>

using System;
using System.Web;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;
using DIYGENS.COM.JQUERY;

public class DataController : DIYGENS.COM.BASECLASS.ControllerBase
{
    
    protected override void Page_Load(object sender, EventArgs e)
    {
        this.Option = Request.QueryString["Option"];
        this.Message = "[{\"Option\":\"{Option}\"}]";
        switch (this.Option)
        {
            case "list": this.list(); break;
            case "update": this.update(); break;
        }
    }

    #region list()   Author: Hcy ( 2011-08-22 )
    /// <summary>
    /// 获取列表
    /// </summary>
    private void list()
    {
        DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Airline_SP", new List<IFields>() { this.CreateIFields().Append("Option", "List")

        }).GetTable();

        this.ReturnValue = this.ToJSON(dt);
        Response.Write(this.ReturnValue);
    }
    #endregion


    #region update()   Author: Hcy ( 2011-08-22 )
    /// <summary>
    /// 更新
    /// </summary>
    private void update()
    {
        bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Airline_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS",FSecurityHelper.CurrentUserDataGET()[11].Substring(0,1))
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("Code",Request.Form["Code"].ToUpper().Trim())
                .Append("Name",Request.Form["Name"].ToUpper().Trim())
                .Append("Country",Request.Form["Country"].Trim()=="Select..."?"":Request.Form["Country"].ToUpper().Trim().Split(' ')[0])
                .Append("CallSign",Request.Form["txtCallSign"].ToUpper().Trim().ToString())
                .Append("Active",Request.QueryString["chkActive"])
                .Append("ROWID",Request.Form["hidRowID"].Trim())
            
        }).Update();

        this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
        Response.Write(this.ReturnValue);
    }
    #endregion
    
}
