$(function() {

    $("table").eq(0).css({ position: "fixed", top: "0", "z-index": "99999" }).next().css("margin-top", "32px");

    $(".btn_clp").click(function() {

        var cntrno = $(this).attr("cntrno");
        var tombl = $(this).attr("tombl");
        SetStyle("装箱单", 925, 370, "Form", "/common/UIControls/CLP.aspx?cntrno=" + cntrno + "&tombl=" + tombl);

    })

    $(window.document).click(function() {
        //  if (document.activeElement.id != "paymentlist" && document.activeElement.id != "paymentlistShow") {
        //        $("#paymentlistShow").hide();
        //    }
        $(".paymentlistShow").hide();
    });

    CreateShow();
    CreatOffical();
    $("tr.td_header td").eq(0).css("border-left", "0px");

    $("tr.tr_line").each(function() {
        $(this).children("td").eq(3).css("text-align", "left");
    })

    var scrollTop = 0;
    $(window).scroll(function() {

        scrollTop = document.documentElement.scrollTop;
        //alert(scrollTop);
        var width = ($(window.document).width() - $("#win_close").width()) / 2;
        if ($("#win_close").css("display") == 'block')
            $("#win_close").animate({ left: width, top: 100 + scrollTop }, 30);
        else
            $("#win_close").animate({ left: '0px', top: 100 + scrollTop }, 30);

    })

    ///新增Invoice
    $(".btn_invoice").click(function() {



        $("#div_offical").hide(); $("#div_HAWB").hide(); //////

        $("#txtCompany").val("").attr("validata", "true");
        //$("body").css("overflow", "hidden"); ////  --------滚动条

        $("#hid_seed").val($(this).attr("seed"));
        //alert($("#hid_seed").val());
        $("#win_show").height($(document).height()).fadeIn("fast").click(function() {
            CloseInvoice();
            ClearInvoiceText();
        });
        var width = ($(window.document).width() - $("#win_close").width()) / 2;
        $("#win_close").animate({ left: width, top: 100 + scrollTop, opacity: 'show' }, 'fast');
        $("#txtCompany").focus();
    })

    ///copy invoice
    $(".btn_copyinvoice").click(function() {

        $("#div_offical").hide(); $("#div_HAWB").hide();  /////
        var seed = $(this).attr("seed");
        Ext.Msg.confirm('status', 'Are you sure ? ', function(btn) {
            if (btn == 'yes')
                $.get('/common/uicontrols/gridHtml.ashx?type=copy&seed=' + seed, function(data) {
                    if (data == "Y") {
                        window.location.reload();
                    }
                    else {
                        Ext.Msg.alert('status', ' Error  ');
                    }
                })
        })
    })


    $("#win_close_invoice").click(function() {
        CloseInvoice();
        ClearInvoiceText();
    })

    $("tr.td_header td").eq(0).css("border-left", "0px");

    $("tr.tr_line").each(function() {
        $(this).children("td").eq(3).css("text-align", "left");
    })

    $("tr.tr_line").hover(function() {
        $(this).css("background", "#fafafa")
    }, function() {
        $(this).css("background", "#fff")
    })

    $("#chball").click(function() {

        if (this.checked)
            $(".td_detail input:checkbox").attr("checked", true);
        else
            $(".td_detail input:checkbox").attr("checked", false);

    })

    $(".btn_Offical").click(function() {
        $("#div_HAWB").hide();
        $("#hidofficalseed").val("");
        $("#txtoffical").val("");
        var offset = $(this).offset();
        $("#div_offical").css({ top: offset.top + 18 + scrollTop, left: offset.left - 50 }).show();
        $("#hidofficalseed").val($(this).attr("seed"));
        $("#txtoffical").val($(this).next("span").text()).focus().select();
    })


    $("#form1").click(function() {
        if (window.event.srcElement.tagName != "A") {
            $("#div_offical").hide();
            $("#div_HAWB").hide();
        }
    })


    $("#txtoffical").keydown(function() {
        if (event.keyCode == 13)
            $("#btn_offical_inv").click();
    })


    $("#btn_offical_inv").click(function() {
        var seed = $("#hidofficalseed").val();
        var offical = $("#txtoffical").val();
//        if (offical == null || offical == "" || offical == undefined) {
//            Ext.Msg.alert("status", " Input can't for empty .", function() {
//                $("#txtoffical").focus();
//            });
//            return;
//        }
        $.get('/common/uicontrols/gridHtml.ashx?type=offical&seed=' + seed + "&offical=" + offical, function(data) {
            if (data == "Y") {
                window.location.reload();
            }
            else {
                Ext.Msg.alert('status', ' Error  ', function() {
                    $("#txtoffical").focus();
                })
            }
        })

    })

})




