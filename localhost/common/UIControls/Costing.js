
//function saveCost(value) {
//    $("#ucCost_hidCostSeed").val(value);
//    Ext.getCmp('ucCost_btnSaveCost').fireEvent('click', this);
//}

function BindingCost() {
    Ext.getCmp('ucCost_btnCancleCost').fireEvent('click', this);
}
function CurDefault() {
    var ppd = $("#ucCost_cos_PPD").val();
    if (ppd.toUpperCase() == "AGENT") {
        $("#ucCost_billcurrency").val($("#ucCost_hidFCur").val());
    }
    else {
        $("#ucCost_billcurrency").val($("#ucCost_hidLCur").val());
    }
}
function displayCost(type) {
    if ($("#ucCost_hidCostSys").val() == "A") {
        $("#cos_Item_O").css("display", "none");
        $("#cos_Item_A").css("display", "block");
    }
    switch (type) {
        case "AIM":
            $("#costTotalAll").css({ "width": "660", "height": "236px" });
            $("#addCostAll").css({ "width": "312px", "margin-left": "3px" });
            $("#addCost1").css("display", "none");
            $("#td_Currency").attr("width", "52");
            $("#td_EX").css("padding-left", "6");
            $("#td_Amount").css("width", "50");
            $("#td_Amount").attr("align", "right");
            $("#td_Company").attr("width", "60");
            $("#td_Item").attr("width", "60");
            $("#td_Calc").attr("width", "60");
            $("#td_Bill").attr("width", "60");
            $("#td_Remark").attr("width", "60");
            $("#addCost61").attr("width", "60");
            $("#addCost62").attr("width", "61");
            $("#cos_ItemA").attr("width", "69");
            $("#cos_ItemA").attr("tabindex", "34");
            $("#btnCostInsert").attr("tabindex", "40");
            $("#btnCostReset").attr("tabindex", "41");
            $("#btnCostDelete").attr("tabindex", "42");
            break;
        case "AIH":
            $("#costTotalAll").css({ "width": "666px", "height": "210px" });
            $("#addCostAll").css({ "width": "304px", "margin-left": "5px" });
            $("#addCost1").css("display", "none");
            $("#cos_ItemA").attr("width", "69");
            $("#cos_ItemA").attr("tabindex", "27");
            $("#btnCostInsert").attr("tabindex", "33");
            $("#btnCostReset").attr("tabindex", "33");
            $("#btnCostDelete").attr("tabindex", "33");
            $("#tb_addCost").attr("width", "304");
            $("#td_Company").attr("width", "55");
            $("#td_Company").css("padding-left", "7");
            $("#tb_Company").attr("width", "245"); 
            $("#td_Item").attr("width", "55");
            $("#td_Calc").attr("width", "55");
            $("#tb_Calc").attr("width", "245");
            $("#td_Bill").attr("width", "55");
            $("#tb_Bill").attr("width", "245");
            $("#addCost61").attr("width", "55");
            $("#addCost62").attr("width", "63");
            $("#tb_Min").attr("width", "182");
            $("#td_Remark").attr("width", "55");
            $("#td_cosAmount").attr("align", "right");
            $("#td_EX").attr("align", "right");
            $("#td_cosQty").attr("align", "right");
            break;
        case "AEM1":
            $("#costTotalAll").css({ "width": "672px", "height": "228px" });
            $("#cos_ItemA").attr("width", "69");
            $("#cos_ItemA").attr("tabindex", "33");
            $("#btnCostInsert").attr("tabindex", "41");
            $("#btnCostReset").attr("tabindex", "42");
            $("#btnCostDelete").attr("tabindex", "43");
            $("#td_Company").attr("width", "66");
            $("#td_EX").css("padding-left", "8px");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#tb_Amount").attr("width", "51");
            $("#tb_Amount").css("margin-left", "2px");
            break;
        case "AEM2":
            $("#costTotalAll").css({ "width": "670px", "height": "236px" });
            $("#addCostAll").css({ "width": "303px", "margin-left": "1px" });
            $("#cos_ItemA").attr("width", "69");
            $("#cos_ItemA").attr("tabindex", "34");
            $("#btnCostInsert").attr("tabindex", "40");
            $("#btnCostReset").attr("tabindex", "41");
            $("#btnCostDelete").attr("tabindex", "42");
            $("#tb_addCost").attr("width", "304");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "65");
            $("#td_EX").css("padding-left", "7px");
            $("#tb_Amount").css("margin-left", "1px");
            break;
        case "AEM3":
            $("#costTotalAll").css({ "width": "670px", "height": "232px" });
            $("#cos_ItemA").attr("width", "69");
            $("#cos_ItemA").attr("tabindex", "46");
            $("#btnCostInsert").attr("tabindex", "53");
            $("#btnCostReset").attr("tabindex", "53");
            $("#btnCostDelete").attr("tabindex", "53");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#tb_Amount").attr("width", "48");
            $("#td_EX").css("padding-left", "7px");
            break;
        case "AEH1":
            $("#costTotalAll").css({ "width": "420px", "height": "212px" });
            $("#addCostAll").css({ "width": "303px", "margin-left": "3px" });
            //$("#addCostAll").css({ "width": "280px" });
            $("#addCost4").css("display", "none");
            $("#cos_ItemA").attr("width", "69");
            $("#cos_ItemA").attr("tabindex", "52");
            $("#btnCostInsert").attr("tabindex", "58");
            $("#btnCostReset").attr("tabindex", "59");
            $("#btnCostDelete").attr("tabindex", "60");
            $("#tb_addCost").attr("width", "304");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#cos_Item_A").attr("width", "226");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_cosAmount").attr("align", "right");
            $("#tb_Amount").attr("width", "43");
            $("#tb_Rate").attr("width", "30");
            $("#td_EX").attr("align", "right");
            $("#td_Remark").attr("width", "66");
            break;
        case "AEH2":
            $("#costTotalAll").css({ "width": "675px", "height": "280px" });
            //$("#addCostAll").css({ "width": "289px" });
            $("#addCost7").css("display", "block");
            //$("#addCost61").css("display", "block");
            //$("#addCost62").css("display", "block");
            $("#cos_ItemA").attr("width", "69");
            $("#cos_ItemA").attr("tabindex", "27");
            $("#btnCostInsert").attr("tabindex", "35");
            $("#btnCostReset").attr("tabindex", "36");
            $("#btnCostDelete").attr("tabindex", "37");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#td_Show").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#tb_Amount").attr("width", "53");
            $("#td_EX").css("padding-left", "8px");
            $("#td_Qty").attr("width", "32");
            $("#td_Qty").css("margin-right", "1px");
            break;
        case "OIM":
            $("#costTotalAll").css({ "width": "670px", "height": "247px" });
            $("#addCostAll").css({ "width": "303px", "padding-left": "1px" });
            $("#cos_Item").attr("width", "69");
            $("#cos_Item").attr("tabindex", "37");
            $("#btnCostInsert").attr("tabindex", "44");
            $("#btnCostReset").attr("tabindex", "44");
            $("#btnCostDelete").attr("tabindex", "44");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#td_EX").css("padding-left", "8px");
            break;
        case "OIH":
            $("#costTotalAll").css({ "width": "670px", "height": "257px" });
            $("#addCostAll").css({ "width": "304px", "padding-left": "1px" });
            $("#cos_Item").attr("width", "69");
            $("#cos_Item").attr("tabindex", "31");
            $("#btnCostInsert").attr("tabindex", "39");
            $("#btnCostReset").attr("tabindex", "40");
            $("#btnCostDelete").attr("tabindex", "41");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#td_EX").css("padding-left", "8px");
            break;
        case "OEM":
            $("#costTotalAll").css({ "width": "670px", "height": "230px" });
            $("#addCostAll").css({ "width": "303px", "margin-left": "2px" });
            $("#cos_Item").attr("width", "69");
            $("#cos_Item").attr("tabindex", "37");
            $("#btnCostInsert").attr("tabindex", "44");
            $("#btnCostReset").attr("tabindex", "44");
            $("#btnCostDelete").attr("tabindex", "44");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#td_EX").css("padding-left", "8px");
            break;
        case "OEH":
            $("#costTotalAll").css({ "width": "672px", "height": "247px" });
            $("#cos_Item").attr("width", "69");
            $("#cos_Item").attr("tabindex", "31");
            $("#btnCostInsert").attr("tabindex", "39");
            $("#btnCostReset").attr("tabindex", "40");
            $("#btnCostDelete").attr("tabindex", "41");
            $("#td_EX").css("padding-left", "8px");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            break;
        case "ATM":
            $("#costTotalAll").css({ "width": "660px", "height": "230px" });
            $("#addCostAll").css({ "width": "315px" });
            $("#addCost1").css("display", "none");
            $("#cos_ItemA").attr("width", "69");
            $("#cos_ItemA").attr("tabindex", "23");
            $("#btnCostInsert").attr("tabindex", "30");
            $("#btnCostReset").attr("tabindex", "31");
            $("#btnCostDelete").attr("tabindex", "32");
            $("#td_EX").css("padding-left", "8px");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#td_cosAmount").css("padding-left", "3px");
            break;
        case "OTM":
            $("#costTotalAll").css({ "width": "654px", "height": "230px" });
            $("#addCostAll").css({ "width": "318px" });
            $("#addCost1").css("display", "none");
            $("#cos_Item").attr("width", "69");
            $("#cos_Item").attr("tabindex", "23");
            $("#btnCostInsert").attr("tabindex", "30");
            $("#btnCostReset").attr("tabindex", "31");
            $("#btnCostDelete").attr("tabindex", "32");
            $("#td_EX").css("padding-left", "8px");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#td_cosAmount").css("padding-left", "3px");
            break;
        case "DMM":
            $("#costTotalAll").css({ "width": "654px", "height": "230px" });
            $("#addCostAll").css({ "width": "318px", "margin-left": "2px" });
            $("#addCost1").css("display", "none");
            $("#cos_Item").attr("width", "69");
            $("#cos_Item").attr("tabindex", "23");
            $("#btnCostInsert").attr("tabindex", "30");
            $("#btnCostReset").attr("tabindex", "31");
            $("#btnCostDelete").attr("tabindex", "32");
            $("#td_EX").css("padding-left", "8px");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#td_cosAmount").css("padding-left", "3px");
            break;
        case "BKM":
            $("#costTotalAll").css({ "width": "654px", "height": "230px" });
            $("#addCostAll").css({ "width": "318px" });
            $("#addCost1").css("display", "none");
            $("#cos_Item").attr("width", "69");
            $("#cos_Item").attr("tabindex", "23");
            $("#btnCostInsert").attr("tabindex", "30");
            $("#btnCostReset").attr("tabindex", "31");
            $("#btnCostDelete").attr("tabindex", "32");
            $("#td_EX").css("padding-left", "8px");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#td_cosAmount").css("padding-left", "3px");
            break;
        case "TKM":
            $("#costTotalAll").css({ "width": "654px", "height": "230px" });
            $("#addCostAll").css({ "width": "318px" });
            $("#addCost1").css("display", "none");
            $("#cos_Item").attr("width", "69");
            $("#cos_Item").attr("tabindex", "26");
            $("#btnCostInsert").attr("tabindex", "34");
            $("#btnCostReset").attr("tabindex", "35");
            $("#btnCostDelete").attr("tabindex", "36");
            $("#td_EX").css("padding-left", "8px");
            $("#td_Company").attr("width", "66");
            $("#td_Item").attr("width", "65");
            $("#tb_Calc").attr("width", "226");
            $("#td_Calc").attr("width", "65");
            $("#tb_Bill").attr("width", "226");
            $("#td_Bill").attr("width", "65");
            $("#addCost61").attr("width", "65");
            $("#tb_Min").attr("width", "162");
            $("#td_Remark").attr("width", "66");
            $("#td_cosAmount").css("padding-left", "3px");
            break;

    }

}

