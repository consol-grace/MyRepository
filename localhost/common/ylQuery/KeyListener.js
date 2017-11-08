
///屏蔽F1- F12 按键功能 兼容 IE   FF   Chrome
var check = function (e) {
    e = e || window.event;
    if ((e.which || e.keyCode) < 124 && (e.which || e.keyCode) > 111) {
        if (e.preventDefault) {
            e.preventDefault();
        }
        else {
            event.keyCode = 0;
            e.returnValue = false;
        }
    }
}
///屏蔽F1帮助 (兼容 IE ) 
var onHelp = function (e) {
    e = e || window.event;
    return false;
}

///添加监听事件
if (document.addEventListener) {
    document.addEventListener("keydown", check, false);
}
else {
    document.attachEvent("onkeydown", check);
    document.attachEvent("onhelp", onHelp);
}
///———————— 屏蔽键盘 end ——————————


///————————渲染 grid 文字颜色————————
var template = '<span style="color:{0};">{1}</span>';

var change = function (value) {
    return String.format(template, (value > 0) ? "green" : "red", value);
};

var pctChange = function (value) {
    return String.format(template, (value > 0) ? "green" : "red", value + "%");
};
///————————  end ——————————


///——————— 获取指定的URL参数值———————
///  var str =Request(ss);
function Request(paramName) {
    paramValue = "";
    isFound = false;
    if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=") > 1) {
        arrSource = unescape(this.location.search).substring(1, this.location.search.length).split("&");
        i = 0;
        while (i < arrSource.length && !isFound) {
            if (arrSource[i].indexOf("=") > 0) {
                if (arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase()) {
                    paramValue = arrSource[i].split("=")[1];
                    isFound = true;
                }
            }
            i++;
        }
    }
    return paramValue;
}
///———————————end —————————


///alert(formatNumber(0, '#.00#'));
///alert(formatNumber(12432.21, '#,###'));
///alert(formatNumber(12432.21, '#,###.000#'));
///alert(formatNumber(12432, '####.00'));
///alert(formatNumber('12432555.415', '####.0#'));
///数字格式 
function formatNumber(number, pattern) {
    var str = number.toString();
    var strInt;
    var strFloat;
    var formatInt;
    var formatFloat;
    if (/\./g.test(pattern)) {
        formatInt = pattern.split('.')[0];
        formatFloat = pattern.split('.')[1];
    } else {
        formatInt = pattern;
        formatFloat = null;
    }

    if (/\./g.test(str)) {
        if (formatFloat != null) {
            var tempFloat = Math.round(parseFloat('0.' + str.split('.')[1]) * Math.pow(10, formatFloat.length)) / Math.pow(10, formatFloat.length);
            strInt = (Math.floor(number) + Math.floor(tempFloat)).toString();
            strFloat = /\./g.test(tempFloat.toString()) ? tempFloat.toString().split('.')[1] : '0';
        } else {
            strInt = Math.round(number).toString();
            strFloat = '0';
        }
    } else {
        strInt = str;
        strFloat = '0';
    }
    if (formatInt != null) {
        var outputInt = '';
        var zero = formatInt.match(/0*$/)[0].length;
        var comma = null;
        if (/,/g.test(formatInt)) {
            comma = formatInt.match(/,[^,]*/)[0].length - 1;
        }
        var newReg = new RegExp('(\\d{' + comma + '})', 'g');

        if (strInt.length < zero) {
            outputInt = new Array(zero + 1).join('0') + strInt;
            outputInt = outputInt.substr(outputInt.length - zero, zero)
        } else {
            outputInt = strInt;
        }

        var
        outputInt = outputInt.substr(0, outputInt.length % comma) + outputInt.substring(outputInt.length % comma).replace(newReg, (comma != null ? ',' : '') + '$1')
        outputInt = outputInt.replace(/^,/, '');

        strInt = outputInt;
    }

    if (formatFloat != null) {
        var outputFloat = '';
        var zero = formatFloat.match(/^0*/)[0].length;

        if (strFloat.length < zero) {
            outputFloat = strFloat + new Array(zero + 1).join('0');
            //outputFloat        = outputFloat.substring(0,formatFloat.length);
            var outputFloat1 = outputFloat.substring(0, zero);
            var outputFloat2 = outputFloat.substring(zero, formatFloat.length);
            outputFloat = outputFloat1 + outputFloat2.replace(/0*$/, '');
        } else {
            outputFloat = strFloat.substring(0, formatFloat.length);
        }

        strFloat = outputFloat;
    } else {
        if (pattern != '' || (pattern == '' && strFloat == '0')) {
            strFloat = '';
        }
    }

    return strInt + (strFloat == '' ? '' : '.' + strFloat);
}


///大写转换  
var ToUpper = function (value) {
    return value.toUpperCase();
}


var webpath = function getRootPath() {
    var strFullPath = window.document.location.href;
    var strPath = window.document.location.pathname;
    var pos = strFullPath.indexOf(strPath);
    var prePath = strFullPath.substring(0, pos);
    //var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);
    return prePath + "/";
}
//var webpath = getRootPath() + "/../AirImport/AIShipmentJobList/";



