function over_text(obj) {
    //document.getElementById(obj).style.display='block';
    $("#" + obj).css("border-bottom", "1px solid #000000");
}

function out_text(obj) {
    //document.getElementById(obj).style.display='none';
    $("#" + obj).css("border-bottom", "1px solid transparent");
    if (obj == "txtShipper1" && $("#hidShowShipperFlag").val() == "1") {
        if ($("#txtCert").length > 0) {
            $("#txtCert").val($("#" + obj).val());
        }
    }
}





//function SetInfo(typename, value) {
//    var r = StoreCompanyInfo.getById(value);
//    var name = typename;
//    if (Ext.isEmpty(r)) {
//        return;
//    }
//    if (name == "Shipper") {
//        txtShipper1.setValue(r.data.co_Name);
//        txtShipper2.setValue(r.data.co_Address1);
//        txtShipper3.setValue(r.data.co_Address2);
//        txtShipper4.setValue(r.data.co_Address3);
//        txtShipper5.setValue(r.data.co_Address4);
//    }
//    else if (name == "Consignee") {
//        txtConsignee1.setValue(r.data.co_Name);
//        txtConsignee2.setValue(r.data.co_Address1);
//        txtConsignee3.setValue(r.data.co_Address2);
//        txtConsignee4.setValue(r.data.co_Address3);
//        txtConsignee5.setValue(r.data.co_Address4);
//    }
//    else if (name == "PartA") {

//    }
//    else if (name == "PartB") {

//    }
//}

function ShowInput(text) {

    //CompanyX.CheckPass(text);
    if (text == "ABC") {
        btnSave.show();
        txtpass.setValue("");
        hidisb.setValue("true");
        windowconfirm.hide();
        btnModify.hide();
        if (hidisb.getValue() == "true") {
            Ext.getCmp('btnSave').fireEvent('click', this);
        }        
    }
    else {
        Ext.Msg.alert('Status', ' The password is invalid .', function() { txtpass.setValue("").focus(); });

    }
}

function ReturnNull() {
    var Currency = $("#txtCurrency").val();
    var GhssCode = $("#txtGhSS").val();
    if (Currency == "" || Currency == undefined) {
        $("#txtCurrency").focus();
        NullMsg("Currency can't be empty!");
        return false;
    }
    if (GhssCode == "" || GhssCode == undefined) {
        $("#txtGhSS").focus();
        NullMsg("GHSS Code can't be empty!");
        return false;
    }
    else {
        return true;
    }
}



//验证错误信息
function NullMsg(msg) {
    $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg);
}

function out_textGhSS(obj) {
    $("#" + obj).css("border-bottom", "0px solid #ffffff");
    var ghss = $("#" + obj).val().toUpperCase();
    if (ghss != "") {
        if (ghss == "PP" || ghss == "P" || ghss == "PC") {
            //$("#txtWTPPD").val("P");
            //$("#txtOtherPPD").val("P");
            //$("#txtWTColl").val("");
            //$("#txtOtherColl").val("");
            if ($("#labhawbormawb span").html() == "HAWB") {
                $("#labppcc").html("FREIGHT PREPAID");
            }
        }
        else if (ghss == "CC" || ghss == "C" || ghss == "CP") {
            //$("#txtWTPPD").val("");
            //$("#txtOtherPPD").val("");
            //$("#txtWTColl").val("C");
            //$("#txtOtherColl").val("C");
            if ($("#labhawbormawb span").html() == "HAWB") {
                $("#labppcc").html("FREIGHT COLLECT");
            }
        }
    }
}

function out_textRate(obj) {
    $("#" + obj).css("border-bottom", "0px solid #ffffff");
    var gwt = $("#txtGWT1").val();
    if (gwt == "") {
        gwt = 0;
    }
    var cwt = $("#txtCWT1").val();
    if (cwt == "") {
        cwt = 0;
    }
    else {
        cwt = cwt.replace('K', '');
    }
    var rate = $("#txtRate1").val();
    if (rate == "") {
        $("#txtTotal1").val("");
    }
    else {
        $("#txtTotal1").val(gwt > cwt ? gwt * rate : cwt * rate);
    }

}




