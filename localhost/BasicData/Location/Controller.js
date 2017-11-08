/// <reference path="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" />
/// <reference path="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" />
/// <reference path="../../common/ylQuery/ylQuery.js" />

$(document).ready(function() {
    $("#Code").focus();
});

function validName(obj,sys,id) {
    var code1 = $("#" + obj).val();
    var code = code1.replace(" ", "")
    var idValue = (id == "" ? "0" : id);
    if (code == "") {
        $("#" + obj).removeClass("bottom_line");
        $("#" + obj).removeAttr("title");
    }
    else {
        $.get("/BasicData/Location/DataController.ashx?name=" + code + "&sys=" + sys + "&id=" + idValue, function(data) {
            if (data == "Y") {
                $("#" + obj).addClass("bottom_line");
                $("#" + obj).attr("title", code1 + " already exists .");
                $("#" + obj).focus();
            }
            else {
                $("#" + obj).removeClass("bottom_line");
                $("#" + obj).removeAttr("title");
            }
        })
    }
    
}