function AddInvoice(sys, company, currency, comcurr, Type) {
    var strLog = "3:   SYS: " + sys + "     company: " + company + "      currency: " + currency + "\r\n";

    $.get('/common/uicontrols/gridHtml.ashx?type=LOG&msg=' + strLog, function (data) {

    })

    if (!ValidataCompany(company)) {
        $("#" + company).focus();
        return;
    }

    if (ValidataText() == false)
        return;


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
    var M = Request("seed");
    if (M == "" || M == undefined) {
        Ext.MessageBox.alert("Status", " Please save the data ! ", function () {
            btnSave.focus();
        })
        return;
    }

    var record = comcurr.getById(curr);
    Ext.getCmp('btnSave').fireEvent('click', this);
    var rate = record.data.rate;
    var fl = record.data.foreign == true ? "F" : "L";
    //string url = "invoice.aspx?sys=AI&M=" + Request["seed"] + "&Company=" + CmbCompanyRightText.Value + "&Currency=" + CmbCurrencyRight.Text + "&rate=" + txtcur_Rate.Text + "&FL=" + (radForeign.Checked ? "F" : "L");
    setTimeout(function () { window.open("http://" + window.location.host + "/AirImport/AIShipmentJobList/invoice.aspx?sys=" + sys + "&" + Type + "=" + M + "&Company=" + code + "&Currency=" + curr + "&rate=" + rate + "&FL=" + fl, "_blank") }, 2000);

}

///更新LotNo
function UpdatelotNo() {

    Ext.MessageBox.confirm('statu', 'Are you sure you want to update?',
    function (btn) {
        if (btn == 'yes') {
            CompanyX.btnUpdateLotNo_Click();
        }
    });
}



///回传值的控件
///回传的code
///回传的Name
///要刷新的store
///回调子窗体的值
function ChildCallBack(obj, str, text) {


    if (obj == '' || obj == undefined) {

        if (typeof Store1 == "object")
            Store1.reload();

        if (typeof StoreUnit == "object")  /// StoreUnit
            StoreUnit.reload();

        if (typeof StoreSalesman == "object")  ///StoreSalesman
            StoreSalesman.reload();

        if (typeof StoreGetItem == "object")   ///StoreGetItem
            StoreGetItem.reload();

        if (typeof StoreItem == "object")   ///StoreItem
            StoreItem.reload();

        if (typeof StoreLocation == "object")  ///StoreLocation
            StoreLocation.reload();

        if (typeof StoreShipKind == "object")  ///StoreShipKind
            StoreShipKind.reload();

        if (typeof StoreServiceMode == "object")  ///StoreServiceMode StoreServiceMode
            StoreServiceMode.reload();

        if (typeof StoreCN == "object")          /// StoreCN
            StoreCN.reload();

        if (typeof StoreVoyage == "object")      /// StoreVoyage    
            StoreVoyage.reload();

        if (typeof StoreVessel == "object")      /// StoreVessel
            StoreVessel.reload();

        if (typeof StoreCurrency == "object")      /// Currency
            StoreCurrency.reload();

        if (typeof StoreCurrInvoice == "object")      /// StoreCurrInvoice
            StoreCurrInvoice.reload();

        if (typeof StoreKind == "object")      /// StoreKind
            StoreKind.reload();

        if (typeof StoreDept == "object")      /// StoreDept
            StoreDept.reload();

        if (typeof StoreForeignKind == "object")      /// StoreForeignKind
            StoreForeignKind.reload();

        if (typeof StoreCompanyKind == "object")      /// StoreCompanyKind
            StoreCompanyKind.reload();

        if (typeof StoreCurrForeign == "object")      /// StoreCurrForeign
            StoreCurrForeign.reload();

        if (typeof StoreCurrLocal == "object")      /// StoreCurrLocal
            StoreCurrLocal.reload();
    }
    else {
        var o = Ext.getCmp(obj);
        if (typeof o == "object")
            o.store.reload();

        if (o != null && o != undefined)
            o.setValue(str.toUpperCase()).focus();
        else
            $("#" + obj).val(str.toUpperCase()).focus();


        if (typeof Ext.getCmp(obj + "_text") == "object" && Ext.getCmp(obj + "_text") != null)
            Ext.getCmp(obj + "_text").setText(text.toUpperCase());

        //        if (typeof Ext.getCmp(obj + "_text") == "object" && Ext.getCmp(obj + "_text") != null)
        //            Ext.getCmp(obj + "_text").setText(text.toUpperCase());

        if (text != undefined && text != "")
            $(document.getElementById(obj + "_text")).text(text.toUpperCase());

        try {
            $(document.getElementById("txtDesc")).val(text.toUpperCase());
        }
        catch (e) {

        }
    }

    if (typeof Window1 == "object" && Window1 != null)
        Window1.close();
}


///隐藏或者显示父窗体的滚动条
function scroll(b) {

    b = b == undefined ? "hide" : b;
    if (b == "hide")
        window.parent.window.document.body.style.overflow = "hide";
    else
        window.parent.window.document.body.style.overflow = "auto";

}

//刷新父窗体grid的数据源
function Reload() {
    //debugger;

    var obj = document.getElementById("btnCancel");
    if (obj != "" && obj != undefined && obj != null) {

        Ext.getCmp('btnCancel').fireEvent('click', this);
    };
}

