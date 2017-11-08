<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Transfer.ascx.cs" Inherits="common_UIControls_Transfer" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<script language="javascript" type="text/javascript">
    function changeSystem() {
        if (TransferSys_btnTransfer.getText() == "Revert") {
            Ext.getCmp('TransferSys_btnTransfer').fireEvent('click', this);
        }
        else {
            var left = $("#labTransferText").offset().left - 32;
            $("#showTransferPanel").css({ left: left }).toggle();
            var hidTrans = null;
            $("#labTransferText").hover(function() {
                clearTimeout(hidTrans);
            }, function() {
                hidTrans = setTimeout(hideTransferPanel, 3000);
            });
            $("#showTransferPanel").focusin(function() {
                clearTimeout(hidTrans);
            }).focusout(function() {
                hidTrans = setTimeout(hideTransferPanel, 3000);
            });
        }
    }
    function hideTransferPanel() {
        $("#showTransferPanel").hide();
    }
    function SetTransferText() {
        $("#labTransferText").val("Revert");
    }
    function TransferVoid() {
        var tipValue = TransferSys_transferLotno.getText();
        var tipValues = TransferSys_btnTransfer.getText();
        tipValues = tipValues.replace(' ', '');
        if (tipValues != undefined && tipValues != "" && tipValue != undefined) {
            if (tipValues != "Revert" && tipValue != "") {
                btnVoid.disable();
            }
        }
    }
</script>
<ext:Store runat="server" ID="StoreSys">
    <Reader>
        <ext:JsonReader IDProperty="value">
            <Fields>
                <ext:RecordField Name="text" />
                <ext:RecordField Name="value" />
            </Fields>
        </ext:JsonReader>
    </Reader>
 </ext:Store>
<ext:Hidden ID="hidseed" runat="server"></ext:Hidden>
<ext:Hidden ID="hidsys" runat="server"></ext:Hidden>
<ext:Hidden ID="hidtype" runat="server"></ext:Hidden>
<table><tr>
<td>
<ext:Label ID="transferLotno" runat="server"></ext:Label>
</td>
<td>
<%--<div id="divtransferImg" class="nav_menu_6" runat="server">
<a href="javascript:void(0)" style="display:block;text-align:center" onclick="changeSystem();"><ext:Label ID="labTransfer" runat="server" Text="Change Sys"></ext:Label></a>
</div>--%>
<div id="divtransferImg" runat="server">
<table cellpadding="0" cellspacing="0" border="0"><tr>
<td class="btn_L1"></td>
<td><input id="labTransferText" onclick="changeSystem();"  type="button" style=" cursor:pointer; vertical-align:middle;" class="btn_C1" value="Change System"/></td>
<td class="btn_R1"></td>
</tr></table>
</div>
</td></tr></table>
<div id="showTransferPanel" style="position:absolute;z-index:1003;top:25px;left:807px;border: solid 1px #7EADD9;background-color: #ECF5FC; padding: 3px 5px;display:none;">
<table width="100%"><tr>
<td>
<ext:ComboBox ID="cmbTransfer" runat="server"  Mode="Local" StoreID="StoreSys"  clsClass="select_160px"
  ForceSelection="true" TriggerAction="All" Width="50" ListWidth="50" DisplayField="text" ValueField="value">
</ext:ComboBox>
</td>
<td align="right" style="padding-right:1px;">
<ext:Button ID="btnTransfer" runat="server" Width="50" Text="Change" Height="16">
<DirectEvents>
    <Click OnEvent="btnTransfer_Click">
    </Click>
</DirectEvents>
</ext:Button>
</td>
</tr></table>
</div>