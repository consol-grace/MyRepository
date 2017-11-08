
var scrollTop;

$(function () {
    //AppendTitle();
    setWidth();
})

///创建Tip
function AppendTitle() {
    var str = "<span id=\"txt_Title\" style=\"border: solid 1px black;position: absolute;padding: 1px 2px; display: none;background: #FDFFE5;font-size: 10px; font-family: Arial;  z-index: 99999;\">F8-Add New  ↓ Popup</span>";
    $("#form1").append(str);
}

var cl;
function ShowTitle(obj) {

    //if ($("#" + obj).val() == "") { 
    clearTimeout(cl);
    var left = $("#" + obj).offset().left + 50;
    var top = $("#" + obj).offset().top + 90;
    $("#txt_Title").css({ left: left, top: top }).show();
    cl = setTimeout(CloseTitle, 1000);
    //}
    //else {
    //    CloseTitle(); 
    //}

}



function CloseTitle() {
    $("#txt_Title").hide();
}


///设置TextBox的宽度 
function setWidth() {
    var patt1 = new RegExp();
    var i = 0;
    $("input:text").each(function (index) {
        var id = $("input:text").eq(index).attr("id");
        if (id.indexOf("_text") == -1) {
            var width = $("#" + id + "_text1").parent("td").width() - 8;
            $("#" + id + "_text1").width(width);
        }
    })
}



///绑定查询事件
/// obj       控件ID
/// event     系统函数
/// title     标题
/// url       地址
/// width     宽度
/// height    长度
function Autocomplete(obj, event, title, url, width, height) {
    if (Ext.isEmpty($("#" + obj).val())) {
        $("#" + obj).removeClass("bottom_line").attr("validata", "true");
        $("#" + obj + "_text").val("");
        $("#" + obj + "_text1").val("");
    }
    event = event || window.event;
    var option = "control=" + obj + "&code=" + $("#" + obj).val() + "&scrollTop=100";
    var winViewParent = window.parent.WinView; //获得INDEX页面里的winView窗体
    var winShowDetail = window.parent.parent.$("#winShow_IFrame").contents().find("#winCombineCostDetail"); //获得公用的顶部的CombineCostDetail窗体
    var winComCostDetail = window.parent.parent.$("#winCombineCost_IFrame").contents().find("#winCombineCostDetail"); //单独打开的界面里的CombineCostDetail

    if (event.keyCode == 40) { //下键
        if (winViewParent == null || winViewParent == undefined) { 

            if (typeof Window1 == "object" && Window1 != null) { 
                window.Window1 = null;
            }

            if (winShowDetail.length > 0 || winComCostDetail.length > 0) {
                window.parent.parent.CreateWindow(obj, "http://" + window.location.host + "/common/UIControls/CompanyList.aspx?" + option);
            } else {
                window.parent.CreateWindow(obj, "http://" + window.location.host + "/common/UIControls/CompanyList.aspx?" + option);
            }
        } else {
            if (typeof window.parent.Window1 == "object" && window.parent.Window1 != null) {
                window.parent.Window1 = null; 
            }
            window.parent.CreateWindow(obj, "http://" + window.location.host + "/common/UIControls/CompanyList.aspx?" + option);
        }
    }
    else if (event.keyCode == 0 || event.keyCode == undefined || event.keyCode == 119) {//F8 
        var query = url.indexOf("?") > 0 ? "&" : "?";
        var winUrl = "http://" + window.location.host + url + query + option;
        CreateForm(title, width, height, winUrl, obj);
    }
    else if (event.keyCode == 9) {//TAB

        Vlidata(obj);
        $("#" + obj).select();
    }
    else if (event.keyCode == 13 || event.keyCode == 16 || event.keyCode == 17 || event.keyCode == 18) {

    }

}

//弹出列表框
function CreateForm(title, width, height, url, obj) {

    var winViewParent = window.parent.WinView; //获得INDEX页面里的winView窗体
    var winShowDetail = window.parent.parent.$("#winShow_IFrame").contents().find("#winCombineCostDetail"); //获得公用的顶部的CombineCostDetail窗体
    var winComCostDetail = window.parent.parent.$("#winCombineCost_IFrame").contents().find("#winCombineCostDetail"); //单独打开的界面里的CombineCostDetail

    if (winViewParent == null || winViewParent == undefined) {
        if (typeof Window1 == "object" && Window1 != null) { 
            Window1 = null;
        }

        if (winShowDetail.length > 0 || winComCostDetail.length > 0) { 
            window.parent.parent.CreateWindow(obj, url, title, 755, 562);
        } else {
            window.parent.CreateWindow(obj, url, title, 755, 562);
        }
    } else {
        if (typeof window.parent.Window1 == "object" && window.parent.Window1 != null) {
            window.parent.Window1 = null;
        }
        window.parent.CreateWindow(obj, url, title, 755, 562);
    }
}

