using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Data;
using System.Text.RegularExpressions;
using System.Collections;

public partial class common_UIControls_ReportContinuousPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string email = FSecurityHelper.CurrentUserDataGET()[3];
        if (string.IsNullOrEmpty(email))
            btnPdf.Disabled = true;
    }

    DataFactory dal = new DataFactory();

   
    public string GetList()
    {
        DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_ReportPrinting", new List<IFields>() { dal.CreateIFields().
                            Append("option", "ALL").   
                            Append("Sys", Request["sysType"]).                       
                            Append("RPG_SeedTo", Request["ID"]) }).GetList();

        DataTable dt = ds.Tables[0];
        DataTable dtmf = ds.Tables[1];
        string divContent = "";
        string Manifest = "";
        for (int i = 0; i < dtmf.Rows.Count ; ++i)
        {
            if (!string.IsNullOrEmpty(dtmf.Rows[i]["print"].ToString()))
            {
                Manifest += "<tr class='tr_line'><td class='td_line'><input type='checkBox' class='chkline'/></td><td>" + dtmf.Rows[i]["no"] + "</td><td>CTNR";
                Manifest += "</td><td></td><td></td><td>" + dtmf.Rows[i]["print"] + GetContainerList(dtmf.Rows[i]["seed"], dtmf.Rows[i]["no"], "0", Request["sysType"]) + "</td></tr>";
            }
        }

        for (int i = 0; i < dt.Rows.Count; ++i)
        {
            if (string.IsNullOrEmpty(dt.Rows[i][0].ToString()))
                continue;
            string ItemStr = dt.Rows[i][0].ToString();  //  content ;
            string Hbl = string.IsNullOrEmpty(dt.Rows[i][2].ToString()) ? "" : dt.Rows[i][2].ToString();    //  tohbl;
            string toHbl = i == 0 ? "----" : dt.Rows[i - 1][2].ToString();    //  tohbl

            if (Hbl == toHbl)  //在一行
                divContent += ItemStr;
            else if (i != 0) //新建一行
                divContent += "</div><div>" + dt.Rows[i]["oe_KeyValue"].ToString() + "|" + dt.Rows[i]["oe_type"].ToString() + "|" + ItemStr;
            else
                divContent += "<div>" + dt.Rows[i]["oe_KeyValue"].ToString() + "|" + dt.Rows[i]["oe_type"].ToString() + "|" + ItemStr;
        }
        divContent += "</div>";

        Regex reg = new Regex("<div>(.*?)</div>");
        MatchCollection mc = reg.Matches(divContent);

        divContent = "<table cellpadding=\"0\" cellspacing=\"0\"><tr class='tr_header'><td class='td_line'><input type='checkBox' class='chkAll'/></td><td>No.#</td><td>Type</td><td>";
        divContent += "<input type='checkBox' class='chkMain'/>Main</td><td><input type='checkBox' class='chkInvoice'/>Invoice</td><td><input type='checkBox' class='chkOther'/>Other</td></tr>";
        divContent += Manifest;
        for (int f = 0; f < mc.Count; ++f)
        {
            divContent += "<tr  class='tr_line'><td class='td_line'><input type='checkbox' class='chkline' currindex='" + f + "'></td>";
            string[] list = mc[f].Groups[1].Value.Split(new string[] { "|" }, StringSplitOptions.None);
            ArrayList str = new ArrayList(list);

            str.Insert(3, str[str.Count - 1]);
            str.RemoveAt(str.Count - 1);

            for (int j = 0; j < str.Count; ++j)
            {
                string conStr = str[j].ToString();
                if (conStr.Contains("for=\"BLSample_"))
                {
                    string rowid = conStr.Substring(conStr.IndexOf("for=\"BLSample_") + 5, conStr.IndexOf("\">BL Sample") - conStr.IndexOf("for=\"BLSample_") - 5);
                    divContent = divContent + "<td>" + Bl(rowid) + "</td>";

                }
                else if (conStr.Contains("for=\"PaymentRequest_"))
                {
                    string rowid = conStr.Substring(conStr.IndexOf("for=\"PaymentRequest_") + 5, conStr.IndexOf("\">PaymentRequest") - conStr.IndexOf("for=\"PaymentRequest_") - 5);
                    divContent = divContent + "<td>" + Pay(rowid) + "</td>";
                }
                else if (conStr.Contains("for=\"Invoice_"))
                {
                    divContent += "<td>" + conStr + "</td>";
                }
                else if (conStr.Contains("for=\"ProfitLoss_"))
                {
                    divContent = divContent.Substring(0, divContent.Length - 5);
                    divContent += conStr + "</br></td>";
                }
                else
                {
                    divContent = divContent + "<td>" + conStr + "</br></td>";
                }
            }
            divContent += "</tr>";
        }
        divContent += "</table>";
        return divContent;
    }

    #region ///OE
    public string Bl(string rowid)
    {
        string bl = "";
        string seed = rowid.Split(new string[] { "_" }, StringSplitOptions.RemoveEmptyEntries)[1];
        DataTable dtBl = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallShipmentForOE_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                                     Append("Option","GetGroupList").
                                     Append("id",seed)}).GetTable();
        if (dtBl != null && dtBl.Rows.Count > 0)
        {
            for (int z = 0; z < dtBl.Rows.Count; ++z)
            {
                if (dtBl.Rows[z][0].ToString() == "Y")
                    bl += "<input type='checkBox' id='BLSample_" + dtBl.Rows[z][1] + "_" + seed + "' /><label for='BLSample_" + dtBl.Rows[z][1] + "_" + seed + "'>BL Sample-<span>" + dtBl.Rows[z][1] + "</span></label></br>";
                else
                    bl += "<input type='checkBox' id='BLSample_0_" + seed + "' /><label for='BLSample_0_" + seed + "'>BL Sample</label></br>";
            }
        }
        return bl;
    }

    public string Pay(string rowid)
    {
        string pay = "";
        string[] list = rowid.Split(new string[] { "_" }, StringSplitOptions.RemoveEmptyEntries);
        string seed = list[1];
        string sys = list[3];
        string type = list[2];
        DataTable dtPay = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_CallPayment_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
                                      Append("Option","GetPaymentList").
                                      Append("seed",seed).
                                      Append("Type",type).
                                      Append("Sys",sys)}).GetTable();

        if (dtPay != null && dtPay.Rows.Count > 0)
        {
            for (int z = 0; z < dtPay.Rows.Count; ++z)
            {
                if (dtPay.Rows[z][0].ToString() == "Y")
                    pay += "<input type='checkBox' id=\"PaymentRequest_" + dtPay.Rows[z][2] + "_" + dtPay.Rows[z][1].ToString().Replace("/", "-") + "_" + seed + "\" /><label for='PaymentRequest_" + dtPay.Rows[z][2] + "_" + dtPay.Rows[z][1].ToString().Replace("/", "-") + "_" + seed + "'>Payment Request-<span>" + dtPay.Rows[z][1] + "</span></label></br>";
                else
                    pay = "";
            }
        }
        return pay;
    }
    #endregion
    #region  ///OI
    public string GetContainerList(object seed ,object cnno ,string isvoid,string sys)
    {

        //string seed = context.Request["seed"];
        //string cnno = context.Request["cnno"];
        //string isvoid = context.Request["isvoid"];
        //string sys = context.Request["sys"];
        string strValue = string.Empty;
        if (sys.ToUpper() == "OI")
        {         
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_GetContainerList_SP", new System.Collections.Generic.List<IFields>() { dal.CreateIFields().
            Append("mblseed",seed).
            Append("cnno",cnno).
            Append("sys",sys).
            Append("ShowVoid",isvoid)
        }).GetTable();
            if (dt != null && dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; ++i)
                {
                    strValue += "<input type='checkBox' id='Devanning_" + dt.Rows[i]["oc_Seed"] + "' /><label for='Devanning_" + dt.Rows[i]["oc_Seed"] + "'>Devanning</label></br>";
                }
            }
        }
        return strValue;
    }
    #endregion
}