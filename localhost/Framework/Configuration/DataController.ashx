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
        //FwConfigurationEntity entity = new FwConfigurationEntity();
        //entity.KeyName = Request.Form["KeyName"];
        //entity.KeyValue = Request.Form["KeyValue"];
        //entity.Remark = Request.Form["Remark"];
        //entity.Creator = this.UserLoginData.UserName;
        //entity.Modifier = this.UserLoginData.UserName;
        //bool bFlag = this.FactoryFramework.IFwConfiguration.Addnew(entity);

        //this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
        //Response.Write(this.ReturnValue);
    }
    
    /// <summary>
    /// 删除
    /// </summary>
    /// 
    protected void Delete()
    {
        //FwConfigurationEntity entity = new FwConfigurationEntity();
        //this.InitDelete();
        //if (string.IsNullOrEmpty(Request.Form["chkItem"]))
        //    this.Message = this.ReturnValue.Replace("{Option}", "false");
        //else
        //{
        //    entity.IDlist = Request.Form["chkItem"];
        //    bool bFlag = this.FactoryFramework.IFwConfiguration.Delete(entity);
        //    if (bFlag) this.Message = this.ReturnValue.Replace("{Option}", "true"); else this.Message = this.ReturnValue.Replace("{Option}", "false");
        //}
        //Response.Write(this.Message);
    }
    
    /// <summary>
    /// 获取列表
    /// </summary>
    private void GetList()
    {
        //FwConfigurationEntity entity = new FwConfigurationEntity();
        //this.Message = "{"
        //    + "\"KeyName\":\"{KeyName}\",\"KeyValue\":\"{KeyValue}\",\"Remark\":\"{Remark}\""
        //    + "}";

        //entity.KeyName = Request.Form["KeyName"];
        //entity.KeyValue = Request.Form["KeyValue"];
        //DataTable dt = this.FactoryFramework.IFwConfiguration.GetTable(entity);
        
        //if (dt == null && dt.Rows.Count == 0)
        //{
        //    this.ReturnValue = this.Message.Replace("{KeyName}", "").Replace("{KeyValue}", "").Replace("{Remark}", "");
        //}
        //else
        //{
        //    foreach (DataRow row in dt.Rows)
        //    {
        //        this.ReturnValue += "," + this.Message.Replace("{KeyName}", row["KeyName"].ToString()).Replace("{KeyValue}", row["KeyValue"].ToString()).Replace("{Remark}", row["Remark"].ToString());
        //    }
        //    this.ReturnValue = "[" + this.ReturnValue.Substring(1, this.ReturnValue.Length - 1) + "]";
        //}
        //Response.Write(this.ReturnValue);
    }
}
