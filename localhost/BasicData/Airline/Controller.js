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
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Airline/DataController.ashx?Option=update&chkActive=" + chk }, function(data) {
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
    if ($.trim($("#Name").val()) == "") {
            alert("Name can't be null");
           $("#Name").focus();
            return false;
        }
    var chk = $("#chkActive").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Airline/DataController.ashx?Option=update&chkActive=" + chk }, function(data) {
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

var selectRow = 0;
function getRowIndex(rowIndex) {
    selectRow = rowIndex;
}

function CancelClick(grid, rowIndex) {
    //    var record = grid.getStore().getAt(rowIndex);   //Get the Record
    //    var fieldName = grid.getColumnModel().getDataIndex(columnIndex); //Get field name
    //    var data = record.get(fieldName);
    var record = grid.getStore().getAt(rowIndex);

    hidRowID.setValue(record.json.RowID);
    Code.setValue(record.json.Code);
    Name.setValue(record.json.Name);
    Country.setValue(record.json.Country == null ? "" : record.json.Country);
    txtCallSign.setValue(record.json.CallSign == null ? "" : record.json.CallSign);
    if (record.json.Active == true) {
        $("#chkActive").attr("checked", true);
    }
    else {
        $("#chkActive").attr("checked", false);
    }
    Code.focus(true);
}

