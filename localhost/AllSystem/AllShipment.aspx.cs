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
using System.IO;

public partial class AllSystem_AllShipment : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();
    protected string allNo = "";
    protected string chkAllp = "";
    protected string chkLotp = "";
    protected string chkMasterp = "";
    protected string chkHousep = "";
    protected string chkInvoicep = "";
    protected string chkCtnrp = "";
    //protected string chkVoidp = "";
    protected string chkSOp = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        allNo = string.IsNullOrEmpty(Request["AllNo"]) ? "" : Request["AllNo"].ToUpper();
        chkAllp = string.IsNullOrEmpty(Request["chkAll"]) ? "" : Request["chkAll"];
        chkLotp = string.IsNullOrEmpty(Request["chkLot"]) ? "" : Request["chkLot"];
        chkMasterp = string.IsNullOrEmpty(Request["chkMaster"]) ? "" : Request["chkMaster"];
        chkHousep = string.IsNullOrEmpty(Request["chkHouse"]) ? "" : Request["chkHouse"];
        chkInvoicep = string.IsNullOrEmpty(Request["chkInvoice"]) ? "" : Request["chkInvoice"];
        chkCtnrp = string.IsNullOrEmpty(Request["chkCtnr"]) ? "" : Request["chkCtnr"];
        //chkVoidp = string.IsNullOrEmpty(Request["chkVoid"]) ? "" : Request["chkVoid"];
        chkSOp = string.IsNullOrEmpty(Request["chkSO"]) ? "" : Request["chkSO"];

        if (!IsPostBack)
        {
            chkAll.Checked = true;
            //chkLot.Checked = true;
            chkMaster.Checked = true;
            chkHouse.Checked = true;
            chkInvoice.Checked = true;
            chkCtnr.Checked = true;
            chkVoid.Checked = true;
        }

    }
    //[DirectMethod]
    //public void BindData(DataTable dt)
    //{
    //    storeList.DataSource = dt;
    //    storeList.DataBind();
    //}

    /// <summary>
    /// 初始化绑定数据以及打勾时绑定数据   未使用view缓存的方法
    /// </summary>
    /// <param name="chkAll">用于判断ALL是否已经打勾</param>
    /// <param name="chkLot"></param>
    /// <param name="chkMaster"></param>
    /// <param name="chkHouse"></param>
    /// <param name="chkInvoice"></param>
    /// <param name="chkCtnr"></param>
    //[DirectMethod]
    //public void BindData(string chkAll, string chkLot, string chkMaster, string chkHouse, string chkInvoice, string chkCtnr, string chkVoid)
    //{
    //    string sys = GetSys();
    //    //string whereStr = " LotNo like '" + allNo + "%' or Master like '" + allNo + "%' or House like '" + allNo + "%' or InvoiceNo like '" + allNo + "%' or CtnrNo like '" + allNo + "%'";
    //    string whereStr = " LotNo like '" + allNo + "%' or Master like '" + allNo + "%' ";
    //    string whereStr3 = " House like '" + allNo + "%' or InvoiceNo like '" + allNo + "%' or CtnrNo like '" + allNo + "%'";
    //    string whereStr2 = "";
    //    if (chkMaster == "chkMaster")
    //    {
    //        whereStr2 += " or Type = 'M'";
    //    }

    //    if (chkHouse == "chkHouse")
    //    {
    //        whereStr2 += " or Type = 'H'";
    //    }

    //    if (chkInvoice == "chkInvoice")
    //    {
    //        whereStr2 += " or Type = 'I'";
    //    }

    //    if (chkCtnr == "chkCtnr")
    //    {
    //        whereStr2 += " or Type = 'C'";
    //    }

    //    //if (chkVoid == "chkVoid")
    //    //{
    //    //    whereStr3 += " or Active = 0 ";
    //    //}
    //    //else
    //    //{
    //    //    whereStr3 += " or Active = 1 ";
    //    //}

    //    if (whereStr2 != "")
    //    {
    //        if (chkVoid == "chkVoid")
    //        {
    //            whereStr2 = " (1=0 " + whereStr2 + ")";
    //        }
    //        else //没有void
    //        {
    //            whereStr2 = " (1=0 " + whereStr2 + ") and Active = 1";
    //        }



    //        //StreamWriter sw = new StreamWriter(@"E:\testWhere.txt", true); //这段放1.3 4848 会报错 因为IIS 跟你 本机虚礼目录是有区别的， 这个是权限问题
    //        //sw.WriteLine("开始时间:" + DateTime.Now);
    //        //sw.WriteLine("查询条件:" + whereStr);
    //        //sw.Close();
    //        //sw.Dispose();

    //        DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllShipment_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
    //         .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
    //         .Append("SYS", sys) 
    //         .Append("WhereStr", whereStr)
    //         .Append("WhereStr2", whereStr2)
    //         .Append("WhereStr3", whereStr3)
    //    }).GetTable();

    //        if (dt == null)
    //        {
    //            X.MessageBox.Alert("Status", "loading failed.Please try later again!").Show();
    //        }
    //        else
    //        {
    //            //storeList.DataSource = dt;
    //            //storeList.DataBind();


    //            this.dview = dt.DefaultView;
    //            this.dview.RowFilter = "type = 'M'";
    //            // storeList.LoadData(this.dview, true);

    //            storeList.DataSource = this.dview;
    //            storeList.DataBind();


    //            //this.dview = dt.DefaultView;
    //            //this.dview.RowFilter = "ID<150";
    //            //storeList.LoadData(this.dview, true);

    //            //int j = 1;
    //            //for (int i = 0; i < dt.Rows.Count; i++)
    //            //{
    //            //    if (i > j * 150)
    //            //    {
    //            //        j++;
    //            //        storeList.LoadData( , true);
    //            //    }
    //            //}
    //        }
    //    }
    //    else
    //    {
    //        storeList.DataSource = "";
    //        storeList.DataBind();
    //    }
    //    X.AddScript("$('#tblChkGroup').attr('disabled', ''); $('#divLoadAllShipment').css('display', 'none'); $('#divLoadMaskAllShipment').css('display', 'none');");

    //    //sw.WriteLine("结束时间：" + DateTime.Now);
    //    //sw.Close();
    //    //sw.Dispose();
    //}

    //[DirectMethod]
    //public void BindData(string chkAll, string chkLot, string chkMaster, string chkHouse, string chkInvoice, string chkCtnr)
    //{
    //     string sys = GetSys();
    //    string whereStr = "1=0";
    //    whereStr += " or LotNo like '" + allNo + "%' or Master like '" + allNo + "%' or House like '" + allNo + "%' or InvoiceNo like '" + allNo + "%' or CtnrNo like '" + allNo + "%'";

    //    DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllShipment_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
    //         .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
    //         .Append("SYS", sys) 
    //         .Append("WhereStr", whereStr)
    //    }).GetTable();

    //    if (dt == null)
    //    {
    //        X.MessageBox.Alert("Status", "loading failed.Please try later again!").Show();
    //    }
    //    else
    //    {
    //        //storeList.DataSource = dt;
    //        //storeList.DataBind();
    //        string filterStr = "Type <> ''";
    //        this.dview = dt.DefaultView;

    //        if (chkAll == "chkAll")
    //        {
    //            this.dview.RowFilter = filterStr;
    //        }

    //        if (chkLot == "chkLot")
    //        {
    //            this.dview.RowFilter = filterStr;
    //        }

    //        if (chkMaster == "chkMaster")
    //        {
    //            filterStr += "and Type = 'M'";
    //        }

    //        if (chkHouse == "chkHouse")
    //        {
    //            filterStr += "or Type = 'H' ";
    //        }

    //        if (chkInvoice == "chkInvoice")
    //        {
    //            filterStr += "or Type = 'I' ";
    //        }

    //        if (chkCtnr == "chkCtnr")
    //        {
    //            filterStr += "or Type = 'C' ";
    //        }

    //        this.dview.RowFilter = filterStr;
    //        storeList.DataSource = this.dview;
    //        storeList.DataBind();
    //        //storeList.LoadData(this.dview, true);

    //        //int j = 1;
    //        //for (int i = 0; i < dt.Rows.Count; i++)
    //        //{
    //        //    if (i > j * 150)
    //        //    {
    //        //        j++;
    //        //        storeList.LoadData( , true);
    //        //    }
    //        //}
    //    }

    //    X.AddScript("$('#tblChkGroup').attr('disabled', ''); $('#divLoadAllShipment').css('display', 'none'); $('#divLoadMaskAllShipment').css('display', 'none');  ");

    //    //sw.WriteLine("结束时间：" + DateTime.Now);
    //    //sw.Close();
    //    //sw.Dispose();
    //}

    ///// <summary>
    ///// 初始化查询结果
    ///// </summary>
    //[DirectMethod]
    //public void BindDataByNo()
    //{
    //    string sys = GetSys();
    //    string whereStr = "";
    //    string whereStr3 ="";
    //    string whereStr2 = "";


    //    if (chkLotp == "chkLot" && chkMasterp == "chkMaster")
    //    {
    //        whereStr = " LotNo like '%" + allNo + "%' or Master like '%" + allNo + "%' ";
    //    }
    //    else if (chkLotp == "chkLot")
    //    {
    //        whereStr += " LotNo like '%" + allNo + "%'";
    //    }
    //    else if (chkMasterp == "chkMaster")
    //    {
    //        whereStr += " Master like '%" + allNo + "%'";
    //    }

    //    if (chkHousep == "chkHouse" && chkInvoicep == "chkInvoice" && chkCtnrp == "chkCtnr")
    //    {
    //        whereStr3 = " House like '%" + allNo + "%' or InvoiceNo like '%" + allNo + "%' or CtnrNo like '%" + allNo + "%'";

    //    }
    //    else if (chkHousep == "chkHouse" && chkInvoicep == "chkInvoice")
    //    {
    //        whereStr3 = " House like '%" + allNo + "%' or InvoiceNo like '%" + allNo + "%'";

    //    }
    //    else if (chkHousep == "chkHouse" && chkCtnrp == "chkCtnr")
    //    {
    //        whereStr3 = " House like '%" + allNo + "%' or CtnrNo like '%" + allNo + "%'";

    //    }
    //    else if (chkInvoicep == "chkInvoice" && chkCtnrp == "chkCtnr")
    //    {
    //        whereStr3 = " InvoiceNo like '%" + allNo + "%' or CtnrNo like '%" + allNo + "%'";

    //    }
    //    else if (chkHousep == "chkHouse")
    //    {
    //        whereStr3 = " House like '%" + allNo + "%'";

    //    }
    //    else if (chkInvoicep == "chkInvoice")
    //    {
    //        whereStr3 = " InvoiceNo like '%" + allNo + "%'";
    //    }
    //    else if (chkCtnrp == "chkCtnr")
    //    {
    //        whereStr3 = " CtnrNo like '%" + allNo + "%'";
    //    }

    //    if (chkVoidp == "chkVoid")
    //    {
    //        whereStr2 = "(1=1)";
    //    }
    //    else
    //    {
    //        whereStr2 = "(1=1) and active = 1";
    //    }

    //    if (chkAllp == "chkAll")
    //    {
    //        whereStr = " LotNo like '%" + allNo + "%' or Master like '%" + allNo + "%' ";
    //        whereStr3 = " House like '%" + allNo + "%' or InvoiceNo like '%" + allNo + "%' or CtnrNo like '%" + allNo + "%'";
    //    }

    //    if (whereStr == "")
    //    {
    //        whereStr = "1=0";
    //    }

    //    if (whereStr3 == "")
    //    {
    //        whereStr3 = "1=0";
    //    }   

    //    DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllShipment_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
    //        .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
    //        .Append("SYS", sys) 
    //        .Append("WhereStr", whereStr)
    //        .Append("WhereStr2", whereStr2)
    //        .Append("WhereStr3", whereStr3)
    //}).GetTable();

    //    if (dt == null)
    //    {
    //        X.MessageBox.Alert("Status", "loading failed.Please try later again!").Show();
    //    }
    //    else
    //    {
    //        System.Data.DataView dview = dt.DefaultView;
    //        Session["AllSystem_AllShipment_dv"] = dview;
    //        storeList.DataSource = dview;
    //        storeList.DataBind();
    //     }

    //     X.AddScript("$('#tblChkGroup').attr('disabled', ''); $('#divLoadAllShipment').css('display', 'none'); $('#divLoadMaskAllShipment').css('display', 'none');");

    //}

    /// <summary>
    /// 初始化查询结果
    /// </summary>
    [DirectMethod]
    public void BindDataByNo()
    {
        string sys = GetSys();
        string IsChkCtnr = "1";
        string IsChkInvoice = "1";
        string IsChkHouse = "1";
        string IsChkMaster = "1";
        string IsChkLot = "1";
        string IsChkVoid = "1";
        string IsChkSO = "1";

        if (chkLotp == "chkLot")
        {
            IsChkLot = "L";
        }

        if (chkMasterp == "chkMaster")
        {
            IsChkMaster = "M";
        }

        if (chkHousep == "chkHouse")
        {
            IsChkHouse = "H";
        }

        if (chkCtnrp == "chkCtnr")
        {
            IsChkCtnr = "C";
        }

        if (chkInvoicep == "chkInvoice")
        {
            IsChkInvoice = "I";
        }

        if (chkSOp == "chkSO")
        {
            IsChkSO = "S";
        }

        //if (chkVoidp == "chkVoid")
        //{
        //    IsChkVoid = "V";
        //}

        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllShipment_SP", new List<IFields>() {dal.CreateIFields().Append("Option", "List")
            .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
            .Append("SYS", sys) 
            .Append("AllNo", allNo)
            .Append("IsChkCtnr", IsChkCtnr)
            .Append("IsChkInvoice", IsChkInvoice)
            .Append("IsChkMaster", IsChkMaster)
            .Append("IsChkHouse", IsChkHouse)
            .Append("IsChkLot", IsChkLot)
            .Append("IsChkSO", IsChkSO)
            //.Append("IsChkVoid", IsChkVoid)
    }).GetList();

        if (ds == null || ds.Tables.Count < 1)
        {
            X.MessageBox.Alert("Status", "loading failed.Please try later again!").Show();
        }
        else
        {
            System.Data.DataView dview = ds.Tables[0].DefaultView;
            Session["AllSystem_AllShipment_dv"] = dview;
            storeList.DataSource = dview;
            storeList.DataBind();
        }

        X.AddScript("$('#tblChkGroup').attr('disabled', ''); $('#divLoadAllShipment').css('display', 'none'); $('#divLoadMaskAllShipment').css('display', 'none');");

    }

    /// <summary>
    /// 初始化绑定数据以及打勾时绑定数据  使用view缓存的方法
    /// </summary>
    /// <param name="chkAll">用于判断ALL是否已经打勾</param>
    /// <param name="chkLot"></param>
    /// <param name="chkMaster"></param>
    /// <param name="chkHouse"></param>
    /// <param name="chkInvoice"></param>
    /// <param name="chkCtnr"></param>
    [DirectMethod]
    public void BindData(string chkAll, string chkMaster, string chkHouse, string chkInvoice, string chkCtnr, string chkVoid)
    {
        string filterStr = "";

        System.Data.DataView dv = Session["AllSystem_AllShipment_dv"] as System.Data.DataView;

        //if (chkAll == "" && chkLot == "" && chkMaster == "" && chkHouse == "" && chkInvoice == "" && chkCtnr == "")
        //{

        //}

        if (chkAll == "chkAll")
        {
            filterStr = "";//Type <> ''
        }

        //if (chkLot == "chkLot")
        //{

        //    filterStr = "";
        //    if (chkMaster == "" && chkHouse == "" && chkInvoice == "" && chkCtnr == "")
        //    {
        //        filterStr = "or type = 'M' or type = 'H' or type = 'I' or type = 'C'";
        //    }
        //}

        if (chkMaster == "chkMaster")
        {
            filterStr += "or type = 'M'";
        }

        if (chkHouse == "chkHouse")
        {
            filterStr += "or type = 'H' ";
        }

        if (chkInvoice == "chkInvoice")
        {
            filterStr += "or type = 'I' ";
        }

        if (chkCtnr == "chkCtnr")
        {
            filterStr += "or type = 'C' ";
        }

        if (filterStr == "")
        {
            storeList.DataSource = "";
            storeList.DataBind();
            X.AddScript("$('#tblChkGroup').attr('disabled', ''); $('#divLoadAllShipment').css('display', 'none'); $('#divLoadMaskAllShipment').css('display', 'none');");
            return;
        }
        else
        {
            if (chkVoid == "chkVoid")
            {
                filterStr = filterStr.Substring(2);
            }
            else //没有void
            {
                filterStr = "(" + filterStr.Substring(2) + ") and active = ''";
            }
        }

        dv.RowFilter = filterStr;

        storeList.DataSource = dv;
        storeList.DataBind();
        X.AddScript("$('#tblChkGroup').attr('disabled', ''); $('#divLoadAllShipment').css('display', 'none'); $('#divLoadMaskAllShipment').css('display', 'none');");
    }


    private string GetSys()
    {
        string MenuList = MenuHelper.GetMenu("MenuList");  // FSecurityHelper.CurrentUserDataGET()[14]; // menu array list
        string str = "";
        string sys = "";
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_MENU_SP", new List<IFields>() { dal.CreateIFields().Append("Option", "user-get-menu")
            .Append("IDlist", MenuList)
        }).GetList();

        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            str += ds.Tables[0].Rows[i]["NameENG"].ToString() + ",";
        }

        str = str.Trim().ToUpper();

        //if (str.IndexOf("AIR EXPORT") != -1)
        //{
        //    sys += "'AE',";
        //}

        //if (str.IndexOf("AIR IMPORT") != -1)
        //{
        //    sys += "'AI',";
        //}

        //if (str.IndexOf("OCEAN EXPORT") != -1)
        //{
        //    sys += "'OE',";
        //}

        //if (str.IndexOf("OCEAN IMPORT") != -1)
        //{
        //    sys += "'OI',";
        //}

        //if (str.IndexOf("TRIANGLE") != -1)
        //{
        //    sys += "'AT','OT',";
        //}

        //if (str.IndexOf("OTHER BUSINESS") != -1)
        //{
        //    sys += "'DM','BK','TK',";
        //}

        //if (sys != "")
        //{
        //    sys = sys.Substring(0, sys.Length - 1);
        //}

        if (str.IndexOf("AIR EXPORT") != -1)
        {
            sys += "AE,";
        }

        if (str.IndexOf("AIR IMPORT") != -1)
        {
            sys += "AI,";
        }

        if (str.IndexOf("OCEAN EXPORT") != -1)
        {
            sys += "OE,";
        }

        if (str.IndexOf("OCEAN IMPORT") != -1)
        {
            sys += "OI,";
        }

        if (str.IndexOf("TRIANGLE") != -1)
        {
            sys += "AT,OT,";
        }

        if (str.IndexOf("OTHER BUSINESS") != -1)
        {
            sys += "DM,BK,TK,";
        }

        if (sys != "")
        {
            sys = sys.Substring(0, sys.Length - 1);
        }

        return sys;
    }

    protected void storeList_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        string[] arrChb = hidChbStr.Text.Split(',');
        BindData(arrChb[0], arrChb[1], arrChb[2], arrChb[3], arrChb[4], arrChb[5]);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="seed">seed</param>
    /// <param name="sys"></param>
    /// <param name="toMbl">本身这个记录对应的ToMaster字段</param>
    /// <param name="toHbl">ToHouse</param>
    /// <param name="type">类型</param>
    /// <param name="InMbl">Invoice这条记录对应的主提单MBLNO 因为INVOICE这条记录当该INVOICE是属于HBL开出来的时候那么就只有TOHOUSE会有值</param>
    [DirectMethod]
    public void ShowDetail(string seed, string sys, string toMbl, string toHbl, string type, string InMbl)//
    {

        //string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/DetailList.aspx?ID=" + id;
        //string url = "/AirImport/AIShipmentJobList/DetailList.aspx?ID=" + id;

        string url = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/"));
        string id = "";
        if (sys == "AI")
        {
            if (type == "I")
            {
                id = toMbl == "" ? InMbl : toMbl;
            }
            else
            {
                id = toMbl == "" ? seed : toMbl;
            }

            url = url.Substring(0, url.LastIndexOf("/")) + "/AirImport/AIShipmentJobList/DetailList.aspx?ID=" + id;
        }
        else if (sys == "AE")
        {
            if (type == "I")
            {
                id = toMbl == "" ? InMbl : toMbl;
            }
            else
            {
                id = toMbl == "" ? seed : toMbl;
            }

            url = url.Substring(0, url.LastIndexOf("/")) + "/AirExport/AEViewConsol/DetailList.aspx?ID=" + id;

        }
        else if (sys == "OE")
        {
            if (type == "C")
            {
                id = InMbl;
            }
            else if (type == "I")
            {
                id = toMbl == "" ? InMbl : toMbl;
                //id = InMbl;
            }
            else
            {
                id = toMbl == "" ? seed : toMbl;
            }

            url = url.Substring(0, url.LastIndexOf("/")) + "/OceanExport/OEJobList/DetailList.aspx?ID=" + id;

        }
        else if (sys == "OI")
        {
            if (type == "C")
            {
                id = InMbl;
            }
            else if (type == "I")
            {
                id = toMbl == "" ? InMbl : toMbl;
            }
            else
            {
                id = toMbl == "" ? seed : toMbl;
            }

            url = url.Substring(0, url.LastIndexOf("/")) + "/OceanImport/OceanShipmentJobList/DetailList.aspx?ID=" + id;

        }
        else if (sys == "AT")
        {
            if (type == "I")
            {
                id = toMbl;
            }
            else
            {
                id = seed;
            }

            url = url.Substring(0, url.LastIndexOf("/")) + "/Triangle/ShipmentList/DetailList.aspx?ID=" + id + "&sys=A"; ;

        }
        else if (sys == "OT")
        {
            if (type == "I")
            {
                id = toMbl;
            }
            else
            {
                id = seed;
            }


            url = url.Substring(0, url.LastIndexOf("/")) + "/Triangle/ShipmentList/DetailList.aspx?ID=" + id + "&sys=O"; ;

        }
        else if (sys == "DM" || sys == "BK" || sys == "TK")
        {
            if (type == "I")
            {
                id = toMbl;
            }
            else
            {
                id = seed;
            }

            url = url.Substring(0, url.LastIndexOf("/")) + "/OtherBusiness/ShipmentList/DetailList.aspx?ID=" + id + "&sys=" + sys; ;

        }

        X.AddScript("var win=this.parent.UserControlTop1_WinView; if(win == null || win == undefined){win= this.parent.WinView;} win.load('" + url + "');win.show();");
        //X.AddScript("var win=this.parent.WinView; win.load('" + url + "');win.show();");
       // X.AddScript("var win = new Ext.Window({id: 'WinView',title: 'View', resizable: true,draggable: true,width: 963,height: 422,modal: false,maximizable: false, padding: 5,x: 195,y: 110,bodyStyle: 'background-color:#fff;', closeAction: 'close' }); win.load('" + url + "');win.show();");
    }

}