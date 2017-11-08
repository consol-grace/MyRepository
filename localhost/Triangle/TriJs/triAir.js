function ReturnNull() {
    var Shipper = "";
    var Shipper1 = "";
    var Consignee = "";
    var Consignee1 = "";
    var sales = "";
    var etd = "";
    var eta = "";

    Shipper = $("#CmbShipperCode").val();
    Shipper1 = $("#CmbShipperCode_name").val();
    Consignee = $("#CmbConsigneeCode").val();
    Consignee1 = $("#CmbConsigneeCode_name").val();
    sales = $("#CmbSalesman").val();
    etd = $("#txtDepartDate").val();
    eta = $("#txtArrivalDate").val();

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
    else if (etd == "" || etd == undefined) {
        $("#txtDepartDate").focus();
        NullMsg("ETD");
        return false;
    }
    else if (eta == "" || eta == undefined) {
        $("#txtArrivalDate").focus();
        NullMsg("ETA");
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



function SetComValue(obj, name) {
    var hidcode = $("#" + obj + "1").val();
    var code = $("#" + obj).val();
    if (hidcode != code) {
        $("#" + obj + "_name").val(name);
        $("#" + obj + "1").val(code);
    }

}


function SelectItem(obj, obj1) {
    var value = $("#" + obj).val();
    var record = StoreLocation.getById(value);
    if (record != null && record != undefined) {
        $("#" + obj1).val(record.data.text);
    }
}

