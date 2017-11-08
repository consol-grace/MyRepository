/// 处理计算


var b = "0";
function Grid_AfterEdit(grid) {
    if (grid == null) return;
    var record = grid.getStore().getAt(selectRow);
    var Min = record.data.Min;
    var Rate = record.data.Rate;
    var Amount = record.data.Amount;

    if ((Rate != "" || Min != "") && b == "1") {
        record.set("Amount", ""); b = "0"; record = grid.getStore().getAt(selectRow);
    }
    else if (Amount != "" && b == "0") {
        record.set("Min", "");
        record.set("Rate", ""); b = "1"; record = grid.getStore().getAt(selectRow);
    }
    SumTotal(grid)
    //gridSumTotal(record,);

}

/// Grid  插入行
///  单击grid  插入行
function NewRow(grid, rowIndex) {
    if (grid == null) return;
    if (grid.store.getTotalCount() > 0) {
        return;
    }
    grid.insertRecord(rowIndex, { Currency: labCurrency.getText(), Ex: txtUSD.getValue(), Tax: txtTax.getValue(true), Percent: '100', TaxTotal: '0', Total: '0', NetTotal: '0' });
    grid.getView().refresh();
    grid.getSelectionModel().selectRow(rowIndex);
    grid.startEditing(rowIndex, 1);
}

/// 获取当前行的索引
var selectRow = -1;
function getRowIndex(rowIndex) {
    selectRow = rowIndex;
}

/// 编辑当前行
function EditRow(grid) {

    if (grid == null) return;
    grid.getSelectionModel().selectRow(selectRow);
    grid.startEditing(selectRow, 1);
}

/// 按键 grid 插入行,是否
function InsertRow(grid, isRow) {
    var row = 0;
    if (grid == null) return;
    if (grid.store.getTotalCount() > 0) {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var ItemCode = grid.getRowsValues({ Selectedonly: true })[i].ItemCode;
            var Description = grid.getRowsValues({ Selectedonly: true })[i].Description;
            var CalBy = grid.getRowsValues({ Selectedonly: true })[i].CalBy;
            var Min = grid.getRowsValues({ Selectedonly: true })[i].Min;
            var NetTotal = grid.getRowsValues({ Selectedonly: true })[i].NetTotal;
            var Amount = grid.getRowsValues({ Selectedonly: true })[i].Amount;
            var Percent = grid.getRowsValues({ Selectedonly: true })[i].Percent;

            if (ItemCode == "" || CalBy == "" || NetTotal == "0") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }
    if (isRow) row = grid.store.getTotalCount();
    else row = selectRow;
    grid.insertRecord(row, { Currency: labCurrency.getText(), Ex: txtUSD.getValue(), Tax: txtTax.getValue(true), Percent: '100', TaxTotal: '0', Total: '0', NetTotal: '0' });
    grid.getView().refresh();
    grid.getSelectionModel().selectRow(row);
    grid.startEditing(row, 1);
}

/// 处理 ComboBox 选择事件，填充其他项
function SetGridItem(obj, grid) {
    if (grid == null && obj == null) return;
    var record = grid.getStore().getAt(selectRow);
    labItemRound.text = obj.Round;
    labMarkUp.text = obj.MarkUp;
    labMarkDown.text = obj.MarkDown;
    record.set("CalBy", obj.CalcQty);
    record.set("Description", obj.itm_Description);
    if (record.data.Min == "" && record.data.Rate == "" && record.data.Amount == "") {
        record.set("Min", obj.Min);
        record.set("Rate", obj.Rate);
        record.set("Amount", obj.Amount);
        RetrunText(obj.CalcQty, grid);

    }

}


