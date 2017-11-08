<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fw_printer.aspx.cs" Inherits="BasicData_Print_fw_printer" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript">
        function textResult() {
            Ext.get("Textfield2").focus();
        }
        function FocusPrinter() {
            Ext.get("Textfield2").focus();
        }
        function FocusPrintName() {
            Ext.get("Textfield3").focus();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResouceID" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <table>
        <tr>
            <td style="padding-top: 8px; padding-left: 8px">
                <ext:Hidden ID="txtRowID" runat="server">
                </ext:Hidden>
                <ext:Hidden ID="txtSTAT" runat="server">
                </ext:Hidden>
                <ext:Hidden ID="txtPrinterCode" runat="server">
                </ext:Hidden>
                <ext:Hidden ID="txtPrinterName" runat="server">
                </ext:Hidden>
                <table width="703px" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                    background="../../images/bg_line.jpg" style="border: 1px solid #81b8ff; color: #1542AF;">
                    <tr>
                        <td class="font_11bold_1542af" style="padding-left: 4px; padding-top: 1px">
                            &nbsp; Print Settings&nbsp;
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td height="10">
                        </td>
                    </tr>
                </table>
                <table border="0'" cellpadding="0" cellspacing="0" class="table_25left">
                    <tr>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Station
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:Store runat="server" ID="StoreStat">
                                <Reader>
                                    <ext:JsonReader IDProperty="FieldText">
                                        <Fields>
                                            <ext:RecordField Name="FieldText" Type="String" />
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                            <ext:ComboBox ID="CmbStat" runat="server" Width="130px" TabIndex="1" Editable="true"
                                TypeAhead="true" Mode="Local" StoreID="StoreStat" DisplayField="FieldText" ValueField="FieldText"
                                ForceSelection="true" TriggerAction="All" EmptyText="Select..." Cls="select"
                                AllowBlank="false">
                                <Template Visible="False" ID="ctl340" StopIDModeInheritance="False" runat="server"
                                    EnableViewState="False">
                                </Template>
                                <DirectEvents>
                                    <Select OnEvent="CmbStat_Select">
                                    </Select>
                                </DirectEvents>
                            </ext:ComboBox>
                        </td>
                        <td style="padding-left: 20px">
                            <table width="50" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">
                                        Printer<span class="font_red" style="padding-left: 2px">*</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField AllowBlank="false" ID="Textfield2" runat="server" ClearCls="" Cls="text_70px"
                                Width="130px" TabIndex="2">
                            </ext:TextField>
                        </td>
                        <td style="padding-left: 20px">
                            <table width="45" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">
                                        Name<span class="font_red" style="padding-left: 2px">*</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField AllowBlank="false" ID="Textfield3" runat="server" ClearCls="" Cls="text_70px"
                                Width="248px" TabIndex="3">
                            </ext:TextField>
                        </td>
                    </tr>
                </table>
                <table width="703" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="5" align="right" height="10px">
                        </td>
                    </tr>
                    <tr>
                        <td width="76" colspan="2">
                            &nbsp;
                        </td>
                        <td align="right" width="70">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="button1" runat="server" value="Next" style="cursor: pointer;
                                            width: 60px" onclick="CompanyX.btnAddSave_Click();" class="btn_text btn_C" tabindex="4" />
                                    </td>
                                    <td class="btn_R">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" width="70" style="padding-left: 3px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="button3" runat="server" value="Delete" style="cursor: pointer;
                                            width: 60px" onclick="Ext.Msg.confirm('status','Are you sure you want to delete',function(btn){if(btn=='yes'){CompanyX.btnCancel_click();}}) "
                                            class="btn_text btn_C" tabindex="5" />
                                    </td>
                                    <td class="btn_R">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" width="70" style="padding-left: 3px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="button2" runat="server" value="Save" style="cursor: pointer;
                                            width: 60px" onclick="CompanyX.btnSave_Click();" class="btn_text btn_C" tabindex="6" />
                                    </td>
                                    <td class="btn_R">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="425" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="10px">
                                    </td>
                                </tr>
                            </table>
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td id="GridView">
                                        <ext:Store ID="Store1" runat="server">
                                            <Reader>
                                                <ext:JsonReader IDProperty="prt_ROWID">
                                                    <Fields>
                                                        <ext:RecordField Name="prt_ROWID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="prt_STAT" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="prt_PrinterCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="prt_PrinterName" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                        <ext:GridPanel ID="GridPanel1" runat="server" Height="342" Width="703" StoreID="Store1"
                                            TrackMouseOver="true" StripeRows="true">
                                            <ColumnModel ID="ctl33">
                                                <Columns>
                                                    <ext:RowNumbererColumn Header="No." Width="30" />
                                                    <ext:Column Header="Stat" DataIndex="prt_STAT" Width="100">
                                                    </ext:Column>
                                                    <ext:Column Header="Printer" DataIndex="prt_PrinterCode" Width="100">
                                                    </ext:Column>
                                                    <ext:Column Header="Name" DataIndex="prt_PrinterName" Width="450">
                                                    </ext:Column>
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                                    <DirectEvents>
                                                        <RowSelect OnEvent="row_Click">
                                                            <ExtraParams>
                                                                <ext:Parameter Name="prt_ROWID" Value="record.data.prt_ROWID" Mode="Raw" />
                                                                <ext:Parameter Name="prt_PrinterCode" Value="record.data.prt_PrinterCode" Mode="Raw" />
                                                                <ext:Parameter Name="prt_PrinterName" Value="record.data.prt_PrinterName" Mode="Raw" />
                                                                <ext:Parameter Name="prt_Remark" Value="record.data.prt_Remark" Mode="Raw" />
                                                                <ext:Parameter Name="prt_STAT" Value="record.data.prt_STAT" Mode="Raw" />
                                                                <ext:Parameter Name="prt_Sys" Value="record.data.prt_Sys" Mode="Raw" />
                                                                <ext:Parameter Name="prt_Report" Value="record.data.prt_ReportCode" Mode="Raw" />
                                                            </ExtraParams>
                                                        </RowSelect>
                                                    </DirectEvents>
                                                </ext:RowSelectionModel>
                                            </SelectionModel>
                                        </ext:GridPanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
