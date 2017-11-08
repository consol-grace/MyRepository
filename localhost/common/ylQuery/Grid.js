/// Grid  当前容器
///  rowIndex  当前行索引
///  cellIndex   当前列索引
///  单击grid  插入行(grid,当前行索引，当前列索引)
function NewRow(grid, rowIndex, cellIndex) {
    if (grid == null) return;
    if (grid.store.getTotalCount() > 0) return;

    grid.insertRecord(rowIndex, {});
    grid.getView().refresh();
    grid.view.focusEl.focus();
    grid.getSelectionModel().selectRow(rowIndex);
    grid.startEditing(rowIndex, cellIndex);

}

/// 获取当前行的索引
var selectRow = 0;
function getRowIndex(rowIndex) {
    selectRow = rowIndex;
}

/// 编辑当前行（grid，当前咧索引）
function EditRow(grid, cellIndex) {
 
    if (grid == null) return;
    if (grid.store.getTotalCount() > 0) {
        grid.getSelectionModel().selectRow(selectRow);
        grid.startEditing(selectRow, cellIndex);
    }
}

/// 按键 插入行,是否当前行插入，否则最下行插入 
/// 插入前先对 grid ——》 DeleteRowEmpty(grid,list)
function InsertRow(grid, isRow, cellIndex) {
    var row = 0;
    if (grid == null) return;

    if (isRow) row = grid.store.getTotalCount();
    else row = selectRow;
    grid.insertRecord(row, {});
    grid.getView().refresh();
    grid.view.focusEl.focus();
    grid.getSelectionModel().selectRow(row);
    grid.startEditing(row, cellIndex);
}

///删除当前行
function DeleteRow(grid, row) {
    if (grid == null) return;
    Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) {
        if (btn == 'yes') {
            if (row != '') {
                grid.getSelectionModel().selectRow(row);
            }
            grid.deleteSelected();
        }
        grid.getView().refresh();
        grid.view.focusEl.focus();
        grid.getSelectionModel().selectRow(0);
    })
}

///循环删除空行 grid 当前编辑的对象，list 数组
function DeleteRowsEmpty(grid, list) {
    if (list == null || list.length == 0) return;
    var str = 0;
    for (var i = 0; i < grid.store.getTotalCount(); ++i) {
        for (var j = 0; j < list.length; ++j) {
            var Filed = list[j];
            var Item = grid.getRowsValues({ Selectedonly: true })[i].DODShipper;
            if (Item == "" || Item == undefined)
                str += 1;
        }
        if (str == list.length) {
            grid.getSelectionModel().selectRow(i);
            grid.deleteSelected();
        }
    }
}




///大写转换  
var ToUpper = function(value) {
    return value.toUpperCase();
}

var Percent = function(value) {
    if (value != null || value != "" || value != undefined)
        value = value + "%";
    return value;
}

function Round(total, num) {
    var vv = Math.pow(10, num);
    return Math.round(total * vv) / vv;
}


function SetCurRate(currencyid, currencyrateid) {
    var objbill = "";
    if ($("#ucCost_billcurrency").length > 0) {
        objbill = "ucCost_billcurrency";
    }
    else {
        objbill = "billcurrency";
    }
    
    if (objbill!="") {
        var cur = $("#" + currencyid).val();
        var billcur = $("#"+objbill).val();
        if (cur != "" && billcur != "") {
            var fr = StoreCurrInvoice.getById(cur).data.rate;
            var billfr = StoreCurrInvoice.getById(billcur).data.rate;
            if (fr != null && billfr != null) {
                if (fr == billfr) {
                    $("#" + currencyrateid).val(1);
                }
                else {
                    if (billfr != 0) {
                        var frTotal = Round((fr / billfr), 3);
                        $("#" + currencyrateid).val(frTotal);
                    }
//                    if (fr != 0) {
//                        var frTotal = Round((billfr / fr), 3);
//                        $("#" + currencyrateid).val(frTotal);
//                    }
                }
            }
            else {
                $("#" + currencyrateid).val("");
            }
        }
    }

//    var lr = StoreCurrInvoice.getById($("#" + currencyid).val());
//    if (lr.data.rate != undefined) {
//        $("#" + currencyrateid).val(lr.data.rate);
//    }
//    else {
//        $("#" + currencyrateid).val("");
//    }
}


