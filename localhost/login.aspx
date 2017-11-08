<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>    
        <title>Login In</title>
        <link href="App_Themes/LOGIN/login.css" rel="stylesheet" type="text/css" />
        <%--<link href="css/style.css" rel="Stylesheet" type="text/css" />--%>
    </head>
    <body>
        <form runat="server" id="form1">
        <asp:ScriptManager ID="manage" runat="server"></asp:ScriptManager>
        <script type="text/javascript" language="javascript">
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                if (args.get_error() != undefined) {
                    args.set_errorHandled(true); location.reload(true);
                }
            }
        </script>
        <asp:UpdatePanel ID="upLogin" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
        <div id="pUpdatePanel" style="vertical-align:middle; height:500px;">
        <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center" style="padding-top:120px;">
                    <table width="400" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="50" align="right" style="padding-bottom: 20px">
                                <img src="/App_Themes/LOGIN/images/login_logo.png" width="294" height="88" />
                            </td>
                            <td width="50" align="right">
                                <img src="/App_Themes/LOGIN/images/line-login.jpg" />
                            </td>
                            <td width="300" align="right" valign="bottom">
                                <table width="300">
                                    <tr>
                                        <td width="79" height="25" align="left">
                                            <table width="78" border="0" cellspacing="0" cellpadding="0" 
                                                style="height: 19px">
                                                <tr>
                                                    <td style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; font-weight:bold; color: #333333" >
                                                        User Name
                                                    </td>
                                                    <td align="right">
                                                        <span style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; font-weight:bold;"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td colspan="2" align="left">
                                           <%-- <input type="text" runat="server" id="UserName"  name="UserName"   style="width:110px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; text-transform:none " class="input_login"/>--%>
                                            <asp:TextBox runat="server" id="UserName" style="width:110px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; text-transform:none;border: 1px solid #7eadd9; height:18px;"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="25" align="left">
                                            <table width="78" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; font-weight:bold; color: #333333">
                                                       Password
                                                    </td>
                                                    <td align="right" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; font-weight:bold;">
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="25" colspan="2" align="left">
                                           <%-- <input type="password" runat="server" name="UserPWD" id="UserPWD"  style="width:110px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px" class="input_login"/>--%>
                                            <asp:TextBox TextMode="Password" runat="server"  id="UserPWD"  style="width:110px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px;border: 1px solid #7eadd9; height:18px;" ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="25" align="left">
                                            &nbsp;
                                        </td>
                                        <td height="25" colspan="2" align="left">
                                             <span class="tb"> <asp:Button runat="server" ID="btnLogin" Text=" Login " 
                                                 OnClick="btnLogin_Click" 
                                                 style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size:10px; font-weight:bold; height: 22px; width: 60px;cursor:pointer; text-transform:capitalize;" />
                                             </span>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td height="25" align="left">&nbsp;</td>
                                        <td width="70" height="25" align="left">&nbsp;</td>
                                        <td width="135" align="left" class="STYLE4">&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </div>
        </ContentTemplate>
        </asp:UpdatePanel>
        </form>
    </body>
</html>
