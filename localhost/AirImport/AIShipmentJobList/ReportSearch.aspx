<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportSearch.aspx.cs" Inherits="AirImport_AIShipmentJobList_ReportSearch" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
       <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
      <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
       <script type="text/javascript">
           $(function () {
               var a = SetFnIsShow("2");
               if (a == "true") {
                   $("#tdExcel").css("visibility", "visible");
               } else {
                   $("#tdExcel").css("visibility", "hidden");
               }
           });
       </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidtop" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidbottom" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidleft" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidright" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidsys" runat="server" Text="AI">
    </ext:Hidden>
    <ext:Hidden ID="hidtype" runat="server" Text="DNCN">
    </ext:Hidden>
    <ext:Hidden ID="hidfrom" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidto" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hiddest" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidsales" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidshipper" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidconsignee" runat="server">
    </ext:Hidden>
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
    <table width="100%">
        <tr>
            <td align="center">
                <table style="text-align: left; margin-left: 4px;">
                    <tr>
                        <td align="left" style="height: 40px;" width="100%;">
                            <div style="width: 100%; position: fixed; top: 0px; z-index: 9999; padding-bottom: 10px;
                                padding-top: 5px; background: #fff">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td align="left" style="font-weight: bold; padding-right: 8px; width: 45px;">
                                            Copies
                                        </td>
                                        <td style="padding-right: 0px; width: 45px; display: block;">
                                            <ext:ComboBox ID="cmbPrintCount" runat="server" Width="40px" SelectedIndex="0" ListWidth="40px"
                                                DisplayField="text" ValueField="value">
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
                                        <td align="left" style="font-weight: bold; padding-right: 8px; width: 45px;">
                                            Printer
                                        </td>
                                        <td width="250px" align="left">
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
                                        <td width="70px">
                                            <ext:Button ID="LinBtnPDF" runat="server" Text="Export" Width="65" AutoFocus="true"
                                                AutoShow="true" Selectable="true">
                                                <DirectEvents>
                                                    <Click OnEvent="LinBtnPDF_Click">
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
					 <td width="70px" style="padding-left: 5px;" id="tdExcel">
                                            <ext:Button ID="LinBtnEXCEL" runat="server" Text="Export Excel" Width="92" AutoFocus="true"
                                                AutoShow="true" Selectable="true">
                                                <DirectEvents>
                                                    <Click OnEvent="LinBtnExcel_Click">
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
                        </td>
                    </tr>
                    <tr>
                        <td style="border: solid 1px #000; text-align: center;" colspan="4">
                            <table style="margin: 15px;">
                                <tr>
                                    <td style="vertical-align: top; text-align: left;">
                                        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
                                            DisplayGroupTree="false" DisplayToolbar="false" SeparatePages="false" ShowAllPageIds="false"
                                            EnableDrillDown="false" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
