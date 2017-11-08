<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReferenceGrid.aspx.cs" Inherits="OceanExport_OEJobRference_ReferenceGrid" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="Stylesheet" type="text/css" />


   <style type="text/css">
       .tr_line:hover{background:#f7f7f7;}
       .tr_line td{font-size:10px;}
    </style>
    <script type="text/javascript" language="javascript">
        function showurl(url) {
            var win = this.parent.parent.WinView;
            win.load(url); 
            win.show();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    
    <ext:Hidden ID="hidsys" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidfrom" runat="server" ></ext:Hidden>
    <ext:Hidden ID="hidto" runat="server"></ext:Hidden>
    <ext:Hidden ID="hiddest" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidsales" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidshipper" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidconsignee" runat="server"></ext:Hidden>
    
    <ext:Hidden ID="hidJob" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidMbl" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidHbl" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidContainer" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidVessel" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidVoyage" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidColoader" runat="server"></ext:Hidden>
    <div id="div1" style="width: 880px;" runat="server">
    </div>
   
     <table><tr><td style="height:5px;"></td></tr></table>
    <asp:GridView ID="gridView" runat="server" Width="880px" HeaderStyle-CssClass="HeaderStyle"
        RowStyle-CssClass="tr_line" CssClass="GridViewCss" FooterStyle-CssClass="FooterStyle"
        GridLines="None" CellSpacing="1" OnRowDataBound="gridView_RowDataBound">
    </asp:GridView>
    <div id="divRep" runat="server" visible="false">
        <asp:Repeater runat="server" ID="RepList">
            <HeaderTemplate>
                <table class="GridViewCss" cellspacing="1" border="0" id="gridView" style="width: 900px;">
                    <tr class="HeaderStyle">
            </HeaderTemplate>
            <ItemTemplate>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("LOTNO")%>
                </th>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("FLTDATE")%>
                </th>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("master_no")%>
                </th>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("house_no")%>
                </th>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("SHPR")%>
                </th>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("CNEE")%>
                </th>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("DEPART")%>
                </th>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("DEST")%>
                </th>
                <th scope="col" style="text-align: center !important; font-weight: bold !important;">
                    <%#Eval("CWT")%>
                </th>
            </ItemTemplate>
            <FooterTemplate>
                </tr> </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
    </form>
</body>
</html>
