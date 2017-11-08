using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Web;
using System.Xml;

namespace System.Net.EDI
{
    /// <summary>
    /// EDI UPDATE LOG
    /// </summary>
    public class EDILOG
    {
        public EDILOG()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        /// <summary>
        /// update edi log
        /// </summary>    
        /// <param name="ediseed"></param>
        /// <param name="stat"></param>
        /// <param name="sys"></param>
        /// <param name="seed"></param>
        /// <param name="groupid"></param>
        /// <param name="filename"></param>
        /// <param name="issent"></param>
        /// <param name="action"></param>
        /// <param name="status"></param>
        /// <param name="message"></param>
        /// <param name="user"></param>
        /// <returns></returns>
        public static string UpdateLog(string ediseed, string stat, string sys, string seed, string groupid, string filename, string issent, string action, string status, string message, string user)
        {
            string errorMsg = "";
            DataFactory dal = new DataFactory();
            try
            {
                bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_EDILog_sp", new List<IFields>() { dal.CreateIFields().
                Append("Option", "update").
                Append("el_EDISeed", ediseed).
                Append("el_STAT", stat).
                Append("el_SYS", sys).
                Append("el_Seed", seed).
                Append("el_GroupID", groupid).
                Append("el_FileName", filename).
                Append("el_IsSent", issent).
                Append("el_Action", action).
                Append("el_Status", status).
                Append("el_Message", message).
                Append("el_User", user)}).Update();

                errorMsg = "{\"code\":\"" + (b ? "200" : "500") + "\",\"msg\":\"\"}";
            }
            catch (Exception exp)
            {
                errorMsg = "{\"code\":\"500\",\"msg\":\"" + exp.Message + "\"}";
            }