function sumTotal() {

    var cwt = txtCWT1.getValue() == undefined ? 0 : txtCWT1.getValue();
    var rate = txtRate1.getValue() == undefined ? 0 : txtRate1.getValue();
    var total = 0;
    if (cwt == 0 || rate == 0) {
        //txtTotal1.setValue(formatNumber("0", "###.00#"));
        txtTotal1.setValue("");
    }
    else {
        total = (cwt * rate).toFixed(2);
        txtTotal1.setValue(total);
    }

}


//-------------
function CheckList() {
    if (chkItem.checked == true && chkOther.checked == true) {

        txtRate2.show()
        txtRate1.hide();
        txtTotal1.hide();
        txtTotal11.show();

        txtPPWeight1.hide();
        txtCCWeight1.hide();
        txtPPOCAgent1.hide();
        txtPPOCAgent.hide();
        txtCCOCAgent.hide();
        txtCCOCAgent1.hide();


        textshow(false);

        if (txtWTPPD.getValue().toUpperCase() == 'P' && txtOtherColl.getValue().toUpperCase() == 'C') {

            //txtCCTotal1.hide();
            txtPPTotal1.show();
            txtCCTotal1.show();

        }
        else if (txtWTColl.getValue().toUpperCase() == 'C' && txtOtherPPD.getValue().toUpperCase() == 'P') {
            //txtPPTotal1.hide();
            txtPPTotal1.show();
            txtCCTotal1.show();
        }
        else if (txtWTColl.getValue().toUpperCase() == 'C' && txtOtherColl.getValue().toUpperCase() == 'C') {
            txtPPTotal1.hide();
            txtCCTotal1.show();
        }
        else if (txtWTPPD.getValue().toUpperCase() == 'P' && txtOtherPPD.getValue().toUpperCase() == 'P') {
            txtCCTotal1.hide();
            txtPPTotal1.show();
        }
        else {
            txtPPTotal1.hide();
            txtCCTotal1.hide();
        }
    }

    else if (chkItem.checked == true && chkOther.checked == false) {
        txtRate2.show()
        txtRate1.hide();
        txtTotal1.hide();
        txtTotal11.show();
        textshow(true);
        if (txtWTPPD.getValue().toUpperCase() == 'P') {
            txtCCWeight.show();
            txtCCWeight1.hide();

            txtPPWeight.hide();
            txtPPWeight1.show();
        }
        else if (txtWTColl.getValue().toUpperCase() == 'C') {
            txtCCWeight.hide();
            txtCCWeight1.show();
            txtPPWeight.show();
            txtPPWeight1.hide();
        }
        txtPPTotal1.hide();
        txtCCTotal1.hide();
        txtPPTotal.show();
        txtCCTotal.show();
    }

    else if (chkItem.checked == false && chkOther.checked == true) {
        txtRate2.hide()
        txtRate1.show();
        txtTotal1.show();
        txtTotal11.hide();

        textshow(true);

        if (txtWTPPD.getValue().toUpperCase() == 'P') {
            txtCCWeight.setValue("");
            txtCCWeight.disabled = true;
            txtPPWeight.setValue(txtTotal1.getValue());
        }
        else if (txtWTColl.getValue().toUpperCase() == 'C') {
            txtPPWeight.setValue("");
            txtPPWeight.disabled = true;
            txtCCWeight.setValue(txtTotal1.getValue());
        }


        if (txtOtherPPD.getValue().toUpperCase() == 'P') {
            txtCCOCAgent.show();
            txtCCOCAgent1.hide();
            txtPPOCAgent.hide();
            txtPPOCAgent1.show();
        }
        else if (txtOtherColl.getValue().toUpperCase() == 'C') {
            txtCCOCAgent.hide();
            txtCCOCAgent1.show();
            txtPPOCAgent.show();
            txtPPOCAgent1.hide();
            //txtCCWeight.setValue(txtTotal1.getValue());
        }

        txtPPTotal1.hide();
        txtCCTotal1.hide();

    }
    else {
        txtRate2.hide()
        txtRate1.show();
        txtTotal1.show();
        txtTotal11.hide();

        txtPPOCAgent.show();
        txtPPOCAgent1.hide();

        txtCCOCAgent.show();
        txtCCOCAgent1.hide();

        txtPPTotal1.hide();
        txtCCTotal1.hide();
        txtPPTotal.show();
        txtCCTotal.show();
        txtCCWeight.show();
        txtPPWeight.show();
        txtCCWeight1.hide();
        txtPPWeight1.hide();

        if (txtWTPPD.getValue().toUpperCase() == 'P') {
            txtCCWeight.setValue("");
            txtCCWeight.disabled = true;
            txtPPWeight.setValue(txtTotal1.getValue());
        }
        else if (txtWTColl.getValue().toUpperCase() == 'C') {
            txtPPWeight.setValue("");
            txtPPWeight.disabled = true;
            txtCCWeight.setValue(txtTotal1.getValue());
        }


        textshow(true);
    }
    TotalPP();
    TotalCC();
}


