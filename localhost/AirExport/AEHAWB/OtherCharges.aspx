<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OtherCharges.aspx.cs" Inherits="AirExport_AEHAWB_OtherCharges" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OtherCharges</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
     <script src="../../common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Total(grid) {
            var count = 0;
            var totalAnget = 0;
            var totalCarrier = 0;
            if (grid.store.getTotalCount() > 0) {
                count = grid.store.getTotalCount();
             
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var amount = data.Amount;
                    var chargeto = data.ChargeTo;
                   
                    if (amount != "" && amount != undefined && chargeto != "" && chargeto != undefined) {
                        if(chargeto == "Agent")
                            totalAnget += parseFloat(amount);
                        else
                            totalCarrier += parseFloat(amount);
                    }
                }
                lblAnget.setValue(totalAnget == 0 ? 0 : Number(totalAnget).toFixed(2));
                lblCarrier.setValue(totalCarrier == 0 ? 0 : Number(totalCarrier).toFixed(2));
            }
            else {
                lblAnget.setValue("");
                lblCarrier.setValue("");
            }

        }


        function DeleteEmpty(grid) {

            if (grid.store.getTotalCount() > 0 && grid.id == "gpDim") {
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var Item = data.Item;
                    var Amount = data.Amount;
                    var Agent = data.Agent;
                    var Carrier = data.Carrier;

                    if (Item == "" || Amount == "" || Agent == "" || Carrier == "") {
                        grid.getSelectionModel().selectRow(i);
                        grid.deleteSelected();
                    }
                }
            }
        }

        function Esc() {
            var ESC = function (e) {
                e = e || window.event;
                //alert(e.keyCode);
                if ((e.which || e.keyCode) == 27) {

                    Ext.getCmp("btnOK").fireEvent('click', this);
                    event.keyCode = 0;
                    return false;

                }
            }

            ///添加监听事件
            if (document.addEventListener) {
                document.addEventListener("keydown", ESC, false);
            }
            else {
                document.attachEvent("onkeydown", ESC);
            }
        }
        Esc();


        function a() {
            var b = $("#txtItem").val().toUpperCase()
            txtItem.setValue(b);
            
            //            $("#txtItem").val($("#txtItem").val().toUpperCase());

        }

        var ToUpper = function (value) {
            return value.toUpperCase();
        };
    </script>
     <style type="text/css">
        .text
        {
            border: 0px;
            text-align: center;
            background-image: none;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
     <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidCurrency" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidRowID" runat="server">
    </ext:Hidden>
    
    <div>
    <table style="background-image: url(Demsions_title_bg.gif); height: 20px; width: 306px; background-position: left -5px; border-bottom: solid 1px #99BBE8; margin-bottom:15px;">
        <tr>
            <td height="20" colspan="6" style="padding-left: 5px;width:280px;" class="font_11px">
                OtherCharges 
            </td>
            <td>
                
                <ext:ImageButton ID="btnOK" runat="server" 
                    Width="16" Height="16"  StyleSpec ="background-image:url(ext.gif);background-position:0px 0px">
                    <DirectEvents>
                        <Click OnEvent="Save">
                            <ExtraParams>
                                <ext:Parameter Name="grid" Value="Ext.encode(#{gpDim}.getRowsValues())" Mode="Raw">
                                </ext:Parameter>
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:ImageButton>
            </td>
        </tr>
    </table>
      <table border="0" cellpadding="0" cellspacing="0" class="table_25left">  
        <tr>
            <td colspan="9" style="padding-top: 5px; padding-left: 5px" id="GridView">
                <ext:GridPanel ID="gpDim" runat="server" Width="296px" Height="175" TrackMouseOver="true"
                    StripeRows="true" ColumnLines="True" ClicksToEdit="1">
                    <Store>
                        <ext:Store runat="server" ID="storeDim">
                            <Reader>
                                <ext:JsonReader IDProperty="RowID">
                                    <Fields>
                                        <ext:RecordField Name="RowID" Type="Int">
                                        </ext:RecordField>
                                        <ext:RecordField Name="Item" Type="String">
                                        </ext:RecordField>
                                        <ext:RecordField Name="Amount" Type="String">
                                        </ext:RecordField>
                                        <ext:RecordField Name="ChargeTo" Type="String">
                                        </ext:RecordField>
                                        <%--<ext:RecordField Name="Agent"  Type="Boolean" DefaultValue="0">
                                        </ext:RecordField>
                                        <ext:RecordField Name="Carrier" Type="Boolean" DefaultValue="0">
                                        </ext:RecordField>--%>
                                    </Fields>
                                </ext:JsonReader>
                            </Reader>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server" ID="ColumnModel5">
                        <Columns>
                            <ext:Column Header="Item" DataIndex="Item" Width="75" Align="Left">
                             <Renderer Fn="ToUpper" />
                                <Editor>
                                    <ext:TextField ID="txtItem" runat="server" MaxLength="5"   Cls="select">
                                    </ext:TextField>
                                </Editor>
                             <%--   <Renderer Fn="change" />--%>
                            </ext:Column>
                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="95" Align="Right" Format="0.00" >
                                <Editor>
                                    <ext:NumberField ID="txtAmount" runat="server">
                                    </ext:NumberField>
                                </Editor>
                            </ext:NumberColumn>
                               <ext:Column Header="Charge To" DataIndex="ChargeTo" Width="95" Align="Left">
                      <Editor>
                          <ext:ComboBox ID="CmbCT" runat="server" Cls="select" DisplayField="value"
                            ForceSelection="true" Mode="Local" TriggerAction="All" ValueField="value" Width="95" >
                            <Items>
                                <ext:ListItem Text="Agent" Value="Agent" />
                                <ext:ListItem Text="Carrier" Value="Carrier" />
                            </Items>
                        </ext:ComboBox>
                    </Editor>
                    </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <KeyMap>
                        <ext:KeyBinding>
                            <Keys>
                                <ext:Key Code="INSERT" />
                            </Keys>
                            <Listeners>
                                <Event Handler="DeleteEmpty(#{gpDim});InsertRow(#{gpDim},false,0);" />
                            </Listeners>
                        </ext:KeyBinding>
                        <ext:KeyBinding Ctrl="true">
                            <Keys>
                                <ext:Key Code="DELETE" />
                            </Keys>
                            <Listeners>
                                <Event Handler="#{gpDim}.deleteSelected();Total(#{gpDim});" />
                            </Listeners>
                        </ext:KeyBinding>
                        <ext:KeyBinding>
                            <Keys>
                                <ext:Key Code="TAB" />
                            </Keys>
                            <Listeners>
                                <Event Handler="DeleteEmpty(#{gpDim});InsertRow(#{gpDim},true,0);" />
                            </Listeners>
                        </ext:KeyBinding>
                        <ext:KeyBinding>
                            <Keys>
                                <ext:Key Code="ENTER" />
                            </Keys>
                            <Listeners>
                                <Event Handler="EditRow(#{gpDim},0)" />
                            </Listeners>
                        </ext:KeyBinding>
                    </KeyMap>
                    <Listeners>
                        <Click Handler="NewRow(#{gpDim},0,0);" /><%--Total(#{gpDim});--%>
                        <AfterEdit  Handler="Total(#{gpDim});"/>
                    </Listeners>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel5" runat="server">
                            <Listeners>
                                <RowSelect Handler="getRowIndex(rowIndex);Total(#{gpDim});" /><%--sum(#{gpDim});--%>
                            </Listeners>
                        </ext:RowSelectionModel>
                    </SelectionModel>
                </ext:GridPanel>
            </td>
        </tr>
        <tr>
            <td colspan="9" style="padding-top: 5px; padding-left: 4px">
                <table width="296" height="20" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="155" height="20" align="left">
                        Anget Total ：
                            <ext:TextField ID="lblAnget" runat="server" Width="60" Disabled="true" Cls="text">
                            </ext:TextField>
                        </td>
                        <td width="155" style="padding-left: 2px" align="left">
                         Carrier Total ：

                            <ext:TextField ID="lblCarrier" runat="server" Width="60" Disabled="true" Cls="text">
                            </ext:TextField>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
