<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailList.aspx.cs" Inherits="OceanExport_OEJobList_DetailList" %>

<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Src="../../common/UIControls/Autocomplete.ascx" TagName="Autocomplete"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/UIControls/gridHtml.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../AirExport/AEViewConsol/Transfer.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var FormatNumber3 = function (obj) {
            if (obj != null) {
                return obj.toFixed(3);
            }
        }
    </script>

    <style type="text/css">
        .div_BtnCtnr {
            z-index: 1;
            margin-left: auto;
            margin-right: auto;
            cursor: pointer;
            background-image: url(/images/arrows_btn_01.png);
            background-repeat: no-repeat;
            width: 16px;
            height: 15px;
        }

            .div_BtnCtnr div {
                display: none;
                position: relative;
                width: 758px;
                height: auto;
                top: -1px;
                left: 30px;
                z-index: 100;
                text-align: left;
                padding-top: 18px;
                padding-left: 8px;
            }

        #grouplist div, #grouplist1 div {
            display: none;
            position: relative;
            width: 73px;
            height: auto;
            top: 0px;
            left: 16px;
            z-index: 100;
            text-align: left;
            padding-top: 2px;
            padding-left: 2px;
        }

        #grouplist1 div {
            width: 80px;
        }

        .btn_print_M_200 {
            background-image: url(/images/layer_btn.png);
        }

        .btn_print0 {
            border: 0px;
            cursor: pointer;
            background-image: url(/images/layer_btn.png);
            background-position: 0px center;
            background-repeat: no-repeat;
            height: 21px;
            text-align: left;
            text-indent: 28px;
            font-size: 9px !important;
            font-weight: bold;
            color: #000 !important;
            display: block;
            text-decoration: none !important;
            line-height: 18px;
            margin: auto;
            width: 62px;
        }

        .div_edi_box {
            position: absolute;
            z-index: 1;
            top: 15px;
            left: 0px;
            width: 79px;
        }
    </style>

    <script type="text/javascript">
        var sysType = 'OE';

        $(function () {

            $("#form1").click(function () {
                if (window.event.srcElement.tagName != "DIV") {
                    $(".div_BtnCtnr").children("div").hide();
                    $("#grouplist").children("div").hide();
                    $("#grouplist1").children("div").hide();
                    $(".div_edi_box").hide();
                }
            });

            $(".txtsubMBL").each(function (index) {
                if ($(".txtsubMBL").eq(index).val() == "")
                    $(".txtsubMBL").eq(index).val("MBL#(报关)").css({ color: "#aaa" });
                else
                    $(".txtsubMBL").eq(index).css({ color: "#000" });
            })

        });
        function saveGroup(obj, seed) {
            var groupvalue = $("#" + obj).val();
            if (groupvalue == "0") {
                $("#" + obj).val("");
            } else {
                $.get("/common/uicontrols/gridHtml.ashx?type=UpdateGroupBy&groupvalue=" + groupvalue + "&groupseed=" + seed, function (data) {
                    if (data == "N") {
                        alert('Data save failed');
                    }
                });
            }
        }
        function keyNumber(event) {
            event = event || window.event;
            if ((event.keyCode == 9) || (event.keyCode == 8) || (event.keyCode == 46) || (event.keyCode > 47 && event.keyCode < 58) || (event.keyCode > 95 && event.keyCode < 106)) {
                return true;
            }
            else {
                event.returnValue = false;

            }
        }
        function GetGroupList(obj, seed, type, tohbl) {
            $.getJSON("/common/uicontrols/gridHtml.ashx?type=GetGroupList&grouplistseed=" + seed, function (data) {
                if (data[0].Flag == "N") {
                    if (type == "M") {
                        $(obj).children("div").hide();
                        window.open("/OceanExport/OEReportFile/ReportFile.aspx?type=BLSample&groupid=0&ID=" + seed, "_blank");
                    }
                    else if (type == "H") {
                        $(obj).children("div").hide();
                        window.open("/OceanExport/OEReportFile/ReportFile.aspx?type=BLSample&groupid=0&ID=" + tohbl, "_blank");
                    }
                    else if (type == "E")  //edi
                    {
                        $(obj).children("div").hide();
                        CreatFile(stat, seed, 0, user);
                    }
                }
                else {
                    var str = "";
                    var bgImg = "layer";
                    if (type == "H") bgImg = "108";
                    else if (type == "E") bgImg = "edi";

                    str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/' + bgImg + '_01.png); width:80px; height:9px;"></td></tr><tr><td style="background-image:url(/images/' + bgImg + '_02.png); width:80px;text-align:center;padding-top:5px;">';
                    str += '<table border="0" cellpadding="0" cellspacing="0">';
                    $.each(data, function (i, n) {
                        if (type == "M") {
                            var gotoGroup = '<a href="/OceanExport/OEReportFile/ReportFile.aspx?type=BLSample&groupid=' + n.GroupID + '&ID=' + seed + '" target="_blank" class="btn_print0 btn_print_M_200">' + n.GroupID + '</a>';
                            str += '<tr><td style="text-align:center;width:80px;height:24px;">' + gotoGroup + '</td></tr>';
                        }
                        else if (type == 'H') {
                            var gotoGroup = '<a href="/OceanExport/OEReportFile/ReportFile.aspx?type=BLSample&groupid=' + n.GroupID + '&ID=' + n.ToHBL + '" target="_blank" class="btn_print0 btn_print_M_200">' + n.GroupID + '</a>';
                            str += '<tr><td style="text-align:center;width:80px;height:24px;">' + gotoGroup + '</td></tr>';
                        }
                        else if (type == "E") {
                            var gotoGroup = '<a href="javascript:void(0);" class="btn_print0 btn_print_M_200" style=\"background-image: url(/images/layer_btn_edi.png);\" onclick="CreatFile(\'' + stat + '\', ' + seed + ',' + n.GroupID + ', \'' + user + '\')">' + n.GroupID + '</a>';
                            str += '<tr><td style="text-align:center;width:80px;height:24px;">' + gotoGroup + '</td></tr>';
                        }
                    });
                    str += '</table>';
                    str += '</td></tr><tr><td style="background-image:url(/images/' + bgImg + '_03.png); width:73px; height:5px;"></td></tr></table>';
                    $(obj).children("div").html(str).show();
                }
            });
        }

        function saveSubMBL(obj, seed) {

            var subMBL = obj.value;
            $.get("/common/uicontrols/gridHtml.ashx?type=ChangeSubMBL&seed=" + seed + "&subMBL=" + subMBL, function (data) {
                if (data == "False") {
                    alert('Data save failed');
                }
            });
        }

        function focusSubMBL(obj) {
            var subMBL = obj.value;
            if (subMBL == "MBL#(报关)") {
                obj.value = "";
            }
            obj.style.color = "#000";
        }

        function blurSubMBL(obj) {
            var subMBL = obj.value;
            if (subMBL == "" || subMBL == null || subMBL == "MBL#(报关)") {
                obj.value = "MBL#(报关)";
                obj.style.color = "#aaa";
            }
        }

        function CreatFile(stat, seed, groupid, user) {
            $.getJSON("/SOA/EDI.ashx?action=CREATEFILE&stat=" + stat + "&sys=OE&seed=" + seed + "&groupid=" + groupid + "&user=" + user + "&Vtype=T", function (data) {
                if (data != null) {
                    if (data.code == "500") {
                        alert("Error message: " + data.msg);
                        var win = parent.CompanyX.UserControlTop1;
                        if (win == undefined)
                            win = parent.CompanyX;

                        if (data.winname == "Container")
                            win.ShowLink('Container Size', '443,480,/BasicData/ContainerSize/ContainerSize.aspx?sys=O');
                        else if (data.winname == "Unit")
                            win.ShowLink("Unit", "510,482,/BasicData/Unit/list.aspx?sys=O");
                    }
                    else {
                        alert(data.msg);
                    }
                }
            })
        }

        function ChkCtnrMain(obj, tombl, rowid) {
            var ismain = 0;
            if (obj.checked || obj.checked == "True" || obj.checked == "checked")
                ismain = 1;
            try {

                $.ajaxSetup({
                    error: function (x, e) {
                        Ext.Msg.alert('Status', '<font color="red">Requested address is not valid. </font>', function () {
                            window.location.reload();
                        });
                        return false;
                    }
                });

                $.getJSON("/common/uicontrols/gridHtml.ashx?type=ChkCtnrIsMain&tombl=" + tombl + "&rowid=" + rowid + "&ismain=" + ismain, function (data) {
                    if (data != null) {
                        if (data[0].Flag == "N") {
                            Ext.Msg.alert("Status", '<font color="red">Execution exception, ' + data[0].Msg + ' </font>', function () {
                                window.location.reload();
                            });
                        }
                        else
                            window.location.reload();
                    }
                    else {
                        Ext.Msg.alert('Status', '<font color="red">Execution exception, The server returned an invalid value. </font>', function () {
                            window.location.reload();
                        });
                    }

                })
            }
            catch (e) {
                Ext.Msg.alert('Status', '<font color="red">' + e.name + ": " + e.message + '</font>', function () {
                    window.location.reload();
                });
            }
        }
    </script>

    <script type="text/javascript">
        $(function () {

            $("#txtcontainer tr.tr_line").children("td").eq(0).css("width", "50px");

            $("#txtcontainer tr.tr_line").children("td").eq(1).css("width", "139px");

            $("#txtcontainer tr.tr_line").each(function () {
                $(this).children("td").eq(2).css({ "width": "150px", "text-align": "left" });
            })

            $("#txtcontainer tr.tr_line").each(function (index) {
                $(this).children("td").eq(3).css({ "width": "83px", "text-align": "right" })
            });

            $("#txtcontainer tr.tr_line").each(function () {
                $(this).children("td").eq(4).css({ "width": "83px", "text-align": "right" })
            });

            $("#txtcontainer tr.tr_line").each(function () {
                $(this).children("td").eq(5).css({ "width": "83px", "text-align": "right" })
            });

            $("#txtcontainer tr.tr_line").each(function () {
                $(this).children("td").eq(6).css({ "width": "165px", "text-align": "left" })
            });

            $("#txtcontainer tr.tr_line").each(function () {
                $(this).children("td").eq(7).css({ "width": "105px", "align": "Center" })
            });

            $("#txtcontainer tr.tr_line").each(function (index) {
                $(this).hover(function () {
                    $(this).css("background", "#fafafa");

                    $(this).find(".btn_ShipmentOrder").css({ position: "absolute" });
                    $(this).find(".btn_clp").css({ "z-index": "888" });

                    $(".div_BtnCtnr").children("div").hide();
                    var isvoid = $("#hidShowVoid").val();
                    if ($(".div_BtnCtnr").eq(index).children("div").html() == "" && isvoid != undefined) {
                        var seed = $(this).find("#hidValue span").eq(0).text();
                        var cnno = $(this).find("#hidValue span").eq(1).text();
                        var str = "";

                        $.getJSON("/common/uicontrols/gridHtml.ashx?type=ContainerList&sys=OE&isvoid=" + isvoid + "&cnno=" + cnno + "&seed=" + seed, function (data) {
                            str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/OEhawb_blue_01.png); width:757px; height:17px;"></td></tr><tr><td style="background-image:url(/images/OEhawb_blue_02.png); width:757px;text-align:left;">';
                            str += '<table border="0" cellpadding="0" cellspacing="0">';
                            $.each(data, function (i, n) {
                                str += '<tr style="line-height:24px;" class="trcolor">' + '<td width="148px">' + n.isvoid + '</td><td  style="text-align:left;width:151px;padding-left:5px;">' + n.HBL + n.so + '</span><i><span style="display:block;padding-left:15px;line-height:15px;margin-top:-3px;color:#F27CBF;">' + n.vv + '</span></i></td>' + '<td style="text-align:right;width:88px;padding-right:5px;">' + n.oc_GWT + '</td>' + '<td  style="text-align:right;width:88px;padding-right:5px;">' + n.oc_CBM + '</td>' + '<td  style="text-align:right;width:88px;padding-right:5px;">' + n.oc_Piece + '</td><td style="text-align:left;width:170px;padding-left:2px;">' + n.Remark + '</td>' + '</tr>';
                            });
                            str += '</table>';
                            str += '</td></tr><tr><td style="background-image:url(/images/OEhawb_blue_03.png); width:757px; height:8px;"></td></tr></table>';

                            $(".div_BtnCtnr").eq(index).children("div").html(str).show();

                            $(".div_BtnCtnr").eq(index).children("div").find("tr.trcolor").click(function () {
                                if (window.event.srcElement.tagName == "TD") {
                                    window.open($(this).children("td").eq(1).find("a").attr("href"), $(this).children("td").eq(1).find("a").attr("target"));
                                }
                            });

                        });
                    }
                    else {

                        $(".div_BtnCtnr").eq(index).children("div").show();

                    }

                }, function () {
                    $(this).css("background", "#fff");
                    //$(".div_BtnCtnr").children("div").hide();
                    $(".div_BtnCtnr").eq(index).children("div").hide();
                    $(this).find(".btn_ShipmentOrder").css({ position: "" });
                    $(this).find(".btn_clp").css({ "z-index": "1" })

                });
            });



        })
    </script>

    <script type="text/javascript">
        $(function () {

            $("#txtcontent tr.tr_line").children("td").eq(0).css("width", "50px");

            $("#txtcontent tr.tr_line td").eq(1).css("width", "80px");

            $("#txtcontent tr.tr_line").each(function () {
                $(this).children("td").eq(2).css({ "width": "50px", "text-align": "Center" });
            })

            $("#txtcontent tr.tr_line").each(function (index) {
                $(this).children("td").eq(3).css({ "width": "150px", "text-align": "left" })
            });

            $("#txtcontent tr.tr_line").each(function () {
                $(this).children("td").eq(4).css({ "width": "60px", "text-align": "Center" })
            });

            $("#txtcontent tr.tr_line").each(function () {
                $(this).children("td").eq(5).css({ "width": "120px", "text-align": "right" })
            });

            $("#txtcontent tr.tr_line").each(function () {
                $(this).children("td").eq(6).css({ "width": "70px", "text-align": "Center" })
            });

            $("#txtcontent tr.tr_line").each(function () {
                $(this).children("td").eq(7).css({ "width": "70px", "align": "Center" })
            });

            $("#txtcontent tr.tr_line").each(function () {
                $(this).children("td").eq(8).css({ "width": "85px", "align": "Center" })
            });

            $("#txtcontent tr.tr_line").each(function () {
                $(this).children("td").eq(9).css({ "width": "105px", "align": "Center" })
            });

        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <%Response.Write("<script src=\"/common/UIControls/ReportContinuousPrint.js?str=" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + "\" type=\"text/javascript\"></script>");%>
        <%Response.Write("<script src=\"/common/UIControls/CreateWindow/CreateWindow.js?str=" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + "\" type=\"text/javascript\"></script>");%>
        <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
        </ext:ResourceManager>
        <ext:Hidden ID="hidShowVoid" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidShowInv" runat="server" Text="1">
        </ext:Hidden>
        <ext:Hidden ID="hidID" runat="server">
        </ext:Hidden>

        <script type="text/javascript">        var UserGroup = '<%=DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[8] %>'; var stat = '<%=DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[12]%>'; var user = '<%=DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[0]%>';</script>

        <div style="display: none">
            <ext:Button ID="btnCancel" runat="server" Text="Cancel">
                <DirectEvents>
                    <Click OnEvent="btnCancel_Click">
                        <EventMask ShowMask="true" />
                    </Click>
                </DirectEvents>
            </ext:Button>
        </div>
        <div>
            <table width="937px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                <tbody>
                    <tr>
                        <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <td width="100%">
                                            <table width="100%">
                                                <tr>
                                                    <td align="left" style="padding-left: 5px; width: 150px" class="font_11bold_1542af">OE-Shipment Detail List
                                                    </td>
                                                    <td width="50px" style="padding: 0 15px 0 0;">
                                                        <nobr><label id="labTransfer" runat="server">
                                        </label></nobr>
                                                    </td>
                                                    <td width="60px" style="padding: 0 0 0 0;">
                                                        <ext:Checkbox ID="chkShowVoid" runat="server" BoxLabel="Void" BoxLabelStyle="color:red;font-weight:bold">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked){hidShowVoid.setValue('1')}else{hidShowVoid.setValue('0')};CompanyX.ShowVoid();" />
                                                            </Listeners>
                                                        </ext:Checkbox>
                                                    </td>
                                                    <td>
                                                        <ext:Checkbox ID="chkShowInv" runat="server" BoxLabel="Invoice" BoxLabelStyle="color:red;font-weight:bold"
                                                            Checked="true">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked){hidShowInv.setValue('1')}else{hidShowInv.setValue('0')};CompanyX.ShowInv();" />
                                                            </Listeners>
                                                        </ext:Checkbox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="301" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px; padding-top: 4px;"
                                            class="font_11bold_1542af">
                                            <nobr> 
                                        Lot#&nbsp;<label id="txtLotNo" runat="server"></label>&nbsp;&nbsp;&nbsp;MBL#&nbsp;<label id="txtMawb" runat="server"></label></nobr>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div style="margin-top: 10px">
                <%--<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border: 1px solid #8db2e3;
            background: #f4f7fc; height: 22px; line-height: 22px">
            <tr>
                <td class="font_11bold_1542af" style="padding-left: 5px">
                    Container
                </td>
            </tr>
        </table>--%>
                <table style="margin-top: 10px; width: 937px" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <div id="txtcontainer" runat="server">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <table style="margin-top: 10px; width: 937px" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <div id="txtcontent" runat="server">
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <ext:Store runat="server" ID="StoreCurrInvoice">
            <Reader>
                <ext:JsonReader IDProperty="code">
                    <Fields>
                        <ext:RecordField Name="code">
                        </ext:RecordField>
                        <ext:RecordField Name="foreign">
                        </ext:RecordField>
                        <ext:RecordField Name="local">
                        </ext:RecordField>
                        <ext:RecordField Name="rate">
                        </ext:RecordField>
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <div id="win_close" style="background-color: Transparent; padding: 5px 15px; display: none; position: absolute; z-index: 2; top: 0px; left: 0px;">
            <img id="win_close_invoice" src="../../images/btn_close.png" style="position: absolute; right: 0; top: 0; width: 33px; height: 33px; cursor: pointer;" />
            <div id="NewInvoice" style="width: 320px; margin-top: 15px; padding-bottom: 10px; background: #fff; border: outset 2px #fff; padding: 10px;">
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tab_Invoice">
                    <tr>
                        <td colspan="2" style="background-image: url(/images/bg_line_3.jpg); height: 27px; border: solid 1px #8DB2E3; text-indent: 10px;"
                            class="font_11bold_1542af">New Invoice
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 15px;"></td>
                    </tr>
                    <tr>
                        <td valign="top" style="padding-top: 2px; padding-left: 40px">Company
                        </td>
                        <td style="width: 210px;">
                            <uc1:Autocomplete ID="txtCompany" runat="server" isAlign="false" TabIndex="45" query="option=CompanyList"
                                Width="100" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                winWidth="800" winHeight="800" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 40px">Currency
                        </td>
                        <td>
                            <ext:ComboBox ID="cmbCurrency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                TabIndex="45" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                Width="127" TriggerAction="All" SelectOnFocus="true" TypeAhead="true">
                                <Listeners>
                                    <Select Handler="#{radForeign}.setValue(record.data.foreign); #{radLocal}.setValue(record.data.local)" />
                                </Listeners>
                            </ext:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 8px;"></td>
                    </tr>
                    <%if (Convert.ToBoolean(DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[26]))
                      { %>
                    <tr>
                        <td></td>
                        <td style="vertical-align: middle; line-height: 25px;">
                            <input type="checkbox" id="chkChina" tabindex="45" style="vertical-align: middle; margin-right: 5px;" />
                            Show Chinese
                        </td>
                    </tr>
                    <%} %>
                    <tr style="display: none">
                        <td></td>
                        <td>
                            <ext:RadioGroup ID="rdNewInvoice" runat="server" SItemCls="x-check-group-base" Width="160px"
                                ReadOnly="true" Enabled="false" TabIndex="31">
                                <Items>
                                    <ext:Radio runat="server" BoxLabel="Foreign" ID="radForeign">
                                    </ext:Radio>
                                    <ext:Radio runat="server" BoxLabel="Local" ID="radLocal">
                                    </ext:Radio>
                                </Items>
                            </ext:RadioGroup>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px;"></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" value="" id="hid_seed" />
                        </td>
                        <td>
                            <input onclick="NewInvoice('OE', 'txtCompany', cmbCurrency, StoreCurrInvoice);" type="button"
                                style="background-image: url(../../images/btn_save_01.jpg); border: 0px; margin-bottom: 12px; width: 82px; height: 22px; cursor: pointer"
                                class="btn_text" tabindex="45" value="New Invoice" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="div_sheet" style="position: absolute; z-index: 889; top: 100px; left: 250px; background-color: #fff; padding: 15px; display: none; border: outset 2px #ddd">
            <img id="win_close_sheet" src="../../images/btn_close.png" style="position: absolute; right: -20px; top: -20px; width: 33px; height: 33px; cursor: pointer;" />
            <uc2:UserSheet ID="UserSheet1" runat="server" />
        </div>
    </form>
</body>
</html>

<script language="javascript" src="../../common/ylQuery/SetWindow.js" type="text/javascript"></script>

