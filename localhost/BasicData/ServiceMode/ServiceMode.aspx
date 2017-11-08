<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ServiceMode.aspx.cs" Inherits="BasicData_ServiceMode_ServiceMode" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .cb-cell td
        {
            padding-right: 20px;
        }
    </style>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
     <script type="text/javascript">
        function TextFocus() {
        }
    </script>
    <script src="../AjaxServer/CheckField.js" type="text/javascript"></script>
    <ext:XScript ID="XScript1" runat="server">
    <script type="text/javascript">
        function SalesActive(id, status) {
            CompanyX.SalesActive(id, status);
        }
        
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
                #{CalcUnitFilter}.reset();
                #{BLStringFilter}.reset();
                #{StoreService}.clearFilter();
            }
           
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
                        return filterString(#{CodeFilter}.getValue(), "sm_CODE", record);
                    }
                });
                  
                f.push({
                    filter: function (record) {                         
                        return filterString(#{DiscriptionFilter}.getValue(), "sm_Description", record);
                    }
                });
                
                f.push({
                    filter: function (record) {                         
                        return filterString(#{CalcUnitFilter}.getValue(), "sm_CalcUnit", record);
                    }
                });

                 f.push({
                    filter: function (record) {                         
                        return filterString(#{BLStringFilter}.getValue(), "sm_BLString", record);
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
    <style type="text/css">
        .style2
        {
            width: 84px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <ext:ResourceManager runat="server" ID="ResouceID">
    </ext:ResourceManager>
    <div id="location_div01">
    <div id="countryControl" >
    <ext:Hidden ID="txtRowID" runat="server" Text="0"></ext:Hidden>
        <table  border="0'" cellpadding="0" cellspacing="0" class="table_25left">
            <tr>
                <td class="style2">
                    <table border="0" cellspacing="0" cellpadding="0">      
                        <tr>
                            <td class="font_11bold">
                                Code<span class="font_red" style="padding-left:2px">*</span> 
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="71">
                    <ext:TextField ID="txtCode" runat="server"  TabIndex="1"
                         AutoFocus="true" Cls="text_75px" AllowBlank="false" BlankText="Code can't be empty">
                         <Listeners>
                                <Blur Handler="checkCode('SERVICEMODE','txtCode',#{txtRowID}.getValue())" />
                                <KeyUp Handler="removeClass('txtCode')" />
                         </Listeners>
                    </ext:TextField>
                </td>
                <td width="37" style="padding-left: 10px">
                    <table width="70" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="font_11bold">
                               Description
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="82">
                    <ext:TextField ID="txtDes" runat="server" ClearCls="" Cls="text_75px" TabIndex="2">
                    </ext:TextField>
                </td>
                <td style="padding-left:5px; padding-right:5px">
                  Calc. BL by  
                </td>
                <td>
                <ext:Store runat="server" ID="Store1" >
<Reader>
 <ext:JsonReader>
   <Fields>
            <ext:RecordField Name="text" />
            <ext:RecordField Name="value" />
  </Fields>
 </ext:JsonReader>
</Reader>
</ext:Store>
<ext:ComboBox ID="CmbCalc"  TabIndex="3"
            runat="server" 
            StoreID="Store1" 
            DisplayField="value"
            ValueField="value"
            Mode="Local"
            width="71"
            Cls="select">
</ext:ComboBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    <table border="0" cellspacing="0" cellpadding="0" style="width: 94px">
                        <tr>
                            <td class="font_11bold">
                                Line Show on BL
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="3">
                   <ext:TextField ID="txtLine" runat="server"  Width="246px" Cls="text" TabIndex="4">
                    </ext:TextField></td>
                    <td style="padding-left:5px; padding-right:5px;display:none;">
                  Group  
                </td>
                <td>
                <ext:Store runat="server" ID="Store2" >
<Reader>
 <ext:JsonReader>
   <Fields>
            <ext:RecordField Name="text" />
            <ext:RecordField Name="value" />
  </Fields>
 </ext:JsonReader>
</Reader>
</ext:Store>
<ext:ComboBox ID="CmbGroup"  TabIndex="4" Hidden="true"
            runat="server" 
            StoreID="Store2" 
            DisplayField="value"
            ValueField="value"
            Mode="Local"
            width="71"
            Cls="select">
</ext:ComboBox>
                </td>
            </tr>
        </table>
        <div style="width: 482px; margin-top: 10px;">
            <div style="float: left; margin-top:2px">
                <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                </ext:CheckboxGroup>
            </div>
            <table border="0" cellpadding="0" cellspacing="0" align="right" style="float: right;">
             <tr>
                <td  align="right">
                    <ext:Checkbox ID="ChbActive" runat="server" Checked="true" TabIndex="5">
                    </ext:Checkbox>
                </td>
                <td class="font_11bold" >
                    Active
                </td>
                <td  align="center" style="padding-left: 5px">
                    <ext:Button ID="btnAddSave" runat="server" Text="Next" Cls="Submit_70px" Width="70px">
                        <DirectEvents>
                            <Click OnEvent="btnAddSave_Click">
                                <EventMask Msg="Saving..." ShowMask="true" />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                </td>
                <td align="center" style="padding-left:5px">
                    <ext:Button ID="btnCancel" Text="Cancel" runat="server" Cls="Submit_70px" Width="70px">
                        <Listeners>
                            <Click Handler="if(txtRowID.getValue()=='0' || txtRowID.getValue() == ''){txtCode.setValue('');txtLine.setValue('');txtDes.setValue('');CmbCalc.setValue('');CmbGroup.setValue('');return false; txtCode.focus(true)}" />
                        </Listeners>
                        <DirectEvents>
                            <Click OnEvent="btnCancel_Click">
                                <EventMask Msg="Loading..." ShowMask="true" />
                                <ExtraParams>
                                    <ext:Parameter Name="sm_ROWID" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.sm_ROWID" Mode="Raw" />
                                    <ext:Parameter Name="sm_CODE" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.sm_CODE" Mode="Raw" />
                                    <ext:Parameter Name="sm_Description" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.sm_Description" Mode="Raw" />
                                    <ext:Parameter Name="sm_CalcUnit" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.sm_CalcUnit" Mode="Raw" />
                                    <ext:Parameter Name="sm_BLString" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.sm_BLString" Mode="Raw" />
                                    <ext:Parameter Name="sm_Group" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.sm_Group" Mode="Raw" />
                                    <ext:Parameter Name="sm_Active" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.sm_Active" Mode="Raw" />
                                    <ext:Parameter Name="StatList" Value="#{GridPanel1}.getStore().getById(txtRowID.getValue()).data.StatList" Mode="Raw" />
                                </ExtraParams>
                            </Click>
                        </DirectEvents>                        
                    </ext:Button>
                </td>
                <td  align="center" style="padding-left:5px;padding-right: 5px">
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
        <table  border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table  border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 8px 0;">
                        <tr>
                            <td id="GridView">
                                <ext:Store ID="StoreService" runat="server">
                                    <Reader>
                                        <ext:JsonReader IDProperty="sm_ROWID">
                                            <Fields>
                                              <ext:RecordField Name="sm_ROWID" Type="Int">
                                                </ext:RecordField>
                                                <ext:RecordField Name="sm_CODE" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="sm_Description" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="sm_CalcUnit" Type="String">
                                                </ext:RecordField>
                                                 <ext:RecordField Name="sm_BLString" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="sm_Group" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="sm_Active" Type="Boolean">
                                                </ext:RecordField>
                                                <ext:RecordField Name="StatList" Type="String">
                                                </ext:RecordField>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                                <ext:GridPanel ID="GridPanel1" runat="server" Height="302" StoreID="StoreService"
                                    TrackMouseOver="true" StripeRows="true">
                                    <ColumnModel ID="ctlMSM33">
                                        <Columns>
                                            <ext:Column Header="Code" DataIndex="sm_CODE" Width="70">
                                            </ext:Column>
                                            <ext:Column Header="Description" DataIndex="sm_Description" Width="90">
                                            </ext:Column>
                                            <ext:Column Header="Calc. BL by" DataIndex="sm_CalcUnit" Width="72" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="Line Show on BL" DataIndex="sm_BLString" Width="180">
                                            </ext:Column>
                                            <ext:Column Header="Group" DataIndex="sm_Group" Width="45" Hidden="true">
                                            </ext:Column>
                                            <ext:CheckColumn Header="Active" DataIndex="sm_Active" Width="48">
                                            </ext:CheckColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                            <DirectEvents>
                                                <RowSelect OnEvent="row_Click">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="sm_ROWID" Value="record.data.sm_ROWID" Mode="Raw" />
                                                        <ext:Parameter Name="sm_CODE" Value="record.data.sm_CODE" Mode="Raw" />
                                                        <ext:Parameter Name="sm_Description" Value="record.data.sm_Description" Mode="Raw" />
                                                        <ext:Parameter Name="sm_CalcUnit" Value="record.data.sm_CalcUnit" Mode="Raw" />
                                                        <ext:Parameter Name="sm_BLString" Value="record.data.sm_BLString" Mode="Raw" />
                                                        <ext:Parameter Name="sm_Group" Value="record.data.sm_Group" Mode="Raw" />
                                                        <ext:Parameter Name="sm_Active" Value="record.data.sm_Active" Mode="Raw" />
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
                                                                <ext:TextField ID="DiscriptionFilter" runat="server" EnableKeyEvents="true">
                                                                    <Listeners>
                                                                        <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                    </Listeners>
                                                                </ext:TextField>
                                                            </Component>
                                                        </ext:HeaderColumn>
                                                        <ext:HeaderColumn Cls="x-small-editor">
                                                            <Component>
                                                                <ext:TextField ID="CalcUnitFilter" runat="server" EnableKeyEvents="true">
                                                                    <Listeners>
                                                                        <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                    </Listeners>
                                                                </ext:TextField>
                                                            </Component>
                                                        </ext:HeaderColumn>
                                                        <ext:HeaderColumn Cls="x-small-editor">
                                                            <Component>
                                                                <ext:TextField ID="BLStringFilter" runat="server" EnableKeyEvents="true">
                                                                    <Listeners>
                                                                        <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                    </Listeners>
                                                                </ext:TextField>
                                                            </Component>
                                                        </ext:HeaderColumn>
                                                         <ext:HeaderColumn Cls="x-small-editor">
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
        if (dept == 'OP' || dept == 'ACCOUNT' || sys == 'N') {
            DisableDIV();
            DisableCombox("CmbCalc");
        }
        SetWinSize();
    });
</script>
