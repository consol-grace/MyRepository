<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReferenceGrid.aspx.cs" Inherits="OceanExport_OEJobRference_ReferenceGrid" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="Stylesheet" type="text/css" />

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

   <style type="text/css">
       .tr_line:hover{background:#f7f7f7;}
       .tr_line td{font-size:10px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidtop" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidbottom" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidleft" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidright" runat="server" Text="0.63"></ext:Hidden>
    <div id="div1" style="width: 900px;" runat="server">
    </div>
    <div style="display:none;">
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                   <td  align="left" style="font-weight:bold; padding-right:8px;width:45px;">Copies</td>     
            <td style="padding-right:0px;width:45px;display:block;">
             <ext:ComboBox ID="cmbPrintCount" runat="server" Width="40px" SelectedIndex="0" ListWidth="40px" DisplayField="text" ValueField="value">
                        <Store>
                        <ext:Store ID="storeCopies" runat="server">
                        <Reader>
                        <ext:JsonReader><Fields><ext:RecordField Name="text" /><ext:RecordField Name="value" /></Fields></ext:JsonReader>
                        </Reader>
                        </ext:Store>
                        </Store>
                        </ext:ComboBox>
            </td>                  
                                    <td align="left" style="font-weight: bold; padding-right: 8px; width: 45px;">
                                        Printer
                                    </td>
                                    <td width="250px" align="left">
                                        <ext:Store runat="server" ID="Store2">
                                            <Reader>
                                                <ext:JsonReader>
                                                    <Fields>
                                                        <ext:RecordField Name="text" />
                                                        <ext:RecordField Name="value" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                        <ext:ComboBox ID="CmbPrint" TabIndex="3" runat="server" StoreID="Store2" DisplayField="text"
                                            ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All" Cls="select"
                                            Width="250" SelectOnFocus="true">
                                           
                                        </ext:ComboBox>
                                    </td>
                                    <td width="70px" style="padding-left: 5px; display: block;">
                                         <ext:Button ID="LinBtnPrint" runat="server" Text="Print" Width="65" AutoFocus="true"
                                            AutoShow="true" Selectable="true">
                                            <DirectEvents>
                                                <Click OnEvent="LinBtnPrint_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td width="70px" >
                                       <ext:Button ID="LinBtnPDF" runat="server" Text="Export" Width="65" AutoFocus="true"
                                            AutoShow="true" Selectable="true">
                                            <DirectEvents>
                                                <Click OnEvent="LinBtnPDF_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td align="right">
                                        <ext:Label ID="lbltishi" runat="server">
                                        </ext:Label>
                                    </td>
                                </tr>
                            </table>
    </div>
    <table><tr><td style="height:5px;"></td></tr></table>
    <asp:GridView ID="gridView" runat="server" Width="900" HeaderStyle-CssClass="HeaderStyle"
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