///创建 Offical inv. 输入框
function CreatOffical() {

    var str = "<div id=\"div_offical\" style=\"display:none; position:absolute;background-image:url(/images/offical.png); width: 170px;height: 55px;padding-top:15px; padding-left:10px; z-index:1;\">"
            + "<p style='line-height:25px;font-size:12px;font-family:微软雅黑'><b>发票号</b></p> <input type='text' id='txtoffical' style='border:solid 1px #ddd;height:14px;padding:1px 2px;margin-right:5px;'>"
            + "<input type='hidden' id='hidofficalseed'><input type='button' id='btn_offical_inv' value=' OK ' style='border:solid 1px #ddd; width:40px; background:#fff; height:18px;cursor:pointer;'> </div>";
    $("body").append(str);
}



///创建遮罩层
function CreateShow() {
    var str = "<div id=\"win_show\" style=\"position: absolute;display:none; top: 0;left: 0;width: 100%;height: 100%; z-index:1;";
    str += "background: #000;filter: alpha(opacity=50);-moz-opacity: 0.5;-khtml-opacity: 0.5;opacity: 0.5;\"></div>";
    $("#form1").append(str);
}



///新增Invoice 
function NewInvoice(sys, company, currency, comcurr) {

    if (!ValidataCompany(company)) {
        $("#" + company).focus();
        return;
    }


    var code = $("#" + company).val();
    var curr = currency.value;

    if (code == "" || code == undefined) {
        Ext.MessageBox.alert("Status", "Input can't for empty ! ! ! ", function() {
            $("#" + company).focus();
        });
        return;
    }
    if (currency.value == "" || currency.value == undefined) {
        Ext.MessageBox.alert("Status", "Input can't for empty ! ! ! ", function() {
            currency.focus();
        });
        return;
    }
    var M = $("#hid_seed").val(); //"M=22623";
    //    if (M == "" || M == undefined) {
    //        Ext.MessageBox.alert("Status", " Please save the data ! ", function() {
    //            btnSave.focus();
    //        })
    //        return;
    //    }
    var lotNo = $("#txtLotNo").text().trim();
    //alert(lotNo);
    var record = comcurr.getById(curr);
    //Ext.getCmp('btnSave').fireEvent('click', this);
    var rate = record.data.rate;
    var fl = record.data.foreign == true ? "F" : "L";

    var chinaMode = $("#chkChina").attr("checked");
    if (chinaMode == true)
        chinaMode = 1;
    else
        chinaMode = 0;

    var date = new Date();
    var strLog = "[" +  (date.getMonth()+1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "]     \r\n";
    strLog = strLog + "UICONTROLS  1:    LOT NO: " + lotNo + "    SYS: " + sys + "     company: " + company + "\r\n";

    $.get('/common/uicontrols/gridHtml.ashx?type=LOG&msg=' + strLog, function (data) {

    })
    //string url = "invoice.aspx?sys=AI&M=" + Request["seed"] + "&Company=" + CmbCompanyRightText.Value + "&Currency=" + CmbCurrencyRight.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
    window.open("http://" + window.location.host + "/AirImport/AIShipmentJobList/invoice.aspx?chinaMode=" + chinaMode + "&sys=" + sys + "&" + M + "&Company=" + code + "&Currency=" + curr + "&rate=" + rate + "&FL=" + fl, lotNo);

    CloseInvoice();
    ClearInvoiceText();

}

function ClearInvoiceText() {
    $("#txtCompany").val("").attr("validata", "true");
    $("#cmbCurrency").val("");
    $("#hid_seed").val("");
    $("#txtCompany_text1").val("");
    $("#radForeign").attr("checked", false);
    $("#radLocal").attr("checked", false);

}

function CloseInvoice() {

    //$("body").css("overflow", "auto");    //-------滚动条
    $("#win_show").fadeOut("fast");
    $("#win_close").fadeOut("fast");
}

function GetPayment(obj, seed, type, sys) {
    $.getJSON("/common/uicontrols/gridHtml.ashx?type=getpayment&payseed=" + seed + "&paytype=" + type + "&paysys=" + sys, function(data) {
        if (data[0].Flag == "Y") {
            var str = '';
            //str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/payment_1.png); width:114px; height:10px;"></td></tr><tr><td style="background-image:url(/images/payment_2.png); width:114px;text-align:center;">';
            str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/cost/cost.png); width:114px; height:9px;"></td></tr><tr><td style="width:114px;text-align:left;border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;background-color:#FFFFFF">';
            str += '<table border="0" cellpadding="0" cellspacing="2" width="100%">';
            $.each(data, function(i, n) {
                str += '<tr><td class="paymentBackground" style="text-align:left;width:110px;" onclick="OpenPayment(\'' + sys + '\',' + seed + ',\'' + n.Company + '\',\'' + n.Currency + '\')">';
                str += '<table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td style="width:98%;height:16px; line-height:16px;text-indent:0px;text-align:center;vertical-align:middle;">' + n.Company + '</td><td style="height:16px; line-height:16px;text-indent:0px;vertical-align:middle;">' + n.Currency + '</td></tr></table></td></tr>';
            });
            str += '</table>';
            //str += '</td></tr><tr><td style="background-image:url(/images/payment_3.png); width:114px; height:2px;"></td></tr></table>';
            str += '</td></tr><tr><td style="border-bottom: 1px solid #8DB2E3; width:114px;"></td></tr></table>';
            $(".paymentlistShow").hide();
            $("#" + obj).children("div").html(str).show();

            $(".paymentBackground").each(function() {
                $(this).hover(function() {
                    $(this).css({ "background": "#dfe8f6" });
                }, function() {
                    $(this).css({ "background": "#fff" });
                });
            });

        }
        else {
            var str = '';
            //str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/payment_1.png); width:114px; height:10px;"></td></tr><tr><td style="background-image:url(/images/payment_2.png); width:114px;text-align:center;">';
            str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/cost/cost.png); width:114px; height:9px;"></td></tr><tr><td style="width:114px;text-align:left;border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;background-color:#FFFFFF">';
            str += '<table border="0" cellpadding="0" cellspacing="2" width="100%">';
            str += '<tr><td style="text-align:left;width:110px;"><table border="0" cellpadding="0" cellspacing="0"><tr><td style="width:110px;height:16px;text-indent:0px;vertical-align:middle;">No Data</td></tr></table></td></tr>';
            str += '</table>';
            //str += '</td></tr><tr><td style="background-image:url(/images/payment_3.png); width:114px; height:2px;"></td></tr></table>';
            str += '</td></tr><tr><td style="border-bottom: 1px solid #8DB2E3; width:114px;"></td></tr></table>';
            $(".paymentlistShow").hide();
            $("#" + obj).children("div").html(str).show();

        }
    });
}

