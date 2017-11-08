<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserList.aspx.cs" Inherits="Framework_User_UserList" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User List</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        input
        {
            text-transform: none;
        }
    </style>

    <script type="text/javascript">
        function userEdit(id) {
            hidID.setValue(id);
            CompanyX.ShowData(1);
        }


        function userActive(id, status) {
            var s = status == "Y" ? "Are you sure you want to be void?" : "Are you sure you want to be active";
            Ext.Msg.confirm('Information', s, function(btn) {
                if (btn == 'yes') {
                    CompanyX.UserActive(id, status);
                }
            });
        }
        function userChangepass(id, name) {
            hidID.setValue(id);
            labName.setText(name);
            winPassChange.show();
        }
        function userStat(name, comid) {
            labUserName.setText(name);
            CompanyX.UserStat(name, comid);
        }
        function statSelect() {
            var str = "";
            for (var i = 0; i < 30; i++) {
                var obj = document.getElementById("chkGroup" + i);
                if (obj == null || obj == undefined) {
                    break;
                }
                else if (obj.checked) {
                    str = str + obj.name + ",";
                }
            }
            hidList.setValue(str);
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidID" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidList" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidName" runat="server">
    </ext:Hidden>
    <ext:Store runat="server" ID="StoreStat">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreGrade">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreDept">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreSys">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <div style="margin-left: 13px">
        <table width="960" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" style="padding-top: 10px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td>
                                            User List
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="10px">
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellspacing="4" cellpadding="0">
                        <tr>
                            <td style="padding-left: 2px">
                                Stat
                            </td>
                            <td>
                                <ext:ComboBox ID="cmbStat" runat="server" Cls="select" Width="75" StoreID="StoreStat"
                                    TabIndex="1" DisplayField="text" ValueField="text" Mode="Local" ForceSelection="true"
                                    TriggerAction="All">
                                </ext:ComboBox>
                            </td>
                            <td width="63" style="padding-left: 2px">
                                User Grade
                            </td>
                            <td width="100">
                                <ext:ComboBox ID="cmbGrade" runat="server" Cls="select" Width="85" StoreID="StoreGrade"
                                    TabIndex="2" DisplayField="text" ValueField="text" Mode="Local" ForceSelection="true"
                                    TriggerAction="All">
                                </ext:ComboBox>
                            </td>
                            <td width="50" style="padding-left: 5px">
                                Department
                            </td>
                            <td width="100">
                                <ext:ComboBox ID="cmbDept" runat="server" Cls="select" Width="85" StoreID="StoreDept"
                                    TabIndex="3" DisplayField="text" ValueField="text" Mode="Local" ForceSelection="true"
                                    TriggerAction="All">
                                </ext:ComboBox>
                            </td>
                            <td style="padding-left: 5px">
                                User
                            </td>
                            <td>
                                <ext:TextField ID="txtUser" runat="server" Cls="text" Width="90" TabIndex="4">
                                </ext:TextField>
                            </td>
                            <td style="padding-left: 5px">
                                <ext:Checkbox ID="chkActive" runat="server" BoxLabel="Active" Checked="true" TabIndex="5">
                                    <Listeners>
                                        <Check Handler="Ext.getCmp('btnFilter').fireEvent('click', this);" />
                                    </Listeners>
                                </ext:Checkbox>
                            </td>
                            <td width="80" align="center">
                                <ext:Button ID="btnFilter" runat="server" Cls="Submit_65px" Text="Search" Width="65"
                                    TabIndex="6" AutoFocus="true">
                                    <DirectEvents>
                                        <Click OnEvent="btnFilter_Click">
                                            <EventMask ShowMask="true" CustomTarget="gridList" />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                    <Enter Handler="btnFilter.fireEvent('click')" />
                                </ext:KeyNav>
                            </td>
                            <td width="80" align="center">
                                <ext:Button ID="btnAdd" runat="server" Cls="Submit_65px" Text="Add User" Width="65"
                                    TabIndex="7" AutoFocus="true">
                                    <Listeners>
                                        <Click Handler="CompanyX.ShowData(0);" />
                                    </Listeners>
                                </ext:Button>
                            </td>
                            <td width="80" align="center" style=" display:none">
                                <ext:Button ID="btnPrinter" runat="server" Text="  Printer  " Cls="Submit_65px" Width="65">
                                <DirectEvents>
                                    <Click OnEvent="btnPrinter_Click">
                                    </Click>
                                </DirectEvents>
                                </ext:Button>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="10">
                </td>
            </tr>
            <tr>
                <td id="GridView">
                    <ext:GridPanel ID="gridList" runat="server" Height="368" Width="960px" TrackMouseOver="true"
                        StripeRows="true">
                        <Store>
                            <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                                AutoLoad="true">
                                <AutoLoadParams>
                                    <ext:Parameter Name="start" Value="={0}" />
                                    <ext:Parameter Name="limit" Value="={100}" />
                                </AutoLoadParams>
                                <Reader>
                                    <ext:JsonReader IDProperty="RowID">
                                        <Fields>
                                            <ext:RecordField Name="UserName" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="NameENG" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="STAT" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Tel" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Email" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="UserGrade" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Dept" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Edit" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Active" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Pass" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="StatList" Type="String">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel runat="server" ID="ColumnModel1">
                            <Columns>
                                <ext:Column Header="User" DataIndex="UserName" Width="100" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Name" DataIndex="NameENG" Width="85" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Stat" DataIndex="STAT" Width="70" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Tel" DataIndex="Tel" Width="120">
                                </ext:Column>
                                <ext:Column Header="Email" DataIndex="Email" Width="150">
                                </ext:Column>
                                <ext:Column Header="Grade" DataIndex="UserGrade" Width="80" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Dept" DataIndex="Dept" Width="80" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Active" DataIndex="Active" Width="55" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Edit" DataIndex="Edit" Width="55" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Password" DataIndex="Pass" Width="65" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Stat List" DataIndex="StatList" Width="80" Align="Center">
                                </ext:Column>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="RowSelectionModel1" SingleSelect="true">
                            </ext:RowSelectionModel>
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar StoreID="storeList" PageSize="100" runat="server" ID="PagingToolbar1"
                                AfterPageText="&nbsp;of {0}" BeforePageText=" Page " DisplayMsg="Displaying {0} - {1} of  {2} "
                                EmptyMsg="No Data">
                            </ext:PagingToolbar>
                        </BottomBar>
                    </ext:GridPanel>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <ext:Window ID="winUserList" runat="server" Hidden="true" Title="Add User" Icon="Add"
            Modal="true" Width="745px" Height="220px" BodyStyle="background-color:#fff;"
            Padding="5" Border="false">
            <Content>
                <table width="710px" border="0" cellpadding="0" cellspacing="0" class="table_23_left">
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
                            <ext:TextField AllowBlank="false" ID="txtUserName" runat="server" Cls="text_80px"
                                Width="115px" TabIndex="20">
                                <Listeners>
                                    <Blur Handler="if(#{txtNameEn}.getValue()==''){#{txtNameEn}.setValue(#{txtUserName}.getValue());}if(#{txtNameLocal}.getValue()==''){#{txtNameLocal}.setValue(#{txtUserName}.getValue());}" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td>
                            <table width="85" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        <ext:Label ID="labPass" runat="server" Text="Password">
                                        </ext:Label>
                                        <ext:Label ID="labRed" runat="server" Text="*" StyleSpec="color:red;">
                                        </ext:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:TextField InputType="Password" AllowBlank="false" ID="txtPwd" runat="server"
                                            Cls="text_80px" Width="115px" TabIndex="21">
                                        </ext:TextField>
                                    </td>
                                    <td style="padding-left: 3px">
                                        <ext:TextField InputType="Password" AllowBlank="false" ID="txtPwdAgain" runat="server"
                                            Vtype="password" MsgTarget="Qtip" Cls="text_80px" Width="115px" TabIndex="22">
                                            <CustomConfig>
                                                <ext:ConfigItem Name="initialPassField" Value="#{txtPwd}" Mode="Value" />
                                            </CustomConfig>
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
                                        Station
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:ComboBox ID="cmbUserStat" runat="server" Cls="select" Width="75" StoreID="StoreStat"
                                TabIndex="23" DisplayField="text" ValueField="value" Mode="Local" ForceSelection="true"
                                TriggerAction="All">
                            </ext:ComboBox>
                        </td>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Group
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:ComboBox ID="cmbSys" runat="server" Cls="select" Width="85" StoreID="StoreSys"
                                            TabIndex="24" DisplayField="text" ValueField="value" Mode="Local" ForceSelection="true"
                                            TriggerAction="All">
                                        </ext:ComboBox>
                                    </td>
                                    <td align="right">
                                        <table cellpadding="0" cellspacing="0" border="0" >
                                            <tr>
                                                <td style="padding-left: 55px">
                                                    <ext:Checkbox ID="chkUserActive" runat="server" Checked="true" TabIndex="25"  LabelWidth="0" HideLabel="true">
                                                    </ext:Checkbox>
                                                </td>
                                                <td class="font_11bold" align="right">
                                                    Active
                                                </td>
                                                <td style="padding-left: 55px">
                                                    <ext:Checkbox ID="chkSales" runat="server" TabIndex="26">
                                                    </ext:Checkbox>
                                                </td>
                                                <td class="font_11bold" align="right">
                                                    Sales
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
                                        Name
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField ID="txtNameEn" runat="server" Cls="text_80px" Width="233px" TabIndex="27">
                            </ext:TextField>
                        </td>
                        <td>
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Grade
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:ComboBox ID="cmbUserGrade" runat="server" Cls="select" Width="85" StoreID="StoreGrade"
                                            TabIndex="31" DisplayField="text" ValueField="value" Mode="Local" ForceSelection="true"
                                            TriggerAction="All">
                                        </ext:ComboBox>
                                    </td>
                                    <td align="right">
                                        <table cellpadding="0" cellspacing="0" border="0" width="115">
                                            <tr>
                                                <td style="padding-left: 55px">
                                                    Department
                                                </td>
                                                <td class="font_11bold" align="right" style="padding-left: 10px">
                                                    <ext:ComboBox ID="cmbUserDept" runat="server" Cls="select" Width="85" StoreID="StoreDept"
                                                        TabIndex="32" DisplayField="text" ValueField="value" Mode="Local" ForceSelection="true"
                                                        TriggerAction="All">
                                                    </ext:ComboBox>
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
                            <table width="85" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Name (Local)
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField ID="txtNameLocal" runat="server" Cls="text_80px" Width="233px" TabIndex="28">
                            </ext:TextField>
                        </td>
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
                            <ext:TextField ID="txtEmail" runat="server" Cls="text_80px" Width="317px" TabIndex="33">
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
                            <ext:TextField ID="txtTel" runat="server" Cls="text_80px" Width="233px" TabIndex="29">
                            </ext:TextField>
                        </td>
                        <td valign="top" rowspan="2">
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px" valign="top">
                                        Remark
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="padding-top: 2px" rowspan="2" valign="top">
                            <ext:TextArea ID="txtRemark" runat="server" Height="45px" Width="317" Cls="text_80px"
                                TabIndex="34">
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
                            <ext:TextField ID="txtFax" runat="server" Cls="text_80px" Width="233px" TabIndex="30">
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td colspan="3" style=" padding-top:8px;">
                            <table>
                                <tr>
                                    <td>
                                        <ext:Button runat="server" ID="btnSave" Cls="Submit_70px" Text="Add" Width="70px"
                                            TabIndex="35">
                                            <DirectEvents>
                                                <Click OnEvent="btnSave_Click">
                                                    <EventMask ShowMask="true" Msg=" Saving... " />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td style="padding-left: 10px;">
                                        <ext:Button runat="server" ID="btnCancel" Cls="Submit_70px" Text="Cancel" Width="70px"
                                            TabIndex="36">
                                            <Listeners>
                                                <Click Handler="winUserList.hide();" />
                                            </Listeners>
                                        </ext:Button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </Content>
        </ext:Window>
        <ext:Window ID="winPassChange" runat="server" Hidden="true" Title="Change Password"
            Icon="UserEdit" Modal="true" Width="300px" Height="150px" BodyStyle="background-color:#fff;"
            Padding="5" Border="false">
            <Content>
                <table width="280px" border="0" cellpadding="0" cellspacing="0" class="table_23_left">
                    <tr>
                        <td>
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        User Name
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:Label ID="labName" runat="server">
                                        </ext:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Password
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:TextField InputType="Password" AllowBlank="false" ID="txtChangePass" runat="server"
                                            Cls="text_80px" Width="115px">
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Confirm password
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField InputType="Password" AllowBlank="false" ID="txtChangePassAgain" runat="server"
                                Vtype="password" MsgTarget="Qtip" Cls="text_80px" Width="115px">
                                <CustomConfig>
                                    <ext:ConfigItem Name="initialPassField" Value="#{txtChangePass}" Mode="Value" />
                                </CustomConfig>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-top: 10px; padding-left: 10px;">
                            <table>
                                <tr>
                                    <td>
                                        <ext:Button runat="server" ID="btnChangePass" Cls="Submit_70px" Text="Update" Width="70px">
                                            <DirectEvents>
                                                <Click OnEvent="btnChangePass_Click">
                                                    <EventMask ShowMask="true" Msg=" Changing... " />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td style="padding-left: 10px;">
                                        <ext:Button runat="server" ID="btnChanageCancel" Cls="Submit_70px" Text="Cancel"
                                            Width="70px">
                                            <Listeners>
                                                <Click Handler="winPassChange.hide();" />
                                            </Listeners>
                                        </ext:Button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </Content>
        </ext:Window>
        <ext:Window ID="winUserStat" runat="server" Hidden="true" Title="User Stat" Icon="User"
            Modal="true" Width="405px" Height="200px" BodyStyle="background-color:#fff;"
            Padding="5" Border="false">
            <Content>
                <table width="96%" border="0" cellpadding="0" cellspacing="0" class="table_23_left">
                    <tr>
                        <td>
                            <table width="100" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        User Name
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="left">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:Label ID="labUserName" runat="server">
                                        </ext:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 10px">
                                        Stat List
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <ext:Panel runat="server" ID="panChk" Width="280px">
                                        </ext:Panel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-top: 10px; padding-left: 10px;">
                            <table>
                                <tr>
                                    <td>
                                        <ext:Button runat="server" ID="btnStatUpdate" Cls="Submit_70px" Text="Update" Width="70px">
                                            <Listeners>
                                                <Click Fn="statSelect" />
                                            </Listeners>
                                            <DirectEvents>
                                                <Click OnEvent="btnStatUpdate_Click">
                                                    <EventMask ShowMask="true" Msg=" Saving... " />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td style="padding-left: 10px;">
                                        <ext:Button runat="server" ID="btnStatCancel" Cls="Submit_70px" Text="Cancel" Width="70px">
                                            <Listeners>
                                                <Click Handler="winUserStat.hide();" />
                                            </Listeners>
                                        </ext:Button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </Content>
        </ext:Window>
    </div>
    </form>
</body>
</html>
