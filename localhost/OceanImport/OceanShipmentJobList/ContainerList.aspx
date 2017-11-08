<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContainerList.aspx.cs" Inherits="OceanImport_OceanShipmentJobList_ContainerList" %>
<%@ Register src="../../common/UIControls/UserComboBox.ascx" tagname="UserComboBox" tagprefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

   
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Store runat="server" ID="StoreCN"  OnRefreshData="StoreCN_OnRefreshData">
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
    <div id="div_title" style=" width:100%"><uc1:UserControlTop ID="UserControlTop1" runat="server"  sys="O"/></div>
    <div id="location_div01" style=" margin-top:80px">
        <table width="680" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top">
                    <table width="725" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="650" class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                                <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('OI');" />
                                &nbsp; OI - Container List
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="5px">
                </td>
            </tr>
            <tr>
                <td>
                    <table width="680" border="0" cellspacing="4" cellpadding="0">
                        <tr>
                            <td width="63" height="17" style="padding-left: 2px">
                                Lot No#
                            </td>
                            <td class="font_11px_gray">
                                <ext:Label runat="server" ID="lblLotNo">
                                </ext:Label>
                            </td>
                            <td>
                                MBL#
                            </td>
                            <td class="font_11px_gray">
                                <ext:Label runat="server" ID="lblMBL">
                                </ext:Label>
                            </td>
                            <td>
                                ETD
                            </td>
                            <td colspan="5" class="font_11px_gray">
                                <ext:Label runat="server" ID="lblETD">
                                </ext:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="63" style="padding-left: 2px">
                                Container#
                            </td>
                            <td width="100">
                                <ext:TextField ID="txtContainer" runat="server" Cls="text_100px" Width="100" TabIndex="1">
                                </ext:TextField>
                            </td>
                            <td width="40">
                                Seal#
                            </td>
                            <td width="100">
                                <ext:TextField ID="txtSeal" runat="server" Cls="text_100px" Width="100" TabIndex="2">
                                </ext:TextField>
                            </td>
                            <td width="47">
                                Size
                            </td>
                             <td width="100">
                                <uc1:UserComboBox runat="server" ID="CmbSize" ListWidth="250" clsClass="select_65"
                                                  TabIndex="3" Query="option=ContainerSize" StoreID="StoreCN" Width="67" winTitle="Container Size"
                                                  winUrl="/BasicData/ContainerSize/ContainerSize.aspx?sys=O" winWidth="450" winHeight="585" isButton="false" />
                            </td>
                            <td width="25">
                                S/O#
                            </td>
                            <td width="100">
                                <ext:TextField ID="txtSO" runat="server" Cls="text_100px" Width="100" TabIndex="4">
                                </ext:TextField>
                            </td>
                            <td width="30">
                                <ext:Button ID="btnAssign" runat="server" Cls="Submit_65px" Text="Assign" Width="65" TabIndex="5"
                                    AutoFocus="true">
                                 <DirectEvents>
                                 <Click OnEvent="btnAssign_Click"></Click>
                                 </DirectEvents>
                                </ext:Button>
                            </td>
                            <td width="31">
                               <ext:Button ID="btnClear" runat="server" Cls="Submit_65px" Text="Clear" Width="65" TabIndex="6"
                                    AutoFocus="true" Hidden="false">
                                    <DirectEvents>
                                 <Click OnEvent="btnClear_Click"></Click>
                                 </DirectEvents> 
                                </ext:Button>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
           
            <tr>
                <td height="5">
                </td>
            </tr>
            <tr>
                <td id="GridView">
                    <ext:GridPanel ID="gridList" runat="server" Height="325px" TrackMouseOver="true"  TabIndex="7"
                        StripeRows="true" Width="725">
                        <LoadMask ShowMask="true" Msg=" Loading..." />
                        <Store>
                            <ext:Store runat="server" ID="storeList" AutoLoad="true">
                                <Reader>
                                    <ext:JsonReader IDProperty="oc_ROWID">
                                        <Fields>
                                            <ext:RecordField Name="oc_ROWID" Type="Int">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_ETD" Type="Date">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_HBL" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="oc_CtnrNo" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="oc_SealNo" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="oc_SONo" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="oc_CtnrSize" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="oc_CBM" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="oc_GWT" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="oc_Piece" Type="String">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel runat="server" ID="ColumnModel1">
                            <Columns>
                                <ext:DateColumn Header="Date" DataIndex="o_ETD" Width="78" Format="dd/m/Y">
                                </ext:DateColumn>
                                <ext:Column Header="HBL" DataIndex="o_HBL" Width="88">
                                </ext:Column>
                                <ext:Column Header="Container#" DataIndex="oc_CtnrNo" Width="78"  Align="Center">
                                </ext:Column>
                                <ext:Column Header="Seal#" DataIndex="oc_SealNo" Width="78"  Align="Center">
                                </ext:Column>
                                <ext:Column Header="Size" DataIndex="oc_CtnrSize" Width="65" Align="Center">
                                </ext:Column>
                                <ext:Column Header="S/O#" DataIndex="oc_SONo" Width="78"  Align="Center">
                                </ext:Column>
                                <ext:NumberColumn Header="WT" DataIndex="oc_GWT" Width="72" Format="0.0" Align="Right">
                                </ext:NumberColumn>
                               <ext:NumberColumn Header="CBM" DataIndex="oc_CBM" Width="72" Format="0.000" Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="PKGS" DataIndex="oc_Piece" Width="72" Format="0" Align="Right">
                                </ext:NumberColumn>
                            </Columns>
                        </ColumnModel>
                       <SelectionModel>
                            <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" >
                            <DirectEvents>
                            <RowSelect OnEvent="row_Click">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="container" Value="record.data.oc_CtnrNo" Mode="Raw" />
                                                        <ext:Parameter Name="seal" Value="record.data.oc_SealNo" Mode="Raw" />
                                                        <ext:Parameter Name="so" Value="record.data.oc_SONo" Mode="Raw" />
                                                        <ext:Parameter Name="size" Value="record.data.oc_CtnrSize" Mode="Raw" />
                                                        
                                                    </ExtraParams>
                                                                                   
                                 </RowSelect>
                            </DirectEvents>
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
