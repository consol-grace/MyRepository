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
        case "CBM":
            Qty = txtCBM.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "PCS":
            Qty = txtPiece.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CNTR": 
            Qty = txtContainer.getValue();
            Unit = CmbUnit.getValue();
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

function AutoDeleteRow(grid) {

    if (grid.store.getTotalCount() > 0 && grid.id == "GridPanelContact") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var Qty = grid.getRowsValues({ Selectedonly: true })[i].Kind;
            var Currency = grid.getRowsValues({ Selectedonly: true })[i].CompanyCode
            var PPD = grid.getRowsValues({ Selectedonly: true })[i].Dept;
            if (Qty == "" && Currency == "" && PPD == "") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }

    else if (grid.store.getTotalCount() > 0 && grid.id == "GridPanelRoute") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var Qty = grid.getRowsValues({ Selectedonly: true })[i].Kind;
            var Currency = grid.getRowsValues({ Selectedonly: true })[i].CompanyCode
            var PPD = grid.getRowsValues({ Selectedonly: true })[i].Dest;
            var CompanyCode = grid.getRowsValues({ Selectedonly: true })[i].Voyage
            var Item = grid.getRowsValues({ Selectedonly: true })[i].ETD
            var CalcKind = grid.getRowsValues({ Selectedonly: true })[i].ETA
            if (Qty == "" &&Currency==""&& PPD == "" && CompanyCode == "" && Item == undefined && CalcKind == undefined) {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }

    else if (grid.store.getTotalCount() > 0 && grid.id == "GridPanelForeign") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var Qty = grid.getRowsValues({ Selectedonly: true })[i].Amount;
            var Currency = grid.getRowsValues({ Selectedonly: true })[i].Currency
            var PPD = grid.getRowsValues({ Selectedonly: true })[i].DN_CNNO;
            var CompanyCode = grid.getRowsValues({ Selectedonly: true })[i].CompanyCode
            var Item = grid.getRowsValues({ Selectedonly: true })[i].Date
            var CalcKind = grid.getRowsValues({ Selectedonly: true })[i].Kind
            if (Qty == "" &&Currency==""&&PPD == "" && CompanyCode == "" && Item == undefined && CalcKind == "") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }

    else if (grid.store.getTotalCount() > 0 && grid.id == "gridCost") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var Qty = grid.getRowsValues({ Selectedonly: true })[i].Qty;
            var Currency = grid.getRowsValues({ Selectedonly: true })[i].Currency
            var PPD = grid.getRowsValues({ Selectedonly: true })[i].PPD;
            var CompanyCode = grid.getRowsValues({ Selectedonly: true })[i].CompanyCode
            var Item = grid.getRowsValues({ Selectedonly: true })[i].Item
            var CalcKind = grid.getRowsValues({ Selectedonly: true })[i].CalcKind
            if (Qty == "" && PPD == "" && CompanyCode == "" && Item == "" && CalcKind == "") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }

    else if (grid.store.getTotalCount() > 0 && grid.id == "GridPanelOther") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var Qty = grid.getRowsValues({ Selectedonly: true })[i].Qty;
            var Show = grid.getRowsValues({ Selectedonly: true })[i].Show
            var PPD = grid.getRowsValues({ Selectedonly: true })[i].PPD;
            var CompanyCode = grid.getRowsValues({ Selectedonly: true })[i].CompanyCode
            var Item = grid.getRowsValues({ Selectedonly: true })[i].Item
            var CalcKind = grid.getRowsValues({ Selectedonly: true })[i].CalcKind
            if (Qty == "" && PPD == ""&&Show==""&& CompanyCode == "" && Item == "" && CalcKind == "") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }
    
}


function Add() {

//    Ext.MessageBox.confirm("Status", " Please save the data ? ", function(e) {
//    if (e == "yes") {
            var s = Request("Seed");
            Ext.getCmp('btnSave').fireEvent('click', this);
            var lotNo = labImpLotNo.getText();
            setTimeout(function() { window.open("Container.aspx?HBL=" + Request("seed"), lotNo) }, 1000);
//        }
//    });
}


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
        case "CBM":
            Qty = txtCBM.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CNTR":
            Qty = txtContainer.getValue();
            Unit = CmbUnit.getValue();
            break;            
    }
    $("#l_qty").val(Qty);
    $("#l_unit").val(Unit);

}


