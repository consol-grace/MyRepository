<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GMlist.aspx.cs" Inherits="Framework_Group_GMlist" Theme="FORM" %>
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
        <script src="JScript-menu.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="form1" runat="server">
            
            <div class="mypanel">
                <table id="table-user" cellpadding="0" cellspacing="0" border="0" style="width:100%">
                    <%
                        for (int i = 0; this.MenuRoot != null && i < this.MenuRoot.Rows.Count; i++)
                        { 
                    %>
                    <tr>
                        <th class="left"><%= this.MenuRoot.Rows[i]["NameCHS"] %>　　　　　　　　<a href='javascript:void(0)' onclick='FwGroupMenu.Header({me:this, form:"Tr<%= i %>"})'>隐藏</a></th>
                    </tr>
                    <tr id='Tr<%= i %>' class='<%= i==0?"show":"hide" %>'>
                        <td colspan="2">
                            <% 
                                this.MenuParent(this.MenuRoot.Rows[i]["MenuID"].ToString());
                            %>
                        &nbsp;</td>
                    </tr>
                    <% 
                        }        
                    %>
                </table>
            </div>
        
        </form>
    </body>
</html>
