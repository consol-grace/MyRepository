<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CostingSearch.aspx.cs" Inherits="common_Cost_CostingSearch" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="/common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cost List</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <script src="/common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="/common/UIControls/CompanyDrpList.js" type="text/javascript"></script>
    <script src="/common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script type="text/javascript">
        function loadCost() {
            Ext.getCmp('btnFilter').fireEvent('click', this);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden runat="server" ID="hidPostSeed">
    </ext:Hidden>
    <div>
    <table>
    <tr><td colspan="2" style="padding-top:5px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                           <table cellpadding="0" cellspacing="0" border="0" width="100%"><tr>
                           <td>Costing</td>
                        <td align="right" class="nav_menu_4" style="padding-bottom:2px; padding-right:2px">
                                                    <a href="javascript:void(0)"  onclick="OpenCostingDetail('','');">Add</a>
                                                    </td>         
                           </tr></table>
                            </td>
                        </tr>
    </table>
    </td></tr>
    <tr><td style="vertical-align:top; text-align:left;width:220px;">
    <table border="0" cellspacing="4" cellpadding="0">
    <tr><td width="90" style="padding-left: 10px">Company</td><td>
    <uc1:AutoComplete runat="server" ID="cmbShipperCode" TabIndex="1" clsClass="x-form-text x-form-field text"
                            Query="option=CompanyList" Width="73" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" isDiplay="false" />
    </td></tr>
    <tr><td width="90" style="padding-left: 10px">Invoice No</td><td><ext:TextField ID="txtInvNo" runat="server" Cls="text_100px" Width="100" TabIndex="2">
                                </ext:TextField></td></tr>
    <tr><td width="90" style="padding-left: 10px">Date From</td><td><ext:DateField ID="txtDateFrom" runat="server" Width="100" Cls="text_100px"  Format="dd/m/Y" TabIndex="3">
                                </ext:DateField></td></tr>
    <tr><td width="90" style="padding-left: 10px">Date To</td><td><ext:DateField ID="txtDateTo" runat="server" Width="100" Cls="text_100px"  Format="dd/m/Y" TabIndex="4">
                                </ext:DateField></td></tr>
    <tr><td width="90" style="padding-left: 10px">Lot No</td><td><ext:TextField ID="txtLotNo" runat="server" Cls="text_100px" Width="100"  TabIndex="5"> 
                                </ext:TextField></td></tr>
    <tr><td width="90" style="padding-left: 10px">Master No</td><td><ext:TextField ID="txtMBL" runat="server" Cls="text_100px" Width="100" TabIndex="6">
                                </ext:TextField></td></tr>
    <tr><td width="90" style="padding-left: 10px">House No</td><td><ext:TextField ID="txtHBL" runat="server" Cls="text_100px" Width="100" TabIndex="7">
                                </ext:TextField></td></tr>
    <tr><td colspan="2" align="right">
    <table><tr><td style="padding-right:6px;">
    <ext:Button ID="btnFilter" runat="server" Cls="Submit" Text="Search" Width="60" AutoFocus="true"
                            AutoShow="true" Selectable="true">
                            <DirectEvents>
                                <Click OnEvent="btnFilter_Click">
                                    <EventMask ShowMask="true" Msg="Searching..." CustomTarget="gridListSearch" />
                                </Click>
                            </DirectEvents>
    </ext:Button>
    <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                            <Enter Handler="btnFilter.fireEvent('click');" />
                        </ext:KeyNav>
    </td><td>
    <ext:Button ID="btnReset" runat="server" Cls="Submit" Text="Reset" Width="60" AutoFocus="true"
                            AutoShow="true" Selectable="true">
                            <DirectEvents>
                                <Click OnEvent="btnReset_Click">
                                
                                </Click>
                            </DirectEvents>
    </ext:Button>
    </td></tr></table>
    </td></tr>
    </table>
    </td>
    <td style="vertical-align:top;text-align:left;width:460px;">
    <table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td height="5px">
                </td>
            </tr>

            <tr>
                <td  id="GridView"> 
                    <ext:GridPanel ID="gridListSearch" runat="server"  Height="475" TrackMouseOver="true"  TabIndex="14"
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
                                    <ext:JsonReader IDProperty="cxh_ROWID">
                                        <Fields>
                                            <ext:RecordField Name="cxh_ROWID" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxh_Seed" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxh_Company" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxh_InvoiceNo" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxh_Date" Type="Date">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxh_Amount" Type="String">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel runat="server" ID="ColumnModel1">
                            <Columns>
                                <ext:Column Header="Company" DataIndex="cxh_Company" Width="120">
                                </ext:Column>
                                <ext:DateColumn Header="Date" DataIndex="cxh_Date" Width="80" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:Column Header="Invoice No" DataIndex="cxh_InvoiceNo" Width="130" Align="Center">
                                </ext:Column>
                                 <ext:NumberColumn Header="Amount" DataIndex="cxh_Amount" Width="98" Align="Right">
                                  </ext:NumberColumn>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="RowSelectionModel1" SingleSelect="true">
                            </ext:RowSelectionModel>
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar StoreID="storeList" PageSize="100" runat="server" ID="PagingToolbar1"
                                AfterPageText="&nbsp;of {0}" BeforePageText=" Page " DisplayMsg="Displaying {0} - {1} of  {2} "
                                EmptyMsg="No Data" Hidden="false">
                            </ext:PagingToolbar>
                        </BottomBar>
                    </ext:GridPanel>
                </td>
            </tr>
        </table>
    </td></tr></table>
    </div>
    </form>
</body>
</html>
