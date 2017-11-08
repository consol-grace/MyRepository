<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Company_Report.aspx.cs" Inherits="BasicData_Customer_compant_report_Company_Report" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../../common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {

            var windowHeight = $(window).height();
            $("#reportView").height(windowHeight - 45); ;
        })
    </script>

    <style type="text/css">
        body
        {
            overflow: hidden;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <table width="100%" style="height: 100%">
        <tr>
            <td align="center" style="height: 100%;">
                <table style="text-align: left; height: 100%; width: 1000px;">
                    <tr>
                        <td align="right" style="padding-bottom: 5px; padding-top: 10px" width="100%">
                            <table cellpadding="0" cellspacing="0" border="0" width="1000">
                                <tr>
                                   
                                    <td align="right" style="font-weight: bold; padding-left: 16px; padding-right: 8px;
                                        width: 45px;">
                                        Type
                                    </td>
                                    <td style="font-weight: bold; padding-right: 5px; text-align: right; display: block;">
                                        <ext:ComboBox  ID="cmbType" Width="127" runat="server" Cls="select_160px"
                                            TabIndex="2" DisplayField="value" Mode="Local" ValueField="value">
                                            <Store>
                                                <ext:Store runat="server" ID="storeType">
                                                    <Reader>
                                                        <ext:JsonReader>
                                                            <Fields>
                                                                <ext:RecordField Name="value">
                                                                </ext:RecordField>
                                                                <ext:RecordField Name="text">
                                                                </ext:RecordField>
                                                            </Fields>
                                                        </ext:JsonReader>
                                                    </Reader>
                                                </ext:Store>
                                            </Store>
                                        </ext:ComboBox>
                                    </td>
                                    <td align="right" style="font-weight: bold; padding-left: 16px; padding-right: 8px;
                                        width: 45px;">
                                        Order
                                    </td>
                                    <td style="font-weight: bold; padding-right: 5px; text-align: right; display: block;">
                                        <ext:ComboBox ID="cmborder" runat="server" Width="63" Cls="select_160px">
                                            <Items>
                                                <ext:ListItem Value="CODE" Text="CODE" />
                                                <ext:ListItem Value="NAME" Text="NAME" />
                                            </Items>
                                        </ext:ComboBox>
                                    </td>
                                    <td style=" padding:0px 10px;">
                                        <ext:Button ID="LinBtnRefresh" runat="server" Text="Refresh" Width="65">
                                            <DirectEvents>
                                                <Click OnEvent="LinBtnRefresh_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td align="right" style="font-weight: bold; padding-left: 16px; padding-right: 8px;
                                        width: 45px;">
                                        Copies
                                    </td>
                                    <td style="padding-left: 2px; padding-right: 0px; width: 45px; display: block;">
                                        <ext:ComboBox ID="cmbPrintCount" runat="server" Width="40px" SelectedIndex="0" ListWidth="40px"
                                            DisplayField="text" ValueField="value" Cls="select_160px">
                                            <Store>
                                                <ext:Store ID="storeCopies" runat="server">
                                                    <Reader>
                                                        <ext:JsonReader>
                                                            <Fields>
                                                                <ext:RecordField Name="text" />
                                                                <ext:RecordField Name="value" />
                                                            </Fields>
                                                        </ext:JsonReader>
                                                    </Reader>
                                                </ext:Store>
                                            </Store>
                                        </ext:ComboBox>
                                    </td>
                                    <td align="right" style="font-weight: bold; padding-left: 16px; padding-right: 8px;
                                        width: 45px;">
                                        Printer
                                    </td>
                                    <td width="230px" align="right" style="padding-right: 5px;">
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
                                            Width="210" SelectOnFocus="true">
                                        </ext:ComboBox>
                                    </td>
                                    <td style=" padding:0px 10px">
                                        <ext:Button ID="LinBtnPrint" runat="server" Text="Print" Width="65">
                                            <DirectEvents>
                                                <Click OnEvent="LinBtnPrint_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td>
                                        <ext:Button ID="LinBtnExcel" runat="server" Text="Excel" Width="65">
                                            <DirectEvents>
                                                <Click OnEvent="LinBtnExcel_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 100%; border: solid 1px #000; text-align: left; vertical-align: top">
                            <iframe id="reportView" name="reportView" src="" height="100%" width="1000" frameborder="0"
                                scrolling="yes"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