/// 计算当前行数据
function gridSumTotal(record) {

    //var record = grid.getStore().getAt(selectRow);
    var Min = record.data.Min;
    var Rate = record.data.Rate;
    var Amount = record.data.Amount;
    var CalcQty = record.data.CalBy;
    var Percent = record.data.Percent;
    var Tax = record.data.Tax;
    var Item = record.data.ItemCode;
    var ex = record.data.Ex;
    ex = ex == undefined || ex == "" ? 1 : ex;
    var Qty = record.data.Qty;
    //    switch (CalcQty) {
    //        case "GWT":
    //            Qty = txtGWT.text;
    //            break;
    //        case "CWT":
    //            Qty = txtCWT.getValue(true);
    //            break;
    //        case "VWT":
    //            Qty = labVWT.text;
    //            break;
    //        case "CBM":
    //            Qty = labVWT.text;
    //            break;
    //        case "PCS":
    //            Qty = labPiece.text;
    //            break;
    //        case "CNTR":
    //            Qty = labPallet.text;
    //            break;
    //    }
    //    var NetTotal, round = labItemRound.text, markUp = labMarkUp.text, markDown = labMarkDown.text;
    var NetTotal, round, markUp, markDown;
    if (Item == undefined || Item == "")
        return;
    var ItemRecord = StoreItem.getById(Item);
    if (ItemRecord != null && ItemRecord != undefined) {
        round = ItemRecord.data.Round;
        markDown = ItemRecord.data.MarkDown;
        markUp = ItemRecord.data.MarkUp;
    }
    else {
        round = 2;
        markDown = false;
        markUp = false;
    }
    if (round == undefined && markDown == undefined && markUp == undefined) return;
    if (Amount != "") { NetTotal = Number(Amount) * 1000 * Number(Percent) * Number(ex) / 100000; }
    else {

        if (Rate != undefined && Rate != "")
            NetTotal = Number(Rate) * 1000 * Number(Qty) * Number(Percent) * Number(ex) / 100000;

        if (Min != undefined && Min != "") {
            var s = Number(Min) * 1000 * Number(Percent) * Number(ex) / 100000
            NetTotal = NetTotal > s ? NetTotal : s;
        }
    }
    NetTotal = getDecimal(NetTotal, round, markUp, markDown);
    var TaxTotal = Round(NetTotal * Tax / 100, 2);
    var Total = Round(NetTotal + TaxTotal, 2);

    record.set("NetTotal", "");
    record.set("TaxTotal", "");
    record.set("Total", "");

    record.set("NetTotal", NetTotal);
    record.set("TaxTotal", TaxTotal);
    record.set("Total", Total);

    //var count = grid.store.getTotalCount();


}

function SumTotal1(grid) {
    if (grid == null) return;
    var count = grid.store.getTotalCount();
    var record;
    var flag = 1;
    var SumNetTotal = 0, SumTaxTotal = 0, SumTotal = 0;
    for (var i = 0; i < count; ++i) {
        flag = 1;
        record = grid.getStore().getAt(i);
        //gridSumTotal(record);
        //if (record.data.Rate < 0 || record.data.Min < 0)
        //    flag = -1;
        SumNetTotal += parseFloat(record.data.NetTotal);
        SumTaxTotal += parseFloat(record.data.TaxTotal);
        SumTotal += parseFloat(record.data.Total);
    }
    //alert(SumNetTotal + " , " + SumTaxTotal + " , " + SumTotal);
    if (SumTotal < 0) {
        labCredit.setText("Credit Note");
        labCredit1.setValue("Credit Note");
    }
    else {
        labCredit.setText("Invoice");
        labCredit1.setValue("Invoice");
    }
    inv_Total.setValue(SumTotal);
    hidNetTotal.setValue(SumNetTotal);
    hidTaxTotal.setValue(SumTaxTotal);
    //    txtTotal1.setText("Net Total: " + Math.abs(Round(SumNetTotal, 2)));
    //    txtTotal2.setText("Tax Total: " + Math.abs(Round(SumTaxTotal, 2)));
    if ($("#hidStat").val() == "USG/SIN") {
        txtTotal1.setText("Net Total: " + formatNumber(Math.abs(Round(SumNetTotal, 2)), "#,###.00#"));
        txtTotal2.setText("Tax Total: " + formatNumber(Math.abs(Round(SumTaxTotal, 2)), "#,###.00#"));
    }
    var cr = SumTotal >= 0 ? "" : " CR";

    txtTotal3.setText("Total: " + formatNumber(Math.abs(Round(SumTotal, 2)), "#,###.00#") + cr);
}


