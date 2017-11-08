<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hawb.aspx.cs" Inherits="AirImport_AIShipmentJobList_hawb" %>

<%@ Register Src="/common/UIControls/Costing.ascx" TagName="Costing" TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/Autocomplete.ascx" TagName="Autocomplete"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/Transfer.ascx" TagName="Transfer" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HAWB</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="AjaxServer/gridHAWB.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/UIControls/SysCheckHBLNO.js" type="text/javascript"></script>

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
        var cmbStoreItem = function(value) {
            var r = StoreItem.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }

            return r.data.text;
        }
        
    </script>

    <style type="text/css">
        #cos_Item_A
        {
            width:245px !important;
        }
        
        #ucCost_cos_Remark
        {
            width: 237px !important;
        }
        
        #ucCost_cos_Amount
        {
            width: 45px !important;
        }
        .tab_sheet
        {
            width:278px !important;
            margin-left:6px;
        }
        
        input[type="checkbox"] {
        height: 13px !important;
        }
        .style1
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            font-weight: bold;
            color: #1542af;
            height: 25px;
        }
        .style2
        {
            width: 23%;
        }
        .style3
        {
            width: 143px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_title" style="width: 100%; z-index: 1000">

        <script type="text/javascript">
            var cur = '<%=cur%>';
        </script>

        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="A" />
    </div>
    <div id="div_title" style="margin-left: 10px; margin-top: 80px; z-index: 990;">
        <table cellpadding="0" cellspacing="0" border="0" width="981px" class="table_nav1 font_11bold_1542af">
            <tr>
                <td style="padding-left: 5px;">
                    <table>
                        <tr>
                            <td>
                                <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('AI');" />
                                &nbsp; AI - HAWB Information&nbsp;
                                <img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle;" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="right" style="padding-right: 5px;">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td style="font-weight: bold">
                                MAWB#
                            </td>
                            <td style="padding-left: 5px;">
                                <nobr> <ext:Label ID="labMAWB" runat="server" StyleSpec=" color:#ff0000;font-weight: bold">
                    </ext:Label></nobr>
                            </td>
                            <td style="padding-left: 5px; font-weight: bold">
                                <nobr>Lot#</nobr>
                            </td>
                            <td style="padding-left: 5px;">
                                <nobr> <ext:Label ID="labLotNo" runat="server" StyleSpec=" color:#ff0000;font-weight: bold">
                    </ext:Label></nobr>
                            </td>
                            <td>
                                <%if (!string.IsNullOrEmpty(Request["seed"]))
                                  { %>
                                <uc1:Transfer runat="server" ID="TransferSys" sys="AI" type="H" />
                                <%} %>
                            </td>
                        </tr>
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
    <ext:Store runat="server" ID="StoreLocation" OnRefreshData="StoreLocation_OnrefreshData">
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
    <ext:Store runat="server" ID="StoreSalesman" OnRefreshData="StoreSalesman_OnrefreshData">
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
    <ext:Store runat="server" ID="StoreUnit" OnRefreshData="StoreUnit_OnrefreshData">
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
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="txtcur_Rate" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidMAWB" runat="server">
    </ext:Hidden>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    <div id="hawb_div" style="margin-top: 108px">
        <table width="690" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="baseline">
                    <table width="669px" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table width="550" border="0" cellpadding="0" cellspacing="4">
                                    <tr>
                                        <td>
                                            <table width="60px">
                                                <tr>
                                                    <td>
                                                        HAWB
                                                    </td>
                                                    <td class="font_red" align="right">
                                                        *
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="90" height="0">
                                            <ext:TextField ID="txtHawb" runat="server" Cls="select" Width="90" TabIndex="1" AllowBlank="false">
                                            <Listeners>
                                                <Blur Handler="CheckHBLNo(this,'AI',hidSeed.getValue())" />
                                            </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td height="0" style="padding-left: 2px">
                                            <table width="60" border="0" cellspacing="0" cellpadding="3">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Reference#
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="88" height="0">
                                            <ext:TextField ID="txtReference" runat="server" Cls="select" Width="85" TabIndex="2">
                                            </ext:TextField>
                                        </td>
                                        <td width="63" height="0" class="font_11bold">
                                            Clearance#
                                        </td>
                                        <td width="116" height="0">
                                            <ext:TextField ID="txtClearance" runat="server" Cls="select" Width="89" TabIndex="3">
                                            </ext:TextField>
                                        </td>
                                        <td width="7" height="0">
                                            &nbsp;
                                        </td>
                                        <td width="250px" rowspan="2" valign="top">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td align="left" >
                                                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td>
                                                                    <ext:Checkbox ID="chkInsurance" runat="server" TabIndex="13"  Height="18" BoxLabelStyle="position:absolute;left:545px;top:108px;" BoxLabel="Insurance">
                                                                    </ext:Checkbox>
                                                                </td>
                                                                <%--<td align="left">
                                                                    Insurance
                                                                </td>--%>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <table width="45" border="0" cellspacing="0" cellpadding="0" >
                                                            <tr>
                                                                <td>
                                                                    <ext:Checkbox ID="chkDG" runat="server" TabIndex="14"  Height="18" BoxLabelStyle="position:absolute;left:545px;top:126px;" BoxLabel="D/G">
                                                                    </ext:Checkbox>
                                                                </td>
                                                               <%-- <td align="left">
                                                                    D/G
                                                                </td>--%>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <table width="80" border="0" cellspacing="0" cellpadding="0" >
                                                            <tr>
                                                                <td>
                                                                    <ext:Checkbox ID="chkSurrender" runat="server" TabIndex="15" Height="18"  BoxLabelStyle="position:absolute;left:545px;top:144px;" BoxLabel="Surrender">
                                                                    </ext:Checkbox>
                                                                </td>
                                                                <%--<td align="left">
                                                                    Surrender
                                                                </td>--%>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="60px">
                                                <tr>
                                                    <td>
                                                        Receipt
                                                    </td>
                                                    <td class="font_red" align="right">
                                                        *
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="20">
                                            <table width="90" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="CmbReceipt" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="4" StoreID="StoreLocation" Width="69" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                                            winWidth="845" winHeight="620" />
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbReceipt" ListWidth="180" clsClass="select_160px"
                                                TabIndex="4"  StoreID="StoreCmb1" Width="69"
                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                winHeight="620" />--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" border="0" width="70px">
                                                <tr>
                                                    <td height="20" align="left" class="font_11bold" style="padding-left: 2px">
                                                        Final Dest.<span class="font_red" style="padding-left: 2px">*</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="20">
                                            <table width="88" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="CmbFinalDest" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="5" StoreID="StoreLocation" Width="64" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                                            winWidth="845" winHeight="620" />
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbFinalDest" ListWidth="180" clsClass="select_160px"
                                                TabIndex="5" Query="option=LocationList&sys=A" StoreID="StoreCmb1" Width="64"
                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                winHeight="620" />--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" border="0" width="70px">
                                                <tr>
                                                    <td height="20" class="font_11bold">
                                                        Salesman<span class="font_red" style="padding-left: 10px">*</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="20">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="6" Width="68" clsClass="select_65"
                                                            StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx?sys=A"
                                                            winWidth="680" winHeight="560" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="20">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="0" style="padding-left: 2px" class="font_11bold">
                                            Shipper
                                        </td>
                                        <td height="0" colspan="3">
                                            <table border="0" cellspacing="0" cellpadding="0" width="250px">
                                                <tr>
                                                    <td width="28%">
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbShipperCode" clsClass="select_160px" TabIndex="7" Query="option=Companylist"
                                                StoreID="StoreCmb3" Width="98" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />--%>
                                                        <uc1:Autocomplete runat="server" ID="CmbShipperCode" clsClass="x-form-text x-form-field text_82px"
                                                            TabIndex="7" Query="option=Companylist" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="0" class="font_11bold">
                                            Consignee
                                        </td>
                                        <td height="0" colspan="3">
                                            <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="28%">
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbConsignee" clsClass="select_160px" TabIndex="8" Query="option=Companylist"
                                                StoreID="StoreCmb3" Width="98" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />--%>
                                                        <uc1:Autocomplete runat="server" ID="CmbConsignee" clsClass="x-form-text x-form-field text_82px"
                                                            TabIndex="8" Query="option=Companylist" Width="62" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="0" style="padding-left: 2px">
                                            <table width="60" border="0" cellspacing="0" cellpadding="3">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Notify #1
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="0" colspan="3">
                                            <table border="0" cellspacing="0" cellpadding="0" width="250">
                                                <tr>
                                                    <td width="28%">
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbNotify1" clsClass="select_160px" TabIndex="9" Query="option=Companylist"
                                                StoreID="StoreCmb3" Width="98" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />--%>
                                                        <uc1:Autocomplete runat="server" ID="CmbNotify1" clsClass="x-form-text x-form-field text_82px"
                                                            TabIndex="9" Query="option=Companylist" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="0">
                                            <table width="55" border="0" cellspacing="0" cellpadding="3">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Notify #2
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="0" colspan="3">
                                            <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="28%">
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbNotify2" clsClass="select_160px" TabIndex="10" Query="option=Companylist"
                                                StoreID="StoreCmb3" Width="98" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" /> --%>
                                                        <uc1:Autocomplete runat="server" ID="CmbNotify2" clsClass="x-form-text x-form-field text_82px"
                                                            TabIndex="10" Query="option=Companylist" Width="62" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 2px">
                                            Co-Loader
                                        </td>
                                        <td height="0" colspan="3">
                                            <table border="0" cellspacing="0" cellpadding="0" width="250">
                                                <tr>
                                                    <td width="28%">
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbCoLoader" clsClass="select_160px" TabIndex="11" Query="option=Companylist"
                                                StoreID="StoreCmb3" Width="98" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" /> --%>
                                                        <uc1:Autocomplete runat="server" ID="CmbCoLoader" clsClass="x-form-text x-form-field text_82px"
                                                            TabIndex="11" Query="option=Companylist" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="0" class="font_11bold">
                                            Broker
                                        </td>
                                        <td height="0" colspan="3">
                                            <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="28%">
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbBroker" clsClass="select_160px" TabIndex="12"  Query="option=Companylist"
                                                StoreID="StoreCmb3" Width="98" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" /> --%>
                                                        <uc1:Autocomplete runat="server" ID="CmbBroker" clsClass="x-form-text x-form-field text_82px"
                                                            TabIndex="12" Query="option=Companylist" Width="62" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
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
                <td style="padding-top: 30px;"> <%--padding-left: 1px--%>
                    <table width="303px" height="25" border="0" cellpadding="0" cellspacing="0" style="position: absolute;left:688px;">
                        <tr style="background-color: #81b8ff">
                            <td colspan="2" align="left" background="../../images/bg_line_3.jpg" class="font_11bold_1542af"
                                style="padding-left: 5px; border: solid 1px #81b8ff; height: 25px">
                                Storage Information
                            </td>
                        </tr>
                        <tr>
                            <td height="5" colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table>
                                    <tr>
                                        <td valign="top" align="left" style="padding-left: 3px">
                                            <table width="76px">
                                                <tr>
                                                    <td>
                                                        Warehouse
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <%-- <uc1:UserComboBox runat="server" ID="CmbWarehouse" clsClass="select_53" TabIndex="21"  Query="option=Companylist"
                                      StoreID="StoreCmb3" Width="150" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                      winWidth="800" winHeight="800" /> --%>
                                            <uc1:Autocomplete runat="server" ID="CmbWarehouse" clsClass="x-form-text x-form-field text_82px"
                                                isAlign="false" TabIndex="21" Query="option=Companylist" Width="63" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 4px">
                                <table width="77px">
                                    <tr>
                                        <td>
                                            Free Storage
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table width="167" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="80">
                                            <ext:DateField ID="txtFreeStorageStart" runat="server" Width="90" Cls="text_60px"
                                                TabIndex="22" Format="dd/m/Y">
                                                <Listeners>
                                                    <Blur Handler="NumFreeStorage.setValue(DateDiff(#{txtFreeStorageStart},#{txtFreeStorageEnd}))" />
                                                </Listeners>
                                                <DirectEvents>
                                                    <Blur OnEvent="txtFreeStoregeStart_Blur">
                                                    </Blur>
                                                </DirectEvents>
                                            </ext:DateField>
                                        </td>
                                        <td width="12" align="center" style="padding-left: 1px; padding-right: 1px">
                                            -
                                        </td>
                                        <td width="80">
                                            <ext:DateField ID="txtFreeStorageEnd" runat="server" Width="90" Cls="text_60px" TabIndex="22"
                                                Format="dd/m/Y">
                                                <Listeners>
                                                    <Blur Handler="NumFreeStorage.setValue(DateDiff(#{txtFreeStorageStart},#{txtFreeStorageEnd}))" />
                                                </Listeners>
                                            </ext:DateField>
                                        </td>
                                        <td width="10">
                                            &nbsp;
                                        </td>
                                        <td width="40px">
                                            <ext:TextField ID="NumFreeStorage" runat="server" Width="20px" Cls="text_20px" Disabled="true">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 6px; padding-top: 3px">
                                Pickup
                            </td>
                            <td style="padding-top: 4px" align="left">
                                <ext:DateField ID="txtPickUp" runat="server" Width="90" Cls="text_60px" TabIndex="24"
                                    Format="dd/m/Y">
                                </ext:DateField>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="470" rowspan="2" valign="top" style="padding-left: 9px">
                    <div id="div_top" style="margin-top: 115px">
                        <table width="301" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="#81b8ff"
                            class="table_nav2">
                            <tr>
                                <td width="709" align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF"
                                    class="font_11bold_1542af" style="padding-left: 5px; height: 24px">
                                    Action
                                </td>
                            </tr>
                        </table>
                        <table width="220" border="0" align="center" cellpadding="0" cellspacing="0" style="padding: 5px 0  5px 0;
                            height: 30px">
                            <tr>
                                <td style="padding-right: 2px; padding-left: 5px">
                                    <ext:Button ID="btnNext" runat="server" Cls="Submit_70px" Width="70px" Text="Next">
                                        <DirectEvents>
                                            <Click OnEvent="btnNext_Click">
                                                <EventMask ShowMask="true" Msg=" Saving ... " />
                                                <ExtraParams>
                                                    <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                    </ext:Parameter>
                                                    <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{GridPanelForeign}.getRowsValues())"
                                                        Mode="Raw">
                                                    </ext:Parameter>
                                                    <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{GridPanelRoute}.getRowsValues())"
                                                        Mode="Raw">
                                                    </ext:Parameter>
                                                    <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{GridPanelContact}.getRowsValues())"
                                                        Mode="Raw">
                                                    </ext:Parameter>
                                                </ExtraParams>
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td style="padding-right: 2px">
                                    <ext:Button ID="btnVoid" runat="server" Cls="Submit_70px" Width="70px" Text="Void">
                                        <DirectEvents>
                                            <Click OnEvent="btnVoid_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td style="padding-right: 2px">
                                    <ext:Button ID="btnCancel" runat="server" Cls="Submit_70px" Width="70px" Text="Cancel">
                                        <DirectEvents>
                                            <Click OnEvent="btnCancel_Click">
                                                <EventMask ShowMask="true" Msg=" Loading ... " />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td style="padding-right: 2px">
                                    <ext:Button ID="btnSave" runat="server" Cls="Submit_70px" Width="70px" Text="Save">
                                        <Listeners>                                             
                                             <Click Handler="return (ReturnNull()&&ValidataText());" />
                                        </Listeners>
                                        <DirectEvents>
                                            <Click OnEvent="btnSave_Click"  Before="return (ReturnNull()&&ValidataText());">
                                                <EventMask ShowMask="true" Msg=" Saving ... " />
                                                <ExtraParams>
                                                    <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                    </ext:Parameter>
                                                    <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{GridPanelForeign}.getRowsValues())"
                                                        Mode="Raw">
                                                    </ext:Parameter>
                                                    <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{GridPanelRoute}.getRowsValues())"
                                                        Mode="Raw">
                                                    </ext:Parameter>
                                                    <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{GridPanelContact}.getRowsValues())"
                                                        Mode="Raw">
                                                    </ext:Parameter>
                                                </ExtraParams>
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
                <td valign="top" style="padding-top: 2px;padding-left:1px;" align="left">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td valign="top">
                                <table width="319px" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                                    <tr>
                                        <td height="25" bgcolor="#FFFFFF" class="table">
                                            <table cellpadding="0" cellspacing="0" border="0" width="65px" class="font_11bold">
                                                <tr>
                                                    <td style="padding-left: 5px">
                                                        GWT
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="25" bgcolor="#FFFFFF" class="table">
                                            <table cellpadding="0" cellspacing="0" border="0" width="80" style="padding-left: 4px">
                                                <tr>
                                                    <td>
                                                        <ext:NumberField ID="txtGWT" runat="server" Cls="text_70px" Width="83px" TabIndex="16"
                                                            StyleSpec="text-align:right">
                                                            <Listeners>
                                                                <Blur Handler="if(this.getValue()>#{txtVWT}.getValue()){#{txtCWT}.setValue(this.getValue())}" />
                                                            </Listeners>
                                                        </ext:NumberField>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" class="table">
                                            <table width="58px">
                                                <tr>
                                                    <td class="font_11bold" align="right">
                                                        Piece(s)
                                                    </td>
                                                    <td class="font_red" align="right">
                                                        *
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="25" bgcolor="#FFFFFF" class="table" align="left">
                                            <table cellpadding="0" cellspacing="0" border="0" width="80" style="padding-left: 4px">
                                                <tr>
                                                    <td>
                                                        <ext:NumberField ID="txtPiece" runat="server" Cls="text_70px" Width="83" AllowDecimals="false"
                                                            StyleSpec="text-align:right" TabIndex="19">
                                                        </ext:NumberField>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="25" bgcolor="#FFFFFF" class="table">
                                            <span class="font_11bold">VWT</span>
                                        </td>
                                        <td height="25" bgcolor="#FFFFFF" class="table">
                                            <ext:NumberField ID="txtVWT" runat="server" Cls="text_70px" Width="83" TabIndex="17"
                                                StyleSpec="text-align:right">
                                                <Listeners>
                                                    <Change Handler="if(this.getValue()>#{txtGWT}.getValue()){#{txtCWT}.setValue(this.getValue()).focus(true);}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" class="table">
                                            <table width="58px">
                                                <tr>
                                                    <td class="font_11bold" align="right">
                                                        Unit
                                                    </td>
                                                    <td class="font_red" align="right">
                                                        *
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="25" bgcolor="#FFFFFF" style="padding-left: 4px;">
                                            <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                                StoreID="StoreUnit" Width="62" winTitle="Unit" TabIndex="20" winUrl="/BasicData/Unit/list.aspx?sys=A"
                                                winWidth="510" winHeight="585" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="25" bgcolor="#FFFFFF" class="table">
                                            <span class="font_11bold" style="padding-left: 7px">CWT</span><span class="font_red"
                                                style="padding-left: 2px">*</span>
                                        </td>
                                        <td height="25" bgcolor="#FFFFFF" class="table" align="center">
                                            <ext:NumberField ID="txtCWT" runat="server" Cls="text_70px" Width="83" TabIndex="18"
                                                StyleSpec="text-align:right">
                                            </ext:NumberField>
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF">
                                            <table width="58">
                                                <tr>
                                                    <td class="font_11bold" align="center">
                                                        Pallet
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="25" bgcolor="#FFFFFF" align="left" style="padding-left: 4px">
                                            <ext:NumberField ID="txtPallet" runat="server" Cls="text_70px" Width="83" AllowDecimals="false"
                                                StyleSpec="text-align:right" TabIndex="20">
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="4px">
                            </td>
                            <td valign="top">
                                <table>
                                    <tr>
                                        <td style="padding-left: 5px">
                                            Remark
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="25" align="left" valign="top" style="padding-left: 5px">
                                            <ext:TextArea ID="txtRemark" runat="server" StyleSpec="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; height:65px; width:330px;text-transform:capitalize"
                                                TabIndex="20">
                                            </ext:TextArea>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="0" cellpadding="0" width="700px">
            <tr>
                <td colspan="2" height="6">
                </td>
            </tr>
            <tr>
                <td id="GridView_1" width="666px" valign="top">
                    <table cellpadding="0" cellspacing="0" width="666px">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #81b8ff; border-left: 1px solid #81b8ff; border-right: 1px solid #81b8ff;
                                height: 25px">
                                Local Invoice
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 145px">
                                <ext:GridPanel ID="GridPanelInvoice" runat="server" Width="666px" Height="145" TrackMouseOver="true"
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
                                            <ext:CheckColumn Header="DN" DataIndex="DN" Width="30">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="CN" DataIndex="CN" Width="30">
                                            </ext:CheckColumn>
                                            <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="130">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="205">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="45" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right" Format="0.00">
                                            </ext:NumberColumn>
                                            <ext:CheckColumn Header="Print" DataIndex="Print" Width="40" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="Void" DataIndex="Void" Width="38" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="AC" DataIndex="AC" Width="30" Align="Center">
                                            </ext:CheckColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="RowSelect">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td id="dis_Invoice" valign="top" align="left" style="padding-left: 6px; display: block">
                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="119" />
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <uc1:Costing ID="ucCost" runat="server" type="H" sys="AI" />
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td id="GridView_3" width="666" valign="top">
                    <table cellpadding="0" cellspacing="0" width="666">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #81b8ff; border-left: 1px solid #81b8ff; border-right: 1px solid #81b8ff;
                                height: 25px">
                                Foreign Invoice
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 190px">
                                <ext:GridPanel ID="GridPanelForeign" runat="server" Width="666" Height="190" TrackMouseOver="true">
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
                                    <ColumnModel ID="ColumnModel1">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Kind" DataIndex="Kind" Width="80">
                                                <Renderer Fn="ToUpper" />
                                            </ext:Column>
                                            <ext:Column Header="Date" DataIndex="Date" Width="80">
                                            </ext:Column>
                                            <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="137">
                                                <Renderer Fn="ToUpper" />
                                            </ext:Column>
                                            <ext:Column Header="Code" DataIndex="CompanyCode" Width="80">
                                                <Renderer Fn="ToUpper" />
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="116">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="55" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Format="0.00" Align="Right">
                                            </ext:NumberColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel2" runat="server">
                                            <Listeners>
                                                <RowSelect Handler="getRowIndex2(rowIndex);" />
                                            </Listeners>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    <Listeners>
                                        <RowClick Handler="getRowIndex2(rowIndex);SelectForeignInvoiceRecord();" />
                                    </Listeners>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="vertical-align: top;"><%-- padding-left: 2px--%>
                    <div style="width: 307px; height: 21px;margin-left: 8px;" id="Div1">
                        <table cellpadding="0" cellspacing="0" style="width: 307px; "><%--padding-left: 4px--%>
                            <tr>
                                <td colspan="6" style="height: 25px; line-height: 25px; padding-left: 5px;" class="font_11bold_1542af table_nav2">
                                    Add Invoice
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 7px; padding-top: 6px">
                                    Kind
                                </td>
                                <td colspan="5" style="padding-top: 8px; width: 220px">
                                    <%-- <uc1:UserComboBox runat="server" ID="l_item" clsClass="select_160px" TabIndex="34" isText="true"
