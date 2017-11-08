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

        //if (this.Option == "search") this.GetList();
        if (this.Option == "update") this.Update();
        //if (this.Option == "delete") this.Delete();
        //if (this.Option == "modify-pwd") this.ModifyPWD();
    }
    
    /// <summary>
    /// 修改密码
    /// </summary>
    private void ModifyPWD()
    {
        //bool bFlag = this.FactoryFramework.IFwUser.CheckPWD(Request.QueryString["username"], Request.Form["OUserPWD1"]);
        //if (bFlag)
        //{
        //    FwUserEntity entity = new FwUserEntity();
        //    entity.UserName = Request.QueryString["username"];
        //    entity.UserPWD = Request.Form["UserPWD"];
        //    bFlag = this.FactoryFramework.IFwUser.ModifyPWD(entity);

        //    if (bFlag) this.ReturnValue = this.Message.Replace("{Option}", "true"); else this.ReturnValue = this.Message.Replace("{Option}", "false");
        //}
        //else
        //{
        //    this.ReturnValue = this.Message.Replace("{Option}", "origin-error");
        //}
        //Response.Write(this.ReturnValue);
    }
    
    /// <summary>
    /// 新增, 修改
    /// </summary>
    private void Update()
    {
        bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "update")
            .Append("UserName", Request.Form["UserName"])
            .Append("IsActivation", Request.Form["IsActivation"])
            .Append("Email", Request.Form["Email"])
            
            .Append("CompanyID", Request.Form["CompanyID"])
            .Append("NameCHS", Request.Form["NameCHS"])
            .Append("NameENG", Request.Form["NameENG"])
            .Append("Question", Request.Form["Question"])
            .Append("Answer", Request.Form["Answer"])
            
            .Append("Creator", FSecurityHelper.CurrentUserDataGET()[0])
            .Append("Modifier", FSecurityHelper.CurrentUserDataGET()[0])
        }).Update();

        this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
        Response.Write(this.ReturnValue);
    }
    
    /// <summary>
    /// 删除
    /// </summary>
    /// 
    protected void Delete()
    {
        //FwUserEntity entity = new FwUserEntity();
        //this.InitDelete();
        //if (string.IsNullOrEmpty(Request.Form["chkItem"]))
        //    this.Message = this.ReturnValue.Replace("{Option}", "false");
        //else
        //{
        //    entity.IDlist = Request.Form["chkItem"];
        //    bool bFlag = this.FactoryFramework.IFwUser.Delete(entity);
        //    if (bFlag) this.Message = this.ReturnValue.Replace("{Option}", "true"); else this.Message = this.ReturnValue.Replace("{Option}", "false");
        //}
        //Response.Write(this.Message);
    }
    
    /// <summary>
    /// 获取列表
    /// </summary>
    private void GetList()
    {
        //FwUserEntity entity = new FwUserEntity();
        //this.Message = "{"
        //    + "\"CompanyNameCHS\":\"{CompanyNameCHS}\",\"UserName\":\"{UserName}\",\"NameCHS\":\"{NameCHS}\""
        //    + ",\"NameENG\":\"{NameENG}\",\"Email\":\"{Email}\",\"Question\":\"{Question}\""
        //    + ",\"Answer\":\"{Answer}\",\"Activation\":\"{Activation}\""
        //    + "}";

        //entity.UserName = Request.Form["UserName"];
        //entity.NameCHS = Request.Form["NameCHS"];
        //entity.Email = Request.Form["Email"];
        //DataTable dt = this.FactoryFramework.IFwUser.GetTable(entity);
        
        //if (dt == null && dt.Rows.Count == 0)
        //{
        //    this.ReturnValue = this.Message
        //        .Replace("{CompanyNameCHS}", "").Replace("{UserName}", "").Replace("{NameCHS}", "")
        //        .Replace("{NameENG}", "").Replace("{Email}", "").Replace("{Question}", "")
        //        .Replace("{Answer}", "").Replace("{Activation}", "");
        //}
        //else
        //{
        //    foreach (DataRow row in dt.Rows)
        //    {
        //        this.ReturnValue += "," + this.Message
        //            .Replace("{CompanyNameCHS}", row["CompanyNameCHS"].ToString()).Replace("{UserName}", row["UserName"].ToString()).Replace("{NameCHS}", row["NameCHS"].ToString())
        //            .Replace("{NameENG}", row["NameENG"].ToString()).Replace("{Email}", row["Email"].ToString()).Replace("{Question}", row["Question"].ToString())
        //            .Replace("{Answer}", row["Answer"].ToString()).Replace("{Activation}", row["Activation"].ToString());
        //    }
        //    this.ReturnValue = "[" + this.ReturnValue.Substring(1, this.ReturnValue.Length - 1) + "]";
        //}
        //Response.Write(this.ReturnValue);
    }
}