function SumTotal(grid) {
    if (grid == null) return;
    var count = grid.store.getTotalCount();
    var record;
    var flag = 1;
    var SumNetTotal = 0, SumTaxTotal = 0, SumTotal = 0;
    for (var i = 0; i < count; ++i) {
        record = grid.getStore().getAt(i);
        flag = 1;
        if (record.data.Rate < 0 || record.data.Min < 0 || record.data.Amount < 0) {
            flag = -1;
            if (record.data.Rate < 0 && record.data.Min < 0)
                flag = -1;
            else if ((record.data.Rate < 0 && record.data.Min == "") || (record.data.Min < 0 && record.data.Rate == ""))
                flag = -1;
            else if (record.data.Rate > 0 || record.data.Min > 0)
                flag = 1;
        }
        gridSumTotal(record);

        SumNetTotal += parseFloat(record.data.NetTotal);
        SumTaxTotal += parseFloat(record.data.TaxTotal);
        SumTotal += parseFloat(record.data.Total);
    }
    //alert(SumNetTotal + " , " + SumTaxTotal + " , " + SumTotal);
    if (SumTotal < 0) {
        labCredit.setText("Credit Note");
        labCredit1.setValue("Credit Note");
    }
    else {
        labCredit.setText("Invoice");
        labCredit1.setValue("Invoice");
    }
    inv_Total.setValue(SumTotal);
    hidNetTotal.setValue(SumNetTotal);
    hidTaxTotal.setValue(SumTaxTotal);
    //txtTotal1.setText("Net Total: " + Math.abs(Round(SumNetTotal, 2)));
    //txtTotal2.setText("Tax Total: " + Math.abs(Round(SumTaxTotal, 2)));
    if ($("#hidStat").val() == "USG/SIN") {
        txtTotal1.setText("Net Total: " + formatNumber(Math.abs(Round(SumNetTotal, 2)), "#,###.00#"));
        txtTotal2.setText("Tax Total: " + formatNumber(Math.abs(Round(SumTaxTotal, 2)), "#,###.00#"));
    }
    var cr = SumTotal >= 0 ? "" : " CR";
    txtTotal3.setText("Total: " + formatNumber(Math.abs(Round(SumTotal, 2)), "#,###.00#") + cr);
}

///四舍五入
function getDecimal(num, v, isUp, isDown) {
    var b = true;  // 是否正数   
    //v = 2;
    num = num == null ? 0 : num;
    var SumTotal = num;

    if (SumTotal < 0)
    { b = false; SumTotal = Math.abs(SumTotal); num = Math.abs(num); }

    var vv = Math.pow(0.1, v);

    SumTotal = ToFixed(SumTotal, v);
    //var SumTotal = formatNumber(num, format);

    if (num == SumTotal) {
        SumTotal = (b ? 1 : -1) * SumTotal;
        return Round(SumTotal, 2);
    }

    if (isUp)
        if (SumTotal < num)
        SumTotal = SumTotal + vv;
    if (isDown)
        if (SumTotal > num)
        SumTotal = SumTotal - vv;
    if (!b)
        SumTotal = SumTotal * (-1);
    return Round(SumTotal, 2); //Math.round(SumTotal * Math.pow(10, v)) / Math.pow(10, v);
}


function ToFixed(number, fractionDigits) {
    with (Math) {
        return round(number * pow(10, fractionDigits)) / pow(10, fractionDigits);
    }
}


function Round(total, num) {
    var vv = Math.pow(10, num);
    return Math.round(total * vv) / vv;
}

function AutoDelete(grid) {

}


var change = function(value) {
    value = value + "%";
    return value;
}
var ToUpper = function(value) {
    return value.toUpperCase();
}
var color = function(value) {
    if (value < 0)
        value = "<font color='red'>" + value + "</font>";
    return value;
}


///删除无效数据
function Delete(grid) {
    if (grid == null) return;
    if (grid.store.getTotalCount() > 0) {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var ItemCode = grid.getRowsValues({ Selectedonly: true })[i].ItemCode;
            var CalBy = grid.getRowsValues({ Selectedonly: true })[i].CalBy;
            var NetTotal = grid.getRowsValues({ Selectedonly: true })[i].NetTotal;
            if (ItemCode == "" || CalBy == "" || NetTotal == "0") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }
}


