<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="AirExport_AEColoaderIn_List" %>
<%@ Register src="/common/UIControls/Costing.ascx" tagname="Costing" tagprefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
       <%@ Register Src="../../common/UIControls/Transfer.ascx" TagName="Transfer"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%=Request["type"]=="s"?"AE Shipping Note":"AE Co-Loader In" %></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script> 

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../AirExport/AEValid/Valid.js" type="text/javascript"></script>

    <script type="text/javascript">    

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
       
        
        var selectRowIndex = -1;
        function GetRowID(row) {
            selectRowIndex = row;
        }
        function InsertORecord() {
            var company = $("#o_company").val().toUpperCase();
            var calc = "CWT"; //$("#o_calc").val();
            var currency = $("#o_currency").val();
            var rate = $("#o_rate").val();
            var amount = $("#o_amount").val();
            var companyName = $("#o_company_text").val();
            var remark = $("#o_remark").val();
            var ex = $("#o_ex").val();


            if (company == "" || company == undefined) {
                $("#o_company").focus();
                return;
            }

            if ((rate == "" || rate == undefined) && (amount == "" || amount == undefined)) {
                $("#o_rate").focus();
                return;
            }
            var count = gpAPCommssion.store.getTotalCount();  // 获取当前行数
            if (selectRowIndex >= 0) {
                var record = gpAPCommssion.getStore().getAt(selectRowIndex); // 获取当前行的数据
                record.set("CompanyCode", company);
                record.set("CompanyName", companyName);
                record.set("CalcKind", calc);
                record.set("Currency", currency);
                record.set("Rate", rate);
                record.set("Amount", amount);
                record.set("Remark", remark);
                record.set("EX",ex);
            }
            else {
                gpAPCommssion.insertRecord(count, { CompanyCode: company, CompanyName: companyName, CalcKind: calc, Currency: currency, Rate: rate, Amount: amount, Remark: remark ,EX:ex});
            }
            gpAPCommssion.getView().refresh();
            gpAPCommssion.view.focusEl.focus();
            ResetORecord();

        }

        function SelectORecord() {
            Invlidata("o_company");
            var record = gpAPCommssion.getStore().getAt(selectRowIndex); // 获取当前行的数据
            if (record == null || record == undefined)
                return;
            else {
                $("#o_company").val(record.data.CompanyCode).removeClass("bottom_line").attr("validata", "true");
                $("#o_calc").val(record.data.CalcKind);
                $("#o_currency").val(record.data.Currency);
                $("#o_rate").val(record.data.Rate);
                $("#o_amount").val(record.data.Amount);
                $("#o_company_text").val(record.data.CompanyName);
                $("#o_company_text1").val(record.data.CompanyName);
                $("#o_remark").val(record.data.Remark);
                $("#o_ex").val(record.data.EX);
            }
        }

        function DeleteORecord() {
            gpAPCommssion.getSelectionModel().selectRow(selectRowIndex);
            gpAPCommssion.deleteSelected();
            ResetORecord();
        }

        function ResetORecord() {
            Invlidata("o_company");
            selectRowIndex = -1;
            $("#o_company").val("").removeClass("bottom_line").attr("validata", "true").focus();
            $("#o_calc").val("");
            $("#o_currency").val("");
            $("#o_rate").val("");
            $("#o_amount").val("");
            $("#o_company_text1").val("")
            $("#o_company_text").val("")
            $("#o_remark").val("");
            $("#o_ex").val("");
        }
        function ReturnNull() {
            var from = "";
            var to = "";
            var shipper = "";
            var consignee = "";
            var est = "";
            var salsman = "";
            var piece = "";
            from = $("#CmbDeparture").val();
            to = $("#CmbFinalDest").val();
            shipper = $("#CmbShipperCode").val();
            consignee = $("#CmbConsignee").val();
            est = $("#txtEst").val();
            salsman = $("#CmbSalesman").val();
            piece = $("#txtPiece").val();
            if ($("#txtHawb").attr("validata") == "false") {
                $("#div_bottom").html("<p class=\"error\">Status : Saved  failed , Error message: the input value is invalid .");
                return false;
            }
            else if (from == "" || from == undefined) {
                $("#CmbDeparture").focus();
                NullMsg("Receipt");
                return false;
            }
            else if (to == "" || to == undefined) {
                $("#CmbFinalDest").focus();
                NullMsg("Dest.");
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
            else if (est == "" || est == undefined) {
                $("#txtEst").focus();
                NullMsg("Est Receipt");
                return false;
            }
            else if (salsman == "" || salsman == undefined) {
                $("#CmbSalesman").focus();
                NullMsg("Salesman");
                return false;
            }
            else if (piece == "" || piece == undefined) {
                $("#txtPiece").focus();
                NullMsg("Piece(s)");
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

        function CheckSpecial(flag) {
            if (flag) {

                $("#tr_list1,#tr_list2,#tab_GENERATE").css("display", "none");
            }
            else {
                $("#tr_list1,#tr_list2,#tab_GENERATE").css("display", "inline");
            }
        }

       
    </script>

    <style type="text/css">
        .textCenter
        {
            text-align: center;
            font-size: 10px;
            text-transform: capitalize;
        }
        
        #ucCost_cos_EX
        {
            width: 48px !important;
        }
        
        #ucCost_cos_Amount
        {
            width: 48px !important;
        }
        
       #ucCost_cos_Remark
        {
            width: 224px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_title" style="width:100%; z-index: 1000">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="A" />
    </div>
   
   <div id="div_title" style="margin-left: 10px; margin-top: 80px;z-index:990;">
        <table cellpadding="0" cellspacing="0" border="0" width="981px" class="table_nav1 font_11bold_1542af">
            <tr>
                <td style="padding-left:5px;">
                <table>
                <tr><td><img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                        alt="View" onclick="createFrom('AE');" />&nbsp;</td><td><%=Request["type"]=="s"?"AE-Shipping Note":"AE-Co-Loader In" %></td>
                        <td style="padding-top:2px;">&nbsp;<img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle; display:none;" /></td></tr>
                </table>  
                </td>
                <td align="right" style="padding-right:5px;">
                <table cellpadding="0" cellspacing="0" border="0">
                <tr><td style="font-weight: bold;" align="right">
                 <ext:Label ID="labHeader" runat="server"></ext:Label>
                 </td><td>
                 <%if (!string.IsNullOrEmpty(Request["seed"]))
                 { %>
                  <uc1:Transfer runat="server" ID="TransferSys" sys="AE" type="H"/>
                   <%} %>
                  </td></tr></table>
                 </td>
            </tr>
        </table>
    </div>
       <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidMAWB" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLotNo" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidForeignID" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLocalID" runat="server">
    </ext:Hidden>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
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
    <ext:Store runat="server" ID="StoreKind">
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
    <div style="margin-left: 10px; margin-bottom: 10px;">
        <table>
            <tr>
                <td style="height: 105px;">
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellspacing="0" cellpadding="0" width="980">
                        <tbody>
                            <tr>
                                <td style="padding-left: 5px; padding-top: 5px" valign="top" width="670px">
                                    <table border="0" cellpadding="0" cellspacing="0" width="670px">
                                        <tbody>
                                            <tr>
                                                <td style="padding-left: 2px; height: 22px" class="font_11bold" align="left">
                                                    HAWB
                                                </td>
                                                <td align="left" style="padding-left: 2px">
                                                    <ext:TextField ID="txtHawb" runat="server" Cls="select" Width="104" TabIndex="1">
                                                        <Listeners>
                                                            <Blur Handler="validName(this.id,'HAWB',#{hidSeed}.getValue());" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </td>
                                                <td align="left" style="padding-left: 10px">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="60">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    Reference
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td colspan="2" align="left" style="padding-left: 2px; padding-right: 10px">
                                                    <ext:TextField ID="txtReference" runat="server" Cls="select" Width="200" TabIndex="2">
                                                    </ext:TextField>
                                                </td>
                                                <td align="left">
                                                <table cellpadding="0" cellspacing="0" border="0" ><tr><td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="65px"><tr><td>N/P</td></tr></table>
                                                </td>
                                                <td class="font_red">*</td>
                                                </tr></table>
                                                
                                                 
                                                </td>
                                                <td valign="center" align="left">
                                                    <table border="0" cellspacing="0" cellpadding="0">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85" style="padding-left: 2px">
                                                                    <ext:ComboBox ID="CmbNP" runat="server" Cls="select" DisplayField="value" TabIndex="3"
                                                                        ForceSelection="true" Mode="Local" TriggerAction="All" ValueField="value" Width="110">
                                                                        <Template Visible="False" ID="ctl2563" StopIDModeInheritance="False" EnableViewState="False">
                                                                        </Template>
                                                                        <Items>
                                                                            <ext:ListItem Text="N" Value="N" />
                                                                            <ext:ListItem Text="P" Value="P" />
                                                                        </Items>
                                                                    </ext:ComboBox>
                                                                </td>
                                                                <td width="107">
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 2px; height: 22px" class="font_11bold" align="left">
                                                <table cellpadding="0" cellspacing="0" border="0"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="60px"><tr><td>Receipt</td></tr></table></td>
                                                <td class="font_red" >*</td></tr></table>
                                                </td>
                                                <td class="font_11px_gray" align="left" style="padding-right: 2px; padding-left:2px">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85" align="left">
                                                                    <uc1:UserComboBox runat="server"  ID="CmbDeparture" ListWidth="180" clsClass="select_160px"
                                                                        TabIndex="3" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="84"
                                                                        winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                                        winHeight="620" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td class="font_11bold" align="left" style="padding-left: 11px">
                                                    Dest.<span class="font_red" style="padding-left:2px">*</span>
                                                </td>
                                                <td width="107" align="left" style="padding-left: 2px">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85">
                                                                    <uc1:UserComboBox runat="server" ID="CmbFinalDest" ListWidth="180" clsClass="select_160px"
                                                                        TabIndex="4" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="83"
                                                                        winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                                        winHeight="620" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td valign="center" align="left">
                                                    &nbsp;
                                                </td>
                                                    <td  align="left">
                                                    <table cellpadding="0" cellspacing="0" border="0"><tr>
                                                    <td><table cellpadding="0" cellspacing="0" border="0" width="65px"><tr><td>Salesman</td></tr></table></td>
                                                    <td class="font_red">*</td>
                                                    </tr></table>
                                                </td>
                                                <td align="left" style="padding-left: 2px">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85">
                                                                    <%--<uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="12" Query="option=SalesList"
                                                            Width="85" clsClass="select_65" StoreID="StoreCmb8" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                            winWidth="680" winHeight="560" />--%>
                                                                    <uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="5" Width="88" clsClass="select_65"
                                                                        StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                                        winWidth="680" winHeight="560" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                               
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 2px" class="font_11bold" valign="center" align="left">
                                                    <%=Request["type"]=="s"?"":"Co-Loader"%>
                                                </td>
                                                <td valign="top" colspan="6" align="left">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="396">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85" style="padding-left: 2px; padding-top: 2px">
                                                                    <%--<uc1:UserComboBox runat="server" ID="CmbCoLoader" Query="option=CompanyList" clsClass="select_160px"
                                                            Width="83" TabIndex="6" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                                    <uc1:AutoComplete runat="server" ID="CmbCoLoader" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                                        Query="option=CompanyList" Width="77" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                        winWidth="800" winHeight="800" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 2px; height: 23px" class="font_11bold"  align="left">
                                                <table cellpadding="0" cellspacing="0" border="0"><tr><td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="60px"><tr><td>Shipper</td></tr></table>
                                                </td><td class="font_red" >*</td></tr></table>
                                                </td>
                                                <td colspan="4" align="left">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="396">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85" style="padding-left: 2px">
                                                                    <%--<uc1:UserComboBox runat="server" ID="CmbShipperCode" Query="option=CompanyList" clsClass="select_160px"
                                                            Width="83" TabIndex="8" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                                    <uc1:AutoComplete runat="server" ID="CmbShipperCode" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                                        Query="option=CompanyList" Width="77" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                        winWidth="800" winHeight="800" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            
                                                <td valign="center" align="left">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="72">
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                <table cellpadding="0" cellspacing="0" border="0"><tr><td><table cellpadding="0" cellspacing="0" border="0" width="65px"><tr><td>Est Receipt</td></tr></table></td>
                                                                <td class="font_red">*</td>
                                                                </tr></table>
                                                            
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td align="left" style="padding-left: 2px">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100">
                                                        <tbody>
                                                            <tr>
                                                                <td width="108" colspan="2">
                                                                    <ext:DateField AllowBlank="false" ID="txtEst" runat="server" Width="110" Cls="text" Format="dd/m/Y"
                                                                        TabIndex="6">
                                                                    </ext:DateField>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 23px">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td style="padding-left: 2px" class="font_11bold" align="left">
                                                            <table width="60px" cellpadding="0" cellspacing="0" border="0"><tr><td>Consignee</td></tr></table>
                                                              <td class="font_red">*</td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td colspan="4" align="left">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="396">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85" style="padding-left: 2px">
                                                                    <%--<uc1:UserComboBox runat="server" ID="CmbConsignee" Query="option=CompanyList" clsClass="select_160px"
                                                            Width="83" TabIndex="9" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                                    <uc1:AutoComplete runat="server" ID="CmbConsignee" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                                        Query="option=CompanyList" Width="77" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                        winWidth="800" winHeight="800" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td valign="center" align="left" style="display: none;">
                                                    C/S
                                                </td>
                                                <td align="left" style="display: none;">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85">
                                                                    <ext:TextField ID="txtCS" runat="server" Cls="select" Width="106" ReadOnly="true"
                                                                        TabIndex="13">
                                                                    </ext:TextField>
                                                                </td>
                                                                <td width="107">
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                       
                                                    <td valign="center" align="left">
                                                    Act Receipt
                                                </td>
                                                <td align="left" style="padding-top: 1px">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100">
                                                        <tbody>
                                                            <tr>
                                                                <td width="108" colspan="2" style="padding-left: 2px">
                                                                    <ext:DateField ID="txtAct" runat="server" Width="110" Cls="text" Format="dd/m/Y"
                                                                        TabIndex="12">
                                                                    </ext:DateField>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 2px; height: 23px" class="font_11bold" valign="center" align="left">
                                                    Notify #1
                                                </td>
                                                <td colspan="4" align="left">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="396">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85" style="padding-left: 2px">
                                                                    <%--<uc1:UserComboBox runat="server" ID="CmbNotify1" Query="option=CompanyList" clsClass="select_160px"
                                                            Width="83" TabIndex="10" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                                    <uc1:AutoComplete runat="server" ID="CmbNotify1" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                                        Query="option=CompanyList" Width="77" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                        winWidth="800" winHeight="800" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <table border="0" cellspacing="0" cellpadding="0">
                                                        <tbody>
                                                            <tr>
                                                                <td style="padding-top: 1px; padding-left: 1px">
                                                                    <ext:Checkbox ID="chkSpecial" runat="server" TabIndex="14">
                                                                        <Listeners>
                                                                            <Check Handler="CheckSpecial(this.checked);" />
                                                                        </Listeners>
                                                                    </ext:Checkbox>
                                                                </td>
                                                                <td style="padding-left: 2px; padding-top: 5px" class="font_11bold">
                                                                    <%=Request["type"]=="s"?"Special Deal":""%>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 2px; height: 23px" class="font_11bold" valign="center" align="left">
                                                    Notify #2
                                                </td>
                                                <td valign="top" colspan="4" align="left" style="padding-top: 2px">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="396">
                                                        <tbody>
                                                            <tr>
                                                                <td width="85" style="padding-left: 2px">
                                                                    <%--<uc1:UserComboBox runat="server" ID="CmbNotify2" Query="option=CompanyList" clsClass="select_160px"
                                                            Width="83" TabIndex="11" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                                    <uc1:AutoComplete runat="server" ID="CmbNotify2" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                                        Query="option=CompanyList" Width="77" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                        winWidth="800" winHeight="800" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td>
                                                </td>
                                                <td valign="top" align="left">
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table>
                                        <tr>
                                            <td colspan="7" style="padding-bottom: 4px; padding-top: 2px"
                                                class="font_11bold" valign="top" align="left">
                                                <table cellpadding="0" cellspacing="0" border="0" width="66px">
                                                    <tr>
                                                        <td >
                                                            <%=Request["type"]=="s"?"":"Nature of goods"%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="7">
                                                <ext:TextArea ID="txtNature" runat="server" Width="574" Height="30" TabIndex="15"
                                                    Cls="text" StyleSpec="text-transform:capitalize">
                                                </ext:TextArea>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="padding-left:1px;">
                                    <div id="div_top" style="margin-top: 115px">
                                        <table class="table_nav2" border="0" cellspacing="0" cellpadding="0" width="301"
                                            height="25">
                                            <tbody>
                                                <tr>
                                                    <td class="font_12bold" width="277">
                                                        <span class="font_11bold_1542af">&nbsp;&nbsp;Action</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table border="0" cellspacing="0" cellpadding="0"   align="center" style="height: 30px">
                                            <tbody align="center">
                                                <tr>
                                                    <td style="padding-right:4px">
                                                        <ext:Button ID="btnPrint" runat="server" Width="55px" Text="Print">
                                                            <DirectEvents>
                                                                <Click OnEvent="btnPrint_Click"> 
                                                                </Click>
                                                            </DirectEvents>
                                                        </ext:Button>
                                                    </td>
                                                    <td  style="padding-right:4px">
                                                        <ext:Button ID="btnNext" runat="server" Width="55px" Text="Next">
                                                            <Listeners>
                                                                <Click Handler="return ReturnNull();" />
                                                            </Listeners>
                                                            <DirectEvents>
                                                                <Click OnEvent="btnNext_Click">
                                                                    <EventMask ShowMask="true" Msg=" Saving ... " />
                                                                    <ExtraParams>
                                                                         <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{gpForeign}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{gpLocal}.getRowsValues())" Mode="Raw">
                                                                        </ext:Parameter>
                                                                       
                                                                        <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{gpAPCommssion}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{gpWTForeign}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_6" Value="Ext.encode(#{gpWTLocal}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_invoice" Value="Ext.encode(#{gpInvoice}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                    </ExtraParams>
                                                                </Click>
                                                            </DirectEvents>
                                                        </ext:Button>
                                                    </td>
                                                    
                                                     
                                                    <td style="padding-right:4px">
                                                        <ext:Button ID="btnVoid" runat="server" Width="55px" Text="Void">
                                                            <DirectEvents>
                                                                <Click OnEvent="btnVoid_Click">
                                                                   
                                                                </Click>
                                                            </DirectEvents>
                                                             
                                                        </ext:Button>
                                                    </td>
                                                    <td style="padding-right:4px">
                                                        <ext:Button ID="btnCancel" runat="server" Width="55px" Text="Cancel">
                                                            <DirectEvents>
                                                                <Click OnEvent="btnCancel_Click">
                                                                    <EventMask ShowMask="true" Msg=" Loading ... " />
                                                                </Click>
                                                            </DirectEvents>
                                                        </ext:Button>
                                                    </td>
                                                    <td>
                                                        <ext:Button ID="btnSave" runat="server" Width="55px" Text="Save">
                                                            <Listeners>
                                                                <Click Handler="return (ReturnNull()&&ValidataText());" />
                                                            </Listeners>
                                                            <DirectEvents>
                                                                <Click OnEvent="btnSave_Click">
                                                                    <EventMask ShowMask="true" Msg=" Saving ... " />
                                                                    <ExtraParams>
                                                                         <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{gpForeign}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{gpLocal}.getRowsValues())" Mode="Raw">
                                                                        </ext:Parameter>
                                                                        
                                                                        <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{gpAPCommssion}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{gpWTForeign}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_6" Value="Ext.encode(#{gpWTLocal}.getRowsValues())"
                                                                            Mode="Raw">
                                                                        </ext:Parameter>
                                                                        <ext:Parameter Name="p_safety_invoice" Value="Ext.encode(#{gpInvoice}.getRowsValues())"
                                                                            Mode="Raw">
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
                                    <table class="table" border="0" cellspacing="1" cellpadding="0" width="302px" bgcolor="#8db2e3"
                                        style="margin-top: 75px;margin-right:5px;">
                                        <tbody>
                                           <%-- <tr>
                                                <td class="font_11bold" bgcolor="#ffffff" height="20" align="center">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="61">
                                                        <tbody>
                                                            <tr>
                                                                <td align="center">
                                                                    GWT
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td bgcolor="#ffffff" height="20" width="99" align="center">
                                                    <ext:NumberField ID="txtGWT" runat="server" Cls="text" Width="70" TabIndex="15" StyleSpec="text-align:right" DecimalPrecision="3">
                                                        <Listeners>
                                                            <Change Handler="if(this.getValue(true)>#{txtVWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtVWT}.getValue(true));}" />
                                                        </Listeners>
                                                    </ext:NumberField>
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td class="font_11bold" bgcolor="#ffffff" height="20" align="center">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="62">
                                                        <tbody>
                                                            <tr>
                                                                <td align="left" style="padding-left:7px">
                                                                    Piece(s)<span class="font_red" style="padding-left:2px">*</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td bgcolor="#ffffff" height="20" width="87" align="center">
                                                    <ext:NumberField AllowBlank="false" ID="txtPiece" runat="server" Cls="text" Width="70" DecimalPrecision="1"
                                                        StyleSpec="text-align:right" TabIndex="18">
                                                    </ext:NumberField>
                                                </td>
                                            </tr>--%>
                                             <tr>
                                                <td class="font_11bold" bgcolor="#ffffff" height="30" align="center" width="65">
                                                      <table border="0" cellspacing="0" cellpadding="0" width="65" style="height:10px;">
                                                        <tbody>
                                                            <tr>
                                                                <td align="center" >
                                                                    GWT
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td bgcolor="#ffffff" height="20" width="99" align="center">
                                                    <ext:NumberField ID="txtGWT" runat="server" Cls="text" Width="70" TabIndex="15" StyleSpec="text-align:right" DecimalPrecision="3">
                                                        <Listeners>
                                                            <Change Handler="if(this.getValue(true)>#{txtVWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtVWT}.getValue(true));}" />
                                                        </Listeners>
                                                    </ext:NumberField>
                                                </td>
                                                <td class="font_11bold" bgcolor="#ffffff" height="30" align="center" width="61">
                                                        <table border="0" cellspacing="0" cellpadding="0" width="61" style="height:10px;">
                                                        <tbody>
                                                            <tr>
                                                                <td align="center">
                                                                    Piece(s)<span class="font_red" style="padding-left:2px">*</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td bgcolor="#ffffff" height="20" width="87" align="center">
                                                    <ext:NumberField AllowBlank="false" ID="txtPiece" runat="server" Cls="text" Width="70" DecimalPrecision="1"
                                                        StyleSpec="text-align:right" TabIndex="18">
                                                    </ext:NumberField>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="font_11bold" bgcolor="#ffffff" height="20" align="center">
                                                    VWT
                                                </td>
                                                <td bgcolor="#ffffff" height="20" align="center">
                                                    <ext:NumberField ID="txtVWT" runat="server" Cls="text" Width="70" TabIndex="16" StyleSpec="text-align:right" DecimalPrecision="3">
                                                        <Listeners>
                                                            <Change Handler="if(this.getValue(true)>#{txtGWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtGWT}.getValue(true));}" />
                                                        </Listeners>
                                                    </ext:NumberField>
                                                </td>
                                                <td class="font_11bold" bgcolor="#ffffff" height="20" align="center">
                                                    Unit
                                                </td>
                                                <td bgcolor="#ffffff" height="20" align="left" style="padding-left: 7px">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <%--<uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                            TabIndex="19" Query="option=UnitBinding" StoreID="StoreCmb1" Width="44" winTitle="Unit"
                                            winUrl="/BasicData/Unit/list.aspx" winWidth="510" winHeight="585" />--%>
                                                                <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                                                    TabIndex="19" Query="option=UnitBinding" StoreID="StoreUnit" Width="49" winTitle="Unit"
                                                                    winUrl="/BasicData/Unit/list.aspx" winWidth="510" winHeight="585" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="font_11bold" bgcolor="#ffffff" height="20" align="center">
                                                    CWT
                                                </td>
                                                <td bgcolor="#ffffff" height="20" align="center">
                                                    <ext:NumberField ID="txtCWT" runat="server" Cls="text" Width="70" TabIndex="17" StyleSpec="text-align:right"  DecimalPrecision="3">
                                                    </ext:NumberField>
                                                </td>
                                                <td class="font_11bold" bgcolor="#ffffff" height="20" align="left" style="padding-left:7px">
                                                    Pallet(s)
                                                </td>
                                                <td bgcolor="#ffffff" height="20" align="center">
                                                    <ext:NumberField ID="txtPallet" runat="server" Cls="text" Width="70" DecimalPrecision="1"
                                                        StyleSpec="text-align:right" TabIndex="20">
                                                    </ext:NumberField>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table border="0" cellspacing="0" cellpadding="0" width="280">
                                        <tbody>
                                            <tr>
                                                <td height="5" colspan="3">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="70">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="62">
                                                        <tbody>
                                                            <tr>
                                                                <td style="text-align:center" >
                                                                   CBM
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td width="226" align="left" style="padding-left:11px;">
                                                   <ext:TextField ID="txtCbf" runat="server" Cls="text" Width="222" TabIndex="21"  Hidden="false">
                                                    </ext:TextField>
                                                </td>
                                                 <td >
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <%--<td style="height: 10px">
                                </td>--%>
                                 <td></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-top:5px">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0" style="margin-bottom: 10px;">
                                    <tr>
                                    </tr>
                                    <td valign="top" id="Td1">
                                        <table cellpadding="0" cellspacing="0" border="0" width="667">
                                            <tr>
                                                <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                                    border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                                    height: 24px">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                Local Invoice
                                                            </td>
                                                            <td align="right" style="padding-right: 5px; ">
                                                                <div id="showGenerate">
                                                                <%if (1==0)
                                                                  { %>
                                                                <table cellpadding="0" cellspacing="0" border="0" id="tab_GENERATE">
                                                                    <tr>
                                                                        <td class="nav_menu_5_01">
                                                                            <% if (!string.IsNullOrEmpty(Request["seed"])) { Response.Write("<a href=\"javascript:void(0)\"  onclick=\"MakeInvoice();\" class=\"font_11bold_1542af\"/>Generate</a>"); }%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <%} %></div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <ext:GridPanel ID="gpInvoice" runat="server" Width="667" Height="147" TrackMouseOver="true"
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
                                                        <ColumnModel ID="ColumnModel7">
                                                            <Columns>
                                                                <ext:RowNumbererColumn Header="#" Width="30">
                                                                </ext:RowNumbererColumn>
                                                                <ext:CheckColumn Header="DN" Width="40" DataIndex="DN" Align="Center">
                                                                </ext:CheckColumn>
                                                                <ext:CheckColumn Header="CN" Width="40" DataIndex="CN" Align="Center">
                                                                </ext:CheckColumn>
                                                                <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="130">
                                                                </ext:Column>
                                                                <ext:Column Header="Company" DataIndex="CompanyName" Width="175">
                                                                </ext:Column>
                                                                <ext:Column Header="CUR" DataIndex="Currency" Width="45" Align="Center">
                                                                </ext:Column>
                                                                <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right">
                                                                </ext:NumberColumn>
                                                                <ext:CheckColumn Header="Print" DataIndex="Print" Width="40" Align="Center">
                                                                </ext:CheckColumn>
                                                                <ext:CheckColumn Header="Void" DataIndex="Void" Width="39" Align="Center">
                                                                </ext:CheckColumn>
                                                                <ext:CheckColumn Header="AC" DataIndex="AC" Width="39" Align="Center">
                                                                </ext:CheckColumn>
                                                                <%-- <ext:ImageCommandColumn Header="Action" Width="50" Align="Center">
                                                <Commands>
                                                    <ext:ImageCommand Icon="BinEmpty" ToolTip-Text="Delete" CommandName="Delete" Style="background-position: center center;
                                                        width: 60px">
                                                        <ToolTip Text="Delete"></ToolTip>
                                                    </ext:ImageCommand>
                                                </Commands>
                                            </ext:ImageCommandColumn>--%>
                                                            </Columns>
                                                        </ColumnModel>
                                                       <%-- <Listeners>
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
                                    <td valign="top" style="padding-left:9px;">
                                        <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="120" />
                                    </td>
                                </table>
                            </td>
                        </tr>
                        <tr id="tr_list1">
                            <td style="padding-bottom: 10px">
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
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100px"><tr><td>Foreign Freight</td></tr></table>
                                                                </td>
                                                                <td style="padding-left: 47px" class="nav_menu_4 font_11px_gray" align="left">
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
                                                                                <ext:TextField ID="ForMin" ReadOnly="true" Cls="textCenter" runat="server" Text="Min"
                                                                                    Width="104" Enabled="false">
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
                                                            <td id="GridView_5" height="0" colspan="2" style="padding-left: 1px; padding-top: 4px"
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
                                            <td id="GridView_1" height="151" style="padding-left: 5px" valign="top">
                                                <table style="border-left: #8db2e3 1px solid; border-top: #8db2e3 1px solid; border-right: #8db2e3 1px solid"
                                                    border="0" cellspacing="0" cellpadding="0" width="420" bgcolor="#8db2e3" height="24px">
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
                                                <ext:GridPanel ID="gpForeign" runat="server" Width="420" Height="190" TrackMouseOver="true"
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
                                                            <ext:Column Header="Code" DataIndex="CompanyCode" Width="127" Align="Center">
                                                            </ext:Column>
                                                            <ext:Column Header="CUR" DataIndex="Currency" Width="38" Align="Center" >
                                                            </ext:Column>
                                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="205" Align="Center" Hidden="true">
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
                                            <td style="padding-left: 9px" width="280px" valign="top" align="left">
                                                <table cellpadding="0" cellspacing="0" border="0" style="width: 303px; height: 215px">
                                                    <tr>
                                                        <td colspan="6" style="height: 23px; padding-left: 5px;" class="font_11bold_1542af table_nav2">
                                                            Add Foreign
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-top: 16px" valign="top">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="60px">
                                                                <tr>
                                                                    <td  style="padding-left: 7px">
                                                                        Company
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td colspan="5" style="padding-top: 10px; width: 220px">
                                                            <uc1:AutoComplete runat="server" ID="f_company" clsClass="x-form-text x-form-field text_82px"
                                                                isAlign="false" TabIndex="24" isText="true" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td style="padding-top:2px; padding-left:7px" valign="top">
                                                                     <table cellpadding="0" cellspacing="0" border="0" width="53px"><tr><td>Item</td></tr></table>
                                                                    </td>
                                                                    <td style="width: 220px; padding-left: 2px">
                                                                        <uc1:UserComboBox runat="server" StoreID="StoreGetItem" ID="f_item" isText="false"
                                                                            isAlign="false" TabIndex="25" clsClass="text_82px" Width="69" winTitle="Item"
                                                                            winUrl="/BasicData/Item/list.aspx?sys=A" Handler="GetAEItemData('foreign','f_item','f_calc','f_qty','f_unit','f_currency','f_rate','f_amount','f_ex','f_min')" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td  style="padding-left: 7px; padding-top:2px">
                                                            Currency
                                                        </td>
                                                        <td colspan="5" style="padding-top: 3px">
                                                            <table cellpadding="0" cellspacing="0" style="padding-top: 2px">
                                                                <tr>
                                                                    <td>
                                                                       <ext:ComboBox ID="f_currency" runat="server" Cls="select_65" StoreID="StoreCurrInvoiceForeign"
                                                                            Width="50" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                                            TriggerAction="All">
                                                                            <Listeners>
                                                                                <Select Handler="#{f_ex}.setValue(record.data.rate)" />
                                                                            </Listeners>
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                    <td style="padding-left: 4px;">
                                                                       <ext:NumberField ID="f_ex" runat="server" Width="81px" DecimalPrecision="4" StyleSpec="text-align:right"
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
                                                        <td class="tb_01" style="padding-left: 7px">
                                                            Min
                                                        </td>
                                                        <td>
                                                            <ext:NumberField ID="f_min" runat="server" Width="50" TabIndex="27" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="2">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{f_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td class="tb_01" style="padding-left: 2px; padding-right: 1px">
                                                            Rate
                                                        </td>
                                                        <td>
                                                            <ext:NumberField ID="f_rate" runat="server" Width="49" TabIndex="28" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{f_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td align="left">
                                                            Amount
                                                        </td>
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
                                                        <td style="vertical-align: top; padding-left: 7px; padding-top: 5px">
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
                                                        <td colspan="6" style="padding-right: 4px; padding-top: 10px" align="right">
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
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr id="tr_list2">
                                        <td valign="top" style="padding-bottom: 10px">
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
                                                                              <table cellpadding="0" cellspacing="0" border="0" width="100px"><tr><td>Local Freight</td></tr></table>
                                                                            </td>
                                                                            <td style="padding-left: 47px; padding-top: 1px" class="nav_menu_4 font_11px_gray"  align="right">
                                                                                        <label>
                                                                                            <ext:ComboBox ID="CmbLocal" runat="server" Cls="select" DisplayField="value" StoreID="StoreCurrLocal"
                                                                                                ForceSelection="true" Mode="Local" TriggerAction="All" TabIndex="35" ValueField="value"
                                                                                                Width="80px">
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
                                                                            <%--<uc1:UserComboBox runat="server" ID="CmbCompany1" Query="option=CompanyList" clsClass="select_160px"
                                            Width="150" TabIndex="25" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                            winWidth="800" winHeight="800" />--%>
                                                                            <uc1:AutoComplete runat="server" ID="CmbCompany1" TabIndex="33" clsClass="x-form-text x-form-field text"
                                                                                isAlign="false" Query="option=CompanyList" Width="77" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                                winWidth="800" winHeight="800" />
                                                                        </td>
                                                                        <td width="7">
                                                                        </td>
                                                                    </tr>
                                                                    <td style="padding-left: 6px" height="0">
                                                                        Sell Rate
                                                                    </td>
                                                                    <td height="0" colspan="2">
                                                                        <table border="0" cellspacing="0" cellpadding="0" width="100">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="padding-right: 1px">
                                                                                        <ext:TextField ID="txtLocMin" ReadOnly="true" Cls="textCenter" runat="server" Text="Min"
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
                                        </td>
                                        <td valign="top" style="padding-left: 6px">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td>
                                                        <table style="border-left: #8db2e3 1px solid; border-top: #8db2e3 1px solid; border-right: #8db2e3 1px solid"
                                                            border="0" cellspacing="0" cellpadding="0" height="24px" bgcolor="#8db2e3" width="420">
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
                                                        <ext:GridPanel ID="gpLocal" runat="server" Width="420" Height="190" TrackMouseOver="true"
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
                                                            <ColumnModel ID="ColumnModel1">
                                                                <Columns>
                                                                    <ext:Column Header="Item" DataIndex="Item" Width="70" Align="Center">
                                                                    </ext:Column>
                                                                    <ext:Column Header="Code" DataIndex="CompanyCode" Width="140" Align="Center">
                                                                    </ext:Column>
                                                                    <ext:Column Header="Company" DataIndex="CompanyName" Width="207" Align="Center" Hidden="true">
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
                                        <td style="padding-left: 9px" width="280px; height: 215px" valign="top">
                                            <div style="width: 280px" id="Div1">
                                                <table cellpadding="0" cellspacing="0" style="height: 215px; width: 303px">
                                                    <tr>
                                                        <td colspan="6" style="height: 23px; line-height: 23px; padding-left: 5px;" class="font_11bold_1542af table_nav2">
                                                            Add Local
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" style="padding-top:16px">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="60px">
                                                                <tr>
                                                                    <td class="tb_01" style="padding-left: 7px">
                                                                        Company
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td colspan="5" style="padding-top: 10px; width: 220px">
                                                            <uc1:AutoComplete runat="server" ID="l_company" clsClass="x-form-text x-form-field text_82px"
                                                                isAlign="false" TabIndex="36" isText="true" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" >
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td style="padding-left: 7px; padding-top:2px" valign="top">
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="53px"><tr><td>Item</td></tr></table>
                                                                    </td>
                                                                    <td style="width: 220px; padding-left: 2px">
                                                                        <uc1:UserComboBox runat="server" StoreID="StoreGetItem" ID="l_item" isText="true"
                                                                            isAlign="false" TabIndex="37" clsClass="select_160px" Width="69" winTitle="Item"
                                                                            winUrl="/BasicData/Item/list.aspx?sys=A" Handler="GetAEItemData('local','l_item','l_calc','l_qty','l_unit','l_currency','l_rate','l_amount','l_ex','l_min')" />
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
                                                    <tr>
                                                        <td class="tb_01" style="padding-left: 7px">
                                                            Min
                                                        </td>
                                                        <td>
                                                            <ext:NumberField ID="l_min" runat="server" Width="50" TabIndex="42" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="2">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{l_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td class="tb_01" style="padding-left: 2px">
                                                            Rate
                                                        </td>
                                                        <td style="padding-left: 1px">
                                                            <ext:NumberField ID="l_rate" runat="server" Width="50" TabIndex="43" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{l_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td align="left">
                                                            Amount
                                                        </td>
                                                        <td align="left">
                                                            <ext:NumberField ID="l_amount" runat="server" Width="50" TabIndex="44" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="2">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{l_rate}.setValue();#{l_min}.setValue();}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-left: 7px; padding-top: 6px" valign="top">
                                                            Show
                                                        </td>
                                                        <td colspan="5" style="vertical-align: top; padding-top: 3px">
                                                            <ext:ComboBox ID="l_show" runat="server" StoreID="StoreShowIn" DisplayField="text"
                                                                Cls="select_65" Text="DN" ValueField="value" Mode="Local" ForceSelection="true"
                                                                TriggerAction="All" Width="69" TabIndex="45">
                                                            </ext:ComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" style="padding-right: 4px; padding-top: 10px" align="right">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td style="padding-right: 3px">
                                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                            <tr>
                                                                                <td class="btn_L">
                                                                                </td>
                                                                                <td>
                                                                                    <input onclick="if(ValidataCompany('l_company')){InsertLRecord()}" type="button"
                                                                                        style="cursor: pointer" tabindex="46" value="Save & Next" class="btn_text btn_C" />
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
                                                                                    <input onclick="ResetLRecord()" type="button" style="cursor: pointer" tabindex="47"
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
                                                                                    <input onclick="DeleteLRecord()" type="button" style="cursor: pointer" tabindex="48"
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
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td valign="top">
                                            <table border="0" cellspacing="0" cellpadding="0" width="240" align="left">
                                                <tbody>
                                                    <tr>
                                                        <td >
                                                            <table border="0" cellspacing="1" cellpadding="0" width="241" bgcolor="#8db2e3" height="25">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="padding-left: 6px" class="font_11bold_1542af" bgcolor="#ffffff" background="../../images/bg_line_3.jpg"
                                                                            align="left">
                                                                            Account Remark
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <table class="select_142px" border="0" cellspacing="0" cellpadding="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td width="240" style="padding-top: 5px">
                                                                            <ext:TextArea ID="txtAccountRemark" runat="server" Width="241" Height="206" TabIndex="49"
                                                                                Cls="text" StyleSpec="text-transform:capitalize">
                                                                            </ext:TextArea>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td id="GridView_3" valign="top" style="padding-left: 6px" colspan="2">
                                           <uc1:Costing ID="ucCost"  runat="server" type="H1"  sys="AE"/> 
                                        </td>
                                       
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td valign="top">
                                            <table border="0" cellspacing="0" cellpadding="0" width="240" align="left">
                                                <tbody>
                                                    <tr>
                                                        <td height="5">
                                                            <table border="0" cellspacing="1" cellpadding="0" width="241" bgcolor="#8db2e3" height="25">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="padding-left: 6px" class="font_11bold_1542af" bgcolor="#ffffff" background="../../images/bg_line_3.jpg"
                                                                            align="left">
                                                                            Operation Remark
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <table class="select_142px" border="0" cellspacing="0" cellpadding="0" style="padding-top: 5px">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>
                                                                            <ext:TextArea ID="txtOperationRemark" runat="server" Width="241" Height="184" TabIndex="61"
                                                                                StyleSpec="text-transform:capitalize" Cls="text">
                                                                            </ext:TextArea>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td id="GridView_4" valign="top" style="padding-left: 6px; padding-bottom: 10px">
                                            <table style="border-left: #8db2e3 1px solid; border-top: #8db2e3 1px solid; border-right: #8db2e3 1px solid"
                                                border="0" cellspacing="0" cellpadding="0" bgcolor="#8db2e3" height="24" width="420">
                                                <tbody>
                                                    <tr>
                                                        <td bgcolor="#ffffff" background="../../images/bg_line_3.jpg" align="left">
                                                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="padding-left: 5px" class="font_11bold_1542af" align="left">
                                                                            A/P (Commssion)
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <ext:GridPanel ID="gpAPCommssion" runat="server" Width="420" Height="190" TrackMouseOver="true"
                                                AllowDomMove="true" ClicksToEdit="1">
                                                <Store>
                                                    <ext:Store runat="server" ID="StoreAPCommssion">
                                                        <Reader>
                                                            <ext:JsonReader IDProperty="RowID">
                                                                <Fields>
                                                                    <ext:RecordField Name="RowID" Type="Int">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="CompanyCode" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="CompanyName" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="CalcKind" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Rate" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Amount" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Currency" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Remark" Type="String">
                                                                    </ext:RecordField>
                                                                     <ext:RecordField Name="EX" Type="String">
                                                                    </ext:RecordField>
                                                                </Fields>
                                                            </ext:JsonReader>
                                                        </Reader>
                                                    </ext:Store>
                                                </Store>
                                                <ColumnModel ID="ColumnModel4">
                                                    <Columns>
                                                        <ext:Column Header="Pay To" DataIndex="CompanyCode" Width="210" Align="Center">
                                                        </ext:Column>
                                                        <ext:Column Header="Pay to(Name)" DataIndex="CompanyName" Width="205" Align="Center"
                                                            Hidden="true">
                                                        </ext:Column>
                                                        <ext:Column Header="Calc.By" DataIndex="CalcKind" Width="55" Align="Center" Hidden="true">
                                                        </ext:Column>
                                                        <ext:Column Header="CUR" DataIndex="Currency" Width="50" Align="Center">
                                                        </ext:Column>
                                                        <ext:NumberColumn Header="Rate" DataIndex="Rate" Width="70" Align="Right" Format="0.000">
                                                        </ext:NumberColumn>
                                                        <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right">
                                                        </ext:NumberColumn>
                                                        <ext:Column Header="Remark" DataIndex="Remark" Width="70" Align="Right" Hidden="true">
                                                        </ext:Column>
                                                    </Columns>
                                                </ColumnModel>
                                                <Listeners>
                                                    <RowClick Handler="GetRowID(rowIndex);SelectORecord();" />
                                                </Listeners>
                                                <SelectionModel>
                                                    <ext:RowSelectionModel ID="RowSelectionModel4" runat="server">
                                                        <Listeners>
                                                            <RowSelect Handler="GetRowID(rowIndex);" />
                                                        </Listeners>
                                                    </ext:RowSelectionModel>
                                                </SelectionModel>
                                            </ext:GridPanel>
                                        </td>
                                        <td valign="top" align="left" style="padding-left: 9px;">
                                            <div  id="Div3">
                                                <table cellpadding="0" cellspacing="0" style="width: 303px" border="0">
                                                    <tr>
                                                        <td colspan="6" style="height: 23px; line-height: 23px; padding-left: 5px;" class="font_11bold_1542af table_nav2">
                                                            Add Commssion
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-top: 11px" valign="top">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="62px">
                                                                <tr>
                                                                    <td class="tb_01" style="padding-left: 7px">
                                                                        Company
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td colspan="5" style="padding-top: 10px; width: 220px">
                                                            <uc1:AutoComplete runat="server" ID="o_company" clsClass="x-form-text x-form-field text_82px"
                                                                isAlign="false" TabIndex="62" isText="true" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="tb_01" style="padding-left: 7px">
                                                            Currency
                                                        </td>
                                                        <td colspan="5" style="padding: 0">
                                                            <table cellpadding="0" cellspacing="0" style="padding-top: 2px">
                                                                <tr>
                                                                    <td>
                                                                        <ext:ComboBox ID="o_currency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                                                            Width="51" TabIndex="63" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                                            TriggerAction="All">
                                                                            <Listeners>
                                                                                <Select Handler="#{o_ex}.setValue(record.data.rate)" />
                                                                            </Listeners>
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                    <td style="padding-left: 4px;">
                                                                        <ext:NumberField ID="o_ex" runat="server" Width="102" DecimalPrecision="4" StyleSpec="text-align:right"
                                                                            Cls="select_160px" TabIndex="64">
                                                                        </ext:NumberField>
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        <table cellpadding="0" cellspacing="0" border="0" style="padding-left: 4px; padding-right: 5px">
                                                                            <tr>
                                                                                <td>
                                                                                    <ext:ComboBox runat="server" ID="o_calc" Cls="select_160px" StoreID="StoreKind" TabIndex="63"
                                                                                        DisplayField="value" ValueField="value" Width="69" ForceSelection="true" TriggerAction="All"
                                                                                        Mode="Local">
                                                                                        <%--<Listeners>
                                                        <Select Handler="SelectCalcData('o_ppd','o_item','o_calc','o_qty','o_unit','o_currency','o_rate','o_amount')"/>
                                                    </Listeners>--%>
                                                                                    </ext:ComboBox>
                                                                                    <ext:NumberField ID="o_qty" runat="server" Width="40" TabIndex="29" Cls="select_160px"
                                                                                        StyleSpec="text-align:right" DecimalPrecision="3">
                                                                                    </ext:NumberField>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        <uc1:UserComboBox runat="server" StoreID="StoreUnit" Width="45" ID="o_unit" ListWidth="180"
                                                                            TabIndex="65" winTitle="Unit" winUrl="/BasicData/Unit/list.aspx?sys=A" winWidth="510"
                                                                            winHeight="585" clsClass="text_80px" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td  style="padding-left: 7px; padding-top: 3px">
                                                            Rate
                                                        </td>
                                                        <td style="padding-top: 5px;width:30px;">
                                                            <ext:NumberField ID="o_rate" runat="server" Width="51" TabIndex="66" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{o_amount}.setValue()}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td  style="padding-left: 5px;padding-top: 3px;width: 50px;" align="left">
                                                          Amount
                                                        </td>
                                                        <td style="padding-top: 5px" colspan="2">
                                                            <ext:NumberField ID="o_amount" runat="server" Width="50" TabIndex="67" Cls="text_80px"
                                                                StyleSpec="text-align:right" DecimalPrecision="2">
                                                                <Listeners>
                                                                    <Blur Handler="if(this.getValue()!=''){#{o_rate}.setValue();}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td style="width: 53px">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-left: 7px; padding-top: 5px" valign="top">
                                                            Remark
                                                        </td>
                                                        <td colspan="5" style="vertical-align: top; padding-top: 5px">
                                                            <ext:TextField ID="o_remark" runat="server" Cls="select_160px" Width="157" TabIndex="68">
                                                            </ext:TextField>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" style=" padding-top: 10px" align="right">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td style="padding-right: 3px">
                                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                                            <tr>
                                                                                <td class="btn_L">
                                                                                </td>
                                                                                <td>
                                                                                    <input onclick="if(ValidataCompany('o_company')){InsertORecord()}" type="button"
                                                                                        style="cursor: pointer" tabindex="69" value="Save & Next" class="btn_text btn_C" />
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
                                                                                    <input onclick="ResetORecord()" type="button" style="cursor: pointer" tabindex="70"
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
                                                                                    <input onclick="DeleteORecord()" type="button" style="cursor: pointer" tabindex="71"
                                                                                        value="Delete" class="btn_text btn_C" />
                                                                                </td>
                                                                                <td class="btn_R">
                                                                                </td>
                                                                            </tr>
                                                                        </table></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
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
    </form>
</body>
</html>
