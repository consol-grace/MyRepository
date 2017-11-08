using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;
using System.Text.RegularExpressions;

public partial class AllSystem_PrintLotList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            InitPage();
            string sys = Request["sys"];
            DisplayTable(sys);
            GetPageParam();
            CreateTable();
        }
    }

    void InitPage()
    {
        tabAE.Visible = false;
        tabAI.Visible = false;
        tabOE.Visible = false;
        tabOI.Visible = false;
        tabTG.Visible = false;
        tabOB.Visible = false;

        #region///AI
        txtAIfrom.Text = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd");
        txtAIto.Text = DateTime.Now.ToString("yyyy-MM-dd");
        txtAIlotno.Text = "";
        txtAImawb.Text = "";
        txtAIshipper.Text = "";
        chkAIDirect.Checked = false;
        chkAINormal.Checked = true;
        chkAIVoid.Checked = false;
        #endregion

        #region///AE
        txtAEcoloader.Text = "";
        txtAEconsignee.Text = "";
        txtAEfrom.Text = DateTime.Now.AddDays(-4).ToString("yyyy-MM-dd");
        txtAElot.Text = "";
        txtAEmawb.Text = "";
        txtAEshipper.Text = "";
        txtAEto.Text = "";
        drpAEdest.Text = "";
        #endregion

        #region///OI
        txtOIfrom.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd"); ;
        txtOIto.Text ="";
        txtOIlot.Text = "";
        txtOImbl.Text = "";
        txtOIpod.Text = "";
        txtOIpol.Text = "";
        txtOIvessel.Text = "";
        #endregion

        #region ///OE
        txtOEdest.Text = "";
        txtOEfrom.Text = DateTime.Now.AddDays(-10).ToString("yyyy-MM-dd");
        txtOElot.Text = "";
        txtOEmbl.Text = "";
        txtOEto.Text = "";
        #endregion

        #region ///TG
        txtTGconsignee.Text = "";
        txtTGfrom.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
        txtTGto.Text = "";
        txtTGhbl.Text = "";
        txtTGLotNo.Text = "";
        txtTGmbl.Text = "";
        txtTGshipper.Text = "";
        #endregion

        #region ///OB
        txtOBconsignee.Text = "";
        txtOBhbl.Text = "";
        txtOBfrom.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
        txtOBto.Text = DateTime.Now.ToString("yyyy-MM-dd");
        txtOBmbl.Text = "";
        txtOBlotNo.Text = "";
        txtOBshipper.Text = "";
        #endregion

        #region ///DO
        txtDODate.Text = DateTime.Now.AddDays(-7).ToString("yyyy/MM/dd");
        txtDOTo.Text = DateTime.MaxValue.ToString("yyyy/MM/dd");
        ddlDOCompany.Text = "";
        #endregion
    }

    void GetPageParam()
    {
        if (labSys.Text == "AI")
        {
            txtAIshipper.Text = Request["air_Shipper"];
            txtAImawb.Text = Request["air_MAWB"];
            drpAIfromto.Text = Request["air_LocLoad"];
            chkAINormal.Checked = Request["air_Normal"] == "0" ? false : true;
            chkAIDirect.Checked = Request["air_IsDirect"] == "0" ? false : true;
            chkAIVoid.Checked = Request["air_Active"] == "0" ? false : true;
            txtAIfrom.Text = Request["from"];
            txtAIto.Text = Request["to"];
            txtAIlotno.Text = Request["LotNo"];
        }
        else if (labSys.Text == "OE")
        {
            txtOElot.Text = Request["LotNo"];
            txtOEmbl.Text = Request["MBL"];
            txtOEdest.Text = Request["Dest"];
            txtOEfrom.Text = Request["ETD"];
            txtOEto.Text = Request["ETA"];
            txtOEShipper.Text = Request["Shipper"];//2014-12-16 Grace (修改查询条件)
        }
        else if (labSys.Text == "OI")
        {
            txtOIfrom.Text = Request["From"];
            txtOIlot.Text = Request["LotNo"];
            txtOImbl.Text = Request["MBL"];
            txtOIpol.Text = Request["POL"];
            txtOIpod.Text = Request["POD"];
            txtOIvessel.Text = Request["Vessel"];
            txtOIto.Text = Request["To"];
            txtOIShipper.Text = Request["Shipper"];//2014-12-16 Grace (修改查询条件)
        }
        else if (labSys.Text == "AE")
        {
            txtAEcoloader.Text = Request["Coloader"];
            txtAEmawb.Text = Request["MAWB"];
            txtAElot.Text = Request["LotNo"];
            drpAEdest.Text = Request["Dest"];
            txtAEfrom.Text = Request["ETD"];
            txtAEto.Text = Request["ETA"];
            txtAEshipper.Text = Request["Shipper"];
            txtAEconsignee.Text = Request["Consignee"];
        }
        else if (labSys.Text == "TG")
        {
            txtTGshipper.Text = Request["Shipper"];
            txtTGmbl.Text = Request["MBL"];
            txtTGhbl.Text = Request["HBL"];
            txtTGLotNo.Text = Request["LotNo"];
            txtTGconsignee.Text = Request["Consignee"];
            txtTGfrom.Text = Request["From"];
            txtTGto.Text = Request["to"];
            txtTGdest.Text = Request["Dest"];
        }
        else if (labSys.Text == "OB")
        {
            txtOBshipper.Text = Request["Shipper"];
            txtOBmbl.Text = Request["MBL"];
            txtOBhbl.Text = Request["HBL"];
            txtOBlotNo.Text = Request["LotNo"];
            txtOBconsignee.Text = Request["Consignee"];
            txtOBfrom.Text = Request["From"];
            txtOBto.Text = Request["To"];
            txtOBdest.Text = Request["Dest"];
        }
        else if (labSys.Text == "DO")
        {
            txtDODate.Text = Request["Date"];
            txtDOTo.Text = Request["To"];
            ddlDOCompany.Text = Request["Company"];
            cbDOVoid.Checked = Request["do_Active"] == "0" ? false : true;
        }
    }

    void DisplayTable(string sys)
    {
        if (!string.IsNullOrEmpty(sys))
            sys = sys.ToUpper().Trim();

        labSys.Text = sys;

        if (sys == "AE")
            tabAE.Visible = true;
        else if (sys == "AI")
            tabAI.Visible = true;
        else if (sys == "OE")
            tabOE.Visible = true;
        else if (sys == "OI")
            tabOI.Visible = true;
        else if (sys == "TG")
            tabTG.Visible = true;
        else if (sys == "OB")
            tabOB.Visible = true;
        else if (sys == "DO")
            tabOB.Visible = true;

    }

    public DataTable GetData(ref List<string[]> list)
    {
        DataFactory dal = new DataFactory();
        DataTable dt = new DataTable();
        list.Clear();
        if (labSys.Text == "AI")
        {
            list.Add(new string[] { "No.", "Direct", "Lot No.#", "MAWB", "Shipper", "Consignee", "Flight No.", "Arrival", "From", "To", "GWT", "CWT" });
            list.Add(new string[] { "Direct", "LotNo", "MAWB", "Shipper", "Consignee", "Flight", "Arrival", "From", "To", "GWT", "CWT" });
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirImport_Joblist_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "List")
                .Append("Option", "List")
                .Append("from",string.IsNullOrEmpty(txtAIfrom.Text)?DateTime.Parse("1900-01-01").ToString("yyyy-MM-dd 0:00:00"):DateTime.Parse(txtAIfrom.Text).ToString("yyyy-MM-dd"))
                .Append("to",string.IsNullOrEmpty(txtAIto.Text)?DateTime.Parse("1900-01-01").ToString("yyyy-MM-dd 0:00:00"):DateTime.Parse(txtAIto.Text).ToString("yyyy-MM-dd"))
                .Append("air_LotNo",txtAIlotno.Text.Trim())
                .Append("air_SYS","AI")
                .Append("air_STAT",FSecurityHelper.CurrentUserDataGET()[12])
                .Append("air_Shipper", txtAIshipper.Text.Trim())
                .Append("air_MAWB", txtAImawb.Text.Trim().Replace(" ",""))
                .Append("air_LocLoad", drpAIfromto.Text.Trim())
                .Append("air_Normal",chkAINormal.Checked?1:0)
                .Append("air_IsDirect", chkAIDirect.Checked?"1":"0")
                .Append("air_Status", "10")
                .Append("air_Active", chkAIVoid.Checked?"1":"0") 
                .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString()) }).GetTable();
            dt.DefaultView.Sort = " LotNo asc";
            dt = dt.DefaultView.ToTable();
        }
        else if (labSys.Text == "AE")
        {
            list.Add(new string[] { "No.", "Out", "Sell", "Direct", "Lot No.#", "MAWB No.", "Flight Date", "Dest.", "Flight No.", "G.WT", "V.WT", "C.WT" });
            list.Add(new string[] { "Coload", "Sell", "Direct", "LotNo", "MAWB", "FlightDate", "Dest", "FlightNo", "GWT", "VWT", "CWT" });
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AirExport_ViewConsol_SP", new List<IFields>() { dal.CreateIFields()
                 .Append("Option", "List")
                 .Append("air_STAT",FSecurityHelper.CurrentUserDataGET()[12])
                 .Append("air_MAWB",txtAEmawb.Text.Replace(" ","").Trim())
                 .Append("air_LotNo",txtAElot.Text.Trim())
                 .Append("air_LocFinal",drpAEdest.Text.Trim())
                 .Append("air_ETD",string.IsNullOrEmpty(txtAEfrom.Text)?DateTime.Parse("1900-01-01 0:00:00").ToString("yyyy-MM-dd 0:00:00"):DateTime.Parse(txtAEfrom.Text).ToString("yyyy-MM-dd 23:59:59"))
                 .Append("air_ETA",string.IsNullOrEmpty(txtAEto.Text)?DateTime.Parse("2900-01-01 0:00:00").ToString("yyyy-MM-dd 0:00:00"):DateTime.Parse(txtAEto.Text).ToString("yyyy-MM-dd 23:59:59"))
                 .Append("air_Shipper",txtAEshipper.Text.Trim())
                 .Append("air_Consignee",txtAEconsignee.Text.Trim())
                 .Append("air_CoLoader",txtAEcoloader.Text.Trim())
                 .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString()) }).GetTable();
            dt.DefaultView.Sort = " LotNo asc";
            dt = dt.DefaultView.ToTable();
        }
        else if (labSys.Text == "OI")
        {
            list.Add(new string[] { "No.", "ETD", "ETA", "Lot No.#", "POL", "POD", "MBL No.#", "Vessel", "Voyage", "Service Mode", "P/C" });
            list.Add(new string[] { "ETD", "ETA", "imp_LotNo", "POL", "POD", "MBL", "Vessel", "Voyage", "ServiceMode", "PPCC" });
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Ocean_OIJobList_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "OIJobList")
                .Append("LotNo", txtOIlot.Text.Trim())
                .Append("MBL", txtOImbl.Text.Trim())
                .Append("POL", txtOIpol.Text.Trim())
                .Append("POD", txtOIpod.Text.Trim())
                .Append("Vessel", txtOIvessel.Text.Trim())
                .Append("From", string.IsNullOrEmpty(txtOIfrom.Text) ? DateTime.Parse("1900-01-01").ToString("yyyy-MM-dd"):DateTime.Parse(txtOIfrom.Text).ToString("yyyy-MM-dd"))
                .Append("To", string.IsNullOrEmpty(txtOIto.Text) ? DateTime.Parse("1900-01-01").ToString("yyyy-MM-dd"):DateTime.Parse(txtOIto.Text).ToString("yyyy-MM-dd"))
                .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("SYS","OI" )
                .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString()) 
                .Append("o_Shipper", txtOIShipper.Text.Trim())//2014-12-18 Grace (修改查询条件)
                .Append("o_Active", chbOIVoid.Checked?"1":"0") 
            }).GetTable();
            dt.DefaultView.Sort = " imp_LotNo asc";
            dt = dt.DefaultView.ToTable();
        }
        else if (labSys.Text == "OE")
        {
            list.Add(new string[] { "No.", "ETD", "Type", "Lot No.#", "POL", "POD", "MBL No.#", "Vessel", "Voyage", "ETA", "P/C", "By", });
            list.Add(new string[] { "ETD", "o_ServiceType", "LotNo", "POL", "POD", "MBL", "Vessel", "Voyage", "ETA", "PPCC", "o_User", });
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_OceanExport_MBL_SP", new List<IFields>() { dal.CreateIFields()
                .Append("Option", "AssignJobList")
                .Append("o_LotNo", txtOElot.Text.Trim())
                .Append("o_MBL", txtOEmbl.Text.Trim())
                .Append("o_LocFinal",txtOEdest.Text.Trim())
                .Append("o_ETD", string.IsNullOrEmpty(txtOEfrom.Text)?DateTime.Parse("1900-01-01 0:00:00").ToString("yyyy-MM-dd 0:00:00"):DateTime.Parse(txtOEfrom.Text).ToString("yyyy-MM-dd"))
                .Append("o_ETA", string.IsNullOrEmpty(txtOEto.Text)?DateTime.Parse("2900-01-01 0:00:00").ToString("yyyy-MM-dd 0:00:00"):DateTime.Parse(txtOEto.Text).ToString("yyyy-MM-dd")) 
                .Append("o_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
                .Append("o_SYS","OE" )
                .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString())
                .Append("o_Shipper", txtOEShipper.Text.Trim())//2014-12-16 Grace (修改查询条件)
                .Append("o_Active", chbOEVoid.Checked ? "1" : "0")
            }).GetTable()
