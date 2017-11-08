 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="AirExport_AEColoaderDirect_List" %>

<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
    <%@ Register src="/common/UIControls/Costing.ascx" tagname="Costing" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sell MAWB</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../AirExport/AEValid/Valid.js" type="text/javascript"></script>
 
    <script language="javascript" type="text/javascript">
        var cmbStoreCompany = function(value) {
            var r = StoreCompany.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.text;
        };
        var cmbStoreItem = function(value) {
            var r = StoreItem.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.text;
        }

        function TabSum(grid) {

            if (grid == null) return;
            var count = grid.store.getTotalCount();

            if (count > 0) {
                if (grid.getRowsValues({ Selectedonly: false })[0].Carrier != "") {
                    CmbCarrierRight.setValue(grid.getRowsValues({ Selectedonly: false })[0].Carrier);
                }
                if (grid.getRowsValues({ Selectedonly: false })[0].FlightNo != "") {
                    txtFlightRight.setValue(grid.getRowsValues({ Selectedonly: false })[0].FlightNo);
                }
                if (grid.getRowsValues({ Selectedonly: false })[0].From != "") {
                    CmbFromRight.setValue(grid.getRowsValues({ Selectedonly: false })[0].From);
                }
                if (grid.getRowsValues({ Selectedonly: false })[count - 1].To != "") {
                    CmbToRight.setValue(grid.getRowsValues({ Selectedonly: false })[count - 1].To);
                }
                if (grid.getRowsValues({ Selectedonly: false })[0].ETD != undefined) {
                    txtETD.setValue(grid.getRowsValues({ Selectedonly: false })[0].ETD);
                }
                if (grid.getRowsValues({ Selectedonly: false })[count - 1].ETA != undefined) {
                    txtETA.setValue(grid.getRowsValues({ Selectedonly: false })[count - 1].ETA);
                }
                if (grid.getRowsValues({ Selectedonly: false })[0].ATD != undefined) {
                    txtATD.setValue(grid.getRowsValues({ Selectedonly: false })[0].ATD);
                }
                if (grid.getRowsValues({ Selectedonly: false })[count - 1].ATA != undefined) {
                    txtATA.setValue(grid.getRowsValues({ Selectedonly: false })[count - 1].ATA);
                }
            }
            else {
                txtFlightRight.setValue("");
                CmbFromRight.setValue("");
                CmbToRight.setValue("");
                txtETD.setValue("");
                txtETA.setValue("");
                txtATD.setValue("");
                txtATA.setValue("");
            }
        }

        function ClearValue(grid, obj) {
            if (grid.id = "gridCost") {
                var record = grid.getStore().getAt(selectRow);
                var Rate = record.data.Rate;
                var Amount = record.data.Amount;
                var Qty = isNaN(record.data.Qty) ? 0 : record.data.Qty;
                if (obj == "0") {
                    if (Rate != "") {
                        record.set("Amount", "");
                    }
                }
                else {
                    if (Amount != "") {
                        record.set("Rate", "");
                    }
                }

                if (Amount == "")
                    Qty = Rate * Qty;
                else
                    Qty = Amount;
                record.set("Total", Qty);
            }
        }

        function RetrunText(obj, grid) {
            var Qty;
            var record = grid.getStore().getAt(selectRow);
            var text = obj;
            var GWT = txtGWT.getValue();
            var VWT = txtVWT.getValue();
            var CWT = parseFloat(txtGWT.getValue()) > parseFloat(txtVWT.getValue()) ? txtGWT.getValue() : txtVWT.getValue();
            if (text == "") return;
            switch (text) {
                case "GWT":
                    Qty = txtGWT.getValue();
                    break;
                case "CWT":
                    Qty = CWT;
                    break;
                case "VWT":
                    Qty = txtVWT.getValue();
                    break;
                case "PCS":
                    Qty = txtPiece.getValue();
                    break;
                default:
                    break;
            }
            record.set("Qty", Qty);
        }

        function DeleteEmpty(grid) {

            if (grid.store.getTotalCount() > 0 && grid.id == "GridFlightList") {
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var no = data.FlightNo;
                    var from = data.From;
                    var to = data.To;

                    if (no == "" && from == "" && to == "") {
                        grid.getSelectionModel().selectRow(i);
                        grid.deleteSelected();
                    }
                }
            }
            else if (grid.store.getTotalCount() > 0 && grid.id == "gridCost") {

                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var item = data.Item;
                    var code = data.CompanyCode;
                    var calc = data.CalcKind;

                    if (item == "" && code == "" && calc == "") {
                        grid.getSelectionModel().selectRow(i);
                        grid.deleteSelected();
                    }
                }
            }

        }

        var selectFRowIndex = -1;
        function GetFRowID(row) {
            selectFRowIndex = row;
        }
        function InsertFRecord() {
            var flightno = $("#l_flightno").val().toUpperCase();
            var from = $("#l_from").val();
            var to = $("#l_to").val();
            var etd = $("#l_etd").val();
            var eta = $("#l_eta").val();
            var atd = $("#l_atd").val();
            var ata = $("#l_ata").val();
            var carrier = $("#l_CmbCarrierRight").val();

            if (carrier == "" || carrier == undefined) {
                $("#l_CmbCarrierRight").focus();
                NullMsg("Carrier");
                return;
            }
            if (flightno == "" || flightno == undefined) {
                $("#l_flightno").focus();
                NullMsg("Flight No");
                return;
            }
            if (from == "" || from == undefined) {
                $("#l_from").focus();
                NullMsg("From");
                return;
            }
            if (to == "" || to == undefined) {
                $("#l_to").focus();
                NullMsg("To");
                return;
            }
            if (etd == "" || etd == undefined) {
                $("#l_etd").focus();
                NullMsg("ETD");
                return;
            }
            if (eta == "" || eta == undefined) {
                $("#l_eta").focus();
                NullMsg("ETA");
                return;
            }


            var count = GridFlightList.store.getTotalCount();  // 获取当前行数
            if (selectFRowIndex >= 0) {
                var record = GridFlightList.getStore().getAt(selectFRowIndex); // 获取当前行的数据
                record.set("FlightNo", flightno);
                record.set("From", from);
                record.set("To", to);
                record.set("ETD", etd);
                record.set("ETA", eta);
                record.set("ATD", atd);
                record.set("ATA", ata);
                record.set("Carrier", carrier);
            }
            else {
                GridFlightList.insertRecord(count, { FlightNo: flightno, From: from, To: to, ETD: etd, ETA: eta, ATD: atd, ATA: ata, Carrier: carrier });
            }
            GridFlightList.getView().refresh();
            GridFlightList.view.focusEl.focus();
            ResetFRecord();
            TabSum(GridFlightList);

        }
        
        function SelectFRecord() {
            var record = GridFlightList.getStore().getAt(selectFRowIndex); // 获取当前行的数据
            if (record == null || record == undefined)
                return;
            else {
                $("#l_flightno").val(record.data.FlightNo);
                $("#l_from").val(record.data.From);
                $("#l_to").val(record.data.To);
                $("#l_etd").val(record.data.ETD);
                $("#l_eta").val(record.data.ETA);
                $("#l_atd").val(record.data.ATD);
                $("#l_ata").val(record.data.ATA);
                $("#l_CmbCarrierRight").val(record.data.Carrier);
            }
        }

        function DeleteFRecord() {
            GridFlightList.getSelectionModel().selectRow(selectFRowIndex);
            GridFlightList.deleteSelected();
            ResetFRecord();
            TabSum(GridFlightList);
        }

        function ResetFRecord() {
            selectFRowIndex = -1;
            $("#l_flightno").val("");
            $("#l_from").val("");
            $("#l_to").val("");
            $("#l_etd").val("");
            $("#l_eta").val("");
            $("#l_atd").val("");
            $("#l_ata").val("");
            $("#l_CmbCarrierRight").val("");
            $("#l_CmbCarrierRight").focus();
        }

        function ReturnNull() {
//            var shipper = "";
//            var consignee = "";
//            shipper = $("#CmbShipperCode").val();
//            consignee = $("#CmbConsignee").val();
            var mawb = "";
            var coloader = "";
            mawb = $("#txtMAWB").val();
            coloader = $("#CmbColoader").val();
            if ($("#txtMAWB").attr("validata") == "false") {
                $("#div_bottom").html("<p class=\"error\">Status : Saved  failed , Error message: the input value is invalid .");
                return false;
            }
            else if (mawb == "" || mawb == undefined) {
            $("#txtMAWB").focus();
            NullMsg("MAWB");
            return false;
            }
            else if (coloader == "" || coloader == undefined) {
            $("#CmbColoader").focus();
            NullMsg("Co-Loader");
                return false;
            }
            //            else if (shipper == "" || shipper == undefined) {
            //                $("#CmbShipperCode").focus();
            //                NullMsg("Shipper");
            //                return false;
            //            }
            //            else if (consignee == "" || consignee == undefined) {
            //                $("#CmbConsignee").focus();
            //                NullMsg("Consignee");
            //                return false;
            //            }
            else if (GridFlightList.store.getTotalCount() == 0) {
                $("#l_CmbCarrierRight").focus();
                NullMsg("Flight Routing");
                return false;
            }
            else {
                return true;
            }
        }
        //验证错误信息
        function NullMsg(msg) {
            $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg + " can't be empty!");
        }

        function ChangeMawb(event) {
            if(event.keyCode == 8||event.keyCode==46)
            {
            return false;
            }
            else if ($("#txtMAWB").val().length == 3) {
            $("#txtMAWB").val($("#txtMAWB").val() + ' ');
            return true;
            }
        }
        function ChangeFlight() {
            if ($("#l_flightno").val() == "" && $("#l_CmbCarrierRight").val() != "") {
                $("#l_flightno").val($("#l_CmbCarrierRight").val() + ' ');
                getSelectPos("l_flightno");
            }
        }
        function getSelectPos(obj) {
            var esrc = document.getElementById(obj);
            if (esrc == null) {
                esrc = event.srcElement;
            }
            var rtextRange = esrc.createTextRange();
            rtextRange.moveStart('character', esrc.value.length);
            rtextRange.collapse(true);
            rtextRange.select();
        } 
    </script>

    <style type="text/css">
          
        #ucCost_cos_Amount
        {
             width: 31px !important;
        }
         
        #ucCost_cos_EX
        {
            width: 43px !important;
        }
        
        #ucCost_cos_Qty
        {
            width: 43px !important;
        }
         
         #ucCost_cos_Currency
         {
            width: 37px !important;
         }
         
         #ucCost_cos_Remark
        {
            width: 222px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_title" style="width: 100%; z-index: 1000">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="A" />
    </div>
    
    <div id="div_title" style="padding-top: 80px; padding-left: 10px; z-index: 990">
        <table cellpadding="0" cellspacing="0" border="0" width="980px">
            <tr>
                <td colspan="2" valign="middle" class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                    <table width="99%" border="0" cellspacing="2" cellpadding="0">
                        <tr>
                            <td width="605">
                                <table>
                                    <tr>
                                        <td>
                                            <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                                alt="View" onclick="createFrom('AE');" />&nbsp;
                                        </td>
                                        <td>
                                            Sell MAWB
                                        </td>
                                        <td style="padding-top: 2px;">
                                            &nbsp;<img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle;
                                                display: none;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="335" align="right" class="font_11px_1542af" style="padding-right: 5px;
                                font-weight: bold;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="100px">
                                            <ext:Button ID="btnUpdateLotNo" runat="server" Hidden="true" Text="Update Lot No."
                                                Cls="btnUpdateLotNo">
                                                <Listeners>
                                                    <Click Handler="UpdatelotNo();" />
                                                </Listeners>
                                            </ext:Button>
                                        </td>
                                        <td>
                                            <%if (Request["seed"] != null)
                                              { %>
                                            Lot#&nbsp;<%} %>
                                        </td>
                                        <td>
                                            <ext:Label ID="labLotNo" runat="server" StyleSpec="color:#ff0000;font-size:10px">
                                            </ext:Label>
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
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLotNo" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidIDList" runat="server">
    </ext:Hidden>
    <ext:Store runat="server" ID="StoreAgentLocal">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreGetItem" OnRefreshData="StoreGetItem_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FCalcQty">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FMin">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FRate">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FAmount">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FCurrency">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FUnit">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FRound">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FMarkUp">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FMarkDown">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LCalcQty">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LMin">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LRate">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LAmount">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LCurrency">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LUnit">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LRound">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LMarkUp">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LMarkDown">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreCurrInvoice" OnRefreshData="StoreCurrInvoice_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="code">
                <Fields>
                    <ext:RecordField Name="code">
                    </ext:RecordField>
                    <ext:RecordField Name="foreign">
                    </ext:RecordField>
                    <ext:RecordField Name="local">
                    </ext:RecordField>
                    <ext:RecordField Name="rate">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreLocation" OnRefreshData="StoreLocation_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreUnit" OnRefreshData="StoreUnit_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreItem">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreKind">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                    <ext:RecordField Name="unit">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    <div style="margin-top: 105px; padding-left: 10px">
        <table border="0" cellpadding="0" cellspacing="0" style="background:#ffffff" >
            <tr>
                <td  valign="top" style="padding-top: 5px" rowspan="2">
                    <table cellpadding="0" cellspacing="0" border="0"  style="background:#ffffff" width="672px">
                        <tr>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="4">
                                    <tr>
                                        <td align="left" class="font_11bold" style="padding-left: 3px">
                                        <table cellpadding="0" cellspacing="0" border="0"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="58px"><tr><td>MAWB</td></tr></table></td><td class="font_red">*</td></tr></table>
                                        </td>
                                        <td width="84" align="left">
                                            <ext:TextField ID="txtMAWB" runat="server" Cls="select" Width="90" TabIndex="1" EnableKeyEvents="true">
                                                <Listeners>
                                                    <Blur Handler="validName(this.id,'MAWB',#{hidSeed}.getValue());" />
                                                    <KeyUp Handler="ChangeMawb(event);" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" style="padding-left:10px">
                                            <table cellpadding="0" cellspacing="0" border="0" width="28px"><tr><td>N/P</td></tr></table>
                                        </td>
                                        <td align="left">
                                            <ext:ComboBox ID="CmbNP" runat="server" Cls="select" DisplayField="value" TabIndex="2"
                                                ForceSelection="true" Mode="Local" TriggerAction="All" ValueField="value" Width="95">
                                                <Items>
                                                    <ext:ListItem Text="N" Value="N" />
                                                    <ext:ListItem Text="P" Value="P" />
                                                </Items>
                                            </ext:ComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="80px" align="left" class="font_11bold" style="padding-left: 3px">
                                        <table cellpadding="0" cellspacing="0" border="0"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="58px"><tr><td>Co-Loader</td></tr></table></td><td class="font_red">*</td></tr></table>
                                        </td>
                                        <td colspan="3" align="left" class="font_11px_gray">
                                            <table width="250" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbColoader" Query="option=CompanyList" clsClass="select_160px"  Width="100"  TabIndex="4"  StoreID="StoreCmb2"  winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800"  />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbColoader" TabIndex="4" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" class="font_11bold" style="padding-left: 3px">
                                            Shipper
                                        </td>
                                        <td colspan="3" align="left" class="font_11px_gray">
                                            <table width="250" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbShipperCode" Query="option=CompanyList" clsClass="select_160px"  Width="100"  TabIndex="5"  StoreID="StoreCmb2"  winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800"  />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbShipperCode" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" class="font_11bold" style="padding-left: 3px;">
                                            Consignee
                                        </td>
                                        <td colspan="3" align="left">
                                            <table width="250" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbConsignee" Query="option=CompanyList" clsClass="select_160px"  Width="100"  TabIndex="6"  StoreID="StoreCmb2"  winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800"  />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbConsignee" TabIndex="6" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" style="padding-top: 4px">
                                <table border="0" cellpadding="0" cellspacing="0" class="select_142px" style="border: 1px solid #8db2e3;
                                    width: 320px; height: 85px">
                                    <tr>
                                        <td align="left" style="padding-left: 5px">
                                            <table width="40px"><tr><td align="left">Carrier</td></tr></table>
                                        </td>
                                        <td>
                                                        <uc1:UserComboBox runat="server" ID="CmbCarrierRight" isButton="false" HideTrigger="true"
                                                            ListWidth="180" clsClass="select_160px input_line_white" TabIndex="8" Query="option=LocationList&sys=A"
                                                            StoreID="StoreLocation" Width="88" winTitle="Location" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="845" winHeight="620" Disabled="true" />
                                        </td>
                                        <td style="padding-left: 3px;">
                                            <table width="60px"><tr><td>Flight No.</td></tr></table>
                                        </td>
                                        <td valign="middle">
                                            <ext:TextField ID="txtFlightRight" runat="server" Cls="text input_line_white " TabIndex="7"
                                                Disabled="true" Width="85">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left:5px">
                                        <table width="40px"><tr><td>From</td></tr></table>
                                        </td>
                                        <td>
                                                <uc1:UserComboBox runat="server" ID="CmbFromRight" isButton="false" HideTrigger="true"
                                                    ListWidth="180" clsClass="select_160px input_line_white" TabIndex="8" Query="option=LocationList&sys=A"
                                                    StoreID="StoreLocation" Width="68" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                                    winWidth="845" winHeight="620" Disabled="true" />
                                        </td>
                                        <td style="padding-left:6px">To</td>
                                        <td>
                                            <uc1:UserComboBox runat="server" ID="CmbToRight" ListWidth="180" clsClass="select_160px input_line_white"
                                                TabIndex="9" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="65"
                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                winHeight="620" Disabled="true" HideTrigger="true" isButton="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 5px">
                                           <table width="40px"><tr><td>ETD</td></tr></table>
                                        </td>
                                        <td align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtETD" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="10" Disabled="true" HideTrigger="true">
                                                    <%-- <Listeners>
                                                        <Change Handler="if(#{txtATD}.getValue(true)==''){#{txtATD}.setValue(this.getValue())}" />
                                                    </Listeners>--%>
                                                </ext:DateField>
                                            </span>
                                        </td>
                                        <td align="left" id="GridView_5" style="padding-left: 5px">
                                        ETA
                                        </td>
                                        <td align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtETA" runat="server" Cls="text input_line_white" Width="85"
                                                    Format="dd/m/Y" TabIndex="11" Disabled="true" HideTrigger="true">
                                                    <%-- <Listeners>
                                                        <Change Handler="if(#{txtATA}.getValue(true)==''){#{txtATA}.setValue(this.getValue())}" />
                                                    </Listeners>--%>
                                                </ext:DateField>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 7px; padding-bottom: 5px">
                                            ATD
                                        </td>
                                        <td height="-2" align="left" id="GridView_5" style="padding-bottom: 6px">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtATD" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="12" Disabled="true" HideTrigger="true">
                                                </ext:DateField>
                                            </span>
                                        </td>
                                        <td align="left" id="GridView_5" style="padding-left: 5px; padding-bottom: 5px">
                                            ATA
                                        </td>
                                        <td align="left" id="GridView_5" style="padding-bottom: 6px">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtATA" runat="server" Cls="text input_line_white" Width="85"
                                                    Format="dd/m/Y" TabIndex="13" Disabled="true" HideTrigger="true">
                                                </ext:DateField>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                                                            <td style="vertical-align: top;">
                                   <table cellspacing="0" cellpadding="0"><tr><td style="padding-left: 7px; width:76px;">Salesman</td><td style="padding-left: 8px;"><uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="9" Width="69" clsClass="select_65"
                                                                        StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                                        winWidth="680" winHeight="560" />
                                    <ext:Store runat="server" ID="StoreSalesman" OnRefreshData="StoreSalesman_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store></td></tr></table> 
                                </td>    

                            <td>
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="60" align="left" class="font_11bold" style="padding-top:1px; padding-bottom: 44px;">Remark
                                 
                                            </td>
                                            <td align="left" style="padding-top:1px;">
                                                <ext:TextArea ID="txtMAWBRemark" runat="server" Width="260" Height="58" Cls="text_80px" TabIndex="14">
                                                </ext:TextArea>
                                            </td>
                                        </tr>
                                    </table>
                    </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-top: 9px;">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <div id="div_top" style="margin-top: 114px;margin-left:5px;" align="left">
                                    <table width="301px" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                                        <tr>
                                            <td class="font_11bold_1542af">
                                                &nbsp;&nbsp;Action
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="200" height="30" border="0" align="Center" cellpadding="0" cellspacing="0"
                                        style="padding-left: 5px">
                                        <tr>
                                            <td class="table" style="padding-bottom: 5px; padding-top: 5px; width: 70px;">
                                                <ext:Button ID="btnNext" runat="server" Width="65px" Text="Next" Hidden="false">
                                                    <Listeners>
                                                        <Click Handler="(ReturnNull()&&ValidataText());" />
                                                    </Listeners>
                                                    <DirectEvents>
                                                        <Click OnEvent="btnNext_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                 <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridFlightList}.getRowsValues())"
                                                                    Mode="Raw" />
                                                                <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{gpInvoice}.getRowsValues())"
                                                                    Mode="Raw" />
                                                            </ExtraParams>
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                            <td class="table" style="padding-left: 3px; width: 70px;">
                                                <ext:Button ID="btnVoid" runat="server" Width="65px" Text="Void">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnVoid_Click">
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                            <td class="table" style="padding-left: 3px; width: 70px;">
                                                <ext:Button ID="btnCancel" runat="server" Width="65px" Text="Cancel">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnCancel_Click">
                                                            <EventMask ShowMask="true" Msg=" Waiting ... " />
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                            <td class="table" style="padding-left: 3px; width: 70px; padding-right: 3px;">
                                                <ext:Button ID="btnSave" runat="server" Width="65px" Text="Save">
                                                    <Listeners>
                                                        <Click Handler="return (ReturnNull()&&ValidataText());" />
                                                    </Listeners>
                                                    <DirectEvents>
                                                        <Click OnEvent="btnSave_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                 <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridFlightList}.getRowsValues())"
                                                                    Mode="Raw" />
                                                                <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{gpInvoice}.getRowsValues())"
                                                                    Mode="Raw" />
                                                            </ExtraParams>
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td align="left" valign="top" style="padding-top: 70px;padding-left:5px;">
                                        <table width="303" border="0" cellpadding="0" cellspacing="1" bgcolor="#8DB2E3" class="table" style=" line-height:26px !important;">
                                            <tr>
                                                <td width="60" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                    <table width="74" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td align="center">
                                                                GWT
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="101" align="center" bgcolor="#FFFFFF" style="padding-left: 2px; padding-right: 2px">
                                                    <ext:NumberField ID="txtGWT" runat="server" Cls="text" Width="70" TabIndex="20" StyleSpec="text-align:right" DecimalPrecision="3">
                                                        <Listeners>
                                                            <Blur Handler="if(this.getValue(true)>#{txtVWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtVWT}.getValue(true));}" />
                                                        </Listeners>
                                                    </ext:NumberField>
                                                </td>
                                                <td width="60" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td align="center">
                                                                Piece(s)
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="100" align="center" bgcolor="#FFFFFF" style="padding-left: 2px; padding-right: 2px">
                                                    <ext:NumberField ID="txtPiece" runat="server" Cls="text" Width="70" DecimalPrecision="1"
                                                        TabIndex="21" StyleSpec="text-align:right">
                                                    </ext:NumberField>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                    VWT
                                                </td>
                                                <td align="center" bgcolor="#FFFFFF">
                                                    <ext:NumberField ID="txtVWT" runat="server" Cls="text" Width="70" TabIndex="20" StyleSpec="text-align:right"  DecimalPrecision="3">
                                                        <Listeners>
                                                            <Blur Handler="if(this.getValue(true)>#{txtGWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtGWT}.getValue(true));}" />
                                                        </Listeners>
                                                    </ext:NumberField>
                                                </td>
                                                <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                    Pallet(s)
                                                </td>
                                                <td align="center" bgcolor="#FFFFFF">
                                                    <ext:NumberField ID="txtPallet" runat="server" Cls="text" Width="70" DecimalPrecision="1"
                                                        TabIndex="21" StyleSpec="text-align:right">
                                                    </ext:NumberField>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                    CWT
                                                </td>
                                                <td align="center" bgcolor="#FFFFFF">
                                                    <ext:NumberField ID="txtCWT" runat="server" Cls="text" Width="70" TabIndex="20" StyleSpec="text-align:right"  DecimalPrecision="3">
                                                    </ext:NumberField>
                                                </td>
                                                <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                    Rate
                                                </td>
                                                <td align="center" bgcolor="#FFFFFF">
                                                    <ext:NumberField ID="txtRate" runat="server" Cls="text" Width="70" DecimalPrecision="3"
                                                        TabIndex="21" StyleSpec="text-align:right">
                                                    </ext:NumberField>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                             </td>
                               </tr>
        </table>
                </td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="2" height="8">
                </td>
            </tr>
            <tr>
                <td valign="top" id="GridView_3">
                    <table cellpadding="0" cellspacing="0" width="670">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                height: 24px">
                                Local Invoice
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="gpInvoice" runat="server" Width="670" Height="148" TrackMouseOver="true"
                                    ColumnLines="True">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreInvoice">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="DN" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CN" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="DN_CNNO" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyName" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Currency" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Amount" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Print" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Void" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="AC" Type="Boolean">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel2">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="#" Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:CheckColumn Header="DN" Width="40" DataIndex="DN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="CN" Width="40" DataIndex="CN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="140">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="160">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="40">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="80" Align="Right">
                                            </ext:NumberColumn>
                                            <ext:CheckColumn Header="Print" DataIndex="Print" Width="40" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="Void" DataIndex="Void" Width="38" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="AC" DataIndex="AC" Width="38" Align="Center">
                                            </ext:CheckColumn>
                                            <%-- <ext:ImageCommandColumn Header="Action" Width="50" Align="Center">
                                            <Commands>
                                                    <ext:ImageCommand Icon="BinEmpty"  ToolTip-Text="Delete"   CommandName="Delete" Style="background-position: center center; width:60px">
