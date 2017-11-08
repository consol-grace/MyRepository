using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DIYGENS.COM.FRAMEWORK;

/// <summary>
///Reportparameters 的摘要说明
/// </summary>
public class Reportparameters
{
    public Reportparameters()
    {
    }


    object _hidInvDraft = "0";
    public Reportparameters(object hidInvDraft)
    {
        _hidInvDraft = hidInvDraft;
    }

    public string[] GetNums(string type, string flag, string printName, string[] param, string sys, System.Web.UI.Page page)
    {

        string[] nums = null;
        string rpt_Type = "";
        string rpt_Header = "";
        int pdfStatus = 1;
        sys = sys.ToUpper();
        #region /// OE
        if (sys == "OE")
        {
            if (type == "Invoice")
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/O" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = "O_Invoice";
                nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
                nums[6] = _hidInvDraft.ToString();
            }
            else if (type == "Manifest")
            {
                rpt_Type = "OE Manifest";
                rpt_Header = "CONTAINER MANIFEST";
                nums = new string[9];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = rpt_Header;
                nums[4] = param[0];
                nums[5] = rpt_Type;
                nums[6] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[7] = FSecurityHelper.CurrentUserDataGET()[15].ToString();
                nums[8] = FSecurityHelper.CurrentUserDataGET()[2].ToString();
            }
            else if (type == "HDraft" || type == "Bill")
            {
                rpt_Type = "OE HAWB";
                nums = new string[7];
                if (pdfStatus == 1 && type == "HDraft")
                {
                    pdfStatus = 0;
                    nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + "pdf.rpt");
                }
                else
                {
                    nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                }
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param.Length == 2 ? "" : param[2];
                nums[4] = param[0];
                nums[5] = rpt_Type;
                nums[6] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
            }
            else if (type == "BLSample")
            {
                nums = new string[8];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = param[1];
                nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[6] = FSecurityHelper.CurrentUserDataGET()[11].ToString();
                nums[7] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
            }

            else if (type == "ACI")
            {
                nums = new string[4];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
            }
            else if (type == "AttachList" || type == "AttachListSBS")
            {
                type = "AttachList";
                nums = new string[4];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
            }

