using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class BasicData_Currency_list : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		sys = Request["sys"];
		if (sys == "D" || sys == "B" || sys == "T")
		{
			sys = "O";
		}
		if (!X.IsAjaxRequest)
		{
			ControlBinder.CmbBinder(cmbCountry, "CountryList", sys);
			this.BindData();
		}

		InitControls();
		div_bottom.Html = "<p class=\"\">Status : New currency record. </p>";
		Code.Focus();
	}


	string sys = string.Empty;
	private void BindData()
	{

		Code.Focus(true);
		var store = this.GridPanel1.GetStore();

		DataFactory dal = new DataFactory();
		DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Currency_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
        .Append("SYS", sys)  //O or A  Request.QueryString["SYS"]
        .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
        .Append("dept",dept)
        }).GetTable();
		if (dt != null && dt.Rows.Count > 0)
		{
			store.DataSource = dt;
			store.DataBind();
		}
	}


	private void CheckGroupClear()
	{
		for (int ii = 0; ii < ChkGrpStat.Items.Count(); ++ii)
			ChkGrpStat.Items[ii].Checked = false;
	}


	#region//Created 2014-09-12  Michael
	/// <summary>
	/// 获取当前用户所属部门
	/// </summary>
	public string dept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
	public string currStation = FSecurityHelper.CurrentUserDataGET()[29].ToUpper(); // Y  总站，N 分站（dept为管理员只有是总站的时候才能新增，分站同OP）
	public string isserver = FSecurityHelper.CurrentUserDataGET()[30].ToUpper();    // Y  当前分公司已经分开系统 fco_isserver=1 ，N 没有分开
	/// <summary>
	/// 根据所属部门初始化控件
	/// </summary>
	private void InitControls()
	{

		if ((dept == "ADMIN" || dept == "IT") && currStation == "Y" )
		{
            if (hidRowID.Value != "0")
            {
                txtBuy.Disabled = true;
                txtSell.Disabled = true;
                txtRate.Disabled = true;
            }
		}
		else
		{
						
				Code.Disabled = true;
				countryControl.Disabled = true;
				Description.Disabled = true;
				txtBuy.Disabled = true;
				txtSell.Disabled = true;
				txtRate.Disabled = true;
				Country.Disabled = true;
				chkActive.Disabled = true;
				chkLocal.Disabled = true;
				ChkGrpStat.Enabled = false;
				Checkforeign.Disabled = true;
				Save.Disabled = true;
				Next.Disabled = true;
				Cancel.Disabled = true;
				ChkGrpStat.Hide();
				if (dept == "ACCOUNT")
				{
					countryControl.Disabled = false;
					txtBuy.Disabled = false;
					txtSell.Disabled = false;
					txtRate.Disabled = false;
					Save.Disabled = false;
				}
			
		}

		ControlBinder.ChkGroupBind(ChkGrpStat);

	}
	#endregion

	DataFactory dal = new DataFactory();

	protected void btnSave_Click(object sender, DirectEventArgs e)
	{
		string strStat = "";

		for (int i = 0; i < ChkGrpStat.Items.Count(); ++i)
		{
			if (!ChkGrpStat.Items[i].Checked)
				strStat += ChkGrpStat.Items[i].Tag.Trim() + ",";
		}
		strStat = strStat.Length > 0 ? strStat.Substring(0, strStat.Length - 1) : strStat;

		if (string.IsNullOrEmpty(Code.Text))
		{
			this.Code.Text = "";
			this.Code.Focus();
			div_bottom.Html = "<p class=\"error\">Status : Error message, The code can't for empty . </p>";
			//X.Msg.Alert("Status", "Code can't be null", "Code.focus();").Show();
			return;
		}

		if (BaseCheckCode.Check("currency", Code.Text.Trim(), sys, hidRowID.Text) == "N" && hidRowID.Text == "0")
		{
			div_bottom.Html = "<p class=\"error\">Status : Error message, The code already exists. </p>";
			return;
		}

		int f = 0, l = 0, b = 0;
		if (Checkforeign.Checked)
		{
			f = 1;
			b = 1;
		}
		if (chkLocal.Checked)
		{
			l = 1;
			b = 1;
		}

		DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Currency_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("dept",dept)
                .Append("SYS",sys)
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                //.Append("statstr",string.IsNullOrEmpty(strStat)?FSecurityHelper.CurrentUserDataGET()[12]:strStat)
				.Append("statstr",strStat)
                .Append("Code",Code.Text.ToUpper())
                .Append("Description",Description.Text.ToUpper())
                .Append("Country",Country.Text)
                .Append("Rate",string.IsNullOrEmpty(txtRate.Text.Trim()) ? DBNull.Value : (object)txtRate.Text.Trim())
                .Append("Sell",string.IsNullOrEmpty(txtSell.Text.Trim()) ? DBNull.Value : (object)txtSell.Text.Trim())
                .Append("Buy",string.IsNullOrEmpty(txtBuy.Text.Trim()) ? DBNull.Value : (object)txtBuy.Text.Trim())
                .Append("Active",chkActive.Checked?"1":"0")
                .Append("ROWID",hidRowID.Text)
                .Append("cur_BuildIn",b)
                .Append("cur_isForeign",f)
                .Append("cur_isLocal",l)
        }).GetList();
		if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
		{
			hidRowID.Text = ds.Tables[0].Rows[0][0].ToString();
			Code.Disabled = true;
            if (dept != "ACCOUNT")
            {
                txtBuy.Disabled = true;
                txtSell.Disabled = true;
                txtRate.Disabled = true;
            }
			if (!string.IsNullOrEmpty(Request["control"]))
			{
				X.AddScript("window.parent.ChildCallBack(Request(\"control\"), $(\"#Code\").val());");
				return;
			}
			if (i == 1)
			{
				Code.Text = "";
				Description.Text = "";
				Country.Text = "";
				txtRate.Clear();
				txtSell.Clear();
				txtBuy.Clear();
				chkLocal.Checked = false;
				Checkforeign.Checked = true;
				hidRowID.Text = "0";
				chkActive.Checked = true;
				Code.Disabled = false;
				CheckGroupClear();
                txtBuy.Disabled = false;
                txtSell.Disabled = false;
                txtRate.Disabled = false;  
			}
			div_bottom.Html = "<p class=\"success\">Status : saved successful. </p>";

		}
		else
			div_bottom.Html = "<p class=\"error\">Status : Error message, saved failed. </p>";

		this.BindData();
	}

	protected void btnCancel_Click(object sender, DirectEventArgs e)
	{
		Row_Select(sender, e);
	}

	int i = 0;
	protected void btnNext_Click(object sender, DirectEventArgs e)
	{
		i = 1;
		btnSave_Click(sender, e);
	}

	protected void Row_Select(object sender, DirectEventArgs e)
	{
		var list = JSON.Deserialize<CurrencyList>(e.ExtraParams["rowdata"]);
		Code.Disabled = true;
        if (dept != "ACCOUNT")
        {            
            txtBuy.Disabled = true;
            txtSell.Disabled = true;
            txtRate.Disabled = true;           
        }
		Code.Text = list.Code;
		Description.Text = list.Description;
		Country.Text = list.Country;
		if (string.IsNullOrEmpty(list.Rate))
			txtRate.Clear();
		else
			txtRate.Text = list.Rate;
		if (string.IsNullOrEmpty(list.Sell))
			txtSell.Clear();
		else
			txtSell.Text = list.Sell;
		if (string.IsNullOrEmpty(list.Buy))
			txtBuy.Clear();
		else
			txtBuy.Text = list.Buy;
		chkLocal.Checked = list.l == "1" ? true : false;
		Checkforeign.Checked = list.f == "1" ? true : false;
		hidRowID.Text = list.RowID;
		chkActive.Checked = list.Active == "1" ? true : false;
		string[] statlist = string.IsNullOrEmpty(list.StatList) ? new string[] { } : list.StatList.Split(',');
		CheckGroupClear();

		foreach (string str in statlist)
		{
			for (int i = 0; i < ChkGrpStat.Items.Count(); ++i)
			{
				if (ChkGrpStat.Items[i].Tag.ToString().Trim().ToUpper() == str.Trim().ToUpper())
				{
					ChkGrpStat.Items[i].Checked = true;
					break;
				}
			}
		}
		Code.Focus();

		div_bottom.Html = "<p class=\"\">Status : Edit the record of <span>" + Code.Text + "</span>. </p>";
	}

}

public class CurrencyList
{
	public string RowID
	{ get; set; }
	public string Code
	{ get; set; }
	public string Description
	{ get; set; }
	public string Country
	{ get; set; }
	public string Rate
	{ get; set; }
	public string Sell
	{ get; set; }
	public string Buy
	{ get; set; }
	public string l
	{ get; set; }
	public string f
	{ get; set; }
	public string Active
	{ get; set; }
	public string StatList
	{ get; set; }
}