            return errorMsg;
        }

        /// <summary>
        /// update edi log
        /// </summary>
        /// <param name="edi">edi entity</param>
        /// <returns></returns>
        public static string UpdateLog(EDIEntity edi)
        {
            string errorMsg = "";
            DataFactory dal = new DataFactory();
            try
            {
                if (edi != null)
                {
                    bool b = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_EDILog_sp", new List<IFields>() { dal.CreateIFields().
                                Append("Option", "update").
                                Append("el_EDISeed", edi.ediseed).
                                Append("el_STAT", edi.stat).
                                Append("el_SYS", edi.sys).
                                Append("el_Seed", edi.seed).
                                Append("el_GroupID", edi.groupid).
                                Append("el_FileName", edi.filename).
                                Append("el_IsSent", edi.issent).
                                Append("el_Action", edi.action).
                                Append("el_Status", edi.status).
                                Append("el_Message", edi.message).
                                Append("el_User", edi.user)}).Update();

                    errorMsg = "{\"code\":\"" + (b ? "200" : "500") + "\",\"msg\":\"" + dal.Message + "\"}";
                }
                else
                    errorMsg = "{\"code\":\"500\",\"msg\":\"Invalid parameter, Entity conversion failed. \"}";
            }
            catch (Exception exp)
            {
                errorMsg = "{\"code\":\"500\",\"msg\":\"" + exp.Message + "\"}";
            }

            return errorMsg;

        }

    }

    /// <summary>
    /// EDI CREATE XML FILE
    /// </summary>
    public class EDIFile
    {
        public static readonly int companyLength = 35;
        StringBuilder sb = new StringBuilder();
        DataFactory dal = new DataFactory();

        /// <summary>
        /// 保存EDI文件的基目录
        /// </summary>
        public static string EDIFilePath = @"D:\USGROUP\Web\operation-test.consol-hk.com\localhost\EDIFiles\";
        /// <summary>
        /// 保存SQL文件的远程目录
        /// </summary>
        public static string EDIRemotePath = @"\\192.168.1.3\d$\USGROUP\Web\operation-test.consol-hk.com\localhost\EDIFiles\sql\";
       // public static string EDIRemotePath = @"\\192.168.1.3\d$\USGROUP\Web\operation-test.consol-hk.com\localhost\EDIFiles\sql\";
        /// <summary>
        /// 回调地址
        /// </summary>
        public static string EDICallBackURL = "http://localhost:8585/SOA/EDI.ashx";


        /// <summary>
        /// 生成xml文件
        /// </summary>
        /// <param name="Seed">master seed id</param>
        /// <param name="GroupID">hbl group id</param>
        /// <param name="stat">stat code</param>
        /// <param name="sys">op system code</param>
        /// <param name="user">op user</param>
        /// <param name="UsageIndicator">Use “P” for production and “T” for testing</param>
        /// <returns>生成错误时返回错误消息，成功返回空</returns>    
        public string CreateFile(string Seed, string GroupID, string stat, string sys, string user, string UsageIndicator)
        {
            //DataSet ds = dal.FactoryDAL("server=.;user id=consol;password=B2e5n14-;database=USGROUP_OPERATION", "FW_SysCreaterDataEDI_sp", new List<IFields>() { dal.CreateIFields()
            DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_SysCreaterDataEDI_sp", new List<IFields>() { dal.CreateIFields()
                        .Append("Option", "list")                        
                        .Append("stat", stat)
                        .Append("sys", sys)
                        .Append("user", user)
                        .Append("seed", Seed)
                        .Append("groupid", GroupID)}).GetList();

            UsageIndicator = UsageIndicator != "P" ? "T" : "P";
            string errorMsg = "", filename = "", ediSeed = "";
            try
            {
                string flag = ds.Tables[0].Rows[0]["flag"].ToString(), winName = ds.Tables[0].Rows[0]["winName"].ToString(), msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                if (flag == "N")
                {
                    EDILOG.UpdateLog(ediSeed, stat, sys, Seed, GroupID, filename, "0", "EDIFile.CreateFile", "500", msg, user);
                    errorMsg = "{\"code\":\"500\", \"winname\":\"" + winName + "\", \"msg\":\"" + msg + "\"}";
                    return errorMsg;
                }
                sb.Remove(0, sb.Length);

                string actionType = ds.Tables[0].Rows[0]["ActionType"].ToString();
                ShippingInstructions(ds, UsageIndicator, actionType, out filename, out ediSeed);
                //string filepath = "/EDIFiles/in/" + filename + ".xml";                
                if (GroupID == "0")
                    filename = filename + "_" + ediSeed + ".xml";
                else
                    filename = filename + "-" + GroupID + "_" + ediSeed + ".xml";

                //#region 1
                //string filepath = @"\\192.168.1.3\d$\USGROUP\Web\operation-test.consol-hk.com\localhost\EDIFiles\in\";  // +filename + ".xml";
                //using (IdentityScope identi = new IdentityScope("michael", "192.168.2.1.3", "C3o15n14"))
                //{
                //    try
                //    {
                //        Directory.CreateDirectory(filepath);
                //        //using (StreamWriter sr = new StreamWriter(HttpContext.Current.Server.MapPath(filepath)))
                //        using (StreamWriter sr = new StreamWriter(filepath + filename))
                //        {
                //            string content = sb.ToString();
                //            content = ReplaceStr(content);
                //            sr.Write(content);
                //        }
                //        /// updatelog 
                //        EDILOG.UpdateLog(ediSeed, stat, sys, Seed, GroupID, filename, "0", "EDIFile.CreateFile", "200", "Successful. ", user);                        
                //        errorMsg = "{\"code\":\"200\",\"winname\":\"\", \"msg\":\"Successful. \"}";
                //    }
                //    catch (Exception exp)
                //    {
                //        EDILOG.UpdateLog(ediSeed, stat, sys, Seed, GroupID, filename, "0", "EDIFile.CreateFile", "500", exp.Message, user);
                //        errorMsg = "{\"code\":\"500\",\"winname\":\"\", \"msg\":\"XML file generation failed, file access denied.\"}";
                //    }
                //}
                //#endregion
                #region 2

                try
                {
                    string userDept = FSecurityHelper.CurrentUserDataGET()[28].ToUpper();


                    ///生成EDI文件 + 与EDI相关的文件
                    Dictionary<string, string>[] dir = new Dictionary<string, string>[2];
                    if (userDept == "IT")
                    {
                        dir[0] = new Dictionary<string, string>();
                        dir[0].Add("action", "SaveFile");
                        dir[0].Add("filename", filename);
                        dir[0].Add("filepath", EDIFilePath);
                        dir[0].Add("dir", "TEST\\in\\");
                        dir[0].Add("actionType", "BUCKUP");
                        dir[0].Add("backupDir", "TEST\\unsent\\");
                        dir[0].Add("content", ReplaceStr(sb.ToString()));

                        dir[1] = new Dictionary<string, string>();
                        dir[1].Add("action", "SaveFile");
                        dir[1].Add("filename", filename);
                        dir[1].Add("filepath", EDIFilePath);
                        dir[1].Add("dir", "TEST\\info\\");
                        dir[1].Add("content", ConvertDataTableToXml(ds.Tables[7]));
                    }
                    else
                    {
                        dir[0] = new Dictionary<string, string>();
                        dir[0].Add("action", "SaveFile");
                        dir[0].Add("filename", filename);
                        dir[0].Add("filepath", EDIFilePath);
                        dir[0].Add("dir", "in\\");
                        dir[0].Add("actionType", "BUCKUP");
                        dir[0].Add("backupDir", "unsent\\");
                        dir[0].Add("content", ReplaceStr(sb.ToString()));

                        dir[1] = new Dictionary<string, string>();
                        dir[1].Add("action", "SaveFile");
                        dir[1].Add("filename", filename);
                        dir[1].Add("filepath", EDIFilePath);
                        dir[1].Add("dir", "info\\");
                        dir[1].Add("content", ConvertDataTableToXml(ds.Tables[7]));
                    }

                    CallRequest request = new CallRequest();
                    string msgstr = request.ExecRequest(dir, EDICallBackURL);
                    if (!string.IsNullOrEmpty(msgstr))
                        throw new Exception(msgstr);

                    /// updatelog 
                    EDILOG.UpdateLog(ediSeed, stat, sys, Seed, GroupID, filename, "0", "EDIFile.CreateFile", "200", "Successful. ", user);
                    errorMsg = "{\"code\":\"200\",\"winname\":\"\", \"msg\":\"Successful. \"}";
                }
                catch (Exception exp)
                {
                    EDILOG.UpdateLog(ediSeed, stat, sys, Seed, GroupID, filename, "0", "EDIFile.CreateFile", "500", exp.Message, user);
                    errorMsg = "{\"code\":\"500\",\"winname\":\"\", \"msg\":\"XML file generation failed, file access denied.\"}";
                }
                #endregion
            }
            catch (Exception exp)
            {
                EDILOG.UpdateLog(ediSeed, stat, sys, Seed, GroupID, filename, "0", "EDIFile.CreateFile", "500", exp.Message, user);
                errorMsg = "{\"code\":\"500\",\"winname\":\"\", \"msg\":\"" + exp.Message + "\"}";
            }

            return errorMsg;
        }


        #region /// main
        /// <summary>
        /// Containers 
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        private string EquipmentInformation(DataTable dt)
        {
            if (dt != null && dt.Rows.Count > 0)
            {
                sb.Append("         <EquipmentInformation>\r\n");
                foreach (DataRow dr in dt.Rows)
                {
                    sb.Append("             <Containers>\r\n");
                    sb.Append("                 <AssociatedBookingNumber>" + dr["SONO"] + "</AssociatedBookingNumber>\r\n");  // len  0-35 
                    sb.Append("                 <ContainerType>" + dr["CTNRTYPE"] + "</ContainerType>\r\n");   // len  0-4
                    //sb.Append("                 <ContainerNumber CheckDigit=\"1\">" + dr["CTNRNO"] + "</ContainerNumber>\r\n"); // len  0-10
                    if (string.IsNullOrEmpty(dr["CTNRNO"].ToString()))
                    {
                        throw new Exception("The container number cannot be empty. ");
                    }
                    else
                    {
                        string ctnrno = dr["CTNRNO"].ToString();
                        sb.Append("                 <ContainerNumber CheckDigit=\"" + ctnrno.Substring(ctnrno.Length - 1, 1) + "\">" + ctnrno.Substring(0, ctnrno.Length - 1) + "</ContainerNumber>\r\n"); // len  0-10
                    }
                    sb.Append("                 <SealNumber Type=\"CA\">" + dr["SEALNO"] + "</SealNumber>\r\n");// len  0-15
                    sb.Append("                 <Package Type=\"" + dr["PKGTYPE"] + "\">" + dr["PACKAGE"] + "</Package>\r\n");  // len  0-8
                    sb.Append("                 <Weight Qualifier=\"GROSS\" Units=\"" + dr["G_UNITS"] + "\">" + dr["GWT"] + "</Weight>\r\n"); // len  0-12,3
                    sb.Append("                 <Volume Units=\"" + dr["V_UNITS"] + "\">" + dr["CBM"] + "</Volume>\r\n");// len  0-10,3
                    //sb.Append("                 <Remarks>-----</Remarks>\r\n");
                    //sb.Append("                 <Indicators>\r\n");
                    //sb.Append("                     <SOCIndicator>-----</SOCIndicator>\r\n");
                    //sb.Append("                     <PerishableGoods>-----</PerishableGoods>\r\n");
                    //sb.Append("                     <DangerousGoods>-----</DangerousGoods>\r\n");
                    //sb.Append("                     <PersonalEffect>-----</PersonalEffect>\r\n");
                    //sb.Append("                 </Indicators>\r\n");
                    //sb.Append("                 <TrafficMode>\r\n");
                    //sb.Append("                     <OutBound>" + dr["OUTSERMODE"] + "</OutBound>\r\n");
                    //sb.Append("                     <InBound>" + dr["INSERMODE"] + "</InBound>\r\n");
                    //sb.Append("                 </TrafficMode>\r\n");
                    //sb.Append("                 <ReeferSettings AtmosphereType=\"MG\" PreCooling=\"0\" GenSetType=\"US\" VentSettingCode=\"OTHER\" DehumidityInd=\"0\" CO2=\"10\" O2=\"10\" SensitiveCargoInd=\"0\">\r\n");
                    //sb.Append("                     <Temperature Units=\"C\">-----</Temperature>\r\n");
                    //sb.Append("                     <Ventilation Units=\"percentage\">-----</Ventilation>\r\n");
                    //sb.Append("                     <DehumidityPercentage>-----</DehumidityPercentage>\r\n");
                    //sb.Append("                 </ReeferSettings>\r\n");
                    sb.Append("             </Containers>\r\n");
                }
                sb.Append("         </EquipmentInformation>\r\n");
            }
            else
                throw new Exception("The EquipmentInformation node is invalid. ");

            return sb.ToString();
        }

        /// <summary>
        /// Cargos
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        //private string Cargoinformation(DataSet ds)
        //{
        //    DataTable dd = ds.Tables[3], dt = ds.Tables[2];

        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        sb.Append("         <CargoInformation>\r\n");
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            sb.Append("             <CargoItems>\r\n");
        //            sb.Append("                 <CargoNature>GC</CargoNature>\r\n");                //type    len 0-2
        //            sb.Append("                 <Package Type=\"" + dr["PKGTYPE"] + "\">" + dr["PACKAGE"] + "</Package>\r\n");           //PCS  len 0-8
        //            sb.Append("                 <Weight Qualifier=\"GROSS\" Units=\"" + dr["G_UNITS"] + "\">" + dr["GWT"] + "</Weight>\r\n");   //GWT    len 0-12,3
        //            sb.Append("                 <Volume Units=\"" + dr["V_UNITS"] + "\">" + dr["CBM"] + "</Volume>\r\n");            // CBM   len 0-10,3
        //            sb.Append("                 <CargoDescription>\r\n");

        //            //string[] content = dr["CARGODESC"].ToString().Replace("&amp;", "&").Split(new string[] { "{$,$}" }, StringSplitOptions.RemoveEmptyEntries);
        //            string[] content = ReplaceXMLStr(dr["CARGODESC"].ToString());
        //            foreach (string des in content)
        //            {
        //                string[] list = des.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.None);
        //                foreach (string d in list)
        //                {
        //                    string dc = d.Length > 0 ? d : " ";
        //                    sb.Append("                     <DescriptionLine><![CDATA[" + dc + "]]></DescriptionLine>\r\n");   // len  512 , 行数  1-99
        //                }
        //                // sb.Append("                     <DescriptionLine><![CDATA[" + " " + "]]></DescriptionLine>\r\n"); 
        //            }
        //            sb.Append("                 </CargoDescription>\r\n");
        //            sb.Append("                 <MarksAndNumbers>\r\n");
        //            // content = dr["CARGOMARKS"].ToString().Replace("&amp;", "&").Split(new string[] { "{$,$}" }, StringSplitOptions.RemoveEmptyEntries);
        //            content = ReplaceXMLStr(dr["CARGOMARKS"].ToString());
        //            foreach (string marks in content)
        //            {
        //                string[] list = marks.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.None);
        //                foreach (string m in list)
        //                    sb.Append("                     <MarksAndNumbersLine><![CDATA[" + m + "]]></MarksAndNumbersLine>\r\n");  // len  0-35  , 行数  1-999
        //            }
        //            sb.Append("                 </MarksAndNumbers>\r\n");
        //            int hblSeed = Convert.ToInt32(dr["hblseed"]);
        //            DataView dv = dd.DefaultView;
        //            dv.RowFilter = "hblSeed=" + hblSeed;
        //            foreach (DataRowView ddr in dv)
        //            {
        //                sb.Append("                 <CargoDetails>\r\n");
        //                sb.Append("                     <AssociatedBookingNumber>" + ddr["SONO"] + "</AssociatedBookingNumber>\r\n");   //SO    len  0-35 

        //                string ctnrno = ddr["CTNRNO"].ToString();
        //                sb.Append("                     <ContainerNumber CheckDigit=\"" + ctnrno.Substring(ctnrno.Length - 1, 1) + "\">" + ctnrno.Substring(0, ctnrno.Length - 1) + "</ContainerNumber>\r\n"); // len  0-10

        //                //sb.Append("                     <ContainerNumber CheckDigit=\"7\">" + ddr["CTNRNO"] + "</ContainerNumber>\r\n");      //CTNR NO   len  0-12 
        //                sb.Append("                     <Package Type=\"" + ddr["PKGTYPE"] + "\">" + ddr["PACKAGE"] + "</Package>\r\n");      //PKGS   len 0- 40  ,   type len 0-5 
        //                sb.Append("                     <Weight Qualifier=\"GROSS\" Units=\"" + ddr["G_UNITS"] + "\">" + ddr["GWT"] + "</Weight>\r\n");  //GWT  len 0-12,3  ;  Qualifier len 0-5
        //                sb.Append("                     <Volume Units=\"" + ddr["V_UNITS"] + "\">" + ddr["CBM"] + "</Volume>\r\n");         //CBM    len  0-10,3  ;   units  len  0-3
        //                sb.Append("                 </CargoDetails>\r\n");
        //            }
        //            sb.Append("             </CargoItems>\r\n");
        //        }
        //        sb.Append("         </CargoInformation>\r\n");
        //    }
        //    else
        //        throw new Exception("The CargoInformation node is invalid. ");

        //    return sb.ToString();
        //}

        /// <summary>
        /// 1对1的版本
        /// </summary>
        /// <param name="ds"></param>
        /// <returns></returns>
        private string Cargoinformation(DataSet ds)
        {
            //DataTable dd = ds.Tables[3], dt = ds.Tables[2];
            DataTable dct = ds.Tables[3];
            if (dct != null && dct.Rows.Count > 0)
            {
                sb.Append("         <CargoInformation>\r\n");
                foreach (DataRow dr in dct.Rows)
                {
                    sb.Append("             <CargoItems>\r\n");
                    sb.Append("                 <CargoNature>GC</CargoNature>\r\n");                //type    len 0-2
                    sb.Append("                 <Package Type=\"" + dr["PKGTYPE"] + "\">" + dr["PACKAGE"] + "</Package>\r\n");           //PCS  len 0-8
                    sb.Append("                 <Weight Qualifier=\"GROSS\" Units=\"" + dr["G_UNITS"] + "\">" + dr["GWT"] + "</Weight>\r\n");   //GWT    len 0-12,3
                    sb.Append("                 <Volume Units=\"" + dr["V_UNITS"] + "\">" + dr["CBM"] + "</Volume>\r\n");            // CBM   len 0-10,3
                    sb.Append("                 <CargoDescription>\r\n");

                    //string[] content = dr["CARGODESC"].ToString().Replace("&amp;", "&").Split(new string[] { "{$,$}" }, StringSplitOptions.RemoveEmptyEntries);
                    string[] content = ReplaceXMLStr(dr["CARGODESC"].ToString());
                    foreach (string des in content)
                    {
                        string[] list = des.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.None);
                        foreach (string d in list)
                        {
                            string dc = d.Length > 0 ? d : " ";
                            sb.Append("                     <DescriptionLine><![CDATA[" + dc + "]]></DescriptionLine>\r\n");   // len  512 , 行数  1-99
                        }
                        // sb.Append("                     <DescriptionLine><![CDATA[" + " " + "]]></DescriptionLine>\r\n"); 
                    }
                    sb.Append("                 </CargoDescription>\r\n");
                    sb.Append("                 <MarksAndNumbers>\r\n");
                    // content = dr["CARGOMARKS"].ToString().Replace("&amp;", "&").Split(new string[] { "{$,$}" }, StringSplitOptions.RemoveEmptyEntries);
                    content = ReplaceXMLStr(dr["CARGOMARKS"].ToString());
                    foreach (string marks in content)
                    {
                        string[] list = marks.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.None);
                        foreach (string m in list)
                            sb.Append("                     <MarksAndNumbersLine><![CDATA[" + m + "]]></MarksAndNumbersLine>\r\n");  // len  0-35  , 行数  1-999
                    }
                    sb.Append("                 </MarksAndNumbers>\r\n");
                    //int hblSeed = Convert.ToInt32(dr["hblseed"]);
                    //DataView dv = dd.DefaultView;
                    //dv.RowFilter = "hblSeed=" + hblSeed;

                    //foreach (DataRowView ddr in dr.DefaultView)
                    //{
                        sb.Append("                 <CargoDetails>\r\n");
                        sb.Append("                     <AssociatedBookingNumber>" + dr["SONO"] + "</AssociatedBookingNumber>\r\n");   //SO    len  0-35 

                        string ctnrno = dr["CTNRNO"].ToString();
                        sb.Append("                     <ContainerNumber CheckDigit=\"" + ctnrno.Substring(ctnrno.Length - 1, 1) + "\">" + ctnrno.Substring(0, ctnrno.Length - 1) + "</ContainerNumber>\r\n"); // len  0-10

                        //sb.Append("                     <ContainerNumber CheckDigit=\"7\">" + ddr["CTNRNO"] + "</ContainerNumber>\r\n");      //CTNR NO   len  0-12 
                        sb.Append("                     <Package Type=\"" + dr["PKGTYPE"] + "\">" + dr["PACKAGE"] + "</Package>\r\n");      //PKGS   len 0- 40  ,   type len 0-5 
                        sb.Append("                     <Weight Qualifier=\"GROSS\" Units=\"" + dr["G_UNITS"] + "\">" + dr["GWT"] + "</Weight>\r\n");  //GWT  len 0-12,3  ;  Qualifier len 0-5
                        sb.Append("                     <Volume Units=\"" + dr["V_UNITS"] + "\">" + dr["CBM"] + "</Volume>\r\n");         //CBM    len  0-10,3  ;   units  len  0-3
                        sb.Append("                 </CargoDetails>\r\n");
                    //}
                    sb.Append("             </CargoItems>\r\n");
                }
                sb.Append("         </CargoInformation>\r\n");
            }
            else
                throw new Exception("The CargoInformation node is invalid. ");

            return sb.ToString();
        }


        //-----------------------------------------------------------------------
        //private string Cargoinformation(DataSet ds)
        //{
        //    DataTable dd = ds.Tables[3], dt = ds.Tables[2];
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        sb.Append("         <CargoInformation>\r\n");
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            string[] contentDesc = ReplaceXMLStr(dr["CARGODESC"].ToString());
        //            string[] contentMarks = ReplaceXMLStr(dr["CARGOMARKS"].ToString());
        //            string[] ocSeedList = dr["oc_seedList"].ToString().Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);

        //            for (int i = 0; i < contentDesc.Length; i++)
        //            {
        //                sb.Append("             <CargoItems>\r\n");
        //                sb.Append("                 <CargoNature>GC</CargoNature>\r\n");                //type    len 0-2
        //                sb.Append("                 <Package Type=\"" + dr["PKGTYPE"] + "\">" + dr["PACKAGE"] + "</Package>\r\n");           //PCS  len 0-8
        //                sb.Append("                 <Weight Qualifier=\"GROSS\" Units=\"" + dr["G_UNITS"] + "\">" + dr["GWT"] + "</Weight>\r\n");   //GWT    len 0-12,3
        //                sb.Append("                 <Volume Units=\"" + dr["V_UNITS"] + "\">" + dr["CBM"] + "</Volume>\r\n");            // CBM   len 0-10,3
        //                sb.Append("                 <CargoDescription>\r\n");

        //                string[] listDesc = contentDesc[i].Split(new string[] { "\n", "\r\n" }, StringSplitOptions.None);
        //                foreach (string d in listDesc)
        //                {
        //                    string dc = d.Length > 0 ? d : " ";
        //                    sb.Append("                     <DescriptionLine><![CDATA[" + dc + "]]></DescriptionLine>\r\n");   // len  512 , 行数  1-99
        //                }

        //                sb.Append("                 </CargoDescription>\r\n");
        //                sb.Append("                 <MarksAndNumbers>\r\n");

        //                string[] listMarks = contentMarks[i].Split(new string[] { "\n", "\r\n" }, StringSplitOptions.None);
        //                foreach (string m in listMarks)
        //                    sb.Append("                     <MarksAndNumbersLine><![CDATA[" + m + "]]></MarksAndNumbersLine>\r\n");  // len  0-35  , 行数  1-999

        //                sb.Append("                 </MarksAndNumbers>\r\n");

        //                int ocSeed = Convert.ToInt32(ocSeedList[i]);
        //                //int hblSeed = Convert.ToInt32(dr["hblseed"]);
        //                //int ocSeed = Convert.ToInt32(dr["OCSEED"]);
        //                DataView dv = dd.DefaultView;
        //               // dv.RowFilter = "OCSEED=" + ocSeed + "AND hblseed=" + hblSeed;
        //                dv.RowFilter = "OCSEED=" + ocSeed;
        //                //dv.RowFilter = "hblSeed=" + hblSeed;
        //                foreach (DataRowView ddr in dv)
        //                {
        //                    sb.Append("                 <CargoDetails>\r\n");
        //                    sb.Append("                     <AssociatedBookingNumber>" + ddr["SONO"] + "</AssociatedBookingNumber>\r\n");   //SO    len  0-35 

        //                    string ctnrno = ddr["CTNRNO"].ToString();
        //                    sb.Append("                     <ContainerNumber CheckDigit=\"" + ctnrno.Substring(ctnrno.Length - 1, 1) + "\">" + ctnrno.Substring(0, ctnrno.Length - 1) + "</ContainerNumber>\r\n"); // len  0-10

        //                    //sb.Append("                     <ContainerNumber CheckDigit=\"7\">" + ddr["CTNRNO"] + "</ContainerNumber>\r\n");      //CTNR NO   len  0-12 
        //                    sb.Append("                     <Package Type=\"" + ddr["PKGTYPE"] + "\">" + ddr["PACKAGE"] + "</Package>\r\n");      //PKGS   len 0- 40  ,   type len 0-5 
        //                    sb.Append("                     <Weight Qualifier=\"GROSS\" Units=\"" + ddr["G_UNITS"] + "\">" + ddr["GWT"] + "</Weight>\r\n");  //GWT  len 0-12,3  ;  Qualifier len 0-5
        //                    sb.Append("                     <Volume Units=\"" + ddr["V_UNITS"] + "\">" + ddr["CBM"] + "</Volume>\r\n");         //CBM    len  0-10,3  ;   units  len  0-3
        //                    sb.Append("                 </CargoDetails>\r\n");
        //                }
        //                sb.Append("             </CargoItems>\r\n");
        //            }
        //        }
        //        sb.Append("         </CargoInformation>\r\n");
        //    }
        //    else
        //        throw new Exception("The CargoInformation node is invalid. ");

        //    return sb.ToString();
        //}

        /// <summary>
        /// SI XML
        /// </summary>
        ///<param name="ds">DataSet</param>
        /// <param name="UsageIndicator">Use “P” for production and “T” for testing</param>
        /// <param name="filename">out filename</param>
        /// <param name="ediSeed">out ediSeed</param>
        /// <returns></returns>
        public string ShippingInstructions(DataSet ds, string UsageIndicator, string ActionType, out string filename, out string ediSeed)
        {
            DataTable dt = ds.Tables[4], dc = ds.Tables[5], dtlocation = ds.Tables[6];
            ediSeed = dt.Rows[0]["EDISeed"].ToString();
            //filename = dt.Rows[0]["LOTNO"] + "_" + dt.Rows[0]["EDISeed"];
            filename = dt.Rows[0]["LOTNO"].ToString();

            if (ediSeed.Length > 6)
                throw new Exception("MessageSessionId length exceeds the maximum limit of 6 characters. ");

            sb.Append("<?xml version=\"1.0\"?>\r\n");
            sb.Append("<ShippingInstructions>\r\n");
            sb.Append(" <InterchangeControlHeader>\r\n");
            sb.Append("     <ControlNumber>" + ediSeed + "</ControlNumber>\r\n");  // len   1-10
            sb.Append("     <SenderId>CONSOLINT</SenderId>\r\n");   // len   1-15
            sb.Append("     <ReceiverId>CARGOSMART</ReceiverId>\r\n");  // len   1-15
            sb.Append("     <DateTime>" + DateTime.Now.ToString("yyyyMMddHHmmss") + "</DateTime>\r\n"); // len   1-14
            sb.Append("     <ControlVersion>00401</ControlVersion>\r\n"); // len   1-5
            sb.Append("     <UsageIndicator>" + UsageIndicator + "</UsageIndicator>\r\n"); // len   1-1
            sb.Append("     <MessageSessionId>" + ediSeed + "</MessageSessionId>\r\n");  // len   1-6
            sb.Append(" </InterchangeControlHeader>\r\n");
            sb.Append(" <SIBillOfLading>\r\n");
            sb.Append("     <GeneralInfo>\r\n");
            sb.Append("         <TransactionInfo>\r\n");
            sb.Append("             <BatchNumber>" + ediSeed + "</BatchNumber>\r\n"); // len   1-14
            sb.Append("             <MessageSender>CONSOLINT</MessageSender>\r\n");
            sb.Append("             <MessageRecipient>CARGOSMART</MessageRecipient>\r\n");
            sb.Append("             <MessageID>SIXML</MessageID>\r\n");
            sb.Append("             <DateCreated TimeZone=\"HKT\">" + DateTime.Now.ToString("yyyyMMddHHmmss") + "</DateCreated>\r\n");
            sb.Append("             <DataSource>0</DataSource>\r\n");  // len   0-8
            sb.Append("             <Version>1</Version>\r\n");// len   1-7
            sb.Append("         </TransactionInfo>\r\n");
            sb.Append("         <ActionType>" + ActionType + "</ActionType>\r\n");  // len   1-3
            string[] hblList = dt.Rows[0]["SONO"].ToString().Split(new string[] { "{$,$}" }, StringSplitOptions.RemoveEmptyEntries);

            //sb.Append("         <BLNumber>" + (hblList.Length > 0 ? dt.Rows[0]["SONO"].ToString().Split(new string[] { "{$,$}" }, StringSplitOptions.RemoveEmptyEntries)[0] : "") + "</BLNumber>\r\n");
            //sb.Append("         <BLNumber></BLNumber>\r\n");
            sb.Append("         <SIReferenceNumber>" + dt.Rows[0]["SINumber"] + "</SIReferenceNumber>\r\n"); // len   1-30
            sb.Append("         <SCAC>OOLU</SCAC>\r\n");
            sb.Append("         <OwnedBy>CONSOLINT</OwnedBy>\r\n");
            sb.Append("     </GeneralInfo>\r\n");
            sb.Append("     <BLDetails>\r\n");
            sb.Append("         <BookingInfo>\r\n");

            string strTemp = "";
            foreach (string hbl in hblList)
            {
                if (strTemp == hbl)
                    break;
                sb.Append("             <BookingNumber>" + hbl + "</BookingNumber>\r\n"); // len   1-35
                strTemp = hbl;
            }
            sb.Append("         </BookingInfo>\r\n");
            if (!string.IsNullOrEmpty(dt.Rows[0]["HBL"].ToString() + dt.Rows[0]["BKNO"].ToString() + dt.Rows[0]["SONO"].ToString()))
            {
                sb.Append("         <UserReferences>\r\n");
                string[] refType = { "CR", "BM", "BN", "SI", "CT" };
                string[] fields = { "SINumber", "SONO", "SONO", "SINumber", "CT" };
                for (int i = 0; i < refType.Length; ++i)
                {
                    strTemp = "";
                    string[] strList = dt.Rows[0][fields[i]].ToString().Split(new string[] { "{$,$}" }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (string str in strList)
                    {
                        if (str == strTemp)
                            break;
                        sb.Append("             <References>\r\n");
                        sb.Append("                 <ReferenceNumber>" + str + "</ReferenceNumber>\r\n");  // len   1-35
                        sb.Append("                 <ReferenceType>" + refType[i] + "</ReferenceType>\r\n");  // len   1-5
                        sb.Append("             </References>\r\n");
                        strTemp = str;
                    }
                }
                sb.Append("         </UserReferences>\r\n");
            }
            sb.Append("         <LegalParties>\r\n");

            foreach (DataRow dr in dc.Rows)
            {
                ArrayList list = subSpace(dr["co_Name"].ToString(), (dr["co_Address1"].ToString() + " " + dr["co_Address2"].ToString() + " " + dr["co_Address3"].ToString() + " " + dr["co_Address4"].ToString()), companyLength);

                sb.Append("             <Party>\r\n");
                sb.Append("                 <PartyType>" + dr["co_type"] + "</PartyType>\r\n"); // len   1-2

                if (list != null && list.Count > 0)
                    sb.Append("                 <PartyName><![CDATA[" + list[0] + "]]></PartyName>\r\n");  // len   0-35
                else
                    throw new Exception("Company type : " + GetCompanyType(dr["co_type"].ToString()) + " , The company name cannot be empty. ");

                //sb.Append("                 <CarrierCustomerCode>-----</CarrierCustomerCode>\r\n");
                if (list.Count > 1)
                {
                    sb.Append("                 <PartyLocation>\r\n");
                    sb.Append("                     <Address>\r\n");
                    for (int i = 1; i < list.Count && i < 4; ++i)
                    {
                        if (!string.IsNullOrEmpty(list[i].ToString()))
                        {
                            sb.Append("                         <AddressLines><![CDATA[" + list[i] + "]]></AddressLines>\r\n"); // len   0-35
                        }
                    }
                    sb.Append("                     </Address>\r\n");
                    //sb.Append("                     <Street>-----</Street>\r\n");
                    sb.Append("                 </PartyLocation>\r\n");
                }
                sb.Append("             </Party>\r\n");
            }


            sb.Append("         </LegalParties>\r\n");

            if (string.IsNullOrEmpty(dt.Rows[0]["BL_VESSEL"].ToString()))
                throw new Exception("The vessel name cannot be empty. ");

            if (string.IsNullOrEmpty(dt.Rows[0]["BL_VOYAGE"].ToString()))
                throw new Exception("The voyage number cannot be empty. ");

            sb.Append("         <RouteInformation>\r\n");
            sb.Append("             <VesselVoyageInformation>\r\n");
            sb.Append("                 <VoyageNumberDirection>" + dt.Rows[0]["BL_VOYAGE"] + "</VoyageNumberDirection>\r\n");  // len  0-22
            sb.Append("                 <VesselInformation>\r\n");
            sb.Append("                     <VesselName>" + dt.Rows[0]["BL_VESSEL"] + "</VesselName>\r\n");   // len  0-30
            sb.Append("                 </VesselInformation>\r\n");
            sb.Append("                 <External>\r\n");
            sb.Append("                     <VoyageNumber>" + dt.Rows[0]["BL_VOYAGE"] + "</VoyageNumber>\r\n");  // len  0-17
            sb.Append("                 </External>\r\n");
            sb.Append("                 <VesselVoyageText>" + dt.Rows[0]["BL_VESSEL"] + " / " + dt.Rows[0]["BL_VOYAGE"] + "</VesselVoyageText>\r\n");  // len 1-50
            sb.Append("                 <TrafficMode>\r\n");
            sb.Append("                     <OutBound>" + dt.Rows[0]["OUTSERMODE"] + "</OutBound>\r\n");// len  0-3
            sb.Append("                     <InBound>" + dt.Rows[0]["INSERMODE"] + "</InBound>\r\n");// len  0-3
            sb.Append("                 </TrafficMode>\r\n");
            sb.Append("                 <Haulage>Pier-to-Pier</Haulage>\r\n");
            sb.Append("             </VesselVoyageInformation>\r\n");


            foreach (DataRow drlocation in dtlocation.Rows)
            {
                if (drlocation["loc_unlcode"].ToString().Trim().Length != 5 && drlocation["loc_unlcode"].ToString().Trim().Length != 0)
                    throw new Exception("Location length must be 3 characters. The relevant code '" + drlocation["loc_Code"] + "'. ");

                sb.Append("             <Location>\r\n");
                sb.Append("                 <FunctionCode>" + drlocation["loc_type"] + "</FunctionCode>\r\n");  // len  1-5
                sb.Append("                 <LocationName>" + drlocation["loc_Name"] + "</LocationName>\r\n");  // len  0-35
                sb.Append("                 <LocationDetails>\r\n");
                sb.Append("                     <LocationCode>\r\n");
                sb.Append("                         <UNLocationCode>" + drlocation["loc_unlcode"] + "</UNLocationCode>\r\n");  // len  0-5
                sb.Append("                     </LocationCode>\r\n");
                sb.Append("                 </LocationDetails>\r\n");
                sb.Append("             </Location>\r\n");
            }

            //sb.Append("             <Location>\r\n");
            //sb.Append("                 <FunctionCode>POL</FunctionCode>\r\n");
            //sb.Append("                 <LocationName>" + dt.Rows[0]["BL_POL"] + "</LocationName>\r\n");
            //sb.Append("                 <LocationDetails>\r\n");
            ////sb.Append("                     <Address>\r\n");
            ////sb.Append("                         <AddressLines>-----</AddressLines>\r\n");
            ////sb.Append("                     </Address>\r\n");
            ////sb.Append("                     <Street>------</Street>\r\n");
            //sb.Append("                     <LocationCode>\r\n");
            //sb.Append("                         <UNLocationCode>" + dt.Rows[0]["BL_POLCODE"] + "</UNLocationCode>\r\n");
            //sb.Append("                     </LocationCode>\r\n");
            //sb.Append("                 </LocationDetails>\r\n");
            //sb.Append("             </Location>\r\n");
            //sb.Append("             <Location>\r\n");
            //sb.Append("                 <FunctionCode>POD</FunctionCode>\r\n");
            //sb.Append("                 <LocationName>" + dt.Rows[0]["BL_POD"] + "</LocationName>\r\n");
            //sb.Append("                 <LocationDetails>\r\n");
            ////sb.Append("                     <Address>\r\n");
            ////sb.Append("                         <AddressLines>-----</AddressLines>\r\n");
            ////sb.Append("                     </Address>\r\n");
            ////sb.Append("                     <Street>-----</Street>\r\n");
            //sb.Append("                     <LocationCode>\r\n");
            //sb.Append("                         <UNLocationCode>" + dt.Rows[0]["BL_PODCODE"] + "</UNLocationCode>\r\n");
            //sb.Append("                     </LocationCode>\r\n");
            //sb.Append("                 </LocationDetails>\r\n");
            //sb.Append("             </Location>\r\n");
            sb.Append("         </RouteInformation>\r\n");

            EquipmentInformation(ds.Tables[1]);
            Cargoinformation(ds);

            sb.Append("     </BLDetails>\r\n");
            sb.Append("     <SummaryDetails>\r\n");
            sb.Append("         <BLInformation BLType=\"SWB\" FreightType=\"" + GetFreightType(dt.Rows[0]["BL_PAYMODE"].ToString(), "bltype") + "\">\r\n");

            strTemp = "";

            foreach (string hbl in hblList)
            {
                if (strTemp.Contains(hbl))
                    break;
                strTemp += hbl + ",";
            }
            strTemp = strTemp.Length > 0 ? strTemp.Substring(0, strTemp.Length - 1) : "";

            sb.Append("             <BLNumber>" + (hblList.Length > 0 ? hblList[0] : "") + "</BLNumber>\r\n");  // len  0-35
            //sb.Append("             <BLNumber>" + strTemp + "</BLNumber>\r\n");
            sb.Append("             <OriginalBL>\r\n");
            sb.Append("                 <ModeOfTransmission>EDI</ModeOfTransmission>\r\n");
            sb.Append("             </OriginalBL>\r\n");
            sb.Append("             <PaymentStatus>" + GetFreightType(dt.Rows[0]["BL_PAYMODE"].ToString(), "value") + "</PaymentStatus>\r\n"); // len  0-10
            //sb.Append("             <BLCargoDescription>-----</BLCargoDescription>\r\n");

            string remark = dt.Rows[0]["REMARK"].ToString();
            ArrayList lines = Removelines(remark.Split(new string[] { "\r\n", "\r", "\n" }, StringSplitOptions.None));
            if (lines.Count > 0)
            {
                sb.Append("             <Remarks>\r\n");
                foreach (string l in lines)
                    sb.Append("                 <RemarksLines><![CDATA[" + (string.IsNullOrEmpty(l) ? " " : l) + "]]></RemarksLines>\r\n");
                sb.Append("             </Remarks>\r\n");
            }
            //sb.Append("             <SIDistribution>\r\n");
            //sb.Append("                 <SIBillOfLadingDistribution DocType=\"SWB\" FreightType=\"" + GetFreightType(dt.Rows[0]["BL_PAYMODE"].ToString(), "") + "\">\r\n");
            ////sb.Append("                     <PartyRole>-----</PartyRole>\r\n");
            //sb.Append("                     <NumberOfCopies>3</NumberOfCopies>\r\n");
            //sb.Append("                 </SIBillOfLadingDistribution>\r\n");
            //sb.Append("             </SIDistribution>\r\n");
            sb.Append("         </BLInformation>\r\n");

            //sb.Append("         <Certifications>\r\n");
            //sb.Append("             <CertificationClauseText Code=\"20\">-----</CertificationClauseText>\r\n");
            //sb.Append("         </Certifications>\r\n");
            //sb.Append("         <Charges>\r\n");
            //sb.Append("             NO SAMPLE\r\n");
            //sb.Append("         </Charges>\r\n");

            if (string.IsNullOrEmpty(dt.Rows[0]["BLCOUNT"].ToString()))
                throw new Exception("No. of original B/L cannot be empty. ");

            sb.Append("         <PaperWork>\r\n");
            sb.Append("             <RequestedDocuments DocumentType=\"SWB\" FreightType=\"" + GetFreightType(dt.Rows[0]["BL_PAYMODE"].ToString(), "") + "\">\r\n");
            sb.Append("                 <NoOfCopies>" + dt.Rows[0]["BLCOUNT"] + "</NoOfCopies>\r\n");
            sb.Append("                 <ModeOfTransmission>EDI</ModeOfTransmission>\r\n");
            sb.Append("             </RequestedDocuments>\r\n");
            sb.Append("         </PaperWork>\r\n");
            sb.Append("     </SummaryDetails>\r\n");
            sb.Append(" </SIBillOfLading>\r\n");
            sb.Append("</ShippingInstructions>\r\n");

            return sb.ToString();
        }
        #endregion

        #region /// other
        private string GetFreightType(string value, string type)
        {
            value = value.ToUpper().Trim();
            if (value == "PP")
            {
                value = "FreightPrepaid";
                if (type == "value")
                    value = "Prepaid";
                else if (type == "bltype")
                    value = "FreightedPrepaid";
            }
            else if (value == "CC")
            {
                value = "FreightCollect";
                if (type == "value")
                    value = "Collect";
                else if (type == "bltype")
                    value = "FreightedCollect";
            }
            else
            {
                value = "NonFreighted";
                if (type == "value")
                    value = "";
            }
            return value;
        }

        /// <summary>
        /// 截取长度35 保留完整单词
        /// </summary>
        /// <returns></returns>
        private ArrayList subSpace(string companyName, string address, int length)
        {
            companyName = companyName.ToUpper();
            address = address.ToUpper();

            ArrayList list = new ArrayList();
            string[] str = null;
            string valueLine = "";

            if (string.IsNullOrEmpty(companyName))
                return list;

            if (companyName.Length <= length)
            {
                list.Add(companyName);
                str = address.Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries);
            }
            else
                str = (companyName + " " + address).Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string v in str)
            {
                if ((valueLine + " " + v).Length > length)
                {
                    list.Add(valueLine.Substring(0, valueLine.Length - 1));
                    valueLine = "";
                }

                valueLine += v + " ";
            }
            if (valueLine.Trim() != "")
                list.Add(valueLine.Substring(0, valueLine.Length - 1));

            return list;
        }


        /// <summary>
        /// 截取字符
        /// </summary>
        private string SubString(string text, int len)
        {
            text = text.Trim().ToUpper();
            if (text.Length > len)
                text = text.Substring(0, len);
            return text;
        }

        /// <summary>
        /// 清除数组最后的空行
        /// </summary>
        /// <param name="values"></param>
        /// <returns></returns>
        private ArrayList Removelines(string[] values)
        {
            ArrayList list = new ArrayList(values);

            for (int i = list.Count - 1; i >= 0; --i)
            {
                if (string.IsNullOrEmpty(list[i].ToString()))
                    list.RemoveAt(i);
                else
                    break;
            }
            return list;
        }


        private string GetCompanyType(string Typecode)
        {
            string strType = "";
            if (Typecode == "CA")
                strType = "Carrier";
            else if (Typecode == "SH")
                strType = "Shipper";
            else if (Typecode == "CN")
                strType = "Consignee";
            else if (Typecode == "N1")
                strType = "Notify";
            return strType;
        }

        /// <summary>
        ///  DataTable 转换成 XML字符串
        /// </summary>
        /// <param name="dt">DataTable</param>
        /// <returns></returns>
        public string ConvertDataTableToXml(DataTable dt)
        {
            StringBuilder strXml = new StringBuilder();
            strXml.AppendLine("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                strXml.AppendLine("<Information>");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    strXml.AppendLine("<" + dt.Columns[j].ColumnName + ">" + dt.Rows[i][j] + "</" + dt.Columns[j].ColumnName + ">");
                }
                strXml.AppendLine("</Information>");
            }
            return strXml.ToString();
        }

        #endregion


        /// <summary>
        /// 创建文件夹
        /// </summary>
        /// <param name="path">路径</param>
        public static void CreateDirecoty(string path)
        {
            string basePath = "";
            string[] Dirlist = path.Split(new string[] { "/" }, StringSplitOptions.RemoveEmptyEntries);

            for (int i = 0; i < Dirlist.Length - 1; ++i)
            {
                basePath += "/" + Dirlist[i];
                if (!Directory.Exists(HttpContext.Current.Server.MapPath("/" + basePath)))
                    Directory.CreateDirectory((HttpContext.Current.Server.MapPath("/" + basePath)));
            }

        }



        /// <summary>
        /// 特殊字符串替换
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string ReplaceStr(string value)
        {
            string[] oldstr = { "，", "。", "？", "！", "—", "-", "‘", "’", "“", "”", "；", "：", "（", "）", "｛", "｝", "【", "】", "%", "％", "&" };
            string[] newstr = { ",", ".", "?", "!", "_", "-", "'", "'", "\"", "\"", ";", ":", "(", ")", "{", "}", "[", "]", "%", "%","&" };

            //string[] oldstr = { "，", "。", "？", "！", "—", "-", "‘", "’", "“", "”", "；", "：", "（", "）", "｛", "｝", "【", "】"};
            //string[] newstr = { ",", ".", "?", "!", "_", "-", "'", "'", "\"", "\"", ";", ":", "(", ")", "{", "}", "[", "]"};
            for (int i = 0; i < oldstr.Length; ++i)
                value = value.Replace(oldstr[i], newstr[i]);

            return value;
        }

        /// <summary>
        /// 替换转义字符并且分割返回数组
        /// </summary>
        /// <returns></returns>
        public static string[] ReplaceXMLStr(string value)
        {
            string[] oldstr = { "&amp;", "&lt;", "&gt;", "&quot;", "&nbsp;" };
            string[] newstr = { "&", "<", ">", "'", " " };

            for (int i = 0; i < oldstr.Length; ++i)
                value = value.Replace(oldstr[i], newstr[i]);

            string[] content = value.Split(new string[] { "{$,$}" }, StringSplitOptions.RemoveEmptyEntries);
            return content;
        }


        /// <summary>
        /// 获取SQL文件，并且执行！
        /// </summary>
        public static void ExecSQL()
        {
            string filepath = EDIRemotePath;
            //using (IdentityScope identi = new IdentityScope("michael", "192.168.1.3", "C3o15n14"))
            using (IdentityScope identi = new IdentityScope("michael", "192.168.1.3", "C3o15n14"))
            {
                string _filename = "", _lotno = ""; //不带后缀的文件名 ;  Lotno
                List<string> toMail = new List<string>() { "245135336@qq.com" };  //收件人地址(管理员邮箱) 
                // EmailFrom ef = EmailFrom.GetEmailFrom(); //获取发件信息
                List<EmailFrom> efList = EmailFrom.Instance.GetEmailFromList().OrderBy(p => p.status).ToList();
                EmailFrom ef = (efList.Count > 0) ? efList[0] : null;
                try
                {
                    Directory.CreateDirectory(filepath); //通过创建文件夹, 检查是否有权限, 否则异常                    
                    using (SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings))
                    {
                        if (con.State == ConnectionState.Closed) con.Open();
                        SqlCommand cmd = new SqlCommand("select case when isnull(cfg_Value,'')='' then 'CON/HKG' else cfg_Value end as stat from cs_SystemString where cfg_Code='STATION'  and cfg_type='STATION'", con);
                        string stat = cmd.ExecuteScalar().ToString().Substring(4, 3);

                        var files = Directory.GetFiles(filepath, stat + "*.sql").OrderBy(p => new FileInfo(p).CreationTime).ToList();
                        foreach (var f in files)
                        {
                            _filename = Path.GetFileNameWithoutExtension(f);
                            _lotno = string.IsNullOrEmpty(_filename) ? "" : _filename.Substring(0, 12);

                            cmd = new SqlCommand("select Email from FW_USER , cs_EDI_Log where UserName = el_User and (el_FileName like '" + _filename + "%') and el_IsSent =0", con);
                            string usermail = cmd.ExecuteScalar() == null ? "" : cmd.ExecuteScalar().ToString();
                            toMail.Add(usermail);  //添加对应的op邮箱

                            string _oldpath = filepath + "old\\";
                            if (!Directory.Exists(_oldpath)) Directory.CreateDirectory(_oldpath);

                            string sql = File.ReadAllText(f);
                            cmd = new SqlCommand(sql, con);
                            if (cmd.ExecuteNonQuery() > 0)  //执行成功，备份源文件
                            {
                                Log("FilePath: " + f + " ; Message: Successful. ");
                                if (File.Exists(_oldpath + Path.GetFileName(f)))
                                    File.Move(f, _oldpath + Path.GetFileNameWithoutExtension(f) + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".sql");
                                else
                                    File.Move(f, _oldpath + Path.GetFileName(f));
                            }
                            else //执行失败
                            {
                                //对比文件时间差 间隔30分钟 ，在范围内，修改文件的修改时间 ; 否则 通知用户
                                if (Math.Abs((File.GetCreationTime(f) - File.GetLastWriteTime(f)).TotalSeconds) < 1800)
                                    File.SetLastWriteTime(f, DateTime.Now);
                                else
                                {
                                    //通知用户,执行失败 ; 备份源文件
                                    Log("FilePath: " + f + " ; Message: SQL file execution failed. ");
                                    if (File.Exists(_oldpath + Path.GetFileName(f)))
                                        File.Move(f, _oldpath + Path.GetFileNameWithoutExtension(f) + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".sql");
                                    else
                                        File.Move(f, _oldpath + Path.GetFileName(f));
                                    MailHelper.sendMail("EDI-OOCL: LotNo# " + _lotno + ", SQL file execution failed. ", "<font color=\"red\" size=\"1\">The mail sent by system, please do not reply.</font>", ef.nickName, toMail, ef.IP, new List<string>() { }, ef.userName, ef.pwd, ef.ssl, ef.Port);
                                }
                            }
                        }
                    }
                }
                catch (Exception exp)
                {
                    Log(exp.Message + "\r\n           " + exp.StackTrace.Replace("\r\n ", "\r\n            "));
                    _lotno = string.IsNullOrEmpty(_lotno) ? "" : "LotNo# " + _lotno + ", ";
                    MailHelper.sendMail("EDI-OOCL: " + _lotno + exp.Message, "<font color=\"red\" size=\"1\">The mail sent by system, please do not reply.</font>", ef.nickName, toMail, ef.IP, new List<string>() { }, ef.userName, ef.pwd, ef.ssl, ef.Port);
                }
            }
        }

        /// <summary>
        /// 跟execsql 功能是一样的
        ///只不过这个之前是用 调用ashx 的形式来用 后面把这个方法取消了
        /// </summary>
        /// <param name="context"></param>
        public static void GetRemoteSQL(HttpContext context)
        {
            string stat = context.Request["stat"]; //  stat
            string status = context.Request["status"]; //  status
            string filepath = context.Request["filepath"]; //  status

            string _filename = "", _lotno = "", json = ""; //不带后缀的文件名 ;  Lotno; json ;       

            var files = Directory.GetFiles(filepath, stat + "*.sql").OrderBy(p => new FileInfo(p).CreationTime).ToList();  //是否存在本站sql文件
            if (files.Count > 0)
            {
                try
                {
                    _filename = Path.GetFileName(files[0]);
                    _lotno = string.IsNullOrEmpty(_filename) ? "" : _filename.Substring(0, 12);

                    string sql = File.ReadAllText(files[0]);
                    json = "{\"filename\": " + _filename + ",\"lotno\": " + _lotno + ",\"sql\":" + sql + "}";

                    string _oldpath = filepath + "old\\";
                    if (!Directory.Exists(_oldpath)) Directory.CreateDirectory(_oldpath);

                    if (File.Exists(_oldpath + Path.GetFileName(files[0])))
                        File.Move(files[0], _oldpath + Path.GetFileNameWithoutExtension(files[0]) + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".sql");
                    else
                        File.Move(files[0], _oldpath + Path.GetFileName(files[0]));
                }
                catch (Exception exp)
                {
                    json = "";
                    Log("FilePath: " + files[0] + " ; Message: "+exp.Message);
                }
            }
            context.Response.Write(json);
        }

        public static void Exec()
        {
            //CallRequest call = new CallRequest();
            //call.ExecRequest()
        }

        //private static Thread thread = null;
        ///// <summary>
        ///// 开启线程，执行ExecSQL
        ///// </summary>
        //public static void Start()
        //{
        //    try
        //    {
        //        ///线程为空，或者终止状态，重新启动
        //        if (thread == null || thread.ThreadState == ThreadState.Stopped)
        //        {
        //            thread = new Thread(ExecSQL);
        //            thread.Start();
        //        }
        //    }
        //    catch (Exception exp)
        //    {
        //        Log(exp.Message + "\r\n           " + exp.StackTrace.Replace("\r\n ", "\r\n            "));
        //    }
        //}

        /// <summary>
        /// 写入日志
        /// </summary>
        /// <param name="msg">日志内容</param>
        public static void Log(string msg)
        {
            string path = AppDomain.CurrentDomain.BaseDirectory + "AppLogs\\";
            if (!Directory.Exists(path)) Directory.CreateDirectory(path);
            StreamWriter sr = File.AppendText(path + "_ExecSQL_" + DateTime.Now.ToString("yyyyMMdd") + ".txt");
            sr.WriteLine("【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "】" + msg + "\r\n");
            sr.Close();
            sr.Dispose();
        }
    }

    /// <summary>
    /// 用户信息
    /// </summary>
    public class UserInfo
    {
        public static string GetUserInfo(string value)
        {
            DataFactory dal = new DataFactory();
            string userinfo = "";
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_EDILog_sp", new List<IFields>() { dal.CreateIFields()
                        .Append("Option", "UserInfo")                        
                        .Append("el_FileName", value)}).GetTable();
            if (dt != null && dt.Rows.Count > 0)
                userinfo = dt.Rows[0][0].ToString();
            return userinfo;
        }
    }

    /// <summary>
    /// EDI ENTITY
    /// </summary>
    public class EDIEntity
    {
        public string ediseed { get; set; }
        public string stat { get; set; }
        public string sys { get; set; }
        public string seed { get; set; }
        public string groupid { get; set; }
        public string filename { get; set; }
        public string issent { get; set; }
        public string action { get; set; }
        public string status { get; set; }
        public string message { get; set; }
        public string user { get; set; }
    }

    /// <summary>
    /// EDI MESSAGE ENTITY
    /// </summary>
    public class EDIMessageEntity
    {
        public string code { get; set; }
        public string msg { get; set; }
    }

    /// <summary>
    /// EDI ENTITY Serialize
    /// </summary>
    public class EDIDateConvert<T>
    {

        public static string SerializeJSON(T edi)
        {
            try
            {
                return Newtonsoft.Json.JsonConvert.SerializeObject(edi);
            }
            catch
            {
                return "";
            }
        }


        public static T DeserializeJSON(string json)
        {
            try
            {
                return Newtonsoft.Json.JsonConvert.DeserializeObject<T>(json);
            }
            catch
            {
                return default(T);
            }

        }
    }

    public class CallRequest
    {
        /// <summary>
        /// 执行远程请求
        /// </summary>
        /// <returns></returns>
        /// <param name="dirData">需要提交远程请求的参数项</param>
        public string ExecRequest(Dictionary<string, string>[] dirData, string url)
        {
            try
            {
                string _postData = "", content = "";
                foreach (Dictionary<string, string> dir in dirData)
                {
                    _postData = "";
                    foreach (KeyValuePair<string, string> o in dir)
                    {
                        _postData += o.Key + "=" + HttpUtility.UrlEncode(o.Value) + "&";
                    }
                    _postData = _postData == "" ? _postData : _postData.Substring(0, _postData.Length - 1);
                    byte[] postData = Encoding.UTF8.GetBytes(_postData);

                    HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                    Encoding myEncoding = Encoding.UTF8;
                    request.Method = "POST";
                    request.KeepAlive = false;
                    request.AllowAutoRedirect = true;
                    request.ContentType = "application/x-www-form-urlencoded";
                    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR  3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)";
                    request.ContentLength = postData.Length;

                    System.IO.Stream outputStream = request.GetRequestStream();
                    outputStream.Write(postData, 0, postData.Length);
                    outputStream.Close();

                    HttpWebResponse response = request.GetResponse() as HttpWebResponse;
                    Stream stream = response.GetResponseStream();
                    StreamReader sr = new StreamReader(stream);
                    content += sr.ReadToEnd();
                    sr.Close();
                    sr.Dispose();
                }
                return content;
            }
            catch (Exception exp)
            {
                return exp.Message;
            }

        }

    }
}

