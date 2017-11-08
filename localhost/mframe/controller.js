/// <reference path="../common/ylQuery/jQuery/js/jquery-1.4.1.js" />
/// <reference path="../common/ylQuery/jQuery/js/jquery.ui.custom.js" />
/// <reference path="../common/ylQuery/ylQuery.js" />
/// <reference path="../common/Global/global.js" />


function getRootPath() {
    var strFullPath = window.document.location.href;
    var strPath = window.document.location.pathname;
    var pos = strFullPath.indexOf(strPath);
    var prePath = strFullPath.substring(0, pos);
    var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);
    return (prePath + postPath);
}
var webpath = getRootPath() + "/../";  //webpath就是目录路径变量

var FwDialog = ylQuery.Dialog;

USGROUP.MENU_FRAME = { LogoutClick: function() {
    window.location = USGROUP.Url.DataController + "?Option=user-logout";
}
    , HomeClick: function() {
        $("#ifmContent").attr("src", "main.aspx");
    }
};
USGROUP.MENU_FRAME.LeftLinkClick = function(hyperlink) {
    if (hyperlink == "/AirImport/AIShipmentJobList/mawb.aspx") {
        window.open(hyperlink, "_blank");
    }
    else if (hyperlink == "/OceanImport/OceanLot/List.aspx") {
        window.open(hyperlink, "_blank");
    }
    else if (hyperlink.substr(0, 10) == "/AirExport" && hyperlink != "/AirExport/AEManageMentList/list.aspx" && hyperlink.indexOf("/AirExport/AEViewConsol/list.aspx?sys=AE") < 0 && hyperlink.indexOf("/AirExport/AECallNo/List.aspx?sys=AE") < 0) {
        window.open(hyperlink, "_blank");
    }
    else if (hyperlink == "/OceanExport/OEShipment/List.aspx") {
        window.open(hyperlink, "_blank");
    }
    else if (hyperlink == "/Triangle/AirShipment/List.aspx") {
        window.open(hyperlink, "_blank");
    }
    else if (hyperlink == "/Triangle/OceanShipment/List.aspx") {
        window.open(hyperlink, "_blank");
    }
    else if (hyperlink == "/OtherBusiness/Brokerage/List.aspx") {
        window.open(hyperlink, "_blank");
    }
    else if (hyperlink == "/OtherBusiness/Domestic/List.aspx") {
        window.open(hyperlink, "_blank");
    }
    else if (hyperlink == "/OtherBusiness/Trucking/List.aspx") {
        window.open(hyperlink, "_blank");
    }
    else
        $("#ifmContent").attr("src", hyperlink);
};


$(document).ready(function() {
    LoadTopMenu("");
    function auto() {
        //$("#tdContent").css({ "height": $(window).height() - $("#m_top").height() - 5 + "px" });
        $("#tdContent").css({ "height": $(window).height() - 5 + "px" });
        $("#left_Menu").height($(window).height() - 120);
        $(".nav_left_01 a").css("padding-top", "8px");
        setTimeout(auto, 100);
    }
    auto();
    $(".nav_left_1").parents("tbody").next().hide();
    $(".nav_left_1:first").parents("tbody").next().slideDown("fast");
    $(".nav_left_1").click(function () {
        if ($(this).parents("tbody").next().css("display") != "block") {
            $(".nav_left_1").parents("tbody").next().hide();
            //alert($(this).children("a").attr("class"))
            LoadTopMenu($(this).children("a").attr("class"));
            $(this).parents("tbody").next().slideDown("slow");
        }
        WinView.hide();
    });

    window.onresize = function () {
        setContentLeft();
    }

});






function LoadTopMenu(key) {
    $("#top_Menu").html("<p style='position:absolute;top:0px;right:15px; z-index:5;'>Loading...</p>");
    $("#outer").hover(function() {
        //alert("aa");
    })
    $.get("/mframe/MenuFrame.ashx?key=" + key, function(data) {
        $("#top_Menu").html(data);
        setContentLeft();
   if (document.getElementById("img")) {
            $("#btnSearch").css("margin-right", "30px");
        } else {
            $("#btnSearch").css("margin-right", "5px");
        }
    })
}


