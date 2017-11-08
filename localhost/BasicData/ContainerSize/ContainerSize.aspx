<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContainerSize.aspx.cs" Inherits="BasicData_ContainerSize_ContainerSize" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <link href="../../common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/ylQuery.js" type="text/javascript"></script>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../AjaxServer/CheckField.js" type="text/javascript"></script>
    <ext:XScript ID="XScript1" runat="server">
    <script type="text/javascript">
            var applyFilter = function (field) {
                var store = #{GridPanel1}.getStore();
                store.suspendEvents();
                store.filterBy(getRecordFilter());                                
                store.resumeEvents();
                #{GridPanel1}.getView().refresh(false);
            };
             
            var clearFilter = function () {
                #{CodeFilter}.reset();
                #{DescriptionFilter}.reset();
                #{LengthFilter}.reset();
                #{ContainerTypeFilter}.reset();
                #{GroupFilter}.reset();
                #{StoreService}.clearFilter();
            };
           
            var filterString = function (value, dataIndex, record) {
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
                        return filterString(#{CodeFilter}.getValue(), "ctnr_Code", record);
                    }
                });
                
                f.push({
                    filter: function (record) {                         
                        return filterString(#{ISOCodeFilter}.getValue(), "ctnr_EDI", record);
                    }
                });
                f.push({
                    filter: function (record) {                         
                        return filterString(#{DescriptionFilter}.getValue(), "ctnr_Description", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{LengthFilter}.getValue(), "ctnr_Length", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{GroupFilter}.getValue(), "ctnr_Group", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{ContainerTypeFilter}.getValue(), "ctnr_ContainerType", record);
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
    <ext:ResourceManager runat="server" ID="ResouceID">
    </ext:ResourceManager>
    <div id="location_div01">
        <ext:Hidden ID="txtRowID" runat="server" Text="0">
        </ext:Hidden>
        <div id="countryControl">
            <table border="0'" cellpadding="0" cellspacing="0" class="table_25left">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold" style="padding-right: 5px">
                                    Code<span class="font_red" style="padding-left: 2px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="71">
                        <ext:TextField ID="txtCode" runat="server" TabIndex="1" Cls="text_75px" AllowBlank="false"
                            BlankText="Code can't be empty" AutoFocus="true" Width="70">
                            <Listeners>
                                <Blur Handler="checkCode('CONTAINER SIZE','txtCode',#{txtRowID}.getValue())" />
                                <KeyUp Handler="removeClass('txtCode')" />
                            </Listeners>
                        </ext:TextField>
                    </td>
                    <td width="37" style="padding-left: 15px; padding-right: 5px">
                        <table width="40" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="41" class="font_11bold">
                                    Description
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="82">
                        <ext:TextField ID="txtDes" runat="server" ClearCls="" Cls="text_75px" TabIndex="2" Width="100">
                        </ext:TextField>
                    </td>
                    <td style="padding-left: 15px; width:85px;">
                           EDI <span class="font_red" style="padding-left: 10px">*</span>
                    </td>
                    <td>  <ext:TextField ID="txtisocode" runat="server" ClearCls="" Cls="text_75px" TabIndex="3" MaxLength="4" AllowBlank="false"
                            BlankText="Code can't be empty" Width="65">
                        </ext:TextField>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Long
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <ext:NumberField ID="txtLong" runat="server" ClearCls="" Cls="text_75px" TabIndex="3" Width="70"
                            StyleSpec="text-align:right">
                        </ext:NumberField>
                    </td>
                    <td style="padding-left: 15px">
                        Type
                    </td>
                    <td>
                        <ext:Store runat="server" ID="Store1">
                            <Reader>
                                <ext:JsonReader>
                                    <Fields>
                                        <ext:RecordField Name="text" />
                                        <ext:RecordField Name="value" />
                                    </Fields>
                                </ext:JsonReader>
                            </Reader>
                        </ext:Store>
                        <ext:ComboBox ID="CmbCalc" TabIndex="4" runat="server" StoreID="Store1" DisplayField="value"
                            ValueField="value" Mode="Local"  Cls="select" Width="100">
                        </ext:ComboBox>
                    </td>
                    <td style="padding-left: 15px; width: 40px;">
                        Group<span class="font_red" style="padding-left: 2px">*</span>
                    </td>
                    <td>
                        <ext:Store runat="server" ID="Store2">
                            <Reader>
                                <ext:JsonReader>
                                    <Fields>
                                        <ext:RecordField Name="text" />
                                        <ext:RecordField Name="value" />
                                    </Fields>
                                </ext:JsonReader>
                            </Reader>
                        </ext:Store>
                        <ext:ComboBox ID="CmbGroup" TabIndex="4" runat="server" StoreID="Store2" DisplayField="value"
                            ValueField="value" Mode="Local" Width="65" Cls="select" AllowBlank="false" BlankText="Group can't be empty">
                        </ext:ComboBox>
                    </td>
                </tr>
            </table>
            <div style="width: 411px; margin-top: 10px;">
                <div style="float: left; margin-top:2px">
                    <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                    </ext:CheckboxGroup>
                </div>
                <table border="0" style="float: right;" align="right" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="right">
                            <ext:Checkbox ID="ChbActive" runat="server" Checked="true" TabIndex="5" Width="28">
                            </ext:Checkbox>
                        </td>
                        <td class="font_11bold" style="padding-left: 5px">
                            Active
                        </td>
                        <td align="center" style="padding-left: 5px">
                            <ext:Button ID="btnAddSave" runat="server" Text="Next" Cls="Submit_70px" Width="70px">
                                <DirectEvents>
                                    <Click OnEvent="btnAddSave_Click">
                                        <EventMask Msg="Saving..." ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                        <td align="center" style="padding-left: 5px">
                            <ext:Button ID="btnCancel" Text="Cancel" runat="server" Cls="Submit_70px" Width="70px">
                                <Listeners>
                                    <Click Handler="if(txtRowID.getValue()=='0'){txtCode.setValue('');txtDes.setValue('');txtLong.setValue('');CmbCalc.setValue('');CmbGroup.setValue('');txtCode.focus(true);return false;}" />
                                    <Click />
                                </Listeners>
                                <DirectEvents>
                                    <Click OnEvent="btnCancel_Click">
                                        <EventMask ShowMask="true" Msg="Loading..." />
                                        <ExtraParams>
                                            <ext:Parameter Name="ctnr_ROWID" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.ctnr_ROWID"
                                                Mode="Raw" />
                                            <ext:Parameter Name="ctnr_Code" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.ctnr_Code"
                                                Mode="Raw" />   
                                            <ext:Parameter Name="ctnr_EDI" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.ctnr_EDI"
                                                Mode="Raw" />
                                            <ext:Parameter Name="ctnr_Description" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.ctnr_Description"
                                                Mode="Raw" />
                                            <ext:Parameter Name="ctnr_Length" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.ctnr_Length"
                                                Mode="Raw" />
                                            <ext:Parameter Name="ctnr_ContainerType" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.ctnr_ContainerType"
                                                Mode="Raw" />
                                            <ext:Parameter Name="ctnr_Group" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.ctnr_Group"
                                                Mode="Raw" />
                                            <ext:Parameter Name="ctnr_Active" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.ctnr_Active"
                                                Mode="Raw" />
                                            <ext:Parameter Name="StatList" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.StatList"
                                                Mode="Raw" />
                                        </ExtraParams>
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                        <td align="center" style="padding-left: 5px">
                            <ext:Button ID="btnSave" Text="Save" runat="server" Cls="Submit_70px" Width="70px">
                                <DirectEvents>
                                    <Click OnEvent="btnSave_Click">
                                        <EventMask Msg="Saving..." ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 8px 0;">
                        <tr>
                            <td id="GridView">
                                <ext:Store ID="StoreService" runat="server">
                                    <Reader>
                                        <ext:JsonReader IDProperty="ctnr_ROWID">
                                            <Fields>
                                                <ext:RecordField Name="ctnr_ROWID" Type="Int">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ctnr_Code" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ctnr_Length" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ctnr_EDI" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ctnr_ContainerType" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ctnr_Description" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ctnr_Active" Type="Boolean">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ctnr_Group" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="StatList" Type="String">
                                                </ext:RecordField>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                                <ext:GridPanel ID="GridPanel1" runat="server" Height="281" Width="411" StoreID="StoreService"
                                    TrackMouseOver="true" StripeRows="true">
                                    <ColumnModel ID="ctlM33">
                                        <Columns>
                                            <ext:Column Header="Code" DataIndex="ctnr_Code" Width="50">
                                            </ext:Column>
                                            <ext:Column Header="EDI" DataIndex="ctnr_EDI" Width="70">
                                            </ext:Column>
                                            <ext:Column Header="Description" DataIndex="ctnr_Description" Width="100">
                                            </ext:Column>
                                            <ext:Column Header="Long" DataIndex="ctnr_Length" Width="60" Align="Right" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="Type" DataIndex="ctnr_ContainerType" Width="60">
                                            </ext:Column>
                                            <ext:Column Header="Group" DataIndex="ctnr_Group" Width="60">
                                            </ext:Column>
                                            <ext:CheckColumn Header="Active" DataIndex="ctnr_Active" Width="50">
                                            </ext:CheckColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>                                                                              
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">                                                                                    
                                             <DirectEvents>                                                                                                
                                                <RowSelect OnEvent="Row_Select">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="ctnr_ROWID" Value="record.data.ctnr_ROWID" Mode="Raw" />
                                                        <ext:Parameter Name="ctnr_Code" Value="record.data.ctnr_Code" Mode="Raw" />
                                                        <ext:Parameter Name="ctnr_EDI" Value="record.data.ctnr_EDI" Mode="Raw" />
                                                        <ext:Parameter Name="ctnr_Description" Value="record.data.ctnr_Description" Mode="Raw" />
                                                        <ext:Parameter Name="ctnr_Length" Value="record.data.ctnr_Length" Mode="Raw" />
                                                        <ext:Parameter Name="ctnr_ContainerType" Value="record.data.ctnr_ContainerType" Mode="Raw" />
                                                        <ext:Parameter Name="ctnr_Group" Value="record.data.ctnr_Group" Mode="Raw" />
                                                        <ext:Parameter Name="ctnr_Active" Value="record.data.ctnr_Active" Mode="Raw" />
                                                        <ext:Parameter Name="StatList" Value="record.data.StatList" Mode="Raw" />
                                                    </ExtraParams>
                                                    <EventMask Msg="Loading..." ShowMask="true" />
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
                                                                <ext:TextField ID="ISOCodeFilter" runat="server" EnableKeyEvents="true">
                                                                    <Listeners>
                                                                        <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                    </Listeners>
                                                                </ext:TextField>
                                                            </Component>
                                                        </ext:HeaderColumn>
                                                        <ext:HeaderColumn Cls="x-small-editor">
                                                            <Component>
                                                                <ext:TextField ID="DescriptionFilter" runat="server" EnableKeyEvents="true">
                                                                    <Listeners>
                                                                        <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                    </Listeners>
                                                                </ext:TextField>
                                                            </Component>
                                                        </ext:HeaderColumn>
                                                        <ext:HeaderColumn Cls="x-small-editor">
                                                            <Component>
                                                                <ext:TextField ID="LengthFilter" runat="server" EnableKeyEvents="true">
                                                                    <Listeners>
                                                                        <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                    </Listeners>
                                                                </ext:TextField>
                                                            </Component>
                                                        </ext:HeaderColumn>
                                                        <ext:HeaderColumn Cls="x-small-editor">
                                                            <Component>
                                                                <ext:TextField ID="ContainerTypeFilter" runat="server" EnableKeyEvents="true">
                                                                    <Listeners>
                                                                        <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                    </Listeners>
                                                                </ext:TextField>
                                                            </Component>
                                                        </ext:HeaderColumn>
                                                        <ext:HeaderColumn Cls="x-small-editor">
                                                            <Component>
                                                                <ext:TextField ID="GroupFilter" runat="server" EnableKeyEvents="true">
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
        var dept = "<%=userDept %>";
        var sys = "<%=stationSys %>";
        var station = "<%=station %>";
        if ((dept == 'OP' || dept == 'ACCOUNT' || sys == 'N')&& station!="CON/HKG") {
            DisableDIV();
            DisableCombox("CmbCalc");
            DisableCombox("CmbGroup");
        }

        SetWinSize();
    });
</script>