//设置父窗体的宽度与高度（自适应页面内容）IE,谷歌
function SetWinSize() {

    $("#location_div01").css("height", "inherit").css("padding-bottom", "0").css("margin-bottom", "0");
    var winWidth, winHeight = 0;

    //if (!document.body.style.marginTop) {
    //    document.body.style.marginTop = "8px";
    //}
    //if (!document.body.style.marginBottom) {
    //    document.body.style.marginBottom = "8px";
    //}
    //if (!document.body.style.marginLeft) {
    //    document.body.style.marginLeft = "8px";
    //}
    //if (!document.body.style.marginRight) {
    //    document.body.style.marginRight = "8px";
    //}

    //winWidth = document.documentElement.scrollWidth + 13;
    //winHeight = document.documentElement.scrollHeight + 40;
    var div_box = document.getElementById("location_div01");
    winWidth = div_box.offsetWidth + div_box.offsetLeft * 2 + 12;
    winHeight = div_box.offsetHeight + div_box.offsetTop * 2 + 52;

    if (winWidth > screen.width)
        winWidth = screen.width;

    if (winHeight > screen.height)
        winHeight = screen.height;
    //alert("offsetHeight:" + div_box.offsetHeight + ",clientHeight:" + div_box.clientHeight + ",scrollHeight:" + div_box.scrollHeight);

    var winshow = parent.winShow;
    var divWin = parent.Window1;
    var obj;
    if (winshow) obj = winshow;
    else if (divWin) obj = divWin;
    else return;

    obj.setWidth(winWidth);
    obj.setHeight(winHeight);
    obj.center();
}

//禁用DIV(countryControl)
//function DisableDIV(height) {
//    var _html = "<div id='div_box' style=' position:absolute; top:0px; left:0px; height:" + height + "px; width:100%; z-index:99999; background:#E8E8E8; filter:alpha(Opacity=0);-moz-opacity:0;opacity: 0;'></div>";
//    $("#location_div01").prepend(_html);//增加一个透明层 以便禁用combox控件
//    $("#countryControl").attr("disabled", "disabled");
//}

//禁用DIV(countryControl)
function DisableDIV() {
    $("#countryControl").attr("disabled", "disabled");
}

//单独禁用Combox(ComboxID) 还可以禁用一些类似于COMBOX的，只要把ID传入即可
function DisableCombox(id) {
    var _td = $("#" + id).parent();
    var w = _td.width();
    var h = _td.height();
    var _html = "";
    _html = "<div style='border:1px solid red; width:" + w + "px; height:" + h + "px; position:absolute; top:0px; left:0px;z-index:99999; background:pink; filter:alpha(Opacity=0);-moz-opacity:0;opacity: 0;'></div>";
    _td.prepend(_html);
}

function DateDiff(d1, d2) {    //sDate1和sDate2是2002-12-18格式

    var sDate1 = d1.getValue();
    var sDate2 = d2.getValue();
    if (sDate1 == "" || sDate1 == undefined || sDate2 == "" || sDate2 == undefined)
        return "";
    else {
        var aDate, oDate1, oDate2, iDays
        aDate = sDate1.format('Y/m/d').split("/")
        oDate1 = new Date(aDate[1] + '/' + aDate[2] + '/' + aDate[0])    //转换为12-18-2002格式
        aDate = sDate2.format('Y/m/d').split("/")
        oDate2 = new Date(aDate[1] + '/' + aDate[2] + '/' + aDate[0])
        iDays = parseInt((oDate2 - oDate1) / 1000 / 60 / 60 / 24)    //把相差的毫秒数转换为天数
        if (iDays < 0) {
            d2.setValue("").focus();
            return "";
        }
        else
            return iDays + 1
    }
}


//创建Iframe
function CreateMask() {
    if (window.parent.document.getElementById("mask") == null || window.parent.document.getElementById("mask") == undefined) {
        var str = "<div><div id=\"mask\" style=\"position: absolute; top:0px; left:0px; width:100%; height:100%;z-index: 9008 !important;display:none;background-color: Transparent;\">";
        str += "<iframe id=\"iframeNewInvoice\" name=\"iframeNewInvoice\" width=\"100%\" height=\"100%\">";
        str += "</iframe></div> </div><input type=\"hidden\" value=\"\" id=\"hidLotNo\" /><input type=\"hidden\" value=\"\" id=\"hid_seed\" />";
        window.parent.$("#form1").append(str);
    }
}

//显示遮罩层 不包括INDEX DETAIL里的NEW INVOICE
function showMask(curSys, sys) {
    document.getElementById("iframeNewInvoice").src = "/common/ylQuery/UserNewInvoice.aspx?curSys=" + curSys + "&Sys=" + sys;
    var form1H = $("#form1").height() + 80 + 25; //80是上面TITLE的高度,25是底部bottom的高度 这里是form1的高度
    var win10H = $("#Window10").height() + 80 + 25; //这里是单独打开界面里的Window10的高度
    var h = form1H;
    var w = $("#form1").width() - 5; //为了不IE11不出现横向滚动条
    if (form1H < win10H) {
        h = win10H;
    }

    $("#mask").height(h);
    $("#iframeNewInvoice").height(h);
    $("#mask").width(w);
    $("#iframeNewInvoice").width(w);
    $("#mask").show("fast");
    //    alert($("#form1").height() + "||" + h +"||"+ $("#Window10").height());
}


var win = null;

