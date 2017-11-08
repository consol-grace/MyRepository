///—————— Local Costing  数据处理 —————

function RetrunText(obj, grid) {

    var Qty, Unit;
    var record = grid.getStore().getAt(selectRow);
    var text = obj == "" ? record.data.CalcKind : obj;  //obj.getValue(true);
    if (text == "") return;
    switch (text) {
        case "GWT":
            Qty = txtGWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CWT":
            Qty = txtCWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "VWT":
            Qty = txtVWT.getValue();
            Unit = CmbUnit.getValue(); 
            break;
        case "PCS":
            Qty = txtPiece.getValue();
            Unit = CmbUnit.getValue();
            break;
        default:
            break;
    }
    record = grid.getStore().getAt(selectRow);
    record.set("Qty", Qty);
    record.set("Unit", Unit);
}



var b = "1";
function gridTotals(grid) {
    if (grid == null) return;
    var record = grid.getStore().getAt(selectRow);
    var Amount = record.data.Amount;
    var Rate = record.data.Rate;
    var Qty = record.data.Qty;

    if (Rate != "" && b == "1") { record.set("Amount", ""); b = "0"; record = grid.getStore().getAt(selectRow); }

    else if (Amount != "" && b == "0") { record.set("Rate", ""); b = "1"; record = grid.getStore().getAt(selectRow); }

    record = grid.getStore().getAt(selectRow);
    Amount = record.data.Amount;
    Rate = record.data.Rate;

    Qty = isNaN(record.data.Qty) ? 0 : record.data.Qty;

    if (Amount == "")
        Qty = Rate * Qty;
    else
        Qty = Amount;
    record.set("Total", Qty);
}
///———————  end ——————————
function DeleteEmpty(grid) {

    if (grid.store.getTotalCount() > 0 && grid.id == "gridCost") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var data = grid.getRowsValues()[i];
            var flighNo = data.CompanyCode;
            var from = data.Item;
            var To = data.CalcKind;
            var ETD = data.Unit;
            var ETA = data.Currency;
            var ATD = data.Rate;
            var ATA = data.Amount;

            if (flighNo == "" && from == "" && To == "" && ETD == "" && ETA == "" && ATD == "" && ATA == "") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }
    else if (grid.store.getTotalCount() > 0 && grid.id == "GridPanelForeign") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var data = grid.getRowsValues()[i];
            var flighNo = data.Kind;
            var from = data.CompanyCode;
            var To = data.Currency;
            var ETD = data.Amount;
            var ETA = data.DN_CNNO;
            var ATD = data.Date;

            if (flighNo == "" && from == "" && To == "" && ETD == "" && ETA == "" && ATD == undefined) {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }

    else if (grid.store.getTotalCount() > 0 && grid.id == "GridPanelRoute") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var data = grid.getRowsValues()[i];
            var flighNo = data.Kind;
            var from = data.CompanyCode;
            var To = data.Dest;
            var ETD = data.Voyage;
            var ETA = data.ETD;
            var ATD = data.ETA;

            if (flighNo == "" && from == "" && To == "" && ETD == "" && ETA == undefined && ATD == undefined) {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }

    else if (grid.store.getTotalCount() > 0 && grid.id == "GridPanelContact") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var data = grid.getRowsValues()[i];
            var flighNo = data.Kind;
            var from = data.CompanyCode;
            var To = data.Dept;

            if (flighNo == "" && from == "" && To == "") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }
}


//Add Foreign Invoice
function InsertForeignInvoiceRecord() {
    var Kind = $("#FI_Kind").val();
    var Date = $("#FI_Date").val();
    var DNCN = $("#FI_DNCN").val().toUpperCase();
    var Company = $("#FI_Company").val().toUpperCase();
    var CompanyName = $("#FI_Company_text").val();
    var Currency = $("#FI_Currency").val();
    var Ex = $("#FI_EX").val();
    var Amonut = $("#FI_Amount").val();

    if (Company == "" || Company == undefined) {
        $("#FI_company").focus();
        return;
    }
    if (Amonut == "" || Amonut == 0 || Amonut == undefined) {
        $("#FI_Amount").focus()
        return;
    }
    var count = GridPanelForeign.store.getTotalCount();  // 获取当前行数
    if (selectRow2 >= 0) {
        var record = GridPanelForeign.getStore().getAt(selectRow2); // 获取当前行的数据
        record.set("Kind", Kind);
        record.set("CompanyCode", Company);
        record.set("CompanyName", CompanyName);
        record.set("Currency", Currency);
        record.set("Amount", Amonut);
        record.set("DN_CNNO", DNCN);
        record.set("Date", Date);
    }
    else {
        GridPanelForeign.insertRecord(count, { Kind: Kind, CompanyCode: Company, CompanyName: CompanyName, Currency: Currency, Amount: Amonut, DN_CNNO: DNCN, Date: Date });
    }
    // grid.insertRecord(rowIndex, { Currency: labCurrency.getText(), Ex: txtUSD.getValue(), Tax: txtTax.getValue(true), Percent: '100', TaxTotal: '0', Total: '0', NetTotal: '0' });
    GridPanelForeign.getView().refresh();
    GridPanelForeign.view.focusEl.focus();
    ResetForeignInvoiceRecord();
}

