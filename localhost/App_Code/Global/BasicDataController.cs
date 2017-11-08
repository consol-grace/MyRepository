using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

namespace USGROUP.OPERATION.CONTROLLER
{
    /// <summary>
    ///BasicDataController 的摘要说明
    /// </summary>
    public class BasicDataController : ControllerBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            this.Option = Request.QueryString["Option"];
            this.Message = "[{\"Option\":\"{Option}\"}]"; 
            switch (this.Option)
            {
                case "list-Country": this.list_Country(); break;
                case "update-Country": this.update_Country(); break;
            }
        }
        #region list_Country()   Author: Hcy ( 2011-08-22 )
        /// <summary>
        /// 获取列表
        /// </summary>
        private void list_Country()
        {
            DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Country_SP", new List<IFields>() { this.CreateIFields().Append("Option", "List")

        }).GetTable();

            this.ReturnValue = this.ToJSON(dt);
            Response.Write(this.ReturnValue);
        }
        #endregion


        #region update_Country()   Author: Hcy ( 2011-08-22 )
        /// <summary>
        /// 更新
        /// </summary>
        private void update_Country()
        {
            bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Country_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS",FSecurityHelper.CurrentUserDataGET()[11].Substring(0,1))
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("Code",Request.Form["Code"].Trim())
                .Append("Name",Request.Form["Name"].Trim())
                .Append("Active",Request.QueryString["chkActive"])
                .Append("ROWID",Request.Form["hidRowID"].Trim())
            
        }).Update();

            this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
            Response.Write(this.ReturnValue);
        }
        #endregion

       
    }
}
