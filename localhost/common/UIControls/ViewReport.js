var start = new Date().format('Y-m-d H:i:s');
var height = 0;
var tip = "<div id='tip_msg' style=\"position:absolute;z-index:9;border:solid 1px #cdcdcd;font-size:11px;padding:5px 10px;bottom:0;right:0;background-color:#fff;color:#555;\">请等待，正在加载中，已耗时 0 秒</div>";
var isRedirect = 0;  // 是否跳转页面
var format = 5;     // 文件格式
var mode = 1;        // 文件显示方式

$(function() {


    if ($("#LinBtnPrint").attr("disabled") == true) {
        $("#LinBtnPrint").css("cursor", "default");
        $("#report_tools").attr("disabled", "disabled");
        $("#report_tools").find("input").attr("disabled", "disabled");
        $("#report_tools").find("img").removeAttr("onclick").css("cursor", "default");
    }

    start = new Date().format('Y-m-d H:i:s');
    WinAuto();
    $(window).resize(function() {
        WinAuto();
        $("#Contentframe").height(height - 12);
        WinT();
    })
    function WinAuto() {
        //height = $(window).height() - 90;
        height = $(window).height() - $("#div_czw").offset().top - 28;
        $("#div_Contentframe").height(height);
    }

    WinT();
    WinShow();


    $(document.body).focus().keydown(function (event) {
        if (event.keyCode == 39)
            NextPage();
        else if (event.keyCode == 37)
            PrePage();
    })

})

///获取处理生成后的文件
function WinShow() {

    start = new Date().format('Y-m-d H:i:s');
    //$("#Contentframe").hide();
    var _left = ($(window.document).width() - $("#show_contentframe_loading").width()) / 2;
    var _top = ($(window.document).height() - $("#show_contentframe_loading").height()) / 2;

    $("#show_contentframe_loading").css({ top: _top, left: _left });
    $("#show_Contentframe,#show_contentframe_loading").show();

    $("#LinBtnPDF").attr("disabled", "disabled");

    ///报表相关参数
    var nums = $("#ViewReport1_hidNumList").val();
    ///报表间距
    var margin = $("#ViewReport1_hidMargin").val();
    ///是否生成InvoiceNo
    var chkflag = $("#chkFlagDraft").attr("checked");
    //
    var sys = $("#hidsys").val();

    ///原始路径查询参数
    var Query = window.location.search + "&datetime=" + new Date().format('YmdHis') + "&format=" + format + "&CreateMode=" + mode + "&chkflag=" + chkflag + "&sys=" + sys;
 
    RunTime(start);
    $.get("/Common/UIControls/ViewReport.ashx" + Query + "&nums=" + nums + "&margin=" + margin, function(url) {

        $("#show_Contentframe,#show_contentframe_loading").slideUp("slow");

        if (isRedirect == 0) {
            $("#div_Contentframe").html(Preview(url)).show();
            $("#ViewReport1_hidPath").val(url);
            GetPageList();
            MoveAll();
        }
        else {
            isRedirect = 0;
            Redirect(url);
        }
        $("#Contentframe").height(height - 12);
        $("#Contentframe").show();

        $("#LinBtnPDF").removeAttr("disabled");
        $("#div_tool").removeAttr("disabled");
        clearInterval(timeout);
    })
}

///设置DIV大小位置
function WinT() {

    //start = new Date().format('Y-m-d H:i:s');

    var width = $("#div_Contentframe").width() - 10;
    var height = $("#div_Contentframe").height() - 8;
    var offset = $("#div_czw").offset();

    $("#show_Contentframe").css({ width: "998px", height: height + 32, top: offset.top, left: offset.left, border: "solid 1px #ddd" }).html(tip);
    //$("#show_Contentframe").css({ width: "100%", height: "100%", top: 0, left: 0 }).html(tip);
}

///计算时间差
function DateDiff(dmEndDate, dmStartDate) {

    dmEndDate = dmEndDate.replace(/-/g, "/");
    dmEndDate = new Date(dmEndDate)
    dmStartDate = dmStartDate.replace(/-/g, "/");
    dmStartDate = new Date(dmStartDate)
    var time = dmEndDate.getTime() - dmStartDate.getTime();
    var second = parseInt(time / (1000));
    return second;
}

