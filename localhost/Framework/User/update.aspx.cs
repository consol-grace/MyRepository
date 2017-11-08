using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.DBLL;

public partial class Framework_User_update : PageBase
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            PageHelper.Builder.FW_COMPANY(this.CompanyID);

            this.Option = Request.QueryString["Option"];
            if (this.Option == "modify" || this.Option == "view")
            {
                this.InitData();
            }
        }
    }

    #region InitData()   初始化资料   作者: Richard ( 2011-03-30 )
    /// <summary>
    /// 初始化资料
    /// </summary>
    protected void InitData()
    {
        string UserName = Request.QueryString["username"];
        DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { this.CreateIFields().Append("Option", "list") 
            .Append("UserName", UserName)
        }).GetTable();

        if (dt != null && dt.Rows.Count > 0)
        {
            this.UserName.Value = dt.Rows[0]["UserName"].ToString();
            this.IsActivation.SelectedValue = dt.Rows[0]["IsActivation"].ToString();
            this.Email.Value = dt.Rows[0]["Email"].ToString();

            this.CompanyID.SelectedValue = dt.Rows[0]["CompanyID"].ToString();
            this.NameCHS.Value = dt.Rows[0]["NameCHS"].ToString();
            this.NameENG.Value = dt.Rows[0]["NameENG"].ToString();
            this.Question.Value = dt.Rows[0]["Question"].ToString();
            this.Answer.Value = dt.Rows[0]["Answer"].ToString();
            this.Remark.Value = dt.Rows[0]["Remark"].ToString();

            if (this.Option == "view")
            {
                this.UserName.Attributes.Add("readonly", "readonly");
                this.UserName.Attributes.Add("style", "background-color:#efefef");

                this.IsActivation.Attributes.Add("readonly", "readonly");
                this.IsActivation.Attributes.Add("style", "background-color:#efefef");

                this.Email.Attributes.Add("readonly", "readonly");
                this.Email.Attributes.Add("style", "background-color:#efefef");

                this.CompanyID.Attributes.Add("readonly", "readonly");
                this.CompanyID.Attributes.Add("style", "background-color:#efefef");

                this.NameCHS.Attributes.Add("readonly", "readonly");
                this.NameCHS.Attributes.Add("style", "background-color:#efefef");

                this.NameENG.Attributes.Add("readonly", "readonly");
                this.NameENG.Attributes.Add("style", "background-color:#efefef");

                this.Question.Attributes.Add("readonly", "readonly");
                this.Question.Attributes.Add("style", "background-color:#efefef");

                this.Answer.Attributes.Add("readonly", "readonly");
                this.Answer.Attributes.Add("style", "background-color:#efefef");

                this.Remark.Attributes.Add("readonly", "readonly");
                this.Remark.Attributes.Add("style", "background-color:#efefef");
            }
        }
    }
    #endregion
}
