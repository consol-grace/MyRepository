<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserControlTop.ascx.cs" Inherits="common_UIControls_UserControlTop" %>
<script src="/common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
<script src="/common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script> 
<script src="/common/ylQuery/ylQuery.js" type="text/javascript"></script>
<script src="/common/Global/global.js" type="text/javascript"></script>
<script src="../../mframe/controller.js" type="text/javascript"></script>
<link href="/common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />

<div style="padding-bottom:10px">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                    <td  style=" padding-left:10px; padding-right:10px; background-color:#0354AD" width="220" ><img src="../../images/logo.png" width="220" height="50" /></td>
                    <td align="left" bgcolor=""  style="background-color:#0354AD; height:65px; vertical-align:middle;">
                            <%-- nav start--%>
                            <table border="0" cellspacing="0" cellpadding="0" style="padding-right:10px; padding-bottom:10px">
                               <% 
                                   this.dview.RowFilter = "MenuID='MBD' ";
                                   if(string.IsNullOrEmpty(Request.QueryString["Remark"]))
                                   {
                                       this.dview1.RowFilter = "ParentID='" + this.dview[0]["MenuID"].ToString() + "'";
                                   }
                                   else
                                   {
                                       this.dview1.RowFilter = "ParentID='" + this.dview[0]["MenuID"].ToString() + "' and Remark='"+Request.QueryString["Remark"]+"'";
                                   }
                                   
                                   if (this.dview1 != null && this.dview1.Count > 0)
                                   {
                                       int count = this.dview1.Count;
                                       if (count % 2 == 0)
                                       {
                                           firstCount = count / 2;
                                       }
                                       else
                                       {
                                           firstCount = count / 2+1;
                                       }
                                   }  
                               %>
                                <tr>
                                    <%
                                        for (int i = 0; this.dview1 != null && i < firstCount; i++)
                                        { 
                                    %>
                                    <td><span class='<%=this.dview1[i]["NameENG"].ToString().Length > 9 ? "nav_btn_01" : "nav_btn_01"%>'>
                                  <a href="javascript:void(0)" onclick='CompanyX.UserControlTop1.ShowLink("<%= this.dview1[i]["NameENG"] %>","<%= this.dview1[i]["Hyperlink"] %>")'> 
                                    <%= this.dview1[i]["NameENG"] %></a></span></td>  
                                    <% 
                                        }                                   
                                    %>                          
                                </tr>
                                <tr>
                                    <%
                                        for (int j = firstCount; this.dview1 != null && j < dview1.Count; j++)
                                        { 
                                    %>
                                    <td><span class='<%=this.dview1[j]["NameENG"].ToString().Length > 9 ? "nav_btn_01" : "nav_btn_01"%>'>
                                    <a href="javascript:void(0)" onclick='CompanyX.UserControlTop1.ShowLink("<%= this.dview1[j]["NameENG"] %>","<%= this.dview1[j]["Hyperlink"] %>")'> 
                                    <%= this.dview1[j]["NameENG"] %></a></span></td>  
                                    <% 
                                        }                                   
                                    %>                          
                                </tr>
                            </table>
                            <%-- nav end --%>                        
                        </td>
                    </tr>
                </table>
                </div>