function RetrunCalc2(text) {

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
        case "CBM":
            Qty = txtCBM.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CNTR":
            Qty = txtContainer.getValue();
            Unit = CmbUnit.getValue();
            break;
    }
    $("#o_qty").val(Qty);
    $("#o_unit").val(Unit);

}

var selectRow1 = -1;
function getRowIndex1(row) {
    selectRow1 = row;
}

var selectRow3 = -1;
function getRowIndex3(row) {
    selectRow3 = row;
}

var selectRow4 = -1;
function getRowIndex4(row) {
    selectRow4 = row;
}

var selectRow5 = -1;
function getRowIndex5(row) {
    selectRow5 = row;
}

var selectRow6 = -1;
function getRowIndex6(row) {
    selectRow6 = row;
}

var selectRow7 = -1;
function getRowIndex7(row) {
    selectRow7 = row;
}


///获取Other Charges当前行数据

function SelectOtherRecord() {
    Invlidata("o_company");
    var record = GridPanelOther.getStore().getAt(selectRow1); // 获取当前行的数据
    if (record == null || record == undefined)
        return;
    else {
        $("#o_ppd").val(record.data.PPD);
        $("#o_company").val(record.data.CompanyCode);
        $("#o_item").val(record.data.Item);
        $("#o_calc").val(record.data.CalcKind);
        $("#o_qty").val(record.data.Qty);
        $("#o_unit").val(record.data.Unit);
        $("#o_currency").val(record.data.Currency);
        $("#o_ex").val(record.data.EX);
        $("#o_rate").val(record.data.Rate);
        $("#o_amount").val(record.data.Amount);
        $("#o_company_text").val(record.data.CompanyName);
        $("#o_company_text1").val(record.data.CompanyName);
        $("#o_item_text").text(record.data.Description);
        $("#o_percent").val(record.data.Percent);
        $("#o_show").val(record.data.Show);
    }
}


///Add Other Charges
function InsertOtherRecord() {
    var ppd = $("#o_ppd").val();
    var company = $("#o_company").val();
    var item = $("#o_item").val();
    var calc = $("#o_calc").val(); 
    var qty = $("#o_qty").val();
    var unit = $("#o_unit").val();
    var currency = $("#o_currency").val();
    var ex = $("#o_ex").val();
    var rate = $("#o_rate").val();
    var amount = $("#o_amount").val();
    var companyName = $("#o_company_text").val();
    var description = $("#o_item_text").text();
    var percent = ($("#o_percent").val() == undefined || $("#o_percent").val() == "") ? 100 : $("#o_percent").val();
    var total = amount == undefined || amount == "" ? qty * rate * percent * 1.0 / 100 : amount * 1.0 * percent / 100;
    var show = o_show.checked; 

    if (company == "" || company == undefined) {
        $("#o_company").focus();
        return;
    }
    if (item == "" || item == undefined) {
        $("#o_item").focus();
        return;
    }

    var count = GridPanelOther.store.getTotalCount();  // 获取当前行数
    if (selectRow1 >= 0) {
        var record = GridPanelOther.getStore().getAt(selectRow1); // 获取当前行的数据
        record.set("PPD", ppd);
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
        record.set("Percent", percent);
        record.set("Show",show);
    }
    else {
        GridPanelOther.insertRecord(count, { EX: ex, PPD: ppd, CompanyCode: company, CompanyName: companyName, Description: description, Item: item, Total: total, CalcKind: calc, Qty: qty, Unit: unit, Currency: currency, Rate: rate, Amount: amount, Percent: percent, Show: show });
    }
    // grid.insertRecord(rowIndex, { Currency: labCurrency.getText(), Ex: txtUSD.getValue(), Tax: txtTax.getValue(true), Percent: '100', TaxTotal: '0', Total: '0', NetTotal: '0' });
    GridPanelOther.getView().refresh();
    GridPanelOther.view.focusEl.focus();
    ResetOtherRecord();
}


///删除Other Charges数据
function DeleteOtherRecord() {
    GridPanelOther.getSelectionModel().selectRow(selectRow1);
    GridPanelOther.deleteSelected();
    ResetOtherRecord();
}


///重置Other Charges数据

