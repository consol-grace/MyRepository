<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportPDF.aspx.cs" Inherits="AirExport_AEReportFile_ReportPDF" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Src="../../common/UIControls/ViewReport.ascx" TagName="ViewReport" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
         <link href="../../css/style.css" rel="stylesheet" type="text/css" />
     <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
  
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body, html
        {
            overflow: hidden;
        }
        #CmbPrint1, #cmbPrintCount1
        {
            border: solid 1px #bbb;
            background-color: Transparent;
            height: 19px;
            line-height: 19px;
            cursor: pointer;
            font-size: 10px;
        }
        #showDraft label
        {
            margin: 0 0 0 5px;
            vertical-align: bottom;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidID" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidtype" runat="server">
    </ext:Hidden>
    <asp:HiddenField ID="hidsys" runat="server" Value="AE" />
    <asp:HiddenField ID="allKey" runat="server" />
    <ext:Hidden ID="hidtop" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidbottom" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidleft" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidright" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidInvDraft" runat="server" Text="1">
    </ext:Hidden>
    <table style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td style="padding-bottom: 2px; padding-top: 10px; height: 50px; text-align: center;">
                <div style="width: 1000px; margin: 0px auto; text-align: right">
                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                        <tr>
                            <td align="left" width="200px">
                                <ext:Label ID="lbltishi" runat="server">
                                </ext:Label>
                            </td>
                            <td>
                            </td>
                            <td style="font-weight: bold; padding:0 8px; text-align: right;">
                                Copies
                            </td>
                            <td style="padding-left: 2px; padding-right: 0px; width: 45px;">
                                <asp:DropDownList runat="server" ID="cmbPrintCount1" Width="40px">
                                </asp:DropDownList>
                            </td>
                            <td align="right" style="font-weight: bold; padding:0 8px; width: 45px;">
                                Printer
                            </td>
                            <td width="250px" align="right" style="padding-right: 5px;">
                                <asp:DropDownList runat="server" ID="CmbPrint1" Width="260px">
                                </asp:DropDownList>
                            </td>
                            <td width="56px" align="center" id="showDraft" runat="server" visible="false">
                                <ext:Checkbox ID="chkFlagDraft" runat="server" Checked="true" BoxLabel="Draft">
                                </ext:Checkbox>
                            </td>
                            <td width="40px">
                                <ext:Button ID="LinBtnPrint" runat="server" Text="Print" Width="65">
                                    <DirectEvents>
                                        <Click OnEvent="LinBtnPrint_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </td>
                            <td width="40px" id="showBtnDraft" runat="server" visible="false" style="padding-left: 5px;">
                                <ext:Button ID="btnInvDraft" runat="server" Text="Draft" Width="65">
                                    <DirectEvents>
                                        <Click OnEvent="btnInvDraft_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </td>
                            <td width="40px" style="padding-left: 5px; display: none">
                                <ext:Button ID="LinBtnPDF" runat="server" Text="Export" Width="65">
                                    <DirectEvents>
                                        <Click OnEvent="LinBtnPDF_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; height: 100%">
                <uc1:ViewReport runat="server" ID="ViewReport1" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
