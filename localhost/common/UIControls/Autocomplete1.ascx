<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Autocomplete1.ascx.cs"
    Inherits="common_UIControls_Autocomplete1" %>
<table cellpadding="0" cellspacing="0" width="100%" <%Response.Write("id=\""+ID+"_tab\"");%>>
    <tr>
        <td style="padding-bottom: 1px">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <div runat="server" id="storeDIV">
                        </div>
                        <div runat="server" id="panel">
                        </div>
                    </td>
                    <td style="width: 23px; text-align: left; <%if (!this.isButton) { Response.Write("display:none;");
                        } %>">
                        <img src="/images/select_btn.jpg" onclick="AutoComboBox('<%=this.ID%>',event,'<%=this.winTitle %>','<%=this.winUrl%>',<%=this.winWidth%>,<%=this.winHeight%>)"
                            style="cursor: pointer; padding-left: 3px;" />
                    </td>
                </tr>
            </table>
        </td>
        <%if (this._isDiplay)
          {
              if (this._isAlign)
              { %>
        <td style="padding-left: 5px; width: 100%;">
            <input type="text" style='font-size: 10px; background: none; border: 0px; padding: 1px 2px;
                width: 99%; color: #666;' readonly="readonly" disabled="disabled" <%Response.Write("id=\""+ID+"_text1\""); %> />
            <input type="hidden" <%Response.Write("id=\""+ID+"_text\" name=\""+ID+"_text\""); %> />
        </td>
    </tr>
    <%}

              else
              {%>
    </tr>
    <tr>
        <td colspan="3" style="width: 100%; padding: 3px 0">
            <input type="text" style='font-size: 10px; background: none; border: 0px; padding: 1px 2px;
                width: 99%; color: #666;' readonly="readonly" disabled="disabled" <%Response.Write("id=\""+ID+"_text1\""); %> />
            <input type="hidden" <%Response.Write("id=\""+ID+"_text\" name=\""+ID+"_text\""); %> />
        </td>
    </tr>
    <% }
          }
          else
          {
    %>
    </tr>
    <%} %>
</table>
