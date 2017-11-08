<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="AirImport_AIShipmentJobList_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AI Shipment List </title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/LockCost.js" type="text/javascript"></script>

    <script type="text/javascript">
        function Reload() {
            var obj = document.getElementById("btnFilter");
            if (obj != "" && obj != undefined && obj != null) {

                Ext.getCmp('btnFilter').fireEvent('click', this);
            };
        }
    </script>
    <style type="text/css">
         input[type="checkbox"] {
        height: 13px !important;
         width: 13px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div style="width: 969px; margin-top: 10px; margin-left: 13px">
        <table width="969px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="81b8ff">
            <tbody>
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="965px" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td width="680" align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                        AI - Shipment List
                                    </td>
                                    <td width="288" align="right" valign="top" style="padding-bottom: 2px; padding-right: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="padding-top: 3px">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td background="../../images/btn_bg_01.png" style="width: 7px; height: 19px">
                                                            </td>
                                                            <td background="../../images/btn_bg_02.png" align="left" style="padding-left: 5px;
                                                                padding-right: 5px">
                                                                <a href="mawb.aspx" target="_blank" class="font_11bold_1542af">Add New</a>
                                                            </td>
                                                            <td background="../../images/btn_bg_03.png" style="width: 7px; height: 19px">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="padding-top: 3px; padding-left: 3px">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td background="../../images/btn_bg_01.png" style="width: 7px; height: 19px">
                                                            </td>
                                                            <td background="../../images/btn_bg_02.png" align="left" style="padding-left: 5px;
                                                                padding-right: 5px">
                                                                <a href="#" class="font_11bold_1542af">New From AE</a>
                                                            </td>
                                                            <td background="../../images/btn_bg_03.png" style="width: 7px; height: 19px">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table width="969" class="table" style="padding: 8px 0">
            <tbody>
                 <%-- 2014-12-16 Grace (修改查询条件) --%>
                <tr>
                    <td width="50" align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        From
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="110" align="left">
                        <ext:DateField ID="txtFrom" runat="server" Cls="text" Format="dd/m/Y" Width="100"
                            TabIndex="1">
                        </ext:DateField>
                    </td>
                    <td width="50" align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" >
                                        To
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="115" align="left">
                        <ext:DateField ID="txtTo" runat="server" Cls="text" Format="dd/m/Y" Width="100"
                            TabIndex="2">
                        </ext:DateField>
                    </td>
                    <td width="50" align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Lot #
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td align="left" width="115">
                        <ext:TextField ID="txtLotNo" runat="server" Cls="text" Width="100" TabIndex="3" AutoFocus="true">
                        </ext:TextField>
                    </td>
                    <td width="115" align="left">
                        <table width="115" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        MAWB #/HAMB #
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="115" align="left">
                        <ext:TextField ID="txtMawb" runat="server" Cls="text" TabIndex="4" Width="100">
                        </ext:TextField>
                    </td>
                    <td align="left">
                        <table width="60" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="left">
                                        Depart/Dest
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="117" align="right">
                        <ext:TextField ID="txtDest" runat="server" Cls="text" TabIndex="5" Width="100">
                        </ext:TextField>
                    </td>
                </tr>
                <tr>
                 <%-- 2014-12-16 Grace (修改查询条件) --%>
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
                    <td width="115" align="left">
                       <ext:TextField ID="txtShipper" runat="server" Cls="text" TabIndex="6" Width="100">
                        </ext:TextField>
                    </td>
                     <td width="120" align="left"colspan="4">
                    </td>
                    <td colspan="2" align="left" width="180">
                         <table class="table" border="0">
                            <tbody>
                                <tr>
                                    <td align="left" width="70px" class="font_11bold">
                                        <ext:Checkbox ID="chbNormal" runat="server" Width="13px" Checked="true" TabIndex="7" BoxLabelStyle="position:absolute;left:570px;top:83px;" BoxLabel="Normal">
                                        </ext:Checkbox>
                                    </td>
                                    <td align="left" width="64px" class="font_11bold">
                                        <ext:Checkbox ID="chbDirect" runat="server" Width="13px" Checked="true" TabIndex="8" BoxLabelStyle="position:absolute;left:643px;top:83px;" BoxLabel="Direct">
                                        </ext:Checkbox>
                                    </td>
                                    <td align="left" width="70px" style="display: none" class="font_11bold">
                                        <ext:Checkbox ID="chbClosed" runat="server" Width="13px" Checked="true" TabIndex="9" BoxLabelStyle="position:absolute;left:705px;top:83px;" BoxLabel="Closed">
                                        </ext:Checkbox>
                                    </td>
                                    <td align="left"  width="70px" class="font_11bold">
                                        <ext:Checkbox ID="chbVoid" runat="server" Width="13px" TabIndex="10" BoxLabelStyle="position:absolute;left:707px;top:83px;" BoxLabel="Void">
                                        </ext:Checkbox>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td align="right" colspan="3" style="padding-top: 2px">
                        <span style="float: right; margin-left: 25px; margin-right: 1px">
                            <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50"
                                TabIndex="12" AutoFocus="true" AutoShow="true" Selectable="true">
                                <DirectEvents>
                                    <Click OnEvent="btnPrint_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </span><span style="float: right">
                            <ext:Button ID="btnFilter" runat="server" Cls="Submit" Text=" Search " Width="80"
                                AutoFocus="true" TabIndex="11" AutoShow="true" Selectable="true">
                                <DirectEvents>
                                    <Click OnEvent="btnFilter_Click">
                                        <EventMask ShowMask="true" Msg="  Searching ... "  CustomTarget="gridList" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                <Enter Handler="btnFilter.fireEvent('click');" />
                            </ext:KeyNav>
                        </span>
                    </td>
                </tr>
            </tbody>
        </table>
        <ext:GridPanel ID="gridList" runat="server" Width="969px" Height="368" TrackMouseOver="true"
            StripeRows="true" ColumnLines="True">
            <LoadMask ShowMask="true" Msg=" Loading..." />
            <Store>
                <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                    AutoLoad="true">
                    <AutoLoadParams>
                        <ext:Parameter Name="start" Value="={0}" />
                        <ext:Parameter Name="limit" Value="={100}" />
                    </AutoLoadParams>
                    <Listeners>
                    </Listeners>
                    <Reader>
                        <ext:JsonReader IDProperty="RowID">
                            <Fields>
                                <ext:RecordField Name="Direct" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="LotNo" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="MAWB" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Shipper" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Consignee" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Flight" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Arrival" Type="Date">
                                </ext:RecordField>
                                <ext:RecordField Name="From" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="To" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="GWT" Type="Float">
                                </ext:RecordField>
                                <ext:RecordField Name="CWT" Type="Float">
                                </ext:RecordField>
                                <ext:RecordField Name="Closed" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="Void" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="AirSeed" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="seed" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="LockCost" Type="String">
                                </ext:RecordField>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel runat="server" ID="ColumnModel1">
                <Columns>
                    <ext:RowNumbererColumn Header="No." Width="30" Fixed="true">
                    </ext:RowNumbererColumn>
                    <ext:CheckColumn Header="Direct" DataIndex="Direct" Width="45">
                    </ext:CheckColumn>
                    <ext:Column Header="Lot No." DataIndex="LotNo" Width="95">
                    </ext:Column>
                    <ext:Column Header="MAWB" DataIndex="MAWB" Width="95">
                    </ext:Column>
                    <ext:Column Header="Shipper" DataIndex="Shipper" Width="108">
                    </ext:Column>
                    <ext:Column Header="Consignee" DataIndex="Consignee" Width="110">
                    </ext:Column>
                    <ext:Column Header="Flight No." DataIndex="Flight" Width="65">
                    </ext:Column>
                    <ext:DateColumn Header="Arrival" DataIndex="Arrival" Width="78" Format="dd/m/Y" Align="Center">
                    </ext:DateColumn>
                    <ext:Column Header="From " DataIndex="From" Width="40" Align="Center">
                    </ext:Column>
                    <ext:Column Header="To " DataIndex="To" Width="35" Align="Center">
                    </ext:Column>
                    <ext:NumberColumn Header="GWT" DataIndex="GWT" Width="58" Format="0.0" Align="Right">
                    </ext:NumberColumn>
                    <ext:NumberColumn Header="CWT" DataIndex="CWT" Width="58" Format="0.0" Align="Right">
                    </ext:NumberColumn>
                    <ext:CheckColumn Header="Closed " DataIndex="Closed" Width="48">
                    </ext:CheckColumn>
                    <ext:CheckColumn Header="Void" DataIndex="Void" Width="35">
                    </ext:CheckColumn>
                    <ext:Column Header="Action" DataIndex="AirSeed" Width="47" Align="Center">
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
                <ext:PagingToolbar StoreID="storeList" PageSize="100" DisplayInfo="true" ID="PagingToolbar1"
                    runat="server">
                </ext:PagingToolbar>
            </BottomBar>
        </ext:GridPanel>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        setGridSize();
    });
</script>