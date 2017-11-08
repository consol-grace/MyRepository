<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Country</title>
    <link href="../../css/style.css" rel="Stylesheet" type="text/css" />
    <link href="/common/ylQuery/ext-3.2.0/resources/css/ext-all.css" rel="stylesheet"
        type="text/css" />
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function TextFocus() {
            Ext.get("txtCode").focus();
        }
    </script>
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
                #{ShortFilter}.reset();
                #{DescriptionFilter}.reset();
                #{StoreDomestic}.clearFilter();
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
                        return filterString(#{CodeFilter}.getValue(), "dk_Code", record);
                    }
                });
                  
                f.push({
                    filter: function (record) {                         
                        return filterString(#{ShortFilter}.getValue(), "dk_Short", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{DescriptionFilter}.getValue(), "dk_Description", record);
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
        <div id="countryControl">
            <table width="425" border="0'" cellpadding="0" cellspacing="0" class="table_25left">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Code <span class="font_red" style="padding-left: 30px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <ext:TextField ID="txtCode" runat="server" TabIndex="1" AutoFocus="true" Cls="text_200px"
                            Height="16" Width="80" AllowBlank="false" BlankText="Code can't be empty">
                            <Listeners>
                                <Blur Handler="checkCode('DOMESTICSTATUS','txtCode',#{txtRowID}.getValue())" />
                                <KeyUp Handler="removeClass('txtCode')" />
                            </Listeners>
                        </ext:TextField>
                    </td>
                    <td width="37" style="padding-left: 15px">
                        <table width="36" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="41" class="font_11bold">
                                    Short<span class="font_red" style="padding-left: 2px; padding-right: 7px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="82">
                        <ext:TextField ID="txtShort" runat="server" Cls="text_200px" Width="80" Height="16"
                            TabIndex="2" AllowBlank="false" BlankText="Short can't be empty">
                        </ext:TextField>
                    </td>
                    <td width="226" style="padding-left: 20px">
                        <ext:Hidden ID="txtRowID" runat="server" Text="0">
                        </ext:Hidden>
                    </td>
                </tr>
                <tr>
                    <td width="55">
                        <table width="70" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Description<span class="font_red" style="padding-left: 2px; padding-right: 2px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td colspan="4">
                        <ext:TextField ID="txtDes" runat="server" Cls="text_200px" Width="220px" Height="16"
                            TabIndex="3" AllowBlank="false" BlankText="Description can't be empty">
                        </ext:TextField>
                    </td>
                </tr>
            </table>
            <div style="width: 465px; margin-top: 10px;">
                <div style="float: left; margin-top: 2px">
                    <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                    </ext:CheckboxGroup>
                </div>
                <table border="0" cellpadding="0" cellspacing="0" align="right" style="float: right;">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td align="right">
                                        <ext:Checkbox ID="ChbActive" runat="server" Checked="true" TabIndex="5" Width="28">
                                        </ext:Checkbox>
                                    </td>
                                    <td class="font_11bold" style="padding-left: 3px">
                                        Active
                                    </td>
                                    <td align="right" style="padding-left: 5px">
                                        <ext:Button ID="btnAddSave" runat="server" Text="Next" Cls="Submit_70px" Width="70px">
                                            <DirectEvents>
                                                <Click OnEvent="btnAddSave_Click">
                                                    <EventMask Msg="Saving..." ShowMask="true" />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td align="right" style="padding-left: 5px">
                                        <ext:Button ID="btnCancel" Text="Cancel" runat="server" Cls="Submit_70px" Width="70px">
                                            <Listeners>
                                                <Click Handler="if(txtRowID.getValue()=='0'){txtCode.setValue('');txtDes.setValue('');txtShort.setValue('');txtCode.focus(true);return false;}" />
                                                <Click />
                                            </Listeners>
                                            <DirectEvents>
                                                <Click OnEvent="btnCancel_Click">
                                                    <EventMask Msg="Loading..." ShowMask="true" />
                                                    <ExtraParams>
                                                        <ext:Parameter Name="rowdata" Value="Ext.encode(#{GridPanel1}.getStore().getById(txtRowID.getValue()).json)"
                                                            Mode="Raw">
                                                        </ext:Parameter>
                                                    </ExtraParams>
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td align="right" style="padding-left: 5px; padding-right: 5px">
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
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table border="0" cellspacing="0" cellpadding="0" style="margin: 12px 0 8px 0;">
                        <tr>
                            <td id="GridView">
                                <ext:Store ID="StoreDomestic" runat="server">
                                    <Reader>
                                        <ext:JsonReader IDProperty="dk_ROWID">
                                            <Fields>
                                                <ext:RecordField Name="dk_Code" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="dk_Short" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="dk_Description" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="dk_Active" Type="Boolean">
                                                </ext:RecordField>
                                                <ext:RecordField Name="StatList" Type="String">
                                                </ext:RecordField>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                                <ext:GridPanel ID="GridPanel1" runat="server" Height="302" Width="465" StoreID="StoreDomestic"
                                    TrackMouseOver="true" StripeRows="true">
                                    <ColumnModel ID="ctlM33">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Code" DataIndex="dk_Code" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="Short" DataIndex="dk_Short" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="Description" DataIndex="dk_Description" Width="200">
                                            </ext:Column>
                                            <ext:CheckColumn Header="Active" DataIndex="dk_Active" Width="50">
                                            </ext:CheckColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                            <DirectEvents>
                                                <RowSelect OnEvent="row_Click">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="rowdata" Value="Ext.encode(record.json)" Mode="Raw" />
                                                    </ExtraParams>
                                                    <EventMask ShowMask="true" Msg="Loading..." />
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
                                                                <ext:TextField ID="ShortFilter" runat="server" EnableKeyEvents="true">
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
        }
        SetWinSize();
    });
</script>
