<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OIJobList.aspx.cs" Inherits="OceanImport_OIJobList" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OI Job List </title>
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
        <table width="967" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="5" valign="top" style="padding-top: 10px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td>
                                            OI - Job List
                                        </td>
                                        <td align="right" style="padding-right: 4px; padding-top: 2px">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td background="../../images/btn_bg_01.png" style="width: 6px; height: 19px">
                                                    </td>
                                                    <td background="../../images/btn_bg_02.png">
                                                        <a href="../OceanLot/List.aspx" target="_blank" class="font_11bold_1542af">Add New</a>
                                                    </td>
                                                    <td background="../../images/btn_bg_03.png" style="width: 6px; height: 19px">
                                                    </td>
                                                </tr>
                                            </table>
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
                    <table border="0"  cellpadding="0" width="100%">
                        <tr>
                            <%--<td width="63" height="17" style="padding-left: 2px">
                                Lot No. #
                            </td>
                            <td>
                                <ext:TextField ID="txtLotNo" runat="server" Cls="text_100px" Width="100" TabIndex="1">
                                </ext:TextField>
                            </td>
                            <td>
                                <table width="50px">
                                    <tr>
                                        <td style="padding-left: 8px">
                                            MBL#
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <ext:TextField ID="txtMBL" runat="server" Cls="text_100px" Width="100" TabIndex="2">
                                </ext:TextField>
                            </td>
                            <td>
                                <table width="50px">
                                    <tr>
                                        <td style="padding-left: 8px">
                                            Vessel
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <ext:TextField ID="txtVessel" runat="server" Cls="text_100px" Width="100" TabIndex="3">
                                </ext:TextField>
                            </td>
                            <td width="63" style="padding-left: 2px">
                                POL
                            </td>
                            <td width="100">
                                <ext:TextField ID="txtPOL" runat="server" Cls="text_100px" Width="100" TabIndex="4">
                                </ext:TextField>
                            </td>
                            <td style="padding-left: 10px">
                                POD
                            </td>
                            <td width="100">
                                <ext:TextField ID="txtPOD" runat="server" Cls="text_100px" Width="100" TabIndex="5">
                                </ext:TextField>
                            </td>--%>
                            <td  width="50" align="left">
                                From
                            </td>
                            <td width="100">
                                <ext:DateField ID="txtFrom" runat="server" Width="100" Cls="text_100px" Format="dd/m/Y"
                                    TabIndex="1">
                                </ext:DateField>
                            </td>
                            <td width="60" align="left">
                                    To
                            </td>
                            <td width="110">
                                <ext:DateField ID="txtTo" runat="server" Cls="text_100px" Width="100" Format="dd/m/Y"
                                    TabIndex="2">
                                </ext:DateField>
                            </td>
                            <td width="60" align="left" height="17">
                                Lot #
                            </td>
                            <td align="left" width="110">
                                <ext:TextField ID="txtLotNo" runat="server" Cls="text_100px" Width="100" TabIndex="3" AutoFocus="true">
                                </ext:TextField>
                            </td>
                            <td width="115" align="left">
                                MBL #/HBL #
                            </td>
                            <td width="110" align="left">
                                <ext:TextField ID="txtMBL" runat="server" Cls="text_100px" Width="100" TabIndex="4">
                                </ext:TextField>
                            </td>
                           <td align="left" width="60" >
                                POL/POD
                            </td>
                            <td  width="110" align="right">
                                <ext:TextField ID="txtPOL" runat="server" Cls="text_100px" Width="100" TabIndex="5"> 
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                           <%-- <td style="padding-left: 2px">
                                From
                            </td>
                            <td width="100">
                                <ext:DateField ID="txtFrom" runat="server" Width="100" Cls="text_100px" Format="dd/m/Y"
                                    TabIndex="6">
                                </ext:DateField>
                            </td>
                            <td>
                                <table width="40px">
                                    <tr>
                                        <td style="padding-left: 10px">
                                            To
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="100">
                                <ext:DateField ID="txtTo" runat="server" Cls="text_100px" Width="100" Format="dd/m/Y"
                                    TabIndex="7">
                                </ext:DateField>
                            </td>
                            <td align="center" colspan="6" style=" padding:5px 0px 5px 0">
                                <span style="float: right; margin: 0px 0px 0px 25px">
                                    <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50"
                                        AutoFocus="true" AutoShow="true" Selectable="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnPrint_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </span><span style="float: right">
                                    <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Text=" Search " Width="80"
                                        TabIndex="8" AutoFocus="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnFilter_Click">
                                                <EventMask ShowMask="true" CustomTarget="GridView" />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                        <Enter Handler="btnCancel.fireEvent('click')" />
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
                            <td width="110" align="left">
                               <ext:TextField ID="txtShipper" runat="server" Cls="text" TabIndex="6" Width="100">
                                </ext:TextField>
                            </td>
                            
                             <td width="40px" align="left">
                                            Vessel
                            </td>
                            <td>
                                <ext:TextField ID="txtVessel" runat="server" Cls="text_100px" Width="100" TabIndex="7">
                                </ext:TextField>
                            </td>
                            <td colspan="3"></td>
                            <td width="52" align="right" style="padding-right:12px;">
                                <table width="40" class="table">
                                    <tbody>
                                        <tr>
                                            <td align="center">
                                                <ext:Checkbox ID="chbVoid" runat="server" Width="25px" TabIndex="8">
                                                </ext:Checkbox>
                                            </td>
                                            <td align="right" class="font_11bold">
                                                Void
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                             <td align="center" colspan="2" style=" padding:5px 0px 5px 0">
                                <span style="float: right; margin: 0px 0px 0px 25px">
                                    <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50"
                                        AutoFocus="true" AutoShow="true" Selectable="true" TabIndex="10">
                                        <DirectEvents>
                                            <Click OnEvent="btnPrint_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </span><span style="float: right">
                                    <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Text=" Search " Width="80"
                                        TabIndex="9" AutoFocus="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnFilter_Click">
                                                <EventMask ShowMask="true" CustomTarget="GridView" />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                        <Enter Handler="btnCancel.fireEvent('click')" />
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
                    <ext:GridPanel ID="gridList" runat="server" Height="368" TrackMouseOver="true" TabIndex="14" Width="967"
                        StripeRows="true">
                        <LoadMask ShowMask="true" Msg=" Loading..." />
                        <Store>
                            <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                                AutoLoad="true">
                                <AutoLoadParams>
                                    <ext:Parameter Name="start" Value="={0}" />
                                    <ext:Parameter Name="limit" Value="={100}" />
                                </AutoLoadParams>
                                <Reader>
                                    <ext:JsonReader IDProperty="RowID">
                                        <Fields>
                                            <ext:RecordField Name="seed">
                                            </ext:RecordField>
                                            <ext:RecordField Name="ETD" Type="Date">
                                            </ext:RecordField>
                                            <ext:RecordField Name="ETA" Type="Date">
                                            </ext:RecordField>
                                            <ext:RecordField Name="LotNo" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="POL" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="POD" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="MBL" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Vessel" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Voyage" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="ServiceMode" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="PPCC" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="OceanSeed" Type="String">
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
                                <ext:RowNumbererColumn Header="No." Width="30" Align="Center">
                                </ext:RowNumbererColumn>
                                <ext:DateColumn Header="ETD" DataIndex="ETD" Width="78" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:DateColumn Header="ETA" DataIndex="ETA" Width="78" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:Column Header="Lot No.#" DataIndex="LotNo" Width="133">
                                </ext:Column>
                                <ext:Column Header="POL" DataIndex="POL" Width="35" Align="Center">
                                </ext:Column>
                                <ext:Column Header="POD" DataIndex="POD" Width="37" Align="Center">
                                </ext:Column>
                                <ext:Column Header="MBL No. #" DataIndex="MBL" Width="132">
                                </ext:Column>
                                <ext:Column Header="Vessel" DataIndex="Vessel" Width="70" Align="left">
                                </ext:Column>
                                <ext:Column Header="Voyage" DataIndex="Voyage" Width="70">
                                </ext:Column>
                                <ext:Column Header="Service Mode" DataIndex="ServiceMode" Width="85">
                                </ext:Column>
                                <ext:Column Header="P/C" DataIndex="PPCC" Width="36" Align="Center">
                                </ext:Column>
                                <ext:CheckColumn Header="Void" DataIndex="Void" Width="45">
                                </ext:CheckColumn>
                                <ext:Column Header="Action" DataIndex="OceanSeed" Width="47" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Cost" DataIndex="LockCost" Width="65" Align="Center" Hidden="true">
                                </ext:Column>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="RowSelectionModel1" SingleSelect="true">
                                <Listeners>
                                    <RowSelect Handler="getRowIndex(rowIndex)" />
                                </Listeners>
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