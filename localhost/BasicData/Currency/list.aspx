<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Currency_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Currency</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>

    <link href="../../common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/ylQuery.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script type="text/javascript" src="Controller.js"></script>

    <script src="../AjaxServer/CheckField.js" type="text/javascript"></script>
    <style type="text/css">
        #ChkGrpStat label {
            margin-right: 8px;
        }

        #ChkGrpStat input {
            margin-right: 3px;
            width: 12px;
            height: 12px;
            vertical-align: middle;
        }

        .x-form-cb-label {
            margin-left: 1px !important;
        }

        .x-column {
            float: left;
        }

        #ChkGrpStat .x-form-check-wrap {
            padding-top: 7px;
        }
    </style>

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
            #{DescriptionFilter}.reset();
            #{CountryFilter}.reset();
            #{RateFilter}.reset();
            #{SellFilter}.reset();
            #{BuyFilter}.reset();
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
                    return filterString(#{DescriptionFilter}.getValue(), "Description", record);
                }
            });

            f.push({
                filter: function (record) {                         
                    return filterString(#{CountryFilter}.getValue(), "Country", record);
                }
            });

            f.push({
                filter: function (record) {                         
                    return filterString(#{RateFilter}.getValue(), "Rate", record);
                }
            });
                  
            f.push({
                filter: function (record) {                         
                    return filterString(#{SellFilter}.getValue(), "Sell", record);
                }
            });

            f.push({
                filter: function (record) {                         
                    return filterString(#{BuyFilter}.getValue(), "Buy", record);
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
        <div id="location_div01" style="width: 623px; height: inherit;">
            <div id="countryControl" runat="server" style="float: left;">
                <table border="0" cellpadding="0" cellspacing="0" class="table_25left" width="620px">
                    <tr>
                        <td style="padding-right: 8px">
                            <table width="35" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">Code<span class="font_red" style="padding-left: 2px">*</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:TextField ID="Code" AllowBlank="false" runat="server" Cls="text_80px" TabIndex="1"
                                MaxLength="3">
                            </ext:TextField>
                            <ext:Hidden ID="hidRowID" runat="server" Text="0">
                            </ext:Hidden>
                        </td>
                        <td style="padding-left: 10px">
                            <table width="68" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">Description
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="100">
                            <ext:TextField ID="Description" runat="server" Cls="text_160px" TabIndex="2" Width="120"
                                MaxLength="20">
                            </ext:TextField>
                        </td>
                        <td width="62" style="padding-left: 10px">
                            <table width="50" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">Country
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:ComboBox ID="Country" runat="server" Cls="select_160px" TabIndex="3" Mode="Local"
                                DisplayField="value" ValueField="value" Width="95">
                                <Store>
                                    <ext:Store runat="server" ID="cmbCountry">
                                        <Reader>
                                            <ext:JsonReader>
                                                <Fields>
                                                    <ext:RecordField Name="text">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="value">
                                                    </ext:RecordField>
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                            </ext:ComboBox>
                        </td>
                        <td>Local
                        </td>
                        <td>
                            <ext:Checkbox ID="chkLocal" runat="server" TabIndex="7">
                                <%-- <Listeners>
                                <Check Handler="if(this.checked==true){#{Checkforeign}.setValue(false)}" />
                            </Listeners>--%>
                            </ext:Checkbox>
                        </td>
                    </tr>
                    <tr>
                        <td width="35">
                            <table width="35" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">Rate
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="80">
                            <ext:NumberField ID="txtRate" runat="server" Cls="text_80px" TabIndex="4" DecimalPrecision="3"
                                StyleSpec="text-align:right">
                                <Listeners>
                                    <Blur Handler="ChangeValue()" />
                                </Listeners>
                            </ext:NumberField>
                        </td>
                        <td width="78" style="padding-left: 10px">
                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">Sell
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:NumberField ID="txtSell" runat="server" Cls="text_80px" TabIndex="5" DecimalPrecision="3"
                                Width="120" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td style="padding-left: 10px">
                            <table width="50" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="font_11bold">Buy
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <ext:NumberField ID="txtBuy" runat="server" Cls="text_80px" Width="95" TabIndex="6"
                                DecimalPrecision="3" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td>Foreign
                        </td>
                        <td>
                            <ext:Checkbox ID="Checkforeign" runat="server" TabIndex="8" Checked="true">
                                <%-- <Listeners>
                                <Check Handler="if(this.checked==true){#{chkLocal}.setValue(false)}" />
                            </Listeners>--%>
                            </ext:Checkbox>
                        </td>
                    </tr>
                </table>
                <div style="float: left;">
                    <%--<asp:CheckBoxList ID="ChkGrpStat" runat="server" RepeatDirection="Horizontal">
                        </asp:CheckBoxList>--%>

                    <ext:CheckboxGroup ID="ChkGrpStat" runat="server">
                    </ext:CheckboxGroup>

                </div>
                <table border="0" cellpadding="0" cellspacing="0" style="float: right; margin-right: 2px;">
                    <tr>
                        <td colspan="5" align="right" height="8"></td>
                    </tr>
                    <tr>
                        <td width="15" align="right">&nbsp;
                        </td>
                        <td align="right">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="padding-right: 10px">
                                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td class="font_11bold">
                                                    <ext:Checkbox ID="chkActive" runat="server" Checked="true" TabIndex="9" Width="23">
                                                    </ext:Checkbox>
                                                </td>
                                                <td class="font_11bold">Active
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <ext:Button runat="server" ID="Next" Cls="Submit_70px" Text="Next" Width="70px">
                                            <DirectEvents>
                                                <Click OnEvent="btnNext_Click">
                                                    <EventMask ShowMask="true" Msg="Saving..." />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td style="padding-left: 2px">
                                        <ext:Button runat="server" ID="Cancel" Cls="Submit_70px" Text="Cancel" Width="70px">
                                            <Listeners>
                                                <Click Handler="if(hidRowID.getValue()=='0'){return false; Code.focus(true);}" />
                                            </Listeners>
                                            <DirectEvents>
                                                <Click OnEvent="btnCancel_Click">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="rowdata" Value="Ext.encode(#{GridPanel1}.getStore().getById(hidRowID.getValue()).json)"
                                                            Mode="Raw">
                                                        </ext:Parameter>
                                                    </ExtraParams>
                                                    <EventMask ShowMask="true" Msg="Loading..." />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </td>
                                    <td style="padding-left: 2px">
                                        <ext:Button runat="server" ID="Save" Cls="Submit_70px" Text="Save" Width="70px">
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
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="12"></td>
                            </tr>
                        </table>
                        <table border="0" cellspacing="0" cellpadding="0" style="margin-bottom:8px;">
                            <tr>
                                <td id="grid">
                                    <ext:GridPanel ID="GridPanel1" runat="server" StripeRows="true" Width="620" Height="282"
                                        AutoExpandColumn="Code">
                                        <ColumnModel ID="ColumnModel1" StopIDModeInheritance="False">
                                            <Columns>
                                                <ext:RowNumbererColumn Header="No." Width="30">
                                                </ext:RowNumbererColumn>
                                                <ext:Column DataIndex="Code" Header="Code" Width="80">
                                                </ext:Column>
                                                <ext:Column DataIndex="Description" Header="Description" Width="200">
                                                </ext:Column>
                                                <ext:Column Align="Center" DataIndex="Country" Header="Country" Width="60">
                                                </ext:Column>
                                                <ext:NumberColumn DataIndex="Rate" Header="Rate" Width="60" Align="Right" Format="0.000">
                                                </ext:NumberColumn>
                                                <ext:NumberColumn DataIndex="Sell" Header="Sell" Width="60" Align="Right" Format="0.000">
                                                </ext:NumberColumn>
                                                <ext:NumberColumn DataIndex="Buy" Header="Buy" Width="60" Align="Right" Format="0.000">
                                                </ext:NumberColumn>
                                                <ext:CheckColumn DataIndex="Active" Header="Active" Width="48">
                                                </ext:CheckColumn>
                                            </Columns>
                                        </ColumnModel>
                                        <Store>
                                            <ext:Store ID="Store7" runat="server" SerializationMode="Simple" StopIDModeInheritance="False">
                                                <Reader>
                                                    <ext:JsonReader IDProperty="RowID">
                                                        <Fields>
                                                            <ext:RecordField Name="Code">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="Description">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="Country">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="Rate" Type="String">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="Sell" Type="String">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="Buy" Type="String">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="f">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="l">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="Active">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="StatList"></ext:RecordField>
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                        </Store>
                                        <LoadMask Msg=" Loading..." ShowMask="True" />
                                        <SelectionModel>
                                            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="True"
                                                StopIDModeInheritance="False">
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
                                                                    <ext:TextField ID="DescriptionFilter" runat="server" EnableKeyEvents="true">
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
                                                                    <ext:TextField ID="RateFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="SellFilter" runat="server" EnableKeyEvents="true">
                                                                        <Listeners>
                                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                                        </Listeners>
                                                                    </ext:TextField>
                                                                </Component>
                                                            </ext:HeaderColumn>
                                                            <ext:HeaderColumn Cls="x-small-editor">
                                                                <Component>
                                                                    <ext:TextField ID="BuyFilter" runat="server" EnableKeyEvents="true">
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
    <script type="text/javascript">
        Ext.onReady(function () {
         
            SetWinSize();
        });
    </script>

</body>
</html>
