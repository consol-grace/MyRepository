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
            case "list": this.List(); break; 
            case "update": this.Update(); break;
            case "add": this.Add(); break;
            case "delete": this.Delete(); break;  
        }
    }

    #region List()   Author: Hcy ( 2011-08-22 )
    /// <summary>
    /// 获取列表
    /// </summary>
    private void List()
    {
        DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Add")
            .Append("UserName", Request.Form["UserName"])
            .Append("IsActivation", Request.Form["IsActivation"])
        }).GetTable();

        this.ReturnValue =this.ToJSON(dt);
        Response.Write(this.ReturnValue);
    }
    #endregion

    #region Add()   Author: Hcy ( 2011-08-22 )
    /// <summary>
    /// 新增
    /// </summary>
    private void Add()
    {
        bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Add")
            .Append("UserName", Request.Form["UserName"])
            .Append("IsActivation", Request.Form["IsActivation"])
        }).Update();

        this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
        Response.Write(this.ReturnValue);
    }
    #endregion

    #region Update()   Author: Hcy ( 2011-08-22 )
    /// <summary>
    /// 更新
    /// </summary>
    private void Update()
    {
        bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Add")
            .Append("UserName", Request.Form["UserName"])
            .Append("IsActivation", Request.Form["IsActivation"])
        }).Update();

        this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
        Response.Write(this.ReturnValue);
    }
    #endregion
    
    #region Delete()   Author: Hcy ( 2011-08-22 )
    /// <summary>
    /// 删除
    /// </summary>
    /// 
    protected void Delete()
    {
        string IDlist = Request.Form["chkItem"];
        bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Add")
            .Append("UserName", Request.Form["UserName"])
            .Append("IsActivation", Request.Form["IsActivation"])
        }).Update();

        this.ReturnValue = PageHelper.SplitToJSON(bFlag, IDlist);  
    }
    #endregion
    
}
