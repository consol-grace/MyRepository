<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Grid1.aspx.cs" Inherits="common_UIControls_Grid1" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="Autocomplete.ascx" TagName="Autocomplete" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .select_160px
        {
            font-size: 10px;
        }
        input
        {
            border: solid 1px #B5B8C8;
            padding: 1px 2px;
            background-image: url(http://localhost:85/extjs/resources/images/default/form/text-bg-gif/ext.axd);
            background-color: #fff;
            text-transform: uppercase;
            font-family: Arial;
        }
        .bottom_line
        {
            background-image: url(/common/uicontrols/ajaxService/bottom_line.gif);
            background-repeat: repeat-x;
            background-position: left bottom;
            color: #FF0000;
            border: solid 1px #ff0000 !important;
            border-bottom: solid 1px #ff0000 !important;
        }
    </style>

    <script src="../myplugin/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="CompanyDrpList.js" type="text/javascript"></script>

    <script type="text/javascript">

       
     
    </script>

</head>
<body style="height: 2000px; width: 2000px">
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="resourecManager">
    </ext:ResourceManager>
    <%-- <input style="ime-mode:disabled" onkeydown="if(event.keyCode==13)event.keyCode=9" onKeyPress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false">
     <input onkeydown="if(event.keyCode==13)event.keyCode=9" />
     <input type="text" id="txtUser"  onkeyup="Autocomplete('txtUser',event)"  />
     <span id="txtUser_text"></span>
     <input onkeydown="if(event.keyCode==13)event.keyCode=9" />--%>
    <table style="padding: 10px; width: 100%">
        <tr>
            <td>
                <uc1:Autocomplete ID="txtName" runat="server" isAlign="false" Cls="select_160px"
                    winUrl="/BasicData/Customer/detail.aspx" winTitle="Company" winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="txtPass" runat="server" isAlign="true" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete3" runat="server" isAlign="false" Cls="select_160px"
                    winUrl="/BasicData/Customer/detail.aspx" winTitle="Company" winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete2" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete1" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete4" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete5" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete6" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete7" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete8" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete9" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete10" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td style="height: 1000px; line-height: 1000px">
                <ext:DateField runat="server" ID="datafield1" ></ext:DateField>
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete11" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete12" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete13" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete14" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete15" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete16" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
            </td>
        </tr>
        <tr>
            <td>
                <uc1:Autocomplete ID="Autocomplete17" runat="server" winUrl="/BasicData/Customer/detail.aspx"
                    winHeight="658" winWidth="755" />
                   
            </td>
        </tr>
    </table>
    <ext:Button ID="button" runat="server" Text="Click" Width="100" TabTip="ssss" ToolTip="aaaaaaa"
        ToolTipType="Qtip">
        <Listeners>
            <Click Handler="return ValidataText()" />
        </Listeners>
        <DirectEvents>
            <Click OnEvent="btn_Click">
            </Click>
        </DirectEvents>
    </ext:Button>
    </form>
</body>
</html>