function RetrunText(obj, grid) {

    var Qty, Unit;
    var record = grid.getStore().getAt(selectRow);
    var text = obj == "" ? record.data.CalBy : obj;  //obj.getValue(true);
    if (text == "") return;
    switch (text) {
        case "GWT":
            //Qty = txtGWT.getText();
            Qty = txtGWT.getValue();
            //Unit = labUnit.getText();
            Unit = $("#labUnit").val();
            break;
        case "CWT":
            Qty = txtCWT.getValue();
            //Unit = labUnit.getText();
            Unit = $("#labUnit").val();
            break;
        case "VWT":
            //Qty = labVWT.getText();
            Qty = labVWT.getValue();
            //Unit = labUnit.getText();
            Unit = $("#labUnit").val();
            break;
        case "PCS":
            //Qty = labPiece.getText();
            Qty = labPiece.getValue();
            //Unit = labUnit.getText();
            Unit = $("#labUnit").val();
            break;
        case "CNTR":
            //Qty = labPallet.getText();
            Qty = labPallet.getValue();
            //Unit = labUnit.getText();
            Unit = $("#labUnit").val();
            break;
        case "CBM":
            //Qty = labVWT.getText();
            Qty = labVWT.getValue();
            //Unit = labUnit.getText();
            Unit = $("#labUnit").val();
            break;
        default:
            break;
    }
    record = grid.getStore().getAt(selectRow);
    record.set("Qty", Qty);
    record.set("Unit", Unit);
}


///////////////////////////////////////hhh
function InsertRecord() {

    if (!Amount())
        return;

    var item = $("#inv_CmbItem").val();
    var calc = $("#inv_Cmbcalby").val();
    calc = calc == "" || calc == undefined ? "Other" : calc;

    var qty = 0;
    var sys = Request("sys");
    if (sys == "AI" || sys == "AE" || sys == "AT")
        qty = $("#txtCWT").val();
    else if (sys == "OI" || sys == "OE" || sys == "OT" || sys == "DM" || sys == "BK" || sys == "TK")
        qty = $("#inv_txtQty").val();

    var unit = $("#inv_CmbUnit").val();
    unit = unit == "" || unit == undefined ? $("#CmbUnit").val() : unit;

    var currency = $("#inv_Currency").val();
    currency = currency == "" || currency == undefined ? $("#labCurrency").text() : currency;

    var ex = $("#inv_Ex").val();
    ex = ex == undefined || ex == "" ? "1" : ex;

    var percent = $("#inv_Percent").val();
    percent = percent == undefined || percent == "" ? "100" : percent;
    var rate = $("#inv_Rate").val();
    var min = $("#inv_Min").val();
    var amount = $("#inv_Amount").val();
    //var description = $("#inv_CmbItem_text").text();
    var description = $("#txtDesc").val();

    //    if (calc.toUpperCase() == "WM") {
    //        if (qty < 1) {
    //            inv_txtQty.focus(true);
    //            //$("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: Qty must be more than one.");
    //            return;
    //        }
    //    }
    //hhh
    var tax = $("#inv_Tax").val();
    if ($("#hidStat").val() == "USG/SIN") {
        tax = tax == "" ? 0 : tax;
    }
    else {
        tax = 0;
    }

    var count = gridList.store.getTotalCount();  // 获取当前行数
    if (selectRow >= 0) {
        var record = gridList.getStore().getAt(selectRow); // 获取当前行的数据
        record.set("ItemCode", item);
        record.set("Description", description);
        record.set("CalBy", calc);
        record.set("Unit", unit);
        record.set("Qty", qty);
        record.set("Currency", currency);
        record.set("Ex", ex);
        record.set("Min", min);
        record.set("Rate", rate);
        record.set("Amount", amount);
        record.set("Percent", percent);
        record.set("Tax", tax);

        //record.set("TaxTotal", amount);
        //record.set("NetTotal", amount);
        //record.set("Total", amount);
    }
    else {
        gridList.insertRecord(count, { Percent: percent, Ex: ex, ItemCode: item, Description: description, CalBy: calc, Qty: qty, Unit: unit, Currency: currency, Min: min, Rate: rate, Amount: amount,Tax:tax});
        selectRow = 0;
        selectRow = count + 1;
    }
    // grid.insertRecord(rowIndex, { Currency: labCurrency.getText(), Ex: txtUSD.getValue(), Tax: txtTax.getValue(true), Percent: '100', TaxTotal: '0', Total: '0', NetTotal: '0' });
    gridList.getView().refresh();
    gridList.view.focusEl.focus();

    SumTotal(gridList)

    ResetRecord();
}

