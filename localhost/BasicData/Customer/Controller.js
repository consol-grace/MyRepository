/// <reference path="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" />
/// <reference path="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" />
/// <reference path="../../common/ylQuery/ylQuery.js" />

var rowclickFn = function(grid, rowIndex, columnIndex, e) {
    //    var record = grid.getStore().getAt(rowIndex);   //Get the Record
    //    var fieldName = grid.getColumnModel().getDataIndex(columnIndex); //Get field name
    //    var data = record.get(fieldName);
    var record = grid.getStore().getAt(rowIndex);
    $("#hidRowID").val(record.json.ROWID);
    $("#txtRemark").val(record.json.Remark == null ? "" : record.json.Remark);
    CompanyX.RowSelectStation(record.json.StatList);
    //alert(record.json.StatList);
}

function NextClick() {
    if ($("#Code").val() == "") {
        alert("Code can't be null");
        $("#Code").focus();
        return false;
    }

    var chkAE = $("#chkAE").attr("checked") == true ? "1" : "0";
    var chkOE = $("#chkOE").attr("checked") == true ? "1" : "0";
    var chkAI = $("#chkAI").attr("checked") == true ? "1" : "0";
    var chkOI = $("#chkOI").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Customer/DataController.ashx?Option=update&chkAE=" + chkAE + "&chkOE=" + chkOE + "&chkAI=" + chkAI + "&chkOI=" + chkOI }, function(data) {
        var json = typeof (data) == "object" ? data : $.parseJSON(data);
        if (json[0].Option == "true") {
            $("#hidRowID").val("");
            $("#countryControl").find("input[type=text]").attr("value", "");
            $("#countryControl").find("textarea").attr("value", "");
            alert("saved successful");
            $("#Code").focus();
        }
        else {
            $("#hidRowID").val("");
            $("#Code").val("");
            $("#countryControl").find("input[type=text]").attr("value", "");
            $("#countryControl").find("textarea").attr("value", "");
            alert("saved failed");
            $("#Code").focus();
        }
    });
}

