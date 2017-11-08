<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="OceanExport_OEJobList_List" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>OE Job List </title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../AirExport/AEViewConsol/Transfer.js" type="text/javascript"></script>

    <script src="../../common/UIControls/LockCost.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
        </ext:ResourceManager>
        <ext:Store runat="server" ID="StoreOP" OnRefreshData="StoreOP_OnRefreshData">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="text">
                        </ext:RecordField>
                        <ext:RecordField Name="value">
                        </ext:RecordField>
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <div style="margin-left: 13px">
            <table width="680" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="5" valign="top" style="padding-top: 10px">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>OE - Job List
                                            </td>
                                            <td align="right" class="nav_menu_5" style="padding-bottom: 2px; padding-right: 2px">
                                                <%--  <a href="../OceanLot/List.aspx" target="_blank">Add New</a>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10px" colspan="5"></td>
                </tr>
                <tr>
                    <td colspan="5">
                        <table border="0" cellpadding="0">
                            <tr>
                                <%-- <td width="70" height="17" style="padding-left: 2px">
                                Lot No. #
                            </td>
                            <td>
                                <ext:TextField ID="txtLotNo" runat="server" Cls="text_100px" Width="100"  TabIndex="1"> 
                                </ext:TextField>
                            </td>
                            <td style=" text-align:center;padding-right:5px " width="50">
                                MBL#
                            </td>
                            <td>
                                <ext:TextField ID="txtMBL" runat="server" Cls="text_100px" Width="100" TabIndex="2">
                                </ext:TextField>
                            </td>
                            <td style="padding-right:5px" align="center" width="50">
                                Dest
                            </td>
                            <td>
                                <ext:TextField ID="txtDest" runat="server" Cls="text_100px" Width="100" TabIndex="3"> 
                                </ext:TextField>
                            </td>
                       
                            <td width="60" style="padding-left: 2px" align="center">
                                From
                            </td>
                            <td width="100">
                                <ext:DateField ID="txtETDFrom" runat="server" Width="100" Cls="text_100px"  Format="dd/m/Y" TabIndex="6">
                                </ext:DateField>
                            </td>
                            <td width="50" style="padding-left:5px"  align="center">
                                 To
                            </td>
                            <td width="100">
                                 <ext:DateField ID="txtETDTo" runat="server" Cls="text_100px" Width="100"  Format="dd/m/Y" TabIndex="7">
                                </ext:DateField>
                            </td>
                            <td width="47">
                                
                            </td>
                            <td width="80">
                              <ext:Button ID="btnFilter" runat="server" Cls="Submit_65px" Text="Search" Width="65" TabIndex="8"
                                    AutoFocus="true">
                                    <DirectEvents>
                                        <Click OnEvent="btnFilter_Click">
                                            <EventMask ShowMask="true" CustomTarget="GridView" />
                                        </Click>
                                    </DirectEvents>  
                                </ext:Button>
                                 <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                        <enter handler="btnFilter.fireEvent('click')" />
                                    </ext:KeyNav>  
                            </td>
                            <td width="25">
                                <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50" AutoFocus="true"
                            AutoShow="true" Selectable="true">
                            <DirectEvents>
                                <Click OnEvent="btnPrint_Click">                                  
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                            </td>--%>
                                <td width="50" align="left">From
                                </td>
                                <td width="115">
                                    <ext:DateField ID="txtETDFrom" runat="server" Width="100" Cls="text_100px" Format="dd/m/Y" TabIndex="1">
                                    </ext:DateField>
                                </td>
                                <td width="60" align="left">To
                                </td>
                                <td width="115" align="left">
                                    <ext:DateField ID="txtETDTo" runat="server" Cls="text_100px" Width="100" Format="dd/m/Y" TabIndex="2">
                                    </ext:DateField>
                                </td>
                                <td width="60" align="left">Lot #
                                </td>
                                <td align="left" width="115">
                                    <ext:TextField ID="txtLotNo" runat="server" Cls="text_100px" Width="100" TabIndex="3" AutoFocus="true">
                                    </ext:TextField>
                                </td>
                                <td width="110">MBL #/HBL #
                                </td>
                                <td width="115" align="left">
                                    <ext:TextField ID="txtMBL" runat="server" Cls="text_100px" Width="100" TabIndex="4">
                                    </ext:TextField>
                                </td>
                                <td align="left" width="60">POL/POD
                                </td>
                                <td width="115" align="right">
                                    <ext:TextField ID="txtDest" runat="server" Cls="text_100px" Width="100" TabIndex="5">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td width="90" align="left">
                                    <table width="90" cellpadding="3">
                                        <tbody>
                                            <tr>
                                                <td class="font_11bold">SHPR/CNEE
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td width="110" align="left">
                                    <ext:TextField ID="txtShipper" runat="server" Cls="text" TabIndex="6" Width="100">
                                    </ext:TextField>
                                </td>
                                <td width="90" align="left">
                                    <table width="90" cellpadding="3">
                                        <tbody>
                                            <tr>
                                                <td class="font_11bold">OP
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td width="110" align="left">
                                    <uc1:usercombobox runat="server" id="cmbOP" query="option=GetUserListByStat" width="100" listwidth="180"
                                        clsclass="select" storeid="StoreOP" wintitle="OP" winurl="/Framework/User/UserList.aspx"
                                        tabindex="4" winwidth="680" winheight="560" isbutton="false" />
                                </td>
                                <td colspan="3"></td>

                                <td width="52" align="right" style="padding-right: 12px;">
                                    <table width="40" class="table">
                                        <tbody>
                                            <tr>
                                                <td align="center">
                                                    <ext:Checkbox ID="chbVoid" runat="server" Width="25px" TabIndex="7">
                                                    </ext:Checkbox>
                                                </td>
                                                <td align="right" class="font_11bold">Void
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>

                                <td width="" align="right" colspan="2">
                                    <span style="float: right; margin-left: 23px;">
                                        <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="50" AutoFocus="true"
                                            AutoShow="true" Selectable="true" TabIndex="9">
                                            <DirectEvents>
                                                <Click OnEvent="btnPrint_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </span><span style="float: right;">

                                        <ext:Button ID="btnFilter" runat="server" Cls="Submit_65px" Text="Search" Width="65" TabIndex="8"
                                            AutoFocus="true">
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
                    <td height="10" colspan="5"></td>
                </tr>
                <tr>
                    <td colspan="5" id="GridView">
                        <ext:GridPanel ID="gridList" runat="server" Height="368" Width="967px" TrackMouseOver="true"
                            TabIndex="14" StripeRows="true">
                            <LoadMask ShowMask="true" Msg=" Loading..." />
                            <Store>
                                <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                                    AutoLoad="true">
                                    <AutoLoadParams>
                                        <ext:Parameter Name="start" Value="={0}" />
                                        <ext:Parameter Name="limit" Value="={100}" />
                                    </AutoLoadParams>
                                    <Reader>
                                        <ext:JsonReader IDProperty="Seed">
                                            <Fields>
                                                <ext:RecordField Name="ETD" Type="Date">
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
                                                <ext:RecordField Name="ETA" Type="Date">
                                                </ext:RecordField>
                                                <ext:RecordField Name="PPCC" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="CFS" Type="Date">
                                                </ext:RecordField>
                                                <ext:RecordField Name="CY" Type="Date">
                                                </ext:RecordField>
                                                <ext:RecordField Name="o_User" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="Seed" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ROWID">
                                                </ext:RecordField>
                                                <ext:RecordField Name="OceanSeed" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="Exported" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="o_ServiceType" Type="String">
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
                                    <ext:DateColumn Header="ETD" DataIndex="ETD" Width="62" Format="dd/m/yy" Align="Center">
                                    </ext:DateColumn>
                                    <ext:Column Header="Type" DataIndex="o_ServiceType" Width="38">
                                    </ext:Column>
                                    <ext:Column Header="Lot No.#" DataIndex="LotNo" Width="93">
                                    </ext:Column>
                                    <ext:Column Header="POL" DataIndex="POL" Width="35" Align="Center">
                                    </ext:Column>
                                    <ext:Column Header="POD" DataIndex="POD" Width="36" Align="Center">
                                    </ext:Column>
                                    <ext:Column Header="MBL No. #" DataIndex="MBL" Width="95">
                                    </ext:Column>
                                    <ext:Column Header="Vessel" DataIndex="Vessel" Width="130" Align="left">
                                    </ext:Column>
                                    <ext:Column Header="Voyage" DataIndex="Voyage" Width="60">
                                    </ext:Column>
                                    <ext:DateColumn Header="ETA" DataIndex="ETA" Width="62" Format="dd/m/yy" Align="Center">
                                    </ext:DateColumn>
                                    <ext:DateColumn Header="CFS" DataIndex="CFS" Width="52" Format="dd/m/yy" Align="Center">
                                    </ext:DateColumn>
                                    <ext:DateColumn Header="CY" DataIndex="CY" Width="52" Format="dd/m/yy" Align="Center">
                                    </ext:DateColumn>
                                    <ext:Column Header="P/C" DataIndex="PPCC" Width="35" Align="Center">
                                    </ext:Column>
                                    <ext:Column Header="By" DataIndex="o_User" Width="45" Align="Center">
                                    </ext:Column>
                                    <ext:CheckColumn Header="Void" DataIndex="Void" Width="35">
                                    </ext:CheckColumn>
                                    <ext:Column Header="Action" DataIndex="OceanSeed" Width="47" Align="Center">
                                    </ext:Column>
                                    <ext:Column Header="Transfer" DataIndex="Exported" Width="65" Align="Center">
                                    </ext:Column>
                                    <ext:Column Header="Cost" DataIndex="LockCost" Width="65" Align="Center" Hidden="true">
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