StoreID="StoreCmb3" Width="90" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
isButton="false" winWidth="800" winHeight="800" Query="option=ItemBinding&sys=A" />--%>
                                    <ext:ComboBox runat="server" ID="FI_Kind" Cls="select_160px" TabIndex="34" StoreID="StoreForeignKind"
                                        Width="90" Mode="Local" ForceSelection="true" TriggerAction="All" DisplayField="text"
                                        ValueField="value" Text="Credit Note">
                                    </ext:ComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="tb_01" style="padding-left: 7px; padding-top: 3px">
                                    Date
                                </td>
                                <td colspan="5" style="padding-top: 5px">
                                    <ext:DateField runat="server" ID="FI_Date" Format="dd/m/Y" Width="90" Cls="select_160px"
                                        TabIndex="35">
                                    </ext:DateField>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 5px; padding-top: 5px">
                                    <table width="75px">
                                        <tr>
                                            <td>
                                                DN/CN No.
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td colspan="5" style="padding-top: 5px">
                                    <ext:TextField ID="FI_DNCN" runat="server" Cls="text_82px" Width="90" TabIndex="36">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td class="tb_01" style="vertical-align: top; padding-top: 6px; padding-left: 7px">
                                    Company
                                </td>
                                <td colspan="5" style="padding-top: 4px">
                                    <%-- <uc1:UserComboBox runat="server" ID="l_company" clsClass="select_160px" TabIndex="33"
