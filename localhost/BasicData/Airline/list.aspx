<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Airline</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .cb-cell td
        {
            padding-right: 20px;
        }
    </style>
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
                #{NameFilter}.reset();
                #{CountryFilter}.reset();
                #{CallSignFilter}.reset();
                #{Store7}.clearFilter();
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
                        return filterString(#{CodeFilter}.getValue(), "Code", record);
                    }
                });
                  
                f.push({
                    filter: function (record) {                         
                        return filterString(#{NameFilter}.getValue(), "Name", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{CountryFilter}.getValue(), "Country", record);
                    }
                });
               
                f.push({
                    filter: function (record) {                         
                        return filterString(#{CallSignFilter}.getValue(), "CallSign", record);
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
    <%--    <CustomDirectEvents>在点击save或者next会先进入Binding事件
            <ext:DirectEvent Target="Save" OnEvent="Binding" />
            <ext:DirectEvent Target="Next" OnEvent="Binding" />
        </CustomDirectEvents>--%>
    </ext:ResourceManager>
    <div id="location_div01">
        <div id="countryControl">
            <table width="510" border="0" cellpadding="0" cellspacing="0" class="table_25left">
                <tr>
                    <td style="padding-left: 6px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Code<span class="font_red" style="padding-left:10px;">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td colspan="2" style="padding-left:2px;">
                        <ext:TextField ID="Code" runat="server" Cls="text_110px" TabIndex="1" AllowBlank="false" BlankText="Code can't be empty" AutoFocus="true">
                             <Listeners>
                                <Blur Handler="checkCode('AIRLINE','Code',#{hidRowID}.getValue())" />
                                <KeyUp Handler="removeClass('Code')" />
                            </Listeners>
                        </ext:TextField>
                        <ext:Hidden runat="server" ID="hidRowID" Text="0">
                        </ext:Hidden>
                    </td>
                    <td style="padding-left: 10px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Name
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="175">
                        <ext:TextField ID="Name" runat="server" Cls="text_110px" TabIndex="2">
                        </ext:TextField>
                    </td>
                    <td width="136" style="padding-left: 30px">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td width="50" style="padding-left: 6px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Country
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="75">                        
                        <ext:ComboBox ID="Country" runat="server" Cls="select_160px" Width="117" TabIndex="2" Mode="Local" DisplayField="value"  ValueField="value">
                            <Store>
                                <ext:Store runat="server" ID="storeCountry">
                                    <Reader>
                                        <ext:JsonReader>
                                            <Fields>
                                                <ext:RecordField Name="value"></ext:RecordField>
                                                <ext:RecordField Name="text"></ext:RecordField>
                                            </Fields>                                            
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>
                        </ext:ComboBox>
                        
                    </td>
                    <td style="width: 20px;">
                    </td>
                    <td width="60" style="padding-left: 10px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Call Sign
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td colspan="2">
                        <ext:TextField ID="txtCallSign" runat="server" Cls="text_110px" TabIndex="4">
                        </ext:TextField>
                    </td>
                </tr>
            </table>
             <div style="width: 510px; margin-top: 10px;">
                <div style="float: left; margin-top:2px">
                    <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                    </ext:CheckboxGroup>
                </div>
                <table border="0" cellpadding="0" cellspacing="0" style="float: right;">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0" align="right">
                            <tr>
                                <td width="15">
                                    <ext:Checkbox runat="server" ID="chkActive" Checked="true" HideLabel="true" Width="25" TabIndex="5" />
                                </td>
                                <td width="20" class="font_11bold">
                                    Active
                                </td>
                                <td style="padding-left: 5px">
                                    <ext:Button runat="server" ID="Next" Cls="Submit_70px" Text="Next" Width="70px">
                                        <DirectEvents>
                                            <Click OnEvent="btnNext_click">
                                                <EventMask ShowMask="true" Msg=" Saving... " />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td style="padding-left: 5px">
                                    <ext:Button runat="server" ID="Cancel" Cls="Submit_70px" Text="Cancel" Width="70px">
                                        <Listeners>
                                            <Click Handler="if(hidRowID.getValue()=='0'){Code.setValue('');Name.setValue('');Country.setValue('');txtCallSign.setValue('');return false; Code.focus(true)}" />
                                        </Listeners>
                                        <DirectEvents>
                                            <Click OnEvent="btnCancel_Click">
                                                <EventMask ShowMask="true" Msg="Loading..." />
                                                <ExtraParams>
                                                    <ext:Parameter Name="rowdata" Value="Ext.encode(#{GridPanel1}.getStore().getById(hidRowID.getValue()).json)"
                                                        Mode="Raw">
                                                    </ext:Parameter>
                                                </ExtraParams>
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td style="padding-left: 5px; padding-right: 5px">
                                    <ext:Button runat="server" ID="Save" Cls="Submit_70px" Text="Save" Width="70px">
                                        <DirectEvents>
                                            <Click OnEvent="btnSave_click">
                                                <EventMask ShowMask="true" Msg=" Saving... " />
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
                    <table border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 8px 0;">
                        <tr>
                            <td id="GridView">
                                <ext:GridPanel ID="GridPanel1" runat="server" StripeRows="true" Height="386" Width="510"
                                    AutoExpandColumn="Code">
                                    <Store>
                                        <ext:Store ID="Store7" runat="server">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="Code" />
                                                        <ext:RecordField Name="Name" />
                                                        <ext:RecordField Name="Country" />
                                                        <ext:RecordField Name="CallSign" />
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
                                            <ext:Column DataIndex="Code" Header="Code" Width="80" Align="Left" />
                                            <ext:Column DataIndex="Name" Header="Name" Width="200" />
                                            <ext:Column DataIndex="Country" Header="Country" Width="60" Align="Center" />
                                            <ext:Column DataIndex="CallSign" Header="Call Sign" Width="80" Align="Center" />
                                            <ext:CheckColumn DataIndex="Active" Header="Active" Width="48" Align="Center" />
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                            <DirectEvents>
                                                <RowSelect OnEvent="Row_Select">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="rowdata" Value="Ext.encode(record.json)" Mode="Raw">
                                                        </ext:Parameter>
                                                    </ExtraParams>
                                                    <EventMask ShowMask="true" Msg=" Loading... " />
                                                </RowSelect>
                                            </DirectEvents>
                                            <Listeners>
                                                <RowSelect Handler="getRowIndex(rowIndex)" />
                                            </Listeners>
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
                                                        <ext:TextField ID="NameFilter" runat="server" EnableKeyEvents="true">
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
                                                        <ext:TextField ID="CallSignFilter" runat="server" EnableKeyEvents="true">
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
        var dept = "<%=userDept %>";
        var sys = "<%=stationSys %>";
        if (dept == 'OP' || dept == 'ACCOUNT' || sys == 'N') {
            DisableDIV();
            DisableCombox("Country");
        }

        SetWinSize();
    });
</script>