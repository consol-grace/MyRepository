
var selectRow = -1;
function GetRowID(row) {
    selectRow = row;
}


function InsertRecord() {
    var company = $("#l_company").val().toUpperCase();
    var item = $("#l_item").val();
    var calc = $("#l_calc").val();
    var qty = $("#l_qty").val();
    var unit = $("#l_unit").val();
    var currency = $("#l_currency").val();
    var ex = $("#l_ex").val();
    var rate = $("#l_rate").val();
    var amount = $("#l_amount").val();
    var companyName = $("#l_company_text").val();
    var description = $("#l_item_text").text();
    var total = amount == undefined || amount == "" ? qty * rate : amount;

    if (company == "" || company == undefined) {
        $("#l_company").focus();
        return;
    }
    if (item == "" || item == undefined) {
        $("#l_item").focus();
        return;
    }

    if ((rate == "" || rate == undefined) && (amount == "" || amount == undefined)) {
        $("#l_rate").focus();
        return;
    }
    var count = GridPanel3.store.getTotalCount();  // 获取当前行数
    if (selectRow >= 0) {
        var record = GridPanel3.getStore().getAt(selectRow); // 获取当前行的数据
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
    }
    else {
        GridPanel3.insertRecord(count, { EX: ex, CompanyCode: company, CompanyName: companyName, Description: description, Item: item, Total: total, CalcKind: calc, Qty: qty, Unit: unit, Currency: currency, Rate: rate, Amount: amount });
    }
    GridPanel3.getView().refresh();
    GridPanel3.view.focusEl.focus();
    ResetRecord();

}

function SelectRecord() {
    Invlidata("l_company");
    var record = GridPanel3.getStore().getAt(selectRow); // 获取当前行的数据
    if (record == null || record == undefined)
        return;
    else {
        $("#l_company").val(record.data.CompanyCode).removeClass("bottom_line").attr("validata", "true");
        $("#l_item").val(record.data.Item);
        $("#l_calc").val(record.data.CalcKind);
        $("#l_qty").val(record.data.Qty);
        $("#l_unit").val(record.data.Unit);
        $("#l_currency").val(record.data.Currency);
        $("#l_ex").val(record.data.EX);
        $("#l_rate").val(record.data.Rate);
        $("#l_amount").val(record.data.Amount);
        $("#l_company_text").val(record.data.CompanyName)
        $("#l_company_text1").val(record.data.CompanyName)
        $("#l_item_text").text(record.data.Description)
    }
}

function DeleteRecord() {
    GridPanel3.getSelectionModel().selectRow(selectRow);
    GridPanel3.deleteSelected();
    ResetRecord();
}

function ResetRecord() {
    Invlidata("l_company");
    selectRow = -1;
    $("#l_company").val("").removeClass("bottom_line").attr("validata", "true").focus();
    $("#l_item").val("");
    $("#l_calc").val("");
    $("#l_qty").val("");
    $("#l_unit").val("");
    $("#l_currency").val("");
    $("#l_ex").val("");
    $("#l_rate").val("");
    $("#l_amount").val("");
    $("#l_company_text1").val("")
    $("#l_company_text").val("")
    $("#l_item_text").text("")
}




function ReturnNull() {
    var Shipper = "";
    var Shipper1 = "";
    var Consignee = "";
    var Consignee1 = "";
    var sales = "";

    Shipper = $("#CmbShipperCode").val();
    Shipper1 = $("#CmbShipperCode_name").val();
    Consignee = $("#CmbConsigneeCode").val();
    Consignee1 = $("#CmbConsigneeCode_name").val();
    sales = $("#CmbSalesman").val();

    if ((Shipper == "" || Shipper == undefined) && (Shipper1 == "" || Shipper1 == undefined)) {
        $("#CmbShipperCode").focus();
        NullMsg("Shipper");
        return false;
    }
    else if ((Consignee == "" || Consignee == undefined) && (Consignee1 == "" || Consignee1 == undefined)) {
        $("#CmbConsigneeCode").focus();
        NullMsg("Consignee");
        return false;
    }
    else if (sales == "" || sales == undefined) {
        $("#CmbSalesman").focus();
        NullMsg("Sales");
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


function getshowVessel(vessel, voyage) {
    cmbVesselCode.setValue(vessel);
    CompanyX.BindVoyag(voyage);
    Window1.close();
}

function ShowVoyage(vesselID, voyageID) {
    //alert(vessel + "," + voyage);
    var option = "?vesselID=" + vesselID + "&voyageID=" + voyageID + "&controlID=control";
    win = new Ext.Window({
        id: "Window1",
        title: "Vessel/Voyage",
        resizable: false,
        draggable: false,
        //animateTarget: "cmbVesselText",  //--- 此效果会有点卡
        width: 710,
        height: 365,
        modal: true,
        closeAction: "close"
    });

    win.on({ close: function(win) {
        //win.close();
        //win.destroy();
        //StoreVoyage.reload();
        window.parent.window.document.body.style.overflow = "auto";
        getSelectPos('cmbVesselCode');
    }
    });
    win.load("http://" + window.location.host + "/Oceanimport/voyage/list.aspx" + option);
    win.show();
    window.parent.window.document.body.style.overflow = "hidden";
}


function SetComValue(obj, name) {
    var hidcode = $("#" + obj + "1").val();
    var code = $("#" + obj).val();
        if (hidcode != code) {
            $("#" + obj + "_name").val(name);
            $("#" + obj + "1").val(code);
        }

    }

    function SelectItem(obj, obj1) {
        var value = $("#"+obj).val();
        var record = StoreLocation.getById(value);
        if (record != null && record != undefined) {
            $("#" + obj1).val(record.data.text);
        }
    }
