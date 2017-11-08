<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintLotList.aspx.cs" Inherits="AllSystem_PrintLotList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lot Printing</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="/common/myplugin/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

    <style type="text/css">
        input[type='text']
        {
            border: outset 1px #555;
        }
        .btn_print
        {
            margin-left: 10px;
        }
        #div_Content p{text-align: center;margin: 0;padding: 4px 0px; display:none}
        #div_Content p.p1{ font-size: 18px;font-weight: bold;color: Black;}
        #div_Content p.p2{font-size: 16px;font-weight: bold;color: #666;text-decoration: underline;}
        #div_Content p.p3 {font-size: 13px; font-weight: normal;color: #111; }
        #div_Content table {width: 100%;margin-top: 20px;}
        #div_Content table td{text-align: left;padding: 2px}
        #div_Content table tr.tr_header td{font-weight: bold;padding: 5px 2px; text-align:left}
        #div_Content table tr.tr_header td{border-bottom: solid 1px #000;}
        #div_Content table td.td_UserName{ width:80px !important;}
        #div_Content table td.td_UserName span{margin-right:10px;}
        #div_Content table td.td_blank{padding-right:3px !important;}
    </style>
    <style type="text/css" media="print">
        .noprint
        {
            display: none;
        }
    </style>
      <script type="text/javascript">
          function doPrint() {

              bdhtml = window.document.body.innerHTML;
              sprnstr = "<!--startprint-->";
              eprnstr = "<!--endprint-->";
              prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
              prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
              window.document.body.innerHTML = prnhtml;
              window.print();
          }
    </script>

    <script type="text/javascript">

        var HKEY_Root, HKEY_Path, HKEY_Key;
        HKEY_Root = "HKEY_CURRENT_USER";
        HKEY_Path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";

        //获得IE浏览器版本
        function checkIEV() {
            var X, V, N;
            V = navigator.appVersion;
            N = navigator.appName;
            if (N == "Microsoft Internet Explorer")
                X = parseFloat(V.substring(V.indexOf("MSIE") + 5, V.lastIndexOf("Windows")));
            else
                X = parseFloat(V);
            return X;
        }


        //设置网页打印的页眉页脚为空
        function pagesetup_null() {
            try {
                var Wsh = new ActiveXObject("WScript.Shell");
                HKEY_Key = "header";
                //设置页眉（为空）
                //Wsh.RegRead(HKEY_Root+HKEY_Path+HKEY_Key)可获得原页面设置   
                Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "");
                HKEY_Key = "footer";
                //设置页脚（为空）   
                Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "");

                //这里需要浏览器版本，8.0以下的页边距设置与8.0及以上不一样，注意注册表里的单位是英寸，打印设置中是毫米，1英寸=25.4毫米
                if (checkIEV() < 8.0) {
                    HKEY_Key = "margin_left";
                    //设置左页边距
                    Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0.25");
                    HKEY_Key = "margin_right";
                    //设置右页边距
                    Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0.25");
                    HKEY_Key = "margin_top";
                    //设置上页边距
                    Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0.10");
                    HKEY_Key = "margin_bottom";
                    //设置下页边距   
                    Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0.10");
                }
                else {
                    HKEY_Key = "margin_left";
                    //设置左页边距
                    Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0");
                    HKEY_Key = "margin_right";
                    //设置右页边距
                    Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0");
                    HKEY_Key = "margin_top";
                    //设置上页边距
                    Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0.405");
                    HKEY_Key = "margin_bottom";
                    //设置下页边距   
                    Wsh.RegWrite(HKEY_Root + HKEY_Path + HKEY_Key, "0.405");
                }

            } catch (e) { }
        }
        //设置网页打印的页眉页脚为默认值
        function pagesetup_default() {
            try {
                var RegWsh = new ActiveXObject("WScript.Shell");
                hkey_key = "header";
                RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "&w&b页码，&p/&P");
                hkey_key = "footer";
                RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "&u&b&d");
            } catch (e) { }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <table width="1000" border="0" cellpadding="0" cellspacing="0">
        <tr class="noprint" style=" display:none ">
            <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                <asp:Label ID="labSys" runat="server"></asp:Label>
                - Lot list
            </td>
        </tr>
        <tr class="noprint" style=" display:none ">
            <td style="padding: 15px 3px">
                <table id="tabAI" runat="server" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>LotNo</td>
                        <td>
                            <asp:TextBox ID="txtAIlotno" runat="server" Cls="text" Width="80"></asp:TextBox>

                        </td>
                        <td>
                            From
                        </td>
                        <td>
                            <asp:TextBox ID="txtAIfrom" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="70"></asp:TextBox>
                        </td>
                         <td>
                            To
                        </td>
                        <td>
                            <asp:TextBox ID="txtAIto" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="70"></asp:TextBox>
                        </td>
                        <td>
                            Shipper/Consignee
                        </td>
                        <td>
                            <asp:TextBox ID="txtAIshipper" runat="server" Cls="text" Width="80"></asp:TextBox>
                        </td>
                        <td>
                            MAWB
                        </td>
                        <td>
                            <asp:TextBox ID="txtAImawb" runat="server" Cls="text" Width="80"></asp:TextBox>
                        </td>
                        <td>
                            From / To
                        </td>
                        <td>
                            <asp:TextBox ID="drpAIfromto" runat="server" Width="60">
                            </asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkAINormal" runat="server" />
                        </td>
                        <td>
                            Normal
                        </td>
                        <td>
                            <asp:CheckBox ID="chkAIDirect" runat="server" />
                        </td>
                        <td>
                            Direct
                        </td>
                        <td>
                            <asp:CheckBox ID="chkAIVoid" runat="server" />
                        </td>
                        <td>
                            Void
                        </td>
                        <td>
                            <asp:Button ID="btnSearchAI" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                        </td>
                        <td>
                            <input type="button" value="Print" onclick="pagesetup_null();WebBrowser.ExecWB(6,2,3);" />
                        </td>
                        <td style="display: none">
                            <input type="button" class="btn_print" value="Print" onclick="pagesetup_null();doPrint();" />
                        </td>
                    </tr>
                </table>
                <table id="tabAE" runat="server" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            Lot#
                        </td>
                        <td>
                            <asp:TextBox ID="txtAElot" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            MAWB No.
                        </td>
                        <td>
                            <asp:TextBox ID="txtAEmawb" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            Dest.
                        </td>
                        <td>
                            <asp:DropDownList ID="drpAEdest" runat="server" Width="95">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Flight From
                        </td>
                        <td>
                            <asp:TextBox ID="txtAEfrom" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox>
                        </td>
                        <td>
                            Flight To
                        </td>
                        <td>
                            <asp:TextBox ID="txtAEto" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="12" style="height: 10px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Shipper
                        </td>
                        <td>
                            <asp:TextBox ID="txtAEshipper" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            Consignee
                        </td>
                        <td>
                            <asp:TextBox ID="txtAEconsignee" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            Co-loader
                        </td>
                        <td>
                            <asp:TextBox ID="txtAEcoloader" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td colspan="4" style="text-align: right; padding-right: 32px">
                            <asp:Button ID="btnSearchAE" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                            <input type="button" class="btn_print" value="Print" onclick="pagesetup_null();WebBrowser.ExecWB(6,2,3);" />
                        </td>
                    </tr>
                </table>
                <table id="tabOI" runat="server" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            Lot No. #
                        </td>
                        <td>
                            <asp:TextBox ID="txtOIlot" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            MBL#
                        </td>
                        <td>
                            <asp:TextBox ID="txtOImbl" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            Vessel
                        </td>
                        <td>
                            <asp:TextBox ID="txtOIvessel" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            POL
                        </td>
                        <td>
                            <asp:TextBox ID="txtOIpol" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            POD
                        </td>
                        <td>
                            <asp:TextBox ID="txtOIpod" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" style="height: 10px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            From
                        </td>
                        <td>
                            <asp:TextBox ID="txtOIfrom" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox>
                        </td>
                        <td>
                            To
                        </td>
                        <td>
                            <asp:TextBox ID="txtOIto" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox>
                        </td>
                        <td colspan="6" style="text-align: right; padding-right: 52px">
                            <asp:Button ID="btnSearchOI" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                            <input type="button" class="btn_print" value="Print" onclick="pagesetup_null();WebBrowser.ExecWB(6,2,3);" />
                        </td>
                         <td>
                            Shipper/Consignee
                        </td>
                        <td>
                            <asp:TextBox ID="txtOIShipper" runat="server" Cls="text" Width="80"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chbOIVoid" runat="server" />
                        </td>
                        <td>
                            Void
                        </td>
                        <td>
                            <asp:Button ID="Button1" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
                <table id="tabOE" runat="server" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            Lot#
                        </td>
                        <td>
                            <asp:TextBox ID="txtOElot" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            MBL#
                        </td>
                        <td>
                            <asp:TextBox ID="txtOEmbl" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            Dest
                        </td>
                        <td>
                            <asp:TextBox ID="txtOEdest" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                        <td>
                            Date From
                        </td>
                        <td>
                            <asp:TextBox ID="txtOEfrom" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="80"></asp:TextBox>
                        </td>
                        <td>
                            Date To
                        </td>
                        <td>
                            <asp:TextBox ID="txtOEto" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="80"></asp:TextBox>
                        </td>
                        <td>
                            Shipper/Consignee
                        </td>
                        <td>
                            <asp:TextBox ID="txtOEShipper" runat="server" Cls="text" Width="80"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chbOEVoid" runat="server" />
                        </td>
                        <td>
                            Void
                        </td>
                        <td>
                            <asp:Button ID="btnSearchOE" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                        </td>
                        <td>
                            <input type="button" class="btn_print" value="Print" onclick="pagesetup_null();WebBrowser.ExecWB(6,2,3);" />
                        </td>
                    </tr>
                </table>
                <table id="tabTG" runat="server" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                    <td>Lot#</td>
                        <td> <asp:TextBox ID="txtTGLotNo" runat="server" Cls="text"  Width="90"></asp:TextBox></td>
                         <td>MBL#</td>
                        <td> <asp:TextBox ID="txtTGmbl" runat="server" Cls="text"  Width="90"></asp:TextBox></td>
                        <td>HBL#</td>
                        <td> <asp:TextBox ID="txtTGhbl" runat="server" Cls="text"  Width="90"></asp:TextBox></td>
                        <td>Shipper</td>
                        <td> <asp:TextBox ID="txtTGshipper" runat="server" Cls="text"  Width="90"></asp:TextBox></td>                    
                        <td>Consignee</td>
                        <td> <asp:TextBox ID="txtTGconsignee" runat="server" Cls="text"  Width="90"></asp:TextBox></td>
                        <td>From</td>
                        <td> <asp:TextBox ID="txtTGfrom" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox></td>
                        <td>To</td>
                        <td> <asp:TextBox ID="txtTGto" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox></td>
                         <td>
                         <td>
                            Dest
                        </td>
                        <td>
                            <asp:TextBox ID="txtTGdest" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                          <td>
                            <asp:CheckBox ID="chbTGVoid" runat="server" />
                        </td>
                        <td>
                            Void
                        </td>
                            <asp:Button ID="btnSearchTG" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                        </td>
                        <td>
                            <input type="button" class="btn_print" value="Print" onclick="pagesetup_null();WebBrowser.ExecWB(6,2,3);" />
                        </td>
                    </tr>
                </table>
                <table id="tabOB" runat="server" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                    <td>Lot#</td>
                        <td> <asp:TextBox ID="txtOBlotNo" runat="server" Cls="text"  Width="90"></asp:TextBox></td>
                         <td>MBL#</td>
                        <td> <asp:TextBox ID="txtOBmbl" runat="server" Cls="text"  Width="90"></asp:TextBox></td>
                        <td>HBL#</td>
                        <td> <asp:TextBox ID="txtOBhbl" runat="server" Cls="text"  Width="90"></asp:TextBox></td>
                        <td>Shipper</td>
                        <td> <asp:TextBox ID="txtOBshipper" runat="server" Cls="text"  Width="90"></asp:TextBox></td>                    
                        <td>Consignee</td>
                        <td> <asp:TextBox ID="txtOBconsignee" runat="server" Cls="text"  Width="90"></asp:TextBox></td>
                        <td>From</td>
                        <td> <asp:TextBox ID="txtOBfrom" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox></td>
                        <td>To</td>
                         <td>
                            Dest
                        </td>
                        <td>
                            <asp:TextBox ID="txtOBdest" runat="server" Cls="text" Width="90"></asp:TextBox>
                        </td>
                          <td>
                            <asp:CheckBox ID="chbOBVoid" runat="server" />
                        </td>
                        <td>
                            Void
                        </td>
                        <td> <asp:TextBox ID="txtOBto" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox></td>
                         <td>
                            <asp:Button ID="btnSearchOB" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                        </td>
                        <td>
                            <input type="button" class="btn_print" value="Print" onclick="pagesetup_null();WebBrowser.ExecWB(6,2,3);" />
                        </td>
                    </tr>
                </table>
                  <table id="tabDO" runat="server" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>Date</td>
                        <td> <asp:TextBox ID="txtDODate" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox></td>
                        <td>To</td>
                         <td> <asp:TextBox ID="txtDOTo" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"
                                Width="90"></asp:TextBox></td>
                                 <td>
                            Company
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDOCompany" runat="server" Width="95">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Void
                        </td>
                          <td>
                            <asp:CheckBox ID="cbDOVoid" runat="server" />
                        </td>
                         <td>
                            <asp:Button ID="btnSearchDO" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                        </td>
                        <td>
                            <input type="button" class="btn_print" value="Print" onclick="pagesetup_null();WebBrowser.ExecWB(6,2,3);" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="border: solid 1px #fff; padding: 10px 5px">
                <object id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0"
                    width="0">
                </object>
                <!--startprint-->
                <div id="div_Content">
                    <p class="p1">
                        <asp:Label ID="labCompany" runat="server"></asp:Label></p>
                    <p class="p2">
                        <asp:Label ID="labReprot" runat="server"></asp:Label></p>
                    <p class="p3">
                        <asp:Label ID="labStat" runat="server"></asp:Label></p>
                    <asp:Literal ID="ltlContent" runat="server">
                    </asp:Literal></div>
                <!--endprint-->
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
