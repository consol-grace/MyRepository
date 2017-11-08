<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Company.aspx.cs" Inherits="BasicData_Company_Company" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Company</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResouceID" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="txtRowID" runat="server">
    </ext:Hidden>
    <table style="padding-top: 8px; padding-left: 8px">
        <tr>
            <td>
                <table width="753" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                    background="../../images/bg_line.jpg" style="border: 1px solid #81b8ff; color: #1542AF;">
                    <tr>
                        <td class="font_11bold_1542af" style="padding-left: 5px; padding-top: 1px">
                            &nbsp;Company&nbsp;
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            <table style="padding-left: 6px; padding-top: 10px">
                                <tr>
                                    <td>
                                        ID
                                    </td>
                                    <td align="left">
                                        <ext:TextField AllowBlank="false" ID="txtId" runat="server" Cls="text_80px" Width="119"
                                            TabIndex="1">
                                        </ext:TextField>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td align="left" style="padding-right: 5px; padding-left: 10px; width:29px">
                                                    Code
                                                </td>
                                                <td>
                                                    <ext:TextField ID="txtCode" runat="server" Cls="text_80px" Width="119" TabIndex="2">
                                                    </ext:TextField>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding-left: 10px">
                                        District
                                    </td>
                                    <td>
                                        <ext:TextField ID="txtDistrict" runat="server" Cls="text_80px" Width="119" TabIndex="3">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Name(En)
                                    </td>
                                    <td colspan="2">
                                        <ext:TextField ID="txtNameEn" runat="server" Cls="text_80px UpperCase" Width="288"
                                            TabIndex="4">
                                        </ext:TextField>
                                    </td>
                                    <td style="padding-left: 10px">
                                        Name(Local)
                                    </td>
                                    <td>
                                        <ext:TextField ID="txtNameLocal" runat="server" Cls="text_80px UpperCase" Width="288"
                                            TabIndex="5">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top; padding-top: 5px">
                                        Address(En)
                                    </td>
                                    <td colspan="2" style="padding-top: 2px">
                                        <ext:TextArea ID="txtAddressEn" runat="server" Cls="text_80px UpperCase" Height="30"
                                            Width="288" TabIndex="6">
                                        </ext:TextArea>
                                    </td>
                                    <td style="vertical-align: top; padding-top: 5px; padding-left: 10px">
                                        Address(Local)
                                    </td>
                                    <td style="padding-top: 2px">
                                        <ext:TextArea ID="txtAddressLocal" runat="server" Cls="text_80px UpperCase" Height="30"
                                            Width="288" TabIndex="7">
                                        </ext:TextArea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Tel
                                    </td>
                                    <td colspan="2" style="padding-top: 2px">
                                        <ext:TextField ID="txtTel" runat="server" Cls="text_80px" Width="288" TabIndex="8">
                                        </ext:TextField>
                                    </td>
                                    <td style="padding-left: 10px">
                                        Fax
                                    </td>
                                    <td style="padding-top: 2px">
                                        <ext:TextField ID="txtFax" runat="server" Cls="text_80px" Width="288" TabIndex="9">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Email
                                    </td>
                                    <td colspan="3">
                                        <ext:TextField ID="txtEmail" runat="server" Cls="text_80px" Width="288" TabIndex="10">
                                        </ext:TextField>
                                    </td>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" align="left">
                                            <tr>
                                                <td valign="bottom" style="padding-bottom: 2px; width: 24px">
                                                    <ext:Checkbox ID="chkActive" runat="server" TabIndex="10">
                                                    </ext:Checkbox>
                                                </td>
                                                <td align="left">
                                                    Active
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 5px">
                            <ext:TabPanel ID="tabPanel" runat="server" Width="250" Height="175" Border="true"
                                Padding="8">
                                <Items>
                                    <ext:Panel ID="Panel1" Title=" Basic " ActiveIndex="0" runat="server">
                                        <Items>
                                            <ext:Checkbox ID="chkChinaMode" FieldLabel="China Mode" runat="server" LabelSeparator=" ">
                                            </ext:Checkbox>
                                        </Items>
                                        <Items>
                                            <ext:Checkbox ID="chkChinaInvoice" FieldLabel="China Invoice" runat="server" LabelSeparator=" ">
                                            </ext:Checkbox>
                                        </Items>
                                        <Items>
                                       <ext:TextField ID="FCurrency" runat="server" Cls="text_80px" Width="150px" FieldLabel="Foreign Currency" LabelSeparator=" " MaxLength="3">
                                        </ext:TextField>
                                        </Items>
                                         <Items>
                                       <ext:TextField ID="LCurrency" runat="server" Cls="text_80px" Width="150px"  FieldLabel="Local Currency" LabelSeparator=" " MaxLength="3">
                                        </ext:TextField>
                                        </Items>
                                    </ext:Panel>
                                    <ext:Panel Title=" AE " ActiveIndex="0" runat="server">
                                        <Items>
                                            <ext:NumberField FieldLabel="Dimension Rate" DecimalPrecision="3" ID="txtDimensionRate"
                                                runat="server" Cls="text_80px" Width="225" TabIndex="11" StyleSpec="text-align:right"
                                                LabelSeparator=" ">
                                            </ext:NumberField>
                                        </Items>
                                        <Items>
                                            <ext:TextField FieldLabel="Dimension Unit" ID="txtDimensionUnit" runat="server" Cls="text_80px"
                                                Width="225" TabIndex="12" LabelSeparator=" ">
                                            </ext:TextField>
                                        </Items>
                                        <Items>
                                            <ext:NumberField FieldLabel="Dimension Float" DecimalPrecision="0" ID="txtDimensionFloat"
                                                runat="server" Cls="text_80px" Width="225" TabIndex="13" StyleSpec="text-align:right"
                                                LabelSeparator=" ">
                                            </ext:NumberField>
                                        </Items>
                                        <Items>
                                            <ext:TextField FieldLabel="Arranged Text" ID="txtArrangedText" runat="server" Cls="text_80px"
                                                Width="225" TabIndex="14" LabelSeparator=" ">
                                            </ext:TextField>
                                        </Items>
                                        <Items>
                                            <ext:Checkbox ID="shipSign" runat="server" FieldLabel="Shipper on Sign" LabelSeparator=" ">
                                            </ext:Checkbox>
                                        </Items>
                                        <Items>
                                            <ext:Checkbox ID="conSign" runat="server" FieldLabel="Company on Sign" LabelSeparator=" ">
                                            </ext:Checkbox>
                                        </Items>
                                    </ext:Panel>
                                    <%--
                                    <ext:Panel ID="Panel1" Title=" AI " ActiveIndex="0" runat="server">
                                    </ext:Panel>
                                    <ext:Panel ID="Panel2" Title=" OE " ActiveIndex="0" runat="server" Padding="5">
                                    </ext:Panel>
                                    <ext:Panel ID="Panel3" Title=" OI " ActiveIndex="0" runat="server">
                                    </ext:Panel>--%>
                                </Items>
                            </ext:TabPanel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-bottom: 5px;
                                padding-top: 5px; padding-right: 5px">
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
                                                        style="cursor: pointer; width: 65px" class="btn_C btn_text" tabindex="15" />
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
                                                    <input type="button" id="Button3" value="Delete" runat="server" onclick="Ext.Msg.confirm('status','Are you sure you want to delete',function(btn){if(btn=='yes'){CompanyX.btnCancel_click();}});"
                                                        class="btn_text btn_C" style="cursor: pointer; width: 65px" tabindex="16" />
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
                                                        tabindex="17" class="btn_text btn_C" style="cursor: pointer; width: 65px" />
                                                </td>
                                                <td class="btn_R">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr id="GridView">
                                    <td>
                                        <ext:Store ID="storeGrid" runat="server">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyID" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="District" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Remark" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Creator" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Modifier" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Tel" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Fax" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Email" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="DIMUnit" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="DIMFloat" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="AddressCHS" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="AddressENG" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="DIMRate" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="AWBArrange" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Stat" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="NameCHS" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="NAMEENG" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="IsDelete" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="flag" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ChinaMode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ChineseInvoice" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="AE_ShowShipperSign" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="AE_ShowCompanySign" Type="String">
                                                        </ext:RecordField>
                                                         <ext:RecordField Name="FCurrency" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="LCurrency" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                        <ext:GridPanel ID="gridpanel" runat="server" Width="751px" Height="236" TrackMouseOver="true"
                                            StripeRows="true" ColumnLines="True" StoreID="storeGrid">
                                            <ColumnModel ID="ctl33">
                                                <Columns>
                                                    <ext:RowNumbererColumn Header="No." Width="30">
                                                    </ext:RowNumbererColumn>
                                                    <ext:Column Header="ID" DataIndex="CompanyID" Width="55">
                                                    </ext:Column>
                                                    <ext:Column Header="Code" DataIndex="Stat" Width="80">
                                                    </ext:Column>
                                                    <ext:Column Header="Name (En)" DataIndex="NAMEENG" Width="150">
                                                    </ext:Column>
                                                    <ext:Column Header="Name (Local)" DataIndex="NameCHS" Width="130">
                                                    </ext:Column>
                                                    <ext:Column Header="Address (En)" DataIndex="AddressENG" Width="130">
                                                    </ext:Column>
                                                    <ext:Column Header="Address (Local)" DataIndex="AddressCHS">
                                                    </ext:Column>
                                                    <ext:Column Header="Active" DataIndex="flag" Align="Center" Width="50">
                                                    </ext:Column>
                                                    <ext:Column Header="ChinaMode" DataIndex="ChinaMode" Align="Center" Width="50" Hidden="true">
                                                    </ext:Column>
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                                    <DirectEvents>
                                                        <RowSelect OnEvent="row_Click">
                                                            <ExtraParams>
                                                                <ext:Parameter Name="RowID" Value="record.data.RowID" Mode="Raw" />
                                                                <ext:Parameter Name="CompanyID" Value="record.data.CompanyID" Mode="Raw" />
                                                                <ext:Parameter Name="District" Value="record.data.District" Mode="Raw" />
                                                                <ext:Parameter Name="Remark" Value="record.data.Remark" Mode="Raw" />
                                                                <ext:Parameter Name="Creator" Value="record.data.Creator" Mode="Raw" />
                                                                <ext:Parameter Name="Modifier" Value="record.data.Modifier" Mode="Raw" />
                                                                <ext:Parameter Name="IsDelete" Value="record.data.IsDelete" Mode="Raw" />
                                                                <ext:Parameter Name="Tel" Value="record.data.Tel" Mode="Raw" />
                                                                <ext:Parameter Name="Fax" Value="record.data.Fax" Mode="Raw" />
                                                                <ext:Parameter Name="Email" Value="record.data.Email" Mode="Raw" />
                                                                <ext:Parameter Name="DIMUnit" Value="record.data.DIMUnit" Mode="Raw" />
                                                                <ext:Parameter Name="DIMFloat" Value="record.data.DIMFloat" Mode="Raw" />
                                                                <ext:Parameter Name="AddressCHS" Value="record.data.AddressCHS" Mode="Raw" />
                                                                <ext:Parameter Name="AddressENG" Value="record.data.AddressENG" Mode="Raw" />
                                                                <ext:Parameter Name="DIMRate" Value="record.data.DIMRate" Mode="Raw" />
                                                                <ext:Parameter Name="AWBArrange" Value="record.data.AWBArrange" Mode="Raw" />
                                                                <ext:Parameter Name="Stat" Value="record.data.Stat" Mode="Raw" />
                                                                <ext:Parameter Name="NameCHS" Value="record.data.NameCHS" Mode="Raw" />
                                                                <ext:Parameter Name="NAMEENG" Value="record.data.NAMEENG" Mode="Raw" />
                                                                <ext:Parameter Name="ChinaMode" Value="record.data.ChinaMode" Mode="Raw" />
                                                                <ext:Parameter Name="ChineseInvoice" Value="record.data.ChineseInvoice" Mode="Raw" />
                                                                <ext:Parameter Name="Com" Value="record.data.AE_ShowCompanySign" Mode="Raw" />
                                                                <ext:Parameter Name="Ship" Value="record.data.AE_ShowShipperSign" Mode="Raw" />
                                                                <ext:Parameter Name="FCurrency" Value="record.data.FCurrency" Mode="Raw" />
                                                                <ext:Parameter Name="LCurrency" Value="record.data.LCurrency" Mode="Raw" />
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
