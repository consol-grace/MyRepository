///—————————grid  start ———————————
/// Grid  插入行
///  单击grid  插入行
function NewRow(grid, rowIndex) {
    if (grid == null) return;
    if (grid.store.getTotalCount() > 0) {
        return;
    }
    grid.insertRecord(rowIndex, {});
    grid.getView().refresh();
    grid.getSelectionModel().selectRow(rowIndex);
    grid.startEditing(rowIndex, 1);
}

/// 按键 grid 插入行
function InsertRow(grid, isRow) {
    var row = 0;
    if (grid == null) return;

    AutoDeleteRow(grid);

    if (isRow) row = grid.store.getTotalCount();
    else row = selectRow;

    grid.insertRecord(row, {});
    grid.getView().refresh();
    grid.getSelectionModel().selectRow(row);
    grid.startEditing(row, 1);
}




function EditRow(grid) {

    if (grid == null) return;
    grid.getSelectionModel().selectRow(selectRow);
    grid.startEditing(selectRow, 1);
}

/// Grid 删除行, row 当前行 ， row 为空  删除所有选择的行
function DeleteRow(grid, row) {

    if (grid == null)
        return;

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
///———————— grid  end —————————

function AutoDeleteRow(grid) {

    if (grid.store.getTotalCount() > 0 && grid.id == "GridFlightList") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var flighNo = grid.getRowsValues({ Selectedonly: true })[i].FlightNo;
            var from = grid.getRowsValues({ Selectedonly: true })[i].From;
            var To = grid.getRowsValues({ Selectedonly: true })[i].To;
            var ETD = grid.getRowsValues({ Selectedonly: true })[i].ETD;
            var ETA = grid.getRowsValues({ Selectedonly: true })[i].ETA;
            var ATD = grid.getRowsValues({ Selectedonly: true })[i].ATD;
            var ATA = grid.getRowsValues({ Selectedonly: true })[i].ATA;

            if (flighNo == "" && from == "" && To == "" && ETD == undefined && ETA == undefined && ATD == undefined && ATA == undefined) {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
        TabSum(grid);
    }
    else if (grid.store.getTotalCount() > 0 && grid.id == "gridCost") {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var flighNo = grid.getRowsValues({ Selectedonly: true })[i].CompanyCode;
            var Currency = grid.getRowsValues({ Selectedonly: true })[i].Item
            var CalcKind = grid.getRowsValues({ Selectedonly: true })[i].CalcKind;
            var Qty = grid.getRowsValues({ Selectedonly: true })[i].Qty
            if (flighNo == "" && Currency == "" && CalcKind == "" && Qty == undefined) {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }
}
document.onfocus = function det() { AutoDeleteRow(gridCost) }

///—————— Flight List  —》Flight ——————
function TabSum(grid) {

    if (grid == null) return;
    var count = grid.store.getTotalCount();

    if (count > 0) {

        txtFlightRight.setValue(grid.getRowsValues({ Selectedonly: true })[0].FlightNo);
        CmbFromRight.setValue(grid.getRowsValues({ Selectedonly: true })[0].From);
        CmbToRight.setValue(grid.getRowsValues({ Selectedonly: true })[count - 1].To);
        txtETD.setValue(grid.getRowsValues({ Selectedonly: true })[0].ETD);
        txtETA.setValue(grid.getRowsValues({ Selectedonly: true })[count - 1].ETA);
        txtATD.setValue(grid.getRowsValues({ Selectedonly: true })[0].ATD);
        txtATA.setValue(grid.getRowsValues({ Selectedonly: true })[count - 1].ATA);
    }
}
///————————— end ——————————


///—————— Local Costing  数据处理 —————
function RetrunText(obj, grid) {

    var Qty, Unit;
    var record = grid.getStore().getAt(selectCostTotalRow);
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
    record = grid.getStore().getAt(selectCostTotalRow);
    record.set("Qty", Qty);
    record.set("Unit", Unit);
}


var b = "1";
function gridTotals(grid) {
    if (grid == null) return;
    var record = grid.getStore().getAt(selectCostTotalRow);
    var Amount = record.data.Amount;
    var Rate = record.data.Rate;
    var Qty = record.data.Qty;

    if (Rate != "" && b == "1") { record.set("Amount", ""); b = "0"; record = grid.getStore().getAt(selectCostTotalRow); }

    else if (Amount != "" && b == "0") { record.set("Rate", ""); b = "1"; record = grid.getStore().getAt(selectCostTotalRow); }

    record = grid.getStore().getAt(selectCostTotalRow);
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


///——————Add Invoice    Add Hawb——————
function Add() {

    //    Ext.MessageBox.confirm("Status", " Please save the data ? ", function(e) {
    //        if (e == "yes") {
    Ext.getCmp('btnSave').fireEvent('click', this);
    var s = Request("seed");
    setTimeout(function() { window.open("hawb.aspx?MAWB=" + Request("seed"), $("#labLotNo").text()) }, 1000);
    //        }
    //    });
}


///—————————— end ——————————



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
    var MAWB = "";
    var Shipper = "";
    var Consignee = "";
    var Salesman = "";
    var CWT = "";
    var Pieces = "";
    var Unit = "";
    var Carrier = "";
    var FlightNo = "";
    var From = "";
    var To = "";
    var ETD = "";
    var ETA = "";
    var ATD = "";
    MAWB = txtMawb.getValue();
    Shipper = $("#CmbShipperCode").val(); 
    Consignee = $("#CmbConsigneeCode").val();
    Salesman = CmbSalesman.getValue();
    CWT = txtCWT.getValue();
    Pieces = txtPiece.getValue();
    Unit = CmbUnit.getValue();
    Carrier = $("#CmbCarrierRight").val();
    FlightNo = txtFlightRight.getValue();
    From = CmbFromRight.getValue();
    To = CmbToRight.getValue();
    ETD = txtETD.getValue();
    ETA = txtETA.getValue();
    ATD = txtATD.getValue();
    if (MAWB == "" || MAWB == undefined)
    {
       txtMawb.focus();
       NullMsg("MAWB");
       return false;
       
    }
     else if (Shipper == ""||Shipper == undefined)
    {
        $("#CmbShipperCode").focus();
        NullMsg("Shipper");
        return false;
    } 
    else if (Consignee == ""||Consignee == undefined)
    {
        $("#CmbConsigneeCode").focus();
        NullMsg("Consignee");
        return false;
    }
    else if ((chbDirect.checked==true)&&(Salesman == ""||Salesman == undefined))
    {
        CmbSalesman.focus();
        NullMsg("Salesman");
        return false;
    }
    else if (CWT == ""||CWT == undefined)
    {
        txtCWT.focus();
        NullMsg("CWT");
        return false;
    }        
    else if (Pieces == ""||Pieces == undefined)
    {
        txtPiece.focus();
        NullMsg("Piece");
        return false;
    }          
    else if (Unit == ""||Unit == undefined)
    {
        CmbUnit.focus();
        NullMsg("Unit");
        return false;
    }
    else if (Carrier == ""||Carrier == undefined)
    {
        $("#CmbCarrierRight").focus();
        NullMsg("Carrier");
        return false;
    }
    else if (FlightNo == "" || FlightNo == undefined) {
        txtFlightRight.focus();
        NullMsg("Flight No");
        return false;
    }
    else if (From == "" || From == undefined) {
        CmbFromRight.focus();
        NullMsg("From");
        return false;
    }
    else if (To == "" || To == undefined) {
        CmbToRight.focus();
        NullMsg("To");
        return false;
    }
    else if (ETD == "" || ETD == undefined) {
        txtETD.focus();
        NullMsg("ETD");
        return false;
    }
    else if (ETA == "" || ETA == undefined) {
        txtETA.focus();
        NullMsg("ETA");
        return false;
    }
    else if (ATD == "" || ATD == undefined) {
        txtATD.focus();
        NullMsg("ATD");
        return false;
    }                               
    else {
        return true;
    }
}


function HawbShow(b) {
    if (b) {
        $(".GridView_1").hide();
        $("#GridView_1").hide();
        $(".chkDirect").css({ "color": "red", "font-weight": "bold" })
    }
    else {
        $(".GridView_1").show();
        $("#GridView_1").show();
//        var obj1 = document.getElementById("grid3");
//        var obj2 = document.getElementById("grid4");
//        obj1.swapNode(obj2);
        $(".chkDirect").css({ "color": "#333", "font-weight": "normal" })
    }
}

function CheckDirect() {

    if (chbDirect.checked == true) {
        $('#td_sales2').css('visibility', 'visible'); $('#td_sales1').css('visibility', 'visible');
        $(".GridView_1").hide();
        $("#GridView_1").hide();
        $(".chkDirect").css({ "color": "red", "font-weight": "bold" })
    }
     else {
         $('#td_sales1').css('visibility', 'hidden'); $('#td_sales2').css('visibility', 'hidden');
         $(".GridView_1").show();
         $("#GridView_1").show();
         $(".chkDirect").css({ "color": "#333", "font-weight": "normal" })

    };
    
    

//    var obj1 = document.getElementById("grid3");
//    var obj2 = document.getElementById("grid4");
//    
//    obj1.swapNode(obj2);
    
    
}



//验证错误信息
function NullMsg(msg) {
    $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg + " can't empty!");
}