function textshow(b) {

    if (b == true) {
        // 显示
        txtPPWeight.show();
        txtCCWeight.show();
        txtPPValuation.show();
        txtCCValuation.show();
        txtPPTax.show();
        txtCCTax.show();
        txtPPOCAgent.show();
        txtCCOCAgent.show();
        txtPPOCCarrier.show();
        txtCCOCCarrier.show();
        txtPPTotal.show();
        txtCCTotal.show();
    }
    else {
        txtPPWeight.hide();
        txtCCWeight.hide();
        txtPPValuation.hide();
        txtCCValuation.hide();
        txtPPTax.hide();
        txtCCTax.hide();
        txtPPOCAgent.hide();
        txtCCOCAgent.hide();
        txtPPOCCarrier.hide();
        txtCCOCCarrier.hide();
        txtPPTotal.hide();
        txtCCTotal.hide();
    }
}


function TotalPP() {
    var a1 = txtPPWeight.getValue() == undefined && isNaN(txtPPWeight.getValue()) ? 0 : txtPPWeight.getValue();
    var a2 = txtPPValuation.getValue() == undefined && isNaN(txtPPValuation.getValue()) ? 0 : txtPPValuation.getValue();
    var a3 = txtPPTax.getValue() == undefined && isNaN(txtPPTax.getValue()) ? 0 : txtPPTax.getValue();
    var a4 = txtPPOCAgent.getValue() == undefined && isNaN(txtPPOCAgent.getValue()) ? 0 : txtPPOCAgent.getValue();
    var a5 = txtPPOCCarrier.getValue() == undefined && isNaN(txtPPOCCarrier.getValue()) ? 0 : txtPPOCCarrier.getValue();
    var a6 = 0;

    if (chkItem.checked == false && chkOther.checked == false) {
        a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        if (a6 == 0)
            a6 = "";

    }
    else if (chkItem.checked == true && chkOther.checked == false) {

        if (txtWTPPD.getValue().toUpperCase() == "P") {
            a6 = Number(a2) + Number(a3) + Number(a4) + Number(a5);

        }
        else {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        }
        if (a6 == 0)
            a6 = "";
    }
    else if (chkItem.checked == false && chkOther.checked == true) {

        if (txtOtherPPD.getValue().toUpperCase() == "P") {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a5);
        }
        else {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        }
        if (a6 == 0)
            a6 = "";

    }
    else {
        a6 = "";
    }
    if (a6 == "")
        txtPPTotal.setValue("");
    else
        txtPPTotal.setValue(formatNumber(a6, "###.00#"));

}

