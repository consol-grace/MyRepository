<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="OceanExport_OEContainerList" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OE - Container List </title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server"  DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div style=" margin-left:13px">
        <table width="680" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="5" valign="top" style="padding-top:10px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                           <table cellpadding="0" cellspacing="0" border="0" width="100%"><tr>
                           <td>OE - Container List</td>
                       <%-- <td align="right" class="nav_menu_5" style="padding-bottom:2px; padding-right:2px">
                                                        <a href="../OceanLot/List.aspx" target="_blank">Add New</a>
                                                    </td>      --%>   
                           </tr></table>
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
                    <table border="0" cellspacing="4" cellpadding="0">
                        <tr>
                            <td  height="17" style="padding-left: 2px; padding-right:10px">
                                Container# 
                            </td>
                            <td align="left">
                                <ext:TextField ID="txtLotNo" runat="server" Cls="text_100px" Width="100"  TabIndex="1"> 
                                </ext:TextField>
                            </td>
                            <td style="padding-left:15px; padding-right:5px">
                                MBL#
                            </td>
                            <td>
                                <ext:TextField ID="txtMBL" runat="server" Cls="text_100px" Width="100" TabIndex="2">
                                </ext:TextField>
                            </td>
                            <td  style="padding-left:15px; padding-right:5px">
                                HBL#
                            </td>
                            <td colspan="4">
                                <ext:TextField ID="txtVessel" runat="server" Cls="text_100px" Width="100" TabIndex="3"> 
                                </ext:TextField>
                            </td>
                            <td width="65" style="padding-left:5px">
                                <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Text="Search" Width="65" TabIndex="8"
                                    AutoFocus="true">
                                    <DirectEvents>
                                        <Click OnEvent="btnFilter_Click">
                                            <EventMask ShowMask="true" CustomTarget="GridView" />
                                        </Click>
                                    </DirectEvents>  
                                </ext:Button>
                                 <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                        <enter handler="btnCancel.fireEvent('click')" />
                                    </ext:KeyNav>
                            </td>
                        </tr>
                        <tr style="display:none">
                            <td width="63" style="padding-left: 2px">
                                POL
                            </td>
                            <td width="100">
                                <ext:TextField ID="txtPOL" runat="server" Cls="text_100px" Width="100" TabIndex="4"> 
                                </ext:TextField>
                            </td>
                            <td width="40">
                                POD
                            </td>
                            <td width="100">
                                <ext:TextField ID="txtPOD" runat="server" Cls="text_100px" Width="100" TabIndex="5">
                                </ext:TextField>
                            </td>
                            <td width="47">
                                ETD
                            </td>
                            <td width="100">
                                <ext:DateField ID="txtETD" runat="server" Width="100" Cls="text_100px"  Format="dd/m/Y" TabIndex="6">
                                </ext:DateField>
                            </td>
                            <td width="25">
                                ETA
                            </td>
                            <td width="100">
                                <ext:DateField ID="txtETA" runat="server" Cls="text_100px" Width="100"  Format="dd/m/Y" TabIndex="7">
                                </ext:DateField>
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
                    <ext:GridPanel ID="gridList" runat="server" Height="368" Width="950" TrackMouseOver="true"  TabIndex="14"
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
                                            <ext:RecordField Name="seed"></ext:RecordField>
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
                                             <ext:RecordField Name="PKG" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Unit" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="OceanSeed" Type="String">
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
                                <ext:DateColumn Header="Date" DataIndex="ETD" Width="78" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:DateColumn Header="Ser. Mode" DataIndex="ETA" Width="78" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:Column Header="HBL#" DataIndex="LotNo" Width="100">
                                </ext:Column>
                                <ext:Column Header="Container#" DataIndex="POL" Width="80" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Size" DataIndex="POD" Width="80" Align="Center">
                                </ext:Column>
                                <ext:Column Header="CBM" DataIndex="MBL" Width="110">
                                </ext:Column>
                                <ext:Column Header="WT" DataIndex="Vessel" Width="110" Align="left">
                                </ext:Column>
                                <ext:Column Header="PKG(S)" DataIndex="Voyage" Width="65" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Unit" DataIndex="ServiceMode" Width="85" Align="Center">
                                </ext:Column>
                                <ext:Column Header="LoadPlan" DataIndex="PPCC" Width="65" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Action" DataIndex="OceanSeed" Width="48" Align="Center">                         
                               </ext:Column>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="RowSelectionModel1" SingleSelect="true">
                                    <Listeners><RowSelect Handler="getRowIndex(rowIndex)" /></Listeners>
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
