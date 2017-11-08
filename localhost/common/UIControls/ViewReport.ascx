<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewReport.ascx.cs" Inherits="ViewReport" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<script src="/common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>
<script src="/common/uicontrols/ViewReport.js?datetime=11132131" type="text/javascript"></script>
<link href="/common/UIControls/img_report/report_tools.css" rel="stylesheet" />
<asp:HiddenField ID="hidPath" runat="server" />
<asp:HiddenField ID="hidOldPath" runat="server" />
<asp:HiddenField ID="hidNumList" runat="server" Value="" />
<asp:HiddenField ID="hidMargin" runat="server" Value="" />
<div id="div_czw" style="width: 1000px; margin: 0px auto;">
</div>
<table id="report_tools" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width: 65%">
            &nbsp;
        </td>
        <td style="width: 50px;">
            <img src="/common/uicontrols/img_report/1.png" alt="First Page" title="First Page"
                onclick="FirstPage();" />
        </td>
        <td style="width: 50px;">
            <img src="/common/uicontrols/img_report/2.png" alt="Previous Page" title="Previous Page"
                onclick="PrePage();" />
        </td>
        <td style="width: 20px;">
            <img src="/common/uicontrols/img_report/line.gif" class="span_line" />
        </td>
        <td style="width: 38px;">
            page
        </td>
        <td style="width: 30px;">
            <input type="text" id="txtPagecurrindex" value="1" onkeydown="NumIntput(event);inputKeyDown(event.keyCode||event.which);"
                onkeypress="" />
            <input type="text" style="display: none" />
        </td>
        <td style="width: 70px;">
            <nobr> / <span id="labPageCount">1</span> <img id="loading_tools" src="/common/uicontrols/img_report/loading_tools.gif" style="margin-left:5px; margin-bottom:2px;display:none" alt="loading..." title="loading..."  /></nobr>
        </td>
        <td style="width: 20px;">
            <img src="/common/uicontrols/img_report/line.gif" class="span_line" alt="" />
        </td>
        <td style="width: 50px;">
            <img src="/common/uicontrols/img_report/3.png" alt="Next Page" title="Next Page"
                onclick="NextPage();" />
        </td>
        <td style="width: 50px;">
            <img src="/common/uicontrols/img_report/4.png" alt="Last Page" title="Last Page"
                onclick="LastPage();" />
        </td>
        <td style="width: 20px;">
            <img src="/common/uicontrols/img_report/line.gif" class="span_line" alt="" />
        </td>
        <td style="width: 80px; display: none;">
            <select id="drpRefreshList">
                <option value="4" selected="selected">PDF</option>
                <option value="2">JPG</option>
                <option value="5">GIF</option>
            </select>
        </td>
        <td id="span_refresh" style="width: 60px;">
            <img src="/common/uicontrols/img_report/5.png" alt="Refresh" title="Refresh" onclick="Refresh();" />
        </td>
        <td style="width: 20px;">
            <img src="/common/uicontrols/img_report/line.gif" class="span_line" />
        </td>
        <td style="width: 80px;">
            <select id="drpDownLoadlist">
                <option value="4" selected="selected">PDF</option>
                         <%--if (stat.Trim() == "CON/SZX" && (type == "BILL" || type == "HAWB" || type == "SBSDRAFT" || type == "ATTACHLIST"))
                         {--%>
                 <%if (IsShowPdfCopy())
                   {%>

                <option value="7">PDF(Copyable)</option>
                <%} %>
                <option value="1">TIF</option>
            </select>
            <!--<option value="2">JPG</option>
                <option value="5">GIF</option> -->
        </td>
        <td id="span1" style="width: 60px;">
            <img src="/common/uicontrols/img_report/6.png" alt="Download" title="Download" onclick="Download();" />
        </td>
    </tr>
</table>
<div id="div_Contentframe" style="text-align: center">
    <div id="Contentframe" style="overflow-y: scroll; border-style: solid; border-width: 5px 1px 5px 5px; border-color: rgb(135, 135, 135); margin: 0px auto; height:98.5%; width: 994px;"></div>
</div>
<div id="show_Contentframe">
</div>
<div id="show_contentframe_loading">
</div>