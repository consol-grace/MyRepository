<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Salesman</title>
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
    <ext:XScript runat="server">
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
                #{CompanyFilter}.reset();
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
                        return filterString(#{DiscriptionFilter}.getValue(), "Name", record);
                    }
                });
                
                f.push({
                    filter: function (record) {                         
                        return filterString(#{CompanyFilter}.getValue(), "Company", record);
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
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
     <%--   <CustomDirectEvents>
            <ext:DirectEvent Target="Save" OnEvent="Binding" />
            <ext:DirectEvent Target="Next" OnEvent="Binding" />
        </CustomDirectEvents>--%>
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
     
        <div id="countryControl" >
            <table border="0" cellpadding="0" cellspacing="0" class="table_25left">
                <tr>
                    <td style="padding-left: 6px">
                        <table width="50" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Code<span class="font_red" style="padding-left: 2px">*</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <ext:TextField ID="Code" runat="server" TabIndex="1" Cls="text_75px" Width="100" AllowBlank="false" BlankText="Code can't be empty" AutoFocus="true">
                            <Listeners>
                                <Blur Handler="checkCode('SALESMAN','Code',#{hidRowID}.getValue())" />
                                <KeyUp Handler="removeClass('Code')" />
                            </Listeners>
                        </ext:TextField>
                        <ext:Hidden runat="server" ID="hidRowID" Text="0">
                        </ext:Hidden>
                    </td>
                    <td style="padding-left: 5px;">
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold" style="padding-right: 6px; text-align: left">
                                    Name
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <ext:TextField ID="Name" runat="server" TabIndex="2" Cls="text_75px" Width="200">
                        </ext:TextField>
                    </td>
                    <td style="padding-left: 10px;">
                        <table width="50" border="0" cellspacing="0" cellpadding="0" style="display: none">
                            <tr>
                                <td>
                                    <ext:Checkbox ID="chkUSGroup" runat="server" TabIndex="4" Checked="true" Width="28">
                                    </ext:Checkbox>
                                </td>
                                <td class="font_11bold" style="padding-top: 2px">
                                    USGroup
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="52" style="padding-left: 5px">
                        <table width="60" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="font_11bold">
                                    Belong to
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table width="120" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <uc1:UserComboBox runat="server" ID="Company" clsClass="select_160px" TabIndex="2"
                                        isButton="false" StoreID="StoreCompany" Width="100" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                        winWidth="800" winHeight="800"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
              </table>  
               <div style="width: 642px; margin-top: 10px;">  
                <div style="float: left; margin-top:2px">
                    <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                    </ext:CheckboxGroup>
                </div>
              <table border="0" style="float: right;" align="right" cellpadding="0" cellspacing="0">   
                <tr>
                    <td colspan="7" >
                        <table cellpadding="0" cellspacing="0" border="0" align="right">
                            <tr>
                                <td style="padding-right: 25px">
                                    <table width="50" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <ext:Checkbox ID="chkActive" runat="server" TabIndex="5" Checked="true" Width="28">
                                                </ext:Checkbox>
                                            </td>
                                            <td class="font_11bold" style="padding-top: 5px">
                                                Active
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
                                            <Click Handler="if(hidRowID.getValue()=='0'){Code.setValue('');Name.setValue('');Company.setValue(''); Code.focus(true);return false;}" />
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
                                <td style="padding-left: 2px">
                                    <ext:Button runat="server" ID="Save" Cls="Submit_70px" Text="Save" Width="70px">
                                        <Listeners>
                                            <Click Handler="return Validata('Code')" />
                                        </Listeners>
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
                    <table border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 8px 0;">
                        <tr>
                            <td id="GridView">
                                <ext:GridPanel ID="GridPanel1" runat="server" TrackMouseOver="true" StripeRows="true"
                                    Height="365" Width="642">
                                    <Store>
                                        <ext:Store ID="Store7" runat="server">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="Code" />
                                                        <ext:RecordField Name="Name" />
                                                        <ext:RecordField Name="Company" />
                                                        <ext:RecordField Name="USGroup" />
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
                                            <ext:Column DataIndex="Code" Header="Code" Width="120" />
                                            <ext:Column DataIndex="Name" Header="Name" Width="240" />
                                            <ext:CheckColumn DataIndex="USGroup" Header="USGroup" Width="60" Hidden="true" />
                                            <ext:Column DataIndex="Company" Header="Belong to" Width="180" />
                                         <%--   <ext:Column DataIndex="Active" Header="Active" Width="50" Align="Center" />--%>
                                           <ext:CheckColumn DataIndex="Active" Header="Active" Width="50" Align="Center" />
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                            <DirectEvents>
                                                <RowSelect OnEvent="Row_Select">
                                                    <ExtraParams>
                                                        <ext:Parameter Mode="Raw" Value="Ext.encode(record.json)" Name="rowdata">
                                                        </ext:Parameter>
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
                                                        </ext:HeaderColumn>
                                                        <ext:HeaderColumn Cls="x-small-editor">
                                                            <Component>
                                                                <ext:TextField ID="CompanyFilter" runat="server" EnableKeyEvents="true">
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
            DisableCombox("Company");
        }
        SetWinSize();
    });
</script>