function ResetOtherRecord() {
    Invlidata("o_company");
    selectRow1 = -1;
    $("#o_ppd").val("").focus();
    $("#o_company").val("");
    $("#o_item").val("");
    $("#o_calc").val("");
    $("#o_qty").val("");
    $("#o_unit").val("");
    $("#o_currency").val("");
    $("#o_ex").val("");
    $("#o_rate").val("");
    $("#o_amount").val("");
    $("#o_company_text1").val("");
    $("#o_company_text").val("");
    $("#o_item_text").text("");
    $("#o_percent").val("100");
    o_show.checked=true;
}


// 获取Foreign Invoice 当前行数据
function SelectForeignInvoiceRecord() {
    Invlidata("FI_Company");
    var record = GridPanelForeign.getStore().getAt(selectRow3); // 获取当前行的数据
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

//Add Foreign Invoice
function InsertForeignInvoiceRecord() {
    var Kind = $("#FI_Kind").val();
    var Date = $("#FI_Date").val();
    var DNCN = $("#FI_DNCN").val().toUpperCase();
    var Company = $("#FI_Company").val();
    var CompanyName = $("#FI_Company_text").val();
    var Currency = $("#FI_Currency").val();
    var Ex = $("#FI_EX").val();
    var Amonut = $("#FI_Amount").val();

    if (Company == "" || Company == undefined) {
        $("#FI_company").focus();
        return;
    }
    var count = GridPanelForeign.store.getTotalCount();  // 获取当前行数
    if (selectRow3 >= 0) {
        var record = GridPanelForeign.getStore().getAt(selectRow3); // 获取当前行的数据
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


//删除Foreign Invoice 当前行数据
function DeleteForeignInvoiceRecord() {
    GridPanelForeign.getSelectionModel().selectRow(selectRow3);
    GridPanelForeign.deleteSelected();
    ResetForeignInvoiceRecord();
}


//重置Foreign Invoice 数据
function ResetForeignInvoiceRecord() {
    Invlidata("FI_Company");
    selectRow3 = -1;
    $("#FI_Kind").val("Credit Note").focus();
    $("#FI_Company").val("");
    $("#FI_Company_text1").val("")
    $("#FI_Company_text").val("")
    $("#FI_Currency").val(cur);
    $("#FI_EX").val("");
    $("#FI_Amount").val("");
    $("#FI_Date").val("")
    $("#FI_DNCN").val("")
}

//获取Domestic 当前行数据
function SelectDomesticRecord() {
    Invlidata("r_Company"); 
    var record = GridPanelRoute.getStore().getAt(selectRow4); // 获取当前行的数据
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


//Add Domestic
function InsertDomesticRecord() {
    var Kind = $("#r_Kind").val();
    var Company = $("#r_Company").val();
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
    if (selectRow4 >= 0) {
        var record = GridPanelRoute.getStore().getAt(selectRow4); // 获取当前行的数据
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
    ResetDomesticRecord();
}


//删除Domestic当前行数据
function DeleteDomesticRecord() {
    GridPanelRoute.getSelectionModel().selectRow(selectRow4);
    GridPanelRoute.deleteSelected();
    ResetDomesticRecord();
}

//重置Domestic数据
function ResetDomesticRecord() {
    Invlidata("r_Company");
    selectRow4 = -1;
    $("#r_Kind").val("").focus();
    $("#r_Company").val("");
    $("#r_Company_text1").val("");
    $("#r_Company_text").val("");
    $("#r_Dest").val("");
    $("#r_Voyage").val("");
    $("#r_ETD").val("");
    $("#r_ETA").val("");
}


//获取Contact 当前行数据
function SelectContactRecord() {
    Invlidata("c_Company");
    var record = GridPanelContact.getStore().getAt(selectRow5); // 获取当前行的数据
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


// Add Contact
function InsertContactRecord() {
    var Kind = $("#c_Kind").val();
    var Company = $("#c_Company").val();
    var CompanyName = $("#c_Company_text").val();
    var Dept = $("#c_Dept").val();

    if (Company == "" || Company == undefined) {
        $("#c_Company").focus();
        return;
    }
    var count = GridPanelContact.store.getTotalCount();  // 获取当前行数
    if (selectRow5 >= 0) {
        var record = GridPanelContact.getStore().getAt(selectRow5); // 获取当前行的数据
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


//删除Contact当前行数据
function DeleteContactRecord() {
    GridPanelContact.getSelectionModel().selectRow(selectRow5);
    GridPanelContact.deleteSelected();
    ResetContactRecord();
}


//重置Contact数据
function ResetContactRecord() {
    Invlidata("c_Company");
    selectRow5 = -1;
    $("#c_Kind").val("").focus();
    $("#c_Company").val("");
    $("#c_Company_text1").val("");
    $("#c_Company_text").val("");
    $("#c_Dept").val("");
}


function ReturnNull()
{
   var HBL = "";
   var SerMode = "";
   var PPCC = "";
   var Salesman = "";
   var Receipt = "";
   var FinalDest = "";
   var Shipper = "";
   var Consignee = "";
   var CBM = "";
   var Unit = "";
   HBL = txtHawb.getValue();
   SerMode = CmbService.getValue();
   PPCC = CmbPPD.getValue();
   Salesman = CmbSalesman.getValue();
   Receipt = CmbReceipt.getValue();
   FinalDest = CmbFinalDest.getValue();
   Shipper = $("#CmbShipperCode").val();
   Consignee = $("#CmbConsignee").val();
   CBM = txtCBM.getValue();
   Unit = CmbUnit.getValue();
   if (HBL == "" || HBL == undefined)
   {
     txtHawb.focus();
     NullMsg("HBL");
     return false;
   } 
   else if (SerMode == "" || SerMode == undefined)
   {
     CmbService.focus();
     NullMsg("Service Mode");
     return false;
   }
   else if (PPCC == "" || PPCC == undefined)
   {
     CmbPPD.focus();
     NullMsg("PPD/COL");
     return false;
   } 
   else if (Salesman == "" || Salesman == undefined)
   {
     CmbSalesman.focus();
     NullMsg("Salesman");
     return false;
   }
   else if (Receipt == "" || Receipt == undefined)
   {
     CmbReceipt.focus();
     NullMsg("Receipt");
     return false;
   }  
   else if (FinalDest == "" || FinalDest == undefined)
   {
     CmbFinalDest.focus();
     NullMsg("Final Dest");
     return false;
   } 
   else if (Shipper == "" || Shipper == undefined)
   {
     $("#CmbShipperCode").focus();
     NullMsg("Shipper");
     return false;
   }
   else if (Consignee == "" || Consignee == undefined)
   {
     $("#CmbConsignee").focus();
     NullMsg("Consignee");
     return false;
   }   
   else if (Unit == "" || Unit == undefined)
   {
     CmbUnit.focus();
     NullMsg("Unit");
     return false;
   }
   else
   {
     return true;
   }                              
}


//验证错误信息
function NullMsg(msg) {
    $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg + " can't empty!");
}


function DeleteContainer(grid, rowIndex) {
    if (rowIndex != "" || rowIndex != undefined) {
        grid.getSelectionModel().selectRow(rowIndex);
    }
    grid.deleteSelected();
    var gwt = 0;
    var cbm = 0;
    var wm = 0;
    var piece = 0;
    var status = 0;
    for (var i = 0; i < grid.store.getTotalCount(); ++i) {
        var data = grid.getRowsValues()[i];
        gwt += parseFloat((data.GWT == "" || data.GWT == null) ? 0 : data.GWT);
        cbm += parseFloat((data.CBM == "" || data.CBM == null) ? 0 : data.CBM);
        wm += parseFloat((data.WM == "" || data.WM == null) ? 0 : data.WM);
        piece += parseFloat((data.PKGS == "" || data.PKGS == null) ? 0 : data.PKGS);
        status = 1;
    }
    if (status == 1) {
        txtAGWT.setValue(gwt == 0 ? "" : Number(gwt).toFixed(3));
        txtACBM.setValue(cbm == 0 ? "" : Number(cbm).toFixed(3));
        txtAWM.setValue(wm == 0 ? "" : Number(wm).toFixed(3));
        txtAPiece.setValue(piece == 0 ? "" : Number(piece).toFixed(0));
    }
    else {
        txtAGWT.setValue("");
        txtACBM.setValue("");
        txtAWM.setValue("");
        txtAPiece.setValue("");
    }
}
