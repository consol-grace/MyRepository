var isUpdate = "false";
var href = "", a = "";
var isLink = "false";
var s = 0, c = 0;
var isdisabled = 0; //用于判断页面按钮是否已禁用,0表示未被禁用
try {
    Ext.onReady(function () {
        var isPage_Details = false;
        var seed = getParam("Seed");
        var id = getParam("ID"); //针对于OEContainerList/Container.aspx
        var type = getParam("type");
        var hbl = getParam("HBL");

        if (type == "Invoice" || (id != "" && hbl == "")) { //针对于INVOICE传的参数为ID
            seed = id;
            id = "";
            isPage_Details = true;
        }

        href = window.location.pathname;
        a = href.split("/");
        var sys = "";
        var time = "";
        var txtid = "";

        if (seed != "" || id != "") {
            $.getJSON("/common/uicontrols/AjaxService/CompareLockDate.ashx?v=" + new Date().getTime() + "&seed=" + encodeURI(seed) + "&id=" + encodeURI(id), function (data) {

                if (data && data == "true") {
                    isdisabled = 1;
                    DisabledBtn("btnRevert");
                    DisabledBtn("btnVoid");
                    DisabledBtn("btnSave");
                    DisabledBtn("btnCancel");
                    DisabledBtn("btnNext");
                    DisabledBtn("btnMan");
                    DisabledBtn("btnDescription");
                    DisabledBtn("btnModify");
                    DisabledBtn("btnDelete");
                    DisabledBtn("btnOk");
                    DisabledBtn("btnNew");
                    DisabledBtn("btnPull");
                    DisabledBtn("btnAddBooking");
                    DisabledBtn("btnNewBooking");

                    $("#showContainer,#showGenerate,#Invoicedetail,#showHBL").attr("disabled", "disabled").find("a").attr("disabled", "disabled").addClass("x-item-disabled").attr("href", "javascript:void(0);").attr("onclick", "").css("cursor", "default");
                    DisabledBtn("btnOption");
                    DisabledBtn("btnUpdateLotNo");
                    DisabledBtn("btnAttach");

                    DisabledHtmlBtn("btn_add");

                    if (!isPage_Details)
                        $("input[type='button']").addClass("x-item-disabled").attr("disabled", "disabled").css("cursor", "default");

                    $(".div_change").remove();

                    if ($("#hidisLock").length > 0) { //针对于INVOICE打印页面的PRINT按钮
                        $("#hidisLock").val("true");
                    }
                }
            });
        }

        //新增修改时提醒用户输入的时间
        setTimeout(function () {
            if (Ext.getCmp("btnSave") != undefined && Ext.getCmp("btnSave") != null) {
                Ext.util.Observable.capture(btnSave, function (name) {
                    if (name == "click") {
                        if (a[1].toUpperCase() == "AIREXPORT") {
                            sys = "AE";
                            if ($("#txtEst").length > 0) {
                                time = $("#txtEst").val();
                                txtid = txtEst;
                            } else if ($("#txtETD").length > 0) {
                                time = $("#txtETD").val();
                                txtid = txtETD;
                            }
                        } else if (a[1].toUpperCase() == "AIRIMPORT") {
                            sys = "AI";
                            if ($("#txtETA").length > 0) {
                                time = $("#txtETA").val();
                                txtid = txtETA;
                            }
                        } else if (a[1].toUpperCase() == "OCEANEXPORT") {
                            sys = "OE";
                            if ($("#txtETD").length > 0) {
                                time = $("#txtETD").val();
                                txtid = txtETD;
                            }
                        } else if (a[1].toUpperCase() == "OCEANIMPORT") {
                            sys = "OI";
                            if ($("#txtETADischarge").length > 0) {
                                time = $("#txtETADischarge").val();
                                txtid = txtETADischarge;
                            }
                        } else if (a[1].toUpperCase() == "TRIANGLE" && a[2].toUpperCase() == "AIRSHIPMENT") {
                            sys = "AT";
                            if ($("#txtJob").length > 0) {
                                time = $("#txtJob").val();
                                txtid = txtJob;
                            }
                        } else if (a[1].toUpperCase() == "TRIANGLE" && a[2].toUpperCase() == "OCEANSHIPMENT") {
                            sys = "OT";
                            if ($("#txtJob").length > 0) {
                                time = $("#txtJob").val();
                                txtid = txtJob;
                            }
                        } else if (a[1].toUpperCase() == "OTHERBUSINESS" && a[2].toUpperCase() == "DOMESTIC") {
                            sys = "DM";
                            if ($("#txtJob").length > 0) {
                                time = $("#txtJob").val();
                                txtid = txtJob;
                            }
                        } else if (a[1].toUpperCase() == "OTHERBUSINESS" && a[2].toUpperCase() == "TRUCKING") {
                            sys = "TK";
                            if ($("#txtJob").length > 0) {
                                time = $("#txtJob").val();
                                txtid = txtJob;
                            }
                        } else if (a[1].toUpperCase() == "OTHERBUSINESS" && a[2].toUpperCase() == "BROKERAGE") {
                            sys = "BK";
                            if ($("#txtJob").length > 0) {
                                time = $("#txtJob").val();
                                txtid = txtJob;
                            }
                        } else {
                            isUpdate = "false";
                            return true;
                        }

                        if (!isSave(sys, time, txtid)) {
                            return false;
                        }
                        else { //保存
                            return true;
                        }
                    }
                });

                $("input[type='text'],textarea").bind({
                    click: function () { this.blur(); this.focus(); },
                    change: function () { isUpdate = "true"; }
                });

                setTimeout(function () {
                    var a = document.getElementsByTagName("a");
                    for (var i = 0; i < a.length; i++) {
                        if (a[i].href.lastIndexOf("aspx") > 0 && a[i].href.lastIndexOf("#") < 0) {
                            a[i].onclick = function () {
                                c++;
                                isLink = "true";
                            }
                        }
                    }
                }, 200);
            }

        }, 200);
    });
}
catch (e)
{ }

