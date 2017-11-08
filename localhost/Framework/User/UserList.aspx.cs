using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Text;

public partial class Framework_User_UserList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            DefaultData();
            DataBinding();
        }
    }

    DataFactory dal = new DataFactory();
    private void DefaultData()
    {
        DataSet dsStat = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetStat")
        }).GetList();
        StoreStat.DataSource = dsStat;
        StoreStat.DataBind();

        DataSet dsGrade = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetGrade")
        }).GetList();
        StoreGrade.DataSource = dsGrade;
        StoreGrade.DataBind();

        DataSet dsDept = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetDept")
        }).GetList();
        StoreDept.DataSource = dsDept;
        StoreDept.DataBind();

        DataSet dsGroup = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetGroup")
        }).GetList();
        StoreSys.DataSource = dsGroup;
        StoreSys.DataBind();

        cmbUserStat.SelectedItem.Value = "CON/HKG";
        cmbSys.SelectedItem.Value = "G09";
        cmbUserGrade.SelectedItem.Value = "User";
        cmbUserDept.SelectedItem.Value = "OP";
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        DataBinding();
    }

    private void DataBinding()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetUserList")
            .Append("UserName", txtUser.Text.Trim())
            .Append("STAT", cmbStat.SelectedItem.Value)
            .Append("UserGrade", cmbGrade.SelectedItem.Value)
            .Append("Dept", cmbDept.SelectedItem.Value)
            .Append("Active", chkActive.Checked?"Y":"N")
        }).GetList();
        storeList.DataSource = ds;
        storeList.DataBind();

        string dep = FSecurityHelper.CurrentUserDataGET()[28];
        if (!(dep.ToUpper() == "IT" || dep.ToUpper() == "ADMIN"))
        {
            btnAdd.Disabled = true;
            btnChangePass.Disabled = true;
            btnSave.Disabled = true;
            btnStatUpdate.Disabled = true;
            gridList.ColumnModel.SetRenderer(7, new Renderer() { Handler = "return '没有权限'" });
            gridList.ColumnModel.SetRenderer(8, new Renderer() { Handler = "return '没有权限'" });
            gridList.ColumnModel.SetRenderer(9, new Renderer() { Handler = "return '没有权限'" });
            gridList.ColumnModel.SetRenderer(10, new Renderer() { Handler = "return '没有权限'" });
        }
    }

    protected void btnFilter_Click(object sender, DirectEventArgs e)
    {
        DataBinding();
    }

    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        if (string.IsNullOrEmpty(txtUserName.Text.Trim()))
        {
            X.Msg.Show(new MessageBoxConfig { Title = "Warning", Message = "User Name can't be empty", Icon = MessageBox.Icon.WARNING, Buttons = MessageBox.Button.OK });
        }
        else if (hidID.Text == "" && string.IsNullOrEmpty(txtPwd.Text.Trim()))
        {
            X.Msg.Show(new MessageBoxConfig { Title = "Warning", Message = "Password can't be empty", Icon = MessageBox.Icon.WARNING, Buttons = MessageBox.Button.OK });
        }
        else if (string.IsNullOrEmpty(cmbUserStat.SelectedItem.Value))
        {
            X.Msg.Show(new MessageBoxConfig { Title = "Warning", Message = "Stat can't be empty", Icon = MessageBox.Icon.WARNING, Buttons = MessageBox.Button.OK });
        }
        else if (string.IsNullOrEmpty(cmbSys.SelectedItem.Value))
        {
            X.Msg.Show(new MessageBoxConfig { Title = "Warning", Message = "Group can't be empty", Icon = MessageBox.Icon.WARNING, Buttons = MessageBox.Button.OK });
        }
        else
        {
            string pass = "";
            if (hidID.Text == "")
            {
                pass = GetMD5(txtPwd.Text.Trim());

            }
            bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "UserUpdate")
            .Append("STAT",cmbUserStat.SelectedItem.Value.ToUpper())
            .Append("CompanyID", cmbUserStat.SelectedItem.Value.Substring(4).ToUpper())
            .Append("IsActivation", chkUserActive.Checked?"Y":"N")
            .Append("IsSales", chkSales.Checked?1:0)
            .Append("UserName", txtUserName.Text.Trim())
            .Append("UserPWD", pass)
            .Append("NameENG", txtNameEn.Text.Trim())
            .Append("NameCHS", txtNameLocal.Text.Trim())
            .Append("Tel", txtTel.Text.Trim())
            .Append("Fax", txtFax.Text.Trim())
            .Append("Email", txtEmail.Text.Trim())
            .Append("Remark", txtRemark.Text.Trim())
            .Append("SYS", cmbSys.SelectedItem.Value=="G07"?"AE":"OE")
            .Append("UserGrade", cmbUserGrade.SelectedItem.Value)
            .Append("Dept", cmbUserDept.SelectedItem.Value)
            .Append("Creator", FSecurityHelper.CurrentUserDataGET()[0])
            .Append("GroupID", cmbSys.SelectedItem.Value)
            .Append("RowID",hidID.Text)
            }).Update();
            if (!flag)
            {
                string message = hidID.Text != "" ? "Save failed" : "Add failed";
                X.Msg.Show(new MessageBoxConfig { Title = "Error", Message = message, Icon = MessageBox.Icon.ERROR, Buttons = MessageBox.Button.OK });
            }
            else
            {
                if (hidID.Text != "")
                {
                    winUserList.Hide();
                    DataBinding();
                }
                else
                {
                    hidID.Text = "";
                    winUserList.Title = "Add User";
                    winUserList.Icon = Icon.UserAdd;
                    ClearValue();
                }
            }
        }
    }

    protected void btnChangePass_Click(object sender, DirectEventArgs e)
    {
        if (string.IsNullOrEmpty(txtChangePass.Text.Trim()))
        {
            X.Msg.Show(new MessageBoxConfig { Title = "Warning", Message = "Password can't be empty", Icon = MessageBox.Icon.WARNING, Buttons = MessageBox.Button.OK });
        }
        else
        {
            bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "ChangePwd")
            .Append("UserPWD", GetMD5(txtChangePass.Text.Trim()))
            .Append("Modifier", FSecurityHelper.CurrentUserDataGET()[0])
            .Append("RowID",hidID.Text)
           }).Update();
            if (!flag)
            {
                X.Msg.Show(new MessageBoxConfig { Title = "Error", Message = "Change password failed", Icon = MessageBox.Icon.ERROR, Buttons = MessageBox.Button.OK });
            }
            else
            {
                txtChangePass.Clear();
                txtChangePassAgain.Clear();
                winPassChange.Hide();
            }
        }
    }

    protected void btnStatUpdate_Click(object sender, DirectEventArgs e)
    {
        bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "UpdateUserStat")
            .Append("UserName", hidName.Text)
            .Append("Modifier", FSecurityHelper.CurrentUserDataGET()[0])
            .Append("IDlist",hidList.Text)
           }).Update();
        if (!flag)
        {
            X.Msg.Show(new MessageBoxConfig { Title = "Error", Message = "Update stat failed", Icon = MessageBox.Icon.ERROR, Buttons = MessageBox.Button.OK });
        }
        else
        {
            winUserStat.Hide();
        }
    }

    protected void ClearValue()
    {
        txtUserName.Clear();
        cmbUserStat.SelectedItem.Value = "CON/HKG";
        cmbSys.SelectedItem.Value = "G09";
        cmbUserGrade.SelectedItem.Value = "User";
        cmbUserDept.SelectedItem.Value = "OP";
        txtPwd.Clear();
        txtPwdAgain.Clear();
        txtTel.Clear();
        txtFax.Clear();
        txtNameEn.Clear();
        txtNameLocal.Clear();
        txtEmail.Clear();
        txtRemark.Clear();
    }
    private string GetMD5(string encrypt)
    {
        encrypt = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(encrypt, "sha1");
        encrypt = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(encrypt, "md5");
        return encrypt;
    }
    [DirectMethod]
    public void ShowData(int type)
    {
        if (type == 0)
        {
            hidID.Text = "";
            winUserList.Title = "Add User";
            winUserList.Icon = Icon.UserAdd;
            btnSave.Text = "Add";
            ClearValue();
            txtUserName.Disabled = false;
            labPass.Hidden = false;
            labRed.Hidden = false;
            txtPwd.Hidden = false;
            txtPwdAgain.Hidden = false;
            cmbUserStat.Disabled = false;
            winUserList.Show();
            txtUserName.Focus(true);
        }
        else
        {
            winUserList.Title = "Edit User";
            winUserList.Icon = Icon.UserEdit;
            btnSave.Text = "Save";
            txtUserName.Disabled = true;
            labPass.Hidden = true;
            labRed.Hidden = true;
            txtPwd.Hidden = true;
            txtPwdAgain.Hidden = true;
            if (FSecurityHelper.CurrentUserDataGET()[12].ToUpper() == "CON/HKG")
                cmbUserStat.Disabled = false;
            else
                cmbUserStat.Disabled = true;
            
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "UserSingle")
            .Append("RowID", hidID.Text)
            }).GetList();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtUserName.Text = ds.Tables[0].Rows[0]["UserName"].ToString();
                cmbUserStat.SelectedItem.Value = ds.Tables[0].Rows[0]["STAT"].ToString();
                cmbSys.SelectedItem.Value = ds.Tables[0].Rows[0]["UserSys"].ToString();
                chkUserActive.Checked = ds.Tables[0].Rows[0]["IsActivation"].ToString() == "Y" ? true : false;
                chkSales.Checked = ds.Tables[0].Rows[0]["IsSales"].ToString() == "True" ? true : false;
                txtTel.Text = ds.Tables[0].Rows[0]["Tel"].ToString();
                txtFax.Text = ds.Tables[0].Rows[0]["Fax"].ToString();
                txtNameEn.Text = ds.Tables[0].Rows[0]["NameENG"].ToString();
                txtNameLocal.Text = ds.Tables[0].Rows[0]["NameCHS"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();
                cmbUserGrade.SelectedItem.Value = ds.Tables[0].Rows[0]["UserGrade"].ToString();
                cmbUserDept.SelectedItem.Value = ds.Tables[0].Rows[0]["Dept"].ToString();
            }
            winUserList.Show();
            txtNameEn.Focus(true);
        }
    }

    [DirectMethod]
    public void UserActive(string id, string type)
    {
        string message = (type == "Y" ? "Void failed" : "Active failed");
        bool flag = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "Active")
            .Append("RowID",id)
        }).Update();
        if (!flag)
        {
            X.Msg.Show(new MessageBoxConfig { Title = "Error", Message = message, Icon = MessageBox.Icon.ERROR, Buttons = MessageBox.Button.OK });
        }
        else
        {
            DataBinding();
        }
    }

    [DirectMethod]
    public void UserStat(string username, string companyid)
    {
        hidName.Text = username;
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_USER_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "UserStat")
            .Append("UserName", username)
            .Append("CompanyID",companyid)
            .Append("Creator", FSecurityHelper.CurrentUserDataGET()[0])
            }).GetList();
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            Ext.Net.CheckboxGroup chkGroup = new CheckboxGroup();
            chkGroup.ID = "chkGroup";
            chkGroup.ColumnsNumber = 3;
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                Ext.Net.Checkbox chk = new Checkbox();
                chk.ID = "chkGroup" + i.ToString();
                chk.BoxLabel = ds.Tables[0].Rows[i]["Stat"].ToString();
                chk.Name = ds.Tables[0].Rows[i]["STATION"].ToString();
                chk.Checked = ds.Tables[0].Rows[i]["IsActive"].ToString() == "N" ? false : true;
                if (ds.Tables[0].Rows[i]["STATION"].ToString() == companyid)
                {
                    chk.Disabled = true;
                }
                chkGroup.Items.Add(chk);
            }
            chkGroup.AddTo(panChk);
        }
        winUserStat.Show();
    }
    protected void btnPrinter_Click(object sender, DirectEventArgs e)
    {
        X.AddScript("window.open('UserPrinter.aspx');");
    }
}
