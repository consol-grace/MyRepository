<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="AirExport_AEViewConsol_List" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>AE View Consol</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="Transfer.js" type="text/javascript"></script>
    
    <script src="../../common/UIControls/LockCost.js" type="text/javascript"></script>
    <script type="text/javascript">
        function RefreshList() {
            Ext.getCmp('btnFilter').fireEvent('click', this);
        }
    </script> 

    <style type="text/css">
        .bottom_line
        {
            color: #000;
            border: solid 1px #B5B8C8 !important;
            border-bottom: solid 1px #B5B8C8 !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div style="width: 970px; margin-top: 10px; margin-left: 13px">
        <table width="970px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tbody>
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="960px" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                        AE - View Consol
                                    </td>
                                    <td width="288" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table class="table" style="padding: 8px 0">
            <tbody>
                <%-- 2014-12-16 Grace (修改查询条件) --%>
               <%-- <tr>
                    <td width="40" align="left">
                        <table width="40" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Lot#
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="100" align="left">
                        <ext:TextField ID="txtLotNo" runat="server" Cls="text" TabIndex="1" Width="100">
                        </ext:TextField>
                    </td>
                    <td width="60" align="left">
                        <table width="70" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="center">
                                        MAWB No.
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="110" align="left">
                        <ext:TextField ID="txtMAWB" runat="server" Cls="text" TabIndex="2" Width="100">
                        </ext:TextField>
                    </td>
                    <td align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="left">
                                        Dest.
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                        <ext:TextField ID="txtDest" runat="server" Cls="text" TabIndex="3" Width="100">
                        </ext:TextField>
                    </td>
                    <td width="80" align="left">
                        <table width="75" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="center">
                                        Flight From
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                        <ext:DateField ID="txtFlightFrom" runat="server" Cls="text" Format="dd/m/Y" Width="90"
                            TabIndex="4">
                        </ext:DateField>
                    </td>
                    <td width="65" align="left">
                        <table width="65" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="center">
                                        Flight To
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                        <ext:DateField ID="txtFlightTo" runat="server" Cls="text" Format="dd/m/Y" Width="90"
                            TabIndex="5">
                        </ext:DateField>
                    </td>
                    <td width="20" align="left">
                    </td>
                </tr>--%>
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
                        <ext:DateField ID="txtFlightFrom" runat="server" Cls="text" Format="dd/m/Y" Width="100"
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
                    <td width="110" align="left">
                        <ext:DateField ID="txtFlightTo" runat="server" Cls="text" Format="dd/m/Y" Width="100"
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
                    <td width="110" align="left">
                        <ext:TextField ID="txtLotNo" runat="server" Cls="text" TabIndex="3" Width="100"  AutoFocus="true">
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
                    <td width="110" align="left">
                        <ext:TextField ID="txtMAWB" runat="server" Cls="text" TabIndex="4" Width="100">
                        </ext:TextField>
                    </td>
                    <td align="left" width="80">
                        <table width="80" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="left">
                                        Depart/Dest
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="115" align="right">
                        <ext:TextField ID="txtDest" runat="server" Cls="text" TabIndex="5" Width="100">
                        </ext:TextField>
                    </td>
                </tr>
                <tr>
                    <%-- 2014-12-16 Grace (修改查询条件) --%>
                   <%-- <td width="40" align="left">
                        <table width="40" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Shipper
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="100" align="left">
                        <uc1:AutoComplete runat="server" ID="cmbShipperCode" TabIndex="6" clsClass="x-form-text x-form-field text"
                            Query="option=CompanyList" Width="73" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" isDiplay="false" />
                    </td>
                    <td>
                        <table width="70" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Consignee
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="110px" align="left">
                        <uc1:AutoComplete runat="server" ID="cmbConsigneeCode" TabIndex="7" clsClass="x-form-text x-form-field text"
                            Query="option=CompanyList" Width="73" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" isDiplay="false" />
                    </td>
                    <td align="left">
                        <table width="60px" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="left">
                                        Co-loader
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                        <uc1:AutoComplete runat="server" ID="CmbColoader" TabIndex="8" clsClass="x-form-text x-form-field text"
                            Query="option=CompanyList" Width="73" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" isDiplay="false" />
                    </td>
                    <td width="80" align="left">
                        <table width="75" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="center">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                    </td>
                    <td width="" align="right" colspan="2">
                        <span style="float: right; margin-left:18px;">
                            <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50"
                                AutoFocus="true" AutoShow="true" Selectable="true">
                                <DirectEvents>
                                    <Click OnEvent="btnPrint_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </span><span style="float: right;">
                            <ext:Button ID="btnFilter" runat="server" Cls="Submit" Text="Search" Width="80" AutoFocus="true"
                                AutoShow="true" Selectable="true" TabIndex="9">
                                <DirectEvents>
                                    <Click OnEvent="btnFilter_Click">
                                        <EventMask ShowMask="true" Msg="Searching..." CustomTarget="gridList" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </span>
                        <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                            <Enter Handler="btnFilter.fireEvent('click');" />
                        </ext:KeyNav>
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
                    
                     <td align="left">
                        <table width="70px" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" align="left">
                                        Co-loader
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="110" align="left">
                            <ext:TextField ID="txtColoader" runat="server" Cls="text" TabIndex="7" Width="100">
                         </ext:TextField>
                    </td>
                     <td width="120" align="left"colspan="3">
                    </td>
                     <td width="50" align="right" style="padding-right:5px;">
                        <table width="40" class="table">
                            <tbody>
                                <tr>
                                    <td align="right">
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
                    <td align="right" colspan="2">
                        <span style="float: right; margin-left:23px;">
                            <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50"
                                AutoFocus="true" AutoShow="true" Selectable="true" TabIndex="10">
                                <DirectEvents>
                                    <Click OnEvent="btnPrint_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </span><span style="float: right;">
                            <ext:Button ID="btnFilter" runat="server" Cls="Submit" Text="Search" Width="80" AutoFocus="true"
                                AutoShow="true" Selectable="true" TabIndex="9">
                                <DirectEvents>
                                    <Click OnEvent="btnFilter_Click">
                                        <EventMask ShowMask="true" Msg="Searching..." CustomTarget="gridList" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </span>
                        <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                            <Enter Handler="btnFilter.fireEvent('click');" />
                        </ext:KeyNav>
                    </td>

                </tr>
            </tbody>
        </table>
        <ext:GridPanel ID="gridList" runat="server" Width="970px"  TrackMouseOver="true" Height="368" 
            StripeRows="true" ColumnLines="True" >
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
                                <ext:RecordField Name="RowID" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Direct" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="CoLoad" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="Sell" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="LotNo" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="MAWB" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="FlightDate" Type="Date">
                                </ext:RecordField>
                                <ext:RecordField Name="Dest" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="FlightNo" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="GWT" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="VWT" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="CWT" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Print" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="House" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="DN" Type="Boolean">
                                </ext:RecordField>
                                <ext:RecordField Name="AESeed" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Exported" Type="String"></ext:RecordField>
                                <ext:RecordField Name="LockCost" Type="String"></ext:RecordField>
                                <ext:RecordField Name="Void" Type="Boolean"></ext:RecordField>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel runat="server" ID="ColumnModel1">
                <Columns>
                    <ext:CheckColumn DataIndex="CoLoad" Header="Out" Width="32" Align="Center">
                    </ext:CheckColumn>
                    <ext:CheckColumn DataIndex="Sell" Header="Sell" Width="30" Align="Center">
                    </ext:CheckColumn>
                    <ext:CheckColumn DataIndex="Direct" Header="Direct" Width="45" Align="Center">
                    </ext:CheckColumn>
                    <ext:Column Header="Lot#" DataIndex="LotNo" Width="95" Align="Center">
                    </ext:Column>
                    <ext:Column Header="MAWB No." DataIndex="MAWB" Width="110">
                    </ext:Column>
                    <ext:DateColumn Header="Flight Date" DataIndex="FlightDate" Width="78" Format="dd/MM/yyyy"
                        Align="Center">
                    </ext:DateColumn>
                    <ext:Column Header="Dest." DataIndex="Dest" Width="45" Align="Center">
                    </ext:Column>
                    <ext:Column Header="Flight No." DataIndex="FlightNo" Width="80">
                    </ext:Column>
                    <ext:NumberColumn Header="G.WT" DataIndex="GWT" Width="92" Format="0.000" Align="Right">
                    </ext:NumberColumn>
                    <ext:NumberColumn Header="V.WT" DataIndex="VWT" Width="92" Format="0.000" Align="Right">
                    </ext:NumberColumn>
                    <ext:NumberColumn Header="C.WT" DataIndex="CWT" Width="92" Format="0.000" Align="Right">
                    </ext:NumberColumn>
                   <%-- <ext:CheckColumn DataIndex="Printed" Header="Print" Width="38" Align="Center">
                    </ext:CheckColumn>
                    <ext:CheckColumn DataIndex="House" Header="House" Width="45" Align="Center">
                    </ext:CheckColumn>
                    <ext:CheckColumn DataIndex="DN" Header="DN" Width="30" Align="Center">
                    </ext:CheckColumn>--%>
                     <ext:CheckColumn  Header="Void" DataIndex="Void" Width="45" ></ext:CheckColumn>
                    <ext:Column Header="Action" DataIndex="AESeed" Width="48" Align="Center">
                    </ext:Column>
                    <ext:Column Header="Transfer" DataIndex="Exported" Width="65" Align="Center" Css="font-weight:bold;"></ext:Column>  
                    <ext:Column Header="Cost" DataIndex="LockCost" Width="65" Align="Center" Hidden="true"></ext:Column>            
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
                </ext:RowSelectionModel>
            </SelectionModel>
            <%-- <Listeners>
                <RowClick Handler="var model=Ext.getCmp('gridList').getSelectionModel();if(model.isSelected(rowIndex)){model.deselectRow(rowIndex,true);} else{model.selectRow(rowIndex);}" />
            </Listeners>--%>
            <BottomBar>
                <ext:PagingToolbar PageSize="100" DisplayInfo="true" ID="PagingToolbar1" runat="server">
                </ext:PagingToolbar>
            </BottomBar>
        </ext:GridPanel>
      <%--  <table width="823px" class="table" style="padding: 8px 0" cellpadding="0" cellspacing="0"
            border="0">
            <tr>
                <td width="90%">
                </td>
                <td>
                </td>
            </tr>
        </table>--%>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        setGridSize();

    });
</script>