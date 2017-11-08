/// <reference path="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" />
/// <reference path="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" />
/// <reference path="../../common/ylQuery/ylQuery.js" />

$(document).ready(function() {
    $("#Code").focus();
});

function NextClick() {
    if ($.trim($("#Code").val()) == "") {
        alert("Code can't be null");
        $("#Code").focus();
        return false;
    }
    if ($.trim($("#Name").val()) == "") {
        alert("Name can't be null");
        $("#Name").focus();
        return false;
    }
    var chk = $("#chkActive").attr("checked") == true ? "1" : "0";
    var chkUS= $("#chkUSGroup").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Salesman/DataController.ashx?Option=update&chkActive=" + chk+"&chkUSGroup="+chkUS }, function(data) {
        var json = typeof (data) == "object" ? data : $.parseJSON(data);
        if (json[0].Option == "true") {
            $("#countryControl").find("input[type=text]").attr("value", "");
            $("#chkActive").attr("checked", false);
            $("#chkUSGroup").attr("checked", false);
            alert("saved successful");
            $("#Code").focus();
        }
        else {
            $("#hidRowID").val("");
            $("#Code").val("");
            $("#countryControl").find("input[type=text]").attr("value", "");
            $("#chkActive").attr("checked", false);
            $("#chkUSGroup").attr("checked", false);
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
    if ($.trim($("#Name").val()) == "") {
        alert("Name can't be null");
        $("#Name").focus();
        return false;
    }
    var chk = $("#chkActive").attr("checked") == true ? "1" : "0";
    var chkUS= $("#chkUSGroup").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Salesman/DataController.ashx?Option=update&chkActive=" + chk +"&chkUSGroup="+chkUS}, function(data) {
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

function CancelClick() {

    $("#hidRowID").val("");
    $("#Code").val("");
    $("#chkActive").attr("checked", false);
    $("#chkUSGroup").attr("checked", false);
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
    $("#Name").val(record.json.Name);
    $("#Company").val(record.json.Company == null ? "" : record.json.Company);
    var rd = Store1.getById(record.json.Company);
    var textCom = "";
    if (Ext.isEmpty(rd)) {
        textCom = "";
    }
    else {
        textCom = rd.data.text;
    }
    $("#Company1").val(textCom);
    if (record.json.Active == true) {
        $("#chkActive").attr("checked", true);
    }
    else {
        $("#chkActive").attr("checked", false);
    }
    if (record.json.USGroup == true) {
        $("#chkUSGroup").attr("checked", true);
    }
    else {
        $("#chkUSGroup").attr("checked", false);
    }
}

