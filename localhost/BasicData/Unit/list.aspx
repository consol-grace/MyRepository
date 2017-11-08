<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Country</title>
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
                #{ShortFilter}.reset();
                #{DescriptionFilter}.reset();
                #{ctl93}.clearFilter();
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
                        return filterString(#{EDIFilter}.getValue(), "EDI", record);
                    }
                });
                  
                f.push({
                    filter: function (record) {                         
                        return filterString(#{ShortFilter}.getValue(), "Short", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{DescriptionFilter}.getValue(), "Description", record);
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
        <%--<CustomDirectEvents>
            <ext:DirectEvent OnEvent="Binding" Target="Save" />
            <ext:DirectEvent OnEvent="Binding" Target="Next" />
        </CustomDirectEvents>--%>
    </ext:ResourceManager>
    <div id="location_div01">
        <div id="countryControl">
            <table border="0" cellpadding="0" cellspacing="0" class="table_25left">
                <tr>
                    <td style="padding-left: 5px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Code<span class="font_red" style="padding-left: 2px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="72">
                        <ext:TextField ID="Code" AllowBlank="false" runat="server" Cls="text_80px" TabIndex="1" MaxLength="4" BlankText="Code can't be empty" AutoFocus="true">
                            <Listeners>
                                <Blur Handler="checkCode('UNIT','Code',#{hidRowID}.getValue())" />
                                <KeyUp Handler="removeClass('Code')" />
                            </Listeners>
                        </ext:TextField>
                        <ext:Hidden runat="server" ID="hidRowID" Text="0">
                        </ext:Hidden>
                    </td>
                    <td width="40" style="padding-left: 15px">
                        <table width="30" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                <table width="46px"><tr><td>Short<span class="font_red" style="padding-left: 2px">*</span></td></tr></table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="80">
                        <ext:TextField AllowBlank="false" ID="Short" runat="server" Cls="text_80px" Width="100" TabIndex="2" BlankText="Short can't be empty" >
                        </ext:TextField>
                    </td>
                     <td width="40" style="padding-left: 15px">
                        <table width="30" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                <table width="46px"><tr><td>EDI<span class="font_red" style="padding-left: 2px">*</span></td></tr></table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="155" style="">
                        <ext:TextField AllowBlank="false" ID="txtEDI" runat="server" Cls="text_80px" Width="81" TabIndex="2" MaxLength="4" BlankText="EDI can't be empty" >
                        </ext:TextField>
                    </td>
                </tr>
                <tr>
                    <td width="62" style="padding-left: 5px">
                        <table width="70" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Description
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td colspan="6">
                        <ext:TextField ID="Description" runat="server" Cls="text_80px" TabIndex="3" Width="390px">
                        </ext:TextField>
                    </td>
                </tr>
            </table>
            <div style="width: 467px; margin-top: 10px;">
                <div style="float: left; margin-top:2px">
                    <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                    </ext:CheckboxGroup>
                </div>
            <table border="0" cellpadding="0" cellspacing="0" style="float: right;">
                <tr>
                    <td >
                        <table align="right">
                            <tr>
                                <td width="15" valign="top" align="right">
                                    <ext:Checkbox ID="chkActive" runat="server" Checked="true" HideLabel="true" TabIndex="4"
                                        Width="25">
                                    </ext:Checkbox>
                                </td>
                                <td width="20" align="left" class="font_11bold">
                                    Active
                                </td>
                                <td style="padding-left: 5px">
                                    <ext:Button runat="server" ID="Next" Cls="Submit_60px" Text="Next" Width="60px" >
                                        <DirectEvents>
                                            <Click OnEvent="btnNext_Click">
                                                <EventMask ShowMask="true" Msg="Saving..." />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td style="padding-left: 5px">
                                    <ext:Button runat="server" ID="Cancel" Cls="Submit_60px" Text="Cancel" Width="60px">
                                        <Listeners>
                                            <Click Handler="if(hidRowID.getValue()=='0'){Code.setValue('');Short.setValue('');Description.setValue('');return false; Code.focus(true);}" />
                                            <Click  />
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
                                <td style="padding-left: 5px;">
                                    <ext:Button runat="server" ID="Save" Cls="Submit_60px" Text="Save" Width="60px">
                                        <DirectEvents>
                                            <Click OnEvent="btnSave_Click">
                                                <EventMask ShowMask="true" Msg="Saving..." />
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
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="8">
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellspacing="0" cellpadding="0" width="467" style="margin:8px 0px 8px 0;">
                        <tr>
                            <td id="GridView">
                                <ext:GridPanel ID="GridPanel1" runat="server" StripeRows="true" Height="343" Width="465"  AutoExpandColumn="Description">
                                    <Store>
                                        <ext:Store runat="server" ID="ctl93">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="Code" />
                                                        <ext:RecordField Name="EDI" />
                                                        <ext:RecordField Name="Short" />
                                                        <ext:RecordField Name="Description" />
                                                        <ext:RecordField Name="Active" />
                                                        <ext:RecordField Name="StatList" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel runat="server" ID="ctl94">
                                        <Columns>
                                            <ext:RowNumbererColumn Width="30" Header="No." />
                                            <ext:Column DataIndex="Code" Header="Code" Width="70" />
                                            <ext:Column DataIndex="EDI" Header="EDI" Width="70" />
                                            <ext:Column DataIndex="Short" Header="Short" Width="72" />
                                            <ext:Column DataIndex="Description" Header="Description" Width="150" />
                                            <ext:CheckColumn DataIndex="Active" Header="Active" Width="50" Align="Center" />
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                            <DirectEvents>
                                                <RowSelect OnEvent="Row_Select">
                                                    <EventMask ShowMask="true" Msg="Loading..." />
                                                    <ExtraParams>
                                                        <ext:Parameter Mode="Raw" Name="rowdata" Value="Ext.encode(record.json)">
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
                                                        <ext:TextField ID="EDIFilter" runat="server" EnableKeyEvents="true">
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
                                    <LoadMask ShowMask="true" Msg="Loading..." AutoDataBind="true" />
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
        var userStat = "<%=userStat %>";
        if ((dept == 'OP' || dept == 'ACCOUNT' || sys == 'N') && userStat !="CON/HKG") {
            DisableDIV();
        }
        SetWinSize();
    });
</script>