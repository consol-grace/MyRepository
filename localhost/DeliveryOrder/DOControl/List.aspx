<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="DeliveryOrder_DOControl_List" %>
<%--ValidateRequest="false"--%> 
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/UserComboBox.ascx" TagName="UserComboBox" TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Delivery Order Control</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <%--  设置div_bottom底部样式--%>
    <link href="../../common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>
    <script src="../AjaxServer/Grid.js" type="text/javascript"></script>

    <style type="text/css">
        .bottom_line
        {
            color: #000;
            border: solid 1px #B5B8C8 !important;
            border-bottom: solid 1px #B5B8C8 !important;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#ACCompany_text1").width(113);
            $("#ACShipper_text1").width(113);
            $("#ACfConsignee_text1").width(223);
            $("#ACfShipper_text1").width(223);

        
        });
    
        var a = 0;
        var selectRow = -1;

        function InsertRecord() {
            var record = gridList.getStore().getAt(selectRow); // 获取当前行的数据

            a--;
            var rowid = $("#hidROWID").val();
            var sys = $("#CmbSys").val();
            var bookingNo = $("#txtfBookingNO").val().toUpperCase();
            var chSPL = false;
            if ($("#chSPL").is(":checked")) {
                chSPL = true;
            }

            var po = $("#txtfPO").val().toUpperCase();
            var shipper = $("#ACfShipper").val();
            var shipperName = $("#ACfShipper_text1").val();
            var consignee = $("#ACfConsignee").val();
            var consigneeName = $("#ACfConsignee_text1").val();
            var ctns = $("#nbfCTNS").val();
            var gw = $("#nbfGW").val();
            var cbm = $("#nbfCBM").val();

            if (sys == "" || sys == undefined) {
                $("#CmbSys").focus();
                return;
            }

            if (po == "" || po == undefined) {
                $("#txtfPO").focus();
                return;
            }
            if (shipper == "" || shipper == undefined) {
                $("#ACfShipper").focus();
                return;
            }

            if ((ctns == "" || ctns == undefined) && (gw == "" || gw == undefined) && (cbm == "" || cbm == undefined)) {
                Ext.Msg.alert('Information', 'CTNS or GW or VOL/CBM is empty!');
                return;
            }

            if (rowid == "") { //判断新增还是修改
                gridList.insertRecord(gridList.store.getTotalCount(), { ROWID: a, DodSys: sys, BookingNo: bookingNo, SPL: chSPL, PO: po, DODShipper: shipper, DODShipperName: shipperName, DODConsignee: consignee, DODConsigneeName: consigneeName, DODCTNS: ctns, DODGW: gw, DODCBM: cbm });
                gridList.getView().refresh();
                ClearRecord();
            } else {
                record.set("DodSys", sys);
                record.set("BookingNo", bookingNo);
                record.set("CompanyName", bookingNo);
                record.set("SPL", chSPL);
                if (chSPL) {
                    $("#chSPL").attr("Checked", "checked");
                } else {
                    $("#chSPL").removeAttr("Checked");
                }
                record.set("PO", po);
                record.set("DODShipper", shipper);
                record.set("DODShipperName", shipperName);
                record.set("DODConsignee", consignee);
                record.set("DODConsigneeName", consigneeName);
                record.set("DODCTNS", ctns);
                record.set("DODGW", gw);
                record.set("DODCBM", cbm);

                ClearRecord();
            }

            setShip();
            
        }

        function ClearRecord() {
            $("#hidROWID").val("");
            $("#CmbSys").val("");
            $("#txtfBookingNO").val("");
            $("#chSPL").removeAttr("Checked");
            $("#txtfPO").val("");
            $("#ACfShipper").val("");
            $("#ACfConsignee").val("");
            $("#nbfCTNS").val("");
            $("#nbfGW").val("");
            $("#nbfCBM").val("");
            $("#ACfConsignee_text1").val("");
            $("#ACfShipper_text1").val("");
            $("#CmbSys").focus();
        }

        function ResetRecord() {
            var record = gridList.getStore().getAt(selectRow); // 获取当前行的数据
            if (record == null || record == undefined) {
                ClearRecord();
            } else {
                $("#hidROWID").val(record.data.ROWID);
                $("#CmbSys").val(record.data.DodSys);
                $("#txtfBookingNO").val(record.data.BookingNo);
                if (record.data.SPL) {
                    $("#chSPL").attr("Checked", "checked");
                } else {
                    $("#chSPL").removeAttr("Checked");
                }
                $("#txtfPO").val(record.data.PO);
                $("#ACfShipper").val(record.data.DODShipper);
                $("#ACfConsignee").val(record.data.DODConsignee);
                $("#nbfCTNS").val(record.data.DODCTNS);
                $("#nbfGW").val(record.data.DODGW);
                $("#nbfCBM").val(record.data.DODCBM);
                $("#ACfConsignee_text1").val(record.data.DODConsigneeName);
                $("#ACfShipper_text1").val(record.data.DODShipperName);
            }
        }

        function SelectRecord(index) {
            selectRow = index;
            var record = gridList.getStore().getAt(selectRow); // 获取当前行的数据
            $("#hidROWID").val(record.data.ROWID);
            $("#CmbSys").val(record.data.DodSys);
            $("#txtfBookingNO").val(record.data.BookingNo);
            if (record.data.SPL) {
                $("#chSPL").attr("Checked", "checked");
            } else {
                $("#chSPL").removeAttr("Checked");
            }

            $("#txtfPO").val(record.data.PO);
            $("#ACfShipper").val(record.data.DODShipper);
            $("#ACfConsignee").val(record.data.DODConsignee);
            $("#ACfConsignee_text1").val(record.data.DODConsigneeName);
            $("#ACfShipper_text1").val(record.data.DODShipperName);
            $("#nbfCTNS").val(record.data.DODCTNS);
            $("#nbfGW").val(record.data.DODGW);
            $("#nbfCBM").val(record.data.DODCBM);

        }

        function DeleteRecord() {
            
            var shipper = $("#ACfShipper").val();
            var shipperName = $("#ACfShipper_text1").val();
            var record = gridList.getStore().getAt(selectRow); // 获取当前行的数据
            if (record == null || record == undefined) {
                Ext.Msg.alert('Information', 'Please select a row');
                return;
            }
            else {
                Ext.Msg.confirm('Delete This Row', 'Are you sure?', function (btn) {
                    if (btn == 'yes') {
                        if (record.id > 0) {
                        $("#hidDelByRowId").val($("#hidDelByRowId").val() + record.id + ",");
                     }  
//                        alert($("#hidDelByRowId").val());
                        gridList.getSelectionModel().selectRow(selectRow);
                        gridList.deleteSelected();
                        ClearRecord();

                        setShip();
                    }
                });
            }
        }

        // 设置SHIPPER的值
        function setShip() { 

            var rowShip = "";
            var count = gridList.store.getTotalCount();  // 获取当前行数

            if (count == 0) { //删除之后
                $("#ACShipper").val("");
                $("#ACShipper_text1").val("");
                return;
            }

            var shipper = gridList.getStore().getAt(0).data.DODShipper;
            var shipperName = gridList.getStore().getAt(0).data.DODShipperName;

            if (count == 1) {
                $("#ACShipper").val(shipper);
                $("#ACShipper_text1").val(shipperName);
                return;
            }

            var a = true;
            for (var i = 0; i < count; i++) {
                rowShip = gridList.getStore().getAt(i);
                if (shipper != rowShip.data.DODShipper) {
                    $("#ACShipper").val("");
                    $("#ACShipper_text1").val("");
                    a = false;
                    break;
                }
            }

            if (a) {
                $("#ACShipper").val(shipper);
                $("#ACShipper_text1").val(shipperName);
            }

        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
     <div id="div_title" style="width: 100%; z-index: 1000" >
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="D" />
    </div>
    <ext:Hidden runat="server" ID="hidSeed" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidDelByRowId" runat="server" Text="">
    </ext:Hidden>
    <ext:Hidden ID="hidROWID" runat="server" Text="">
    </ext:Hidden>
    <div style="width: 980px; margin-top: 80px; margin-left: 13px;z-index: 990;">
        <table width="980px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tbody>
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="970px" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td align="left" style="padding-left: 5px; width: 530px" class="font_11bold_1542af">
                                        Delivery Order Control &nbsp;<img src="../../images/void.png" runat="server" id="img_void"
                                            style="vertical-align: middle; display: none;" />
                                    </td>
                                    <td class="font_11bold_1542af" align="right" style="width: 440px">
                                        <%if (!string.IsNullOrEmpty(Request["seed"]))
                                          { %>
                                        DO # &nbsp;
                                        <%} %>
                                    </td>
                                    <td align="right">
                                        <ext:Label runat="server" ID="labDO" StyleSpec="color:#ff0000;font-size:10px;font-weight:bold;">
                                        </ext:Label>
                                        <ext:Hidden ID="hidLabDO" runat="server">
                                        </ext:Hidden>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table class="table" style="padding: 15px 0" border="0" width="980px">
            <tbody>
                <tr>
                    <td width="50" align="left" class="font_11bold">
                        Date
                    </td>
                    <td width="100" align="left">
                        <ext:DateField ID="txtDate" runat="server" Cls="text" Format="dd/m/Y" Width="100"
                            TabIndex="1">
                        </ext:DateField>
                    </td>
                    <td width="60" align="left" class="font_11bold">
                         Company
                    </td>
                    <td align="left" valign="middle" width="240px">

                    <%--  往下
                            <uc1:AutoComplete runat="server" ID="ACCompany" clsClass="x-form-text x-form-field text_82px" 
                    isText="true" isAlign="false" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                    winWidth="800" winHeight="800" Query="option=CompanyList"  />--%>
                                         
                    <%--旁边--%>
                    <uc1:AutoComplete runat="server" ID="ACCompany" TabIndex="2" clsClass="x-form-text x-form-field text"
                                    Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                    winWidth="800" winHeight="800"/>   
                                   
                    </td>
                    <td width="50" align="left" valign="middle" class="font_11bold">
                        Type
                    </td>
                    <td align="left" valign="middle" width="120">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tbody>
                                <tr>
                                    <%--StoreID="StoreLocation"--%>
                                    <td>
                                          <ext:ComboBox ID="cmbType" runat="server" Cls="select" DisplayField="value" ForceSelection="true"
                                            Mode="Local" TriggerAction="All" ValueField="value" Width="81" TabIndex="3">
                                            <Items>
                                                <ext:ListItem Text="Type1" Value="Type1" />
                                                <ext:ListItem Text="Type2" Value="Type2" />
                                            </Items>
                                        </ext:ComboBox>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td rowspan="3" height="64px" align="left" colspan="2">
                         <div id="div_top" style=" margin-top:115px; margin-left:20px;">
                            <table width="300" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                                <tbody>
                                    <tr>
                                        <td width="300" class="font_11bold_1542af" style="padding-left: 5px;">
                                            Action
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table width="290" height="40" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td width="65" class="table" style="padding-bottom: 5px; padding-top: 5px">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tbody>
                                                    <tr>
                                                         <td style="width: 65px; padding-left: 5px;">
                                                    <ext:Button ID="btnVoid" runat="server" Width="65px" Text="Void">
                                                        <DirectEvents>
                                                            <Click OnEvent="btnVoid_Click">
                                                            </Click>
                                                        </DirectEvents>
                                                    </ext:Button>
                                                </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td class="table" style="padding-bottom: 5px; padding-top: 5px; width: 65px;padding-left: 5px;">
                                    <ext:Button ID="btnNext" runat="server" Width="65px" Text="Next" Hidden="false">
                                        <DirectEvents>
                                            <Click OnEvent="btnNext_Click">
                                                <EventMask ShowMask="true" Msg=" Saving ... " />
                                                <ExtraParams>
                                                    <ext:Parameter Name="grid" Value="Ext.encode(#{gridList}.getRowsValues())" Mode="Raw">
                                                    </ext:Parameter>
                                                </ExtraParams>
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                        <td class="table" style="padding-left: 5px; width: 65px;">
                                    <ext:Button ID="btnCancel" runat="server" Width="65px" Text="Cancel">
                                        <DirectEvents>
                                            <Click OnEvent="btnCancel_Click">
                                                <EventMask ShowMask="true" Msg=" Waiting ... " />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td class="table" style="padding-left: 5px;">
                                    <ext:Button ID="btnSave" runat="server" Width="65px" Text="Save">
                                        <DirectEvents>
                                            <Click OnEvent="btnSave_Click">
                                                <EventMask ShowMask="true" Msg=" Saving ... " />
                                                <ExtraParams>
                                                    <ext:Parameter Name="grid" Value="Ext.encode(#{gridList}.getRowsValues())" Mode="Raw">
                                                    </ext:Parameter>
                                                </ExtraParams>
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        
                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="50" align="left" class="font_11bold">
                        Pallets
                    </td>
                    <td align="left" style="width: 115px">
                        <ext:NumberField ID="txtPallets" runat="server" Width="100" Cls="text" TabIndex="4" StyleSpec="text-align:right" AllowDecimals="false" >
                        </ext:NumberField>
                    </td>
                     <td align="left" class="font_11bold" style="width: 60px">
                        Shipper
                    </td>
                    <td align="left" style=" width:240px">
                          <%--旁边--%>
                    <uc1:AutoComplete runat="server" ID="ACShipper" TabIndex="5" clsClass="x-form-text x-form-field text"
                                    Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                    winWidth="800" winHeight="800"/>   
                <%-- <uc1:UserComboBox runat="server" ID="ACShipper1" Query="option=CompanyList" clsClass="select_160px"  Width="100"  TabIndex="5"   winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" Disabled="true" />--%>
                    </td>
                    <td width="50" align="left" class="font_11bold">
                        Cost
                    </td>
                    <td align="left" style="width: 115px">
                        <ext:NumberField ID="txtCost" runat="server" Width="81" Cls="text" TabIndex="6" StyleSpec="text-align:right" DecimalPrecision="2">
                        </ext:NumberField>
                    </td>
                </tr>
                <tr style=" height:4px"></tr>
                <tr >
                    <td width="50" align="left" class="font_11bold" valign="top">
                        Address
                    </td>
                    <td colspan="3" align="left" valign="top">
                        <ext:TextField ID="txtAddress" runat="server" Width="400" Height="15" Cls="text" TabIndex="7">
                        </ext:TextField>
                    </td>
                    <td width="60" align="left" class="font_11bold" valign="top">
                        Remark
                    </td>
                    <td colspan="3" align="left" valign="baseline">
                        <ext:TextArea ID="txtRemark" runat="server" Width="445" Height="28" Cls="text_80px" TabIndex="8">
                        </ext:TextArea>
                    </td>
                </tr>
            </tbody>
        </table>
        <div style="width: 980px;">
            <div style="float: left; width: 680px">
                <table  cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                             <ext:GridPanel ID="gridList" runat="server" Width="670px" TrackMouseOver="true" Height="350px"
                                StripeRows="true" ColumnLines="True" Title="List">
                                <LoadMask ShowMask="true" Msg=" Loading..." />
                                <Store>
                                    <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                                        AutoLoad="true">
                                        <AutoLoadParams>
                                            <ext:Parameter Name="start" Value="={0}" />
                                            <ext:Parameter Name="limit" Value="={100}" />
                                        </AutoLoadParams>
                                        <Reader>
                                            <ext:JsonReader IDProperty="ROWID">
                                                <Fields>
                                                    <ext:RecordField Name="ROWID" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="DodSys" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="BookingNo" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="SPL" Type="Boolean" DefaultValue="0">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="PO" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="DODShipper" Type="String">
                                                    </ext:RecordField>
                                                     <ext:RecordField Name="DODShipperName" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="DODConsignee" Type="String">
                                                    </ext:RecordField>
                                                     <ext:RecordField Name="DODConsigneeName" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="DODCTNS" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="DODGW" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="DODCBM" Type="String">
                                                    </ext:RecordField>
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <ColumnModel runat="server" ID="ColumnModel1">
                                    <Columns>
                                        <ext:Column DataIndex="ROWID" Hidden="true">
                                        </ext:Column>
                                          <ext:Column Header="System" DataIndex="DodSys" Width="55" Align="Left">
                                        </ext:Column>
                                        <ext:Column Header="Booking #" DataIndex="BookingNo" Width="90" Align="Left">
                                        </ext:Column>
                                        <ext:CheckColumn Header="SPL" DataIndex="SPL" Width="35">
                                        </ext:CheckColumn>
                                        <ext:Column Header="PO #" DataIndex="PO" Width="90" Align="Left">
                                        </ext:Column>
                                        <ext:Column Header="Shipper" DataIndex="DODShipper" Width="90" Align="Left">
                                        </ext:Column>
                                        <ext:Column Header="Consignee" DataIndex="DODConsignee" Width="90" Align="Left">
                                        </ext:Column>
                                        <ext:Column Header="CTNS" DataIndex="DODCTNS" Width="69" Align="Right">
                                        </ext:Column>
                                        <ext:NumberColumn Header="GW" DataIndex="DODGW" Width="69" Format="0,000.000" Align="Right">
                                        </ext:NumberColumn>
                                        <ext:NumberColumn Header="VOL/CBM" DataIndex="DODCBM" Width="77" Format="0,000.000"
                                            Align="Right">
                                        </ext:NumberColumn>
                                          <ext:Column DataIndex="DODShipperName" Width="90" Align="Left" Hidden="true">
                                        </ext:Column>
                                          <ext:Column DataIndex="DODConsigneeName" Width="90" Align="Left" Hidden="true" >
                                        </ext:Column>
                                    </Columns>
                                </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
                                       <%-- <Listeners>
                                        <RowSelect Handler="SelectRecord(rowIndex);" />
                                        </Listeners>--%>
                                    </ext:RowSelectionModel>
                                   
                                </SelectionModel>
                                <Listeners>
                                    <RowClick Handler="SelectRecord(rowIndex);" />
                                </Listeners>
                        <%--        <BottomBar>
                                    <ext:PagingToolbar PageSize="100" DisplayInfo="true" ID="PagingToolbar1" runat="server">
                                    </ext:PagingToolbar>
                                </BottomBar>--%>
                            </ext:GridPanel>
                        </td>
                    </tr>
                </table>
            </div>
             <div style="width: 300px; float: left; ">
                <table border="0" cellpadding="0" cellspacing="0">
                     <tr>
                        <td  colspan="4" style="padding-left: 5px; height: 24px; width: 300px;" class="font_11bold_1542af table_nav2" >
                            <ext:Label ID="labaddcosting" runat="server" Text="Add"></ext:Label>
                        </td>
                    </tr>
                    <tr height="6"></tr>
                    <tr>
                        <td colspan="4" width="300px";>
                            <table cellpadding="0" cellspacing="0" border="0" >
                                <tr>
                                    <td width="70px">
                                        &nbsp;System
                                    </td>
                                    <td width="104px" >
                                        <ext:ComboBox ID="CmbSys" runat="server" Cls="select" DisplayField="value" ForceSelection="true"
                                            Mode="Local" TriggerAction="All" ValueField="value" Width="81" TabIndex="9" Height="18">
                                            <Items>
                                                <ext:ListItem Text="AE" Value="AE" />
                                                <ext:ListItem Text="OE" Value="OE" />
                                                <ext:ListItem Text="TK" Value="TK" />
                                            </Items>
                                        </ext:ComboBox>
                                    </td>
                                    <td width="40px" align="left">
                                        SPL
                                    </td>
                                    <td width="86px" align="left">
                                        <ext:Checkbox ID="chSPL" runat="server" TabIndex="10" Width="86px">
                                        </ext:Checkbox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr height="6"></tr>
                    <tr>
                        <td colspan="4" width="300px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                        <td width="70px" align="left">
                            &nbsp;Booking #
                        </td>
                        <td width="230px">
                            <ext:TextField ID="txtfBookingNO" runat="server" TabIndex="11" Width="103px" Cls="text" />
                        </td>
                            </tr>
                        </table>
                            </td>
                    </tr>
                      <tr height="6"></tr>
                    <tr>
                        <td colspan="4" width="300px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                        <td width="70px" align="left">
                           &nbsp;PO #
                        </td>
                        <td width="230px" align="left">
                            <ext:TextField ID="txtfPO" runat="server" TabIndex="12" Width="103px" Cls="text" />
                        </td>
                            </tr>
                        </table>
                            </td>
                    </tr>
                      <tr height="6"></tr>
                      <tr>
                        <td colspan="4" width="300px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                        <td width="70px" valign="top" align="left"  >
                          &nbsp;Shipper
                        </td>
                        <td colspan="3" width="230px" align="left" >
                            <%--<ext:TextField ID="ACfShipper" runat="server" TabIndex="5" Width="158px"/>--%>
                          <%--    往下--%>
                            <uc1:AutoComplete runat="server" ID="ACfShipper" clsClass="x-form-text x-form-field text_82px" 
                    isText="true" isAlign="false" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                    winWidth="800" winHeight="800" Query="option=CompanyList" TabIndex="13" />
                        </td>
                         </tr>
                        </table>
                            </td>
                    </tr>
                   <tr>
                         <td colspan="4" width="300px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                        <td width="70px"  valign="top" align="left">
                        &nbsp;Consignee
                        </td>
                        <td colspan="3" width="230px" align="left">
                          <%--  <ext:TextField ID="ACfConsignee" runat="server" TabIndex="6" Width="158px"/>--%>
                            <uc1:AutoComplete runat="server" ID="ACfConsignee" clsClass="x-form-text x-form-field text_82px" 
                    isText="true" isAlign="false" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                    winWidth="800" winHeight="800" Query="option=CompanyList" TabIndex="14" />
                        </td>
                         </tr>
                        </table>
                            </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <table cellpadding="0" cellspacing="0" border="0" width="300px" >
                                <tr>
                                   
                                    <td  width="73px">
                                        &nbsp;CTNS
                                    </td>
                                    <td  width="50px" align="left">
                                        <ext:NumberField ID="nbfCTNS" runat="server" AllowDecimals="false" TabIndex="15" Width="43px" Cls="text" StyleSpec="text-align:right">
                                        </ext:NumberField>
                                    </td>
                                    <td width="26px" align="center">
                                        GW
                                    </td>
                                    <td width="53px"  align="left">
                                        <ext:NumberField ID="nbfGW" runat="server" TabIndex="16" Width="43px" StyleSpec="text-align:right" Cls="text" DecimalPrecision="3">
                                        </ext:NumberField>
                                    </td>
                                     <td width="45px"align="right">
                                        VOL/CBM
                                    </td>
                                    <td width="53px" align="right">
                                        <ext:NumberField ID="nbfCBM" runat="server" TabIndex="17" Width="43px" Cls="text" StyleSpec="text-align:right" DecimalPrecision="3">
                                        </ext:NumberField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-right: 0px; padding-top: 10px" align="right" colspan="4">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td class="btn_L">
                                                </td>
                                                <td>
                                                    <input id="btnInsert" onclick="InsertRecord()" type="button" style="cursor: pointer"
                                                        tabindex="44" class="btn_text btn_C" value="Save & Next" />
                                                </td>
                                                <td class="btn_R">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding-left: 2px">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td class="btn_L">
                                                </td>
                                                <td>
                                                    <input id="btnReset" onclick="ResetRecord()" type="button" style="cursor: pointer"
                                                        tabindex="44" class="btn_text btn_C" value="Reset" />
                                                </td>
                                                <td class="btn_R">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding-left: 3px">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td class="btn_L">
                                                </td>
                                                <td>
                                                    <input id="btnDelete" onclick="DeleteRecord()" type="button" style="cursor: pointer"
                                                        tabindex="44" class="btn_text btn_C" value="Delete" />
                                                </td>
                                                <td class="btn_R">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        var _td = $("#ACShipper_panel").parent().parent().parent().parent().parent(); //禁用到三个点
        //        var _td = $("#ACShipper_tab").parent();//禁用到最后面的文本框描述
        //        alert(_td.html());

        var w = _td.width();
        var h = _td.height();
        var _html = "<div style='border:1px solid red; width:" + w + "px; height:" + h + "px;position:absolute; z-index:99999; background:pink;filter:alpha(Opacity=0);-moz-opacity:0;opacity: 0;'></div>";
    
        _td.prepend(_html);

        _td.attr("disabled", "disabled");

        //        DisableCombox(ACShipper);
        //        gridList.setHeight(document.documentElement.clientHeight - 200 - $("#PagingToolbar1").height());
        //        $("#ACShipper").next().attr("src", "../../images/DO/gcmb.png");
    });
</script>