/// <summary>
/// 登录共享
/// </summary>
public class IdentityScope : IDisposable
{
    // obtains user token
    [DllImport("advapi32.dll", SetLastError = true)]
    static extern bool LogonUser(string pszUsername, string pszDomain, string pszPassword, int dwLogonType, int dwLogonProvider, ref IntPtr phToken);
    // closes open handes returned by LogonUser
    [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
    extern static bool CloseHandle(IntPtr handle);

    [DllImport("Advapi32.DLL")]
    static extern bool ImpersonateLoggedOnUser(IntPtr hToken);
    [DllImport("Advapi32.DLL")]
    static extern bool RevertToSelf();
    const int LOGON32_PROVIDER_DEFAULT = 0;
    const int LOGON32_LOGON_NEWCREDENTIALS = 9;//域ò控?中D的?需è要a用?:Interactive = 2
    private bool disposed;
    /// <summary>
    /// 登录
    /// </summary>
    /// <param name="sUsername">用户名</param>
    /// <param name="sDomain">域名,如果不在域中就使用机器IP地址</param>
    /// <param name="sPassword">密码</param>
    public IdentityScope(string sUsername, string sDomain, string sPassword)
    {
        // initialize tokens
        IntPtr pExistingTokenHandle = new IntPtr(0);
        IntPtr pDuplicateTokenHandle = new IntPtr(0);
        try
        {
            // get handle to token
            bool bImpersonated = LogonUser(sUsername, sDomain, sPassword, LOGON32_LOGON_NEWCREDENTIALS, LOGON32_PROVIDER_DEFAULT, ref pExistingTokenHandle);
            if (true == bImpersonated)
            {
                if (!ImpersonateLoggedOnUser(pExistingTokenHandle))
                {
                    int nErrorCode = Marshal.GetLastWin32Error();
                    throw new Exception("ImpersonateLoggedOnUser error;Code=" + nErrorCode);
                }
            }
            else
            {
                int nErrorCode = Marshal.GetLastWin32Error();
                throw new Exception("LogonUser error;Code=" + nErrorCode);
            }
        }
        finally
        {
            // close handle(s)
            if (pExistingTokenHandle != IntPtr.Zero)
                CloseHandle(pExistingTokenHandle);
            if (pDuplicateTokenHandle != IntPtr.Zero)
                CloseHandle(pDuplicateTokenHandle);
        }
    }
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            RevertToSelf();
            disposed = true;
        }
    }
    public void Dispose()
    {
        Dispose(true);
    }
}