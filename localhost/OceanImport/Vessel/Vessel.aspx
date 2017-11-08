<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vessel.aspx.cs" Inherits="OceanExport_Vessel" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/ylQuery.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
 
    <ext:XScript ID="XScript1" runat="server">
    <script  type="text/javascript">
         var applyFilter = function (field) {                
                var store = #{gridList}.getStore();
                store.suspendEvents();
                store.filterBy(getRecordFilter());                                
                store.resumeEvents();
                #{gridList}.getView().refresh(false);
            };
             
            var clearFilter = function () {
                #{VesselFilter}.reset();
                #{VoyageFilter}.reset();
                 
                #{storeList}.clearFilter();
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
                        return filterString(#{VesselFilter}.getValue(), "Vessel", record);
                    }
                });
                 
                f.push({
                    filter: function (record) {                         
                        return filterString(#{VoyageFilter}.getValue(), "Voyage", record);
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

    <script type="text/javascript">
       
        function windowshow() {
            //this.parent.winShow.reload();
            try {
                this.parent.winShow.setWidth(710);
                this.parent.winShow.setHeight(375);
            }
            catch (ex) {
            }
        }

       
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" >
    </ext:ResourceManager>
    <ext:Store runat="server" ID="StoreCompany" OnRefreshData="StoreCompany_OnRefreshData">
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
        <table cellpadding="0" cellspacing="0" border="0" width="500" style="margin:8px 0 0 0;">
            <tr>
                <td width="252px" valign="top" id="GridView">
                    <ext:GridPanel ID="gridList" runat="server" TrackMouseOver="true" StripeRows="true" width="224px"
                        height="282px">
                        <LoadMask ShowMask="true" Msg=" Loading..." />
                        <Store>
                            <ext:Store runat="server" ID="storeList" AutoLoad="true" OnRefreshData="storeList_OnRefreshData">
                                <AutoLoadParams>
                                    <ext:Parameter Name="start" Value="={0}" />
                                    <ext:Parameter Name="limit" Value="={100}" />
                                </AutoLoadParams>
                                <Reader>
                                    <ext:JsonReader IDProperty="vs_RowID">
                                        <Fields>
                                            <ext:RecordField Name="Vessel" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Voyage" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="RowID" Type="String">
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
                                <ext:Column Header="Vessel" DataIndex="Vessel" Width="110">
                                </ext:Column>
                                <ext:Column Header="Voyage" DataIndex="Voyage" Width="65">
                                </ext:Column>
                                <ext:Column Width="28" DataIndex="Vessel" Sortable="false" MenuDisabled="true" Header="&nbsp;"
                                    Fixed="true">
                                    <Renderer Handler="return '';" />
                                </ext:Column>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="RowSelectionModel1" SingleSelect="true">
                                <DirectEvents>
                                    <RowSelect OnEvent="row_Click">
                                        <ExtraParams>
                                            <ext:Parameter Name="vs_RowID" Value="this.getSelected().id" Mode="Raw" />
                                            <ext:Parameter Name="RowID" Value="record.data.RowID" Mode="Raw" />
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
                                                <Component>
                                                    <ext:TextField ID="VesselFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="VoyageFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn AutoWidthElement="false">
                                                <Component>
                                                    <ext:Button ID="ClearFilterButton" runat="server" Icon="Cancel">
                                                        <ToolTips>
                                                            <ext:ToolTip ID="ToolTip1" runat="server" Html="Clear filter" />
                                                        </ToolTips>
                                                        <Listeners>
                                                            <Click Handler="clearFilter(null);" />
                                                        </Listeners>
                                                    </ext:Button>
                                                </Component>
                                            </ext:HeaderColumn>
                                        </Columns>
                                    </ext:HeaderRow>
                                </HeaderRows>
                            </ext:GridView>
                        </View>
                        <BottomBar>
                <ext:PagingToolbar PageSize="100" DisplayInfo="false" ID="PagingToolbar1" runat="server" HideRefresh="true">
                </ext:PagingToolbar>
            </BottomBar>
                    </ext:GridPanel>
                </td>
                <td width="248" valign="top" style="padding-left: 5px">
                    <div id="countryControl">
                    <table width="300" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td colspan="3">
                                <table width="100%" border="0" cellpadding="0" cellspacing="1" class="x-toolbar"
                                    style="border: solid 1px #8DB2E3; height: 18px;">
                                    <tr>
                                        <td class="font_11bold_1542af" style="padding-left: 5px; line-height: 18px; font-weight: bold">
                                            Vessel
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="5" colspan="3">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table width="310" border="0" cellpadding="0" cellspacing="3">
                                    <tr>
                                        <td width="100" style="padding-left: 4px" class="font_11bold">
                                            Vessel<span class="font_red" style="padding-left: 2px">*</span>
                                        </td>
                                        <td colspan="3">
                                            <ext:TextField ID="txtVessel" runat="server" Cls="text_160px" Width="132" TabIndex="1">
                                            </ext:TextField>
                                            <ext:Hidden ID="hidVesselID" runat="server">
                                            </ext:Hidden>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="font_11bold" style="padding-left: 4px">
                                            Carrier
                                        </td>
                                        <td width="85">
                                            <uc1:UserComboBox runat="server" ID="CmbCarrier" TabIndex="2" clsClass="select" isButton="false"
                                                StoreID="StoreCompany" Width="132" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800"  />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="10" colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td width="211" align="right" style="padding-right: 2px">
                            <div style="width: 411px; margin-top: 5px;">
                <div style="float: left; margin-top:2px">
                    <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                    </ext:CheckboxGroup>
                </div>
                                <table  border="0" style="float: right;" align="right" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="right">
                                            <ext:Checkbox ID="chkActive" Checked="true" runat="server" TabIndex="3">
                                            </ext:Checkbox>
                                        </td>
                                        <td align="left" style="padding-right: 10px">
                                            Active
                                        </td>
                                        <td>
                                            <ext:Button ID="btnAddSave" runat="server" Cls="Submit_65px" Text="New" Width="65"
                                                TabIndex="4">
                                                <DirectEvents>
                                                    <Click OnEvent="btnAddSave_Click">
                                                        <EventMask ShowMask="true" Msg=" Saving..." />
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                        <td>
                                            <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Text="Cancel" Width="65"
                                                TabIndex="5">
                                                <DirectEvents>
                                                    <Click OnEvent="btnCancel_Click">
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                        <td>
                                            <ext:Button ID="btnSave" runat="server" Cls="Submit_65px" Text="Save" Width="65"
                                                TabIndex="6">
                                                <DirectEvents>
                                                    <Click OnEvent="btnSave_Click">
                                                        <EventMask ShowMask="true" Msg=" Saving..." />
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                    </tr>
                                </table>
                        </div>
                            </td>
                        </tr>
                        <tr>
                            <td height="5" colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table width="100%" border="0" cellpadding="0" cellspacing="1" class="x-toolbar"
                                    style="border: solid 1px #8DB2E3; height: 18px;">
                                    <tr>
                                        <td background="images/bg_line.jpg" class="font_11bold_1542af" style="padding-left: 5px;
                                            line-height: 18px; font-weight: bold">
                                            Voyage
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" height="5">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table width="380" border="0" cellpadding="0" cellspacing="4">
                                    <tr>
                                        <td width="88" class="font_11bold" style="padding-left: 4px">
                                            Voyage
                                        </td>
                                        <td width="13" class="font_11bold">
                                        </td>
                                        <td height="20" class="font_11px_gray" width="80px">
                                            <ext:Label runat="server" ID="lblVoyage">
                                            </ext:Label>
                                        </td>
                                        <td colspan="3">
                                            <ext:Button ID="btnNewVoyage" runat="server" Cls="Submit_65px" Text="New" Width="65"
                                                TabIndex="7">
                                                <DirectEvents>
                                                    <Click OnEvent="btnNewVoyage_Click">
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="font_11bold" style="padding-left: 4px">
                                            POL
                                        </td>
                                        <td class="font_11bold">
                                        </td>
                                        <td>
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td height="20" class="font_11px_gray">
                                                        <ext:Label runat="server" ID="lblPOL">
                                                        </ext:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="82" class="font_11bold">
                                            POD
                                        </td>
                                        <td width="6" class="font_11bold">
                                        </td>
                                        <td width="109">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11px_gray">
                                                        <ext:Label runat="server" ID="lblPOD">
                                                        </ext:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="font_11bold" style="padding-left: 4px">
                                            Onboard
                                        </td>
                                        <td class="font_11bold">
                                        </td>
                                        <td height="20" colspan="4" class="font_11px_gray">
                                            <ext:Label runat="server" ID="lblOnboard" Width="80">
                                            </ext:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="font_11bold" style="padding-left: 4px">
                                            ETD
                                        </td>
                                        <td class="font_11bold">
                                        </td>
                                        <td width="111" class="font_11px_gray">
                                            <ext:Label runat="server" ID="lblETD" Width="80">
                                            </ext:Label>
                                        </td>
                                        <td class="font_11bold">
                                            ETA
                                        </td>
                                        <td class="font_11bold">
                                        </td>
                                        <td width="109" class="font_11px_gray">
                                            <ext:Label runat="server" ID="lblETA" Width="80">
                                            </ext:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 4px">
                                            CFS Closing
                                        </td>
                                        <td class="font_11bold">
                                        </td>
                                        <td width="111" height="20" class="font_11px_gray">
                                            <ext:Label runat="server" ID="lblCFS" Width="80">
                                            </ext:Label>
                                        </td>
                                        <td class="font_11bold">
                                            CY Closing
                                        </td>
                                        <td class="font_11bold">
                                        </td>
                                        <td class="font_11px_gray">
                                            <ext:Label runat="server" ID="lblCY" Width="80">
                                            </ext:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        var h = $("#countryControl").height();
        Ext.getCmp("gridList").setHeight(h);
        var dept = "<%=userDept %>";
        var sys = "<%=stationSys %>";
        if (dept == 'OP' || dept == 'ACCOUNT' || sys == 'N') {
            DisableDIV();
            DisableCombox("CmbCarrier");
        }
        SetWinSize();
    });
</script>
