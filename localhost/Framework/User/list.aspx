<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="Framework_User_list"
    Theme="FORM" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="asp" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>User Control</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:Hidden ID="txtRowID" runat="server">
    </ext:Hidden>
    <ext:ResourceManager runat="server" ID="ResouceID" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <table>
        <tr>
            <td height="10">
            </td>
        </tr>
        <tr>
            <td>
                <table width="703px" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                    background="../../images/bg_line.jpg" style="border: 1px solid #81b8ff; color: #1542AF">
                    <tr>
                        <td class="font_11bold_1542af" style="padding-left: 4px; padding-top: 1px">
                            &nbsp; User Control&nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table width="703px" border="0" cellpadding="0" cellspacing="0" class="table_23_left">
                    <tr>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 12px">
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
                            <ext:ComboBox ID="CmbStat" runat="server" Width="115" SelectOnFocus="true" TabIndex="1"
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
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Company
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:Store runat="server" ID="Store1">
                                            <Reader>
                                                <ext:JsonReader IDProperty="FieldText">
                                                    <Fields>
                                                        <ext:RecordField Name="FieldText" Type="String" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                        <ext:ComboBox ID="cmbCompany" runat="server" Width="115" SelectOnFocus="true" Editable="true"
                                            TypeAhead="true" Mode="Local" StoreID="Store1" DisplayField="FieldText" ValueField="FieldText"
                                            TabIndex="2" ForceSelection="true" TriggerAction="All" EmptyText="Select..."
                                            Cls="select">
                                            <Template Visible="False" ID="Template1" StopIDModeInheritance="False" runat="server"
                                                EnableViewState="False">
                                            </Template>
                                        </ext:ComboBox>
                                    </td>
                                    <td align="right">
                                        <table cellpadding="0" cellspacing="0" border="0" width="115">
                                            <tr>
                                                <td style="padding-left: 55px">
                                                    <ext:Checkbox ID="chkActive" runat="server" TabIndex="3">
                                                    </ext:Checkbox>
                                                </td>
                                                <td class="font_11bold" align="right">
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
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 12px">
                                        User<span style="padding-left: 2px" class="font_red">*</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField AllowBlank="false" ID="txtUser" runat="server" Cls="text_80px" Width="115px"
                                TabIndex="4">
                            </ext:TextField>
                        </td>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Password<span style="padding-left: 2px" class="font_red">*</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:TextField InputType="Password" AllowBlank="false" ID="txtPwd" runat="server"
                                            Cls="text_80px" Width="115px" TabIndex="5">
                                        </ext:TextField>
                                    </td>
                                    <td style="padding-left: 3px">
                                        <ext:TextField InputType="Password" AllowBlank="false" ID="txtPwdAgain" runat="server"
                                            Cls="text_80px" Width="115px" TabIndex="6">
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 12px">
                                        Name
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField ID="txtNameEn" runat="server" Cls="text_80px" Width="233px" TabIndex="7">
                            </ext:TextField>
                        </td>
                        <td>
                            <table width="85" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Name (Local)
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField ID="txtNameLocal" runat="server" Cls="text_80px" Width="233px" TabIndex="8">
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 12px">
                                        Tel
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField ID="txtTel" runat="server" Cls="text_80px" Width="233px" TabIndex="9">
                            </ext:TextField>
                        </td>
                        <td valign="top" rowspan="3">
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px" valign="top">
                                        Remark
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="padding-top: 2px" rowspan="3" valign="top">
                            <ext:TextArea ID="txtRemark" runat="server" Height="65px" Width="317" Cls="text_80px"
                                TabIndex="12">
                            </ext:TextArea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 12px">
                                        Fax
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField ID="txtFax" runat="server" Cls="text_80px" Width="233px" TabIndex="10">
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 12px">
                                        Email
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" style="padding-top: 2px">
                            <ext:TextField ID="txtEmail" runat="server" Cls="text_80px" Width="233px" TabIndex="11">
                            </ext:TextField>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-bottom: 8px;
                                padding-top: 8px; padding-right: 5px">
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
                                                    <input type="button" id="btnNext" value="Next" runat="server" onclick="CompanyX.btnAddSave_Click();"
                                                        style="cursor: pointer; width: 65px" class="btn_C btn_text" tabindex="13" />
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
                                                    <input type="button" id="btnDelete" value="Delete" runat="server" onclick="Ext.Msg.confirm('status','Are you sure you want to delete',function(btn){if(btn=='yes'){CompanyX.btnCancel_click();}});"
                                                        class="btn_text btn_C" style="cursor: pointer; width: 65px" tabindex="14" />
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
                                                        tabindex="15" class="btn_text btn_C" style="cursor: pointer; width: 65px" />
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
                        <td align="left">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr id="GridView">
                                    <td>
                                        <ext:Store ID="storeGrid" runat="server">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="UserName" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="UserPWD" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="NameCHS" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="NameENG" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyID" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Email" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Question" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Answer" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Tel" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="IsActivation" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="SYS" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="STAT" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Remark" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Creator" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Modifier" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Fax" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="_Active" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="_Fax" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="_Email" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="_Remark" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="_Tel" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                        <ext:GridPanel ID="gridpanel" runat="server" Width="703px" Height="342px" TrackMouseOver="true"
                                            StripeRows="true" ColumnLines="True" StoreID="storeGrid">
                                            <ColumnModel ID="ctl33">
                                                <Columns>
                                                    <ext:RowNumbererColumn Header="No." Width="30">
                                                    </ext:RowNumbererColumn>
                                                    <ext:Column Header="Station" DataIndex="STAT" Width="100" Align="Center">
                                                    </ext:Column>
                                                    <ext:Column Header="User" DataIndex="UserName" Width="120">
                                                    </ext:Column>
                                                    <ext:Column Header="Name" DataIndex="NameENG" Width="130">
                                                    </ext:Column>
                                                    <ext:Column Header="Tel" DataIndex="_Tel" Width="60" Align="Center">
                                                    </ext:Column>
                                                    <ext:Column Header="Fax" DataIndex="_Fax" Width="60" Align="Center">
                                                    </ext:Column>
                                                    <ext:Column Header="Email" DataIndex="_Email" Width="60" Align="Center">
                                                    </ext:Column>
                                                    <ext:Column Header="Remark" DataIndex="_Remark" Width="60" Align="Center">
                                                    </ext:Column>
                                                    <ext:Column Header="Active" DataIndex="_Active" Width="60" Align="Center">
                                                    </ext:Column>
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                                    <DirectEvents>
                                                        <RowSelect OnEvent="row_Click">
                                                            <ExtraParams>
                                                                <ext:Parameter Name="RowID" Value="record.data.RowID" Mode="Raw" />
                                                                <ext:Parameter Name="UserName" Value="record.data.UserName" Mode="Raw" />
                                                                <ext:Parameter Name="NameCHS" Value="record.data.NameCHS" Mode="Raw" />
                                                                <ext:Parameter Name="NameENG" Value="record.data.NameENG" Mode="Raw" />
                                                                <ext:Parameter Name="CompanyID" Value="record.data.CompanyID" Mode="Raw" />
                                                                <ext:Parameter Name="Email" Value="record.data.Email" Mode="Raw" />
                                                                <ext:Parameter Name="IsDelete" Value="record.data.IsDelete" Mode="Raw" />
                                                                <ext:Parameter Name="Tel" Value="record.data.Tel" Mode="Raw" />
                                                                <ext:Parameter Name="Fax" Value="record.data.Fax" Mode="Raw" />
                                                                <ext:Parameter Name="Question" Value="record.data.Question" Mode="Raw" />
                                                                <ext:Parameter Name="Answer" Value="record.data.Answer" Mode="Raw" />
                                                                <ext:Parameter Name="IsActivation" Value="record.data.IsActivation" Mode="Raw" />
                                                                <ext:Parameter Name="SYS" Value="record.data.SYS" Mode="Raw" />
                                                                <ext:Parameter Name="STAT" Value="record.data.STAT" Mode="Raw" />
                                                                <ext:Parameter Name="Remark" Value="record.data.Remark" Mode="Raw" />
                                                                <ext:Parameter Name="AWBArrange" Value="record.data.AWBArrange" Mode="Raw" />
                                                                <ext:Parameter Name="Stat" Value="record.data.Stat" Mode="Raw" />
                                                                <ext:Parameter Name="UserPWD" Value="record.data.UserPWD" Mode="Raw" />
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
