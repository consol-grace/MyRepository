$(function () {

    //            $("#win_show").fadeIn("fast").click(function () {
    //                //            CloseInvoice();
    //                //            ClearInvoiceText();
    //            });
    //            $("#win_close").fadeIn("fast");

    $("#txtCompany").focus();
    $("#win_close_invoice").click(function () {
        CloseInvoice();
        ClearInvoiceText();
    });

    $("#win_show").click(function () {
        CloseInvoice();
        ClearInvoiceText();
    });


    sys = getParam("Sys");
});
var sys;
function OpenInvoice() {
    //var sys =$("<%=hid_sys.ClientID %>").val();
    //var sys =$("#UserNewInvoice1_hid_sys").val();

    var strLog = "2:    SYS: " + sys + "     \r\n";

    $.get('/common/uicontrols/gridHtml.ashx?type=LOG&msg=' + strLog, function (data) {

    })

    NewInvoice(sys, 'txtCompany', cmbCurrency, StoreCurrInvoice);
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
    window.parent.$("#mask").hide();
}

///新增Invoice 跳转页面
function NewInvoice(sys, company, currency, comcurr) {
    if (!ValidataCompany(company)) {
        $("#" + company).focus();
        return;
    }

    var code = $("#" + company).val();
    var curr = currency.value;

    if (code == "" || code == undefined) {
        Ext.MessageBox.alert("Status", "Input can't for empty ! ! ! ", function () {
            $("#" + company).focus();
        });
        return;
    }
    if (currency.value == "" || currency.value == undefined) {
        Ext.MessageBox.alert("Status", "Input can't for empty ! ! ! ", function () {
            currency.focus();
        });
        return;
    }
    var M = window.parent.$("#hid_seed").val(); //"M=22623";

    //    if (M == "" || M == undefined) {
    //        Ext.MessageBox.alert("Status", " Please save the data ! ", function() {
    //            btnSave.focus();
    //        })
    //        return;
    //    }
    var lotNo = ""
//    if (document.getElementById("hidLotNo") != null || document.getElementById("hidLotNo") != undefined) {
        lotNo = window.parent.$("#hidLotNo").val().trim();
//    }
//     else {
//        lotNo = window.parent.$("#UserControlTop1_hidLotNo").val().trim();
//    }

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

    var strLog = "3:    lot : " + lotNo + " SYS: " + sys + "     \r\n";
    
    $.get('/common/uicontrols/gridHtml.ashx?type=LOG&msg=' + strLog, function (data) {
        
    })
    //string url = "invoice.aspx?sys=AI&M=" + Request["seed"] + "&Company=" + CmbCompanyRightText.Value + "&Currency=" + CmbCurrencyRight.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
    window.open("http://" + window.location.host + "/AirImport/AIShipmentJobList/invoice.aspx?chinaMode=" + chinaMode + "&sys=" + sys + "&" + M + "&Company=" + code + "&Currency=" + curr + "&rate=" + rate + "&FL=" + fl, lotNo);

    CloseInvoice();
    ClearInvoiceText();

}

function getParam(name) {//获取url传入的参数
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    //var schema = window.location.search.substr(1);
    var schema = window.location.toString(); //Owen url中包含#就解析不了
    if (schema.indexOf("?") < 1) {
        return"";
    }
    else {
        schema = schema.substr(schema.indexOf("?") + 1);
    }
    var result = schema.match(reg);
    if (result != null)
        return unescape(result[2]);
    else
        return"";
}