//Index  //这里是获得悬浮行的每列的INDEX 悬浮的宽度
function numsIndex(costtype) {
    //0 宽度 1 ppdIndex 2 companyIndex 3 currencyIndex 4 totalIndex 5 amountIndex
    var list = new Array();
    if ("OEM,OEH,OIM,OIH,AEM1,AEM2,AEM3".indexOf(costtype) >= 0) {
        if (costtype == "OIM") {
            list[0] = 669;
        } else if (costtype == "AEM1") {
            list[0] = 669;
        }
        else if (costtype == "AEM2") {
            list[0] = 670;
        }
        else if (costtype == "AEM3") {
            list[0] = 667;
        }
        else {
            list[0] = 670;
        }
        list[1] = 1;
        list[2] = 2;
        list[3] = 6;
        list[4] = 9;
        list[5] = 8;
    }
    else if ("AIM,AIH,ATM,OTM,DMM,TKM,BKM".indexOf(costtype) >= 0) {
        if (costtype == "AIH") {
            list[0] = 663;
        } else if (costtype == "AIM") {
            list[0] = 655;
        }
        else if (costtype == "ATM") {
            list[0] = 659;
        }
        else if ("OTM,DMM,TKM,BKM".indexOf(costtype) >= 0) {
            list[0] = 650;
        }
        list[1] = -1;
        list[2] = 1;
        list[3] = 5;
        list[4] = 8;
        list[5] = 7;
    }
    else if ("AEH2".indexOf(costtype) >= 0) {
        list[0] = 673;
        list[1] = 1;
        list[2] = 2;
        list[3] = 4;
        list[4] = 8;
        list[5] = 7;
    }
    else if ("AEH1".indexOf(costtype) >= 0) {
        list[0] = 418;
        list[1] = 3;
        list[2] = 1;
        list[3] = 2;
        list[4] = 4;
        list[5] = 4;
    }
    return list;
}