//Add Route 
function InsertRouteRecord() {
    var Kind = $("#r_Kind").val();
    var Company = $("#r_Company").val().toUpperCase();
    var CompanyName = $("#r_Company_text").val();
    var Dest = $("#r_Dest").val();
    var Voyage = $("#r_Voyage").val().toUpperCase();
    var ETD = $("#r_ETD").val();
    var ETA = $("#r_ETA").val();

    if (Company == "" || Company == undefined) {
        $("#r_Company").focus();
        return;
    }
    var count = GridPanelRoute.store.getTotalCount();  // 获取当前行数
    if (selectRow3 >= 0) {
        var record = GridPanelRoute.getStore().getAt(selectRow3); // 获取当前行的数据
        record.set("Kind", Kind);
        record.set("CompanyCode", Company);
        record.set("CompanyName", CompanyName);
        record.set("Dest", Dest);
        record.set("Voyage", Voyage);
        record.set("ETD", ETD);
        record.set("ETA", ETA);
    }
    else {
        GridPanelRoute.insertRecord(count, { Kind: Kind, CompanyCode: Company, CompanyName: CompanyName, Dest: Dest, Voyage: Voyage, ETD: ETD, ETA: ETA });
    }
    // grid.insertRecord(rowIndex, { Currency: labCurrency.getText(), Ex: txtUSD.getValue(), Tax: txtTax.getValue(true), Percent: '100', TaxTotal: '0', Total: '0', NetTotal: '0' });
    GridPanelRoute.getView().refresh();
    GridPanelRoute.view.focusEl.focus();
    ResetRouteRecord();
}

// Add Contact
function InsertContactRecord() {
    var Kind = $("#c_Kind").val();
    var Company = $("#c_Company").val().toUpperCase();
    var CompanyName = $("#c_Company_text").val();
    var Dept = $("#c_Dept").val();

    if (Company == "" || Company == undefined) {
        $("#c_Company").focus();
        return;
    }
    var count = GridPanelContact.store.getTotalCount();  // 获取当前行数
    if (selectRow4 >= 0) {
        var record = GridPanelContact.getStore().getAt(selectRow4); // 获取当前行的数据
        record.set("Kind", Kind);
        record.set("CompanyCode", Company);
        record.set("CompanyName", CompanyName);
        record.set("Dept", Dept);
    }
    else {
        GridPanelContact.insertRecord(count, { Kind: Kind, CompanyCode: Company, CompanyName: CompanyName, Dept: Dept });
    }
    // grid.insertRecord(rowIndex, { Currency: labCurrency.getText(), Ex: txtUSD.getValue(), Tax: txtTax.getValue(true), Percent: '100', TaxTotal: '0', Total: '0', NetTotal: '0' });
    GridPanelContact.getView().refresh();
    GridPanelContact.view.focusEl.focus();
    ResetContactRecord();
}



var selectRow2 = -1;
function getRowIndex2(rowIndex) {
    selectRow2 = rowIndex;
}

var selectRow3 = -1;
function getRowIndex3(rowIndex) {
    selectRow3 = rowIndex;
}

// 获取Foreign Invoice 当前行数据
function SelectForeignInvoiceRecord() {

    Invlidata("FI_Company");

    var record = GridPanelForeign.getStore().getAt(selectRow2); // 获取当前行的数据
    if (record == null || record == undefined)
        return;
    else {
        $("#FI_Kind").val(record.data.Kind);
        if (record.data.Date == "")
            $("#FI_Date").val("")
        else
            $("#FI_Date").val(record.data.Date);
        $("#FI_DNCN").val(record.data.DN_CNNO);
        $("#FI_Company").val(record.data.CompanyCode);
        $("#FI_Company_text").val(record.data.CompanyName);
        $("#FI_Company_text1").val(record.data.CompanyName);
        $("#FI_Currency").val(record.data.Currency);
        $("#FI_Amount").val(record.data.Amount);
    }

}

