<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportContinuousPrint.aspx.cs"
    Inherits="common_UIControls_ReportContinuousPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="/common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="/common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script type="text/javascript" src="/common/UIControls/ReportContinuousPrint.js"></script>

    <script type="text/javascript">
        $(function() {

            $("#div_content").focus();
            var height = $("#div_content").height() + 46;
            var docHeight = parseInt(window.parent.document.documentElement.clientHeight);
            if (height > (docHeight - 100))
                height = docHeight - 80;
            var top = (docHeight - height) / 2;
            if (top <= 0)
                top = 0;
            else if (top >= 50)
                top = top - top * 0.25;

            window.parent.div_parent_content.style.height = height + 'px';
            window.parent.div_parent_content.style.top = top + 'px';
            window.parent.td_content.style.height = (height - 20) + 'px';

            $(document).keydown(function(e) {

                if (e.keyCode == 27) {
                    window.parent.document.getElementById('div_parent_show').style.display = 'none';
                    window.parent.document.getElementById('div_parent_content').style.display = 'none';
                }
            })

            $("#chkHBL").click(function() {
                selectBox("bill", $(this).attr("checked"));
            })
            $("#chkSbs").click(function() {
                selectBox("sbs", $(this).attr("checked"));
            })
            $("#chkDraft").click(function() {
                selectBox("HDraft", $(this).attr("checked"));
            })

        })

        function selectBox(classid, flag) {
            $("." + classid).attr("checked", flag);
        }
    </script>

    <style type="text/css">
        *
        {
            margin: 0px;
            padding: 0px;
        }
        body
        {
            -webkit-text-size-adjust: none;
            padding: 10px;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            color: #000000;
            border: 0;
            height: 100%;
        }
        input[type="checkbox"]
        {
            vertical-align: middle;
            border: 0px;
            margin-right: 3px;
            margin-top: -3px;
        }
        label
        {
            margin-right: 15px;
        }
        .table_grid div
        {
            border-bottom: dashed 1px #ddd;
            line-height: 30px;
            clear: both;
            float: left;
            width: 98.8%;
        }
        li
        {
            float: left;
            list-style-type: none;
        }
        #table_button
        {
            margin-bottom: 8px;
            margin-left: 3px;
            float: right;
        }
        #table_button input[type='button'], #btnContinue, #btnCancel
        {
            cursor: pointer;
            margin: 0px 2px;
            background-image: url("/common/uicontrols/ajaxservice/repList_btn.png");
            background-position: center center;
            width: 65px;
            height: 22px;
            border: 0px;
            font-size: 10px;
            font-weight: bold;
        }
        #btnContinue, #btnCancel
        {
            width: 63px;
            height: 21px;
            margin: 0px 15px;
            font-size: 11px !important;
        }
        .table_grid table
        {
            vertical-align: top;
            width: 100%;
            border: solid 1px #99BBE8;
        }
        .table_grid table .tr_header td
        {
            font-weight: bold;
            height: 23px;
            vertical-align: middle;
            background-image: url("/images/html_img/T_bg_01.jpg");
            border-left: solid 1px white;
            border-right: solid 1px #D0D0D0;
            border-bottom: solid 1px #D0D0D0;
            padding: 0px 5px;
        }
        .table_grid table tr.tr_line td
        {
            padding: 2px 2px 2px 5px;
            border-left: solid 1px white;
            border-right: solid 1px #E9E9E9;
            border-top: solid 1px white;
            border-bottom: solid 1px #E9E9E9;
            vertical-align: top;
        }
        .table_grid table tr.tr_line td
        {
            line-height: 14px;
        }
        .table_grid table td.td_line
        {
            vertical-align: middle;
            text-align: center;
            border-left: solid 0px #fff !important;
        }
        .table_grid table tr input.chkline
        {
            margin-top: 3px;
        }
        label span
        {
            color: Blue; /*#4392d4*/
        }
        i
        {
            color: #555;
        }
        input[type='checkbox']
        {
            width: 12px;
            height: 12px;
        }
        .table_grid table table{ margin:0px; padding:0px; border:0px;}
        .table_grid table tr.tr_line td table td{ margin:0px; padding:0px; border:0px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" id="hidParm" value="" />
    <div id="div_content" style="float: left; width: 100%; padding-bottom: 15px;">
        <table id="table_button">
            <tr>
                <% if (Request["sysType"] == "OE")
                   {%>
                <%-- <td>
                    <input type="checkbox" id="chkSbs" title="select all SBS" /><label title="select all SBS"
                        for="chkSbs">SBS</label>
                </td>
                <td>
                    <input type="checkbox" id="chkDraft" title="select all Draft" /><label title="select all Draft"
                        for="chkDraft">Draft</label>
                </td>--%>
                 <td>
                    <input type="checkbox" id="chkDraft" title="select all Draft" /><label title="select all Draft"
                        for="chkDraft">HBL Draft</label>
                </td>
                <td>
                    <input type="checkbox" id="chkHBL" title="select all HBL" /><label title="select all HBL"
                        for="chkHBL">HBL</label>
                </td>
                <%}
                   else if (Request["sysType"] == "OI")
                   {%>
                <%}
                   else if (Request["sysType"] == "AE")
                   {%>
                <%}
                   else if (Request["sysType"] == "AI")
                   {%>
                <%} %>
                <td width="90px">
                    <input type="checkbox" id="chkAll" /><label for="chkAll" id="labAll">Select All</label>
                </td>
                <td width="120px">
                    <input type="checkbox" id="chkItem" /><label for="chkItem" id="labItem">Invert Select</label>
                </td>
                <td>
                    <input type="button" id="btnPrint" value="Print" onclick="PrintAll('PRINT');" />
                </td>
                <td>
                    <input type="button" runat="server" id="btnPdf" value="Email" onclick="PrintAll('PDF');" />
                </td>
            </tr>
        </table>
        <div class="table_grid" style="clear: both;">
            <%=GetList()%>
        </div>
    </div>
    <div id="win_show" style="display: none; position: absolute; z-index: 9998; top: 0px;
        left: 0px; width: 100%; height: 100%; background-color: #ccc; filter: alpha(opacity=50);
        opacity: 0.5;">
    </div>
    <div id="div_confirm" style="width: 300px; position: absolute; display: none; border: solid 1px #B3C4DA;
        z-index: 99999; padding: 2px 5px; top: 0; left: 31%; background-image: url('/common/uicontrols/ajaxservice/cont_bg.png');
        background-color: #ffffff">
        <div style="font-weight: bold; font-size: 11px;">
            <span>Status</span><span></span></div>
        <div style="vertical-align: middle; line-height: 16px; margin: 13px 5px; font-size: 11px;
            float: left; width: 290px">
            <img src="img_report/confirm.gif" style="float: left; margin-right: 8px; width: 32px;" />
            <div class="div_confirm_content" style="float: right; width: 245px; margin-right: 2px;">
            </div>
        </div>
        <div style="text-align: center; margin: 10px 0; clear: both">
            <input type="button" value="Yes" id="btnContinue" /><input type="button" value="No"
                id="btnCancel" /></div>
    </div>
    </form>
</body>
</html>