//list set 悬浮的DIV
function setTotalDiv(costtype) {
    switch (costtype) {
        case "AIM":
            $(".costTotalDiv div.childdiv").css({ "width": "659px", "top": "-10px", "left": "-7px" });
            break;
        case "AIH":
            $(".costTotalDiv div.childdiv").css({ "width": "663px", "top": "-10px", "left": "-7px" });
            break;
        case "AEM1":
            $(".costTotalDiv div.childdiv").css({ "width": "669px", "top": "-10px", "left": "-7px" });
            break;
        case "AEM2":
            $(".costTotalDiv div.childdiv").css({ "width": "667px", "top": "-10px", "left": "-7px" });
            break;
        case "AEM3":
            $(".costTotalDiv div.childdiv").css({ "width": "667px", "top": "-10px", "left": "-7px" });
            break;
        case "AEH1":
            $(".costTotalDiv div.childdiv").css({ "width": "418px", "top": "-10px", "left": "-7px" });
            break;
        case "AEH2":
            $(".costTotalDiv div.childdiv").css({ "width": "673px", "top": "-10px", "left": "-7px" });
            break;
        case "OIM":
            $(".costTotalDiv div.childdiv").css({ "width": "668px", "top": "-10px", "left": "-7px" });
            break;
        case "OIH":
            $(".costTotalDiv div.childdiv").css({ "width": "668px", "top": "-10px", "left": "-7px" });
            break;
        case "OEM":
            $(".costTotalDiv div.childdiv").css({ "width": "668px", "top": "-10px", "left": "-7px" });
            break;
        case "OEH":
            $(".costTotalDiv div.childdiv").css({ "width": "670px", "top": "-10px", "left": "-7px" });
            break;
        case "ATM":
            $(".costTotalDiv div.childdiv").css({ "width": "659px", "top": "-10px", "left": "-7px" });
            break;
        case "OTM":
            $(".costTotalDiv div.childdiv").css({ "width": "650px", "top": "-10px", "left": "-7px" });
            break;
        case "DMM":
            $(".costTotalDiv div.childdiv").css({ "width": "650px", "top": "-10px", "left": "-7px" });
            break;
        case "BKM":
            $(".costTotalDiv div.childdiv").css({ "width": "650px", "top": "-10px", "left": "-7px" });
            break;
        case "TKM":
            $(".costTotalDiv div.childdiv").css({ "width": "650px", "top": "-10px", "left": "-7px" });
            break;
    }
}