function TotalCC() {

    var a1 = txtCCWeight.getValue() == undefined && isNaN(txtCCWeight.getValue()) ? 0 : txtCCWeight.getValue();
    var a2 = txtCCValuation.getValue() == undefined && isNaN(txtCCValuation.getValue()) ? 0 : txtCCValuation.getValue();
    var a3 = txtCCTax.getValue() == undefined && isNaN(txtCCTax.getValue()) ? 0 : txtCCTax.getValue();
    var a4 = txtCCOCAgent.getValue() == undefined && isNaN(txtCCOCAgent.getValue()) ? 0 : txtCCOCAgent.getValue();
    var a5 = txtCCOCCarrier.getValue() == undefined && isNaN(txtCCOCCarrier.getValue()) ? 0 : txtCCOCCarrier.getValue();
    var a6;

    if (chkItem.checked == false && chkOther.checked == false) {
        a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        if (a6 == 0)
            a6 = "";
    }
    else if (chkItem.checked == true && chkOther.checked == false) {
        if (txtWTColl.getValue().toUpperCase() == "C") {
            a6 = Number(a2) + Number(a3) + Number(a4) + Number(a5);

        }
        else {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        }
        if (a6 == 0)
            a6 = "";

    }
    else if (chkItem.checked == false && chkOther.checked == true) {
        if (txtOtherColl.getValue().toUpperCase() == "C") {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a5);
        }
        else {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        }
        if (a6 == 0)
            a6 = "";

    }
    else {
        a6 = "";
    }

    if (a6 == "")
        txtCCTotal.setValue("");
    else
        txtCCTotal.setValue(formatNumber(a6, "###.00#"));

}

