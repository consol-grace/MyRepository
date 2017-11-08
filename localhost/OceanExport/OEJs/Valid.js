function validName(obj, obj1) {
    var value = $("#" + obj).val();
    var oldname = $("#hidHawb").val();
    var idValue = ($("#" + obj1).val() == "" ? "0" : $("#" + obj1).val());
   
    $.get("/OceanExport/OEShipment/Handler.ashx?oldname=" + oldname + "&name=" + value + "&id=" + idValue, function(data) {
        if (data == "S") {
            $("#" + obj).addClass("bottom_line");
            $("#" + obj).attr("validata", "false");
            $("#" + obj).attr("title", "Can change the discharge port code on the auto-generated HBL only.");
            $("#div_bottom").html("<p class=\"error\">Status:Can change the discharge port code on the auto-generated HBL only.</p>");
            getSelectPos(obj);
        }
        else if (data == "Y") {
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


function validMBL(obj, type, id) {
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
        $.get("/OceanImport/AjaxServer/Handler.ashx?sys=OE&name=" + value + "&type=" + type + "&id=" + idValue, function(data) {
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