function DeleteRecord() {
    gridList.getSelectionModel().selectRow(selectRow);
    gridList.deleteSelected();
    SumTotal(gridList)
    gridList.getView().refresh();
    gridList.view.focusEl.focus();
    ResetRecord();
}

function ResetRecord() {

    selectRow = -1;
    $("#inv_CmbItem").val("").focus();
    $("#inv_Cmbcalby").val("");
    $("#inv_txtQty").val("");
    $("#inv_CmbUnit").val("");
    $("#inv_Currency").val(labEx.getText());
    $("#inv_Ex").val(Number(1));
    $("#inv_Rate").val("");
    $("#inv_Min").val("");
    $("#inv_Amount").val("");
    $("#inv_CmbItem_text").text("");
    $("#txtDesc").val("");
    $("#inv_Percent").val("100");
    if ($("#hidStat").val() == "USG/SIN") {
        $("#inv_Tax").val($("#txtTax").val());
    }

}

function SelectRecord() {
    var record = gridList.getStore().getAt(selectRow); // 获取当前行的数据
    if (record == null || record == undefined)
        return;
    else {
        $("#inv_CmbItem").val(record.data.ItemCode);
        $("#inv_CmbItem_text").text(record.data.Description)
        $("#inv_Cmbcalby").val(record.data.CalBy);
        $("#inv_txtQty").val(record.data.Qty);
        $("#inv_CmbUnit").val(record.data.Unit);
        $("#inv_Currency").val(record.data.Currency);
        $("#inv_Ex").val(record.data.Ex);
        $("#inv_Rate").val(record.data.Rate);
        $("#inv_Min").val(record.data.Min);
        $("#inv_Amount").val(record.data.Amount);
        $("#txtDesc").val(record.data.Description);
        $("#inv_Percent").val(record.data.Percent);
        

        $("#l_item").text(record.data.ItemCode);
        $("#l_itemdesc").text(record.data.Description);
        $("#l_calby").text(record.data.CalBy);
        $("#l_qty").text(record.data.Qty);
        $("#l_unit").text(record.data.Unit);
        $("#l_currency").text(record.data.Currency);
        $("#l_ex").text(record.data.Ex);
        $("#l_rate").text(record.data.Rate);
        $("#l_min").text(record.data.Min);
        $("#l_amount").text(record.data.Amount);
        $("#l_percent").text(record.data.Percent);

        //hhh
        if ($("#hidStat").val() == "USG/SIN") {
            $("#inv_Tax").val(record.data.Tax);
            $("#labTax").text(record.data.Tax);
        }

    }
}


function Qty() {
    if (Request('sys').toUpperCase() == 'AI' || Request('sys').toUpperCase() == 'AE' || Request('sys').toUpperCase() == 'AT') {
        var qty = $("#txtCWT").val();
        qty = qty == undefined || qty == "" ? 0 : qty;
        $("#inv_txtQty").val(qty);
        var count = gridList.store.getTotalCount();
        var record;
        for (var i = 0; i < count; ++i) {
            record = gridList.getStore().getAt(i);
            record.set("Qty", qty);
        }
        SumTotal(gridList);
    }

}

function Tax() {
    var tax = $("#txtTax").val();
    tax=tax==""?0:tax;
    var count = gridList.store.getTotalCount();
    var record;
    for (var i = 0; i < count; ++i) {
            record = gridList.getStore().getAt(i);
            record.set("Tax", tax);
    }
    SumTotal(gridList);
}

