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
    if ($.trim($("#Short").val())== "") {
        alert("Short can't be null");
        $("#Short").focus();
        return false;
    }
    var chk = $("#chkActive").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Unit/DataController.ashx?Option=update&chkActive=" + chk }, function(data) {
        var json = typeof (data) == "object" ? data : $.parseJSON(data);
        if (json[0].Option == "true") {
            $("#hidRowID").val("");
            $("#Code").val("");
            $("#Short").val("");
            $("#Description").val("");
            $("#chkActive").attr("checked", false);
            alert("saved successful");
            $("#Code").focus();
        }
        else {
            $("#hidRowID").val("");
            $("#Code").val("");
            $("#Short").val("");
            $("#Description").val("");
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
    if ($.trim($("#Short").val()) == "") {
        alert("Short can't be null");
        $("#Short").focus();
        return false;
    }
    var chk = $("#chkActive").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Unit/DataController.ashx?Option=update&chkActive=" + chk }, function(data) {
        var json = typeof (data) == "object" ? data : $.parseJSON(data);
        if (json[0].Option == "true") {
            if (Request("control") != "") {
                //window.parent.UserComboBox1.getStore().reload();
                //window.parent.Window1.hide();
                window.parent.ChildCallBack(Request("control"), $("#Code").val());
            }
            else {
                alert("saved successful");
                $("#Code").focus();
            }
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
    $("#Short").val("");
    $("#Description").val("");
    $("#chkActive").attr("checked", false);
    $("#Code").focus();
}

var rowclickFn = function(grid, rowIndex, columnIndex, e) {
    //    var record = grid.getStore().getAt(rowIndex);   //Get the Record
    //    var fieldName = grid.getColumnModel().getDataIndex(columnIndex); //Get field name
    //    var data = record.get(fieldName);
    var record = grid.getStore().getAt(rowIndex);

    $("#hidRowID").val(record.json.RowID);
    $("#Code").val(record.json.Code);
    $("#Short").val(record.json.Short == null ? "" : record.json.Short);
    $("#Description").val(record.json.Description == null ? "" : record.json.Description);
    if (record.json.Active == true) {
        $("#chkActive").attr("checked", true);
    }
    else {
        $("#chkActive").attr("checked", false);
    }

}