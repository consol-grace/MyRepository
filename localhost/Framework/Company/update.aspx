<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true" CodeFile="update.aspx.cs" Inherits="Framework_Company_update" Theme="FORM" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>
        <link href="../../Common/myplugin/myplugin.css" rel="stylesheet" type="text/css" />
        <script src="../../Common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/jquery.ui.custom.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.core.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.ui.js" type="text/javascript"></script>
        <script src="JScript.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="form1" runat="server">
        <div class="mypanel">
            <table id="table-company-update" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <th>名称(中)</th>
                    <td>
                        <input type="text" runat="server" class="hide" id="CompanyID" name="CompanyID" />
                        <input type="text"  runat="server" id="NameCHS" name="NameCHS" />
                        
                    </td>
                </tr>
                <tr>
                    <th>名称(英)</th>
                    <td>
                        <input type="text"  runat="server" id="NameENG" name="NameENG" />
                    </td>
                </tr>
                <tr>
                    <th>区域</th>
                    <td>
                        <input type="text"  runat="server" id="District" name="District" />
                    </td>
                </tr>
            </table>
        </div>
        <% if (this.Option != "view")
           { %>
        <div class="pDivSplitor">
            <button type="reset" id="btnReset">重填</button><button type="button" id="btnSave">保存</button>
        </div>
        <%} %>
        </form>
    </body>
</html>