<ToolTip Text="Delete"></ToolTip>
                                                    </ext:ImageCommand>
                                            </Commands>
                                            </ext:ImageCommandColumn>--%>
                                        </Columns>
                                    </ColumnModel>
                                    <%--<Listeners>
                                     <Command Handler="DeleteRow(#{gpInvoice},rowIndex)" />
                                    </Listeners>
                                     <KeyMap>
                                     <ext:KeyBinding Ctrl="true">
                                    <Keys>
                                        <ext:Key Code="DELETE" />
                                    </Keys>
                                    <Listeners>
                                        <Event Handler="DeleteRow(#{gpInvoice})" />
                                    </Listeners>
                                </ext:KeyBinding>
                            </KeyMap>--%>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="RowSelect">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 1px;">
                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="121" Width="303" />
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td valign="top" style="width: 677px;">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td valign="top" id="GridView_1" colspan="2" align="left">
                                <table cellpadding="0" cellspacing="0" border="0" width="670">
                                    <tr>
                                        <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                            border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                            height: 23px;">
                                            Flight Routing
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <ext:GridPanel ID="GridFlightList" runat="server" Width="670" Height="148" TrackMouseOver="true"
                                                ClicksToEdit="1" ColumnLines="True">
                                                <Store>
                                                    <ext:Store runat="server" ID="StoreFlight">
                                                        <Reader>
                                                            <ext:JsonReader IDProperty="RowID">
                                                                <Fields>
                                                                    <ext:RecordField Name="RowID" Type="Int">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="FlightNo" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="From" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="To" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="ETD" Type="string">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="ETA" Type="string">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="ATD" Type="string">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="ATA" Type="string">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Carrier" Type="string">
                                                                    </ext:RecordField>
                                                                </Fields>
                                                            </ext:JsonReader>
                                                        </Reader>
                                                    </ext:Store>
                                                </Store>
                                                <ColumnModel ID="clmFlight">
                                                    <Columns>
                                                        <ext:RowNumbererColumn Header="#" Width="30">
                                                        </ext:RowNumbererColumn>
                                                        <ext:Column Header="Flight No." DataIndex="FlightNo" Width="136">
                                                        </ext:Column>
                                                        <ext:Column Header="From" DataIndex="From" Width="70" Align="Center">
                                                        </ext:Column>
                                                        <ext:Column Header="To" DataIndex="To" Width="70" Align="Center">
                                                        </ext:Column>
                                                        <ext:Column Header="ETD" DataIndex="ETD" Width="85" Align="Center">
                                                        </ext:Column>
                                                        <ext:Column Header="ETA" DataIndex="ETA" Width="85" Align="Center">
                                                        </ext:Column>
                                                        <ext:Column Header="ATD" DataIndex="ATD" Width="85" Align="Center">
                                                        </ext:Column>
                                                        <ext:Column Header="ATA" DataIndex="ATA" Width="85" Align="Center">
                                                        </ext:Column>
                                                    </Columns>
                                                </ColumnModel>
                                                <Listeners>
                                                    <RowClick Handler="GetFRowID(rowIndex);SelectFRecord();" />
                                                </Listeners>
                                                <SelectionModel>
                                                    <ext:RowSelectionModel runat="server" ID="ctl5836">
                                                        <Listeners>
                                                            <RowSelect Handler="GetFRowID(rowIndex);" />
                                                        </Listeners>
                                                    </ext:RowSelectionModel>
                                                </SelectionModel>
                                            </ext:GridPanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="left" valign="top" >
                    <div id="isMawbFlag" runat="server">
                        <table width="296" border="0" align="left" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="5">
                                    <table width="303" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                                        <tr>
                                            <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                                style="padding-left: 5px">
                                                Add Flight
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" cellpadding="0" cellspacing="0" class="select_142px">
                                        <tr>
                                            <td height="5" colspan="4">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="44" height="25" class="font_11bold" style="padding-left: 5px">
                                            <table border="0" cellspacing="0" cellpadding="0" width="54px"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="35px"><tr><td>Carrier</td></tr></table></td><td class="font_red"  align="left">*</td></tr></table>
                                            </td>
                                            <td >
                                                
                                                            <%--<uc1:UserComboBox runat="server" ID="CmbCarrierRight" clsClass="select_160px" TabIndex="6"
                                                            StoreID="StoreCmb3" Width="67" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" Query="option=CompanyList" />--%>
                                                            <uc1:AutoComplete runat="server" ID="l_CmbCarrierRight" TabIndex="21" clsClass="x-form-text x-form-field text"
                                                                Query="option=CompanyList" Width="61" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                winWidth="800" winHeight="800" isDiplay="false" />
                                                        
                                            </td>
                                            <td height="25" class="font_11bold" style="padding-left:3px">
                                            <table border="0" cellspacing="0" cellpadding="0"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="54px"><tr><td>Flight No.</td></tr></table></td><td class="font_red"  align="left" style="padding-right:4px">*</td></tr></table>
                                            </td>
                                            <td height="0">
                                                <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="70">
                                                            <ext:TextField ID="l_flightno" runat="server" Cls="text" TabIndex="22">
                                                                <Listeners>
                                                                    <Focus Handler="ChangeFlight();" />
                                                                </Listeners>
                                                            </ext:TextField>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="0" style="padding-left:5px">
                                            <table border="0" cellspacing="0" cellpadding="0" width="54px"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="35px"><tr><td>From</td></tr></table></td><td class="font_red"  align="left">*</td></tr></table>
                                            </td>
                                            <td height="0">
                                                <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="70">
                                                            <uc1:UserComboBox runat="server" ID="l_from" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="22" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="67"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                                winHeight="620" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="padding-left:3px">
                                            <table border="0" cellspacing="0" cellpadding="0"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="54px"><tr><td>To</td></tr></table></td><td class="font_red"  align="left" style="padding-right:4px">*</td></tr></table>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <uc1:UserComboBox runat="server" ID="l_to" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="23" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="68"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                                winHeight="620" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="25" style="padding-left:5px">
                                            <table border="0" cellspacing="0" cellpadding="0" width="54px"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="35px"><tr><td>ETD</td></tr></table></td><td class="font_red"  align="left">*</td></tr></table>
                                            </td>
                                            <td align="left" id="Td1">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_etd" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="24">
                                                        <Listeners>
                                                            <%--<Blur Handler="if(#{l_eta}.getValue(true)==''){#{l_eta}.setValue(this.getValue())}" />--%>
                                                            <Blur Handler="#{l_eta}.setValue(this.getValue());" />
                                                        </Listeners>
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                            <td align="left" id="Td2" style="padding-left:3px">
                                            <table border="0" cellspacing="0" cellpadding="0"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="54px"><tr><td>ETA</td></tr></table></td><td class="font_red"  align="left" style="padding-right:4px">*</td></tr></table>
                                            </td>
                                            <td align="left" id="Td3">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_eta" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="25">
                                                        <%-- <Listeners>
                                                        <Change Handler="if(#{l_ata}.getValue(true)==''){#{l_ata}.setValue(this.getValue())}" />
                                                    </Listeners>--%>
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left:5px">
                                                ATD
                                            </td>
                                            <td height="-2" align="left" id="Td4">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_atd" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="26">
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                            <td align="left" id="Td5" style="padding-left: 4px">
                                                ATA
                                            </td>
                                            <td align="left" id="Td6">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_ata" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="27">
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" style="padding-top: 10px" align="right">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="InsertFRecord()" type="button" style="cursor: pointer" tabindex="28"
                                                                            value="Save & Next" class="btn_text btn_C" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="ResetFRecord()" type="button" style="cursor: pointer" tabindex="29"
                                                                            value="Reset" class="btn_text btn_C" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="DeleteFRecord()" type="button" style="cursor: pointer" tabindex="30"
                                                                            value="Delete" class="btn_text btn_C" />
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
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
              <td colspan="2">
               <uc1:Costing ID="ucCost"  runat="server" type="M2"  sys="AE"/>
              </td>   
            </tr>
           <tr>
                <td colspan="2" height="30">
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
