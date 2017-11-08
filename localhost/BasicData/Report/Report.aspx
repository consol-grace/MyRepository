<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="BasicData_Report_Default" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript">
        function textResult() {
            Ext.get("txtReport").focus();
        }
        function FocusName() {
            Ext.get("txtName").focus();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResouceID" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="txtRowID" runat="server">
    </ext:Hidden>
    <table>
        <tr>
            <td style="padding-top: 8px; padding-left: 8px">
                <table width="832" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                    background="../../images/bg_line.jpg" style="border: 1px solid #81b8ff; color: #1542AF;">
                    <tr>
                        <td class="font_11bold_1542af" style="padding-left: 5px; padding-top: 1px">
                            &nbsp;Report Control&nbsp;
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td height="5">
                        </td>
                    </tr>
                </table>
                <table border="0" cellpadding="0" cellspacing="0" class="table_23_left">
                    <tr>
                        <td>
                        </td>
                        <td>
                            Station
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0" width="250">
                                <tr>
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
                                        <ext:ComboBox ID="cmbStat" runat="server" Width="115" SelectOnFocus="true" TabIndex="1"
                                            Editable="true" TypeAhead="true" Mode="Local" StoreID="StoreStat" DisplayField="FieldText"
                                            ValueField="FieldText" ForceSelection="true" TriggerAction="All" EmptyText="Select..."
                                            Cls="select">
                                            <Template Visible="False" ID="Template2" StopIDModeInheritance="False" runat="server"
                                                EnableViewState="False">
                                            </Template>
                                            <DirectEvents>
                                                <Select OnEvent="CmbStat_Select">
                                                </Select>
                                            </DirectEvents>
                                        </ext:ComboBox>
                                    </td>
                                    <td style="padding-left: 15px; padding-right: 31px">
                                        Sys
                                    </td>
                                    <td align="right">
                                        <ext:Store runat="server" ID="StoreSys">
                                            <Reader>
                                                <ext:JsonReader>
                                                    <Fields>
                                                        <ext:RecordField Name="text" />
                                                        <ext:RecordField Name="value" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                        <ext:ComboBox ID="cmbSys" TabIndex="2" runat="server" StoreID="StoreSys" Editable="true"
                                            DisplayField="value" ValueField="value" TypeAhead="true" Mode="Local" Width="115"
                                            ForceSelection="true" TriggerAction="All" EmptyText="Select..." Cls="select"
                                            SelectOnFocus="true">
                                            <Template Visible="False" ID="Template1" StopIDModeInheritance="False" runat="server"
                                                EnableViewState="False">
                                            </Template>
                                        </ext:ComboBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                        </td>
                        <td>
                            Report
                        </td>
                        <td>
                            <ext:TextField AllowBlank="false" ID="txtReport" runat="server" TabIndex="3" Cls="text_80px"
                                Width="115">
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            Name
                        </td>
                        <td>
                            <ext:TextField ID="txtName" runat="server" TabIndex="4" Cls="text_80px" Width="295">
                            </ext:TextField>
                        </td>
                        <td>
                        </td>
                        <td>
                            Title
                        </td>
                        <td valign="top" style="padding-top: 1px">
                            <ext:TextField ID="txtTitle" runat="server" TabIndex="5" Cls="text_80px" Width="295">
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td valign="top">
                            Rpt Header
                        </td>
                        <td style="padding-top: 1px">
                            <ext:TextArea ID="txtRptHeader" runat="server" TabIndex="6" Cls="text_80px UpperCase" Width="295" 
                                Height="30">
                            </ext:TextArea>
                        </td>
                        <td>
                        </td>
                        <td valign="top">
                            Rpt Footer
                        </td>
                        <td valign="top" style="padding-top: 1px">
                            <ext:TextArea ID="txtRptFooter" runat="server" TabIndex="7" Cls="text_80px UpperCase" Width="295"
                                Height="30">
                            </ext:TextArea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td valign="top" style="padding-top: 3px">
                            Page Header
                        </td>
                        <td style="padding-top: 5px; padding-bottom: 2px">
                            <ext:TextArea ID="txtPageHeader" runat="server" TabIndex="8" Cls="text_80px UpperCase" Width="295"
                                Height="30">
                            </ext:TextArea>
                        </td>
                        <td>
                        </td>
                        <td valign="top" style="padding-top: 3px">
                            Page Footer
                        </td>
                        <td valign="top" style="padding-top: 5px">
                            <ext:TextArea ID="txtPageFooter" runat="server" TabIndex="9" Cls="text_80px UpperCase" Width="295"
                                Height="30">
                            </ext:TextArea>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 4px">
                            <ext:Checkbox runat="server" ID="chkCompnayEN" TabIndex="10">
                            </ext:Checkbox>
                        </td>
                        <td style="padding-right: 5px">
                            Company (EN)
                        </td>
                        <td>
                            <ext:TextField ID="txtCompanyEN" runat="server" TabIndex="11" Cls="text_80px UpperCase" Width="295">
                            </ext:TextField>
                        </td>
                        <td style="padding-left: 10px; padding-bottom: 4px">
                            <ext:Checkbox runat="server" ID="chkCompanyLocal" TabIndex="12">
                            </ext:Checkbox>
                        </td>
                        <td style="padding-right: 5px">
                            Company (Local)
                        </td>
                        <td>
                            <ext:TextField runat="server" ID="txtCompanyLocal" TabIndex="13" Cls="text_80px UpperCase"
                                Width="295">
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 4px">
                            <ext:Checkbox runat="server" ID="chkAddressEN" TabIndex="14">
                            </ext:Checkbox>
                        </td>
                        <td>
                            Address (EN)
                        </td>
                        <td>
                            <ext:TextArea runat="server" ID="txtAddressEN" TabIndex="15" Cls="text_80px" Width="295"
                                Height="30">
                            </ext:TextArea>
                        </td>
                        <td style="padding-left: 10px; padding-bottom: 4px">
                            <ext:Checkbox runat="server" ID="chkAddressLocal" TabIndex="16">
                                <Listeners>
                                </Listeners>
                            </ext:Checkbox>
                        </td>
                        <td>
                            Address (Local)
                        </td>
                        <td>
                            <ext:TextArea runat="server" ID="txtAddressLocal" TabIndex="17" Cls="text_80px" Height="30"
                                Width="295">
                            </ext:TextArea>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 4px">
                            <ext:Checkbox runat="server" ID="chkTelFax" TabIndex="18">
                            </ext:Checkbox>
                        </td>
                        <td>
                            Tel &amp; Fax
                        </td>
                        <td>
                            <ext:TextField runat="server" ID="txtTelFax" TabIndex="19" Cls="text_80px" Width="295">
                            </ext:TextField>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            Top
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0" width="250">
                                <tr>
                                    <td>
                                        <ext:NumberField DecimalPrecision="4" runat="server" ID="txtTop" Cls="text_80px"
                                            Width="115" TabIndex="20" StyleSpec="text-align:right">
                                        </ext:NumberField>
                                    </td>
                                    <td style="padding-left: 15px; padding-right: 10px">
                                        Bottom
                                    </td>
                                    <td align="right">
                                        <ext:NumberField DecimalPrecision="4" runat="server" ID="txtBottom" Cls="text_80px"
                                            Width="115" TabIndex="21" StyleSpec="text-align:right">
                                        </ext:NumberField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                        </td>
                        <td>
                            Left
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0" width="250">
                                <tr>
                                    <td>
                                        <ext:NumberField DecimalPrecision="4" runat="server" ID="txtLeft" Cls="text_80px"
                                            Width="115" TabIndex="22" StyleSpec="text-align:right">
                                        </ext:NumberField>
                                    </td>
                                    <td style="padding-left: 26px; padding-right: 10px">
                                        Right
                                    </td>
                                    <td align="right">
                                        <ext:NumberField DecimalPrecision="4" runat="server" ID="txtRight" Cls="text_80px"
                                            Width="115" TabIndex="23" StyleSpec="text-align:right">
                                        </ext:NumberField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="5" align="right" height="10px">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                        <td align="right" width="70px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="Button1" value="Next" runat="server" onclick="CompanyX.btnAddSave_Click();"
                                            style="cursor: pointer; width: 65px" class="btn_C btn_text" tabindex="24" />
                                    </td>
                                    <td class="btn_R">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" width="70px" style="padding-left: 3px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="Button2" value="Delete" runat="server" onclick="Ext.Msg.confirm('status','Are you sure you want to delete',function(btn){if(btn=='yes'){CompanyX.btnCancel_click();}});"
                                            class="btn_text btn_C" style="cursor: pointer; width: 65px" tabindex="25" />
                                    </td>
                                    <td class="btn_R">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" width="70px" style="padding-right: 1px; padding-left: 3px">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td class="btn_L">
                                    </td>
                                    <td>
                                        <input type="button" id="btnSave" value="Save" runat="server" onclick="CompanyX.btnSave_Click();"
                                            class="btn_text btn_C" style="cursor: pointer; width: 65px" tabindex="26" />
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
                                    <td height="13px">
                                    </td>
                                </tr>
                            </table>
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td id="GridView">
                                        <ext:Store ID="GridBinder" runat="server">
                                            <Reader>
                                                <ext:JsonReader IDProperty="rp_RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="rp_RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_Stat" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_Sys" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ReportCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ReportName" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_Title" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ReportHeader" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ReportFooter" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_PageHeader" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_PageFooter" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_CompanyNameEn" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_CompanyNameCN" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_CompanyAddressEn" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_CompanyAddressCN" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_CompanyTelFax" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_MarginTop" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_MarginBottom" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_MarginLeft" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_MarginRight" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_Remark" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_Creator" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_CreateDate" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_Modifier" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ModifyDate" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_IsDelete" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_UseCompanyNameCN" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_UseCompanyNameEN" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_UseCompanyAddressCN" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_UseCompanyAddressEN" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_UseCompanyTelFax" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ucnen" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ucncn" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ucaen" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_ucacn" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="rp_uctf" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                        <ext:GridPanel ID="GridPanel" runat="server" Height="236" Width="832" StoreID="GridBinder"
                                            StripeRows="true">
                                            <ColumnModel ID="ctl333" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn Header="No." Width="30" />
                                                    <ext:Column Header="Station" DataIndex="rp_Stat" Width="65">
                                                    </ext:Column>
                                                    <ext:Column Header="Sys" DataIndex="rp_Sys" Width="45">
                                                    </ext:Column>
                                                    <ext:Column Header="Report" DataIndex="rp_ReportCode">
                                                    </ext:Column>
                                                    <ext:Column Header="Name" DataIndex="rp_ReportName">
                                                    </ext:Column>
                                                    <ext:BooleanColumn Header="Rpt H" DataIndex="rp_ReportHeader" Width="45" TrueText="√"
                                                        FalseText="" Align="Center">
                                                    </ext:BooleanColumn>
                                                    <ext:BooleanColumn Header="Rpt F" DataIndex="rp_ReportFooter" Width="45" TrueText="√"
                                                        FalseText="" Align="Center">
                                                    </ext:BooleanColumn>
                                                    <ext:BooleanColumn Header="Page H" DataIndex="rp_PageHeader" Width="50" TrueText="√"
                                                        FalseText="" Align="Center">
                                                    </ext:BooleanColumn>
                                                    <ext:BooleanColumn Header="Page F" DataIndex="rp_PageFooter" Width="50" TrueText="√"
                                                        FalseText="" Align="Center">
                                                    </ext:BooleanColumn>
                                                    <ext:Column Header="Co (E)" DataIndex="rp_ucnen" Width="45">
                                                    </ext:Column>
                                                    <ext:Column Header="Co (L)" DataIndex="rp_ucncn" Width="45">
                                                    </ext:Column>
                                                    <ext:Column Header="Addr (E)" DataIndex="rp_ucaen" Width="60">
                                                    </ext:Column>
                                                    <ext:Column Header="Addr (L)" DataIndex="rp_ucacn" Width="60">
                                                    </ext:Column>
                                                    <ext:Column Header="Tel & Fax" DataIndex="rp_uctf" Width="70">
                                                    </ext:Column>
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                                    <DirectEvents>
                                                        <RowSelect OnEvent="row_Click">
                                                            <ExtraParams>
                                                                <ext:Parameter Name="rp_RowID" Value="record.data.rp_RowID" Mode="Raw" />
                                                                <ext:Parameter Name="rp_Stat" Value="record.data.rp_Stat" Mode="Raw" />
                                                                <ext:Parameter Name="rp_Sys" Value="record.data.rp_Sys" Mode="Raw" />
                                                                <ext:Parameter Name="rp_ReportCode" Value="record.data.rp_ReportCode" Mode="Raw" />
                                                                <ext:Parameter Name="rp_ReportName" Value="record.data.rp_ReportName" Mode="Raw" />
                                                                <ext:Parameter Name="rp_Title" Value="record.data.rp_Title" Mode="Raw" />
                                                                <ext:Parameter Name="rp_ReportHeader" Value="record.data.rp_ReportHeader" Mode="Raw" />
                                                                <ext:Parameter Name="rp_ReportFooter" Value="record.data.rp_ReportFooter" Mode="Raw" />
                                                                <ext:Parameter Name="rp_PageHeader" Value="record.data.rp_PageHeader" Mode="Raw" />
                                                                <ext:Parameter Name="rp_PageFooter" Value="record.data.rp_PageFooter" Mode="Raw" />
                                                                <ext:Parameter Name="rp_CompanyNameEn" Value="record.data.rp_CompanyNameEn" Mode="Raw" />
                                                                <ext:Parameter Name="rp_CompanyNameCN" Value="record.data.rp_CompanyNameCN" Mode="Raw" />
                                                                <ext:Parameter Name="rp_CompanyAddressEn" Value="record.data.rp_CompanyAddressEn"
                                                                    Mode="Raw" />
                                                                <ext:Parameter Name="rp_CompanyAddressCN" Value="record.data.rp_CompanyAddressCN"
                                                                    Mode="Raw" />
                                                                <ext:Parameter Name="rp_CompanyTelFax" Value="record.data.rp_CompanyTelFax" Mode="Raw" />
                                                                <ext:Parameter Name="rp_MarginTop" Value="record.data.rp_MarginTop" Mode="Raw" />
                                                                <ext:Parameter Name="rp_MarginBottom" Value="record.data.rp_MarginBottom" Mode="Raw" />
                                                                <ext:Parameter Name="rp_MarginLeft" Value="record.data.rp_MarginLeft" Mode="Raw" />
                                                                <ext:Parameter Name="rp_MarginRight" Value="record.data.rp_MarginRight" Mode="Raw" />
                                                                <ext:Parameter Name="rp_Remark" Value="record.data.rp_Remark" Mode="Raw" />
                                                                <ext:Parameter Name="rp_Creator" Value="record.data.rp_Creator" Mode="Raw" />
                                                                <ext:Parameter Name="rp_CreateDate" Value="record.data.rp_CreateDate" Mode="Raw" />
                                                                <ext:Parameter Name="rp_UseCompanyNameCN" Value="record.data.rp_UseCompanyNameCN"
                                                                    Mode="Raw" />
                                                                <ext:Parameter Name="rp_UseCompanyNameEN" Value="record.data.rp_UseCompanyNameEN"
                                                                    Mode="Raw" />
                                                                <ext:Parameter Name="rp_UseCompanyAddressCN" Value="record.data.rp_UseCompanyAddressCN"
                                                                    Mode="Raw" />
                                                                <ext:Parameter Name="rp_UseCompanyAddressEN" Value="record.data.rp_UseCompanyAddressEN"
                                                                    Mode="Raw" />
                                                                <ext:Parameter Name="rp_UseCompanyTelFax" Value="record.data.rp_UseCompanyTelFax"
                                                                    Mode="Raw" />
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