///刷新加载时间
var timeout = null;
function RunTime() {

    var end = new Date().format('Y-m-d H:i:s');
    var diff = DateDiff(end, start);
    $("#tip_msg").html("请等待，正在加载中，已耗时 " + diff + " 秒");

    timeout = setTimeout(RunTime, 1000);
}

///跳转页面
function Redirect(url) {
    //var url = $("#ViewReport1_hidPath").val();
    url = "/common/uicontrols/ViewReport_Down.aspx?pdfpath=" + url;
    setTimeout(function ss() { window.location.href = url }, 1500);
}

///显示预览
function Preview(str) {

    var view = "";
    if (str.indexOf(".PDF") > -1) {
        view = "<iframe src=\"" + str + "\"  width=\"999\" height=\"99%\" id=\"Contentframe\"  style=\"border-bottom:solid 1px #878787; border-right:solid 1px #878787\" frameborder=\"0\" scrolling=\"no\" ></iframe>";
    }
    else if (str.indexOf(".TIF") > -1) {
        view = "<div id=\"Contentframe\" style=\"overflow-Y:scroll;border:solid 5px #878787;margin:0px auto; height:99%; border-right:solid 1px #878787; width:994px; \"><div style=\"position: relative;\" onmouseover='upNext();'><a id=\"div_up\"></a><img src=\"" + str + "\"   width=\"100%\"  style=\"position: absolute;\"  /><a id=\"div_next\"></a></div></div>";
    }
    else {
        view = "<div id=\"Contentframe\" style=\"overflow-Y:scroll;border:solid 5px #878787;margin:0px auto; height:99%; border-right:solid 1px #878787; width:994px; \"><div onmouseover='upNext();'><a id=\"div_up\"></a><a id=\"div_next\"></a><img src=\"" + str + "\"   width=\"100%\"  style=\"position: relative;\" /></div></div>";
    }

    return view;
}

///刷新 重新加载
function Refresh() {
    $("#labPageCount").html(1);
    $("#txtPagecurrindex").val(1);
    format = 5;
    mode = 1;
    WinT();
    WinShow();
}

///下载文件
function Download() {
    isRedirect = 1;
    mode = 0;
    format = $("#drpDownLoadlist").val();
    WinT();
    WinShow();
}


var num = 0;
var value = 0;
var cleargetPage = null;
///显示页数，一秒钟获取一次，如果连续30秒没有变化 停止获取
function GetPageList() {
    var Query = window.location.search;
    var url = $("#ViewReport1_hidPath").val();
    $("#loading_tools").fadeIn('slow');
    value = $("#labPageCount").html();
    $.get("/Common/UIControls/ViewReport_Tools.ashx" + Query + "&filepath=" + url + "&option=getpagesize", function(data) {
        $("#labPageCount").html(data);
    })
    cleargetPage = setTimeout(GetPageList, 3000);
}

///移动文件
function MoveAll() {
    var Query = window.location.search;
    var url = $("#ViewReport1_hidPath").val();
    $.get("/Common/UIControls/ViewReport_Tools.ashx" + Query + "&filepath=" + url + "&option=move", function(data) {
        clearTimeout(cleargetPage);
        $("#loading_tools").hide();
        $("#labPageCount").html(data);
    })
}

///当前文件地址
function GetURL() {
    var url = $("#ViewReport1_hidPath").val();
    return url;
}

///处理过后的文件地址
function GetCurrUrl(currindex) {
    var url = $("#ViewReport1_hidPath").val();
    if (currindex == 1 || currindex == 0)
        currindex = "";
    url = url.replace(".", currindex + ".");
    return url;
}

///首页
function FirstPage() {
    var url = GetCurrUrl("");
    $("#txtPagecurrindex").val("1");
    $("#div_Contentframe").html(Preview(url)).show();
    $("#Contentframe").height(height - 12);

}