function createFrom(type) {

    var doc = $(window).height(); //浏览器当前窗口可视区域高度

    var top = $("#img_showlist").offset().top;


    var height = doc - top - 55;

    type = type.toUpperCase();


    var id = "";
    try {
        if (type == "AI" || type == "AIINVOICE" || type == "AIINVOICEADD") {
            if (type == "AIINVOICEADD")
                id = Request("M") == "" ? Request("H") : Request("M");
            else
                id = Request("MAWB") == "" ? Request("seed") : Request("MAWB");
        }
        else if (type == "OI" || type == "OIINVOICE" || type == "OICONTAINER" || type == "OIINVOICEADD") {
            if (type == "OICONTAINER")
                id = Request("HBL");
            else if (type == "OIINVOICEADD")
                id = Request("M") == "" ? Request("H") : Request("M");
            else
                id = Request("MBL") == "" ? Request("seed") : Request("MBL");
        }
        else if (type == "AE" || type == "AEINVOICE" || type == "AEINVOICEADD" || type == "AEHAWB") {
            if (type == "AEINVOICEADD")
                id = Request("M") == "" ? Request("H") : Request("M");
            else
                id = Request("MAWB") == "" ? Request("seed") : Request("MAWB");
        }
        else if (type == "OE" || type == "OEINVOICE" || type == "OECONTAINER" || type == "OEINVOICEADD" || type == "OEHBL") {
            if (type == "OECONTAINER")
                id = Request("HBL");
            else if (type == "OEINVOICEADD")
                id = Request("M") == "" ? Request("H") : Request("M");
            else if (type == "OEHBL")
                id = Request("seed");
            else
                id = Request("MBL") == "" ? Request("seed") : Request("MBL");
        }
        else if (type == "AT" || type == "OT" || type == "ATINVOICEADD" || type == "OTINVOICEADD" || type == "ATINVOICE" || type == "OTINVOICE") {
            if (type == "ATINVOICEADD" || type == "OTINVOICEADD")
                id = Request("M");
            else
                id = Request("seed");
        }
        else if (type == "DM" || type == "BK" || type == "TK" || type == "DMINVOICEADD" || type == "BKINVOICEADD" || type == "TKINVOICEADD" || type == "DMINVOICE" || type == "BKINVOICE" || type == "TKINVOICE") {
            if (type == "DMINVOICEADD" || type == "BKINVOICEADD" || type == "TKINVOICEADD")
                id = Request("M");
            else
                id = Request("seed");
        }


        if (Request("copyseed") != "") {
            id = Request("copyseed");
        }
        Ext.getCmp("Window10").close();
        win = null;

    }
    catch (exp)
    { }

    if (id == "") id = -1;

    var url = "http://" + window.location.host + "/AirImport/AIShipmentJobList/DetailList.aspx?id=" + id;


    if (type == "OI")
        url = "http://" + window.location.host + "/OceanImport/OceanShipmentJobList/DetailList.aspx?id=" + id;
    else if (type == "OIINVOICE")
        url = "http://" + window.location.host + "/OceanImport/OceanShipmentJobList/DetailList.aspx?id=" + id + "&type=invoice";
    else if (type == "OICONTAINER")
        url = "http://" + window.location.host + "/OceanImport/OceanShipmentJobList/DetailList.aspx?id=" + id + "&type=Container";
    else if (type == "AI")
        url = "http://" + window.location.host + "/AirImport/AIShipmentJobList/DetailList.aspx?id=" + id;
    else if (type == "AIINVOICE")
        url = "http://" + window.location.host + "/AirImport/AIShipmentJobList/DetailList.aspx?id=" + id + "&type=invoice";
    else if (type == "AE" || type == "AEHAWB")
        url = "http://" + window.location.host + "/AirExport/AEViewConsol/DetailList.aspx?id=" + id;
    else if (type == "AEINVOICE")
        url = "http://" + window.location.host + "/AirExport/AEViewConsol/DetailList.aspx?id=" + id + "&type=invoice";
    else if (type == "OE")
        url = "http://" + window.location.host + "/OceanExport/OEJobList/DetailList.aspx?id=" + id;
    else if (type == "OEINVOICE")
        url = "http://" + window.location.host + "/OceanExport/OEJobList/DetailList.aspx?id=" + id + "&type=invoice";
    else if (type == "OECONTAINER")
        url = "http://" + window.location.host + "/OceanExport/OEJobList/DetailList.aspx?id=" + id + "&type=Container";
    else if (type == "AIINVOICEADD")
        url = "http://" + window.location.host + "/AirImport/AIShipmentJobList/DetailList.aspx?id=" + id + "&type=addInvoice";
    else if (type == "OIINVOICEADD")
        url = "http://" + window.location.host + "/OceanImport/OceanShipmentJobList/DetailList.aspx?id=" + id + "&type=addInvoice";
    else if (type == "AEINVOICEADD")
        url = "http://" + window.location.host + "/AirExport/AEViewConsol/DetailList.aspx?id=" + id + "&type=addInvoice";
    else if (type == "OEINVOICEADD")
        url = "http://" + window.location.host + "/OceanExport/OEJobList/DetailList.aspx?id=" + id + "&type=addInvoice";
    else if (type == "OEHBL")
        url = "http://" + window.location.host + "/OceanExport/OEJobList/DetailList.aspx?id=" + id + "&type=OEHBL";
    else if (type == "AT" || type == "ATINVOICEADD") {
        url = "http://" + window.location.host + "/Triangle/ShipmentList/DetailList.aspx?sys=A&ID=" + id;
    }
    else if (type == "OT" || type == "OTINVOICEADD") {
        url = "http://" + window.location.host + "/Triangle/ShipmentList/DetailList.aspx?sys=O&ID=" + id;
    }
    else if (type == "DM" || type == "DMINVOICEADD") {
        url = "http://" + window.location.host + "/OtherBusiness/ShipmentList/DetailList.aspx?sys=DM&ID=" + id;
    }
    else if (type == "BK" || type == "BKINVOICEADD") {
        url = "http://" + window.location.host + "/OtherBusiness/ShipmentList/DetailList.aspx?sys=BK&ID=" + id;
    }
    else if (type == "TK" || type == "TKINVOICEADD") {
        url = "http://" + window.location.host + "/OtherBusiness/ShipmentList/DetailList.aspx?sys=TK&ID=" + id;
    }
    else if (type == "ATINVOICE") {
        url = "http://" + window.location.host + "/Triangle/ShipmentList/DetailList.aspx?sys=A&ID=" + id + "&type=invoice";
    }
    else if (type == "OTINVOICE") {
        url = "http://" + window.location.host + "/Triangle/ShipmentList/DetailList.aspx?sys=O&ID=" + id + "&type=invoice";
    }
    else if (type == "DMINVOICE") {
        url = "http://" + window.location.host + "/OtherBusiness/ShipmentList/DetailList.aspx?sys=DM&ID=" + id + "&type=invoice";
    }
    else if (type == "BKINVOICE") {
        url = "http://" + window.location.host + "/OtherBusiness/ShipmentList/DetailList.aspx?sys=BK&ID=" + id + "&type=invoice";
    }
    else if (type == "TKINVOICE") {
        url = "http://" + window.location.host + "/OtherBusiness/ShipmentList/DetailList.aspx?sys=TK&ID=" + id + "&type=invoice";
    }
    url += "&target=parent";

    if (win == null) {
        var win = new Ext.Window({
            id: "Window10",
            title: "View",
            resizable: true,
            draggable: true,
            maximizable: false,
            pageX: 10,
            pageY: (type == "OEHBL" || type == "AEHAWB") ? 45 : 110,
            x: 10,
            y: (type == "OEHBL" || type == "AEHAWB") ? 45 : 110,
            //animateTarget: "img_showlist",
            width: 963,
            height: 422,
            padding: 6,
            bodyStyle: "background-color:#fff",
            modal: false,
            closeAction: "close",
            shadow: false
        });

        win.on({
            hide: function (win) {
                win.close();
                win.destroy();
                win = null;
            }
        });
        win.load(url);
    }

    win.show();

}