function Amount() {

    var item = $("#inv_CmbItem").val();
    var calby = $("#inv_Cmbcalby").val();
    var qty = $("#inv_txtQty").val();
    var unit = $("#inv_CmbUnit").val();
    var rate = $("#inv_Rate").val();
    var min = $("#inv_Min").val();
    var amount = $("#inv_Amount").val();
    if (Request('sys').toUpperCase() == 'AI' || Request('sys').toUpperCase() == 'AE' || Request('sys').toUpperCase() == 'AT') {
        if (item == undefined || item == "") {
            $("#inv_CmbItem").focus();
            return false;
        }
        if (((rate == "" || rate == undefined) && (min == "" || min == undefined)) && (amount == "" || amount == undefined)) {
            $("#inv_Min").focus();
            return false;
        }
    }
    else if (Request('sys').toUpperCase() == 'OI' || Request('sys').toUpperCase() == 'OE' || Request('sys').toUpperCase() == 'OT' || Request('sys').toUpperCase() == 'DM' || Request('sys').toUpperCase() == 'BK' || Request('sys').toUpperCase() == 'TK') {
        if (item == undefined || item == "") {
            $("#inv_CmbItem").focus();
            return false;
        }

        if (((qty == undefined || qty == "" || qty == 0) || (rate == "" || rate == undefined)) && (amount == "" || amount == undefined)) {
            if (qty == undefined || qty == "" || qty == 0)
                $("#inv_txtQty").focus();
            else
                $("#inv_Rate").focus();
            return false;
        }

        if ((rate == "" || rate == undefined) && (amount == "" || amount == undefined)) {
            $("#inv_Rate").focus();
            return false;
        }
    }

    return true;

}


function CurrencySelect() {

    var currency = inv_Currency.getValue();
    var ex1;
    var ex2 = txtUSD.getValue();
    if (ex2 == '' || ex2 == undefined || ex2 == 0)
        ex2 = 1;
    var record = StoreCurrInvoice.getById(currency)
    if (record == undefined || record == null || record == "") {
        ex1 = 1;
    }
    else {
        ex1 = record.data.rate;
    }
    if (ex1 == null) {
        return;
    }  
    
    var ex = ex1 / ex2;

    if (currency == $("#labCurrency").val())
        ex = 1;

    inv_Ex.setValue(ex);
}



function CalbySelect() {
    var Qty, Unit;
    var text = $("#inv_Cmbcalby").val();  //obj.getValue(true);
    if (text == "") return;
    var record = StorecalcQty.getById(text);
    if (record == undefined || record == null)
        Unit = "";
    else
        Unit = StorecalcQty.getById(text).data.unit;
    switch (text) {
        case "GWT":
            //Qty = txtGWT.getText();
            Qty = txtGWT.getValue();
            break;
        case "CWT":
            Qty = txtCWT.getValue();
            break;
        case "WM":
            Qty = txtCWT.getValue();
            Qty = Qty < 1 ? 1 : Qty;
            break;
        case "VWT":
            //Qty = labVWT.getText();
            Qty = labVWT.getValue();
            break;
        case "PCS":
            //Qty = labPiece.getText();
            Qty = labPiece.getValue();
            //Unit = labUnit.getText();
            Unit = $("#labUnit").val();
            break;
        case "CNTR":
            //Qty = labPallet.getText();
            Qty = labPallet.getValue();
            break;
        case "CBM":
            //Qty = labVWT.getText();
            Qty = labVWT.getValue();
            break;
        default:
            break;
    }

    $("#inv_txtQty").val(Qty);
    inv_CmbUnit.setValue(Unit);

}


function selectItem() {
    var value = $("#inv_CmbItem").val();
    var record = StoreItem.getById(value);
    if (record != null && record != undefined) {

        $('#txtDesc').val($('#inv_CmbItem_text').text());
        inv_Cmbcalby.setValue(record.data.CalcQty);
        //var text = record.data.CalcQty;
        inv_CmbUnit.setValue(record.data.unit);
        //inv_txtQty.setValue(txtCWT.getValue());
        CalbySelect();

    }
}