//-------------Mark页面使用
function CheckListMark() {
    if (window.parent.chkItem.checked == true && window.parent.chkOther.checked == true) {

        txtRate2.show()
        txtRate1.hide();
        txtTotal1.hide();
        txtTotal11.show();

        window.parent.txtPPWeight1.hide();
        window.parent.txtCCWeight1.hide();
        window.parent.txtPPOCAgent1.hide();
        window.parent.txtPPOCAgent.hide();
        window.parent.txtCCOCAgent.hide();
        window.parent.txtCCOCAgent1.hide();


        textshowMark(false);

        if (window.parent.txtWTPPD.getValue().toUpperCase() == 'P' && window.parent.txtOtherColl.getValue().toUpperCase() == 'C') {

            //txtCCTotal1.hide();
            window.parent.txtPPTotal1.show();
            window.parent.txtCCTotal1.show();

        }
        else if (window.parent.txtWTColl.getValue().toUpperCase() == 'C' && window.parent.txtOtherPPD.getValue().toUpperCase() == 'P') {
            //txtPPTotal1.hide();
            window.parent.txtPPTotal1.show();
            window.parent.txtCCTotal1.show();
        }
        else if (window.parent.txtWTColl.getValue().toUpperCase() == 'C' && window.parent.txtOtherColl.getValue().toUpperCase() == 'C') {
            window.parent.txtPPTotal1.hide();
            window.parent.txtCCTotal1.show();
        }
        else if (window.parent.txtWTPPD.getValue().toUpperCase() == 'P' && window.parent.txtOtherPPD.getValue().toUpperCase() == 'P') {
            window.parent.txtCCTotal1.hide();
            window.parent.txtPPTotal1.show();
        }
        else {
            window.parent.txtPPTotal1.hide();
            window.parent.txtCCTotal1.hide();
        }
    }

    else if (window.parent.chkItem.checked == true && window.parent.chkOther.checked == false) {
        txtRate2.show()
        txtRate1.hide();
        txtTotal1.hide();
        txtTotal11.show();
        textshowMark(true);
        if (window.parent.txtWTPPD.getValue().toUpperCase() == 'P') {
            window.parent.txtCCWeight.show();
            window.parent.txtCCWeight1.hide();

            window.parent.txtPPWeight.hide();
            window.parent.txtPPWeight1.show();
        }
        else if (txtWTColl.getValue().toUpperCase() == 'C') {
            window.parent.txtCCWeight.hide();
            window.parent.txtCCWeight1.show();
            window.parent.txtPPWeight.show();
            window.parent.txtPPWeight1.hide();
        }
        window.parent.txtPPTotal1.hide();
        window.parent.txtCCTotal1.hide();
        window.parent.txtPPTotal.show();
        window.parent.txtCCTotal.show();
    }

    else if (window.parent.chkItem.checked == false && window.parent.chkOther.checked == true) {
        txtRate2.hide()
        txtRate1.show();
        txtTotal1.show();
        txtTotal11.hide();

        textshowMark(true);

        if (window.parent.txtWTPPD.getValue().toUpperCase() == 'P') {
            window.parent.txtCCWeight.setValue("");
            window.parent.txtCCWeight.disabled = true;
            window.parent.txtPPWeight.setValue(txtTotal1.getValue());
        }
        else if (window.parent.txtWTColl.getValue().toUpperCase() == 'C') {
            window.parent.txtPPWeight.setValue("");
            window.parent.txtPPWeight.disabled = true;
            window.parent.txtCCWeight.setValue(txtTotal1.getValue());
        }


        if (window.parent.txtOtherPPD.getValue().toUpperCase() == 'P') {
            window.parent.txtCCOCAgent.show();
            window.parent.txtCCOCAgent1.hide();
            window.parent.txtPPOCAgent.hide();
            window.parent.txtPPOCAgent1.show();
        }
        else if (window.parent.txtOtherColl.getValue().toUpperCase() == 'C') {
            window.parent.txtCCOCAgent.hide();
            window.parent.txtCCOCAgent1.show();
            window.parent.txtPPOCAgent.show();
            window.parent.txtPPOCAgent1.hide();
            //txtCCWeight.setValue(txtTotal1.getValue());
        }

        window.parent.txtPPTotal1.hide();
        window.parent.txtCCTotal1.hide();

    }
    else {
        txtRate2.hide()
        txtRate1.show();
        txtTotal1.show();
        txtTotal11.hide();

        window.parent.txtPPOCAgent.show();
        window.parent.txtPPOCAgent1.hide();

        window.parent.txtCCOCAgent.show();
        window.parent.txtCCOCAgent1.hide();

        window.parent.txtPPTotal1.hide();
        window.parent.txtCCTotal1.hide();
        window.parent.txtPPTotal.show();
        window.parent.txtCCTotal.show();
        window.parent.txtCCWeight.show();
        window.parent.txtPPWeight.show();
        window.parent.txtCCWeight1.hide();
        window.parent.txtPPWeight1.hide();

        if (window.parent.txtWTPPD.getValue().toUpperCase() == 'P') {
            window.parent.txtCCWeight.setValue("");
            window.parent.txtCCWeight.disabled = true;
            window.parent.txtPPWeight.setValue(txtTotal1.getValue());
        }
        else if (window.parent.txtWTColl.getValue().toUpperCase() == 'C') {
            window.parent.txtPPWeight.setValue("");
            window.parent.txtPPWeight.disabled = true;
            window.parent.txtCCWeight.setValue(txtTotal1.getValue());
        }


        textshowMark(true);
    }
    TotalPPMark();
    TotalCCMark();
}

