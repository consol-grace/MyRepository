<%@ WebHandler Language="C#" Class="DataController" %>

using System;
using System.Web;
using System.Data;
using DIYGENS.COM.JQUERY;

public class DataController : DIYGENS.COM.BASECLASS.ControllerBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        //this.InitVariable(ContentType.HTML);
        //this.Option = Request.QueryString["Option"];
        //this.Entity = new FwCompanyEntity();
        //this.Entity.CompanyID = Request.QueryString["companyid"];

        //if (this.Option == "search") this.GetList();
        //if (this.Option == "update") this.Update();
        //if (this.Option == "delete") this.Delete();
    }
    
    /// <summary>
    /// 新增, 修改
    /// </summary>
    private void Update()
    {
        //this.Entity.CompanyID = Request.Form["CompanyID"];
        //this.Entity.NameCHS = Request.Form["NameCHS"];
        //this.Entity.NameENG = Request.Form["NameENG"];
        //this.Entity.District = Request.Form["District"];
        //bool bFlag = this.FactoryFramework.IFwCompany.Addnew(this.Entity);

        //this.Message = "[{\"Option\":\"{Option}\"}]";
        //this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
        //Response.Write(this.ReturnValue);
    }
    
    /// <summary>
    /// 删除
    /// </summary>
    /// 
    protected void Delete()
    {
        //this.InitDelete();
        //if (string.IsNullOrEmpty(Request.Form["chkItem"]))
        //    this.Message = this.ReturnValue.Replace("{Option}", "false");
        //else
        //{
        //    this.Entity.IDlist = Request.Form["chkItem"];
        //    bool bFlag = this.FactoryFramework.IFwCompany.Delete(this.Entity);
        //    if (bFlag) this.Message = this.ReturnValue.Replace("{Option}", "true"); else this.Message = this.ReturnValue.Replace("{Option}", "false");
        //}
        //Response.Write(this.Message);
    }
    
    /// <summary>
    /// 获取列表
    /// </summary>
    private void GetList()
    {
        //this.Message = "{\"CompanyID\":\"{CompanyID}\",\"NameCHS\":\"{NameCHS}\",\"NameENG\":\"{NameENG}\",\"District\":\"{District}\"}";
        //this.Entity.CompanyID = Request.Form["CompanyID"];
        //this.Entity.NameCHS = Request.Form["NameCHS"];
        //DataTable dt = this.FactoryFramework.IFwCompany.GetTable(this.Entity);
        //if (dt == null && dt.Rows.Count == 0)
        //{
        //    this.ReturnValue = this.Message.Replace("{CompanyID}", "")
        //        .Replace("{NameCHS}", "")
        //        .Replace("{NameENG}", "")
        //        .Replace("{District}", "");
        //}
        //else
        //{
        //    foreach (DataRow row in dt.Rows)
        //    {
        //        this.ReturnValue += "," + this.Message.Replace("{CompanyID}", row["CompanyID"].ToString())
        //            .Replace("{NameCHS}", row["NameCHS"].ToString())
        //            .Replace("{NameENG}", row["NameENG"].ToString())
        //            .Replace("{District}", row["District"].ToString());
        //    }
        //    this.ReturnValue = "[" + this.ReturnValue.Substring(1, this.ReturnValue.Length - 1) + "]";
        //}
        //Response.Write(this.ReturnValue);
    }
}
