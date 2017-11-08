<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OceanShipmentHouse.aspx.cs"
    Inherits="OceanImport_OceanShipmentJobList_OceanShipmentHouse" %>

<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/Costing.ascx" TagName="Costing" TagPrefix="uc1" %>
 <%@ Register Src="../../common/UIControls/Transfer.ascx" TagName="Transfer"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>House</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../AjaxServer/gridHouse.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>
    <script src="../../OceanImport/AjaxServer/Valid.js" type="text/javascript"></script>
    <script type="text/javascript">
        function TextFocus() {
            Ext.get("txtHawb").focus();
        }
        var cmbStoreCompany = function(value) {
            var r = StoreCompany.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.text;
        };
        var cmbStoreForeignKind = function(value) {
            var r = StoreForeignKind.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.text;
        };
        var cmbStoreShipKind = function(value) {
            var r = StoreShipKind.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.text;
        };
        var cmbStoreCompanyKind = function(value) {
            var r = StoreCompanyKind.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.text;
        }
        var cmbStorePPCC = function(value) {
            var r = StorePPCC.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.text;
        }
        var cmbStoreItem = function(value) {
            var r = StoreItem.getById(value);
            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        }
        var ChangeValue = function(value) {
            return String.format("{0}", value + "%");
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_title" style="width: 100%; z-index: 1000;">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="O" />
    </div>
    <div id="div_title" style="margin-left: 10px; margin-top: 80px; z-index: 990;">
        <table width="980px" border="0" cellspacing="0" cellpadding="0" class="table_nav1 font_11bold_1542af">
            <tr>
                 <td style="padding-left:5px;">
                <table>
                <tr><td>
                <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                        alt="View" onclick="createFrom('OI');" />
                    &nbsp; OI - Shipment (House) Information &nbsp;
                    <img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle;
                        display: none;" />
                </td></tr></table>
                </td>
                 <td align="right" style="padding-right:5px;">
                <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                <td style="font-weight:bold">
                    MBL#
                </td>
                <td style="padding-left: 5px;">
                   <nobr> <ext:Label ID="labMBL" runat="server" StyleSpec=" color:#ff0000;">
                    </ext:Label></nobr>
                </td>
                <td style="padding-left: 5px; font-weight: bold">
                    <nobr>Lot#</nobr>
                </td>
                <td style="padding-left: 5px;">
                     <nobr><ext:Label runat="server" ID="labImpLotNo" StyleSpec=" color:#ff0000;">
                    </ext:Label></nobr>
                </td>
                <td>
                 <%if (!string.IsNullOrEmpty(Request["seed"]))
                 { %>
                  <uc1:Transfer runat="server" ID="TransferSys" sys="OI" type="H"/>
                   <%} %>
                  </td></tr>
                </table>
                </td>
            </tr>
        </table>
    </div>
    <ext:Store runat="server" ID="StoreAgentLocal">
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
    <ext:Store runat="server" ID="StorePPCC">
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
    <ext:Store runat="server" ID="StoreServiceMode" OnRefreshData="StoreServiceMode_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreLocation" OnRefreshData="StoreLocation_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreSalesman" OnRefreshData="StoreSalesman_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreUnit" OnRefreshData="StoreUnit_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreGetItem" OnRefreshData="StoreItem_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FCalcQty">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FMin">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FRate">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FAmount">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FCurrency">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FUnit">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FRound">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FMarkUp">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_FMarkDown">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LCalcQty">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LMin">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LRate">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LAmount">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LCurrency">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LUnit">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LRound">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LMarkUp">
                    </ext:RecordField>
                    <ext:RecordField Name="itm_LMarkDown">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreKind" OnRefreshData="StoreKind_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                    <ext:RecordField Name="unit">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreDept" OnRefreshData="StoreDept_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreForeignKind" OnRefreshData="StoreForeignKind_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreShipKind" OnRefreshData="StoreShipKind_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreCompanyKind" OnRefreshData="StoreCompanyKind_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreCurrInvoice" OnRefreshData="StoreCurrInvoice_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="code">
                <Fields>
                    <ext:RecordField Name="code">
                    </ext:RecordField>
                    <ext:RecordField Name="foreign">
                    </ext:RecordField>
                    <ext:RecordField Name="local">
                    </ext:RecordField>
                    <ext:RecordField Name="rate">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidMAWB" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="txtcur_Rate" runat="server">
    </ext:Hidden>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    <div style="margin-left: 10px; margin-top: 110px;">
        <table width="956" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="664" height="2">
                </td>
                <td width="301" rowspan="4" valign="top" align="left" style="padding-left: 1px">
                    <div id="div_top" style="margin-top: 116px">
                        <table width="301" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                            <tr>
                                <td width="301" class="font_11bold_1542af">
                                    &nbsp;&nbsp;Action
                                </td>
                            </tr>
                        </table>
                        <table width="260" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="88" class="table" style="padding-bottom: 5px; padding-top: 5px">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center">
                                                <ext:Button ID="btnNext" runat="server" Cls="Submit_65px" Width="65px" Text="Next">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnNext_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridPanelOther}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{GridPanelForeign}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{GridPanelRoute}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{GridPanelContact}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_6" Value="Ext.encode(#{GridPanelContainer}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_7" Value="Ext.encode(#{GridPanelInvoice}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                            </ExtraParams>
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="76" class="table">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" style="padding-left: 2px">
                                                <ext:Button ID="btnVoid" runat="server" Cls="Submit_65px" Width="65px" Text="Void">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnVoid_Click">
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="66" class="table">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" style="padding-left: 2px">
                                                <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Width="65px" Text="Cancel">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnCancel_Click">
                                                            <EventMask ShowMask="true" Msg=" Loading ... " />
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="100" class="table">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" style="padding-left: 2px">
                                                <ext:Button ID="btnSave" runat="server" Cls="Submit_65px" Width="65px" Text="Save">
                                                    <Listeners>
                                                        <Click Handler="return (ReturnNull()&&ValidataText());" />
                                                    </Listeners>
                                                    <DirectEvents>
                                                        <Click OnEvent="btnSave_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridPanelOther}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{GridPanelForeign}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{GridPanelRoute}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{GridPanelContact}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_6" Value="Ext.encode(#{GridPanelContainer}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_7" Value="Ext.encode(#{GridPanelInvoice}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                            </ExtraParams>
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
                    <div style="position: absolute; top: 185px">
                        <table width="303" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px">
                                    Storage Information
                                </td>
                            </tr>
                        </table>
                        <table width="292" border="0" cellpadding="0" cellspacing="4" class="select_142px">
                            <tr>
                                <td height="3" colspan="2">
                                </td>
                            </tr>
                            <tr valign="top">
                                <td width="70px" height="0" class="font_11bold" style="padding-left: 2px">
                                    WHSE
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0" width="210px">
                                        <tr>
                                            <td>
                                                <%--  <uc1:UserComboBox runat="server" ID="CmbWarehouse" clsClass="select_160px" TabIndex="26"
                                        StoreID="StoreCmb3" Width="146" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                        winWidth="800" winHeight="800" Query="option=CompanyList" /> --%>
                                                <uc1:AutoComplete runat="server" ID="CmbWarehouse" clsClass="x-form-text x-form-field text"
                                                    TabIndex="26" isAlign="false" Width="64" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" Query="option=CompanyList" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="0">
                                    <table width="75" border="0" cellpadding="3" cellspacing="0">
                                        <tr>
                                            <td class="font_11bold" style="padding-left: 3px">
                                                Free Storage
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td height="0">
                                    <table width="167" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="80">
                                                <ext:DateField ID="txtFreeStorageStart" runat="server" Width="91" Cls="text_80px"
                                                    Format="d/m/Y" TabIndex="27">
                                                    <DirectEvents>
                                                        <Blur OnEvent="txtFreeStoregeStart_Blur">
                                                        </Blur>
                                                    </DirectEvents>
                                                </ext:DateField>
                                            </td>
                                            <td width="12" align="center" style="padding-left: 1px; padding-right: 1px">
                                                -
                                            </td>
                                            <td width="60">
                                                <ext:DateField ID="txtFreeStorageEnd" runat="server" Width="91" Cls="text_80px" Format="d/m/Y"
                                                    TabIndex="27">
                                                </ext:DateField>
                                            </td>
                                            <td width="10">
                                                &nbsp;
                                            </td>
                                            <td width="70">
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="font_11bold" style="padding-left: 3px; padding-top: 2px" valign="top">
                                    Pickup
                                </td>
                                <td>
                                    <ext:DateField ID="txtPickUp" runat="server" Width="91" Cls="text_80px" Format="d/m/Y"
                                        TabIndex="28">
                                    </ext:DateField>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left: 3px">
                    <table border="0" cellpadding="0" cellspacing="0" width="673px">
                        <tr>
                            <td>
                                <table width="673" border="0" cellspacing="1" cellpadding="0" style="line-height: 22px">
                                    <tr>
                                        <td style="line-height: 12px; padding-left: 2px">
                                            Coloader HBL#
                                        </td>
                                        <td style="padding-right: 4px">
                                            <ext:TextField ID="txtColoader" runat="server" Cls="text" TabIndex="1" Width="85">
                                            </ext:TextField>
                                        </td>
                                        <td class="font_11bold">
                                            Reference#
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtReference" runat="server" Cls="text" TabIndex="2" Width="91">
                                            </ext:TextField>
                                        </td>
                                        <td class="font_11bold" style="padding-left: 3px; padding-right: 2px">
                                            Clearance#
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtClearance" runat="server" Cls="text" Width="90" TabIndex="3">
                                            </ext:TextField>
                                        </td>
                                        <td class="font_11bold" style="padding-left: 3px">
                                            D/O#
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtDO" Cls="text" Width="99px" runat="server" TabIndex="4">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="69px">
                                                <tr>
                                                    <td>
                                                        HBL#
                                                    </td>
                                                    <td class="font_red" align="right" style="padding-right:2px;" >
                                                        *
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="85">
                                            <ext:TextField ID="txtHawb" runat="server" Cls="text" AllowBlank="false" TabIndex="5"
                                                Width="85" EnableKeyEvents="true">
                                                 <Listeners>
                                                    <Blur Handler="validName(this.id,'HBL',#{hidSeed}.getValue());" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td>
                                            <table cellpadding="0" border="0" cellspacing="0" width="77">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Service Mode<span class="font_red" style="padding-left: 2px">*</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="CmbService" ListWidth="180" clsClass="select"
                                                            TabIndex="6" Query="option=ServerMode" StoreID="StoreServiceMode" Width="70"
                                                            winTitle="Service Mode" winUrl="/BasicData/ServiceMode/ServiceMode.aspx?sys=O"
                                                            winWidth="516" winHeight="585" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="63" class="font_11bold" style="padding-left: 3px">
                                            PPD/COL<span class="font_red" style="padding-left: 2px">*</span>
                                        </td>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">
                                                        <ext:ComboBox ID="CmbPPD" runat="server" Cls="select" DisplayField="text" TabIndex="7"
                                                            ForceSelection="true" Mode="Local" StoreID="StorePPCC" TriggerAction="All" ValueField="text"
                                                            Width="90">
                                                            <Template Visible="False" ID="Template1dd" StopIDModeInheritance="False" EnableViewState="False">
                                                            </Template>
                                                        </ext:ComboBox>
                                                    </td>
                                                    <td width="107">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" border="0" width="67">
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 3px">
                                                        Salesman <span class="font_red" style="padding-left: 2px; padding-right: 2px">*</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-right: 6px">
                                            <table width="100" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">
                                                        <uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="8" Query="option=SalesList"
                                                            Width="78" clsClass="select" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                            winWidth="680" winHeight="560" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="69px">
                                                <tr>
                                                    <td>
                                                        Receipt
                                                    </td>
                                                    <td class="font_red" align="right" style="padding-right:2px;">
                                                        *
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="85">
                                            <uc1:UserComboBox runat="server" ID="CmbReceipt" ListWidth="180" clsClass="select_160px"
                                                TabIndex="9" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="64"
                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                winHeight="620" />
                                        </td>
                                        <td width="64" class="font_11bold">
                                            <table cellpadding="0" cellspacing="0" border="0" width="85">
                                                <tr>
                                                    <td>
                                                        Final Dest.<span class="font_red" style="padding-left: 16px">*</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">
                                                        <uc1:UserComboBox runat="server" ID="CmbFinalDest" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="10" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="70"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                            winHeight="620" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td colspan="3">
                                            <table cellpadding="0" cellspacing="0" border="0" width="200">
                                                <tr>
                                                    <td>
                                                        <table border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td>
                                                                    <ext:Checkbox ID="chkInsurance" runat="server" Width="23" TabIndex="11">
                                                                    </ext:Checkbox>
                                                                </td>
                                                                <td class="font_11bold" align="left" style="padding-top: 4px">
                                                                    Insurance
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table border="0" cellspacing="0" cellpadding="0" style="padding-left: 12px">
                                                            <tr>
                                                                <td>
                                                                    <ext:Checkbox ID="chkDG" runat="server" Width="23" TabIndex="12">
                                                                    </ext:Checkbox>
                                                                </td>
                                                                <td class="font_11bold" style="padding-top: 4px">
                                                                    D/G
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table border="0" cellspacing="0" cellpadding="0" style="padding-left: 12px">
                                                            <tr>
                                                                <td>
                                                                    <ext:Checkbox ID="chkSurrender" runat="server" Width="23" TabIndex="13">
                                                                    </ext:Checkbox>
                                                                </td>
                                                                <td>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="90px">
                                                                        <tr>
                                                                            <td class="font_11bold" style="padding-top: 4px">
                                                                                Need Surrender
                                                                            </td>
                                                                        </tr>
                                                                    </table>
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
                                            <table width="69px">
                                                <tr>
                                                    <td>
                                                        Shipper
                                                    </td>
                                                    <td class="font_red" align="right" style="padding-right:2px;">
                                                        *
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td colspan="3">
                                            <table border="0" cellspacing="0" cellpadding="0" width="252">
                                                <tr>
                                                    <td>
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbShipperCode" TabIndex="14" clsClass="select"
                                                Query="option=CompanyList" StoreID="StoreCmb1" Width="87" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                                        <uc1:AutoComplete runat="server" ID="CmbShipperCode" TabIndex="14" clsClass="text input"
                                                            Query="option=CompanyList" Width="58" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td colspan="4" rowspan="5">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td align="left" valign="top" style="padding-top: 1px; padding-left: 3px">
                                                        Remark
                                                    </td>
                                                    <td height="3" valign="top" style="padding-top: 3px; padding-left: 20px">
                                                        <ext:TextArea ID="txtRemark" runat="server" StyleSpec="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; height:100px; width:257px;text-transform:capitalize"
                                                            TabIndex="20">
                                                        </ext:TextArea>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="69px">
                                                <tr>
                                                    <td>
                                                        Consignee
                                                    </td>
                                                    <td class="font_red" align="right" style="padding-right:2px;">
                                                        *
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td colspan="3">
                                            <table border="0" cellspacing="0" cellpadding="0" width="252">
                                                <tr>
                                                    <td>
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbConsignee" TabIndex="15" clsClass="select"
                                                Query="option=CompanyList" StoreID="StoreCmb1" Width="104" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbConsignee" TabIndex="15" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="58" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 2px">
                                            Notify #1
                                        </td>
                                        <td colspan="3">
                                            <table border="0" cellspacing="0" cellpadding="0" width="252">
                                                <tr>
                                                    <td>
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbNotify1" TabIndex="16" clsClass="select"
                                                    Query="option=CompanyList" StoreID="StoreCmb1" Width="87" winTitle="Company"
                                                    winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbNotify1" TabIndex="16" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="58" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="font_11bold" style="display: none">
                                            Co-Loader
                                        </td>
                                        <td colspan="3" style="display: none">
                                            <table border="0" cellspacing="0" cellpadding="0" width="250">
                                                <tr>
                                                    <td>
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbCoLoader" TabIndex="18" clsClass="select"
                                                    Query="option=CompanyList" StoreID="StoreCmb1" Width="87" winTitle="Company"
                                                    winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                                        <uc1:AutoComplete runat="server" ID="CmbCoLoader" TabIndex="18" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 2px">
                                            Notify #2
                                        </td>
                                        <td colspan="3">
                                            <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="85">
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbNotify2"  clsClass="select"
                                                    Query="option=CompanyList" StoreID="StoreCmb1" Width="104" winTitle="Company"
                                                    winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                                        <uc1:AutoComplete runat="server" ID="CmbNotify2" TabIndex="17" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="58" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 2px">
                                            Broker
                                        </td>
                                        <td colspan="3">
                                            <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="85">
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbBroker" TabIndex="19" clsClass="select" Query="option=CompanyList"
                                                    StoreID="StoreCmb1" Width="104" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" /> --%>
                                                        <uc1:AutoComplete runat="server" ID="CmbBroker" TabIndex="19" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="58" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                </tr>
                                            </table>
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
                </td>
            </tr>
        </table>
        <table width="973" border="0" cellspacing="0" cellpadding="0" style="padding-top: 5px">
            <tr>
                <td colspan="2" height="6">
                </td>
            </tr>
            <tr>
                <td width="668" id="GridView_1" valign="top" style="padding-left: 2px">
                    <table cellpadding="0" cellspacing="0" width="668px" border="0">
                        <tr>
                            <td>
                                <ext:GridPanel ID="GridPanelInvoice" runat="server" Width="668px" Height="171" TrackMouseOver="true"
                                    Title="Local Invoice">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreInvoice" OnRefreshData="storeInvoice_OnRefreshData"
                                            ShowWarningOnFailure="false">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="DN" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CN" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="DN_CNNO" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyName" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Currency" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Amount" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Print" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Void" Type="Boolean">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="AC" Type="Boolean">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel2">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:CheckColumn Header="DN" Width="30" DataIndex="DN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="CN" Width="30" DataIndex="CN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="120">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="200" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="65" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Format="0.00" Align="Right">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="RowID" DataIndex="RowID" Hidden="true" Width="0">
                                            </ext:NumberColumn>
                                            <ext:CheckColumn Header="Print" Width="38" DataIndex="Print" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="Void" Width="38" DataIndex="Void" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="AC" Width="30" DataIndex="AC" Align="Center">
                                            </ext:CheckColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="rowSelect19877">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td id="dis_Invoice" valign="top" style="padding-left:5px;">
                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="119" Width="303" />
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td id="GridView_2" style="width: 668px; padding-left: 2px">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="font_11bold_1542af  nav_menu_4" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                font-size: 11px; height: 23px">
                                <table width="665px" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="width: 665px" class="font_11bold_1542af">
                                            Container
                                        </td>
                                        <td>
                                            <div id="showContainer">

                                                <script type="text/javascript">
                                                    if (Request("Seed") != "") {
                                                        document.write("<a href='javascript:Add()'>New</a>");
                                                    }                                                  
                                                </script>

                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="GridPanelContainer" runat="server" Width="668px" Height="150"
                                    TrackMouseOver="true">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreContainer">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Container" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ContainerSize" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="PKGS" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Unit" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="GWT" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CBM" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="WM" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel1">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Container #" DataIndex="Container" Width="100">
                                            </ext:Column>
                                            <ext:Column Header="Container Size" DataIndex="ContainerSize" Width="100">
                                            </ext:Column>
                                            <ext:NumberColumn Header="PKG(S)" DataIndex="PKGS" Width="70" Align="right" Format="0">
                                            </ext:NumberColumn>
                                            <ext:Column Header="Unit" DataIndex="Unit" Width="40" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="WT" DataIndex="GWT" Width="70" Align="Right" Format="0.000">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="CBM" DataIndex="CBM" Width="70" Align="Right" Format="0.000">
                                            </ext:NumberColumn>
                                            <ext:ImageCommandColumn Header="Action" Width="50" Align="Center" Hidden="true">
                                                <Commands>
                                                    <ext:ImageCommand Icon="BinEmpty" ToolTip-Text="Delete" CommandName="Delete" Style="background-position: center center;
                                                        width: 50px">
                                                        <ToolTip Text="Delete"></ToolTip>
                                                    </ext:ImageCommand>
                                                </Commands>
                                            </ext:ImageCommandColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="rowSelectModel12345">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    <%--<Listeners>
                                        <Command Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') { DeleteContainer(#{GridPanelContainer},rowIndex); }})" />
                                    </Listeners>
                                    <KeyMap>
                                        <ext:KeyBinding Ctrl="true">
                                            <Keys>
                                                <ext:Key Code="DELETE"/>
                                            </Keys>
                                            <Listeners>
                                                <Event Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') { DeleteContainer(#{GridPanelContainer}); }})" />
                                            </Listeners>
                                        </ext:KeyBinding>
                                    </KeyMap>--%>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 7px">
                    <table width="303" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                        <tr>
                            <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                style="padding-left: 5px">
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="0" style="padding-top: 5px" width="300px">
                        <tr>
                            <td>
                            </td>
                            <td style="padding-top: 5px; padding-left: 27px" align="left">
                                Actual
                            </td>
                            <td style="padding-top: 5px; padding-left: 14px" align="left">
                                Charge
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#FFFFFF" style="padding-left: 7px">
                                <span class="font_11bold">Piece(s)</span><%--<span class="font_red" style="padding-left:2px">*</span>--%>
                            </td>
                            <td style="padding-left: 10px">
                                <ext:NumberField ID="txtAPiece" runat="server" Width="78" DecimalPrecision="0" StyleSpec="text-align:right"
                                    Cls="select_160px" Disabled="true">
                                </ext:NumberField>
                            </td>
                            <td height="25" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 2px">
                                <ext:NumberField ID="txtPiece" runat="server" Cls="text_70px" Width="70" DecimalPrecision="0"
                                    StyleSpec="text-align:right" TabIndex="28">
                                </ext:NumberField>
                            </td>
                            <td height="25" bgcolor="#FFFFFF" class="table" align="left" style="padding-left: 2px;
                                padding-right: 2px">
                                <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                    TabIndex="28" Query="option=UnitBinding" StoreID="StoreUnit" Width="58" winTitle="Unit"
                                    isButton="false" winUrl="/BasicData/Unit/list.aspx" winWidth="510" winHeight="585" />
                            </td>
                        </tr>
                        <tr>
                            <td height="25" bgcolor="#FFFFFF" style="padding-left: 7px">
                                <span class="font_11bold">WT</span>
                            </td>
                            <td style="padding-left: 10px">
                                <ext:NumberField ID="txtAGWT" runat="server" Width="78" StyleSpec="text-align:right"
                                    DecimalPrecision="3" Cls="select_160px" Disabled="true">
                                </ext:NumberField>
                            </td>
                            <td height="25" bgcolor="#FFFFFF" class="table" style="padding-left: 2px; padding-right: 2px">
                                <ext:NumberField ID="txtGWT" runat="server" Cls="text_70px" Width="70" TabIndex="28"
                                    StyleSpec="text-align:right" DecimalPrecision="3">
                                    <Listeners>
                                        <Blur Handler="var wt=#{txtGWT}.getValue()!=''?#{txtGWT}.getValue():#{txtAGWT}.getValue();var cbm=#{txtCBM}.getValue()!=''?#{txtCBM}.getValue():#{txtACBM}.getValue(); if(wt!=''){ if(cbm==''){#{txtCWT}.setValue(wt*1.0000/1000)} else{if(wt>cbm*1000){#{txtCWT}.setValue(wt*1.0000/1000)}else{#{txtCWT}.setValue(cbm)}} } else { if(cbm!=''){#{txtCWT}.setValue(cbm)}}" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                        </tr>
                        <tr>
                            <td height="25" bgcolor="#FFFFFF" style="padding-left: 7px">
                                <span class="font_11bold">CBM</span>
                            </td>
                            <td style="padding-left: 10px">
                                <ext:NumberField ID="txtACBM" runat="server" Width="78" StyleSpec="text-align:right"
                                    DecimalPrecision="3" Cls="select_160px" Disabled="true">
                                </ext:NumberField>
                            </td>
                            <td height="25" bgcolor="#FFFFFF" class="table" style="padding-left: 2px; padding-right: 2px">
                                <ext:NumberField ID="txtCBM" DecimalPrecision="3" runat="server" Cls="text_70px"
                                    StyleSpec="text-align:right" Width="70" TabIndex="28">
                                    <Listeners>
                                        <Change Handler="var wt=#{txtGWT}.getValue()!=''?#{txtGWT}.getValue():#{txtAGWT}.getValue();var cbm=#{txtCBM}.getValue()!=''?#{txtCBM}.getValue():#{txtACBM}.getValue(); if(cbm!=''){if(wt==''){#{txtCWT}.setValue(cbm)}else{ if(wt>cbm*1000){#{txtCWT}.setValue(wt*1.0000/1000)}else{#{txtCWT}.setValue(cbm)} }} else{ if(wt!=''){#{txtCWT}.setValue(wt*1.0000/1000)}};#{txtCWT}.focus(true);" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                        </tr>
                        <tr>
                            <td height="25" bgcolor="#FFFFFF" style="padding-left: 7px">
                                <span class="font_11bold">WM</span>
                            </td>
                            <td style="padding-left: 10px">
                                <ext:NumberField ID="txtAWM" runat="server" Width="78" StyleSpec="text-align:right"
                                    DecimalPrecision="3" Cls="select_160px" Disabled="true">
                                </ext:NumberField>
                            </td>
                            <td height="25" bgcolor="#FFFFFF" class="table" align="center" style="padding: 0 2px">
                                <ext:NumberField ID="txtCWT" runat="server" Cls="text_70px" Width="70" TabIndex="28"
                                    StyleSpec="text-align:right" DecimalPrecision="3">
                                </ext:NumberField>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td height="25" bgcolor="#FFFFFF" style="padding-left: 7px">
                                <table cellpadding="0" cellspacing="0" border="0" width="55px">
                                    <tr>
                                        <td>
                                            Container
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td height="25" bgcolor="#FFFFFF" class="table" style="padding-left: 7px">
                                <ext:NumberField ID="txtContainer" runat="server" Cls="text_70px" Width="78" AllowDecimals="false"
                                    StyleSpec="text-align:right" Disabled="true">
                                </ext:NumberField>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <uc1:Costing ID="ucCost" runat="server" type="H" sys="OI" />
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td id="GridView_4">
                    <table cellpadding="0" cellspacing="0" width="668">
                        <tr>
                            <td id="GridView_3" style="width: 668; padding-left: 2px">
                                <table cellpadding="0" cellspacing="0" width="668">
                                    <tr>
                                        <td>
                                            <ext:GridPanel ID="GridPanelOther" runat="server" Width="668" Height="257" TrackMouseOver="true"
                                                AllowDomMove="true" Title="Other Charges (CS)" ClicksToEdit="1">
                                                <Store>
                                                    <ext:Store ID="StoreOther" runat="server" SerializationMode="Simple" StopIDModeInheritance="False">
                                                        <Reader>
                                                            <ext:JsonReader IDProperty="RowID">
                                                                <Fields>
                                                                    <ext:RecordField Name="RowID" Type="Int">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="PPD" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="CompanyCode" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="CompanyName" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Item" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Description" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Total" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="CalcKind" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Qty" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Unit" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Currency" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="EX" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Rate" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Amount" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Percent" Type="String">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="Show" Type="String">
                                                                    </ext:RecordField>
                                                                </Fields>
                                                            </ext:JsonReader>
                                                        </Reader>
                                                    </ext:Store>
                                                </Store>
                                                <ColumnModel ID="ColumnModel3">
                                                    <Columns>
                                                        <ext:RowNumbererColumn Header="No." Width="30">
                                                        </ext:RowNumbererColumn>
                                                        <ext:Column Header="A/L" DataIndex="PPD" Width="45" Align="Center">
                                                        </ext:Column>
                                                        <ext:Column Header="Code" DataIndex="CompanyCode" Width="63">
                                                        </ext:Column>
                                                        <ext:Column Header="Company" DataIndex="CompanyName" Width="200" Hidden="true">
                                                        </ext:Column>
                                                        <ext:Column Header="Item" DataIndex="Item" Width="62">
                                                        </ext:Column>
                                                        <ext:Column Header="Description" DataIndex="Description" Width="200" Hidden="true">
                                                        </ext:Column>
                                                        <ext:NumberColumn Header="Total" DataIndex="Total" Width="70" Align="Right" Format="0.00">
                                                        </ext:NumberColumn>
                                                        <ext:Column Header="Calc Kind" DataIndex="CalcKind" Width="70" Align="Center" Hidden="true">
                                                        </ext:Column>
                                                        <ext:Column Header="Qty" DataIndex="Qty" Width="70" Align="Right">
                                                        </ext:Column>
                                                        <ext:Column Header="Unit" DataIndex="Unit" Width="40" Align="center">
                                                        </ext:Column>
                                                        <ext:Column Header="CUR" DataIndex="Currency" Width="40" Align="Center">
                                                        </ext:Column>
                                                        <ext:NumberColumn Header="EX." DataIndex="EX" Width="70" Format="0.000" Align="Right"
                                                            Hidden="true">
                                                        </ext:NumberColumn>
                                                        <ext:NumberColumn Header="Rate" DataIndex="Rate" Width="70" Align="Right" Format="0.000">
                                                        </ext:NumberColumn>
                                                        <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right" Format="0.00">
                                                        </ext:NumberColumn>
                                                        <ext:Column Header="%" DataIndex="Percent" Width="45" Align="Center">
                                                            <Renderer Fn="ChangeValue" />
                                                        </ext:Column>
                                                        <ext:CheckColumn Header="Show" DataIndex="Show" Width="40" Align="Center">
                                                        </ext:CheckColumn>
                                                    </Columns>
                                                </ColumnModel>
                                                <SelectionModel>
                                                    <ext:RowSelectionModel ID="RowSelectionModel3" runat="server">
                                                        <Listeners>
                                                            <RowSelect Handler="getRowIndex1(rowIndex);" />
                                                        </Listeners>
                                                    </ext:RowSelectionModel>
                                                </SelectionModel>
                                                <Listeners>
                                                    <RowClick Handler="getRowIndex1(rowIndex);SelectOtherRecord();" />
                                                </Listeners>
                                            </ext:GridPanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="vertical-align: top; padding-left: 7px; padding-top: 3px">
                                <div id="Div4">
                                    <table cellpadding="0" cellspacing="0" style="width: 303px">
                                        <tr>
                                            <td colspan="6" style="padding-left: 5px; height: 24px;" class="font_11bold_1542af table_nav2">
                                                Add Other Charges
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="72px">
                                                    <tr>
                                                        <td class="tb_01" style="vertical-align: top; padding-top: 14px; padding-left: 6px">
                                                            Agent/Local
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 12px">
                                                <ext:ComboBox ID="o_ppd" runat="server" DisplayField="text" StoreID="StoreAgentLocal"
                                                    ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All" Cls="select_160px"
                                                    Width="91" TabIndex="42" StyleSpec="text-transform:capitalize">
                                                    <Listeners>
                                                        <Select Handler="GetItemData('o_ppd','o_item','o_calc','o_qty','o_unit','o_currency','o_rate','o_amount','o_ex')" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="vertical-align: top; padding-top: 8px; padding-left: 6px">
                                                Company
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <%-- <uc1:UserComboBox runat="server" ID="l_company" clsClass="select_160px" TabIndex="33"
            isText="true" isAlign="false" StoreID="StoreCmb3" Width="137" winTitle="Company"
            winUrl="/BasicData/Customer/detail.aspx" isButton="false" winWidth="800" winHeight="800"
            Query="option=CompanyList" /> --%>
                                                <uc1:AutoComplete runat="server" ID="o_company" clsClass="x-form-text x-form-field text_82px"
                                                    TabIndex="43" isText="true" isAlign="false" Width="64" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" Query="option=CompanyList" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="vertical-align: top; padding-left: 7px">
                                                Item
                                            </td>
                                            <td colspan="5">
                                                <uc1:UserComboBox runat="server" StoreID="StoreGetItem" ID="o_item" isText="true"
                                                    TabIndex="44" clsClass="select_160px" Width="70" winTitle="Item" winUrl="/BasicData/Item/list.aspx?sys=O"
                                                    winWidth="965" winHeight="480" Handler="GetItemData('o_ppd','o_item','o_calc','o_qty','o_unit','o_currency','o_rate','o_amount','o_ex')" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 7px">
                                                Calc
                                            </td>
                                            <td colspan="5" style="padding: 0">
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <ext:ComboBox runat="server" ID="o_calc" Cls="select_160px" StoreID="StoreKind" TabIndex="45"
                                                                DisplayField="value" ValueField="value" Width="60" ForceSelection="true" TriggerAction="All"
                                                                Mode="Local">
                                                                <Listeners>
                                                                    <Select Handler="SelectCalc('o_calc','o_qty','o_unit')" />
                                                                </Listeners>
                                                            </ext:ComboBox>
                                                        </td>
                                                        <td>
                                                            <table width="30px">
                                                                <tr>
                                                                    <td align="center">
                                                                        Qty
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            <ext:NumberField ID="o_qty" runat="server" Width="40" Cls="select_160px" TabIndex="46"
                                                                DecimalPrecision="3" StyleSpec="text-align:right">
                                                            </ext:NumberField>
                                                        </td>
                                                        <td>
                                                            <table width="30">
                                                                <tr>
                                                                    <td align="center">
                                                                        Unit
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            <ext:ComboBox ID="o_unit" runat="server" DisplayField="value" ValueField="value"
                                                                TabIndex="47" ListWidth="180" ItemSelector="tr.list-item" StoreID="StoreUnit"
                                                                Mode="Local" ForceSelection="true" TriggerAction="All" Width="60" Cls="select_160px">
                                                            </ext:ComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 7px; padding-top: 3px">
                                                Currency
                                            </td>
                                            <td colspan="5" style="padding-top: 5px">
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <ext:ComboBox ID="o_currency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                                                Width="60" TabIndex="48" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                                TriggerAction="All">
                                                                <Listeners>
                                                                    <Select Handler="#{o_ex}.setValue(record.data.rate)" />
                                                                </Listeners>
                                                            </ext:ComboBox>
                                                        </td>
                                                        <td colspan="3" style="padding-left: 2px">
                                                            <ext:NumberField ID="o_ex" runat="server" Width="68" DecimalPrecision="4" StyleSpec="text-align:right"
                                                                Cls="select_160px" TabIndex="49">
                                                            </ext:NumberField>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 7px; padding-top: 5px">
                                                Rate
                                            </td>
                                            <td style="padding-top: 5px">
                                                <ext:NumberField ID="o_rate" runat="server" Width="60" TabIndex="50" Cls="select_65"
                                                    StyleSpec="text-align:right" DecimalPrecision="2">
                                                    <Listeners>
                                                        <Blur Handler="if(this.getValue()!=''){#{o_amount}.setValue()}" />
                                                    </Listeners>
                                                </ext:NumberField>
                                            </td>
                                            <td style="padding-top: 5px">
                                                <table width="68px">
                                                    <tr>
                                                        <td align="right">
                                                            Amount
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="left" style="padding-top: 5px">
                                                <ext:NumberField ID="o_amount" runat="server" Width="78" TabIndex="51" Cls="select_65"
                                                    StyleSpec="text-align:right" DecimalPrecision="2">
                                                    <Listeners>
                                                        <Blur Handler="if(this.getValue()!=''){#{o_rate}.setValue()}" />
                                                    </Listeners>
                                                </ext:NumberField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 7px; padding-top: 3px">
                                                Percent
                                            </td>
                                            <td style="padding-top: 5px">
                                                <ext:NumberField ID="o_percent" runat="server" Cls="text" Width="60" TabIndex="52"
                                                    Text="100" MaxLength="5" DecimalPrecision="1" StyleSpec="text-align:left;background-image:url(../../images/icon.gif);background-repeat:no-repeat; background-position:right center;">
                                                </ext:NumberField>
                                            </td>
                                            <td align="right">
                                                <table>
                                                    <tr>
                                                        <td style="padding-right: 6px">
                                                            Show
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="padding-top: 4px; text-align: left">
                                                <ext:Checkbox ID="o_show" runat="server" Cls="text" TabIndex="53" HideLabel="true"
                                                    Width="25" Checked="true">
                                                </ext:Checkbox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="padding-top: 10px; padding-right: 7px" align="right">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="if(ValidataCompany('o_company')){InsertOtherRecord()}" type="button"
                                                                            style="cursor: pointer" tabindex="54" class="btn_text btn_C" value="Save & Next" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="ResetOtherRecord()" type="button" style="cursor: pointer" tabindex="55"
                                                                            class="btn_text btn_C" value="Reset" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                           </td> 
                                                            <td>
                                                                <table cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td class="btn_L">
                                                                        </td>
                                                                        <td>
                                                                            <input onclick="DeleteOtherRecord()" type="button" style="cursor: pointer" tabindex="56"
                                                                                class="btn_text btn_C" value="Delete" />
                                                                        </td>
                                                                        <td class="btn_R">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                    </tr>
                                                </table>
                                                <%--<input type="button" value="Save & Next" onclick="InsertRecord()" tabindex="39" />                                               
        <input type="button" value="Reset" onclick="ResetRecord()"  />
        <input type="button" value="Delete" onclick="DeleteRecord()"  />--%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td id="GridView_5">
                    <table cellpadding="0" cellspacing="0" width="668">
                        <tr>
                            <td style="padding-left: 2px">
                                <ext:GridPanel ID="GridPanelForeign" runat="server" Width="668" Height="240" TrackMouseOver="true"
                                    Title="Foreign Invoice" ClicksToEdit="1">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreForeign">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Kind" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyName" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Currency" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Amount" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="DN_CNNO" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Date" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel5">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Kind" DataIndex="Kind" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="Date" DataIndex="Date" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="190">
                                            </ext:Column>
                                            <ext:Column Header="Code" DataIndex="CompanyCode" Width="130">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="180" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="65" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right">
                                            </ext:NumberColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel4" runat="server">
                                            <Listeners>
                                                <RowSelect Handler="getRowIndex3(rowIndex);" />
                                            </Listeners>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    <Listeners>
                                        <RowClick Handler="getRowIndex3(rowIndex);SelectForeignInvoiceRecord()" />
                                    </Listeners>
                                </ext:GridPanel>
                            </td>
                            <td style="vertical-align: top; padding-left: 7px">
                                <div style="width: 302px" id="Div1">
                                    <table cellpadding="0" cellspacing="0" style="width: 303px">
                                        <tr>
                                            <td colspan="6" style="padding-left: 5px; height: 24px;" class="font_11bold_1542af table_nav2">
                                                Add Foreign Invoice
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="63px">
                                                    <tr>
                                                        <td class="tb_01" style="padding-left: 6px; padding-top: 11px" valign="top">
                                                            Kind
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 12px">
                                                <ext:ComboBox runat="server" ID="FI_Kind" Cls="select_160px" TabIndex="57" StoreID="StoreForeignKind"
                                                    Width="91" Mode="Local" ForceSelection="true" TriggerAction="All" DisplayField="text"
                                                    ValueField="value" Text="Credit Note">
                                                </ext:ComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 6px; padding-top: 8px" valign="top">
                                                Date
                                            </td>
                                            <td colspan="5" style="padding: 0; padding-top: 6px">
                                                <ext:DateField runat="server" ID="FI_Date" Format="dd/m/Y" Cls="select_160px" Width="91"
                                                    TabIndex="58">
                                                </ext:DateField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 6px; padding-top: 8px" valign="top">
                                                DN/CN No.
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <ext:TextField ID="FI_DNCN" runat="server" Cls="text_80px" Width="91" TabIndex="59">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-top: 7px; padding-left: 6px" valign="top">
                                                Company
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <%-- <uc1:UserComboBox runat="server" ID="l_company" clsClass="select_160px" TabIndex="33"
isText="true" isAlign="false" StoreID="StoreCmb3" Width="137" winTitle="Company"
winUrl="/BasicData/Customer/detail.aspx" isButton="false" winWidth="800" winHeight="800"
Query="option=CompanyList" /> --%>
                                                <uc1:AutoComplete runat="server" ID="FI_Company" clsClass="x-form-text x-form-field text_82px"
                                                    TabIndex="60" isText="true" isAlign="false" Width="64" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" Query="option=CompanyList" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 6px;">
                                                Currency
                                            </td>
                                            <td colspan="5">
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="padding-right: 2px">
                                                            <ext:ComboBox ID="FI_Currency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                                                Width="91" TabIndex="61" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                                TriggerAction="All">
                                                                <Listeners>
                                                                    <Select Handler="#{FI_EX}.setValue(record.data.rate)" />
                                                                </Listeners>
                                                            </ext:ComboBox>

                                                            <script type="text/javascript">
                                                                var cur = '<%=cur%>';
                                                            </script>

                                                        </td>
                                                        <td colspan="3" style="display: none">
                                                            <ext:NumberField ID="FI_EX" runat="server" Width="68" DecimalPrecision="4" StyleSpec="text-align:right"
                                                                Cls="select_160px" TabIndex="62">
                                                            </ext:NumberField>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 6px; padding-top: 8px" valign="top">
                                                Amount
                                            </td>
                                            <td colspan="5" style="padding-top: 7px">
                                                <ext:NumberField ID="FI_Amount" runat="server" Cls="text_80px" Width="91" TabIndex="63"
                                                    StyleSpec="text-align:right">
                                                </ext:NumberField>
                                            </td>
                                        </tr>
                                        <tr>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="padding-top: 10px; padding-right: 7px" align="right">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="if(ValidataCompany('FI_Company')){InsertForeignInvoiceRecord()}"
                                                                            type="button" style="cursor: pointer" tabindex="64" class="btn_text btn_C" value="Save & Next" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="ResetForeignInvoiceRecord()" type="button" style="cursor: pointer"
                                                                            tabindex="65" class="btn_text btn_C" value="Reset" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="DeleteForeignInvoiceRecord()" type="button" style="cursor: pointer"
                                                                            tabindex="66" class="btn_text btn_C" value="Delete" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <%--<input type="button" value="Save & Next" onclick="InsertRecord()" tabindex="39" />                                               
<input type="button" value="Reset" onclick="ResetRecord()"/>
<input type="button" value="Delete" onclick="DeleteRecord()" />--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 35px">
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="0" cellpadding="0" style="visibility: hidden">
            <tr style="display: none">
                <td id="GridView_6">
                    <table cellpadding="0" cellspacing="0" width="674">
                        <tr>
                            <td style="padding-left: 2px">
                                <ext:GridPanel ID="GridPanelRoute" runat="server" Width="674" Height="240" TrackMouseOver="true"
                                    Title="Domestic Information">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreRoute">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Kind" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyName" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Dest" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Voyage" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ETD" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ETA" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel6">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Kind" DataIndex="Kind" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="Code" DataIndex="CompanyCode" Width="100">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="180" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="Dest." DataIndex="Dest" Width="60">
                                            </ext:Column>
                                            <ext:Column Header="Voyage" DataIndex="Voyage" Width="65" Align="center">
                                            </ext:Column>
                                            <ext:Column Header="ETD" DataIndex="ETD" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="ETA" DataIndex="ETA" Width="80">
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel5" runat="server">
                                            <Listeners>
                                                <RowSelect Handler="getRowIndex4(rowIndex)" />
                                            </Listeners>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    <Listeners>
                                        <RowClick Handler="getRowIndex4(rowIndex);SelectDomesticRecord();" />
                                    </Listeners>
                                </ext:GridPanel>
                            </td>
                            <td style="vertical-align: top; padding-left: 7px">
                                <div style="width: 302px; height: 21px;" id="Div2">
                                    <table cellpadding="0" cellspacing="0" style="width: 303px">
                                        <tr>
                                            <td colspan="6" style="padding-left: 5px; height: 24px;" class="font_11bold_1542af table_nav2">
                                                Add Domestic Route
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="64px">
                                                    <tr>
                                                        <td class="tb_01" style="vertical-align: top; padding-left: 6px; padding-top: 10px">
                                                            Kind
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 10px">
                                                <%-- <uc1:UserComboBox runat="server" ID="l_item" clsClass="select_160px" TabIndex="34" isText="true"
StoreID="StoreCmb3" Width="90" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
isButton="false" winWidth="800" winHeight="800" Query="option=ItemBinding&sys=A" />--%>
                                                <ext:ComboBox ID="r_Kind" runat="server" StoreID="StoreShipKind" DisplayField="text"
                                                    TabIndex="55" ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All"
                                                    Cls="select_160px" Width="91">
                                                    <Template Visible="False" ID="ctl7617" StopIDModeInheritance="False" EnableViewState="False">
                                                    </Template>
                                                </ext:ComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="vertical-align: top; padding-top: 8px; padding-left: 6px">
                                                Company
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <uc1:AutoComplete runat="server" ID="r_Company" clsClass="x-form-text x-form-field text_82px"
                                                    isText="true" isAlign="false" Width="64" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" TabIndex="56" Query="option=CompanyList" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 6px;">
                                                DEST.
                                            </td>
                                            <td colspan="5">
                                                <uc1:UserComboBox runat="server" ID="r_Dest" ListWidth="180" clsClass="select_160px"
                                                    TabIndex="57" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="70"
                                                    winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                    winHeight="620" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="vertical-align: top; padding-top: 8px; padding-left: 6px">
                                                Voyage
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <ext:TextField ID="r_Voyage" runat="server" Cls="text_80px" Width="91" TabIndex="58">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 6px; padding-top: 6px">
                                                ETD
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <ext:DateField ID="r_ETD" runat="server" Format="dd/m/Y" Cls="select_160px" Width="91px"
                                                    TabIndex="59">
                                                    <Listeners>
                                                        <Blur Handler="DateDiff(#{r_ETD},#{r_ETA})" />
                                                    </Listeners>
                                                </ext:DateField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 6px; padding-top: 6px">
                                                ETA
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <ext:DateField ID="r_ETA" runat="server" Format="dd/m/Y" Cls="select_160px" Width="91px"
                                                    TabIndex="60">
                                                    <Listeners>
                                                        <Blur Handler="DateDiff(#{r_ETD},#{r_ETA})" />
                                                    </Listeners>
                                                </ext:DateField>
                                            </td>
                                        </tr>
                                        <tr>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="padding-top: 10px; padding-right: 7px" align="right">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="if(ValidataCompany('r_Company')){InsertDomesticRecord()}" type="button"
                                                                            style="cursor: pointer" tabindex="60" class="btn_text btn_C" value="Save & Next" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="ResetDomesticRecord()" type="button" style="cursor: pointer" tabindex="60"
                                                                            class="btn_text btn_C" value="Reset" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td class="btn_C">
                                                                        <input onclick="DeleteDomesticRecord()" type="button" style="cursor: pointer" tabindex="60"
                                                                            class="btn_text btn_C" value="Delete" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--<input type="button" value="Save & Next" onclick="InsertRecord()" tabindex="39" />                                               
<input type="button" value="Reset" onclick="ResetRecord()"  />
<input type="button" value="Delete" onclick="DeleteRecord()" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="display: none">
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr style="display: none">
                <td id="GridView_7">
                    <table cellpadding="0" cellspacing="0" style="margin-bottom: 30px" width="674">
                        <tr>
                            <td style="padding-left: 2px">
                                <ext:GridPanel ID="GridPanelContact" runat="server" Width="674" Height="157" TrackMouseOver="true"
                                    Title="Contact Information">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreContact">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Kind" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CompanyName" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Dept" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Contact" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Phone" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Fax" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Email" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel7">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Kind" DataIndex="Kind" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="Code" DataIndex="CompanyCode" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="200" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="Dept" DataIndex="Dept" Width="40" Align="center">
                                            </ext:Column>
                                            <ext:Column Header="Contact" DataIndex="Contact" Width="150" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="Phone" DataIndex="Phone" Width="150" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="Fax" DataIndex="Fax" Width="150" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="Email" DataIndex="Email" Width="200" Hidden="true">
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel6" runat="server">
                                            <Listeners>
                                                <RowSelect Handler="getRowIndex5(rowIndex)" />
                                            </Listeners>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    <Listeners>
                                        <RowClick Handler="getRowIndex5(rowIndex);SelectContactRecord();" />
                                    </Listeners>
                                </ext:GridPanel>
                            </td>
                            <td valign="top" style="padding-left: 7px">
                                <div style="width: 292px" id="Div3">
                                    <table cellpadding="0" cellspacing="0" style="width: 303px">
                                        <tr>
                                            <td colspan="6" style="padding-left: 5px; height: 24px" class="font_11bold_1542af table_nav2">
                                                Add Contact
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="64px">
                                                    <tr>
                                                        <td class="tb_01" style="padding-left: 6px; padding-top: 11px" valign="top">
                                                            Kind
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 10px">
                                                <ext:ComboBox ID="c_Kind" runat="server" StoreID="StoreCompanyKind" DisplayField="text"
                                                    TabIndex="61" ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All"
                                                    Cls="select_160px" Width="91">
                                                    <Template Visible="False" ID="ctl7627" StopIDModeInheritance="False" EnableViewState="False">
                                                    </Template>
                                                </ext:ComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="vertical-align: top; padding-top: 8px; padding-left: 6px">
                                                Company
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <uc1:AutoComplete runat="server" ID="c_Company" clsClass="x-form-text x-form-field text_82px"
                                                    isText="true" isAlign="false" Width="64" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" Query="option=CompanyList" TabIndex="62" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-left: 6px; padding-top: 1px" valign="top">
                                            Dept
                                        </td>
                                            <td>
                                            <ext:ComboBox ID="c_Dept" runat="server" StoreID="StoreDept" DisplayField="value"
                                                TabIndex="63" ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All"
                                                Cls="select_160px" Width="91">
                                                <Template Visible="False" ID="ctl7631" StopIDModeInheritance="False" EnableViewState="False">
                                                </Template>
                                            </ext:ComboBox>
                                        </td>
                                        </tr>                                       
                                        <tr>
                                            <td colspan="6" style="padding-top: 10px; padding-right: 7px" align="right">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="if(ValidataCompany('c_Company')){InsertContactRecord()}" type="button"
                                                                            style="cursor: pointer" tabindex="63" class="btn_text btn_C" value="Save & Next" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="padding-right: 2px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="ResetContactRecord()" type="button" style="cursor: pointer" tabindex="63"
                                                                            class="btn_text btn_C" value="Reset" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="DeleteContactRecord()" type="button" style="cursor: pointer" tabindex="63"
                                                                            class="btn_text btn_C" value="Delete" />
                                                                    </td>
                                                                    <td class="btn_R">
                                                                    </td>
                                                                </tr>
                                                            </table>
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
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
