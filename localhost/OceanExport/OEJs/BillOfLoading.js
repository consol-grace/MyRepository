function ReturnNull() {
    GetLineData();
    return true;
}

function TotalPPCC(obj) {
    var total = 0;
    if (obj == "PP") {
        for (var i = 1; i < 11; i++) {
            if ($("#txtPre" + i).val() != "" && $("#txtPre" + i).val() != undefined) {
                total += Number($("#txtPre" + i).val());
            }
        }
        if (total == 0) {
            $("#txtCharge1").val("");
        }
        else {
            $("#txtCharge1").val(Number(total).toFixed(2));
        }
    }
    if (obj == "CC") {
        for (var i = 1; i < 11; i++) {
            if ($("#txtCol" + i).val() != "" && $("#txtCol" + i).val() != undefined) {
                total += Number($("#txtCol" + i).val());
            }
        }
        if (total == 0) {
            $("#txtCharge2").val("");
        }
        else {
            $("#txtCharge2").val(Number(total).toFixed(2));
        }
    }
}
function SetBLCount(event) {
    if ((event.keyCode == 9) || (event.keyCode == 8)||(event.keyCode==46) || (event.keyCode > 47 && event.keyCode < 58) || (event.keyCode > 95 && event.keyCode < 106)) {
        return true;
    }
    else {
        $("#txtOrignBL1").val($("#txtOrignBL").val());
        getSelectPos("txtOrignBL1");
        return false;
    }
}

function GetBLCount() {
    var blcount = $("#txtOrignBL1").val();
    if (!isNaN(blcount)) {
        $("#txtOrignBL").val($("#txtOrignBL1").val());
        CompanyX.SetBLCount();
    }
}

function KeyNumber(event, obj) {
    event = event || window.event;
    if ((event.keyCode == 190)||(event.keyCode == 110) || (event.keyCode == 9) || (event.keyCode == 8) || (event.keyCode == 46) || (event.keyCode > 47 && event.keyCode < 58) || (event.keyCode > 95 && event.keyCode < 106)) {
        return true;
    }
    else {
        $("#" + obj).val($("#" + obj).val().substr(0, $("#" + obj).val().length-1));
        return false;
    }
}

var preEvent = function() {
    txtService1.focus(true);
}
var backEvent = function() {
    txtPre10.focus(true);
}
var backEvent1 = function() {
    txtCol10.focus(true);
}
function KeyNumberListener(event, obj) {
   event = event || window.event;
   if(obj=="txtCol10")
   {
     if(event.keyCode==9&&!event.shiftKey) {
         if (window.addEventListener) {
             //document.getElementById(obj).removeEventListener("blur", backEvent, false);
             document.getElementById(obj).removeEventListener("blur", preEvent, false);
             document.getElementById(obj).addEventListener("blur",preEvent, false);   
         }
         else {
             //document.getElementById(obj).detachEvent("onblur", backEvent);
             document.getElementById(obj).detachEvent("onblur", preEvent);
             document.getElementById(obj).attachEvent("onblur",preEvent);
         }  
       
     }
     if (event.keyCode == 9 && event.shiftKey) {
         if (window.addEventListener) {
             document.getElementById(obj).removeEventListener("blur", preEvent, false);
             //document.getElementById(obj).removeEventListener("blur", backEvent, false);
             //document.getElementById(obj).addEventListener("blur",backEvent, false);
         }
         else {
             document.getElementById(obj).detachEvent("onblur", preEvent);
             //document.getElementById(obj).detachEvent("onblur", backEvent);
             //document.getElementById(obj).attachEvent("onblur", backEvent);
         }  
       
     }
 }

// if (obj == "txtService1") {
//     if (event.keyCode == 9 && !event.shiftKey) {
//         if (window.addEventListener) {
//             document.getElementById(obj).removeEventListener("blur", backEvent1, false);
//         }
//         else {
//             document.getElementById(obj).detachEvent("onblur", backEvent1);
//         }

//     }
//     if (event.keyCode == 9 && event.shiftKey) {

//         if (window.addEventListener) {
//             document.getElementById(obj).removeEventListener("blur", backEvent1, false);
//             document.getElementById(obj).addEventListener("blur", backEvent1, false);
//         }
//         else {
//             document.getElementById(obj).detachEvent("onblur", backEvent1);
//             document.getElementById(obj).attachEvent("onblur", backEvent1);
//         }  
//     }
// }  
}

