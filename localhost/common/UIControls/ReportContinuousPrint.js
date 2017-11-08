var lotNo = "";

$(function() {

    AppendList();
    //CheckItem();

    var tip = "<div id='tip_msg' style=\"position:absolute;z-index:9999;border:solid 1px #cdcdcd;font-size:11px;padding:5px 10px;top:38%;left:40%;background-color:#fff;color:#000;display:none;\">The data has been submitted, please wait...</div>";
    $("body").append(tip);

    $("#chkAll,.chkAll").click(function() {

        if ($(this).attr("checked") == true) {
            SelectAll(true);
            $("#chkAll").attr("checked", "checked");
        }
        else {
            SelectAll(false);
            $("#chkAll").attr("checked", "");
        }
    })

    $("#chkItem").click(function() {
        SelectItem();
    })

    ///全选行
    $(".td_line .chkline").click(function() {
        if ($(this).attr("checked") == true)
            $(this).parent("td").parent("tr").find("input").attr("checked", "checked");
        else
            $(this).parent("td").parent("tr").find("input").attr("checked", "");

    })

    ///全选列
    $(".tr_header td").each(function(i) {
        $(this).children("input").click(function() {
            if ($(this).attr("checked") == true) {
                $(".tr_line").each(function() {
                    $(this).children("td").eq(i).find("input").attr("checked", "checked");
                })
            }
            else {
                $(".tr_line").each(function() {
                    $(this).children("td").eq(i).find("input").attr("checked", "");
                })
            }
        })
    })

    $("tr.tr_line").hover(function() {
        $(this).css("background", "#fafafa")
    }, function() {
        $(this).css("background", "#fff")
    })



    $("div.div_all_print").click(function() {

        lotNo = $("#txtLotNo").html();
        var obj = window.parent.div_parent_content;
        var seed = $("#hidID").val();
        //SetStyle(obj, "/common/uicontrols/ReportContinuousPrint.aspx?id=" + seed + "&sysType=" + sysType);
        SetStyle("Lot Printing (Lot# " + lotNo + ")", 860, 250, "Form", "/common/uicontrols/ReportContinuousPrint.aspx?id=" + seed + "&sysType=" + sysType);
    })

    ///检测打印机后，继续执行    
    $("#btnContinue").click(function() {

        var param = $("#hidParm").val();
        $("#div_confirm").hide();
        $("#tip_msg").html("<img src='/common/UIControls/img_report/S_041.gif' style='vertical-align: middle;margin:0 5px 3px 0;' />Print is processing...").hide();
        Tip_Msg_Position();

        $.post("/common/uicontrols/ReportContinuousPrint.ashx", { param: param, sys: Request("sysType"), Seed: Request("ID"), printType: "PRINT", option: "select" }, function(data) {

            setTimeout(HideTip, 0);
        })
    })

    ///检测打印机后，取消执行
    $("#btnCancel").click(function() {
        $("#div_confirm").hide();
        setTimeout(HideTip, 0);
    })

})




///创建动态层
function AppendList() {
    var obj = window.parent.div_print_msg;
    if (obj == undefined || obj == null) {

        var div3 = document.createElement("div");
        div3.setAttribute("id", "div_print_msg");
        div3.setAttribute("style", "position:fixed; z-index:99999;bottom:-50px;right:0px;border:solid 3px #eef5fd;background:#fff;padding:12px;");
        window.parent.form1.appendChild(div3);

        var div2 = document.createElement("script");
        div2.setAttribute("type", "text/javascript");
        div2.setAttribute("src", "/common/UIControls/ReportContinuousPrint.js?v=" + new Date().toString());
        window.parent.form1.appendChild(div2);
    }
}


///设置样式
function SetStyle(obj, url) {

    var show = window.parent.div_parent_show;
    show.style.display = 'block';
    show.style.height = window.parent.document.documentElement.scrollHeight;
    var left = (parseInt(window.parent.document.body.clientWidth) - parseInt(obj.style.width == "" ? 0 : obj.style.width)) / 2;
    var top = (parseInt(window.parent.document.documentElement.clientHeight) - parseInt(obj.style.height)) / 2;
    obj.style.display = 'block';
    obj.style.left = left + "px";
    obj.style.top = "2%";
    var strcontent = "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style='width:100%;height:100%'><tr><td style='height:18px;'><p   onmousedown='window.parent.startDrag(this)' onmouseup='window.parent.stopDrag(this)' onmousemove='window.parent.drag(this)'  style='line-height:20px;height:18px;color: #1542AF;font: bold 11px tahoma,arial,verdana;cursor:move'>";
    strcontent += "<span style='float:left'>Lot Printing (Lot# " + lotNo + ")</span><span style='float:right;background-image:url(\"/images/close_01.jpg\");width:57px;height: 15px;cursor: pointer;' onclick=\"document.getElementById('div_parent_show').style.display='none';document.getElementById('div_parent_content').style.display='none';\">";
    strcontent += "</span></p></td></tr><tr><td id='td_content'style='vertical-align:top; height:100%; border:solid 1px #B3C4DA;'><iframe frameborder='0' scrolling='auto' height='100%' width='100%' style='background-color:#fff;height:100%;' src='" + url + "'></iframe></td></tr></table>";
    obj.innerHTML = strcontent;
}

///提示对话框
function Tip_Msg_Position() {
    var tip_width = $("#tip_msg").width();
    var left = ($(document).width() - tip_width) / 2;
    $("#tip_msg").css({ left: left }).show();
}


///选中被打印过的项
function CheckItem() {

    $.getJSON("/common/uicontrols/ReportContinuousPrint.ashx?option=checkItem&Seed=" + Request("ID"), function(data) {

        if (data != null) {
            $.each(data, function(i, item) {
                $("#" + item.ChkBoxID).attr("checked", "checked");
            })
        }
    })
}

