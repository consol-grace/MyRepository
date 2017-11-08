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
        //this.Entity = new FwGroupEntity();
        //this.Entity.GroupID = Request.QueryString["groupid"];

        //if (this.Option == "list") this.GetTreeList();
        //if (this.Option == "detail") this.GetTreeDetail();
        //if (this.Option == "delete") this.Delete();
        //if (this.Option == "save-main") this.UpdateMain();
        //if (this.Option == "save-sub") this.UpdateSub();


        //if (this.Option == "groupuser-update") this.GroupUserUpdate();
        //if (this.Option == "groupuser-checked") this.GroupUserChecked();

        //if (this.Option == "grouppermission-update") this.GroupPermissionUpdate();
        //if (this.Option == "grouppermission-checked") this.GroupPermissionChecked();

        //if (this.Option == "groupmenu-update") this.GroupMenuUpdate();
        //if (this.Option == "groupmenu-delete") this.GroupMenuDelete();
        //if (this.Option == "groupmenu-checked") this.GroupMenuChecked();
    }

    /// <summary>
    /// 保存资料 ( GroupPermisstion )
    /// </summary>
    private void GroupMenuUpdate()
    {
        //string IDlist = Request.QueryString["menuid"];
        //string GroupID = Request.QueryString["groupid"];

        //MenuFrameEntity entity = new MenuFrameEntity();
        //entity.GroupID = GroupID;
        //entity.IDlist = IDlist;
        //bool bFlag = this.FactoryFramework.IMenuFrame.GroupMenuUpdate(entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }
    /// <summary>
    /// 删除资料 ( GroupPermisstion )
    /// </summary>
    private void GroupMenuDelete()
    {
        //string IDlist = Request.QueryString["menuid"];
        //string GroupID = Request.QueryString["groupid"];

        //MenuFrameEntity entity = new MenuFrameEntity();
        //entity.GroupID = GroupID;
        //entity.MenuID = IDlist;
        //bool bFlag = this.FactoryFramework.IMenuFrame.GroupMenuDelete(entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }
    /// <summary>
    /// 验证是否选中 ( GroupPermisstion )
    /// </summary>
    private void GroupMenuChecked()
    {
        //string GroupID = Request.QueryString["groupid"];
        //this.Message = "{\"ID\":\"{ID}\"}";

        //MenuFrameEntity entity = new MenuFrameEntity();
        //entity.GroupID = GroupID;
        //string IDlist = this.FactoryFramework.IMenuFrame.GroupMenuChecked(entity).Rows[0]["IDlist"].ToString();
        //if (!String.IsNullOrEmpty(IDlist) && IDlist.IndexOf(",") == -1)
        //{
        //    this.ReturnValue = this.Message.Replace("{ID}", IDlist);
        //}
        //else
        //{
        //    string[] list = IDlist.Split(',');
        //    for (int i = 0; i < list.Length; i++)
        //    {
        //        this.ReturnValue += "," + this.Message.Replace("{ID}", list[i]);
        //    }
        //    this.ReturnValue = this.ReturnValue.Substring(1, this.ReturnValue.Length - 1);
        //}
        //this.ReturnValue = "[" + this.ReturnValue + "]";
        //Response.Write(this.ReturnValue);
    }
    
    
    /// <summary>
    /// 保存资料 ( GroupPermisstion )
    /// </summary>
    private void GroupPermissionUpdate()
    {
        //string IDlist = Request.Form["chkItem"];
        //string GroupID = Request.QueryString["groupid"];

        //MenuFrameEntity entity = new MenuFrameEntity();
        //entity.GroupID = GroupID;
        //entity.IDlist = IDlist;
        //bool bFlag = this.FactoryFramework.IMenuFrame.GroupPermissionUpdate(entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }
    /// <summary>
    /// 验证是否选中 ( GroupPermisstion )
    /// </summary>
    private void GroupPermissionChecked()
    {
        //string GroupID = Request.QueryString["groupid"];
        //this.Message = "{\"ID\":\"{ID}\"}";

        //MenuFrameEntity entity = new MenuFrameEntity();
        //entity.GroupID = GroupID;
        //string IDlist = this.FactoryFramework.IMenuFrame.GroupPermissionChecked(entity).Rows[0]["IDlist"].ToString();
        //if (!String.IsNullOrEmpty(IDlist) && IDlist.IndexOf(",") == -1)
        //{
        //    this.ReturnValue = this.Message.Replace("{ID}", IDlist);
        //}
        //else
        //{
        //    string[] list = IDlist.Split(',');
        //    for (int i = 0; i < list.Length; i++)
        //    {
        //        this.ReturnValue += "," + this.Message.Replace("{ID}", list[i]);
        //    }
        //    this.ReturnValue = this.ReturnValue.Substring(1, this.ReturnValue.Length - 1);
        //}
        //this.ReturnValue = "[" + this.ReturnValue + "]";
        //Response.Write(this.ReturnValue);
    }

    
    
    /// <summary>
    /// 验证是否选中 ( GroupUser )
    /// </summary>
    private void GroupUserChecked()
    {
        //string GroupID = Request.QueryString["groupid"];
        //string CompanyID = Request.QueryString["companyid"];
        //this.Message = "{\"ID\":\"{ID}\"}";

        //MenuFrameEntity entity = new MenuFrameEntity();
        //entity.GroupID = GroupID;
        //entity.CompanyID = CompanyID;
        //string IDlist = this.FactoryFramework.IMenuFrame.GroupUserChecked(entity).Rows[0]["IDlist"].ToString();
        //if (!String.IsNullOrEmpty(IDlist) && IDlist.IndexOf(",") == -1)
        //{
        //    this.ReturnValue = this.Message.Replace("{ID}", IDlist);
        //}
        //else
        //{
        //    string[] list = IDlist.Split(',');
        //    for (int i = 0; i < list.Length; i++)
        //    {
        //        this.ReturnValue += "," + this.Message.Replace("{ID}", list[i]);
        //    }
        //    this.ReturnValue = this.ReturnValue.Substring(1, this.ReturnValue.Length - 1);
        //}
        //this.ReturnValue = "[" + this.ReturnValue + "]";
        //Response.Write(this.ReturnValue);
    }    
    /// <summary>
    /// 保存资料 ( GroupUser )
    /// </summary>
    private void GroupUserUpdate()
    {
        //string IDlist = Request.Form["chk"+Request.QueryString["companyid"]];
        //string GroupID = Request.QueryString["groupid"];
        //string CompanyID = Request.QueryString["companyid"];
        
        //MenuFrameEntity entity = new MenuFrameEntity();
        //entity.GroupID = GroupID;
        //entity.CompanyID = CompanyID;
        //entity.IDlist = IDlist;        
        //bool bFlag = this.FactoryFramework.IMenuFrame.GroupUserUpdate(entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /// <summary>
    /// 保存资料(main)
    /// </summary>
    private void UpdateMain()
    {
        //this.Entity.RootID = Request.Form["RootID"];
        //this.Entity.ParentID = Request.Form["ParentID"];
        //this.Entity.GroupID = Request.Form["GroupID"];
        //this.Entity.NameCHS = Request.Form["NameCHS"];
        //this.Entity.Remark = Request.Form["Remark"];
        //bool bFlag = this.FactoryFramework.IFwGroup.Addnew(this.Entity);
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
        //this.Entity.GroupID = Request.Form["GroupID1"];
        //this.Entity.NameCHS = Request.Form["NameCHS1"];
        //this.Entity.Remark = Request.Form["Remark1"];
        //bool bFlag = this.FactoryFramework.IFwGroup.Addnew(this.Entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }
    
    /// <summary>
    /// 删除资料
    /// </summary>
    private void Delete()
    {
        //this.Entity.IDlist = this.Entity.GroupID;
        //bool bFlag = this.FactoryFramework.IFwGroup.Delete(this.Entity);
        //if (bFlag) this.Message = "[{\"Option\":\"true\"}]"; else this.Message = "[{\"Option\":\"false\"}]";
        //Response.Write(this.Message);
    }
    
    /// <summary>
    /// 获取明细资料
    /// </summary>
    private void GetTreeDetail()
    {
        //this.Message = "{\"RootID\":\"{RootID}\",\"ParentID\":\"{ParentID}\",\"PNameCHS\":\"{PNameCHS}\",\"GroupID\":\"{GroupID}\",\"NameCHS\":\"{NameCHS}\",\"Remark\":\"{Remark}\"}";
        //DataTable dt = this.FactoryFramework.IFwGroup.TreeDetail(this.Entity.GroupID.ToString());
        //if (dt == null && dt.Rows.Count == 0)
        //{
        //    this.ReturnValue = this.Message.Replace("{RootID}", "")
        //        .Replace("{ParentID}", "")
        //        .Replace("{PNameCHS}", "")
        //        .Replace("{GroupID}", "")
        //        .Replace("{NameCHS}", "")
        //        .Replace("{Remark}", "");
        //}
        //else
        //{
        //    DataRow Row = dt.Rows[0];
        //    this.ReturnValue = this.Message.Replace("{RootID}", Row["RootID"].ToString())
        //        .Replace("{ParentID}", Row["ParentID"].ToString())
        //        .Replace("{PNameCHS}", Row["PNameCHS"].ToString())
        //        .Replace("{GroupID}", Row["GroupID"].ToString())
        //        .Replace("{NameCHS}", Row["NameCHS"].ToString())
        //        .Replace("{Remark}", Row["Remark"].ToString());
        //}
        //Response.Write("[" + this.ReturnValue + "]");
    }
    
    /// <summary>
    /// 获取列表
    /// </summary>
    private void GetTreeList()
    {
        //DataTable dt = this.FactoryFramework.IFwGroup.TreeList(this.Entity.GroupID.ToString());
        //Response.Write(TreeHelper.Display(dt));
    }
}