            else if (type == "PaymentRequest")
            {
                nums = new string[9];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = "OE";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
                nums[7] = param[1].Replace("-", "/"); // stat
                nums[8] = param[2]; // currency
            }
            else if (type == "ProfitLoss")
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/ProfitAndLoss.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = "OE";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
            }
            else if (type == "ShipmentOrder")
            {
                nums = new string[4];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
            }
            else if (type == "BillForSBS")
            {
                nums = new string[5];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param.Length == 3 ? param[1] : param[0];
                nums[4] = param.Length == 3 ? param[0] : "1";
            }
            else if (type == "SBSDraft")
            {
                nums = new string[8];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param.Length == 5 ? param[3] : param[0];
                string htype = "";
                if (param.Length == 4)
                    htype = param[2];
                else if (param.Length == 5)
                    htype = param[1];
                nums[4] = htype;
                nums[5] = "OE SBS";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[7] = param.Length == 5 ? param[0] : "1";
            }
            else if (type == "OutShipment")
            {
                nums = new string[4];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
            }
            else if (type == "InWarehouse")
            {
                if (FSecurityHelper.CurrentUserDataGET()[4].ToString() == "SZX1")
                {
                    nums = new string[4];
                    nums[0] = page.Server.MapPath("~/Report/OEReportFile/SZX" + type + ".rpt");
                    nums[1] = flag;
                    nums[2] = printName;
                    nums[3] = param[0];
                }
                else
                {
                    nums = new string[4];
                    nums[0] = page.Server.MapPath("~/Report/OEReportFile/SHA" + type + ".rpt");
                    nums[1] = flag;
                    nums[2] = printName;
                    nums[3] = param[0];
                }
            }
            else if (type == "CLP")
            {
                nums = new string[5];
                nums[0] = page.Server.MapPath("~/Report/OEReportFile/CLP.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = param[1];
            }
        }
        #endregion
        #region /// OI
        else if (sys == "OI")
        {
            if (type == "Arrivial")
            {
                rpt_Type = "Arrival";
                rpt_Header = "ARRIVAL NOTICE";
                type = "Common";
            }
            else if (type == "Delivery")
            {
                rpt_Type = "Delivery";
                rpt_Header = "DELIVERY ORDER";
                type = "Common";
            }
            else if (type == "Storage")
            {
                rpt_Type = "Storage";
                rpt_Header = "FREE STORAGE NOTICE";
                type = "Common";
            }
            else if (type == "Letter")
            {
                rpt_Type = "Letter";
                rpt_Header = "LETTER OF GUARANTEE";
            }
            else if (type == "Devanning")
            {
                rpt_Header = "入口拆櫃報告(IMPORT DEVANNING REPORT)";
                rpt_Type = "Devanning";
            }
            else if (type == "Manifest")
            {
                rpt_Type = "OI Manifest";
                rpt_Header = "CONTAINER MANIFEST";
            }
            else if (type == "Attachment")
            {
                rpt_Type = "OI Attachment";
                rpt_Header = "CARRIER ATTACHMENT";
            }
            if (type == "Invoice")
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/O" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = "O_Invoice";
                nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
                nums[6] = _hidInvDraft.ToString();
            }
            else if (type == "PaymentRequest")
            {
                nums = new string[9];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = "OI";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
                nums[7] = param[1].Replace("-", "/"); // stat
                nums[8] = param[2]; // currency
            }
            else if (type == "ProfitLoss")
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/ProfitAndLoss.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = "OI";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper();
            }
            else
            {
                nums = new string[9];
                nums[0] = page.Server.MapPath("~/Report/OIReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = rpt_Header;
                nums[4] = param[0];
                nums[5] = rpt_Type;
                nums[6] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[7] = FSecurityHelper.CurrentUserDataGET()[15].ToString();
                nums[8] = FSecurityHelper.CurrentUserDataGET()[2].ToString();
            }
        }
        #endregion
        #region /// AE
        else if (sys == "AE")
        {
            if (type == "Invoice")
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/A" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = "A_Invoice";
                nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
                nums[6] = _hidInvDraft.ToString();
            }
            else if (type == "ShippingNote")
            {
                nums = new string[5];
                nums[0] = page.Server.MapPath("~/Report/AEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = param[0];
            }
            else if (type == "Manifest")
            {
                nums = new string[6];
                nums[0] = page.Server.MapPath("~/Report/AEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0]; //air_seed
                nums[4] = param[0]; //air_tomawb
                nums[5] = param[0]; //air_seed
            }
            else if (type == "Pre-Alert")
            {
                nums = new string[6];
                nums[0] = page.Server.MapPath("~/Report/AEReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0]; //air_seed
                nums[4] = param[0]; //air_tomawb
                nums[5] = param[0]; //air_seed
            }
            else if (type == "HAWB")
            {
                nums = new string[4];
                nums[0] = page.Server.MapPath("~/Report/AEReportFile/" + type + "-PROC.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
            }
            else if (type == "HAWB1")
            {
                nums = new string[4];
                nums[0] = page.Server.MapPath("~/Report/AEReportFile/" + "HAWB" + "View.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
            }
            else if (type == "MAWB")
            {
                nums = new string[4];
                nums[0] = page.Server.MapPath("~/Report/AEReportFile/" + type + "-PROC.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
            }
            else if (type == "PaymentRequest")
            {
                nums = new string[9];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = "AE";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
                nums[7] = param[1].Replace("-", "/"); // stat
                nums[8] = param[2]; // currency
            }
            else if (type == "ProfitLoss")
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/ProfitAndLoss.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = "AE";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper();
            }
            else if (type == "Draft")
            {
                nums = new string[4];
                nums[0] = page.Server.MapPath("~/Report/AEReportFile/AEHDraft.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                //nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
            }
        }
        #endregion
        #region/// AI
        else if (sys == "AI")
        {
            if (type == "PaymentRequest")
            {
                nums = new string[9];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = "AI";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
                nums[7] = param[1].Replace("-", "/"); // stat
                nums[8] = param[2]; // currency
            }
            else if (type == "ProfitLoss")
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/ProfitAndLoss.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = "AI";
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper();
            }
            else
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/A" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = "A_Invoice";
                nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
                nums[6] = _hidInvDraft.ToString();
            }
        }
        #endregion
        #region /// AT,OT,DM,TK,BK
        else if (sys == "DM" || sys == "TK" || sys == "BK" || sys == "AT" || sys == "OT")
        {
            if (type == "Invoice")
            {
                string stype = sys == "AT" ? "A" : "O";

                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/" + stype + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = stype + "_Invoice";
                nums[5] = FSecurityHelper.CurrentUserDataGET()[12].ToUpper();
                nums[6] = _hidInvDraft.ToString();
            }
            else if (type == "PaymentRequest")
            {
                nums = new string[9];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/" + type + ".rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[2];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = sys;
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString();
                nums[7] = param[1].Replace("-", "/"); // stat
                nums[8] = param[0]; // currency
            }
            else if (type == "ProfitLoss")
            {
                nums = new string[7];
                nums[0] = page.Server.MapPath("~/Report/CommonReportFile/ProfitAndLoss.rpt");
                nums[1] = flag;
                nums[2] = printName;
                nums[3] = param[0];
                nums[4] = FSecurityHelper.CurrentUserDataGET()[12].ToString();
                nums[5] = sys;
                nums[6] = FSecurityHelper.CurrentUserDataGET()[0].ToString().ToUpper();
            }
        }
        #endregion
        return nums;
    }

}