var sec = 0;
var secDate;
function getDate() {

    ++sec;
    secDate = setTimeout(getDate, 1000);

}

 


///获取选择的报表，并且传入后台处理
function PrintAll(printType) {
    sec = 0;
    getDate();
    var start = new Date();
    $("#btnPrint,#btnPdf").blur();

    var checkedCount = $(".table_grid input[type='checkbox']:checked").size();
    if (checkedCount <= 0) {
        $("#tip_msg").html("<span style='color:red'>Please select the items you need to print. </span>").hide();
        Tip_Msg_Position();
        $("#win_show").height($(document).height()).fadeIn(10)
        $("#win_show,#tip_msg").show();
        setTimeout(HideTip, 2000);
        return;
    }

    $("#win_show").height($(document).height()).fadeIn("fast")
    //$("#win_show").show();
    $("#tip_msg").html("<img src='/common/UIControls/img_report/S_041.gif' style='vertical-align: middle;margin:0 5px 3px 0;' />The data has been submitted, please wait...").hide();
    Tip_Msg_Position();

    var param = "";
    var obj = $(".table_grid input[type='checkbox']:checked");
    var length = obj.size();
    for (var i = 0; i < length; ++i) {
        param += obj.eq(i).attr("id") + "|";
    }

    $("#hidParm").val(param);

    ///更新打印列表
    $.post("/common/uicontrols/ReportContinuousPrint.ashx", { param: param, sys: Request("sysType"), Seed: Request("ID"), option: "update" }, function(data) {

        if (data == "True") {

            ///检查打印机
            $.post("/common/uicontrols/ReportContinuousPrint.ashx", { param: param, sys: Request("sysType"), Seed: Request("ID"), printType: printType, option: "checkPrint" }, function(data) {

                ///一切OK 继续执行
                if (data == "True") {
                    $("#tip_msg").html("<img src='/common/UIControls/img_report/S_041.gif' style='vertical-align: middle;margin:0 5px 3px 0;' />Print is processing...").hide();
                    Tip_Msg_Position();

                    $.post("/common/uicontrols/ReportContinuousPrint.ashx", { param: param, sys: Request("sysType"), Seed: Request("ID"), printType: printType, option: "select" }, function(data) {

                        clearTimeout(secDate);
                        setTimeout(HideTip, 0);

                        var msg = "";
                        //if (printType == "PDF") { msg = "Email has been sent, a total of " + data + " files were generated, took " + sec + " seconds."; }
                        //else { msg = "Batch printing has completed, a total of " + data + " files printed, took " + sec + " seconds."; }

                        if (printType == "PDF") { msg = "邮件已发送，共生成 " + data + " 份文件，耗时 " + sec + " 秒。"; }
                        else { msg = "打印已完成，共打印 " + data + " 份文件，耗时 " + sec + " 秒。"; }

                        //                        window.parent.div_print_msg.innerHTML = msg;

                        //                        window.parent.div_print_msg.style.display = "block";

                        //                        setTimeout(function() { window.parent.div_print_msg.style.display = "none"; }, 5000);

                        window.parent.div_print_msg.innerHTML = msg;
                        var height = parseFloat(window.parent.div_print_msg.offsetHeight);

                        var show = function() {

                            window.parent.div_print_msg.style.bottom = 0;

                        }
                        var hide = function() {

                            window.parent.div_print_msg.style.bottom = "-" + height + "px";

                        }
                        function send() {
                            show();
                            setTimeout(hide, 5000);
                        }

                        send();

                    })
                }
                ///打印机异常，提示对话框
                else {
                    ///显示对话框
                    var top = ($(window).height() - $("#div_confirm").height()) / 2;
                    top = top - top * 0.2;
                    $("#tip_msg").hide();
                    $("#div_confirm").css("top", top).show().find("div.div_confirm_content").html("'" + data + "' did not set the default printer, continue? ");
                }
            })

        }
        else {
            $("#tip_msg").html("<span style='color:red'>The abnormal data, submit failed. </span>").hide();
            Tip_Msg_Position();
            setTimeout(HideTip, 3000);
        }

    })
}


///影藏关闭Tip
function HideTip() {
    $("#win_show,#tip_msg").hide();
}


///checkbox全选
function SelectAll(b) {
    if (b) {
        $(".table_grid input[type='checkbox']").attr("checked", "checked");
        $("#labAll").html("Unselect");
        $("#chkHBL,#chkSbs,#chkDraft").attr("checked", "checked");
    }
    else {
        $(".table_grid input[type='checkbox']").attr("checked", "");
        $("#labAll").html("Select All");
        $("#chkHBL,#chkSbs,#chkDraft").attr("checked", "");
    }
    $("#chkItem").attr("checked", "");
}

///checkbox反选
function SelectItem(b) {

    var obj = $(".table_grid input[type='checkbox']:checked");
    $(".table_grid input[type='checkbox']").attr("checked", "checked");
    $(".tr_header input[type='checkbox']").attr("checked", "");
    $(".td_line input").attr("checked", "");
    for (var i = 0; i < obj.size(); ++i) {
        obj.eq(i).attr("checked", "");
    }
}


///——————— 获取指定的URL参数值———————
///  var str =Request(ss);
function Request(paramName) {
    paramValue = "";
    isFound = false;
    if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=") > 1) {
        arrSource = unescape(this.location.search).substring(1, this.location.search.length).split("&");
        i = 0;
        while (i < arrSource.length && !isFound) {
            if (arrSource[i].indexOf("=") > 0) {
                if (arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase()) {
                    paramValue = arrSource[i].split("=")[1];
                    isFound = true;
                }
            }
            i++;
        }
    }
    return paramValue;
}
///———————————end —————————