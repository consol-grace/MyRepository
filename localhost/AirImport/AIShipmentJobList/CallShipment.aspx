<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CallShipment.aspx.cs" Inherits="AirImport_AIShipmentJobList_CallShipment" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script> 
    <script language="javascript" type="text/javascript">
        var FormatNumber3 = function(obj) {
            if (obj != null) {
                return obj.toFixed(3);
            }
        }
    </script>

</head>
<body  style=" width:100%; height:100%">
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div>
        <ext:Window ID="Window1" runat="server" Resizable="false" Height="180" Title="Call Form"  Closable="false"
            Draggable="true" Width="230" Modal="false" Padding="6" PageY="150" PageX="200">
            <Content>
                <table cellpadding="3" cellspacing="2">
                    <tr>
                        <td  style="padding-bottom:4px"><ext:Radio runat="server" ID="rdLot" Name="rablist" Checked="true"  Width="23px"></ext:Radio></td>
                        <td class="font_11px">
                            Lot No.
                        </td>
                        <td>
                            <ext:TextField runat="server" ID="txtLot" TabIndex="1" Cls="text_80px" Width="128" AutoFocus="true">
                                <Listeners>
                                    <Focus Handler="CompanyX.Check('rdLot')" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom:4px"><ext:Radio runat="server" ID="rdMawb" Name="rablist" Width="23px"></ext:Radio></td>
                        <td  class="font_11px">
                            MAWB
                        </td>
                        <td>
                            <ext:TextField runat="server" ID="txtMawb" TabIndex="2" Cls="text_80px" Width="128">
                                <Listeners>
                                    <Focus Handler="CompanyX.Check('rdMawb')" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td   style="padding-bottom:4px"><ext:Radio runat="server" ID="rdHawb" Name="rablist" Width="23px"></ext:Radio></td>
                        <td class="font_11px">
                            HAWB
                        </td>
                        <td>
                            <ext:TextField runat="server" ID="txtHawb" TabIndex="3" Cls="text_80px" Width="128">
                                <Listeners>
                                    <Focus Handler="CompanyX.Check('rdHawb')" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td  style="padding-bottom:7px"><ext:Radio runat="server" ID="rdInvoice" Name="rablist" Width="23px"></ext:Radio></td>
                        <td class="font_11px" style="padding-right:4px">
                            Invoice 
                        </td>
                        <td>
                            <ext:TextField runat="server" ID="txtInvoice" TabIndex="4" Cls="text_80px" Width="128">
                                <Listeners>
                                    <Focus Handler="CompanyX.Check('rdInvoice')" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <table cellpadding="0" cellspacing="0" border="0" width="100%" >
                                <tr>
                                    <td style="width:100%"></td>
                                    <td>
                                        <ext:Button ID="btnDetail" runat="server" Text="Open" Cls="Submit_70px" Width="57px" Height="18px">
                                            <DirectEvents>
                                                <Click OnEvent="btnDetail_Click">
                                                    <EventMask ShowMask="true" Msg=" Waiting ... " />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td style="padding-left:4px">
                                        <ext:Button ID="btnLotlist" runat="server" Text="Lot Detail" Cls="Submit_70px" Width="62px"  Height="18px"> 
                                            <DirectEvents>
                                                <Click OnEvent="btnLotlist_Click">
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
            </Content>
        </ext:Window>
        
    </div>
    </form>
</body>
</html>