function setContentLeft() {
  
    if (document.documentElement.clientWidth <= 1024 && document.documentElement.clientWidth > 600) {
        var width = 0;
        if ($("#div_content table").width() > 575) {//这个是因为有时候标题过长（base）然后导致上面2排（查询跟标题）不能对齐
            $("#AllSearch").css("width", document.documentElement.clientWidth - 14); //设置查询的位置
            width = document.documentElement.clientWidth - $("#div_content table").width() - 15;
            $("#divChkGroupTitle").css("right", "201px");
            $("#btnCmbChkGroup").css("right", "184px");
            $("#divChkGroup").css("right", "186px");
        } else {
            $("#AllSearch").css("width", document.documentElement.clientWidth - 13); //设置查询的位置
            width = document.documentElement.clientWidth - $("#div_content table").width() - 10;
            $("#divChkGroupTitle").css("right", "227px");
            $("#btnCmbChkGroup").css("right", "210px");
            $("#divChkGroup").css("right", "212px");
        }

       
        $("#div_content").css("left", width); //设置头部标题的位置

    } else if (document.documentElement.clientWidth <= 1185) { //1185的时候不会跟随左边菜单移动
        if ($("#div_content table").width() > 575) {
            $("#div_content").css("left", 410);
            $("#divChkGroupTitle").css("right", "201px");
            $("#btnCmbChkGroup").css("right", "184px");
            $("#divChkGroup").css("right", "186px");
        } else if ($("#div_content table").width() > 510) {
            $("#div_content").css("left", 430);
            $("#divChkGroupTitle").css("right", "227px");
            $("#btnCmbChkGroup").css("right", "210px");
            $("#divChkGroup").css("right", "212px");
        } else {
            $("#div_content").css("left", 500);
            $("#divChkGroupTitle").css("right", "227px");
            $("#btnCmbChkGroup").css("right", "210px");
            $("#divChkGroup").css("right", "212px");
        }

        $("#AllSearch").css("width", 993);
    }
    else {
        var width = 0;

        if ($("#tdLeft").css("display") == "none") {
            if ($("#div_content table").width() > 575) {
                width = 1161 - $("#tdLeft").width();
            } else if ($("#div_content table").width() > 560) {
                width = 1158 - $("#tdLeft").width();
            } else {
                width = 1158 - $("#tdLeft").width();
            }
        } else {
            if ($("#div_content table").width() > 575) {
                width = 1167;
                $("#divChkGroupTitle").css("right", "201px");
                $("#btnCmbChkGroup").css("right", "184px");
                $("#divChkGroup").css("right", "186px");
            } else if ($("#div_content table").width() > 560) {//OE
                width = 1165;
                $("#divChkGroupTitle").css("right", "227px");
                $("#btnCmbChkGroup").css("right", "210px");
                $("#divChkGroup").css("right", "212px");
            } else {//AE
                width = 1165;
                $("#divChkGroupTitle").css("right", "227px");
                $("#btnCmbChkGroup").css("right", "210px");
                $("#divChkGroup").css("right", "212px");
            }
        }
        $("#AllSearch").css("width", width);
        $("#div_content").css("left", 1024 - $("#div_content table").width() - 24 + $("#left_Menu").width());

    }
}


var clear;
$(function () {
    $("#left_Menu").mouseover(function () {
        //var left = 1024 - $("#div_content table").width() - 24 + $("#left_Menu").width();
        //$("#div_content").css("left", left);
   
       setContentLeft();
    })

    $("#tdLeft").hover(function () {
        clearTimeout(clear);

    }, function() {
        if ($(window).width() < 1170) {
            clear = setTimeout(NavClose, 200);
        }
    })

    $("#tdCenter").hover(function () {
        clearTimeout(clear);
        $("#tdLeft").css("display", "inline");
        $("#tdCenter1").css({ "background": "url(../images/center0.gif)", "background-repeat": "no-repeat", "background-position": "center 170px" });
        $("#tdCenter").css({ "width": "10px" });
        temp = 0;
    }, function() {

        if ($(window).width() < 1170) {
            clear = setTimeout(NavClose, 200);
        }
    }).click(function() {
        //var left = 1024 - $("#div_content table").width() - 24;
        //$("#div_content").css("left", left);

        NavClose();
        setContentLeft();
    })
})

function NavClose() {
    $("#tdLeft").css("display", "none");
    $("#tdCenter1").css({ "background": "url(../images/center.gif)", "background-repeat": "no-repeat", "background-position": "center 170px" });
    $("#tdCenter").css("width", "10px");
    temp = 1;
}




$(function() {

    MenuList();
    $(window).resize(function() {

        MenuList();

    })

    var port = window.location.port;
    if (port == "4848") {
        //alert(port);
        $("#sy_top").css("background-color", "#000");
    }
})


function LoadUrl(obj) {
    var url = "http://" + window.location.host + "/mframe/blank.html";
    obj.load(url);
}



function WindowClose() {


}





///获取用户屏幕大小然后取决用那个 Menu List
function MenuList() {

    $("#tdCenter1").css("height", $("body").height() - 72);

    var width = $(window).width();
    if (width >= 1170) {

        $("#div_Menu").removeAttr("style");
        $("#td_Menu").removeAttr("style");
        var height = $("#td_Menu").height();
        $("#div_Menu").css({ "height": height });
        $("#td_Menu").css({ "width": "15px", "padding": "0 0 0 0" })
    }
    else {

        var height = $("#td_Menu").height();
        $("#td_Menu").css({ "width": "15px", "padding": "0 5px 0 0" })
        $("#div_Menu").css({ "position": "absolute", "z-index": "111", "height": height });

    }

}

$(function() {


    $("#div_Menu_list p:first").next("div").slideDown("fast");
    $("#div_Menu_list p").click(function() {
        if ($(this).next("div").css("display") != "block") {
            $("#div_Menu_list P").nextAll("div").slideUp('fast');
            $(this).next("div").slideDown('fast');
            var sys = $(this).find("a").attr("class");
            if (sys.length > 1)
                sys = "";                
            LoadTopMenu(sys);
        }
        WinView.hide();

    })

    $("a.Report_List").each(function(index) {

        $(this).append($(this).next("div"));
        $(this).hover(function() {
            var height = $(window).height();
            var offset = $(this).offset();
            var h = height - offset.top - $(this).find("div").height();
            $("a.Report_List").find("span").removeClass("span");
            $(this).find("span").addClass("span");
            if (h >= 25)
                $(this).find("div").show();
            else
                $(this).find("div").addClass("bottom").show();

        }, function() {
            $(this).find("span").removeClass("span");
            $(this).find("div").hide();
        })

    })

})  