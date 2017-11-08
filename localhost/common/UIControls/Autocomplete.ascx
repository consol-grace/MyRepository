<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Autocomplete.ascx.cs"
    Inherits="common_UIControls_Autocomplete" %>
<table cellpadding="0" cellspacing="0" width="100%" <%Response.Write("id=\""+ID+"_tab\"");%>>
    <tr>
        <td style="padding-bottom: 1px">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <input tabindex='<%=this.TabIndex %>' style='font-size: 10px; ime-mode: disabled;
                            <%Response.Write("width:"+this.Width); %>' type="text" <%Response.Write("id=\""+ID+"\"  name=\""+ID+"\"  class=\"input "+clsClass+"\""); %>
                            onfocus="ShowTitle('<%=this.ID%>');" onblur="Vlidata('<%=this.ID%>')" onkeyup="Autocomplete('<%=this.ID%>',event,'<%=this.winTitle %>','<%=this.winUrl%>',<%=this.winWidth%>,<%=this.winHeight%>)" />
                    </td>
                    <td style="width: 23px; text-align: left;<%if (!this.isButton) { Response.Write("display:none;");
            } %>">
                        <img src="/images/select_btn.jpg"  onclick="Autocomplete('<%=this.ID%>',event,'<%=this.winTitle %>','<%=this.winUrl%>',<%=this.winWidth%>,<%=this.winHeight%>)"
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
                color: #666;' readonly="readonly" <%Response.Write("id=\""+ID+"_text1\""); %> />
            <input type="text" <%Response.Write("id=\""+ID+"_text\" name=\""+ID+"_text\""); %>
                style="display: none" />
        </td>
    </tr>
    <%}

              else
              {%>
    </tr>
    <tr>
        <td colspan="3" style="width: 100%; padding: 3px 0">
            <input type="text" style='font-size: 10px; background: none; border: 0px; padding: 1px 2px;
                color: #666;' readonly="readonly" <%Response.Write("id=\""+ID+"_text1\""); %> />
            <input type="text" <%Response.Write("id=\""+ID+"_text\" name=\""+ID+"_text\""); %>
                style="display: none" />
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
