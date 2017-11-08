/// <reference path="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" />
/// <reference path="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" />
/// <reference path="../../common/ylQuery/ylQuery.js" />

$(document).ready(function() {
    $("#Code").focus();
});

var number3 = function(value) {
    return value.toFixed(3);
}


function NextClick() {
    if ($.trim($("#Code").val()) == "") {
        alert("Code can't be null");
        $("#Code").focus();
        return false;
    }
    if ($.trim($("#Description").val()) == "") {
        alert("Description can't be null");
        $("#Description").focus();
        return false;
    }
    var chk = $("#chkActive").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Currency/DataController.ashx?Option=update&chkActive=" + chk }, function(data) {
        var json = typeof (data) == "object" ? data : $.parseJSON(data);
        if (json[0].Option == "true") {
            $("#countryControl").find("input[type=text]").attr("value", "");
            $("#chkActive").attr("checked", false);
            alert("saved successful");
            $("#Code").focus();
        }
        else {
            $("#hidRowID").val("");
            $("#Code").val("");
            $("#countryControl").find("input[type=text]").attr("value", "");
            $("#chkActive").attr("checked", false);
            alert("saved failed");
            $("#Code").focus();
        }
    });
}

function SaveClick() {
    if ($.trim($("#Code").val()) == "") {
        alert("Code can't be null");
        $("#Code").focus();
        return false;
    }
    if ($.trim($("#Description").val()) == "") {
        alert("Description can't be null");
        $("#Description").focus();
        return false;
    }
    var chk = $("#chkActive").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Currency/DataController.ashx?Option=update&chkActive=" + chk }, function(data) {
        var json = typeof (data) == "object" ? data : $.parseJSON(data);
        if (json[0].Option == "true") {
            alert("saved successful");
            $("#Code").focus();
        }
        else {
            alert("saved failed");
            $("#Code").focus();
        }
    });
}

function ChangeValue() {

    if ($("#txtSell").val() == "" || $("#txtSell").val() == "0") {
        $("#txtSell").val($("#txtRate").val());
    }
    if ($("#txtBuy").val() == "" || $("#txtBuy").val() == "0") {
        $("#txtBuy").val($("#txtRate").val());
    }
}

function CancelClick() {

    $("#hidRowID").val("");
    $("#Code").val("");
    $("#chkActive").attr("checked", false);
    $("#countryControl").find("input[type=text]").attr("value", "");
    $("#Code").focus();
}

var rowclickFn = function(grid, rowIndex, columnIndex, e) {
    //    var record = grid.getStore().getAt(rowIndex);   //Get the Record
    //    var fieldName = grid.getColumnModel().getDataIndex(columnIndex); //Get field name
    //    var data = record.get(fieldName);
    var record = grid.getStore().getAt(rowIndex);

    $("#hidRowID").val(record.json.RowID);
    $("#Code").val(record.json.Code);
    $("#Description").val(record.json.Description);
    $("#Country").val(record.json.Country == null ? "" : record.json.Country);
    $("#txtRate").val(record.json.Rate == null ? 0 : Number(record.json.Rate).toFixed(3));
    $("#txtSell").val(record.json.Sell == null ? 0 : Number(record.json.Sell).toFixed(3));
    $("#txtBuy").val(record.json.Buy == null ? 0 : Number(record.json.Buy).toFixed(3));
    if (record.json.Active == true) {
        $("#chkActive").attr("checked", true);
    }
    else {
        $("#chkActive").attr("checked", false);
    }

}

