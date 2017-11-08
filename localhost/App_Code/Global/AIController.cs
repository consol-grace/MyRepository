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
    ///AIController 的摘要说明
    /// </summary>
    public class AIController : ControllerBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            this.Option = Request.QueryString["Option"];
            this.Message = "[{\"Option\":\"{Option}\"}]";
            switch (this.Option)
            {
                case "list-Country": this.List(); break;
                case "update-Country": this.Update(); break;
            }
        }
        #region List()   Author: Hcy ( 2011-08-22 )
        /// <summary>
        /// 获取列表
        /// </summary>
        private void List()
        {
            DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Country_SP", new List<IFields>() { this.CreateIFields().Append("Option", "List")
        }).GetTable();

            this.ReturnValue = this.ToJSON(dt);
            Response.Write(this.ReturnValue);
        }
        #endregion


        #region Update()   Author: Hcy ( 2011-08-22 )
        /// <summary>
        /// 更新
        /// </summary>
        private void Update()
        {
            bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Country_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Add")
            
        }).Update();

            this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
            Response.Write(this.ReturnValue);
        }
        #endregion
    }
}