///文本框获取焦点，并在最后
function getSelectPos(obj) {
    if ($.browser.msie) {
        var esrc = document.getElementById(obj);
        //        var esrc = $("#" + obj);
        if (esrc == null) {
            esrc = event.srcElement;
        }
        var rtextRange = esrc.createTextRange();
        rtextRange.moveStart('character', esrc.value.length);
        rtextRange.collapse(true);
        rtextRange.select();
    }
    else {
        //$("#" + obj).focus();
    }
}

///绑定验证事件
function Vlidata(obj) {

    var text = $("#" + obj).val();

    //$("#" + obj).val(text.toUpperCase());
    //$("#" + obj).removeClass("bottom_line"); //.attr("validata", "true");
    //$("#" + obj + "_text1").html("");

    if (Ext.isEmpty(text)) {
        $("#" + obj + "_text").val("");
        $("#" + obj + "_text1").val("");
        return;
    }

    $.getJSON("/common/uicontrols/AjaxService/DataHandler.ashx?action=companylist&key=" + encodeURI(text), function (data) {
        if (data[0] != undefined) {
            $("#" + obj).removeClass("bottom_line").attr("validata", "true");
            $("#" + obj + "_text").val(data[0].text);
            $("#" + obj + "_text1").val(data[0].text).css("color", "#666");
            if ($("#hidSetInformation").length > 0) {
                if ($("#hidSetInformation").val() == "1") {
                    SetComValue(obj, data[0].text);
                }
                else {
                    CompanyX.SetInfo(obj, text);
                }
            }
        }
        else {
            $("#" + obj).addClass("bottom_line").attr("validata", "false");
            $("#" + obj + "_text1").val("The company code is invalid .").css({ "color": "#ff0000", "text-transform": "none" });
            $("#" + obj + "_text").val("");
        }
    })

    //window.event.keyCode = 9; 
}


var win;
/// 创建Window 窗体
function CreateWindow(obj, url, title, width, height) {

    if (title == null || title == undefined)
        title = "Company";
    if (width == null || width == undefined)
        width = 755;
    if (height == null || height == undefined)
        height = 568;

    win = new Ext.Window({
        id: "Window1",
        title: title,
        resizable: false,
        draggable: false,
        //        animateTarget: obj,  //--- 此效果会有点卡 
        width: width, // 417,
        height: height, // 561,
        modal: true,
        bodyStyle: "background-color:#fff;",
        closeAction: "close"
    });

    win.on({
        hide: function (win) {
            DeleteWindow1();

            //这里是设置页面是否出现滚动条
            if (window.parent.WinView == null || window.parent.WinView == undefined) {
                window.parent.window.document.body.style.overflow = "auto"; 
                window.parent.getSelectPos(obj);
            } else {
                window.parent.window.document.body.style.overflow = "hidden"; //主页面是不需要滚动条的
                getSelectPos(obj);
            }
        }
    });

    win.load(url);
    win.show();
    window.parent.window.document.body.style.overflow = "hidden";
}

function GetCompany(obj, code) {
    var getIframe = $("#tes"); 

    var winShowIframe = window.parent.$("#winShow_IFrame"); //顶上的winCombineCost窗口（ID=WINSHOW）
    var winComCostIframe = window.parent.$("#winCombineCost_IFrame"); //页面里的winCombineCost窗口（ID=WINCOMBINECOST）
    var winShowDetailIframe = window.parent.parent.$("#winShow_IFrame").contents().find("#winCombineCostDetail_IFrame"); //所有页面里最顶上面的CombineCostDetail
    var winComCostDetailIframe = window.parent.$("#winCombineCost_IFrame").contents().find("#winCombineCostDetail_IFrame"); //单独打开的界面里的CombineCostDetail
    var contentIfram = window.parent.$("#ifmContent"); //INDEX页面里的report页面的查询列表
    var winWindow10Ifram = window.parent.$("#Window10_IFrame"); //单独打开界面的winView窗体（ID=Window10）

    if (window.parent.WinView != null && window.parent.WinView != undefined) {
        if (obj == "txtCompany") { 
            getIframe = window.parent.$("#WinView_IFrame");
        }
        else {
            if (winShowDetailIframe.attr("name") == "winCombineCostDetail_IFrame") {
                getIframe = winShowDetailIframe;
            } else if (contentIfram.attr("name") == "ifmContent" && (winShowIframe.css("visibility") == "hidden" || winShowIframe.css("visibility") == null)) {
                getIframe = contentIfram;
            } else {
                getIframe = winShowIframe; 
            }
        }

        window.parent.window.document.body.style.overflow = "hidden";
    } else {
        if (winShowDetailIframe.attr("name") == "winCombineCostDetail_IFrame") {
            getIframe = winShowDetailIframe;
        } else if (winComCostDetailIframe.attr("name") == "winCombineCostDetail_IFrame") {
            getIframe = winComCostDetailIframe;
        } else if (winShowIframe.attr("name") == "winShow_IFrame" && winShowIframe.css("visibility") == "visible") {
            getIframe = winShowIframe;
        } else if (winWindow10Ifram.attr("name") == "Window10_IFrame") {
            getIframe = winWindow10Ifram;
        }

        window.parent.window.document.body.style.overflow = "auto";
    }

    if (getIframe.attr("name") == null || getIframe.attr("name") == undefined) {
        window.parent.$("#" + obj).removeClass("bottom_line").attr("validata", "true");
        window.parent.$("#" + obj).val(code).focus();
    }
    else {
        getIframe.contents().find("#" + obj).removeClass("bottom_line").attr("validata", "true");
        getIframe.contents().find("#" + obj).val(code).focus();
    }

    DeleteWindow1();
}