function textshowMark(b) {

    if (b == true) {
        // 显示
        window.parent.txtPPWeight.show();
        window.parent.txtCCWeight.show();
        window.parent.txtPPValuation.show();
        window.parent.txtCCValuation.show();
        window.parent.txtPPTax.show();
        window.parent.txtCCTax.show();
        window.parent.txtPPOCAgent.show();
        window.parent.txtCCOCAgent.show();
        window.parent.txtPPOCCarrier.show();
        window.parent.txtCCOCCarrier.show();
        window.parent.txtPPTotal.show();
        window.parent.txtCCTotal.show();
    }
    else {
        window.parent.txtPPWeight.hide();
        window.parent.txtCCWeight.hide();
        window.parent.txtPPValuation.hide();
        window.parent.txtCCValuation.hide();
        window.parent.txtPPTax.hide();
        window.parent.txtCCTax.hide();
        window.parent.txtPPOCAgent.hide();
        window.parent.txtCCOCAgent.hide();
        window.parent.txtPPOCCarrier.hide();
        window.parent.txtCCOCCarrier.hide();
        window.parent.txtPPTotal.hide();
        window.parent.txtCCTotal.hide();
    }
}

function TotalPPMark() {
    var a1 = window.parent.txtPPWeight.getValue() == undefined && isNaN(window.parent.txtPPWeight.getValue()) ? 0 : window.parent.txtPPWeight.getValue();
    var a2 = window.parent.txtPPValuation.getValue() == undefined && isNaN(window.parent.txtPPValuation.getValue()) ? 0 : window.parent.txtPPValuation.getValue();
    var a3 = window.parent.txtPPTax.getValue() == undefined && isNaN(window.parent.txtPPTax.getValue()) ? 0 : window.parent.txtPPTax.getValue();
    var a4 = window.parent.txtPPOCAgent.getValue() == undefined && isNaN(window.parent.txtPPOCAgent.getValue()) ? 0 : window.parent.txtPPOCAgent.getValue();
    var a5 = window.parent.txtPPOCCarrier.getValue() == undefined && isNaN(window.parent.txtPPOCCarrier.getValue()) ? 0 : window.parent.txtPPOCCarrier.getValue();
    var a6 = 0;

    if (window.parent.chkItem.checked == false && window.parent.chkOther.checked == false) {
        a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        if (a6 == 0)
            a6 = "";

    }
    else if (window.parent.chkItem.checked == true && window.parent.chkOther.checked == false) {

        if (window.parent.txtWTPPD.getValue().toUpperCase() == "P") {
            a6 = Number(a2) + Number(a3) + Number(a4) + Number(a5);

        }
        else {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        }
        if (a6 == 0)
            a6 = "";
    }
    else if (window.parent.chkItem.checked == false && window.parent.chkOther.checked == true) {

        if (window.parent.txtOtherPPD.getValue().toUpperCase() == "P") {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a5);
        }
        else {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        }
        if (a6 == 0)
            a6 = "";

    }
    else {
        a6 = "";
    }
    if (a6 == "")
        window.parent.txtPPTotal.setValue("");
    else
        window.parent.txtPPTotal.setValue(formatNumber(a6, "###.00#"));

}

function TotalCCMark() {

    var a1 = window.parent.txtCCWeight.getValue() == undefined && isNaN(window.parent.txtCCWeight.getValue()) ? 0 : window.parent.txtCCWeight.getValue();
    var a2 = window.parent.txtCCValuation.getValue() == undefined && isNaN(window.parent.txtCCValuation.getValue()) ? 0 : window.parent.txtCCValuation.getValue();
    var a3 = window.parent.txtCCTax.getValue() == undefined && isNaN(window.parent.txtCCTax.getValue()) ? 0 : window.parent.txtCCTax.getValue();
    var a4 = window.parent.txtCCOCAgent.getValue() == undefined && isNaN(window.parent.txtCCOCAgent.getValue()) ? 0 : window.parent.txtCCOCAgent.getValue();
    var a5 = window.parent.txtCCOCCarrier.getValue() == undefined && isNaN(window.parent.txtCCOCCarrier.getValue()) ? 0 : window.parent.txtCCOCCarrier.getValue();
    var a6;

    if (window.parent.chkItem.checked == false && window.parent.chkOther.checked == false) {
        a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        if (a6 == 0)
            a6 = "";
    }
    else if (window.parent.chkItem.checked == true && window.parent.chkOther.checked == false) {
        if (window.parent.txtWTColl.getValue().toUpperCase() == "C") {
            a6 = Number(a2) + Number(a3) + Number(a4) + Number(a5);

        }
        else {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        }
        if (a6 == 0)
            a6 = "";

    }
    else if (window.parent.chkItem.checked == false && window.parent.chkOther.checked == true) {
        if (window.parent.txtOtherColl.getValue().toUpperCase() == "C") {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a5);
        }
        else {
            a6 = Number(a1) + Number(a2) + Number(a3) + Number(a4) + Number(a5);
        }
        if (a6 == 0)
            a6 = "";

    }
    else {
        a6 = "";
    }

    if (a6 == "")
        window.parent.txtCCTotal.setValue("");
    else
        window.parent.txtCCTotal.setValue(formatNumber(a6, "###.00#"));

}

