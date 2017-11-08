using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using System.Collections;
using System.Data.SqlClient;


public partial class BasicData_Country_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        sys = Request["sys"];
        if (sys == "D" || sys == "B" || sys == "T")
        {
            sys = "O";
        }
        //if (!X.IsAjaxRequest)
        //{
        //        //ControlsInitial();
        //        //userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
        //        //stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
        //        //isServer = FSecurityHelper.CurrentUserDataGET()[30].ToUpper();

        //        //if ((userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N") && isServer == "Y")
        //        //{
        //        //    DisabledControl();
        //        //}
        //        //else
        //        //{
        //        //    UseControl();
        //        //}

        //        //ControlBinding();
        //        ////DataBinder();
        //        //div_bottom.Html = "<p>Status: New Item record .</p>";
            
        //}
           ControlBinder.ChkGroupBind(this.tblChkGroup); //绑定CheckBoxGroup ( 2014-10-12 )
        
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {

                ControlsInitial();
                userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
                stationSys = FSecurityHelper.CurrentUserDataGET()[29].ToUpper();
                isServer = FSecurityHelper.CurrentUserDataGET()[30].ToUpper();

                if ((userDept == "OP" || userDept == "ACCOUNT" || stationSys == "N") && isServer == "Y")
                {
                    DisabledControl();
                }
                else
                {
                    UseControl();
                }              

                ControlBinding();
                DataBinder();
                div_bottom.Html = "<p>Status: New Item record .</p>";
            }
        }
    }

    DataFactory dal = new DataFactory();
    string sys = string.Empty;
    public string userDept; //当前用户所在部门
    public string stationSys; //当前用户所在系统（总站系统为Y或者分站系统为N）
    public string isServer;// 当前站已经独立了,那么 isserver 就等于Y ，如果不是就等于N 
    /// <summary>
    /// 控件初始化 
    /// </summary>
    #region   ControlsInitial()   Author：Micro  （2011-08-29）
    void ControlsInitial()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Item_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "currency")
        .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
        .Append("SYS",sys[0].ToString())//FSecurityHelper.CurrentUserDataGET()[11].Substring(0,1))
        }).GetList();

        txtCode.Text = "";
        txtShort.Text = "";
        txtDes.Text = "";
        txtDesCN.Text = "";
        cmbFCurrency.Text = ds.Tables[0].Rows[0]["f"].ToString();
        cmbFby.Text = "OTHER";
        cmbFUnit.Text = "";
        //txtFMain.Clear();
        //txtFRate.Clear();
        //txtFAmount.Clear();
        txtFRound.Text = "2";
        chbFUp.Checked = false;
        chbFDown.Checked = false;
        //labCurrency.Text = "";
        cmbLby.Text = "OTHER";
        cmbLUnit.Text = "";
        //txtLMin.Clear();
        //txtLRate.Clear();
        //txtLAmount.Clear();
        txtLRound.Text = "2";
        chbLUp.Checked = false;
        chbLDown.Checked = false;
        chbActive.Checked = true;
        labFvalues.Text = "";
        labFRound.Text = "";
        labLValues.Text = "";
        labLRound.Text = "";
        labCurrency.Text = ds.Tables[0].Rows[0]["l"].ToString();
        txtCode.Focus(true, 5);
    }
    #endregion

    /// <summary>
    /// 禁用控件
    /// </summary>
    void DisabledControl()
    {
        txtCode.Disabled = true;
        txtShort.Disabled = true;
        txtDes.Disabled = true;
        txtDesCN.Disabled = true;
        btnNext.Disabled = true;
        btnCancel.Disabled = true;
        chbActive.Disabled = true;
        cmbFCurrency.Disabled = true;
        cmbFUnit.Disabled = true;
        cmbFby.Disabled = true;
        labCurrency.Disabled = true;
        cmbLUnit.Disabled = true;
        cmbLby.Disabled = true;
    }

    /// <summary>
    /// 启用控件
    /// </summary>
    void UseControl()
    {
        txtCode.Disabled = false;
        txtShort.Disabled = false;
        txtDes.Disabled = false;
        txtDesCN.Disabled = false;
        btnNext.Disabled = false;
        btnCancel.Disabled = false;
        chbActive.Disabled = false;
        cmbFCurrency.Disabled = false;
        cmbFUnit.Disabled = false;
        cmbFby.Disabled = false;
        labCurrency.Disabled = false;
        cmbLUnit.Disabled = false;
        cmbLby.Disabled = false;



        //txtFMain.Disabled = true;
        //txtFRate.Disabled = true;
        //txtFAmount.Disabled = true;
        //txtFRound.Disabled = true;
        //chbFUp.Disabled = true;
        //chbFDown.Disabled = true;

        //txtLMin.Disabled = true;
        //txtLRate.Disabled = true;
        //txtLAmount.Disabled = true;
        //txtLRound.Disabled = true;
        //chbLUp.Disabled = true;
        //chbLDown.Disabled = true;
    }

    /// <summary>
    /// 清空Checkbox
    /// </summary>
    private void CheckGroupClear()
    {
        for (int ii = 0; ii < tblChkGroup.Items.Count(); ++ii)
            tblChkGroup.Items[ii].Checked = false;
    }

    /// <summary>
    /// Checkbox全选
    /// </summary>
    private void CheckGroupChecked()
    {
        for (int ii = 0; ii < tblChkGroup.Items.Count(); ++ii)
            tblChkGroup.Items[ii].Checked = true;
    }
    /// <summary>
    /// Grid 数据绑定   
    /// </summary>
    #region   DataBinder()   Author: Micro ( 2011-08-27 )  修改时间2014-09-20 Grace
    void DataBinder()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Item_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List").Append("itm_ROWID",txtRowID.Text) 
        .Append("itm_STAT",FSecurityHelper.CurrentUserDataGET()[12])
        .Append("itm_code",Request["code"])    
        .Append("itm_SYS",sys)//FSecurityHelper.CurrentUserDataGET()[11].Substring(0,1))
        .Append("dept", userDept)
        }).GetList();
        
        if (ds != null && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
            {
                txtRowID.Text = ds.Tables[1].Rows[0]["itm_RowID"].ToString();
                txtCode.Text = ds.Tables[1].Rows[0]["itm_Code"].ToString();
                txtShort.Text = ds.Tables[1].Rows[0]["itm_Short"].ToString();
                txtDes.Text = ds.Tables[1].Rows[0]["itm_Description"].ToString();
                txtDesCN.Text = ds.Tables[1].Rows[0]["itm_Description_CN"].ToString();
                cmbFCurrency.Text = ds.Tables[1].Rows[0]["itm_FCurrency"].ToString();
                cmbFby.Text = ds.Tables[1].Rows[0]["itm_FCalcQty"].ToString();
                cmbFUnit.Text = ds.Tables[1].Rows[0]["itm_FUnit"].ToString();
                if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_FMin"].ToString()))
                    txtFMain.Clear();
                else
                    txtFMain.Text = ds.Tables[1].Rows[0]["itm_FMin"].ToString();

                if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_FRate"].ToString()))
                    txtFRate.Clear();
                else
                    txtFRate.Text = ds.Tables[1].Rows[0]["itm_FRate"].ToString();

                if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_FAmount"].ToString()))
                    txtFAmount.Clear();
                else
                    txtFAmount.Text = ds.Tables[1].Rows[0]["itm_FAmount"].ToString();

                if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_FRound"].ToString()))
                    txtFRound.Clear();
                else
                    txtFRound.Text = ds.Tables[1].Rows[0]["itm_FRound"].ToString();

                chbFUp.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_FMarkUp"]);
                chbFDown.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_FMarkDown"]);
                labCurrency.Text = ds.Tables[1].Rows[0]["itm_LCurrency"].ToString(); //保存获取不到Text值
                txtlab.Text = ds.Tables[1].Rows[0]["itm_LCurrency"].ToString();
                cmbLby.Text = ds.Tables[1].Rows[0]["itm_LCalcQty"].ToString();
                cmbLUnit.Text = ds.Tables[1].Rows[0]["itm_LUnit"].ToString();
                if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_LMin"].ToString()))
                    txtLMin.Clear();
                else
                    txtLMin.Text = ds.Tables[1].Rows[0]["itm_LMin"].ToString();

                if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_LRate"].ToString()))
                    txtLRate.Clear();
                else
                    txtLRate.Text = ds.Tables[1].Rows[0]["itm_LRate"].ToString();

                if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_LAmount"].ToString()))
                    txtLAmount.Clear();
                else
                    txtLAmount.Text = ds.Tables[1].Rows[0]["itm_LAmount"].ToString();

                if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_LRound"].ToString()))
                    txtLRound.Clear();
                else
                    txtLRound.Text = ds.Tables[1].Rows[0]["itm_LRound"].ToString();

                chbLUp.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_LMarkUp"]);
                chbLDown.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_LMarkDown"]);
                chbActive.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_Active"]);
                labFvalues.Text = ds.Tables[1].Rows[0]["Fvalues"].ToString();
                labFRound.Text = ds.Tables[1].Rows[0]["FRound"].ToString();
                labLValues.Text = ds.Tables[1].Rows[0]["Lvalues"].ToString();
                labLRound.Text = ds.Tables[1].Rows[0]["LRound"].ToString();

                string[] statlist = string.IsNullOrEmpty(ds.Tables[1].Rows[0]["StatList"].ToString()) ? new string[] { } : ds.Tables[1].Rows[0]["StatList"].ToString().Split(',');
                CheckGroupClear();

                foreach (string str in statlist)
                {
                    for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
                    {
                        if (tblChkGroup.Items[i].Tag.ToString().Trim().ToUpper() == str.Trim().ToUpper())
                        {
                            tblChkGroup.Items[i].Checked = true;
                            break;
                        }
                    }
                }

            }
                //txtCode.Focus(true);
            if (txtCode.Text != "")
            {
                div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + txtCode.Text + "</span>.</p>";
                txtCode.Disabled = true;
            }
            StoreDomestic.DataSource = ds.Tables[0];
            StoreDomestic.DataBind();
        }
        else
        {
            div_bottom.Html = "<p class=''>Status: New Item record.</p>";
        }
    }
    #endregion


    /// <summary>
    /// 控件 数据绑定   
    /// </summary>
    #region   ControlBinding()   Author: Hcy ( 2011-09-08 )
    void ControlBinding()
    {

        ControlBinder.CmbBinder(StoreUnit, "UnitBinding", sys);

        ControlBinder.CmbBinder(StoreForeign, "CurrencysListF", sys);
        ControlBinder.CmbBinder(StoreLocal, "CurrencysListL", sys);

        ControlBinder.CmbBinder(storeCaclby, "QtyKindBinding", sys);

        cmbFUnit.Template.Html = template.Html;
        cmbLUnit.Template.Html = template.Html;

  
    }
    #endregion

    /// <summary>
    /// Grid 行点击事件数据处理   
    /// </summary>
    #region   Row_Click(object,DirectEventArgs)   Author: Micro ( 2011-08-27 )
    protected void Row_Click(object sender, DirectEventArgs e)
    {
        txtRowID.Text = e.ExtraParams["itm_ROWID"];
        BinderData(txtRowID.Text);
    }
    #endregion

    void BinderData(string rowID)
    {
        X.AddScript("removeLine('txtCode');removeLine('txtDes');");
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Item_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List").Append("itm_ROWID", rowID).Append("itm_SYS", sys) }).GetList();
        if (ds != null && ds.Tables[1].Rows.Count > 0)
        {
            txtCode.Text = ds.Tables[1].Rows[0]["itm_Code"].ToString();
            txtShort.Text = ds.Tables[1].Rows[0]["itm_Short"].ToString();
            txtDes.Text = ds.Tables[1].Rows[0]["itm_Description"].ToString();
            txtDesCN.Text = ds.Tables[1].Rows[0]["itm_Description_CN"].ToString();
            cmbFCurrency.Text = ds.Tables[1].Rows[0]["itm_FCurrency"].ToString();
            cmbFby.Text = ds.Tables[1].Rows[0]["itm_FCalcQty"].ToString();
            cmbFUnit.Text = ds.Tables[1].Rows[0]["itm_FUnit"].ToString();
            if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_FMin"].ToString()))
                txtFMain.Clear();
            else
                txtFMain.Text = ds.Tables[1].Rows[0]["itm_FMin"].ToString();

            if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_FRate"].ToString()))
                txtFRate.Clear();
            else
                txtFRate.Text = ds.Tables[1].Rows[0]["itm_FRate"].ToString();

            if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_FAmount"].ToString()))
                txtFAmount.Clear();
            else
                txtFAmount.Text = ds.Tables[1].Rows[0]["itm_FAmount"].ToString();

            if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_FRound"].ToString()))
                txtFRound.Clear();
            else
                txtFRound.Text = ds.Tables[1].Rows[0]["itm_FRound"].ToString();

            chbFUp.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_FMarkUp"]);
            chbFDown.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_FMarkDown"]);
            labCurrency.Text = ds.Tables[1].Rows[0]["itm_LCurrency"].ToString(); //保存获取不到Text值
            txtlab.Text = ds.Tables[1].Rows[0]["itm_LCurrency"].ToString();
            cmbLby.Text = ds.Tables[1].Rows[0]["itm_LCalcQty"].ToString();
            cmbLUnit.Text = ds.Tables[1].Rows[0]["itm_LUnit"].ToString();
            if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_LMin"].ToString()))
                txtLMin.Clear();
            else
                txtLMin.Text = ds.Tables[1].Rows[0]["itm_LMin"].ToString();
            if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_LRate"].ToString()))
                txtLRate.Clear();
            else
                txtLRate.Text = ds.Tables[1].Rows[0]["itm_LRate"].ToString();

            if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_LAmount"].ToString()))
                txtLAmount.Clear();
            else
                txtLAmount.Text = ds.Tables[1].Rows[0]["itm_LAmount"].ToString();

            if (string.IsNullOrEmpty(ds.Tables[1].Rows[0]["itm_LRound"].ToString()))
                txtLRound.Clear();
            else
                txtLRound.Text = ds.Tables[1].Rows[0]["itm_LRound"].ToString();

 
            chbLUp.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_LMarkUp"]);
            chbLDown.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_LMarkDown"]);
            chbActive.Checked = Convert.ToBoolean(ds.Tables[1].Rows[0]["itm_Active"]);
            labFvalues.Text = ds.Tables[1].Rows[0]["Fvalues"].ToString();
            labFRound.Text = ds.Tables[1].Rows[0]["FRound"].ToString();
            labLValues.Text = ds.Tables[1].Rows[0]["Lvalues"].ToString();
            labLRound.Text = ds.Tables[1].Rows[0]["LRound"].ToString();
            //txtCode.Focus(true);
            string[] statlist = string.IsNullOrEmpty(ds.Tables[1].Rows[0]["StatList"].ToString()) ? new string[] { } : ds.Tables[1].Rows[0]["StatList"].ToString().Split(',');
            CheckGroupClear();

            foreach (string str in statlist)
            {
                for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
                {
                    if (tblChkGroup.Items[i].Tag.ToString().Trim().ToUpper() == str.Trim().ToUpper())
                    {
                        tblChkGroup.Items[i].Checked = true;
                        break;
                    }
                }
            }
            div_bottom.Html = "<p class=''>Status : Edit the record  of <span>" + txtCode.Text + "</span>.</p>";
            txtCode.Disabled = true;
        }
        else
        {
            ControlsInitial();
        }
    }

    /// <summary>
    /// 重置按钮
    /// </summary>    
    #region  btnCancel_Click(object, DirectEventArgs)  Author：Micro  (2011-08-29)
    protected void btnCancel_Click(object sender, DirectEventArgs e)
    {
        //ControlsInitial();
        //txtRowID.Text = "0";
        BinderData(txtRowID.Text);
    }
    #endregion


    /// <summary>
    /// 保存按钮
    /// </summary>
    #region  btnSave_Click(sender,DirectEventArgs)   Author：Micro  (2011-08-29)
    protected void btnSave_Click(object sender, DirectEventArgs e)
    {
        string strStat = "";

        for (int i = 0; i < tblChkGroup.Items.Count(); ++i)
        {
            string a = tblChkGroup.Items[i].Tag;
            if (!tblChkGroup.Items[i].Checked)
                strStat += tblChkGroup.Items[i].Tag.Trim() + ",";
        }

        strStat = strStat.Length > 0 ? strStat.Substring(0, strStat.Length - 1) : strStat;
 
        if (string.IsNullOrEmpty(txtCode.Text.Trim()))
        {
            txtCode.Text = "";
            txtCode.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , code can't be empty ! </p>";
            return;
        }
        if (string.IsNullOrEmpty(txtShort.Text.Trim()))
        {
            txtShort.Text = "";
            txtShort.Focus();
            div_bottom.Html = "<p class=\"error\">Status : Saved failed , short can't be empty ! </p>";
            return;
        }


        if (string.IsNullOrEmpty(txtDes.Text.Trim()))
        {
            txtDes.Text = "";
            txtDes.Focus();
            div_bottom.Html = "<p class='error'>Status : Saved failed , description can't be empty ! </p>";
            return;
        }

        if (!CheckCode("code"))
        {
            txtCode.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the code already exists! </p>";
            return;
        }

        if (!CheckCode("des"))
        {
            txtCode.Focus(true);
            div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the Description already exists! </p>";
            return;
        }

        //修改时间2014-09-23 Grace 
        //if (BaseCheckCode.Check("ITEM", txtCode.Text.ToUpper().Trim(), sys, txtRowID.Text) == "N")
        // {
        //     txtCode.Focus(true);
        //     div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the code already exists! </p>";
        //     return;
        // }

        //if (BaseCheckCode.Check("ITEMDESC", txtDes.Text.ToUpper().Trim(), sys, txtRowID.Text) == "N")
        //{
        //    txtCode.Focus(true);
        //    div_bottom.Html = "<p class=\"error\">Status : Saved failed ,the Description already exists! </p>";
        //    return;
        //}

        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Item_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "AddModify")                
                 .Append("itm_ROWID", txtRowID.Text) 
                 .Append("itm_Code", txtCode.Text.ToUpper()) 
                 .Append("itm_Short", txtShort.Text.ToUpper()) 
                 .Append("itm_Description",txtDes.Text.ToUpper()) 
                 .Append("itm_Description_CN",txtDesCN.Text.ToUpper()) 
                 .Append("itm_FCurrency",cmbFCurrency.Text) 
                 .Append("itm_FCalcQty", cmbFby.Text.ToUpper()) 
                 .Append("itm_FUnit", cmbFUnit.Text) 
                 .Append("itm_FMin", string.IsNullOrEmpty(txtFMain.Text.Trim())?DBNull.Value:(object)txtFMain.Text) 
                 .Append("itm_FRate",string.IsNullOrEmpty(txtFRate.Text.Trim())?DBNull.Value:(object)txtFRate.Text) 
                 .Append("itm_FAmount",string.IsNullOrEmpty(txtFAmount.Text.Trim())?DBNull.Value:(object)txtFAmount.Text) 
                 .Append("itm_FRound",string.IsNullOrEmpty(txtFRound.Text.Trim())?DBNull.Value:(object)txtFRound.Text) 
                 .Append("itm_FMarkUp", chbFUp.Checked?1:0) 
                 .Append("itm_FMarkDown",chbFDown.Checked?1:0) 
                 .Append("itm_LCurrency", labCurrency.Text.ToUpper()) 
                 .Append("itm_LCalcQty", cmbLby.Text.ToUpper()) 
                 .Append("itm_LUnit", cmbLUnit.Text) 
                 .Append("itm_LMin", string.IsNullOrEmpty(txtLMin.Text.Trim())?DBNull.Value:(object)txtLMin.Text) 
                 .Append("itm_LRate",string.IsNullOrEmpty(txtLRate.Text.Trim())?DBNull.Value:(object)txtLRate.Text) 
                 .Append("itm_LAmount",string.IsNullOrEmpty(txtLAmount.Text.Trim())?DBNull.Value:(object)txtLAmount.Text) 
                 .Append("itm_LRound",string.IsNullOrEmpty(txtLRound.Text.Trim())?DBNull.Value:(object)txtLRound.Text) 
                 .Append("itm_LMarkUp", chbLUp.Checked?1:0) 
                 .Append("itm_LMarkDown",chbLDown.Checked?1:0) 
                 .Append("itm_Active", chbActive.Checked?1:0) 
                 .Append("itm_User",FSecurityHelper.CurrentUserDataGET()[0])
                 .Append("itm_STAT",FSecurityHelper.CurrentUserDataGET()[12])
                 .Append("itm_SYS",sys) 
                 .Append("statstr",strStat)
                 .Append("dept", FSecurityHelper.CurrentUserDataGET()[28])
                    }).GetTable();
        if (dt != null && dt.Rows.Count > 0)
        {
            txtRowID.Text = dt.Rows[0][0].ToString();
            //txtRowID.Text = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Item_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "List").Append("itm_ROWID",txtRowID.Text) 
            //                    .Append("itm_STAT",FSecurityHelper.CurrentUserDataGET()[12])
            //                    .Append("itm_code",txtCode.Text.Trim())    
            //                    .Append("itm_SYS",sys)//FSecurityHelper.CurrentUserDataGET()[11].Substring(0,1))
            //                    .Append("dept", FSecurityHelper.CurrentUserDataGET()[28])
            //                    .Append("isGetId", 1)
            //                }).GetTable().Rows[0][0].ToString();

            if (!string.IsNullOrEmpty(Request["control"]))
            {
                X.AddScript("window.parent.ChildCallBack(Request(\"control\"), $(\"#txtCode\").val(), $(\"#txtDes\").val());");
                return;
            }
            if (i == 1)
            {
                txtRowID.Text = "0";
                ControlsInitial();
                txtFMain.Clear();
                txtFRate.Clear();
                txtFAmount.Clear();
                txtFRound.Clear();
                txtLMin.Clear();
                txtLRate.Clear();
                txtLAmount.Clear();
                txtLRound.Clear();
                txtCode.Disabled = false;
                CheckGroupChecked();
            }
            else
            {
                txtCode.Disabled = true;
            }
            //X.Msg.Alert("prompt", " Saved successfully !!! ", new JFunction { Fn = "TextFocus" }).Show();
            div_bottom.Html = "<p class='success'>Status :  Saved successful . </p>";
        }
        else
            div_bottom.Html = "<p class='error'>Status :  Save failed, please check the data ! </p>";
        //X.Msg.Alert("prompt", " Save failed !!! ", new JFunction { Fn = "TextFocus" }).Show();

        DataBinder();
        txtCode.Focus(true);
    }
    #endregion


    int i = 0;
    /// <summary>
    /// 保存新增按钮
    /// </summary>    
    #region  btnNext_Click(object, DirectEventArgs)  Author：Micro  (2011-08-29)
    protected void btnNext_Click(object sender, DirectEventArgs e)
    {
        i = 1;
        btnSave_Click(sender, e);
        //txtRowID.Text="0";
        //ControlsInitial();
    }
    #endregion

    /// <summary>
    /// 修改时间2014-09-19 Grace 只分系统不分站  验证是否存在
    /// </summary>
    /// <param name="type"></param>
    /// <returns></returns>
    public bool CheckCode(string type)
    {
        bool flag = false;
        userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();
        try
        {
            if (string.IsNullOrEmpty(txtCode.Text) || string.IsNullOrEmpty(txtDes.Text))
                flag = false;
            else
            {
                string cmdText = string.Empty;
                if (type == "code")
                {
                    cmdText = string.Format(@"
                    if exists(select * from fw_company where isnull(fco_isServer, 0) = 1 and IsDelete = 'N') and '{0}' in ('IT','ADMIN')
                    begin
                        select  itm_ROWID from cs_item  where itm_code='{1}' and itm_SYS='{2}' and itm_STAT=''
                    end 
                    else
                    begin
                        select  itm_ROWID from cs_item  where itm_code='{1}' and itm_SYS='{2}' and itm_stat='{3}'
                    end
                    ", userDept, txtCode.Text, sys, FSecurityHelper.CurrentUserDataGET()[12]);
                }
                else
                {
                    cmdText = string.Format(@"
                    if exists(select * from fw_company where isnull(fco_isServer, 0) = 1 and IsDelete = 'N') and '{0}' in ('IT','ADMIN')
                    begin
                        select itm_RowID from cs_item  where itm_Description='{1}' and itm_SYS='{2}' and itm_Code!='{3}' and itm_STAT=''
                    end 
                    else
                    begin
                        select itm_RowID from cs_item  where itm_Description='{1}' and itm_SYS='{2}' and itm_stat='{4}'
                    end
                    ", userDept, txtDes.Text, sys, txtCode.Text, FSecurityHelper.CurrentUserDataGET()[12]);
                }

                SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings);
                con.Open();
                SqlCommand cmd = new SqlCommand(cmdText, con);
                object result = cmd.ExecuteScalar();
                con.Close();

                if (result == null || result == DBNull.Value)
                    flag = true;
                else if (result.ToString() == txtRowID.Text)
                    flag = true;
            }
        }
        catch
        {
            flag = false;
        }
        return flag;
    }


    public XTemplate template
    {
        get
        {
            XTemplate xt = new XTemplate();
            xt.Html = "<tpl for=\".\">" +
                                                       "<tpl if=\"[xindex] == 1\">" +
                                                           "<table class=\"cbStates-list\">" +
                                                               "<tr>" +
                                                                    "<th>value</th>" +
                                                                   "<th>text</th>" +
                                                               "</tr>" +
                                                       "</tpl>" +
                                                           "<tr class=\"list-item\">" +
                                                           "<td style=\"padding:3px 0px; width:30%\">{value}</td>" +
                                                           "<td style=\"padding:3px 0px; width:70%\">{text}</td>" +
                                                       "</tr>" +
                                                       "<tpl if=\"[xcount-xindex]==0\">" +
                                                               "</table>" +
                                                       "</tpl></tpl>";
            return xt;
        }
    }

}
