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
        //this.Entity = new FwMenuEntity();
        //this.Entity.MenuID = Request.QueryString["menuid"];

        //if (this.Option == "list") this.GetTreeList();
        //if (this.Option == "detail") this.GetTreeDetail();
        //if (this.Option == "delete") this.Delete();
        //if (this.Option == "save-main") this.UpdateMain();
        //if (this.Option == "save-sub") this.UpdateSub();
    }
    
    /// <summary>
    /// 保存资料(main)
    /// </summary>
    private void UpdateMain()
    {
        //this.Entity.RootID = Request.Form["RootID"];
        //this.Entity.ParentID = Request.Form["ParentID"];
        //this.Entity.MenuID = Request.Form["MenuID"];
        //this.Entity.NameCHS = Request.Form["NameCHS"];
        //this.Entity.Hyperlink = Request.Form["Hyperlink"];
        //bool bFlag = this.FactoryFramework.IFwMenu.Addnew(this.Entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }

    /// <summary>
    /// 保存资料(sub)
    /// </summary>
    private void UpdateSub()
    {
        //this.Entity.RootID = Request.Form["RootID1"];
        //this.Entity.ParentID = Request.Form["ParentID1"];
        //this.Entity.MenuID = Request.Form["MenuID1"];
        //this.Entity.NameCHS = Request.Form["NameCHS1"];
        //this.Entity.Hyperlink = Request.Form["Hyperlink1"];
        //bool bFlag = this.FactoryFramework.IFwMenu.Addnew(this.Entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }
    
    /// <summary>
    /// 删除资料
    /// </summary>
    private void Delete()
    {
        //this.Entity.IDlist = this.Entity.MenuID;
        //bool bFlag = this.FactoryFramework.IFwMenu.Delete(this.Entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }
    
    /// <summary>
    /// 获取明细资料
    /// </summary>
    private void GetTreeDetail()
    {
        //this.Message = "{\"RootID\":\"{RootID}\",\"ParentID\":\"{ParentID}\",\"PNameCHS\":\"{PNameCHS}\",\"MenuID\":\"{MenuID}\",\"NameCHS\":\"{NameCHS}\",\"Hyperlink\":\"{Hyperlink}\"}";
        //DataTable dt = this.FactoryFramework.IFwMenu.TreeDetail(this.Entity);
        //if (dt == null && dt.Rows.Count == 0)
        //{
        //    this.ReturnValue = this.Message.Replace("{RootID}", "")
        //        .Replace("{ParentID}", "")
        //        .Replace("{PNameCHS}", "")
        //        .Replace("{MenuID}", "")
        //        .Replace("{NameCHS}", "")
        //        .Replace("{Hyperlink}", "");
        //}
        //else
        //{
        //    DataRow Row = dt.Rows[0];
        //    this.ReturnValue = this.Message.Replace("{RootID}", Row["RootID"].ToString())
        //        .Replace("{ParentID}", Row["ParentID"].ToString())
        //        .Replace("{PNameCHS}", Row["PNameCHS"].ToString())
        //        .Replace("{MenuID}", Row["MenuID"].ToString())
        //        .Replace("{NameCHS}", Row["NameCHS"].ToString())
        //        .Replace("{Hyperlink}", Row["Hyperlink"].ToString());
        //}
        //Response.Write("[" + this.ReturnValue + "]");
    }
    
    /// <summary>
    /// 获取列表
    /// </summary>
    private void GetTreeList()
    {
        //DataTable dt = this.FactoryFramework.IFwMenu.TreeList();
        //Response.Write(TreeHelper.Display(dt));
    }
}
