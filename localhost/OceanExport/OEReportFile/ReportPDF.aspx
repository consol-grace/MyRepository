<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportPDF.aspx.cs" Inherits="OceanExport_OEReportFile_ReportPDF" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/ViewReport.ascx" TagName="ViewReport" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Report preview</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body, html
        {
            overflow: auto;
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
        #labSurrendered
        {
            margin-left: 8px;
            vertical-align: top;
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
    <asp:HiddenField ID="allKey" runat="server" />
    <asp:HiddenField ID="hidsys" runat="server" />
    <ext:Hidden ID="hidInvDraft" runat="server" Text="1">
    </ext:Hidden>
    <ext:Hidden ID="hidtop" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidbottom" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidleft" runat="server" Text="0.63">
    </ext:Hidden>
    <ext:Hidden ID="hidright" runat="server" Text="0.63">
    </ext:Hidden>
    <div style="height: 100%; overflow-y: auto;">
        <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="padding-bottom: 2px; padding-top: 10px; height: 50px; text-align: center;">
                    <%if (hidtype.Text == "OutShipment")
                      { %>
                    <iframe id="iframeRemark" width="1000px" height="150px" frameborder="0" src="../OEJobList/OERemark.aspx?ID=<%=hidID.Text%>">
                    </iframe>
                    <%} %>
                    <div style="width: 1000px; margin: 0px auto; text-align: right">
                        <table cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
                            <tr>
                                <td>
                                    <nobr><ext:Label ID="lbltishi" runat="server">
                                </ext:Label></nobr>
                                </td>
                                <td>
                                    <ext:Button ID="btnPrint" runat="server" Text="HBL" Cls="font_11px_bold2" Width="60px"
                                        StyleSpec="margin:0px 2px;">
                                        <DirectEvents>
                                            <Click OnEvent="btnPrint_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td>
                                    <ext:Button ID="btnDraft" runat="server" Text="Draft" Cls="font_11px_bold2" Width="60px"
                                        StyleSpec="margin:0px 2px;">
                                        <DirectEvents>
                                            <Click OnEvent="btnDraft_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td>
                                    <ext:Button ID="btnACI" runat="server" Text="ACI" Cls="font_11px_bold2" Width="60px"
                                        StyleSpec="margin:0px 2px;">
                                        <DirectEvents>
                                            <Click OnEvent="btnACI_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td>
                                    <ext:Button ID="btnAttachList" runat="server" Text="Attach" Cls="font_11px_bold2"
                                        Width="60px" StyleSpec="margin:0px 2px;">
                                        <DirectEvents>
                                            <Click OnEvent="btnAttachList_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td valign="bottom">
                                    <div id="div_Surrendered" style="float: left;" runat="server">
                                        <nobr><input type="checkbox" id="chkSurrendered" runat="server" onclick="CompanyX.chkSurrendered_CheckedChanged();" /><label id="labSurrendered" for="chkSurrendered">SURRENDERED</label></nobr>
                                    </div>
                                </td>
                                <td valign="bottom" style="<%if (!Request["type"].ToUpper().Contains("SBS")){Response.Write("display:none");} %>">
                                    
                                    <div style="float: left; margin-left:10px; ">
                                     <nobr>   <input type="checkbox" runat="server" id="chkIsPKGS" checked="checked"  onclick="CompanyX.chkIsShowPKGS_CheckedChanged();" />                                         
                                        <label for="chkIsPKGS" style=" margin-top:8px; vertical-align:top; ">Show PKGS</label></nobr></div>
                                    
                                </td>
                                <td style="width: 500px; font-weight: bold;" align="right" valign="middle">
                                </td>
                                <td style="font-weight: bold; padding-right: 8px; text-align: right;">
                                    Copies
                                </td>
                                <td style="padding-left: 2px; padding-right: 0px; width: 45px;">
                                    <asp:DropDownList runat="server" ID="cmbPrintCount1" Width="40px">
                                    </asp:DropDownList>
                                </td>
                                <td align="right" style="font-weight: bold; padding: 0 8px; width: 45px;">
                                    Printer
                                </td>
                                <td width="250px" align="Right">
                                    <asp:DropDownList runat="server" ID="CmbPrint1" Width="260px">
                                    </asp:DropDownList>
                                </td>
                                <td style="padding: 0 10px; display: none" runat="server" id="showDraft" visible="false">
                                    <nobr><asp:CheckBox runat="server" ID="chkFlagDraft" Checked="true" Text="Draft"/></nobr>
                                </td>
                                <td width="40px" style="padding-left: 5px;">
                                    <input type="button" id="LinBtnPrint" runat="server" value="Print" onclick="this.disabled = true; this.blur(); CompanyX.LinBtnPrint_Click();" />
                                </td>
                                <td width="40px" style="padding-left: 5px; display: none">
                                    <ext:Hidden ID="hidb" runat="server" Text="false">
                                    </ext:Hidden>
                                    <ext:Button ID="LinBtnPDF" runat="server" Text="Export" Width="65" AutoFocus="true"
                                        Hidden="true" AutoShow="true" Selectable="true">
                                        <DirectEvents>
                                            <Click OnEvent="LinBtnPDF_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td width="40px" id="showBtnDraft" runat="server" visible="false" style="padding-left: 5px;">
                                    <input type="button" id="btnInvDraft" runat="server" value="Draft" onclick="this.disabled = true; this.blur(); CompanyX.btnInvDraft_Click();" />
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
    </div>
    </form>
</body>
</html>
