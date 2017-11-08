<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OIHBLList.aspx.cs" Inherits="OceanImport_OceanShipmentJobList_OIHBLList" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OI HBLList</title>
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" /> 
   <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
</head>
<body style="width:850px; overflow-x:hidden;">
    <form id="form1" runat="server">
       <ext:ResourceManager runat="server" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="HidHBL" runat="server" Text="">
    </ext:Hidden>
    <div style="margin-left: 10px; margin-top: 5px;">
      <table width="780" border="0" cellspacing="0" cellpadding="0" >
     <tr>
        <td valign="top">
                    <table width="780px" height="25" border="0" cellpadding="0" cellspacing="0" style=" padding-bottom:5px;"  >
                        <tbody>
                            <tr>
                                <td width="780px" align="left" valign="top" >
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tbody>
                                            <tr>
                                                <td style="width:570px;"></td>
                                                <td align="right"  style=" padding-right:5px;height:25px;width:100px; font-weight:bold">
                                                   Transhipment To
                                                </td>
                                                <td align="right"  style="padding-right:5px;width:50px;">
                                                   <ext:ComboBox ID="cmbSys" runat="server"
                                                    TabIndex="1"  ForceSelection="true" ListWidth="50"
                                                    Width="50" TriggerAction="All" SelectOnFocus="true" TypeAhead="true" Text="OE">
                                                    <Items>
                                                     <%--   <ext:ListItem Text="AE" Value="AE" />
                                                        <ext:ListItem Text="AI" Value="AI" />--%>
                                                        <ext:ListItem Text="OE" Value="OE" />
                                                       <%-- <ext:ListItem Text="OI" Value="OI" />
                                                        <ext:ListItem Text="AT" Value="AT" />
                                                        <ext:ListItem Text="OT" Value="OT" />
                                                        <ext:ListItem Text="DM" Value="DM" />
                                                        <ext:ListItem Text="TK" Value="TK" />
                                                        <ext:ListItem Text="BK" Value="BK" />--%>
                                                    </Items>
                                                </ext:ComboBox>
                                                </td>
                                                  <td align="right"  class="nav_menu_4" style="padding-right:5px;width:65px;">
                                                      <ext:Button ID="btnOIToOE" runat="server" Cls="Submit_65px" Text="GO" Width="65" TabIndex="5"
                                                        AutoFocus="true">
                                                     <DirectEvents>
                                                      <Click OnEvent="btnOIToOE_Click">
                                                        <ExtraParams>
                                                        <ext:Parameter Name="RowData" Value="Ext.encode(#{gridHBL}.getRowsValues({selectedOnly : true}))" Mode="Raw" />
                                                        </ExtraParams>
                                                        </Click>
                                                     </DirectEvents>
                                                    </ext:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
     </tr>
          <tr>
                <td valign="top" id="GridView_1">
                    <ext:GridPanel runat="server" ID="gridHBL" TrackMouseOver="true" Width="780" Height="200">
                        <LoadMask ShowMask="true" Msg=" Loading ... " />
                        <Store>
                            <ext:Store runat="server" ID="storeHBL">
                                <Reader>
                                    <ext:JsonReader>
                                        <Fields>
                                            <ext:RecordField Name="RowID">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Seed">
                                            </ext:RecordField>
                                            <ext:RecordField Name="HBL" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="TranHBL">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Consignee">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Shipper">
                                            </ext:RecordField>
                                            <ext:RecordField Name="POL">
                                            </ext:RecordField>
                                             <ext:RecordField Name="POD">
                                            </ext:RecordField>
                                            <ext:RecordField Name="ServiceMode">
                                            </ext:RecordField>
                                            <ext:RecordField Name="CWT">
                                            </ext:RecordField>
                                            <ext:RecordField Name="CBM">
                                            </ext:RecordField>
                                            <ext:RecordField Name="PKGS">
                                            </ext:RecordField>
                                            <ext:RecordField Name="WM">
                                            </ext:RecordField>
                                            <ext:RecordField Name="PPD">
                                            </ext:RecordField>
                                            <ext:RecordField Name="VesselID">
                                            </ext:RecordField>
                                            <ext:RecordField Name="VoyageID">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Vessel" >
                                            </ext:RecordField>
                                            <ext:RecordField Name="Voyage">
                                            </ext:RecordField>
                                            <ext:RecordField Name="ETD">
                                            </ext:RecordField>
                                            <ext:RecordField Name="POD">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel runat="server" ID="ColumnModel1">
                            <Columns>
                                <ext:Column Header="HBL" DataIndex="HBL" Width="145">
                                </ext:Column>
                                <ext:Column Header="Tran HBL" DataIndex="TranHBL" Width="120">
                                </ext:Column>
                                  <ext:Column Header="Shipper" DataIndex="Shipper" Width="130">
                                </ext:Column>
                                <ext:Column Header="POL" DataIndex="POL" Width="45" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Ser. Mode" DataIndex="ServiceMode" Width="70" Align="Center">
                                </ext:Column>
                                <ext:NumberColumn Header="WT" DataIndex="CWT" Width="65" Format="0.000" Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="CBM" DataIndex="CBM" Width="55" Format="0.000" Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="Piece(s)" DataIndex="PKGS" Width="70" Align="Right" Format="0">
                                </ext:NumberColumn>
                                <ext:Column Header="P/C" DataIndex="PPD" Width="35" Align="Center">
                                </ext:Column>
                                <ext:NumberColumn Header="RowID" DataIndex="RowID" Hidden="true" Width="0">
                                </ext:NumberColumn>
                                  <ext:NumberColumn Header="Seed" DataIndex="Seed" Hidden="true" Width="0">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="VesselID" DataIndex="VesselID" Hidden="true" Width="0">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="VoyageID" DataIndex="VoyageID" Hidden="true" Width="0">
                                </ext:NumberColumn>
                                <ext:Column Header="Vessel" DataIndex="Vessel" Width="0" Hidden="true">
                                </ext:Column>
                                <ext:Column Header="Voyage" DataIndex="Voyage" Width="0" Hidden="true">
                                </ext:Column>
                               <ext:Column Header="ETD" DataIndex="ETD" Width="0"  Hidden="true"></ext:Column>
                                <ext:Column Header="POD" DataIndex="POD" Hidden="true" Width="0">
                                </ext:Column>
                            </Columns>
                        </ColumnModel>
                          <SelectionModel>
                            <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server"  HideCheckAll="true" SingleSelect="true" >
                            </ext:CheckboxSelectionModel>
                        </SelectionModel>
                       
                    </ext:GridPanel>
                </td>
            </tr>
      </table>
    </div>
    </form>
</body>
</html>
