<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reportView.aspx.cs" Inherits="BasicData_Customer_company_report_reportView" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField ID="hidCopies" runat="server" />
    <asp:HiddenField ID="hidtype" runat="server" />
    <asp:HiddenField ID="hidPrint" runat="server" />
    <asp:HiddenField ID="hidID" runat="server" />
    <asp:HiddenField ID="hidSort" runat="server" />
    <asp:HiddenField ID="hidtop" runat="server" Value="0.63" />
    <asp:HiddenField ID="hidbottom" runat="server" Value="0.63" />
    <asp:HiddenField ID="hidleft" runat="server" Value="0.63" />
    <asp:HiddenField ID="hidright" runat="server" Value="0.63" />
    <asp:HiddenField ID="hidInvDraft" runat="server" Value="1" />
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" Width="1000" AutoDataBind="true"
        DisplayGroupTree="false" DisplayToolbar="false" SeparatePages="false" ShowAllPageIds="false" 
        EnableDrillDown="false" />
    </form>
</body>
</html>
