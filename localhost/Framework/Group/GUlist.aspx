<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GUlist.aspx.cs" Inherits="Framework_Group_GUlist" Theme="FORM" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>
        <meta http-equiv="X-UA-Compatible" content="IE=7" />
        <link href="../../Common/myplugin/myplugin.css" rel="stylesheet" type="text/css" />
        <script src="../../Common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/jquery.ui.custom.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.core.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.ui.js" type="text/javascript"></script>
        <script src="JScript-user.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="form1" runat="server">
            
            <div class="mypanel">
                <table id="table-user" cellpadding="0" cellspacing="0" border="0" style="width:100%">
                    <% 
                        for (int i = 0; dt1 != null && i < dt1.Rows.Count; i++)
                        {
                    %>
                    <tr>
                        <th class="left"><input type="checkbox" id="chkAll<%= dt1.Rows[i]["CompanyID"] %>" name="chkAll<%= dt1.Rows[i]["CompanyID"] %>" onclick='Myplugin.Checkbox.ChoiceAll("chkAll<%= dt1.Rows[i]["CompanyID"] %>", "chk<%=dt1.Rows[i]["CompanyID"] %>");' />　<%= dt1.Rows[i]["NameCHS"] %>　　　　　　　　<a href='javascript:void(0)' name="aSave" onclick='FwGroupUser.Upade({form:"Tr<%=dt1.Rows[i]["CompanyID"] %><%= i %>", CompanyID:"<%=dt1.Rows[i]["CompanyID"] %>"})'>保存</a>　　<a href='javascript:void(0)' onclick='FwGroupUser.Header({me:this, form:"Tr<%=dt1.Rows[i]["CompanyID"] %><%= i %>", CompanyID:"<%=dt1.Rows[i]["CompanyID"] %>"})'>隐藏</a></th>
                    </tr>
                    <tr id='Tr<%=dt1.Rows[i]["CompanyID"] %><%= i %>' class='<%= i==0?"show":"hide" %>'>
                        <td colspan="2"><div class="padding13">
                            <% 
                                //Entity = new MenuFrameEntity();
                                //Entity.CompanyID = dt1.Rows[i]["CompanyID"];
                                //this.dt2 = this.FactoryFramework.IMenuFrame.GroupUserList(Entity);
                                for (int j = 0; dt2 != null && j < dt2.Rows.Count; j++)
                                {
                            %>
                            <input type="checkbox" name='chk<%=dt1.Rows[i]["CompanyID"] %>' value='<%= dt2.Rows[j]["UserName"]%>' onclick='Myplugin.Checkbox.ChoicItemAll("chkAll<%= dt1.Rows[i]["CompanyID"] %>", "chk<%=dt1.Rows[i]["CompanyID"] %>")' />　<%= dt2.Rows[j]["NameCHS"]%>　　　<% if (j != 0 && j % 5 == 0) { %><br /><% } %>
                            <% 
                                }        
                            %></div>
                        </td>
                    </tr>
                    <% 
                        }
                    %>
                </table>
            </div>
        
        </form>
    </body>
</html>
