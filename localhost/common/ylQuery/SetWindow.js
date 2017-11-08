$(function () {

    var b_version = navigator.appVersion
    var version = b_version.split(";");
    var trim_Version = version[1].replace(/[ ]/g, "");
    if (trim_Version == "MSIE10.0") {
        window.parent.$(".x-ie-shadow").css("background-image", "url('/extjs/resources/images/default/shadow-lr-png/ext.axd')");
        window.parent.$(".x-ie-shadow").css("background-color", "transparent");
    }

    //弹出框整个高度 
    var setHeight = $("#form1").height() + 78;

    if (setHeight < 422) { setHeight = 422; } //这个是设置的WinView弹出框框的最小高度

    //父窗体高度
    var parentHeight = $(window.parent).height();

    if (setHeight >= parentHeight) {
        if (window.parent.WinView != null && window.parent.WinView != undefined) {
            if ($(window.parent).width() < 1170) {
                window.parent.WinView.setPagePosition(25, 110);
            }
            window.parent.WinView.setHeight(parentHeight - 140);
            window.parent.WinView.setWidth(983);
        } else if (window.parent.UserControlTop1_WinView != null && window.parent.UserControlTop1_WinView != undefined) {
            if ($(window.parent).width() < 1170) {
                window.parent.UserControlTop1_WinView.setPagePosition(25, 110);
            }
            window.parent.UserControlTop1_WinView.setHeight(parentHeight - 140);
            window.parent.UserControlTop1_WinView.setWidth(983);
        } else {
            window.parent.Window10.setHeight(parentHeight - 140);
            window.parent.Window10.setWidth(983);
        }
    }
    else {
        if (window.parent.WinView != null && window.parent.WinView != undefined) {
            if ($(window.parent).width() < 1170) {
                window.parent.WinView.setPagePosition(25, 110);
            }
            window.parent.WinView.setHeight(setHeight);
            window.parent.WinView.setWidth(963);
        } else if (window.parent.UserControlTop1_WinView != null && window.parent.UserControlTop1_WinView != undefined) {
            if ($(window.parent).width() < 1170) {
                window.parent.UserControlTop1_WinView.setPagePosition(25, 110);
            }
            window.parent.UserControlTop1_WinView.setHeight(setHeight);
            window.parent.UserControlTop1_WinView.setWidth(963);
        } else {
            window.parent.Window10.setHeight(setHeight);
            window.parent.Window10.setWidth(963);
        }
    }
});