function GetItemData(type, obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8) {
    var obj = "";
    if ($("#" + type).length > 0) {
        obj = $("#" + type).val();
    }
    else {
        if (type.toUpperCase() == "FOREIGN") {
            obj = "AGENT";
        }
        else {
            obj = "LOCAL";
        }
    }
    var r = StoreGetItem.getById($("#" + obj1).val());
    if (Ext.isEmpty(r)) {
        return false;
    }
    else {
        if (obj.toUpperCase() == "AGENT") {
            $("#" + obj2).val(r.data.itm_FCalcQty);
            $("#" + obj4).val(r.data.itm_FUnit);
            $("#" + obj5).val(r.data.itm_FCurrency);
            var objbill = "";
            if ($("#ucCost_billcurrency").length > 0) {
                objbill = "ucCost_billcurrency";
            }
            else {
                objbill = "billcurrency";
            }

            if (objbill != "") {
                if ($("#"+objbill).val()=="") {
                $("#"+objbill).val(r.data.itm_FCurrency);
                }
            }
            
//            var fr = StoreCurrInvoice.getById($("#" + obj5).val());
//            if (fr.data.rate != undefined) {
//                $("#" + obj8).val(fr.data.rate);
//            }
//            else {
//                $("#" + obj8).val("");
            //  
             //         }
            SetCurRate(obj5, obj8);
            
            
            if (r.data.itm_FRate != undefined) {
                $("#" + obj6).val(r.data.itm_FRate);
            }
            else {
                $("#" + obj6).val("");
            }
            if (r.data.itm_FAmount != undefined) {
                $("#" + obj7).val(r.data.itm_FAmount);
            }
            else {
                $("#" + obj7).val("");
            }
            GetCalcData($("#" + obj2).val(), obj4, obj3);
            
        }
        else {
            $("#" + obj2).val(r.data.itm_LCalcQty);
            $("#" + obj4).val(r.data.itm_LUnit);
            $("#" + obj5).val(r.data.itm_LCurrency);

            var objbill = "";
            if ($("#ucCost_billcurrency").length > 0) {
                objbill = "ucCost_billcurrency";
            }
            else {
                objbill = "billcurrency";
            }

            if (objbill != "") {
                if ($("#" + objbill).val() == "") {
                    $("#" + objbill).val(r.data.itm_LCurrency);
                }
            }
//            if ($("#billcurrency").length > 0) {
//                if ($("#billcurrency").val() == "") {
//                    $("#billcurrency").val(r.data.itm_LCurrency);
//                }
//            }
            
//            var lr = StoreCurrInvoice.getById($("#" + obj5).val());
//            if (lr.data.rate != undefined) {
//                $("#" + obj8).val(lr.data.rate);
//            }
//            else {
//                $("#" + obj8).val("");
//            }
            SetCurRate(obj5, obj8);
            
            if (r.data.itm_LRate != undefined) {
                $("#" + obj6).val(r.data.itm_LRate);
            }
            else {
                $("#" + obj6).val("");
            }
            if (r.data.itm_LAmount != undefined) {
                $("#" + obj7).val(r.data.itm_LAmount);
            }
            else {
                $("#" + obj7).val("");
            }
            GetCalcData($("#" + obj2).val(), obj4, obj3);
        }
    }
}

