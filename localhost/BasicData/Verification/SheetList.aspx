<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SheetList.aspx.cs" Inherits="common_UIControls_SheetList" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verification List</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            margin: 8px;
        }
        #tab_header td
        {
            padding-right: 8px;
        }
        #gridList input
        {
            background: #fff;
            border: 0px;
            text-align: left;
            direction: rtl;
        }
    </style>
     <script type="text/javascript">
         function Reload() {
             var obj = document.getElementById("btnFilter");
             if (obj != "" && obj != undefined && obj != null) {

                 Ext.getCmp('btnFilter').fireEvent('click', this);
             };
         }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:KeyMap runat="server" ID="KeyMap" Target="form1">
        <ext:KeyBinding>
            <Keys><ext:Key Code="ENTER" /></Keys>
            <Listeners><Event Handler="Reload();" /></Listeners>
        </ext:KeyBinding>
    </ext:KeyMap>
    <div style="padding-top: 15px;">
        <table id="tab_header" cellpadding="0" cellspacing="0" style="margin-bottom: 15px;">
            <tr>
                <td>
                    提单/报关单
                </td>
                <td>
                    <ext:TextField ID="txtSheetNo" runat="server" Width="80" Cls="text_100px">
                    </ext:TextField>
                </td>
                <td>
                    作业号
                </td>
                <td>
                    <ext:TextField ID="txtLotno" runat="server" Width="80" Cls="text_100px">
                    </ext:TextField>
                </td>
                <td>
                    主/分单号
                </td>
                <td>
                    <ext:TextField ID="txtMHno" runat="server" Width="80" Cls="text_100px">
                    </ext:TextField>
                </td>
                <td>
                    状态
                </td>
                <td>
                    <ext:ComboBox ID="cmbStatus" runat="server" Width="60" Cls="text_100px">
                        <Items>
                            <ext:ListItem Text=" " Value="0" />
                            <ext:ListItem Text="寄出" Value="1" />
                            <ext:ListItem Text="退回" Value="2" />
                        </Items>
                    </ext:ComboBox>
                </td>
                <td>
                    <ext:DateField ID="txtBeginDate" runat="server" Cls="text_100px" Width="95" Format="d/M/Y">
                    </ext:DateField>
                </td>
                <td>
                    ~
                </td>
                <td>
                    <ext:DateField ID="txtEndDate" runat="server" Cls="text_100px" Width="95" Format="d/M/Y">
                    </ext:DateField>
                </td>
                <td>
                    <ext:Button ID="btnFilter" runat="server" Text=" 查 询 " Cls="text_100px" Width="60">
                        <DirectEvents>
                            <Click OnEvent="btnFilter_Click">
                                <EventMask ShowMask="true" Msg="Search..." CustomTarget="gridList" />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                </td>
                <td>
                    <ext:Button ID="btnPrint" runat="server" Text=" 打 印 " Cls="text_100px" Width="60"
                        Hidden="true">
                    </ext:Button>
                </td>
                <td style="">
                </td>
            </tr>
        </table>
        <ext:GridPanel ID="gridList" runat="server" Height="390" TrackMouseOver="true" StripeRows="true"
            Width="949" ColumnLines="True">
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
                                <ext:RecordField Name="pkg" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="broker" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="flight" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_ReturnedDate" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_CBM" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_ExpressNo" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_DeclarationNo" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_Factory" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_GWT" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_HBL" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_Require" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="vv_Remark" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="lotNo" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="M" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="H" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="dest" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="shipper" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="sheet" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="DepDate" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="user" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="recDate" Type="String">
                                </ext:RecordField>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel runat="server" ID="ColumnModel1">
                <Columns>
                    <ext:Column Header="日期" Width="70" DataIndex="DepDate" Locked="true">
                    </ext:Column>
                    <ext:Column Header="提单号" DataIndex="sheet" Width="80" Locked="true">
                    </ext:Column>
                    <ext:Column Header="报关单号" DataIndex="vv_DeclarationNo" Width="80" Locked="true">
                    </ext:Column>
                    <ext:Column Header="作业号" DataIndex="lotNo" Width="80" Locked="true">
                    </ext:Column>
                    <ext:Column Header="主单号" DataIndex="M" Width="80" Locked="true">
                    </ext:Column>
                    <ext:Column Header="进仓编号" DataIndex="vv_HBL" Width="80">
                    </ext:Column>
                    <ext:Column Header="货名" DataIndex="vv_Factory" Width="80">
                    </ext:Column>
                    <ext:Column Header="需求" DataIndex="vv_Require" Width="80">
                    </ext:Column>
                    <ext:Column Header="件数 " DataIndex="pkg" Width="50" Align="Right">
                    </ext:Column>
                    <ext:Column Header="毛重 " DataIndex="vv_GWT" Width="50" Align="Right">
                    </ext:Column>
                    <ext:Column Header="尺码" DataIndex="vv_CBM" Width="50" Align="Right">
                    </ext:Column>
                    <ext:Column Header="寄出" DataIndex="recDate" Width="70" Align="Right">
                    </ext:Column>
                    <ext:Column Header="快递 " DataIndex="vv_ExpressNo" Width="60">
                    </ext:Column>
                    <ext:Column Header="退回" DataIndex="vv_ReturnedDate" Width="70">
                    </ext:Column>
                    <ext:Column Header="备注" DataIndex="vv_Remark" Width="100">
                    </ext:Column>
                    <ext:Column Header="报关行" DataIndex="broker" Width="80">
                    </ext:Column>
                    <ext:Column Header="寄货人" DataIndex="shipper" Width="80">
                    </ext:Column>
                    <ext:Column Header="目的地" DataIndex="dest" Width="80">
                    </ext:Column>
                    <ext:Column Header="航次" DataIndex="flight" Width="80">
                    </ext:Column>
                    <ext:Column Header="用户" DataIndex="user" Width="80">
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <View>
               <ext:LockingGridView runat="server"></ext:LockingGridView>
            </View>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" SingleSelect="true">
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