function SelectCurrSum() {

    var currency = labCurrency.getValue();
    var ex1;

    var record = StoreCurrInvoice.getById(currency)
    if (record == undefined || record == null)
        ex1 = 1;
    else {
        ex1 = record.data.rate;
    }
    if (ex1 == null) {
        return;
    }

    txtUSD.setValue(ex1);
    labEx.setText(currency);
    labCurrency1.setText(currency);

    inv_Currency.setValue(currency);
    inv_Ex.setValue(1);

    var type = Request("sys").toUpperCase();

    //if (type == "OI" || type == "OE" || type == "OT" || type == "BK" || type == "DM" || type == "TK") {
    var count = gridList.store.getTotalCount();
    var record;
    for (var i = 0; i < count; ++i) {
        record = gridList.getStore().getAt(i);
        if (record.data.Currency == currency) {
            record.set("Ex", 1);
            record.set("Currency", currency);
        }
        else {
            var cur = record.data.Currency;

            if (record.data.Currency == cur) {

                var currinvoice = StoreCurrInvoice.getById(cur);
                var ee1 = currinvoice.data.rate;
                var ee = ee1 / ex1;
                record.set("Ex", Number(ee).toFixed(4));
            }
        }
    }
    SumTotal(gridList);
    //}
    //else {
    //    var count1 = gridList.store.getTotalCount();
    //    var record1;
    //    for (var i = 0; i < count1; ++i) {
    //        record1 = gridList.getStore().getAt(i);

    //            record1.set("Ex", 1);
    //             record1.set("Currency", currency);

    //     }
    // }

}



var apressed, bpressed;


function getFocus(event, obj) {


    //    var sys = Request("sys").toUpperCase();
    //    if (event.keyCode == 9) {
    //        if (obj.id == "txtDesc" && company == "CON/HKG") {
    //            if (sys == "OI" || sys == "OE" || sys == "OT") {
    //                inv_Cmbcalby.focus(true);
    //            }
    //        }
    //        else if (obj.id == "inv_txtQty" && company == "CON/HKG") {
    //            if (sys == "OI" || sys == "OE" || sys == "OT") {
    //                inv_Percent.focus(true);
    //            }
    //        }
    //        else if (obj.id == "inv_Ex" && company == "CON/HKG") {
    //            if (sys == "OI" || sys == "OE" || sys == "OT") {
    //                inv_Percent.focus(true);
    //            }
    //        }
    //    }
}


var pctChange = function(value) {
    return String.format(template, (value > 0) ? "black" : "black", value + " %");
};


function Validate() {

    if (txtInvoiceDate.getValue() == '' || txtInvoiceDate.getValue() == undefined) {
        $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: Invoice Date can't be empty!");
        txtInvoiceDate.focus(true);
        return false;
    }
    else if (txtUSD.getValue() == '' || txtUSD.getValue() == undefined) {
        $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: Exchange rate can't be empty!");
        txtUSD.focus(true);
        return false;
    }
    else if (txtTax.value == '' || txtTax.value == undefined) {
        $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: Tax  can't be empty!");
        txtTax.focus(true);
        return false;

    }
    else if ($("#CmbShipperCode").val() == "" || $("#CmbShipperCode").val() == undefined) {
        $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: Company can't be empty!");
        getSelectPos("CmbShipperCode");
        return false;
    }
    else if ($("#CmbShipperCode").attr("validata") == "false") {
        $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: The company code is invalid!");
        getSelectPos("CmbShipperCode");
        return false;
    }

}


function officalInv() {
    var seed = Request("seed");
    var offical = $("#txtoffical").val();


    if (offical == null || offical == "" || offical == undefined) {
        Ext.Msg.alert("status", " Input can't for empty . ", function() {
            $("#txtoffical").focus();
        });
        return;
    }

    $.get('/common/uicontrols/gridHtml.ashx?type=offical&seed=' + seed + "&offical=" + offical, function(data) {
        if (data == "Y") {
            //window.location.reload();
            $("#div_bottom").html("<p class=\"success\">Status :  Saved successfully . </p>");
            $("#btn_offical").blur();
        }
        else {
            Ext.Msg.alert('status', ' Error  ');
            $("#txtoffical").focus("");
            $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: Please check the data .</p>");
        }
    })

}

