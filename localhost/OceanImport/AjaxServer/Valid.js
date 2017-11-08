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
    else {
        $.get("/OceanImport/AjaxServer/Handler.ashx?sys=OI&name=" + value + "&type=" + type + "&id=" + idValue, function(data) {
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