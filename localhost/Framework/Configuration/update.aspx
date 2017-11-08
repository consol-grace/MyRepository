<%@ Page Language="C#" AutoEventWireup="true" CodeFile="update.aspx.cs" Inherits="Framework_Configuration_update" Theme="FORM" %>

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
        <script src="JScript.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="form1" runat="server">
        <div class="mypanel">
            <table id="table-company-update" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <th>Key名</th>
                    <td>
                        <input type="text" runat="server" id="KeyName" name="KeyName" />&nbsp;<font color="red">* 例: P01</font>
                    </td>
                </tr>
                <tr>                    
                    <th>Key值</th>
                    <td>
                        <input type="text"  runat="server" id="KeyValue" name="KeyValue" />&nbsp;<font color="red">*</font>
                    </td>
                </tr>
                <tr>                    
                    <th>备注</th>
                    <td colspan="3">
                        <input type="text" class="width898p" runat="server" id="Remark" name="Remark" />
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
