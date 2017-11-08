<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="AirExport_AEMakeConsol_List" %>
<%@ Register src="/common/UIControls/Costing.ascx" tagname="Costing" tagprefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AE Direct MAWB</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script> 

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../AirExport/AEValid/Valid.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var ChangeValue = function(value) {
            return String.format("{0}", ">" + (value == "" ? 0 : value));
        }
        function DeleteEmpty(grid) {
            if (grid.store.getTotalCount() > 0 && grid.id == "gpWTForeign") {
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var WT = data.WT;
                    var rate = data.Rate;
                    if (WT == undefined) { WT = 0; }
                    if (rate == undefined) { rate = 0; }

                    if ((WT == 0) && (rate == 0)) {
                        grid.getSelectionModel().selectRow(i);
                        grid.deleteSelected();
                    }
                }
            }
            else if (grid.store.getTotalCount() > 0 && grid.id == "gpWTLocal") {
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var WT = data.WT;
                    var rate = data.Rate;
                    if (WT == undefined) { WT = 0; }
                    if (rate == undefined) { rate = 0; }

                    if ((WT == 0) && (rate == 0)) {
                        grid.getSelectionModel().selectRow(i);
                        grid.deleteSelected();
                    }
                }
            }
        }
        function checkData(e) {
            if (e.grid == null) return;

            if (e.grid.store.getTotalCount() > 1) {
                var WTValue = e.grid.getRowsValues()[e.grid.store.getTotalCount() - 1].WT;
                if (WTValue == undefined) { WTValue = 0; }
                WTValue = parseFloat(WTValue);
                for (var i = 0; i < e.grid.store.getTotalCount() - 1; i++) {
                    var maxWT = e.grid.getRowsValues()[i].WT;
                    if (maxWT == undefined) { maxWT = 0; }
                    maxWT = parseFloat(maxWT);
                    if (maxWT == WTValue) {
                        e.grid.getSelectionModel().selectRow(e.grid.store.getTotalCount() - 1);
                        e.grid.deleteSelected();
                    }
                }
            }


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


        var selectFlRowIndex = -1;
        function GetFlRowID(row) {
            selectFlRowIndex = row;
        }
        function InsertFlRecord() {
            var flightno = $("#l_flightno").val().toUpperCase();
            var from = $("#l_from").val();
            var to = $("#l_to").val();
            var etd = $("#l_etd").val();
            var eta = $("#l_eta").val();
            var atd = $("#l_atd").val();
            var ata = $("#l_ata").val();
            var carrier = $("#l_CmbCarrierRight").val();

            if (carrier == "" || carrier == undefined) {
                NullMsg("Carrier");
                $("#l_CmbCarrierRight").focus();
                return;
            }
            if (flightno == "" || flightno == undefined) {
                NullMsg("Flight No");
                $("#l_flightno").focus();
                return;
            }
            if (from == "" || from == undefined) {
                NullMsg("From");
                $("#l_from").focus();
                return;
            }
            if (to == "" || to == undefined) {
                NullMsg("To");
                $("#l_to").focus();
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
            if (selectFlRowIndex >= 0) {
                var record = GridFlightList.getStore().getAt(selectFlRowIndex); // 获取当前行的数据
                if (isMawbFlag == 'Y' && selectFlRowIndex == 0) {
                    record.set("To", to);
                    record.set("ATD", atd);
                    record.set("ATA", ata);
                    record.set("Carrier", carrier);
                }
                else {
                    record.set("FlightNo", flightno);
                    record.set("From", from);
                    record.set("To", to);
                    record.set("ETD", etd);
                    record.set("ETA", eta);
                    record.set("ATD", atd);
                    record.set("ATA", ata);
                    record.set("Carrier", carrier);
                }
            }
            else {
                GridFlightList.insertRecord(count, { FlightNo: flightno, From: from, To: to, ETD: etd, ETA: eta, ATD: atd, ATA: ata, Carrier: carrier });
            }
            GridFlightList.getView().refresh();
            GridFlightList.view.focusEl.focus();
            ResetFlRecord();
            TabSum(GridFlightList);

        }

        function SelectFlRecord() {
            var record = GridFlightList.getStore().getAt(selectFlRowIndex); // 获取当前行的数据
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

        function DeleteFlRecord() {
            GridFlightList.getSelectionModel().selectRow(selectFlRowIndex);
            GridFlightList.deleteSelected();
            ResetFlRecord();
            TabSum(GridFlightList);
        }

        function ResetFlRecord() {
            selectFlRowIndex = -1;
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

        var selectFRowIndex = -1;
        function GetFRowID(row) {
            selectFRowIndex = row;
        }
        function InsertFRecord() {
            var company = $("#f_company").val().toUpperCase();
            var item = $("#f_item").val();
            var calc = "CWT";  //$("#f_calc").val();
            var qty = $("#txtCWT").val();
            var unit = $("#f_unit").val();
            //var currency = $("#CmbForeign").val();
            var currency = $("#f_currency").val();
            var ex = $("#f_ex").val();
            var rate = $("#f_rate").val();
            var amount = $("#f_amount").val();
            var companyName = $("#f_company_text").val();
            var description = $("#f_item_text").text();
            var min = $("#f_min").val();
            var showin = $("#f_show").val();
            var total = amount == undefined || amount == "" ? qty * rate : amount;

            if (company == "" || company == undefined) {
                $("#f_company").focus();
                return;
            }
            if (item == "" || item == undefined) {
                $("#f_item").focus();
                return;
            }

            if ((rate == "" || rate == undefined) && (min == "" || min == undefined) && (amount == "" || amount == undefined)) {
                $("#f_rate").focus();
                return;
            }
            var count = gpForeign.store.getTotalCount();  // 获取当前行数
            if (selectFRowIndex >= 0) {
                var record = gpForeign.getStore().getAt(selectFRowIndex); // 获取当前行的数据
                record.set("CompanyCode", company);
                record.set("CompanyName", companyName);
                record.set("Item", item);
                record.set("Description", description);
                record.set("Total", total);
                record.set("CalcKind", calc);
                record.set("Qty", qty);
                record.set("Unit", unit);
                record.set("Currency", currency);
                record.set("EX", ex);
                record.set("Rate", rate);
                record.set("Amount", amount);
                record.set("Min", min);
                record.set("Show", showin);
            }
            else {
                gpForeign.insertRecord(count, { EX: ex, CompanyCode: company, CompanyName: companyName, Item: item, Description: description, Total: total, CalcKind: calc, Qty: qty, Unit: unit, Currency: currency, Rate: rate, Amount: amount, Show: showin, Min: min });
            }
            gpForeign.getView().refresh();
            gpForeign.view.focusEl.focus();
            ResetFRecord();

        }

        function SelectFRecord() {
            Invlidata("f_company");
            var record = gpForeign.getStore().getAt(selectFRowIndex); // 获取当前行的数据
            if (record == null || record == undefined)
                return;
            else {
                $("#f_company").val(record.data.CompanyCode).removeClass("bottom_line").attr("validata", "true");
                $("#f_item").val(record.data.Item);
                $("#f_calc").val(record.data.CalcKind);
                $("#f_qty").val(record.data.Qty);
                $("#f_unit").val(record.data.Unit);
                //$("#f_currency").val(record.data.Currency);
                $("#f_currency").val(record.data.Currency);
                $("#f_ex").val(record.data.EX);
                $("#f_rate").val(record.data.Rate);
                $("#f_amount").val(record.data.Amount);
                $("#f_company_text").val(record.data.CompanyName);
                $("#f_company_text1").val(record.data.CompanyName);
                $("#f_item_text").text(record.data.Description);
                $("#f_show").val(record.data.Show);
                $("#f_min").val(record.data.Min);
            }
        }

        function DeleteFRecord() {
            gpForeign.getSelectionModel().selectRow(selectFRowIndex);
            gpForeign.deleteSelected();
            ResetFRecord();
        }

        function ResetFRecord() {
            Invlidata("f_company");
            selectFRowIndex = -1;
            $("#f_company").val("").removeClass("bottom_line").attr("validata", "true").focus();
            $("#f_item").val("");
            $("#f_calc").val("");
            $("#f_qty").val("");
            $("#f_unit").val("");
            //$("#f_currency").val("");
            $("#f_currency").val("");
            $("#f_ex").val("");
            $("#f_rate").val("");
            $("#f_amount").val("");
            $("#f_company_text1").val("")
            $("#f_company_text").val("")
            $("#f_item_text").text("")
            $("#f_show").val("DN");
            $("#f_min").val("");
        }

        var selectLRowIndex = -1;
        function GetLRowID(row) {
            selectLRowIndex = row;
        }
        function InsertLRecord() {
            var company = $("#l_company").val().toUpperCase();
            var item = $("#l_item").val();
            var calc = "CWT"; //$("#l_calc").val();
            var qty = $("#txtCWT").val();
            var unit = $("#l_unit").val();
            var currency = $("#CmbLocal").val();
            var ex = $("#l_ex").val();
            var rate = $("#l_rate").val();
            var amount = $("#l_amount").val();
            var companyName = $("#l_company_text").val();
            var description = $("#l_item_text").text();
            var min = $("#l_min").val();
            var showin = $("#l_show").val();
            var total = amount == undefined || amount == "" ? qty * rate : amount;

            if (company == "" || company == undefined) {
                $("#l_company").focus();
                return;
            }
            if (item == "" || item == undefined) {
                $("#l_item").focus();
                return;
            }

            if ((rate == "" || rate == undefined) && (min == "" || min == undefined) && (amount == "" || amount == undefined)) {
                $("#l_rate").focus();
                return;
            }
            var count = gpLocal.store.getTotalCount();  // 获取当前行数
            if (selectLRowIndex >= 0) {
                var record = gpLocal.getStore().getAt(selectLRowIndex); // 获取当前行的数据
                record.set("CompanyCode", company);
                record.set("CompanyName", companyName);
                record.set("Item", item);
                record.set("Description", description);
                record.set("Total", total);
                record.set("CalcKind", calc);
                record.set("Qty", qty);
                record.set("Unit", unit);
                record.set("Currency", currency);
                record.set("EX", ex);
                record.set("Rate", rate);
                record.set("Amount", amount);
                record.set("Min", min);
                record.set("Show", showin);
            }
            else {
                gpLocal.insertRecord(count, { EX: ex, CompanyCode: company, CompanyName: companyName, Item: item, Description: description, Total: total, CalcKind: calc, Qty: qty, Unit: unit, Currency: currency, Rate: rate, Amount: amount, Show: showin, Min: min });
            }
            gpLocal.getView().refresh();
            gpLocal.view.focusEl.focus();
            ResetLRecord();

        }

        function SelectLRecord() {
            Invlidata("l_company");
            var record = gpLocal.getStore().getAt(selectLRowIndex); // 获取当前行的数据
            if (record == null || record == undefined)
                return;
            else {
                $("#l_company").val(record.data.CompanyCode).removeClass("bottom_line").attr("validata", "true");
                $("#l_item").val(record.data.Item);
                $("#l_calc").val(record.data.CalcKind);
                $("#l_qty").val(record.data.Qty);
                $("#l_unit").val(record.data.Unit);
                //$("#l_currency").val(record.data.Currency);
                $("#l_ex").val(record.data.EX);
                $("#l_rate").val(record.data.Rate);
                $("#l_amount").val(record.data.Amount);
                $("#l_company_text").val(record.data.CompanyName);
                $("#l_company_text1").val(record.data.CompanyName);
                $("#l_item_text").text(record.data.Description);
                $("#l_show").val(record.data.Show);
                $("#l_min").val(record.data.Min);
            }
        }

        function DeleteLRecord() {
            gpLocal.getSelectionModel().selectRow(selectLRowIndex);
            gpLocal.deleteSelected();
            ResetLRecord();
        }
        function ResetLRecord() {
            Invlidata("l_company");
            selectLRowIndex = -1;
            $("#l_company").val("").removeClass("bottom_line").attr("validata", "true").focus();
            $("#l_item").val("");
            $("#l_calc").val("");
            $("#l_qty").val("");
            $("#l_unit").val("");
            //$("#l_currency").val("");
            $("#l_ex").val("");
            $("#l_rate").val("");
            $("#l_amount").val("");
            $("#l_company_text1").val("")
            $("#l_company_text").val("")
            $("#l_item_text").text("")
            $("#l_show").val("DN");
            $("#l_min").val("");
        }



        function ReturnNull() {
            var shipper = "";
            var consignee = "";
            shipper = $("#CmbShipperCode").val();
            consignee = $("#CmbConsignee").val();
            if ($("#txtMAWB").attr("validata") == "false") {
                $("#div_bottom").html("<p class=\"error\">Status : Saved  failed , Error message: the input value is invalid .");
                return false;
            }
            else if (shipper == "" || shipper == undefined) {
                $("#CmbShipperCode").focus();
                NullMsg("Shipper");
                return false;
            }
            else if (consignee == "" || consignee == undefined) {
                $("#CmbConsignee").focus();
                NullMsg("Consignee");
                return false;
            }
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
            if (event.keyCode == 8 || event.keyCode == 46) {
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

        function MakeInvoice() {
            Ext.Msg.confirm('Make Invoice', 'Are you sure?', function(btn) {
                if (btn == 'yes') {
                    Ext.getCmp('btnSave').fireEvent('click', this);
                    setTimeout(function() { CompanyX.MakeInvoice(); }, 4000);
                }
            });
        }
        $(document).ready(function() {
            $("#f_company").focus(function() {
                if ($("#f_company").val() == "" && $("#CmbCompany").val() != "") {
                    $("#f_company").val($("#CmbCompany").val());
                    $("#f_company_text").val($("#CmbCompany_text").val());
                    $("#f_company_text1").val($("#CmbCompany_text").val());
                }
            });
            $("#l_company").focus(function() {
                if ($("#l_company").val() == "" && $("#CmbCompany1").val() != "") {
                    $("#l_company").val($("#CmbCompany1").val());
                    $("#l_company_text").val($("#CmbCompany1_text").val());
                    $("#l_company_text1").val($("#CmbCompany1_text").val());
                }
            });
        })
    </script>

    <style type="text/css">
        .textCenter
        {
            text-align: center;
            font-size: 10px;
            text-transform: capitalize;
        }
        
        #txtOperation
        {
            width:156px !important;
        }
            
        #txtAccount
        {
            width:156px !important;
        }
        
        #ucCost_cos_Amount
        {
            width: 40px !important;
        }
        
        #td_assCosting
        {
            padding-left: 7px !important;
        }
        
         #ucCost_cos_Currency
         {
            width: 37px !important;
         }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
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
    </ext:Store>
    
        <div id="div_top" style="margin-top: 118px; margin-left:687px; float:left">
                        <table width="301" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                            <tr>
                                <td width="300" class="font_12bold">
                                    <span class="font_11bold_1542af">&nbsp;&nbsp;Action</span>
                                </td>
                            </tr>
                        </table>
                        <table width="260" height="42" border="0" align="Center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="table" style="padding-bottom: 5px; padding-top: 5px">
                                    <ext:Button ID="btnNext" runat="server" Width="65px" Text="Next" Hidden="true">
                                        <Listeners>
                                            <Click Handler="return (ReturnNull()&&ValidataText());" />
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
                                                   
                                                    <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{gpForeign}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                     <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{gpLocal}.getRowsValues())" Mode="Raw">
                                                                      </ext:Parameter>
                                                      <ext:Parameter Name="p_safety_6" Value="Ext.encode(#{gpWTForeign}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                      <ext:Parameter Name="p_safety_7" Value="Ext.encode(#{gpWTLocal}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                </ExtraParams>
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:Button ID="btnRevert" runat="server" Width="65px" Text="Revert">
                                        <DirectEvents>
                                            <Click OnEvent="btnRevert_Click">
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
                                            <Click Handler="return  (ReturnNull()&&ValidataText());" />
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
                                                    
                                                    <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{gpForeign}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                     <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{gpLocal}.getRowsValues())" Mode="Raw">
                                                                      </ext:Parameter>
                                                      <ext:Parameter Name="p_safety_6" Value="Ext.encode(#{gpWTForeign}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                      <ext:Parameter Name="p_safety_7" Value="Ext.encode(#{gpWTLocal}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                </ExtraParams>
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                            </tr>
                        </table>
       
                    </div>
    <div id="div_title" style="width: 100%; z-index: 1000">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="A" />
    </div>
    <div id="div_title" style="padding-top: 80px; padding-left: 10px; z-index: 990;">
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
                                            AE-Direct MAWB
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
                                            <ext:Label ID="labLot" runat="server">
                                            </ext:Label>
                                        </td>
                                        <td style="padding-left: 2px;">
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
      <ext:Hidden ID="hidForeignID" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLocalID" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLotNo" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidIDList" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
     <ext:Store runat="server" ID="StoreShowIn">
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
    <ext:Store runat="server" ID="StoreCurrForeign" OnRefreshData="StoreCurrForeign_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreCurrLocal" OnRefreshData="StoreCurrLocal_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreCurrInvoiceForeign" OnRefreshData="StoreCurrInvoiceForeign_OnRefreshData">
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
    <div style="margin-top: 105px; padding-left: 10px;">
        <table border="0" cellpadding="0" cellspacing="0" width="980px">
            <tr>
                <td valign="top" style="padding-top: 10px">
                    <table cellpadding="0" cellspacing="0" border="0" width="653px">
                        <tr>
                            <td valign="top" style="padding-left: 5px">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="left" class="font_11bold" style="padding-left: 3px; height: 25px">
                                            MAWB
                                        </td>
                                        <td width="84" align="left">
                                            <ext:TextField ID="txtMAWB" runat="server" Cls="select" Width="88" TabIndex="1" EnableKeyEvents="true">
                                                <Listeners>
                                                    <Blur Handler="validName(this.id,'MAWB',#{hidSeed}.getValue());" />
                                                    <KeyUp Handler="ChangeMawb(event);" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="center"><table width="50px"><tr><td>Sales</td></tr></table></td>
                                        <td align="left"> <uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="1" Width="85" clsClass="select_65"
                                                                        StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                                        winWidth="680" winHeight="560" /></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left:1px"><table width="75px"><tr><td>Shipper</td><td class="font_red" align="right">*</td></tr></table></td>
                                        <td colspan="3" align="left" class="font_11px_gray" style="padding-top: 4px">
                                            <table width="250" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbShipperCode" Query="option=CompanyList" clsClass="select_160px"
                                                Width="100" TabIndex="4" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbShipperCode" TabIndex="4" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="61" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left:1px"><Table width="75px"><tr><td>Consignee</td><td class="font_red" align="right">*</td></tr></Table></td>
                                        <td colspan="3" align="left" style="padding-top: 6px">
                                            <table width="250" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbConsignee" Query="option=CompanyList" clsClass="select_160px"
                                                Width="100" TabIndex="5" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbConsignee" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="61" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" style="padding-top: 3px; padding-left:5px">
                                <table border="0" cellpadding="0" cellspacing="0" class="select_142px" style="border: 1px solid #8db2e3;
                                    width: 315px; height: 70px">
                                    <tr>
                                        <td height="0" align="left" style="padding-left: 6px">
                                            <table width="50" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td align="left">
                                                        Carrier
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="0">
                                            <table width="68" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="68">
                                                        <uc1:UserComboBox runat="server" ID="CmbCarrierRight" isButton="false" HideTrigger="true"
                                                            ListWidth="180" clsClass="select_160px input_line_white" TabIndex="8" Query="option=LocationList&sys=A"
                                                            StoreID="StoreLocation" Width="88" winTitle="Location" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="845" winHeight="620" Disabled="true" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 2px;"><table width="60"><tr><td>Flight No.</td></tr></table></td>
                                        <td valign="middle" class="font_11px_gray">
                                            <ext:TextField ID="txtFlightRight" runat="server" Cls="text input_line_white " TabIndex="7"
                                                Disabled="true" Width="88">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="0" style="padding-left: 6px">
                                            From
                                        </td>
                                        <td height="0">
                                            <table width="68" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="68">
                                                        <uc1:UserComboBox runat="server" ID="CmbFromRight" isButton="false" HideTrigger="true"
                                                            ListWidth="180" clsClass="select_160px input_line_white" TabIndex="8" Query="option=LocationList&sys=A"
                                                            StoreID="StoreLocation" Width="88" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                                            winWidth="845" winHeight="620" Disabled="true" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 4px;">
                                            To
                                        </td>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="80px">
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="CmbToRight" ListWidth="180" clsClass="select_160px input_line_white"
                                                            TabIndex="9" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="88"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                            winHeight="620" Disabled="true" HideTrigger="true" isButton="false" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 6px">
                                            ETD
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
                                        <td align="left" id="GridView_5" style="padding-left: 4px">
                                            ETA
                                        </td>
                                        <td align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtETA" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="11" Disabled="true" HideTrigger="true">
                                                    <%-- <Listeners>
                                                        <Change Handler="if(#{txtATA}.getValue(true)==''){#{txtATA}.setValue(this.getValue())}" />
                                                    </Listeners>--%>
                                                </ext:DateField>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 7px">
                                            ATD
                                        </td>
                                        <td height="-2" align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtATD" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="12" Disabled="true" HideTrigger="true">
                                                </ext:DateField>
                                            </span>
                                        </td>
                                        <td align="left" id="GridView_5" style="padding-left: 4px">
                                            <table cellpadding="0" cellspacing="0" border="0" width="30">
                                                <tr>
                                                    <td>
                                                        ATA
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtATA" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="13" Disabled="true" HideTrigger="true">
                                                </ext:DateField>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td align="right" valign="top" style="padding-top: 5px">
                                <table border="0" cellpadding="0" cellspacing="1" bgcolor="#8DB2E3" class="table"
                                    width="325px">
                                    <tr>
                                        <td align="center" bgcolor="#FFFFFF" width="65" class="font_11bold">
                                                        GWT
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                            <ext:NumberField ID="txtGWT" runat="server" Cls="text" Width="80" TabIndex="6" StyleSpec="text-align:right" DecimalPrecision="3">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue(true)>#{txtVWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtVWT}.getValue(true));}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" width="63" class="font_11bold">
                                                        Piece(s)
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                            <ext:NumberField ID="txtPiece" runat="server" Cls="text" Width="80" DecimalPrecision="1"
                                                StyleSpec="text-align:right" TabIndex="9">
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                            VWT
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                            <ext:NumberField ID="txtVWT" runat="server" Cls="text" Width="80" TabIndex="7" StyleSpec="text-align:right" DecimalPrecision="3">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue(true)>#{txtGWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtGWT}.getValue(true));}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td bgcolor="#FFFFFF" align="center" class="font_11bold">
                                            Pallet(s)
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                            <ext:NumberField ID="txtPallet" runat="server" Cls="text" Width="80" DecimalPrecision="1"
                                                StyleSpec="text-align:right" TabIndex="10">
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" align="center" class="font_11bold">
                                            CWT
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                            <ext:NumberField ID="txtCWT" runat="server" Cls="text" Width="80" TabIndex="8" StyleSpec="text-align:right" DecimalPrecision="3">
                                            </ext:NumberField>
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                            Rate
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                            <ext:NumberField ID="txtRate" runat="server" Cls="text" Width="80" DecimalPrecision="2"
                                                StyleSpec="text-align:right" TabIndex="11">
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-left: 7px; padding-top: 4px" valign="top">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td valign="top" style="padding-bottom: 4px">
                                            Account Remark
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <ext:TextArea ID="txtAccount" runat="server" Width="156px" Height="68px" StyleSpec="text-transform:capitalize"
                                                Cls="text" TabIndex="12">
                                            </ext:TextArea>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-top:4px; padding-left:5px">   <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td valign="top" style="padding-bottom: 4px">
                                            Operation Remark
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <ext:TextArea ID="txtOperation" runat="server" Width="156px" Height="68px" StyleSpec="text-transform:capitalize"
                                                Cls="text" TabIndex="12">
                                            </ext:TextArea>
                                        </td>
                                    </tr>
                                </table></td>
                                <td style="padding-top:4px; padding-left:4px">   <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td valign="top" style="padding-bottom: 4px">
                                            Remark
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <ext:TextArea ID="txtRemark" runat="server" Width="303px" Height="68px" StyleSpec="text-transform:capitalize"
                                                Cls="text" TabIndex="12">
                                            </ext:TextArea>
                                        </td>
                                    </tr>
                                </table></td>
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
                <td colspan="2">
                <table cellpadding="0" cellspacing="0" border="0"><tr>
                <td valign="top" id="GridView_1" align="left" width="671">
                    <table cellpadding="0" cellspacing="0" border="0" width="671">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                height: 23px">
                                Flight Routing
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="GridFlightList" runat="server" Width="671" Height="148" TrackMouseOver="true"
                                    ColumnLines="True">
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
                                            <ext:Column Header="Flight No." DataIndex="FlightNo" Width="100">
                                            </ext:Column>
                                            <ext:Column Header="From" DataIndex="From" Width="55" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="To" DataIndex="To" Width="55" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="ETD" DataIndex="ETD" Width="80" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="ETA" DataIndex="ETA" Width="80" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="ATD" DataIndex="ATD" Width="80" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="ATA" DataIndex="ATA" Width="80" Align="Center">
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <Listeners>
                                        <RowClick Handler="GetFlRowID(rowIndex);SelectFlRecord();" />
                                    </Listeners>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="ctl5836">
                                            <Listeners>
                                                <RowSelect Handler="GetFlRowID(rowIndex);" />
                                            </Listeners>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 6px" align="left" width="310px">
                    <div id="isMawbFlag" runat="server">

                        <script type="text/javascript">
                            var isMawbFlag = 'N';
                        </script>

                        <table width="302" border="0" align="left" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="5" style=" padding-top:1px;">
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
                                            <td style="padding-left: 4px"><table width="50px"><tr><td>Carrier</td><td class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td height="0" style="padding-right: 2px">
                                                <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="70">
                                                            <uc1:AutoComplete runat="server" ID="l_CmbCarrierRight" TabIndex="13" clsClass="x-form-text x-form-field text"
                                                                Query="option=CompanyList" Width="61" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                winWidth="800" winHeight="800" isDiplay="false" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td><td height="25" style="padding-left: 2px"><table width="68"><tr><td align="left">Flight No.</td><td  class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td height="0">
                                                <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="70">
                                                            <ext:TextField ID="l_flightno" runat="server" Cls="text" TabIndex="14">
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
                                            <td style="padding-left: 4px"><table width="50px"><tr><td>From</td><td class="font_red" align="right">*</td></tr></table>
                                            <td>
                                                <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="70">
                                                            <uc1:UserComboBox runat="server" ID="l_from" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="15" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="67"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                                winHeight="620" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="padding-left: 2px;"><table width="68px"><tr><td>To</td><td class="font_red" align="right">*</td></tr></table> </td>
                                            <td>
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <uc1:UserComboBox runat="server" ID="l_to" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="16" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="67"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                                winHeight="620" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 4px; height:25px"><table width="50px"><tr><td>ETD</td><td  class="font_red" align="right">*</td></tr></table> </td>
                                            <td align="left" id="Td1">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_etd" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="17">
                                                       <Listeners>
                                                            <%--<Blur Handler="if(#{l_eta}.getValue(true)==''){#{l_eta}.setValue(this.getValue())}" />--%>
                                                            <Blur Handler="#{l_eta}.setValue(this.getValue());" />
                                                        </Listeners>
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                            <td align="left" style="padding-left: 2px"><table width="68px"><tr><td>ETA</td><td class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td align="left" id="Td3">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_eta" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="18">
                                                        <%-- <Listeners>
                                                        <Change Handler="if(#{l_ata}.getValue(true)==''){#{l_ata}.setValue(this.getValue())}" />
                                                    </Listeners>--%>
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 7px">
                                                ATD
                                            </td>
                                            <td height="-2" align="left" id="Td4">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_atd" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="19">
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                            <td align="left" style="padding-left: 4px">
                                                ATA
                                            </td>
                                            <td align="left" id="Td6">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_ata" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="20">
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" style="padding-top: 10px" align="right">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="padding-right: 3px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="InsertFlRecord()" type="button" style="cursor: pointer" tabindex="21"
                                                                            value="Save & Next" class="btn_text btn_C" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="padding-right: 3px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="ResetFlRecord()" type="button" style="cursor: pointer" tabindex="22"
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
                                                                        <input onclick="DeleteFlRecord()" type="button" style="cursor: pointer" tabindex="22"
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
                </tr></table>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            
        
            <tr>
                <td valign="top" id="GridView_3">
                    <table cellpadding="0" cellspacing="0" border="0" width="671">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                height: 24px">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                Local Invoice
                                                            </td>
                                                            <td align="right" style="padding-right: 4px">
                                                                <div id="showGenerate" style="display:none;">
                                                             
                                                                <table cellpadding="0" cellspacing="0" cellpadding="0" id="tab_GENERATE">
                                                                    <tr>
                                                                        <td background="../../images/btn_bg_01.jpg" style="width: 6px; height: 19px">
                                                                        </td>
                                                                        <td background="../../images/btn_bg_02.jpg">
                                                                            <a href="javascript:void(0)"  onclick="MakeInvoice();" class="font_11bold_1542af">Generate</a>
                                                                        </td>
                                                                        <td background="../../images/btn_bg_03.jpg" style="width: 6px; height: 19px">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="gpInvoice" runat="server" Width="671" Height="148" TrackMouseOver="true"
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
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="145">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="65" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right">
                                            </ext:NumberColumn>
                                            <ext:CheckColumn Header="Print" DataIndex="Print" Width="40" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="Void" DataIndex="Void" Width="38" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="AC" DataIndex="AC" Width="38" Align="Center">
                                            </ext:CheckColumn>
                                         
                                        </Columns>
                                    </ColumnModel>
                                   
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="RowSelect">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 5px;">
                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="121" />
                </td>
           </tr>
            <%--BEGIN--%>
            <tr >
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr >
            <td colspan="2">
            <table border="0" cellspacing="0" cellpadding="0"  align="left">
                                    <tbody>
                                        <tr>
                                            <td height="5" valign="top" width="242px">
                                                <table border="0" cellspacing="1" cellpadding="0" width="241" bgcolor="#8db2e3" height="25">
                                                    <tbody>
                                                        <tr>
                                                            <td style="padding-left: 5px" class="font_11bold_1542af" bgcolor="#ffffff" background="../../images/bg_line_3.jpg"
                                                                align="left">
                                                                <table><tr><td>
                                                                 Foreign Freight
                                                                </td>
                                                                 <td style="padding-left: 61px" class="nav_menu_4 font_11px_gray" align="left">
                                                                                <label>
                                                                                    <ext:ComboBox ID="CmbForeign" runat="server" Cls="select" DisplayField="value" ForceSelection="true"
                                                                                        Mode="Local" TriggerAction="All" StoreID="StoreCurrForeign" TabIndex="23" ValueField="value"
                                                                                        Width="80">
                                                                                        <Listeners>
                                                                                            <Select Handler="if(this.getValue()!='') {#{lblCurForeign}.setText(this.getValue());}" />
                                                                                        </Listeners>
                                                                                        <Template Visible="False" ID="Template15" StopIDModeInheritance="False" EnableViewState="False">
                                                                                        </Template>
                                                                                    </ext:ComboBox>
                                                                                </label>
                                                                            </td>
                                                                </tr></table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="select_142px" border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td height="3" colspan="3">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-left: 6px; padding-top: 5px" class="font_11bold" height="0" valign="top">
                                                                <table cellpadding="0" cellspacing="0" border="0" width="64px">
                                                                    <tr>
                                                                        <td>
                                                                            Company
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td height="0" style="padding-left: 1px; padding-top: 5px" width="190px">
                                                                <%--<uc1:UserComboBox runat="server" ID="CmbCompany" Query="option=CompanyList" clsClass="select_160px"
                                                            Width="150" TabIndex="22" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                                <uc1:AutoComplete runat="server" ID="CmbCompany" TabIndex="22" clsClass="x-form-text x-form-field text"
                                                                    isAlign="false" Query="option=CompanyList" Width="77" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                    winWidth="800" winHeight="800" />
                                                            </td>
                                                            <td height="0" width="5">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-left: 5px" height="0">
                                                                Sell Rate
                                                            </td>
                                                            <td height="0" colspan="2">
                                                                <table border="0" cellspacing="1" cellpadding="0" width="100">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td>
                                                                                <ext:TextField ID="ForMin" ReadOnly="true" Cls="textCenter text" runat="server" Text="Min"
                                                                                    Width="104" Enabled="false" >
                                                                                </ext:TextField>
                                                                            </td>
                                                                            <td>
                                                                                <ext:NumberField ID="txtFor" runat="server" Width="65" Cls="text" TabIndex="22" StyleSpec="text-align:right">
                                                                                </ext:NumberField>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td id="Td2" height="0" colspan="2" style="padding-left: 1px; padding-top: 4px"
                                                                align="left">
                                                                <ext:GridPanel ID="gpWTForeign" runat="server" Width="170px" Height="117" TrackMouseOver="true"
                                                                    StripeRows="true" ColumnLines="True" ClicksToEdit="1">
                                                                    <Store>
                                                                        <ext:Store runat="server" ID="storeWTForeign">
                                                                            <Reader>
                                                                                <ext:JsonReader IDProperty="RowID">
                                                                                    <Fields>
                                                                                        <ext:RecordField Name="RowID" Type="Int">
                                                                                        </ext:RecordField>
                                                                                        <ext:RecordField Name="WT" Type="Float">
                                                                                        </ext:RecordField>
                                                                                        <ext:RecordField Name="Rate" Type="Float">
                                                                                        </ext:RecordField>
                                                                                    </Fields>
                                                                                </ext:JsonReader>
                                                                            </Reader>
                                                                        </ext:Store>
                                                                    </Store>
                                                                    <ColumnModel runat="server" ID="ColumnModel5">
                                                                        <Columns>
                                                                            <ext:Column Header="W.T." DataIndex="WT" Width="81" Align="center">
                                                                                <Renderer Fn="ChangeValue" />
                                                                                <Editor>
                                                                                    <ext:NumberField ID="txtWTForeign" runat="server" AllowBlank="false" AllowNegative="false">
                                                                                    </ext:NumberField>
                                                                                </Editor>
                                                                            </ext:Column>
                                                                            <ext:NumberColumn Header="Rate" DataIndex="Rate" Width="70" Align="Right" Format="0.000">
                                                                                <Editor>
                                                                                    <ext:NumberField ID="txtRateForeign" runat="server">
                                                                                    </ext:NumberField>
                                                                                </Editor>
                                                                            </ext:NumberColumn>
                                                                        </Columns>
                                                                    </ColumnModel>
                                                                    <KeyMap>
                                                                        <ext:KeyBinding>
                                                                            <Keys>
                                                                                <ext:Key Code="INSERT" />
                                                                            </Keys>
                                                                            <Listeners>
                                                                                <Event Handler="DeleteEmpty(#{gpWTForeign});InsertRow(#{gpWTForeign},false,0);" />
                                                                            </Listeners>
                                                                        </ext:KeyBinding>
                                                                        <ext:KeyBinding Ctrl="true">
                                                                            <Keys>
                                                                                <ext:Key Code="DELETE" />
                                                                            </Keys>
                                                                            <Listeners>
                                                                                <Event Handler="DeleteRow(#{gpWTForeign})" />
                                                                            </Listeners>
                                                                        </ext:KeyBinding>
                                                                        <ext:KeyBinding>
                                                                            <Keys>
                                                                                <ext:Key Code="TAB" />
                                                                            </Keys>
                                                                            <Listeners>
                                                                                <Event Handler="DeleteEmpty(#{gpWTForeign});InsertRow(#{gpWTForeign},true,0);" />
                                                                            </Listeners>
                                                                        </ext:KeyBinding>
                                                                        <ext:KeyBinding>
                                                                            <Keys>
                                                                                <ext:Key Code="ENTER" />
                                                                            </Keys>
                                                                            <Listeners>
                                                                                <Event Handler="EditRow(#{gpWTForeign},0)" />
                                                                            </Listeners>
                                                                        </ext:KeyBinding>
                                                                    </KeyMap>
                                                                    <Listeners>
                                                                        <Click Handler="NewRow(#{gpWTForeign},0,0)" />
                                                                        <AfterEdit Fn="checkData" />
                                                                    </Listeners>
                                                                    <SelectionModel>
                                                                        <ext:RowSelectionModel ID="RowSelectionModel5" runat="server">
                                                                            <Listeners>
                                                                                <RowSelect Handler="getRowIndex(rowIndex);" />
                                                                            </Listeners>
                                                                        </ext:RowSelectionModel>
                                                                    </SelectionModel>
                                                                </ext:GridPanel>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td id="Td5" height="151" style="padding-left: 5px" valign="top">
                                                <table style="border-left: #8db2e3 1px solid; border-top: #8db2e3 1px solid; border-right: #8db2e3 1px solid"
                                                    border="0" cellspacing="0" cellpadding="0" width="423" bgcolor="#8db2e3" height="26px">
                                                    <tbody>
                                                        <tr>
                                                            <td bgcolor="#ffffff" background="../../images/bg_line_3.jpg" align="left">
                                                                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="padding-left: 5px" class="font_11bold_1542af" align="left">
                                                                                Foreign - Other Charge (<ext:Label ID="lblCurForeign" runat="server" Text="USD">
                                                                                </ext:Label>
                                                                                )
                                                                            </td>
                                                                           
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <ext:GridPanel ID="gpForeign" runat="server" Width="423" Height="190" TrackMouseOver="true"
                                                    AllowDomMove="true" ClicksToEdit="1">
                                                    <Store>
                                                        <ext:Store runat="server" ID="StoreForeign">
                                                            <Reader>
                                                                <ext:JsonReader IDProperty="RowID">
                                                                    <Fields>
                                                                        <ext:RecordField Name="RowID" Type="Int">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="CompanyCode" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="CompanyName" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Item" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Description" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Total" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="CalcKind" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Qty" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Unit" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="EX" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Rate" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Amount" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Currency" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Min" Type="String">
                                                                        </ext:RecordField>
                                                                        <ext:RecordField Name="Show" Type="String">
                                                                        </ext:RecordField>
                                                                    </Fields>
                                                                </ext:JsonReader>
                                                            </Reader>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="ColumnModel3">
                                                        <Columns>
                                                            <ext:Column Header="Item" DataIndex="Item" Width="45" Align="Center">
                                                            </ext:Column>
                                                            <ext:Column Header="Code" DataIndex="CompanyCode" Width="128" Align="Center">
                                                            </ext:Column>
                                                            <ext:Column Header="CUR" DataIndex="Currency" Width="35" Align="Center" >
                                                            </ext:Column>
                                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="200" Align="Center" Hidden="true">
                                                            </ext:Column>
                                                            <ext:Column Header="Calc.By" DataIndex="CalcKind" Width="55" Align="Center" Hidden="true">
                                                            </ext:Column>
                                                            <ext:NumberColumn Header="Min" DataIndex="Min" Width="50" Align="Right">
                                                            </ext:NumberColumn>
                                                            <ext:NumberColumn Header="Rate" DataIndex="Rate" Width="70" Align="Right" Format="0.000">
                                                            </ext:NumberColumn>
                                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="right">
                                                            </ext:NumberColumn>
                                                            <ext:Column Header="Show" DataIndex="Show" Width="60" Align="Center" Hidden="true">
                                                            </ext:Column>
                                                        </Columns>
                                                    </ColumnModel>
                                                    <Listeners>
                                                        <RowClick Handler="GetFRowID(rowIndex);SelectFRecord();" />
                                                    </Listeners>
                                                    <SelectionModel>
                                                        <ext:RowSelectionModel ID="RowSelectionModel3" runat="server">
                                                            <Listeners>
                                                                <RowSelect Handler="GetFRowID(rowIndex);" />
                                                            </Listeners>
                                                        </ext:RowSelectionModel>
                                                    </SelectionModel>
                                                </ext:GridPanel>
                                            </td>
                                            <td style="padding-left: 7px" width="300px" valign="top" align="left">
                                                <table cellpadding="0" cellspacing="0" border="0" style="width: 303px; height: 215px">
                                                    <tr>
                                                        <td colspan="6" style="height: 23px; padding-left: 5px;" class="font_11bold_1542af table_nav2">
                                                            Add Foreign
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-top: 16px; padding-left:4px" valign="top"><table width="59px"><tr><td>Company</td></tr></table></td>
                                                        <td colspan="5" style="padding-top: 10px; width: 220px">
                                                            <uc1:AutoComplete runat="server" ID="f_company" clsClass="x-form-text x-form-field text_82px"
                                                                isAlign="false" TabIndex="24" isText="true" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" />
                                                        </td>
                                                    </tr>
                                                   <tr>
                                                        <td style="padding-left:4px"><table width="50px"><tr><td>Item</td></tr></table></td>
                                                        <td colspan="5">
                                                        <uc1:UserComboBox runat="server" StoreID="StoreGetItem" ID="f_item" isText="false"
                                                            isAlign="false" TabIndex="25" clsClass="text_82px" Width="69" winTitle="Item"
                                                            winUrl="/BasicData/Item/list.aspx?sys=A" Handler="GetAEItemData('foreign','f_item','f_calc','f_qty','f_unit','f_currency','f_rate','f_amount','f_ex','f_min')" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td  style="padding-left: 6px; padding-top:2px">
                                                            Currency
                                                        </td>
                                                        <td colspan="5" style="padding-top: 3px">
                                                            <table cellpadding="0" cellspacing="0" style="padding-top: 2px">
                                                                <tr>
                                                                    <td>
                                                                       <ext:ComboBox ID="f_currency" runat="server" Cls="select_65" StoreID="StoreCurrInvoiceForeign"
                                                                            Width="51" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                                            TriggerAction="All">
                                                                            <Listeners>
                                                                                <Select Handler="#{f_ex}.setValue(record.data.rate)" />
                                                                            </Listeners>
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                    <td style="padding-left: 4px;">
                                                                       <ext:NumberField ID="f_ex" runat="server" Width="80" DecimalPrecision="4" StyleSpec="text-align:right"
                                                                            Cls="select_160px" TabIndex="31">
                                                                        </ext:NumberField>
                                                                    </td>
                                                                  
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td class="tb_01" style="padding-left: 7px">
                                                            Calc
                                                        </td>
                                                        <td colspan="5" style="padding-top: 3px">
                                                            <table cellpadding="0" cellspacing="0" style="padding-top: 2px">
                                                                <tr>
                                                                    <td>
                                                                        <ext:ComboBox runat="server" ID="f_calc" Cls="select_160px" StoreID="StoreKind" TabIndex="26"
                                                                            DisplayField="value" ValueField="value" Width="69" ForceSelection="true" TriggerAction="All"
                                                                            Mode="Local">
                                                                            <Listeners>
                                                                                <Select Handler="SelectCalc('f_calc','f_qty','f_unit')" />
                                                                            </Listeners>
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" style="padding-left: 4px; padding-right: 4px">
                                                                            <tr>
                                                                                <td>
                                                                                    <%-- Currency--%>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        <table cellpadding="0" cellspacing="0" border="0" style="padding-left: 4px; padding-right: 5px">
                                                                            <tr>
                                                                                <td>
                                                                                    <ext:NumberField ID="f_qty" runat="server" Width="40" TabIndex="29" Cls="select_160px"
                                                                                        StyleSpec="text-align:right" DecimalPrecision="3">
                                                                                    </ext:NumberField>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        <uc1:UserComboBox runat="server" StoreID="StoreUnit" Width="45" ID="f_unit" ListWidth="180"
                                                                            TabIndex="30" winTitle="Unit" winUrl="/BasicData/Unit/list.aspx?sys=A" winWidth="510"
                                                                            winHeight="585" clsClass="text_80px" />
                                                                        
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tb_01" style="padding-left: 6px">
                                                            Min
                                                        </td>
                                                        <td>
                                                            <ext:NumberField ID="f_min" runat="server" Width="51" TabIndex="27" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="2">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{f_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td class="tb_01" style="padding-left: 2px"><table width="30px"><tr><td>Rate</td></tr></table></td>
                                                        <td>
                                                            <ext:NumberField ID="f_rate" runat="server" Width="50" TabIndex="28" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{f_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td align="left"><table width="50"><tr><td align="center">Amount</td></tr></table></td>
                                                        <td align="left">
                                                            <ext:NumberField ID="f_amount" runat="server" Width="50" TabIndex="29" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="2">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{f_rate}.setValue();#{f_min}.setValue();}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="vertical-align: top; padding-left: 6px; padding-top: 5px">
                                                            Show
                                                        </td>
                                                        <td colspan="5" style="vertical-align: top; padding-top: 3px">
                                                            <ext:ComboBox ID="f_show" runat="server" StoreID="StoreShowIn" DisplayField="text"
                                                                Cls="select_65" ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All"
                                                                Width="69" TabIndex="29" Text="DN">
                                                            </ext:ComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" style="padding-right: 1px; padding-top: 10px" align="right">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td style="padding-right: 3px">
                                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                            <tr>
                                                                                <td class="btn_L">
                                                                                </td>
                                                                                <td>
                                                                                    <input onclick="if(ValidataCompany('f_company')){InsertFRecord()}" type="button"
                                                                                        style="cursor: pointer" tabindex="30" value="Save & Next" class="btn_text btn_C" />
                                                                                </td>
                                                                                <td class="btn_R">
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="padding-right: 3px">
                                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                            <tr>
                                                                                <td class="btn_L">
                                                                                </td>
                                                                                <td>
                                                                                    <input onclick="ResetFRecord()" type="button" style="cursor: pointer" tabindex="31"
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
                                                                                    <input onclick="DeleteFRecord()" type="button" style="cursor: pointer" tabindex="32"
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
                                    </tbody>
               </table>
            </td>
            </tr>
            <tr >
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr >
            <td colspan="2">
             <table cellpadding="0" cellspacing="0" border="0">
                                    <tr id="tr_list2">
                                        <td valign="top" >
                                               <table border="0" cellspacing="0" cellpadding="0" width="240" align="left">
                                                <tbody>
                                                    <tr>
                                                        <td height="5" valign="top">
                                                            <table border="0" cellspacing="1" cellpadding="0" width="241" bgcolor="#8db2e3" height="25">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="padding-left: 5px" class="font_11bold_1542af" bgcolor="#ffffff" background="../../images/bg_line_3.jpg"
                                                                            align="left">
                                                                            <table><tr><td>
                                                                                Local Freight
                                                                            </td>
                                                                             <td style="padding-left: 75px; padding-top: 1px" class="nav_menu_4 font_11px_gray"
                                                                                        align="right">
                                                                                        <label>
                                                                                            <ext:ComboBox ID="CmbLocal" runat="server" Cls="select" DisplayField="value" StoreID="StoreCurrLocal"
                                                                                                ForceSelection="true" Mode="Local" TriggerAction="All" TabIndex="35" ValueField="value"
                                                                                                Width="80">
                                                                                                <Listeners>
                                                                                                    <Select Handler="if(this.getValue()!='') {#{lblCurLocal}.setText(this.getValue());}" />
                                                                                                </Listeners>
                                                                                                <Template Visible="False" ID="Template17" StopIDModeInheritance="False" EnableViewState="False">
                                                                                                </Template>
                                                                                            </ext:ComboBox>
                                                                                        </label>
                                                                                    </td>
                                                                            </tr></table>
                                                                        
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <table class="select_142px" border="0" cellspacing="0" cellpadding="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td height="3" colspan="3">
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="padding-left: 6px; padding-top: 5px" class="font_11bold" valign="top">
                                                                            <table cellpadding="0" cellspacing="0" border="0" width="65px">
                                                                                <tr>
                                                                                    <td>
                                                                                        Company
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td style="padding-top: 5px" width="190px">
                                                                          
                                                                            <uc1:AutoComplete runat="server" ID="CmbCompany1" TabIndex="33" clsClass="x-form-text x-form-field text"
                                                                                isAlign="false" Query="option=CompanyList" Width="77" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                                winWidth="800" winHeight="800" />
                                                                        </td>
                                                                        <td width="7">
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                    <td style="padding-left: 6px" height="0">
                                                                        Sell Rate
                                                                    </td>
                                                                    <td height="0" colspan="2">
                                                                        <table border="0" cellspacing="0" cellpadding="0" width="100">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding-right: 1px">
                                                                                        <ext:TextField ID="txtLocMin" ReadOnly="true" Cls="textCenter text" runat="server" Text="Min"
                                                                                            Width="104" Enabled="false">
                                                                                        </ext:TextField>
                                                                                    </td>
                                                                                    <td>
                                                                                        <ext:NumberField ID="txtLoc" runat="server" Width="65" Cls="text" TabIndex="34" StyleSpec="text-align:right">
                                                                                        </ext:NumberField>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                    </tr>
                                                                  <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td id="GridView_6" height="0" colspan="2" align="left" style="padding-top: 5px">
                                                            <ext:GridPanel ID="gpWTLocal" runat="server" Width="170px" Height="118" TrackMouseOver="true"
                                                                StripeRows="true" ColumnLines="True" ClicksToEdit="1">
                                                                <Store>
                                                                    <ext:Store runat="server" ID="storeWTLocal">
                                                                        <Reader>
                                                                            <ext:JsonReader IDProperty="RowID">
                                                                                <Fields>
                                                                                    <ext:RecordField Name="RowID" Type="Int">
                                                                                    </ext:RecordField>
                                                                                    <ext:RecordField Name="WT" Type="Float">
                                                                                    </ext:RecordField>
                                                                                    <ext:RecordField Name="Rate" Type="Float">
                                                                                    </ext:RecordField>
                                                                                </Fields>
                                                                            </ext:JsonReader>
                                                                        </Reader>
                                                                    </ext:Store>
                                                                </Store>
                                                                <ColumnModel runat="server" ID="ColumnModel6">
                                                                    <Columns>
                                                                        <ext:Column Header="W.T." DataIndex="WT" Width="81" Align="center">
                                                                            <Renderer Fn="ChangeValue" />
                                                                            <Editor>
                                                                                <ext:NumberField ID="txtWTLocal" runat="server" AllowBlank="false" AllowNegative="false">
                                                                                </ext:NumberField>
                                                                            </Editor>
                                                                        </ext:Column>
                                                                        <ext:NumberColumn Header="Rate" DataIndex="Rate" Width="70" Align="Right" Format="0.000">
                                                                            <Editor>
                                                                                <ext:NumberField ID="txtRateLocal" runat="server">
                                                                                </ext:NumberField>
                                                                            </Editor>
                                                                        </ext:NumberColumn>
                                                                    </Columns>
                                                                </ColumnModel>
                                                                <KeyMap>
                                                                    <ext:KeyBinding>
                                                                        <Keys>
                                                                            <ext:Key Code="INSERT" />
                                                                        </Keys>
                                                                        <Listeners>
                                                                            <Event Handler="DeleteEmpty(#{gpWTLocal});InsertRow(#{gpWTLocal},false,0);" />
                                                                        </Listeners>
                                                                    </ext:KeyBinding>
                                                                    <ext:KeyBinding Ctrl="true">
                                                                        <Keys>
                                                                            <ext:Key Code="DELETE" />
                                                                        </Keys>
                                                                        <Listeners>
                                                                            <Event Handler="DeleteRow(#{gpWTLocal})" />
                                                                        </Listeners>
                                                                    </ext:KeyBinding>
                                                                    <ext:KeyBinding>
                                                                        <Keys>
                                                                            <ext:Key Code="TAB" />
                                                                        </Keys>
                                                                        <Listeners>
                                                                            <Event Handler="DeleteEmpty(#{gpWTLocal});InsertRow(#{gpWTLocal},true,0);" />
                                                                        </Listeners>
                                                                    </ext:KeyBinding>
                                                                    <ext:KeyBinding>
                                                                        <Keys>
                                                                            <ext:Key Code="ENTER" />
                                                                        </Keys>
                                                                        <Listeners>
                                                                            <Event Handler="EditRow(#{gpWTLocal},0)" />
                                                                        </Listeners>
                                                                    </ext:KeyBinding>
                                                                </KeyMap>
                                                                <Listeners>
                                                                    <Click Handler="NewRow(#{gpWTLocal},0,0)" />
                                                                    <AfterEdit Fn="checkData" />
                                                                </Listeners>
                                                                <SelectionModel>
                                                                    <ext:RowSelectionModel ID="RowSelectionModel6" runat="server">
                                                                        <Listeners>
                                                                            <RowSelect Handler="getRowIndex(rowIndex);" />
                                                                        </Listeners>
                                                                    </ext:RowSelectionModel>
                                                                </SelectionModel>
                                                            </ext:GridPanel>
                                                        </td>
                                                    </tr>
                                                        </tbody>
                                                           </table>
                                                           </td></tr></tbody></table>
                                        </td>
                                        <td valign="top" style="padding-left: 6px">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td>
                                                        <table style="border-left: #8db2e3 1px solid; border-top: #8db2e3 1px solid; border-right: #8db2e3 1px solid"
                                                            border="0" cellspacing="0" cellpadding="0" height="26px" bgcolor="#8db2e3" width="423">
                                                            <tbody>
                                                                <tr>
                                                                    <td bgcolor="#ffffff" background="../../images/bg_line_3.jpg" align="left">
                                                                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding-left: 5px" class="font_11bold_1542af" align="left">
                                                                                        Local - Other Charge (<ext:Label ID="lblCurLocal" runat="server" Text="HKD">
                                                                                        </ext:Label>
                                                                                        )
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
                                                <tr valign="top">
                                                    <td id="GridView_2" height="190">
                                                        <ext:GridPanel ID="gpLocal" runat="server" Width="423" Height="190" TrackMouseOver="true"
                                                            AllowDomMove="true" ClicksToEdit="1">
                                                            <Store>
                                                                <ext:Store runat="server" ID="StoreLocal">
                                                                    <Reader>
                                                                        <ext:JsonReader IDProperty="RowID">
                                                                            <Fields>
                                                                                <ext:RecordField Name="RowID" Type="Int">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="CompanyCode" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="CompanyName" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Item" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Description" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Total" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="CalcKind" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Qty" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Unit" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="EX" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Rate" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Amount" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Currency" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Min" Type="String">
                                                                                </ext:RecordField>
                                                                                <ext:RecordField Name="Show" Type="String">
                                                                                </ext:RecordField>
                                                                            </Fields>
                                                                        </ext:JsonReader>
                                                                    </Reader>
                                                                </ext:Store>
                                                            </Store>
                                                            <ColumnModel ID="ColumnModel4">
                                                                <Columns>
                                                                    <ext:Column Header="Item" DataIndex="Item" Width="70" Align="Center">
                                                                    </ext:Column>
                                                                    <ext:Column Header="Code" DataIndex="CompanyCode" Width="135" Align="Center">
                                                                    </ext:Column>
                                                                    <ext:Column Header="Company" DataIndex="CompanyName" Width="200" Align="Center" Hidden="true">
                                                                    </ext:Column>
                                                                    <ext:Column Header="Calc.By" DataIndex="CalcKind" Width="55" Align="Center" Hidden="true">
                                                                    </ext:Column>
                                                                    <ext:Column Header="Currency" DataIndex="Currency" Width="65" Align="Center" Hidden="true">
                                                                    </ext:Column>
                                                                    <ext:NumberColumn Header="Min" DataIndex="Min" Width="50" Align="Right">
                                                                    </ext:NumberColumn>
                                                                    <ext:NumberColumn Header="Rate" DataIndex="Rate" Width="70" Align="Right" Format="0.000">
                                                                    </ext:NumberColumn>
                                                                    <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="right">
                                                                    </ext:NumberColumn>
                                                                    <ext:Column Header="Show" DataIndex="Show" Width="60" Align="Center" Hidden="true">
                                                                    </ext:Column>
                                                                </Columns>
                                                            </ColumnModel>
                                                            <Listeners>
                                                                <RowClick Handler="GetLRowID(rowIndex);SelectLRecord();" />
                                                            </Listeners>
                                                            <SelectionModel>
                                                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
                                                                    <Listeners>
                                                                        <RowSelect Handler="GetLRowID(rowIndex);" />
                                                                    </Listeners>
                                                                </ext:RowSelectionModel>
                                                            </SelectionModel>
                                                        </ext:GridPanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 6px"  valign="top">
                                                <table cellpadding="0" cellspacing="0" style="height: 215px; width: 303px">
                                                    <tr><td colspan="6" style="height: 23px; line-height: 23px; padding-left: 7px;" class="font_11bold_1542af table_nav2">Add Local</td></tr>
                                                    <tr><td valign="top" style="padding-top:14px; padding-left:4px"><table width="59px"><tr><td>Company</td></tr></table></td>
                                                            <td colspan="5" style="padding-top: 10px; width: 220px">
                                                            <uc1:AutoComplete runat="server" ID="l_company" clsClass="x-form-text x-form-field text_82px"
                                                                isAlign="false" TabIndex="35" isText="true" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" />
                                                            </td>  
                                                    </tr>
                                                    <tr><td valign="top" style="padding-top:5px; padding-left:6px">Item</td>
                                                            <td colspan="5" >
                                                            <uc1:UserComboBox runat="server" StoreID="StoreGetItem" ID="l_item" isText="true"
                                                                isAlign="false" TabIndex="36" clsClass="select_160px" Width="69" winTitle="Item"
                                                                winUrl="/BasicData/Item/list.aspx?sys=A" Handler="GetAEItemData('local','l_item','l_calc','l_qty','l_unit','l_currency','l_rate','l_amount','l_ex','l_min')" />
                                                             </td>     
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td class="tb_01" style="padding-left: 7px">
                                                            Calc
                                                        </td>
                                                        <td colspan="5" style="padding-top: 3px">
                                                            <table cellpadding="0" cellspacing="0" style="padding-top: 2px">
                                                                <tr>
                                                                    <td>
                                                                        <ext:ComboBox runat="server" ID="l_calc" Cls="select_160px" StoreID="StoreKind" TabIndex="38"
                                                                            DisplayField="value" ValueField="value" Width="69" ForceSelection="true" TriggerAction="All"
                                                                            Mode="Local">
                                                                            <Listeners>
                                                                                <Select Handler="SelectCalc('l_calc','l_qty','l_unit')" />
                                                                            </Listeners>
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" style="padding-left: 4px; padding-right: 4px">
                                                                            <tr>
                                                                                <td>
                                                                                    <%--Currency--%>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        <ext:ComboBox ID="l_currency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                                                            Width="51" TabIndex="39" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                                            TriggerAction="All">
                                                                            <Listeners>
                                                                                <Select Handler="#{l_ex}.setValue(record.data.rate)" />
                                                                            </Listeners>
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        <table cellpadding="0" cellspacing="0" border="0" style="padding-left: 4px; padding-right: 5px">
                                                                            <tr>
                                                                                <td>
                                                                                    <ext:NumberField ID="l_qty" runat="server" Width="40" TabIndex="40" Cls="select_160px"
                                                                                        StyleSpec="text-align:right" DecimalPrecision="3">
                                                                                    </ext:NumberField>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        <uc1:UserComboBox runat="server" StoreID="StoreUnit" Width="45" ID="l_unit" ListWidth="180"
                                                                            TabIndex="30" winTitle="Unit" winUrl="/BasicData/Unit/list.aspx?sys=A" winWidth="510"
                                                                            winHeight="585" clsClass="text_80px" />
                                                                        <ext:NumberField ID="l_ex" runat="server" Width="65" DecimalPrecision="4" StyleSpec="text-align:right"
                                                                            Cls="select_160px" TabIndex="41">
                                                                        </ext:NumberField>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr><td class="tb_01" style="padding-left: 6px">Min</td>
                                                            <td>
                                                            <ext:NumberField ID="l_min" runat="server" Width="50" TabIndex="37" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="2">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{l_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td  style="padding-left: 2px"><table width="30px"><tr><td>Rate</td></tr></table></td>
                                                        <td style="padding-left: 1px">
                                                            <ext:NumberField ID="l_rate" runat="server" Width="50" TabIndex="38" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{l_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td align="left">
                                                        <table width="50"><tr><td align="center">Amount</td></tr></table>
                                                        </td>
                                                        <td align="left">
                                                            <ext:NumberField ID="l_amount" runat="server" Width="50" TabIndex="39" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="2">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{l_rate}.setValue();#{l_min}.setValue();}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-left: 6px; padding-top: 6px" valign="top">
                                                            Show
                                                        </td>
                                                        <td colspan="5" style="vertical-align: top; padding-top: 3px">
                                                            <ext:ComboBox ID="l_show" runat="server" StoreID="StoreShowIn" DisplayField="text"
                                                                Cls="select_65" Text="DN" ValueField="value" Mode="Local" ForceSelection="true"
                                                                TriggerAction="All" Width="69" TabIndex="40">
                                                            </ext:ComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" style="padding-right: 1px; padding-top: 10px" align="right">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td style="padding-right: 3px">
                                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                            <tr>
                                                                                <td class="btn_L">
                                                                                </td>
                                                                                <td>
                                                                                    <input onclick="if(ValidataCompany('l_company')){InsertLRecord()}" type="button"
                                                                                        style="cursor: pointer" tabindex="41" value="Save & Next" class="btn_text btn_C" />
                                                                                </td>
                                                                                <td class="btn_R">
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="padding-right: 3px">
                                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                            <tr>
                                                                                <td class="btn_L">
                                                                                </td>
                                                                                <td>
                                                                                    <input onclick="ResetLRecord()" type="button" style="cursor: pointer" tabindex="42"
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
                                                                                    <input onclick="DeleteLRecord()" type="button" style="cursor: pointer" tabindex="43"
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
            </td>
            </tr>
             <%--END--%>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
            <td colspan="2">
            <uc1:Costing ID="ucCost"  runat="server" type="M3"  sys="AE"/>
            </td> 
            </tr>
        </table>
         <br />
        <br />
        <br />
    </div>
    
    </form>
</body>
</html>
