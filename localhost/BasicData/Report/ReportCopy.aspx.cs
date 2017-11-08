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

public partial class BasicData_Report_ReportCopy : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            BindPanelTitle();
            BindReportCheckGroup();
        }
        
    }

    public readonly DataFactory dal = new DataFactory();

    public void BindReportCheckGroup()
    {
        #region Stat1
        BindCheckboxGroup(lblStat1.Text, "AE", ChkGroupAEReport1);
        BindCheckboxGroup(lblStat1.Text, "AI", ChkGroupAIReport1);
        BindCheckboxGroup(lblStat1.Text, "OE", ChkGroupOEReport1);
        BindCheckboxGroup(lblStat1.Text, "OI", ChkGroupOIReport1);
        BindCheckboxGroup(lblStat1.Text, "AT", ChkGroupATReport1);
        BindCheckboxGroup(lblStat1.Text, "OT", ChkGroupOTReport1);
        BindCheckboxGroup(lblStat1.Text, "DM", ChkGroupDMReport1);
        BindCheckboxGroup(lblStat1.Text, "TK", ChkGroupTKReport1);
        BindCheckboxGroup(lblStat1.Text, "BK", ChkGroupBKReport1);

        BindCheckAll(ChkGroupAEReport1, chkAllAE1);
        BindCheckAll(ChkGroupAIReport1, chkAllAI1);
        BindCheckAll(ChkGroupOEReport1, chkAllOE1);
        BindCheckAll(ChkGroupOIReport1, chkAllOI1);
        BindCheckAll(ChkGroupATReport1, chkAllAT1);
        BindCheckAll(ChkGroupOTReport1, chkAllOT1);
        BindCheckAll(ChkGroupDMReport1, chkAllDM1);
        BindCheckAll(ChkGroupTKReport1, chkAllTK1);
        BindCheckAll(ChkGroupBKReport1, chkAllBK1);
        #endregion

        #region Stat2
        BindCheckboxGroup(lblStat2.Text, "AE", ChkGroupAEReport2);
        BindCheckboxGroup(lblStat2.Text, "AI", ChkGroupAIReport2);
        BindCheckboxGroup(lblStat2.Text, "OE", ChkGroupOEReport2);
        BindCheckboxGroup(lblStat2.Text, "OI", ChkGroupOIReport2);
        BindCheckboxGroup(lblStat2.Text, "AT", ChkGroupATReport2);
        BindCheckboxGroup(lblStat2.Text, "OT", ChkGroupOTReport2);
        BindCheckboxGroup(lblStat2.Text, "DM", ChkGroupDMReport2);
        BindCheckboxGroup(lblStat2.Text, "TK", ChkGroupTKReport2);
        BindCheckboxGroup(lblStat2.Text, "BK", ChkGroupBKReport2);

        BindCheckAll(ChkGroupAEReport2, chkAllAE2);
        BindCheckAll(ChkGroupAIReport2, chkAllAI2);
        BindCheckAll(ChkGroupOEReport2, chkAllOE2);
        BindCheckAll(ChkGroupOIReport2, chkAllOI2);
        BindCheckAll(ChkGroupATReport2, chkAllAT2);
        BindCheckAll(ChkGroupOTReport2, chkAllOT2);
        BindCheckAll(ChkGroupDMReport2, chkAllDM2);
        BindCheckAll(ChkGroupTKReport2, chkAllTK2);
        BindCheckAll(ChkGroupBKReport2, chkAllBK2);
        #endregion

        #region Stat3
        BindCheckboxGroup(lblStat3.Text, "AE", ChkGroupAEReport3);
        BindCheckboxGroup(lblStat3.Text, "AI", ChkGroupAIReport3);
        BindCheckboxGroup(lblStat3.Text, "OE", ChkGroupOEReport3);
        BindCheckboxGroup(lblStat3.Text, "OI", ChkGroupOIReport3);
        BindCheckboxGroup(lblStat3.Text, "AT", ChkGroupATReport3);
        BindCheckboxGroup(lblStat3.Text, "OT", ChkGroupOTReport3);
        BindCheckboxGroup(lblStat3.Text, "DM", ChkGroupDMReport3);
        BindCheckboxGroup(lblStat3.Text, "TK", ChkGroupTKReport3);
        BindCheckboxGroup(lblStat3.Text, "BK", ChkGroupBKReport3);

        BindCheckAll(ChkGroupAEReport3, chkAllAE3);
        BindCheckAll(ChkGroupAIReport3, chkAllAI3);
        BindCheckAll(ChkGroupOEReport3, chkAllOE3);
        BindCheckAll(ChkGroupOIReport3, chkAllOI3);
        BindCheckAll(ChkGroupATReport3, chkAllAT3);
        BindCheckAll(ChkGroupOTReport3, chkAllOT3);
        BindCheckAll(ChkGroupDMReport3, chkAllDM3);
        BindCheckAll(ChkGroupTKReport3, chkAllTK3);
        BindCheckAll(ChkGroupBKReport3, chkAllBK3);
        #endregion

        #region Stat4
        BindCheckboxGroup(lblStat4.Text, "AE", ChkGroupAEReport4);
        BindCheckboxGroup(lblStat4.Text, "AI", ChkGroupAIReport4);
        BindCheckboxGroup(lblStat4.Text, "OE", ChkGroupOEReport4);
        BindCheckboxGroup(lblStat4.Text, "OI", ChkGroupOIReport4);
        BindCheckboxGroup(lblStat4.Text, "AT", ChkGroupATReport4);
        BindCheckboxGroup(lblStat4.Text, "OT", ChkGroupOTReport4);
        BindCheckboxGroup(lblStat4.Text, "DM", ChkGroupDMReport4);
        BindCheckboxGroup(lblStat4.Text, "TK", ChkGroupTKReport4);
        BindCheckboxGroup(lblStat4.Text, "BK", ChkGroupBKReport4);

        BindCheckAll(ChkGroupAEReport4, chkAllAE4);
        BindCheckAll(ChkGroupAIReport4, chkAllAI4);
        BindCheckAll(ChkGroupOEReport4, chkAllOE4);
        BindCheckAll(ChkGroupOIReport4, chkAllOI4);
        BindCheckAll(ChkGroupATReport4, chkAllAT4);
        BindCheckAll(ChkGroupOTReport4, chkAllOT4);
        BindCheckAll(ChkGroupDMReport4, chkAllDM4);
        BindCheckAll(ChkGroupTKReport4, chkAllTK4);
        BindCheckAll(ChkGroupBKReport4, chkAllBK4);
        #endregion

        #region Stat5
        BindCheckboxGroup(lblStat5.Text, "AE", ChkGroupAEReport5);
        BindCheckboxGroup(lblStat5.Text, "AI", ChkGroupAIReport5);
        BindCheckboxGroup(lblStat5.Text, "OE", ChkGroupOEReport5);
        BindCheckboxGroup(lblStat5.Text, "OI", ChkGroupOIReport5);
        BindCheckboxGroup(lblStat5.Text, "AT", ChkGroupATReport5);
        BindCheckboxGroup(lblStat5.Text, "OT", ChkGroupOTReport5);
        BindCheckboxGroup(lblStat5.Text, "DM", ChkGroupDMReport5);
        BindCheckboxGroup(lblStat5.Text, "TK", ChkGroupTKReport5);
        BindCheckboxGroup(lblStat5.Text, "BK", ChkGroupBKReport5);

        BindCheckAll(ChkGroupAEReport5, chkAllAE5);
        BindCheckAll(ChkGroupAIReport5, chkAllAI5);
        BindCheckAll(ChkGroupOEReport5, chkAllOE5);
        BindCheckAll(ChkGroupOIReport5, chkAllOI5);
        BindCheckAll(ChkGroupATReport5, chkAllAT5);
        BindCheckAll(ChkGroupOTReport5, chkAllOT5);
        BindCheckAll(ChkGroupDMReport5, chkAllDM5);
        BindCheckAll(ChkGroupTKReport5, chkAllTK5);
        BindCheckAll(ChkGroupBKReport5, chkAllBK5);
        #endregion

        #region Stat6
        BindCheckboxGroup(lblStat6.Text, "AE", ChkGroupAEReport6);
        BindCheckboxGroup(lblStat6.Text, "AI", ChkGroupAIReport6);
        BindCheckboxGroup(lblStat6.Text, "OE", ChkGroupOEReport6);
        BindCheckboxGroup(lblStat6.Text, "OI", ChkGroupOIReport6);
        BindCheckboxGroup(lblStat6.Text, "AT", ChkGroupATReport6);
        BindCheckboxGroup(lblStat6.Text, "OT", ChkGroupOTReport6);
        BindCheckboxGroup(lblStat6.Text, "DM", ChkGroupDMReport6);
        BindCheckboxGroup(lblStat6.Text, "TK", ChkGroupTKReport6);
        BindCheckboxGroup(lblStat6.Text, "BK", ChkGroupBKReport6);

        BindCheckAll(ChkGroupAEReport6, chkAllAE6);
        BindCheckAll(ChkGroupAIReport6, chkAllAI6);
        BindCheckAll(ChkGroupOEReport6, chkAllOE6);
        BindCheckAll(ChkGroupOIReport6, chkAllOI6);
        BindCheckAll(ChkGroupATReport6, chkAllAT6);
        BindCheckAll(ChkGroupOTReport6, chkAllOT6);
        BindCheckAll(ChkGroupDMReport6, chkAllDM6);
        BindCheckAll(ChkGroupTKReport6, chkAllTK6);
        BindCheckAll(ChkGroupBKReport6, chkAllBK6);
        #endregion

        #region Stat7
        BindCheckboxGroup(lblStat7.Text, "AE", ChkGroupAEReport7);
        BindCheckboxGroup(lblStat7.Text, "AI", ChkGroupAIReport7);
        BindCheckboxGroup(lblStat7.Text, "OE", ChkGroupOEReport7);
        BindCheckboxGroup(lblStat7.Text, "OI", ChkGroupOIReport7);
        BindCheckboxGroup(lblStat7.Text, "AT", ChkGroupATReport7);
        BindCheckboxGroup(lblStat7.Text, "OT", ChkGroupOTReport7);
        BindCheckboxGroup(lblStat7.Text, "DM", ChkGroupDMReport7);
        BindCheckboxGroup(lblStat7.Text, "TK", ChkGroupTKReport7);
        BindCheckboxGroup(lblStat7.Text, "BK", ChkGroupBKReport7);

        BindCheckAll(ChkGroupAEReport7, chkAllAE7);
        BindCheckAll(ChkGroupAIReport7, chkAllAI7);
        BindCheckAll(ChkGroupOEReport7, chkAllOE7);
        BindCheckAll(ChkGroupOIReport7, chkAllOI7);
        BindCheckAll(ChkGroupATReport7, chkAllAT7);
        BindCheckAll(ChkGroupOTReport7, chkAllOT7);
        BindCheckAll(ChkGroupDMReport7, chkAllDM7);
        BindCheckAll(ChkGroupTKReport7, chkAllTK7);
        BindCheckAll(ChkGroupBKReport7, chkAllBK7);
        #endregion

        #region Stat8
        BindCheckboxGroup(lblStat8.Text, "AE", ChkGroupAEReport8);
        BindCheckboxGroup(lblStat8.Text, "AI", ChkGroupAIReport8);
        BindCheckboxGroup(lblStat8.Text, "OE", ChkGroupOEReport8);
        BindCheckboxGroup(lblStat8.Text, "OI", ChkGroupOIReport8);
        BindCheckboxGroup(lblStat8.Text, "AT", ChkGroupATReport8);
        BindCheckboxGroup(lblStat8.Text, "OT", ChkGroupOTReport8);
        BindCheckboxGroup(lblStat8.Text, "DM", ChkGroupDMReport8);
        BindCheckboxGroup(lblStat8.Text, "TK", ChkGroupTKReport8);
        BindCheckboxGroup(lblStat8.Text, "BK", ChkGroupBKReport8);

        BindCheckAll(ChkGroupAEReport8, chkAllAE8);
        BindCheckAll(ChkGroupAIReport8, chkAllAI8);
        BindCheckAll(ChkGroupOEReport8, chkAllOE8);
        BindCheckAll(ChkGroupOIReport8, chkAllOI8);
        BindCheckAll(ChkGroupATReport8, chkAllAT8);
        BindCheckAll(ChkGroupOTReport8, chkAllOT8);
        BindCheckAll(ChkGroupDMReport8, chkAllDM8);
        BindCheckAll(ChkGroupTKReport8, chkAllTK8);
        BindCheckAll(ChkGroupBKReport8, chkAllBK8);
        #endregion

        #region Stat9
        BindCheckboxGroup(lblStat9.Text, "AE", ChkGroupAEReport9);
        BindCheckboxGroup(lblStat9.Text, "AI", ChkGroupAIReport9);
        BindCheckboxGroup(lblStat9.Text, "OE", ChkGroupOEReport9);
        BindCheckboxGroup(lblStat9.Text, "OI", ChkGroupOIReport9);
        BindCheckboxGroup(lblStat9.Text, "AT", ChkGroupATReport9);
        BindCheckboxGroup(lblStat9.Text, "OT", ChkGroupOTReport9);
        BindCheckboxGroup(lblStat9.Text, "DM", ChkGroupDMReport9);
        BindCheckboxGroup(lblStat9.Text, "TK", ChkGroupTKReport9);
        BindCheckboxGroup(lblStat9.Text, "BK", ChkGroupBKReport9);

        BindCheckAll(ChkGroupAEReport9, chkAllAE9);
        BindCheckAll(ChkGroupAIReport9, chkAllAI9);
        BindCheckAll(ChkGroupOEReport9, chkAllOE9);
        BindCheckAll(ChkGroupOIReport9, chkAllOI9);
        BindCheckAll(ChkGroupATReport9, chkAllAT9);
        BindCheckAll(ChkGroupOTReport9, chkAllOT9);
        BindCheckAll(ChkGroupDMReport9, chkAllDM9);
        BindCheckAll(ChkGroupTKReport9, chkAllTK9);
        BindCheckAll(ChkGroupBKReport9, chkAllBK9);
        #endregion

        #region Stat10
        BindCheckboxGroup(lblStat10.Text, "AE", ChkGroupAEReport10);
        BindCheckboxGroup(lblStat10.Text, "AI", ChkGroupAIReport10);
        BindCheckboxGroup(lblStat10.Text, "OE", ChkGroupOEReport10);
        BindCheckboxGroup(lblStat10.Text, "OI", ChkGroupOIReport10);
        BindCheckboxGroup(lblStat10.Text, "AT", ChkGroupATReport10);
        BindCheckboxGroup(lblStat10.Text, "OT", ChkGroupOTReport10);
        BindCheckboxGroup(lblStat10.Text, "DM", ChkGroupDMReport10);
        BindCheckboxGroup(lblStat10.Text, "TK", ChkGroupTKReport10);
        BindCheckboxGroup(lblStat10.Text, "BK", ChkGroupBKReport10);

        BindCheckAll(ChkGroupAEReport10, chkAllAE10);
        BindCheckAll(ChkGroupAIReport10, chkAllAI10);
        BindCheckAll(ChkGroupOEReport10, chkAllOE10);
        BindCheckAll(ChkGroupOIReport10, chkAllOI10);
        BindCheckAll(ChkGroupATReport10, chkAllAT10);
        BindCheckAll(ChkGroupOTReport10, chkAllOT10);
        BindCheckAll(ChkGroupDMReport10, chkAllDM10);
        BindCheckAll(ChkGroupTKReport10, chkAllTK10);
        BindCheckAll(ChkGroupBKReport10, chkAllBK10);
        #endregion

        #region Stat11
        BindCheckboxGroup(lblStat11.Text, "AE", ChkGroupAEReport11);
        BindCheckboxGroup(lblStat11.Text, "AI", ChkGroupAIReport11);
        BindCheckboxGroup(lblStat11.Text, "OE", ChkGroupOEReport11);
        BindCheckboxGroup(lblStat11.Text, "OI", ChkGroupOIReport11);
        BindCheckboxGroup(lblStat11.Text, "AT", ChkGroupATReport11);
        BindCheckboxGroup(lblStat11.Text, "OT", ChkGroupOTReport11);
        BindCheckboxGroup(lblStat11.Text, "DM", ChkGroupDMReport11);
        BindCheckboxGroup(lblStat11.Text, "TK", ChkGroupTKReport11);
        BindCheckboxGroup(lblStat11.Text, "BK", ChkGroupBKReport11);

        BindCheckAll(ChkGroupAEReport11, chkAllAE11);
        BindCheckAll(ChkGroupAIReport11, chkAllAI11);
        BindCheckAll(ChkGroupOEReport11, chkAllOE11);
        BindCheckAll(ChkGroupOIReport11, chkAllOI11);
        BindCheckAll(ChkGroupATReport11, chkAllAT11);
        BindCheckAll(ChkGroupOTReport11, chkAllOT11);
        BindCheckAll(ChkGroupDMReport11, chkAllDM11);
        BindCheckAll(ChkGroupTKReport11, chkAllTK11);
        BindCheckAll(ChkGroupBKReport11, chkAllBK11);
        #endregion
    }

    //公用方法 绑定CheckboxGroup 站,系统,控件ID
    public void BindCheckboxGroup(string Stat,string Sys, CheckboxGroup chkGroup)
    {
        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_PRINTERCopy_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "BindCheck")
             .Append("Stat",Stat)
             .Append("Sys",Sys)
        }).GetTable();

        if (dt != null && dt.Rows.Count > 0)
        {
            int i = 0;
            bool isCH = false;
            foreach (DataRow dr in dt.Rows)
            {
                i++;
                if (dr[2].ToString().ToUpper() == "TRUE")
                {
                    isCH = true;
                }
                else
                {
                    isCH = false;
                }

                chkGroup.Items.Add(new Checkbox()
                {
                    Value = dr[1].ToString(),
                    Tag = dr[1].ToString().Trim(),
                    BoxLabel = dr[0].ToString(),
                    LabelAlign = LabelAlign.Right,
                    LabelWidth = 95,
                    Checked = isCH
                });

            }

            //X.AddScript("$('#" + chkGroup.ID + " input[type=\"checkbox\"]').click(function () {alert(1)});");
            //X.AddScript("alert($('#" + chkGroup.ID + " input[type=\"checkbox\"]').html());");
        }
        else
        {
            chkGroup.Items.Add(new Checkbox());
            chkGroup.Hide();
            chkGroup.Dispose();
            chkGroup.Destroy();
        }
    }

    public void BindCheckAll(CheckboxGroup chkGroup,Checkbox chk)
    {
        string strSeed = "";
        bool isChecked = true;
        for (int i = 0; i < chkGroup.Items.Count(); ++i)
        {
            if (!chkGroup.Items[i].Checked)
                isChecked = false;

            strSeed += chkGroup.Items[i].Tag.Trim() + ",";
        }

        strSeed = strSeed.Length > 0 ? strSeed.Substring(0, strSeed.Length - 1) : strSeed;
        chk.Tag = strSeed;
        chk.Checked = isChecked;
    }
    //绑定Panel标题
    public void BindPanelTitle()
    {
        DataTable dsPanelTitle = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_PRINTERCopy_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "BindTitle")
        }).GetTable();

        Panel1.Title = dsPanelTitle.Rows[0][0].ToString();
        lblStat1.Text = dsPanelTitle.Rows[0][1].ToString();

        Panel2.Title = dsPanelTitle.Rows[1][0].ToString();
        lblStat2.Text = dsPanelTitle.Rows[1][1].ToString();

        Panel3.Title = dsPanelTitle.Rows[2][0].ToString();
        lblStat3.Text = dsPanelTitle.Rows[2][1].ToString();

        Panel4.Title = dsPanelTitle.Rows[3][0].ToString();
        lblStat4.Text = dsPanelTitle.Rows[3][1].ToString();

        Panel5.Title = dsPanelTitle.Rows[4][0].ToString();
        lblStat5.Text = dsPanelTitle.Rows[4][1].ToString();

        Panel6.Title = dsPanelTitle.Rows[5][0].ToString();
        lblStat6.Text = dsPanelTitle.Rows[5][1].ToString();

        Panel7.Title = dsPanelTitle.Rows[6][0].ToString();
        lblStat7.Text = dsPanelTitle.Rows[6][1].ToString();

        Panel8.Title = dsPanelTitle.Rows[7][0].ToString();
        lblStat8.Text = dsPanelTitle.Rows[7][1].ToString();

        Panel9.Title = dsPanelTitle.Rows[8][0].ToString();
        lblStat9.Text = dsPanelTitle.Rows[8][1].ToString();

        Panel10.Title = dsPanelTitle.Rows[9][0].ToString();
        lblStat10.Text = dsPanelTitle.Rows[9][1].ToString();

        Panel11.Title = dsPanelTitle.Rows[10][0].ToString();
        lblStat11.Text = dsPanelTitle.Rows[10][1].ToString();

        //Panel12.Title = dsPanelTitle.Rows[11][0].ToString();
    }

    //[DirectMethod]
    //public void CheckedLis(string v,string s)
    //{
    //    DataTable dsPanelTitle = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_PRINTERCopy_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
    //         .Append("Option","Checked")
    //         .Append("ReportCode",v)
    //         .Append("Stat", lblStat1.Text)
    //         .Append("Sys",s)
    //    }).GetTable();
    //}
    
}