///上一页
function PrePage() {
    var url = "";
    var pageCurrindex = parseInt($("#txtPagecurrindex").val()) - 1;
    if (pageCurrindex <= 1) {
        pageCurrindex = 1;
        url = GetCurrUrl("");
    }
    else {
        url = GetCurrUrl(pageCurrindex);
    }
    $("#txtPagecurrindex").val(pageCurrindex);
    $("#div_Contentframe").html(Preview(url)).show();
    $("#Contentframe").height(height - 12);
}

///下一页
function NextPage() {
    var url = "";
    var pageCurrindex = parseInt($("#txtPagecurrindex").val()) + 1;
    if (pageCurrindex >= parseInt($("#labPageCount").html())) {
        pageCurrindex = parseInt($("#labPageCount").html());
    }

    url = GetCurrUrl(pageCurrindex);
    $("#txtPagecurrindex").val(pageCurrindex);
    $("#div_Contentframe").html(Preview(url)).show();
    $("#Contentframe").height(height - 12);
}

///末页
function LastPage() {
    var pageCount = parseInt($("#labPageCount").html());

    $("#txtPagecurrindex").val(pageCount);
    if (pageCount == 1) {
        pageCount = "";
    }
    var url = GetCurrUrl(pageCount);
    $("#div_Contentframe").html(Preview(url)).show();
    $("#Contentframe").height(height - 12);

}

///Text回车事件
function inputKeyDown(e) {

    if (e == 13 || e == 32) {
        var url = "";
        var pageCount = 1;
        try {
            if ($("#txtPagecurrindex").val() == "" || $("#txtPagecurrindex").val() == undefined || $("#txtPagecurrindex").val() == null)
                pageCount = 1;
            else
                pageCount = Number($("#txtPagecurrindex").val());
        }
        catch (e) {
            pageCount = 1;
        }
        if (pageCount >= parseInt($("#labPageCount").html())) {
            pageCount = parseInt($("#labPageCount").html());
            url = GetCurrUrl(pageCount);
        }
        else if (pageCount <= 0) {
            pageCount = 1;
            url = GetCurrUrl("");
        }
        else {
            url = GetCurrUrl(pageCount);
        }
        $("#txtPagecurrindex").val(pageCount);
        $("#div_Contentframe").html(Preview(url)).show();
        $("#Contentframe").height(height - 12);
        $("#txtPagecurrindex").focus().select();
    }
}

///只能输入数字
function NumIntput(event) {

    event = event || window.event;
    var code = event.keyCode;

    if (!(code >= 48 && code <= 57) && code != 46 && code != 8 && !(code >= 96 && code <= 105)) {
        event.returnValue = false;
    }
}

///左右翻页效果
function upNext() {
    var imgurl = "right";
    $("#Contentframe div").mousemove(function(e) {
        window.status = e.pageX + ',' + e.pageY;
        var width = $(this).width();
        var height = $(this).height();
        if (e.pageX - $(this).offset().left < width / 2) {

            $(this).find("#div_next").css({ "filter": "alpha(opacity=10)", "-moz-opacity": "0.1", "opacity": "0.1" });
            $(this).find("#div_up").css({ "filter": "alpha(opacity=50)", "-moz-opacity": "0.5", "opacity": "0.5" });
            imgurl = "left";
        } else {

            $(this).find("#div_up").css({ "filter": "alpha(opacity=10)", "-moz-opacity": "0.1", "opacity": "0.1" });
            $(this).find("#div_next").css({ "filter": "alpha(opacity=50)", "-moz-opacity": "0.5", "opacity": "0.5" });
            imgurl = "right";
        }
    }).mouseup(function() {
        if (imgurl == "left")
            PrePage();
        else
            NextPage();
    }).mouseout(function() {

        $(this).find("#div_up").css({ "filter": "alpha(opacity=10)", "-moz-opacity": "0.1", "opacity": "0.1" });
        $(this).find("#div_next").css({ "filter": "alpha(opacity=10)", "-moz-opacity": "0.1", "opacity": "0.1" });

    })
}