function OpenPayment(sys, seed, company, currency) {
    if (sys == 'AI') {
        window.open("/AirImport/AIShipmentJobList/ReportFile.aspx?type=PaymentRequest&ID=" + seed + "&Company=" + company + "&Currency=" + currency, "_blank");
    }
    else if (sys == 'AE') {
        window.open("/AirExport/AEReportFile/ReportFile.aspx?type=PaymentRequest&ID=" + seed + "&Company=" + company + "&Currency=" + currency, "_blank");
    }
    else if (sys == 'OI') {
        window.open("/OceanImport/OceanShipmentJobList/ReportFile.aspx?type=PaymentRequest&ID=" + seed + "&Company=" + company + "&Currency=" + currency, "_blank");
    }
    else if (sys == 'OE') {
        window.open("/OceanExport/OEReportFile/ReportFile.aspx?type=PaymentRequest&ID=" + seed + "&Company=" + company + "&Currency=" + currency, "_blank");
    }
    else if (sys == 'AT' || sys == "OT") {
        window.open("/Triangle/Report/ReportFile.aspx?type=PaymentRequest&sys=" + sys + "&ID=" + seed + "&Company=" + company + "&Currency=" + currency, "_blank");
    }
    else if (sys == 'DM' || sys == 'BK' || sys == 'TK') {
        window.open("/OtherBusiness/Report/ReportFile.aspx?type=PaymentRequest&sys=" + sys + "&ID=" + seed + "&Company=" + company + "&Currency=" + currency, "_blank");
    }

}