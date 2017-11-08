<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="Triangle_ShipmentList_List" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Tran. Shipment List</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/LockCost.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div style="margin-left: 13px">
        <table width="968" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="5" valign="top" style="padding-top: 10px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="table_nav1 font_11bold_1542af" style="padding-left: 10px">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td>
                                            Tran. Shipment List
                                        </td>
                                        <td align="right" class="nav_menu_5" style="padding-bottom: 2px; padding-right: 2px">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="10px" colspan="5">
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <table border="0" cellspacing="0" cellpadding="0" width="100%" class="table_24">
                        <tr>
                           <%-- <td width="50px" style="padding-right: 8px; padding-left: 10px" align="left">
                                Lot No.#
                            </td>
                            <td align="left">
                                <ext:TextField ID="txtLotNo" runat="server" Cls="text_100px" Width="120" TabIndex="1">
                                </ext:TextField>
                            </td>
                            <td align="left" style="padding-left: 10px">
                                MBL #
                            </td>
                            <td align="left">
                                <ext:TextField ID="txtMBL" runat="server" Cls="text_100px" Width="120" TabIndex="2">
                                </ext:TextField>
                            </td>
                            <td width="70" align="left" style="padding-left: 10px">
                                HBL #
                            </td>
                            <td align="left">
                                <ext:TextField ID="txtHBL" runat="server" Cls="text_100px" Width="120" TabIndex="3">
                                </ext:TextField>
                            </td>
                         
                              <td style="padding-left: 10px;" align="left">
                                Consignee
                            </td>
                            <td width="100" align="left">
                                <ext:TextField ID="txtCNEE" runat="server" Cls="text_100px" Width="120" TabIndex="5">
                                </ext:TextField>
                            </td>--%>
                            <td align="left" width="50">
                                From
                            </td>
                            <td align="left"  width="115">
                                <ext:DateField ID="txtFrom" runat="server" Cls="text_100px" Width="100" Format="dd/m/Y"
                                    TabIndex="1">
                                </ext:DateField>
                            </td>
                              <td align="left" width="50">
                                To
                            </td>
                            <td align="left"  width="115">
                                <ext:DateField ID="txtTo" runat="server" Cls="text_100px" Width="100" Format="dd/m/Y"
                                    TabIndex="2">
                                </ext:DateField>
                            </td>
                            <td width="55px" align="left">
                                Lot #
                            </td>
                            <td align="left" width="115">
                                <ext:TextField ID="txtLotNo" runat="server" Cls="text_100px" Width="100" TabIndex="3" AutoFocus="true">
                                </ext:TextField>
                            </td>
                            <td width="115" align="left">
                                MBL #/HBL #
                            </td>
                            <td width="115" align="left">
                                <ext:TextField ID="txtMBL" runat="server" Cls="text_100px" Width="100" TabIndex="4">
                                </ext:TextField>
                            </td>
                          <td  width="50" align="left">
                        <table width="50">
                                        Depart/Dest
                        </table>
                    </td>
                    <td width="115" align="right">
                        <ext:TextField ID="txtDest" runat="server" Cls="text" TabIndex="5" Width="100">
                        </ext:TextField>
                    </td>
                        </tr>
                        <tr>
                           <%-- <td width="63" style="padding-right: 8px; padding-left: 10px;text-align: left;">
                                Shipper
                            </td>
                            <td width="100" align="left">
                                <ext:TextField ID="txtShipper" runat="server" Cls="text_100px" Width="120" TabIndex="6">
                                </ext:TextField>
                            </td>
                          
                            <td style="padding-right: 8px; padding-left: 10px" align="left">
                                From
                            </td>
                            <td align="left">
                                <ext:DateField ID="txtFrom" runat="server" Cls="text_100px" Width="120" Format="dd/m/Y"
                                    TabIndex="6">
                                </ext:DateField>
                            </td>
                              <td style="padding-right: 8px; padding-left: 10px" align="left">
                                To
                            </td>
                            <td align="left">
                                <ext:DateField ID="txtTo" runat="server" Cls="text_100px" Width="120" Format="dd/m/Y"
                                    TabIndex="6">
                                </ext:DateField>
                            </td>
                            <td  colspan="2" align="left" style="padding-top: 8px; padding-bottom: 5px; padding-left: 5px;
                                width: 200px">
                              <span style="float: right; margin: 0px 0px 0px 25px">
                                    <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50" TabIndex="8"
                                        AutoFocus="true" AutoShow="true" Selectable="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnPrint_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </span>
                                <span style="float: right">
                                    <ext:Button ID="btnFilter" runat="server" Cls="Submit_65px" Text="Search" Width="80"
                                        TabIndex="7" AutoFocus="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnFilter_Click">
                                                <EventMask ShowMask="true" CustomTarget="GridView" />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                        <Enter Handler="btnFilter.fireEvent('click')" />
                                    </ext:KeyNav>
                                </span>
                            </td>--%>
                                <td width="80" align="left">
                                <table width="80" cellpadding="3">
                                    <tbody>
                                        <tr>
                                            <td class="font_11bold">
                                                SHPR/CNEE
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                            <td width="105" align="left">
                               <ext:TextField ID="txtShipper" runat="server" Cls="text" TabIndex="6" Width="100">
                                </ext:TextField>
                            </td>
                            
                            <td colspan="5"></td>
                            <td width="52" align="right" style="padding-right:9px;">
                                <table width="40" class="table">
                                    <tbody>
                                        <tr>
                                            <td align="center">
                                                <ext:Checkbox ID="chbVoid" runat="server" Width="25px" TabIndex="7">
                                                </ext:Checkbox>
                                            </td>
                                            <td align="right" class="font_11bold">
                                                Void
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                             <td  colspan="2" align="left" style="padding-top: 8px; padding-bottom: 5px; padding-left: 5px;
                                width: 200px">
                              <span style="float: right; margin: 0px 0px 0px 25px">
                                    <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50" TabIndex="9"
                                        AutoFocus="true" AutoShow="true" Selectable="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnPrint_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </span>
                                <span style="float: right">
                                    <ext:Button ID="btnFilter" runat="server" Cls="Submit_65px" Text="Search" Width="80"
                                        TabIndex="8" AutoFocus="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnFilter_Click">
                                                <EventMask ShowMask="true" CustomTarget="GridView" />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                        <Enter Handler="btnFilter.fireEvent('click')" />
                                    </ext:KeyNav>
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="10" colspan="5">
                </td>
            </tr>
            <tr>
                <td colspan="5" id="GridView">
                    <ext:GridPanel ID="gridList" runat="server" Height="368" TrackMouseOver="true" TabIndex="14"
                        StripeRows="true" Width="968">
                        <LoadMask ShowMask="true" Msg=" Loading..." />
                        <Store>
                            <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                                AutoLoad="true">
                                <AutoLoadParams>
                                    <ext:Parameter Name="start" Value="={0}" />
                                    <ext:Parameter Name="limit" Value="={100}" />
                                </AutoLoadParams>
                                <Reader>
                                    <ext:JsonReader IDProperty="tri_Seed">
                                        <Fields>
                                            <ext:RecordField Name="Type" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_MBL" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_HBL" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_LotNo" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_ETD" Type="Date">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_ETA" Type="Date">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_ShipperLine" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_ConsigneeLine" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_LocReceived" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_LocFinal" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="tri_Seed">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Detail" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="LockCost" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Void" Type="Boolean">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel runat="server" ID="ColumnModel1">
                            <Columns>
                                <ext:Column Header="Type" DataIndex="Type" Width="48" Align="left">
                                </ext:Column>
                                <ext:Column Header="MBL/MAWB" DataIndex="tri_MBL" Width="110">
                                </ext:Column>
                                <ext:Column Header="HBL/HAWB" DataIndex="tri_HBL" Width="110">
                                </ext:Column>
                                <ext:Column Header="Lot#" DataIndex="tri_LotNo" Width="130">
                                </ext:Column>
                                <ext:Column Header="Shipper" DataIndex="tri_ShipperLine" Width="125">
                                </ext:Column>
                                <ext:Column Header="Consignee" DataIndex="tri_ConsigneeLine" Width="125">
                                </ext:Column>
                                <ext:DateColumn Header="ETD" DataIndex="tri_ETD" Width="78" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:DateColumn Header="ETA" DataIndex="tri_ETA" Width="78" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:Column Header="Depart." DataIndex="tri_LocReceived" Width="55" Align="left">
                                </ext:Column>
                                <ext:Column Header="Dest." DataIndex="tri_LocFinal" Width="45" Align="left">
                                </ext:Column>
                                <ext:CheckColumn Header="Void" DataIndex="Void" Width="35">
                                </ext:CheckColumn>
                                <ext:Column Header="Action" DataIndex="Detail" Width="48" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Cost" DataIndex="LockCost" Width="64" Align="Center" Hidden="true">
                                </ext:Column>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="RowSelectionModel1" SingleSelect="true">
                            </ext:RowSelectionModel>
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar StoreID="storeList" PageSize="100" runat="server" ID="PagingToolbar1"
                                AfterPageText="&nbsp;of {0}" BeforePageText=" Page " DisplayMsg="Displaying {0} - {1} of  {2} "
                                EmptyMsg="No Data">
                            </ext:PagingToolbar>
                        </BottomBar>
                    </ext:GridPanel>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        setGridSize();
    });
</script>