var selectCostRow = -1;
$(function () {
    $("#costTotal tr.tr_line").live("mouseenter", function () {

        $(".costTotalDiv").children("div.childdiv").hide();
        var costtype = $("#ucCost_hidCostType").val();
        var getIndex = numsIndex(costtype);
        var ppd;
        if (getIndex[1] == -1) {
            ppd = "";
        } else {
            ppd = $(this).children("td").eq(getIndex[1]).text();
        }
        var company = $.trim($(this).children("td").eq(getIndex[2]).text());
        var currency = $.trim($(this).children("td").eq(getIndex[3]).text());

        var count = ucCost_gridCost.getStore().getTotalCount();
        var str = '';
        str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/cost/cost.png); width:' + getIndex[0] + 'px; height:9px;"></td></tr><tr><td style="width:' + getIndex[0] + 'px;text-align:left;border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;background-color:#FFFFFF">';
        str += '<table><tr><td><div class="scrolldiv"><table id="div_CostDetail" cellpadding="0" cellspacing="0" border="0">';
        for (var i = 0; i < count; i++) {
            var costrecord = ucCost_gridCost.getStore().getAt(i);
            var ppdvalue;
            if (getIndex[1] == -1) {
                ppdvalue = "";
            }
            else {
                ppdvalue = costrecord.data.PPD;
            }

            // 这里是悬浮的行
            if (ppdvalue == ppd && $.trim(costrecord.data.CompanyCode) == company && $.trim(costrecord.data.si_BillCurrency) == currency) {
                if ("OEH".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td width="46px;padding-right:5px;" >' + costrecord.data.curStatus + '</td><td style="text-align:center" width="49px">' + costrecord.data.PPD + '</td><td style="text-align:left; padding-left:5px" width="100px">' + costrecord.data.CompanyCode + '</td><td style="text-align:Center" width="49px">' + costrecord.data.Item + '</td>';
                    str += '<td style="text-align:right;padding-right:2px;" width="52px">' + costrecord.data.Qty + '</td><td style="text-align:Center" width="55px">' + costrecord.data.Unit + '</td><td style="text-align:Center" width="40px">' + costrecord.data.Currency + '</td>';
                    str += '<td style="text-align:right" width="87px">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="text-align:right" width="91px">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="text-align:right;" width="86px">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                } else if ("OEM".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td width="46px;padding-right:5px;" >' + costrecord.data.curStatus + '</td><td style="text-align:center" width="49px">' + costrecord.data.PPD + '</td><td style="text-align:left; padding-left:5px" width="103px">' + costrecord.data.CompanyCode + '</td><td style="text-align:Center" width="55px">' + costrecord.data.Item + '</td>';
                    str += '<td style="text-align:right;padding-right:2px;" width="46px">' + costrecord.data.Qty + '</td><td style="text-align:Center" width="51px">' + costrecord.data.Unit + '</td><td style="text-align:Center" width="40px">' + costrecord.data.Currency + '</td>';
                    str += '<td style="text-align:right" width="87px">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="text-align:right" width="91px">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="text-align:right;" width="86px">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                }
                else if ("OIM".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td width="42px" style="padding-right:5px">' + costrecord.data.curStatus + '</td><td width="48px">' + costrecord.data.PPD + '</td><td  style="text-align:left; padding-left:5px" width="108px">' + costrecord.data.CompanyCode + '</td><td width="46px">' + costrecord.data.Item + '</td>';
                    str += '<td width="56px" style="text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td width="51px">' + costrecord.data.Unit + '</td><td width="48px">' + costrecord.data.Currency + '</td>';
                    str += '<td width="82px" style="text-align:right">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td width="82px" style="text-align:right">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td width="85px" style="text-align:right">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                } else if ("OIH".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:42px;padding-right:5px">' + costrecord.data.curStatus + '</td><td  style="width:50px">' + costrecord.data.PPD + '</td><td style="width:108px;text-align:left; padding-left:5px">' + costrecord.data.CompanyCode + '</td><td style="width:48px">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:57px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:50px">' + costrecord.data.Unit + '</td><td style="width:50px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="width:78px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="text-align:right" width="93">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:86px;text-align:right;padding-right:2px;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                } else if ("AIM".indexOf(costtype) >= 0) {
                    //                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:45px;text-align:center;padding-right:5px">' + costrecord.data.curStatus + '</td><td style="width:116px;text-align:left; padding-left:2px">' + costrecord.data.CompanyCode + '</td><td style="width:54px;text-align:center;">' + costrecord.data.Item + '</td>';
                    //                    str += '<td style="width:52px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:60px;text-align:center;">' + costrecord.data.Unit + '</td><td style="width:55px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    //                    str += '<td style="width:77px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="width:86px;text-align:right">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:84px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                    //                }
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:43px;text-align:center;padding-right:5px">' + costrecord.data.curStatus + '</td><td style="width:118px;text-align:left; padding-left:2px">' + costrecord.data.CompanyCode + '</td><td style="width:60px;text-align:center;">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:58px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:56px;text-align:center;">' + costrecord.data.Unit + '</td><td style="width:55px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="width:79px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="width:86px;text-align:right">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:84px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                }
                else if ("AIH".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:43px;text-align:center;padding-right:5px">' + costrecord.data.curStatus + '</td><td style="width:108px;text-align:left; padding-left:2px">' + costrecord.data.CompanyCode + '</td><td style="width:56px;text-align:center;">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:56px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:59px;text-align:right;">' + costrecord.data.Unit + '</td><td style="text-align:center" width="69px">' + costrecord.data.Currency + '</td>';
                    str += '<td style="text-align:right;" width="78px">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="text-align:right" width="87px">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="text-align:right;" width="90px">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                }
                else if ("ATM".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:50px;padding-right:5px">' + costrecord.data.curStatus + '</td><td style="width:108px;text-align:left; padding-left:5px">' + costrecord.data.CompanyCode + '</td><td style="width:60px;text-align:center;">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:52px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:69px;text-align:center;">' + costrecord.data.Unit + '</td><td style="width:45px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="width:86px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="width:85px;text-align:right">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:85px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                } else if ("OTM".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td width="50px" style="padding-right:5px">' + costrecord.data.curStatus + '</td><td style="width:125px;text-align:left; padding-left:5px">' + costrecord.data.CompanyCode + '</td><td style="width:46px">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:58px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:53px">' + costrecord.data.Unit + '</td><td style="width:46px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="width:85px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="width:82px;text-align:right;">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:86px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                } else if ("BKM".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td width="54px" style="padding-right:5px">' + costrecord.data.curStatus + '</td><td style="width:108px;text-align:left;pddding-left:7px">' + costrecord.data.CompanyCode + '</td><td style="width:53px;text-align:center;">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:56px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:60px;text-align:center;">' + costrecord.data.Unit + '</td><td style="width:53px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="width:85px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="width:82px;text-align:right">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:85px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                } else if ("DMM".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td width="50px" style="padding-right:5px">' + costrecord.data.curStatus + '</td><td style="width:118px;text-align:left;padding-left:5px">' + costrecord.data.CompanyCode + '</td><td style="width:48px;text-align:center;">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:53px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:60px;text-align:center;">' + costrecord.data.Unit + '</td><td style="width:50px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="width:83px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="width:84px;text-align:right">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:85px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                }
                else if ("TKM".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td width="55px" style="padding-right:5px">' + costrecord.data.curStatus + '</td><td style="width:113px;text-align:left; pddding-left:7px">' + costrecord.data.CompanyCode + '</td><td style="width:53px">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:52px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:62px; text-align:center">' + costrecord.data.Unit + '</td><td style="width:50px">' + costrecord.data.Currency + '</td>';
                    str += '<td style="width:79px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="width:87px;text-align:right">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:85px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                }
                else if ("AEM1".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:44px;padding-right:5px;text-align:center;">' + costrecord.data.curStatus + '</td><td  style="width:38px;text-align:center;">' + costrecord.data.PPD + '</td><td style="width:128px;text-align:left;padding-left:8px">' + costrecord.data.CompanyCode + '</td><td style="width:46px;text-align:center;">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:47px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:39px;text-align:center;">' + costrecord.data.Unit + '</td><td style="width:38px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="text-align:right;" width="90px">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="text-align:right" width="86px">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:90px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                }
                else if ("AEM2".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:40px;padding-right:5px;text-align:center;">' + costrecord.data.curStatus + '</td><td  style="width:47px;text-align:center;">' + costrecord.data.PPD + '</td><td style="width:140px;text-align:left; padding-left:6px">' + costrecord.data.CompanyCode + '</td><td style="width:43px;text-align:center;">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:44px;text-align:right;padding-right:2px;">' + costrecord.data.Qty + '</td><td style="width:43px;text-align:center;">' + costrecord.data.Unit + '</td><td style="width:38px;text-align:center;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="width:85px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="text-align:right" width="82px">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:84px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                }
                else if ("AEM3".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:42px;padding-right:5px;text-align:center;">' + costrecord.data.curStatus + '</td><td style="text-align:center" width="48px">' + costrecord.data.PPD + '</td><td style="text-align:left; padding-left:5px" width="130px">' + costrecord.data.CompanyCode + '</td><td style="text-align:Center" width="53px">' + costrecord.data.Item + '</td>';
                    str += '<td style="text-align:right;padding-right:2px;" width="56px">' + costrecord.data.Qty + '</td><td style="text-align:Center" width="43px">' + costrecord.data.Unit + '</td><td style="text-align:Center" width="38px">' + costrecord.data.Currency + '</td>';
                    str += '<td style="text-align:right" width="76px">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="text-align:right" width="81px">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="text-align:right" width="79px">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td></tr>';
                }
                else if ("AEH1".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:52px;padding-right:6px;text-align:center;">' + costrecord.data.Item + '</td><td style="text-align:left;width:119px; padding-left:2px">' + costrecord.data.CompanyCode + '</td>';
                    str += '<td style="text-align:Center;width:58px;">' + costrecord.data.Currency + '</td>';
                    str += '<td style="text-align:right;width:88px;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td><td style="text-align:right;width:83px">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td></tr>';
                }
                else if ("AEH2".indexOf(costtype) >= 0) {
                    str += '<tr style="line-height:20px;cursor:pointer;" onclick="SelectRecordCostTotal(' + i + ')" class="tr_CostDetail"><td style="width:42px;padding-right:4px;text-align:center;">' + costrecord.data.curStatus + '</td><td  style="width:38px;text-align:center;">' + costrecord.data.PPD + '</td><td style="width:125px;text-align:left; padding-left:6px">' + costrecord.data.CompanyCode + '</td><td style="width:41px;text-align:center;">' + costrecord.data.Item + '</td>';
                    str += '<td style="width:45px;text-align:center;">' + costrecord.data.Currency + '</td><td style="width:73px;text-align:right;">' + costrecord.data.Min + '</td><td style="width:80px;text-align:right;">' + (costrecord.data.Rate == '' ? '' : Number(costrecord.data.Rate).toFixed(3)) + '</td>';
                    str += '<td style="width:79px;text-align:right;">' + (costrecord.data.Amount == '' ? '' : Number(costrecord.data.Amount).toFixed(2)) + '</td><td style="width:80px;text-align:right;">' + (costrecord.data.Total == '' ? '' : Number(costrecord.data.Total).toFixed(2)) + '</td><td style="width:50px;text-align:center;">' + costrecord.data.Show + '</td></tr>';
                }

            }
        }
        str += '</table></div></td></tr></table>';
        str += '</td></tr><tr><td style="border-bottom: 1px solid #8DB2E3; width:' + getIndex[0] + 'px;"></td></tr></table>';

        setTotalDiv(costtype);

        $(this).find(".costTotalDiv").children("div.childdiv").html(str).show();

        var t = $(this).find(".scrolldiv").offset().top;
        var s = $(this).find(".scrolldiv").height();
        var c = document.documentElement.clientHeight;

        //       alert("C：" + c + " S: " + s + " T: " + t +" height: "+ (c-t-30));

        // GRACE 2015-09-22 解决有时悬浮DIV高度显示不正常的问题
//        if (t + s + 30 > c) {
//            $(".scrolldiv").css({ "max-height": c - t - 30, "height": c - t - 30 });
//        }

        if (s > 196) {
          
            $(".scrolldiv").css({ "max-height": 196, "height": 196 });
        }


        $("#div_CostDetail tr.tr_CostDetail").each(function () {
            $(this).hover(function () {
                $(this).css({ "background": "#dfe8f6" });
            }, function () {
                $(this).css({ "background": "#fff" });
            });
        });

    }).live("mouseleave", function () {
        $(this).find(".costTotalDiv").children("div.childdiv").hide();
    });

});


function CostTotalList() {
    $("#costTotal table.table_gridcost").remove();
    var costtype = $("#ucCost_hidCostType").val();
    var getIndex = numsIndex(costtype);
    var str = '';
    //header
    str += '<table  class="table_gridcost"  cellpadding="0" cellspacing="0"  id="table_grid_cost"><tr class="td_header">';
    // 这里是每个GIRD的列名
    if ("OEM,OEH".indexOf(costtype) >= 0) {
        str += '<td style="width:40px;text-align:center;">Status</td><td style="width:40px;text-align:center;">A/L</td><td style="width:100px;text-align:center;">Company</td><td style="width:40px;text-align:center;">Item</td>';
        str += '<td style="width:43px;text-align:center;">Qty</td><td style="width:40px;text-align:center;">Unit</td><td style="width:40px;text-align:center;">CUR</td>';
        str += '<td style="width:75px;text-align:center;">Rate</td><td style="width:86px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("OIM".indexOf(costtype) >= 0) {
        str += '<td style="width:40px;text-align:center;">Status</td><td style="width:40px;text-align:center;">A/L</td><td style="width:100px;text-align:center;">Company</td><td style="width:40px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:40px;text-align:center;">Unit</td><td style="width:40px;text-align:center;">CUR</td>';
        str += '<td style="width:74px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("OIH".indexOf(costtype) >= 0) {
        str += '<td style="width:40px;text-align:center;">Status</td><td style="width:40px;text-align:center;">A/L</td><td style="width:100px;text-align:center;">Company</td><td style="width:40px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:40px;text-align:center;">Unit</td><td style="width:40px;text-align:center;">CUR</td>';
        str += '<td style="width:72px;text-align:center;">Rate</td><td style="width:83px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("AIM".indexOf(costtype) >= 0) {
//        str += '<td style="width:40px;text-align:center;">Status</td><td style="width:110px;text-align:center;">Company</td><td style="width:45px;text-align:center;">Item</td>';
//        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:45px;text-align:center;">Unit</td><td style="width:45px;text-align:center;">CUR</td>';
//        str += '<td style="width:73px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
//    }
        str += '<td style="width:40px;text-align:center;">Status</td><td style="width:118px;text-align:center;">Company</td><td style="width:45px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:45px;text-align:center;">Unit</td><td style="width:45px;text-align:center;">CUR</td>';
        str += '<td style="width:75px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("AIH".indexOf(costtype) >= 0) {
        str += '<td style="width:40px;text-align:center;">Status</td><td style="width:100px;text-align:center;">Company</td><td style="width:50px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:50px;text-align:center;">Unit</td><td style="width:50px;text-align:center;">CUR</td>';
        str += '<td style="width:74px;text-align:center;">Rate</td><td style="width:80px;text-align:center;">Amount</td><td style="width:80px;text-align:center;">Total</td>';
    }
    else if ("ATM".indexOf(costtype) >= 0) {
        str += '<td style="width:50px;text-align:center;">Status</td><td style="width:100px;text-align:center;">Company</td><td style="width:50px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:50px;text-align:center;">Unit</td><td style="width:46px;text-align:center;">CUR</td>';
        str += '<td style="width:75px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("OTM".indexOf(costtype) >= 0) {
        str += '<td style="width:50px;text-align:center;">Status</td><td style="width:117px;text-align:center;">Company</td><td style="width:40px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:40px;text-align:center;">Unit</td><td style="width:40px;text-align:center;">CUR</td>';
        str += '<td style="width:75px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("BKM".indexOf(costtype) >= 0) {
        str += '<td style="width:50px;text-align:center;">Status</td><td style="width:102px;text-align:center;">Company</td><td style="width:45px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:45px;text-align:center;">Unit</td><td style="width:45px;text-align:center;">CUR</td>';
        str += '<td style="width:75px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("DMM".indexOf(costtype) >= 0) {
        str += '<td style="width:50px;text-align:center;">Status</td><td style="width:110px;text-align:center;">Company</td><td style="width:40px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:44px;text-align:center;">Unit</td><td style="width:43px;text-align:center;">CUR</td>';
        str += '<td style="width:75px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("TKM".indexOf(costtype) >= 0) {
        str += '<td style="width:50px;text-align:center;">Status</td><td style="width:105px;text-align:center;">Company</td><td style="width:45px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:45px;text-align:center;">Unit</td><td style="width:45px;text-align:center;">CUR</td>';
        str += '<td style="width:75px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("AEM1".indexOf(costtype) >= 0) {
        str += '<td style="text-align:center;" width="40px">Status</td><td style="width:35px;text-align:center;">A/L</td><td style="width:126px;text-align:center;">Company</td><td style="text-align:center;" width="30px">Item</td>';
        str += '<td style="width:40px;text-align:center;">Qty</td><td style="width:30px;text-align:center;">Unit</td><td style="width:30px;text-align:center;">CUR</td>';
        str += '<td style="width:80px">Rate</td><td style="width:80px">Amount</td><td style="width:80px">Total</td>';
    }
    else if ("AEM2".indexOf(costtype) >= 0) {
        str += '<td style="width:39px;text-align:center;">Status</td><td style="width:39px;text-align:center;">A/L</td><td style="width:135px;text-align:center;">Company</td><td style="width:35px;text-align:center;">Item</td>';
        str += '<td style="width:35px;text-align:center;">Qty</td><td style="width:30px;text-align:center;">Unit</td><td style="width:30px;text-align:center;">CUR</td>';
        str += '<td style="width:75px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td><td style="width:75px;text-align:center;">Total</td>';
    }
    else if ("AEM3".indexOf(costtype) >= 0) {
        str += '<td style="width:40px;text-align:center;">Status</td><td style="width:40px;text-align:center;">A/L</td><td style="width:125px;text-align:center;">Company</td><td style="width:40px;text-align:center;">Item</td>';
        str += '<td style="width:50px;text-align:center;">Qty</td><td style="width:32px;text-align:center;">Unit</td><td style="width:32px;text-align:center;">CUR</td>';
        str += '<td style="width:70px;text-align:center;">Rate</td><td style="width:70px;text-align:center;">Amount</td><td style="width:70px;text-align:center;">Total</td>';
    }
    else if ("AEH1".indexOf(costtype) >= 0) {
        str += '<td style="width:50px;text-align:center;">Item</td><td style="width:113px;text-align:center;">Code</td>';
        str += '<td style="width:50px;text-align:center;">CUR</td>';
        str += '<td style="width:80px;text-align:center;">Rate</td><td style="width:75px;text-align:center;">Amount</td>';
    }
    else if ("AEH2".indexOf(costtype) >= 0) {
        str += '<td style="width:40px;text-align:center;">Status</td><td style="width:30px;text-align:center;">A/L</td><td style="width:120px;text-align:center;">Company</td><td style="width:33px;text-align:center;">Item</td>';
        str += '<td style="width:30px;text-align:center;">CUR</td><td style="width:70px;text-align:center;">Min</td><td style="width:70px;text-align:center;">Rate</td>';
        str += '<td style="width:70px;text-align:center;">Amount</td><td style="width:70px;text-align:center;">Total</td><td style="width:40px;text-align:center;">Show</td>';
    }
    str += '</tr></table>';
    $("#costTotal").append(str);

    var count = ucCost_gridCost.getStore().getTotalCount();
    if (count > 0) {
        for (var i = 0; i < count; i++) {
            var strline = '';
            var costrecord = ucCost_gridCost.getStore().getAt(i);
            var ppd;
            if (getIndex[1] == -1) {
                ppd = "";
            }
            else {
                ppd = costrecord.data.PPD;
            }
            var company = costrecord.data.CompanyCode;
            var currency = costrecord.data.si_BillCurrency;
            var total = 0;
            var amount = 0;

            if (i > 0) {
                var totalcount = $("#costTotal tr.tr_line").size();
                var flag = "N";
                for (var j = 0; j < totalcount; j++) {
                    var ppdvalue;
                    if (getIndex[1] == -1) {
                        ppdvalue = "";
                    }
                    else {
                        ppdvalue = $("#costTotal tr.tr_line").eq(j).children("td").eq(getIndex[1]).text();
                    }
                    if (ppdvalue == ppd && $("#costTotal tr.tr_line").eq(j).children("td").eq(getIndex[2]).text() == company && $("#costTotal tr.tr_line").eq(j).children("td").eq(getIndex[3]).text() == currency) {

                        total = Number(costrecord.data.Total) + Number($("#costTotal tr.tr_line").eq(j).children("td").eq(getIndex[4]).text());
                        amount = total;

                        $("#costTotal tr.tr_line").eq(j).children("td").eq(getIndex[4]).text(total == 0 ? '' : Number(total).toFixed(2));
                        $("#costTotal tr.tr_line").eq(j).children("td").eq(getIndex[5]).text(amount == 0 ? '' : Number(amount).toFixed(2));

                        var sta1 = $("#costTotal tr.tr_line").eq(j).children("td").eq(0).find("div.costStatus").text();
                        var sta2 = costrecord.data.curStatus;
                        if ((sta1 == "" && sta2 != "") || (sta1 != "" && sta2 == "") || sta2.indexOf(sta1) < 0) {
                            $("#costTotal tr.tr_line").eq(j).children("td").eq(0).find("div.costStatus").empty();
                        }

                        flag = "Y";
                        break;
                    }
                }
                //这里是每行（不是悬浮行）
                if (flag == "N") {
                    if (costrecord.data.Total == '' || costrecord.data.Total == null) {
                        total = '';
                        amount = '';
                    }
                    else {
                        total = Number(costrecord.data.Total).toFixed(2);
                        amount = total;
                    }
                    if ("OEM,OEH,OIM,OIH,AEM1,AEM2,AEM3".indexOf(costtype) >= 0) {
                        strline += '<tr class="tr_line" style="line-height:20px;"><td><div style="height:20px;" class="costStatus">' + costrecord.data.curStatus + '</div><div class="costTotalDiv"><div class="childdiv"></div></div></td><td>' + ppd + '</td><td style="text-align:left">' + company
                         + '</td><td></td><td></td><td></td><td>' + currency + '</td><td></td><td style="text-align:right;">' + amount + '</td><td style="text-align:right;font-weight:bold;">' + total + '</td></tr>';
                    }
                    else if ("AIM,AIH,ATM,OTM,DMM,TKM,BKM".indexOf(costtype) >= 0) {
                        strline += '<tr class="tr_line" style="line-height:20px;"><td><div style="height:20px;" class="costStatus">' + costrecord.data.curStatus + '</div><div class="costTotalDiv"><div class="childdiv"></div></div></td><td  style="text-align:left">' + company
                         + '</td><td></td><td></td><td></td><td>' + currency + '</td><td></td><td style="text-align:right;">' + amount + '</td><td style="text-align:right;font-weight:bold;">' + total + '</td></tr>';
                    }
                    else if ("AEH2".indexOf(costtype) >= 0) {
                        strline = '<tr class="tr_line"  style="line-height:20px"><td><div style="height:20px;" class="costStatus">' + costrecord.data.curStatus + '</div><div class="costTotalDiv"><div class="childdiv"></div></div></td><td >' + ppd + '</td><td style="text-align:left">' + company
                         + '</td><td></td><td>' + currency + '</td><td></td><td></td><td style="text-align:right;">' + amount + '</td><td style="text-align:right;font-weight:bold;">' + total + '</td><td></td></tr>';
                    }
                    else if ("AEH1".indexOf(costtype) >= 0) {
                        strline += '<tr class="tr_line" style="line-height:20px;"><td><div style="height:20px;" class="costStatus">' + costrecord.data.curStatus + '</div><div class="costTotalDiv"><div class="childdiv"></div></div></td><td style="text-align:left">' + company + '</td><td>' + currency + '</td><td><span style="display:none;">' + ppd + '</span></td><td style="text-align:right;">' + amount + '</td></tr>';
                    }
                    $("#table_grid_cost").append(strline);
                }
            }
            else {
                if (costrecord.data.Total == '' || costrecord.data.Total == null) {
                    total = '';
                    amount = '';
                }
                else {
                    total = Number(costrecord.data.Total).toFixed(2);
                    amount = total;
                }
                if ("OEM,OEH,OIM,OIH,AEM1,AEM2,AEM3".indexOf(costtype) >= 0) {
                    strline += '<tr class="tr_line" style="line-height:20px;"><td><div style="height:20px;" class="costStatus">' + costrecord.data.curStatus + '</div><div class="costTotalDiv"><div class="childdiv"></div></div></td><td>' + ppd + '</td><td style="text-align:left">' + company
                     + '</td><td></td><td></td><td></td><td>' + currency + '</td><td></td><td style="text-align:right;">' + amount + '</td><td style="text-align:right;font-weight:bold;">' + total + '</td></tr>';
                }
                else if ("AIM,AIH,ATM,OTM,DMM,TKM,BKM".indexOf(costtype) >= 0) {
                    strline += '<tr class="tr_line" style="line-height:20px;"><td><div style="height:20px;" class="costStatus">' + costrecord.data.curStatus + '</div><div class="costTotalDiv"><div class="childdiv"></div></div></td><td  style="text-align:left">' + company
                     + '</td><td></td><td></td><td></td><td>' + currency + '</td><td></td><td style="text-align:right;">' + amount + '</td><td style="text-align:right;font-weight:bold;">' + total + '</td></tr>';
                }
                else if ("AEH2".indexOf(costtype) >= 0) {
                    strline = '<tr class="tr_line"  style="line-height:20px"><td><div style="height:20px;" class="costStatus">' + costrecord.data.curStatus + '</div><div class="costTotalDiv"><div class="childdiv"></div></div></td><td >' + ppd + '</td><td style="text-align:left">' + company
                     + '</td><td></td><td>' + currency + '</td><td></td><td></td><td style="text-align:right;">' + amount + '</td><td style="text-align:right;font-weight:bold;">' + total + '</td><td></td></tr>';
                }
                else if ("AEH1".indexOf(costtype) >= 0) {
                    strline += '<tr class="tr_line" style="line-height:20px;"><td><div style="height:20px;" class="costStatus">' + costrecord.data.curStatus + '</div><div class="costTotalDiv"><div class="childdiv"></div></div></td><td style="text-align:left">' + company + '</td><td>' + currency + '</td><td><span style="display:none;">' + ppd + '</span></td><td style="text-align:right;">' + amount + '</td></tr>';
                }
                $("#table_grid_cost").append(strline);
            }
        }
    }
}


function CostInsertRecord() {
   
        var PPD = $("#ucCost_cos_PPD").val();
        var company = $("#cos_Company").val().toUpperCase();
        var companyName = $("#cos_Company_text").val().toUpperCase();
        var item;
        var description;
        if ($("#ucCost_hidCostSys").val() == "A") {
            item = $("#cos_ItemA").val();
            description = $("#cos_ItemA_text").text();
        } else {
            item = $("#cos_Item").val();
            description = $("#cos_Item_text").text();
        }
        var calc = $("#ucCost_cos_Calc").val();
        var qty = $("#ucCost_cos_Qty").val();
        var unit = $("#ucCost_cos_Unit").val();
        var currency = $("#ucCost_cos_Currency").val();
        var billcurrency = $("#ucCost_billcurrency").val();
        var ex = $("#ucCost_cos_EX").val();
        var rate = $("#ucCost_cos_Rate").val();
        var amount = $("#ucCost_cos_Amount").val();
        var min = $("#ucCost_cos_Min").val();
        var percent = $("#ucCost_cos_Percent").val();
        var show = $("#ucCost_cos_Show").val();
        var remark = $("#ucCost_cos_Remark").val().toUpperCase();

        if ($("#ucCost_hidCostType").val() != "AEH2") {
            show = "";
        }
        var total;
        //    if (amount == "" || amount == undefined) {
        //        if (min == undefined || min == "") {
        //            total = qty * rate;
        //        }
        //        else {
        //            total = qty * rate > min ? qty * rate : min;
        //        }
        //    }
        //    else {
        //        total = amount;
        //    }

        if (company == "" || company == undefined) {
            $("#cos_Company").focus();
            return;
        }

        if ($("#cos_Company").attr("validata") == "false") {
            $("#cos_Company").focus();
            return;
        }

        if (item == "" || item == undefined) {
            $("#cos_Item").focus();
            return;
        }
        if (billcurrency == "" || billcurrency == undefined) {
            $("#ucCost_billcurrency").focus();
            return;
        }
        if (currency == "" || currency == undefined) {
            $("#ucCost_cos_Currency").focus();
            return;
        }
        if (ex == "" || ex == undefined) {
            $("#ucCost_cos_EX").focus();
            return;
        }

        //Make Data
        if (percent == "" || percent == undefined) {
            percent = 100;
        }
        var atotal, ftotal, round, markUp, markDown;

        var ItemRecord = StoreGetItem.getById(item);
        if (ItemRecord != null && ItemRecord != undefined) {
            if (PPD.toUpperCase() == "AGENT") {
                round = ItemRecord.data.itm_FRound;
                markDown = ItemRecord.data.itm_FMarkDown;
                markUp = ItemRecord.data.itm_FMarkUp;
            }
            else {
                round = ItemRecord.data.itm_LRound;
                markDown = ItemRecord.data.itm_LMarkDown;
                markUp = ItemRecord.data.itm_LMarkUp;
            }
        }
        else {
            round = 2;
            markDown = false;
            markUp = false;
        }
        if (round == undefined && markDown == undefined && markUp == undefined) {
            round = 2;
            markDown = false;
            markUp = false;
        }
        if (round == null || round == "") { round = 2; }
        if ((markDown == "" || markDown == null) && (markUp == "" || markUp == null)) { markDown = false; markUp = false; }

        if (amount != "") {
            atotal = Number(amount);
        }
        else {
            if (rate != undefined && rate != "" && qty != undefined && qty != "") {
                atotal = Number(rate) * Number(qty);
            }
            else {
                atotal = "";
            }

            if (min != undefined && min != "") {
                var s = Number(min);
                if (atotal != "") {
                    atotal = atotal > s ? atotal : s;
                }
                else {
                    atotal = s;
                }
            }
        }


        if (atotal == "") {
            ftotal = ""; total = "";
        }
        else {
            //        if (currency == billcurrency && ex == 1) {
            //            ftotal = "";
            //        }
            //        else {
            ftotal = Number(atotal) * 1000 * Number(percent) / 100000;
            ftotal = getDecimal(ftotal, round, markUp, markDown);
            //}

            //GRACE 2015-08-21 
            if (amount != "") {
                total = atotal;
                ftotal = atotal;
            } else {
                atotal = Number(atotal) * 1000 * Number(percent) * Number(ex) / 100000;
                total = getDecimal(atotal, round, markUp, markDown);
            }
        }



        var count = ucCost_gridCost.store.getTotalCount();  // 获取当前行数
        if (selectCostRow >= 0) {
            var record = ucCost_gridCost.getStore().getAt(selectCostRow); // 获取当前行的数据
            record.set("PPD", PPD);
            record.set("CompanyCode", company);
            record.set("CompanyName", companyName);
            record.set("Item", item);
            record.set("Description", description);
            record.set("Total", total);
            record.set("CalcKind", calc);
            record.set("Qty", qty);
            record.set("Unit", unit);
            record.set("Currency", currency);
            record.set("EX", ex);
            record.set("Rate", rate);
            record.set("Amount", amount);
            record.set("Remark", remark);
            record.set("si_BillCurrency", billcurrency);
            record.set("Min", min);
            record.set("Show", show);
            record.set("Percent", percent);
            record.set("ATotal", total);
            record.set("FTotal", ftotal);
        }
        else {
            ucCost_gridCost.insertRecord(count, { PPD: PPD, EX: ex, CompanyCode: company, CompanyName: companyName, Description: description, Item: item, Total: total, CalcKind: calc, Qty: qty, Unit: unit, Currency: currency, Rate: rate, Amount: amount, Remark: remark, si_BillCurrency: billcurrency, Min: min, Show: show, Percent: percent, ATotal: total, FTotal: ftotal });
        }

        ucCost_gridCost.getView().refresh();
        ucCost_gridCost.view.focusEl.focus();
        CostTotalList();
        CostResetRecord();


}

function SelectRecordCostTotal(index) {
    selectCostRow = index;
    CostSelectRecord();
}

function CostSelectRecord() {
    try {
        Invlidata("cos_Company");
        var record = ucCost_gridCost.getStore().getAt(selectCostRow); // 获取当前行的数据
        if (record == null || record == undefined)
            return;
        else {

            $("#ucCost_cos_PPD").val(record.data.PPD);
            $("#cos_Company").val(record.data.CompanyCode);
            $("#cos_Company_text").val(record.data.CompanyName);
            $("#cos_Company_text1").val(record.data.CompanyName);
            if ($("#ucCost_hidCostSys").val() == "A") {
                $("#cos_ItemA").val(record.data.Item);
                $("#cos_ItemA_text").text(record.data.Description);
            }
            else {
                $("#cos_Item").val(record.data.Item);
                $("#cos_Item_text").text(record.data.Description);
            }
            $("#ucCost_cos_Calc").val(record.data.CalcKind);
            $("#ucCost_cos_Qty").val(record.data.Qty);
            $("#ucCost_cos_Unit").val(record.data.Unit);
            $("#ucCost_cos_Currency").val(record.data.Currency);
            $("#ucCost_billcurrency").val(record.data.si_BillCurrency);
            $("#ucCost_cos_EX").val(record.data.EX);
            $("#ucCost_cos_Rate").val(record.data.Rate);
            $("#ucCost_cos_Amount").val(record.data.Amount);
            $("#ucCost_cos_Min").val(record.data.Min);
            $("#ucCost_cos_Percent").val(record.data.Percent);
            $("#ucCost_cos_Show").val(record.data.Show);
            $("#ucCost_cos_Remark").val(record.data.Remark);

            if (record.data.curStatus == "" && isdisabled == 0) {
                $("#btnCostInsert").removeClass("x-item-disabled").attr("disabled", "").css("cursor", "pointer");
                $("#btnCostDelete").removeClass("x-item-disabled").attr("disabled", "").css("cursor", "pointer");
            }
            else {
                $("#btnCostInsert").addClass("x-item-disabled").attr("disabled", "disabled").css("cursor", "default");
                $("#btnCostDelete").addClass("x-item-disabled").attr("disabled", "disabled").css("cursor", "default");
            }

        }
    } catch (e) {
        $("#btnCostInsert").addClass("x-item-disabled").attr("disabled", "disabled").css("cursor", "default");
        $("#btnCostDelete").addClass("x-item-disabled").attr("disabled", "disabled").css("cursor", "default");
    }
}

function CostDeleteRecord() {
    var record = ucCost_gridCost.getStore().getAt(selectCostRow); // 获取当前行的数据
    if (record == null || record == undefined)
        return;
    else {
        if (record.data.curStatus == "") {
            var ppd = record.data.PPD;
            var company = record.data.CompanyCode;
            var currency = record.data.Currency;
            ucCost_gridCost.getSelectionModel().selectRow(selectCostRow);
            ucCost_gridCost.deleteSelected();
            CostTotalList();
            CostResetRecord();
        }
    }

}

function CostResetRecord() {
    //Invlidata("cos_Company");
    selectCostRow = -1;
    //$("#ucCost_cos_PPD").val("").focus();
    //$("#cos_Company").val("");
    //$("#cos_Company_text1").val("");
    //$("#cos_Company_text").val("");
    if ($("#ucCost_hidCostSys").val() == "A") {
        $("#cos_ItemA").val("").focus();
        $("#cos_ItemA_text").text("");
    } else {
        $("#cos_Item").val("").focus();
        $("#cos_Item_text").text("");
    }
    $("#ucCost_cos_Calc").val("");
    $("#ucCost_cos_Qty").val("");
    $("#ucCost_cos_Unit").val("");
    $("#ucCost_cos_Currency").val("");
    $("#ucCost_cos_EX").val("");
    $("#ucCost_cos_Rate").val("");
    $("#ucCost_cos_Amount").val("");
    $("#ucCost_cos_Min").val("");
    $("#ucCost_cos_Percent").val("100");
    if ($("#ucCost_hidCostType").val() != "AEH2") {
        $("#ucCost_cos_Show").val("");
    }
    $("#ucCost_cos_Remark").val("");
    $("#btnCostInsert").removeClass("x-item-disabled").attr("disabled", "").css("cursor", "pointer");
}

function getDecimal(num, v, isUp, isDown) {
    var b = true;  // 是否正数   
    //v = 2;
    num = num == null ? 0 : num;
    var SumTotal = num;

    if (SumTotal < 0)
    { b = false; SumTotal = Math.abs(SumTotal); num = Math.abs(num); }

    var vv = Math.pow(0.1, v);

    SumTotal = ToFixed(SumTotal, v);
    //var SumTotal = formatNumber(num, format);

    if (num == SumTotal) {
        SumTotal = (b ? 1 : -1) * SumTotal;
        return Round(SumTotal, 2);
    }

    if (isUp)
        if (SumTotal < num)
            SumTotal = SumTotal + vv;
    if (isDown)
        if (SumTotal > num)
            SumTotal = SumTotal - vv;
    if (!b)
        SumTotal = SumTotal * (-1);
    return Round(SumTotal, 2);
}

function ToFixed(number, fractionDigits) {
    with (Math) {
        return round(number * pow(10, fractionDigits)) / pow(10, fractionDigits);
    }
}


function Round(total, num) {
    var vv = Math.pow(10, num);
    return Math.round(total * vv) / vv;
}