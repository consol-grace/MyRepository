<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pwupdate.aspx.cs" Inherits="Framework_User_pwupdate" Theme="FORM" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>
        <meta http-equiv="X-UA-Compatible" content="IE=7" />
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
            <table id="table-company-update" cellpadding="0" cellspacing="0" border="0" width="200px">
                <tr>
                    <th>原密码</th>
                    <td>
                        <input type="password" runat="server" id="OUserPWD" name="OUserPWD" onkeyup="OUserPWD1.value=this.value" />&nbsp;<font color="red">*</font>
                        <input type="text" class="hide" id="OUserPWD1" name="OUserPWD1" />
                    </td>
                </tr>
                <tr>
                    <th>新密码</th>
                    <td>
                        <input type="password" id="UserPWD1" name="UserPWD1" onkeyup='UserPWD.value=this.value' />&nbsp;<font color="red">*</font>
                        <input type="text" class="hide" id="UserPWD" name="UserPWD" />
                    </td>
                </tr>
                <tr>
                    <th>确认密码</th>
                    <td>
                        <input type="password" id="RUserPWD" name="RUserPWD" />&nbsp;<font color="red">*</font>
                    </td>
                </tr>
            </table>
        </div>
        <div class="pDivSplitor">
            <button type="button" id="btnModifyPWD">保存</button>
        </div>
        </form>
    </body>
</html>
