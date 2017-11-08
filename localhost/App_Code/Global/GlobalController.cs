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
    #region DataController 类   作者: Richard ( 2011-08-02 )
    /// <summary>
    /// DataController 数据管控类
    /// </summary>
    public class DataController : ControllerBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            this.Option = Request.QueryString["Option"];
            if (this.Option == "user-logout") this.USER_LOGOUT();

            #region FW_USER
            
            if (this.Option == "fw_user_update") this.FW_USER_UPDATE();
            if (this.Option == "fw_user_search") this.FW_USER_SEARCH();
            if (this.Option == "fw_user_delete") this.FW_USER_DELETE();

            #endregion
        }

        #region USER_LOGOUT()   用户登出   作者: Richard ( 2011-08-04 )
        /// <summary>
        /// 用户登出
        /// </summary>
        private void USER_LOGOUT()
        {
            FSecurityHelper.SignOut();
        }
        #endregion

        #region FW_USER   系统管理   作者: Richard ( 2011-08-08 )

        #region FW_USER_UPDATE()   用户更新资料   作者: Richard ( 2011-08-08 )
        /// <summary>
        /// 用户更新资料
        /// </summary>
        private void FW_USER_UPDATE()
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
        #endregion

        #region FW_USER_SEARCH()   用户查询   作者: Richard ( 2011-08-08 )
        /// <summary>
        /// 用户查询
        /// </summary>
        private void FW_USER_SEARCH()
        {
            this.Message = "{"
                + "\"CompanyNameCHS\":\"{CompanyNameCHS}\",\"UserName\":\"{UserName}\",\"NameCHS\":\"{NameCHS}\""
                + ",\"NameENG\":\"{NameENG}\",\"Email\":\"{Email}\",\"Question\":\"{Question}\""
                + ",\"Answer\":\"{Answer}\",\"Activation\":\"{Activation}\""
                + "}";
            string UserName = Request.Form["UserName"];
            string NameCHS = Request.Form["NameCHS"];
            string Email = Request.Form["Email"];
            DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "list")
                .Append("UserName", UserName)
                .Append("NameCHS", NameCHS)
                .Append("Email", Email)
            }).GetTable();
            if (dt == null && dt.Rows.Count == 0)
            {
                this.ReturnValue = this.Message
                    .Replace("{CompanyNameCHS}", "").Replace("{UserName}", "").Replace("{NameCHS}", "")
                    .Replace("{NameENG}", "").Replace("{Email}", "").Replace("{Question}", "")
                    .Replace("{Answer}", "").Replace("{Activation}", "");
            }
            else
            {
                foreach (DataRow row in dt.Rows)
                {
                    this.ReturnValue += "," + this.Message
                        .Replace("{CompanyNameCHS}", row["CompanyNameCHS"].ToString()).Replace("{UserName}", row["UserName"].ToString()).Replace("{NameCHS}", row["NameCHS"].ToString())
                        .Replace("{NameENG}", row["NameENG"].ToString()).Replace("{Email}", row["Email"].ToString()).Replace("{Question}", row["Question"].ToString())
                        .Replace("{Answer}", row["Answer"].ToString()).Replace("{Activation}", row["Activation"].ToString());
                }
                this.ReturnValue = "[" + this.ReturnValue.Substring(1, this.ReturnValue.Length - 1) + "]";
            }
            Response.Write(this.ReturnValue);
        }
        #endregion

        #region FW_USER_DELETE()   用户删除   作者: Richard ( 2011-08-08 )
        /// <summary>
        /// 用户删除
        /// </summary>
        private void FW_USER_DELETE()
        {
            string chkItem = Request.Form["chkItem"];
            if (string.IsNullOrEmpty(chkItem))
                this.ReturnValue = "[{\"Option\":\"false\"}]";
            else
            {
                bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "delete")
                    .Append("IDlist", Request.Form["chkItem"])
                }).Update();
                this.ReturnValue = PageHelper.SplitToJSON(bFlag, Request.Form["chkItem"]);
            }
            Response.Write(this.ReturnValue);
        }
        #endregion

        #endregion
    }
    #endregion

}