using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.BASECLASS;

public partial class Framework_Group_GMlist : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack) InitData();
    }

    #region InitData()   初始化资料   作者: Richard ( 2011-04-06 )
    /// <summary>
    /// 
    /// </summary>
    private void InitData()
    {
        this.Message = "<input type=\"checkbox\" {id} name='{name}' value=\"{value}\" onclick='FwGroupMenu.Upade({form:this})' />　{text}";
    }
    #endregion


    #region Menu   作者: Richard ( 2011-04-06 )
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    protected DataTable MenuRoot
    {
        get
        {
            return new DataTable();
            //return this.FactoryFramework.IMenuFrame.GroupMenuRoot();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="MenuID"></param>
    protected void MenuParent(string MenuID)
    {
        //MenuFrameEntity entity = new MenuFrameEntity();
        //entity.MenuID = MenuID;
        //DataTable dt = this.FactoryFramework.IMenuFrame.GroupMenuList(entity);
        //if (dt.Rows.Count > 0)
        //{
        //    foreach (DataRow row in dt.Rows)
        //    {
        //        if (row["ParentID"].ToString().Trim() == MenuID)
        //        {
        //            this.ReturnValue = this.Message
        //                .Replace("{id}", "id='chk" + row["MenuID"].ToString() + "All'")
        //                .Replace("{name}", "chk" + row["MenuID"].ToString()+"All")
        //                .Replace("{value}", row["MenuID"].ToString())
        //                .Replace("{nameAll}", "chk" + row["MenuID"].ToString() + "All")
        //                .Replace("{text}", row["NameCHS"].ToString());
        //            Response.Write(this.ReturnValue + "<br />");
        //            this.MenuChild(dt, row["MenuID"].ToString(), 1);
        //            Response.Write("<br />");
        //        }
        //    }
        //}
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dt"></param>
    /// <param name="MenuID"></param>
    /// <param name="length"></param>
    private void MenuChild(DataTable dt, string MenuID, Int32 length)
    {
        //DataRow[] rows = dt.Select("ParentID='" + MenuID + "'");
        //for (int i = 0; i < rows.Length; i++)
        //{
        //    if (rows[i]["Hyperlink"].ToString() != "#1")
        //    {
        //        this.ReturnValue = this.Message
        //            .Replace("{id}", "")
        //            .Replace("{name}", "chk" + MenuID)
        //            .Replace("{value}", rows[i]["MenuID"].ToString())
        //            .Replace("{nameAll}", "chk" + MenuID + "All")
        //            .Replace("{text}", rows[i]["NameCHS"].ToString());
        //        Response.Write(MenuChild_SpaceLength(length) + this.ReturnValue + "<br />");                
        //    }
        //    this.MenuChild(dt, rows[i]["MenuID"].ToString(), length + 1);
        //}        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="i"></param>
    /// <returns></returns>
    private string MenuChild_SpaceLength(int i)
    {
        string space = "";
        for (int j = 0; j < i; j++) space += "　　";
        return space;
    }
    #endregion
}