function OpenCosting(seed) {
    var getseed = Number(seed);
    if (getseed > 0) {

        var winCombineCost;
        if (!winCombineCost) {
            winCombineCost = new Ext.Window({
                id: "winCombineCost",
                title: "Combine Cost",
                resizable: true,
                draggable: true,
                maximizable: false,
                width: 416,
                height: 396,
                padding: 5,
                bodyStyle: "background-color:#fff",
                modal: false,
                closeAction: "close"
            });
            winCombineCost.on({
                hide: function (winCombineCost) {
                    winCombineCost.close();
                    winCombineCost.destroy();
                }
            });
            winCombineCost.load("http://" + window.location.host + "/common/Cost/CostingList.aspx?CostingSeed=" + getseed);
        }
        winCombineCost.show();
    }
}

function SetCostingList() {
    try {
        this.parent.winCombineCost.setWidth(700);
        this.parent.winCombineCost.setHeight(560);
    }
    catch (ex) {
    }
}

function OpenCostingDetail(id, seed) {
    var getid = Number(id);
    var getseed = Number(seed);

    SetCostingList();
    var winCombineCostDetail;
    if (!winCombineCostDetail) {
        winCombineCostDetail = new Ext.Window({
            id: "winCombineCostDetail",
            title: "Combine Cost Detail",
            resizable: false,
            draggable: false,
            maximizable: false,
            width: 626,
            height: 452,
            padding: 5,
            bodyStyle: "background-color:#fff",
            modal: true,
            closeAction: "close"
        });
        winCombineCostDetail.on({
            hide: function (winCombineCostDetail) {
                winCombineCostDetail.close();
                winCombineCostDetail.destroy();
            }
        });
        winCombineCostDetail.load("http://" + window.location.host + "/common/Cost/CostingDetail.aspx?CostingID=" + getid + "&CostingDetailSeed=" + getseed);
    }
    winCombineCostDetail.show();

}

function showCompanyRemark(IDList, NameList) {

    CreateSearch(IDList, NameList);
    $(".SearchClose").click(function () {
        $("#CompanySearch").hide();
    });

    var allid = "";
    var IDValues = new Array();
    IDValues = IDList.split(",");
    var len = IDValues.length;
    for (var i = 0; i < len; i++) {
        if (i == len - 1) {
            allid += "#" + IDValues[i];
        }
        else {
            allid += "#" + IDValues[i] + ",";
        }
    }

    //scroll
    var lastid = IDValues[len - 1];
    var top = $("#" + lastid).offset().top;
    var scrolltop;
    $(window).scroll(function () {
        scrolltop = document.documentElement.scrollTop || document.body.scrollTop;
        if (scrolltop > top - 90) {
            $("#CompanySearch").hide();
        }
    });

    $("#CompanySearch").mousedown(function () {
        $(allid).unbind("blur", hideSearch);
    });

    $(allid).bind("focus", function () {
        showSearchPage($(this).attr("id"), "focus");
        $(allid).bind("blur", hideSearch);
    });

    $(allid).bind("blur", hideSearch);

    $(allid).bind("blur", function () {
        showSearchPage($(this).attr("id"), "blur");
    });

    $(window).resize(function () {
        if ($("#CompanySearch").css("display") != "none") {
            resizeHeight("Y");
        }
    });
}

