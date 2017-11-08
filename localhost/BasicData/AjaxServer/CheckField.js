
function checkCode(type, obj, rowid) {

    $("#" + obj).focus(function() {

        $(this).removeClass("bottom_line").attr("validata", "true").removeAttr("title");
        return;

    })

    if ($("#" + obj).val() == "") {
        $(this).removeClass("bottom_line").attr("validata", "true").removeAttr("title");
        TipMsg("<p class=\"\">Status : New  " + type.toLowerCase() + " record. </p>") 
        //修改时间2014-09-19 Grace 用于解决code为空的时候还是会报code已经存在这个错误..
        return;
    }
    
    
    var option = "type=" + type + "&sys=" + Request('sys') + "&code=" + escape($("#" + obj).val()) + "&rowid=" + rowid + "&desCode=" + escape($("#txtCode").val());
    $.get("/BasicData/AjaxServer/CheckField.ashx?" + option, function(data) {

        //alert(data)
        if (data == "N") {
            $("#" + obj).attr("validata", "false").addClass("bottom_line").attr("title", "The code already exists .");
            if (type == "ITEMDESC" || type == "LOCDESC")
                TipMsg("<p class=\"error\">Status : The description already exists . </p>");
            else
                TipMsg("<p class=\"error\">Status : The code already exists . </p>");
                
            return;
        }
        else {
            if (rowid != "" && rowid != 0) {
                if (type == "ITEMDESC")
                    TipMsg("<p class=\"\">Status : Edit the record  of <span>" + $("#txtCode").val().toUpperCase() + "</span>. </p>")
                else if(type=="LOCDESC")
                    TipMsg("<p class=\"\">Status : Edit the record  of <span>" + $("#Code").val().toUpperCase() + "</span>. </p>")                
                else
                    TipMsg("<p class=\"\">Status : Edit the record  of <span>" + $("#" + obj).val().toUpperCase() + "</span>. </p>")
            }
            else {
                if (type == "ITEMDESC")
                    type = "ITEM";
                else if (type == "LOCDESC")
                    type = "Location";
                TipMsg("<p class=\"\">Status : New  " + type.toLowerCase() + " record. </p>")
            }
            $("#" + obj).removeClass("bottom_line").attr("validata", "true").removeAttr("title");
            //TipMsg("<p class=\"success\">Status : This code can be used . </p>")
        }
        
         if(type=="COMPANY"){
            CheckInputLen(false);
         }
    })
}


function removeClass(obj) {

    if ($("#" + obj).val() == '') {
        $("#" + obj).removeClass("bottom_line").attr("validata", "true").removeAttr("title");
    }
}

function removeLine(obj) {
    $("#" + obj).removeClass("bottom_line").attr("validata", "true").removeAttr("title");
}


function Validata(obj) {

    if ($("#" + obj).attr("validata") == "false") {
        //$("#" + obj).focus().select();
        return false;
    }
    else
        return true;

}


//错误提示
function TipMsg(msg) {

    $("#div_bottom").html(msg);

}

function checkInputValue(obj) {
    var check = $("#" + obj).val();
    if (/^[A-Za-z0-9/]+$/.test(check) == false && check != "") {
        //alert('The input can\'t contain special characters\r\n "');
        Ext.Msg.alert('status', 'The input is only English and numbers!', function() { getSelectPos(obj); });

    }
}