<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="OceanExport_OEAssignJob_List"
    ValidateRequest="false" %>

<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/Costing.ascx" TagName="Costing" TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/Transfer.ascx" TagName="Transfer" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>OE MBL</title>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../OEJs/gridList.js?V=1111" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../OceanExport/OEJs/Valid.js" type="text/javascript"></script>

    <script type="text/javascript">

        var PPCC = function (value) {
            var r = StorePPCC.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        };

        var StoreCompany = function (value) {
            var r = StoreCmb.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        };

        var StoreDescription = function (value) {
            var r = StoreItem.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        };

        var ToUpper = function (value) {
            return value.toUpperCase();
        }
        function refreshdata(seed, str) {
            CompanyX.RefreshData(seed, str);
        }
        function smGroup(value) {
            var r = StoreMode.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            if (r.data.group != null) {
                CmbGroup.setValue(r.data.group);
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" GZip="true" DirectMethodNamespace="CompanyX">
        </ext:ResourceManager>
        <div id="div_title" style="width: 100%; z-index: 1000">
            <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="O" />
        </div>
        <ext:Store runat="server" ID="StoreGroup">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="text" />
                        <ext:RecordField Name="value" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <div id="div_title" style="margin-left: 10px; margin-top: 80px; z-index: 990;">
            <table width="980px" border="0" cellspacing="0" cellpadding="0" class="table_nav1 font_11bold_1542af">
                <tbody>
                    <tr>
                        <td class="" style="padding-left: 5px;">
                            <table>
                                <tr>
                                    <td>
                                        <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                            alt="View" onclick="createFrom('OE');" />
                                    </td>
                                    <td>&nbsp;OE - MBL Information
                                    </td>
                                    <td style="padding-left: 5px;">
                                        <ext:ComboBox ID="CmbGroup" runat="server" StoreID="StoreGroup" DisplayField="value"
                                            ValueField="value" Mode="Local" Width="70" Cls="select" ListWidth="70" AllowBlank="false"
                                            TabIndex="1">
                                        </ext:ComboBox>
                                    </td>
                                    <td style="padding-top: 2px;">&nbsp;<img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle; display: none;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" style="padding-right: 5px;">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <ext:Button ID="btnUpdateLotNo" runat="server" Hidden="true" Text="Update Lot No."
                                            Cls="btnUpdateLotNo">
                                            <Listeners>
                                                <Click Handler="UpdatelotNo();" />
                                            </Listeners>
                                        </ext:Button>
                                    </td>
                                    <td style="padding-left: 5px;">
                                        <ext:Label runat="server" ID="labImpLotNo" StyleSpec=" color:#ff0000" Hidden="true">
                                        </ext:Label>
                                        <ext:Label ID="labHeader" runat="server">
                                        </ext:Label>
                                    </td>
                                    <td>
                                        <%if (!string.IsNullOrEmpty(Request["seed"]))
                                          { %>
                                        <uc1:Transfer runat="server" ID="TransferSys" sys="OE" type="M" />
                                        <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
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
        <ext:Store runat="server" ID="StoreVessel" OnRefreshData="StoreVessel_OnRefreshData">
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
        <ext:Store runat="server" ID="StoreVoyage" OnRefreshData="StoreVoyage_OnRefreshData">
            <Reader>
                <ext:JsonReader IDProperty="value">
                    <Fields>
                        <ext:RecordField Name="text">
                        </ext:RecordField>
                        <ext:RecordField Name="value">
                        </ext:RecordField>
                        <ext:RecordField Name="ETD">
                        </ext:RecordField>
                        <ext:RecordField Name="ETA">
                        </ext:RecordField>
                        <ext:RecordField Name="POL">
                        </ext:RecordField>
                        <ext:RecordField Name="POD">
                        </ext:RecordField>
                        <ext:RecordField Name="CFS">
                        </ext:RecordField>
                        <ext:RecordField Name="CY">
                        </ext:RecordField>
                        <ext:RecordField Name="Onboard">
                        </ext:RecordField>
                        <ext:RecordField Name="Carrier">
                        </ext:RecordField>
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <ext:Store runat="server" ID="StorePreVoyage" OnRefreshData="StorePreVoyage_OnRefreshData">
            <Reader>
                <ext:JsonReader IDProperty="value">
                    <Fields>
                        <ext:RecordField Name="text">
                        </ext:RecordField>
                        <ext:RecordField Name="value">
                        </ext:RecordField>
                        <ext:RecordField Name="ETD">
                        </ext:RecordField>
                        <ext:RecordField Name="ETA">
                        </ext:RecordField>
                        <ext:RecordField Name="POL">
                        </ext:RecordField>
                        <ext:RecordField Name="POD">
                        </ext:RecordField>
                        <ext:RecordField Name="CFS">
                        </ext:RecordField>
                        <ext:RecordField Name="CY">
                        </ext:RecordField>
                        <ext:RecordField Name="Onboard">
                        </ext:RecordField>
                        <ext:RecordField Name="Carrier">
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
        <ext:Store runat="server" ID="StoreMode" OnRefreshData="StoreMode_OnRefreshData">
            <Reader>
                <ext:JsonReader IDProperty="value">
                    <Fields>
                        <ext:RecordField Name="text">
                        </ext:RecordField>
                        <ext:RecordField Name="value">
                        </ext:RecordField>
                        <ext:RecordField Name="group">
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
        <ext:Container runat="server" ID="div_bottom">
        </ext:Container>
        <ext:Hidden runat="server" ID="hidSeed" Text="0">
        </ext:Hidden>
        <ext:Hidden runat="server" ID="txtcur_Rate">
        </ext:Hidden>
        <ext:Hidden ID="hidIDList" runat="server">
        </ext:Hidden>
        <ext:Hidden ID="hidVoid" runat="server" Text="0">
        </ext:Hidden>
        <div style="margin-bottom: 20px; margin-top: 111px; margin-left: 10px">
            <table width="969" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                        <td>
                            <table width="670px">
                                <tr>
                                    <td valign="top">
                                        <table width="670px" border="0" cellpadding="0" cellspacing="4">
                                            <tbody>
                                                <tr>
                                                    <td align="left" class="font_11bold" style="padding-left: 2px">MBL#
                                                    </td>
                                                    <td align="left">
                                                        <ext:TextField ID="txtMBL" runat="server" Cls="text" Width="90" TabIndex="1" EnableKeyEvents="true">
                                                            <%-- <Listeners>
                                                            <Blur Handler="validMBL(this.id,'MBL',#{hidSeed}.getValue());" />
                                                        </Listeners>--%>
                                                        </ext:TextField>
                                                    </td>
                                                    <td style="padding-left: 3px">
                                                        <table cellpadding="0" cellspacing="0" border="0" width="77px">
                                                            <tr>
                                                                <td align="left" class="font_11bold">Service Mode<span class="font_red" style="padding-left: 3px">*</span>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td align="left" style="padding-right: 3px">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <uc1:UserComboBox runat="server" ID="cmbMode" ListWidth="180" clsClass="select" Query="option=ServerMode"
                                                                            StoreID="StoreMode" Width="65" winTitle="Service Mode" TabIndex="2" winUrl="/BasicData/ServiceMode/ServiceMode.aspx?sys=0"
                                                                            winWidth="516" winHeight="585" Handler="smGroup(this.getValue());" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    <td align="left" class="font_11bold">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="47px">
                                                            <tr>
                                                                <td>PPD/COL<span class="font_red" style="padding-left: 3px; padding-right: 1px">*</span>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td align="left">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <ext:ComboBox ID="cmbPPD" runat="server" Cls="select" Width="85" StoreID="StorePPCC"
                                                                            TabIndex="3" DisplayField="text" ValueField="text" Mode="Local" ForceSelection="true"
                                                                            TriggerAction="All">
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    <td align="left">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="55px">
                                                            <tr>
                                                                <td>Salesman
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <uc1:UserComboBox runat="server" ID="cmbSales" Query="option=SalesList" Width="87"
                                                                            clsClass="select" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                                            TabIndex="4" winWidth="680" winHeight="560" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table cellpadding="0" cellspacing="0" border="0" width="63px">
                                                            <tr>
                                                                <td align="left" valign="middle" class="font_11bold" style="padding-left: 2px; padding-bottom: 2px">Co-Loader
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td colspan="3" align="left" valign="top" style="padding-top: 3px">
                                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="270">
                                                                            <tr>
                                                                                <td width="85">
                                                                                    <%-- <uc1:UserComboBox runat="server" ID="cmbDischargeCode" TabIndex="13" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                                                                    <uc1:AutoComplete runat="server" ID="cmbDischargeCode" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                                                        Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                                        winWidth="800" winHeight="800" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="padding-left: 2px"></td>
                                                                    <td width="170"></td>
                                                                    <td width="22"></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    <td align="left" class="font_11bold">Carrier
                                                    </td>
                                                    <td colspan="3" align="left" style="padding-top: 3px">
                                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="253">
                                                                        <tr>
                                                                            <td width="85">
                                                                                <uc1:AutoComplete runat="server" ID="cmbCarrierCode" TabIndex="10" clsClass="text input"
                                                                                    Query="option=CompanyList" Width="58" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                                    winWidth="800" winHeight="800" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td style="padding-left: 2px"></td>
                                                                <td width="170"></td>
                                                                <td width="22"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table width="65px">
                                                            <tr>
                                                                <td>Shipper
                                                                </td>
                                                                <td class="font_red" align="right">*
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td colspan="3" align="left" valign="top" style="padding-top: 4px">
                                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="270">
                                                                            <tr>
                                                                                <td width="85">
                                                                                    <%-- <uc1:UserComboBox runat="server" ID="cmbShipperCode" TabIndex="11" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                                                                    <uc1:AutoComplete runat="server" ID="cmbShipperCode" TabIndex="6" clsClass="x-form-text x-form-field text"
                                                                                        Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                                        winWidth="800" winHeight="800" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="padding-left: 2px"></td>
                                                                    <td width="170"></td>
                                                                    <td width="22"></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    <td align="left" valign="middle" class="font_11bold">Broker
                                                    </td>
                                                    <td colspan="3" align="left" style="padding-top: 4px">
                                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="253">
                                                                            <tr>
                                                                                <td width="85">
                                                                                    <%-- <uc1:UserComboBox runat="server" ID="cmbBrokerCode" TabIndex="14" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                                                                    <uc1:AutoComplete runat="server" ID="cmbBrokerCode" TabIndex="11" clsClass="x-form-text x-form-field text"
                                                                                        Query="option=CompanyList" Width="58" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                                        winWidth="800" winHeight="800" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="padding-left: 2px"></td>
                                                                    <td width="170"></td>
                                                                    <td width="22"></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table width="65px">
                                                            <tr>
                                                                <td>Consignee
                                                                </td>
                                                                <td class="font_red" style="text-align: right">*
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td colspan="3" align="left" valign="top">
                                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="270">
                                                                            <tr>
                                                                                <td width="85" style="padding-top: 4px">
                                                                                    <%-- <uc1:UserComboBox runat="server" ID="cmbConsigneeCode" TabIndex="12" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                                                                    <uc1:AutoComplete runat="server" ID="cmbConsigneeCode" TabIndex="7" clsClass="x-form-text x-form-field text"
                                                                                        Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                                        winWidth="800" winHeight="800" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="padding-left: 2px"></td>
                                                                    <td width="170"></td>
                                                                    <td width="22"></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    <td align="left" valign="top" class="font_11bold">Vessel / Voyage
                                                    </td>
                                                    <td colspan="3" align="left" valign="top" style="padding-top: 4px">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <ext:ComboBox ID="cmbVesselCode" runat="server" Cls="select" Width="130" StoreID="StoreVessel"
                                                                            DisplayField="text" TabIndex="12" ValueField="value" Mode="Local" ForceSelection="true"
                                                                            TriggerAction="All">
                                                                            <DirectEvents>
                                                                                <Select OnEvent="cmbVessel_Select">
                                                                                </Select>
                                                                            </DirectEvents>
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                    <td style="padding-left: 3px"></td>
                                                                    <td>
                                                                        <ext:ComboBox ID="cmbVesselText" runat="server" Cls="select" Width="107" StoreID="StoreVoyage"
                                                                            ItemSelector="tr.list-item" ListWidth="130px" DisplayField="text" ValueField="value"
                                                                            Mode="Local" ForceSelection="true" TriggerAction="All">
                                                                            <%--     <Listeners>
                                                                <Select Handler="CompanyX.BindVoyag(this.getValue());" />
                                                            </Listeners>--%>
                                                                            <DirectEvents>
                                                                                <Select OnEvent="cmbVesselText_Select" />
                                                                            </DirectEvents>
                                                                        </ext:ComboBox>
                                                                    </td>
                                                                    <td style="text-align: left;">
                                                                        <img src="../../images/select_btn.jpg" width="18" height="18" class="cursor" alt=""
                                                                            onclick="CompanyX.ShowVoyage('');">
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 2px">Notify #1
                                                    </td>
                                                    <td colspan="3">
                                                        <table border="0" cellspacing="0" cellpadding="0" width="252">
                                                            <tr>
                                                                <td>
                                                                    <%-- <uc1:UserComboBox runat="server" ID="CmbNotify1" TabIndex="16" clsClass="select"
                                                Query="option=CompanyList" StoreID="StoreCmb1" Width="87" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                                                    <uc1:AutoComplete runat="server" ID="CmbNotify1" TabIndex="8" clsClass="x-form-text x-form-field text"
                                                                        Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                        winWidth="800" winHeight="800" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td align="left" valign="middle" class="font_11bold">Loading<span class="font_red" style="padding-left: 8px">*</span>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <uc1:UserComboBox runat="server" ID="cmbLoading" ListWidth="180" clsClass="select_160px"
                                                                            TabIndex="13" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="64"
                                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                                            winHeight="620" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    <td align="left" valign="middle" class="font_11bold">Discharge<br />
                                                        Port
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <uc1:UserComboBox runat="server" ID="cmbPort" ListWidth="180" clsClass="select_160px"
                                                                            TabIndex="14" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="88"
                                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                                            winHeight="620" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 2px">Notify #2
                                                    </td>
                                                    <td colspan="3">
                                                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td width="85">
                                                                    <%-- <uc1:UserComboBox runat="server" ID="CmbNotify2"  clsClass="select"
                                                Query="option=CompanyList" StoreID="StoreCmb1" Width="104" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                                                    <uc1:AutoComplete runat="server" ID="CmbNotify2" TabIndex="9" clsClass="x-form-text x-form-field text"
                                                                        Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                        winWidth="800" winHeight="800" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="59" align="left" valign="middle" class="font_11bold">Final Dest
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <uc1:UserComboBox runat="server" ID="cmbFinalDest" ListWidth="180" clsClass="select_160px"
                                                                            TabIndex="15" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="64"
                                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                                            winHeight="620" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    <td align="left" valign="middle"></td>
                                                    <td align="right" style="padding-right: 2px;">
                                                        <ext:Button ID="btnPrecarriage" Text="Pre-Carriage" runat="server">
                                                            <Listeners>
                                                                <Click Handler="#{windowPrecarriage}.show();#{cmbpreVessel}.focus(true);" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 2px; vertical-align: top; padding-top: 6px;">Manifest To
                                                    </td>
                                                    <td colspan="3" style="vertical-align: top; padding-top: 3px;">
                                                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td width="85">
                                                                    <uc1:AutoComplete runat="server" ID="txtM_to" TabIndex="15" clsClass="x-form-text x-form-field text"
                                                                        Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                        winWidth="800" winHeight="800" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 2px; vertical-align: top; padding-top: 6px;">Account Remark
                                                    </td>
                                                    <td colspan="3" style="vertical-align: top; padding-top: 3px;">
                                                        <ext:TextArea ID="txtAccRemark" runat="server" Width="260" Height="46" Cls="text_80px"
                                                            TabIndex="16">
                                                        </ext:TextArea>
                                                    </td>
                                                    <td width="60" align="left" class="font_11bold" style="vertical-align: top; padding-top: 6px;">Shipping Remark
                                                    </td>
                                                    <td colspan="3" style="vertical-align: top; padding-top: 3px;">
                                                        <ext:TextArea ID="txtMAWBRemark" runat="server" Width="260" Height="46" Cls="text_80px"
                                                            TabIndex="16">
                                                        </ext:TextArea>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="455" valign="top">
                            <div id="div_top" style="margin-top: 115px;">
                                <table width="301px" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                                    <tbody>
                                        <tr>
                                            <td width="288" class="font_11bold_1542af" style="padding-left: 5px;">Action
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table width="260" height="35" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td width="88" class="table" style="padding-bottom: 5px; padding-top: 5px">
                                                <table border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="Center">
                                                                <%--<ext:Button ID="btnNext" runat="server" Cls="Submit_65px" Text=" Next " Width="70px">
                                                                <DirectEvents>
                                                                    <Click OnEvent="btnNext_Click">
                                                                        <EventMask ShowMask="true" Msg=" Saving ... " />
                                                                        <ExtraParams>
                                                                            <ext:Parameter Name="gridHBL" Value="Ext.encode(#{gridHBL}.getRowsValues())" Mode="Raw">
                                                                            </ext:Parameter>
                                                                            <ext:Parameter Name="gridInvoice" Value="Ext.encode(#{gridInvoice}.getRowsValues())"
                                                                                Mode="Raw">
                                                                            </ext:Parameter>
                                                                            <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                            </ext:Parameter>
                                                                        </ExtraParams>
                                                                    </Click>
                                                                </DirectEvents>
                                                            </ext:Button>--%>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td width="76" class="table">
                                                <table border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" style="padding-left: 2px">
                                                                <ext:Button ID="btnVoid" runat="server" Cls="Submit_65px" Text="Void" Width="70px">
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnVoid_Click">
                                                                        </Click>
                                                                    </DirectEvents>
                                                                </ext:Button>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td width="66" class="table">
                                                <table border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" style="padding-left: 2px">
                                                                <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Text=" Cancel " Width="70px">
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnCancel_Click">
                                                                            <EventMask ShowMask="true" Msg=" Loading ... " />
                                                                        </Click>
                                                                    </DirectEvents>
                                                                </ext:Button>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td width="100" class="table">
                                                <table border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" style="padding-left: 2px">
                                                                <ext:Button ID="btnSave" runat="server" Cls="Submit_65px" Text=" Save " Width="70px">
                                                                    <Listeners>
                                                                        <Click Handler="return (ReturnNull()&&ValidataText());" />
                                                                    </Listeners>
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnSave_Click">
                                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                                            <ExtraParams>
                                                                                <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                                </ext:Parameter>
                                                                                <ext:Parameter Name="gridHBL" Value="Ext.encode(#{gridHBL}.getRowsValues())" Mode="Raw">
                                                                                </ext:Parameter>
                                                                                <ext:Parameter Name="gridInvoice" Value="Ext.encode(#{gridInvoice}.getRowsValues())"
                                                                                    Mode="Raw">
                                                                                </ext:Parameter>
                                                                            </ExtraParams>
                                                                        </Click>
                                                                    </DirectEvents>
                                                                </ext:Button>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                        <td valign="top" align="left" style="padding-top: 77px">
                            <table cellpadding="0" cellspacing="4" border="0">
                                <tr>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="padding-left: 2px">CFS Closing
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 90px" class="font_11px_gray">
                                        <ext:DateField ID="txtCFSClosing" runat="server" Width="88" Cls="text_80px" Format="d/m/Y"
                                            TabIndex="16">
                                        </ext:DateField>
                                    </td>
                                    <td style="padding-left: 3px">CY Closing
                                    </td>
                                    <td style="width: 90px">
                                        <ext:DateField ID="txtCYClosing" runat="server" Width="88" Cls="text_80px" Format="d/m/Y"
                                            TabIndex="17">
                                        </ext:DateField>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-top: 3px; padding-left: 2px; vertical-align: top">Onboard<span class="font_red" style="padding-left: 3px; padding-right: 5px">*</span>
                                    </td>
                                    <td align="left" class="font_11px_gray">
                                        <ext:DateField ID="txtOnBoard" runat="server" Width="88" Cls="text_100px" Format="d/m/Y"
                                            TabIndex="18">
                                        </ext:DateField>
                                    </td>
                                    <td style="padding-top: 3px; padding-left: 3px; vertical-align: top">ETD<span class="font_red" style="padding-left: 3px; padding-right: 5px">*</span>
                                    </td>
                                    <td class="font_11px_gray">
                                        <ext:DateField ID="txtETD" runat="server" Width="88" Cls="text_100px" Format="d/m/Y"
                                            TabIndex="19">
                                        </ext:DateField>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 2px">ETA Discharge
                                    </td>
                                    <td class="font_11px_gray">
                                        <ext:DateField ID="txtETADischarge" runat="server" Width="88" Format="d/m/Y" Cls="text_100px"
                                            TabIndex="20">
                                        </ext:DateField>
                                    </td>
                                    <td style="padding-left: 3px">ETA Final
                                    </td>
                                    <td class="font_11px_gray">
                                        <ext:DateField ID="txtETAFinal" runat="server" Width="88" Format="d/m/Y" Cls="text_100px"
                                            TabIndex="21">
                                        </ext:DateField>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 2px; padding-top: 2px; vertical-align: top">ATD
                                    </td>
                                    <td class="font_11px_gray">
                                        <ext:DateField ID="txtATD" runat="server" Width="88" Cls="text_100px" Format="d/m/Y"
                                            TabIndex="22">
                                        </ext:DateField>
                                    </td>
                                </tr>
                                <tr style="<%if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[12].ToString().ToUpper() == "CON/HKG") { Response.Write("display:none"); }%>">
                                    <td class="font_11bold" style="padding-left: 2px; vertical-align: top; padding-top: 10px;">Declare Remark
                                    </td>
                                    <td class="font_11px_gray" style="vertical-align: top; padding-top: 8px;" colspan="3">
                                        <ext:TextArea ID="txtclpRemark" runat="server" Width="225" Height="46" Cls="text_80px"
                                            TabIndex="22">
                                        </ext:TextArea>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" width="969">
                <tr>
                    <td colspan="2" height="5"></td>
                </tr>
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td valign="top">
                                    <table width="670" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                                        style="border-left: 1px solid #8db2e3; border-right: 1px solid #8db2e3; border-top: 1px solid #8db2e3;">
                                        <tbody>
                                            <tr>
                                                <td width="670" align="left" valign="top" bgcolor="#FFFFFF" background="../../../images/bg_line_3.jpg">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tbody>
                                                            <tr>
                                                                <td width="48%" align="left" class="font_11bold_1542af" style="padding-left: 5px; line-height: 26px; height: 26px">HBL List
                                                                </td>
                                                                <td width="52%" align="right" class="nav_menu_4" style="padding-right: 2px; padding-bottom: 1px">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <ext:Button ID="btnAddBooking" Text="Add Booking" runat="server" Width="100">
                                                                                    <DirectEvents>
                                                                                        <Click OnEvent="btnAddBooking_Click">
                                                                                            <ExtraParams>
                                                                                                <ext:Parameter Name="p_safety_HBL" Value="Ext.encode(#{gridHBL}.getRowsValues())"
                                                                                                    Mode="Raw" />
                                                                                            </ExtraParams>
                                                                                        </Click>
                                                                                    </DirectEvents>
                                                                                </ext:Button>
                                                                            </td>
                                                                            <td>
                                                                                <ext:Button ID="btnNewBooking" Text="New Booking" runat="server" Width="100">
                                                                                    <DirectEvents>
                                                                                        <Click OnEvent="btnNewBooking_Click">
                                                                                            <EventMask ShowMask="true" Msg="Waiting..." Target="Page" />
                                                                                            <ExtraParams>
                                                                                                <ext:Parameter Name="p_safety_HBL" Value="Ext.encode(#{gridHBL}.getRowsValues())"
                                                                                                    Mode="Raw" />
                                                                                            </ExtraParams>
                                                                                        </Click>
                                                                                    </DirectEvents>
                                                                                </ext:Button>
                                                                            </td>
                                                                            <td>
                                                                                <ext:Button ID="btnPull" runat="server" Text="Pull Back">
                                                                                    <Listeners>
                                                                                        <Click Handler="DeleteHBL(#{gridHBL});" />
                                                                                    </Listeners>
                                                                                </ext:Button>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" id="GridView_1">
                                    <ext:GridPanel runat="server" ID="gridHBL" TrackMouseOver="true" Width="670" Height="150">
                                        <LoadMask ShowMask="true" Msg=" Loading ... " />
                                        <Store>
                                            <ext:Store runat="server" ID="storeHBL">
                                                <Reader>
                                                    <ext:JsonReader IDProperty="o_ROWID">
                                                        <Fields>
                                                            <ext:RecordField Name="o_ROWID">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_Seed">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_ScheduleDate" Type="Date">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="ActReceipt" Type="Date">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_BookNo">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_HBL">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_Shipper">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_Consignee">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_LocFinal">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_ServiceMode">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_PKGS">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_Unit">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_WT">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_WM">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_CBM">
                                                            </ext:RecordField>
                                                            <ext:RecordField Name="o_PaymentMode">
                                                            </ext:RecordField>
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                        </Store>
                                        <ColumnModel runat="server" ID="ctl1762">
                                            <Columns>
                                                <ext:DateColumn Header="Onboard" DataIndex="o_ScheduleDate" Width="76" Format="dd/m/Y">
                                                </ext:DateColumn>
                                                <ext:DateColumn Header="Act Receipt" DataIndex="ActReceipt" Width="76" Format="dd/m/Y"
                                                    Hidden="true">
                                                    <%-- <Editor>
                               <ext:DateField runat="server" ID="actReceipt"></ext:DateField>
                               </Editor>--%>
                                                </ext:DateColumn>
                                                <ext:Column Header="Booking#" DataIndex="o_BookNo" Width="116" Align="Center">
                                                </ext:Column>
                                                <ext:Column Header="HBL#" DataIndex="o_HBL" Width="85" Align="Center">
                                                </ext:Column>
                                                <ext:Column Header="Shipper" DataIndex="o_Shipper" Width="70" Align="Center">
                                                </ext:Column>
                                                <ext:Column Header="Consignee" DataIndex="o_Consignee" Width="97" Hidden="true">
                                                </ext:Column>
                                                <ext:Column Header="Dest" DataIndex="o_LocFinal" Width="40" Align="Center">
                                                </ext:Column>
                                                <ext:Column Header="S. Mode" DataIndex="o_ServiceMode" Width="58" Align="Center">
                                                </ext:Column>
                                                <ext:NumberColumn Header="PKGS" DataIndex="o_PKGS" Width="55" Format="0" Align="Right">
                                                </ext:NumberColumn>
                                                <ext:Column Header="Unit" DataIndex="o_Unit" Width="55" Hidden="true">
                                                </ext:Column>
                                                <ext:NumberColumn Header="WT" DataIndex="o_WT" Width="55" Format="0.000" Align="Right">
                                                </ext:NumberColumn>
                                                <ext:NumberColumn Header="CBM" DataIndex="o_CBM" Width="55" Format="0.000" Align="Right">
                                                </ext:NumberColumn>
                                                <ext:NumberColumn Header="WM" DataIndex="o_WM" Width="55" Format="0.000" Align="Right"
                                                    Hidden="true">
                                                </ext:NumberColumn>
                                                <ext:Column Header="P/C" DataIndex="o_PaymentMode" Width="35" Align="Center">
                                                </ext:Column>
                                                <ext:Column Header="ID" DataIndex="o_ROWID" Hidden="true">
                                                </ext:Column>
                                                <ext:Column Header="Seed" DataIndex="o_Seed" Hidden="true">
                                                </ext:Column>
                                            </Columns>
                                        </ColumnModel>
                                        <SelectionModel>
                                            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
                                            </ext:RowSelectionModel>
                                        </SelectionModel>
                                    </ext:GridPanel>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <table width="670" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                                        style="border-left: 1px solid #8db2e3; border-right: 1px solid #8db2e3; border-bottom: 1px solid #8db2e3;">
                                        <tbody>
                                            <tr>
                                                <td width="664" valign="middle" bgcolor="#FFFFFF" background="../../../images/bg_line_3.jpg">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td></td>
                                                            <td width="55px" align="right">
                                                                <ext:Label runat="server" ID="totalPiece">
                                                                </ext:Label>
                                                            </td>
                                                            <td width="55px" align="right">
                                                                <ext:Label runat="server" ID="totalGWT">
                                                                </ext:Label>
                                                            </td>
                                                            <td width="55px" align="right">
                                                                <ext:Label runat="server" ID="totalCBM">
                                                                </ext:Label>
                                                            </td>
                                                            <td width="60px"></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" align="left" style="padding-left: 6px">
                        <table cellpadding="0" cellspacing="0" border="0" width="299">
                            <tr>
                                <td>
                                    <table width="303px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                                        <tr>
                                            <td align="left" background="../../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                                style="padding-left: 5px"></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 292px; padding-top: 5px">
                                        <tr>
                                            <td></td>
                                            <td style="padding-top: 5px; padding-left: 20px" align="left">Actual
                                            </td>
                                            <td style="padding-top: 5px; padding-right: 35px" align="left">Charge
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-top: 5px; padding-left: 6px">
                                                <table cellpadding="0" cellspacing="0" border="0" width="68px">
                                                    <tr>
                                                        <td>Piece(s)
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 5px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>
                                                            <ext:NumberField ID="txtAPiece" runat="server" Width="78" DecimalPrecision="0" StyleSpec="text-align:right"
                                                                Cls="select_160px" Disabled="true">
                                                            </ext:NumberField>
                                                        </td>
                                                        <td colspan="3" style="padding-left: 2px">
                                                            <ext:NumberField ID="txtCPiece" runat="server" Width="78" DecimalPrecision="0" AllowNegative="false"
                                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="22">
                                                            </ext:NumberField>
                                                        </td>
                                                        <td style="padding-left: 2px">
                                                            <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                                                StyleSpec="text-align:right" isButton="false" TabIndex="23" Query="option=UnitBinding"
                                                                StoreID="StoreUnit" Width="55" winTitle="Unit" winUrl="/BasicData/Unit/list.aspx"
                                                                winWidth="510" winHeight="585" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-top: 5px; padding-left: 6px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>WT
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 5px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>
                                                            <ext:NumberField ID="txtAGWT" runat="server" Width="78" DecimalPrecision="3" StyleSpec="text-align:right"
                                                                Cls="select_160px" Disabled="true">
                                                            </ext:NumberField>
                                                        </td>
                                                        <td colspan="3" style="padding-left: 2px">
                                                            <ext:NumberField ID="txtCGWT" runat="server" Width="78" DecimalPrecision="3" AllowNegative="false"
                                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="24">
                                                                <Listeners>
                                                                    <Blur Handler="var wt=#{txtCGWT}.getValue()!=''?#{txtCGWT}.getValue():#{txtAGWT}.getValue();var cbm=#{txtCCBM}.getValue()!=''?#{txtCCBM}.getValue():#{txtACBM}.getValue(); if(wt!=''){ if(cbm==''){#{txtCWM}.setValue(wt*1.0000/1000)} else{if(wt>cbm*1000){#{txtCWM}.setValue(wt*1.0000/1000)}else{#{txtCWM}.setValue(cbm)}} } else { if(cbm!=''){#{txtCWM}.setValue(cbm)}}" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-top: 5px; padding-left: 6px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>CBM
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 5px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>
                                                            <ext:NumberField ID="txtACBM" runat="server" Width="78" DecimalPrecision="3" StyleSpec="text-align:right"
                                                                Cls="select_160px" Disabled="true">
                                                            </ext:NumberField>
                                                        </td>
                                                        <td colspan="3" style="padding-left: 2px">
                                                            <ext:NumberField ID="txtCCBM" runat="server" Width="78" DecimalPrecision="3" AllowNegative="false"
                                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="25">
                                                                <Listeners>
                                                                    <Change Handler="var wt=#{txtCGWT}.getValue()!=''?#{txtCGWT}.getValue():#{txtAGWT}.getValue();var cbm=#{txtCCBM}.getValue()!=''?#{txtCCBM}.getValue():#{txtACBM}.getValue();if(cbm!=''){if(wt==''){#{txtCWM}.setValue(cbm)}else{ if(wt>cbm*1000){#{txtCWM}.setValue(wt*1.0000/1000)}else{#{txtCWM}.setValue(cbm)} }} else{ if(wt!=''){#{txtCWM}.setValue(wt*1.0000/1000)}};#{txtCWM}.focus(true);" />
                                                                </Listeners>
                                                            </ext:NumberField>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-top: 5px; padding-left: 6px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>WM
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 5px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>
                                                            <ext:NumberField ID="txtAWM" runat="server" Width="78" DecimalPrecision="3" StyleSpec="text-align:right"
                                                                Cls="select_160px" Disabled="true">
                                                            </ext:NumberField>
                                                        </td>
                                                        <td colspan="3" style="padding-left: 2px">
                                                            <ext:NumberField ID="txtCWM" runat="server" Width="78" DecimalPrecision="3" AllowNegative="false"
                                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="26">
                                                            </ext:NumberField>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="padding-top: 5px; padding-left: 6px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>Container
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td colspan="5" style="padding-top: 5px">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td>
                                                            <ext:NumberField ID="txtContainer" runat="server" Width="78" DecimalPrecision="4"
                                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="46" Disabled="true">
                                                            </ext:NumberField>
                                                        </td>
                                                        <td colspan="3" style="padding-left: 2px"></td>
                                                        <td></td>
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
                    <td height="5"></td>
                    <td valign="top" align="left" style="padding-left: 5px"></td>
                </tr>
                <tr>
                    <td valign="top" id="GridView_2">
                        <ext:GridPanel runat="server" ID="gridInvoice" TrackMouseOver="true" Width="670"
                            Height="169" Title="Local Invoice" Footer="true" Header="true">
                            <LoadMask ShowMask="true" Msg=" Loading ... " />
                            <Store>
                                <ext:Store runat="server" ID="StoreInvoice">
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
                                                <ext:RecordField Name="CompanyCode" Type="String">
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
                            <ColumnModel ID="ColumnModel1">
                                <Columns>
                                    <ext:RowNumbererColumn Header="No." Width="30">
                                    </ext:RowNumbererColumn>
                                    <ext:CheckColumn Header="DN" Width="30" DataIndex="DN" Align="Center">
                                    </ext:CheckColumn>
                                    <ext:CheckColumn Header="CN" Width="30" DataIndex="CN" Align="Center">
                                    </ext:CheckColumn>
                                    <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="125">
                                    </ext:Column>
                                    <ext:Column Header="Company" DataIndex="CompanyName" Width="214">
                                    </ext:Column>
                                    <ext:Column Header="CUR" DataIndex="Currency" Width="40" Align="Center">
                                    </ext:Column>
                                    <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right" Format="0.00">
                                    </ext:NumberColumn>
                                    <ext:NumberColumn Header="RowID" DataIndex="RowID" Hidden="true" Width="0">
                                    </ext:NumberColumn>
                                    <ext:CheckColumn Header="Print" Width="38" DataIndex="Print" Align="Center">
                                    </ext:CheckColumn>
                                    <ext:CheckColumn Header="Void" Width="38" DataIndex="Void" Align="Center">
                                    </ext:CheckColumn>
                                    <ext:CheckColumn Header="AC" Width="30" DataIndex="AC" Align="Center">
                                    </ext:CheckColumn>
                                    <%--<ext:ImageCommandColumn Header="Action" Width="48" Align="Center" Hidden="true">
                                    <Commands>
                                        <ext:ImageCommand Icon="BinEmpty" ToolTip-Text="Delete" CommandName="Delete" Style="background-position: center center;
                                            width: 50px">
                                            <ToolTip Text="Delete"></ToolTip>
                                        </ext:ImageCommand>
                                    </Commands>
                                </ext:ImageCommandColumn>--%>
                                </Columns>
                            </ColumnModel>
                            <%--<Listeners>
                            <Command Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') {#{gridInvoice}.getSelectionModel().selectRow(rowIndex);#{gridInvoice}.deleteSelected();#{gridInvoice}.view.focusEl.focus();}})" />
                        </Listeners>--%>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel2" runat="server">
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <%-- <KeyMap>
                            <ext:KeyBinding Ctrl="true">
                                <Keys>
                                    <ext:Key Code="DELETE" />
                                </Keys>
                                <Listeners>
                                    <Event Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') {#{gridInvoice}.deleteSelected();} #{gridInvoice}.view.focusEl.focus();})" />
                                </Listeners>
                            </ext:KeyBinding>
                        </KeyMap>--%>
                        </ext:GridPanel>
                    </td>
                    <td valign="top" style="padding-left: 6px">
                        <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="117" />
                    </td>
                </tr>
                <tr>
                    <td height="5" colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <%-- gridCost  --%>
                        <uc1:Costing ID="ucCost" runat="server" type="M" sys="OE" />
                    </td>
                </tr>
                <tr>
                    <td class="style2">&nbsp;
                    </td>
                    <td>&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <ext:Window runat="server" ID="windowPrecarriage" Title="Pre-Carriage" Width="355" Height="110" Resizable="False" PageX="325" PageY="275" Padding="10" Hidden="true">
            <Content>
                <table>
                    <tr>
                        <td align="left" valign="top" class="font_11bold">Vessel / Voyage
                        </td>
                        <td colspan="3" align="left" valign="top" style="padding-top: 4px">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td>
                                            <ext:ComboBox ID="cmbpreVessel" runat="server" Cls="select" Width="130" StoreID="StoreVessel"
                                                DisplayField="text" TabIndex="100" ValueField="value" Mode="Local" ForceSelection="true"
                                                TriggerAction="All">
                                                <DirectEvents>
                                                    <Select OnEvent="cmbVessel_Select">
                                                    </Select>
                                                </DirectEvents>
                                            </ext:ComboBox>
                                        </td>
                                        <td style="padding-left: 3px"></td>
                                        <td>
                                            <ext:ComboBox ID="cmbpreVoyage" runat="server" Cls="select" Width="107" StoreID="StorePreVoyage"
                                                ItemSelector="tr.list-item" ListWidth="130px" DisplayField="text" ValueField="value"
                                                Mode="Local" ForceSelection="true" TriggerAction="All" TabIndex="101">
                                                <DirectEvents>
                                                    <Select OnEvent="cmbVesselText_Select" />
                                                </DirectEvents>
                                            </ext:ComboBox>
                                        </td>
                                        <td style="text-align: left;">
                                            <img src="../../images/select_btn.jpg" width="18" height="18" class="cursor" alt=""
                                                onclick="CompanyX.ShowVoyage('pre');">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 5px;">Onboard</td>
                        <td style="padding-top: 5px;">
                            <ext:DateField ID="txtpreonboard" runat="server" Width="88" Cls="text_100px" TabIndex="102" Format="d/m/Y">
                            </ext:DateField>
                        </td>
                    </tr>
                </table>
            </Content>
        </ext:Window>
    </form>
</body>
</html>
