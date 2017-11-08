<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="Triangle_AirShipment_List" %>

<%@ Register Src="/common/UIControls/Costing.ascx" TagName="Costing" TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ OutputCache Duration="3600" VaryByParam="none" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/Autocomplete.ascx" TagName="Autocomplete"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/Transfer.ascx" TagName="Transfer" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Air Shipment</title>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../TriJs/triAir.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/UIControls/SysCheckHBLNO.js" type="text/javascript"></script>

    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <div id="div_title" style="width: 100%; z-index: 1000">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="A" />
    </div>
    <ext:Hidden ID="hidSeed" runat="server" Text="0">
    </ext:Hidden>
    <div id="div_title" style="margin-left: 10px; margin-top: 80px; z-index: 990">
        <table width="980" border="0" cellspacing="0" cellpadding="0" class="table_nav1 font_11bold_1542af">
            <tr>
                <td style="padding-left: 5px">
                    <table>
                        <tr>
                            <td>
                                <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('AT');" />&nbsp;
                            </td>
                            <td>
                                Triangle Shipment (Air)
                            </td>
                            <td>
                                &nbsp;<img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle;
                                    display: none;" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="right" style="padding-right: 5px;">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td style="padding-right: 5px;">
                                <ext:Button ID="btnUpdateLotNo" runat="server" Hidden="true" Text="Update Lot No."
                                    Cls="btnUpdateLotNo">
                                    <Listeners>
                                        <Click Handler="UpdatelotNo();" />
                                    </Listeners>
                                </ext:Button>
                            </td>
                            <td style="padding-right: 5px;">
                                <% if (!string.IsNullOrEmpty(Request["seed"])) { Response.Write("Lot# "); }%>
                            </td>
                            <td>
                                <ext:DisplayField runat="server" StyleSpec=" color:#ff0000" ID="labLotNo">
                                </ext:DisplayField>
                            </td>
                            <td>
                                <%if (!string.IsNullOrEmpty(Request["seed"]))
                                  { %>
                                <uc1:Transfer runat="server" ID="TransferSys" sys="AT" />
                                <%} %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <ext:Hidden ID="txtVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="txtcur_Rate" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLotNo" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidSetInformation" runat="server" Text="1">
    </ext:Hidden>
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
    <ext:Store runat="server" ID="StoreLocation" OnRefreshData="StoreLocation_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreUnit" OnRefreshData="StoreUnit_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreSalesman" OnRefreshData="StoreSalesman_OnRefreshData">
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
    <div id="mawb_div" runat="server" style="margin-bottom: 30px; margin-top: 70px">
        <table width="950" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align="left" valign="top">
                </td>
                <td width="488" rowspan="3" valign="top" style="padding-left: 4px; padding-top: 30px">
                    <div id="div_top" style="margin-top: 115px">
                        <table width="314" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                            <tr>
                                <td width="363" class="font_11bold_1542af" style="padding-left: 5px">
                                    Action
                                </td>
                            </tr>
                        </table>
                        <table width="260" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="88" class="table" style="padding-bottom: 5px; padding-top: 5px">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center">
                                                <ext:Button ID="btnNext" runat="server" Cls="Submit_65px" Text="Next" Width="65px">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnNext_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{gridInvoice}.getRowsValues())"
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
                                            <td align="center" style="padding-left: 3px">
                                                <ext:Button ID="btnVoid" runat="server" Cls="Submit_65px" Text="Void" Width="65px">
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
                                            <td align="center" style="padding-left: 3px">
                                                <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Text="Cancel" Width="65px">
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
                                            <td align="center" style="padding-left: 3px">
                                                <ext:Button ID="btnSave" runat="server" Cls="Submit_65px" Text="Save" Width="65px">
                                                    <Listeners>
                                                        <Click Handler="return (ReturnNull()&&ValidataText())" />
                                                    </Listeners>
                                                    <DirectEvents>
                                                        <Click OnEvent="btnSave_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{gridInvoice}.getRowsValues())"
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
                    <table width="305" border="0" cellpadding="0" cellspacing="1" bgcolor="#8DB2E3" class="table"
                        style="position: absolute; margin-top: 85px; margin-left: 0px;">
                        <tr>
                            <td align="center" bgcolor="#FFFFFF">
                                <table border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="center" class="font_11bold">
                                            <table cellpadding="0" cellspacing="0" border="0" width="63px">
                                                <tr>
                                                    <td align="center">
                                                        GWT
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="center" bgcolor="#FFFFFF" style="padding-left: 2px; padding-right: 2px;
                                width: 80px;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <ext:NumberField ID="txtGWT" runat="server" Cls="text" DecimalPrecision="1" StyleSpec="text-align:right"
                                                TabIndex="15" Width="90">
                                                <Listeners>
                                                    <Change Handler="if(#{txtGWT}.getValue(true)>=#{txtVWT}.getValue(true)){#{txtCWT}.setValue(#{txtGWT}.getValue(true))} else{#{txtCWT}.setValue(#{txtVWT}.getValue(true))}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="65" align="center" bgcolor="#FFFFFF">
                                <table width="62" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center" class="font_11bold">
                                            Piece(s)
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="center" bgcolor="#FFFFFF" style="padding-left: 2px; padding-right: 2px">
                                <ext:NumberField ID="txtPiece" runat="server" Cls="text" AllowDecimals="false" StyleSpec="text-align:right"
                                    TabIndex="18">
                                </ext:NumberField>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                VWT
                            </td>
                            <td align="center" bgcolor="#FFFFFF">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <ext:NumberField ID="txtVWT" runat="server" Cls="text" DecimalPrecision="1" StyleSpec="text-align:right"
                                                TabIndex="16" Width="90">
                                                <Listeners>
                                                    <Change Handler="if(#{txtGWT}.getValue(true)>=#{txtVWT}.getValue(true)){#{txtCWT}.setValue(#{txtGWT}.getValue(true))} else{#{txtCWT}.setValue(#{txtVWT}.getValue(true))}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                </table>
                                <td align="center" bgcolor="#FFFFFF">
                                    <table width="60" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" class="font_11bold">
                                                Unit
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="center" bgcolor="#FFFFFF" style="padding-left: 2px; padding-right: 2px">
                                    <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                        StoreID="StoreUnit" Width="67" winTitle="Unit" TabIndex="19" winUrl="/BasicData/Unit/list.aspx?sys=A"
                                        winWidth="510" winHeight="585" />
                                </td>
                        </tr>
                        <tr>
                            <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                CWT
                            </td>
                            <td align="center" bgcolor="#FFFFFF">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <ext:NumberField ID="txtCWT" runat="server" Cls="text" DecimalPrecision="1" StyleSpec="text-align:right"
                                                TabIndex="17" Width="90">
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                </table>
                                <td align="center" bgcolor="#FFFFFF">
                                    <table width="60" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" class="font_11bold">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="center" bgcolor="#FFFFFF">
                                </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" style="padding-top: 38px; padding-left: 6px; width: 624px">
                    <table width="624px" border="0" cellpadding="0" cellspacing="0" style="margin-top: 8px;">
                        <tr style="height: 24px">
                            <td align="left" valign="middle" style="padding-left: 2px">
                                MAWB #
                            </td>
                            <td align="left" class="font_11px_gray">
                                <ext:TextField ID="txtMAWB" runat="server" Cls="text_82px" Width="88" TabIndex="1">
                                </ext:TextField>
                            </td>
                            <td align="left" style="width: 60px; text-align: left; padding-left: 3px;">
                                HAWB #
                            </td>
                            <td align="left">
                                <ext:TextField ID="txtHAWB" runat="server" Cls="text_110px" Width="110" TabIndex="2">
                                    <Listeners>
                                        <Blur Handler="CheckHBLNo(this,'AT',hidSeed.getValue())" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0" width="63">
                                    <tr>
                                        <td class="font_11bold" style="padding-left: 10px; padding-right: 2px;">
                                            Sales<span class="font_red" style="padding-left: 2px">*</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left">
                                <uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="3" Query="option=SalesList"
                                    Width="69" clsClass="select_65" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                    winWidth="680" winHeight="560" />
                            </td>
                            <td class="font_11bold" style="padding-left: 9px; padding-right: 2px;">
                                Job Date
                            </td>
                            <td align="left">
                                <ext:DateField ID="txtJob" runat="server" Cls="text" Width="88" Format="d/m/Y" TabIndex="4">
                                </ext:DateField>
                            </td>
                        </tr>
                        <tr style="height: 24px">
                            <td>
                                <table width="71px">
                                    <tr>
                                        <td>
                                            Shipper
                                        </td>
                                        <td class="font_red" align="right">
                                            *
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <uc1:Autocomplete runat="server" ID="CmbShipperCode" TabIndex="5" Width="61" clsClass="text_82px"
                                                winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800"
                                                Query="option=CompanyList" isDiplay="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" colspan="2" style="padding-left: 4px; padding-bottom: 1px">
                                <ext:TextField ID="CmbShipperCode_name" runat="server" Cls="text_82px" Width="169"
                                    TabIndex="5">
                                </ext:TextField>
                                <ext:Hidden ID="CmbShipperCode1" runat="server">
                                </ext:Hidden>
                            </td>
                            <td align="left" class="font_11bold" style="padding-left: 10px">
                                Carrier
                            </td>
                            <td align="left">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <uc1:Autocomplete runat="server" ID="CmbCarrierCode" clsClass="input text_82px" TabIndex="11"
                                                Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800"
                                                winHeight="800" Query="option=CompanyList" isDiplay="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" colspan="2" style="padding-left: 4px">
                                <ext:TextField ID="CmbCarrierCode_name" runat="server" Cls="text_82px" Width="150"
                                    TabIndex="11">
                                </ext:TextField>
                                <ext:Hidden ID="CmbCarrierCode1" runat="server">
                                </ext:Hidden>
                            </td>
                            <td colspan="4" style="border: solid 1px #fff; padding: 5px 0px 0px 0px;">
                            </td>
                        </tr>
                        <tr style="height: 24px">
                            <td>
                                <table width="71px">
                                    <tr>
                                        <td>
                                            Consignee
                                        </td>
                                        <td class="font_red" align="right">
                                            *
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <uc1:Autocomplete runat="server" ID="CmbConsigneeCode" Query="option=CompanyList"
                                                TabIndex="6" Width="61" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" isDiplay="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" colspan="2" style="padding-left: 4px; padding-bottom: 1px">
                                <ext:TextField ID="CmbConsigneeCode_name" runat="server" Cls="text_82px" Width="169"
                                    TabIndex="6">
                                </ext:TextField>
                                <ext:Hidden ID="CmbConsigneeCode1" runat="server">
                                </ext:Hidden>
                            </td>
                            <td class="font_11bold" style="text-align: left; padding-left: 10px">
                                Flight No.
                            </td>
                            <td align="left">
                                <ext:TextField ID="txtFlightNo" runat="server" Cls="text_82px" Width="90" TabIndex="12">
                                </ext:TextField>
                            </td>
                            <td colspan="2">
                            </td>
                        </tr>
                        <tr style="height: 24px">
                            <td align="left" style="padding-left: 2px">
                                Notify #1
                            </td>
                            <td align="left">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <uc1:Autocomplete runat="server" ID="CmbNotify1Code" Query="option=CompanyList" TabIndex="7"
                                                Width="61" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" isDiplay="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" colspan="2" style="padding-left: 4px; padding-bottom: 1px">
                                <ext:TextField ID="CmbNotify1Code_name" runat="server" Cls="text_82px" Width="169"
                                    TabIndex="7">
                                </ext:TextField>
                                <ext:Hidden ID="CmbNotify1Code1" runat="server">
                                </ext:Hidden>
                            </td>
                            <td class="font_11bold" style="padding-left: 10px; padding-right: 2px;">
                                Departure
                            </td>
                            <td align="left">
                                <uc1:UserComboBox runat="server" ID="CmbDeparture" ListWidth="180" clsClass="select_160px"
                                    TabIndex="13" StoreID="StoreLocation" Width="69" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                    winWidth="845" winHeight="620" Handler="SelectItem('CmbDeparture','txtDepL')" />
                            </td>
                            <td class="font_11bold" style="text-align: left; padding-left: 4px" colspan="2">
                                <ext:TextField ID="txtDepL" runat="server" Cls="text_82px" Width="150" TabIndex="13">
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr style="height: 24px">
                            <td align="left" style="padding-left: 2px">
                                Notify #2
                            </td>
                            <td align="left">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <uc1:Autocomplete runat="server" ID="CmbNotify2Code" Query="option=CompanyList" TabIndex="8"
                                                Width="61" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" isDiplay="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" colspan="2" style="padding-left: 4px; padding-bottom: 1px">
                                <ext:TextField ID="CmbNotify2Code_name" runat="server" Cls="text_82px" Width="169"
                                    TabIndex="8">
                                </ext:TextField>
                                <ext:Hidden ID="CmbNotify2Code1" runat="server">
                                </ext:Hidden>
                            </td>
                            <td class="font_11bold" style="padding-left: 10px; padding-right: 2px;">
                                Dest
                            </td>
                            <td align="left">
                                <uc1:UserComboBox runat="server" ID="CmbDest" ListWidth="180" clsClass="select_160px"
                                    TabIndex="14" StoreID="StoreLocation" Width="69" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                    winWidth="845" winHeight="620" Handler="SelectItem('CmbDest','txtDesL')" />
                            </td>
                            <td class="font_11bold" style="text-align: left; padding-left: 4px" colspan="2">
                                <ext:TextField ID="txtDesL" runat="server" Cls="text_82px" Width="150" TabIndex="14">
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr style="height: 24px">
                            <td style="padding-left: 2px">
                                Co-Loader
                            </td>
                            <td align="left">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <uc1:Autocomplete runat="server" ID="CmbCoLoader" clsClass="input text_82px" TabIndex="9"
                                                Width="61" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800"
                                                winHeight="800" Query="option=CompanyList" isDiplay="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" colspan="2" style="padding-left: 4px; padding-bottom: 1px">
                                <ext:TextField ID="CmbCoLoader_name" runat="server" Cls="text_82px" Width="169" TabIndex="9">
                                </ext:TextField>
                                <ext:Hidden ID="CmbCoLoader1" runat="server">
                                </ext:Hidden>
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0" width="76">
                                    <tr>
                                        <td class="font_11bold" style="padding-left: 10px; padding-right: 2px;">
                                            ETD<span class="font_red" style="padding-left: 2px">*</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left">
                                <ext:DateField ID="txtDepartDate" runat="server" Cls="text" Width="90" Format="d/m/Y"
                                    TabIndex="14">
                                </ext:DateField>
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0" width="66">
                                    <tr>
                                        <td class="font_11bold" style="text-align: left; padding-left: 9px">
                                            ETA<span class="font_red" style="padding-left: 2px">*</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left">
                                <ext:DateField ID="txtArrivalDate" runat="server" Cls="text" Width="88" Format="d/m/Y"
                                    TabIndex="14">
                                </ext:DateField>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table id="table1" width="800px" border="0" cellpadding="0" cellspacing="0" style="padding-top: 15px">
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr id="grid3">
                <td valign="top" id="GridView_2">
                    <table cellpadding="0" cellspacing="0" width="660">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                height: 25px">
                                Local Invoice
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="gridInvoice" runat="server" Width="660" Height="160" TrackMouseOver="true"
                                    ColumnLines="True">
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
                                    <ColumnModel ID="ColumnModel2">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:CheckColumn Header="CN" Width="30" DataIndex="CN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="DN" Width="30" DataIndex="DN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:Column Header="Bill To" DataIndex="CompanyName" Width="180">
                                            </ext:Column>
                                            <ext:Column Header="Invoice/Credit #" DataIndex="DN_CNNO" Width="140">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="40" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right">
                                            </ext:NumberColumn>
                                            <ext:CheckColumn Header="Print" DataIndex="Print" Width="40" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="Void" DataIndex="Void" Width="39" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="AC" DataIndex="AC" Width="39" Align="Center">
                                            </ext:CheckColumn>
                                            <%-- <ext:ImageCommandColumn Header="Action" Width="48" Align="Center">
                                                <Commands>
                                                    <ext:ImageCommand Icon="BinEmpty" ToolTip-Text="Delete" CommandName="Delete" Style="background-position: center center;
                                                        width: 60px">
                                                        <ToolTip Text="Delete"></ToolTip>
                                                    </ext:ImageCommand>
                                                </Commands>
                                            </ext:ImageCommandColumn>--%>
                                        </Columns>
                                    </ColumnModel>
                                    <%--  <Listeners>
                                        <Command Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') {#{gridInvoice}.getSelectionModel().selectRow(rowIndex);#{gridInvoice}.deleteSelected();#{gridInvoice}.getView().refresh();#{gridInvoice}.view.focusEl.focus();}})" />
                                    </Listeners>
                                    <KeyMap>
                                        <ext:KeyBinding Ctrl="true">
                                            <Keys>
                                                <ext:Key Code="DELETE" />
                                            </Keys>
                                            <Listeners>
                                                <Event Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') {#{gridInvoice}.deleteSelected();} #{gridInvoice}.getView().refresh();#{gridInvoice}.view.focusEl.focus();})" />
                                            </Listeners>
                                        </ext:KeyBinding>
                                    </KeyMap>--%>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="RowSelect">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 1px;">
                     <table width="300" border="0" align="left" cellpadding="0" cellspacing="0">
                     <tr>
                    <td width="60" align="left" class="font_11bold" style="padding-left: 0px;" valign="top">
                        Remark
                    </td>
                    <td style="padding-left: 13px;">
                        <ext:TextArea ID="txtMAWBRemark" runat="server" Width="258" Height="80" Cls="text_80px" TabIndex="15">
                        </ext:TextArea>
                    </td>
                    </tr>
                    </table>
                    <table width="316" border="0" align="left" cellpadding="0" cellspacing="0" style="display: none;">
                        <tr>
                            <td align="left">
                                <table width="316" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                                    <tr>
                                        <td class="font_11bold_1542af" style="padding-left: 5px; height: 25px; line-height: 25px">
                                            New Invoice
                                        </td>
                                    </tr>
                                </table>
                                <table border="0" align="left" cellpadding="0" cellspacing="4" class="select_142px">
                                    <tr>
                                        <td height="5" colspan="4" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="0" align="left" style="padding-left: 4px; padding-top: 2px; vertical-align: text-top"
                                            class="font_11bold">
                                            Company
                                        </td>
                                        <td height="0" align="left">
                                            <uc1:Autocomplete runat="server" ID="CmbCompanyRightCode" Query="option=CompanyList"
                                                isAlign="false" clsClass="text_82px" Width="63" TabIndex="20" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="0" align="left" valign="top" style="padding-top: 2px">
                                            <table width="59px" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 4px">
                                                        Currency
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="0" colspan="3" align="left">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="60" class="font_11bold">
                                                        <ext:ComboBox ID="CmbCurrencyRight" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                                            TabIndex="21" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                            TriggerAction="All">
                                                            <Listeners>
                                                                <Select Handler="#{radForeign}.setValue(record.data.foreign); #{radLocal}.setValue(record.data.local)" />
                                                            </Listeners>
                                                        </ext:ComboBox>
                                                    </td>
                                                    <td width="12" align="center">
                                                    </td>
                                                    <td width="10">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="0" align="left">
                                            &nbsp;
                                        </td>
                                        <td height="0" colspan="3" align="left">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="18" valign="middle">
                                                        <ext:RadioGroup ID="rdNewInvoice" runat="server" SItemCls="x-check-group-base" Width="160px"
                                                            ReadOnly="true" Enabled="false" TabIndex="31">
                                                            <Items>
                                                                <ext:Radio runat="server" BoxLabel="Foreign" ID="radForeign">
                                                                </ext:Radio>
                                                                <ext:Radio runat="server" BoxLabel="Local" ID="radLocal">
                                                                </ext:Radio>
                                                            </Items>
                                                        </ext:RadioGroup>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="0" align="left">
                                            &nbsp;
                                        </td>
                                        <td height="0" colspan="3" align="left">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td class="btn_L">
                                                    </td>
                                                    <td>
                                                        <input onclick="if(ReturnNull()&&ValidataText()){AddInvoice('AT','CmbCompanyRightCode',CmbCurrencyRight,StoreCurrInvoice,'M')}"
                                                            type="button" style="cursor: pointer" class="btn_text btn_C" tabindex="21" value="New Invoice" />
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
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <uc1:Costing ID="ucCost" runat="server" type="M" sys="AT" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height: 30px;">
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