function KeyNumberLeave(obj, number) {
    var num=2;
    if (obj == "txtGW") {
        if ($("#hidDigits").val() == "1") {
            num = 3;
        }
    }
    else {
        num = number;
    }
    var value = $("#" + obj).val();
    if (value == "") {
        $("#" + obj).val("");
    }
    else {
        if (!isNaN(value)) {
            $("#" + obj).val(Number(value).toFixed(num));
        }
        else {
            $("#" + obj).val("");
        }
    }
}

//05/14
function GetLineData() {
    //M
    var getMLine = 12;
    var makeMLine = Number($("#hidMakeMLine").val());
    var j = 5 + makeMLine;
    for (var i = j; i < 17; i++) {
        if ($("#txtMarks" + i).val() != "" && $("#txtMarks" + i).val() != undefined) {
            getMLine = i - 5;
            break;
        }
    }

    //P
    var getPLine = 11;
    var makePLine = Number($("#hidMakePLine").val());
    var m = 5 + makePLine;
    for (var i = m; i < 20; i++) {
        if ($("#txtPKGS" + i).val() != "" && $("#txtPKGS" + i).val() != undefined) {
            getPLine = i - 9;
            break;
        }
    }
    
    //D
    var getDLine = 12;
    var makeDLine = Number($("#hidMakeDLine").val());
    var n = 3 + makeDLine;
    for (var i = n; i < 18; i++) {
        if ($("#txtDes" + i).val() != "" && $("#txtDes" + i).val() != undefined) {
            getDLine = i - 5;
            break;
        }
    }
    $("#hidMLine").val(getMLine);
    $("#hidPLine").val(getPLine);
    $("#hidDLine").val(getDLine);
}

//05/14
function SetLineData() {
    var makeMLine = Number($("#hidMakeMLine").val());
    var makePLine = Number($("#hidMakePLine").val());
    var makeDLine = Number($("#hidMakeDLine").val());
   
//  for (var i = 5; i < 5+makeMLine; i++) {
//      $("#txtMarks" + i).attr("disabled", true);
//  }
//  for (var i = 5; i < 5 + makePLine; i++) {
//      $("#txtPKGS" + i).attr("disabled", true);
//  }
//  for (var i = 1; i < 3 + makeDLine; i++) {
//      $("#txtDes" + i).attr("disabled", true);
    //  }
    var make = 1;
    if (Number(makeMLine) > Number(makePLine)) {
        make = makeMLine;
        if (Number(makeMLine) > (Number(makeDLine)-2)) {
            make = Number(makeMLine)+5;
        }
        else {
            make = Number(makeDLine)+3;
          }
    }
    else {
        make = makePLine;
        if (Number(makePLine) > (Number(makeDLine) - 2)) {
            make = Number(makePLine)+5;
        }
        else {
            make = Number(makeDLine)+3;
        }
    }

//    for (var i = 1; i < 21; i++) {
//        $("#txtMarks" + i).attr("disabled", false);
//    }
//    for (var i = 1; i < 21; i++) {
//        $("#txtPKGS" + i).attr("disabled", false);
//    }
//    for (var i = 1; i < 21; i++) {
//        $("#txtDes" + i).attr("disabled", false);
//    }
//    
//    for (var i = 1; i < make; i++) {
//        $("#txtMarks" + i).attr("disabled", true);
//    }
//    for (var i = 1; i < make; i++) {
//        $("#txtPKGS" + i).attr("disabled", true);
//    }
//    for (var i = 1; i < make; i++) {
//        $("#txtDes" + i).attr("disabled", true);
//    }

  $("#txtGW").attr("disabled", true);
  $("#txtMea").attr("disabled", true);
  $("#txtMarks20").attr("disabled", true);
  //$("#txtDes19").attr("disabled", true);
  //$("#txtDes20").attr("disabled", true);
  //$("#txtDes21").attr("disabled", true);
}

function SelectItem(obj, obj1) {
    ////&&$.browser.msie&&$.browser.version=="9.0"
   
    var value = $("#" + obj).val();
//    var record = StoreLocation.getById(value);
//    if (record != null && record != undefined) {
    //        $("#" + obj1).val(record.data.text);
//    }
    CompanyX.SetLocationItem(value,obj);
}