function SaveClick() {
    if ($("#Code").val() == "") {
        alert("Code can't be null");
        $("#Code").focus();
        return false;
    }

    var chkAE = $("#chkAE").attr("checked") == true ? "1" : "0";
    var chkOE = $("#chkOE").attr("checked") == true ? "1" : "0";
    var chkAI = $("#chkAI").attr("checked") == true ? "1" : "0";
    var chkOI = $("#chkOI").attr("checked") == true ? "1" : "0";
    ylQuery.Controller({ form: "countryControl", url: ylQuery.ContextPath + "BasicData/Customer/DataController.ashx?Option=update&chkAE=" + chkAE + "&chkOE=" + chkOE + "&chkAI=" + chkAI + "&chkOI=" + chkOI }, function(data) {
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
    $("#countryControl").find("input[type=text]").attr("value", "");
    $("#countryControl").find("textarea").attr("value", "");
    $("#Code").focus();
}

function Copy(obj) {
    $("#" + obj + "Company").val($("#geCompany").val());
    $("#" + obj + "Address1").val($("#geAddress1").val());
    $("#" + obj + "Address2").val($("#geAddress2").val());
    $("#" + obj + "Address3").val($("#geAddress3").val());
    $("#" + obj + "Address4").val($("#geAddress4").val());
    $("#" + obj + "Contact").val($("#geContact").val());
    $("#" + obj + "Phone").val($("#gePhone").val());
    $("#" + obj + "Fax").val($("#geFax").val());
    $("#" + obj + "Email").val($("#geEmail").val());
    $("#" + obj + "Country").val($("#geCountry").val());
    $("#" + obj + "ZIP").val($("#geZIP").val());
    $("#" + obj + "State").val($("#geState").val());
    if (obj == "bi") {
        $("#biPaymentto").val($("#geCompany").val());
    }

}
function ShowOne(obj) {
    if ($("#chk" + obj).attr("checked") == true) {
        $("#" + obj + "Display").attr("style", "display:block;");
    }
    else {
        $("#" + obj + "Display").attr("style", "display:none;");
    }

    $("#BILLDisplay").attr("style", "display:block;");
    $("#chkBILL").attr("checked", true);
}

var oldValue = new Array();
function checkMaxLen(obj, maxlength, num) {
    if (obj.value.length > maxlength) {
        obj.value = oldValue[num];
    }
    else {
        oldValue[num] = obj.value;
    }
}

function BtnCancel() {
    CancelClick();
    $("#chkall input:checkbox").attr("checked", "")
    $("#div_china,#AEDisplay,#AIDisplay,#OIDisplay,#OEDisplay").hide();
    $("#geAWB").text("");
}

function geAWB(str) {
    $("#geAWB").html(str);
}


function Address(obj) {
    var value = "";
    var str = $("#geCompany").val();
    var str1 = $("#geAddress1").val();
    var str2 = $("#geAddress2").val();
    var str3 = $("#geAddress3").val();
    var str4 = $("#geAddress4").val();

    var str5 = $("#geContact").val();
    var str6 = $("#gePhone").val();
    var str7 = $("#geFax").val();
    var str8 = $("#geMobile").val();
    var str9 = $("#geEmail").val();



    value = str + "</br>" + str1 + "</br>" + str2 + "</br>" + str3 + "</br>" + str4 + "</br>";
    $("#geAWB").html(value.toUpperCase().replace(/\s/g, '&nbsp;'));

    obj = obj.substring(2);
    if (chbBill.checked) {

        $("#bi" + obj).val($("#ge" + obj).val());
        if (obj == "Company") {
            $("#biPaymentto").val($("#geCompany").val());
        }
    }
}


function ReadOnly(id, b) {
    if (b) {
        $("#" + id + " table input").attr("disabled", "disabled");
        $("#biCredit").removeAttr("disabled").css("color", "#777");
    }
    else {
        $("#" + id + " table input").removeAttr("disabled");
        $("#biCredit").removeAttr("disabled").css("color", "#333");
    }
}

function ReadOnlyAll(flag) {
    if (flag == "N")  //NO DATA  LOADING...
    {
        $("body").append("<div id='div_disabled_show' style='width: 100%;height: 100%;background: white;position: absolute;opacity: 0.1;filter:alpha(opacity=10);-moz-opacity:0.1' disabled='disabled'></div>");
        $("#div_disabled_show").height($(window.document).height());
        $("input,img,button,textarea").attr("disabled", "disabled").css("background-color", "#eeeeee");
        $("#button,#button input,textarea").removeAttr("disabled");
    }
    else {
        $("body").append("<div id='div_disabled_show' style='width: 400px;height: 100%;background: white;position: absolute;opacity: 0.1;filter:alpha(opacity=10);-moz-opacity:0.1' disabled='disabled'></div>");
        $("#div_disabled_show").height($(window.document).height());
        $("input:[type='text'],input:[type='checkbox'],img").attr("disabled", "disabled").css("background-color", "#eeeeee");        
    }
}

function ReadOnlyByType(type) {

    type = type.toUpperCase();
    if (type == "AIRLINE" || type == "VESSEL") {
        $("#baseCompany input,#chbBill,#chbChinese,#div_china input,#biCredit,#BILLDisplay input").attr("disabled", "disabled");
        $("#geCompany").removeAttr("disabled");
    }
    else {

        if ($("#chbBill").attr("checked").toString() == "false") {
            $("#BILLDisplay input").removeAttr("disabled");
        }
        else {
            $("#BILLDisplay input").attr("disabled", "disabled");
        }
        $("#baseCompany input,#chbBill,#chbChinese,#biCredit,#div_china input").removeAttr("disabled");
    }

    if (type == "BRANCH" || type == "AG_CL") {
        $("#chkIsSales").removeAttr("disabled");
    }
    else {
        $("#chkIsSales").attr("checked","").attr("disabled", "disabled");
        
    }

    if (hidRowID.getValue() == "0" || hidRowID.getValue() == "" || hidRowID.getValue() == undefined) {
        $("#div_bottom").html("<p class=\"\">Status : New company record. </p>");
    }
    else {
        $("#div_bottom").html("<p class=\"\">Status : Edit the record  of <span>" + hidChageCode.getValue().toUpperCase() + "</span>.</p>");
    }
    $("#Code").removeClass("bottom_line").attr("validata", "true").removeAttr("title");

}



function Address1() {
    //    var value = "";
    //    var str = $("#txtCCompany").val();
    //    var str1 = $("#txtCAddress1").val();
    //    var str2 = $("#txtCAddress2").val();
    //    var str3 = $("#txtCAddress3").val();
    //    var str4 = $("#txtCAddress4").val();

    //    value = str + "</br>" + str1 + "</br>" + str2 + "</br>" + str3 + "</br>" + str4 + "</br>";
    //    $("#cngeAWB").html(value.toUpperCase());
}


///
function CheckInputLen(b) {
    var len = Code.getValue().length;
    var str = 2;
    var type = cmbType.getValue();
    if (type != "" && type != null && type != undefined) {
        if (type == "AIRLINE" && len != 2) {
            str = 2;
        }
        else if (type == "VESSEL" && len != 3) {
            str = 3;
        }
        else if (type == "BRANCH" && len != 7) {
            str = 7;
        }
        else if (type == "AG_CL" && len != 7) {
            str = 7;
        }
        else if (type == "OTHERS" && len != 4) {
          str = 4;
        }
        else if (type == "TK_WH" && len != 5) {
            str = 5;
        }
        else if (type == "CUST" && len != 8) {
            str = 8;
        }
        else {

            var msg = (hidRowID.getValue() == "0" || hidRowID.getValue() == "" || hidRowID.getValue() == undefined) ? "New company record." : "Edit the record  of <span>" + hidChageCode.getValue().toUpperCase() + "</span>.";

            $("#div_bottom").html("<p class=\"\">Status : " + msg + "</p>");
            return;
        }

        var color = b ? "blue" : "red";
        if (b) {
            $("#Code").removeClass("bottom_line").attr("validata", "true").removeAttr("title");
        }
        else {
            $("#Code").attr("validata", "false").addClass("bottom_line").attr("title", "The code length must be " + str + " .");
        }
        $("#div_bottom").html("<p style='color:" + color + "' class=\"\">Status : The code length must be " + str + " .</p>");

    }
}



function ValidSpecialCharacter(obj) {
    var check = event.srcElement.value;
    if (/["\\]/.test(check)) {
        //alert('The input can\'t contain special characters\r\n "');
        Ext.Msg.alert('status', 'The input can\'t contain special characters\r\n " \\ ', function() { getSelectPos(obj); });

    }
}

function getSelectPos(obj) {
    var esrc = document.getElementById(obj);
    if (esrc == null) {
        esrc = event.srcElement;
    }
    var rtextRange = esrc.createTextRange();
    rtextRange.moveStart('character', esrc.value.length);
    rtextRange.collapse(true);
    rtextRange.select();
} 