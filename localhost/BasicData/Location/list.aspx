<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Location</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>
    <link href="../../common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/ylQuery.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script type="text/javascript" src="Controller.js"></script>
    <script src="../AjaxServer/CheckField.js" type="text/javascript"></script>
    <ext:XScript ID="XScript1" runat="server">
    <script type="text/javascript">
            var applyFilter = function (field) {
                var store = #{GridPanel1}.getStore();
                store.suspendEvents();
                store.filterBy(getRecordFilter());                                
                store.resumeEvents();
                #{GridPanel1}.getView().refresh(false);
            }
             
            var clearFilter = function () {
                #{CodeFilter}.reset();
                #{DiscriptionFilter}.reset();
                #{cityFilter}.reset();
                #{CountryFilter}.reset();
                #{oceanFilter}.reset();
                #{airFilter}.reset();
                #{currencyFilter}.reset();
                #{Store7}.clearFilter();
            }
           
            var filterString = function (value, dataIndex, record){
                var val = record.get(dataIndex);
                
                if (typeof val != "string") {
                    return value.length == 0;
                }
                
                return val.toLowerCase().indexOf(value.toLowerCase()) > -1;
            };
            var getRecordFilter = function () {
                var f = [];
 
                f.push({
                    filter: function (record) {                         
                        return filterString(#{CodeFilter}.getValue(), "Code", record);
                    }
                });
                  
                f.push({
                    filter: function (record) {                         
                        return filterString(#{DiscriptionFilter}.getValue(), "Name", record);
                    }
                });
                f.push({
                    filter: function (record) {                         
                        return filterString(#{CountryFilter}.getValue(), "Country", record);
                    }
                });
               
 
                var len = f.length;
                 
                return function (record) {
                    for (var i = 0; i < len; i++) {
                        if (!f[i].filter(record)) {
                            return false;
                        }
                    }
                    return true;
                };
            };
    </script>
    </ext:XScript>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server">
    </ext:ResourceManager>
    <ext:Store runat="server" ID="StoreCompany">
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
        <AutoLoadParams>
            <ext:Parameter Name="start" Value="={0}" />
            <ext:Parameter Name="limit" Value="={100}" />
        </AutoLoadParams>
    </ext:Store>
    <div id="location_div01">
        <div id="countryControl">
            <table width="650" border="0" cellpadding="0" cellspacing="0" class="table_25left">
                <tr>
                    <td width="53" style="padding-left: 6px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Code<span class="font_red" style="padding-left: 2px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="100px">
                        <ext:TextField AllowBlank="false" ID="Code" runat="server" Cls="text_110px" Width="90"
                            TabIndex="1" MaxLength="5" MinLength="3" BlankText="Code can't be empty" AutoFocus="true">
                            <Listeners>
                                <Blur Handler="checkCode('LOCATION','Code',#{hidRowID}.getValue())" />
                                <KeyUp Handler="removeClass('Code')" />
                            </Listeners>
                        </ext:TextField>
                        <ext:Hidden ID="hidRowID" runat="server" Text="0" />
                    </td>
                    <td style="padding-left: 10px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Description<span class="font_red" style="padding: 0 5px 0 2px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <ext:TextField AllowBlank="false" Cls="text_160px" ID="Name" TabIndex="2" runat="server"
                            Width="150" MaxLength="30" BlankText="Description can't be empty">
                        </ext:TextField>
                    </td>
                    <td style="padding-left: 15px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Country<span class="font_red" style="padding: 0 8px 0 2px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td >
                        <ext:ComboBox ID="Country" runat="server" Cls="select_160px" Width="100" Mode="Local"
                            TabIndex="3" DisplayField="value" ValueField="value" AllowBlank="false" MinChars="1"
                            ListWidth="200" ItemSelector="tr.list-item" BlankText="Country can't be empty"
                           >
                            <Store>
                                <ext:Store runat="server" ID="storeCountry">
                                    <Reader>
                                        <ext:JsonReader>
                                            <Fields>
                                                <ext:RecordField Name="value">
                                                </ext:RecordField>
                                                <ext:RecordField Name="text">
                                                </ext:RecordField>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>
                            <Template ID="Template1" runat="server">
                                <Html>
                                    <tpl for=".">
						<tpl if="[xindex] == 1">
							<table class="cbStates-list">
								<tr>
									<th>Code</th>
									<th>Name</th>
								</tr>
						</tpl>
						<tr class="list-item">
							<td style="padding:3px 0px 3px 5px; width:60px;">{value}</td>
							<td style=" width:140px;">{text}</td>
						</tr>
						<tpl if="[xcount-xindex]==0"></tpl> 
                        </tpl>
                                </Html>
                            </Template>
                        </ext:ComboBox>
                    </td>
                    <td width="47" style="padding-left: 15px; display: none">
                        <table width="40" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    City
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="display: none">
                        <ext:TextField Cls="text_160px" ID="City" TabIndex="4" runat="server" MaxLength="50"
                            Width="120" />
                    </td>
                </tr>
                <tr style="display: none">
                    <td style="padding-left: 6px">
                        <table width="60" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Air Agent
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <uc1:UserComboBox runat="server" ID="AirAgent" clsClass="select_160px" TabIndex="5"
                            StoreID="StoreCompany" Width="90" winTitle="Company" isButton="false" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" />
                    </td>
                    <td>
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold" style="padding-left: 10px">
                                    Ocean Agent
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <uc1:UserComboBox runat="server" ID="OceanAgent" clsClass="select_160px" TabIndex="6"
                            StoreID="StoreCompany" Width="100" winTitle="Company" isButton="false" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" />
                    </td>
                    <td class="font_11bold" style="padding-left: 15px; padding-right: 15px" colspan="1">
                        Currency
                    </td>
                    <td>
                        <ext:ComboBox ID="Currency" runat="server" Cls="select_160px" Mode="Local" DisplayField="value"
                            Width="100" ValueField="value" TabIndex="7">
                            <Store>
                                <ext:Store runat="server" ID="storeCurrency">
                                    <Reader>
                                        <ext:JsonReader>
                                            <Fields>
                                                <ext:RecordField Name="value">
                                                </ext:RecordField>
                                                <ext:RecordField Name="text">
                                                </ext:RecordField>
                                    
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>
                        </ext:ComboBox>
                    </td>
                </tr>
            </table>
            <div style="width: 808px; margin-top: 10px;">
                <div style="float: left; margin-top: 2px">
                    <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                    </ext:CheckboxGroup>
                </div>
                <table border="0" cellpadding="0" cellspacing="0" style="float: right;">
                    <tr>
                        <td>
                            <table align="right">
                                <tr>
                                    <td align="right">
                                        <ext:Checkbox Checked="true" ID="chkActive" runat="server" HideLabel="true" Width="28"
                                            TabIndex="8">
                                        </ext:Checkbox>
                                    </td>
                                    <td class="font_11bold" style="padding-right: 3px">
                                        Active
                                    </td>
                                    <td>
                                        <ext:Button runat="server" ID="Next" Cls="Submit_70px" Text="Next" Width="70px">
                                            <Listeners>
                                                <Click Handler="return Validata('Code')" />
                                            </Listeners>
                                            <DirectEvents>
                                                <Click OnEvent="btnNext_Click">
                                                    <EventMask Msg="Saving..." ShowMask="true" />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td style="padding: 0px 2px">
                                        <ext:Button runat="server" ID="Cancel" Cls="Submit_70px" Text="Cancel" Width="70px">
                                            <Listeners>
                                                <Click Handler="if(hidRowID.getValue()=='0'){Code.setValue('');Name.setValue(''); Code.focus(true);Country.setValue(''); return false; }" />
                                            </Listeners>
                                            <DirectEvents>
                                                <Click OnEvent="btnCancel_click">
                                                    <EventMask Msg="Loading..." ShowMask="true" />
                                                    <ExtraParams>
                                                        <ext:Parameter Name="rowdata" Value="Ext.encode(#{GridPanel1}.getStore().getById(hidRowID.getValue()).json)"
                                                            Mode="Raw">
                                                        </ext:Parameter>
                                                    </ExtraParams>
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td>
                                        <ext:Button runat="server" ID="Save" Cls="Submit_70px" Text="Save" Width="70px">
                                            <Listeners>
                                                <Click Handler="return Validata('Code')" />
                                            </Listeners>
                                            <DirectEvents>
                                                <Click OnEvent="btnSave_Click">
                                                    <EventMask Msg="Saving..." ShowMask="true" />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            </div>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0" style="margin:12px 0 8px 0;">
                            <tr>
                                <td id="GridView">
                                    <ext:GridPanel ID="GridPanel1" runat="server" StripeRows="true" Height="365" Width="808"
                                        AutoExpandColumn="Code">
                                        <Store>
                                            <ext:Store ID="Store7" runat="server">
                                                <Reader>
                                                    <ext:JsonReader IDProperty="RowID">
                                                        <Fields>
                                                            <ext:RecordField Name="Code" />
                                                            <ext:RecordField Name="Name" />
                                                            <ext:RecordField Name="City" />
                                                            <ext:RecordField Name="Country" />
                                                            <ext:RecordField Name="AIR" />
                                                            <ext:RecordField Name="OCEAN" />
                                                            <ext:RecordField Name="Currency" />
                                                            <ext:RecordField Name="Active" />
                                                             <ext:RecordField Name="StatList" />
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                        </Store>
                                        <ColumnModel ID="ColumnModel1" runat="server">
                                            <Columns>
                                                <ext:RowNumbererColumn Width="30" Header="No." />
                                                <ext:Column DataIndex="Code" Header="Code" Width="150" />
                                                <ext:Column DataIndex="Name" Header="Description" Width="350" />
                                                <ext:Column DataIndex="City" Header="City" Width="100" Hidden="true" />
                                                <ext:Column DataIndex="Country" Header="Country" Width="150" />
                                                <ext:Column DataIndex="AIR" Header="AIR" Width="90" Hidden="true" />
                                                <ext:Column DataIndex="OCEAN" Header="OCEAN" Width="100" Hidden="true" />
                                                <ext:Column DataIndex="Currency" Header="Currency" Width="65" Hidden="true" />
                                                <ext:CheckColumn DataIndex="Active" Header="Active" Width="50" />
                                            </Columns>
                                        </ColumnModel>
                                        <SelectionModel>
                                            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                                <DirectEvents>
                                                    <RowSelect OnEvent="Row_Select">
                                                        <EventMask ShowMask="true" Msg="Loading..." />
                                                        <ExtraParams>
                                                            <ext:Parameter Name="rowdata" Value="Ext.encode(record.json)" Mode="Raw">
                                                            </ext:Parameter>
                                                        </ExtraParams>
                                                    </RowSelect>
                                                </DirectEvents>
                                            </ext:RowSelectionModel>
                                        </SelectionModel>
                                        <View>
                                            <ext:GridView ID="GridView1" runat="server">
                                                <HeaderRows>
                                                    <ext:HeaderRow>
                                                        <Columns>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="CodeFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="DiscriptionFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="cityFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="CountryFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="oceanFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="airFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="currencyFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn>
                                                                <Component>
                                                                    <ext:Button ID="ClearFilterButton" runat="server" Icon="Cancel">
                                                                        <Listeners>
                                                                            <Click Handler="clearFilter();" />
                                                                        </Listeners>
                                                                    </ext:Button>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                        </Columns>
                                                    </ext:HeaderRow>
                                                </HeaderRows>
                                            </ext:GridView>
                                        </View>
                                        <LoadMask ShowMask="true" Msg=" Loading..." />
                                    </ext:GridPanel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <ext:Container runat="server" ID="div_bottom">
        </ext:Container>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        var dept = "<%=dep %>";
        var sys = "<%=stationSys %>";
        if (dept == 'OP' || dept == 'ACCOUNT' || sys == 'N') {
            DisableDIV();
            DisableCombox("Country");
        }
        SetWinSize();
    });
</script>