function GetCalcData(text,obj1,obj2) {
    var Qty = "";
    switch (text) {
        case "GWT":
            if ($("#txtGWT").length > 0) {
                Qty = txtGWT.getValue();
                if (Qty == "" && $("#txtAGWT").length > 0) {
                    Qty = txtAGWT.getValue();
                }
            }
            else if ($("#txtCGWT").length > 0) {
                Qty = txtCGWT.getValue();
                if (Qty == "") {
                    Qty = txtAGWT.getValue();
                }
            }
            break;
        case "CWT":
            if ($("#txtCWT").length > 0) {
                Qty = txtCWT.getValue();
            }
            break;
        case "WM":
            if ($("#txtCWT").length > 0) {
                Qty = txtCWT.getValue();
                if (Qty == "" && $("#txtAWM").length > 0) {
                    Qty = txtAWM.getValue();
                }
            }
            else if ($("#txtCWM").length > 0) {
                Qty = txtCWM.getValue();
                if (Qty == "") {
                    Qty = txtAWM.getValue();
                }
            }
            //min
//            if (Qty != "") {
//                if (Qty > 0 && Qty < 1) {
//                    Qty = 1;
//                }
//            }
            break;   
        case "VWT":
            if ($("#txtVWT").length > 0) {
                Qty = txtVWT.getValue();
            }
            break;
        case "PCS":
            if ($("#txtPiece").length > 0) {
                Qty = txtPiece.getValue();
                if (Qty == "" && $("#txtAPiece").length > 0) {
                    Qty = txtAPiece.getValue();
                }
            }
            else if ($("#txtPieces").length > 0) {
                Qty = txtPieces.getValue();
            }
            else if ($("#txtCPiece").length > 0) {
                Qty = txtCPiece.getValue();
                if (Qty == "") {
                    Qty = txtAPiece.getValue();
                }
            }
            if ($("#CmbUnit").length > 0) {
                Unit = CmbUnit.getValue();
                $("#" + obj1).val(Unit);
            }
            else {
                $("#" + obj1).val("");
            }
            break;
        case "CNTR":
            if ($("#txtContainer").length > 0) {
                Qty = txtContainer.getValue();
            }
            break;
        case "CBM":
            if ($("#txtCBM").length > 0) {
                Qty = txtCBM.getValue();
                if (Qty == "" && $("#txtACBM").length > 0) {
                    Qty = txtACBM.getValue();
                }
            }
            else if ($("#txtCCBM").length > 0) {
                Qty = txtCCBM.getValue();
                if (Qty == "") {
                    Qty = txtACBM.getValue();
                }
            }
            break;
        case "CCBM":
            if ($("#txtCBM").length > 0) {
                Qty = txtCBM.getValue();
            }
            break;
        case "OTHER":
            if ($("#CmbUnit").length > 0) {
                $("#" + obj1).val("");
            }
            break;    
    }
    $("#" + obj2).val(Qty);

}

function SelectCalcData(type,obj1, obj2, obj3, obj4, obj5, obj6, obj7) {
    var Qty = "", Unit = "";
    var obj = "";
    if ($("#" + type).length > 0) {
        obj = $("#" + type).val();
    }
    else {
        obj = "LOCAL";
    }
    var kind = $("#"+obj2).val();
    var r = StoreGetItem.getById($("#" + obj1).val());
    if (Ext.isEmpty(r)) {
        return false;
    }
    else {
        if (obj.toUpperCase() == "AGENT") {
            $("#" + obj4).val(r.data.itm_FUnit);
//            $("#" + obj5).val(r.data.itm_FCurrency);
//            if (r.data.itm_FRate != undefined) {
//                $("#" + obj6).val(r.data.itm_FRate);
//            }
//            else {
//                $("#" + obj6).val("");
//            }
//            if (r.data.itm_FAmount != undefined) {
//                $("#" + obj7).val(r.data.itm_FAmount);
//            }
//            else {
//                $("#" + obj7).val("");
//            }
        }
        else {
            $("#" + obj4).val(r.data.itm_LUnit);
//            $("#" + obj5).val(r.data.itm_LCurrency);
//            if (r.data.itm_LRate != undefined) {
//                $("#" + obj6).val(r.data.itm_LRate);
//            }
//            else {
//                $("#" + obj6).val("");
//            }
//            if (r.data.itm_LAmount != undefined) {
//                $("#" + obj7).val(r.data.itm_LAmount);
//            }
//            else {
//                $("#" + obj7).val("");
//            }
        }
    }
    switch (kind) {
        case "GWT":
            if ($("#txtGWT").length > 0) {
                Qty = txtGWT.getValue();
                if (Qty == "" && $("#txtAGWT").length > 0) {
                    Qty = txtAGWT.getValue();
                }
            }
            else if ($("#txtCGWT").length > 0) {
                Qty = txtCGWT.getValue();
                if (Qty == "") {
                    Qty = txtAGWT.getValue();
                }
            }
            break;
        case "CWT":
            if ($("#txtCWT").length > 0) {
                Qty = txtCWT.getValue();
            }
            break;
        case "WM":
            if ($("#txtCWT").length > 0) {
                Qty = txtCWT.getValue();
                if (Qty == "" && $("#txtAWM").length > 0) {
                    Qty = txtAWM.getValue();
                }
            }
            else if ($("#txtCWM").length > 0) {
                Qty = txtCWM.getValue();
                if (Qty == "") {
                    Qty = txtAWM.getValue();
                }
            }
            //min
            //            if (Qty != "") {
            //                if (Qty > 0 && Qty < 1) {
            //                    Qty = 1;
            //                }
            //            }
            break;   
        case "VWT":
            if ($("#txtVWT").length > 0) {
                Qty = txtVWT.getValue();
            }
            break;
        case "PCS":
            if ($("#txtPiece").length > 0) {
                Qty = txtPiece.getValue();
                if (Qty == "" && $("#txtAPiece").length > 0) {
                    Qty = txtAPiece.getValue();
                }
            }
            else if ($("#txtPieces").length > 0) {
                Qty = txtPieces.getValue();
            }
            else if ($("#txtCPiece").length > 0) {
                Qty = txtCPiece.getValue();
                if (Qty == "") {
                Qty=txtAPiece.getValue();
                }
            }
            if ($("#CmbUnit").length > 0) {
                Unit = CmbUnit.getValue();
                $("#" + obj4).val(Unit);
            }
            break;
        case "CNTR":
            if ($("#txtContainer").length > 0) {
                Qty = txtContainer.getValue();
            }
            break;
        case "CBM":
            if ($("#txtCBM").length > 0) {
                Qty = txtCBM.getValue();
                if (Qty == "" && $("#txtACBM").length > 0) {
                    Qty = txtACBM.getValue();
                }
            }
            else if ($("#txtCCBM").length > 0) {
            Qty = txtCCBM.getValue();
                
                if (Qty == "") {
                    Qty = txtACBM.getValue();
                }
            }
            break;
        case "CCBM":
            if ($("#txtCBM").length > 0) {
                Qty = txtCBM.getValue();
            }
            break;
        case "OTHER":
            if ($("#CmbUnit").length > 0) {
                $("#" + obj4).val("");
            }
            break;
    }
    $("#" + obj3).val(Qty);
}

