<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dimensions.aspx.cs" Inherits="AirExport_AEHAWB_Dimensions" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dimensions</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script type="text/javascript">

        function Total(grid) {

            var count = 0;
            var totalPiece = 0;
            var totalCM3 = 0;
            if (grid.store.getTotalCount() > 0) {
                count = grid.store.getTotalCount();
                lblCount.setValue(count);

                for (var i = 0; i < grid.store.getTotalCount(); ++i) { 
                    var data = grid.getRowsValues()[i];
                    var piece = data.Pieces;
                    var cm3 = data.CM3;
                    if (piece != "" && piece != undefined) {
                        totalPiece += parseFloat(piece);
                    }
                    if (cm3 != "" && cm3 != undefined) {
                        totalCM3 += parseFloat(cm3);
                    }
                }
                lblPieces.setValue(totalPiece);
                lblCM3.setValue(totalCM3==0?0: Number(totalCM3).toFixed(2));
            }
            else {
                lblCount.setValue("");
                lblPieces.setValue("");
                lblCM3.setValue("");
            }

        }

        function sum(grid) {
            var record = grid.getStore().getAt(selectRow);
            var W = record.data.W == "" ? "0" : record.data.W;
            var L = record.data.L == "" ? "0" : record.data.L;
            var H = record.data.H == "" ? "0" : record.data.H;
            var Pieces = record.data.Pieces == "" ? "0" : record.data.Pieces;
            record.set("CM3", parseFloat(W) * parseFloat(L) * parseFloat(H) * parseFloat(Pieces));
            if (grid.store.getTotalCount() > 0 && grid.id == "gpDim") {
                var count = 0;
                var totalPiece = 0;
                var totalCM3 = 0;
                if (grid.store.getTotalCount() > 0) {
                    count = grid.store.getTotalCount();
                    lblCount.setValue(count);
                }
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var piece = data.Pieces;
                    var cm3 = data.CM3;
                    if (piece != "" && piece != undefined) {
                        totalPiece += parseFloat(piece);
                    }
                    if (cm3 != "" && cm3 != undefined) {
                        totalCM3 += parseFloat(cm3);
                    }
                }
                lblPieces.setValue(totalPiece);
                lblCM3.setValue(totalCM3 == 0 ? 0 : Number(totalCM3).toFixed(2));
            }
        }

        function DeleteEmpty(grid) {

            if (grid.store.getTotalCount() > 0 && grid.id == "gpDim") {
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var L = data.L;
                    var W = data.W;
                    var H = data.H;
                    var piece = data.Pieces;
                    var cm3 = data.CM3;

                    if (cm3 == ""||cm3=='0'||cm3=='0.0'||cm3==undefined) {
                        grid.getSelectionModel().selectRow(i);
                        grid.deleteSelected();
                    }
                }
            }
        }

        function Esc() {
            var ESC = function(e) {
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
    <ext:Hidden ID="hidRowID" runat="server">
    </ext:Hidden>
    <table style="background-image: url(Demsions_title_bg.gif); height: 20px; width: 386px; background-position: left -5px; border-bottom: solid 1px #99BBE8; margin-bottom:15px;">
        <tr>
            <td height="20" colspan="6" style="padding-left: 5px;width:360px;" class="font_11px">
                Dimensions 
            </td>
            <td>
                
                <ext:ImageButton ID="btnOK" runat="server" 
                    Width="16" Height="16"  StyleSpec ="background-image:url(ext.gif);background-position:0px 0px">
                    <DirectEvents>
                        <Click OnEvent="Save">
                            <ExtraParams>
                                <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{gpDim}.getRowsValues())" Mode="Raw">
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
            <td style="padding-left: 5px; padding-right: 5px">
                Digit
            </td>
            <td width="40px">
            <ext:SpinnerField ID="txtDigit" runat="server" Width="30px" Cls="text_80px" MinValue="1"
                    MaxValue="2" Text="2">
             </ext:SpinnerField></td>
            <td width="40" style="padding-left: 8px">
                Rate
            </td>
            <td colspan="2" style="padding-left: 8px">
                <ext:NumberField ID="txtRate" runat="server" Cls="text_80px" Width="65" Format="0"  StyleSpec="text-align:right">
                   
                </ext:NumberField>
            </td>
            <td width="53" style="padding-left: 8px">
                <table width="45px">
                    <tr>
                        <td>
                            Line at
                        </td>
                    </tr>
                </table>
            </td>
            <td width="40">
                <ext:SpinnerField ID="txtLine" runat="server" Width="45px" Cls="text_80px" MinValue="1"
                    MaxValue="14" Text="7">
                </ext:SpinnerField>
            </td>
            <td width="34" style="padding-left: 8px; padding-right: 2px">
                CM3
            </td>
            <td width="155">
                <ext:NumberField ID="txtCM3" runat="server" Cls="text_80px" Width="75" Format="0.0"  StyleSpec="text-align:right">
                    <Listeners>
                        <Blur Handler="#{gpDim}.getSelectionModel().selectRow(0); #{gpDim}.startEditing(0, 0);;txtL.focus(true);" />
                    </Listeners>
                </ext:NumberField>
            </td>
           
        </tr>
        <tr>
            <td colspan="9" style="padding-top: 5px; padding-left: 5px" id="GridView">
                <ext:GridPanel ID="gpDim" runat="server" Width="376px" Height="175" TrackMouseOver="true"
                    StripeRows="true" ColumnLines="True" ClicksToEdit="1">
                    <Store>
                        <ext:Store runat="server" ID="storeDim">
                            <Reader>
                                <ext:JsonReader IDProperty="RowID">
                                    <Fields>
                                        <ext:RecordField Name="RowID" Type="Int">
                                        </ext:RecordField>
                                        <ext:RecordField Name="L" Type="String">
                                        </ext:RecordField>
                                        <ext:RecordField Name="W" Type="String">
                                        </ext:RecordField>
                                        <ext:RecordField Name="H" Type="String">
                                        </ext:RecordField>
                                        <ext:RecordField Name="Pieces" Type="String">
                                        </ext:RecordField>
                                        <ext:RecordField Name="CM3" Type="String">
                                        </ext:RecordField>
                                    </Fields>
                                </ext:JsonReader>
                            </Reader>
                        </ext:Store>
                    </Store>
                  
                    <ColumnModel runat="server" ID="ColumnModel5">
                        <Columns>
                            <ext:NumberColumn Header="L" DataIndex="L" Width="65" Align="Right" Format="0.00">
                                <Editor>
                                    <ext:NumberField ID="txtL" runat="server">
                                    
                                    </ext:NumberField>
                                </Editor>
                                <Renderer Fn="change" />
                            </ext:NumberColumn>
                            <ext:NumberColumn Header="W" DataIndex="W" Width="65" Align="Right" Format="0.00">
                                <Editor>
                                    <ext:NumberField ID="txtW" runat="server">
                                    </ext:NumberField>
                                </Editor>
                            </ext:NumberColumn>
                            <ext:NumberColumn Header="H" DataIndex="H" Width="65" Align="Right" Format="0.00">
                                <Editor>
                                    <ext:NumberField ID="txtH" runat="server">
                                    </ext:NumberField>
                                </Editor>
                            </ext:NumberColumn>
                            <ext:NumberColumn Header="Pieces" DataIndex="Pieces" Width="60" Align="Right" Format="0">
                                <Editor>
                                    <ext:NumberField ID="txtPieces" runat="server">
                                    </ext:NumberField>
                                </Editor>
                            </ext:NumberColumn>
                            <ext:NumberColumn Header="CM3" DataIndex="CM3" Width="99" Align="Right" Format="0.00">
                            </ext:NumberColumn>
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
                        <Click Handler="NewRow(#{gpDim},0,0)" />
                        <AfterEdit Handler="sum(#{gpDim});" />
                    </Listeners>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel5" runat="server">
                            <Listeners>
                                <RowSelect Handler="getRowIndex(rowIndex);sum(#{gpDim});" />
                            </Listeners>
                        </ext:RowSelectionModel>
                    </SelectionModel>
                </ext:GridPanel>
            </td>
        </tr>
        <tr>
            <td colspan="9" style="padding-top: 5px; padding-left: 4px">
                <table width="376" height="25" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="197" height="25">
                            <ext:TextField ID="lblCount" runat="server" Width="40" Disabled="true" Cls="text">
                            </ext:TextField>
                        </td>
                        <td width="60">
                            <ext:TextField ID="lblPieces" runat="server" Width="60" Disabled="true" Cls="text">
                            </ext:TextField>
                        </td>
                        <td width="100" style="padding-left: 2px">
                            <ext:TextField ID="lblCM3" runat="server" Width="100" Disabled="true" Cls="text">
                            </ext:TextField>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