function resizeHeight(resizeFlag) {
    var clientH = document.documentElement.clientHeight || document.body.clientHeight;
    var rh1 = $("#CompanySearch").height();
    var rh2 = 176;
    $("#CompanySearch .SearchRemarkStyle").each(function () {
        if ($(this).height() > 0) {
            rh2 = $(this).height();
        }

    });
    var rh3 = $("#CompanySearch .SearchScroll").height();
    if (clientH <= 450) {
        if (resizeFlag == "Y") {
            if (rh2 == 176) {
                $("#CompanySearch .SearchRemarkStyle").height(96);
            } else if (rh2 == 160) {
                $("#CompanySearch .SearchRemarkStyle").height(80);
            }

            if (rh3 == 203) {
                $("#CompanySearch .SearchScroll").height(123);
            }

            if (rh1 == 243) {
                $("#CompanySearch").height(163);
            }
        }
        else if (resizeFlag == "M") {
            if (rh2 != 80) {
                $("#CompanySearch .SearchRemarkStyle").height(80);
            }
            if (rh3 != 123) {
                $("#CompanySearch .SearchScroll").height(123);
            }
            if (rh1 != 163) {
                $("#CompanySearch").height(163);
            }
        }
        else if (resizeFlag == "N") {
            if (rh2 != 96) {
                $("#CompanySearch .SearchRemarkStyle").height(96);
            }
            if (rh3 != 123) {
                $("#CompanySearch .SearchScroll").height(123);
            }
            if (rh1 != 163) {
                $("#CompanySearch").height(163);
            }
        }
    }
    else {
        if (resizeFlag == "Y") {
            if (rh1 == 163) {
                $("#CompanySearch").height(243);
            }

            if (rh3 == 123) {
                $("#CompanySearch .SearchScroll").height(203);
            }
            if (rh2 == 96) {
                $("#CompanySearch .SearchRemarkStyle").height(176);
            } else if (rh2 == 80) {
                $("#CompanySearch .SearchRemarkStyle").height(160);
            }
        }
        else if (resizeFlag == "M") {
            if (rh1 != 243) {
                $("#CompanySearch").height(243);
            }
            if (rh3 != 203) {
                $("#CompanySearch .SearchScroll").height(203);
            }
            if (rh2 != 160) {
                $("#CompanySearch .SearchRemarkStyle").height(160);
            }
        }
        else if (resizeFlag == "N") {
            if (rh1 != 243) {
                $("#CompanySearch").height(243);
            }
            if (rh3 != 203) {
                $("#CompanySearch .SearchScroll").height(203);
            }
            if (rh2 != 176) {
                $("#CompanySearch .SearchRemarkStyle").height(176);
            }
        }
    }
}


function showSearchPage(id, eventtype) {
    if (eventtype == "focus") {
        var code = 0;
        $("#SearchShow>td").each(function () {
            var name = $(this).attr("id").substr(2);
            if ($.trim($("#" + name).val()) != "" && $("#" + name).attr("validata") != "false") {
                code = code + 1;
                $(this).css("display", "table-cell");
            } else {
                $(this).css("display", "none");
            }

        });

        if (code > 0) {
            $("#CompanySearch").show();
            $("#CompanySearch .SearchRemarkStyle").css("color", "black");
            $("#Ts" + id).css("color", "green");
        } else {
            $("#CompanySearch").hide();
        }

        if (code > 3) {
            resizeHeight("M");
        }
        else {
            resizeHeight("N");
        }
    }
    if (eventtype == "blur") {
        var value = $.trim($("#" + id).val());
        if (value != "") {
            $.getJSON("/common/uicontrols/AjaxService/CompanyHandler.ashx?option=companysearch&type=y&code=" + encodeURI(value), function (data) {
                if (data[0] != undefined) {
                    if ($("#Td" + id).css("display") == "none") {
                        $("#Td" + id).css("display", "table-cell");
                    }
                    $("#Ts" + id).val(data[0].remark);
                }
                else {
                    if ($("#Td" + id).css("display") == "table-cell") {
                        $("#Td" + id).css("display", "none");
                    }
                }
            });
        }
    }
}

function hideSearch() {
    $("#CompanySearch").hide();
}

