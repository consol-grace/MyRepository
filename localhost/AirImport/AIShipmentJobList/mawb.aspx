<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="mawb.aspx.cs"
    Inherits="AirImport_AIShipmentJobList_mawb" %>
<%@ Register src="/common/UIControls/Costing.ascx" tagname="Costing" tagprefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ OutputCache Duration="3600" VaryByParam="none" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/Autocomplete.ascx" TagName="Autocomplete"
    TagPrefix="uc1" %>
    <%@ Register Src="../../common/UIControls/Transfer.ascx" TagName="Transfer"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MAWB</title>
   
<%--    <link href="/common/ylQuery/ext-3.2.0/resources/css/ext-all.css" rel="stylesheet"
        type="text/css" />--%>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="AjaxServer/gridMAWB.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function TextFocus() {
            Ext.get("txtMawb").focus();
        }
        function Blur_Click() {
            Ext.get("txtMawb").focus();
        }

        var ToUpper = function (value) {
            return value.toUpperCase();
        }

        var cmbStoreCompany = function (value) {
            var r = StoreCmb.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        };

        var cmbStoreItem = function (value) {
            var r = StoreItem.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        };

        function allquery() {
            //return document.getElementById(document.activeElement.id).value;
            var obj = document.activeElement.id;
            if ($(obj).attr("src") != "")
                return document.getElementById(document.activeElement.id).value;
            else
                return $(obj).prev("input").val();
        }

        function ChangeFlight() {
            if ($("#txtFlightRight").val() == "" && $("#CmbCarrierRight").val() != "") {
                $("#txtFlightRight").val($("#CmbCarrierRight").val() + ' ');
                getSelectPos("txtFlightRight");
            }
        }
        function getSelectPos(obj) {
            var esrc = document.getElementById(obj);
            if (esrc == null) {
                esrc = event.srcElement;
            }
            var rtextRange = esrc.createTextRange();
            rtextRange.moveStart('character', esrc.value.length);
            rtextRange.collapse(true);
            rtextRange.select();
        } 
    </script>

    <style type="text/css">
        #ucCost_cos_Remark
        {
            width: 238px !important;
        }
        
        #ucCost_cos_Amount
        {
             width: 46px !important;
        }
         
        #ucCost_cos_EX
        {
            width: 59px !important;
        }
        
        #ucCost_cos_Qty
         {
              width: 59px !important;
         }
         
        .tab_sheet
        {
            width:290px !important;
            margin-left:3px;
        }
        
        .td_Sheet
        {
            width:100px !important;
        }
         
        .style1
        {
            width: 85px;
        }
        .style2
        {
            width: 67px;
        }
        .style3
        {
            width: 65px;
        }
        .style4
        {
            width: 219px;
        }
        .style5
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            font-weight: bold;
            color: #1542af;
            width: 308px;
        }
        .ext-el-mask
        {
            background-color: White;
        }
        .x-form-element
        {
            padding-left: 0px !important;
        }
        .x-form-item-label
        {
            display: none !important;
            width: 0px !important;
        }
        
        .font_left
        {
            width: 70px;
            margin: 2px 0;
            height: 25px;
        }
        .table_list .td
        {
            height: 25px;
        }
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_title" style="width: 100%; z-index: 1000" >
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="A" />
    </div>
    
    <div id="div_title" style="margin-left: 10px; margin-top: 80px; z-index: 990">
        <table width="981px" border="0" cellspacing="0" cellpadding="0" class="table_nav1 font_11bold_1542af">
            <tr>
                <td style="padding-left:5px;">
                   <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                        <td> <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('AI');" />
                                &nbsp; AI - MAWB Information&nbsp;
                                <ext:Hidden ID="hidRowID" runat="server" Text="0">
                                </ext:Hidden>
                                <ext:Hidden ID="hidSeed" runat="server" Text="0">
                                </ext:Hidden>
                                <img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle; display:none;" /> </td>
                        </tr>
                        </table>
                </td>
                 <td align="right" style="padding-right:5px;">
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
                                <nobr>
                                <% if (!string.IsNullOrEmpty(Request["seed"])) { Response.Write("Lot#"); }%></nobr>
                            </td>
                            <td style="padding-left: 5px;">
                                <ext:DisplayField runat="server" StyleSpec=" color:#ff0000" ID="labLotNo">
                                </ext:DisplayField>
                            </td>
                             <td>
                 <%if (!string.IsNullOrEmpty(Request["seed"]))
                 { %>
                  <uc1:Transfer runat="server" ID="TransferSys" sys="AI" type="M"/>
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
      <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="txtcur_Rate" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLotNo" runat="server">
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
    <ext:Store runat="server" ID="StoreCurrency" OnRefreshData="StoreCurrInvoice_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreSalesman" OnRefreshData="StoreSales_OnRefreshData">
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
                <td width="488" rowspan="3" valign="top" style="padding-left: 5px; padding-top: 30px">
                    <div id="div_top" style="margin-top: 115px">
                        <table width="310" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                            <tr>
                                <td class="font_11bold_1542af" style="padding-left: 5px">
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
                                                    <Listeners>
                                                        <Click Handler="if(#{txtMawb}.getValue(true)==''){Ext.Msg.alert('Status', 'Input can not for empty ! ! ! '); return false;}" />
                                                    </Listeners>
                                                    <DirectEvents>
                                                        <Click OnEvent="btnNext_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridFlightList}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{GridPanel1}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{GridPanel2}.getRowsValues())"
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
                                                        <Click Handler="return (ReturnNull()&&ValidataText());" />
                                                    </Listeners>
                                                    <DirectEvents>
                                                        <Click OnEvent="btnSave_Click">
                                                            <EventMask ShowMask="true" Msg=" Saving ... " />
                                                            <ExtraParams>
                                                                 <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridFlightList}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                               
                                                                <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{GridPanel1}.getRowsValues())"
                                                                    Mode="Raw">
                                                                </ext:Parameter>
                                                                <ext:Parameter Name="p_safety_4" Value="Ext.encode(#{GridPanel2}.getRowsValues())"
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
                    <table width="312px" border="0" cellpadding="0" cellspacing="1" bgcolor="#81b8ff" class="table"
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
                            <td align="center" bgcolor="#FFFFFF" style="padding-left: 2px; padding-right: 2px">
                                <ext:NumberField ID="txtGWT" runat="server" Cls="text" DecimalPrecision="1" StyleSpec="text-align:right" Width="71"
                                    TabIndex="13">
                                    <Listeners>
                                        <Change Handler="if(#{txtGWT}.getValue(true)>=#{txtVWT}.getValue(true)){#{txtCWT}.setValue(#{txtGWT}.getValue(true))} else{#{txtCWT}.setValue(#{txtVWT}.getValue(true))}" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                            <td width="65" align="center" bgcolor="#FFFFFF">
                                <table width="60" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td><table width="60"><tr><td class="font_11bold">Piece(s)</td><td  class="font_red" align="right">*</td></tr></table></td>
                                    </tr>
                                </table>
                            </td>
                            <td align="center" bgcolor="#FFFFFF" style="padding-left: 2px; padding-right: 2px">
                                <ext:NumberField ID="txtPiece" runat="server" Cls="text" AllowDecimals="false" StyleSpec="text-align:right" Width="71"
                                    TabIndex="16">
                                </ext:NumberField>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                VWT
                            </td>
                            <td align="center" bgcolor="#FFFFFF">
                                <ext:NumberField ID="txtVWT" runat="server" Cls="text" DecimalPrecision="1" StyleSpec="text-align:right" Width="71"
                                    TabIndex="14">
                                    <Listeners>
                                        <Change Handler="if(#{txtGWT}.getValue(true)>=#{txtVWT}.getValue(true)){#{txtCWT}.setValue(#{txtGWT}.getValue(true))} else{#{txtCWT}.setValue(#{txtVWT}.getValue(true))};txtCWT.focus(true);" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                            <td align="center" bgcolor="#FFFFFF">
                                <table width="60" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                    <td><table width="60"><tr><td class="font_11bold">Unit</td><td  class="font_red" align="right">*</td></tr></table></td>
                                    </tr>
                                </table>
                            </td>
                            <td align="center" bgcolor="#FFFFFF" style="padding-left: 2px; padding-right: 2px">
                                <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                    StoreID="StoreUnit" Width="50" winTitle="Unit" TabIndex="17" winUrl="/BasicData/Unit/list.aspx?sys=A"
                                    winWidth="510" winHeight="585" />
                                <%--  <ext:ComboBox ID="CmbUnit" runat="server" DisplayField="value" TabIndex="17" ValueField="value"
                                    ListWidth="250" ItemSelector="tr.list-item" StoreID="StoreUnit" Mode="Local"
                                    ForceSelection="true" TriggerAction="All" Width="88" Cls="select_160px">
                                </ext:ComboBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" bgcolor="#FFFFFF" class="font_11bold" style="padding-left:8px">
                                CWT<span class="font_red" style="padding-left:2px">*</span>
                            </td>
                            <td align="center" bgcolor="#FFFFFF">
                                <ext:NumberField ID="txtCWT" runat="server" Cls="text" DecimalPrecision="1" StyleSpec="text-align:right" Width="71"
                                    TabIndex="15">
                                </ext:NumberField>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <table width="56"><tr><td class="font_11bold" align="left" style="padding-left:2px;">Pallet</td></tr></table>
                            </td>
                            <td align="center" bgcolor="#FFFFFF">
                                <ext:NumberField ID="txtPallet" runat="server" Cls="text" AllowDecimals="false" AllowBlank="true" Width="71"
                                    StyleSpec="text-align:right" TabIndex="18">
                                </ext:NumberField>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top" style="padding-top: 38px; padding-left: 4px">
                        <table width="660px" border="0" cellpadding="0" cellspacing="0" style="margin-top: 8px;">
                        <tr style="height: 25px">
                        <td width="75px" align="left">AE Lot# </td>
                        <td align="left" width="100">
                            <ext:TextField ID="labAeLotNo" runat="server" Cls="text_82px" width="97" TabIndex="1">
                            </ext:TextField>
                        </td>
                        <td width="50px">
                        <span style="padding-left:3px;">MAWB</span><span class="font_red" id="Span1" runat="server" style="padding-left:2px">*</span>
                        </td>
                        <td align="left" width="100">
                            <ext:TextField ID="txtMawb" runat="server" Cls="text_110px" Width="100" TabIndex="2">
                            </ext:TextField>
                        </td>
                        <td width="75px" align="left" style="padding-left:3px;">Reference#</td>
                        <td width="82px">
                            <ext:TextField ID="txtReference" runat="server" Cls="text_82px" TabIndex="3" >
                            </ext:TextField>
                        </td>
                        <td width="75" align="left" style="padding-left:3px;">Clearance#</td>
                        <td class="style1" width="81">
                            <ext:TextField ID="txtClearence" runat="server" Cls="text_82px" width="81" TabIndex="4">
                            </ext:TextField>
                        </td>
                        </tr>
                        <tr style="display: none">
                            <td width="75px" align="left" class="font_11bold">Carrier </td>
                            <td colspan="7" align="left">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <uc1:Autocomplete runat="server" ID="CmbCarrierCode" clsClass="input text_82px" TabIndex="5"
                                                Width="70" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800"
                                                winHeight="800" Query="option=CompanyList" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                        <td width="75px" align="left">
                        <span>Shipper</span><span class="font_red" id="Span2" runat="server" style="padding-left:2px">*</span>
                        </td>
                         <td align="left" width="250px" colspan="3">
                            <uc1:Autocomplete runat="server" ID="CmbShipperCode" TabIndex="6" Width="70" clsClass="text_82px"
                                                winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800"
                                                Query="option=CompanyList" />
                        </td>
                           <td width="75px" align="left" style="padding-left:3px;" class="font_11bold">
                            <span >Salesman</span><span class="font_red" id="td_sales2" runat="server" style="padding-left:2px">*</span>
                           </td>
                            <td align="left" width="82px">
                                <uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="9" Width="69" clsClass="select_65"
                                    StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx?sys=A"
                                    winWidth="680" winHeight="560" />
                            </td>
                            <td width="75" align="left" ></td>

                                    <td align="left" class="style2">
                                        <table width="82" border="0" cellpadding="0" cellspacing="0"><tr>
                                            <td width="10">
                                                <ext:Checkbox ID="chbDirect" runat="server" Width="25px" TabIndex="12">
                                                    <Listeners>
                                                        <Check Handler="CheckDirect();" />
                                                    </Listeners>
                                                </ext:Checkbox>
                                            </td>
                                            <td class="font_11bold chkDirect" style="padding-top: 3px;">
                                                Direct
                                            </td></tr></table>
                                    </td></tr>
                                    <tr style="height:20px">
                                     <td width="75px" align="left">
                        <span>Consignee</span><span class="font_red" id="Span3" runat="server" style="padding-left:2px">*</span>
                        </td>
                                 
                                    <td colspan="3" align="left">
                                         <table border="0" cellspacing="0" cellpadding="0" width="255px"><tr><td>
                                                <uc1:Autocomplete runat="server" ID="CmbConsigneeCode" Query="option=CompanyList"
                                                    TabIndex="6" Width="70" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" /></td></tr>
                                         </table>
                                        </td>
                                         <td width="75px" align="left" style="padding-left:3px;">Remark#</td>
                                          
                                        <td style="padding-top: 4px;" width="250px" colspan="3" rowspan="3" height="51px">
                                            <ext:TextArea ID="txtRemark" runat="server" StyleSpec="font-family:Verdana, Arial, Helvetica, sans-serif; font-size: 10px; height:51px; width: 240px;text-transform:capitalize"
                                                TabIndex="12" >
                                            </ext:TextArea>
                                        </td>
                                    </tr>
                                    <tr style="display: none">
                                        <td align="left" class="font_11bold" style="padding-left: 4px; display: none">
                                            Discharge
                                        </td>
                                        <td colspan="3" align="left" style="display: none">
                                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <uc1:Autocomplete runat="server" ID="CmbDischargeCode" TabIndex="9" Query="option=CompanyList"
                                                            Width="61" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                         <td width="75px" align="left">
                        Notify #1
                        </td>
                                        <td align="left" colspan="3">
                                            <table border="0" cellspacing="0" cellpadding="0" width="247px">
                                                <tr>
                                                    <td>
                                                        <uc1:Autocomplete runat="server" ID="CmbNotify1Code" Query="option=CompanyList" TabIndex="6"
                                                            Width="70" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                         <td width="75px" align="left">
                        Notify #2
                        </td>
                                        <td colspan="3" align="left">
                                            <table border="0" cellspacing="0" cellpadding="0" width="247px">
                                                <tr>
                                                    <td>
                                                        <uc1:Autocomplete runat="server" ID="CmbNotify2Code" Query="option=CompanyList" TabIndex="6"
                                                            Width="70" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

            <tr>
                <td valign="top" height="38">
                </td>
            </tr>
        </table>
        <table id="table1" width="800px" border="0" cellpadding="0" cellspacing="0" style="padding-top: 20px">
            <tr>
                <td width="663" valign="top" id="GridView_3">
                    <table cellpadding="0" cellspacing="0" width="660px">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #81b8ff; border-left: 1px solid #81b8ff; border-right: 1px solid #81b8ff;
                                height: 25px">
                                Flight Routing
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="GridFlightList" runat="server" width="660" Height="100" TrackMouseOver="true"
                                    ClicksToEdit="1" ColumnLines="True">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreFlight">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="FlightNo" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="From" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="To" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ETD" Type="Date">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ETA" Type="Date">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ATD" Type="Date">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ATA" Type="Date">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="clmFlight">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Flight No." DataIndex="FlightNo" Width="95">
                                              
                                            </ext:Column>
                                            <ext:Column Header="From" DataIndex="From" Width="40" Align="Center">
                                               
                                            </ext:Column>
                                            <ext:Column Header="To" DataIndex="To" Width="40" Align="Center">
                                               
                                            </ext:Column>
                                            <ext:Column Header="ETD" DataIndex="ETD" Width="80" Align="Center">
                                               
                                            </ext:Column>
                                            <ext:Column Header="ETA" DataIndex="ETA" Width="80" Align="Center">
                                                
                                            </ext:Column>
                                            <ext:Column Header="ATD" DataIndex="ATD" Width="80" Align="Center">
                                               
                                            </ext:Column>
                                            <ext:Column Header="ATA" DataIndex="ATA" Width="80" Align="Center">
                                               
                                            </ext:Column>
                                            <ext:ImageCommandColumn Header="Action" ColumnID="BinEmpty" Width="53" Align="Center">
                                                <%--<Commands>
                                                    <ext:ImageCommand Icon="BinEmpty" ToolTip-Text="Delete" CommandName="Delete" Style="background-position: center center;
                                                        width: 40px">
                                                        <ToolTip Text="Delete"></ToolTip>
                                                    </ext:ImageCommand>
                                                </Commands>--%>
                                            </ext:ImageCommandColumn>
                                        </Columns>
                                    </ColumnModel>
                                   <%-- <Listeners>
                                        <Click Handler="NewRow(this,0)"></Click>
                                        <Command Handler="DeleteRow(#{GridFlightList},rowIndex)" />
                                        <Activate Handler="alert()"></Activate>
                                    </Listeners>--%>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="ctl5836">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 9px">
                    <table height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2" width="312px">
                        <tr>
                            <td  class="font_12bold">
                                <span class="font_11bold_1542af" style="padding-left: 5px">Flight</span>
                            </td>
                        </tr>
                    </table>
                    <table width="305" border="0" cellpadding="0" cellspacing="4">
                        <tr>
                            <td colspan="4" align="center" bgcolor="#FFFFFF" height="2">
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                            <table width="50px"><tr><td>Carrier</td><td class="font_red"  align="right">*</td></tr></table>
                            </td>
                            <td align="center" bgcolor="#FFFFFF">
                                <%-- <uc1:UserComboBox runat="server" ID="CmbCarrierRight" clsClass="select_160px" Query="option=CompanyList"
                                    StoreID="StoreCmb1" isButton="false" Width="88" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                    winWidth="800" winHeight="800" TabIndex="19" /> --%>
                                <uc1:Autocomplete runat="server" ID="CmbCarrierRight" clsClass="text_82px" isDiplay="false"
                                    Query="option=CompanyList" Width="61" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                    winWidth="800" winHeight="800" TabIndex="19" />
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                            <table width="65px"><tr><td>Flight No.</td><td class="font_red" align="right">*</td></tr></table>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <ext:TextField ID="txtFlightRight" runat="server" Cls="text" TabIndex="20" Width="88">
                                <Listeners>
                                                                    <Focus Handler="ChangeFlight();" />
                                 </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" bgcolor="#FFFFFF">
                            <table width="50px"><tr><td>From</td><td class="font_red"  align="right">*</td></tr></table>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <uc1:UserComboBox runat="server" ID="CmbFromRight" ListWidth="180" clsClass="select_160px"
                                    TabIndex="21" StoreID="StoreLocation" Width="67" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                    winWidth="845" winHeight="620" />
                                <%--<ext:ComboBox ID="CmbFromRight" runat="server" DisplayField="value" TabIndex="21"
                                    ValueField="value" ListWidth="250" ItemSelector="tr.list-item" StoreID="StoreLocation"
                                    Mode="Local" ForceSelection="true" TriggerAction="All" Width="88" Cls="select_160px">
                                </ext:ComboBox>--%>
                            </td>
                            <td><table width="65px"><tr><td>To</td><td class="font_red" align="right">*</td></tr></table></td>
                            <td align="left" bgcolor="#FFFFFF">
                                <uc1:UserComboBox runat="server" ID="CmbToRight" ListWidth="180" clsClass="select_160px"
                                    TabIndex="22" StoreID="StoreLocation" Width="67" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                    winWidth="845" winHeight="620" />
                                <%--<ext:ComboBox ID="CmbToRight" runat="server" DisplayField="value" TabIndex="22" ValueField="value"
                                    ListWidth="250" ItemSelector="tr.list-item" StoreID="StoreLocation" Mode="Local"
                                    ForceSelection="true" TriggerAction="All" Width="88" Cls="select_160px">
                                </ext:ComboBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" bgcolor="#FFFFFF">
                            <table width="50px"><tr><td>ETD</td><td class="font_red"  align="right">*</td></tr></table>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <ext:DateField ID="txtETD" runat="server" Cls="text" Width="88" Format="d/m/Y" TabIndex="23">
                                    <Listeners>
                                        <Change Handler="if(#{txtATD}.getValue(true)==''){#{txtATD}.setValue(this.getValue())}" />
                                    </Listeners>
                                </ext:DateField>
                            </td>
                            <td><table width="65px"><tr><td>ETA</td><td class="font_red"  align="right">*</td></tr></table></td>
                            <td align="left" bgcolor="#FFFFFF">
                                <ext:DateField ID="txtETA" runat="server" Cls="text" Width="88" Format="d/m/Y" TabIndex="24">
                                </ext:DateField>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" bgcolor="#FFFFFF">
                            <table width="50px"><tr><td>ATD</td><td class="font_red"  align="right">*</td></tr></table>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <ext:DateField ID="txtATD" runat="server" Cls="text" Width="88" Format="d/m/Y" TabIndex="25">
                                </ext:DateField>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="padding-left: 3px" class="font_11bold">
                                ATA
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <ext:DateField ID="txtATA" runat="server" Cls="text" Width="88" Format="d/m/Y" TabIndex="26">
                                </ext:DateField>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="5" colspan="2">
                </td>
            </tr>
            <tr>
                <td height="5" valign="top" class="GridView_1" colspan="3">
                    <table width="660" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px solid #81b8ff;
                        border-right: 1px solid #81b8ff; border-top: 1px solid #81b8ff;">
                        <tr>
                            <td align="left" background="../../images/bg_line_3.jpg" class="font_11bold_1542af"
                                style="padding-left: 5px; line-height: 26px;">
                                HAWB List
                            </td>
                            <td align="right" background="../../images/bg_line_3.jpg" class="nav_menu_4" style="padding-right: 4px">
                                <div id="showHBL">
                                <% if (!string.IsNullOrEmpty(Request["seed"])) { Response.Write("<a href=\"javascript:void(0)\"  onclick=\"if(ReturnNull()&&ValidataText()){Add();}\"/>New</a>"); }%>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" id="GridView_1" colspan="3"  style="padding-bottom:5px;">
                    <ext:GridPanel ID="GridPanel1" runat="server" width="660" Height="100" TrackMouseOver="true"
                        ColumnLines="True">
                        <Store>
                            <ext:Store runat="server" ID="StoreHawb">
                                <Reader>
                                    <ext:JsonReader IDProperty="RowID">
                                        <Fields>
                                            <ext:RecordField Name="RowID" Type="Int">
                                            </ext:RecordField>
                                            <ext:RecordField Name="HAWB" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Consignee" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Final" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="GWT" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="VWT" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="CWT" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Piece" Type="String">
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
                                <ext:Column Header="HAWB" DataIndex="HAWB" Width="100">
                                </ext:Column>
                                <ext:Column Header="Consignee" DataIndex="Consignee" Width="235">
                                </ext:Column>
                                <ext:Column Header="Final" DataIndex="Final" Width="40" Align="Center">
                                </ext:Column>
                                <ext:Column Header="GWT" DataIndex="GWT" Width="55" Align="Right">
                                </ext:Column>
                                <ext:Column Header="VWT" DataIndex="VWT" Width="55" Align="Right">
                                </ext:Column>
                                <ext:Column Header="CWT" DataIndex="CWT" Width="55" Align="Right">
                                </ext:Column>
                                <ext:Column Header="Piece(s)" DataIndex="Piece" Width="70" Align="Right">
                                </ext:Column>
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
                            <ext:RowSelectionModel ID="ctl9874">
                            </ext:RowSelectionModel>
                        </SelectionModel>
                    </ext:GridPanel>
                </td>
            </tr>
         
            <tr id="grid3">
                <td valign="top" id="GridView_2">
                    <table cellpadding="0" cellspacing="0" width="658">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #81b8ff; border-left: 1px solid #81b8ff; border-right: 1px solid #81b8ff;
                                height: 25px">
                                Local Invoice
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="GridPanel2" runat="server" width="660" Height="154" TrackMouseOver="true"
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
                                            <ext:CheckColumn Header="DN" Width="30" DataIndex="DN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="CN" Width="30" DataIndex="CN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="130">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="195">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="40" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right" Format="0.00">
                                            </ext:NumberColumn>
                                            <ext:CheckColumn Header="Print" DataIndex="Print" Width="40" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="Void" DataIndex="Void" Width="38" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="AC" DataIndex="AC" Width="38" Align="Center">
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
                <td id="dis_Invoice" valign="top" style="padding-left: 6px; display:block;">
                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="128" Width="301"  />
                </td>
            </tr>
            <tr>
                <td height="5" colspan="2">
                </td>
            </tr>
            <tr>
              <td colspan="2">
               <uc1:Costing ID="ucCost"  runat="server" type="M"  sys="AI" /> </td>
            </tr>
            <tr>
                <td colspan="2"  height="35px">
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
