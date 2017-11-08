<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="OceanExport_OEShipment_List" %>

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
<head id="Head1" runat="server">
    <title>OE House</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../OEJs/gridHouse.js" type="text/javascript"></script>

    <script src="../OEJs/Valid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script type="text/javascript">

        var status = 0;
        function DateShow() {
            if (winShowDate.isVisible()) {
                winShowDate.hide();
            }
            else {
                winShowDate.show();
            }
        }

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
        function SetHBL(lotno, hbl, type) {

            CompanyX.SetHBL(lotno, hbl, type);

        }

        function changePayAt() {
            var port = $("#hidPort").val();
            var POD = $("#cmbPort").val();
            var payat = $("#cmbPayAt").val();
            if (payat == "" || payat == port) {
                $("#cmbPayAt").val(POD);
                $("#hidPort").val(POD);

                var record = StoreLocation.getById(POD);
                if (record != null && record != undefined) {
                    $("#txtPayAtL").val(record.data.text);
                }
            }
        }

        function SelectItem(obj, obj1) {
            var value = $("#" + obj).val();
            var record = StoreLocation.getById(value);
            if (record != null && record != undefined) {
                $("#" + obj1).val(record.data.text);
            }
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
        <table width="981px" border="0" cellspacing="0" cellpadding="0" class="table_nav1 font_11bold_1542af">
            <tr>
                <td style="padding-left: 5px;">
                    <table>
                        <tr>
                            <td>
                                <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('OE');" />
                            </td>
                            <td>
                                OE - Shipment (House) Information
                            </td>
                            <td style="padding-top: 2px;">
                                &nbsp;<img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: bottom;
                                    display: none;" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="right" style="padding-right:5px;">
                 <table  border="0" cellspacing="0" cellpadding="0"><tr>
                   <td align="right">
                    <ext:Label runat="server" ID="labImpLotNo" Hidden="true">
                    </ext:Label>
                </td>
                <td style="font-weight: bold;" align="right">
                    <ext:Label ID="labHeader" runat="server">
                    </ext:Label>
                </td>
                 <td>
                  <%if ( !string.IsNullOrEmpty(Request["seed"]))
                              { %>
                              <uc1:Transfer runat="server" ID="TransferSys" sys="OE" type="H"/>
                            <%} %>
                 </td>
            </tr>
             </table>
                           
                </td></tr>
        </table>
    </div>
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
    <ext:Store runat="server" ID="StoreDept">
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
          <ext:Hidden ID="hidTran" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLotNo" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidMAWB" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidHawb" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidisACorPrint" runat="server" Text="true">
    </ext:Hidden>
    <ext:Hidden ID="txtcur_Rate" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    <div style="margin-left: 8px; margin-top: 110px; float: left;">
        <table width="956" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="664" height="2">
                </td>
                <td width="345" rowspan="4" valign="top" align="left" style="padding-left: 5px">
                    <div id="div_top" style="margin-top: 116px; ">
                        <table width="301px" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                            <tr>
                                <td class="font_11bold_1542af">
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
                                                    <Listeners>
                                                        <Click Handler="return (ReturnNull()&&ValidataText());" />
                                                    </Listeners>
                                                    <DirectEvents>
                                                        <Click OnEvent="btnNext_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridPanelOther}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
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
                                                        <Click Handler="return (ValidataText()&&ReturnNull());" />
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
                                <%if (hidTran.Text == "TRUE")
                                  { %>
                    <tr>
                        <td colspan="4" style="  height:25px;padding-bottom: 5px;" >
                            <table border="0" cellpadding="0" cellspacing="0" width="266px;">
                                <tr>
                                    <td  style="color:green; font-weight:bold;width:32px;">
                                        T/S
                                    </td>
                                    
                                    <td colspan="2" style="color:green; font-weight:bold;width:169px;">
                                         Lot # <a style="color:green;font-weight:normal !important;" href="/OceanImport/OceanLot/List.aspx?seed=<%=TranToMBL %>" target="<%=TranLotNo %>"><%=TranLotNo %></a>
                                    </td>
                                    <td rowspan="2">
                                    <table border="0" cellspacing="0" cellpadding="0" >
                                        <tr>
                                            <td align="center" style="padding-left: 2px">
                                                <ext:Button ID="btnRelease" runat="server" Cls="Submit_65px" Width="65px" Text="Release">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnRelease_Click">
                                                            <EventMask ShowMask="true" Msg=" Loading ... " />
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                        </tr>
                                    </table>
                                   </td>
                                </tr>
                                <tr>
                                    <td></td>
                                     <td style="color:green; font-weight:bold;">
                                         HBL# <a style="color:green;font-weight:normal !important;" href="/OceanImport/OceanShipmentJobList/OceanShipmentHouse.aspx?MBL=<%=TranToMBL %>&seed=<%=TranSeed %>" target="<%=TranLotNo %>"><%=TranHBL%></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                        </table>
                    </div>
                    <table cellpadding="0" cellspacing="0" border="0" style="margin-top: 81px;">
                       <tr style=" height:25px;" id ="trIsTran">
                       </tr>
                        <tr>
                            <td colspan="2">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="left" valign="middle">
                                            <table width="58px">
                                                <tr>
                                                    <td>
                                                        Est Receipt
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="left" valign="middle" width="90px">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtEstReceipt" runat="server" Width="90" Cls="text_100px" Format="d/m/Y"
                                                    TabIndex="20">
                                                </ext:DateField>
                                            </span>
                                        </td>
                                        <td align="left" valign="middle" width="50px" style="padding-right: 2px; padding-left: 10px">
                                            Act Receipt
                                        </td>
                                        <td align="left" valign="middle" width="90px">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtActReceipt" runat="server" Width="90" Cls="text_100px" Format="d/m/Y"
                                                    TabIndex="21">
                                                </ext:DateField>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top;padding-top:1px;">
                                <table width="58px">
                                    <tr>
                                        <td>
                                            Remark
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style=padding-bottom:5px;">
                                <ext:TextArea ID="txtRemark" runat="server" StyleSpec="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px; height:74px;width:234px;text-transform:capitalize"
                                    TabIndex="22">
                                </ext:TextArea>
                            </td>
                        </tr>
                        
                        <tr><td style="border-bottom:solid 1px #8DB2e3;line-height:1px; padding:5px 0px 0px 0px" colspan="2"></td></tr>
                        <tr>
                            <td colspan="2" style="padding-top:6px">
                                <table>
                                    <tr>
                                        <td align="left" valign="middle" width="55px" >
                                            Currency
                                        </td>
                                        <td align="left" valign="middle" width="90px" style="padding-top:2px">
                                            <ext:ComboBox ID="cmbCurrency" runat="server" Cls="select_160px" StoreID="StoreCurrInvoice"
                                                Width="70" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                TriggerAction="All" TabIndex="23">
                                            </ext:ComboBox>
                                        </td>
                                        <td align="left"   style="padding-right: 2px; padding-left: 10px;width:140px;">
                                        <ext:Checkbox ID="chkSBSReceive" runat="server" TabIndex="23"  Height="18" BoxLabel="Show Receive Place">
                                            </ext:Checkbox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table width="652px" border="0" cellspacing="4" cellpadding="0">
                        <tr>
                            <td align="left" valign="top" class="font_11bold" style="padding-left: 3px">
                                Vessel / Voyage
                            </td>
                            <td colspan="3" align="left" valign="top" style="padding-top: 4px">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td width="86">
                                                <ext:ComboBox ID="cmbVesselCode" runat="server" Cls="select" Width="147" StoreID="StoreVessel"
                                                    DisplayField="text" ValueField="value" Mode="Local" ForceSelection="true" TabIndex="1"
                                                    TriggerAction="All">
                                                    <DirectEvents>
                                                        <Select OnEvent="cmbVessel_Select" />
                                                    </DirectEvents>
                                                </ext:ComboBox>
                                            </td>
                                            <td style="padding-left: 3px">
                                            </td>
                                            <td>
                                                <ext:ComboBox ID="cmbVesselText" runat="server" Cls="select" Width="100" StoreID="StoreVoyage"
                                                    TabIndex="1" ItemSelector="tr.list-item" DisplayField="text" ValueField="value"
                                                    Mode="Local" ForceSelection="true" TriggerAction="All" ListWidth="130px">
                                                    <%-- <Listeners>
                                                                <Select Handler="CompanyX.BindVoyag(this.getValue());" />
                                                            </Listeners>--%>
                                                    <DirectEvents>
                                                        <Select OnEvent="cmbVesselText_Select" />
                                                    </DirectEvents>
                                                </ext:ComboBox>
                                            </td>
                                            <td style="text-align: left;">
                                                <img src="../../images/select_btn.jpg" width="18" height="18" class="cursor" alt=""
                                                    onclick="CompanyX.ShowVoyage();">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                            <td class="font_11bold" style="padding-left:5px;width:55px;">
                                Carrier
                            </td>
                            <td>
                                <ext:TextField ID="txtCarrier" runat="server" Cls="text" Width="86" Disabled="true"
                                    TabIndex="2">
                                </ext:TextField>
                            </td>
                            <td class="font_11bold" style="padding-left:0px;width:65px;">
                                Booking Date
                            </td>
                            <td style="width:88px;">
                                <ext:DateField ID="txtBookingDate" runat="server" Width="88" Cls="text_80px" Format="d/m/Y"
                                    Disabled="true" TabIndex="3">
                                </ext:DateField>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="63px">
                                    <tr>
                                        <td>
                                            HBL#
                                        </td>
                                        <td class="font_red" align="right">
                                            *
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="100">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtHawb" runat="server" Cls="text" Width="81" TabIndex="4">
                                                <Listeners>
                                                    <Blur Handler="validName('txtHawb','hidSeed')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td style="padding-left: 1px">
                                            <%--<img src="../../images/A_btn.jpg" width="18" height="18" class="cursor" />--%>
                                            <ext:Image ID="imgHBL" runat="server" ImageUrl="~/images/A_btn.jpg" Height="18" Cls="cursor"
                                                Disabled="true">
                                                <DirectEvents>
                                                    <Click OnEvent="imgHBL_Click">
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Image>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="font_11bold">
                                <table cellpadding="0" cellspacing="0" border="0" width="65">
                                    <tr>
                                        <td>
                                            Ser. Mode<span class="font_red" style="padding-left: 2px">*</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <uc1:UserComboBox runat="server" ID="CmbService" ListWidth="180" clsClass="select"
                                                Query="option=ServerMode" StoreID="StoreServiceMode" Width="69" TabIndex="11"
                                                winTitle="Service Mode" winUrl="/BasicData/ServiceMode/ServiceMode.aspx?sys=O"
                                                winWidth="516" winHeight="585" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="font_11bold" style="padding-left: 5px">
                            <table border="0" cellpadding="0" cellspacing="0" width="61px"><tr><td>PPD/COL</td><td class="font_red" style="text-align:right">*</td></tr></table>

                            </td>
                            <td>
                                            <ext:ComboBox ID="CmbPPD" runat="server" Cls="select" DisplayField="text" TabIndex="12"
                                                ForceSelection="true" Mode="Local" StoreID="StorePPCC" TriggerAction="All" ValueField="text"
                                                Width="86">
                                                <Template Visible="False" ID="Template1dd" StopIDModeInheritance="False" EnableViewState="False">
                                                </Template>
                                            </ext:ComboBox>
                            </td>
                            <td class="font_11bold">
                            <table border="0" cellpadding="0" cellspacing="0" width="64px"><tr><td>Salesman</td><td class="font_red" style="text-align:right">*</td></tr></table>
                                           
                            </td>
                            <td width="88px">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <uc1:UserComboBox runat="server" ID="CmbSalesman" Query="option=SalesList" TabIndex="13"
                                                Width="67" clsClass="select" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                winWidth="680" winHeight="560" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="<%if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[12].ToString().ToUpper() != "") { Response.Write("display:none");
                            }%>">
                            <td>
                                 <table width="73px">
                                    <tr>
                                        <td class="font_11bold">
                                            MBL#(报关)
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2">
                                <ext:TextField ID="txtSubMBL" runat="server" Cls="text" Width="146">
                                </ext:TextField>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="63px">
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
                            <td colspan="3">
                                <table border="0" cellspacing="0" cellpadding="0" width="252">
                                    <tr>
                                        <td>
                                            <uc1:AutoComplete runat="server" ID="CmbShipperCode" TabIndex="5" clsClass="text input"
                                                Query="option=CompanyList" Width="75" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="4" rowspan="6" valign="top" align="left" style="padding-top: 3px;">
                                <table cellpadding="0" cellspacing="0" border="0" style="width: 325px; height: 130px">
                                    <tr>
                                        <td style="background: url(../../images/line_bg_01.gif);">
                                            <table width="320" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td colspan="4" style="padding-left: 5px; padding-bottom: 2px">
                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                            <tr>
                                                                <td valign="top">
                                                                    <ext:Checkbox ID="chkLocation" runat="server" Width="23">
                                                                    </ext:Checkbox>
                                                                </td>
                                                                <td class="font_11bold" align="left" style="padding-top: 4px">
                                                                    Same as MBL
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="1px" colspan="4">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 5px; padding-right: 0px">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="67px"><tr><td>Receive</td>
                                                    
                                                    </tr></table>   
                                                    </td>
                                                    <td style="padding-bottom: 5px">
                                                        <div id="showCmbReceive" runat="server" style="display: block;">
                                                            <uc1:UserComboBox runat="server" ID="CmbReceive" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="13" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="69"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                                winHeight="620" />
                                                        </div>
                                                        <ext:TextField ID="labReceive" runat="server" Cls="text" Width="86" Disabled="true"
                                                            Hidden="true">
                                                        </ext:TextField>
                                                    </td>
                                                   <td style="padding-left: 6px">
                                                        <table cellpadding="0" cellspacing="0" border="0" width="59">
                                                            <tr>
                                                                <td class="font_11bold">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="64px"><tr><td>Loading</td><td class="font_red" style="text-align:right;padding-right:5px;">*</td></tr></table>
                                                                   
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="padding-bottom: 4px">
                                                        <div id="showcmbLoading" runat="server" style="display: block;">
                                                            <uc1:UserComboBox runat="server" ID="cmbLoading" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="14" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="67"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                                winHeight="620" />
                                                        </div>
                                                        <ext:TextField ID="labLoading" runat="server" Cls="text" Width="88" Disabled="true"
                                                            Hidden="true">
                                                        </ext:TextField>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 5px">
                                                        Discharge<span class="font_red" style="padding-left: 1px;">*</span>
                                                    </td>
                                                    <td>
                                                        <div id="showcmbPort" runat="server" style="display: block;">
                                                            <uc1:UserComboBox runat="server" ID="cmbPort" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="15" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="69"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                                winHeight="620" Handler="changePayAt();" />
                                                        </div>
                                                        <ext:TextField ID="labPort" runat="server" Cls="text" Width="86" Disabled="true"
                                                            Hidden="true">
                                                        </ext:TextField>
                                                        <ext:Hidden ID="hidPort" runat="server">
                                                        </ext:Hidden>
                                                    </td>
                                                    <td class="font_11bold" style="padding-left: 6px">
                                                        Final
                                                    </td>
                                                    <td>
                                                        <div id="showcmbFinalDest" runat="server" style="display: block;">
                                                            <uc1:UserComboBox runat="server" ID="cmbFinalDest" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="16" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="67"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                                winHeight="620" />
                                                        </div>
                                                        <ext:TextField ID="labFinalDest" runat="server" Cls="text" Width="88" Disabled="true"
                                                            Hidden="true">
                                                        </ext:TextField>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="10" colspan="4">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="padding-left: 5px">
                                                        <table cellpadding="0" cellspacing="0" border="0">
                                                            <tr>
                                                                <td>
                                                                    <ext:Checkbox ID="chkDate" runat="server" Width="23">
                                                                    </ext:Checkbox>
                                                                </td>
                                                                <td class="font_11bold" align="left" style="padding-top: 4px">
                                                                    Same as MBL
                                                                </td>
                                                                <td style="padding-top: 6px; padding-left: 5px; padding-top: 3px">
                                                                    <img src="../../images/arrows_btn.jpg" width="17" height="13" class="cursor" id="showDate"
                                                                        onclick="DateShow();" />
                                                                    <ext:Window ID="winShowDate" runat="server" Hidden="true" Width="350px" Height="140px"
                                                                        BodyStyle="background-color: #fff;" Padding="5" Border="false" PageX="468" PageY="255">
                                                                        <Content>
                                                                            <table style="width: 330px;">
                                                                                <tr>
                                                                                    <td align="left" valign="middle" class="font_11bold">
                                                                                        OnBoard
                                                                                    </td>
                                                                                    <td align="left" valign="middle" style="padding-bottom: 5px; padding-top: 5px" class="font_11px_gray">
                                                                                        <ext:DateField ID="txtOnBoard1" runat="server" Width="88" Cls="text_100px" Format="d/m/Y"
                                                                                            TabIndex="16">
                                                                                            <Listeners>
                                                                                                <Blur Handler="#{txtOnBoard}.setValue(this.getValue());" />
                                                                                            </Listeners>
                                                                                        </ext:DateField>
                                                                                    </td>
                                                                                    <td align="left" valign="middle" style="padding-left: 4px" class="font_11bold">
                                                                                        ETD
                                                                                    </td>
                                                                                    <td align="left" class="font_11px_gray">
                                                                                        <ext:DateField ID="txtETD1" runat="server" Width="88" Cls="text_100px" Format="d/m/Y">
                                                                                            <Listeners>
                                                                                                <Blur Handler="#{txtETD}.setValue(this.getValue());" />
                                                                                            </Listeners>
                                                                                        </ext:DateField>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left">
                                                                                        <table cellpadding="0" cellspacing="0" border="0" width="70px">
                                                                                            <tr>
                                                                                                <td class="font_11bold">
                                                                                                    CFS Closing
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                    <td class="font_11px_gray">
                                                                                        <ext:DateField ID="txtCFSClosing" runat="server" Width="88" Cls="text_80px" Format="d/m/Y">
                                                                                        </ext:DateField>
                                                                                    </td>
                                                                                    <td class="font_11bold" style="width: 75px; padding-left: 4px;">
                                                                                        CY Closing
                                                                                    </td>
                                                                                    <td valign="left" style="width: 90px">
                                                                                        <ext:DateField ID="txtCYClosing" runat="server" Width="88" Cls="text_80px" Format="d/m/Y">
                                                                                        </ext:DateField>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left" valign="middle" class="font_11bold">
                                                                                        ETA Discharge
                                                                                    </td>
                                                                                    <td align="left" valign="middle" class="font_11px_gray">
                                                                                        <ext:DateField ID="txtETADischarge" runat="server" Width="88" Format="d/m/Y" Cls="text_100px">
                                                                                        </ext:DateField>
                                                                                    </td>
                                                                                    <td align="left" valign="middle" class="font_11bold" style="padding-left: 5px; padding-right: 5px;
                                                                                        width: 65px">
                                                                                        ETA Final
                                                                                    </td>
                                                                                    <td align="left" valign="middle" class="font_11px_gray">
                                                                                        <ext:DateField ID="txtETAFinal" runat="server" Width="88" Format="d/m/Y" Cls="text_100px">
                                                                                        </ext:DateField>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left" valign="middle" class="font_11bold">
                                                                                        ATD
                                                                                    </td>
                                                                                    <td align="left" valign="middle">
                                                                                        <span class="font_11px_gray">
                                                                                            <ext:DateField ID="txtATD" runat="server" Width="88" Cls="text_100px" Format="d/m/Y">
                                                                                            </ext:DateField>
                                                                                        </span>
                                                                                    </td>
                                                                                    <td align="left" valign="middle">
                                                                                    </td>
                                                                                    <td align="left" valign="middle">
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </Content>
                                                                    </ext:Window>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="5px" colspan="4">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="font_11bold" style="padding-left: 5px">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="62px"><tr><td>Onboard</td><td class="font_red" style="text-align:right">*</td></tr></table>
                                                      
                                                    </td>
                                                    <td>
                                                        <ext:DateField ID="txtOnBoard" runat="server" Width="86" Cls="text_100px" Format="d/m/Y"
                                                            TabIndex="16">
                                                            <Listeners>
                                                                <Blur Handler="#{txtOnBoard1}.setValue(this.getValue());" />
                                                            </Listeners>
                                                        </ext:DateField>
                                                    </td>
                                                    <td class="font_11bold" style="padding-left: 6px">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="64px"><tr><td>ETD</td><td class="font_red" style="text-align:right; padding-right:5px">*</td></tr></table>
                                                       
                                                    </td>
                                                    <td>
                                                        <ext:DateField ID="txtETD" runat="server" Width="88" Cls="text_100px" Format="d/m/Y"
                                                            TabIndex="16">
                                                            <Listeners>
                                                                <Blur Handler="#{txtETD1}.setValue(this.getValue());" />
                                                            </Listeners>
                                                        </ext:DateField>
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
                                <table width="63px">
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
                            <td colspan="3">
                                <table border="0" cellspacing="0" cellpadding="0" width="252">
                                    <tr>
                                        <td>
                                            <uc1:AutoComplete runat="server" ID="CmbConsignee" TabIndex="6" clsClass="x-form-text x-form-field text"
                                                Query="option=CompanyList" Width="75" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="font_11bold" style="padding-left: 2px">
                                Notify #1
                            </td>
                            <td colspan="3">
                                <table border="0" cellspacing="0" cellpadding="0" width="252">
                                    <tr>
                                        <td>
                                            <%-- <uc1:UserComboBox runat="server" ID="CmbNotify1" TabIndex="16" clsClass="select"
                                                Query="option=CompanyList" StoreID="StoreCmb1" Width="87" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                            <uc1:AutoComplete runat="server" ID="CmbNotify1" clsClass="x-form-text x-form-field text"
                                                TabIndex="7" Query="option=CompanyList" Width="75" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="font_11bold" style="padding-left: 2px">Notify #2</span>
                            </td>
                            <td colspan="3">
                                <table width="250" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="85">
                                            <%-- <uc1:UserComboBox runat="server" ID="CmbNotify2"  clsClass="select"
                                                Query="option=CompanyList" StoreID="StoreCmb1" Width="104" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                            <uc1:AutoComplete runat="server" ID="CmbNotify2" clsClass="x-form-text x-form-field text"
                                                TabIndex="8" Query="option=CompanyList" Width="75" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="font_11bold" style="padding-left: 3px">
                                Agent
                            </td>
                            <td colspan="3">
                                <table border="0" cellspacing="0" cellpadding="0" width="252">
                                    <tr>
                                        <td>
                                            <uc1:AutoComplete runat="server" ID="CmbAgent" TabIndex="9" clsClass="x-form-text x-form-field text"
                                                Query="option=CompanyList" Width="75" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="font_11bold" style="padding-left: 2px">
                                Broker
                            </td>
                            <td colspan="3">
                                <table width="250" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="85">
                                            <uc1:AutoComplete runat="server" ID="CmbBroker"  TabIndex="9" clsClass="x-form-text x-form-field text"
                                                Query="option=CompanyList" Width="75" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                     
                        <tr><td style="border-bottom:solid 1px #8DB2e3; line-height:1px; padding:5px 0px 0px 0px" colspan="8"></td></tr>
                        <tr>
                            <td class="font_11bold" style="padding-left: 2px; padding-top:4px">
                                Ship To
                            </td>
                            <td colspan="3" style="padding-top:6px">
                                <table width="250" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="85">
                                            <uc1:AutoComplete runat="server" ID="CmbShipTo"  TabIndex="22" clsClass="x-form-text x-form-field text"
                                                Query="option=CompanyList" Width="75" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" /></td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="4">
                            <table cellpadding="0" cellspacing="0" border="0"><tr>
                             <td class="font_11bold" style="padding-left:5px; padding-top:2px">
                              Issue Place
                            </td>
                            <td style="padding-left:3px; padding-top:4px">
                               <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="cmbIssue" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="22" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="44"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                            winHeight="620" isButton="false" Handler="SelectItem('cmbIssue','txtIssueL')" />
                                                    </td>
                                                    <td style="padding-left: 2px;">
                                                        <ext:TextField ID="txtIssueL" runat="server" Cls="text_82px" Width="40" TabIndex="22">
                                                        </ext:TextField>
                                                    </td>
                                                </tr>
                                            </table>  
                            </td>
                            <td class="font_11bold" style="padding-left:6px; padding-top:1px;width:70px;">
                                Pay At
                            </td>
                            <td style="padding-top:4px">
                             <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="cmbPayAt" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="22" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="44"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                            winHeight="620" isButton="false" Handler="SelectItem('cmbPayAt','txtPayAtL')" />
                                                    </td>
                                                    <td style="padding-left: 2px;">
                                                        <ext:TextField ID="txtPayAtL" runat="server" Cls="text_82px" Width="42" TabIndex="22">
                                                        </ext:TextField>
                                                    </td>
                                                </tr>
                                            </table>                           
                            </td>
                            </tr></table>
                            </td>
                           
                        </tr>
                    </table>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <table width="970" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td id="GridView_2" style="width: 650px; padding-left: 2px; padding-top:0px" >
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="font_11bold_1542af  nav_menu_4" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                font-size: 11px; height: 25px">
                                <table cellpadding="0" cellspacing="0" border="0" width="670px">
                                    <tr>
                                        <td class="font_11bold_1542af">
                                            Container
                                        </td>
                                        <td style="padding-right: 3px" align="right">
                                            <div id="showContainer">

                                                <script type="text/javascript">
                                                    if (Request("seed") != "") {
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
                                <ext:GridPanel ID="GridPanelContainer" runat="server" Width="672px" Height="150"
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
                                                        <ext:RecordField Name="PKG" Type="String">
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
                                            <ext:Column Header="Container #" DataIndex="Container" Width="110">
                                            </ext:Column>
                                            <ext:Column Header="Container Size" DataIndex="ContainerSize" Width="100">
                                            </ext:Column>
                                            <ext:NumberColumn Header="PKG(S)" DataIndex="PKG" Width="70" Align="Center" Format="0">
                                            </ext:NumberColumn>
                                            <ext:Column Header="Unit" DataIndex="Unit" Width="40" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="WT" DataIndex="GWT" Width="70" Align="Right" Format="0.000">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="CBM" DataIndex="CBM" Width="70" Align="Right" Format="0.000">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="WM" DataIndex="WM" Width="70" Align="Right" Format="0.000">
                                            </ext:NumberColumn>
                                            <ext:ImageCommandColumn Header="Action" Width="48" Align="Center" Hidden="true">
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
                                    <%--  <Listeners>
                                        <Command Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') {DeleteContainer(#{GridPanelContainer},rowIndex);}})" />
                                    </Listeners>
                                    <KeyMap>
                                        <ext:KeyBinding Ctrl="true">
                                            <Keys>
                                                <ext:Key Code="DELETE" />
                                            </Keys>
                                            <Listeners>
                                                <Event Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') {DeleteContainer(#{GridPanelContainer});}})" />
                                            </Listeners>
                                        </ext:KeyBinding>
                                    </KeyMap>--%>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 0px; padding-top:0px">
                    <table width="303px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                        <tr>
                            <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                style="padding-left: 5px">
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" style="width: 292px">
                        <tr>
                            <td style="height: 5px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="padding-top: 5px; padding-left: 22px" align="left">
                                Actual
                            </td>
                            <td style="padding-top: 5px; padding-left: 12px" align="left">
                                Charge
                            </td>
                            <td align="left">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="right">
                                            <ext:Checkbox ID="chkDG" runat="server" TabIndex="23">
                                            </ext:Checkbox>
                                        </td>
                                        <td align="left" style="padding-top: 3px">
                                            D/G
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_01" style="padding-top: 5px; padding-left: 4px">
                                <table width="66px">
                                    <tr>
                                        <td>
                                            Piece(s)
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
                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="24">
                                            </ext:NumberField>
                                        </td>
                                        <td style="padding-left: 2px">
                                            <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                                StyleSpec="text-align:right" isButton="false" TabIndex="25" Query="option=UnitBinding"
                                                StoreID="StoreUnit" Width="57" winTitle="Unit" winUrl="/BasicData/Unit/list.aspx"
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
                                        <td>
                                            WT
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
                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="26">
                                                <Listeners>
                                                    <Blur Handler="var wt=#{txtCGWT}.getValue()!=''?#{txtCGWT}.getValue():#{txtAGWT}.getValue();var cbm=#{txtCCBM}.getValue()!=''?#{txtCCBM}.getValue():#{txtACBM}.getValue(); if(wt!=''){ if(cbm==''){#{txtCWM}.setValue(wt*1.0000/1000)} else{if(wt>cbm*1000){#{txtCWM}.setValue(wt*1.0000/1000)}else{#{txtCWM}.setValue(cbm)}} } else { if(cbm!=''){#{txtCWM}.setValue(cbm)}}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_01" style="padding-top: 5px; padding-left: 6px">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            CBM
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
                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="27">
                                                <Listeners>
                                                    <Change Handler="var wt=#{txtCGWT}.getValue()!=''?#{txtCGWT}.getValue():#{txtAGWT}.getValue();var cbm=#{txtCCBM}.getValue()!=''?#{txtCCBM}.getValue():#{txtACBM}.getValue();if(cbm!=''){if(wt==''){#{txtCWM}.setValue(cbm)}else{ if(wt>cbm*1000){#{txtCWM}.setValue(wt*1.0000/1000)}else{#{txtCWM}.setValue(cbm)} }} else{ if(wt!=''){#{txtCWM}.setValue(wt*1.0000/1000)}};#{txtCWM}.focus(true);" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_01" style="padding-top: 5px; padding-left: 6px">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            WM
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
                                                StyleSpec="text-align:right" Cls="select_160px" TabIndex="28">
                                            </ext:NumberField>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_01" style="padding-top: 5px; padding-left: 6px">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            Container
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="5" style="padding-top: 5px">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <ext:NumberField ID="txtContainer" runat="server" Width="78" DecimalPrecision="4"
                                                StyleSpec="text-align:right" Cls="select_160px" Disabled="true">
                                            </ext:NumberField>
                                        </td>
                                        <td colspan="3" style="padding-left: 2px">
                                        </td>
                                        <td>
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
                <td width="650" id="GridView_1" valign="top" style="padding-left: 2px; padding-right: 6px;">
                    <table cellpadding="0" cellspacing="0" width="669px">
                        <tr>
                            <td>
                                <ext:GridPanel ID="GridPanelInvoice" runat="server" Width="672px" Height="169" TrackMouseOver="true"
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
                                            <%--<ext:ImageCommandColumn Header="Action" Width="48" Align="Center">
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
                                        <Command Handler="Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) { if (btn == 'yes') {#{GridPanelInvoice}.getSelectionModel().selectRow(rowIndex);#{GridPanelInvoice}.deleteSelected();#{GridPanelInvoice}.view.focusEl.focus();}})" />
                                    </Listeners>
                                    <KeyMap>
                                        <ext:KeyBinding Ctrl="true">
                                            <Keys>
                                                <ext:Key Code="DELETE" />
                                            </Keys>
                                            <Listeners>
                                                <Event Handler="DeleteRow(#{GridPanelInvoice})" />
                                            </Listeners>
                                        </ext:KeyBinding>
                                    </KeyMap>--%>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="rowSelect19877">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 1px">
                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="117" />
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-left: 2px;">
                    <%-- gridCost  --%>
                    <uc1:Costing ID="ucCost" runat="server" type="H" sys="OE" />
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td id="GridView_7" style="display: none;">
                    <table cellpadding="0" cellspacing="0" style="margin-bottom: 30px" width="655">
                        <tr>
                            <td style="padding-left: 2px">
                                <ext:GridPanel ID="GridPanelContact" runat="server" Width="655" Height="157" TrackMouseOver="true"
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
                                <div style="width: 302px" id="Div3">
                                    <table cellpadding="0" cellspacing="0" style="width: 302px">
                                        <tr>
                                            <td colspan="6" style="padding-left: 5px; height: 24px" class="font_11bold_1542af table_nav2">
                                                Add Contact
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="67px">
                                                    <tr>
                                                        <td class="tb_01" style="vertical-align: top; padding-left: 8px; padding-top: 12px">
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
                                            <td class="tb_01" style="vertical-align: top; padding-top: 8px; padding-left: 8px">
                                                Company
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <uc1:AutoComplete runat="server" ID="c_Company" clsClass="x-form-text x-form-field text_82px"
                                                    isText="true" isAlign="false" Width="64" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" Query="option=CompanyList" TabIndex="62" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tb_01" style="vertical-align: top; padding-left: 8px">
                                                Dept
                                            </td>
                                            <td colspan="5" style="padding-top: 6px">
                                                <ext:ComboBox ID="c_Dept" runat="server" StoreID="StoreDept" DisplayField="value"
                                                    TabIndex="63" ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All"
                                                    Cls="select_160px" Width="91">
                                                    <Template Visible="False" ID="ctl7631" StopIDModeInheritance="False" EnableViewState="False">
                                                    </Template>
                                                </ext:ComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" style="padding-top: 10px; padding-right: 3px" align="right">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="padding-right: 2px">
                                                            <table>
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
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td id="GridView_3" style="width: 675px; padding-left: 2px">
                    <table cellpadding="0" cellspacing="0" width="669px">
                        <tr>
                            <td>
                                <ext:GridPanel ID="GridPanelOther" runat="server" Width="672px" Height="275" TrackMouseOver="true"
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
                                            <ext:Column Header="Code" DataIndex="CompanyCode" Width="77">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="200" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="Item" DataIndex="Item" Width="60">
                                            </ext:Column>
                                            <ext:Column Header="Description" DataIndex="Description" Width="200" Hidden="true">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Total" DataIndex="Total" Width="65" Align="Right" Format="0.00">
                                            </ext:NumberColumn>
                                            <ext:Column Header="Calc Kind" DataIndex="CalcKind" Width="70" Align="Center" Hidden="true">
                                            </ext:Column>
                                            <ext:Column Header="Qty" DataIndex="Qty" Width="65" Align="Right">
                                            </ext:Column>
                                            <ext:Column Header="Unit" DataIndex="Unit" Width="40" Align="center">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="40" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="EX." DataIndex="EX" Width="70" Format="0.000" Align="Right"
                                                Hidden="true">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="Rate" DataIndex="Rate" Width="65" Align="Right" Format="0.000">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right" Format="0.00">
                                            </ext:NumberColumn>
                                            <ext:Column Header="%" DataIndex="Percent" Width="45" Align="Center">
                                                <Renderer Fn="ChangeValue" />
                                            </ext:Column>
                                            <ext:CheckColumn Header="Show" DataIndex="Show" Width="45" Align="Center">
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
                <td style="padding-left: 3px" valign="top">
                    <table cellpadding="0" cellspacing="0" width="303">
                        <tr>
                            <td colspan="6" style="padding-left: 5px; height: 24px" class="font_11bold_1542af table_nav2">
                                Add Other Charges
                            </td>
                        </tr>
                        <tr><td><table border="0" cellpadding="0" cellspacing="0" width="295px"><tr><td>
                        <tr>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0" width="71px">
                                    <tr>
                                        <td class="tb_01" style="padding-top: 12px; padding-left: 5px" valign="top">
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
                            <td style="padding-top: 7px; padding-left: 5px" valign="top">
                                Company
                            </td>
                            <td colspan="5" style="padding-top: 6px">
                                <uc1:AutoComplete runat="server" ID="o_company" clsClass="x-form-text x-form-field text_82px"
                                    TabIndex="43" isText="true" isAlign="false" Width="64" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                    winWidth="800" winHeight="800" Query="option=CompanyList" />
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_01" style="padding-left: 5px; padding-top: 3px" valign="top">
                                Item
                            </td>
                            <td colspan="5">
                                <uc1:UserComboBox runat="server" StoreID="StoreGetItem" ID="o_item" isText="true"
                                    TabIndex="44" clsClass="select_160px" Width="70" winTitle="Item" winUrl="/BasicData/Item/list.aspx?sys=O"
                                    winWidth="965" winHeight="480" Handler="GetItemData('o_ppd','o_item','o_calc','o_qty','o_unit','o_currency','o_rate','o_amount','o_ex')" />
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_01" style="padding-left: 5px">
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
                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                            </ext:NumberField>
                                        </td>
                                        <td>
                                            <table width="33">
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
                                                Mode="Local" ForceSelection="true" TriggerAction="All" Width="69" Cls="select_160px">
                                            </ext:ComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_01" style="padding-left: 6px; padding-top: 3px">
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
                            <td class="tb_01" style="padding-left: 6px; padding-top: 5px">
                                Rate
                            </td>
                            <td style="padding-top: 5px">
                                <ext:NumberField ID="o_rate" runat="server" Width="60" TabIndex="50" Cls="select_65"
                                    StyleSpec="text-align:right" DecimalPrecision="3">
                                    <Listeners>
                                        <Blur Handler="if(this.getValue()!=''){#{o_amount}.setValue()}" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                            <td align="center" style="padding-top: 5px">
                                <table width="61px">
                                    <tr>
                                        <td>
                                            Amount
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" style="padding-top: 5px">
                                <ext:NumberField ID="o_amount" runat="server" Width="110" TabIndex="51" Cls="select_65"
                                    StyleSpec="text-align:right" DecimalPrecision="2">
                                    <Listeners>
                                        <Blur Handler="if(this.getValue()!=''){#{o_rate}.setValue()}" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_01" style="padding-left: 6px; padding-top: 3px">
                                Percent
                            </td>
                            <td style="padding-top: 5px">
                                <ext:NumberField ID="o_percent" runat="server" Cls="text" Width="60" TabIndex="52"
                                    Text="100" MaxLength="5" DecimalPrecision="1" StyleSpec="text-align:left;background-image:url(../../images/icon.gif);background-repeat:no-repeat; background-position:right center;">
                                </ext:NumberField>
                            </td>
                            <td class="tb_01" style="vertical-align: top; padding-top: 7px; padding-left: 6px;
                                text-align: center">
                                Show
                            </td>
                            <td style="text-align: left">
                                <ext:Checkbox ID="o_show" runat="server" Cls="text" TabIndex="53" HideLabel="true"
                                    Width="25" Checked="true">
                                </ext:Checkbox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="padding-top: 10px; padding-right: 0px" align="right">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="padding-right: 3px">
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
                                        <td style="padding-right: 3px">
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
                            </td>
                        </tr>
                        </td></tr></table></td></tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="30">
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