if (window.parent.winShow != undefined && window.parent.winShow != null) {
    var win = window.parent.winShow;
    winBeforehide(win);

} else if (window.parent.winCombineCostDetail != undefined && window.parent.winCombineCostDetail != null) {
    var win = window.parent.winCombineCostDetail;
    winBeforehide(win);

} else {
    window.onbeforeunload = function (e) {
        s++;
        if (s > c) {
            isLink = "false";
            s = 0;
            c = 0;
        }

        if (Ext.getCmp("btnSave") != undefined && Ext.getCmp("btnSave") != null && a[1].toUpperCase() != "BASICDATA") {
            if (isUpdate == "true") {
                if (isLink == "false") {
                    if (window.event.clientX < 0 || window.event.clientY < 0 || window.event.altKey) { //该段是区分是(除ENTER以及刷新按钮还有F5没效果)刷新还是关闭
                        e = e || window.event; //这里是用来兼容其他浏览器
                        if (e) {
                            e.returnValue = 'The current operation is not saved, Are you sure to leave this page ?';
                        }

                        return "The current operation is not saved, Are you sure to leave this page ?";

                    }
                } else {
                    return "The current operation is not saved, Are you sure to leave this page ?";
                }
            }
        }
    }
}

function winBeforehide(win) {
    if (win != undefined && win != null) {
        win.on({
            beforehide: function (win) {

                if (isUpdate == "true") {

                    if (confirm("The current operation is not saved, Are you sure to leave this page ?")) {
                        return true;
                    } else { return false; }
                }
            }
        });
    }
}

function isSave(sys, time, txtid) {
    var b = false;
    $.ajaxSettings.async = false;

    $.getJSON("/common/uicontrols/AjaxService/CompareSaveDate.ashx?v=" + new Date().getTime() + "&sys=" + encodeURI(sys) + "&time=" + encodeURI(time), function (data) {

        if (data && data == "false") {
            $("#div_bottom").html("<P class='error'>Status : Saved failed , Error message: Please check the date!");
            txtid.focus().addClass("x-form-invalid");
            b = false;
        } else {
            isUpdate = "false";
            b = true;
        }

    });
    $.ajaxSettings.async = true;
    return b;
}

function DisabledBtn(id) {

    if (Ext.getCmp(id) != undefined && Ext.getCmp(id) != null) {
        Ext.getCmp(id).disable();
    }
    $("#" + id).addClass("x-item-disabled").attr("disabled", "disabled");
    $("#" + id + "  button").addClass("x-item-disabled").css("cursor", "").attr("disabled", "disabled");
    $("#" + id + "  input[type='button']").addClass("x-item-disabled").css("cursor", "").attr("disabled", "disabled");

}

function DisabledHtmlBtn(obj) {
    $("." + obj).each(function (i) {
        var btnText = $(this).text().trim();
        if (btnText == "New SN" || btnText == "New CL" || btnText == "New Invoice" || btnText == "Gen. Invoice" || btnText == "New HAWB" || btnText == "New CTNR" || btnText == "New HBL") {
            $(this).removeClass("x-btn  x-btn-noicon");
            $(this).addClass("x-item-disabled").attr("disabled", "disabled").attr("onclick", "").css("cursor", "default");
            var _td = $(this).parent();
            var w = $(this).width();
            var h = $(this).height();
            var offset = $(this).offset();
            var _html = "";
            _html = "<div style='width:" + w + "px; height:" + h + "px; left:" + offset.left + "px; top:" + offset.top + "px; position:absolute;z-index:999; filter:alpha(Opacity=0);-moz-opacity:0;opacity: 0;'></div>";
            _td.prepend(_html);
        }
    })
}