function SelectCalc(obj,obj1,obj2) {
    var Qty, Unit;
    var kind = $("#"+obj).val();
    var r = StoreKind.getById(kind);
    if (Ext.isEmpty(r)) {
        return false;
    }
    else {
        $("#" + obj2).val(r.data.unit);
        switch (kind) {
            case "GWT":
                if ($("#txtGWT").length > 0) {
                    Qty = txtGWT.getValue();
                    if (Qty == "" && $("#txtAGWT").length > 0) {
                        Qty = txtAGWT.getValue();
                    }
                }
                else if ($("#txtCGWT").length > 0) {
                    Qty = txtCGWT.getValue();
                    if (Qty == "") {
                        Qty = txtAGWT.getValue();
                    }
                }
                break;
            case "CWT":
                if ($("#txtCWT").length > 0) {
                    Qty = txtCWT.getValue();
                }
                break;
            case "WM":
                if ($("#txtCWT").length > 0) {
                    Qty = txtCWT.getValue();
                    if (Qty == "" && $("#txtAWM").length > 0) {
                        Qty = txtAWM.getValue();
                    }
                }
                else if ($("#txtCWM").length > 0) {
                Qty = txtCWM.getValue();
                if (Qty == "") {
                    Qty = txtAWM.getValue();
                }
               }
               //min
               //            if (Qty != "") {
               //                if (Qty > 0 && Qty < 1) {
               //                    Qty = 1;
               //                }
               //            }
                break;   
            case "VWT":
                if ($("#txtVWT").length > 0) {
                    Qty = txtVWT.getValue();
                }
                break;
            case "PCS":
                if ($("#txtPiece").length > 0) {
                    Qty = txtPiece.getValue();
                    if (Qty == "" && $("#txtAPiece").length > 0) {
                        Qty = txtAPiece.getValue();
                    }
                }
                else if ($("#txtPieces").length > 0) {
                    Qty = txtPieces.getValue();
                }
                else if ($("#txtCPiece").length > 0) {
                    Qty = txtCPiece.getValue();
                    if (Qty == "") {
                        Qty = txtAPiece.getValue();
                    }
                }
                if ($("#CmbUnit").length > 0) {
                    Unit = CmbUnit.getValue();
                    $("#" + obj2).val(Unit);
                }
                break;
            case "CNTR":
                if ($("#txtContainer").length > 0) {
                    Qty = txtContainer.getValue();
                }
                break;
            case "CBM":
                if ($("#txtCBM").length > 0) {
                    Qty = txtCBM.getValue();
                    if (Qty == "" && $("#txtACBM").length > 0) {
                        Qty = txtACBM.getValue();
                    }
                }
                else if ($("#txtCCBM").length > 0) {
                Qty = txtCCBM.getValue();
                if (Qty == "") {
                    Qty = txtACBM.getValue();
                }
                }
                break;
            case "CCBM":
                if ($("#txtCBM").length > 0) {
                    Qty = txtCBM.getValue();
                }
                break;
            case "OTHER":
                if ($("#CmbUnit").length > 0) {
                    $("#" + obj2).val("");
                }
                break;
        }
        $("#" + obj1).val(Qty);
    }
}