function changePPCC() {

    var ippd = txtWTPPD.getValue().toUpperCase();
    var icoll = txtWTColl.getValue().toUpperCase();
    var oppd = txtOtherPPD.getValue().toUpperCase();
    var ocoll = txtOtherColl.getValue().toUpperCase();


    if (ippd == "P" && oppd == "P") {
        txtGhSS.setValue("PP");
        labppcc.setText("FREIGHT PREPAID");
    }
    else if (ippd == "P" && ocoll == "C") {
        txtGhSS.setValue("");
        labppcc.setText("FREIGHT PREPAID");
    }
    else if (icoll == "C" && oppd == "P") {
        txtGhSS.setValue("CP");
        labppcc.setText("FREIGHT COLLECT");
    }
    else if (icoll == "C" && ocoll == "C") {
        txtGhSS.setValue("CC");
        labppcc.setText("FREIGHT COLLECT");
    }

}



function Keyshow(event) {

    if (event.keyCode != 80 && event.keyCode != 112 && event.keyCode != 99 && event.keyCode != 67) {
        event.returnValue = false;
    }
    //    else if (event.keyCode == 80 || event.keyCode == 112) {
    //    if (txtGhSS.getValue() == 'CC' || txtGhSS.getValue() =='C' || txtGhSS.getValue() == '' || txtGhSS.getValue().toUpperCase() == 'P' || txtGhSS.getValue().toUpperCase() == 'PP')
    //            return;
    //        else if (txtGhSS.getValue().toUpperCase() != "PP" && txtGhSS.getValue().toUpperCase() != "P")
    //            event.returnValue = false;

    //    }
    //    else if (event.keyCode == 99 || event.keyCode == 67) {
    //    if (txtGhSS.getValue() == 'PP' || txtGhSS.getValue() == 'C' || txtGhSS.getValue() == '' || txtGhSS.getValue().toUpperCase() == 'C' || txtGhSS.getValue().toUpperCase() == 'CC')
    //            return;
    //        else if (txtGhSS.getValue().toUpperCase() != "CC" && txtGhSS.getValue().toUpperCase() != "C")
    //            event.returnValue = false;
    //    }
}



///数字格式化
function FormatNum(obj, length) {

    var ss = obj.getValue();
    if (ss != null && ss != "" && ss != undefined) {
        try {
            var num = Number(obj.getValue());

            if (num != null && !isNaN(num) && num != undefined) {
                num = num + 0.00001;
                num = num.toFixed(length);
            }
            else
                num = "";

            obj.setValue(num);

        }
        catch (e) {
            obj.setValue("");
        }
    }
    else {
        obj.setValue("");
    }
}




function ShowDimensions() {

    if (event.keyCode == 119) {
        CompanyX.ShowDimension();
    }
   
   
}

function ShowDescription()
{
    if (event.keyCode == 119 && Request("type").toUpperCase() == "M") {

    CompanyX.ShowDescription();
    }
}


function SetRate() {
    CompanyX.SetRate();
}