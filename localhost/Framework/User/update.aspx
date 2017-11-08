<%@ Page Language="C#" AutoEventWireup="true" CodeFile="update.aspx.cs" Inherits="Framework_User_update" Theme="FORM" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>
        <link href="/common/ylQuery/jQuery/css/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
        <script src="/common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="/common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>
        <link href="/common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />
        <script src="/common/ylQuery/ylQuery.js" type="text/javascript"></script>
        <link href="/common/ylQuery/ext-3.2.0/resources/css/ext-all.css" rel="stylesheet" type="text/css" />
        <script src="/common/ylQuery/ext-3.2.0/adapter/ext/ext-base.js" type="text/javascript"></script>
        <script src="/common/ylQuery/ext-3.2.0/ext-all.js" type="text/javascript"></script>
        <link href="/App_Themes/LOGIN/mframe.css" rel="stylesheet" type="text/css" />
        <script src="/common/Global/global.js" type="text/javascript"></script>
        <script src="JScript.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="form1" runat="server">
        <div class="mypanel">
            <table id="table-company-update" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <th>用户帐号</th>
                    <td>
                        <input type="text" runat="server" id="UserName" name="UserName" />&nbsp;<font color="red">* 例: K00001</font>
                    </td>
                    <th>激活</th>
                    <td>
                        <asp:DropDownList runat="server" ID="IsActivation">
                            <asp:ListItem Value="N">否</asp:ListItem>
                            <asp:ListItem Value="Y">是</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>                    
                    <th>邮箱</th>
                    <td>
                        <input type="text"  runat="server" id="Email" name="Email" />&nbsp;<font color="red">*</font>
                    </td>
                    <th>公司</th>
                    <td>
                        <asp:DropDownList runat="server" ID="CompanyID"></asp:DropDownList>&nbsp;<font color="red">*</font>
                    </td>
                </tr>
                <tr>
                    <th>姓名</th>
                    <td>
                        <input type="text"  runat="server" id="NameCHS" name="NameCHS" />&nbsp;<font color="red">*</font>
                    </td>
                    <th>昵称</th>
                    <td>
                        <input type="text"  runat="server" id="NameENG" name="NameENG" />
                    </td>                    
                </tr>
                <tr>
                    <th>问题</th>
                    <td>
                        <input type="text"  runat="server" id="Question" name="Question" />&nbsp;<font color="red">*</font>
                    </td>
                    <th>答案</th>
                    <td>
                        <input type="text"  runat="server" id="Answer" name="Answer" />&nbsp;<font color="red">*</font>
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
