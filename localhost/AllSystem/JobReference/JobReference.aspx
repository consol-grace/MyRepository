<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JobReference.aspx.cs" Inherits="AllSystem_JobReference_JobReference" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Job Reference</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var showTip = function() {
            var rowIndex = gridReference.view.findRowIndex(this.triggerElement),
                cellIndex = gridReference.view.findCellIndex(this.triggerElement),
                record = StoreReference.getAt(rowIndex),
                fieldName = gridReference.getColumnModel().getDataIndex(cellIndex),
                data = record.get(fieldName);

            this.body.dom.innerHTML = data;
        };

        function LoadTd() {
            $("#tr_class").find("td").eq(0).append($("#lblVerifyNo"));
            $("#tr_class").find("td").eq(1).append($("#txtVerifyNo").width("82px"));
        }
        
        
        function showurl(sys, id,isvoid) {
            var win = this.parent.parent.WinView;
            if (win != undefined) {
                var url = "http://" + window.location.host;
                if (sys == "OE") {
                    url = url + "/OceanExport/OEJobList/DetailList.aspx?ID=" + id;
                }
                else if (sys == "AE") {
                    url = url + "/AirExport/AEViewConsol/DetailList.aspx?ID=" + id;
                }
                else if (sys == "OI") {
                    url = url + "/OceanImport/OceanShipmentJobList/DetailList.aspx?ID=" + id;
                }
                else if (sys == "AI") {
                    url = url + "/AirImport/AIShipmentJobList/DetailList.aspx?ID=" + id;
                }
//                if ($("#chkVoid").attr("checked") == true) {
//                    CompanyX.SetID(id);
                //                }
                if (isvoid == 1) {
                    CompanyX.SetID(id);
                }
                win.load(url);
                win.show();
            }
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
    <ext:ResourceManager ID="ResourceManager1" runat="server" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidsys" runat="server" Text="OX">
    </ext:Hidden>
    <ext:Store runat="server" ID="StoreLocation" OnRefreshData="StoreLocation_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreSalesman" OnRefreshData="StoreSalesman_OnRefreshData">
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
    <div>
        <div style="padding-top: 10px; padding-bottom: 10px; padding-left: 10px">
            <table width="970px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="800px" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                    Job Reference
                                </td>
                                <td width="288" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <table border="0" cellspacing="4" cellpadding="0" style="padding-left: 10px">
            <tr>
                <td width="40" style="padding-left: 2px">
                    Date
                </td>
                <td width="90">
                    <ext:DateField ID="txtETDFrom" runat="server" Cls="text_100px" Width="110" Format="dd/m/Y"
                        TabIndex="1">
                    </ext:DateField>
                </td>
                <td width="40" style="padding-left: 10px">
                    To
                </td>
                <td width="90">
                    <ext:DateField ID="txtETDTo" runat="server" Cls="text_100px" Width="90" Format="dd/m/Y"
                        TabIndex="2">
                    </ext:DateField>
                </td>
                <td width="50" style="padding-left: 10px">
                    <asp:Label ID="lblJobNo" runat="server" Text="Lot No#"></asp:Label>
                </td>
                <td>
                    <ext:TextField ID="txtJobNo" runat="server" Width="127" TabIndex="3" Cls="text">
                    </ext:TextField>
                </td>
                <td style="padding-left: 10px">
                    <asp:Label ID="lblMBL" runat="server" Text="MBL"></asp:Label>
                </td>
                <td>
                    <ext:TextField ID="txtMBL" runat="server" Width="127" TabIndex="4" Cls="text">
                    </ext:TextField>
                </td>
                <td style="padding-left: 10px">
                    <asp:Label ID="lblHBL" runat="server" Text="HBL"></asp:Label>
                </td>
                <td>
                    <ext:TextField ID="txtHBL" runat="server" Width="127" TabIndex="5" Cls="text">
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td width="40" style="padding-left: 2px">
                    <asp:Label ID="lblDest" runat="server" Text="Location"></asp:Label>
                </td>
                <td width="90">
                    <div id="divDest" runat="server">
                        <uc1:UserComboBox runat="server" ID="cmbDest" ListWidth="180" clsClass="select_160px"
                            TabIndex="6" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="90"
                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                            winHeight="620" isButton="false" />
                    </div>
                </td>
                <td width="40" style="padding-left: 10px">
                    <asp:Label ID="lblSales" Text="Sales" runat="server"></asp:Label>
                </td>
                <td width="90">
                    <div id="divSalesman" runat="server">
                        <uc1:UserComboBox runat="server" ID="cmbSalesman" Query="option=SalesList" Width="90"
                            clsClass="select" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                            TabIndex="7" winWidth="680" winHeight="560" isButton="false" />
                    </div>
                </td>
                <td width="50" style="padding-left: 10px">
                    <asp:Label ID="lblSHPR" runat="server" Text="Shipper"></asp:Label>
                </td>
                <td>
                    <uc1:AutoComplete runat="server" ID="cmbShipperCode" TabIndex="8" clsClass="x-form-text x-form-field text"
                        Query="option=CompanyList" Width="100" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                        winWidth="800" winHeight="800" isDiplay="false" />
                </td>
                <td width="50" style="padding-left: 10px">
                    <asp:Label ID="lblCNEE" runat="server" Text="Consignee"></asp:Label>
                </td>
                <td>
                    <uc1:AutoComplete runat="server" ID="cmbConsigneeCode" TabIndex="9" clsClass="x-form-text x-form-field text"
                        Query="option=CompanyList" Width="100" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                        winWidth="800" winHeight="800" isDiplay="false" />
                </td>
                <td width="50" style="padding-left: 10px">
                    <asp:Label ID="labcoloader" runat="server" Text="Coloader"></asp:Label>
                </td>
                <td>
                    <uc1:AutoComplete runat="server" ID="CmbColoader" TabIndex="10" clsClass="x-form-text x-form-field text"
                        Query="option=CompanyList" Width="100" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                        winWidth="800" winHeight="800" isDiplay="false" />
                </td>
            </tr>
            <tr id="tr_class">
                <td width="40" style="padding-left: 2px" >
                    <asp:Label ID="lblVessel" runat="server" Text="Vessel"></asp:Label>
                </td>
                <td>
                    <ext:TextField ID="txtVessel" runat="server" Width="110" TabIndex="11" Cls="text">
                    </ext:TextField>
                </td>
                <td width="40" style="padding-left: 10px">
                    <asp:Label ID="lblVoyage" runat="server" Text="Voyage"></asp:Label>
                </td>
                <td>
                    <ext:TextField ID="txtVoyage" runat="server" Width="90" TabIndex="12" Cls="text">
                    </ext:TextField>
                </td>
                <td width="40" style="padding-left: 10px">
                    <asp:Label ID="lblContainer" runat="server" Text="Container"></asp:Label>
                </td>
                <td>
                    <ext:TextField ID="txtContainer" runat="server" Width="127" TabIndex="13" Cls="text">
                    </ext:TextField>
                </td>
                <td width="80" style="padding-left: 10px" id="td_lblVerifyNo">
                    <ext:Label ID="lblVerifyNo" runat="server" Text="Verification No">
                    </ext:Label>
                </td>
                <td id="td_txtVerifyNo">
                    <ext:TextField ID="txtVerifyNo" runat="server" Width="127" TabIndex="13" Cls="text">
                    </ext:TextField>
                </td>
                <td width="50">
                </td>
                <td align="right" style="padding-right: 2px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <ext:Checkbox ID="chkVoid" runat="server" BoxLabel="Void" Hidden="true">
                                    <Listeners>
                                        <Check Handler="Ext.getCmp('btnSearch').fireEvent('click', this);" />
                                    </Listeners>
                                </ext:Checkbox>
                            </td>
                            <td style="padding-left: 20px;">
                                <ext:Button runat="server" Text="Search" ID="btnSearch" Width="65" AutoFocus="true">
                                    <DirectEvents>
                                        <Click OnEvent="btnSearch_Click">
                                            <EventMask ShowMask="true" CustomTarget="form1" />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:KeyNav ID="keyNav1" Target="#{form1}" runat="server">
                                    <Enter Handler="btnSearch.fireEvent('click')" />
                                </ext:KeyNav>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="0" cellpadding="0" style="padding-left: 10px">
            <tr>
                <td>
                    <ext:GridPanel runat="server" ID="gridReference" TrackMouseOver="true" StripeRows="true"
                        Height="470" Width="970">
                        <%--    <LoadMask ShowMask="true" Msg=" Loading..."/>--%>
                        <Store>
                            <ext:Store runat="server" ID="StoreReference" OnRefreshData="StoreReference_OnRefreshData"
                                AutoLoad="true">
                                <AutoLoadParams>
                                    <ext:Parameter Name="start" Value="={0}" />
                                    <ext:Parameter Name="limit" Value="={200}" />
                                </AutoLoadParams>
                                <Reader>
                                    <ext:JsonReader>
                                        <Fields>
                                            <ext:RecordField Name="mawb_LotNo" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_Date" Type="Date">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_master" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="hawb_HAWB" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_Shipper" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_Consignee" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_From" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_Dest" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_CWT" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_MAWBCost" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="mawb_MAWBInv" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="remark" Type="String">
                                            </ext:RecordField>
                                             <ext:RecordField Name="Void" Type="String">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="ColumnModel3">
                            <Columns>
                                <ext:Column Header="Lot No #" DataIndex="mawb_LotNo" Width="98" Align="Center">
                                </ext:Column>
                                <ext:DateColumn Header="Date" DataIndex="mawb_Date" Width="76" Format="dd/m/Y" Align="Center">
                                </ext:DateColumn>
                                <ext:Column Header="MBL" DataIndex="mawb_master" Width="115">
                                </ext:Column>
                                <ext:Column Header="HBL" DataIndex="hawb_HAWB" Width="94">
                                </ext:Column>
                                <ext:Column Header="Shipper" DataIndex="mawb_Shipper" Width="90">
                                </ext:Column>
                                <ext:Column Header="Consignee" DataIndex="mawb_Consignee" Width="82">
                                </ext:Column>
                                <ext:Column Header="From" DataIndex="mawb_From" Width="40">
                                </ext:Column>
                                <ext:Column Header="Dest" DataIndex="mawb_Dest" Width="40">
                                </ext:Column>
                                <ext:NumberColumn Header="CWT" DataIndex="mawb_CWT" Width="62" Format="0.00" Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="Cost" DataIndex="mawb_MAWBCost" Width="62" Format="0.00"
                                    Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="Revenue" DataIndex="mawb_MAWBInv" Width="73" Format="0.00"
                                    Align="Right">
                                </ext:NumberColumn>
                                <ext:Column Header="Remark" DataIndex="remark" Width="70">
                                </ext:Column>
                                <ext:Column Header="Status" DataIndex="Void" Width="48" Align="Center">
                                </ext:Column>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="ctl1606">
                            </ext:RowSelectionModel>
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar StoreID="StoreReference" PageSize="200" runat="server" ID="PagingToolbar1"
                                AfterPageText="&nbsp;of {0}" BeforePageText=" Page " DisplayMsg="Displaying {0} - {1} of  {2} "
                                EmptyMsg="No Data">
                            </ext:PagingToolbar>
                        </BottomBar>
                    </ext:GridPanel>
                    <ext:ToolTip ID="RowTip" runat="server" Target="={gridReference.getView().mainBody}"
                        Delegate=".x-grid3-cell" TrackMouse="true">
                        <Listeners>
                            <Show Fn="showTip" />
                        </Listeners>
                    </ext:ToolTip>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        setGridSize(gridReference);
    });
</script>