isText="true" isAlign="false" StoreID="StoreCmb3" Width="137" winTitle="Company"
winUrl="/BasicData/Customer/detail.aspx" isButton="false" winWidth="800" winHeight="800"
Query="option=CompanyList" /> --%>
                                    <uc1:Autocomplete runat="server" ID="FI_Company" clsClass="x-form-text x-form-field text_82px"
                                        TabIndex="37" isText="true" isAlign="false" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                        winWidth="800" winHeight="800" Query="option=CompanyList" />
                                </td>
                            </tr>
                </td>
            </tr>
            <tr>
                <td class="tb_01" style="padding-top: 2px; padding-left: 7px" valign="top">
                    Currency
                </td>
                <td colspan="5">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <ext:ComboBox ID="FI_Currency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                    Width="90" TabIndex="38" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                    TriggerAction="All">
                                    <Listeners>
                                        <Select Handler="#{FI_EX}.setValue(record.data.rate)" />
                                    </Listeners>
                                </ext:ComboBox>
                            </td>
                            <td colspan="3" style="padding-left: 2px; display: none">
                                <ext:NumberField ID="FI_EX" runat="server" Width="65" DecimalPrecision="4" StyleSpec="text-align:right"
                                    Cls="select_160px" TabIndex="38">
                                </ext:NumberField>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <td class="tb_01" style="padding-top: 4px; padding-left: 7px">
                Amount
            </td>
            <td colspan="5" style="padding-top: 5px">
                <ext:NumberField ID="FI_Amount" runat="server" Cls="text_82px" Width="90" TabIndex="39"
                    StyleSpec="text-align:right">
                </ext:NumberField>
            </td>
            <tr>
            </tr>
            <tr>
                <td colspan="6" style="padding-right: 7px; padding-top: 8px" align="right">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td style="padding-right: 3px">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="btn_L">
                                        </td>
                                        <td>
                                            <input onclick="if(ValidataCompany('FI_Company')){InsertForeignInvoiceRecord()}"
                                                type="button" style="cursor: pointer" tabindex="39" value="Save & Next" class="btn_text btn_C" />
                                        </td>
                                        <td class="btn_R">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-right: 3px">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="btn_L">
                                        </td>
                                        <td>
                                            <input onclick="ResetForeignInvoiceRecord()" type="button" style="cursor: pointer"
                                                tabindex="39" value="Reset" class="btn_text btn_C" />
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
                                                tabindex="39" value="Delete" class="btn_text btn_C" />
                                        </td>
                                        <td class="btn_R">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <%--<input type="button" value="Save & Next" onclick="InsertRecord()"  />                                               
