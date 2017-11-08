$(function() {

    var scrollTop = 0;
    $(window).scroll(function() {

        //scrollTop = document.documentElement.scrollTop;
    })


    if (isload == "True") {
        $("#txt_seed").val(Request("seed"));
        if ($("#txt_seed").val() != "")
            list($("#txt_seed").val());
    }

    $(".btn_sheet").click(function() {

        $("#txtSheetNO").val("");
        $("#txtPKG").val("");
        $("#div_offical").hide();  /////

        var seed = 0;
        if ($(this).attr("M") == undefined) {
            seed = $(this).attr("H");
            $("#txt_type").val("H");
        }
        else {
            seed = $(this).attr("M");
            $("#txt_type").val("M");
        }

        $("#txt_seed").val(seed);
        list(seed);
        var width = ($(window.document).width() - $("#div_sheet").width()) / 2;
        var height

        $("#win_show").height($(document).height()).fadeIn("fast").click(function() { SheetClose(); });
        $("#div_sheet").css({ left: width }).fadeIn("fast");
        $("#txtSheetNO").focus();
    })


    $("#win_close_sheet").click(function() {
        SheetClose();
    })
    LoadWidth();


})


var edit = 0;

function SheetClose() {
    $("#txtSheetNO").val("");
    $("#txtPKG").val("");
    $("#win_show").fadeOut("fast");
    $("#div_sheet").fadeOut("fast");
    if (edit == 1) {
        this.location.reload();
    }
}


function list(seed) {

    $("#tab_Replist tr").remove();
    var str = "";

    $.getJSON("/common/uicontrols/UserSheet.ashx?type=list&seed=" + seed, function(data) {
        $.each(data, function(i, n) {
            str += "<tr style='font-family: Verdana; font-size: 10px !important;'><td style='display:none'>" + n.rowid + "</td><td class='td_Sheet' style=\"width:90px\">" + n.SheetNo + "</td><td  class='td_pkg' width='50px'>" + n.Pkg + "</td><td  class='td_receive' style=\"width:70px\">" + n.Receive + "</td>"
            + "<td  class='td_Action' style=\"width:70px\"><div id='div_edit" + i + "'><a href='javascript:void(0);' onclick=\"Edit('" + n.rowid + "','" + i + "')\">编辑</a> <a>|</a> <a href='javascript:void(0);' onclick='Delete(" + n.rowid + ");'>删除</a></div>"
            + "<div id='div_save" + i + "' style='display:none'><a href='javascript:void(0);' onclick=\"Save('" + n.rowid + "','" + i + "')\">保存</a> <a>|</a> <a href='javascript:void(0);' onclick=\"Cancel('" + i + "')\">取消</a></div></td></tr>";
        })
        $("#tab_Replist").append(str);

        LoadWidth();

    })
}


function Insert() {
    var toM = 0;
    var toH = 0;
    if ($("#txt_type").val() == "M")
        toM = 1;
    else
        toH = 1;
    var seed = $("#txt_seed").val();

    $.get("/common/uicontrols/UserSheet.ashx?type=update&sysType=" + sysType + "&seed=" + seed + "&rowid=0&H=" + toH + "&M=" + toM + "&SheetNo=" + $("#txtSheetNO").val() + "&Pkg=" + $("#txtPKG").val() + "&received=0&recedate=", function(data) {

        if (data == "Y") {
            $("#txtSheetNO").val("").focus();
            $("#txtPKG").val("");
            edit = 1;
            list(seed);
        }
        else
            Ext.Msg.alert("Status", "Error , Please checked the data .", function() {
                $("#txtSheetNO").val("").focus();
            });
    })
}

///rowid ,  当前行号
function Edit(rowid, currindex) {

    Cancel($("#txt_eIndex").val());

    $("#div_edit" + currindex).hide();
    $("#div_save" + currindex).show();

    var sheet = $("#tab_Replist tr").eq(currindex).children("td").eq(1).text();
    var pkg = $("#tab_Replist tr").eq(currindex).children("td").eq(2).text();
    var date = $("#tab_Replist tr").eq(currindex).children("td").eq(3).text();


    $("#txt_eSheet").val(sheet);
    $("#txt_ePkg").val(pkg);
    $("#txt_eIndex").val(currindex);
    $("#txt_eDate").val(date);

    //if (date != undefined && date != null && date != "") {
    $("#tab_Replist tr").eq(currindex).children("td").eq(3).html("<input type='text' value='" + date + "' id='txt_d" + currindex + "' style='width:65px'  onfocus=\"txtfocus(this);\"   onblur=\"CheckDate('" + currindex + "');txtblur(this);\"  onkeypress=\"keyDate(event,'" + currindex + "');\" />");
    //}

    $("#tab_Replist tr").eq(currindex).children("td").eq(1).html("<input type='text' value='" + sheet + "' id='txt_s" + currindex + "' style='width:85px'   onfocus=\"txtfocus(this);\"  onblur=\"txtblur(this);\"  />");
    $("#tab_Replist tr").eq(currindex).children("td").eq(2).html("<input type='text' value='" + pkg + "' id='txt_p" + currindex + "' style='width:45px'    onfocus=\"txtfocus(this);\"  onblur=\"txtblur(this);\"  />");

    $("#txt_s" + currindex).focus().select();

}


