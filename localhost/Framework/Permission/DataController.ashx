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
        //this.Message = "[{\"Option\":\"{Option}\"}]";        

        //if (this.Option == "search") this.GetList();
        //if (this.Option == "update") this.Update();
        //if (this.Option == "delete") this.Delete();
    }
    
    /// <summary>
    /// 新增, 修改
    /// </summary>
    private void Update()
    {
        //FwPermissionEntity entity = new FwPermissionEntity();
        //entity.PermissionID = Request.Form["PermissionID"];
        //entity.NameCHS = Request.Form["NameCHS"];
        //entity.NameENG = Request.Form["NameENG"];
        //entity.Remark = Request.Form["Remark"];
        //entity.Creator = this.UserLoginData.UserName;
        //entity.Modifier = this.UserLoginData.UserName;
        //bool bFlag = this.FactoryFramework.IFwPermission.Addnew(entity);

        //this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
        //Response.Write(this.ReturnValue);
    }
    
    /// <summary>
    /// 删除
    /// </summary>
    /// 
    protected void Delete()
    {
        //FwPermissionEntity entity = new FwPermissionEntity();
        //this.InitDelete();
        //if (string.IsNullOrEmpty(Request.Form["chkItem"]))
        //    this.Message = this.ReturnValue.Replace("{Option}", "false");
        //else
        //{
        //    entity.IDlist = Request.Form["chkItem"];
        //    bool bFlag = this.FactoryFramework.IFwPermission.Delete(entity);
        //    if (bFlag) this.Message = this.ReturnValue.Replace("{Option}", "true"); else this.Message = this.ReturnValue.Replace("{Option}", "false");
        //}
        //Response.Write(this.Message);
    }
    
    /// <summary>
    /// 获取列表
    /// </summary>
    private void GetList()
    {
        //FwPermissionEntity entity = new FwPermissionEntity();
        //this.Message = "{"
        //    + "\"PermissionID\":\"{PermissionID}\",\"NameCHS\":\"{NameCHS}\",\"NameENG\":\"{NameENG}\""
        //    + "}";

        //entity.PermissionID = Request.Form["PermissionID"];
        //entity.NameCHS = Request.Form["NameCHS"];
        //DataTable dt = this.FactoryFramework.IFwPermission.GetTable(entity);
        
        //if (dt == null && dt.Rows.Count == 0)
        //{
        //    this.ReturnValue = this.Message.Replace("{PermissionID}", "").Replace("{NameCHS}", "").Replace("{NameENG}", "");
        //}
        //else
        //{
        //    foreach (DataRow row in dt.Rows)
        //    {
        //        this.ReturnValue += "," + this.Message.Replace("{PermissionID}", row["PermissionID"].ToString()).Replace("{NameCHS}", row["NameCHS"].ToString()).Replace("{NameENG}", row["NameENG"].ToString());
        //    }
        //    this.ReturnValue = "[" + this.ReturnValue.Substring(1, this.ReturnValue.Length - 1) + "]";
        //}
        //Response.Write(this.ReturnValue);
    }
}