function CreateSearch(IDList, NameList) {
    var IDValues = new Array();
    var NameValues = new Array();
    IDValues = IDList.split(",");
    NameValues = NameList.split(",");

    var strSearch = '';
    strSearch += '<div id="CompanySearch">';

    strSearch += '<table width="1024" border="0" cellspacing="0" cellpadding="0">';
    strSearch += '<tr><td width="10"><img src="/images/company/line1.png" width="10" height="30"/></td><td width="1004" background="/images/company/line2.png">';
    strSearch += '<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td style="color:#1542AF;font-weight:bold;text-align:left;width:100px;padding-left:2px;">Remark:</td>';
    strSearch += '<td style="text-align:right;"><img src="/images/company/close_01.jpg" class="SearchClose"/></td></tr></table>';
    strSearch += '</td><td width="10"><img src="/images/company/line3.png" width="10" height="30"/></td></tr><tr><td background="/images/company/line4.png"></td><td style="background-color:White;">';

    strSearch += '<table cellpadding="0" cellspacing="0" width="100%">';
    strSearch += '<tr><td>';
    strSearch += '<div class="SearchScroll">';
    strSearch += '<table cellpadding="0" cellspacing="0"><tr id="SearchShow">';
    for (var i = 0; i < IDValues.length; i++) {
        var name = NameValues[i] == "" ? "Remark" : NameValues[i];
        strSearch += '<td class="SearchRemark" id="Td' + IDValues[i] + '"><table><tr><td class="SearchName"><span id="Ls' + IDValues[i] + '">' + name + '</span></td></tr></table>';
        strSearch += '<textarea id="Ts' + IDValues[i] + '" class="SearchRemarkStyle" readonly="readonly"></textarea></td>';
    }
    strSearch += '</tr></table>';
    strSearch += '</div>';
    strSearch += '</td></tr></table>';

    strSearch += '</td><td background="/images/company/line5.png"></td></tr><tr><td width="10"><img src="/images/company/line6.png" width="10" height="10"/></td>';
    strSearch += '<td width="1004" background="/images/company/line7.png"></td><td width="10"><img src="/images/company/line8.png" width="10" height="10"/></td></tr></table>';

    strSearch += '</div>';

    $("body").append(strSearch);

    for (var j = 0; j < IDValues.length; j++) {
        var value = $.trim($("#" + IDValues[j]).val());
        if (value != "" && value != null) {
            showSearch(IDValues[j], value);
        }
    }

}

function showSearch(id, value) {
    $.getJSON("/common/uicontrols/AjaxService/CompanyHandler.ashx?option=companysearch&type=y&code=" + encodeURI(value), function (data) {
        if (data[0] != undefined) {
            $("#Ts" + id).val(data[0].remark);
            $("#Td" + id).css("display", "table-cell");
        }
    });
}

//2014-12-9  Grace 时间转换
function timeFormatter(value) {

    var da = new Date(parseInt(value.replace("/Date(", "").replace(")/", "").split("+")[0]));
    var month = da.getMonth() + 1;

    return ((month >= 10) ? month : "0" + month) + "/" + ((da.getDate() >= 10) ? da.getDate() : "0" + da.getDate()) + " " + ((da.getHours() >= 10) ? da.getHours() : "0" + da.getHours()) + ":" + ((da.getMinutes() >= 10) ? da.getMinutes() : "0" + da.getMinutes());

}

//2014-12-9  Grace 
function getParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var schema = window.location.toString();
    if (schema.indexOf("?") < 1) {
        return "";
    }
    else {
        schema = schema.substr(schema.indexOf("?") + 1);
    }
    var result = schema.match(reg);
    if (result != null)
        return unescape(result[2]);
    else
        return "";
}

function getData() {
    var seed = getParam("Seed");
    var id = getParam("ID"); //针对于OEContainerList/Container.aspx
    var str = "";
    if (seed != "" || id != "") {
        $.ajaxSettings.async = false;
        $.getJSON("/common/uicontrols/AjaxService/LastUserHandler.ashx?seed=" + encodeURI(seed) + "&id=" + encodeURI(id), function (data) {
            if (data != undefined && data[0] != undefined) {

                var user = (data[0]["LUser"] == null || data[0]["LUser"] == "") ? data[0]["CUser"].toUpperCase() : data[0]["LUser"].toUpperCase();
                var date = (data[0]["LDate"] == null || data[0]["LDate"] == "") ? timeFormatter(data[0]["CDate"]) : timeFormatter(data[0]["LDate"]);
                var s = "<span style='font-size:9px'>OP:</span><span style='color:#800000;font-size:9px'>" + user + "</span>";
                var t = "OP:" + user + "&#10;" + date + "";

                str = "<span style='float:right;padding-right:5px;' title='" + t + "'>" + s + "</span>";
            }
        });
        $.ajaxSettings.async = true;
    }
    return str;
}

//2014-12-9  Grace 在界面中添加修改人(lastUser)，修改时间,以及页面按钮的禁用（2015-06-16）
$(function () {
    CreateMask();
    try {
        Ext.onReady(function () {
            var v = new Date().getTime();
            var script = document.createElement("script");
            script.setAttribute("type", "text/javascript");
            script.setAttribute("src", "/common/ylQuery/page_CloseBtn.js?v=" + v + "");
            window.form1.appendChild(script);

            var script1 = document.createElement("script");
            script1.setAttribute("type", "text/javascript");
            script1.setAttribute("src", "/common/ylQuery/EXTWindow.js?v=" + v + "");
            window.form1.appendChild(script1);
        })
    }
    catch (e) {
        var v = new Date().getTime();
        var script = document.createElement("script");
        script.setAttribute("type", "text/javascript");
        script.setAttribute("src", "/common/ylQuery/page_CloseBtn.js?v=" + v + "");
        window.form1.appendChild(script);

        var script1 = document.createElement("script");
        script1.setAttribute("type", "text/javascript");
        script1.setAttribute("src", "/common/ylQuery/EXTWindow.js?v=" + v + "");
        window.form1.appendChild(script1);
    }
})