//获取Route 当前行数据
function SelectRouteRecord() {
    Invlidata("r_Company");
    var record = GridPanelRoute.getStore().getAt(selectRow3); // 获取当前行的数据
    if (record == null || record == undefined)
        return;
    else {
        $("#r_Kind").val(record.data.Kind);
        $("#r_Company").val(record.data.CompanyCode);
        $("#r_Company_text").val(record.data.CompanyName);
        $("#r_Company_text1").val(record.data.CompanyName);
        $("#r_Dest").val(record.data.Dest);
        $("#r_Voyage").val(record.data.Voyage);
        $("#r_ETD").val(record.data.ETD);
        $("#r_ETA").val(record.data.ETA);
    }

}

//获取Contact 当前行数据
function SelectContactRecord() {
    Invlidata("c_Company");
    var record = GridPanelContact.getStore().getAt(selectRow4); // 获取当前行的数据
    if (record == null || record == undefined)
        return;
    else {
        $("#c_Kind").val(record.data.Kind);
        $("#c_Company").val(record.data.CompanyCode);
        $("#c_Company_text").val(record.data.CompanyName);
        $("#c_Company_text1").val(record.data.CompanyName);
        $("#c_Dept").val(record.data.Dept);
    }
}




//删除Foreign Invoice 当前行数据
function DeleteForeignInvoiceRecord() {
    GridPanelForeign.getSelectionModel().selectRow(selectRow2);
    GridPanelForeign.deleteSelected();
    ResetForeignInvoiceRecord();
}

//删除Route当前行数据
function DeleteRouteRecord() {
    GridPanelRoute.getSelectionModel().selectRow(selectRow3);
    GridPanelRoute.deleteSelected();
    ResetRouteRecord();
}

//删除Contact当前行数据
function DeleteContactRecord() {
    GridPanelContact.getSelectionModel().selectRow(selectRow4);
    GridPanelContact.deleteSelected();
    ResetContactRecord();
}



//重置Foreign Invoice 数据
function ResetForeignInvoiceRecord() {
    Invlidata("FI_Company");
    selectRow2 = -1;
    $("#FI_Kind").val("").focus();
    $("#FI_Company").val("");
    $("#FI_Company_text1").val("");
    $("#FI_Company_text").val("");
    $("#FI_Currency").val(cur);
    $("#FI_EX").val("");
    $("#FI_Amount").val("");
    $("#FI_Date").val("");
    $("#FI_DNCN").val("");
}

//重置Route数据
function ResetRouteRecord() {
    Invlidata("r_Company");
    selectRow3 = -1;
    $("#r_Kind").val("").focus();
    $("#r_Company").val("");
    $("#r_Company_text1").val("");
    $("#r_Company_text").val("");
    $("#r_Dest").val("");
    $("#r_Voyage").val("");
    $("#r_ETD").val("");
    $("#r_ETA").val("");
}

//重置Contact数据
function ResetContactRecord() {
    Invlidata("c_Company");
    selectRow4 = -1;
    $("#c_Kind").val("").focus();
    $("#c_Company").val("");
    $("#c_Company_text1").val("");
    $("#c_Company_text").val("");
    $("#c_Dept").val("");
}

///
function RetrunCalc(text) {

    var Qty = "", Unit = "";
    switch (text) {
        case "GWT":
            Qty = txtGWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CWT":
            Qty = txtCWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "VWT":
            Qty = txtVWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "PCS":
            Qty = txtPiece.getValue();
            Unit = CmbUnit.getValue();
            break;
    }
    $("#l_qty").val(Qty);
    $("#l_unit").val(Unit);

}


function ReturnNull() {
    var Receipt = "";
    var FinalDest = "";
    var Salesman = "";
    var CWT = "";
    var Pieces = "";
    var Unit = "";

    Receipt = CmbReceipt.getValue();
    FinalDest = CmbFinalDest.getValue();
    Salesman = CmbSalesman.getValue();
    CWT = txtCWT.getValue();
    Pieces = txtPiece.getValue();
    Unit = CmbUnit.getValue();

    if (Receipt == "" || Receipt == undefined) {
        CmbReceipt.focus();
        NullMsg("Receipt");
        return false;
    }
    else if (FinalDest == "" || FinalDest == undefined) {
        CmbFinalDest.focus();
        NullMsg("Final Dest");
        return false;
    }
    else if (Salesman == "" || Salesman == undefined) {
        CmbSalesman.focus();
        NullMsg("Salesman");
        return false;
    }
    else if (CWT == "" || CWT == undefined) {
        txtCWT.focus();
        NullMsg("CWT");
        return false;
    }
    else if (Pieces == "" || Pieces == undefined) {
        txtPiece.focus();
        NullMsg("Pieces");
        return false;
    }
    else if (Unit == "" || Unit == undefined) {
        CmbUnit.focus();
        NullMsg("Unit");
        return false;
    }
    else {
        return true;
    }


}



//验证错误信息
function NullMsg(msg) {
    $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg + " can't empty!");
}