//双击之后调用的方法
function GetCompany(obj, code, name, scroll) {

    scrollTop = scroll;
    var getIframe = $("#tes"); //该地方一定要赋值变成JQ对象否则下面会报错

    var winShowIframe = window.parent.$("#winShow_IFrame"); //顶上的winCombineCost窗口（ID=WINSHOW）
    var winComCostIframe = window.parent.$("#winCombineCost_IFrame"); //页面里的winCombineCost窗口（ID=WINCOMBINECOST）
    var winShowDetailIframe = window.parent.parent.$("#winShow_IFrame").contents().find("#winCombineCostDetail_IFrame"); //所有页面里最顶上面的CombineCostDetail
    var winComCostDetailIframe = window.parent.$("#winCombineCost_IFrame").contents().find("#winCombineCostDetail_IFrame"); //单独打开的界面里的CombineCostDetail
    var contentIfram = window.parent.$("#ifmContent"); //INDEX页面里的report页面的查询列表
    var winWindow10Ifram = window.parent.$("#Window10_IFrame");//单独打开界面的winView窗体（ID=Window10）

    if (window.parent.WinView != null && window.parent.WinView != undefined) {
        if (obj == "txtCompany") {
            getIframe = window.parent.$("#WinView_IFrame"); 
        }
        else {
            if (winShowDetailIframe.attr("name") == "winCombineCostDetail_IFrame") {
                getIframe = winShowDetailIframe;
            } else if (contentIfram.attr("name") == "ifmContent" && (winShowIframe.css("visibility") == "hidden" || winShowIframe.css("visibility") == null)) {
                getIframe = contentIfram;
            } else {
                getIframe = winShowIframe;
            }
        }

        window.parent.window.document.body.style.overflow = "hidden";
    } else {
        if (winShowDetailIframe.attr("name") == "winCombineCostDetail_IFrame") {
            getIframe = winShowDetailIframe;
        } else if (winComCostDetailIframe.attr("name") == "winCombineCostDetail_IFrame") {
            getIframe = winComCostDetailIframe;
        } else if (winShowIframe.attr("name") == "winShow_IFrame" && winShowIframe.css("visibility") == "visible") {
            getIframe = winShowIframe;
        } else if (winWindow10Ifram.attr("name") == "Window10_IFrame") {
            getIframe = winWindow10Ifram;
        }

        window.parent.window.document.body.style.overflow = "auto";
    }

    if (getIframe.attr("name") == null || getIframe.attr("name") == undefined) {
        window.parent.$("#" + obj).removeClass("bottom_line").attr("validata", "true");
        window.parent.$("#" + obj).val(code).focus();
        window.parent.$("#" + obj + "_text").val(name);
        window.parent.$("#" + obj + "_text1").val(name).css("color", "#666")
    }
    else {
        getIframe.contents().find("#" + obj).removeClass("bottom_line").attr("validata", "true");
        getIframe.contents().find("#" + obj).val(code).focus();

        getIframe.contents().find("#" + obj + "_text").val(name);
        getIframe.contents().find("#" + obj + "_text1").val(name).css("color", "#666");


    }

    try {

        DeleteWindow1();
    }
    catch (e)
    { }

    //     getSelectPos(obj);
}

///验证TextBox是否通过验证
function ValidataText() {

    var i = 0;
    $("input:text").each(function (index) {
        if ($("input:text").eq(index).attr("validata") == "false") {
            ++i;
        }
    })
    if (i > 0) {
        Msg();
        return false;
    }
    else
        return true;
}

///验证当前ID是否通过验证   
function ValidataCompany(obj) {
    if ($("#" + obj).attr("validata") == "false") {
        $("#" + obj).focus();
        return false;
    }
    else
        return true;
}


//验证错误信息
function Msg() {
    $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message:The input value is invalid .</p>")
}


///取消验证的错误信息 
function Invlidata(obj) {
    $("#" + obj).removeClass("bottom_line").attr("validata", "true");
    $("#" + obj + "_text").val("");
    $("#" + obj + "_text1").val("").css("color", "#666");
}

//删除window1（company）窗体
function DeleteWindow1() {
    window.parent.$("#Window1").prev().prev().prev().remove();
    window.parent.$("#Window1").prev().prev().remove();
    window.parent.$("#Window1").prev().remove();
    window.parent.$("#Window1").remove();
}