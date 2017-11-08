<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MakeHBL.aspx.cs" Inherits="OceanExport_OEShipment_MakeHBL" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Store runat="server" ID="StoreAssign">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <table cellpadding="3" cellspacing="2">
        <div id="divHBL" runat="server">
            <tr>
                <td colspan="3">
                    <table width="215" height="20" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                        <tr>
                            <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                style="padding-left: 5px">
                                HBL#
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 5px">
                    <ext:Radio runat="server" ID="rdAutoGene" Name="rablist" Width="23px">
                    </ext:Radio>
                </td>
                <td style="padding-top: 3px">
                    Auto Generate
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 5px">
                    <ext:Radio runat="server" ID="rdManual" Name="rablist" Width="23px">
                    </ext:Radio>
                </td>
                <td style="padding-top: 4px">
                    Manual
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="padding: 1px 0;">
                </td>
                <td colspan="2">
                    <ext:TextField runat="server" ID="txtManual" Cls="text" Width="180">
                    </ext:TextField>
                </td>
            </tr>
        </div>
        <div id="divLotNo" runat="server">
            <tr>
                <td colspan="3" style="padding-top: 5px">
                    <table width="215" height="20" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                        <tr>
                            <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                style="padding-left: 5px">
                                Lot#
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 5px">
                    <ext:Radio runat="server" ID="rdNewLot" Name="rablist1" Width="23px">
                    </ext:Radio>
                </td>
                <td style="padding-top: 4px">
                    New Lot
                </td>
                <td style="padding-top: 4px">
                    <ext:Label ID="labVessel" runat="server">
                    </ext:Label>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 5px">
                    <ext:Radio runat="server" ID="rdAssign" Name="rablist1" Width="23px">
                    </ext:Radio>
                </td>
                <td style="padding-top: 4px">
                    Assign To
                </td>
                <td style="padding-top: 4px">
                    <ext:Label ID="labVoyage" runat="server">
                    </ext:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td colspan="2" style="padding-top: 3px">
                    <ext:ComboBox ID="CmbAssign" runat="server" Cls="select" DisplayField="text" ForceSelection="true"
                        Mode="Local" StoreID="StoreAssign" TriggerAction="All" ValueField="text" Width="115">
                        <Template Visible="False" ID="Template1dd" StopIDModeInheritance="False" EnableViewState="False">
                        </Template>
                    </ext:ComboBox>
                </td>
            </tr>
            <tr style="display: none">
                <td style="padding-left: 5px">
                    <ext:Radio runat="server" ID="rdManual1" Name="rablist1" Width="23px">
                    </ext:Radio>
                </td>
                <td style="padding-top: 4px">
                    Manual
                </td>
            </tr>
            <tr style="display: none">
                <td>
                </td>
                <td colspan="2">
                    <ext:TextField runat="server" ID="txtManual1" Cls="text" Width="180">
                    </ext:TextField>
                </td>
            </tr>
        </div>
        <tr>
            <td colspan="3" style="padding-left: 28px; padding-top: 10px">
                <table width="100%">
                    <tr>
                        <td>
                            <ext:Button ID="btnCancel" runat="server" Text="Cancel" Cls="Submit_70px" Width="70px"
                                Height="18px">
                                <DirectEvents>
                                    <Click OnEvent="btnCancel_Click">
                                        <EventMask ShowMask="true" Msg=" Waiting ... " />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                        <td>
                            <ext:Button ID="btnOK" runat="server" Text="OK" Cls="Submit_70px" Width="70px" Height="18px">
                                <DirectEvents>
                                    <Click OnEvent="btnOK_Click">
                                        <EventMask ShowMask="true" Msg=" Waiting ... " />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
