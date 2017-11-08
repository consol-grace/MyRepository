<%@ WebHandler Language="C#" Class="DataController" %>

using System;
using System.Web;
using System.Data;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using System.Collections.Generic;
using DIYGENS.COM.JQUERY;

public class DataController : DIYGENS.COM.BASECLASS.ControllerBase
{
    
    protected override void Page_Load(object sender, EventArgs e)
    {
        this.Option = Request.QueryString["Option"];
        this.Message = "[{\"Option\":\"{Option}\"}]";
        switch (this.Option)
        {
            case "list": this.list(); break;
            case "update": this.update(); break;
        }
    }

    #region list()   Author: Hcy ( 2011-08-22 )
    /// <summary>
    /// 获取列表
    /// </summary>
    private void list()
    {
        DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Detail")
            .Append("ROWID",Request.QueryString["id"])
            .Append("Group",Request.QueryString["group"])
            .Append("CompanyKind",Request.QueryString["type"])
        }).GetTable();

        this.ReturnValue = this.ToJSON(dt);
        Response.Write(this.ReturnValue);
    }
    #endregion


    #region update()   Author: Hcy ( 2011-08-22 )
    /// <summary>
    /// 更新
    /// </summary>
    private void update()
    {
        bool bFlag = false;
        if (Request.Form["hidRowID"] != "")//更新
        {
            List<IFields> fields = new List<IFields>();
            fields.Add(this.CreateIFields().Append("Option", "Update")
            .Append("ROWID", Request.Form["hidRowID"].Trim())
            .Append("ParentID", "0")
            .Append("Code", Request.Form["Code"].Trim())
            .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
            .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
            .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
            //.Append("HaveAE", Request.QueryString["chkAE"])
            //.Append("HaveOE", Request.QueryString["chkOE"])
            //.Append("HaveAI", Request.QueryString["chkAI"])
            //.Append("HaveOI", Request.QueryString["chkOI"])
            
             //Ge
            .Append("Name", Request.Form["geCompany"])
            .Append("Address1", Request.Form["geAddress1"])
            .Append("Address2", Request.Form["geAddress2"])
            .Append("Address3", Request.Form["geAddress3"])
            .Append("Address4", Request.Form["geAddress4"])
            .Append("Contact", Request.Form["geContact"])
            .Append("Phone", Request.Form["gePhone"])
            .Append("Fax", Request.Form["geFax"])
            .Append("Mobile", Request.Form["geMobile"])
            .Append("Email", Request.Form["geEmail"])
            .Append("Keyword", Request.Form["geKeyword"])
            //.Append("Group", Request.Form["Group"])
            );
            fields.Add(this.CreateIFields().Append("Option", "Update")
                  .Append("Code", Request.Form["Code"].Trim())
            .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
            .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
            .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                .Append("CompanyKind", "BILL")
                .Append("ParentID", Request.Form["hidRowID"].Trim())
                .Append("ROWID", Request.Form["hidRowID"].Trim())
                .Append("CreditTerm", Request.Form["biCredit"])
                .Append("Name", Request.Form["biCompany"])
                .Append("Address1", Request.Form["biAddress1"])
                .Append("Address2", Request.Form["biAddress2"])
                .Append("Address3", Request.Form["biAddress3"])
                .Append("Address4", Request.Form["biAddress4"])
                .Append("Contact", Request.Form["biContact"])
                .Append("Phone", Request.Form["biPhone"])
                .Append("Fax", Request.Form["biFax"])
                .Append("Remark", Request.Form["biRemark"])
                .Append("Email", Request.Form["geEmail"]));
            if (Request.QueryString["chkAE"] == "1")
            {
                fields.Add(this.CreateIFields().Append("Option", "Update")
                    .Append("ROWID", Request.Form["hidRowID"].Trim())
                     .Append("Code", Request.Form["Code"].Trim())
            .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
            .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
            .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                    .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                     .Append("CompanyKind", "AE")
                     .Append("ParentID", Request.Form["hidRowID"].Trim())
                     .Append("Name", Request.Form["aeCompany"])
                    .Append("Address1", Request.Form["aeAddress1"])
                    .Append("Address2", Request.Form["aeAddress2"])
                    .Append("Address3", Request.Form["aeAddress3"])
                    .Append("Address4", Request.Form["aeAddress4"])
                    .Append("Contact", Request.Form["aeContact"])
                    .Append("Phone", Request.Form["aePhone"])
                    .Append("Fax", Request.Form["aeFax"])
                    .Append("Email", Request.Form["aeEmail"])
                    //.Append("Remark", Request.Form["aeAWB"])
                );
            }
            if (Request.QueryString["chkAI"] == "1")
            {
                fields.Add(this.CreateIFields().Append("Option", "Update")
                    .Append("ROWID", Request.Form["hidRowID"].Trim())
                     .Append("Code", Request.Form["Code"].Trim())
            .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
            .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
            .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                    .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                       .Append("CompanyKind", "AI")
                       .Append("ParentID", Request.Form["hidRowID"].Trim())
                       .Append("Name", Request.Form["aiCompany"])
                    .Append("Address1", Request.Form["aiAddress1"])
                    .Append("Address2", Request.Form["aiAddress2"])
                    .Append("Address3", Request.Form["aiAddress3"])
                    .Append("Address4", Request.Form["aiAddress4"])
                    .Append("Contact", Request.Form["aiContact"])
                    .Append("Phone", Request.Form["aiPhone"])
                    .Append("Fax", Request.Form["aiFax"])
                    .Append("Email", Request.Form["aiEmail"]));
            }
            if (Request.QueryString["chkOE"] == "1")
            {
                fields.Add(this.CreateIFields().Append("Option", "Update")
                      .Append("CompanyKind", "OE")
                       .Append("Code", Request.Form["Code"].Trim())
            .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
            .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
            .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                      .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                      .Append("ROWID", Request.Form["hidRowID"].Trim())
                      .Append("ParentID", Request.Form["hidRowID"].Trim())
                      .Append("Name", Request.Form["oeCompany"])
                    .Append("Address1", Request.Form["oeAddress1"])
                    .Append("Address2", Request.Form["oeAddress2"])
                    .Append("Address3", Request.Form["oeAddress3"])
                    .Append("Address4", Request.Form["oeAddress4"])
                    .Append("Contact", Request.Form["oeContact"])
                    .Append("Phone", Request.Form["oePhone"])
                    .Append("Fax", Request.Form["oeFax"])
                    .Append("Email", Request.Form["oeEmail"])
                   // .Append("Remark", Request.Form["oeAWB"])
               );
            }
            if (Request.QueryString["chkOI"] == "1")
            {
                fields.Add(this.CreateIFields().Append("Option", "Update")
                    .Append("ROWID", Request.Form["hidRowID"].Trim())
                     .Append("Code", Request.Form["Code"].Trim())
            .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
            .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
            .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                    .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                  .Append("CompanyKind", "OI")
                  .Append("ParentID", Request.Form["hidRowID"].Trim())
                  .Append("Name", Request.Form["oiCompany"])
                .Append("Address1", Request.Form["oiAddress1"])
                 .Append("Address2", Request.Form["oiAddress2"])
                  .Append("Address3", Request.Form["oiAddress3"])
                   .Append("Address4", Request.Form["oiAddress4"])
                .Append("Contact", Request.Form["oiContact"])
                .Append("Phone", Request.Form["oiPhone"])
                .Append("Fax", Request.Form["oiFax"])
                .Append("Email", Request.Form["oiEmail"]));
            }
            bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", fields).Update();
        }
        else//添加
        {
               DataSet ds = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", new List<IFields>() { this.CreateIFields().Append("Option", "Update")
                .Append("User",FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS",FSecurityHelper.CurrentUserDataGET()[11].Substring(0,1))
                .Append("STAT",FSecurityHelper.CurrentUserDataGET()[12])
                //标头
                .Append("Code",Request.Form["Code"].Trim())
                .Append("CompanyKind", "BASE")
                .Append("CompanyType",Request.Form["Type"].Trim()=="Select..."?"":Request.Form["Type"].Trim())
                .Append("Location",Request.Form["Location"].Trim()=="Select..."?"":Request.Form["Location"].Trim())
                .Append("Sales",Request.Form["Sales"].Trim()=="Select..."?"":Request.Form["Sales"].Trim())
                .Append("HaveAE","0")
                .Append("HaveOE","0")
                .Append("HaveAI","0")
                .Append("HaveOI","0")
                //Ge
                .Append("Name",Request.Form["geCompany"])
                .Append("Address1", Request.Form["geAddress1"])
            .Append("Address2", Request.Form["geAddress2"])
            .Append("Address3", Request.Form["geAddress3"])
            .Append("Address4", Request.Form["geAddress4"])
                .Append("Contact",Request.Form["geContact"])
                .Append("Phone",Request.Form["gePhone"])
                .Append("Fax",Request.Form["geFax"])
                .Append("Mobile",Request.Form["geMobile"])
                .Append("Email",Request.Form["geEmail"])
                .Append("Keyword",Request.Form["geKeyword"])
                //.Append("Group",Request.Form["Group"])
               }).GetList();
               if (ds != null && ds.Tables[0].Rows.Count > 0)
               {
                   string RowID = ds.Tables[0].Rows[0][0].ToString();
                   List<IFields> fl = new List<IFields>();
                   //Bill
                   fl.Add(this.CreateIFields().Append("Option", "Update")
                       //标头
                .Append("Code", Request.Form["Code"].Trim())
                .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
                .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
                .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                .Append("HaveAE", "0")
                .Append("HaveOE", "0")
                .Append("HaveAI", "0")
                .Append("HaveOI", "0")
                 .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                .Append("CompanyKind", "BILL")
                .Append("ParentID", RowID)
                .Append("CreditTerm", Request.Form["biCredit"])
                .Append("Name", Request.Form["biCompany"])
                .Append("Address1", Request.Form["biAddress1"])
                .Append("Address2", Request.Form["biAddress2"])
                .Append("Address3", Request.Form["biAddress3"])
                .Append("Address4", Request.Form["biAddress4"])
                .Append("Contact", Request.Form["biContact"])
                .Append("Phone", Request.Form["biPhone"])
                .Append("Fax", Request.Form["biFax"])
                .Append("Remark", Request.Form["biRemark"])
                .Append("Email", Request.Form["geEmail"]));
                 //AE
                   if (Request.QueryString["chkAE"] == "1")
                   {
                       fl.Add(this.CreateIFields().Append("Option", "Update")
                           //标头
                    .Append("Code", Request.Form["Code"].Trim())
                    .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
                    .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
                    .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                    .Append("HaveAE", "1")
                    .Append("HaveOE", "0")
                    .Append("HaveAI", "0")
                    .Append("HaveOI", "0")
                           .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                       .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                      .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                          .Append("CompanyKind", "AE")
                          .Append("ParentID", RowID)
                           .Append("Name", Request.Form["aeCompany"])
                          .Append("Address1", Request.Form["aeAddress1"])
                    .Append("Address2", Request.Form["aeAddress2"])
                    .Append("Address3", Request.Form["aeAddress3"])
                    .Append("Address4", Request.Form["aeAddress4"])
                          .Append("Contact", Request.Form["aeContact"])
                          .Append("Phone", Request.Form["aePhone"])
                          .Append("Fax", Request.Form["aeFax"])
                          .Append("Email", Request.Form["aeEmail"])
                           //.Append("Remark", Request.Form["aeAWB"])
                      );
                   }
                   //AI
                   if (Request.QueryString["chkAI"] == "1")
                   {
                       fl.Add(this.CreateIFields().Append("Option", "Update")
                           //标头
                    .Append("Code", Request.Form["Code"].Trim())
                    .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
                    .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
                    .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                    .Append("HaveAE", "0")
                    .Append("HaveOE", "0")
                    .Append("HaveAI", "1")
                    .Append("HaveOI", "0")
                           .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                        .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                       .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                           .Append("CompanyKind", "AI")
                           .Append("ParentID", RowID)
                           .Append("Name", Request.Form["aiCompany"])
                        .Append("Address1", Request.Form["aiAddress1"])
                    .Append("Address2", Request.Form["aiAddress2"])
                    .Append("Address3", Request.Form["aiAddress3"])
                    .Append("Address4", Request.Form["aiAddress4"])
                        .Append("Contact", Request.Form["aiContact"])
                        .Append("Phone", Request.Form["aiPhone"])
                        .Append("Fax", Request.Form["aiFax"])
                        .Append("Email", Request.Form["aiEmail"]));
                   }
                   //OE
                   if (Request.QueryString["chkOE"] == "1")
                   {
                       fl.Add(this.CreateIFields().Append("Option", "Update")
                           //标头
                    .Append("Code", Request.Form["Code"].Trim())
                    .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
                    .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
                    .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                    .Append("HaveAE", "0")
                    .Append("HaveOE", "1")
                    .Append("HaveAI", "0")
                    .Append("HaveOI", "0")
                           .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                        .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                       .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                         .Append("CompanyKind", "OE")
                         .Append("ParentID", RowID)
                         .Append("Name", Request.Form["oeCompany"])
                       .Append("Address1", Request.Form["oeAddress1"])
                    .Append("Address2", Request.Form["oeAddress2"])
                    .Append("Address3", Request.Form["oeAddress3"])
                    .Append("Address4", Request.Form["oeAddress4"])
                       .Append("Contact", Request.Form["oeContact"])
                       .Append("Phone", Request.Form["oePhone"])
                       .Append("Fax", Request.Form["oeFax"])
                       .Append("Email", Request.Form["oeEmail"])
                           //.Append("Remark", Request.Form["oeAWB"])
                    );
                   }
                   //OI
                   if (Request.QueryString["chkOI"] == "1")
                   {
                       fl.Add(this.CreateIFields().Append("Option", "Update")
                           //标头
                    .Append("Code", Request.Form["Code"].Trim())
                    .Append("CompanyType", Request.Form["Type"].Trim() == "Select..." ? "" : Request.Form["Type"].Trim())
                    .Append("Location", Request.Form["Location"].Trim() == "Select..." ? "" : Request.Form["Location"].Trim())
                    .Append("Sales", Request.Form["Sales"].Trim() == "Select..." ? "" : Request.Form["Sales"].Trim())
                    .Append("HaveAE", "0")
                    .Append("HaveOE", "0")
                    .Append("HaveAI", "0")
                    .Append("HaveOI", "1")
                       .Append("User", FSecurityHelper.CurrentUserDataGET()[0])
                        .Append("SYS", FSecurityHelper.CurrentUserDataGET()[11].Substring(0, 1))
                       .Append("STAT", FSecurityHelper.CurrentUserDataGET()[12])
                      .Append("CompanyKind", "OI")
                      .Append("ParentID", RowID)
                      .Append("Name", Request.Form["oiCompany"])
                    .Append("Address1", Request.Form["oiAddress1"])
                 .Append("Address2", Request.Form["oiAddress2"])
                  .Append("Address3", Request.Form["oiAddress3"])
                   .Append("Address4", Request.Form["oiAddress4"])
                    .Append("Contact", Request.Form["oiContact"])
                    .Append("Phone", Request.Form["oiPhone"])
                    .Append("Fax", Request.Form["oiFax"])
                    .Append("Email", Request.Form["oiEmail"]));
                   }

                   bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, "FW_BasicData_Company_SP", fl).Update();
               }
               else
               {
                   bFlag = false;
               }
        }

        this.ReturnValue = bFlag ? this.Message.Replace("{Option}", "true") : this.Message.Replace("{Option}", "false");
        Response.Write(this.ReturnValue);
    }
    #endregion
    
}
