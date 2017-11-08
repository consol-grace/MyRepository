<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PerformanceReports.aspx.cs"
    Inherits="PerformanceReports" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Performance reports</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="common/myplugin/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <style type="text/css">
        #div_Content p{text-align: center;margin: 0;padding: 4px 0px; }
        #div_Content p.p1{ font-size: 18px;font-weight: bold;color: Black;}
        #div_Content p.p2{font-size: 16px;font-weight: bold;color: #666;text-decoration: underline;}
        #div_Content p.p3 {font-size: 13px; font-weight: normal;color: #111; }
        #div_Content table {width: 100%;margin-top: 35px;}
        #div_Content table td{text-align: right;padding: 2px}
        #div_Content table tr.tr_header td, #div_Content table tr.tr_footer td {font-weight: bold;padding: 5px 2px; text-align:right}
        #div_Content table tr.tr_header td{border-bottom: solid 1px #000;}
        #div_Content table tr.tr_footer td{border-top: solid 1px #000;}
        #div_Content table td.td_UserName{ width:80px !important;}
        #div_Content table td.td_UserName span{margin-right:10px;}
        #div_Content table td.td_blank{padding-right:3px !important;}
        /* #div_Content table td.td_AE{width:35px;}
        #div_Content table td.td_Normal{width:70px;}
        #div_Content table td.td_SellMAWB{width:100px;}
        #div_Content table td.td_CONSOL{width:100px;}
        #div_Content table td.td_CBM{width:120px;}
        #div_Content table td.td_Direct{width:70px;}
        #div_Content table td.td_CWT{width:120px;} 
        #div_Content table td.td_OE{width:30px;}
        #div_Content table td.td_SellMAWB{width:80px;}
        #div_Content table td.td_F20{width:30px;}
        #div_Content table td.td_F40{width:30px;}
        #div_Content table td.td_F40H{width:30px;}
        #div_Content table td.td_F45{width:30px;}
        #div_Content table td.td_L20{width:30px;}
        #div_Content table td.td_L40{width:30px;}
        #div_Content table td.td_L40H{width:30px;}
        #div_Content table td.td_L45{width:30px;}
        #div_Content table td.td_AI{width:30px;}
        #div_Content table td.td_OI{width:30px;}
        #div_Content table td.td_AT{width:30px;}
        #div_Content table td.td_OT{width:30px;}
        #div_Content table td.td_TK{width:30px;}
        #div_Content table td.td_BK{width:30px;}
        #div_Content table td.td_DM{width:30px;}*/
    </style>
    <style type="text/css" media="print">
        .noprint
        {
            display: none;
        }
    </style>

    <script type="text/javascript">
        $(function() {
            $("#div_Content table tr").each(function() {
                $(this).children("td").eq(0).css("border-right", "solid 1px #000");
            })

        })
    </script>

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
        <tr class="noprint">
            <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                Performance reports
            </td>
        </tr>
        <tr class="noprint">
            <td style="padding: 15px 3px">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            Date
                        </td>
                        <td>
                            <asp:TextBox ID="txtBeginDate" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"></asp:TextBox>
                        </td>
                        <td>
                            To
                        </td>
                        <td>
                            <asp:TextBox ID="txtEndDate" runat="server" Cls="text" onfocus="WdatePicker({readOnly:true});"></asp:TextBox>                            
                        </td>
                        <td>
                            Department
                        </td>
                        <td>
                                <asp:DropDownList ID="drpDepartment" runat="server" ></asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button ID="btnSearch" runat="server" Text=" Search " OnClick="btnSearch_Click" />
                              
                        </td>
                        <td style="display: none">
                            <asp:Button ID="btnExport" runat="server" Text="Export" />
                        </td>
                        <td>
                            <input type="button" value="Print" onclick="pagesetup_null();WebBrowser.ExecWB(6,2,3);" />
                        </td>
                        <td style="display: none">
                            <input type="button" value="Print" onclick="pagesetup_null();doPrint();" />
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
