<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CLP.aspx.cs" Inherits="common_UIControls_CLP" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>装箱单</title>

    <script src="../myplugin/jquery-1.4.1.js" type="text/javascript"></script>

    <style type="text/css">
        tr.tr_bottom td
        {
            border-top: solid 1px #99BBE8;
        }
    </style>
</head>
<body style="padding: 8px;">
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_CLP" style="background: #fff;">
        <%Response.Write("<link href=\"/css/gridHtml.css?v=" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + "\" rel=\"stylesheet\" type=\"text/css\" />\r\n"); %>
        <%Response.Write("<script src=\"/common/uicontrols/CLP.js?v=" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + "\" type=\"text/javascript\"></script>"); %>
        <table class="tab_sheet" cellpadding="0" cellspacing="0" style="width: 905px;">
            <tr>
                <td colspan="14" class="td_title" style="font-family: Verdana, Arial, Helvetica, sans-serif !important;
                    font-size: 10px  !important; font-weight: bold; color: #1542af">
                    <span style="float: right;">Container#
                        <label id="labCntrNo" style="color: Red" runat="server">
                        </label>
                        <input type="hidden" id="txtCntrNo" value="0" runat="server" />
                        <input type="hidden" id="txtToMBL" value="0" runat="server" />
                    </span><span style="float: left; color: #666; font-size: 11px; font-weight: normal;">
                        * 录入新行按键盘【Insert】 </span><span id="span_loading" style="float: right; padding-right: 50px;
                            font-size: 11px; font-weight: normal;"></span>
                </td>
            </tr>
            <tr class="tr_header">
                <td style="display: none; visibility: hidden">
                    编 号
                </td>
                <td class='td_checkbox' width="30">
                    主
                </td>
                <td class="td_Sheet" width="90">
                    提 单 号
                </td>
                <td class="td_hbl" width="90">
                    进 仓 编 号
                </td>
                <td class="td_goods" width="90">
                    货 名
                </td>
                <td class="td_req" width="70">
                    需 求
                </td>
                <td class="td_pkg" width="50">
                    件 数
                </td>
                <td class="td_gwt" width="50">
                    毛 重
                </td>
                <td class="td_cbm" width="50">
                    尺 码
                </td>
                 <td class="td_remark" width="80">
                    报 关 单 号
                </td>
                <td class="td_rec" width="80" style="text-align:center !important;">
                    日 期
                </td>
                <td class="td_remark" width="80">
                    快 递
                </td>
                <td class="td_remark" width="80">
                    备 注
                </td>
                <td class="td_action" width="35">
                    操 作
                </td>
                <td class="td_blank" width="16">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="14" style="padding: 0px; border: 0px;">
                    <div style="overflow-y: scroll; height: 250px; width: 905px">
                        <table id="tab_Replist" class="tab_sheet" cellpadding="0" cellspacing="0" border="0"
                            width="100%" style="border: 0px;">
                            <tr class="tr_line">
                                <td class='td_checkbox'>
                                    <input type="checkbox" />
                                </td>
                                <td class="td_Sheet" width="131">
                                    <input type="text" class="txt_sheet" />
                                </td>
                                <td class="td_hbl" width="120">
                                    <input type="text" class="txt_hbl" />
                                </td>
                                <td class="td_goods" width="140">
                                    <input type="text" class="txt_goods" />
                                </td>
                                <td class="td_req" width="60">
                                    <input type="text" class="txt_req" />
                                </td>
                                <td class="td_pkg" width="60">
                                    <input type="text" class="txt_pkg" />
                                </td>
                                <td class="td_gwt" width="60">
                                    <input type="text" class="txt_gwt" />
                                </td>
                                <td class="td_cbm" width="60">
                                    <input type="text" class="txt_cbm" />
                                </td>
                                <td class="td_action" width="80">
                                </td>
                                <td class="td_action" width="100">
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr class="tr_bottom">
                <td colspan="3">
                    <input type="button" value=" 新 增 " id="btn_Insert" class="input_button" />
                    <input type="button" id="btnSave" value=" 保 存 " onclick="SaveAll();" class="input_button"  />    
                    <label id="txtMsg" style="color: #1542AF; margin-left:15px;"></label>
                </td>
                <td>
                    需 求
                </td>
                <td colspan="3">
                    <input type="text" id="txtComRequest" readonly="readonly" style="border:0; border-bottom:solid 1px #ddd;text-transform: uppercase;font-family:'微软雅黑' !important;font-size: 11px !important;width: 95%;" />
                </td>
                <td>
                    备注
                </td>
                <td colspan="6">
                    <input type="text" id="txtComRemark" readonly="readonly" style="border:0; border-bottom:solid 1px #ddd;text-transform: uppercase;font-family:'微软雅黑' !important;font-size: 11px !important;width: 95%;" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