///rowid ,  当前行号
function Save(rowid, currindex) {
    var seed = $("#txt_seed").val();
    var IsReceived = 0;
    var sheet = $("#txt_s" + currindex).val().toUpperCase();
    var pkg = $("#txt_p" + currindex).val();
    var Date = $("#txt_d" + currindex).val();
    if (Date != "" && Date != null && Date != undefined)
        var IsReceived = 1;
    else {
        Date = "";
    }
    $.get("/common/uicontrols/UserSheet.ashx?type=update&rowid=" + rowid + "&SheetNo=" + sheet + "&Pkg=" + pkg + "&recedate=" + Date + "&received=" + IsReceived, function(data) {

        if (data == "Y") {

            edit = 1;
            $("#txt_eSheet").val(sheet);
            $("#txt_ePkg").val(pkg);
            $("#txt_eIndex").val(currindex);
            $("#txt_eDate").val(Date);
            list(seed);
        }
        else
            Ext.Msg.alert("Status", "Error , Please checked the data .", function() {
                $("#txt_s" + currindex).focus().select();
            });
    })

}


///取消
function Cancel(currindex) {

    var sheet = $("#txt_eSheet").val();
    var pkg = $("#txt_ePkg").val();
    var date = $("#txt_eDate").val();

    var rowid = $("#tab_Replist tr").eq(currindex).children("td").eq(0).html();


    $("#div_edit" + currindex).show();
    $("#div_save" + currindex).hide();

    if (date != undefined && date != null && date != "") {
        $("#tab_Replist tr").eq(currindex).children("td").eq(3).html(date);
    }
    else {
        $("#tab_Replist tr").eq(currindex).children("td").eq(3).html("<input type=\"checkbox\" class=\"chk_rece\" onclick=\"CheckReceive('" + rowid + "','" + currindex + "')\" />");
    }
    $("#tab_Replist tr").eq(currindex).children("td").eq(1).html(sheet);
    $("#tab_Replist tr").eq(currindex).children("td").eq(2).html(pkg);

}

///删除
function Delete(rowid) {
    edit = 1;
    var seed = $("#txt_seed").val();

    Ext.Msg.confirm("Status", "Are you sure you want to delete ? ", function(btn) {
        if (btn == "yes") {
            $.get("/common/uicontrols/UserSheet.ashx?type=delete&rowid=" + rowid, function(data) {

                if (data == "Y") {
                    list(seed);
                }
                else
                    Ext.Msg.alert("Status", "Error , Please checked the data .");
            })
        }
    })
}


function CheckReceive(rowid, currindex) {

    var sheet = $("#tab_Replist tr").eq(currindex).children("td").eq(1).text();
    var pkg = $("#tab_Replist tr").eq(currindex).children("td").eq(2).text();

    if (sheet == "")
        sheet = $("#tab_Replist tr").eq(currindex).children("td").eq(1).find("input").val();
    if (pkg == "")
        pkg = $("#tab_Replist tr").eq(currindex).children("td").eq(2).find("input").val();

    $.get("/common/uicontrols/UserSheet.ashx?type=CheckReceive&rowid=" + rowid + "&SheetNo=" + sheet + "&Pkg=" + pkg, function(data) {

        if (data != "Y")
            list($("#txt_seed").val());
        else
            Ext.Msg.alert("Status", "Error , Please checked the data .");
    })
}



function txtfocus(obj) {
    $(obj).addClass("hover");
}

function txtblur(obj) {
    $(obj).removeClass("hover");
}


function keyDate(event, currindex) {

    event = event || window.event;
    if (event.keyCode >= 48 && event.keyCode <= 57) {
        var dd = $("#txt_d" + currindex).val();

        if (dd.length < 10) {
            if (dd.length == 2 || dd.length == 5) {
                $("#txt_d" + currindex).val($("#txt_d" + currindex).val() + "/");
            }
        }
        else {
            event.returnValue = false;
        }
    }
    else {
        event.returnValue = false;
    }
}

function CheckDate(currindex) {

    var value;
    var date = new Date();
    var yy = date.getFullYear();
    var mm = date.getMonth() + 1;
    var dd = date.getDate();
    if (mm < 10)
        mm = "0" + mm;
    if (dd < 10)
        dd = "0" + dd;

    var d = $.trim($("#txt_d" + currindex).val());

    var adate = d.split("/");
    var len = adate.length;
    if (len == 1) {
        if (adate[0] == null || adate[0] == undefined || adate[0] == "")
            value = "";
        else
            value = yy + "/" + mm + "/" + adate[0];
    }
    else if (len == 2) {
        if (adate[1] == null || adate[1] == undefined || adate[1] == "")
            value = yy + "/" + mm + "/" + adate[0];
        else
            value = yy + "/" + adate[1] + "/" + adate[0];
    }
    else {
        if (adate[2] == null || adate[2] == undefined || adate[2] == "" || adate[2].length != 4)
            value = yy + "/" + adate[1] + "/" + adate[0];
        else
            value = adate[2] + "/" + adate[1] + "/" + adate[0];
    }

    if (value != "") {
        var sdate = new Date(value);

        var ndate = sdate.format("Y/m/d").split("/");
        value = ndate[2] + "/" + ndate[1] + "/" + ndate[0];
    }
    $("#txt_d" + currindex).val(value);
}


function LoadWidth() {

    //var width = $(".tab_sheet").width();
    //var sheet = width - 210;
    //$("td.td_Sheet").width(sheet);
}