$(function () {

    var str = "";
    if ($.trim($("#div_top").find("td").first().text()).toUpperCase() == "ACTION" && $("#div_top").length > 0) {
        str = getData();
        $("#div_top").find("td").first().append(str);
    } else if ($("#invoice_div").length > 0) {
        str = getData();
        $("#img_void").after(str); //针对于Invoice页面
    } else if ($("#btnDelete_Container").length > 0) {
        str = getData();
        $("#btnDelete_Container").parent().parent().parent().parent().parent().before("<td><span style='float:left'>" + str + "</span></td>");
    }

});

//设置页面GirdPanel的高度
function setGridSize(name) {

    if (name == null || name == undefined) {
        name = gridList;
    }

    name.setHeight(document.documentElement.clientHeight - 175 - $("#PagingToolbar1").height());
}


function openwin(url, id) {
    var a = document.createElement("a");
    a.setAttribute("href", url);
    a.setAttribute("target", "_blank");
    a.setAttribute("id", id);
    document.body.appendChild(a);
    a.click();
}

//$(function () {
//    var a = SetFnIsShow("1");
//    if (a == "true") {
//        alert("开放权限"); //显示按钮
//    } else {
//        alert("关闭权限"); //隐藏按钮
//    }
//});

//NameOrSeed 是列表中的Name or Seedkey
function SetFnIsShow(NameOrSeed) {
    var state = "";
    $.ajaxSettings.async = false; //必须加这个否则会在还没得到返回的data数据时就已经return了
    $.getJSON("/common/uicontrols/AjaxService/FnManageHandler.ashx?NameOrSeed=" + NameOrSeed + "&sys=" + getSys(), function (data) {
        state = data.toString();
    });
    $.ajaxSettings.async = true;
    return state;
}


//获取当前页面所属系统
function getSys() {
    var href = window.location.pathname;
    var a = href.split("/");
    var sys = "";
    if (a[1].toUpperCase() == "AIREXPORT") {
        sys = "AE";
    } else if (a[1].toUpperCase() == "AIRIMPORT") {
        sys = "AI";
    } else if (a[1].toUpperCase() == "OCEANEXPORT") {
        sys = "OE";
    } else if (a[1].toUpperCase() == "OCEANIMPORT") {
        sys = "OI";
    } else if (a[1].toUpperCase() == "TRIANGLE" && a[2].toUpperCase() == "AIRSHIPMENT") {
        sys = "AT";
    } else if (a[1].toUpperCase() == "TRIANGLE" && a[2].toUpperCase() == "OCEANSHIPMENT") {
        sys = "OT";
    } else if (a[1].toUpperCase() == "OTHERBUSINESS" && a[2].toUpperCase() == "DOMESTIC") {
        sys = "DM";
    } else if (a[1].toUpperCase() == "OTHERBUSINESS" && a[2].toUpperCase() == "TRUCKING") {
        sys = "TK";
    } else if (a[1].toUpperCase() == "OTHERBUSINESS" && a[2].toUpperCase() == "BROKERAGE") {
        sys = "BK";
    }

    return sys;
}

////用遮罩层禁用按钮，可以不用判断ID是否存在，JQ自动忽略  GRACE
//function DisabledBtn(id) {
//    //$("#" + id).removeClass("x-btn  x-btn-noicon");
//    //$("#" + id).addClass("x-btn x-btn-noicon x-item-disabled");
//    //var _td = $("#" + id).parent();
//    //var w = _td.width();
//    //var h = _td.height();
//    //var _html = "";
//    //_html = "<div style='border:1px solid red; width:" + w + "px; height:" + h + "px; position:absolute;z-index:99999; background:pink; filter:alpha(Opacity=0);-moz-opacity:0;opacity: 0;'></div>";

//    //_td.prepend(_html);
//    if (Ext.getCmp(id) != undefined && Ext.getCmp(id) != null)
//        Ext.getCmp(id).disable();
//}

////EXT禁用按钮，只适用于 Ext.onReady()中 需要判断ID是否存在，否则报错  GRACE
//function DisabledBtnByEXT(id) {
//    if ($("#" + id).length > 0) {
//        Ext.getCmp("#" + id).disable();
//    }
//}

//(function (window, $) {

//    var fakemr = {};

//    /**
//    * ExtWindow.CreateWin({})
//    */
//    fakemr.CreateWin = function (attrs) {
//        var ops = $.extend(fakemr.dft, attrs); //这个方法可以合并并且替换返回的是属性集合
//        var win = new Ext.Window(ops);
//        win.load("http://" + window.location.host + ops.url);
//        win.show();
//    };

//    fakemr.dft = { //属性集合
//        //以下为该插件的属性及其默认值   
//        id: 'EXTWindow',
//        title: 'EXT Window', // 标题
//        x: 300,
//        y: 160,
//        width: 750,
//        height: 300,
//        resizable: false,
//        draggable: true,
//        maximizable: false,
//        bodyStyle: 'background-color:#fff',
//        modal: true,
//        closeAction: "close",
//        hidden: true,
//        url: "1",
//        shadow: true //阴影

//    };

//    window.ExtWindow = fakemr;
//})(window, jQuery);


