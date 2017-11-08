<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CostingList.aspx.cs" Inherits="common_Cost_CostingList" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script type="text/javascript">
        function loadCost() {
            //window.location.reload();
            Ext.getCmp('btnFilter').fireEvent('click', this);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidPageSeed" runat="server" Text="0"></ext:Hidden>
    <ext:Button ID="btnFilter" runat="server" Cls="Submit" Text="Search" Width="60" AutoFocus="true"
                            AutoShow="true" Selectable="true" Hidden="true">
                            <DirectEvents>
                                <Click OnEvent="btnFilter_Click">
                                    <EventMask ShowMask="true" Msg="Searching..." CustomTarget="gridList" />
                                </Click>
                            </DirectEvents>
    </ext:Button>
    <div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">

            <tr>
                <td colspan="5" valign="top" style="padding-top:0px">
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
                </td>
            </tr>
            <tr>
                <td height="10px" colspan="5">
                </td>
            </tr>

            <tr>
                <td colspan="5" id="GridView"> 
                    <ext:GridPanel ID="gridList" runat="server"  Height="310" TrackMouseOver="true"  TabIndex="14"
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
                                <ext:Column Header="Company" DataIndex="cxh_Company" Width="100">
                                </ext:Column>
                                <ext:DateColumn Header="Date" DataIndex="cxh_Date" Width="80" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:Column Header="Invoice No" DataIndex="cxh_InvoiceNo" Width="120" Align="Center">
                                </ext:Column>
                                 <ext:NumberColumn Header="Amount" DataIndex="cxh_Amount" Width="70" Align="Right">
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
                                EmptyMsg="No Data" Hidden="true">
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
