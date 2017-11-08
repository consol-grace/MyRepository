<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailList.aspx.cs" Inherits="OceanImport_OceanShipmentJobList_DetailList" %>

<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Src="../../common/UIControls/Autocomplete.ascx" TagName="Autocomplete"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/UIControls/gridHtml.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var FormatNumber3 = function(obj) {
            if (obj != null) {
                return obj.toFixed(3);
            }
        }
    </script>

    <style type="text/css">
        .div_BtnCtnr
        {
            z-index: 1;
            margin-left: auto;
            margin-right: auto;
            cursor: pointer;
            background-image: url(/images/arrows_btn_01.png);
            background-repeat: no-repeat;
            width: 16px;
            height: 15px;
        }
        .div_BtnCtnr div
        {
            display: none;
            position: relative;
            width: 876px;
            height: auto;
            top: -1px;
            left: 30px;
            z-index: 100;
            text-align: left;
            padding-top: 18px;
            padding-left: 8px;
        }
    </style>

    <script type="text/javascript">
        var sysType = 'OI';

        $(function() {
            //            $(".div_BtnCtnr").each(function(index) {
            //                $(this).click(function() {
            //                    if (window.event.srcElement.tagName == "DIV") {
            //                        $(".div_BtnCtnr").children("div").hide();
            //                        var seed = $(this).parent().parent().find("#hidValue span").eq(0).text();
            //                        var cnno = $(this).parent().parent().find("#hidValue span").eq(1).text();
            //                        var isvoid = $("#hidShowVoid").val();
            //                        var str = "";

            //                        $.getJSON("/common/uicontrols/gridHtml.ashx?type=ContainerList&sys=OI&isvoid=" + isvoid + "&cnno=" + cnno + "&seed=" + seed, function(data) {
            //                            str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/hawb_blue_01.png); width:824px; height:17px;"></td></tr><tr><td style="background-image:url(/images/hawb_blue_02.png); width:824px;text-align:left;">';
            //                            str += '<table border="0" cellpadding="0" cellspacing="0">';
            //                            $.each(data, function(i, n) {
            //                                str += '<tr style="line-height:18px;" class="trcolor">' + '<td width="102px">' + n.isvoid + '</td><td  style="text-align:left;width:142px;padding-left:6px;">' + n.HBL + '</td>' + '<td style="text-align:right;width:94px;padding-right:10px;">' + n.oc_GWT + '</td>' + '<td  style="text-align:right;width:94px;padding-right:15px;">' + n.oc_CBM + '</td>' + '<td  style="text-align:right;width:93px;padding-right:15px;">' + n.oc_Piece + '</td><td style="text-align:left;width:285px;padding-left:1px;">' + n.Remark + '</td>' + '</tr>';
            //                            });
            //                            str += '</table>';
            //                            str += '</td></tr><tr><td style="background-image:url(/images/hawb_blue_03.png); width:824px; height:8px;"></td></tr></table>';
            //                            $(".div_BtnCtnr").eq(index).children("div").html(str).show();

            //                            $("#txtcontainer .div_BtnCtnr").children("div").find("tr.trcolor").click(function() {
            //                                if (window.event.srcElement.tagName == "TD") {
            //                                    window.open($(this).children("td").eq(1).find("a").attr("href"), $(this).children("td").eq(1).find("a").attr("target"));

            //                                }
            //                            });


            //                        });
            //                    }
            //                })
            //            })



            $("#form1").click(function() {
                if (window.event.srcElement.tagName != "DIV") {
                    $(".div_BtnCtnr").children("div").hide();
                }
            })

        })
       
        
    </script>

    <script type="text/javascript">
        $(function() {

            $("#txtcontainer tr.tr_line").children("td").eq(0).css("width", "50px");

            $("#txtcontainer tr.tr_line").children("td").eq(1).css("width", "139px");

            $("#txtcontainer tr.tr_line").each(function() {
                $(this).children("td").eq(2).css({ "width": "150px", "text-align": "left" });
            })

            $("#txtcontainer tr.tr_line").each(function(index) {
                $(this).children("td").eq(3).css({ "width": "83px", "text-align": "right" })
            });

            $("#txtcontainer tr.tr_line").each(function() {
                $(this).children("td").eq(4).css({ "width": "83px", "text-align": "right" })
            });

            $("#txtcontainer tr.tr_line").each(function() {
                $(this).children("td").eq(5).css({ "width": "83px", "text-align": "right" })
            });

            $("#txtcontainer tr.tr_line").each(function() {
                $(this).children("td").eq(6).css({ "width": "165px", "text-align": "left" })
            });

            $("#txtcontainer tr.tr_line").each(function() {
                $(this).children("td").eq(7).css({ "width": "105px", "align": "Center" })
            });


            $("#txtcontainer tr.tr_line").each(function(index) {
                $(this).hover(function() {
                    $(this).css("background", "#fafafa");
                    $(".div_BtnCtnr").children("div").hide();
                    var isvoid = $("#hidShowVoid").val();
                    if ($(".div_BtnCtnr").eq(index).children("div").html() == "" && isvoid != undefined) {
                        var seed = $(this).find("#hidValue span").eq(0).text();
                        var cnno = $(this).find("#hidValue span").eq(1).text();

                        var str = "";

                        $.getJSON("/common/uicontrols/gridHtml.ashx?type=ContainerList&sys=OI&isvoid=" + isvoid + "&cnno=" + cnno + "&seed=" + seed, function(data) {
                            str += '<table border="0" cellpadding="0" cellspacing="0"><tr><td style="background-image:url(/images/hawb_blue_01.png); width:875px; height:17px;"></td></tr><tr><td style="background-image:url(/images/hawb_blue_02.png); width:875px;text-align:left;">';
                            str += '<table border="0" cellpadding="0" cellspacing="0">';
                            $.each(data, function(i, n) {
                                var remark = '<a class="btn_print btn_print_C_20 btn_print_140" href="ReportFile.aspx?type=Devanning&ID=' + n.oc_Seed + '" target="_blank">Devanning</a>';   //n.Remark
                                str += '<tr style="line-height:26px;" class="trcolor">' + '<td width="148px">' + n.isvoid + '</td><td  style="text-align:left;width:151px;padding-left:5px;">' + n.HBL + '</td>' + '<td style="text-align:right;width:88px;padding-right:5px;">' + n.oc_GWT + '</td>' + '<td  style="text-align:right;width:88px;padding-right:5px;">' + n.oc_CBM + '</td>' + '<td  style="text-align:right;width:88px;padding-right:5px;">' + n.oc_Piece + '</td><td style="text-align:left;width:170px;padding-left:2px;">' + n.Remark + '</td><td style="vertical-align:middle;text-align:center;width:118px;padding-left:4px;">' + remark + '</td></tr>';
                            });
                            str += '</table>';
                            str += '</td></tr><tr><td style="background-image:url(/images/hawb_blue_03.png); width:875px; height:8px;"></td></tr></table>';

                            $(".div_BtnCtnr").eq(index).children("div").html(str).show();

                            $(".div_BtnCtnr").eq(index).children("div").find("tr.trcolor").click(function() {
                                if (window.event.srcElement.tagName == "TD") {
                                    window.open($(this).children("td").eq(1).find("a").attr("href"), $(this).children("td").eq(1).find("a").attr("target"));

                                }
                            });


                        });
                    }
                    else {
                        $(".div_BtnCtnr").eq(index).children("div").show();

                    }

                }, function() {
                    $(this).css("background", "#fff");
                    //$(".div_BtnCtnr").children("div").hide();
                    $(".div_BtnCtnr").eq(index).children("div").hide();
                });
            });

        })
    </script>

    <script type="text/javascript">
        $(function() {

            $("#txtContent tr.tr_line").children("td").eq(0).css("width", "50px");

            $("#txtContent tr.tr_line td").eq(1).css("width", "80px");

            $("#txtContent tr.tr_line").each(function() {
                $(this).children("td").eq(2).css({ "width": "50px", "text-align": "Center" });
            })

            $("#txtContent tr.tr_line").each(function(index) {
                $(this).children("td").eq(3).css({ "width": "150px", "text-align": "left" })
            });

            $("#txtContent tr.tr_line").each(function() {
                $(this).children("td").eq(4).css({ "width": "60px", "text-align": "Center" })
            });

            $("#txtContent tr.tr_line").each(function() {
                $(this).children("td").eq(5).css({ "width": "120px", "text-align": "right" })
            });

            $("#txtContent tr.tr_line").each(function() {
                $(this).children("td").eq(6).css({ "width": "70px", "text-align": "Center" })
            });

            $("#txtContent tr.tr_line").each(function() {
                $(this).children("td").eq(7).css({ "width": "70px", "align": "Center" })
            });

            $("#txtContent tr.tr_line").each(function() {
                $(this).children("td").eq(8).css({ "width": "85px", "align": "Center" })
            });

            $("#txtContent tr.tr_line").each(function() {
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
    <div>
        <div style="display: none">
            <ext:Button ID="btnCancel" runat="server" Text="Cancel">
                <DirectEvents>
                    <Click OnEvent="btnCancel_Click">
                        <EventMask ShowMask="true" />
                    </Click>
                </DirectEvents>
            </ext:Button>
        </div>
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
                                                <td align="left" style="padding-left: 5px; width: 150px" class="font_11bold_1542af">
                                                    OI-Shipment Detail List
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
                                    <td width="371" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px;
                                        padding-top: 4px;" class="font_11bold_1542af">
                                        <nobr> Lot#&nbsp;<label id="txtLotNo" runat="server"></label>&nbsp;&nbsp;&nbsp;MBL#&nbsp;<label id="txtMawb" runat="server"></label></nobr>
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
                    <div id="txtContent" runat="server">
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
    <div id="win_close" style="background-color: Transparent; padding: 5px 15px; display: none;
        position: absolute; z-index: 2; top: 0px; left: 0px;">
        <img id="win_close_invoice" src="../../images/btn_close.png" style="position: absolute;
            right: 0; top: 0; width: 33px; height: 33px; cursor: pointer;" />
        <div id="NewInvoice" style="width: 320px; margin-top: 15px; padding-bottom: 10px;
            background: #fff; border: outset 2px #fff; padding: 10px;">
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tab_Invoice">
                <tr>
                    <td colspan="2" style="background-image: url(/images/bg_line_3.jpg); height: 27px;
                        border: solid 1px #8DB2E3; text-indent: 10px;" class="font_11bold_1542af">
                        New Invoice
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 15px;">
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="padding-top: 2px; text-indent: 40px;">
                        Company
                    </td>
                    <td style="width: 210px;">
                        <uc1:Autocomplete ID="txtCompany" runat="server" isAlign="false" TabIndex="45" query="option=CompanyList"
                            Width="100" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" />
                    </td>
                </tr>
                <tr>
                    <td style="text-indent: 40px;">
                        Currency
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
                    <td colspan="2" style="height: 8px;">
                    </td>
                </tr>
                <%if (Convert.ToBoolean(DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[26]))
                  { %>
                <tr>
                    <td>
                    </td>
                    <td style="vertical-align: middle; line-height: 25px;">
                        <input type="checkbox" id="chkChina" tabindex="45" style="vertical-align: middle;
                            margin-right: 5px;" />
                        Show Chinese
                    </td>
                </tr>
                <%} %>
                <tr style="display: none">
                    <td>
                    </td>
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
                    <td colspan="2" style="height: 10px;">
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" value="" id="hid_seed" />
                    </td>
                    <td>
                        <input onclick="NewInvoice('OI','txtCompany',cmbCurrency,StoreCurrInvoice);" type="button"
                            style="background-image: url(../../images/btn_save_01.jpg); border: 0px; margin-bottom: 12px;
                            width: 82px; height: 22px; cursor: pointer" class="btn_text" tabindex="45" value="New Invoice" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="div_sheet" style="position: absolute; z-index: 3; top: 100px; left: 250px;
        background-color: #fff; padding: 15px; display: none; border: outset 2px #ddd">
        <img id="win_close_sheet" src="../../images/btn_close.png" style="position: absolute;
            right: -20px; top: -20px; width: 33px; height: 33px; cursor: pointer;" />
        <uc2:UserSheet ID="UserSheet1" runat="server" />
    </div>
    </form>
</body>
</html>

<script language="javascript" src="../../common/ylQuery/SetWindow.js" type="text/javascript"></script>

