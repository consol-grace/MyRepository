<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailList.aspx.cs" Inherits="AirImport_AIShipmentJobList_DetailList" %>

<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Src="../../common/UIControls/Autocomplete.ascx" TagName="Autocomplete"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/UIControls/gridHtml.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="Transfer.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        var sysType = 'AE';

        var FormatNumber3 = function(obj) {
            if (obj != null) {
                return obj.toFixed(3);
            }
        }
        $(function() {

            CreatHAWB();

            var scrollTop = 0;
            $(window).scroll(function() {
                if ($.browser.msie) {
                    if ($.browser.version == "8.0")
                        scrollTop = document.documentElement.scrollTop;
                }
            })

            $(".tr_line").hover(function() {
                $(this).find(".div_change").show();
            },
            function() {
                if ($("#div_HAWB").css("display") == "none") { $(this).find(".div_change").hide(); }
            })


            $(".div_change").click(function() {
                $("#div_offical").hide();
                $(".div_change").hide();
                $(this).show();
                var offset = $(this).offset();
                $("#div_HAWB").css({ top: offset.top + 16 + scrollTop, left: offset.left - 70 }).show();
                $("#hidseed").val($(this).attr("seed"));
                $("#txtHAWB").val($(this).parent().prev().find("a").text()).focus().select();
            })

            $("#txtHAWB").keydown(function() {
                if (event.keyCode == 13)
                    $("#btn_Hawb").click();
            })

            $("#btn_Hawb").click(function() {

                var seed = $("#hidseed").val();
                var offical = $("#txtHAWB").val();
                if (offical == null || offical == "" || offical == undefined) {
                    offical = "";
                }
                if (seed == null || seed == "" || seed == undefined) {
                    Ext.Msg.alert('status', ' Error ,Please refresh the page . ', function() {
                        window.location.reload();
                    })
                }

                $.get('/common/uicontrols/gridHtml.ashx?type=HAWB&seed=' + seed + "&hawbNo=" + offical, function(data) {

                    if (data == "Y") {
                        window.location.reload();
                    }
                    else {
                        Ext.Msg.alert('status', ' Error ,The input value already exists . ', function() {
                            $("#txtHAWB").focus().select();
                        })
                    }
                })

            })



        })

        ///创建 hawb No 输入框
        function CreatHAWB() {

            var str = "<div id=\"div_HAWB\" style=\"display:none; position:absolute;background-image:url(/images/hawb_pink.png); width: 170px;height: 55px;padding-top:15px; padding-left:10px; z-index:1;\">"
            + "<p style='line-height:25px;font-size:12px;margin:0px;padding:0px; font-family:微软雅黑'><b>HAWB</b></p> <input type='text' id='txtHAWB' style='border:solid 1px #ddd;height:14px;padding:1px 2px;margin-right:5px;'>"
            + "<input type='hidden' id='hidseed'><input type='button' id='btn_Hawb' value=' OK ' style='border:solid 1px #ddd;width:40px; background:#fff; height:18px;cursor:pointer;'> </div>";
            $("body").append(str);
        }

        
    </script>

    <style type="text/css">
        .div_change
        {
            position: absolute;
            z-index: 1;
            margin-left: 5px;
            display: none;
            cursor: pointer;
            background-image: url(/images/hawb.png);
            background-repeat: no-repeat;
            width: 47px;
            height: 17px;
        }
    </style>
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
        <table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tbody>
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="100%">
                            <tbody>
                                <tr>
                                    <td width="100" align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                        AE-Detail List
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
                                    <td width="301" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px;
                                        padding-top: 4px;" class="font_11bold_1542af">
                                        <nobr>Lot#&nbsp;<label id="txtLotNo" runat="server"></label>&nbsp;&nbsp;&nbsp;MAWB#&nbsp;<label id="txtMawb" runat="server"></label>  </nobr>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top: 10px; width: 100%">
            <tr>
                <td>
                    <div runat="server" id="txtcontent">
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