function GetAEItemData(type, obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8,obj9) {
    var obj = "";
    if ($("#" + type).length > 0) {
        obj = $("#" + type).val();
    }
    else {
        if (type.toUpperCase() == "FOREIGN") {
            obj = "AGENT";
        }
        else {
            obj = "LOCAL";
        }
    }
    var r = StoreGetItem.getById($("#" + obj1).val());
    if (Ext.isEmpty(r)) {
        return false;
    }
    else {
        if (obj.toUpperCase() == "AGENT") {
            $("#" + obj2).val(r.data.itm_FCalcQty);
            $("#" + obj4).val(r.data.itm_FUnit);
            $("#" + obj5).val(r.data.itm_FCurrency);

            var objbill = "";
            if ($("#ucCost_billcurrency").length > 0) {
                objbill = "ucCost_billcurrency";
            }
            else {
                objbill = "billcurrency";
            }

            if (objbill != "") {
                if ($("#" + objbill).val() == "") {
                    $("#" + objbill).val(r.data.itm_FCurrency);
                }
            }
//            if ($("#billcurrency").length > 0) {
//                if ($("#billcurrency").val() == "") {
//                    $("#billcurrency").val(r.data.itm_FCurrency);
//                }
//            }
            
//            var fr = StoreCurrInvoice.getById($("#" + obj5).val());
//            if (fr.data.rate != undefined) {
//                $("#" + obj8).val(fr.data.rate);
//            }
//            else {
//                $("#" + obj8).val("");
//            }
            SetCurRate(obj5, obj8);
            
            if (r.data.itm_FRate != undefined) {
                $("#" + obj6).val(r.data.itm_FRate);
            }
            else {
                $("#" + obj6).val("");
            }
            if (r.data.itm_FAmount != undefined) {
                $("#" + obj7).val(r.data.itm_FAmount);
            }
            else {
                $("#" + obj7).val("");
            }
            if ($("#" + obj9).length > 0) {
                if (r.data.itm_FMin != undefined) {
                    $("#" + obj9).val(r.data.itm_FMin);
                }
                else {
                    $("#" + obj9).val("");
                }
            }
            GetCalcData($("#" + obj2).val(), obj4, obj3);
        }
        else {
            $("#" + obj2).val(r.data.itm_LCalcQty);
            $("#" + obj4).val(r.data.itm_LUnit);
            $("#" + obj5).val(r.data.itm_LCurrency);


            var objbill = "";
            if ($("#ucCost_billcurrency").length > 0) {
                objbill = "ucCost_billcurrency";
            }
            else {
                objbill = "billcurrency";
            }

            if (objbill != "") {
                if ($("#" + objbill).val() == "") {
                    $("#" + objbill).val(r.data.itm_LCurrency);
                }
            }
//            if ($("#billcurrency").length > 0) {
//                if ($("#billcurrency").val() == "") {
//                    $("#billcurrency").val(r.data.itm_LCurrency);
//                }
//            }
            
//            var lr = StoreCurrInvoice.getById($("#" + obj5).val());
//            if (lr.data.rate != undefined) {
//                $("#" + obj8).val(lr.data.rate);
//            }
//            else {
//                $("#" + obj8).val("");
//            }
            SetCurRate(obj5, obj8);
            
            if (r.data.itm_LRate != undefined) {
                $("#" + obj6).val(r.data.itm_LRate);
            }
            else {
                $("#" + obj6).val("");
            }
            if (r.data.itm_LAmount != undefined) {
                $("#" + obj7).val(r.data.itm_LAmount);
            }
            else {
                $("#" + obj7).val("");
            }
            if ($("#" + obj9).length > 0) {
                if (r.data.itm_LMin != undefined) {
                    $("#" + obj9).val(r.data.itm_LMin);
                }
                else {
                    $("#" + obj9).val("");
                }
            }
            GetCalcData($("#" + obj2).val(), obj4, obj3);
        }
    }
}