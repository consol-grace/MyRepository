<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserSheet.ascx.cs" Inherits="common_UIControls_UserSheet" %>
<link href="/css/gridHtml.css" rel="stylesheet" type="text/css" />

<script src="/common/uicontrols/UserSheet.js" type="text/javascript"></script>

<% if (Convert.ToBoolean(DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[25]) == true)
   { %>
<table class="tab_sheet" cellpadding="0" cellspacing="0" style="width: 301px; margin-bottom: 10px;
    <%if (!this._disHeader) { Response.Write("display:none"); } %>">
    <tr>
        <td>
            核销单
        </td>
        <td>
            <input type="text" id="txtSheetNO" onblur="txtblur(this);" onfocus="txtfocus(this);" />
        </td>
    </tr>
    <tr>
        <td style="border-bottom: solid 0px #fff;">
            件&nbsp;&nbsp;&nbsp;数
        </td>
        <td style="border-bottom:solid 0px #fff;">
            <input type="text" id="txtPKG" onblur="txtblur(this);" onfocus="txtfocus(this);" />
            <input type="hidden" id="txt_seed" value="<%=seed%>" />
            <input type="hidden" id="txt_type" />
            <input type="hidden" id="txt_eSheet" />
            <input type="hidden" id="txt_ePkg" />
            <input type="hidden" id="txt_eDate" />
            <input type="hidden" id="txt_eIndex" value="-1" />
            <script type="text/javascript">
                var isload = "<%=isLoad%>";
            </script>
            <input type="button" value=" 保存 " onclick="Insert();" id="btn_insert" />
        </td>
    </tr>
</table>
<table class="tab_sheet" cellpadding="0" cellspacing="0" style="width:<%=Width%>">
    <tr>
        <td colspan="5" class="td_title" style="<%if(!this.isLoad){ Response.Write("display:none");
            }%>">核销单</td>
    </tr>
    <tr class="tr_header">
        <td class="td_Sheet" style="width:90px">
            核销单
        </td>
        <td class="td_pkg" style=" width:50px;">
            件 数
        </td>
        <td class="td_receive"  style="width:70px">
            收 回
        </td>
        <td class="td_Action"   style="width:70px">
            操 作
        </td>
        <td class="td_blank"  style="width:15px">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="6" style="padding: 0px; border:0px;">
            <div style="overflow-y: scroll; height: <%=Height%> ;">
                <table id="tab_Replist" class="tab_sheet" cellpadding="0" cellspacing="0" border="0"
                    width="100%" style="border: 0px;">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td class="td_Sheet">
                                    <%#Eval("SheetNo") %>
                                </td>
                                <td class="td_pkg">
                                    <%#Eval("Pkg") %>
                                </td>
                                <td class="td_receive">
                                    <%#Eval("Receive") %>
                                </td>
                                <td class="td_Action">
                                    编辑|删除
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </td>
    </tr>
</table>
<%} else{%>
<script type="text/javascript">
      var isload = "<%=isLoad%>";
</script>
<%} %>
