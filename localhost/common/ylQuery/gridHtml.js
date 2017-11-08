$(function() {

    CreateShow();

    $("tr.td_header td").eq(0).css("border-left", "0px");

    $("tr.tr_line").each(function() {
        $(this).children("td").eq(2).css("text-align", "left");
    })

})


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
    var M = $("#hid_seed").val();//"M=22623";
//    if (M == "" || M == undefined) {
//        Ext.MessageBox.alert("Status", " Please save the data ! ", function() {
//            btnSave.focus();
//        })
//        return;
//    }

    var record = comcurr.getById(curr);
    //Ext.getCmp('btnSave').fireEvent('click', this);
    var rate = record.data.rate;
    var fl = record.data.foreign == true ? "F" : "L";
    //string url = "invoice.aspx?sys=AI&M=" + Request["seed"] + "&Company=" + CmbCompanyRightText.Value + "&Currency=" + CmbCurrencyRight.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");

    var date = new Date();
    var strLog = "[" + date.getMonth() + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "]     \r\n";
    strLog = strLog + "YLQUERY  1:   SYS: " + sys + "     company: " + company + "\r\n";

    $.get('/common/uicontrols/gridHtml.ashx?type=LOG&msg=' + strLog, function (data) {

    })

    window.open("http://" + window.location.host + "/AirImport/AIShipmentJobList/invoice.aspx?sys=" + sys + "&" + M + "&Company=" + code + "&Currency=" + curr + "&rate=" + rate + "&FL=" + fl, "_blank");

    CloseInvoice();
    ClearInvoiceText();
    
}

function ClearInvoiceText() {
    $("#txtCompany").val("").attr("validata","true");
    $("#cmbCurrency").val("");
    $("#hid_seed").val("");
    $("#txtCompany_text1").val("");
    $("#radForeign").attr("checked", false);
    $("#radLocal").attr("checked", false);
    
} 

function CloseInvoice() {

    $("#win_show").fadeOut("fast");
    $("#win_close").fadeOut("fast");
}
    