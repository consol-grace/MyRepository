<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserComboBox.ascx.cs"
    Inherits="common_UIControls_UserComboBox" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<table cellpadding="0" cellspacing="0" border="0">
    <tr>
    <td>
    <table cellpadding="0" cellspacing="0" border="0">
  
    <tr>
    <td>
            <div runat="server" id="panel">
            </div>
        </td>
        <td style="text-align: left;vertical-align: top; padding-left:3px;<%if (!this.isButton||CheckDest()) { Response.Write("display:none");
            } %>">
            <ext:ImageButton ImageUrl="/images/select_btn.jpg" runat="server" ID="btnimg" TabIndex="0">
                <DirectEvents>
                    <Click OnEvent="btnimg_AddNew">
                    </Click>
                </DirectEvents>
            </ext:ImageButton>
        </td>
        <%if (isAlign)
          { %>
        <td style="<%if(!this.isText){Response.Write("display:none; ");}%>padding-left:3px;width:100%;" align="left" >
            <label <%Response.Write("id="+this.ID+"_text"); %>  style="padding: 2px 3px; color:#888">       
            </label>
        </td>
        <%} %>
    </tr>
    </table> 
    </td>
        
    </tr>    
    <%if (!isAlign)
      { %>
    <tr>
        <td  style="<%if(!this.isText){Response.Write("display:none"); }%>;width=100%; height:16px; padding:2px 0">
            <label <%Response.Write("id="+this.ID+"_text"); %> class="select_160px" style="padding: 2px 0px;color:#888; height:16px; line-height:16px;">
            </label>
        </td>
    </tr>
    <%} %>
</table>
