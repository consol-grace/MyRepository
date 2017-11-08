function validName(obj, type, id) {
    var value1 = $("#" + obj).val();
    var value = value1.replace(" ", "");
    var idValue = (id == "" ? "0" : id);
    if (value == "") {
        $("#" + obj).removeClass("bottom_line");
        $("#" + obj).attr("validata", "true");
        $("#" + obj).removeAttr("title");
        $("#div_bottom").html("<p class=\"success\">Status: The input value is valid .</p>");
    }
    else if (value.length < 10&&type=="MAWB") {
    $("#" + obj).addClass("bottom_line");
    $("#" + obj).attr("validata", "false");
    $("#" + obj).attr("title", "At least 10 numbers is valid .");
    $("#div_bottom").html("<p class=\"error\">Status: At least 10 numbers is valid .</p>");
    getSelectPos(obj);
    }
    else {
        $.get("/AirExport/AEValid/Handler.ashx?name=" + value + "&type=" + type + "&id=" + idValue, function(data) {
            if (data == "Y") {
                $("#" + obj).addClass("bottom_line");
                $("#" + obj).attr("validata", "false");
                $("#" + obj).attr("title", "The input value already exists .");
                $("#div_bottom").html("<p class=\"error\">Status: The input value already exists .</p>");
                getSelectPos(obj);
            }
            else {
                $("#" + obj).removeClass("bottom_line");
                $("#" + obj).attr("validata", "true");
                $("#" + obj).removeAttr("title");
                $("#div_bottom").html("<p class=\"success\">Status: The input value is valid .</p>");
            }
        })
    }
    
}