<input type="button" value="Reset" onclick="ResetRecord()" />
<input type="button" value="Delete" onclick="DeleteRecord()" tabindex="41" />--%>
                </td>
            </tr>
        </table>
    </div>
    </td> </tr>
    <tr>
        <td colspan="2" height="5">
        </td>
    </tr>
    <tr style="display: none">
        <td id="GridView_4" width="656" valign="top">
            <table cellpadding="0" cellspacing="0" width="656">
                <tr>
                    <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                        border-top: 1px solid #81b8ff; border-left: 1px solid #81b8ff; border-right: 1px solid #81b8ff;
                        height: 25px">
                        Domestic/Local Delivery Route
                    </td>
                </tr>
                <tr>
                    <td style="height: 190px">
                        <ext:GridPanel ID="GridPanelRoute" runat="server" Width="656" Height="190" TrackMouseOver="true">
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
                                                <ext:RecordField Name="ETD" Type="string">
                                                </ext:RecordField>
                                                <ext:RecordField Name="ETA" Type="string">
                                                </ext:RecordField>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel4">
                                <Columns>
                                    <ext:RowNumbererColumn Header="No." Width="30">
                                    </ext:RowNumbererColumn>
                                    <ext:Column Header="Kind" DataIndex="Kind" Width="80">
                                    </ext:Column>
                                    <ext:Column Header="Code" DataIndex="CompanyCode" Width="100">
                                    </ext:Column>
                                    <ext:Column Header="Company" DataIndex="CompanyName" Width="151">
                                    </ext:Column>
                                    <ext:Column Header="Dest." DataIndex="Dest" Width="45" Align="center">
                                    </ext:Column>
                                    <ext:Column Header="Voyage" DataIndex="Voyage" Width="70">
                                    </ext:Column>
                                    <ext:Column Header="ETD" DataIndex="ETD" Width="78" Align="center">
                                    </ext:Column>
                                    <ext:Column Header="ETA" DataIndex="ETA" Width="78" Align="center">
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
                                    <Listeners>
                                        <RowSelect Handler="getRowIndex3(rowIndex)" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <Listeners>
                                <RowClick Handler="getRowIndex3(rowIndex);SelectRouteRecord();" />
                            </Listeners>
                        </ext:GridPanel>
                    </td>
                </tr>
            </table>
        </td>
        <td style="vertical-align: top; padding-left: 2px">
            <div style="width: 307px; height: 21px;" id="Div2">
                <table cellpadding="0" cellspacing="0" style="width: 307px; padding-left: 4px">
                    <tr>
                        <td colspan="6" style="height: 25px; line-height: 25px; padding-left: 5px;" class="font_11bold_1542af table_nav2">
                            Add Route
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0" width="73px">
                                <tr>
                                    <td class="tb_01" style="vertical-align: top; padding-left: 7px; padding-top: 8px">
                                        Kind
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="5" style="padding-left: 5px; padding-top: 8px">
                            <%--<ext:ComboBox ID="r_Kind" runat="server" StoreID="StoreShipKind" DisplayField="text"
                                ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All" Width="82" TabIndex="40"
                                Cls="select_160px">
                                <Template Visible="False" ID="ctl7617" StopIDModeInheritance="False" EnableViewState="False">
                                </Template>
                            </ext:ComboBox>--%>
                            <uc1:UserComboBox runat="server" ID="r_Kind" ListWidth="180" clsClass="select_160px"
                                StoreID="StoreShipKind" Width="69" winTitle="ShipKind" TabIndex="40" winUrl="/BasicData/DomesticStatus/list.aspx"
                                winWidth="480" winHeight="584" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_01" style="padding-top: 7px; padding-left: 7px;" valign="top">
                            Company
                        </td>
                        <td colspan="5" style="padding-top: 5px; padding-left: 5px; width: 200px">
                            <uc1:Autocomplete runat="server" ID="r_Company" clsClass="x-form-text x-form-field text_82px"
                                TabIndex="41" isText="true" isAlign="false" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                winWidth="800" winHeight="800" Query="option=CompanyList" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_01" style="padding-left: 7px;">
                            DEST.
                        </td>
                        <td colspan="5" style="padding: 0; padding-left: 5px">
                            <%-- <ext:ComboBox ID="r_Dest" runat="server" StoreID="StoreLocation" DisplayField="value" TabIndex="42"
                                ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All" Cls="select_160px"
                                Width="82">
                                <Template Visible="False" ID="ctl7621" StopIDModeInheritance="False" EnableViewState="False">
                                </Template>
                            </ext:ComboBox>--%>
                            <uc1:UserComboBox runat="server" ID="r_Dest" ListWidth="180" clsClass="select_160px"
                                TabIndex="42" StoreID="StoreLocation" Width="69" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                winWidth="845" winHeight="620" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_01" style="padding-top: 5px; padding-left: 7px" valign="top">
                            Voyage
                        </td>
                        <td colspan="5" style="padding-top: 4px; padding-left: 5px">
                            <ext:TextField ID="r_Voyage" runat="server" Cls="text_82px" Width="90" TabIndex="43">
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_01" style="padding-left: 7px; padding-top: 4px">
                            ETD
                        </td>
                        <td colspan="5" style="padding-top: 4px; padding-left: 5px">
                            <ext:DateField ID="r_ETD" runat="server" Format="dd/m/Y" Cls="select_160px" Width="90"
                                TabIndex="44">
                                <Listeners>
                                    <Blur Handler="DateDiff(#{r_ETD},#{r_ETA})" />
                                </Listeners>
                            </ext:DateField>
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_01" style="padding-left: 7px; padding-top: 3px">
                            ETA
                        </td>
                        <td colspan="5" style="padding-top: 4px; padding-left: 5px">
                            <ext:DateField ID="r_ETA" runat="server" Format="dd/m/Y" Cls="select_160px" Width="90"
                                TabIndex="45">
                                <Listeners>
                                    <Blur Handler="DateDiff(#{r_ETD},#{r_ETA})" />
                                </Listeners>
                            </ext:DateField>
                        </td>
                        <tr>
                        </tr>
                        <tr>
                            <td colspan="6" style="padding-right: 7px; padding-top: 10px" align="right">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="padding-right: 3px">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td class="btn_L">
                                                    </td>
                                                    <td>
                                                        <input onclick="if(ValidataCompany('r_Company')){InsertRouteRecord()}" type="button"
                                                            style="cursor: pointer" tabindex="45" value="Save & Next" class="btn_text btn_C" />
                                                    </td>
                                                    <td class="btn_R">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-right: 3px">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td class="btn_L">
                                                    </td>
                                                    <td>
                                                        <input onclick="ResetRouteRecord()" type="button" style="cursor: pointer" tabindex="45"
                                                            value="Reset" class="btn_text btn_C" />
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
                                                        <input onclick="DeleteRouteRecord()" type="button" style="cursor: pointer" tabindex="45"
                                                            value="Delete" class="btn_text btn_C" />
                                                    </td>
                                                    <td class="btn_R">
                                                </tr>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                </table>
                <%--<input type="button" value="Save & Next" onclick="InsertRecord()"  />                                               
