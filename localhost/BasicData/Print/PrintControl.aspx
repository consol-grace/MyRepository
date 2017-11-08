<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintControl.aspx.cs" Inherits="BasicData_Print_PrintControl" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript">
        function textResult() {
            Ext.get("txtReportName").focus();
        }
        function FocusStat() {
            Ext.get("CmbStat").focus();
        }
        function FocusSys() {
            Ext.get("CMbSys").focus();
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
                <ext:Hidden ID="prt_PrinterCode" runat="server">
                </ext:Hidden>
                <ext:Hidden ID="prt_PrinterName" runat="server">
                </ext:Hidden>
                <ext:Hidden ID="txtStat" runat="server">
                </ext:Hidden>
                <ext:Hidden ID="txtSys" runat="server">
                </ext:Hidden>
                <ext:Hidden ID="txtReport" runat="server">
                </ext:Hidden>
                <table width="772px" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                    background="../../images/bg_line.jpg" style="border: 1px solid #81b8ff; color: #1542AF;">
                    <tr>
                        <td class="font_11bold_1542af" style="padding-left: 4px; padding-top: 1px">
                            &nbsp; Printer Control&nbsp;
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td height="10">
                        </td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0" class="table_25left">
                    <tr>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Stat<span class="font_red" style="padding-left: 17px">*</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:Store runat="server" ID="Store2">
                                <Reader>
                                    <ext:JsonReader IDProperty="value">
                                        <Fields>
                                            <ext:RecordField Name="text" />
                                            <ext:RecordField Name="value" />
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                            <ext:ComboBox AllowBlank="false" ID="CmbStat" TabIndex="1" runat="server" StoreID="Store2"
                                Editable="true" DisplayField="value" ValueField="value" TypeAhead="true" Mode="Local"
                                Width="126" ForceSelection="true" TriggerAction="All" EmptyText="Select..." Cls="select">
                                <Template Visible="False" ID="ctl340" StopIDModeInheritance="False" runat="server"
                                    EnableViewState="False">
                                </Template>
                                <DirectEvents>
                                    <Select OnEvent="CmbStat_Select">
                                    </Select>
                                </DirectEvents>
                            </ext:ComboBox>
                        </td>
                        <td style="padding-left: 15px">
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">
                                        Sys<span class="font_red" style="padding-left: 17px">*</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:Store runat="server" ID="Store3">
                                <Reader>
                                    <ext:JsonReader>
                                        <Fields>
                                            <ext:RecordField Name="text" />
                                            <ext:RecordField Name="value" />
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                            <ext:ComboBox AllowBlank="false" ID="CMbSys" TabIndex="2" runat="server" StoreID="Store3"
                                Editable="true" DisplayField="text" ValueField="value" TypeAhead="true" Mode="Local"
                                Width="126" ForceSelection="true" TriggerAction="All" EmptyText="Select..." Cls="select"
                                SelectOnFocus="true">
                                
                            </ext:ComboBox>
                        </td>
                          <td  style="padding-left: 10px" width="50px">
                            Default
                        </td>
                        <td>
                            <ext:Checkbox ID="chkDefault" runat="server" TabIndex="5">
                            </ext:Checkbox>
                        </td>
                        <td style="padding-left: 15px">
                        </td>
                        <td style="padding-left: 15px">
                        </td>
                    </tr>
                    <tr>
                        <td width="60" class="font_11bold">
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-right: 4px; padding-left: 10px">
                                        Report<span class="font_red" style="padding-left: 2px">*</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField AllowBlank="false" TabIndex="3" ID="txtReportName" runat="server"
                                ClearCls="" Cls="text_70px" Width="126px">
                            </ext:TextField>
                        </td>
                        <td width="60" class="font_11bold" style="padding-left: 15px">
                            Printer<span class="font_red" style="padding-left: 0px">*</span>
                        </td>
                        <td>
                            <ext:Store ID="StorePrinter" runat="server">
                                <Reader>
                                    <ext:JsonReader IDProperty="prt_PrinterCode">
                                        <Fields>
                                            <ext:RecordField Name="prt_PrinterCode">
                                            </ext:RecordField>
                                            <ext:RecordField Name="prt_PrinterName">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                            <uc1:UserComboBox runat="server" ID="CmbPrinter" ListWidth="330" TabIndex="4" Width="126"
                                isButton="false" winHeight="585" StoreID="StorePrinter" clsClass="select" DisplayField="prt_PrinterCode"
                                ValueField="prt_PrinterName" Blur="var record=StorePrinter.getById(this.getValue());if(record!=null&&record!=undefined){prt_PrinterName.setValue(record.data.prt_PrinterName)};" />
                            <%-- <ext:ComboBox ID="CmbPrinter" StoreID="StorePrinter" runat="server" DisplayField="prt_PrinterName">
                            <Items>
                                <ext:ListItem Text="" Value="" />
                            </Items>
                        </ext:ComboBox>--%>
                        </td>
                         <td style="padding-left: 10px" width="50px">
                         Copies
                        </td>
                        <td>
                        <ext:NumberField TabIndex="5" ID="txtPrintCount" runat="server" Width="126px" Cls="text_70px" DecimalPrecision="0" AllowNegative="false">
                         </ext:NumberField>
                        </td>
                        <td width="60" style="padding-left: 15px">
                            Remark
                        </td>
                        <td>
                            <ext:TextField TabIndex="5" ID="txtRemark" runat="server" Width="126px" Cls="text_70px">
                            </ext:TextField>
                        </td>
                       
                    </tr>
                    <tr>
                        <td style="padding-left: 10px">
                            Top
                        </td>
                        <td>
                            <ext:NumberField DecimalPrecision="4" TabIndex="6" ID="txtReportTop" runat="server"
                                Width="126px" Cls="text_70px" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td style="padding-left: 15px">
                            Bottom
                        </td>
                        <td>
                            <ext:NumberField DecimalPrecision="4" TabIndex="7" ID="txtReportBottom" runat="server"
                                Width="126px" Cls="text_70px" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td style="padding-left: 10px" width="50px">
                            Left
                        </td>
                        <td>
                            <ext:NumberField DecimalPrecision="4" TabIndex="8" ID="txtReportLeft" runat="server"
                                Width="126px" Cls="text_70px" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td style="padding-left: 15px; padding-right: 14px">
                            Right
                        </td>
                        <td>
                            <ext:NumberField DecimalPrecision="4" TabIndex="9" ID="txtReportRight" runat="server"
                                Width="126px" Cls="text_70px" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                    </tr>
                </table>
                <table width="772" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="5" align="right" height="15px">
                        </td>
                    </tr>
                    <tr>
                        <td width="76" colspan="2">
                            &nbsp;
                        </td>
                         <td align="right" width="150">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="btnCopyPdf" runat="server" value="Copyable PDF Setting" onclick="CompanyX.btnCopyPdf_Click();"
                                            style="cursor: pointer; width: 140px" class="btn_text btn_C" tabindex="10" />
                                    </td>
                                    <td class="btn_R">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" width="70" style="padding-left: 3px">
                            <%--<ext:Button ID="btnAddSave" runat="server" Text="Next" Cls="Submit_70px"
                        Width="70px">
                        <DirectEvents>
                            <Click OnEvent="btnAddSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>--%>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="button1" runat="server" value="Next" onclick="CompanyX.btnAddSave_Click();"
                                            style="cursor: pointer; width: 60px" class="btn_text btn_C" tabindex="10" />
                                    </td>
                                    <td class="btn_R">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" width="70" style="padding-left: 3px">
                            <%--<ext:Button ID="btnCancel" Text="Delete" runat="server" Cls="Submit_70px"
                        Width="70px">
                        <Listeners>
                            <Click Handler="Ext.Msg.confirm('status','Are you sure you want to delete',function(btn){if(btn=='yes'){CompanyX.btnCancel_Click();}}) " />
                        </Listeners>
                    </ext:Button>--%>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="button3" runat="server" value="Delete" onclick="Ext.Msg.confirm('status','Are you sure you want to delete',function(btn){if(btn=='yes'){CompanyX.btnCancel_Click();}})"
                                            style="cursor: pointer; width: 60px" class="btn_text btn_C" tabindex="11" />
                                    </td>
                                    <td class="btn_R">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" width="70" style="padding-left: 3px">
                            <%--<ext:Button ID="btnSave" Text="Save" runat="server" Cls="Submit_70px"
                        Width="70px">
                        <DirectEvents>
                            <Click OnEvent="btnSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>--%>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="button2" runat="server" value="Save" onclick="CompanyX.btnSave_Click();"
                                            style="cursor: pointer; width: 60px" class="btn_text btn_C" tabindex="12" />
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
                                    <td height="15px">
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
                                                        <ext:RecordField Name="prt_ReportCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="prt_PrinterCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="prt_PrinterName" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="prt_Remark" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="prt_STAT" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="prt_Sys" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rc_rptTop" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rc_rptBottom" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rc_rptLeft" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rc_rptRight" Type="String">
                                                        </ext:RecordField>
                                                         <ext:RecordField Name="prt_PrintCount" Type="String">
                                                        </ext:RecordField>
                                                           <ext:RecordField Name="prt_IsDefault" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                        <ext:GridPanel ID="GridPanel1" runat="server" Height="342" StoreID="Store1" TrackMouseOver="true"
                                            StripeRows="true">
                                            <ColumnModel ID="ctl33">
                                                <Columns>
                                                    <ext:RowNumbererColumn Header="No." Width="30" />
                                                    <ext:Column Header="Stat" DataIndex="prt_STAT" Width="70">
                                                    </ext:Column>
                                                    <ext:Column Header="Sys" DataIndex="prt_Sys" Width="30">
                                                    </ext:Column>
                                                    <ext:Column Header="Report" DataIndex="prt_ReportCode" Width="80">
                                                    </ext:Column>
                                                     <ext:Column Header="Print Code" DataIndex="prt_PrinterCode" Width="85">
                                                    </ext:Column>
                                                    <ext:Column Header="Print Name" DataIndex="prt_PrinterName" Width="150">
                                                    </ext:Column>
                                                      <ext:Column Header="Default" DataIndex="prt_IsDefault" Width="55" Align="Center">
                                                    </ext:Column>
                                                    <ext:Column Header="Copies" DataIndex="prt_PrintCount" Width="40" Hidden="true">
                                                    </ext:Column>
                                                    <ext:Column Header="Top" DataIndex="rc_rptTop" Width="60" Align="Right">
                                                    </ext:Column>
                                                    <ext:Column Header="Bottom" DataIndex="rc_rptBottom" Width="70" Align="Right">
                                                    </ext:Column>
                                                    <ext:Column Header="Left" DataIndex="rc_rptLeft" Width="60" Align="Right">
                                                    </ext:Column>
                                                    <ext:Column Header="Right" DataIndex="rc_rptRight" Width="60" Align="Right">
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
                                                                <ext:Parameter Name="rc_rptTop" Value="record.data.rc_rptTop" Mode="Raw" />
                                                                <ext:Parameter Name="rc_rptBottom" Value="record.data.rc_rptBottom" Mode="Raw" />
                                                                <ext:Parameter Name="rc_rptLeft" Value="record.data.rc_rptLeft" Mode="Raw" />
                                                                <ext:Parameter Name="rc_rptRight" Value="record.data.rc_rptRight" Mode="Raw" />
                                                                <ext:Parameter Name="prt_PrintCount" Value="record.data.prt_PrintCount" Mode="Raw" />
                                                                <ext:Parameter Name="prt_IsDefault" Value="record.data.prt_IsDefault" Mode="Raw" />
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
        <ext:Window ID="winCopyPdf" runat="server" Resizable="false" Height="600" Title="Copyable PDF Setting"
        Hidden="true" BodyStyle="background-color:#fff" Draggable="true" Width="1010"
        Modal="false" Maximizable="false" Padding="5" X="10" Y="50" Shadow="None">
        <LoadMask Msg="Loading..." ShowMask="true" />
    </ext:Window>
    </form>
</body>
</html>