;
            dt.DefaultView.Sort = " LotNo asc";
            dt = dt.DefaultView.ToTable();
        }

        else if (labSys.Text == "TG")
        {

            list.Add(new string[] { "No.", "Type", "MBL/MAWB", "HBL/HAWB", "Lot No.#", "Shipper", "Consignee", "ETD", "ETA", "Depart.", "Dest." });
            list.Add(new string[] { "Type", "tri_MBL", "tri_HBL", "tri_LotNo", "tri_ShipperLine", "tri_ConsigneeLine", "tri_ETD", "tri_ETA", "tri_LocReceived", "tri_LocFinal" });
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Triangle_ShipmentList_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetList")
            .Append("tri_MBL", txtTGmbl.Text.Trim())
            .Append("tri_HBL", txtTGhbl.Text.Trim())
            .Append("tri_LotNo",txtTGLotNo.Text.Trim())
            .Append("tri_Shipper",txtTGshipper.Text.Trim())
            .Append("tri_Consignee", txtTGconsignee.Text.Trim()) 
            .Append("tri_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("From",  string.IsNullOrEmpty(txtTGfrom.Text)?DateTime.Parse("1900-01-01").ToString("yyyy-MM-dd"):DateTime.Parse(txtTGfrom.Text).ToString("yyyy-MM-dd"))
            .Append("To",  string.IsNullOrEmpty(txtTGto.Text)?DateTime.Parse("1900-01-01").ToString("yyyy-MM-dd"):DateTime.Parse(txtTGto.Text).ToString("yyyy-MM-dd"))
            .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString())
            .Append("tri_Active", chbTGVoid.Checked ? "1" : "0")//2014-12-16 Grace (修改查询条件)
            .Append("tri_LocFinal",txtTGdest.Text.Trim())
            }).GetTable();
            dt.DefaultView.Sort = " tri_LotNo asc";
            dt = dt.DefaultView.ToTable();
        }

        else if (labSys.Text == "OB")
        {

            list.Add(new string[] { "No.", "Type", "MBL", "HBL", "Lot No.#", "Shipper", "Consignee", "ETD", "ETA", "Depart.", "Dest." });
            list.Add(new string[] { "Type", "tri_MBL", "tri_HBL", "tri_LotNo", "tri_ShipperLine", "tri_ConsigneeLine", "tri_ETD", "tri_ETA", "tri_LocReceived", "tri_LocFinal" });
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_Other_ShipmentList_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "GetList")
            .Append("tri_MBL", txtOBmbl.Text.Trim())
            .Append("tri_HBL", txtOBhbl.Text.Trim())
            .Append("tri_LotNo",txtOBlotNo.Text.Trim())
            .Append("tri_Shipper",txtOBshipper.Text.Trim())
            .Append("tri_Consignee", txtOBconsignee.Text.Trim()) 
            .Append("tri_STAT", FSecurityHelper.CurrentUserDataGET()[12].ToString())
            .Append("From", string.IsNullOrEmpty(txtOBfrom.Text)?DateTime.Parse("1900-01-01").ToString("yyyy-MM-dd"):DateTime.Parse(txtOBfrom.Text).ToString("yyyy-MM-dd"))
            .Append("To", string.IsNullOrEmpty(txtOBto.Text)?DateTime.Parse("1900-01-01").ToString("yyyy-MM-dd"):DateTime.Parse(txtOBto.Text).ToString("yyyy-MM-dd"))
            .Append("UserGrade",FSecurityHelper.CurrentUserDataGET()[27].ToString())
            .Append("tri_Active", chbOBVoid.Checked ? "1" : "0")//2014-12-16 Grace (修改查询条件)
            .Append("tri_LocFinal",txtOBdest.Text.Trim())
            }).GetTable();
            dt.DefaultView.Sort = " tri_LotNo asc";
            dt = dt.DefaultView.ToTable();
        }

        else if (labSys.Text == "DO")
        {
            list.Add(new string[] { "No.", "Void", "DO #", "Date", "PO #", "Shipper", "Pick up place", "CTNS", "GW", "VOL/CBM", "Cost" });
            list.Add(new string[] { "IsVoid", "DO", "OrderDate", "PO", "Shipper", "ADDR", "CTNS", "GW", "CBM", "Cost" });
            dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_System_SP", new List<IFields>() { dal.CreateIFields()
            .Append("Option", "List")
            .Append("do_OrderDate", ControlBinder.getDate(string.IsNullOrEmpty(txtDODate.Text.Trim()) ? "1900/01/01" : (object)txtDODate.Text.Trim()))
            .Append("do_OrderTo", ControlBinder.getDate(string.IsNullOrEmpty(txtDOTo.Text.Trim()) ? DateTime.MaxValue : (object)txtDOTo.Text.Trim()))
            .Append("do_Company",ddlDOCompany.Text.Trim())
            .Append("do_IsVoid", cbDOVoid.Checked?"1":"0")
            .Append("do_Stat",FSecurityHelper.CurrentUserDataGET()[12])
            }).GetTable();
            dt.DefaultView.Sort = " DO asc";
            dt = dt.DefaultView.ToTable();
        }

        return dt;
    }


    public void CreateTable()
    {
        string strContent = "";
        List<string[]> list = new List<string[]>();
        DataTable dt = GetData(ref list);
        if (dt != null)
        {
            strContent = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n";
            if (dt.Rows.Count > 0)
            {
                strContent += "<tr class='tr_header'>\r\n";
                for (int i = 0; i < list[0].Count(); i++)
                {
                    strContent += "<td>" + list[0][i].ToUpper() + "</td>\r\n";
                }
                strContent += "</tr>\r\n";

                for (int i = 0; i < dt.Rows.Count && i < 500; ++i)
                {

                    strContent += "<tr class='tr_item'>\r\n<td>" + (i + 1).ToString() + "</td>";
                    for (int j = 0; j < list[1].Count(); ++j)
                    {
                        if (list[1][j] == "ETD" || list[1][j] == "ETA" || list[1][j] == "CFS" || list[1][j] == "CY" || list[1][j] == "Arrival" || list[1][j] == "FlightDate" || list[1][j] == "tri_ETA" || list[1][j] == "tri_ETD")
                            strContent += "<td class=\"td_" + dt.Columns[list[1][j]].ColumnName + "\"><span>" + (string.IsNullOrEmpty(dt.Rows[i][list[1][j]].ToString()) ? "" : Convert.ToDateTime(dt.Rows[i][list[1][j]]).ToString("dd/MM/yyyy")) + "</span></td>\r\n";
                        else if (list[1][j] == "LotNo" || list[1][j] == "imp_LotNo" || list[1][j] == "tri_LotNo")
                        {
                            string Htmlstring = dt.Rows[i][list[1][j]].ToString();
                            Htmlstring = Regex.Replace(Htmlstring, @"<(.[^>]*)>", "", RegexOptions.IgnoreCase);
                            strContent += "<td class=\"td_" + dt.Columns[list[1][j]].ColumnName + "\"><span>" + Htmlstring.ToUpper() + "</span></td>\r\n";
                        }
                        else
                        {
                            string value = dt.Rows[i][list[1][j]].ToString().ToUpper();
                            if (value == "TRUE")
                                value = "<div style='text-align:center;text-indent:-15px;'>√</div>";
                            else if (value == "FALSE")
                                value = "";

                            strContent += "<td class=\"td_" + dt.Columns[list[1][j]].ColumnName + "\"><span>" + value + "</span></td>\r\n";
                        }
                    }

                    strContent += "</tr>\r\n";
                }
            }
            strContent += "</table>\r\n";
        }

        ltlContent.Text = strContent;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Response.Write(drpAIfromto.Text);
        CreateTable();
    }
}
