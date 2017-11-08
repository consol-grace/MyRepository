<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WebUserControl.ascx.cs"
    Inherits="common_UIControls_WebUserControl" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script src="/common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

<script type="text/javascript">
   
    var cmbx_<%= this.ID %>;
    Ext.onReady(function() {        
        
        cmbx_<%= this.ID %> = new Ext.form.ComboBox({
            id: "cmbx_<%= this.ID %>",
            typeAhead: true,
            triggerAction: 'all',
            lazyRender: true,
            mode: 'local',
            store: new Ext.data.JsonStore({
                id: 0,
                fields: [
                    'FieldValue',
                    'FieldText'
                ],
                data: [['M10001', 'M10001'], ['M10002', 'M10002'], ['M10003', 'M10003']]
            }),
            //valueField: 'FieldValue',
            //displayField: 'FieldText'
        });
        //cmbx_<%= this.ID %>.render("div_<%= this.ID %>"); 
        
        Ext.getCmp("cmbx_<%= this.ID %>").render("div_<%=this.ID %>");          
        
    })    
   
   function Reload(obj)   {
        obj.store.reload();
   }
   
    
</script>

<div style="float: left; display: block; padding: 50px">
    <div <% if (!string.IsNullOrEmpty(this.ID)) { Response.Write("id=\"div_"+ this.ID +"\""); } %>>
    </div>
    <div style="float: left; margin-left: 2px">
        <ext:Button ID="btnShow" runat="server" Text=" ... ">
            <DirectEvents>
                <Click OnEvent="btn_Click">
                    <EventMask ShowMask="true" MinDelay="250" Msg=" Loading... " />
                </Click>
            </DirectEvents>
        </ext:Button>
    </div>
</div>
