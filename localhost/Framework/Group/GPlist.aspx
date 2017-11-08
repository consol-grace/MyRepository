<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GPlist.aspx.cs" Inherits="Framework_Group_GPlist" Theme="FORM" %>

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
        <script src="JScript-permission.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="form1" runat="server">
            
            <div class="mypanel">
                <table id="table-user" cellpadding="0" cellspacing="0" border="0" style="width:100%">
                    <tr>
                        <th class="left"><input type="checkbox" id="chkAll" name="chkAll" onclick='Myplugin.Checkbox.ChoiceAll("chkAll", "chkItem");' />　操作权限　　　　　　　　<a href='javascript:void(0)' name="aSave" onclick='FwGroupPermission.Upade({form:"Tr0"})'>保存</a></th>
                    </tr>
                    <tr id='Tr0' class='show'>
                        <td colspan="2"><div class="padding13">
                            <% 
                                for (int i = 0; dt1 != null && i < dt1.Rows.Count; i++)
                                {
                            %>
                            <input type="checkbox" name='chkItem' value='<%= dt1.Rows[i]["PermissionID"]%>' onclick='Myplugin.Checkbox.ChoicItemAll("chkAll", "chkItem")' />　<%= dt1.Rows[i]["NameCHS"]%>　　　<% if (i != 0 && i % 5 == 0) { %><br /><% } %>
                            <% 
                                }        
                            %></div>
                        </td>
                    </tr>

                </table>
            </div>
        
        </form>
    </body>
</html>