<input type="button" value="Reset" onclick="ResetRecord()" tabindex="40" />
<input type="button" value="Delete" onclick="DeleteRecord()" tabindex="41" />--%>
        </td>
    </tr>
    </tr> </table> </div> </td> </tr>
    <tr>
        <td colspan="2" height="5">
        </td>
    </tr>
    <tr style="display: none">
        <td valign="top" id="GridView_5" width="600px">
            <table cellpadding="0" cellspacing="0" width="600px">
                <tr>
                    <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                        border-top: 1px solid #81b8ff; border-left: 1px solid #81b8ff; border-right: 1px solid #81b8ff;
                        height: 25px">
                        Contact Information
                    </td>
                </tr>
                <tr>
                    <td style="height: 145px">
                        <ext:GridPanel ID="GridPanelContact" runat="server" Width="600px" Height="145" TrackMouseOver="true"
                            ClicksToEdit="1">
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
                            <ColumnModel ID="ColumnModel5">
                                <Columns>
                                    <ext:RowNumbererColumn Header="No." Width="30">
                                    </ext:RowNumbererColumn>
                                    <ext:Column Header="Kind" DataIndex="Kind" Width="80">
                                    </ext:Column>
                                    <ext:Column Header="Code" DataIndex="CompanyCode" Width="80">
                                    </ext:Column>
                                    <ext:Column Header="Company" DataIndex="CompanyName" Width="200">
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
                                <ext:RowSelectionModel runat="server" ID="ctl12262">
                                    <Listeners>
                                        <RowSelect Handler="getRowIndex4(rowIndex)" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <Listeners>
                                <RowClick Handler="SelectContactRecord();" />
                            </Listeners>
                        </ext:GridPanel>
                    </td>
                </tr>
            </table>
        </td>
        <td style="vertical-align: top;">
            <div style="width: 311px;" id="Div3">
                <table cellpadding="0" cellspacing="0" style="width: 311px; padding-left: 5px">
                    <tr>
                        <td colspan="6" style="height: 25px; line-height: 25px; padding-left: 5px;" class="font_11bold_1542af table_nav2">
                            Add Contact
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0" width="76px">
                                <tr>
                                    <td class="tb_01" style="vertical-align: top; padding-left: 7px; padding-top: 8px">
                                        Kind
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="5" style="padding-left: 8px; padding-top: 8px">
                            <ext:ComboBox ID="c_Kind" runat="server" StoreID="StoreCompanyKind" DisplayField="text"
                                ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All" Width="82"
                                TabIndex="47" Cls="select_160px">
                                <Template Visible="False" ID="ctl7627" StopIDModeInheritance="False" EnableViewState="False">
                                </Template>
                            </ext:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_01" style="vertical-align: top; padding-top: 4px; padding-left: 6px">
                            Company
                        </td>
                        <td colspan="5" style="padding-top: 4px; width: 220px; padding-left: 8px">
                            <uc1:Autocomplete runat="server" ID="c_Company" clsClass="x-form-text x-form-field text_82px"
                                TabIndex="48" isText="true" isAlign="false" Width="76" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                winWidth="800" winHeight="800" Query="option=CompanyList" />
                        </td>
                    </tr>
                    <td class="tb_01" style="vertical-align: top; padding-top: 4px; padding-left: 6px">
                        Dept
                    </td>
                    <td style="vertical-align: top; padding-left: 8px">
                        <ext:ComboBox ID="c_Dept" runat="server" StoreID="StoreDept" DisplayField="value"
                            TabIndex="49" Cls="select_160px" Width="82" ValueField="value" Mode="Local" ForceSelection="true"
                            TriggerAction="All">
                            <Template Visible="False" ID="ctl7631" StopIDModeInheritance="False" EnableViewState="False">
                            </Template>
                        </ext:ComboBox>
                    </td>
                    <tr>
                        <td colspan="6" style="padding-right: 7px; padding-top: 10px" align="right">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="padding-right: 2px">
                                        <input onclick="if(ValidataCompany('c_Company')){InsertContactRecord()}" type="button"
                                            style="background-image: url(../../images/btn_save_01.jpg); border: 0px; width: 82px;
                                            height: 22px; cursor: pointer" tabindex="49" value="Save & Next" class="btn_text" />
                                    </td>
                                    <td style="padding-right: 2px">
                                        <input onclick="ResetContactRecord()" type="button" style="background-image: url(../../images/btn_save_02.jpg);
                                            border: 0px; width: 60px; height: 22px; cursor: pointer" tabindex="33" value="Reset"
                                            class="btn_text" />
                                    </td>
                                    <td>
                                        <input onclick="DeleteContactRecord()" type="button" style="background-image: url(../../images/btn_save_02.jpg);
                                            border: 0px; width: 60px; height: 22px; cursor: pointer" tabindex="33" value="Delete"
                                            class="btn_text" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    </table> </div>
    </form>
</body>
</html>
