<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="DeliveryOrder_DOSystem_List" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete" TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/UserComboBox.ascx" TagName="UserComboBox" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>
    
    <script src="../../common/UIControls/LockCost.js" type="text/javascript"></script>
    <script type="text/javascript">
        function RefreshList() {
            Ext.getCmp('btnFilter').fireEvent('click', this);
        }

        function renderCost(value, meta, record) {
            return String.format("<a class='company-link' href='../DOControl/List.aspx?Seed={1}'>{0}</a>",
             Ext.util.Format.number(value.toString(), "0,000.00")
             , record.data.Seed);
        }

        function renderDO(value, meta, record) {

            return String.format("<a class='company-link' target='{0}' title='{0}' href='../DOControl/List.aspx?Seed={1}'>{0}</a>",
            value, record.data.Seed);
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
    <div style="width: 982px; margin-top: 10px; margin-left: 13px">
        <table width="982px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tbody>
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="977px" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                       Delivery Order System
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
        <table class="table" style="padding: 15px 0;">
            <tbody>
                <tr>
                    <td align="left" class="font_11bold" style="padding-right: 2px" width="60">
                    <nobr>
                        DO #
                        </nobr>
                    </td>
                    <td align="left" width="110">
                        <ext:TextField ID="txtDO" runat="server" Cls="text" Width="100" TabIndex="1">
                        </ext:TextField>
                    </td>
                    <td width="50" align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Date
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="120" align="left">
                        <ext:DateField ID="txtDate" runat="server" Cls="text" Format="dd/m/Y" Width="100"
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
                    <td width="120" align="left">
                        <ext:DateField ID="txtTo" runat="server" Cls="text" Format="dd/m/Y" Width="100"
                            TabIndex="2">
                        </ext:DateField>
                    </td>
                    <td width="70" align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" >
                                        Company
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td  width="120" align="left">
                            <uc1:AutoComplete runat="server" ID="ACCompany" TabIndex="3" clsClass="x-form-text x-form-field text"
                                                                Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                winWidth="800" winHeight="800" isDiplay="false"/>
                    </td>
                     <td width="73" align="right" style="padding-right:20px;">
                        <table width="40" class="table">
                            <tbody>
                                <tr>
                                    <td align="right">
                                        <ext:Checkbox ID="chbVoid" runat="server" Width="25px" TabIndex="4">
                                        </ext:Checkbox>
                                    </td>
                                    <td align="right" class="font_11bold">
                                        Void
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td align="right">
                        <span style="float: right; margin-left:15px;">
                            <ext:Button ID="btnPrint" runat="server" Cls="Submit lotprint" Text="Print" Width="75"
                                AutoFocus="true" AutoShow="true" Selectable="true" TabIndex="6">
                                <DirectEvents>
                                    <Click OnEvent="btnPrint_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </span><span style="float: right;">
                            <ext:Button ID="btnFilter" runat="server" Cls="Submit" Text="Search" Width="75" AutoFocus="true"
                                AutoShow="true" Selectable="true" TabIndex="5">
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
        <ext:GridPanel ID="gridList" runat="server" Width="982px"  TrackMouseOver="true" Height="368" 
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
                                <ext:RecordField Name="Void" Type="Boolean"></ext:RecordField>
                                <ext:RecordField Name="RowID" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="DO" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="OrderDate" Type="Date">
                                </ext:RecordField>
                                <ext:RecordField Name="PO???" Type="String">
                                </ext:RecordField>
                                 <ext:RecordField Name="Shipper" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="ADDR" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="AD" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="CTNS" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="GW" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="CBM" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Cost" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Seed" Type="Int">
                                </ext:RecordField>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel runat="server" ID="ColumnModel1">
                <Columns>
                     <ext:CheckColumn  Header="Void" DataIndex="Void" Width="45" ></ext:CheckColumn>
                    <ext:Column Header="DO #" DataIndex="DO" Width="106" Align="Left">
                    <Renderer Fn="renderDO" />
                    </ext:Column>
                    <ext:DateColumn Header="Date" DataIndex="OrderDate" Width="78" Format="dd/MM/yyyy"
                        Align="Center">
                    </ext:DateColumn>
                    <ext:Column Header="PO#" DataIndex="PO" Width="106" Align="Left">
                    </ext:Column>
                    <ext:Column Header="Shipper" DataIndex="Shipper" Width="92" Align="Left">
                    </ext:Column>
                     <ext:Column Header="Pick up place" DataIndex="ADDR" Width="200" Align="Left">
                     <%--<Editor>
                     <ext:TextField runat="server" ReadOnly="true">
                        
                     </ext:TextField>
                     </Editor>  --%>
                    </ext:Column>
                    <ext:Column Header="CTNS" DataIndex="CTNS" Width="78" Align="Right">
                    </ext:Column>
                    <ext:NumberColumn Header="GW" DataIndex="GW" Width="85" Format="0,000.000" Align="Right">
                    </ext:NumberColumn>
                    <ext:NumberColumn Header="VOL/CBM" DataIndex="CBM" Width="85" Format="0,000.000" Align="Right">
                    </ext:NumberColumn>
                    <ext:Column Header="Cost" DataIndex="Cost" Width="85" Align="Right">
                    <Renderer Fn="renderCost" />
                    </ext:Column>
                     <ext:Column Header="Seed" DataIndex="Seed" Width="90" Align="Right" Hidden="true">
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
                </ext:RowSelectionModel>
            </SelectionModel>
            <BottomBar>
                <ext:PagingToolbar PageSize="100" DisplayInfo="true" ID="PagingToolbar1" runat="server">
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