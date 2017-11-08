using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;


public partial class common_UIControls_Costing : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            hidCostType.Text = this.sys+this.type;
            hidCostSeed.Text = Request["seed"] == null ? "" : Request["seed"];
            
            hidCostSys.Text = this.sys.StartsWith("A") ? "A" : "O";

            if (hidCostSeed.Text == "")
            {
                if (hidCostSys.Text == "A" && Request["MAWB"] != null)
                {
                    hidLockCostSeed.Text = Request["MAWB"];
                }
                else if (hidCostSys.Text == "A" && Request["transSeed"] != null)
                {
                    hidLockCostSeed.Text = Request["transSeed"];
                }
                else if (hidCostSys.Text == "O" && Request["MBL"] != null)
                {
                    hidLockCostSeed.Text = Request["MBL"];
                }
                else if (hidCostSys.Text == "O" && Request["Jobseed"] != null)
                {
                    hidLockCostSeed.Text = Request["Jobseed"];
                }
            }
            else
            {
                hidLockCostSeed.Text = hidCostSeed.Text;
            }
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                SetDefaultValue();
                CostDataBinding();
                X.AddScript("CostTotalList();");
                Prepare();
            }
            
        }
        
    }

    #region CostDataBinding
    private void CostDataBinding()
    {
        DataFactory dalCost = new DataFactory();
        DataSet dsCost = dalCost.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallCost_SP", new List<IFields> { dalCost.CreateIFields()
            .Append("Option", "GetCost").Append("seed", hidCostSeed.Text==""?null:hidCostSeed.Text).Append("type",this.type) }).GetList();

        StoreCosting.DataSource = dsCost;
        StoreCosting.DataBind();

        LockCost();

    }
    #endregion

    #region Lock Cost
    private void LockCost()
    {
        if (hidLockCostSeed.Text != null && hidLockCostSeed.Text != "")
        {
            DataFactory dalCost = new DataFactory();
            DataSet dsStatus = dalCost.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallLockCost_SP", new List<IFields> { dalCost.CreateIFields()
            .Append("Option", "LockCostStatus").Append("seed", hidLockCostSeed.Text).Append("sys",this.sys) }).GetList();
            if (dsStatus != null && dsStatus.Tables.Count > 0)
            {
                int lockcost = int.Parse(dsStatus.Tables[0].Rows[0][0].ToString());
                if (lockcost == 1)
                {
                    labLockCost.Hidden = false;
                    X.AddScript("$('#LockCostMask').css('display','block');");
                    X.AddScript("$('#LockCostRight').attr('disabled',true);");
                    //X.AddScript("$('#btnCostInsert').attr('disabled',true);");
                    //X.AddScript("$('#btnCostReset').attr('disabled',true);");
                    //X.AddScript("$('#btnCostDelete').attr('disabled',true);");
                }
                else
                {
                    labLockCost.Hidden = true;
                    X.AddScript("$('#LockCostMask').css('display','none');");
                    X.AddScript("$('#LockCostRight').attr('disabled',false);");
                    //X.AddScript("$('#btnCostInsert').attr('disabled',false);");
                    //X.AddScript("$('#btnCostReset').attr('disabled',false);");
                    //X.AddScript("$('#btnCostDelete').attr('disabled',false);");
                }
            }
        }
    }
    #endregion

    #region CancleCost
    protected void btnCancleCost_Click(object sender, DirectEventArgs e)
    {
        CostDataBinding();
        X.AddScript("CostTotalList();");
    }
    #endregion

   

    public void btnCostEvent(object sender, DirectEventArgs e)
    {
        #region Update Cost
        hidCostSeed.Text = this.costseed;
        var CostList = JSON.Deserialize<List<Cost>>(e.ExtraParams["gridCost"]);
        var RowID = "0,";
        for (int i = 0; i < CostList.Count; ++i)
        {
            RowID += CostList[i].RowID + ",";
        }
        RowID = RowID.Substring(0, RowID.Length - 1);
        DataFactory dal = new DataFactory();
        bool cost = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallCost_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "DeleteCost")
            .Append("seed",hidCostSeed.Text==""?null:hidCostSeed.Text)
            .Append("type",this.type)
            .Append("ROWID",RowID)}).Update();
        bool l = true;
        List<IFields> listCosting = new List<IFields>();
        if (CostList.Count == 0)
        {
            l = true;
        }
        else
        {
            for (int i = 0; i < CostList.Count; ++i)
            {
                listCosting.Add(dal.CreateIFields().Append("Option", "UpdateCost").
                Append("si_ROWID", CostList[i].RowID).
                Append("si_Stat", FSecurityHelper.CurrentUserDataGET()[12].ToString()).
                Append("si_Sys", this.sys).
                Append("si_ToMaster", this.type.StartsWith("M") ? (hidCostSeed.Text == "" ? null : hidCostSeed.Text) : null).
                Append("si_ToHouse", this.type.StartsWith("M") ? null : (hidCostSeed.Text == "" ? null : hidCostSeed.Text)).
                Append("si_Seed", hidCostSeed.Text == "" ? null : hidCostSeed.Text).
                Append("si_BillTo", CostList[i].CompanyCode.Trim().ToUpper()).
                Append("si_Item", CostList[i].Item.Trim().ToUpper()).
                Append("si_Description", CostList[i].Description.ToUpper()).
                Append("si_QtyKind", CostList[i].CalcKind).
                Append("si_Quantity", string.IsNullOrEmpty(CostList[i].Qty) ? DBNull.Value : (object)CostList[i].Qty).
                Append("si_Unit", CostList[i].Unit).
                Append("si_Currency", CostList[i].Currency).
                Append("si_ExRate", string.IsNullOrEmpty(CostList[i].Ex) ? DBNull.Value : (object)CostList[i].Ex).
                Append("si_Rate", string.IsNullOrEmpty(CostList[i].Rate) ? DBNull.Value : (object)CostList[i].Rate).
                Append("si_Amount", string.IsNullOrEmpty(CostList[i].Amount) ? DBNull.Value : (object)CostList[i].Amount).
                Append("si_User", FSecurityHelper.CurrentUserDataGET()[0].ToString()).
                Append("si_Total", string.IsNullOrEmpty(CostList[i].Total) ? DBNull.Value : (object)CostList[i].Total).
                Append("si_Remark", CostList[i].Remark.Trim().ToUpper()).
                Append("si_BillCurrency", CostList[i].si_BillCurrency).
                Append("si_Min", string.IsNullOrEmpty(CostList[i].Min) ? DBNull.Value : (object)CostList[i].Min).
                Append("si_Percent", string.IsNullOrEmpty(CostList[i].Percent) ? DBNull.Value : (object)CostList[i].Percent).
                Append("si_ShowIn", CostList[i].Show).
                Append("si_PPCC", CostList[i].PPD).
                Append("si_ActTotal", string.IsNullOrEmpty(CostList[i].ATotal) ? DBNull.Value : (object)CostList[i].ATotal).
                Append("si_ForeignTotal", string.IsNullOrEmpty(CostList[i].FTotal) ? DBNull.Value : (object)CostList[i].FTotal)
                );
            }
            l = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallCost_SP", listCosting).Update();
        }
        bool costHeader = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallCost_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "SetCostHeader")
            .Append("seed",hidCostSeed.Text==""?null:hidCostSeed.Text).Append("si_User",FSecurityHelper.CurrentUserDataGET()[0].ToString())}).Update();
        CostDataBinding();
        X.AddScript("CostTotalList();");
        #endregion
    }



    #region Prepare
    private void Prepare()
    {
        cos_Unit.Template.Html = Template.Html;
        
        switch (hidCostType.Text)
        {
            case "AIM":
                //cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_ItemA.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(63);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(63);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(45);
                cos_Amount.Width = Unit.Pixel(46);
                cos_Remark.Width = Unit.Pixel(242);

                //cos_PPD.TabIndex = 33;
                cos_Company.TabIndex = 33;
                cos_ItemA.TabIndex = 34;
                cos_Calc.TabIndex = 35;
                cos_Unit.TabIndex = 36;
                cos_Qty.TabIndex = 37;
                billcurrency.TabIndex = 38;
                cos_Currency.TabIndex = 38;
                cos_EX.TabIndex = 38;
                cos_Percent.TabIndex = 38;
                cos_Min.TabIndex = 39;
                cos_Rate.TabIndex = 39;
                cos_Amount.TabIndex = 40;
                cos_Remark.TabIndex = 40;
                break;
            case "AIH":
                //cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_ItemA.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(54);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(54);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(41);
                cos_Amount.Width = Unit.Pixel(41);
                cos_Remark.Width = Unit.Pixel(233);

                //cos_PPD.TabIndex = 26;
                cos_Company.TabIndex = 26;
                cos_ItemA.TabIndex = 27;
                cos_Calc.TabIndex = 28;
                cos_Unit.TabIndex = 29;
                cos_Qty.TabIndex = 30;
                billcurrency.TabIndex = 31;
                cos_Currency.TabIndex = 31;
                cos_EX.TabIndex = 31;
                cos_Percent.TabIndex = 31;
                cos_Min.TabIndex = 32;
                cos_Rate.TabIndex = 32;
                cos_Amount.TabIndex = 33;
                cos_Remark.TabIndex = 33;
                break;
            case "AEM1":
                cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_ItemA.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);

                cos_PPD.TabIndex = 32;
                cos_Company.TabIndex = 32;
                cos_ItemA.TabIndex = 33;
                cos_Calc.TabIndex = 34;
                cos_Unit.TabIndex = 35;
                cos_Qty.TabIndex = 36;
                billcurrency.TabIndex = 37;
                cos_Currency.TabIndex = 37;
                cos_EX.TabIndex = 38;
                cos_Percent.TabIndex = 38;
                cos_Min.TabIndex = 39;
                cos_Rate.TabIndex = 39;
                cos_Amount.TabIndex = 40;
                cos_Remark.TabIndex = 40;
                break;
            case "AEM2":
                cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_ItemA.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);

                cos_PPD.TabIndex = 33;
                cos_Company.TabIndex = 33;
                cos_ItemA.TabIndex = 34;
                cos_Calc.TabIndex = 35;
                cos_Unit.TabIndex = 36;
                cos_Qty.TabIndex = 37;
                billcurrency.TabIndex = 38;
                cos_Currency.TabIndex = 38;
                cos_EX.TabIndex = 38;
                cos_Percent.TabIndex = 38;
                cos_Min.TabIndex = 39;
                cos_Rate.TabIndex = 39;
                cos_Amount.TabIndex = 40;
                cos_Remark.TabIndex = 40;
                break;
            case "AEM3":
                cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_ItemA.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);

                cos_PPD.TabIndex = 44;
                cos_Company.TabIndex = 45;
                cos_ItemA.TabIndex = 46;
                cos_Calc.TabIndex = 47;
                cos_Unit.TabIndex = 48;
                cos_Qty.TabIndex = 49;
                billcurrency.TabIndex = 50;
                cos_Currency.TabIndex = 50;
                cos_EX.TabIndex = 50;
                cos_Percent.TabIndex = 50;
                cos_Min.TabIndex = 51;
                cos_Rate.TabIndex = 51;
                cos_Amount.TabIndex = 52;
                cos_Remark.TabIndex = 52;
                break;
            case "AEH1":
                cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_ItemA.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);

                cos_PPD.TabIndex = 50;
                cos_Company.TabIndex = 51;
                cos_ItemA.TabIndex = 52;
                cos_Calc.TabIndex = 52;
                cos_Unit.TabIndex = 52;
                cos_Qty.TabIndex = 52;
                billcurrency.TabIndex = 53;
                cos_Currency.TabIndex = 53;
                cos_EX.TabIndex = 54;
                cos_Percent.TabIndex = 54;
                cos_Min.TabIndex = 55;
                cos_Rate.TabIndex = 55;
                cos_Amount.TabIndex = 56;
                cos_Remark.TabIndex = 57;

                labCosting.Text = "A/P (Costs)";
                labaddcosting.Text = "Add AP Cost";
                break;
            case "AEH2":
                cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_ItemA.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);
                
                cos_PPD.TabIndex = 26;
                cos_Company.TabIndex = 26;
                cos_ItemA.TabIndex = 27;
                cos_Calc.TabIndex = 28;
                cos_Unit.TabIndex = 29;
                cos_Qty.TabIndex = 30;
                billcurrency.TabIndex = 31;
                cos_Currency.TabIndex = 31;
                cos_EX.TabIndex = 31;
                cos_Min.TabIndex = 32;
                cos_Rate.TabIndex = 32;
                cos_Amount.TabIndex = 33;
                cos_Percent.TabIndex = 33;
                cos_Show.TabIndex = 33;
                cos_Remark.TabIndex = 34;

                cos_Show.StoreID = "StoreShowIn";
                break;
            case "OIM":
                cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_Item.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);

                cos_PPD.TabIndex = 35;
                cos_Company.TabIndex = 36;
                cos_Item.TabIndex = 37;
                cos_Calc.TabIndex = 38;
                cos_Unit.TabIndex = 39;
                cos_Qty.TabIndex = 40;
                billcurrency.TabIndex = 41;
                cos_Currency.TabIndex = 41;
                cos_EX.TabIndex = 41;
                cos_Percent.TabIndex = 41;
                cos_Min.TabIndex = 42;
                cos_Rate.TabIndex = 42;
                cos_Amount.TabIndex = 43;
                cos_Remark.TabIndex = 43;
                break;
            case "OIH":
                cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_Item.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);


                cos_PPD.TabIndex = 29;
                cos_Company.TabIndex = 30;
                cos_Item.TabIndex = 31;
                cos_Calc.TabIndex = 32;
                cos_Unit.TabIndex = 33;
                cos_Qty.TabIndex = 34;
                billcurrency.TabIndex = 35;
                cos_Currency.TabIndex = 35;
                cos_EX.TabIndex = 36;
                cos_Percent.TabIndex = 36;
                cos_Min.TabIndex = 37;
                cos_Rate.TabIndex = 37;
                cos_Amount.TabIndex = 38;
                cos_Remark.TabIndex = 38;
                break;
            case "OEM":
                cos_PPD.Width = Unit.Pixel(90) ;
                cos_Company.Width = Unit.Pixel(63);
                cos_Item.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);

                cos_PPD.TabIndex = 35;
                cos_Company.TabIndex = 36;
                cos_Item.TabIndex = 37;
                cos_Calc.TabIndex = 38;
                cos_Unit.TabIndex = 39;
                cos_Qty.TabIndex = 40;
                billcurrency.TabIndex = 41;
                cos_Currency.TabIndex = 41;
                cos_EX.TabIndex = 41;
                cos_Percent.TabIndex = 41;
                cos_Min.TabIndex = 42;
                cos_Rate.TabIndex = 42;
                cos_Amount.TabIndex = 43;
                cos_Remark.TabIndex = 43;
                break;
            case "OEH":
                cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_Item.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(53);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(53);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(42);
                cos_Amount.Width = Unit.Pixel(43);
                cos_Remark.Width = Unit.Pixel(232);


                cos_PPD.TabIndex = 29;
                cos_Company.TabIndex = 30;
                cos_Item.TabIndex = 31;
                cos_Calc.TabIndex = 32;
                cos_Unit.TabIndex = 33;
                cos_Qty.TabIndex = 34;
                billcurrency.TabIndex = 35;
                cos_Currency.TabIndex = 35;
                cos_EX.TabIndex = 36;
                cos_Percent.TabIndex = 36;
                cos_Min.TabIndex = 37;
                cos_Rate.TabIndex = 37;
                cos_Amount.TabIndex = 38;
                cos_Remark.TabIndex = 38;
                break;
            case "ATM":
                //cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_ItemA.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(67);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(67);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(48);
                cos_Amount.Width = Unit.Pixel(48);
                cos_Remark.Width = Unit.Pixel(246);

                //cos_PPD.TabIndex = 22;
                cos_Company.TabIndex = 22;
                cos_ItemA.TabIndex = 23;
                cos_Calc.TabIndex = 24;
                cos_Unit.TabIndex = 25;
                cos_Qty.TabIndex = 26;
                billcurrency.TabIndex = 27;
                cos_Currency.TabIndex = 27;
                cos_EX.TabIndex = 27;
                cos_Percent.TabIndex = 27;
                cos_Min.TabIndex = 28;
                cos_Rate.TabIndex = 28;
                cos_Amount.TabIndex = 29;
                cos_Remark.TabIndex = 29;
                break;
            case "OTM":
                //cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_Item.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(68);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(68);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(48);
                cos_Amount.Width = Unit.Pixel(48);
                cos_Remark.Width = Unit.Pixel(247);

                //cos_PPD.TabIndex = 22;
                cos_Company.TabIndex = 22;
                cos_Item.TabIndex = 23;
                cos_Calc.TabIndex = 24;
                cos_Unit.TabIndex = 25;
                cos_Qty.TabIndex = 26;
                billcurrency.TabIndex = 27;
                cos_Currency.TabIndex = 27;
                cos_EX.TabIndex = 27;
                cos_Percent.TabIndex = 27;
                cos_Min.TabIndex = 28;
                cos_Rate.TabIndex = 28;
                cos_Amount.TabIndex = 29;
                cos_Remark.TabIndex = 29;
                break;
            case "DMM":
                //cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_Item.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(68);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(68);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(48);
                cos_Amount.Width = Unit.Pixel(48);
                cos_Remark.Width = Unit.Pixel(247);

                //cos_PPD.TabIndex = 22;
                cos_Company.TabIndex = 22;
                cos_Item.TabIndex = 23;
                cos_Calc.TabIndex = 24;
                cos_Unit.TabIndex = 25;
                cos_Qty.TabIndex = 26;
                billcurrency.TabIndex = 27;
                cos_Currency.TabIndex = 27;
                cos_EX.TabIndex = 27;
                cos_Percent.TabIndex = 27;
                cos_Min.TabIndex = 28;
                cos_Rate.TabIndex = 28;
                cos_Amount.TabIndex = 29;
                cos_Remark.TabIndex = 29;
                break;
            case "BKM":
                //cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_Item.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(68);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(68);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(48);
                cos_Amount.Width = Unit.Pixel(48);
                cos_Remark.Width = Unit.Pixel(247);

                //cos_PPD.TabIndex = 22;
                cos_Company.TabIndex = 22;
                cos_Item.TabIndex = 23;
                cos_Calc.TabIndex = 24;
                cos_Unit.TabIndex = 25;
                cos_Qty.TabIndex = 26;
                billcurrency.TabIndex = 27;
                cos_Currency.TabIndex = 27;
                cos_EX.TabIndex = 27;
                cos_Percent.TabIndex = 27;
                cos_Min.TabIndex = 28;
                cos_Rate.TabIndex = 28;
                cos_Amount.TabIndex = 29;
                cos_Remark.TabIndex = 29;
                break;
            case "TKM":
                //cos_PPD.Width = Unit.Pixel(90);
                cos_Company.Width = Unit.Pixel(63);
                cos_Item.Width = Unit.Pixel(69);
                cos_Calc.Width = Unit.Pixel(61);
                cos_Unit.Width = Unit.Pixel(56);
                cos_Qty.Width = Unit.Pixel(68);
                billcurrency.Width = Unit.Pixel(61);
                cos_Currency.Width = Unit.Pixel(61);
                cos_EX.Width = Unit.Pixel(68);
                cos_Min.Width = Unit.Pixel(61);
                cos_Rate.Width = Unit.Pixel(48);
                cos_Amount.Width = Unit.Pixel(48);
                cos_Remark.Width = Unit.Pixel(247);

                //cos_PPD.TabIndex = 25;
                cos_Company.TabIndex = 25;
                cos_Item.TabIndex = 26;
                cos_Calc.TabIndex = 27;
                cos_Unit.TabIndex = 28;
                cos_Qty.TabIndex = 29;
                billcurrency.TabIndex = 30;
                cos_Currency.TabIndex = 30;
                cos_EX.TabIndex = 31;
                cos_Percent.TabIndex = 31;
                cos_Min.TabIndex = 32;
                cos_Rate.TabIndex = 32;
                cos_Amount.TabIndex = 33;
                cos_Remark.TabIndex = 33;
                break;
        }
        X.AddScript("displayCost('" + hidCostType.Text + "');");
    }
    public XTemplate Template
    {
        get
        {
            XTemplate xt = new XTemplate();
            xt.Html = "<tpl for=\".\">" +
                      "<tpl if=\"[xindex] == 1\">" +
                          "<table class=\"cbStates-list\">" +
                              "<tr>" +
                                   "<th>Code</th>" +
                                  "<th>Name</th>" +
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
    #endregion

    #region default value
    private void SetDefaultValue()
    {
        DataFactory dal = new DataFactory();
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallCost_SP", new List<IFields> { dal.CreateIFields()
            .Append("Option", "GetDefaultValue").Append("si_Sys", hidCostSys.Text).Append("si_Stat",FSecurityHelper.CurrentUserDataGET()[12].ToString()) }).GetList();
        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                hidFCur.Text = ds.Tables[0].Rows[0][0].ToString();
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                hidLCur.Text = ds.Tables[1].Rows[0][0].ToString();
                billcurrency.SelectedItem.Value = hidLCur.Text;
            }
        }

    }
    #endregion


    #region 属性
    #region 系统
    private string _sys = ""; 
        public string sys
        {
            get{return _sys;}
            set{_sys=value;}
        }
        #endregion
    #region 类型
    private string _type = "";
    public string type
    {
        get { return _type; }
        set { _type = value; }
    }
    #endregion
    #region 类型
    private string _costseed = "";
    public string costseed
    {
        get { return _costseed; }
        set { _costseed = value; }
    }
    #endregion
    #endregion

    #region Cost 实体类
        class Cost
        {
            public string RowID
            { get; set; }
            public string PPD
            { get; set; }
            public string CompanyCode
            { get; set; }
            public string CompanyName
            { get; set; }
            public string Item
            { get; set; }
            public string Description
            { get; set; }
            public string Total
            { get; set; }
            public string CalcKind
            { get; set; }
            public string Qty
            { get; set; }
            public string Unit
            { get; set; }
            public string Currency
            { get; set; }
            public string Ex
            { get; set; }
            public string Rate
            { get; set; }
            public string Amount
            { get; set; }
            public string Remark
            { get; set; }
            public string si_BillCurrency
            { get; set; }
            public string Min
            { get; set; }
            public string Percent
            { get; set; }
            public string Show
            { get; set; }
            public string ATotal
            { get; set; }
            public string FTotal
            { get; set; }
        }
        #endregion
    
}
